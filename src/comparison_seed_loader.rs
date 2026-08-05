use crate::db::DbPool;
use chrono::{DateTime, NaiveDateTime, Utc};
use serde::{Deserialize, Serialize};
use serde_json::{json, Value};
use sqlx::{MySql, Transaction};
use std::{collections::HashSet, fmt, fs, path::PathBuf};
use url::Url;

const MAX_CLIP_DURATION_SECONDS: u32 = 600;
const ENCODING_PROFILE_VERSION: &str = "v1-copy";

#[derive(Debug, Clone)]
pub struct ComparisonSeedLoadOptions {
    pub bundle_path: PathBuf,
    pub run_id: String,
    pub dry_run: bool,
    pub resume: bool,
    pub limit: Option<usize>,
    pub source_code_version: Option<String>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct CandidateRow {
    schema_version: String,
    candidate_key: String,
    candidate_status: String,
    confidence: String,
    reviewed_at: String,
    work_candidate: WorkCandidate,
    sector_candidate: SectorCandidate,
    source: SourceCandidate,
    credits: Vec<CreditCandidate>,
    clip: ClipCandidate,
    publication_gate: String,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct WorkCandidate {
    natural_key: String,
    preferred_title_ko: String,
    preferred_title_en: String,
    external_identifiers: Vec<ExternalIdentifier>,
    composer: ComposerCandidate,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct ComposerCandidate {
    preferred_name: String,
    name_ko: String,
    external_identifiers: Vec<ExternalIdentifier>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct ExternalIdentifier {
    namespace: String,
    value: String,
    source_url: String,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct SectorCandidate {
    sector_key: String,
    sector_type: String,
    name_ko: String,
    name_en: String,
    measure_start: String,
    measure_end: String,
    start_cue: String,
    end_cue: String,
    target_min_ms: u32,
    target_max_ms: u32,
    #[serde(default)]
    editorial_note: Option<String>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct SourceCandidate {
    provider: String,
    video_id: String,
    original_url: String,
    title: String,
    channel: String,
    channel_id: String,
    channel_url: String,
    upload_date: String,
    duration_seconds: u32,
    availability_status: String,
    availability_checked_at: String,
    availability_evidence: AvailabilityEvidence,
    rights_mode: String,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct AvailabilityEvidence {
    method: String,
    extractor_availability: String,
    live_status: String,
    oembed_url: String,
    oembed_http_status: u16,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct CreditCandidate {
    role_code: String,
    is_primary: bool,
    display_order: i32,
    entity_candidate: ArtistCandidate,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct ArtistCandidate {
    preferred_name: String,
    external_identifiers: Vec<ExternalIdentifier>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct ClipCandidate {
    start_seconds: u32,
    end_seconds: u32,
    timeline_method: String,
    verification_note: String,
}

#[derive(Debug, Clone)]
struct ValidatedCandidate {
    line: usize,
    row: CandidateRow,
    work_mbid: String,
    composer_wikidata_id: String,
    credit_wikidata_ids: Vec<String>,
    availability_checked_at: NaiveDateTime,
    start_ms: u32,
    end_ms: u32,
    evidence_json: String,
}

#[derive(Debug, Clone, Default, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ComparisonSeedMutationCounts {
    pub performance_sources: u64,
    pub performance_sectors: u64,
    pub performance_candidates: u64,
    pub performance_credits: u64,
    pub performances: u64,
    pub clip_jobs: u64,
    pub total: u64,
}

impl ComparisonSeedMutationCounts {
    fn increment(&mut self, table: &str) {
        match table {
            "performance_sources" => self.performance_sources += 1,
            "performance_sectors" => self.performance_sectors += 1,
            "performance_candidates" => self.performance_candidates += 1,
            "performance_credits" => self.performance_credits += 1,
            "performances" => self.performances += 1,
            "clip_jobs" => self.clip_jobs += 1,
            _ => unreachable!("지원하는 비교 시드 테이블만 기록함"),
        }
        self.total += 1;
    }
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ComparisonSeedLoadReport {
    pub status: &'static str,
    pub run_id: String,
    pub bundle_path: String,
    pub row_count: usize,
    pub dry_run: bool,
    pub mutations: ComparisonSeedMutationCounts,
    pub planned_mutations: ComparisonSeedMutationCounts,
}

#[derive(Debug)]
pub enum ComparisonSeedLoadError {
    Input {
        code: &'static str,
        message: String,
        line: Option<usize>,
    },
    Database(sqlx::Error),
}

impl ComparisonSeedLoadError {
    pub const fn code(&self) -> &'static str {
        match self {
            Self::Input { code, .. } => code,
            Self::Database(_) => "DATABASE_ERROR",
        }
    }

    pub const fn line(&self) -> Option<usize> {
        match self {
            Self::Input { line, .. } => *line,
            Self::Database(_) => None,
        }
    }

    pub const fn exit_code(&self) -> i32 {
        match self {
            Self::Input { .. } => 2,
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

impl fmt::Display for ComparisonSeedLoadError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Input { message, .. } => formatter.write_str(message),
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
        }
    }
}

impl std::error::Error for ComparisonSeedLoadError {}

impl From<sqlx::Error> for ComparisonSeedLoadError {
    fn from(error: sqlx::Error) -> Self {
        Self::Database(error)
    }
}

pub struct ComparisonSeedLoader;

impl ComparisonSeedLoader {
    pub async fn load(
        pool: &DbPool,
        options: &ComparisonSeedLoadOptions,
    ) -> Result<ComparisonSeedLoadReport, ComparisonSeedLoadError> {
        validate_uuid(&options.run_id, "runId", None)?;
        let mut candidates = parse_bundle(&options.bundle_path)?;
        if options.limit == Some(0) {
            return Err(ComparisonSeedLoadError::input(
                "INVALID_LIMIT",
                "limit은 1 이상이어야 함",
                None,
            ));
        }
        if let Some(limit) = options.limit {
            candidates.truncate(limit);
        }
        ensure_new_run_id(pool, &options.run_id).await?;

        let mut transaction = pool.begin().await?;
        insert_seed_run(&mut transaction, options).await?;
        let result = apply_candidates(&mut transaction, &candidates, &options.run_id).await;

        match result {
            Ok(counts) => {
                let summary = json!({
                    "rowCount": candidates.len(),
                    "mutations": counts,
                });
                if options.dry_run {
                    transaction.rollback().await?;
                    insert_terminal_dry_run(pool, options, &summary).await?;
                    Ok(ComparisonSeedLoadReport {
                        status: "dry-run",
                        run_id: options.run_id.clone(),
                        bundle_path: options.bundle_path.display().to_string(),
                        row_count: candidates.len(),
                        dry_run: true,
                        mutations: ComparisonSeedMutationCounts::default(),
                        planned_mutations: counts,
                    })
                } else {
                    finish_seed_run(&mut transaction, &options.run_id, "SUCCEEDED", &summary)
                        .await?;
                    transaction.commit().await?;
                    Ok(ComparisonSeedLoadReport {
                        status: "succeeded",
                        run_id: options.run_id.clone(),
                        bundle_path: options.bundle_path.display().to_string(),
                        row_count: candidates.len(),
                        dry_run: false,
                        mutations: counts.clone(),
                        planned_mutations: counts,
                    })
                }
            }
            Err(error) => {
                transaction.rollback().await?;
                insert_failed_run(pool, options, &candidates, &error).await?;
                Err(error)
            }
        }
    }
}

fn parse_bundle(path: &PathBuf) -> Result<Vec<ValidatedCandidate>, ComparisonSeedLoadError> {
    let contents = fs::read_to_string(path).map_err(|error| {
        ComparisonSeedLoadError::input(
            "BUNDLE_READ_ERROR",
            format!("후보 bundle을 읽을 수 없음: {error}"),
            None,
        )
    })?;
    let mut candidate_keys = HashSet::new();
    let mut video_ids = HashSet::new();
    let mut rows = Vec::new();

    for (index, raw_line) in contents.lines().enumerate() {
        let line = index + 1;
        if raw_line.trim().is_empty() {
            return Err(ComparisonSeedLoadError::input(
                "INVALID_BUNDLE_ROW",
                "빈 JSONL 행은 허용하지 않음",
                Some(line),
            ));
        }
        let row = serde_json::from_str::<CandidateRow>(raw_line).map_err(|error| {
            ComparisonSeedLoadError::input(
                "INVALID_BUNDLE_ROW",
                format!("후보 행을 strict parse할 수 없음: {error}"),
                Some(line),
            )
        })?;
        validate_candidate(&row, line)?;
        if !candidate_keys.insert(row.candidate_key.clone()) {
            return Err(ComparisonSeedLoadError::input(
                "DUPLICATE_CANDIDATE_KEY",
                format!("candidateKey가 중복됨: {}", row.candidate_key),
                Some(line),
            ));
        }
        if !video_ids.insert(row.source.video_id.clone()) {
            return Err(ComparisonSeedLoadError::input(
                "DUPLICATE_VIDEO_ID",
                format!("videoId가 중복됨: {}", row.source.video_id),
                Some(line),
            ));
        }

        let work_mbid = one_identifier(
            &row.work_candidate.external_identifiers,
            "musicbrainz_work",
            line,
            "작품",
        )?;
        validate_uuid(&work_mbid, "musicbrainz_work", Some(line))?;
        let canonical_natural_key =
            row.work_candidate
                .natural_key
                .replacen("musicbrainz-work:", "musicbrainz_work:", 1);
        if canonical_natural_key != format!("musicbrainz_work:{work_mbid}") {
            return Err(ComparisonSeedLoadError::input(
                "INVALID_WORK_NATURAL_KEY",
                "작품 naturalKey를 musicbrainz_work:{MBID}로 정규화할 수 없거나 식별자와 다름",
                Some(line),
            ));
        }
        let composer_wikidata_id = one_identifier(
            &row.work_candidate.composer.external_identifiers,
            "wikidata",
            line,
            "작곡가",
        )?;
        validate_wikidata_id(&composer_wikidata_id, line)?;
        let mut credit_wikidata_ids = Vec::with_capacity(row.credits.len());
        for credit in &row.credits {
            let wikidata_id = one_identifier(
                &credit.entity_candidate.external_identifiers,
                "wikidata",
                line,
                "연주자",
            )?;
            validate_wikidata_id(&wikidata_id, line)?;
            credit_wikidata_ids.push(wikidata_id);
        }
        let reviewed_at = parse_timestamp(&row.reviewed_at, "reviewedAt", line)?;
        let availability_checked_at = parse_timestamp(
            &row.source.availability_checked_at,
            "availabilityCheckedAt",
            line,
        )?;
        if reviewed_at < availability_checked_at {
            return Err(ComparisonSeedLoadError::input(
                "INVALID_REVIEW_TIME",
                "reviewedAt은 availabilityCheckedAt보다 빠를 수 없음",
                Some(line),
            ));
        }
        let start_ms = row.clip.start_seconds.checked_mul(1000).ok_or_else(|| {
            ComparisonSeedLoadError::input(
                "INVALID_CLIP_RANGE",
                "startSeconds를 밀리초로 변환할 수 없음",
                Some(line),
            )
        })?;
        let end_ms = row.clip.end_seconds.checked_mul(1000).ok_or_else(|| {
            ComparisonSeedLoadError::input(
                "INVALID_CLIP_RANGE",
                "endSeconds를 밀리초로 변환할 수 없음",
                Some(line),
            )
        })?;
        let evidence_json = serde_json::to_string(&row).map_err(|error| {
            ComparisonSeedLoadError::input(
                "INVALID_BUNDLE_ROW",
                format!("후보 근거를 직렬화할 수 없음: {error}"),
                Some(line),
            )
        })?;
        rows.push(ValidatedCandidate {
            line,
            row,
            work_mbid,
            composer_wikidata_id,
            credit_wikidata_ids,
            availability_checked_at,
            start_ms,
            end_ms,
            evidence_json,
        });
    }

    if rows.is_empty() {
        return Err(ComparisonSeedLoadError::input(
            "EMPTY_BUNDLE",
            "후보 bundle이 비어 있음",
            None,
        ));
    }
    rows.sort_by(|left, right| left.row.candidate_key.cmp(&right.row.candidate_key));
    Ok(rows)
}

fn validate_candidate(row: &CandidateRow, line: usize) -> Result<(), ComparisonSeedLoadError> {
    if row.schema_version != "1"
        || row.candidate_status != "APPROVED"
        || row.publication_gate != "RIGHTS_AND_CLIP_ASSET_REQUIRED"
    {
        return Err(ComparisonSeedLoadError::input(
            "INVALID_REVIEW_GATE",
            "schemaVersion=1, candidateStatus=APPROVED, publicationGate=RIGHTS_AND_CLIP_ASSET_REQUIRED만 적재할 수 있음",
            Some(line),
        ));
    }
    if row.source.provider != "youtube"
        || !is_youtube_video_id(&row.source.video_id)
        || row.source.original_url
            != format!("https://www.youtube.com/watch?v={}", row.source.video_id)
        || row.source.availability_status != "AVAILABLE"
        || row.source.rights_mode != "unknown"
        || row.source.availability_evidence.extractor_availability != "public"
        || row.source.availability_evidence.live_status != "not_live"
        || row.source.availability_evidence.oembed_http_status != 200
    {
        return Err(ComparisonSeedLoadError::input(
            "INVALID_SOURCE_CONTRACT",
            "공개 상태가 확인된 정규 YouTube URL과 rightsMode=unknown 후보만 지원함",
            Some(line),
        ));
    }
    validate_https_url(&row.source.original_url, "source.originalUrl", line)?;
    validate_https_url(&row.source.channel_url, "source.channelUrl", line)?;
    validate_https_url(
        &row.source.availability_evidence.oembed_url,
        "source.availabilityEvidence.oembedUrl",
        line,
    )?;
    if row.source.duration_seconds == 0
        || row.clip.end_seconds <= row.clip.start_seconds
        || row.clip.end_seconds - row.clip.start_seconds > MAX_CLIP_DURATION_SECONDS
        || row.clip.end_seconds > row.source.duration_seconds
    {
        return Err(ComparisonSeedLoadError::input(
            "INVALID_CLIP_RANGE",
            "클립 구간은 원본 길이 안의 1~600초여야 함",
            Some(line),
        ));
    }
    let expected_key = format!(
        "yt:{}:{}:{}",
        row.source.video_id, row.clip.start_seconds, row.clip.end_seconds
    );
    if row.candidate_key != expected_key {
        return Err(ComparisonSeedLoadError::input(
            "INVALID_CANDIDATE_KEY",
            format!("candidateKey가 영상/구간과 다름: {expected_key}"),
            Some(line),
        ));
    }
    if row.credits.is_empty()
        || row
            .credits
            .iter()
            .filter(|credit| credit.is_primary)
            .count()
            != 1
        || row.credits.iter().any(|credit| {
            credit.role_code.is_empty()
                || credit.role_code.len() > 64
                || !credit
                    .role_code
                    .chars()
                    .all(|character| character.is_ascii_uppercase() || character == '_')
        })
    {
        return Err(ComparisonSeedLoadError::input(
            "INVALID_CREDITS",
            "크레딧에는 정확히 한 primary와 대문자 roleCode가 필요함",
            Some(line),
        ));
    }
    if row.sector_candidate.sector_key.is_empty()
        || row.sector_candidate.sector_key.len() > 150
        || !row.sector_candidate.sector_key.chars().all(|character| {
            character.is_ascii_lowercase() || character == '-' || character.is_ascii_digit()
        })
        || row.sector_candidate.target_min_ms == 0
        || row.sector_candidate.target_max_ms < row.sector_candidate.target_min_ms
        || row.sector_candidate.target_max_ms > 600_000
    {
        return Err(ComparisonSeedLoadError::input(
            "INVALID_SECTOR",
            "sectorKey 또는 목표 구간이 계약과 다름",
            Some(line),
        ));
    }
    Ok(())
}

async fn apply_candidates(
    transaction: &mut Transaction<'_, MySql>,
    candidates: &[ValidatedCandidate],
    run_id: &str,
) -> Result<ComparisonSeedMutationCounts, ComparisonSeedLoadError> {
    let mut counts = ComparisonSeedMutationCounts::default();

    for candidate in candidates {
        let piece_id = resolve_piece(transaction, candidate).await?;
        let artist_ids = resolve_artists(transaction, candidate).await?;
        let primary_artist_id = candidate
            .row
            .credits
            .iter()
            .zip(&artist_ids)
            .find_map(|(credit, artist_id)| credit.is_primary.then_some(*artist_id))
            .expect("입력 검증에서 primary 크레딧을 보장함");

        let source_id = ensure_source(transaction, candidate, run_id, &mut counts).await?;
        let sector_id =
            ensure_sector(transaction, candidate, piece_id, run_id, &mut counts).await?;
        ensure_candidate(
            transaction,
            candidate,
            sector_id,
            source_id,
            run_id,
            &mut counts,
        )
        .await?;
        ensure_credits(
            transaction,
            candidate,
            source_id,
            &artist_ids,
            run_id,
            &mut counts,
        )
        .await?;
        let performance_id = ensure_performance(
            transaction,
            candidate,
            piece_id,
            sector_id,
            source_id,
            primary_artist_id,
            run_id,
            &mut counts,
        )
        .await?;
        ensure_clip_job(transaction, candidate, performance_id, run_id, &mut counts).await?;
    }

    Ok(counts)
}

async fn resolve_piece(
    transaction: &mut Transaction<'_, MySql>,
    candidate: &ValidatedCandidate,
) -> Result<i32, ComparisonSeedLoadError> {
    let rows = sqlx::query_as::<_, (i32, String)>(
        "SELECT piece.id, CAST(composer_identifier.external_id AS CHAR CHARACTER SET utf8mb4)
         FROM piece_identifiers piece_identifier
         JOIN pieces piece ON piece.id = piece_identifier.piece_id
         JOIN composers composer ON composer.id = piece.composer_id
         JOIN external_identifiers composer_identifier
           ON composer_identifier.authority_entity_id = composer.authority_entity_id
          AND composer_identifier.namespace = 'wikidata'
         WHERE piece_identifier.namespace = 'musicbrainz_work'
           AND piece_identifier.external_id = ?
         FOR UPDATE",
    )
    .bind(&candidate.work_mbid)
    .fetch_all(&mut **transaction)
    .await?;
    if rows.len() != 1 || rows[0].1 != candidate.composer_wikidata_id {
        return Err(ComparisonSeedLoadError::input(
            "UNRESOLVED_WORK_IDENTIFIER",
            format!(
                "MusicBrainz 작품 {}와 Wikidata 작곡가 {}를 정확히 해소할 수 없음",
                candidate.work_mbid, candidate.composer_wikidata_id
            ),
            Some(candidate.line),
        ));
    }
    Ok(rows[0].0)
}

async fn resolve_artists(
    transaction: &mut Transaction<'_, MySql>,
    candidate: &ValidatedCandidate,
) -> Result<Vec<i32>, ComparisonSeedLoadError> {
    let mut resolved = Vec::with_capacity(candidate.credit_wikidata_ids.len());
    let mut seen = HashSet::new();
    for wikidata_id in &candidate.credit_wikidata_ids {
        let rows = sqlx::query_scalar::<_, i32>(
            "SELECT artist.id
             FROM external_identifiers identifier
             JOIN artists artist
               ON artist.authority_entity_id = identifier.authority_entity_id
             WHERE identifier.namespace = 'wikidata' AND identifier.external_id = ?
             FOR UPDATE",
        )
        .bind(wikidata_id)
        .fetch_all(&mut **transaction)
        .await?;
        if rows.len() != 1 || !seen.insert(rows[0]) {
            return Err(ComparisonSeedLoadError::input(
                "UNRESOLVED_ARTIST_IDENTIFIER",
                format!("Wikidata 연주자 {wikidata_id}를 정확히 해소할 수 없음"),
                Some(candidate.line),
            ));
        }
        resolved.push(rows[0]);
    }
    Ok(resolved)
}

async fn ensure_source(
    transaction: &mut Transaction<'_, MySql>,
    candidate: &ValidatedCandidate,
    run_id: &str,
    counts: &mut ComparisonSeedMutationCounts,
) -> Result<u64, ComparisonSeedLoadError> {
    let existing = sqlx::query_as::<_, (u64, String, String, Option<String>, Option<u32>)>(
        "SELECT id,
                CAST(availability_status AS CHAR CHARACTER SET utf8mb4),
                CAST(rights_mode AS CHAR CHARACTER SET utf8mb4),
                source_url, source_duration_ms
         FROM performance_sources
         WHERE provider = ? AND provider_video_id = ?
         FOR UPDATE",
    )
    .bind(&candidate.row.source.provider)
    .bind(&candidate.row.source.video_id)
    .fetch_optional(&mut **transaction)
    .await?;
    if let Some((id, availability, rights_mode, source_url, source_duration_ms)) = existing {
        if availability != "AVAILABLE"
            || rights_mode != "unknown"
            || source_url.as_deref() != Some(candidate.row.source.original_url.as_str())
            || source_duration_ms != candidate.row.source.duration_seconds.checked_mul(1000)
        {
            return Err(ComparisonSeedLoadError::input(
                "SOURCE_STATE_CONFLICT",
                "기존 영상 source 상태가 후보 bundle과 다르므로 자동 변경하지 않음",
                Some(candidate.line),
            ));
        }
        return Ok(id);
    }

    let source_duration_ms = candidate
        .row
        .source
        .duration_seconds
        .checked_mul(1000)
        .ok_or_else(|| {
            ComparisonSeedLoadError::input(
                "INVALID_SOURCE_DURATION",
                "원본 영상 길이를 밀리초로 변환할 수 없음",
                Some(candidate.line),
            )
        })?;
    let inserted = sqlx::query(
        "INSERT INTO performance_sources (
            provider, provider_video_id, source_url, source_duration_ms,
            availability_status, rights_mode, last_checked_at
         ) VALUES (?, ?, ?, ?, 'AVAILABLE', 'unknown', ?)",
    )
    .bind(&candidate.row.source.provider)
    .bind(&candidate.row.source.video_id)
    .bind(&candidate.row.source.original_url)
    .bind(source_duration_ms)
    .bind(candidate.availability_checked_at)
    .execute(&mut **transaction)
    .await?;
    let id = inserted.last_insert_id();
    record_insert_mutation(
        transaction,
        run_id,
        "performance_sources",
        id.to_string(),
        json!({
            "provider": candidate.row.source.provider,
            "providerVideoId": candidate.row.source.video_id,
            "rightsMode": "unknown",
        }),
    )
    .await?;
    counts.increment("performance_sources");
    Ok(id)
}

async fn ensure_sector(
    transaction: &mut Transaction<'_, MySql>,
    candidate: &ValidatedCandidate,
    piece_id: i32,
    run_id: &str,
    counts: &mut ComparisonSeedMutationCounts,
) -> Result<i32, ComparisonSeedLoadError> {
    let existing = sqlx::query_scalar::<_, i32>(
        "SELECT id FROM performance_sectors
         WHERE piece_id = ? AND sector_key = ?
         FOR UPDATE",
    )
    .bind(piece_id)
    .bind(&candidate.row.sector_candidate.sector_key)
    .fetch_optional(&mut **transaction)
    .await?;
    if let Some(id) = existing {
        return Ok(id);
    }
    let sector = &candidate.row.sector_candidate;
    let description = sector.editorial_note.as_deref();
    let inserted = sqlx::query(
        "INSERT INTO performance_sectors (
            piece_id, sector_name, description, display_order, sector_key,
            sector_type, name_ko, name_en, measure_start, measure_end,
            start_cue, end_cue, target_min_ms, target_max_ms,
            editorial_status, origin, editor_locked
         ) VALUES (?, ?, ?, 0, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
                   'FACTS_VERIFIED', 'seed', FALSE)",
    )
    .bind(piece_id)
    .bind(&sector.name_ko)
    .bind(description)
    .bind(&sector.sector_key)
    .bind(&sector.sector_type)
    .bind(&sector.name_ko)
    .bind(&sector.name_en)
    .bind(&sector.measure_start)
    .bind(&sector.measure_end)
    .bind(&sector.start_cue)
    .bind(&sector.end_cue)
    .bind(sector.target_min_ms)
    .bind(sector.target_max_ms)
    .execute(&mut **transaction)
    .await?;
    let id = i32::try_from(inserted.last_insert_id()).map_err(|_| {
        ComparisonSeedLoadError::input(
            "DATABASE_ID_OVERFLOW",
            "새 performance sector ID가 i32 범위를 벗어남",
            Some(candidate.line),
        )
    })?;
    record_insert_mutation(
        transaction,
        run_id,
        "performance_sectors",
        id.to_string(),
        json!({"pieceId": piece_id, "sectorKey": sector.sector_key}),
    )
    .await?;
    counts.increment("performance_sectors");
    Ok(id)
}

async fn ensure_candidate(
    transaction: &mut Transaction<'_, MySql>,
    candidate: &ValidatedCandidate,
    sector_id: i32,
    source_id: u64,
    run_id: &str,
    counts: &mut ComparisonSeedMutationCounts,
) -> Result<(), ComparisonSeedLoadError> {
    let existing = sqlx::query_as::<_, (u64, String, Option<String>)>(
        "SELECT id,
                CAST(candidate_status AS CHAR CHARACTER SET utf8mb4),
                CAST(JSON_UNQUOTE(JSON_EXTRACT(evidence, '$.candidateKey')) AS CHAR CHARACTER SET utf8mb4)
         FROM performance_candidates
         WHERE sector_id = ? AND performance_source_id = ?
           AND proposed_start_ms = ? AND proposed_end_ms = ?
         FOR UPDATE",
    )
    .bind(sector_id)
    .bind(source_id)
    .bind(candidate.start_ms)
    .bind(candidate.end_ms)
    .fetch_optional(&mut **transaction)
    .await?;
    if let Some((_id, status, candidate_key)) = existing {
        if status != "REVIEW_REQUIRED"
            || candidate_key.as_deref() != Some(candidate.row.candidate_key.as_str())
        {
            return Err(ComparisonSeedLoadError::input(
                "CANDIDATE_STATE_CONFLICT",
                "기존 후보 상태 또는 candidateKey가 bundle과 다르므로 자동 변경하지 않음",
                Some(candidate.line),
            ));
        }
        return Ok(());
    }
    let inserted = sqlx::query(
        "INSERT INTO performance_candidates (
            sector_id, performance_source_id, proposed_start_ms,
            proposed_end_ms, candidate_status, evidence, seed_run_id
         ) VALUES (?, ?, ?, ?, 'REVIEW_REQUIRED', CAST(? AS JSON), ?)",
    )
    .bind(sector_id)
    .bind(source_id)
    .bind(candidate.start_ms)
    .bind(candidate.end_ms)
    .bind(&candidate.evidence_json)
    .bind(run_id)
    .execute(&mut **transaction)
    .await?;
    let id = inserted.last_insert_id();
    record_insert_mutation(
        transaction,
        run_id,
        "performance_candidates",
        id.to_string(),
        json!({
            "candidateKey": candidate.row.candidate_key,
            "candidateStatus": "REVIEW_REQUIRED",
        }),
    )
    .await?;
    counts.increment("performance_candidates");
    Ok(())
}

async fn ensure_credits(
    transaction: &mut Transaction<'_, MySql>,
    candidate: &ValidatedCandidate,
    source_id: u64,
    artist_ids: &[i32],
    run_id: &str,
    counts: &mut ComparisonSeedMutationCounts,
) -> Result<(), ComparisonSeedLoadError> {
    for (credit, artist_id) in candidate.row.credits.iter().zip(artist_ids) {
        let canonical_role = canonical_credit_role(&credit.role_code, candidate.line)?;
        let existing = sqlx::query_as::<_, (u64, bool, i32)>(
            "SELECT id, is_primary, display_order FROM performance_credits
             WHERE performance_source_id = ? AND artist_id = ? AND role_code = ?
             FOR UPDATE",
        )
        .bind(source_id)
        .bind(artist_id)
        .bind(canonical_role)
        .fetch_optional(&mut **transaction)
        .await?;
        if let Some((_id, is_primary, display_order)) = existing {
            if is_primary != credit.is_primary || display_order != credit.display_order {
                return Err(ComparisonSeedLoadError::input(
                    "CREDIT_STATE_CONFLICT",
                    "기존 performance credit이 bundle과 다르므로 자동 변경하지 않음",
                    Some(candidate.line),
                ));
            }
            continue;
        }
        let inserted = sqlx::query(
            "INSERT INTO performance_credits (
                performance_source_id, artist_id, role_code, is_primary, display_order
             ) VALUES (?, ?, ?, ?, ?)",
        )
        .bind(source_id)
        .bind(artist_id)
        .bind(canonical_role)
        .bind(credit.is_primary)
        .bind(credit.display_order)
        .execute(&mut **transaction)
        .await?;
        let id = inserted.last_insert_id();
        record_insert_mutation(
            transaction,
            run_id,
            "performance_credits",
            id.to_string(),
            json!({
                "performanceSourceId": source_id,
                "artistId": artist_id,
                "roleCode": canonical_role,
                "sourceRoleCode": credit.role_code,
            }),
        )
        .await?;
        counts.increment("performance_credits");
    }
    Ok(())
}

#[allow(clippy::too_many_arguments)]
async fn ensure_performance(
    transaction: &mut Transaction<'_, MySql>,
    candidate: &ValidatedCandidate,
    piece_id: i32,
    sector_id: i32,
    source_id: u64,
    primary_artist_id: i32,
    run_id: &str,
    counts: &mut ComparisonSeedMutationCounts,
) -> Result<i32, ComparisonSeedLoadError> {
    let existing = sqlx::query_as::<_, (i32, String, bool, i32, i32, String)>(
        "SELECT id,
                CAST(publish_status AS CHAR CHARACTER SET utf8mb4),
                editor_locked, piece_id, artist_id,
                CAST(video_id AS CHAR CHARACTER SET utf8mb4)
         FROM performances
         WHERE sector_id = ? AND performance_source_id = ?
           AND start_ms = ? AND end_ms = ? AND origin = 'seed'
         FOR UPDATE",
    )
    .bind(sector_id)
    .bind(source_id)
    .bind(candidate.start_ms)
    .bind(candidate.end_ms)
    .fetch_optional(&mut **transaction)
    .await?;
    if let Some((id, publish_status, editor_locked, existing_piece, existing_artist, video_id)) =
        existing
    {
        if publish_status != "DRAFT"
            || editor_locked
            || existing_piece != piece_id
            || existing_artist != primary_artist_id
            || video_id != candidate.row.source.video_id
        {
            return Err(ComparisonSeedLoadError::input(
                "PERFORMANCE_STATE_CONFLICT",
                "권리 미확인 seed performance가 DRAFT/unlocked 상태가 아니므로 자동 변경하지 않음",
                Some(candidate.line),
            ));
        }
        return Ok(id);
    }

    let inserted = sqlx::query(
        "INSERT INTO performances (
            sector_id, piece_id, artist_id, video_platform, video_id,
            start_time, end_time, characteristic, performance_source_id,
            start_ms, end_ms, publish_status, seed_run_id, origin, editor_locked
         ) VALUES (?, ?, ?, 'youtube', ?, ?, ?, ?, ?, ?, ?, 'DRAFT', ?, 'seed', FALSE)",
    )
    .bind(sector_id)
    .bind(piece_id)
    .bind(primary_artist_id)
    .bind(&candidate.row.source.video_id)
    .bind(candidate.row.clip.start_seconds)
    .bind(candidate.row.clip.end_seconds)
    .bind(&candidate.row.clip.verification_note)
    .bind(source_id)
    .bind(candidate.start_ms)
    .bind(candidate.end_ms)
    .bind(run_id)
    .execute(&mut **transaction)
    .await?;
    let id = i32::try_from(inserted.last_insert_id()).map_err(|_| {
        ComparisonSeedLoadError::input(
            "DATABASE_ID_OVERFLOW",
            "새 performance ID가 i32 범위를 벗어남",
            Some(candidate.line),
        )
    })?;
    record_insert_mutation(
        transaction,
        run_id,
        "performances",
        id.to_string(),
        json!({
            "candidateKey": candidate.row.candidate_key,
            "publishStatus": "DRAFT",
        }),
    )
    .await?;
    counts.increment("performances");
    Ok(id)
}

async fn ensure_clip_job(
    transaction: &mut Transaction<'_, MySql>,
    candidate: &ValidatedCandidate,
    performance_id: i32,
    run_id: &str,
    counts: &mut ComparisonSeedMutationCounts,
) -> Result<(), ComparisonSeedLoadError> {
    let duration_ms = candidate.end_ms - candidate.start_ms;
    let output_key = format!(
        "{}-{}-{}-{}.mp4",
        candidate.row.source.video_id, candidate.start_ms, duration_ms, ENCODING_PROFILE_VERSION
    );
    let existing = sqlx::query_as::<_, (u64, String, String)>(
        "SELECT id, CAST(status AS CHAR CHARACTER SET utf8mb4),
                CAST(encoding_profile_version AS CHAR CHARACTER SET utf8mb4)
         FROM clip_jobs
         WHERE performance_id = ? AND output_key = ?
         FOR UPDATE",
    )
    .bind(performance_id)
    .bind(&output_key)
    .fetch_optional(&mut **transaction)
    .await?;
    if let Some((_id, status, encoding_profile)) = existing {
        if status != "PENDING" || encoding_profile != ENCODING_PROFILE_VERSION {
            return Err(ComparisonSeedLoadError::input(
                "CLIP_JOB_STATE_CONFLICT",
                "권리 미확인 후보의 clip job이 PENDING 상태가 아니므로 자동 변경하지 않음",
                Some(candidate.line),
            ));
        }
        return Ok(());
    }
    let inserted = sqlx::query(
        "INSERT INTO clip_jobs (
            performance_id, seed_run_id, status, output_key,
            encoding_profile_version, attempts, priority
         ) VALUES (?, ?, 'PENDING', ?, ?, 0, 0)",
    )
    .bind(performance_id)
    .bind(run_id)
    .bind(&output_key)
    .bind(ENCODING_PROFILE_VERSION)
    .execute(&mut **transaction)
    .await?;
    let id = inserted.last_insert_id();
    record_insert_mutation(
        transaction,
        run_id,
        "clip_jobs",
        id.to_string(),
        json!({
            "performanceId": performance_id,
            "status": "PENDING",
            "outputKey": output_key,
        }),
    )
    .await?;
    counts.increment("clip_jobs");
    Ok(())
}

async fn record_insert_mutation(
    transaction: &mut Transaction<'_, MySql>,
    run_id: &str,
    target_table: &str,
    target_id: String,
    after_json: Value,
) -> Result<(), ComparisonSeedLoadError> {
    sqlx::query(
        "INSERT INTO seed_mutations (
            seed_run_id, target_table, target_id, operation,
            before_json, after_json, manual_guard_confirmed
         ) VALUES (?, ?, ?, 'INSERT', NULL, CAST(? AS JSON), TRUE)",
    )
    .bind(run_id)
    .bind(target_table)
    .bind(target_id)
    .bind(after_json.to_string())
    .execute(&mut **transaction)
    .await?;
    Ok(())
}

async fn ensure_new_run_id(pool: &DbPool, run_id: &str) -> Result<(), ComparisonSeedLoadError> {
    let exists = sqlx::query_scalar::<_, i64>("SELECT COUNT(*) FROM seed_runs WHERE id = ?")
        .bind(run_id)
        .fetch_one(pool)
        .await?;
    if exists != 0 {
        return Err(ComparisonSeedLoadError::input(
            "DUPLICATE_RUN_ID",
            format!("이미 존재하는 runId임: {run_id}"),
            None,
        ));
    }
    Ok(())
}

async fn insert_seed_run(
    transaction: &mut Transaction<'_, MySql>,
    options: &ComparisonSeedLoadOptions,
) -> Result<(), ComparisonSeedLoadError> {
    let manifest = json!({
        "bundlePath": options.bundle_path.display().to_string(),
        "resume": options.resume,
        "limit": options.limit,
    });
    sqlx::query(
        "INSERT INTO seed_runs (
            id, run_kind, command, status, dry_run, source_code_version, manifest
         ) VALUES (?, 'comparison_candidates', 'load_comparison_candidates',
                   'RUNNING', ?, ?, CAST(? AS JSON))",
    )
    .bind(&options.run_id)
    .bind(options.dry_run)
    .bind(&options.source_code_version)
    .bind(manifest.to_string())
    .execute(&mut **transaction)
    .await?;
    Ok(())
}

async fn finish_seed_run(
    transaction: &mut Transaction<'_, MySql>,
    run_id: &str,
    status: &str,
    summary: &Value,
) -> Result<(), ComparisonSeedLoadError> {
    sqlx::query(
        "UPDATE seed_runs
         SET status = ?, summary = CAST(? AS JSON), finished_at = CURRENT_TIMESTAMP(6)
         WHERE id = ?",
    )
    .bind(status)
    .bind(summary.to_string())
    .bind(run_id)
    .execute(&mut **transaction)
    .await?;
    Ok(())
}

async fn insert_terminal_dry_run(
    pool: &DbPool,
    options: &ComparisonSeedLoadOptions,
    summary: &Value,
) -> Result<(), ComparisonSeedLoadError> {
    let manifest = json!({
        "bundlePath": options.bundle_path.display().to_string(),
        "resume": options.resume,
        "limit": options.limit,
    });
    sqlx::query(
        "INSERT INTO seed_runs (
            id, run_kind, command, status, dry_run, source_code_version,
            manifest, summary, finished_at
         ) VALUES (?, 'comparison_candidates', 'load_comparison_candidates',
                   'SUCCEEDED', TRUE, ?, CAST(? AS JSON), CAST(? AS JSON), CURRENT_TIMESTAMP(6))",
    )
    .bind(&options.run_id)
    .bind(&options.source_code_version)
    .bind(manifest.to_string())
    .bind(summary.to_string())
    .execute(pool)
    .await?;
    Ok(())
}

