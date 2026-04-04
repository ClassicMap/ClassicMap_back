use std::collections::hash_map::DefaultHasher;
use std::hash::{Hash, Hasher};
use std::path::{Path, PathBuf};
use tokio::fs;

const CACHE_DIR: &str = "cache/images";
const ALLOWED_DOMAINS: &[&str] = &[
    "upload.wikimedia.org",
    "commons.wikimedia.org",
    "en.wikipedia.org",
    "ko.wikipedia.org",
];

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

        // 캐시 미스 → 위키피디아에서 다운로드
        let client = reqwest::Client::new();
        let response = client
            .get(url)
            .header("User-Agent", "ClassicMapBot/1.0 (https://classicmap.app; contact@classicmap.app)")
            .send()
            .await
            .map_err(|e| format!("이미지 다운로드 실패: {}", e))?;

        if !response.status().is_success() {
            return Err(format!("이미지 요청 실패: {}", response.status()));
        }

        let content_type = response
            .headers()
            .get("content-type")
            .and_then(|v| v.to_str().ok())
            .unwrap_or("image/jpeg")
            .to_string();

        let bytes = response
            .bytes()
            .await
            .map_err(|e| format!("이미지 읽기 실패: {}", e))?
            .to_vec();

        // 캐시 디렉토리 생성 후 저장
        fs::create_dir_all(CACHE_DIR)
            .await
            .map_err(|e| format!("캐시 디렉토리 생성 실패: {}", e))?;

        fs::write(&path, &bytes)
            .await
            .map_err(|e| format!("캐시 저장 실패: {}", e))?;

        Ok((bytes, content_type))
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
