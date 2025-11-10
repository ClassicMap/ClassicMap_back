use super::model::{ClerkWebhookEvent, UpdateUser, User};
use super::service::UserService;
use crate::db::DbPool;
use crate::logger::Logger;
use rocket::http::Status;
use rocket::{serde::json::Json, State};

#[get("/users")]
pub async fn get_users(pool: &State<DbPool>) -> Result<Json<Vec<User>>, Status> {
    match UserService::get_all_users(pool).await {
        Ok(users) => Ok(Json(users)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get users: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/users/<id>")]
pub async fn get_user(pool: &State<DbPool>, id: i32) -> Result<Json<Option<User>>, Status> {
    match UserService::get_user_by_id(pool, id).await {
        Ok(user) => Ok(Json(user)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get user {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/users/clerk/<clerk_id>")]
pub async fn get_user_by_clerk_id(
    pool: &State<DbPool>,
    clerk_id: String,
) -> Result<Json<Option<User>>, Status> {
    match UserService::get_user_by_clerk_id(pool, &clerk_id).await {
        Ok(user) => Ok(Json(user)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get user by clerk_id {}: {}", clerk_id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/users/email/<email>")]
pub async fn get_user_by_email(
    pool: &State<DbPool>,
    email: String,
) -> Result<Json<Option<User>>, Status> {
    match UserService::get_user_by_email(pool, &email).await {
        Ok(user) => Ok(Json(user)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get user by email {}: {}", email, e));
            Err(Status::InternalServerError)
        }
    }
}

#[put("/users/<id>", data = "<user>")]
pub async fn update_user(
    pool: &State<DbPool>,
    id: i32,
    user: Json<UpdateUser>,
) -> Result<Json<u64>, Status> {
    match UserService::update_user(pool, id, user.into_inner()).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to update user {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[delete("/users/<id>")]
pub async fn delete_user(pool: &State<DbPool>, id: i32) -> Result<Json<u64>, Status> {
    match UserService::delete_user(pool, id).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete user {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/users/webhook", data = "<event>")]
pub async fn clerk_webhook(
    pool: &State<DbPool>,
    event: Json<ClerkWebhookEvent>,
) -> Result<Json<String>, Status> {
    match UserService::handle_clerk_webhook(pool, event.into_inner()).await {
        Ok(_) => Ok(Json("Webhook handled successfully".to_string())),
        Err(e) => {
            Logger::error("API", &format!("Webhook error: {}", e));
            Err(Status::InternalServerError)
        }
    }
}
