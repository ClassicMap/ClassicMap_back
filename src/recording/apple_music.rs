//! Apple Music 카탈로그 API 클라이언트.
//!
//! 개발자 토큰은 ES256 JWT다 (header `kid` = 키 ID, claims `iss` = 팀 ID).
//! 키는 환경변수로만 받고, 값은 어디에도 남기지 않는다.

use jsonwebtoken::{encode, Algorithm, EncodingKey, Header};
use serde::{Deserialize, Serialize};
use std::env;
use std::time::{Duration, SystemTime, UNIX_EPOCH};

const API_BASE: &str = "https://api.music.apple.com/v1";
/// 토큰 수명. Apple 은 최대 6개월까지 받지만 동기화 한 번 동안만 쓰면 된다.
const TOKEN_TTL_SECS: u64 = 60 * 60;
/// 시드 앨범 제목·아티스트 이름이 영어라 미국 스토어프런트로 맞춘다. ID 는 스토어프런트와 무관하다.
const DEFAULT_STOREFRONT: &str = "us";
const MAX_RETRIES: u32 = 3;

#[derive(Clone)]
pub struct AppleMusicConfig {
    private_key_pem: String,
    key_id: String,
    team_id: String,
    pub storefront: String,
}

impl std::fmt::Debug for AppleMusicConfig {
    // 키가 로그에 찍히지 않게 값은 숨긴다
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("AppleMusicConfig")
            .field("storefront", &self.storefront)
            .finish_non_exhaustive()
    }
}

impl AppleMusicConfig {
    /// APPLE_MUSIC_PRIVATE_KEY · APPLE_MUSIC_KEY_ID · APPLE_MUSIC_TEAM_KEY 가 모두 있어야 한다.
    /// 하나라도 비면 None (동기화를 끈다).
    pub fn from_env() -> Option<Self> {
        let read = |name: &str| {
            env::var(name)
                .ok()
                .map(|value| value.trim().to_string())
                .filter(|v| !v.is_empty())
        };
        Some(Self {
            private_key_pem: normalize_pem(&read("APPLE_MUSIC_PRIVATE_KEY")?),
            key_id: read("APPLE_MUSIC_KEY_ID")?,
            team_id: read("APPLE_MUSIC_TEAM_KEY")?,
            storefront: read("APPLE_MUSIC_STOREFRONT")
                .unwrap_or_else(|| DEFAULT_STOREFRONT.to_string()),
        })
    }

    pub fn developer_token(&self, now_secs: u64) -> Result<String, String> {
        let mut header = Header::new(Algorithm::ES256);
        header.kid = Some(self.key_id.clone());
        let key = EncodingKey::from_ec_pem(self.private_key_pem.as_bytes())
            .map_err(|_| "Apple Music private key is not a valid EC PEM".to_string())?;
        encode(&header, &token_claims(&self.team_id, now_secs), &key)
            .map_err(|_| "Failed to sign Apple Music developer token".to_string())
    }
}

/// .env 에 한 줄로 넣은 PEM 은 줄바꿈이 `\n` 문자로 들어 있다.
fn normalize_pem(raw: &str) -> String {
    raw.trim_matches('"').replace("\\n", "\n")
}

#[derive(Debug, Serialize, PartialEq)]
pub struct TokenClaims {
    pub iss: String,
    pub iat: u64,
    pub exp: u64,
}

pub fn token_claims(team_id: &str, now_secs: u64) -> TokenClaims {
    TokenClaims {
        iss: team_id.to_string(),
        iat: now_secs,
        exp: now_secs + TOKEN_TTL_SECS,
    }
}

// ---------- 응답 모양 ----------

#[derive(Debug, Deserialize)]
pub struct Page<T> {
    #[serde(default = "Vec::new")]
    pub data: Vec<T>,
}

#[derive(Debug, Deserialize)]
pub struct Artwork {
    pub url: String,
    pub width: Option<i32>,
    pub height: Option<i32>,
}

