use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct PerformanceSector {
    pub id: i32,
    pub piece_id: i32,
    pub sector_name: String,
    pub description: Option<String>,
    pub display_order: Option<i32>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CreatePerformanceSector {
    pub piece_id: i32,
    pub sector_name: String,
    pub description: Option<String>,
    pub display_order: Option<i32>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct UpdatePerformanceSector {
    pub sector_name: Option<String>,
    pub description: Option<String>,
    pub display_order: Option<i32>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PerformanceSectorWithCount {
    #[serde(flatten)]
    pub sector: PerformanceSector,
    pub performance_count: i32,
}
