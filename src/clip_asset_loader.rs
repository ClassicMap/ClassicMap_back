use crate::{
    comparison::repository::{ComparisonContractError, ComparisonRepository},
    db::DbPool,
};
use chrono::{DateTime, NaiveDateTime, Utc};
use serde::{Deserialize, Serialize};
use sha2::{Digest, Sha256};
use sqlx::{FromRow, MySql, QueryBuilder, Transaction};
use std::{
    collections::{HashMap, HashSet},
    fmt, fs,
    fs::File,
    io::{BufReader, Read},
    net::{IpAddr, Ipv4Addr},
    path::{Component, Path, PathBuf},
};
use url::Url;

const MAX_CLIP_DURATION_MS: u32 = 600_000;
const DEFAULT_CACHE_DIR: &str = "/var/cache/classicmap-video-clips";

#[derive(Debug, Clone)]
pub struct ClipAssetLoadOptions {
    pub bundle_path: PathBuf,
    pub cache_dir: PathBuf,
    pub public_base_url: String,
    pub dry_run: bool,
    pub publish: bool,
    pub seed_run_id: Option<String>,
}

impl ClipAssetLoadOptions {
    pub fn with_defaults(bundle_path: PathBuf, public_base_url: String) -> Self {
        Self {
            bundle_path,
            cache_dir: PathBuf::from(DEFAULT_CACHE_DIR),
            public_base_url,
            dry_run: false,
            publish: false,
            seed_run_id: None,
        }
    }
}

#[derive(Debug, Clone, Deserialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct ClipAssetBundleRow {
    performance_id: i32,
    storage_key: String,
    public_url: String,
    sha256: String,
    file_size: u64,
    probed_duration_ms: u32,
    encoding_profile_version: String,
    asset_validated_at: String,
    range_verified_at: String,
}

#[derive(Debug, Clone)]
struct ValidatedBundleRow {
    line: usize,
    performance_id: i32,
    storage_key: String,
    storage_path: String,
    public_url: String,
    public_contract: PublicUrlContract,
    sha256: String,
    file_size: u64,
    probed_duration_ms: u32,
    encoding_profile_version: String,
    asset_validated_at: NaiveDateTime,
    range_verified_at: NaiveDateTime,
    ffprobe_result: String,
}

#[derive(Debug, Clone)]
struct PublicUrlContract {
    video_id: String,
    start_ms: u32,
    end_ms: u32,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
struct ClipAssetSidecar {
    metadata_version: u32,
    storage_key: String,
    encoding_profile_version: String,
    start_ms: u32,
    duration_ms: u32,
    file_size: u64,
    probed_duration_ms: u32,
    sha256: String,
    asset_validated_at: String,
    video_codec: String,
    audio_codec: Option<String>,
}

#[derive(Debug, Clone)]
struct AllowedPublicBase {
    url: Url,
    normalized_path: String,
}

#[derive(Debug, Clone, FromRow)]
struct PerformanceState {
    performance_id: i32,
    start_ms: u32,
    end_ms: u32,
    publish_status: String,
    provider_video_id: String,
}

#[derive(Debug, Clone, FromRow)]
struct ClipJobState {
    id: u64,
    status: String,
    encoding_profile_version: String,
    seed_run_id: Option<String>,
}

#[derive(Debug, Clone, FromRow)]
struct ClipAssetState {
    id: u64,
    clip_job_id: u64,
    status: String,
    storage_path: String,
    public_url: Option<String>,
    encoding_profile_version: String,
    file_size: Option<u64>,
    duration_ms: Option<u32>,
    sha256: Option<String>,
    range_verified: bool,
    seed_run_id: Option<String>,
    asset_validated_at: Option<NaiveDateTime>,
    range_verified_at: Option<NaiveDateTime>,
}

#[derive(Debug, Clone)]
struct PreparedRow {
    row: ValidatedBundleRow,
    performance: PerformanceState,
    job: Option<ClipJobState>,
    current_asset: Option<ClipAssetState>,
    asset_is_exact: bool,
    asset_seed_needs_update: bool,
}

#[derive(Debug, Clone, Default, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ClipAssetMutationCounts {
    pub clip_jobs_inserted: u64,
    pub clip_jobs_updated: u64,
    pub clip_assets_inserted: u64,
    pub clip_assets_retired: u64,
    pub clip_assets_updated: u64,
    pub performances_ready: u64,
    pub publish_transitions: u64,
    pub total: u64,
}

impl ClipAssetMutationCounts {
    fn finish(mut self) -> Self {
        self.total = self.clip_jobs_inserted
            + self.clip_jobs_updated
            + self.clip_assets_inserted
            + self.clip_assets_retired
            + self.clip_assets_updated
            + self.performances_ready
            + self.publish_transitions;
        self
    }
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ClipAssetLoadReport {
    pub status: &'static str,
    pub bundle_path: String,
    pub row_count: usize,
    pub dry_run: bool,
    pub publish: bool,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub seed_run_id: Option<String>,
    pub mutations: ClipAssetMutationCounts,
    pub planned_mutations: ClipAssetMutationCounts,
    pub performance_ids: Vec<i32>,
}

#[derive(Debug)]
pub enum ClipAssetLoadError {
    Input {
        code: &'static str,
        message: String,
        line: Option<usize>,
    },
    Database(sqlx::Error),
    Publish(ComparisonContractError),
}

impl ClipAssetLoadError {
    pub const fn code(&self) -> &'static str {
        match self {
            Self::Input { code, .. } => code,
            Self::Database(_) => "DATABASE_ERROR",
            Self::Publish(_) => "PUBLISH_ERROR",
        }
    }

    pub const fn line(&self) -> Option<usize> {
        match self {
            Self::Input { line, .. } => *line,
            Self::Database(_) | Self::Publish(_) => None,
        }
    }

    pub const fn exit_code(&self) -> i32 {
        match self {
            Self::Input { .. } => 2,
            Self::Database(_) | Self::Publish(_) => 3,
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

impl fmt::Display for ClipAssetLoadError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Input { message, .. } => formatter.write_str(message),
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
            Self::Publish(error) => write!(formatter, "발행 오류: {error}"),
        }
    }
}

impl std::error::Error for ClipAssetLoadError {}

impl From<sqlx::Error> for ClipAssetLoadError {
    fn from(error: sqlx::Error) -> Self {
        Self::Database(error)
    }
}

impl From<ComparisonContractError> for ClipAssetLoadError {
    fn from(error: ComparisonContractError) -> Self {
        Self::Publish(error)
    }
}

