use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
pub struct Venue {
    pub id: i32,
    pub name: String,
    pub address: Option<String>,
    pub city: Option<String>,
    pub country: Option<String>,
    pub capacity: Option<i32>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct CreateVenue {
    pub name: String,
    pub address: Option<String>,
    pub city: Option<String>,
    pub country: Option<String>,
    pub capacity: Option<i32>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct UpdateVenue {
    pub name: Option<String>,
    pub address: Option<String>,
    pub city: Option<String>,
    pub country: Option<String>,
    pub capacity: Option<i32>,
}
