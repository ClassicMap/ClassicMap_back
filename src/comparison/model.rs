use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use std::{fmt, str::FromStr};

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub enum EditorialStatus {
    Discovered,
    IdentifiersMatched,
    FactsVerified,
    EditorReviewed,
    Published,
    ReviewRequired,
}

impl EditorialStatus {
    pub const fn as_str(self) -> &'static str {
        match self {
            Self::Discovered => "DISCOVERED",
            Self::IdentifiersMatched => "IDENTIFIERS_MATCHED",
            Self::FactsVerified => "FACTS_VERIFIED",
            Self::EditorReviewed => "EDITOR_REVIEWED",
            Self::Published => "PUBLISHED",
            Self::ReviewRequired => "REVIEW_REQUIRED",
        }
    }
}

impl fmt::Display for EditorialStatus {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        formatter.write_str(self.as_str())
    }
}

impl FromStr for EditorialStatus {
    type Err = String;

    fn from_str(value: &str) -> Result<Self, Self::Err> {
        match value {
            "DISCOVERED" => Ok(Self::Discovered),
            "IDENTIFIERS_MATCHED" => Ok(Self::IdentifiersMatched),
            "FACTS_VERIFIED" => Ok(Self::FactsVerified),
            "EDITOR_REVIEWED" => Ok(Self::EditorReviewed),
            "PUBLISHED" => Ok(Self::Published),
            "REVIEW_REQUIRED" => Ok(Self::ReviewRequired),
            _ => Err(format!("지원하지 않는 editorial status: {value}")),
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub enum ClipStatus {
    Pending,
    Queued,
    Generating,
    Ready,
    Published,
    Failed,
    Retired,
}

impl ClipStatus {
    pub const fn as_str(self) -> &'static str {
        match self {
            Self::Pending => "PENDING",
            Self::Queued => "QUEUED",
            Self::Generating => "GENERATING",
            Self::Ready => "READY",
            Self::Published => "PUBLISHED",
            Self::Failed => "FAILED",
            Self::Retired => "RETIRED",
        }
    }

    pub const fn can_be_published(self) -> bool {
        matches!(self, Self::Ready | Self::Published)
    }
}

impl fmt::Display for ClipStatus {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        formatter.write_str(self.as_str())
    }
}

impl FromStr for ClipStatus {
    type Err = String;

    fn from_str(value: &str) -> Result<Self, Self::Err> {
        match value {
            "PENDING" => Ok(Self::Pending),
            "QUEUED" => Ok(Self::Queued),
            "GENERATING" => Ok(Self::Generating),
            "READY" => Ok(Self::Ready),
            "PUBLISHED" => Ok(Self::Published),
            "FAILED" => Ok(Self::Failed),
            "RETIRED" => Ok(Self::Retired),
            _ => Err(format!("지원하지 않는 clip status: {value}")),
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub enum PerformancePublishStatus {
    Draft,
    Ready,
    Published,
    Retired,
}

impl PerformancePublishStatus {
    pub const fn as_str(self) -> &'static str {
        match self {
            Self::Draft => "DRAFT",
            Self::Ready => "READY",
            Self::Published => "PUBLISHED",
            Self::Retired => "RETIRED",
        }
    }
}

impl fmt::Display for PerformancePublishStatus {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        formatter.write_str(self.as_str())
    }
}

impl FromStr for PerformancePublishStatus {
    type Err = String;