#[derive(Debug, Deserialize)]
pub struct EditorialNotes {
    pub standard: Option<String>,
    pub short: Option<String>,
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct AlbumAttributes {
    pub name: String,
    pub release_date: Option<String>,
    pub record_label: Option<String>,
    pub upc: Option<String>,
    pub track_count: Option<i32>,
    pub is_single: Option<bool>,
    pub is_compilation: Option<bool>,
    #[serde(default)]
    pub genre_names: Vec<String>,
    pub copyright: Option<String>,
    pub editorial_notes: Option<EditorialNotes>,
    pub artwork: Option<Artwork>,
    pub url: Option<String>,
}

#[derive(Debug, Deserialize)]
pub struct Album {
    pub id: String,
    pub attributes: Option<AlbumAttributes>,
    pub relationships: Option<AlbumRelationships>,
}

#[derive(Debug, Deserialize)]
pub struct AlbumRelationships {
    pub artists: Option<Page<ResourceRef>>,
}

#[derive(Debug, Deserialize)]
pub struct ResourceRef {
    pub id: String,
    pub attributes: Option<ArtistAttributes>,
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ArtistAttributes {
    pub name: String,
    #[serde(default)]
    pub genre_names: Vec<String>,
}

#[derive(Debug, Deserialize)]
pub struct SearchResponse {
    pub results: SearchResults,
}

#[derive(Debug, Deserialize)]
pub struct SearchResults {
    pub artists: Option<Page<ResourceRef>>,
}

/// 표지 템플릿 `{w}x{h}` 을 시드와 같은 1000x1000bb 로 채운다.
pub fn artwork_url(template: &str) -> String {
    template
        .replace("{w}x{h}bb", "1000x1000bb")
        .replace("{w}", "1000")
        .replace("{h}", "1000")
}

/// 발매일은 'YYYY-MM-DD' 또는 'YYYY' 로 온다.
pub fn release_year(release_date: &str) -> Option<String> {
    let year = release_date.get(0..4)?;
    year.chars()
        .all(|c| c.is_ascii_digit())
        .then(|| year.to_string())
}

/// 이름 비교용: 소문자, 글자와 숫자만. 악센트는 흔한 라틴 글자만 벗긴다.
pub fn normalize_name(name: &str) -> String {
    name.chars()
        .flat_map(|c| c.to_lowercase())
        .map(|c| match c {
            'á' | 'à' | 'â' | 'ä' | 'ã' | 'å' => 'a',
            'é' | 'è' | 'ê' | 'ë' => 'e',
            'í' | 'ì' | 'î' | 'ï' => 'i',
            'ó' | 'ò' | 'ô' | 'ö' | 'õ' | 'ø' => 'o',
            'ú' | 'ù' | 'û' | 'ü' => 'u',
            'ç' | 'č' | 'ć' => 'c',
            'ñ' | 'ń' => 'n',
            'š' | 'ś' => 's',
            'ž' | 'ź' | 'ż' => 'z',
            'ł' => 'l',
            'ř' => 'r',
            'ý' | 'ÿ' => 'y',
            other => other,
        })
        .filter(|c| c.is_alphanumeric())
        .collect()
}

pub fn same_name(a: &str, b: &str) -> bool {
    let (a, b) = (normalize_name(a), normalize_name(b));
    !a.is_empty() && a == b
}

/// 우리 앨범에 참여한 Apple 아티스트 중 이 연주자를 고른다.
/// 이름이 정확히 같으면 그 사람, 아니면 앨범 아티스트가 한 명뿐이고 성(마지막 단어)이 같을 때만.
pub fn pick_album_artist<'a>(
    english_name: &str,
    korean_name: &str,
    artists: &'a [ResourceRef],
) -> Option<&'a ResourceRef> {
    let is_ours = |name: &str| same_name(name, english_name) || same_name(name, korean_name);
    if let Some(exact) = artists.iter().find(|artist| is_ours(artist_name(artist))) {
        return Some(exact);
    }
    if artists.len() != 1 {
        return None;
    }
    let only = &artists[0];
    let last = |name: &str| {
        name.split_whitespace()
            .last()
            .map(normalize_name)
            .unwrap_or_default()
    };
    let ours = last(english_name);
    (!ours.is_empty() && ours == last(artist_name(only))).then_some(only)
}

