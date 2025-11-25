use super::model::{Concert, CreateConcert, SubmitRating, UpdateConcert, ConcertWithArtists, ConcertWithDetails, ConcertListItem, ConcertTicketVendor};
use super::service::ConcertService;
use crate::auth::{AuthenticatedUser, ModeratorUser};
use crate::db::DbPool;
use crate::logger::Logger;
use rocket::{http::Status, serde::json::Json, State};
use rust_decimal::Decimal;

#[get("/concerts?<offset>&<limit>")]
pub async fn get_concerts(
    pool: &State<DbPool>,
    offset: Option<i64>,
    limit: Option<i64>,
) -> Result<Json<Vec<ConcertListItem>>, Status> {
    match ConcertService::get_all_concerts_list_view(pool, offset, limit).await {
        Ok(concerts) => {
            // 첫 번째 공연 데이터 로깅 (있으면)
            if let Some(first) = concerts.first() {
                Logger::info("API_RESPONSE", &format!("First concert: {}", serde_json::to_string_pretty(first).unwrap_or_else(|_| "Failed to serialize".to_string())));
            }
            Logger::info("API_RESPONSE", &format!("Total concerts returned: {}", concerts.len()));
            Ok(Json(concerts))
        },
        Err(e) => {
            Logger::error("API", &format!("Failed to get concerts: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/concerts/<id>")]
pub async fn get_concert(pool: &State<DbPool>, id: i32) -> Result<Json<Option<ConcertWithDetails>>, Status> {
    match ConcertService::get_concert_with_details(pool, id).await {
        Ok(concert) => {
            if let Some(ref c) = concert {
                Logger::info("API_RESPONSE", &format!("Concert detail {}: {}", id, serde_json::to_string_pretty(c).unwrap_or_else(|_| "Failed to serialize".to_string())));
            }
            Ok(Json(concert))
        },
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

// ============================================
// New Enhanced Endpoints
// ============================================

#[get("/concerts/featured?<area_code>&<limit>")]
pub async fn get_featured_concerts(
    pool: &State<DbPool>,
    area_code: Option<String>,
    limit: Option<i32>,
) -> Result<Json<Vec<ConcertWithDetails>>, Status> {
    match ConcertService::get_featured_concerts(pool, area_code, limit).await {
        Ok(concerts) => Ok(Json(concerts)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get featured concerts: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/concerts/upcoming?<sort>&<limit>")]
pub async fn get_upcoming_concerts(
    pool: &State<DbPool>,
    sort: Option<String>,
    limit: Option<i32>,
) -> Result<Json<Vec<ConcertListItem>>, Status> {
    match ConcertService::get_upcoming_concerts(pool, sort, limit).await {
        Ok(concerts) => Ok(Json(concerts)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get upcoming concerts: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/concerts/search?<genre>&<area>&<is_visit>&<is_festival>")]
pub async fn search_concerts(
    pool: &State<DbPool>,
    genre: Option<String>,
    area: Option<String>,
    is_visit: Option<bool>,
    is_festival: Option<bool>,
) -> Result<Json<Vec<ConcertListItem>>, Status> {
    match ConcertService::search_concerts(pool, genre, area, is_visit, is_festival).await {
        Ok(concerts) => Ok(Json(concerts)),
        Err(e) => {
            Logger::error("API", &format!("Failed to search concerts: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/concerts/<id>/ticket-vendors")]
pub async fn get_ticket_vendors(
    pool: &State<DbPool>,
    id: i32,
) -> Result<Json<Vec<ConcertTicketVendor>>, Status> {
    Logger::info("API", &format!("GET /concerts/{}/ticket-vendors", id));
    match ConcertService::get_ticket_vendors(pool, id).await {
        Ok(vendors) => {
            Logger::info("API", &format!("Found {} ticket vendors for concert {}", vendors.len(), id));
            if !vendors.is_empty() {
                Logger::debug("API", &format!("Vendors: {:?}", vendors));
            }
            Ok(Json(vendors))
        },
        Err(e) => {
            Logger::error("API", &format!("Failed to get ticket vendors for concert {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}
