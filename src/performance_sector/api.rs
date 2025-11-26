use rocket::http::Status;
use rocket::serde::json::Json;
use rocket::State;

use crate::auth::ModeratorUser;

use super::model::{CreatePerformanceSector, PerformanceSector, PerformanceSectorWithCount, UpdatePerformanceSector};
use super::repository::DbPool;
use super::service::PerformanceSectorService;

/// GET /api/pieces/<piece_id>/sectors
/// 특정 곡의 모든 섹터 조회 (연주 개수 포함)
#[get("/pieces/<piece_id>/sectors")]
pub async fn get_sectors_by_piece(
    pool: &State<DbPool>,
    piece_id: i32,
) -> Result<Json<Vec<PerformanceSectorWithCount>>, Status> {
    match PerformanceSectorService::get_sectors_by_piece(pool, piece_id).await {
        Ok(sectors) => Ok(Json(sectors)),
        Err(e) => {
            eprintln!("Failed to get sectors: {:?}", e);
            Err(Status::InternalServerError)
        }
    }
}

/// GET /api/sectors/<id>
/// ID로 섹터 조회
#[get("/sectors/<id>")]
pub async fn get_sector(
    pool: &State<DbPool>,
    id: i32,
) -> Result<Json<Option<PerformanceSector>>, Status> {
    match PerformanceSectorService::get_sector(pool, id).await {
        Ok(sector) => Ok(Json(sector)),
        Err(e) => {
            eprintln!("Failed to get sector: {:?}", e);
            Err(Status::InternalServerError)
        }
    }
}

/// POST /api/sectors
/// 섹터 생성 (관리자 권한 필요)
#[post("/sectors", data = "<sector>")]
pub async fn create_sector(
    pool: &State<DbPool>,
    sector: Json<CreatePerformanceSector>,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match PerformanceSectorService::create_sector(pool, sector.into_inner()).await {
        Ok(id) => Ok(Json(id)),
        Err(e) => {
            eprintln!("Failed to create sector: {:?}", e);
            Err(Status::InternalServerError)
        }
    }
}

/// PUT /api/sectors/<id>
/// 섹터 수정 (관리자 권한 필요)
#[put("/sectors/<id>", data = "<sector>")]
pub async fn update_sector(
    pool: &State<DbPool>,
    id: i32,
    sector: Json<UpdatePerformanceSector>,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match PerformanceSectorService::update_sector(pool, id, sector.into_inner()).await {
        Ok(rows) => {
            if rows == 0 {
                Err(Status::NotFound)
            } else {
                Ok(Json(rows))
            }
        }
        Err(e) => {
            eprintln!("Failed to update sector: {:?}", e);
            Err(Status::InternalServerError)
        }
    }
}

/// DELETE /api/sectors/<id>
/// 섹터 삭제 (관리자 권한 필요)
/// 연결된 performances도 CASCADE로 자동 삭제됨
#[delete("/sectors/<id>")]
pub async fn delete_sector(
    pool: &State<DbPool>,
    id: i32,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match PerformanceSectorService::delete_sector(pool, id).await {
        Ok(rows) => {
            if rows == 0 {
                Err(Status::NotFound)
            } else {
                Ok(Json(rows))
            }
        }
        Err(e) => {
            eprintln!("Failed to delete sector: {:?}", e);
            Err(Status::InternalServerError)
        }
    }
}
