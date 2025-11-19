use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct Recording {
    pub id: i32,
    pub artist_id: i32,
    pub title: String,
    pub year: String,
    pub release_date: Option<String>,
    pub label: Option<String>,
    pub cover_url: Option<String>,
    pub upc: Option<String>,
    pub apple_music_id: Option<String>,
    pub track_count: Option<i32>,
    pub is_single: Option<bool>,
    pub is_compilation: Option<bool>,
    pub genre_names: Option<String>,
    pub copyright: Option<String>,
    pub editorial_notes: Option<String>,
    pub artwork_width: Option<i32>,
    pub artwork_height: Option<i32>,
    pub spotify_url: Option<String>,
    pub apple_music_url: Option<String>,
    pub youtube_music_url: Option<String>,
    pub external_url: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CreateRecording {
    pub artist_id: i32,
    pub title: String,
    pub year: String,
    pub release_date: Option<String>,
    pub label: Option<String>,
    pub cover_url: Option<String>,
    pub upc: Option<String>,
    pub apple_music_id: Option<String>,
    pub track_count: Option<i32>,
    pub is_single: Option<bool>,
    pub is_compilation: Option<bool>,
    pub genre_names: Option<String>,
    pub copyright: Option<String>,
    pub editorial_notes: Option<String>,
    pub artwork_width: Option<i32>,
    pub artwork_height: Option<i32>,
    pub spotify_url: Option<String>,
    pub apple_music_url: Option<String>,
    pub youtube_music_url: Option<String>,
    pub external_url: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct UpdateRecording {
    pub title: Option<String>,
    pub year: Option<String>,
    pub release_date: Option<String>,
    pub label: Option<String>,
    pub cover_url: Option<String>,
    pub upc: Option<String>,
    pub apple_music_id: Option<String>,
    pub track_count: Option<i32>,
    pub is_single: Option<bool>,
    pub is_compilation: Option<bool>,
    pub genre_names: Option<String>,
    pub copyright: Option<String>,
    pub editorial_notes: Option<String>,
    pub artwork_width: Option<i32>,
    pub artwork_height: Option<i32>,
    pub spotify_url: Option<String>,
    pub apple_music_url: Option<String>,
    pub youtube_music_url: Option<String>,
    pub external_url: Option<String>,
}