    fn from_str(value: &str) -> Result<Self, Self::Err> {
        match value {
            "DRAFT" => Ok(Self::Draft),
            "READY" => Ok(Self::Ready),
            "PUBLISHED" => Ok(Self::Published),
            "RETIRED" => Ok(Self::Retired),
            _ => Err(format!("지원하지 않는 performance publish status: {value}")),
        }
    }
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ComparisonCredit {
    pub artist_id: i32,
    pub artist_name: String,
    /// 연주자 사진. 카탈로그 미리보기(작품당 4명)에 없는 연주자도 얼굴을 보여 주려고 싣는다
    pub image_url: Option<String>,
    pub role: String,
    pub is_primary: bool,
    pub display_order: i32,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ComparisonPerformance {
    pub id: i32,
    pub source_id: u64,
    pub sector_id: i32,
    pub piece_id: i32,
    pub piece_title: String,
    pub composer_id: i32,
    pub composer_name: String,
    pub sector_name: String,
    pub start_ms: u32,
    pub end_ms: u32,
    pub clip_status: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub clip_url: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub video_id: Option<String>,
    pub credits: Vec<ComparisonCredit>,
    /// 확정된 연주 노트. 없으면 null
    pub note: Option<PerformanceListeningNote>,
}

/// 들을 곳. `offset_ms` 는 클립 처음부터 잰 시점이다
#[derive(Debug, Clone, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ListeningMoment {
    pub offset_ms: u32,
    pub label: String,
}

/// 연주 노트: 이 연주를 부르는 제목, 두세 문장, 들을 곳, 사실 태그
#[derive(Debug, Clone, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct PerformanceListeningNote {
    pub headline: String,
    pub body: String,
    pub moments: Vec<ListeningMoment>,
    pub facts: Vec<String>,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct FeaturedPairMoment {
    pub performance_id: i32,
    pub offset_ms: u32,
    pub label: String,
}

/// 구간의 추천 비교 한 쌍. 두 연주 모두 이 구간의 공개 연주일 때만 나간다
#[derive(Debug, Clone, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct FeaturedPair {
    pub performance_ids: [i32; 2],
    pub title: String,
    pub note: String,
    pub moments: Vec<FeaturedPairMoment>,
}

/// DB 에 적힌 들을 곳. `at_ms` 는 원본 영상 시각이다
#[derive(Debug, Clone, Deserialize)]
#[serde(rename_all = "camelCase")]
pub(crate) struct StoredMoment {
    pub at_ms: u32,
    pub label: String,
    #[serde(default)]
    pub performance_id: Option<i32>,
}

/// 원본 영상 시각을 클립 처음부터의 오프셋으로 바꾼다. 클립 밖이면 버린다
/// (클립을 다시 자르면 들을 곳이 구간을 벗어날 수 있다)
pub(crate) fn clip_offset(at_ms: u32, start_ms: u32, end_ms: u32) -> Option<u32> {
    (start_ms..=end_ms)
        .contains(&at_ms)
        .then(|| at_ms - start_ms)
}

/// JSON 배열 열을 읽는다. 비었으면 빈 목록, 모양이 틀리면 `Err`
pub(crate) fn parse_json_list<T: serde::de::DeserializeOwned>(
    raw: Option<&str>,
) -> Result<Vec<T>, serde_json::Error> {
    match raw {
        Some(text) if !text.trim().is_empty() => serde_json::from_str(text),
        _ => Ok(Vec::new()),
    }
}

/// 연주 노트의 들을 곳을 그 연주의 클립 기준으로 바꾼다
pub(crate) fn note_moments(
    stored: Vec<StoredMoment>,
    start_ms: u32,
    end_ms: u32,
) -> Vec<ListeningMoment> {
    stored
        .into_iter()
        .filter_map(|moment| {
            clip_offset(moment.at_ms, start_ms, end_ms).map(|offset_ms| ListeningMoment {
                offset_ms,
                label: moment.label,
            })
        })
        .collect()
}

/// 추천 비교의 들을 곳을 각 연주의 클립 기준으로 바꾼다. 두 연주가 아닌 것은 버린다
pub(crate) fn pair_moments(
    stored: Vec<StoredMoment>,
    bounds: [(i32, u32, u32); 2],
) -> Vec<FeaturedPairMoment> {
    stored
        .into_iter()
        .filter_map(|moment| {
            let performance_id = moment.performance_id?;
            let (_, start_ms, end_ms) = bounds.iter().find(|(id, _, _)| *id == performance_id)?;
            clip_offset(moment.at_ms, *start_ms, *end_ms).map(|offset_ms| FeaturedPairMoment {
                performance_id,
                offset_ms,
                label: moment.label,
            })
        })
        .collect()
}

/// 곡 비교 화면에 공개되는 섹터. 두 카운트는 같은 공개 연주 집합에서 센다.
#[derive(Debug, Clone, Serialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ComparisonSector {
    pub id: i32,
    pub piece_id: i32,
    pub sector_name: String,
    pub sector_name_en: Option<String>,
    /// 구간의 갈래. `WHOLE_WORK` · `MOVEMENT` · `EXCERPT` 는 같은 대목의 다른 해석을
    /// 견주는 구간이고, `ARRANGEMENTS` 는 편성이 서로 다른 편곡을 나란히 듣는 구간이다.
    /// 뒤엣것은 정렬 비용 임계를 적용하지 않으므로 화면이 갈래를 표시해야 한다.
    pub sector_type: Option<String>,
    pub description: Option<String>,
    pub display_order: Option<i32>,
    pub measure_start: Option<String>,
    pub measure_end: Option<String>,
    pub ready_performance_count: i64,
    pub primary_artist_count: i64,
    /// 확정된 추천 비교. 없으면 null
    #[sqlx(skip)]
    pub featured_pair: Option<FeaturedPair>,
}

/// 비교 카탈로그의 작품 한 줄. 공개 섹터가 하나 이상 있는 작품만 나온다.
#[derive(Debug, Clone, Serialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ComparisonPiece {
    pub piece_id: i32,
    pub piece_title: String,
    pub opus_number: Option<String>,
    pub composer_id: i32,
    pub composer_name: String,
    pub composer_avatar_url: Option<String>,
    /// 공개 섹터 수
    pub sector_count: i64,
    /// 공개 섹터들에 등장하는 서로 다른 primary artist 수
    pub performer_count: i64,
    #[sqlx(skip)]
    pub performers: Vec<ComparisonPiecePerformer>,
}

