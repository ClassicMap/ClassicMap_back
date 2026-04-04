use std::collections::hash_map::DefaultHasher;
use std::hash::{Hash, Hasher};
use std::path::{Path, PathBuf};
use tokio::fs;
use crate::db::DbPool;
use crate::logger::Logger;

const CACHE_DIR: &str = "cache/images";
const ALLOWED_DOMAINS: &[&str] = &[
    "upload.wikimedia.org",
    "commons.wikimedia.org",
    "en.wikipedia.org",
    "ko.wikipedia.org",
];

#[derive(sqlx::FromRow)]
struct ImageUrl {
    url: String,
}

#[derive(serde::Serialize)]
#[serde(rename_all = "camelCase")]
pub struct WarmupResult {
    pub total: u32,
    pub cached: u32,
    pub skipped: u32,
    pub failed: u32,
}

pub struct ImageProxyService;

impl ImageProxyService {
    pub fn validate_url(url: &str) -> Result<(), String> {
        let parsed = url::Url::parse(url).map_err(|_| "잘못된 URL 형식".to_string())?;

        let host = parsed.host_str().ok_or("호스트 없음".to_string())?;

        if !ALLOWED_DOMAINS.iter().any(|d| host.ends_with(d)) {
            return Err("허용되지 않은 도메인".to_string());
        }

        Ok(())
    }

    fn cache_path(url: &str) -> PathBuf {
        let mut hasher = DefaultHasher::new();
        url.hash(&mut hasher);
        let hash = hasher.finish();

        let ext = url
            .rsplit('.')
            .next()
            .filter(|e| ["jpg", "jpeg", "png", "gif", "webp", "svg"].contains(e))
            .unwrap_or("jpg");

        Path::new(CACHE_DIR).join(format!("{:x}.{}", hash, ext))
    }

    pub async fn get_or_fetch(url: &str) -> Result<(Vec<u8>, String), String> {
        Self::validate_url(url)?;

        let path = Self::cache_path(url);

        // 캐시 히트
        if path.exists() {
            let bytes = fs::read(&path).await.map_err(|e| e.to_string())?;
            let content_type = Self::guess_content_type(&path);
            return Ok((bytes, content_type));
        }

        // 캐시 미스 → 위키피디아에서 다운로드 (429 시 재시도)
        let client = reqwest::Client::new();
        let max_retries = 3;
        let mut last_error = String::new();

        let (bytes, content_type) = 'retry: {
            for attempt in 0..max_retries {
                if attempt > 0 {
                    tokio::time::sleep(std::time::Duration::from_millis(500 * (1 << attempt))).await;
                }

                let response = match client
                    .get(url)
                    .header("User-Agent", "ClassicMapBot/1.0 (https://classicmap.app; contact@classicmap.app)")
                    .send()
                    .await
                {
                    Ok(r) => r,
                    Err(e) => {
                        last_error = format!("이미지 다운로드 실패: {}", e);
                        continue;
                    }
                };

                if response.status() == reqwest::StatusCode::TOO_MANY_REQUESTS {
                    last_error = "429 Too Many Requests".to_string();
                    continue;
                }

                if !response.status().is_success() {
                    return Err(format!("이미지 요청 실패: {}", response.status()));
                }

                let ct = response
                    .headers()
                    .get("content-type")
                    .and_then(|v| v.to_str().ok())
                    .unwrap_or("image/jpeg")
                    .to_string();

                let data = response
                    .bytes()
                    .await
                    .map_err(|e| format!("이미지 읽기 실패: {}", e))?
                    .to_vec();

                break 'retry (data, ct);
            }
            return Err(format!("재시도 초과: {}", last_error));
        };

        // 캐시 디렉토리 생성 후 저장
        fs::create_dir_all(CACHE_DIR)
            .await
            .map_err(|e| format!("캐시 디렉토리 생성 실패: {}", e))?;

        fs::write(&path, &bytes)
            .await
            .map_err(|e| format!("캐시 저장 실패: {}", e))?;

        Ok((bytes, content_type))
    }

    pub async fn warmup_cache(pool: &DbPool) -> Result<WarmupResult, String> {
        // DB에서 위키피디아 이미지 URL 전부 수집
        let rows = sqlx::query_as::<_, ImageUrl>(
            "SELECT avatar_url AS url FROM composers WHERE avatar_url IS NOT NULL
             UNION
             SELECT cover_image_url AS url FROM composers WHERE cover_image_url IS NOT NULL
             UNION
             SELECT image_url AS url FROM artists WHERE image_url IS NOT NULL
             UNION
             SELECT cover_image_url AS url FROM artists WHERE cover_image_url IS NOT NULL"
        )
        .fetch_all(pool)
        .await
        .map_err(|e| format!("DB 조회 실패: {}", e))?;

        // 위키피디아 도메인만 필터
        let urls: Vec<String> = rows
            .into_iter()
            .filter(|r| Self::validate_url(&r.url).is_ok())
            .map(|r| r.url)
            .collect();

        let total = urls.len();
        let mut cached = 0u32;
        let mut skipped = 0u32;
        let mut failed = 0u32;

        Logger::info("CACHE", &format!("캐시 워밍업 시작: {} 개 이미지", total));

        for (i, url) in urls.iter().enumerate() {
            let path = Self::cache_path(url);

            // 이미 캐시돼 있으면 스킵
            if path.exists() {
                skipped += 1;
                continue;
            }

            match Self::get_or_fetch(url).await {
                Ok(_) => {
                    cached += 1;
                    Logger::info("CACHE", &format!("[{}/{}] 캐싱 완료: {}", i + 1, total, url));
                }
                Err(e) => {
                    failed += 1;
                    Logger::error("CACHE", &format!("[{}/{}] 캐싱 실패: {} - {}", i + 1, total, url, e));
                }
            }

            // 429 방지: 요청 간 200ms 딜레이
            tokio::time::sleep(std::time::Duration::from_millis(200)).await;
        }

        Logger::success("CACHE", &format!(
            "캐시 워밍업 완료: 총 {} / 신규 {} / 기존 {} / 실패 {}",
            total, cached, skipped, failed
        ));

        Ok(WarmupResult { total: total as u32, cached, skipped, failed })
    }

    fn guess_content_type(path: &Path) -> String {
        match path.extension().and_then(|e| e.to_str()) {
            Some("png") => "image/png",
            Some("gif") => "image/gif",
            Some("webp") => "image/webp",
            Some("svg") => "image/svg+xml",
            _ => "image/jpeg",
        }
        .to_string()
    }
}