impl AllowedPublicBase {
    fn parse(raw: &str) -> Result<Self, ClipAssetLoadError> {
        let url = Url::parse(raw).map_err(|error| {
            ClipAssetLoadError::input(
                "INVALID_PUBLIC_BASE_URL",
                format!("공개 클립 기본 URL을 해석할 수 없음: {error}"),
                None,
            )
        })?;

        if url.scheme() != "https"
            || url.host_str().is_none()
            || !url.username().is_empty()
            || url.password().is_some()
            || url.query().is_some()
            || url.fragment().is_some()
            || is_local_host(url.host_str().unwrap_or_default())
        {
            return Err(ClipAssetLoadError::input(
                "INVALID_PUBLIC_BASE_URL",
                "공개 클립 기본 URL은 사용자 정보, 쿼리, fragment가 없는 외부 HTTPS URL이어야 함",
                None,
            ));
        }

        let normalized_path = normalize_base_path(url.path())?;
        Ok(Self {
            url,
            normalized_path,
        })
    }

    fn validate_row_url(
        &self,
        raw: &str,
        profile: &str,
        line: usize,
    ) -> Result<PublicUrlContract, ClipAssetLoadError> {
        if raw.len() > 1000 {
            return Err(ClipAssetLoadError::input(
                "INVALID_PUBLIC_URL",
                "publicUrl이 1000자를 초과함",
                Some(line),
            ));
        }

        let parsed = Url::parse(raw).map_err(|error| {
            ClipAssetLoadError::input(
                "INVALID_PUBLIC_URL",
                format!("publicUrl을 해석할 수 없음: {error}"),
                Some(line),
            )
        })?;
        if parsed.scheme() != "https"
            || parsed.origin() != self.url.origin()
            || !parsed.username().is_empty()
            || parsed.password().is_some()
            || parsed.fragment().is_some()
        {
            return Err(ClipAssetLoadError::input(
                "INVALID_PUBLIC_URL",
                "publicUrl은 허용된 기본 URL과 같은 외부 HTTPS origin이어야 함",
                Some(line),
            ));
        }

        let expected_prefix = if self.normalized_path == "/" {
            "/".to_string()
        } else {
            format!("{}/", self.normalized_path)
        };
        let video_id = parsed
            .path()
            .strip_prefix(&expected_prefix)
            .filter(|value| !value.contains('/'))
            .filter(|value| is_youtube_video_id(value))
            .ok_or_else(|| {
                ClipAssetLoadError::input(
                    "INVALID_PUBLIC_URL_PATH",
                    "publicUrl 경로는 허용된 base path 바로 아래의 YouTube videoId여야 함",
                    Some(line),
                )
            })?
            .to_string();

        let query = parsed.query_pairs().collect::<Vec<_>>();
        let expected_names = ["end", "profile", "start"];
        if query.len() != expected_names.len()
            || query
                .iter()
                .zip(expected_names)
                .any(|((name, _), expected)| name != expected)
        {
            return Err(ClipAssetLoadError::input(
                "INVALID_PUBLIC_URL_QUERY",
                "publicUrl 쿼리는 end, profile, start를 정확히 한 번씩 이 순서로 포함해야 함",
                Some(line),
            ));
        }
        if query[1].1 != profile {
            return Err(ClipAssetLoadError::input(
                "INVALID_PUBLIC_URL_QUERY",
                "publicUrl profile이 encodingProfileVersion과 다름",
                Some(line),
            ));
        }

        let end_ms = parse_seconds_as_ms(&query[0].1, "end", line)?;
        let start_ms = parse_seconds_as_ms(&query[2].1, "start", line)?;
        if end_ms <= start_ms || end_ms - start_ms > MAX_CLIP_DURATION_MS {
            return Err(ClipAssetLoadError::input(
                "INVALID_PUBLIC_URL_RANGE",
                "publicUrl 구간은 양수이며 600초 이하여야 함",
                Some(line),
            ));
        }

        Ok(PublicUrlContract {
            video_id,
            start_ms,
            end_ms,
        })
    }
}

pub struct ClipAssetLoader;

impl ClipAssetLoader {
    pub async fn load(
        pool: &DbPool,
        options: &ClipAssetLoadOptions,
    ) -> Result<ClipAssetLoadReport, ClipAssetLoadError> {
        let allowed_public_base = AllowedPublicBase::parse(&options.public_base_url)?;
        let cache_dir = validate_cache_dir(&options.cache_dir)?;
        let rows = parse_bundle(&options.bundle_path, &cache_dir, &allowed_public_base)?;
        validate_seed_run_id_format(options.seed_run_id.as_deref())?;

        let mut transaction = pool.begin().await?;
        if let Some(seed_run_id) = options.seed_run_id.as_deref() {
            ensure_seed_run_exists(&mut transaction, seed_run_id).await?;
        }

        let performance_states = lock_performances(&mut transaction, &rows).await?;
        let prepared = prepare_rows(
            &mut transaction,
            rows,
            performance_states,
            options.seed_run_id.as_deref(),
        )
        .await?;
        let planned_mutations =
            plan_mutations(&prepared, options.publish, options.seed_run_id.as_deref());
        let performance_ids = prepared
            .iter()
            .map(|prepared_row| prepared_row.row.performance_id)
            .collect::<Vec<_>>();

        if options.dry_run {
            transaction.rollback().await?;
            return Ok(ClipAssetLoadReport {
                status: "dry-run",
                bundle_path: options.bundle_path.display().to_string(),
                row_count: prepared.len(),
                dry_run: true,
                publish: options.publish,
                seed_run_id: options.seed_run_id.clone(),
                mutations: ClipAssetMutationCounts::default(),
                planned_mutations,
                performance_ids,
            });
        }

        let mutations = apply_rows(
            &mut transaction,
            &prepared,
            options.publish,
            options.seed_run_id.as_deref(),
        )
        .await?;
        transaction.commit().await?;

        Ok(ClipAssetLoadReport {
            status: "succeeded",
            bundle_path: options.bundle_path.display().to_string(),
            row_count: prepared.len(),
            dry_run: false,
            publish: options.publish,
            seed_run_id: options.seed_run_id.clone(),
            mutations,
            planned_mutations,
            performance_ids,
        })
    }
}

