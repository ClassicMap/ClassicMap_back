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
    #[serde(rename = "posterUrl")]
    pub poster_url: Option<String>,
    pub is_recommended: bool,
    pub status: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct CreateConcert {
    pub title: String,
    #[serde(alias = "composerInfo")]
    pub composer_info: Option<String>,
    #[serde(alias = "venueId")]
    pub venue_id: i32,
    #[serde(alias = "concertDate")]
    pub concert_date: String,
    #[serde(alias = "concertTime")]
    pub concert_time: Option<String>,
    #[serde(alias = "priceInfo")]
    pub price_info: Option<String>,
    #[serde(alias = "posterUrl")]
    pub poster_url: Option<String>,
    #[serde(alias = "isRecommended")]
    pub is_recommended: bool,
    pub status: String,
}
