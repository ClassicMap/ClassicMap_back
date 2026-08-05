use super::{repository::ComparisonContractError, service::ComparisonService};
use crate::{db::DbPool, logger::Logger};
use rocket::{http::Status, serde::json::Json, State};

use super::model::ComparisonPerformancePage;

#[get("/artists/<artist_id>/comparison-performances?<cursor>&<limit>")]
pub async fn get_artist_comparison_performances(
    pool: &State<DbPool>,
    artist_id: i32,
    cursor: Option<&str>,
    limit: Option<u32>,
) -> Result<Json<ComparisonPerformancePage>, Status> {
    match ComparisonService::get_artist_performances(pool, artist_id, cursor, limit).await {
        Ok(page) => Ok(Json(page)),
        Err(ComparisonContractError::InvalidCursor) => Err(Status::BadRequest),
        Err(error) => {
            Logger::error(
                "API",
                &format!(
                    "Failed to get comparison performances for artist {}: {}",
                    artist_id, error
                ),
            );
            Err(Status::InternalServerError)
        }
    }
}
