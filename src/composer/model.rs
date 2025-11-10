use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct Composer {
    pub id: i32,
    pub name: String,
    pub full_name: String,
    pub english_name: String,
    pub period: String,
    pub birth_year: i32,
    pub death_year: i32,
    pub nationality: String,
    pub image_url: Option<String>,
    pub avatar_url: Option<String>,
    pub cover_image_url: Option<String>,
    pub bio: Option<String>,
    pub style: Option<String>,
    pub influence: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CreateComposer {
    pub name: String,
    pub full_name: String,
    pub english_name: String,
    pub period: String,
    pub birth_year: i32,
    pub death_year: i32,
    pub nationality: String,
    pub image_url: Option<String>,
    pub avatar_url: Option<String>,
    pub cover_image_url: Option<String>,
    pub bio: Option<String>,
    pub style: Option<String>,
    pub influence: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct UpdateComposer {
    pub name: Option<String>,
    pub full_name: Option<String>,
    pub english_name: Option<String>,
    pub period: Option<String>,
    pub birth_year: Option<i32>,
    pub death_year: Option<i32>,
    pub nationality: Option<String>,
    pub image_url: Option<String>,
    pub avatar_url: Option<String>,
    pub cover_image_url: Option<String>,
    pub bio: Option<String>,
    pub style: Option<String>,
    pub influence: Option<String>,
}