fn parse_bundle(
    bundle_path: &Path,
    cache_dir: &Path,
    allowed_public_base: &AllowedPublicBase,
) -> Result<Vec<ValidatedBundleRow>, ClipAssetLoadError> {
    let contents = fs::read_to_string(bundle_path).map_err(|error| {
        ClipAssetLoadError::input(
            "BUNDLE_READ_ERROR",
            format!("bundle을 읽을 수 없음: {error}"),
            None,
        )
    })?;
    let canonical_cache_dir = validate_cache_directory(cache_dir)?;
    let mut seen_performance_ids = HashSet::new();
    let mut rows = Vec::new();

    for (index, raw_line) in contents.lines().enumerate() {
        let line = index + 1;
        if raw_line.trim().is_empty() {
            return Err(ClipAssetLoadError::input(
                "INVALID_BUNDLE_ROW",
                "빈 JSONL 행은 허용하지 않음",
                Some(line),
            ));
        }

        let row = serde_json::from_str::<ClipAssetBundleRow>(raw_line).map_err(|error| {
            ClipAssetLoadError::input(
                "INVALID_BUNDLE_ROW",
                format!("JSONL 행을 strict parse할 수 없음: {error}"),
                Some(line),
            )
        })?;
        if row.performance_id <= 0 {
            return Err(ClipAssetLoadError::input(
                "INVALID_PERFORMANCE_ID",
                "performanceId는 1 이상의 정수여야 함",
                Some(line),
            ));
        }
        if !seen_performance_ids.insert(row.performance_id) {
            return Err(ClipAssetLoadError::input(
                "DUPLICATE_PERFORMANCE_ID",
                format!("performanceId {}가 중복됨", row.performance_id),
                Some(line),
            ));
        }
        validate_storage_key(&row.storage_key, line)?;
        validate_sha256(&row.sha256, line)?;
        if row.file_size == 0 {
            return Err(ClipAssetLoadError::input(
                "INVALID_FILE_SIZE",
                "fileSize는 1 이상이어야 함",
                Some(line),
            ));
        }
        if row.probed_duration_ms == 0 || row.probed_duration_ms > MAX_CLIP_DURATION_MS {
            return Err(ClipAssetLoadError::input(
                "INVALID_CLIP_DURATION",
                "probedDurationMs는 1~600000 범위여야 함",
                Some(line),
            ));
        }
        validate_encoding_profile(&row.encoding_profile_version, line)?;
        let asset_validated_at =
            parse_timestamp(&row.asset_validated_at, "assetValidatedAt", line)?;
        let range_verified_at = parse_timestamp(&row.range_verified_at, "rangeVerifiedAt", line)?;
        if range_verified_at < asset_validated_at {
            return Err(ClipAssetLoadError::input(
                "INVALID_VERIFICATION_TIME",
                "rangeVerifiedAt은 assetValidatedAt보다 빠를 수 없음",
                Some(line),
            ));
        }
        let public_contract = allowed_public_base.validate_row_url(
            &row.public_url,
            &row.encoding_profile_version,
            line,
        )?;
        let storage_path = canonical_cache_dir.join(&row.storage_key);
        let storage_path = storage_path.to_str().ok_or_else(|| {
            ClipAssetLoadError::input(
                "INVALID_CACHE_PATH",
                "cache 경로는 UTF-8이어야 함",
                Some(line),
            )
        })?;
        if storage_path.len() > 1000 {
            return Err(ClipAssetLoadError::input(
                "INVALID_CACHE_PATH",
                "cache 경로가 1000자를 초과함",
                Some(line),
            ));
        }

        let mut validated_row = ValidatedBundleRow {
            line,
            performance_id: row.performance_id,
            storage_key: row.storage_key,
            storage_path: storage_path.to_string(),
            public_url: row.public_url,
            public_contract,
            sha256: row.sha256,
            file_size: row.file_size,
            probed_duration_ms: row.probed_duration_ms,
            encoding_profile_version: row.encoding_profile_version,
            asset_validated_at,
            range_verified_at,
            ffprobe_result: String::new(),
        };
        let sidecar = validate_cached_asset(&validated_row, &canonical_cache_dir)?;
        validated_row.ffprobe_result = serde_json::to_string(&sidecar).map_err(|error| {
            ClipAssetLoadError::input(
                "INVALID_SIDECAR",
                format!("검증된 FFprobe sidecar를 직렬화할 수 없음: {error}"),
                Some(line),
            )
        })?;
        rows.push(validated_row);
    }

    if rows.is_empty() {
        return Err(ClipAssetLoadError::input(
            "EMPTY_BUNDLE",
            "bundle에 적재할 행이 없음",
            None,
        ));
    }

    Ok(rows)
}

async fn ensure_seed_run_exists(
    transaction: &mut Transaction<'_, MySql>,
    seed_run_id: &str,
) -> Result<(), ClipAssetLoadError> {
    let exists = sqlx::query_scalar::<_, String>(
        "SELECT CAST(id AS CHAR CHARACTER SET utf8mb4) FROM seed_runs WHERE id = ?",
    )
    .bind(seed_run_id)
    .fetch_optional(&mut **transaction)
    .await?;
    if exists.is_none() {
        return Err(ClipAssetLoadError::input(
            "UNKNOWN_SEED_RUN",
            format!("seed_runs에 없는 seed run id임: {seed_run_id}"),
            None,
        ));
    }
    Ok(())
}