/// 카탈로그 카드에 얼굴로 보여 줄 연주자. 작품마다 최대 4명.
#[derive(Debug, Clone, Serialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ComparisonPiecePerformer {
    #[serde(skip)]
    pub piece_id: i32,
    pub artist_id: i32,
    pub artist_name: String,
    pub image_url: Option<String>,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ComparisonPerformancePage {
    pub items: Vec<ComparisonPerformance>,
    pub next_cursor: Option<String>,
}

#[derive(Debug, FromRow)]
pub(crate) struct ComparisonPerformanceRow {
    pub id: i32,
    pub source_id: u64,
    pub sector_id: i32,
    pub piece_id: i32,
    pub piece_title: String,
    pub composer_id: i32,
    pub composer_name: String,
    pub sector_name: String,
    pub start_ms: u32,
    pub end_ms: u32,
    pub clip_status: String,
    pub clip_url: Option<String>,
    pub video_id: Option<String>,
}

#[derive(Debug, FromRow)]
pub(crate) struct ListeningNoteRow {
    pub performance_id: i32,
    pub headline: String,
    pub note: String,
    pub moments: Option<String>,
    pub facts: Option<String>,
}

#[derive(Debug, FromRow)]
pub(crate) struct FeaturedPairRow {
    pub sector_id: i32,
    pub performance_a_id: i32,
    pub performance_b_id: i32,
    pub title: String,
    pub note: String,
    pub moments: Option<String>,
    pub a_start_ms: u32,
    pub a_end_ms: u32,
    pub b_start_ms: u32,
    pub b_end_ms: u32,
}

#[derive(Debug, FromRow)]
pub(crate) struct ComparisonCreditRow {
    pub source_id: u64,
    pub artist_id: i32,
    pub artist_name: String,
    pub image_url: Option<String>,
    pub role: String,
    pub is_primary: bool,
    pub display_order: i32,
}

