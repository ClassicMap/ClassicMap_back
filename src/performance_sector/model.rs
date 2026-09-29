use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct PerformanceSector {
    pub id: i32,
    pub piece_id: i32,
    pub sector_name: String,
    /// 구간의 갈래. `WHOLE_WORK` · `MOVEMENT` · `EXCERPT` 는 같은 대목의 다른 해석을
    /// 견주는 구간이고, `ARRANGEMENTS` 는 편성이 서로 다른 편곡을 나란히 듣는 구간이다.
    /// 뒤엣것은 정렬 비용 임계를 적용하지 않으므로 화면이 갈래를 드러내야 한다.
    pub sector_type: Option<String>,
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