async fn lock_performances(
    transaction: &mut Transaction<'_, MySql>,
    rows: &[ValidatedBundleRow],
) -> Result<HashMap<i32, PerformanceState>, ClipAssetLoadError> {
    let mut query = QueryBuilder::<MySql>::new(
        "SELECT performance.id AS performance_id,
                performance.start_ms,
                performance.end_ms,
                CAST(performance.publish_status AS CHAR CHARACTER SET utf8mb4) AS publish_status,
                CAST(source.provider_video_id AS CHAR CHARACTER SET utf8mb4) AS provider_video_id
         FROM performances performance
         JOIN performance_sources source ON source.id = performance.performance_source_id
         WHERE performance.id IN (",
    );
    let mut separated = query.separated(", ");
    for row in rows {
        separated.push_bind(row.performance_id);
    }
    separated.push_unseparated(") FOR UPDATE");

    let states = query
        .build_query_as::<PerformanceState>()
        .fetch_all(&mut **transaction)
        .await?;
    let states = states
        .into_iter()
        .map(|state| (state.performance_id, state))
        .collect::<HashMap<_, _>>();

    for row in rows {
        let performance = states.get(&row.performance_id).ok_or_else(|| {
            ClipAssetLoadError::input(
                "INVALID_PERFORMANCE",
                format!(
                    "performance {}가 없거나 source/start/end가 준비되지 않음",
                    row.performance_id
                ),
                Some(row.line),
            )
        })?;
        validate_performance_contract(row, performance)?;
    }

    Ok(states)
}

async fn prepare_rows(
    transaction: &mut Transaction<'_, MySql>,
    rows: Vec<ValidatedBundleRow>,
    mut performances: HashMap<i32, PerformanceState>,
    requested_seed_run_id: Option<&str>,
) -> Result<Vec<PreparedRow>, ClipAssetLoadError> {
    let mut prepared = Vec::with_capacity(rows.len());
    for row in rows {
        let performance = performances
            .remove(&row.performance_id)
            .expect("lock_performances가 전체 행을 검증함");
        let job = sqlx::query_as::<_, ClipJobState>(
            "SELECT id,
                    CAST(status AS CHAR CHARACTER SET utf8mb4) AS status,
                    CAST(encoding_profile_version AS CHAR CHARACTER SET utf8mb4) AS encoding_profile_version,
                    CAST(seed_run_id AS CHAR CHARACTER SET utf8mb4) AS seed_run_id
             FROM clip_jobs
             WHERE performance_id = ? AND output_key = ?
             FOR UPDATE",
        )
        .bind(row.performance_id)
        .bind(&row.storage_key)
        .fetch_optional(&mut **transaction)
        .await?;
        let current_asset = sqlx::query_as::<_, ClipAssetState>(
            "SELECT id,
                    clip_job_id,
                    CAST(status AS CHAR CHARACTER SET utf8mb4) AS status,
                    CAST(storage_path AS CHAR CHARACTER SET utf8mb4) AS storage_path,
                    public_url,
                    CAST(encoding_profile_version AS CHAR CHARACTER SET utf8mb4) AS encoding_profile_version,
                    file_size,
                    duration_ms,
                    CAST(sha256 AS CHAR CHARACTER SET utf8mb4) AS sha256,
                    range_verified,
                    CAST(seed_run_id AS CHAR CHARACTER SET utf8mb4) AS seed_run_id,
                    CAST(asset_validated_at AS DATETIME(6)) AS asset_validated_at,
                    CAST(range_verified_at AS DATETIME(6)) AS range_verified_at
             FROM clip_assets
             WHERE performance_id = ? AND is_current = TRUE
             FOR UPDATE",
        )
        .bind(row.performance_id)
        .fetch_optional(&mut **transaction)
        .await?;

        let asset_is_exact = current_asset.as_ref().is_some_and(|asset| {
            asset_matches(asset, &row)
                && job.as_ref().is_some_and(|job| asset.clip_job_id == job.id)
        });
        let asset_seed_needs_update = asset_is_exact
            && requested_seed_run_id.is_some_and(|seed_run_id| {
                current_asset
                    .as_ref()
                    .and_then(|asset| asset.seed_run_id.as_deref())
                    != Some(seed_run_id)
            });
        if !asset_is_exact {
            ensure_storage_identity_available(transaction, &row, current_asset.as_ref()).await?;
        }
        prepared.push(PreparedRow {
            row,
            performance,
            job,
            current_asset,
            asset_is_exact,
            asset_seed_needs_update,
        });
    }
    Ok(prepared)
}

async fn ensure_storage_identity_available(
    transaction: &mut Transaction<'_, MySql>,
    row: &ValidatedBundleRow,
    current_asset: Option<&ClipAssetState>,
) -> Result<(), ClipAssetLoadError> {
    if current_asset.is_some_and(|asset| asset.storage_path == row.storage_path) {
        return Err(ClipAssetLoadError::input(
            "CLIP_ASSET_IDENTITY_CONFLICT",
            "같은 storageKey의 현재 자산 메타데이터가 bundle과 다름",
            Some(row.line),
        ));
    }
    let historical_id = sqlx::query_scalar::<_, u64>(
        "SELECT id
         FROM clip_assets
         WHERE performance_id = ? AND storage_path = ?
         LIMIT 1
         FOR UPDATE",
    )
    .bind(row.performance_id)
    .bind(&row.storage_path)
    .fetch_optional(&mut **transaction)
    .await?;
    if historical_id.is_some() {
        return Err(ClipAssetLoadError::input(
            "CLIP_ASSET_IDENTITY_CONFLICT",
            "같은 storageKey가 이전 자산 이력에 이미 존재함",
            Some(row.line),
        ));
    }
    Ok(())
}

fn plan_mutations(
    prepared: &[PreparedRow],
    publish: bool,
    seed_run_id: Option<&str>,
) -> ClipAssetMutationCounts {
    let mut counts = ClipAssetMutationCounts::default();
    for item in prepared {
        match item.job.as_ref() {
            None => counts.clip_jobs_inserted += 1,
            Some(job) if !job_matches(job, &item.row, seed_run_id) => counts.clip_jobs_updated += 1,
            Some(_) => {}
        }
        if !item.asset_is_exact {
            counts.clip_assets_inserted += 1;
            counts.clip_assets_retired += u64::from(item.current_asset.is_some());
        }
        counts.clip_assets_updated += u64::from(item.asset_seed_needs_update);
        if publish {
            if item.performance.publish_status != "PUBLISHED" {
                counts.publish_transitions += 1;
            }
            let asset_status = if item.asset_is_exact {
                item.current_asset
                    .as_ref()
                    .map(|asset| asset.status.as_str())
            } else {
                Some("READY")
            };
            if asset_status != Some("PUBLISHED") {
                counts.publish_transitions += 1;
            }
        } else if (!item.asset_is_exact && item.performance.publish_status != "READY")
            || (item.asset_is_exact && item.performance.publish_status == "DRAFT")
        {
            counts.performances_ready += 1;
        }
    }
    counts.finish()
}

async fn apply_rows(
    transaction: &mut Transaction<'_, MySql>,
    prepared: &[PreparedRow],
    publish: bool,
    seed_run_id: Option<&str>,
) -> Result<ClipAssetMutationCounts, ClipAssetLoadError> {
    let mut counts = ClipAssetMutationCounts::default();
    for item in prepared {
        let job_id = match item.job.as_ref() {
            Some(job) => {
                if !job_matches(job, &item.row, seed_run_id) {
                    let result = sqlx::query(
                        "UPDATE clip_jobs
                         SET status = 'READY',
                             seed_run_id = COALESCE(?, seed_run_id),
                             encoding_profile_version = ?,
                             attempts = GREATEST(attempts, 1),
                             error_code = NULL,
                             error_message = NULL,
                             finished_at = COALESCE(finished_at, CURRENT_TIMESTAMP(6))
                         WHERE id = ?",
                    )
                    .bind(seed_run_id)
                    .bind(&item.row.encoding_profile_version)
                    .bind(job.id)
                    .execute(&mut **transaction)
                    .await?;
                    counts.clip_jobs_updated += result.rows_affected();
                }
                job.id
            }
            None => {
                let result = sqlx::query(
                    "INSERT INTO clip_jobs (
                        performance_id, seed_run_id, status, output_key,
                        encoding_profile_version, attempts, finished_at
                     ) VALUES (?, ?, 'READY', ?, ?, 1, CURRENT_TIMESTAMP(6))",
                )
                .bind(item.row.performance_id)
                .bind(seed_run_id)
                .bind(&item.row.storage_key)
                .bind(&item.row.encoding_profile_version)
                .execute(&mut **transaction)
                .await?;
                counts.clip_jobs_inserted += result.rows_affected();
                result.last_insert_id()
            }
        };

        if !item.asset_is_exact {
            if let Some(current_asset) = item.current_asset.as_ref() {
                let retired = sqlx::query(
                    "UPDATE clip_assets
                     SET status = 'RETIRED', is_current = FALSE,
                         retired_at = COALESCE(retired_at, CURRENT_TIMESTAMP(6))
                     WHERE id = ? AND is_current = TRUE",
                )
                .bind(current_asset.id)
                .execute(&mut **transaction)
                .await?;
                counts.clip_assets_retired += retired.rows_affected();
            }

            let inserted = sqlx::query(
                "INSERT INTO clip_assets (
                    performance_id, clip_job_id, seed_run_id, status,
                    storage_path, public_url, encoding_profile_version,
                    file_size, duration_ms, sha256, ffprobe_result,
                    range_verified, asset_validated_at, range_verified_at,
                    is_current, generated_at
                 ) VALUES (
                    ?, ?, ?, 'READY', ?, ?, ?, ?, ?, ?,
                    CAST(? AS JSON),
                    TRUE, ?, ?, TRUE, ?
                 )",
            )
            .bind(item.row.performance_id)
            .bind(job_id)
            .bind(seed_run_id)
            .bind(&item.row.storage_path)
            .bind(&item.row.public_url)
            .bind(&item.row.encoding_profile_version)
            .bind(item.row.file_size)
            .bind(item.row.probed_duration_ms)
            .bind(&item.row.sha256)
            .bind(&item.row.ffprobe_result)
            .bind(item.row.asset_validated_at)
            .bind(item.row.range_verified_at)
            .bind(item.row.asset_validated_at)
            .execute(&mut **transaction)
            .await?;
            counts.clip_assets_inserted += inserted.rows_affected();
        } else if item.asset_seed_needs_update {
            let updated = sqlx::query("UPDATE clip_assets SET seed_run_id = ? WHERE id = ?")
                .bind(seed_run_id)
                .bind(item.current_asset.as_ref().expect("exact asset").id)
                .execute(&mut **transaction)
                .await?;
            counts.clip_assets_updated += updated.rows_affected();
        }

        if !publish
            && ((!item.asset_is_exact && item.performance.publish_status != "READY")
                || (item.asset_is_exact && item.performance.publish_status == "DRAFT"))
        {
            let readied = sqlx::query(
                "UPDATE performances
                 SET publish_status = 'READY', seed_run_id = COALESCE(?, seed_run_id)
                 WHERE id = ? AND publish_status IN ('DRAFT', 'READY', 'PUBLISHED')
                   AND publish_status <> 'READY'",
            )
            .bind(seed_run_id)
            .bind(item.row.performance_id)
            .execute(&mut **transaction)
            .await?;
            counts.performances_ready += readied.rows_affected();
        }
    }

    if publish {
        for item in prepared {
            counts.publish_transitions +=
                ComparisonRepository::publish_ready_performance_in_transaction(
                    transaction,
                    item.row.performance_id,
                )
                .await?;
        }
    }

    Ok(counts.finish())
}

