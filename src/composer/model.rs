use serde::ser::SerializeSeq;
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
    pub tier: Option<String>,
    pub birth_year: i32,
    pub death_year: Option<i32>,
    pub nationality: String,
    pub avatar_url: Option<String>,
    pub cover_image_url: Option<String>,
    pub bio: Option<String>,
    pub style: Option<String>,
    pub influence: Option<String>,
    /// 영어판 글(없으면 null, 화면은 한국어를 쓴다)
    #[sqlx(default)]
    pub bio_en: Option<String>,
    #[sqlx(default)]
    pub style_en: Option<String>,
    #[sqlx(default)]
    pub influence_en: Option<String>,
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
    /// 영어판 글(없으면 null, 화면은 한국어를 쓴다)
    #[sqlx(default)]
    pub bio_en: Option<String>,
    #[sqlx(default)]
    pub style_en: Option<String>,
    #[sqlx(default)]
    pub influence_en: Option<String>,
    pub major_pieces: Option<String>,
    /// 목록(`Composer.piece_count`)과 같은 기준: 이 작곡가의 최상위 작품 수.
    /// 다른 작품(묶음)의 part 로 이어진 작품은 묶음 안에서 보이므로 세지 않는다.
    pub piece_count: Option<i64>,
    /// 화면 머리 배너용 가로 그림. 공개된 배너 기록이 있을 때만 낸다
    #[sqlx(skip)]
    pub banner: Option<crate::artist::model::ArtistBanner>,
    /// 지금 얼굴 그림(avatar_url)과 같은 파일의 공개된 출처 기록. 배너가 없을 때 화면이 이 그림을 쓴다
    #[sqlx(skip)]
    pub avatar_credit: Option<crate::artist::model::ImageCredit>,
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
