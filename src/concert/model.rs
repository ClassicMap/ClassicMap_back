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
    pub ticket_url: Option<String>,
    pub is_recommended: bool,
    pub status: String,
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
    pub ticket_url: Option<String>,
    pub is_recommended: bool,
    pub status: String,
}
