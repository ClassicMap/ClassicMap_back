use rust_decimal::Decimal;
use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct Artist {
    pub id: i32,
    pub name: String,
    pub english_name: String,
    pub category: String,
    pub tier: String,
    pub rating: Option<Decimal>,
    pub image_url: Option<String>,
    pub cover_image_url: Option<String>,
    pub birth_year: Option<String>,
    pub nationality: String,
    pub bio: Option<String>,
    pub style: Option<String>,
    pub concert_count: i32,
    pub album_count: i32,
    pub top_award_id: Option<i32>,
    pub specialties: Option<String>,
}

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ArtistAward {
    pub id: i32,
    pub artist_id: i32,
    pub year: String,
    pub award_name: String,
    pub award_type: Option<String>,
    pub organization: Option<String>,
    pub category: Option<String>,
    pub ranking: Option<String>,
    pub source: Option<String>,
    pub notes: Option<String>,
    pub display_order: i32,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ArtistWithAwards {
    #[serde(flatten)]
    pub artist: Artist,
    pub awards: Vec<ArtistAward>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CreateArtist {
    pub name: String,
    pub english_name: String,
    pub category: String,
    pub tier: String,
    pub nationality: String,
    pub rating: Option<Decimal>,
    pub image_url: Option<String>,
    pub cover_image_url: Option<String>,
    pub birth_year: Option<String>,
    pub bio: Option<String>,
    pub style: Option<String>,
    pub concert_count: Option<i32>,
    pub album_count: Option<i32>,
    pub top_award_id: Option<i32>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct UpdateArtist {
    pub name: Option<String>,
    pub english_name: Option<String>,
    pub category: Option<String>,
    pub tier: Option<String>,
    pub nationality: Option<String>,
    pub rating: Option<Decimal>,
    pub image_url: Option<String>,
    pub cover_image_url: Option<String>,
    pub birth_year: Option<String>,
    pub bio: Option<String>,
    pub style: Option<String>,
    pub concert_count: Option<i32>,
    pub album_count: Option<i32>,
    pub top_award_id: Option<i32>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CreateArtistAward {
    pub year: String,
    pub award_name: String,
    pub award_type: Option<String>,
    pub organization: Option<String>,
    pub category: Option<String>,
    pub ranking: Option<String>,
    pub source: Option<String>,
    pub notes: Option<String>,
    pub display_order: Option<i32>,
}
