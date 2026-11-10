use super::models::{
    BoxofficeResponse, ConcertDetailResponse, ConcertListResponse, VenueDetailResponse,
    VenueListResponse,
};
use reqwest::StatusCode;
use serde_xml_rs::from_str;
use std::time::{Duration, Instant};
use tokio::sync::Mutex;

/// KOPIS 는 짧은 시간에 몰아 부르면(1.7초에 7번째쯤부터) 400 "Request Blocked" 로 막는다.
/// 요청 사이를 이만큼 띄운다
const MIN_REQUEST_INTERVAL: Duration = Duration::from_millis(500);
/// 막히거나 일시 오류일 때 다시 부르기 전에 기다리는 시간
const RETRY_DELAYS: [Duration; 4] = [
    Duration::from_secs(5),
    Duration::from_secs(15),
    Duration::from_secs(45),
    Duration::from_secs(120),
];
const REQUEST_TIMEOUT: Duration = Duration::from_secs(30);

pub struct KopisClient {
    api_key: String,
    base_url: String,
    client: reqwest::Client,
    last_request: Mutex<Option<Instant>>,
}

impl KopisClient {
    pub fn new(api_key: String, base_url: String) -> Self {
        let client = reqwest::Client::builder()
            .timeout(REQUEST_TIMEOUT)
            .build()
            .unwrap_or_else(|_| reqwest::Client::new());
        Self {
            api_key,
            base_url,
            client,
            last_request: Mutex::new(None),
        }
    }

    /// 앞 요청과 MIN_REQUEST_INTERVAL 만큼 떨어질 때까지 기다린다
    async fn wait_turn(&self) {
        let mut last = self.last_request.lock().await;
        if let Some(previous) = *last {
            let elapsed = previous.elapsed();
            if elapsed < MIN_REQUEST_INTERVAL {
                tokio::time::sleep(MIN_REQUEST_INTERVAL - elapsed).await;
            }
        }
        *last = Some(Instant::now());
    }

    /// 400(Request Blocked)·429·5xx 와 연결 오류는 잠시 뒤 다시 부른다
    fn is_retryable(status: StatusCode) -> bool {
        status == StatusCode::BAD_REQUEST
            || status == StatusCode::TOO_MANY_REQUESTS
            || status.is_server_error()
    }

    /// KOPIS 오류 응답이면 "코드 메시지" 를 돌려준다
    fn error_envelope(body: &str) -> Option<String> {
        let code = Self::tag_text(body, "returncode")?;
        let message = Self::tag_text(body, "errmsg").unwrap_or_default();
        Some(format!("{} {}", code, message).trim().to_string())
    }

    fn tag_text(body: &str, tag: &str) -> Option<String> {
        let open = format!("<{}>", tag);
        let close = format!("</{}>", tag);
        let start = body.find(&open)? + open.len();
        let end = body[start..].find(&close)? + start;
        Some(body[start..end].trim().to_string())
    }

    /// GET 해서 본문을 돌려준다. 오류 문구에는 URL 을 넣지 않는다(서비스 키가 들어 있다)
    async fn get_text(&self, url: &str, what: &str) -> Result<String, String> {
        let mut attempt = 0;
        loop {
            self.wait_turn().await;
            let failure = match self.client.get(url).send().await {
                Ok(response) => {
                    let status = response.status();
                    if status.is_success() {
                        let body = response.text().await.map_err(|e| {
                            format!("Failed to read {} response: {}", what, e.without_url())
                        })?;
                        // 오류도 200 으로 <returncode>/<errmsg> 를 담아 온다. 빈 목록으로 읽히지 않게 막는다
                        if let Some(message) = Self::error_envelope(&body) {
                            return Err(format!("KOPIS API error for {}: {}", what, message));
                        }
                        return Ok(body);
                    }
                    if !Self::is_retryable(status) {
                        return Err(format!("KOPIS API returned error for {}: {}", what, status));
                    }
                    format!("KOPIS API returned error for {}: {}", what, status)
                }
                Err(e) => format!("Failed to fetch {}: {}", what, e.without_url()),
            };
            match RETRY_DELAYS.get(attempt) {
                Some(delay) => {
                    tokio::time::sleep(*delay).await;
                    attempt += 1;
                }
                None => return Err(failure),
            }
        }
    }

    pub fn from_env() -> Result<Self, String> {
        let api_key = std::env::var("KOPIS_API_KEY")
            .map_err(|_| "KOPIS_API_KEY not found in environment".to_string())?;
        let base_url = std::env::var("KOPIS_BASE_URL")
            .unwrap_or_else(|_| "http://www.kopis.or.kr/openApi/restful".to_string());

        Ok(Self::new(api_key, base_url))
    }

