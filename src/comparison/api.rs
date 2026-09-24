use super::{repository::ComparisonContractError, service::ComparisonService};
use crate::{db::DbPool, logger::Logger};
use rocket::{http::Status, serde::json::Json, State};

use super::model::{ComparisonPerformance, ComparisonPerformancePage, ComparisonSector};

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

#[get("/pieces/<piece_id>/comparison-sectors")]
pub async fn get_piece_comparison_sectors(
    pool: &State<DbPool>,
    piece_id: i32,
) -> Result<Json<Vec<ComparisonSector>>, Status> {
    match ComparisonService::get_piece_sectors(pool, piece_id).await {
        Ok(Some(sectors)) => Ok(Json(sectors)),
        Ok(None) => Err(Status::NotFound),
        Err(error) => {
            Logger::error(
                "API",
                &format!(
                    "Failed to get comparison sectors for piece {}: {}",
                    piece_id, error
                ),
            );
            Err(Status::InternalServerError)
        }
    }
}

#[get("/sectors/<sector_id>/comparison-performances")]
pub async fn get_sector_comparison_performances(
    pool: &State<DbPool>,
    sector_id: i32,
) -> Result<Json<Vec<ComparisonPerformance>>, Status> {
    match ComparisonService::get_sector_performances(pool, sector_id).await {
        Ok(Some(performances)) => Ok(Json(performances)),
        Ok(None) => Err(Status::NotFound),
        Err(error) => {
            Logger::error(
                "API",
                &format!(
                    "Failed to get comparison performances for sector {}: {}",
                    sector_id, error
                ),
            );
            Err(Status::InternalServerError)
        }
    }
}
