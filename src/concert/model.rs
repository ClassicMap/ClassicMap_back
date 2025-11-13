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
    pub concert_date: String,
    pub concert_time: Option<String>,
    pub price_info: Option<String>,
    pub poster_url: Option<String>,
    pub program: Option<String>,
    pub ticket_url: Option<String>,
    pub status: String,
    pub rating: Option<Decimal>,
    pub rating_count: Option<i32>,
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
    pub concert_date: String,
    pub concert_time: Option<String>,
    pub price_info: Option<String>,
    pub poster_url: Option<String>,
    pub program: Option<String>,
    pub ticket_url: Option<String>,
    pub status: String,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct UpdateConcert {
    pub title: Option<String>,
    pub composer_info: Option<String>,
    pub venue_id: Option<i32>,
    pub concert_date: Option<String>,
    pub concert_time: Option<String>,
    pub price_info: Option<String>,
    pub poster_url: Option<String>,
    pub program: Option<String>,
    pub ticket_url: Option<String>,
    pub status: Option<String>,
}
