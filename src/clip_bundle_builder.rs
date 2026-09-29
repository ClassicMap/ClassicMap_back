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
    pub performance_id: i32,
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
    performance_id: i32,
    provider_video_id: String,
    start_ms: u32,
    end_ms: u32,
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
    pub performance_id: i32,
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

/// `{videoId}-{startMs}-{durationMs}-{profile}.mp4`.
///
/// **둘째 숫자는 끝 시각이 아니라 길이다.** 사이드카의 `durationMs` 가 그 값이고
/// 이름 그대로다. 처음에 끝 시각으로 잘못 알고 짓다가 **시작이 0 인 구간만 맞고
/// 나머지는 전부 어긋났다** — 0 에서는 끝 시각과 길이가 같아 틀린 것이 드러나지
/// 않는다. 운영 캐시의 실제 이름으로 확인했다.
pub fn storage_key(video_id: &str, start_ms: u32, end_ms: u32, profile: &str) -> String {
    let duration_ms = end_ms.saturating_sub(start_ms);
    format!("{video_id}-{start_ms}-{duration_ms}-{profile}.mp4")
}

/// 질의 문자열은 알파벳 차례다. `load_clip_assets` 가 등록된 공개 주소와 대조한다.
pub fn public_url(base: &str, video_id: &str, start_ms: u32, end_ms: u32, profile: &str) -> String {
    let base = base.trim_end_matches('/');
    let start = start_ms / 1000;
    let end = end_ms / 1000;
    format!("{base}/{video_id}?end={end}&profile={profile}&start={start}")
}

fn clip_url(base: &str, video_id: &str, start_ms: u32, end_ms: u32, profile: &str) -> String {
    public_url(base, video_id, start_ms, end_ms, profile)
}

async fn fetch_jobs(pool: &Pool<MySql>, run_id: &str) -> Result<Vec<ClipJobRow>, ClipBundleError> {
    let rows = sqlx::query_as::<_, ClipJobRow>(
        // provider_video_id 는 utf8mb4_bin 이라 그대로 읽으면 VARBINARY 로 와서
        // String 으로 디코딩되지 않는다. clip_asset_loader 와 같은 방식으로 캐스팅한다.
        "SELECT performance.id AS performance_id,
                CAST(source.provider_video_id AS CHAR CHARACTER SET utf8mb4) AS provider_video_id,
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

/// 클립을 만들게 하고, 그다음 Range 요청이 되는지 확인한다.
///
/// **요청을 둘로 나눈다.** 통째로 받는 요청은 캐시에 없는 클립을 만들게 하려는
/// 것이고(`prewarm.mjs` 도 그렇게 했다), Range 요청은 `rangeVerifiedAt` 을 적을
/// 근거를 만들려는 것이다. Range 요청만으로도 클리퍼가 만드는지는 확인하지 않았다 —
/// 만들지 않을 수도 있으니 안전한 쪽을 쓴다.
async fn build_and_verify(
    client: &reqwest::Client,
    url: &str,
    token: &str,
) -> Result<bool, String> {
    let mut built = client
        .get(url)
        .bearer_auth(token)
        .send()
        .await
        .map_err(|error| error.to_string())?;

    let status = built.status();
    if !status.is_success() {
        return Err(format!("만들기 {status} — {url}"));
    }
    // 본문을 끝까지 비워야 클리퍼가 파일 쓰기를 마친다. 메모리에 쌓지 않고 흘려버린다
    // — 45분 영상의 구간도 수십 MB 라 파드 한도(256Mi)에 담아 둘 이유가 없다.
    while let Some(_chunk) = built
        .chunk()
        .await
        .map_err(|error| format!("본문을 받는 중 끊김: {error}"))?
    {}

    let verified = client
        .get(url)
        .bearer_auth(token)
        .header(reqwest::header::RANGE, "bytes=0-1")
        .send()
        .await
        .map_err(|error| format!("Range 확인 실패: {error}"))?;

    // 206 과 Content-Range 가 함께 와야 Range 를 지원하는 것이다.
    Ok(verified.status() == reqwest::StatusCode::PARTIAL_CONTENT
        && verified
            .headers()
            .contains_key(reqwest::header::CONTENT_RANGE))
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

    /// 운영 캐시의 실제 이름으로 맞춘 것이다. 시작이 0 이 아닌 것을 꼭 넣는다 —
    /// 0 에서는 끝 시각과 길이가 같아 틀린 것이 드러나지 않는다.
    #[test]
    fn storage_key_second_number_is_duration() {
        assert_eq!(
            storage_key("cIQhpLSO4bA", 4000, 125000, "v1-copy"),
            "cIQhpLSO4bA-4000-121000-v1-copy.mp4"
        );
        assert_eq!(
            storage_key("JH1miZzWZ2I", 1000, 176000, "v1-copy"),
            "JH1miZzWZ2I-1000-175000-v1-copy.mp4"
        );
        assert_eq!(
            storage_key("pY6TiZP14Qc", 1000, 115000, "v1-copy"),
            "pY6TiZP14Qc-1000-114000-v1-copy.mp4"
        );
    }

    #[test]
    fn storage_key_is_same_shape_when_start_is_zero() {
        assert_eq!(
            storage_key("EpP4UsviQPA", 0, 121000, "v1-copy"),
            "EpP4UsviQPA-0-121000-v1-copy.mp4"
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
