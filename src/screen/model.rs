use serde::{Deserialize, Serialize};
use sqlx::FromRow;

/// 모아 보는 화면·검색 결과의 작품 한 줄
#[derive(Debug, Clone, Serialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ScreenTitleSummary {
    pub id: i32,
    pub slug: String,
    pub kind: String,
    pub title_ko: String,
    pub title_original: Option<String>,
    pub release_year: Option<u16>,
    pub country_code: Option<String>,
    pub credit_line: Option<String>,
    /// TMDB 이미지 파일 경로. 주소는 앱이 크기를 골라 붙인다
    pub poster_path: Option<String>,
    pub backdrop_path: Option<String>,
    /// 포스터 주소(KMDb). 화면에 출처(poster_credit)를 같이 적는다
    pub poster_url: Option<String>,
    pub poster_credit: Option<String>,
    /// 공개된 큐 수
    pub cue_count: i64,
    /// 포스터·스틸이 없을 때 쓸 대표 그림. 권리자 공식 YouTube 클립 id.
    /// 작품에 정한 예고편이 먼저, 없으면 스포일러가 아닌 큐의 클립
    pub cover_video_id: Option<String>,
    /// 대표 그림 클립을 올린 채널. 화면에 출처로 적는다
    pub cover_channel: Option<String>,
    /// 대표 그림 클립의 가장 높은 jpg·webp 썸네일 화질(`OfficialClip` 과 같음)
    pub cover_thumb_jpg: Option<String>,
    pub cover_thumb_webp: Option<String>,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ScreenTitlePage {
    pub items: Vec<ScreenTitleSummary>,
    pub has_more: bool,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct OfficialClip {
    pub video_id: String,
    pub start_sec: u32,
    pub channel: String,
    pub title: String,
    /// 있는 가장 높은 jpg 썸네일 화질. 모르면 빠진다
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub thumb_jpg: Option<String>,
    /// 있는 가장 높은 webp 썸네일 화질. webp 가 없거나 모르면 빠진다
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub thumb_webp: Option<String>,
    /// 그 곡이 나오는 장면을 보여 주는 썸네일(default·1·2·3). 확인한 클립에만 있다
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub scene_frame: Option<String>,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CueEvidence {
    pub grade: String,
    pub kind: String,
    pub url: String,
    pub note: String,
}

#[derive(Debug, Clone, Default, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct StreamingLinks {
    pub apple_music_url: Option<String>,
    pub spotify_url: Option<String>,
    pub youtube_music_url: Option<String>,
}

/// 이 큐의 곡을 어떻게 들을 수 있는지.
///
/// `sector` 는 영화에 나온 대목과 같은 비교 구간이 공개돼 있다. `piece` 는 같은 곡의 다른
/// 비교 구간만 있다. `external` 은 비교는 없고 스트리밍 링크만 있다. `none` 은 들을 곳이 없다.
#[derive(Debug, Clone, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct CueListen {
    pub kind: &'static str,
    pub sector_id: Option<i32>,
    pub ready_performance_count: Option<i64>,
    pub links: Option<StreamingLinks>,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ScreenCue {
    pub id: u64,
    pub order: u16,
    pub episode_label: Option<String>,
    pub composer_id: Option<i32>,
    pub composer_name: String,
    pub piece_id: Option<i32>,
    pub work_title: String,
    pub part_label: Option<String>,
    pub usage: String,
    pub arranged: bool,
    pub approx_at_sec: Option<u32>,
    pub scene_note: String,
    pub spoiler: bool,
    pub official_clip: Option<OfficialClip>,
    pub evidence: Vec<CueEvidence>,
    pub still_path: Option<String>,
    pub listen: CueListen,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ScreenTitleDetail {
    #[serde(flatten)]
    pub title: ScreenTitleSummary,
    pub cues: Vec<ScreenCue>,
}

/// 비교 화면 '이 곡이 나온 작품' 띠의 한 칸
#[derive(Debug, Clone, Serialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct PieceScreenCue {
    pub cue_id: u64,
    pub title_id: i32,
    pub title_ko: String,
    pub kind: String,
    pub release_year: Option<u16>,
    pub poster_path: Option<String>,
    pub poster_url: Option<String>,
    pub poster_credit: Option<String>,
    pub part_label: Option<String>,
    pub episode_label: Option<String>,
    /// 영화에 나온 대목과 같은 비교 구간. 다른 대목이면 null
    pub sector_id: Option<i32>,
    pub usage: String,
    /// 작품의 대표 장면 클립 id
    pub cover_video_id: Option<String>,
    pub cover_thumb_jpg: Option<String>,
    pub cover_thumb_webp: Option<String>,
}

/// 모아 보는 화면 '그 대목 바로 듣기'. 비교 구간이 그대로 공개된 큐만
#[derive(Debug, Clone, Serialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct FeaturedScreenCue {
    pub cue_id: u64,
    pub title_id: i32,
    pub title_ko: String,
    pub kind: String,
    pub poster_path: Option<String>,
    pub poster_url: Option<String>,
    pub poster_credit: Option<String>,
    pub composer_id: i32,
    pub composer_name: String,
    pub piece_id: i32,
    pub work_title: String,
    pub part_label: Option<String>,
    pub sector_id: i32,
    /// 작품의 대표 장면 클립 id
    pub cover_video_id: Option<String>,
    pub cover_thumb_jpg: Option<String>,
    pub cover_thumb_webp: Option<String>,
}

/// '곡으로 찾기' 한 줄. 영화에 나온 곡 하나와 그 곡이 나온 작품들
#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ScreenWork {
    pub composer_id: Option<i32>,
    pub composer_name: String,
    /// 카탈로그 작품이면 비교로 바로 갈 수 있다. 카탈로그 밖 곡이면 null
    pub piece_id: Option<i32>,
    pub work_title: String,
    /// 이 곡이 나온 작품. 모아 보는 화면 순서대로, 작품마다 한 번
    pub titles: Vec<ScreenWorkTitle>,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ScreenWorkTitle {
    pub title_id: i32,
    pub title_ko: String,
    pub kind: String,
    pub release_year: Option<u16>,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ScreenWorkPage {
    pub items: Vec<ScreenWork>,
    pub has_more: bool,
}

/// 관리자 장면 스틸 고르기
#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ScreenStillCandidates {
    pub title_id: i32,
    pub backdrop_path: Option<String>,
    pub still_paths: Vec<String>,
    pub cues: Vec<ScreenCueStill>,
}

#[derive(Debug, Clone, Serialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ScreenCueStill {
    pub id: u64,
    pub work_title: String,
    pub part_label: Option<String>,
    pub still_path: Option<String>,
}

#[derive(Debug, Clone, Deserialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct ScreenCueStillInput {
    pub still_path: Option<String>,
}
