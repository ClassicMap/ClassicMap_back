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
    use super::{ClipStatus, EditorialStatus, PerformancePublishStatus};
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
    fn unknown_status_is_rejected() {
        assert!(ClipStatus::from_str("DONE").is_err());
        assert!(EditorialStatus::from_str("VERIFIED").is_err());
        assert!(PerformancePublishStatus::from_str("QUEUED").is_err());
    }
}
