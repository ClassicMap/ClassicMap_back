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
pub(crate) struct ComparisonCreditRow {
    pub source_id: u64,
    pub artist_id: i32,
    pub artist_name: String,
    pub role: String,
    pub is_primary: bool,
    pub display_order: i32,
}

impl From<ComparisonCreditRow> for ComparisonCredit {
    fn from(row: ComparisonCreditRow) -> Self {
        Self {
            artist_id: row.artist_id,
            artist_name: row.artist_name,
            role: row.role,
            is_primary: row.is_primary,
            display_order: row.display_order,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::{ClipStatus, ComparisonSector, EditorialStatus, PerformancePublishStatus};
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
        };

        let value = serde_json::to_value(sector).expect("섹터 직렬화");
        assert_eq!(value["sectorName"], "1악장 카덴차");
        assert_eq!(value["readyPerformanceCount"], 4);
        assert_eq!(value["primaryArtistCount"], 3);
        assert_eq!(value["sectorType"], "EXCERPT");
        for key in ["sectorNameEn", "description", "measureStart", "measureEnd"] {
            assert!(
                value.get(key).is_some_and(serde_json::Value::is_null),
                "{key}"
            );
        }
    }

    #[test]
    fn unknown_status_is_rejected() {
        assert!(ClipStatus::from_str("DONE").is_err());
        assert!(EditorialStatus::from_str("VERIFIED").is_err());
        assert!(PerformancePublishStatus::from_str("QUEUED").is_err());
    }
}
