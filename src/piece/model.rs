use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct Piece {
    pub id: i32,
    pub composer_id: i32,
    pub title: String,
    pub title_en: Option<String>,
    #[serde(rename = "type")]
    pub r#type: String,
    pub description: Option<String>,
    pub opus_number: Option<String>,
    pub composition_year: Option<i32>,
    pub difficulty_level: Option<i32>,
    pub duration_minutes: Option<i32>,
    pub spotify_url: Option<String>,
    pub apple_music_url: Option<String>,
    pub youtube_music_url: Option<String>,
}

/// 작품 검색 결과. 목록에 작곡가를 함께 보여줄 수 있게 이름을 싣는다.
#[derive(Debug, Serialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct PieceSearchResult {
    #[serde(flatten)]
    #[sqlx(flatten)]
    pub piece: Piece,
    pub composer_name: String,
    /// 검색 결과 작품 행에 작곡가 초상을 얼굴로 쓴다
    pub composer_avatar_url: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CreatePiece {
    pub composer_id: i32,
    pub title: String,
    pub title_en: Option<String>,
    #[serde(rename = "type")]
    pub r#type: String,
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
    #[serde(rename = "type")]
    pub r#type: Option<String>,
    pub description: Option<String>,
    pub opus_number: Option<String>,
    pub composition_year: Option<i32>,
    pub difficulty_level: Option<i32>,
    pub duration_minutes: Option<i32>,
    pub spotify_url: Option<String>,
    pub apple_music_url: Option<String>,
    pub youtube_music_url: Option<String>,
}