impl From<ComparisonCreditRow> for ComparisonCredit {
    fn from(row: ComparisonCreditRow) -> Self {
        Self {
            artist_id: row.artist_id,
            artist_name: row.artist_name,
            image_url: row.image_url,
            role: row.role,
            is_primary: row.is_primary,
            display_order: row.display_order,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::{
        clip_offset, note_moments, pair_moments, parse_json_list, ClipStatus, ComparisonSector,
        EditorialStatus, FeaturedPairMoment, ListeningMoment, PerformancePublishStatus,
        StoredMoment,
    };
    use std::str::FromStr;

    #[test]
    fn status_values_match_database_contract() {
        assert_eq!(EditorialStatus::Published.as_str(), "PUBLISHED");
        assert_eq!(ClipStatus::Ready.as_str(), "READY");
        assert_eq!(PerformancePublishStatus::Draft.as_str(), "DRAFT");
        assert!(ClipStatus::Ready.can_be_published());
        assert!(ClipStatus::Published.can_be_published());
        assert!(!ClipStatus::Generating.can_be_published());
    }

    #[test]
    fn sector_serializes_missing_values_as_null() {
        let sector = ComparisonSector {
            id: 14,
            piece_id: 226,
            sector_name: "1악장 카덴차".to_string(),
            sector_name_en: None,
            sector_type: Some("EXCERPT".to_string()),
            description: None,
            display_order: Some(1),
            measure_start: None,
            measure_end: None,
            ready_performance_count: 4,
            primary_artist_count: 3,
            featured_pair: None,
        };

        let value = serde_json::to_value(sector).expect("섹터 직렬화");
        assert_eq!(value["sectorName"], "1악장 카덴차");
        assert_eq!(value["readyPerformanceCount"], 4);
        assert_eq!(value["primaryArtistCount"], 3);
        assert_eq!(value["sectorType"], "EXCERPT");
        for key in [
            "sectorNameEn",
            "description",
            "measureStart",
            "measureEnd",
            "featuredPair",
        ] {
            assert!(
                value.get(key).is_some_and(serde_json::Value::is_null),
                "{key}"
            );
        }
    }

    #[test]
    fn moments_become_clip_offsets_and_drop_outside_clip() {
        assert_eq!(clip_offset(238_600, 236_000, 259_000), Some(2_600));
        assert_eq!(clip_offset(236_000, 236_000, 259_000), Some(0));
        assert_eq!(clip_offset(259_000, 236_000, 259_000), Some(23_000));
        assert_eq!(clip_offset(235_999, 236_000, 259_000), None);
        assert_eq!(clip_offset(259_001, 236_000, 259_000), None);

        let stored: Vec<StoredMoment> = parse_json_list(Some(
            r#"[{"atMs": 238600, "label": "시작하자마자 정점"}, {"atMs": 300000, "label": "밖"}]"#,
        ))
        .expect("들을 곳 JSON");
        assert_eq!(
            note_moments(stored, 236_000, 259_000),
            vec![ListeningMoment {
                offset_ms: 2_600,
                label: "시작하자마자 정점".to_string(),
            }]
        );
    }

    #[test]
    fn pair_moments_keep_only_the_two_performances() {
        let stored: Vec<StoredMoment> = parse_json_list(Some(
            r#"[
                {"performanceId": 93, "atMs": 238600, "label": "키신의 정점"},
                {"performanceId": 102, "atMs": 262900, "label": "랑랑의 정점"},
                {"performanceId": 104, "atMs": 250000, "label": "다른 연주"},
                {"atMs": 240000, "label": "연주 없음"}
            ]"#,
        ))
        .expect("추천 비교 JSON");
        let moments = pair_moments(stored, [(93, 236_000, 259_000), (102, 243_000, 267_000)]);
        assert_eq!(
            moments,
            vec![
                FeaturedPairMoment {
                    performance_id: 93,
                    offset_ms: 2_600,
                    label: "키신의 정점".to_string(),
                },
                FeaturedPairMoment {
                    performance_id: 102,
                    offset_ms: 19_900,
                    label: "랑랑의 정점".to_string(),
                },
            ]
        );
    }

    #[test]
    fn empty_json_lists_read_as_empty_and_bad_shapes_fail() {
        assert!(parse_json_list::<String>(None).expect("없음").is_empty());
        assert!(parse_json_list::<String>(Some("[]"))
            .expect("빈 배열")
            .is_empty());
        assert_eq!(
            parse_json_list::<String>(Some(r#"["오시아 카덴차"]"#)).expect("사실 태그"),
            vec!["오시아 카덴차".to_string()]
        );
        assert!(parse_json_list::<StoredMoment>(Some(r#"[{"label": "시점 없음"}]"#)).is_err());
    }

    #[test]
    fn unknown_status_is_rejected() {
        assert!(ClipStatus::from_str("DONE").is_err());
        assert!(EditorialStatus::from_str("VERIFIED").is_err());
        assert!(PerformancePublishStatus::from_str("QUEUED").is_err());
    }
}