async fn insert_failed_run(
    pool: &DbPool,
    options: &ComparisonSeedLoadOptions,
    candidates: &[ValidatedCandidate],
    error: &ComparisonSeedLoadError,
) -> Result<(), ComparisonSeedLoadError> {
    let manifest = json!({
        "bundlePath": options.bundle_path.display().to_string(),
        "resume": options.resume,
        "limit": options.limit,
    });
    let summary = json!({
        "error": {"code": error.code(), "message": error.to_string(), "line": error.line()},
    });
    let mut transaction = pool.begin().await?;
    sqlx::query(
        "INSERT INTO seed_runs (
            id, run_kind, command, status, dry_run, source_code_version,
            manifest, summary, finished_at
         ) VALUES (?, 'comparison_candidates', 'load_comparison_candidates',
                   'FAILED', ?, ?, CAST(? AS JSON), CAST(? AS JSON), CURRENT_TIMESTAMP(6))",
    )
    .bind(&options.run_id)
    .bind(options.dry_run)
    .bind(&options.source_code_version)
    .bind(manifest.to_string())
    .bind(summary.to_string())
    .execute(&mut *transaction)
    .await?;
    if let Some(line) = error.line() {
        if let Some(candidate) = candidates.iter().find(|candidate| candidate.line == line) {
            match error.code() {
                "UNRESOLVED_ARTIST_IDENTIFIER" => {
                    for wikidata_id in &candidate.credit_wikidata_ids {
                        let count = sqlx::query_scalar::<_, i64>(
                            "SELECT COUNT(*)
                             FROM external_identifiers identifier
                             JOIN artists artist
                               ON artist.authority_entity_id = identifier.authority_entity_id
                             WHERE identifier.namespace = 'wikidata'
                               AND identifier.external_id = ?",
                        )
                        .bind(wikidata_id)
                        .fetch_one(&mut *transaction)
                        .await?;
                        if count != 1 {
                            insert_resolution_review(
                                &mut transaction,
                                &options.run_id,
                                "artist",
                                &format!("wikidata:{wikidata_id}"),
                                "MISSING_OR_AMBIGUOUS_LEGACY_ARTIST",
                                candidate,
                                "wikidata",
                                wikidata_id,
                            )
                            .await?;
                        }
                    }
                }
                "UNRESOLVED_WORK_IDENTIFIER" => {
                    insert_resolution_review(
                        &mut transaction,
                        &options.run_id,
                        "piece",
                        &format!("musicbrainz_work:{}", candidate.work_mbid),
                        "MISSING_OR_MISMATCHED_LEGACY_WORK",
                        candidate,
                        "musicbrainz_work",
                        &candidate.work_mbid,
                    )
                    .await?;
                }
                _ => {}
            }
        }
    }
    transaction.commit().await?;
    Ok(())
}

