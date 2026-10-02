use super::category::serialize_category;
use rust_decimal::Decimal;
use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct Artist {
    pub id: i32,
    pub name: String,
    pub english_name: String,
    #[serde(serialize_with = "serialize_category")]
    pub category: String,
    pub tier: String,
    /// DB는 DECIMAL이지만 응답은 숫자로 낸다.
    #[serde(with = "rust_decimal::serde::float_option")]
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
    /// 지금 사진(`image_url`)의 출처. 공개된 출처 기록이 있을 때만 낸다
    pub image_credit: Option<ImageCredit>,
}

/// 사진 출처. 위키미디어 사진은 작가와 라이선스를, 보도용 사진은 출처 이름을 밝힌다
#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ImageCredit {
    pub credit_line: Option<String>,
    pub author: Option<String>,
    pub license: Option<String>,
    pub license_url: Option<String>,
    pub source_url: String,
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

#[cfg(test)]
mod tests {
    use super::Artist;
    use rust_decimal::Decimal;
    use std::str::FromStr;

    fn artist(category: &str, rating: Option<Decimal>) -> Artist {
        Artist {
            id: 1,
            name: "임윤찬".to_string(),
            english_name: "Yunchan Lim".to_string(),
            category: category.to_string(),
            tier: "S".to_string(),
            rating,
            image_url: None,
            cover_image_url: None,
            birth_year: None,
            nationality: "대한민국".to_string(),
            bio: None,
            style: None,
            concert_count: 0,
            album_count: 0,
            top_award_id: None,
        }
    }

    #[test]
    fn response_uses_category_code_and_numeric_rating() {
        let value = serde_json::to_value(artist("피아노", Decimal::from_str("4.5").ok()))
            .expect("아티스트 직렬화");
        assert_eq!(value["category"], "pianist");
        assert_eq!(value["rating"], 4.5);

        let value = serde_json::to_value(artist("테오르보", None)).expect("아티스트 직렬화");
        assert_eq!(value["category"], "other");
        assert!(value["rating"].is_null());
    }
}
