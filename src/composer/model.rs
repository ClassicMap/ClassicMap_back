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
pub struct CreateComposer {
    pub name: String,
    #[serde(alias = "fullName")]
    pub full_name: String,
    #[serde(alias = "englishName")]
    pub english_name: String,
    pub period: String,
    #[serde(alias = "birthYear")]
    pub birth_year: i32,
    #[serde(alias = "deathYear")]
    pub death_year: i32,
    pub nationality: String,
    #[serde(alias = "imageUrl")]
    pub image_url: Option<String>,
    #[serde(alias = "avatarUrl")]
    pub avatar_url: Option<String>,
    #[serde(alias = "coverImageUrl")]
    pub cover_image_url: Option<String>,
    pub bio: Option<String>,
    pub style: Option<String>,
    pub influence: Option<String>,
}
