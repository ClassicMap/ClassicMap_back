use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
pub struct Piece {
    pub id: i32,
    pub composer_id: i32,
    pub title: String,
    pub description: Option<String>,
    pub opus_number: Option<String>,
    pub composition_year: Option<i32>,
    pub difficulty_level: Option<i32>,
    pub duration_minutes: Option<i32>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct CreatePiece {
    pub composer_id: i32,
    pub title: String,
    pub description: Option<String>,
    pub opus_number: Option<String>,
    pub composition_year: Option<i32>,
    pub difficulty_level: Option<i32>,
    pub duration_minutes: Option<i32>,
}