    /// 공연장 목록 조회
    ///
    /// # Arguments
    /// * `page` - 현재 페이지 (1부터 시작)
    /// * `rows` - 페이지당 목록 수 (최대 100)
    /// * `after_date` - 해당일자 이후 등록/수정된 항목만 출력 (YYYYMMDD, Optional)
    pub async fn fetch_venue_list(
        &self,
        page: u32,
        rows: u32,
        after_date: Option<&str>,
    ) -> Result<VenueListResponse, String> {
        let mut url = format!(
            "{}/prfplc?service={}&cpage={}&rows={}",
            self.base_url,
            self.api_key,
            page,
            rows.min(100)
        );

        if let Some(date) = after_date {
            url.push_str(&format!("&afterdate={}", date));
        }

        let xml_text = self.get_text(&url, "venue list").await?;

        // XML 파싱
        match from_str::<VenueListResponse>(&xml_text) {
            Ok(parsed) => Ok(parsed),
            Err(e) => {
                // 파싱 실패 시 원본 XML도 함께 출력
                eprintln!("XML parsing error: {}", e);
                eprintln!(
                    "Raw XML (first 500 chars): {}",
                    xml_text.chars().take(500).collect::<String>()
                );
                Err(format!("Failed to parse XML response: {}", e))
            }
        }
    }

    /// 공연장 상세 정보 조회
    ///
    /// # Arguments
    /// * `facility_id` - 공연시설ID (예: FC000517)
    pub async fn fetch_venue_detail(
        &self,
        facility_id: &str,
    ) -> Result<VenueDetailResponse, String> {
        let url = format!(
            "{}/prfplc/{}?service={}",
            self.base_url, facility_id, self.api_key
        );

        let xml_text = self.get_text(&url, "venue detail").await?;

        // XML 파싱
        match from_str::<VenueDetailResponse>(&xml_text) {
            Ok(parsed) => Ok(parsed),
            Err(e) => {
                eprintln!("XML parsing error: {}", e);
                eprintln!(
                    "Raw XML (first 500 chars): {}",
                    xml_text.chars().take(500).collect::<String>()
                );
                Err(format!("Failed to parse XML response: {}", e))
            }
        }
    }

    /// 모든 페이지의 공연장 목록 조회 (페이징 처리)
    ///
    /// # Arguments
    /// * `after_date` - 해당일자 이후 등록/수정된 항목만 출력 (YYYYMMDD, Optional)
    pub async fn fetch_all_venues(
        &self,
        after_date: Option<&str>,
    ) -> Result<Vec<crate::kopis::models::VenueListItem>, String> {
        let mut all_venues = Vec::new();
        let mut page = 1u32;
        let rows_per_page = 100u32;

        loop {
            let response = self
                .fetch_venue_list(page, rows_per_page, after_date)
                .await?;

            let venue_count = response.db.len();
            if venue_count == 0 {
                break;
            }

            all_venues.extend(response.db);

            // 100개 미만이면 마지막 페이지
            if venue_count < rows_per_page as usize {
                break;
            }

            page += 1;

            // 안전장치: 최대 100페이지까지만 (10,000개)
            if page > 100 {
                break;
            }
        }

        Ok(all_venues)
    }

    // ============================================
    // 공연 관련 API
    // ============================================

    /// 공연 목록 조회
    ///
    /// # Arguments
    /// * `start_date` - 공연시작일자 (YYYYMMDD)
    /// * `end_date` - 공연종료일자 (YYYYMMDD, 최대 31일)
    /// * `page` - 현재 페이지 (1부터 시작)
    /// * `rows` - 페이지당 목록 수 (최대 100)
    /// * `genre_code` - 장르코드 (Optional, 예: "CCCA" = 클래식)
    /// * `after_date` - 해당일자 이후 등록/수정된 항목만 출력 (YYYYMMDD, Optional)
    pub async fn fetch_concert_list(
        &self,
        start_date: &str,
        end_date: &str,
        page: u32,
        rows: u32,
        genre_code: Option<&str>,
        after_date: Option<&str>,
    ) -> Result<ConcertListResponse, String> {
        let mut url = format!(
            "{}/pblprfr?service={}&stdate={}&eddate={}&cpage={}&rows={}",
            self.base_url,
            self.api_key,
            start_date,
            end_date,
            page,
            rows.min(100)
        );

        if let Some(code) = genre_code {
            url.push_str(&format!("&shcate={}", code));
        }

        if let Some(date) = after_date {
            url.push_str(&format!("&afterdate={}", date));
        }

        let xml_text = self.get_text(&url, "concert list").await?;

        match from_str::<ConcertListResponse>(&xml_text) {
            Ok(parsed) => Ok(parsed),
            Err(e) => {
                eprintln!("XML parsing error: {}", e);
                eprintln!(
                    "Raw XML (first 500 chars): {}",
                    xml_text.chars().take(500).collect::<String>()
                );
                Err(format!("Failed to parse XML response: {}", e))
            }
        }
    }

