use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
pub struct Concert {
    pub id: i32,
    pub title: String,
    pub composer_info: Option<String>,
    pub venue_id: i32,
    pub concert_date: String,
    pub concert_time: Option<String>,
    pub price_info: Option<String>,
    pub is_recommended: bool,
    pub status: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct CreateConcert {
    pub title: String,
    pub composer_info: Option<String>,
    pub venue_id: i32,
    pub concert_date: String,
    pub concert_time: Option<String>,
    pub price_info: Option<String>,
    pub is_recommended: bool,
    pub status: String,
}