#[allow(clippy::too_many_arguments)]
async fn insert_resolution_review(
    transaction: &mut Transaction<'_, MySql>,
    run_id: &str,
    target_type: &str,
    target_id: &str,
    reason_code: &str,
    candidate: &ValidatedCandidate,
    namespace: &str,
    external_id: &str,
) -> Result<(), ComparisonSeedLoadError> {
    let evidence = json!({
        "candidateKey": candidate.row.candidate_key,
        "namespace": namespace,
        "externalId": external_id,
        "automaticNameMatch": false,
        "action": "legacy 행을 권위 식별자로 먼저 연결한 뒤 후보 bundle을 재실행해야 합니다.",
    });
    sqlx::query(
        "INSERT INTO review_queue (
            seed_run_id, target_type, target_id, reason_code,
            status, priority, evidence
         ) VALUES (?, ?, ?, ?, 'OPEN', 100, CAST(? AS JSON))",
    )
    .bind(run_id)
    .bind(target_type)
    .bind(target_id)
    .bind(reason_code)
    .bind(evidence.to_string())
    .execute(&mut **transaction)
    .await?;
    Ok(())
}

fn one_identifier(
    identifiers: &[ExternalIdentifier],
    namespace: &str,
    line: usize,
    subject: &str,
) -> Result<String, ComparisonSeedLoadError> {
    let unique = identifiers
        .iter()
        .map(|identifier| (&identifier.namespace, &identifier.value))
        .collect::<HashSet<_>>();
    if unique.len() != identifiers.len() {
        return Err(ComparisonSeedLoadError::input(
            "DUPLICATE_EXTERNAL_IDENTIFIER",
            format!("{subject} 외부 식별자가 중복됨"),
            Some(line),
        ));
    }
    let matches = identifiers
        .iter()
        .filter(|identifier| identifier.namespace == namespace)
        .collect::<Vec<_>>();
    if matches.len() != 1 {
        return Err(ComparisonSeedLoadError::input(
            "INVALID_EXTERNAL_IDENTIFIER",
            format!("{subject}에 {namespace} 식별자가 정확히 하나 필요함"),
            Some(line),
        ));
    }
    validate_https_url(&matches[0].source_url, "externalIdentifier.sourceUrl", line)?;
    Ok(matches[0].value.clone())
}

