use serde::{Deserialize, Serialize};
use serde::ser::SerializeSeq;
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct Composer {
    pub id: i32,
    pub name: String,
    pub full_name: String,
    pub english_name: String,
    pub period: String,
    pub tier: Option<String>,
    pub birth_year: i32,
    pub death_year: Option<i32>,
    pub nationality: String,
    pub avatar_url: Option<String>,
    pub cover_image_url: Option<String>,
    pub bio: Option<String>,
    pub style: Option<String>,
    pub influence: Option<String>,
    pub piece_count: Option<i64>,
}

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ComposerWithMajorPieces {
    pub id: i32,
    pub name: String,
    pub full_name: String,
    pub english_name: String,
    pub period: String,
    pub tier: Option<String>,
    pub birth_year: i32,
    pub death_year: Option<i32>,
    pub nationality: String,
    pub avatar_url: Option<String>,
    pub cover_image_url: Option<String>,
    pub bio: Option<String>,
    pub style: Option<String>,
    pub influence: Option<String>,
    pub major_pieces: Option<String>,
}

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ComposerWithPerformance {
    pub composer_id: i32,
    pub composer_name: String,
    pub composer_avatar_url: Option<String>,
    pub piece_id: i32,
    pub piece_title: String,
    pub performance_count: i64,
    #[serde(serialize_with = "serialize_comma_separated")]
    pub artist_names: Option<String>,
}

fn serialize_comma_separated<S>(value: &Option<String>, serializer: S) -> Result<S::Ok, S::Error>
where
    S: serde::Serializer,
{
    match value {
        Some(s) => {
            let names: Vec<&str> = s.split(',').collect();
            names.serialize(serializer)
        }
        None => serializer.serialize_seq(Some(0))?.end(),
    }
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CreateComposer {
    pub name: String,
    pub full_name: String,
    pub english_name: String,
    pub period: String,
    pub tier: Option<String>,
    pub birth_year: i32,
    pub death_year: Option<i32>,
    pub nationality: String,
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
    pub tier: Option<String>,
    pub birth_year: Option<i32>,
    pub death_year: Option<i32>,
    pub nationality: Option<String>,
    pub avatar_url: Option<String>,
    pub cover_image_url: Option<String>,
    pub bio: Option<String>,
    pub style: Option<String>,
    pub influence: Option<String>,
}