fn validate_performance_contract(
    row: &ValidatedBundleRow,
    performance: &PerformanceState,
) -> Result<(), ClipAssetLoadError> {
    if performance.publish_status == "RETIRED" {
        return Err(ClipAssetLoadError::input(
            "RETIRED_PERFORMANCE",
            "RETIRED performance에는 클립을 적재할 수 없음",
            Some(row.line),
        ));
    }
    if performance.end_ms <= performance.start_ms
        || performance.end_ms - performance.start_ms > MAX_CLIP_DURATION_MS
    {
        return Err(ClipAssetLoadError::input(
            "INVALID_PERFORMANCE_RANGE",
            "DB performance 구간은 양수이며 600초 이하여야 함",
            Some(row.line),
        ));
    }
    if performance.provider_video_id != row.public_contract.video_id {
        return Err(ClipAssetLoadError::input(
            "VIDEO_ID_MISMATCH",
            "publicUrl videoId가 performance source와 다름",
            Some(row.line),
        ));
    }
    if performance.start_ms.abs_diff(row.public_contract.start_ms) > 1
        || performance.end_ms.abs_diff(row.public_contract.end_ms) > 1
    {
        return Err(ClipAssetLoadError::input(
            "PERFORMANCE_RANGE_MISMATCH",
            "publicUrl start/end가 DB performance 구간과 다름",
            Some(row.line),
        ));
    }
    let expected_duration = performance.end_ms - performance.start_ms;
    let tolerance = 3_000_u32.max(expected_duration.saturating_mul(3) / 100);
    if expected_duration.abs_diff(row.probed_duration_ms) > tolerance {
        return Err(ClipAssetLoadError::input(
            "PROBED_DURATION_MISMATCH",
            format!(
                "probedDurationMs가 DB 구간 허용 오차를 벗어남 (expected={expected_duration}, tolerance={tolerance})"
            ),
            Some(row.line),
        ));
    }
    Ok(())
}

fn asset_matches(asset: &ClipAssetState, row: &ValidatedBundleRow) -> bool {
    matches!(asset.status.as_str(), "READY" | "PUBLISHED")
        && asset.storage_path == row.storage_path
        && asset.public_url.as_deref() == Some(row.public_url.as_str())
        && asset.encoding_profile_version == row.encoding_profile_version
        && asset.file_size == Some(row.file_size)
        && asset.duration_ms == Some(row.probed_duration_ms)
        && asset.sha256.as_deref() == Some(row.sha256.as_str())
        && asset.range_verified
        && asset.asset_validated_at == Some(row.asset_validated_at)
        && asset.range_verified_at == Some(row.range_verified_at)
}

fn job_matches(
    job: &ClipJobState,
    row: &ValidatedBundleRow,
    requested_seed_run_id: Option<&str>,
) -> bool {
    job.status == "READY"
        && job.encoding_profile_version == row.encoding_profile_version
        && requested_seed_run_id
            .is_none_or(|seed_run_id| job.seed_run_id.as_deref() == Some(seed_run_id))
}

fn validate_storage_key(storage_key: &str, line: usize) -> Result<(), ClipAssetLoadError> {
    if storage_key.len() > 255
        || !storage_key.ends_with(".mp4")
        || storage_key.contains("..")
        || storage_key.contains('/')
        || storage_key.contains('\\')
        || !storage_key
            .bytes()
            .all(|byte| byte.is_ascii_alphanumeric() || matches!(byte, b'_' | b'.' | b'-'))
    {
        return Err(ClipAssetLoadError::input(
            "INVALID_STORAGE_KEY",
            "storageKey는 경로가 아닌 안전한 flat MP4 파일명이어야 함",
            Some(line),
        ));
    }
    Ok(())
}

fn validate_sha256(sha256: &str, line: usize) -> Result<(), ClipAssetLoadError> {
    if sha256.len() != 64
        || !sha256
            .bytes()
            .all(|byte| byte.is_ascii_digit() || (b'a'..=b'f').contains(&byte))
    {
        return Err(ClipAssetLoadError::input(
            "INVALID_SHA256",
            "sha256은 64자의 소문자 16진수여야 함",
            Some(line),
        ));
    }
    Ok(())
}

