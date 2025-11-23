use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use chrono::NaiveDateTime;

#[derive(Debug, Serialize, Deserialize, FromRow, Clone)]
pub struct Hall {
    pub id: i32,
    pub venue_id: i32,
    pub kopis_id: Option<String>,
    pub name: String,
    pub seats: Option<i32>,
    pub is_active: Option<bool>,
    pub created_at: Option<NaiveDateTime>,
    pub updated_at: Option<NaiveDateTime>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct CreateHall {
    pub venue_id: i32,
    pub kopis_id: Option<String>,
    pub name: String,
    pub seats: Option<i32>,
    pub is_active: Option<bool>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct UpdateHall {
    pub venue_id: Option<i32>,
    pub kopis_id: Option<String>,
    pub name: Option<String>,
    pub seats: Option<i32>,
    pub is_active: Option<bool>,
}
