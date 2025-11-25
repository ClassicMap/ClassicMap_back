use rust_decimal::Decimal;
use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct Concert {
    pub id: i32,
    pub title: String,
    pub composer_info: Option<String>,
    pub venue_id: i32,

    // Date fields (changed from concert_date)
    pub start_date: String,
    pub end_date: Option<String>,
    pub concert_time: Option<String>,

    // Basic info
    pub price_info: Option<String>,
    pub poster_url: Option<String>,
    pub program: Option<String>,
    pub status: String,
    pub rating: Option<Decimal>,
    pub rating_count: Option<i32>,

    // KOPIS sync metadata
    pub kopis_id: Option<String>,
    pub kopis_updated_at: Option<String>,
    pub data_source: Option<String>,
    pub venue_kopis_id: Option<String>,

    // KOPIS basic info
    pub genre: Option<String>,
    pub area: Option<String>,
    pub facility_name: Option<String>,
    pub is_open_run: Option<bool>,

    // Cast and crew
    pub cast: Option<String>,
    pub crew: Option<String>,

    // Performance details
    pub runtime: Option<String>,
    pub age_restriction: Option<String>,
    pub synopsis: Option<String>,
    pub performance_schedule: Option<String>,

    // Production companies
    pub production_company: Option<String>,
    pub production_company_plan: Option<String>,
    pub production_company_agency: Option<String>,
    pub production_company_host: Option<String>,
    pub production_company_sponsor: Option<String>,

    // Classification flags
    pub is_visit: Option<bool>,
    pub is_child: Option<bool>,
    pub is_daehakro: Option<bool>,
    pub is_festival: Option<bool>,
}

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ConcertArtist {
    pub id: i32,
    pub concert_id: i32,
    pub artist_id: i32,
    pub artist_name: String,
    pub role: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ConcertWithArtists {
    #[serde(flatten)]
    pub concert: Concert,
    pub artists: Vec<ConcertArtist>,
}

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct UserConcertRating {
    pub id: i32,
    pub user_id: i32,
    pub concert_id: i32,
    pub rating: Decimal,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct SubmitRating {
    pub rating: f32,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CreateConcert {
    pub title: String,
    pub composer_info: Option<String>,
    pub venue_id: i32,
    pub start_date: String,
    pub end_date: Option<String>,
    pub concert_time: Option<String>,
    pub price_info: Option<String>,
    pub poster_url: Option<String>,
    pub program: Option<String>,
    pub status: String,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct UpdateConcert {
    pub title: Option<String>,
    pub composer_info: Option<String>,
    pub venue_id: Option<i32>,
    pub start_date: Option<String>,
    pub end_date: Option<String>,
    pub concert_time: Option<String>,
    pub price_info: Option<String>,
    pub poster_url: Option<String>,
    pub program: Option<String>,
    pub status: Option<String>,
}

// ============================================
// Related Models
// ============================================

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ConcertTicketVendor {
    pub id: i32,
    pub concert_id: i32,
    pub vendor_name: Option<String>,
    pub vendor_url: String,
    pub display_order: i32,
}

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ConcertImage {
    pub id: i32,
    pub concert_id: i32,
    pub image_url: String,
    pub image_type: String, // 'introduction', 'poster', 'other'
    pub display_order: i32,
}

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ConcertBoxofficeRanking {
    pub id: i32,
    pub concert_id: i32,
    pub kopis_genre_code: Option<String>,
    pub genre_name: Option<String>,
    pub kopis_area_code: Option<String>,
    pub area_name: Option<String>,
    pub ranking: i32,
    pub seat_scale: Option<String>,
    pub performance_count: Option<i32>,
    pub venue_name: Option<String>,
    pub seat_count: Option<i32>,
    pub sync_start_date: String,
    pub sync_end_date: String,
    pub synced_at: Option<String>,
    pub is_featured: Option<bool>,
}

// ============================================
// Response Models
// ============================================

// Simplified model for list views (performance optimized)
#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ConcertListItem {
    pub id: i32,
    pub title: String,
    pub venue_id: i32,
    pub start_date: String,
    pub end_date: Option<String>,
    pub concert_time: Option<String>,
    pub poster_url: Option<String>,
    pub status: String,
    pub rating: Option<Decimal>,
    pub rating_count: Option<i32>,
    pub genre: Option<String>,
    pub area: Option<String>,
    pub facility_name: Option<String>,
    pub is_open_run: Option<bool>,
    pub is_visit: Option<bool>,
    pub is_festival: Option<bool>,
}

// Full detail response with all related data
#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ConcertWithDetails {
    #[serde(flatten)]
    pub concert: Concert,
    pub artists: Vec<ConcertArtist>,
    pub ticket_vendors: Vec<ConcertTicketVendor>,
    pub images: Vec<ConcertImage>,
    pub boxoffice_ranking: Option<ConcertBoxofficeRanking>,
}