fn validate_encoding_profile(profile: &str, line: usize) -> Result<(), ClipAssetLoadError> {
    let valid = profile.len() <= 32
        && profile
            .bytes()
            .next()
            .is_some_and(|byte| byte.is_ascii_lowercase() || byte.is_ascii_digit())
        && profile.bytes().all(|byte| {
            byte.is_ascii_lowercase() || byte.is_ascii_digit() || matches!(byte, b'_' | b'.' | b'-')
        });
    if !valid {
        return Err(ClipAssetLoadError::input(
            "INVALID_ENCODING_PROFILE",
            "encodingProfileVersion 형식이 올바르지 않음",
            Some(line),
        ));
    }
    Ok(())
}

fn parse_timestamp(
    value: &str,
    field: &str,
    line: usize,
) -> Result<NaiveDateTime, ClipAssetLoadError> {
    DateTime::parse_from_rfc3339(value)
        .map(|value| value.with_timezone(&Utc).naive_utc())
        .map_err(|error| {
            ClipAssetLoadError::input(
                "INVALID_TIMESTAMP",
                format!("{field}가 RFC3339 시각이 아님: {error}"),
                Some(line),
            )
        })
}

fn parse_seconds_as_ms(value: &str, field: &str, line: usize) -> Result<u32, ClipAssetLoadError> {
    let seconds = value.parse::<f64>().map_err(|_| {
        ClipAssetLoadError::input(
            "INVALID_PUBLIC_URL_RANGE",
            format!("publicUrl {field}가 숫자가 아님"),
            Some(line),
        )
    })?;
    let milliseconds = seconds * 1000.0;
    if !milliseconds.is_finite() || milliseconds < 0.0 || milliseconds > u32::MAX as f64 {
        return Err(ClipAssetLoadError::input(
            "INVALID_PUBLIC_URL_RANGE",
            format!("publicUrl {field} 범위가 올바르지 않음"),
            Some(line),
        ));
    }
    Ok(milliseconds.round() as u32)
}

fn validate_cache_dir(cache_dir: &Path) -> Result<PathBuf, ClipAssetLoadError> {
    if !cache_dir.is_absolute()
        || cache_dir
            .components()
            .any(|component| matches!(component, Component::ParentDir | Component::CurDir))
    {
        return Err(ClipAssetLoadError::input(
            "INVALID_CACHE_DIR",
            "cache dir은 . 또는 ..가 없는 절대 경로여야 함",
            None,
        ));
    }
    Ok(cache_dir.to_path_buf())
}

fn validate_cache_directory(cache_dir: &Path) -> Result<PathBuf, ClipAssetLoadError> {
    let metadata = fs::symlink_metadata(cache_dir).map_err(|error| {
        ClipAssetLoadError::input(
            "CACHE_DIR_READ_ERROR",
            format!("cache dir을 읽을 수 없음: {error}"),
            None,
        )
    })?;
    if metadata.file_type().is_symlink() || !metadata.is_dir() {
        return Err(ClipAssetLoadError::input(
            "INVALID_CACHE_DIR",
            "cache dir은 symlink가 아닌 실제 디렉터리여야 함",
            None,
        ));
    }
    cache_dir.canonicalize().map_err(|error| {
        ClipAssetLoadError::input(
            "CACHE_DIR_READ_ERROR",
            format!("cache dir canonical 경로를 확인할 수 없음: {error}"),
            None,
        )
    })
}

fn validate_cached_asset(
    row: &ValidatedBundleRow,
    canonical_cache_dir: &Path,
) -> Result<ClipAssetSidecar, ClipAssetLoadError> {
    let asset_path = Path::new(&row.storage_path);
    validate_direct_regular_file(asset_path, canonical_cache_dir, row.line, "클립 파일")?;
    let metadata = fs::metadata(asset_path).map_err(|error| {
        ClipAssetLoadError::input(
            "CLIP_FILE_READ_ERROR",
            format!("클립 파일 metadata를 읽을 수 없음: {error}"),
            Some(row.line),
        )
    })?;
    if metadata.len() != row.file_size {
        return Err(ClipAssetLoadError::input(
            "CLIP_FILE_SIZE_MISMATCH",
            format!(
                "클립 파일 크기가 bundle과 다름 (actual={}, expected={})",
                metadata.len(),
                row.file_size
            ),
            Some(row.line),
        ));
    }
    let actual_sha256 = sha256_file(asset_path, row.line)?;
    if actual_sha256 != row.sha256 {
        return Err(ClipAssetLoadError::input(
            "CLIP_FILE_SHA256_MISMATCH",
            "클립 파일 SHA-256이 bundle과 다름",
            Some(row.line),
        ));
    }

    let metadata_key = format!(
        "{}.metadata.json",
        row.storage_key
            .strip_suffix(".mp4")
            .expect("storageKey 검증이 .mp4 suffix를 보장함")
    );
    let sidecar_path = canonical_cache_dir.join(metadata_key);
    validate_direct_regular_file(
        &sidecar_path,
        canonical_cache_dir,
        row.line,
        "FFprobe sidecar",
    )?;
    let sidecar_size = fs::metadata(&sidecar_path)
        .map_err(|error| {
            ClipAssetLoadError::input(
                "SIDECAR_READ_ERROR",
                format!("FFprobe sidecar metadata를 읽을 수 없음: {error}"),
                Some(row.line),
            )
        })?
        .len();
    if sidecar_size == 0 || sidecar_size > 1_048_576 {
        return Err(ClipAssetLoadError::input(
            "INVALID_SIDECAR",
            "FFprobe sidecar는 1바이트~1MiB 범위여야 함",
            Some(row.line),
        ));
    }
    let sidecar_contents = fs::read_to_string(&sidecar_path).map_err(|error| {
        ClipAssetLoadError::input(
            "SIDECAR_READ_ERROR",
            format!("FFprobe sidecar를 읽을 수 없음: {error}"),
            Some(row.line),
        )
    })?;
    let sidecar = serde_json::from_str::<ClipAssetSidecar>(&sidecar_contents).map_err(|error| {
        ClipAssetLoadError::input(
            "INVALID_SIDECAR",
            format!("FFprobe sidecar JSON이 올바르지 않음: {error}"),
            Some(row.line),
        )
    })?;
    validate_sidecar(row, &sidecar)?;
    Ok(sidecar)
}

fn validate_direct_regular_file(
    path: &Path,
    canonical_cache_dir: &Path,
    line: usize,
    label: &str,
) -> Result<(), ClipAssetLoadError> {
    let metadata = fs::symlink_metadata(path).map_err(|error| {
        ClipAssetLoadError::input(
            "CLIP_FILE_READ_ERROR",
            format!("{label}을 읽을 수 없음: {error}"),
            Some(line),
        )
    })?;
    if metadata.file_type().is_symlink() || !metadata.is_file() {
        return Err(ClipAssetLoadError::input(
            "UNSAFE_CLIP_FILE",
            format!("{label}은 symlink가 아닌 regular file이어야 함"),
            Some(line),
        ));
    }
    let canonical_path = path.canonicalize().map_err(|error| {
        ClipAssetLoadError::input(
            "CLIP_FILE_READ_ERROR",
            format!("{label} canonical 경로를 확인할 수 없음: {error}"),
            Some(line),
        )
    })?;
    if canonical_path.parent() != Some(canonical_cache_dir) {
        return Err(ClipAssetLoadError::input(
            "UNSAFE_CLIP_FILE",
            format!("{label}은 canonical cache dir 바로 아래에 있어야 함"),
            Some(line),
        ));
    }
    Ok(())
}