fn canonical_credit_role(
    source_role: &str,
    line: usize,
) -> Result<&'static str, ComparisonSeedLoadError> {
    match source_role {
        "PIANIST" => Ok("soloist"),
        _ => Err(ComparisonSeedLoadError::input(
            "UNSUPPORTED_CREDIT_ROLE",
            format!("API canonical role로 매핑되지 않은 roleCode임: {source_role}"),
            Some(line),
        )),
    }
}

fn validate_uuid(
    value: &str,
    field: &str,
    line: Option<usize>,
) -> Result<(), ComparisonSeedLoadError> {
    let bytes = value.as_bytes();
    let valid = bytes.len() == 36
        && bytes.iter().enumerate().all(|(index, byte)| {
            if matches!(index, 8 | 13 | 18 | 23) {
                *byte == b'-'
            } else {
                byte.is_ascii_hexdigit()
            }
        });
    if !valid {
        return Err(ComparisonSeedLoadError::input(
            "INVALID_UUID",
            format!("{field}가 UUID 형식이 아님: {value}"),
            line,
        ));
    }
    Ok(())
}

fn validate_wikidata_id(value: &str, line: usize) -> Result<(), ComparisonSeedLoadError> {
    if value.len() < 2
        || !value.starts_with('Q')
        || !value[1..]
            .chars()
            .all(|character| character.is_ascii_digit())
    {
        return Err(ComparisonSeedLoadError::input(
            "INVALID_WIKIDATA_ID",
            format!("Wikidata ID 형식이 아님: {value}"),
            Some(line),
        ));
    }
    Ok(())
}

