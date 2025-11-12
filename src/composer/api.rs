use rocket::{State, serde::json::Json, http::Status};
use crate::auth::ModeratorUser;
use crate::db::DbPool;
use crate::logger::Logger;
use super::model::{Composer, CreateComposer, UpdateComposer};
use super::service::ComposerService;

#[get("/composers")]
pub async fn get_composers(pool: &State<DbPool>) -> Result<Json<Vec<Composer>>, Status> {
    match ComposerService::get_all_composers(pool).await {
        Ok(composers) => Ok(Json(composers)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get composers: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/composers/<id>")]
pub async fn get_composer(pool: &State<DbPool>, id: i32) -> Result<Json<Option<Composer>>, Status> {
    match ComposerService::get_composer_by_id(pool, id).await {
        Ok(composer) => Ok(Json(composer)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get composer {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/composers", data = "<composer>")]
pub async fn create_composer(
    pool: &State<DbPool>,
    composer: Json<CreateComposer>,
    _moderator: ModeratorUser,  // 인증 및 권한 확인
) -> Result<Json<i32>, Status> {
    match ComposerService::create_composer(pool, composer.into_inner()).await {
        Ok(id) => Ok(Json(id)),
        Err(e) => {
            Logger::error("API", &format!("Failed to create composer: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[put("/composers/<id>", data = "<composer>")]
pub async fn update_composer(
    pool: &State<DbPool>,
    id: i32,
    composer: Json<UpdateComposer>,
    _moderator: ModeratorUser,  // 인증 및 권한 확인
) -> Result<Json<u64>, Status> {
    match ComposerService::update_composer(pool, id, composer.into_inner()).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to update composer {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[delete("/composers/<id>")]
pub async fn delete_composer(
    pool: &State<DbPool>,
    id: i32,
    _moderator: ModeratorUser,  // 인증 및 권한 확인
) -> Result<Json<u64>, Status> {
    match ComposerService::delete_composer(pool, id).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete composer {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}
