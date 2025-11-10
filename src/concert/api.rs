use rocket::{State, serde::json::Json, http::Status};
use crate::db::DbPool;
use crate::logger::Logger;
use super::model::{Concert, CreateConcert, UpdateConcert};
use super::service::ConcertService;

#[get("/concerts")]
pub async fn get_concerts(pool: &State<DbPool>) -> Result<Json<Vec<Concert>>, Status> {
    match ConcertService::get_all_concerts(pool).await {
        Ok(concerts) => Ok(Json(concerts)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get concerts: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/concerts/<id>")]
pub async fn get_concert(pool: &State<DbPool>, id: i32) -> Result<Json<Option<Concert>>, Status> {
    match ConcertService::get_concert_by_id(pool, id).await {
        Ok(concert) => Ok(Json(concert)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get concert {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/concerts", data = "<concert>")]
pub async fn create_concert(pool: &State<DbPool>, concert: Json<CreateConcert>) -> Result<Json<i32>, Status> {
    match ConcertService::create_concert(pool, concert.into_inner()).await {
        Ok(id) => Ok(Json(id)),
        Err(e) => {
            Logger::error("API", &format!("Failed to create concert: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[put("/concerts/<id>", data = "<concert>")]
pub async fn update_concert(pool: &State<DbPool>, id: i32, concert: Json<UpdateConcert>) -> Result<Json<u64>, Status> {
    match ConcertService::update_concert(pool, id, concert.into_inner()).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to update concert {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[delete("/concerts/<id>")]
pub async fn delete_concert(pool: &State<DbPool>, id: i32) -> Result<Json<u64>, Status> {
    match ConcertService::delete_concert(pool, id).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete concert {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}