    /// 공연 상세 정보 조회
    ///
    /// # Arguments
    /// * `performance_id` - 공연ID (예: PF132236)
    pub async fn fetch_concert_detail(
        &self,
        performance_id: &str,
    ) -> Result<ConcertDetailResponse, String> {
        let url = format!(
            "{}/pblprfr/{}?service={}",
            self.base_url, performance_id, self.api_key
        );

        let xml_text = self.get_text(&url, "concert detail").await?;

        match from_str::<ConcertDetailResponse>(&xml_text) {
            Ok(parsed) => Ok(parsed),
            Err(e) => {
                eprintln!("XML parsing error: {}", e);
                eprintln!(
                    "Raw XML (first 500 chars): {}",
                    xml_text.chars().take(500).collect::<String>()
                );
                Err(format!("Failed to parse XML response: {}", e))
            }
        }
    }

    /// 모든 페이지의 공연 목록 조회 (페이징 처리)
    ///
    /// # Arguments
    /// * `start_date` - 공연시작일자 (YYYYMMDD)
    /// * `end_date` - 공연종료일자 (YYYYMMDD, 최대 31일)
    /// * `genre_code` - 장르코드 (Optional)
    /// * `after_date` - 해당일자 이후 등록/수정된 항목만 출력 (YYYYMMDD, Optional)
    pub async fn fetch_all_concerts(
        &self,
        start_date: &str,
        end_date: &str,
        genre_code: Option<&str>,
        after_date: Option<&str>,
    ) -> Result<Vec<crate::kopis::models::ConcertListItem>, String> {
        let mut all_concerts = Vec::new();
        let mut page = 1u32;
        let rows_per_page = 100u32;

        loop {
            let response = self
                .fetch_concert_list(
                    start_date,
                    end_date,
                    page,
                    rows_per_page,
                    genre_code,
                    after_date,
                )
                .await?;

            let concert_count = response.db.len();
            if concert_count == 0 {
                break;
            }

            all_concerts.extend(response.db);

            if concert_count < rows_per_page as usize {
                break;
            }

            page += 1;

            // 안전장치: 최대 100페이지까지만
            if page > 100 {
                break;
            }
        }

        Ok(all_concerts)
    }

    // ============================================
    // 예매상황판 API
    // ============================================

    /// 예매상황판 조회 (순위)
    ///
    /// # Arguments
    /// * `start_date` - 시작일자 (YYYYMMDD)
    /// * `end_date` - 종료일자 (YYYYMMDD, 최대 31일)
    /// * `genre_code` - 장르 구분 코드 (Optional, 예: "CCCA" = 클래식)
    /// * `area_code` - 지역 코드 (Optional, 예: "11" = 서울)
    pub async fn fetch_boxoffice_rankings(
        &self,
        start_date: &str,
        end_date: &str,
        genre_code: Option<&str>,
        area_code: Option<&str>,
    ) -> Result<BoxofficeResponse, String> {
        let mut url = format!(
            "{}/boxoffice?service={}&stdate={}&eddate={}",
            self.base_url, self.api_key, start_date, end_date
        );

        if let Some(code) = genre_code {
            url.push_str(&format!("&catecode={}", code));
        }

        if let Some(area) = area_code {
            url.push_str(&format!("&area={}", area));
        }

        let xml_text = self.get_text(&url, "boxoffice rankings").await?;

        match from_str::<BoxofficeResponse>(&xml_text) {
            Ok(parsed) => Ok(parsed),
            Err(e) => {
                eprintln!("XML parsing error: {}", e);
                eprintln!(
                    "Raw XML (first 500 chars): {}",
                    xml_text.chars().take(500).collect::<String>()
                );
                Err(format!("Failed to parse XML response: {}", e))
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn retries_blocked_throttled_and_server_errors_only() {
        assert!(KopisClient::is_retryable(StatusCode::BAD_REQUEST));
        assert!(KopisClient::is_retryable(StatusCode::TOO_MANY_REQUESTS));
        assert!(KopisClient::is_retryable(StatusCode::BAD_GATEWAY));
        assert!(!KopisClient::is_retryable(StatusCode::NOT_FOUND));
        assert!(!KopisClient::is_retryable(StatusCode::FORBIDDEN));
    }

    #[test]
    fn reads_error_envelope_but_not_normal_lists() {
        let error = "<dbs><db><returncode>06</returncode><errmsg>최대 조회수는 100건까지 가능합니다.</errmsg></db></dbs>";
        assert_eq!(
            KopisClient::error_envelope(error).as_deref(),
            Some("06 최대 조회수는 100건까지 가능합니다.")
        );
        let list = "<dbs><db><mt20id>PF1</mt20id><prfnm>공연</prfnm></db></dbs>";
        assert_eq!(KopisClient::error_envelope(list), None);
        assert_eq!(KopisClient::error_envelope("<boxofs></boxofs>"), None);
    }

    #[tokio::test]
    async fn spaces_requests_apart() {
        let client = KopisClient::new("key".to_string(), "http://localhost".to_string());
        let started = Instant::now();
        client.wait_turn().await;
        client.wait_turn().await;
        client.wait_turn().await;
        assert!(started.elapsed() >= MIN_REQUEST_INTERVAL * 2);
    }
}
