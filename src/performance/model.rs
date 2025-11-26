use chrono::NaiveDateTime;
use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct Performance {
    pub id: i32,
    pub piece_id: i32,
    pub artist_id: i32,
    pub video_platform: String,
    pub video_id: String,
    pub start_time: i32,
    pub end_time: i32,
    pub characteristic: Option<String>,
    pub recording_date: Option<NaiveDateTime>,
    pub view_count: i32,
    pub rating: f64,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CreatePerformance {
    pub piece_id: i32,
    pub artist_id: i32,
    pub video_platform: String,
    pub video_id: String,
    pub start_time: i32,
    pub end_time: i32,
    pub characteristic: Option<String>,
    pub recording_date: Option<NaiveDateTime>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct UpdatePerformance {
    pub video_platform: Option<String>,
    pub video_id: Option<String>,
    pub start_time: Option<i32>,
    pub end_time: Option<i32>,
    pub characteristic: Option<String>,
    pub recording_date: Option<NaiveDateTime>,
    pub view_count: Option<i32>,
    pub rating: Option<f64>,
}
