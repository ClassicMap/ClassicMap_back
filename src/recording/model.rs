use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use sqlx::types::chrono::NaiveDate;
use sqlx::types::JsonValue;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct Recording {
    pub id: i32,
    pub artist_id: i32,
    pub title: String,
    pub year: String,
    #[serde(with = "optional_naive_date_format")]
    pub release_date: Option<NaiveDate>,
    pub label: Option<String>,
    pub cover_url: Option<String>,
    pub upc: Option<String>,
    pub apple_music_id: Option<String>,
    pub track_count: Option<i32>,
    pub is_single: Option<bool>,
    pub is_compilation: Option<bool>,
    pub genre_names: Option<JsonValue>,
    pub copyright: Option<String>,
    pub editorial_notes: Option<String>,
    pub artwork_width: Option<i32>,
    pub artwork_height: Option<i32>,
    pub spotify_url: Option<String>,
    pub apple_music_url: Option<String>,
    pub youtube_music_url: Option<String>,
    pub external_url: Option<String>,
}

// NaiveDate를 문자열로 직렬화/역직렬화하기 위한 커스텀 포맷
mod optional_naive_date_format {
    use serde::{self, Deserialize, Deserializer, Serializer};
    use sqlx::types::chrono::NaiveDate;

    const FORMAT: &str = "%Y-%m-%d";

    pub fn serialize<S>(date: &Option<NaiveDate>, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: Serializer,
    {
        match date {
            Some(d) => serializer.serialize_str(&d.format(FORMAT).to_string()),
            None => serializer.serialize_none(),
        }
    }

    pub fn deserialize<'de, D>(deserializer: D) -> Result<Option<NaiveDate>, D::Error>
    where
        D: Deserializer<'de>,
    {
        let s: Option<String> = Option::deserialize(deserializer)?;
        match s {
            Some(s) => NaiveDate::parse_from_str(&s, FORMAT)
                .map(Some)
                .map_err(serde::de::Error::custom),
            None => Ok(None),
        }
    }
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
