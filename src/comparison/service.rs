use super::{
    model::ComparisonPerformancePage,
    repository::{ComparisonContractError, ComparisonPageRequest, ComparisonRepository},
};
use crate::db::DbPool;

pub struct ComparisonService;

impl ComparisonService {
    pub async fn get_artist_performances(
        pool: &DbPool,
        artist_id: i32,
        cursor: Option<&str>,
        limit: Option<u32>,
    ) -> Result<ComparisonPerformancePage, ComparisonContractError> {
        let page = ComparisonPageRequest::parse(cursor, limit)?;
        ComparisonRepository::find_published_by_artist(pool, artist_id, page).await
    }
}