fn sha256_file(path: &Path, line: usize) -> Result<String, ClipAssetLoadError> {
    let file = File::open(path).map_err(|error| {
        ClipAssetLoadError::input(
            "CLIP_FILE_READ_ERROR",
            format!("클립 파일을 열 수 없음: {error}"),
            Some(line),
        )
    })?;
    let mut reader = BufReader::new(file);
    let mut hasher = Sha256::new();
    let mut buffer = [0_u8; 64 * 1024];
    loop {
        let read = reader.read(&mut buffer).map_err(|error| {
            ClipAssetLoadError::input(
                "CLIP_FILE_READ_ERROR",
                format!("클립 파일을 해시 중 읽을 수 없음: {error}"),
                Some(line),
            )
        })?;
        if read == 0 {
            break;
        }
        hasher.update(&buffer[..read]);
    }
    Ok(format!("{:x}", hasher.finalize()))
}

fn validate_sidecar(
    row: &ValidatedBundleRow,
    sidecar: &ClipAssetSidecar,
) -> Result<(), ClipAssetLoadError> {
    let sidecar_validated_at = parse_timestamp(
        &sidecar.asset_validated_at,
        "sidecar.assetValidatedAt",
        row.line,
    )?;
    let expected_duration = row.public_contract.end_ms - row.public_contract.start_ms;
    let codec_is_valid = !sidecar.video_codec.trim().is_empty()
        && sidecar
            .audio_codec
            .as_ref()
            .is_none_or(|codec| !codec.trim().is_empty());
    if sidecar.metadata_version != 1
        || sidecar.storage_key != row.storage_key
        || sidecar.encoding_profile_version != row.encoding_profile_version
        || sidecar.start_ms != row.public_contract.start_ms
        || sidecar.duration_ms != expected_duration
        || sidecar.file_size != row.file_size
        || sidecar.probed_duration_ms != row.probed_duration_ms
        || sidecar.sha256 != row.sha256
        || sidecar_validated_at != row.asset_validated_at
        || !codec_is_valid
    {
        return Err(ClipAssetLoadError::input(
            "SIDECAR_BUNDLE_MISMATCH",
            "FFprobe sidecar의 storage/profile/range/size/hash/codec가 bundle과 다름",
            Some(row.line),
        ));
    }
    Ok(())
}

fn validate_seed_run_id_format(seed_run_id: Option<&str>) -> Result<(), ClipAssetLoadError> {
    if let Some(seed_run_id) = seed_run_id {
        let bytes = seed_run_id.as_bytes();
        let valid = bytes.len() == 36
            && bytes.iter().enumerate().all(|(index, byte)| {
                if matches!(index, 8 | 13 | 18 | 23) {
                    *byte == b'-'
                } else {
                    byte.is_ascii_hexdigit()
                }
            });
        if !valid {
            return Err(ClipAssetLoadError::input(
                "INVALID_SEED_RUN_ID",
                "seed run id는 UUID 형식이어야 함",
                None,
            ));
        }
    }
    Ok(())
}

fn normalize_base_path(path: &str) -> Result<String, ClipAssetLoadError> {
    if path.contains('\\') || path.to_ascii_lowercase().contains("%2f") {
        return Err(ClipAssetLoadError::input(
            "INVALID_PUBLIC_BASE_URL",
            "공개 클립 base path에 인코딩된 구분자나 역슬래시를 사용할 수 없음",
            None,
        ));
    }
    let normalized = path.trim_end_matches('/');
    Ok(if normalized.is_empty() {
        "/".to_string()
    } else {
        normalized.to_string()
    })
}

fn is_local_host(host: &str) -> bool {
    let host = host
        .strip_prefix('[')
        .and_then(|value| value.strip_suffix(']'))
        .unwrap_or(host);
    if host.eq_ignore_ascii_case("localhost") || host.to_ascii_lowercase().ends_with(".localhost") {
        return true;
    }

    host.parse::<IpAddr>().is_ok_and(|address| match address {
        IpAddr::V4(address) => is_local_ipv4(address),
        IpAddr::V6(address) => {
            address.is_loopback()
                || address.is_unspecified()
                || address.is_unique_local()
                || address.is_unicast_link_local()
                || address.to_ipv4_mapped().is_some_and(is_local_ipv4)
        }
    })
}

fn is_local_ipv4(address: Ipv4Addr) -> bool {
    address.is_loopback()
        || address.is_unspecified()
        || address.is_private()
        || address.is_link_local()
}

fn is_youtube_video_id(value: &str) -> bool {
    value.len() == 11
        && value
            .bytes()
            .all(|byte| byte.is_ascii_alphanumeric() || matches!(byte, b'_' | b'-'))
}

#[cfg(test)]
mod tests {
    use super::{parse_bundle, sha256_file, AllowedPublicBase, ClipAssetLoadError};
    use std::{
        fs,
        path::PathBuf,
        sync::atomic::{AtomicU64, Ordering},
        time::SystemTime,
    };

    const STORAGE_KEY: &str = "abcdefghijk-10000-10000-v1-copy.mp4";
    static FIXTURE_SEQUENCE: AtomicU64 = AtomicU64::new(0);

    fn write_bundle(contents: &str) -> std::path::PathBuf {
        let path = std::env::temp_dir().join(format!(
            "classicmap-clip-bundle-{}-{}-{}.jsonl",
            std::process::id(),
            SystemTime::now()
                .duration_since(SystemTime::UNIX_EPOCH)
                .expect("현재 시각")
                .as_nanos(),
            FIXTURE_SEQUENCE.fetch_add(1, Ordering::Relaxed)
        ));
        fs::write(&path, contents).expect("bundle fixture 작성");
        path
    }

    fn create_cache() -> PathBuf {
        let path = std::env::temp_dir().join(format!(
            "classicmap-clip-cache-{}-{}-{}",
            std::process::id(),
            SystemTime::now()
                .duration_since(SystemTime::UNIX_EPOCH)
                .expect("현재 시각")
                .as_nanos(),
            FIXTURE_SEQUENCE.fetch_add(1, Ordering::Relaxed)
        ));
        fs::create_dir(&path).expect("cache fixture 생성");
        path
    }

