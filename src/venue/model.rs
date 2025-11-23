use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use chrono::NaiveDateTime;

#[derive(Debug, Serialize, Deserialize, FromRow, Clone)]
pub struct Venue {
    pub id: i32,
    pub kopis_id: Option<String>,
    pub name: String,
    pub address: Option<String>,
    pub city: Option<String>,
    pub province: Option<String>,
    pub country: Option<String>,
    pub seats: Option<i32>,
    pub hall_count: Option<i32>,
    pub opening_year: Option<i16>,
    pub is_active: Option<bool>,
    pub data_source: Option<String>,
    pub created_at: Option<NaiveDateTime>,
    pub updated_at: Option<NaiveDateTime>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct CreateVenue {
    pub kopis_id: Option<String>,
    pub name: String,
    pub address: Option<String>,
    pub city: Option<String>,
    pub province: Option<String>,
    pub country: Option<String>,
    pub seats: Option<i32>,
    pub hall_count: Option<i32>,
    pub opening_year: Option<i16>,
    pub is_active: Option<bool>,
    pub data_source: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct UpdateVenue {
    pub kopis_id: Option<String>,
    pub name: Option<String>,
    pub address: Option<String>,
    pub city: Option<String>,
    pub province: Option<String>,
    pub country: Option<String>,
    pub seats: Option<i32>,
    pub hall_count: Option<i32>,
    pub opening_year: Option<i16>,
    pub is_active: Option<bool>,
    pub data_source: Option<String>,
}