fn artist_name(artist: &ResourceRef) -> &str {
    artist
        .attributes
        .as_ref()
        .map(|a| a.name.as_str())
        .unwrap_or("")
}

/// 이름 검색 결과는 동명이인 위험이 커서 이름이 정확히 같고 장르에 Classical 이 있을 때만 쓴다.
pub fn pick_search_artist<'a>(
    english_name: &str,
    artists: &'a [ResourceRef],
) -> Option<&'a ResourceRef> {
    let mut matches = artists.iter().filter(|artist| {
        artist.attributes.as_ref().is_some_and(|attributes| {
            same_name(&attributes.name, english_name)
                && attributes
                    .genre_names
                    .iter()
                    .any(|genre| genre.eq_ignore_ascii_case("classical"))
        })
    });
    let first = matches.next()?;
    // 같은 이름의 클래식 아티스트가 둘 이상이면 고르지 않는다
    matches.next().is_none().then_some(first)
}

// ---------- 호출 ----------

pub struct AppleMusicClient {
    http: reqwest::Client,
    config: AppleMusicConfig,
    token: String,
    /// 요청 사이 간격. 카탈로그 API 한도를 넘지 않게 천천히 부른다.
    pub pace: Duration,
}

impl AppleMusicClient {
    pub fn new(config: AppleMusicConfig) -> Result<Self, String> {
        let now = SystemTime::now()
            .duration_since(UNIX_EPOCH)
            .map_err(|e| e.to_string())?
            .as_secs();
        let token = config.developer_token(now)?;
        let http = reqwest::Client::builder()
            .timeout(Duration::from_secs(20))
            .build()
            .map_err(|e| e.to_string())?;
        Ok(Self {
            http,
            config,
            token,
            pace: Duration::from_millis(250),
        })
    }

    pub fn storefront(&self) -> &str {
        &self.config.storefront
    }

    async fn get<T: for<'de> Deserialize<'de>>(
        &self,
        path_and_query: &str,
    ) -> Result<Option<T>, String> {
        let url = format!("{}{}", API_BASE, path_and_query);
        let mut attempt = 0;
        loop {
            tokio::time::sleep(self.pace).await;
            let response = self
                .http
                .get(&url)
                .bearer_auth(&self.token)
                .send()
                .await
                .map_err(|e| format!("Apple Music request failed: {}", e.without_url()))?;
            let status = response.status();
            if status.as_u16() == 404 {
                return Ok(None);
            }
            if status.as_u16() == 429 || status.is_server_error() {
                attempt += 1;
                if attempt > MAX_RETRIES {
                    return Err(format!(
                        "Apple Music {} after {} retries",
                        status, MAX_RETRIES
                    ));
                }
                tokio::time::sleep(Duration::from_secs(5 * 2u64.pow(attempt - 1))).await;
                continue;
            }
            if !status.is_success() {
                return Err(format!(
                    "Apple Music {} for {}",
                    status,
                    path_and_query.split('?').next().unwrap_or("")
                ));
            }
            return response
                .json::<T>()
                .await
                .map(Some)
                .map_err(|e| format!("Apple Music response parse failed: {}", e.without_url()));
        }
    }

    /// 앨범과 그 앨범의 아티스트들
    pub async fn album_with_artists(&self, album_id: &str) -> Result<Option<Album>, String> {
        let page: Option<Page<Album>> = self
            .get(&format!(
                "/catalog/{}/albums/{}?include=artists",
                self.storefront(),
                url_escape(album_id)
            ))
            .await?;
        Ok(page.and_then(|page| page.data.into_iter().next()))
    }

