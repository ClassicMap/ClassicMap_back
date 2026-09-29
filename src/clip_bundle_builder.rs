//! 시드 실행 하나의 클립을 클리퍼에 만들게 하고 `load_clip_assets` 번들을 낸다.
//!
//! 프런트 저장소의 `ops/video-clips/prewarm.mjs` 가 하던 일을 클러스터 안에서
//! 한다. 노트북에서 포트포워딩으로 클리퍼를 부르고 `kubectl cp` 로 클립을
//! 끌어오던 단계가 사라진다.
//!
//! 클리퍼는 클립을 만들면서 `<storageKey>.metadata.json` 사이드카에 sha256 ·
//! fileSize · probedDurationMs 를 이미 적어 둔다. 여기서 다시 재지 않고 그대로
//! 옮긴다 — `load_clip_assets` 가 캐시의 실제 파일과 대조해 검증한다.
//!
//! **`rangeVerifiedAt` 은 실제로 Range 요청을 해 본 뒤에만 적는다.** 타임스탬프만
//! 채우면 검증하지 않은 것을 검증했다고 적는 셈이다.

use chrono::Utc;
use serde::{Deserialize, Serialize};
use sqlx::{MySql, Pool};
use std::{fmt, path::Path, time::Duration};

/// 클리퍼가 클립 옆에 남기는 사이드카. 쓰는 쪽은 클리퍼이므로 읽기만 한다.
#[derive(Debug, Deserialize)]
#[serde(rename_all = "camelCase")]
struct ClipSidecar {
    file_size: u64,
    probed_duration_ms: u32,
    sha256: String,
    asset_validated_at: String,
    encoding_profile_version: String,
}

/// `load_clip_assets --bundle` 이 읽는 한 줄.
#[derive(Debug, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct ClipBundleRow {
    pub performance_id: i64,
    pub storage_key: String,
    pub encoding_profile_version: String,
    pub file_size: u64,
    pub probed_duration_ms: u32,
    pub sha256: String,
    pub public_url: String,
    pub asset_validated_at: String,
    pub range_verified_at: String,
}

#[derive(Debug, sqlx::FromRow)]
struct ClipJobRow {
    performance_id: i64,
    provider_video_id: String,
    start_ms: i64,
    end_ms: i64,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ClipBundleReport {
    pub run_id: String,
    pub built: usize,
    pub reused: usize,
    pub failed: Vec<ClipFailure>,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ClipFailure {
    pub performance_id: i64,
    pub storage_key: String,
    pub reason: String,
}

#[derive(Debug)]
pub enum ClipBundleError {
    EmptyRun(String),
    Database(sqlx::Error),
    Http(String),
    Sidecar(String),
}

impl ClipBundleError {
    pub fn code(&self) -> &'static str {
        match self {
            Self::EmptyRun(_) => "EMPTY_SEED_RUN",
            Self::Database(_) => "DATABASE_ERROR",
            Self::Http(_) => "CLIPPER_REQUEST_FAILED",
            Self::Sidecar(_) => "SIDECAR_UNREADABLE",
        }
    }
}

impl fmt::Display for ClipBundleError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::EmptyRun(run_id) => write!(formatter, "시드 실행에 clip_jobs 가 없음: {run_id}"),
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
            Self::Http(message) => write!(formatter, "클리퍼 요청 실패: {message}"),
            Self::Sidecar(message) => write!(formatter, "사이드카를 읽을 수 없음: {message}"),
        }
    }
}

impl std::error::Error for ClipBundleError {}

impl From<sqlx::Error> for ClipBundleError {
    fn from(error: sqlx::Error) -> Self {
        Self::Database(error)
    }
}

#[derive(Debug, Clone)]
pub struct ClipBundleOptions {
    pub run_id: String,
    pub clipper_base_url: String,
    pub public_base_url: String,
    pub cache_dir: std::path::PathBuf,
    pub encoding_profile_version: String,
    pub build_token: String,
    /// 원본을 처음 받는 영상은 오래 걸린다. 45분 영상이 수십 초다.
    pub request_timeout: Duration,
}

/// `{videoId}-{startMs}-{endMs}-{profile}.mp4`. 사이드카의 이름이 아니라 값으로
/// 만든다 — 사이드카는 끝 시각을 `durationMs` 라고 잘못 적어 두었다.
pub fn storage_key(video_id: &str, start_ms: i64, end_ms: i64, profile: &str) -> String {
    format!("{video_id}-{start_ms}-{end_ms}-{profile}.mp4")
}

/// 질의 문자열은 알파벳 차례다. `load_clip_assets` 가 등록된 공개 주소와 대조한다.
pub fn public_url(base: &str, video_id: &str, start_ms: i64, end_ms: i64, profile: &str) -> String {
    let base = base.trim_end_matches('/');
    let start = start_ms / 1000;
    let end = end_ms / 1000;
    format!("{base}/{video_id}?end={end}&profile={profile}&start={start}")
}

fn clip_url(base: &str, video_id: &str, start_ms: i64, end_ms: i64, profile: &str) -> String {
    public_url(base, video_id, start_ms, end_ms, profile)
}

async fn fetch_jobs(pool: &Pool<MySql>, run_id: &str) -> Result<Vec<ClipJobRow>, ClipBundleError> {
    let rows = sqlx::query_as::<_, ClipJobRow>(
        "SELECT performance.id AS performance_id,
                source.provider_video_id AS provider_video_id,
                performance.start_ms AS start_ms,
                performance.end_ms AS end_ms
         FROM clip_jobs job
         JOIN performances performance ON performance.id = job.performance_id
         JOIN performance_sources source ON source.id = performance.performance_source_id
         WHERE job.seed_run_id = ?
         ORDER BY performance.id",
    )
    .bind(run_id)
    .fetch_all(pool)
    .await?;

    if rows.is_empty() {
        return Err(ClipBundleError::EmptyRun(run_id.to_string()));
    }
    Ok(rows)
}

