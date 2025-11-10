use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct Recording {
    pub id: i32,
    pub artist_id: i32,
    pub title: String,
    pub year: String,
    pub label: Option<String>,
    pub cover_url: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CreateRecording {
    pub artist_id: i32,
    pub title: String,
    pub year: String,
    pub label: Option<String>,
    pub cover_url: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct UpdateRecording {
    pub title: Option<String>,
    pub year: Option<String>,
    pub label: Option<String>,
    pub cover_url: Option<String>,
}