    pub async fn search_artists(&self, term: &str) -> Result<Vec<ResourceRef>, String> {
        let response: Option<SearchResponse> = self
            .get(&format!(
                "/catalog/{}/search?types=artists&limit=10&term={}",
                self.storefront(),
                url_escape(term)
            ))
            .await?;
        Ok(response
            .and_then(|r| r.results.artists)
            .map(|p| p.data)
            .unwrap_or_default())
    }

    /// 아티스트의 정규 앨범. Apple Music 앱과 같은 순서(최근 발매 먼저)로 온다.
    pub async fn artist_full_albums(
        &self,
        artist_id: &str,
        limit: u32,
    ) -> Result<Vec<Album>, String> {
        let page: Option<Page<Album>> = self
            .get(&format!(
                "/catalog/{}/artists/{}/view/full-albums?limit={}",
                self.storefront(),
                url_escape(artist_id),
                limit.clamp(1, 100)
            ))
            .await?;
        Ok(page.map(|p| p.data).unwrap_or_default())
    }
}

fn url_escape(value: &str) -> String {
    url::form_urlencoded::byte_serialize(value.as_bytes()).collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn artist(name: &str, genres: &[&str]) -> ResourceRef {
        ResourceRef {
            id: name.to_string(),
            attributes: Some(ArtistAttributes {
                name: name.to_string(),
                genre_names: genres.iter().map(|g| g.to_string()).collect(),
            }),
        }
    }

    #[test]
    fn claims_use_team_id_and_expire_after_ttl() {
        let claims = token_claims("TEAM", 1_000);
        assert_eq!(
            claims,
            TokenClaims {
                iss: "TEAM".into(),
                iat: 1_000,
                exp: 1_000 + TOKEN_TTL_SECS
            }
        );
    }

    #[test]
    fn pem_with_escaped_newlines_is_restored() {
        let pem =
            normalize_pem("\"-----BEGIN PRIVATE KEY-----\\nabc\\n-----END PRIVATE KEY-----\"");
        assert_eq!(
            pem,
            "-----BEGIN PRIVATE KEY-----\nabc\n-----END PRIVATE KEY-----"
        );
    }

    #[test]
    fn config_debug_hides_secrets() {
        let config = AppleMusicConfig {
            private_key_pem: "SECRET-PEM".into(),
            key_id: "SECRET-KID".into(),
            team_id: "SECRET-TEAM".into(),
            storefront: "kr".into(),
        };
        let printed = format!("{:?}", config);
        assert!(!printed.contains("SECRET"));
    }

    #[test]
    fn artwork_template_fills_size() {
        assert_eq!(
            artwork_url("https://is1-ssl.mzstatic.com/image/thumb/a/b/cover.jpg/{w}x{h}bb.jpg"),
            "https://is1-ssl.mzstatic.com/image/thumb/a/b/cover.jpg/1000x1000bb.jpg"
        );
    }

    #[test]
    fn release_year_reads_date_or_year() {
        assert_eq!(release_year("2025-05-16").as_deref(), Some("2025"));
        assert_eq!(release_year("2024").as_deref(), Some("2024"));
        assert_eq!(release_year("bad"), None);
    }

    #[test]
    fn names_match_ignoring_case_spacing_and_accents() {
        assert!(same_name("Yeol Eum Son", "yeol eum  son"));
        assert!(same_name("Mitsuko Uchida", "Mitsuko Uchida"));
        assert!(same_name("Gábor Takács-Nagy", "Gabor Takacs Nagy"));
        assert!(!same_name("Lang Lang", "Yundi"));
        assert!(!same_name("", ""));
    }

    #[test]
    fn album_artist_prefers_exact_name_then_single_artist_surname() {
        let pair = [
            artist("Andrés Orozco-Estrada", &[]),
            artist("Yuja Wang", &[]),
        ];
        assert_eq!(
            pick_album_artist("Yuja Wang", "유자 왕", &pair).map(|a| a.id.as_str()),
            Some("Yuja Wang")
        );
        assert!(pick_album_artist("Seong-Jin Cho", "조성진", &pair).is_none());

        let korean = [artist("손열음", &[]), artist("레지덴티 오케스트라", &[])];
        assert_eq!(
            pick_album_artist("Yeol Eum Son", "손열음", &korean).map(|a| a.id.as_str()),
            Some("손열음")
        );

        let solo = [artist("Seong-Jin Cho", &[])];
        assert!(pick_album_artist("Seongjin Cho", "조성진", &solo).is_some());
        let other = [artist("Daniel Barenboim", &[])];
        assert!(pick_album_artist("Seong-Jin Cho", "조성진", &other).is_none());
    }

    #[test]
    fn search_artist_needs_exact_name_classical_and_no_twin() {
        let results = [
            artist("Lang Lang", &["Classical"]),
            artist("Lang Lang Band", &["Pop"]),
        ];
        assert!(pick_search_artist("Lang Lang", &results).is_some());

        let pop = [artist("John Williams", &["Soundtrack"])];
        assert!(pick_search_artist("John Williams", &pop).is_none());

        let twins = [
            artist("John Williams", &["Classical"]),
            artist("John Williams", &["Classical", "Guitar"]),
        ];
        assert!(pick_search_artist("John Williams", &twins).is_none());
    }

    #[test]
    fn album_page_parses_optional_fields() {
        let json = r#"{"data":[{"id":"1797822937","attributes":{"name":"Ravel","releaseDate":"2025-05-16",
            "recordLabel":"Naïve","upc":"3617390936252","trackCount":8,"isSingle":false,"isCompilation":false,
            "genreNames":["Classical"],"artwork":{"url":"https://x/{w}x{h}bb.jpg","width":3000,"height":3000},
            "url":"https://music.apple.com/kr/album/x/1797822937","editorialNotes":{"short":"s"}},
            "relationships":{"artists":{"data":[{"id":"1","attributes":{"name":"Yeol Eum Son","genreNames":["Classical"]}}]}}}]}"#;
        let page: Page<Album> = serde_json::from_str(json).unwrap();
        let album = &page.data[0];
        let attributes = album.attributes.as_ref().unwrap();
        assert_eq!(attributes.upc.as_deref(), Some("3617390936252"));
        assert_eq!(
            attributes
                .editorial_notes
                .as_ref()
                .and_then(|n| n.short.as_deref()),
            Some("s")
        );
        let artists = &album
            .relationships
            .as_ref()
            .unwrap()
            .artists
            .as_ref()
            .unwrap()
            .data;
        assert_eq!(artists[0].id, "1");
    }

    /// 실API 확인용. 키가 있을 때만 `cargo test --lib apple_music_live -- --ignored --nocapture`.
    /// 토큰과 키는 출력하지 않고 개수만 찍는다.
    #[tokio::test]
    #[ignore]
    async fn apple_music_live() {
        let Some(config) = AppleMusicConfig::from_env() else {
            println!("apple music env not set");
            return;
        };
        let client = AppleMusicClient::new(config).expect("token");
        let album = client
            .album_with_artists("1797822937")
            .await
            .expect("album")
            .expect("album exists");
        let artists = album
            .relationships
            .and_then(|r| r.artists)
            .map(|p| p.data)
            .unwrap_or_default();
        println!(
            "album artists: {:?}",
            artists.iter().map(|a| artist_name(a)).collect::<Vec<_>>()
        );
        let picked = pick_album_artist("Yeol Eum Son", "손열음", &artists).expect("picked artist");
        println!("resolved artist id: {}", picked.id);
        let albums = client
            .artist_full_albums(&picked.id, 25)
            .await
            .expect("albums");
        println!("full albums: {}", albums.len());
        for album in albums.iter().take(5) {
            let attributes = album.attributes.as_ref().unwrap();
            println!(
                "  {} | {}",
                attributes.release_date.as_deref().unwrap_or("-"),
                attributes.name
            );
        }
        let search = client.search_artists("Yeol Eum Son").await.expect("search");
        println!("search matches: {}", search.len());
    }
}