fn read_sidecar(cache_dir: &Path, key: &str) -> Result<ClipSidecar, String> {
    let path = cache_dir.join(key.replace(".mp4", ".metadata.json"));
    let text =
        std::fs::read_to_string(&path).map_err(|error| format!("{} ({error})", path.display()))?;
    serde_json::from_str(&text).map_err(|error| format!("{} ({error})", path.display()))
}

/// 클립을 만들게 하고 Range 요청이 되는지 확인한다.
async fn build_and_verify(
    client: &reqwest::Client,
    url: &str,
    token: &str,
) -> Result<bool, String> {
    let built = client
        .get(url)
        .bearer_auth(token)
        .header(reqwest::header::RANGE, "bytes=0-1")
        .send()
        .await
        .map_err(|error| error.to_string())?;

    let status = built.status();
    if !status.is_success() {
        return Err(format!("{status} — {url}"));
    }
    // 206 과 Content-Range 가 함께 와야 Range 를 지원하는 것이다.
    let range_ok = status == reqwest::StatusCode::PARTIAL_CONTENT
        && built.headers().contains_key(reqwest::header::CONTENT_RANGE);
    Ok(range_ok)
}

pub async fn build_clip_bundle(
    pool: &Pool<MySql>,
    options: &ClipBundleOptions,
) -> Result<(Vec<ClipBundleRow>, ClipBundleReport), ClipBundleError> {
    let jobs = fetch_jobs(pool, &options.run_id).await?;
    let client = reqwest::Client::builder()
        .timeout(options.request_timeout)
        .build()
        .map_err(|error| ClipBundleError::Http(error.to_string()))?;

    let mut rows = Vec::with_capacity(jobs.len());
    let mut report = ClipBundleReport {
        run_id: options.run_id.clone(),
        built: 0,
        reused: 0,
        failed: Vec::new(),
    };

    for job in jobs {
        let profile = options.encoding_profile_version.as_str();
        let key = storage_key(&job.provider_video_id, job.start_ms, job.end_ms, profile);
        let existed = options.cache_dir.join(&key).exists();

        let url = clip_url(
            &options.clipper_base_url,
            &job.provider_video_id,
            job.start_ms,
            job.end_ms,
            profile,
        );
        let range_ok = match build_and_verify(&client, &url, &options.build_token).await {
            Ok(range_ok) => range_ok,
            Err(reason) => {
                report.failed.push(ClipFailure {
                    performance_id: job.performance_id,
                    storage_key: key,
                    reason,
                });
                continue;
            }
        };
        if !range_ok {
            report.failed.push(ClipFailure {
                performance_id: job.performance_id,
                storage_key: key,
                reason: "Range 요청에 206 과 Content-Range 가 오지 않음".to_string(),
            });
            continue;
        }

        let sidecar = match read_sidecar(&options.cache_dir, &key) {
            Ok(sidecar) => sidecar,
            Err(reason) => {
                report.failed.push(ClipFailure {
                    performance_id: job.performance_id,
                    storage_key: key,
                    reason,
                });
                continue;
            }
        };

        if existed {
            report.reused += 1;
        } else {
            report.built += 1;
        }

        // 시계 어긋남으로 rangeVerifiedAt 이 assetValidatedAt 보다 빠르면 적재기가
        // 막는다. 방금 확인했으므로 둘 중 늦은 쪽으로 맞춘다.
        let verified_at = Utc::now().format("%Y-%m-%dT%H:%M:%S%.3fZ").to_string();
        let range_verified_at = if verified_at < sidecar.asset_validated_at {
            sidecar.asset_validated_at.clone()
        } else {
            verified_at
        };

        rows.push(ClipBundleRow {
            performance_id: job.performance_id,
            public_url: public_url(
                &options.public_base_url,
                &job.provider_video_id,
                job.start_ms,
                job.end_ms,
                profile,
            ),
            storage_key: key,
            encoding_profile_version: sidecar.encoding_profile_version,
            file_size: sidecar.file_size,
            probed_duration_ms: sidecar.probed_duration_ms,
            sha256: sidecar.sha256,
            asset_validated_at: sidecar.asset_validated_at,
            range_verified_at,
        });
    }

    Ok((rows, report))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn storage_key_uses_end_not_duration() {
        assert_eq!(
            storage_key("-Bxpm0EmOMU", 12000, 272000, "v1-copy"),
            "-Bxpm0EmOMU-12000-272000-v1-copy.mp4"
        );
    }

    #[test]
    fn public_url_sorts_query_and_uses_seconds() {
        assert_eq!(
            public_url(
                "https://kang1027.com/classicmap/clips/",
                "5_iz_nFNbKE",
                1000,
                122000,
                "v1-copy"
            ),
            "https://kang1027.com/classicmap/clips/5_iz_nFNbKE?end=122&profile=v1-copy&start=1"
        );
    }

    #[test]
    fn error_codes_are_stable() {
        assert_eq!(
            ClipBundleError::EmptyRun("x".into()).code(),
            "EMPTY_SEED_RUN"
        );
        assert_eq!(
            ClipBundleError::Http("x".into()).code(),
            "CLIPPER_REQUEST_FAILED"
        );
    }
}