fn validate_https_url(raw: &str, field: &str, line: usize) -> Result<(), ComparisonSeedLoadError> {
    let parsed = Url::parse(raw).map_err(|error| {
        ComparisonSeedLoadError::input(
            "INVALID_URL",
            format!("{field} URL을 해석할 수 없음: {error}"),
            Some(line),
        )
    })?;
    if parsed.scheme() != "https"
        || parsed.host_str().is_none()
        || !parsed.username().is_empty()
        || parsed.password().is_some()
    {
        return Err(ComparisonSeedLoadError::input(
            "INVALID_URL",
            format!("{field}는 사용자 정보 없는 HTTPS URL이어야 함"),
            Some(line),
        ));
    }
    Ok(())
}

fn parse_timestamp(
    raw: &str,
    field: &str,
    line: usize,
) -> Result<NaiveDateTime, ComparisonSeedLoadError> {
    DateTime::parse_from_rfc3339(raw)
        .map(|value| value.with_timezone(&Utc).naive_utc())
        .map_err(|error| {
            ComparisonSeedLoadError::input(
                "INVALID_TIMESTAMP",
                format!("{field}가 RFC3339 형식이 아님: {error}"),
                Some(line),
            )
        })
}

fn is_youtube_video_id(value: &str) -> bool {
    value.len() == 11
        && value.chars().all(|character| {
            character.is_ascii_alphanumeric() || character == '_' || character == '-'
        })
}

