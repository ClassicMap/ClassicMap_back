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

// ============================================
// KOPIS API 공연 목록 응답
// ============================================
#[derive(Debug, Deserialize, Serialize)]
#[serde(rename = "dbs")]
pub struct ConcertListResponse {
    #[serde(rename = "db", default)]
    pub db: Vec<ConcertListItem>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct ConcertListItem {
    #[serde(rename = "mt20id")]
    pub performance_id: String,  // 공연ID (예: PF178134)

    #[serde(rename = "prfnm")]
    pub performance_name: String,  // 공연명

    #[serde(rename = "prfpdfrom")]
    pub start_date: String,  // 공연시작일 (예: "2021.08.21")

    #[serde(rename = "prfpdto")]
    pub end_date: String,  // 공연종료일 (예: "2024.09.29")

    #[serde(rename = "fcltynm")]
    pub facility_name: String,  // 공연시설명(공연장명)

    #[serde(rename = "poster")]
    pub poster: Option<String>,  // 포스터이미지경로

    #[serde(rename = "area")]
    pub area: Option<String>,  // 공연지역 (예: "서울특별시")

    #[serde(rename = "genrenm")]
    pub genre_name: String,  // 공연 장르명 (예: "뮤지컬", "클래식")

    #[serde(rename = "openrun")]
    pub open_run: Option<String>,  // 오픈런 (Y/N)

    #[serde(rename = "prfstate")]
    pub performance_state: String,  // 공연상태 (예: "공연중", "공연예정", "공연완료")
}

// ============================================
// KOPIS API 공연 상세 응답
// ============================================
#[derive(Debug, Deserialize, Serialize)]
#[serde(rename = "dbs")]
pub struct ConcertDetailResponse {
    #[serde(rename = "db")]
    pub db: ConcertDetail,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct ConcertDetail {
    #[serde(rename = "mt20id")]
    pub performance_id: String,  // 공연ID

    #[serde(rename = "prfnm")]
    pub performance_name: String,  // 공연명

    #[serde(rename = "prfpdfrom")]
    pub start_date: String,  // 공연시작일

    #[serde(rename = "prfpdto")]
    pub end_date: String,  // 공연종료일

    #[serde(rename = "fcltynm")]
    pub facility_name: String,  // 공연시설명

    #[serde(rename = "prfcast")]
    pub cast: Option<String>,  // 공연출연진

    #[serde(rename = "prfcrew")]
    pub crew: Option<String>,  // 공연제작진

    #[serde(rename = "prfruntime")]
    pub runtime: Option<String>,  // 공연 런타임 (예: "1시간 30분")

    #[serde(rename = "prfage")]
    pub age_restriction: Option<String>,  // 공연 관람 연령 (예: "만 12세 이상")

    #[serde(rename = "entrpsnm")]
    pub production_company: Option<String>,  // 기획제작사

    #[serde(rename = "entrpsnmP")]
    pub production_company_plan: Option<String>,  // 제작사

    #[serde(rename = "entrpsnmA")]
    pub production_company_agency: Option<String>,  // 기획사

    #[serde(rename = "entrpsnmH")]
    pub production_company_host: Option<String>,  // 주최

    #[serde(rename = "entrpsnmS")]
    pub production_company_sponsor: Option<String>,  // 주관

    #[serde(rename = "pcseguidance")]
    pub price_info: Option<String>,  // 티켓가격 (예: "전석 30,000원")

    #[serde(rename = "poster")]
    pub poster: Option<String>,  // 포스터이미지경로

    #[serde(rename = "sty")]
    pub synopsis: Option<String>,  // 줄거리

    #[serde(rename = "area")]
    pub area: Option<String>,  // 지역

    #[serde(rename = "genrenm")]
    pub genre_name: String,  // 장르

    #[serde(rename = "openrun")]
    pub open_run: Option<String>,  // 오픈런 (Y/N)

    #[serde(rename = "visit")]
    pub is_visit: Option<String>,  // 내한 (Y/N)

    #[serde(rename = "child")]
    pub is_child: Option<String>,  // 아동 (Y/N)

    #[serde(rename = "daehakro")]
    pub is_daehakro: Option<String>,  // 대학로 (Y/N)

    #[serde(rename = "festival")]
    pub is_festival: Option<String>,  // 축제 (Y/N)

    #[serde(rename = "updatedate")]
    pub update_date: Option<String>,  // 최종수정일 (예: "2019-07-25 10:03:14")

    #[serde(rename = "prfstate")]
    pub performance_state: String,  // 공연상태

    #[serde(rename = "styurls")]
    pub intro_images: Option<IntroImageList>,  // 소개이미지목록

    #[serde(rename = "mt10id")]
    pub facility_id: String,  // 공연시설ID (KOPIS 공연장 ID)

    #[serde(rename = "dtguidance")]
    pub performance_schedule: Option<String>,  // 공연시간

    #[serde(rename = "relates")]
    pub ticket_vendors: Option<TicketVendorList>,  // 예매처목록
}

#[derive(Debug, Deserialize, Serialize)]
pub struct IntroImageList {
    #[serde(rename = "styurl", default)]
    pub images: Vec<String>,  // 소개이미지 URL 목록
}

#[derive(Debug, Deserialize, Serialize)]
pub struct TicketVendorList {
    #[serde(rename = "relate", default)]
    pub vendors: Vec<TicketVendor>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct TicketVendor {
    #[serde(rename = "relatenm")]
    pub vendor_name: Option<String>,  // 예매처명

    #[serde(rename = "relateurl")]
    pub vendor_url: String,  // 예매처 URL
}

// ============================================
// KOPIS API 예매상황판 응답
// ============================================
#[derive(Debug, Deserialize, Serialize)]
#[serde(rename = "boxofs")]
pub struct BoxofficeResponse {
    #[serde(rename = "boxof", default)]
    pub boxof: Vec<BoxofficeItem>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct BoxofficeItem {
    #[serde(rename = "prfplcnm")]
    pub venue_name: String,  // 공연장

    #[serde(rename = "seatcnt")]
    pub seat_count: Option<i32>,  // 좌석수

    #[serde(rename = "rnum")]
    pub ranking: i32,  // 순위

    #[serde(rename = "poster")]
    pub poster: Option<String>,  // 포스터이미지

    #[serde(rename = "prfpd")]
    pub performance_period: String,  // 공연기간 (예: "2023.05.17~2023.06.25")

    #[serde(rename = "mt20id")]
    pub performance_id: String,  // 공연ID

    #[serde(rename = "prfnm")]
    pub performance_name: String,  // 공연명

    #[serde(rename = "cate")]
    pub category: String,  // 장르

    #[serde(rename = "prfdtcnt")]
    pub performance_count: Option<i32>,  // 상연횟수

    #[serde(rename = "area")]
    pub area: String,  // 지역
}

// ============================================
// Helper 함수들
// ============================================
use chrono::NaiveDate;

impl ConcertListItem {
    /// "2021.08.21" 형식을 NaiveDate로 파싱
    pub fn parse_start_date(&self) -> Option<NaiveDate> {
        parse_kopis_date(&self.start_date)
    }

