use crate::db::DbPool;
use chrono::DateTime;
use serde::{Deserialize, Serialize};
use serde_json::{json, Value};
use sha2::{Digest, Sha256};
use sqlx::{MySql, Row, Transaction};
use std::{
    collections::{BTreeMap, HashSet},
    fmt,
    fs::File,
    io::{BufRead, BufReader, Read},
    path::PathBuf,
};
use url::Url;
use uuid::Uuid;

const CONTRACT_VERSION: &str = "legacy-authority-link-v1";
const RUN_KIND: &str = "legacy_authority_linkage";
const COMMAND: &str = "link_legacy_authorities";

#[derive(Debug, Clone)]
pub struct LegacyAuthorityLinkOptions {
    pub bundle_path: PathBuf,
    pub run_id: Uuid,
    pub dry_run: bool,
    pub resume: bool,
    pub limit: Option<usize>,
}

impl LegacyAuthorityLinkOptions {
    pub fn new(bundle_path: PathBuf, run_id: Uuid) -> Self {
        Self {
            bundle_path,
            run_id,
            dry_run: false,
            resume: true,
            limit: None,
        }
    }
}

#[derive(Debug, Clone, Default, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct LegacyLinkMutationCounts {
    pub linked: u64,
    pub source_record_linked: u64,
    pub reused: u64,
    pub total: u64,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct LegacyLinkRollbackEntry {
    pub sequence: usize,
    pub target_table: String,
    pub target_id: String,
    pub reverse_operation: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub restore_json: Option<Value>,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct LegacyLinkRollbackManifest {
    pub schema_version: &'static str,
    pub seed_run_id: String,
    pub dry_run: bool,
    pub entries: Vec<LegacyLinkRollbackEntry>,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct LegacyAuthorityLinkReport {
    pub status: &'static str,
    pub contract_version: &'static str,
    pub bundle_path: String,
    pub input_sha256: String,
    pub seed_run_id: String,
    pub row_count: usize,
    pub dry_run: bool,
    pub mutations: LegacyLinkMutationCounts,
    pub planned_mutations: LegacyLinkMutationCounts,
    pub table_mutations: BTreeMap<String, u64>,
    pub rollback_manifest: LegacyLinkRollbackManifest,
}

#[derive(Debug)]
pub enum LegacyAuthorityLinkError {
    Input {
        code: &'static str,
        message: String,
        line: Option<usize>,
    },
    Io(std::io::Error),
    Database(sqlx::Error),
}

impl LegacyAuthorityLinkError {
    pub const fn code(&self) -> &'static str {
        match self {
            Self::Input { code, .. } => code,
            Self::Io(_) => "INPUT_IO_ERROR",
            Self::Database(_) => "DATABASE_ERROR",
        }
    }

    pub const fn line(&self) -> Option<usize> {
        match self {
            Self::Input { line, .. } => *line,
            Self::Io(_) | Self::Database(_) => None,
        }
    }

    pub const fn exit_code(&self) -> i32 {
        match self {
            Self::Input { .. } | Self::Io(_) => 2,
            Self::Database(_) => 3,
        }
    }

    fn input(code: &'static str, message: impl Into<String>, line: Option<usize>) -> Self {
        Self::Input {
            code,
            message: message.into(),
            line,
        }
    }
}

impl fmt::Display for LegacyAuthorityLinkError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Input { message, .. } => formatter.write_str(message),
            Self::Io(error) => write!(formatter, "linkage bundle 파일 오류: {error}"),
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
        }
    }
}

impl std::error::Error for LegacyAuthorityLinkError {}

impl From<std::io::Error> for LegacyAuthorityLinkError {
    fn from(error: std::io::Error) -> Self {
        Self::Io(error)
    }
}

impl From<sqlx::Error> for LegacyAuthorityLinkError {
    fn from(error: sqlx::Error) -> Self {
        Self::Database(error)
    }
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash)]
#[serde(rename_all = "snake_case")]
enum LegacyEntityType {
    Composer,
    Artist,
}

