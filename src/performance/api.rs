use crate::db::DbPool;
use crate::auth::ModeratorUser;
use crate::logger::Logger;
use super::model::{Performance, CreatePerformance, UpdatePerformance};
use super::service::PerformanceService;
use rocket::serde::json::Json;
use rocket::{State, http::Status};

#[get("/performances")]
pub async fn get_performances(pool: &State<DbPool>) -> Result<Json<Vec<Performance>>, Status> {
    match PerformanceService::get_all_performances(pool).await {
        Ok(performances) => Ok(Json(performances)),
        Err(e) => {
            Logger::error("API", &format!("Failed to fetch performances: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/performances/<id>")]
pub async fn get_performance(pool: &State<DbPool>, id: i32) -> Result<Json<Performance>, Status> {
    match PerformanceService::get_performance(pool, id).await {
        Ok(Some(performance)) => Ok(Json(performance)),
        Ok(None) => Err(Status::NotFound),
        Err(e) => {
            Logger::error("API", &format!("Failed to fetch performance {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/pieces/<piece_id>/performances")]
pub async fn get_piece_performances(pool: &State<DbPool>, piece_id: i32) -> Result<Json<Vec<Performance>>, Status> {
    match PerformanceService::get_performances_by_piece(pool, piece_id).await {
        Ok(performances) => Ok(Json(performances)),
        Err(e) => {
            Logger::error("API", &format!("Failed to fetch performances for piece {}: {}", piece_id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/artists/<artist_id>/performances")]
pub async fn get_artist_performances(pool: &State<DbPool>, artist_id: i32) -> Result<Json<Vec<Performance>>, Status> {
    match PerformanceService::get_performances_by_artist(pool, artist_id).await {
        Ok(performances) => Ok(Json(performances)),
        Err(e) => {
            Logger::error("API", &format!("Failed to fetch performances for artist {}: {}", artist_id, e));
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
        Ok(id) => {
            Logger::success("API", &format!("Performance created with id: {}", id));
            Ok(Json(id))
        },
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
        Ok(rows) if rows > 0 => {
            Logger::success("API", &format!("Performance {} updated", id));
            Ok(Json(rows))
        },
        Ok(_) => Err(Status::NotFound),
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
        Ok(rows) if rows > 0 => {
            Logger::success("API", &format!("Performance {} deleted", id));
            Ok(Json(rows))
        },
        Ok(_) => Err(Status::NotFound),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete performance {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}
