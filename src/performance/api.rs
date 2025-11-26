use rocket::{State, serde::json::Json, http::Status};
use crate::auth::ModeratorUser;
use crate::db::DbPool;
use crate::logger::Logger;
use super::model::{Performance, CreatePerformance, UpdatePerformance};
use super::service::PerformanceService;

#[get("/performances")]
pub async fn get_performances(pool: &State<DbPool>) -> Result<Json<Vec<Performance>>, Status> {
    match PerformanceService::get_all_performances(pool).await {
        Ok(performances) => Ok(Json(performances)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get performances: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/sectors/<sector_id>/performances")]
pub async fn get_performances_by_sector(pool: &State<DbPool>, sector_id: i32) -> Result<Json<Vec<Performance>>, Status> {
    match PerformanceService::get_performances_by_sector(pool, sector_id).await {
        Ok(performances) => Ok(Json(performances)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get performances for sector {}: {}", sector_id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/pieces/<piece_id>/performances")]
pub async fn get_performances_by_piece(pool: &State<DbPool>, piece_id: i32) -> Result<Json<Vec<Performance>>, Status> {
    match PerformanceService::get_performances_by_piece(pool, piece_id).await {
        Ok(performances) => Ok(Json(performances)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get performances for piece {}: {}", piece_id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/artists/<artist_id>/performances")]
pub async fn get_performances_by_artist(pool: &State<DbPool>, artist_id: i32) -> Result<Json<Vec<Performance>>, Status> {
    match PerformanceService::get_performances_by_artist(pool, artist_id).await {
        Ok(performances) => Ok(Json(performances)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get performances for artist {}: {}", artist_id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/performances/<id>")]
pub async fn get_performance(pool: &State<DbPool>, id: i32) -> Result<Json<Option<Performance>>, Status> {
    match PerformanceService::get_performance(pool, id).await {
        Ok(performance) => Ok(Json(performance)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get performance {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/performances", data = "<performance>")]
pub async fn create_performance(
    pool: &State<DbPool>,
    performance: Json<CreatePerformance>,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match PerformanceService::create_performance(pool, performance.into_inner()).await {
        Ok(id) => Ok(Json(id)),
        Err(e) => {
            Logger::error("API", &format!("Failed to create performance: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[put("/performances/<id>", data = "<performance>")]
pub async fn update_performance(
    pool: &State<DbPool>,
    id: i32,
    performance: Json<UpdatePerformance>,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match PerformanceService::update_performance(pool, id, performance.into_inner()).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to update performance {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[delete("/performances/<id>")]
pub async fn delete_performance(
    pool: &State<DbPool>,
    id: i32,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match PerformanceService::delete_performance(pool, id).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete performance {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}