    pub fn parse_end_date(&self) -> Option<NaiveDate> {
        parse_kopis_date(&self.end_date)
    }

    pub fn is_open_run(&self) -> bool {
        self.open_run.as_ref().map(|s| s == "Y").unwrap_or(false)
    }
}

impl ConcertDetail {
    pub fn parse_start_date(&self) -> Option<NaiveDate> {
        parse_kopis_date(&self.start_date)
    }

    pub fn parse_end_date(&self) -> Option<NaiveDate> {
        parse_kopis_date(&self.end_date)
    }

    pub fn is_open_run(&self) -> bool {
        self.open_run.as_ref().map(|s| s == "Y").unwrap_or(false)
    }

    pub fn is_visit(&self) -> bool {
        self.is_visit.as_ref().map(|s| s == "Y").unwrap_or(false)
    }

    pub fn is_child(&self) -> bool {
        self.is_child.as_ref().map(|s| s == "Y").unwrap_or(false)
    }

    pub fn is_daehakro(&self) -> bool {
        self.is_daehakro.as_ref().map(|s| s == "Y").unwrap_or(false)
    }

    pub fn is_festival(&self) -> bool {
        self.is_festival.as_ref().map(|s| s == "Y").unwrap_or(false)
    }

    /// KOPIS 공연상태를 DB ENUM으로 변환
    pub fn parse_status(&self) -> String {
        match self.performance_state.as_str() {
            "공연예정" => "upcoming".to_string(),
            "공연중" => "ongoing".to_string(),
            "공연완료" => "completed".to_string(),
            _ => "upcoming".to_string(),
        }
    }
}

/// KOPIS 날짜 형식 "2021.08.21" → NaiveDate 변환
fn parse_kopis_date(date_str: &str) -> Option<NaiveDate> {
    let parts: Vec<&str> = date_str.split('.').collect();
    if parts.len() == 3 {
        let year = parts[0].parse::<i32>().ok()?;
        let month = parts[1].parse::<u32>().ok()?;
        let day = parts[2].parse::<u32>().ok()?;
        NaiveDate::from_ymd_opt(year, month, day)
    } else {
        None
    }
}
