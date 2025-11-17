use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct Piece {
    pub id: i32,
    pub composer_id: i32,
    pub title: String,
    pub title_en: Option<String>,
    pub description: Option<String>,
    pub opus_number: Option<String>,
    pub composition_year: Option<i32>,
    pub difficulty_level: Option<i32>,
    pub duration_minutes: Option<i32>,
    pub spotify_url: Option<String>,
    pub apple_music_url: Option<String>,
    pub youtube_music_url: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CreatePiece {
    pub composer_id: i32,
    pub title: String,
    pub title_en: Option<String>,
    pub description: Option<String>,
    pub opus_number: Option<String>,
    pub composition_year: Option<i32>,
    pub difficulty_level: Option<i32>,
    pub duration_minutes: Option<i32>,
    pub spotify_url: Option<String>,
    pub apple_music_url: Option<String>,
    pub youtube_music_url: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct UpdatePiece {
    pub title: Option<String>,
    pub title_en: Option<String>,
    pub description: Option<String>,
    pub opus_number: Option<String>,
    pub composition_year: Option<i32>,
    pub difficulty_level: Option<i32>,
    pub duration_minutes: Option<i32>,
    pub spotify_url: Option<String>,
    pub apple_music_url: Option<String>,
    pub youtube_music_url: Option<String>,
}
