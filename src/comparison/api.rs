use super::{repository::ComparisonContractError, service::ComparisonService};
use crate::{db::DbPool, logger::Logger};
use rocket::{http::Status, serde::json::Json, State};

use super::model::{
    is_piece_genre, ComparisonGenreSummary, ComparisonPerformance, ComparisonPerformancePage,
    ComparisonPiece, ComparisonSector,
};

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

/// 장르 요약: 장르마다 공개 비교 작품 수와 대표 작곡가 초상. 작품이 없는 장르는 빠진다.
/// 홈·둘러보기 장르 타일이 카탈로그 전체를 받지 않고 이것만 받는다.
#[get("/comparison-genres")]
pub async fn get_comparison_genres(
    pool: &State<DbPool>,
) -> Result<Json<Vec<ComparisonGenreSummary>>, Status> {
    match ComparisonService::get_genre_summaries(pool).await {
        Ok(summaries) => Ok(Json(summaries)),
        Err(error) => {
            Logger::error(
                "API",
                &format!("Failed to get comparison genres: {}", error),
            );
            Err(Status::InternalServerError)
        }
    }
}

const DEFAULT_CATALOG_PAGE_SIZE: i64 = 20;
const MAX_CATALOG_PAGE_SIZE: i64 = 50;

/// 비교 카탈로그: 공개 섹터가 있는 작품. `composer`로 한 작곡가만, `genre`로 한 장르만 거를 수 있다.
/// 모르는 장르 키는 400 이다.
#[get("/comparison-pieces?<composer>&<genre>&<offset>&<limit>")]
pub async fn get_comparison_pieces(
    pool: &State<DbPool>,
    composer: Option<i32>,
    genre: Option<&str>,
    offset: Option<i64>,
    limit: Option<i64>,
) -> Result<Json<Vec<ComparisonPiece>>, Status> {
    let offset = offset.unwrap_or(0);
    if offset < 0 {
        return Err(Status::BadRequest);
    }
    if genre.is_some_and(|value| !is_piece_genre(value)) {
        return Err(Status::BadRequest);
    }
    let limit = limit
        .unwrap_or(DEFAULT_CATALOG_PAGE_SIZE)
        .clamp(1, MAX_CATALOG_PAGE_SIZE);

    match ComparisonService::get_public_pieces(pool, composer, genre, offset, limit).await {
        Ok(pieces) => Ok(Json(pieces)),
        Err(error) => {
            Logger::error(
                "API",
                &format!("Failed to get comparison pieces: {}", error),
            );
            Err(Status::InternalServerError)
        }
    }
}
