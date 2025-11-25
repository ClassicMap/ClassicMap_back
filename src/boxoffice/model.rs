use rust_decimal::Decimal;
use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct BoxofficeConcert {
    pub id: i32,
    pub concert_id: i32,
    pub ranking: i32,
    pub genre_name: Option<String>,
    pub area_name: Option<String>,
    pub sync_start_date: String,
    pub sync_end_date: String,

    // Concert info
    pub title: String,
    pub poster_url: Option<String>,
    pub start_date: String,
    pub end_date: Option<String>,
    pub concert_time: Option<String>,
    pub facility_name: Option<String>,
    pub status: String,
    pub rating: Option<Decimal>,
    pub rating_count: Option<i32>,
    pub genre: Option<String>,
    pub area: Option<String>,
}
