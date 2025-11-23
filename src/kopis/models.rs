use serde::{Deserialize, Serialize};

// KOPIS API 공연시설 목록 응답
#[derive(Debug, Deserialize, Serialize)]
#[serde(rename = "dbs")]
pub struct VenueListResponse {
    #[serde(rename = "db", default)]
    pub db: Vec<VenueListItem>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct VenueListItem {
    #[serde(rename = "fcltynm")]
    pub facility_name: String,  // 공연시설명

    #[serde(rename = "mt10id")]
    pub facility_id: String,  // 공연시설ID (예: FC000517)

    #[serde(rename = "mt13cnt")]
    pub hall_count: Option<i32>,  // 공연장 수

    #[serde(rename = "fcltychartr")]
    pub facility_type: Option<String>,  // 시설특성 (문예회관 등)

    #[serde(rename = "sidonm")]
    pub province: Option<String>,  // 지역(시도)

    #[serde(rename = "gugunnm")]
    pub city: Option<String>,  // 지역(구군)

    #[serde(rename = "opende")]
    pub opening_year: Option<String>,  // 개관연도
}

// KOPIS API 공연시설 상세 응답
#[derive(Debug, Deserialize, Serialize)]
#[serde(rename = "dbs")]
pub struct VenueDetailResponse {
    #[serde(rename = "db")]
    pub db: VenueDetail,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct VenueDetail {
    #[serde(rename = "fcltynm")]
    pub facility_name: String,  // 공연시설명

    #[serde(rename = "mt10id")]
    pub facility_id: String,  // 공연시설ID

    #[serde(rename = "mt13cnt")]
    pub hall_count: Option<i32>,  // 공연장 수

    #[serde(rename = "fcltychartr")]
    pub facility_type: Option<String>,  // 시설특성

    #[serde(rename = "opende")]
    pub opening_year: Option<String>,  // 개관연도

    #[serde(rename = "seatscale")]
    pub total_seats: Option<String>,  // 총 좌석 수 (문자열로 올 수 있음, 예: "41356" 또는 "41,356")

    #[serde(rename = "telno")]
    pub phone: Option<String>,  // 전화번호

    #[serde(rename = "relateurl")]
    pub website: Option<String>,  // 홈페이지

    #[serde(rename = "adres")]
    pub address: Option<String>,  // 주소

    #[serde(rename = "la")]
    pub latitude: Option<String>,  // 위도

    #[serde(rename = "lo")]
    pub longitude: Option<String>,  // 경도

    #[serde(rename = "mt13s")]
    pub halls: Option<HallList>,  // 공연장 목록
}

#[derive(Debug, Deserialize, Serialize)]
pub struct HallList {
    #[serde(rename = "mt13", default)]
    pub halls: Vec<HallDetail>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct HallDetail {
    #[serde(rename = "prfplcnm")]
    pub hall_name: String,  // 공연장명

    #[serde(rename = "mt13id")]
    pub hall_id: String,  // 공연장ID (예: FC001247-01)

    #[serde(rename = "seatscale")]
    pub seats: Option<String>,  // 좌석규모 (예: "15,000")
}

// Helper 함수들
impl VenueDetail {
    pub fn parse_seats(&self) -> Option<i32> {
        self.total_seats.as_ref().and_then(|s| {
            s.replace(",", "").parse::<i32>().ok()
        })
    }

    pub fn parse_opening_year(&self) -> Option<i16> {
        self.opening_year.as_ref().and_then(|y| {
            y.parse::<i16>().ok()
        })
    }
}

impl VenueListItem {
    pub fn parse_opening_year(&self) -> Option<i16> {
        self.opening_year.as_ref().and_then(|y| {
            y.parse::<i16>().ok()
        })
    }
}

impl HallDetail {
    pub fn parse_seats(&self) -> Option<i32> {
        self.seats.as_ref().and_then(|s| {
            s.replace(",", "").parse::<i32>().ok()
        })
    }
}