#[cfg(test)]
mod tests {
    use super::{parse_bundle, ComparisonSeedLoadError};
    use std::{fs, path::PathBuf, time::SystemTime};

    fn pilot_path() -> PathBuf {
        PathBuf::from(env!("CARGO_MANIFEST_DIR"))
            .join("seed_pipeline/curation/pilot-2026-08-05/candidates.jsonl")
    }

    fn temporary_path(name: &str) -> PathBuf {
        std::env::temp_dir().join(format!(
            "classicmap-comparison-{name}-{}-{}",
            std::process::id(),
            SystemTime::now()
                .duration_since(SystemTime::UNIX_EPOCH)
                .expect("현재 시각")
                .as_nanos()
        ))
    }

    #[test]
    fn repository_pilot_is_strictly_valid() {
        let rows = parse_bundle(&pilot_path()).expect("파일럿 후보 검증");
        assert_eq!(rows.len(), 15);
        assert!(rows.windows(2).all(|pair| {
            pair[0].row.candidate_key.as_str() < pair[1].row.candidate_key.as_str()
        }));
    }

    #[test]
    fn unknown_fields_are_rejected() {
        let first = fs::read_to_string(pilot_path())
            .expect("파일럿 읽기")
            .lines()
            .next()
            .expect("첫 행")
            .replace(
                "\"schemaVersion\":\"1\"",
                "\"schemaVersion\":\"1\",\"unknown\":true",
            );
        let path = temporary_path("unknown.jsonl");
        fs::write(&path, format!("{first}\n")).expect("fixture 쓰기");
        let error = parse_bundle(&path).expect_err("unknown 필드 거부");
        assert!(matches!(error, ComparisonSeedLoadError::Input { .. }));
        fs::remove_file(path).expect("fixture 삭제");
    }

    #[test]
    fn ranges_over_600_seconds_are_rejected() {
        let first = fs::read_to_string(pilot_path())
            .expect("파일럿 읽기")
            .lines()
            .next()
            .expect("첫 행")
            .replace("\"durationSeconds\":40", "\"durationSeconds\":601")
            .replace("\"endSeconds\":40", "\"endSeconds\":601")
            .replace(":0:40\"", ":0:601\"");
        let path = temporary_path("duration.jsonl");
        fs::write(&path, format!("{first}\n")).expect("fixture 쓰기");
        let error = parse_bundle(&path).expect_err("600초 초과 거부");
        assert_eq!(error.code(), "INVALID_CLIP_RANGE");
        fs::remove_file(path).expect("fixture 삭제");
    }
}