impl LegacyEntityType {
    const fn table(self) -> &'static str {
        match self {
            Self::Composer => "composers",
            Self::Artist => "artists",
        }
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct ExpectedFingerprint {
    name: String,
    #[serde(default)]
    english_name: Option<String>,
    #[serde(default)]
    birth_year: Option<String>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct AuthorityIdentifier {
    namespace: String,
    value: String,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct LinkEvidence {
    url: String,
    note: String,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct LegacyLinkRecord {
    entity_type: LegacyEntityType,
    legacy_id: i32,
    expected_fingerprint: ExpectedFingerprint,
    authority_identifier: AuthorityIdentifier,
    reviewed_at: String,
    reviewer: String,
    evidence: LinkEvidence,
}

#[derive(Debug, Clone)]
struct BundleRecord {
    line: usize,
    record: LegacyLinkRecord,
}

#[derive(Debug, Clone)]
struct LegacyState {
    name: String,
    english_name: Option<String>,
    birth_year: Option<String>,
    authority_entity_id: Option<String>,
    source_record_id: Option<u64>,
    origin: String,
    editor_locked: bool,
}

#[derive(Debug, Clone)]
struct AuthorityState {
    authority_entity_id: String,
    source_record_id: Option<u64>,
}

#[derive(Debug, Clone)]
struct ResolvedLink {
    item: BundleRecord,
    before: LegacyState,
    authority: AuthorityState,
    fingerprint_sha256: String,
    needs_authority_link: bool,
    needs_source_link: bool,
}

pub struct LegacyAuthorityLinker;

impl LegacyAuthorityLinker {
    pub async fn link(
        pool: &DbPool,
        options: &LegacyAuthorityLinkOptions,
    ) -> Result<LegacyAuthorityLinkReport, LegacyAuthorityLinkError> {
        let (records, input_sha256) = parse_bundle(options)?;
        let manifest = json!({
            "contractVersion": CONTRACT_VERSION,
            "inputSha256": input_sha256,
            "rowCount": records.len(),
        });
        let mut transaction = pool.begin().await?;
        let existing_run = fetch_seed_run(&mut transaction, options.run_id).await?;
        validate_resume(existing_run.as_ref(), options, &manifest)?;

        let resolved = preflight_links(&mut transaction, records).await?;
        let mut planned = LegacyLinkMutationCounts::default();
        let mut table_mutations = BTreeMap::new();
        for link in &resolved {
            if link.needs_authority_link || link.needs_source_link {
                planned.linked += 1;
                if link.needs_source_link {
                    planned.source_record_linked += 1;
                }
                *table_mutations
                    .entry(link.item.record.entity_type.table().to_string())
                    .or_insert(0) += 1;
            } else {
                planned.reused += 1;
            }
        }
        planned.total = planned.linked;
        let mut inserted_mutation_ids = Vec::new();
        let mutations = if options.dry_run || planned.total == 0 {
            transaction.rollback().await?;
            LegacyLinkMutationCounts::default()
        } else {
            if existing_run.is_none() {
                insert_seed_run(&mut transaction, options.run_id, &manifest).await?;
            } else {
                mark_seed_run_running(&mut transaction, options.run_id).await?;
            }
            for link in &resolved {
                if !link.needs_authority_link && !link.needs_source_link {
                    continue;
                }
                apply_link(&mut transaction, link).await?;
                inserted_mutation_ids
                    .push(insert_seed_mutation(&mut transaction, options.run_id, link).await?);
            }
            finish_seed_run(&mut transaction, options.run_id, &planned).await?;
            transaction.commit().await?;
            planned.clone()
        };
        let rollback_manifest = build_rollback_manifest(
            options.run_id,
            options.dry_run,
            &resolved,
            &inserted_mutation_ids,
            existing_run.is_none() && planned.total > 0,
        );

        Ok(LegacyAuthorityLinkReport {
            status: "succeeded",
            contract_version: CONTRACT_VERSION,
            bundle_path: options.bundle_path.display().to_string(),
            input_sha256,
            seed_run_id: options.run_id.to_string(),
            row_count: resolved.len(),
            dry_run: options.dry_run,
            mutations,
            planned_mutations: planned,
            table_mutations,
            rollback_manifest,
        })
    }
}

fn parse_bundle(
    options: &LegacyAuthorityLinkOptions,
) -> Result<(Vec<BundleRecord>, String), LegacyAuthorityLinkError> {
    let mut bytes = Vec::new();
    File::open(&options.bundle_path)?.read_to_end(&mut bytes)?;
    let input_sha256 = format!("{:x}", Sha256::digest(&bytes));
    let reader = BufReader::new(bytes.as_slice());
    let mut records = Vec::new();
    let mut targets = HashSet::new();
    let mut identifiers = HashSet::new();
    for (line_index, line_result) in reader.lines().enumerate() {
        let line_number = line_index + 1;
        let line = line_result?;
        if line.trim().is_empty() {
            return Err(LegacyAuthorityLinkError::input(
                "EMPTY_JSONL_LINE",
                "빈 JSONL 행은 허용되지 않음",
                Some(line_number),
            ));
        }
        let record: LegacyLinkRecord = serde_json::from_str(&line).map_err(|error| {
            LegacyAuthorityLinkError::input(
                "INVALID_JSONL_RECORD",
                format!("strict legacy authority linkage record가 아님: {error}"),
                Some(line_number),
            )
        })?;
        validate_record(&record, line_number)?;
        if !targets.insert((record.entity_type, record.legacy_id)) {
            return Err(LegacyAuthorityLinkError::input(
                "DUPLICATE_LEGACY_TARGET",
                format!(
                    "중복 legacy target임: {}:{}",
                    record.entity_type.table(),
                    record.legacy_id
                ),
                Some(line_number),
            ));
        }
        if !identifiers.insert((
            record.authority_identifier.namespace.clone(),
            record.authority_identifier.value.clone(),
        )) {
            return Err(LegacyAuthorityLinkError::input(
                "DUPLICATE_AUTHORITY_IDENTIFIER",
                "bundle에 중복 authority identifier가 있음",
                Some(line_number),
            ));
        }
        records.push(BundleRecord {
            line: line_number,
            record,
        });
        if options.limit.is_some_and(|limit| records.len() > limit) {
            return Err(LegacyAuthorityLinkError::input(
                "BUNDLE_LIMIT_EXCEEDED",
                format!(
                    "bundle record 수가 --limit {}을 초과함",
                    options.limit.expect("limit 존재")
                ),
                Some(line_number),
            ));
        }
    }
    if records.is_empty() {
        return Err(LegacyAuthorityLinkError::input(
            "EMPTY_BUNDLE",
            "bundle에 linkage record가 없음",
            None,
        ));
    }
    Ok((records, input_sha256))
}

fn validate_record(record: &LegacyLinkRecord, line: usize) -> Result<(), LegacyAuthorityLinkError> {
    if record.legacy_id <= 0 {
        return Err(LegacyAuthorityLinkError::input(
            "INVALID_LEGACY_ID",
            "legacyId는 양의 정수여야 함",
            Some(line),
        ));
    }
    if record.expected_fingerprint.name.is_empty() {
        return Err(LegacyAuthorityLinkError::input(
            "EMPTY_EXPECTED_NAME",
            "expectedFingerprint.name은 비어 있을 수 없음",
            Some(line),
        ));
    }
    if !matches!(
        record.authority_identifier.namespace.as_str(),
        "wikidata" | "musicbrainz_artist"
    ) {
        return Err(LegacyAuthorityLinkError::input(
            "UNSUPPORTED_AUTHORITY_NAMESPACE",
            "authorityIdentifier.namespace은 wikidata 또는 musicbrainz_artist여야 함",
            Some(line),
        ));
    }
    let identifier_valid = match record.authority_identifier.namespace.as_str() {
        "wikidata" => record
            .authority_identifier
            .value
            .strip_prefix('Q')
            .is_some_and(|digits| !digits.is_empty() && digits.chars().all(|c| c.is_ascii_digit())),
        "musicbrainz_artist" => Uuid::parse_str(&record.authority_identifier.value).is_ok(),
        _ => false,
    };
    if !identifier_valid {
        return Err(LegacyAuthorityLinkError::input(
            "INVALID_AUTHORITY_IDENTIFIER",
            "authority identifier 값 형식이 namespace와 맞지 않음",
            Some(line),
        ));
    }
    if DateTime::parse_from_rfc3339(&record.reviewed_at).is_err() {
        return Err(LegacyAuthorityLinkError::input(
            "INVALID_REVIEWED_AT",
            "reviewedAt은 RFC3339 timestamp여야 함",
            Some(line),
        ));
    }
    if record.reviewer.trim().is_empty() || record.reviewer.len() > 200 {
        return Err(LegacyAuthorityLinkError::input(
            "INVALID_REVIEWER",
            "reviewer는 1~200 byte 문자열이어야 함",
            Some(line),
        ));
    }
    let evidence_url = Url::parse(&record.evidence.url).map_err(|error| {
        LegacyAuthorityLinkError::input(
            "INVALID_EVIDENCE_URL",
            format!("evidence.url을 해석할 수 없음: {error}"),
            Some(line),
        )
    })?;
    if evidence_url.scheme() != "https" || evidence_url.host_str().is_none() {
        return Err(LegacyAuthorityLinkError::input(
            "INVALID_EVIDENCE_URL",
            "evidence.url은 host가 있는 HTTPS URL이어야 함",
            Some(line),
        ));
    }
    if record.evidence.note.trim().is_empty() || record.evidence.note.len() > 2000 {
        return Err(LegacyAuthorityLinkError::input(
            "INVALID_EVIDENCE_NOTE",
            "evidence.note는 1~2000 byte 문자열이어야 함",
            Some(line),
        ));
    }
    Ok(())
}

#[derive(Debug)]
struct ExistingSeedRun {
    run_kind: String,
    command: String,
    status: String,
    manifest: Value,
}

async fn fetch_seed_run(
    transaction: &mut Transaction<'_, MySql>,
    run_id: Uuid,
) -> Result<Option<ExistingSeedRun>, LegacyAuthorityLinkError> {
    let row = sqlx::query(
        "SELECT run_kind, command, status, manifest
         FROM seed_runs WHERE id = ? FOR UPDATE",
    )
    .bind(run_id.to_string())
    .fetch_optional(&mut **transaction)
    .await?;
    row.map(|row| {
        let manifest: Option<sqlx::types::Json<Value>> = row.try_get("manifest")?;
        Ok::<ExistingSeedRun, sqlx::Error>(ExistingSeedRun {
            run_kind: row.try_get("run_kind")?,
            command: row.try_get("command")?,
            status: row.try_get("status")?,
            manifest: manifest.map_or(Value::Null, |value| value.0),
        })
    })
    .transpose()
    .map_err(LegacyAuthorityLinkError::from)
}

fn validate_resume(
    existing: Option<&ExistingSeedRun>,
    options: &LegacyAuthorityLinkOptions,
    manifest: &Value,
) -> Result<(), LegacyAuthorityLinkError> {
    let Some(existing) = existing else {
        return Ok(());
    };
    if !options.resume {
        return Err(LegacyAuthorityLinkError::input(
            "SEED_RUN_ALREADY_EXISTS",
            format!("seed_runs {}가 이미 존재함", options.run_id),
            None,
        ));
    }
    if existing.run_kind != RUN_KIND
        || existing.command != COMMAND
        || existing.manifest != *manifest
        || !matches!(existing.status.as_str(), "RUNNING" | "SUCCEEDED")
    {
        return Err(LegacyAuthorityLinkError::input(
            "SEED_RUN_RESUME_CONFLICT",
            "기존 seed run의 command, manifest 또는 status가 linkage bundle과 다름",
            None,
        ));
    }
    Ok(())
}

async fn preflight_links(
    transaction: &mut Transaction<'_, MySql>,
    records: Vec<BundleRecord>,
) -> Result<Vec<ResolvedLink>, LegacyAuthorityLinkError> {
    let mut resolved = Vec::with_capacity(records.len());
    let mut authority_targets = HashSet::new();
    for item in records {
        let authority = fetch_authority(transaction, &item).await?;
        if !authority_targets.insert((
            item.record.entity_type,
            authority.authority_entity_id.clone(),
        )) {
            return Err(LegacyAuthorityLinkError::input(
                "DUPLICATE_AUTHORITY_TARGET",
                "같은 entity type에서 둘 이상의 legacy row가 같은 authority를 가리킴",
                Some(item.line),
            ));
        }
        let before = fetch_legacy_state(transaction, &item).await?;
        validate_manual_state(&item, &before)?;
        let occupied = count_other_authority_projection(
            transaction,
            item.record.entity_type,
            item.record.legacy_id,
            &authority.authority_entity_id,
        )
        .await?;
        if occupied > 0 {
            return Err(LegacyAuthorityLinkError::input(
                "AUTHORITY_ALREADY_LINKED",
                "authority가 같은 entity type의 다른 legacy row에 이미 연결됨",
                Some(item.line),
            ));
        }
        if before
            .authority_entity_id
            .as_ref()
            .is_some_and(|current| current != &authority.authority_entity_id)
        {
            return Err(LegacyAuthorityLinkError::input(
                "LEGACY_AUTHORITY_CONFLICT",
                "legacy row가 이미 다른 authority_entity_id에 연결되어 있음",
                Some(item.line),
            ));
        }
        let needs_authority_link = before.authority_entity_id.is_none();
        let needs_source_link =
            before.source_record_id.is_none() && authority.source_record_id.is_some();
        let fingerprint_sha256 = expected_fingerprint_sha256(&item.record)?;
        resolved.push(ResolvedLink {
            item,
            before,
            authority,
            fingerprint_sha256,
            needs_authority_link,
            needs_source_link,
        });
    }
    Ok(resolved)
}

async fn fetch_authority(
    transaction: &mut Transaction<'_, MySql>,
    item: &BundleRecord,
) -> Result<AuthorityState, LegacyAuthorityLinkError> {
    let rows = sqlx::query(
        "SELECT
            CAST(identifier.authority_entity_id AS CHAR CHARACTER SET utf8mb4)
                AS authority_entity_id,
            COALESCE(identifier.source_record_id, authority.canonical_source_record_id)
                AS source_record_id
         FROM external_identifiers identifier
         JOIN authority_entities authority ON authority.id = identifier.authority_entity_id
         WHERE identifier.namespace = ? AND identifier.external_id = ?
         LIMIT 2 FOR UPDATE",
    )
    .bind(&item.record.authority_identifier.namespace)
    .bind(&item.record.authority_identifier.value)
    .fetch_all(&mut **transaction)
    .await?;
    if rows.len() != 1 {
        return Err(LegacyAuthorityLinkError::input(
            if rows.is_empty() {
                "AUTHORITY_IDENTIFIER_NOT_FOUND"
            } else {
                "AUTHORITY_IDENTIFIER_AMBIGUOUS"
            },
            "authority identifier는 DB에서 정확히 한 entity로 해소되어야 함",
            Some(item.line),
        ));
    }
    Ok(AuthorityState {
        authority_entity_id: rows[0].try_get("authority_entity_id")?,
        source_record_id: rows[0].try_get("source_record_id")?,
    })
}

async fn fetch_legacy_state(
    transaction: &mut Transaction<'_, MySql>,
    item: &BundleRecord,
) -> Result<LegacyState, LegacyAuthorityLinkError> {
    let query = format!(
        "SELECT name, english_name, CAST(birth_year AS CHAR) AS birth_year,
                CAST(authority_entity_id AS CHAR CHARACTER SET utf8mb4)
                    AS authority_entity_id,
                source_record_id, origin, editor_locked
         FROM {} WHERE id = ? FOR UPDATE",
        item.record.entity_type.table()
    );
    let row = sqlx::query(&query)
        .bind(item.record.legacy_id)
        .fetch_optional(&mut **transaction)
        .await?
        .ok_or_else(|| {
            LegacyAuthorityLinkError::input(
                "LEGACY_TARGET_NOT_FOUND",
                format!(
                    "{}:{} legacy row가 없음",
                    item.record.entity_type.table(),
                    item.record.legacy_id
                ),
                Some(item.line),
            )
        })?;
    Ok(LegacyState {
        name: row.try_get("name")?,
        english_name: row.try_get("english_name")?,
        birth_year: row.try_get("birth_year")?,
        authority_entity_id: row.try_get("authority_entity_id")?,
        source_record_id: row.try_get("source_record_id")?,
        origin: row.try_get("origin")?,
        editor_locked: row.try_get("editor_locked")?,
    })
}

fn validate_manual_state(
    item: &BundleRecord,
    state: &LegacyState,
) -> Result<(), LegacyAuthorityLinkError> {
    if state.origin != "manual" || !state.editor_locked {
        return Err(LegacyAuthorityLinkError::input(
            "LEGACY_ROW_NOT_MANUAL_LOCKED",
            "linkage 대상은 origin=manual, editor_locked=true여야 함",
            Some(item.line),
        ));
    }
    let expected = &item.record.expected_fingerprint;
    if state.english_name.is_some() && expected.english_name.is_none()
        || state.birth_year.is_some() && expected.birth_year.is_none()
    {
        return Err(LegacyAuthorityLinkError::input(
            "INCOMPLETE_EXPECTED_FINGERPRINT",
            "DB에 존재하는 englishName/birthYear는 expectedFingerprint에 포함해야 함",
            Some(item.line),
        ));
    }
    if state.name != expected.name
        || state.english_name != expected.english_name
        || state.birth_year != expected.birth_year
    {
        return Err(LegacyAuthorityLinkError::input(
            "LEGACY_FINGERPRINT_MISMATCH",
            "legacy row의 현재 name, englishName 또는 birthYear가 expectedFingerprint와 다름",
            Some(item.line),
        ));
    }
    Ok(())
}

async fn count_other_authority_projection(
    transaction: &mut Transaction<'_, MySql>,
    entity_type: LegacyEntityType,
    legacy_id: i32,
    authority_entity_id: &str,
) -> Result<i64, LegacyAuthorityLinkError> {
    let query = format!(
        "SELECT COUNT(*) FROM {} WHERE authority_entity_id = ? AND id <> ?",
        entity_type.table()
    );
    Ok(sqlx::query_scalar(&query)
        .bind(authority_entity_id)
        .bind(legacy_id)
        .fetch_one(&mut **transaction)
        .await?)
}

fn expected_fingerprint_sha256(
    record: &LegacyLinkRecord,
) -> Result<String, LegacyAuthorityLinkError> {
    let value = json!({
        "entityType": record.entity_type,
        "legacyId": record.legacy_id,
        "expectedFingerprint": record.expected_fingerprint,
    });
    let bytes = serde_json::to_vec(&value).map_err(|error| {
        LegacyAuthorityLinkError::input(
            "FINGERPRINT_SERIALIZATION_ERROR",
            format!("expected fingerprint를 직렬화할 수 없음: {error}"),
            None,
        )
    })?;
    Ok(format!("{:x}", Sha256::digest(bytes)))
}

async fn insert_seed_run(
    transaction: &mut Transaction<'_, MySql>,
    run_id: Uuid,
    manifest: &Value,
) -> Result<(), LegacyAuthorityLinkError> {
    sqlx::query(
        "INSERT INTO seed_runs (
            id, run_kind, command, status, dry_run, manifest
         ) VALUES (?, ?, ?, 'RUNNING', FALSE, ?)",
    )
    .bind(run_id.to_string())
    .bind(RUN_KIND)
    .bind(COMMAND)
    .bind(sqlx::types::Json(manifest.clone()))
    .execute(&mut **transaction)
    .await?;
    Ok(())
}

async fn mark_seed_run_running(
    transaction: &mut Transaction<'_, MySql>,
    run_id: Uuid,
) -> Result<(), LegacyAuthorityLinkError> {
    sqlx::query(
        "UPDATE seed_runs
         SET status='RUNNING', finished_at=NULL
         WHERE id=?",
    )
    .bind(run_id.to_string())
    .execute(&mut **transaction)
    .await?;
    Ok(())
}

async fn apply_link(
    transaction: &mut Transaction<'_, MySql>,
    link: &ResolvedLink,
) -> Result<(), LegacyAuthorityLinkError> {
    let query = format!(
        "UPDATE {} SET authority_entity_id = ?, source_record_id = COALESCE(source_record_id, ?)
         WHERE id = ? AND origin = 'manual' AND editor_locked = TRUE",
        link.item.record.entity_type.table()
    );
    let result = sqlx::query(&query)
        .bind(&link.authority.authority_entity_id)
        .bind(link.authority.source_record_id)
        .bind(link.item.record.legacy_id)
        .execute(&mut **transaction)
        .await?;
    if result.rows_affected() != 1 {
        return Err(LegacyAuthorityLinkError::input(
            "LEGACY_LINK_UPDATE_FAILED",
            "manual legacy row 연결 update가 정확히 한 행을 변경하지 못함",
            Some(link.item.line),
        ));
    }
    Ok(())
}

async fn insert_seed_mutation(
    transaction: &mut Transaction<'_, MySql>,
    run_id: Uuid,
    link: &ResolvedLink,
) -> Result<u64, LegacyAuthorityLinkError> {
    let before = json!({
        "authority_entity_id": link.before.authority_entity_id,
        "source_record_id": link.before.source_record_id,
    });
    let after = json!({
        "authority_entity_id": link.authority.authority_entity_id,
        "source_record_id": link.before.source_record_id.or(link.authority.source_record_id),
        "linkage_review": {
            "expected_fingerprint": link.item.record.expected_fingerprint,
            "expected_fingerprint_sha256": link.fingerprint_sha256,
            "authority_identifier": link.item.record.authority_identifier,
            "reviewed_at": link.item.record.reviewed_at,
            "reviewer": link.item.record.reviewer,
            "evidence": link.item.record.evidence,
        }
    });
    let result = sqlx::query(
        "INSERT INTO seed_mutations (
            seed_run_id, target_table, target_id, operation,
            before_json, after_json, manual_guard_confirmed
         ) VALUES (?, ?, ?, 'UPDATE', ?, ?, TRUE)",
    )
    .bind(run_id.to_string())
    .bind(link.item.record.entity_type.table())
    .bind(link.item.record.legacy_id.to_string())
    .bind(sqlx::types::Json(before))
    .bind(sqlx::types::Json(after))
    .execute(&mut **transaction)
    .await?;
    Ok(result.last_insert_id())
}

async fn finish_seed_run(
    transaction: &mut Transaction<'_, MySql>,
    run_id: Uuid,
    counts: &LegacyLinkMutationCounts,
) -> Result<(), LegacyAuthorityLinkError> {
    let summary = json!({
        "contractVersion": CONTRACT_VERSION,
        "linked": counts.linked,
        "sourceRecordLinked": counts.source_record_linked,
        "reused": counts.reused,
        "mutationCount": counts.total,
    });
    let result = sqlx::query(
        "UPDATE seed_runs
         SET status='SUCCEEDED', summary=?, finished_at=CURRENT_TIMESTAMP(6)
         WHERE id=?",
    )
    .bind(sqlx::types::Json(summary))
    .bind(run_id.to_string())
    .execute(&mut **transaction)
    .await?;
    if result.rows_affected() != 1 {
        return Err(LegacyAuthorityLinkError::input(
            "SEED_RUN_FINISH_FAILED",
            "linkage seed run 완료 상태를 기록하지 못함",
            None,
        ));
    }
    Ok(())
}

fn build_rollback_manifest(
    run_id: Uuid,
    dry_run: bool,
    resolved: &[ResolvedLink],
    inserted_mutation_ids: &[u64],
    seed_run_inserted: bool,
) -> LegacyLinkRollbackManifest {
    let mut entries = resolved
        .iter()
        .filter(|link| link.needs_authority_link || link.needs_source_link)
        .rev()
        .map(|link| LegacyLinkRollbackEntry {
            sequence: 0,
            target_table: link.item.record.entity_type.table().to_string(),
            target_id: link.item.record.legacy_id.to_string(),
            reverse_operation: "RESTORE".to_string(),
            restore_json: Some(json!({
                "authority_entity_id": link.before.authority_entity_id,
                "source_record_id": link.before.source_record_id,
            })),
        })
        .collect::<Vec<_>>();
    for mutation_id in inserted_mutation_ids.iter().rev() {
        entries.push(LegacyLinkRollbackEntry {
            sequence: 0,
            target_table: "seed_mutations".to_string(),
            target_id: mutation_id.to_string(),
            reverse_operation: "DELETE".to_string(),
            restore_json: None,
        });
    }
    if dry_run && !entries.is_empty() && inserted_mutation_ids.is_empty() {
        entries.push(LegacyLinkRollbackEntry {
            sequence: 0,
            target_table: "seed_mutations".to_string(),
            target_id: run_id.to_string(),
            reverse_operation: "PLANNED_DELETE_BY_SEED_RUN".to_string(),
            restore_json: None,
        });
    }
    if seed_run_inserted {
        entries.push(LegacyLinkRollbackEntry {
            sequence: 0,
            target_table: "seed_runs".to_string(),
            target_id: run_id.to_string(),
            reverse_operation: "DELETE".to_string(),
            restore_json: None,
        });
    }
    for (index, entry) in entries.iter_mut().enumerate() {
        entry.sequence = index + 1;
    }
    LegacyLinkRollbackManifest {
        schema_version: "1",
        seed_run_id: run_id.to_string(),
        dry_run,
        entries,
    }
}

#[cfg(test)]
mod tests {
    use super::{parse_bundle, LegacyAuthorityLinkOptions};
    use std::{fs, path::PathBuf, time::SystemTime};
    use uuid::Uuid;

    fn temp_path(name: &str) -> PathBuf {
        std::env::temp_dir().join(format!(
            "classicmap-{name}-{}-{}.jsonl",
            std::process::id(),
            SystemTime::now()
                .duration_since(SystemTime::UNIX_EPOCH)
                .expect("현재 시각")
                .as_nanos()
        ))
    }

    fn valid_line() -> String {
        serde_json::json!({
            "entityType": "composer",
            "legacyId": 1,
            "expectedFingerprint": {
                "name": "바흐",
                "englishName": "Johann Sebastian Bach",
                "birthYear": "1685"
            },
            "authorityIdentifier": {"namespace": "wikidata", "value": "Q1339"},
            "reviewedAt": "2026-08-05T00:00:00Z",
            "reviewer": "fixture-reviewer",
            "evidence": {"url": "https://www.wikidata.org/wiki/Q1339", "note": "fixture"}
        })
        .to_string()
    }

    #[test]
    fn strict_unknown_field_and_duplicates_are_rejected() {
        let run_id = Uuid::parse_str("77777777-7777-4777-8777-777777777777").expect("UUID");
        let unknown = temp_path("legacy-link-unknown");
        let mut value: serde_json::Value = serde_json::from_str(&valid_line()).expect("JSON");
        value["unknown"] = serde_json::json!(true);
        fs::write(&unknown, format!("{value}\n")).expect("fixture 쓰기");
        let error = parse_bundle(&LegacyAuthorityLinkOptions::new(unknown.clone(), run_id))
            .expect_err("unknown field 거절");
        assert_eq!(error.code(), "INVALID_JSONL_RECORD");

        let duplicate = temp_path("legacy-link-duplicate");
        fs::write(&duplicate, format!("{}\n{}\n", valid_line(), valid_line()))
            .expect("fixture 쓰기");
        let error = parse_bundle(&LegacyAuthorityLinkOptions::new(duplicate.clone(), run_id))
            .expect_err("중복 target 거절");
        assert_eq!(error.code(), "DUPLICATE_LEGACY_TARGET");
        let duplicate_identifier = temp_path("legacy-link-duplicate-identifier");
        let first: serde_json::Value = serde_json::from_str(&valid_line()).expect("첫 JSON");
        let mut second = first.clone();
        second["legacyId"] = serde_json::json!(2);
        fs::write(&duplicate_identifier, format!("{first}\n{second}\n")).expect("fixture 쓰기");
        let error = parse_bundle(&LegacyAuthorityLinkOptions::new(
            duplicate_identifier.clone(),
            run_id,
        ))
        .expect_err("중복 identifier 거절");
        assert_eq!(error.code(), "DUPLICATE_AUTHORITY_IDENTIFIER");
        fs::remove_file(unknown).expect("fixture 삭제");
        fs::remove_file(duplicate).expect("fixture 삭제");
        fs::remove_file(duplicate_identifier).expect("fixture 삭제");
    }
}
