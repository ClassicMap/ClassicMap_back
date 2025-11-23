use super::models::{
    VenueListResponse, VenueDetailResponse,
    ConcertListResponse, ConcertDetailResponse,
    BoxofficeResponse,
};
use reqwest;
use serde_xml_rs::from_str;

pub struct KopisClient {
    api_key: String,
    base_url: String,
    client: reqwest::Client,
}

impl KopisClient {
    pub fn new(api_key: String, base_url: String) -> Self {
        Self {
            api_key,
            base_url,
            client: reqwest::Client::new(),
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
            self.base_url, self.api_key, page, rows.min(100)
        );

        if let Some(date) = after_date {
            url.push_str(&format!("&afterdate={}", date));
        }

        let response = self.client
            .get(&url)
            .send()
            .await
            .map_err(|e| format!("Failed to fetch venue list: {}", e))?;

        if !response.status().is_success() {
            return Err(format!("KOPIS API returned error: {}", response.status()));
        }

        let xml_text = response
            .text()
            .await
            .map_err(|e| format!("Failed to read response body: {}", e))?;

        // XML 파싱
        match from_str::<VenueListResponse>(&xml_text) {
            Ok(parsed) => Ok(parsed),
            Err(e) => {
                // 파싱 실패 시 원본 XML도 함께 출력
                eprintln!("XML parsing error: {}", e);
                eprintln!("Raw XML (first 500 chars): {}", &xml_text.chars().take(500).collect::<String>());
                Err(format!("Failed to parse XML response: {}", e))
            }
        }
    }

    /// 공연장 상세 정보 조회
    ///
    /// # Arguments
    /// * `facility_id` - 공연시설ID (예: FC000517)
    pub async fn fetch_venue_detail(&self, facility_id: &str) -> Result<VenueDetailResponse, String> {
        let url = format!(
            "{}/prfplc/{}?service={}",
            self.base_url, facility_id, self.api_key
        );

        let response = self.client
            .get(&url)
            .send()
            .await
            .map_err(|e| format!("Failed to fetch venue detail: {}", e))?;

        if !response.status().is_success() {
            return Err(format!("KOPIS API returned error: {}", response.status()));
        }

        let xml_text = response
            .text()
            .await
            .map_err(|e| format!("Failed to read response body: {}", e))?;

        // XML 파싱
        match from_str::<VenueDetailResponse>(&xml_text) {
            Ok(parsed) => Ok(parsed),
            Err(e) => {
                eprintln!("XML parsing error: {}", e);
                eprintln!("Raw XML (first 500 chars): {}", &xml_text.chars().take(500).collect::<String>());
                Err(format!("Failed to parse XML response: {}", e))
            }
        }
    }

    /// 모든 페이지의 공연장 목록 조회 (페이징 처리)
    ///
    /// # Arguments
    /// * `after_date` - 해당일자 이후 등록/수정된 항목만 출력 (YYYYMMDD, Optional)
    pub async fn fetch_all_venues(&self, after_date: Option<&str>) -> Result<Vec<crate::kopis::models::VenueListItem>, String> {
        let mut all_venues = Vec::new();
        let mut page = 1u32;
        let rows_per_page = 100u32;

        loop {
            let response = self.fetch_venue_list(page, rows_per_page, after_date).await?;

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
            self.base_url, self.api_key, start_date, end_date, page, rows.min(100)
        );

        if let Some(code) = genre_code {
            url.push_str(&format!("&shcate={}", code));
        }

        if let Some(date) = after_date {
            url.push_str(&format!("&afterdate={}", date));
        }

        let response = self.client
            .get(&url)
            .send()
            .await
            .map_err(|e| format!("Failed to fetch concert list: {}", e))?;

        if !response.status().is_success() {
            return Err(format!("KOPIS API returned error: {}", response.status()));
        }

        let xml_text = response
            .text()
            .await
            .map_err(|e| format!("Failed to read response body: {}", e))?;

        match from_str::<ConcertListResponse>(&xml_text) {
            Ok(parsed) => Ok(parsed),
            Err(e) => {
                eprintln!("XML parsing error: {}", e);
                eprintln!("Raw XML (first 500 chars): {}", &xml_text.chars().take(500).collect::<String>());
                Err(format!("Failed to parse XML response: {}", e))
            }
        }
    }

    /// 공연 상세 정보 조회
    ///
    /// # Arguments
    /// * `performance_id` - 공연ID (예: PF132236)
    pub async fn fetch_concert_detail(&self, performance_id: &str) -> Result<ConcertDetailResponse, String> {
        let url = format!(
            "{}/pblprfr/{}?service={}",
            self.base_url, performance_id, self.api_key
        );

        let response = self.client
            .get(&url)
            .send()
            .await
            .map_err(|e| format!("Failed to fetch concert detail: {}", e))?;

        if !response.status().is_success() {
            return Err(format!("KOPIS API returned error: {}", response.status()));
        }

        let xml_text = response
            .text()
            .await
            .map_err(|e| format!("Failed to read response body: {}", e))?;

        match from_str::<ConcertDetailResponse>(&xml_text) {
            Ok(parsed) => Ok(parsed),
            Err(e) => {
                eprintln!("XML parsing error: {}", e);
                eprintln!("Raw XML (first 500 chars): {}", &xml_text.chars().take(500).collect::<String>());
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
            let response = self.fetch_concert_list(
                start_date,
                end_date,
                page,
                rows_per_page,
                genre_code,
                after_date,
            ).await?;

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

        let response = self.client
            .get(&url)
            .send()
            .await
            .map_err(|e| format!("Failed to fetch boxoffice rankings: {}", e))?;

        if !response.status().is_success() {
            return Err(format!("KOPIS API returned error: {}", response.status()));
        }

        let xml_text = response
            .text()
            .await
            .map_err(|e| format!("Failed to read response body: {}", e))?;

        match from_str::<BoxofficeResponse>(&xml_text) {
            Ok(parsed) => Ok(parsed),
            Err(e) => {
                eprintln!("XML parsing error: {}", e);
                eprintln!("Raw XML (first 500 chars): {}", &xml_text.chars().take(500).collect::<String>());
                Err(format!("Failed to parse XML response: {}", e))
            }
        }
    }
}
