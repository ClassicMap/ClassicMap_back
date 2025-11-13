use super::model::{Concert, CreateConcert, SubmitRating, UpdateConcert, ConcertWithArtists};
use super::service::ConcertService;
use crate::auth::{AuthenticatedUser, ModeratorUser};
use crate::db::DbPool;
use crate::logger::Logger;
use rocket::{http::Status, serde::json::Json, State};
use rust_decimal::Decimal;

#[get("/concerts")]
pub async fn get_concerts(pool: &State<DbPool>) -> Result<Json<Vec<ConcertWithArtists>>, Status> {
    match ConcertService::get_all_concerts_with_artists(pool).await {
        Ok(concerts) => Ok(Json(concerts)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get concerts: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/concerts/<id>")]
pub async fn get_concert(pool: &State<DbPool>, id: i32) -> Result<Json<Option<ConcertWithArtists>>, Status> {
    match ConcertService::get_concert_by_id_with_artists(pool, id).await {
        Ok(concert) => Ok(Json(concert)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get concert {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/concerts", data = "<concert>")]
pub async fn create_concert(
    pool: &State<DbPool>,
    concert: Json<CreateConcert>,
    _moderator: ModeratorUser,
) -> Result<Json<i32>, Status> {
    match ConcertService::create_concert(pool, concert.into_inner()).await {
        Ok(id) => Ok(Json(id)),
        Err(e) => {
            Logger::error("API", &format!("Failed to create concert: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[put("/concerts/<id>", data = "<concert>")]
pub async fn update_concert(
    pool: &State<DbPool>,
    id: i32,
    concert: Json<UpdateConcert>,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match ConcertService::update_concert(pool, id, concert.into_inner()).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to update concert {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[delete("/concerts/<id>")]
pub async fn delete_concert(
    pool: &State<DbPool>,
    id: i32,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match ConcertService::delete_concert(pool, id).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete concert {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/concerts/<id>/rating", data = "<rating>")]
pub async fn submit_rating(
    pool: &State<DbPool>,
    id: i32,
    rating: Json<SubmitRating>,
    user: AuthenticatedUser,
) -> Result<Status, Status> {
    match ConcertService::submit_rating(pool, user.user.id, id, rating.rating).await {
        Ok(_) => Ok(Status::Ok),
        Err(e) => {
            Logger::error(
                "API",
                &format!("Failed to submit rating for concert {}: {}", id, e),
            );
            Err(Status::InternalServerError)
        }
    }
}

#[get("/concerts/<id>/user-rating")]
pub async fn get_user_rating(
    pool: &State<DbPool>,
    id: i32,
    user: AuthenticatedUser,
) -> Result<Json<Option<Decimal>>, Status> {
    match ConcertService::get_user_rating(pool, user.user.id, id).await {
        Ok(rating) => Ok(Json(rating)),
        Err(e) => {
            Logger::error(
                "API",
                &format!("Failed to get user rating for concert {}: {}", id, e),
            );
            Err(Status::InternalServerError)
        }
    }
}