    fn write_verified_asset(cache: &std::path::Path) -> String {
        let contents = b"verified clip fixture bytes";
        let asset_path = cache.join(STORAGE_KEY);
        fs::write(&asset_path, contents).expect("클립 fixture 작성");
        let sha256 = sha256_file(&asset_path, 1).expect("fixture SHA-256");
        let sidecar_path = cache.join("abcdefghijk-10000-10000-v1-copy.metadata.json");
        fs::write(
            sidecar_path,
            format!(
                "{{\"metadataVersion\":1,\"storageKey\":\"{STORAGE_KEY}\",\"encodingProfileVersion\":\"v1-copy\",\"startMs\":10000,\"durationMs\":10000,\"fileSize\":{},\"probedDurationMs\":10000,\"sha256\":\"{sha256}\",\"assetValidatedAt\":\"2026-08-05T00:00:00.000Z\",\"videoCodec\":\"h264\",\"audioCodec\":null}}",
                contents.len()
            ),
        )
        .expect("sidecar fixture 작성");
        sha256
    }

    fn valid_row(performance_id: i32, sha256: &str) -> String {
        format!(
            "{{\"performanceId\":{performance_id},\"storageKey\":\"{STORAGE_KEY}\",\"publicUrl\":\"https://media.example.test/classicmap/clips/abcdefghijk?end=20&profile=v1-copy&start=10\",\"sha256\":\"{sha256}\",\"fileSize\":27,\"probedDurationMs\":10000,\"encodingProfileVersion\":\"v1-copy\",\"assetValidatedAt\":\"2026-08-05T00:00:00.000Z\",\"rangeVerifiedAt\":\"2026-08-05T00:00:01.000Z\"}}"
        )
    }

    #[test]
    fn strict_bundle_contract_is_accepted() {
        let cache = create_cache();
        let sha256 = write_verified_asset(&cache);
        let path = write_bundle(&format!("{}\n", valid_row(11, &sha256)));
        let base = AllowedPublicBase::parse("https://media.example.test/classicmap/clips")
            .expect("public base");
        let rows = parse_bundle(&path, &cache, &base).expect("bundle");
        fs::remove_file(path).expect("fixture 삭제");

        assert_eq!(rows.len(), 1);
        assert_eq!(rows[0].performance_id, 11);
        assert_eq!(
            rows[0].storage_path,
            cache
                .canonicalize()
                .expect("cache canonical 경로")
                .join(STORAGE_KEY)
                .display()
                .to_string()
        );
        fs::remove_dir_all(cache).expect("cache fixture 삭제");
    }

    #[test]
    fn duplicate_performance_and_unknown_field_are_rejected() {
        let cache = create_cache();
        let sha256 = write_verified_asset(&cache);
        let duplicate_path = write_bundle(&format!(
            "{}\n{}\n",
            valid_row(11, &sha256),
            valid_row(11, &sha256)
        ));
        let base = AllowedPublicBase::parse("https://media.example.test/classicmap/clips")
            .expect("public base");
        let duplicate =
            parse_bundle(&duplicate_path, &cache, &base).expect_err("performanceId 중복 거부");
        fs::remove_file(duplicate_path).expect("fixture 삭제");
        assert_eq!(duplicate.code(), "DUPLICATE_PERFORMANCE_ID");

        let unknown_path = write_bundle(&valid_row(12, &sha256).replace(
            "\"rangeVerifiedAt\"",
            "\"storagePath\":\"/tmp/injected.mp4\",\"rangeVerifiedAt\"",
        ));
        let unknown = parse_bundle(&unknown_path, &cache, &base).expect_err("임의 경로 필드 거부");
        fs::remove_file(unknown_path).expect("fixture 삭제");
        assert_eq!(unknown.code(), "INVALID_BUNDLE_ROW");
        fs::remove_dir_all(cache).expect("cache fixture 삭제");
    }

    #[test]
    fn unsafe_url_and_storage_key_are_rejected() {
        assert!(matches!(
            AllowedPublicBase::parse("http://127.0.0.1:3200/classicmap/clips"),
            Err(ClipAssetLoadError::Input {
                code: "INVALID_PUBLIC_BASE_URL",
                ..
            })
        ));
        for private_base in [
            "https://10.0.0.1/classicmap/clips",
            "https://172.16.0.1/classicmap/clips",
            "https://192.168.1.1/classicmap/clips",
            "https://169.254.1.1/classicmap/clips",
            "https://[fc00::1]/classicmap/clips",
            "https://[fe80::1]/classicmap/clips",
            "https://[::ffff:192.168.1.1]/classicmap/clips",
        ] {
            assert!(
                matches!(
                    AllowedPublicBase::parse(private_base),
                    Err(ClipAssetLoadError::Input {
                        code: "INVALID_PUBLIC_BASE_URL",
                        ..
                    })
                ),
                "private 또는 link-local literal이 허용됨: {private_base}"
            );
        }

        let cache = create_cache();
        let path = write_bundle(
            &valid_row(13, &"a".repeat(64))
                .replace("abcdefghijk-10000-10000-v1-copy.mp4", "../injected.mp4"),
        );
        let base = AllowedPublicBase::parse("https://media.example.test/classicmap/clips")
            .expect("public base");
        let error = parse_bundle(&path, &cache, &base).expect_err("경로 주입 거부");
        fs::remove_file(path).expect("fixture 삭제");
        assert_eq!(error.code(), "INVALID_STORAGE_KEY");
        fs::remove_dir_all(cache).expect("cache fixture 삭제");
    }

    #[cfg(unix)]
    #[test]
    fn symlinked_clip_file_is_rejected() {
        use std::os::unix::fs::symlink;

        let cache = create_cache();
        let external_path = write_bundle("external clip bytes");
        symlink(&external_path, cache.join(STORAGE_KEY)).expect("symlink fixture 생성");
        let bundle = write_bundle(&valid_row(14, &"a".repeat(64)));
        let base = AllowedPublicBase::parse("https://media.example.test/classicmap/clips")
            .expect("public base");
        let error = parse_bundle(&bundle, &cache, &base).expect_err("symlink 거부");

        assert_eq!(error.code(), "UNSAFE_CLIP_FILE");
        fs::remove_file(bundle).expect("bundle fixture 삭제");
        fs::remove_file(external_path).expect("외부 fixture 삭제");
        fs::remove_dir_all(cache).expect("cache fixture 삭제");
    }

    #[test]
    fn clip_file_sha256_mismatch_is_rejected() {
        let cache = create_cache();
        let original_sha256 = write_verified_asset(&cache);
        fs::write(cache.join(STORAGE_KEY), vec![b'x'; 27]).expect("클립 변조 fixture 작성");
        let bundle = write_bundle(&valid_row(15, &original_sha256));
        let base = AllowedPublicBase::parse("https://media.example.test/classicmap/clips")
            .expect("public base");
        let error = parse_bundle(&bundle, &cache, &base).expect_err("SHA-256 불일치 거부");

        assert_eq!(error.code(), "CLIP_FILE_SHA256_MISMATCH");
        fs::remove_file(bundle).expect("bundle fixture 삭제");
        fs::remove_dir_all(cache).expect("cache fixture 삭제");
    }
}
