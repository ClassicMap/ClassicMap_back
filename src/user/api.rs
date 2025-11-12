use super::model::{ClerkDeleteWebhookEvent, ClerkWebhookEvent, UpdateUser, User};
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
    clerk_id: &str,
) -> Result<Json<Option<User>>, Status> {
    match UserService::get_user_by_clerk_id(pool, clerk_id).await {
        Ok(user) => {
            Logger::info("API", &format!("user: {}", user.clone().unwrap().email));
            Ok(Json(user))
        }
        Err(e) => {
            Logger::error(
                "API",
                &format!("Failed to get user by clerk_id {}: {}", clerk_id, e),
            );
            Err(Status::InternalServerError)
        }
    }
}

#[get("/users/email/<email>")]
pub async fn get_user_by_email(
    pool: &State<DbPool>,
    email: &str,
) -> Result<Json<Option<User>>, Status> {
    match UserService::get_user_by_email(pool, email).await {
        Ok(user) => Ok(Json(user)),
        Err(e) => {
            Logger::error(
                "API",
                &format!("Failed to get user by email {}: {}", email, e),
            );
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
    event: Json<serde_json::Value>,
) -> Result<Json<String>, Status> {
    let event_value = event.into_inner();
    let event_type = event_value["type"].as_str().unwrap_or("");

    match event_type {
        "user.deleted" => {
            let delete_event: ClerkDeleteWebhookEvent = serde_json::from_value(event_value)
                .map_err(|e| {
                    Logger::error("API", &format!("Failed to parse delete event: {}", e));
                    Status::BadRequest
                })?;

            match UserService::handle_clerk_delete_webhook(pool, delete_event).await {
                Ok(_) => Ok(Json("Webhook handled successfully".to_string())),
                Err(e) => {
                    Logger::error("API", &format!("Webhook error: {}", e));
                    Err(Status::InternalServerError)
                }
            }
        }
        _ => {
            let webhook_event: ClerkWebhookEvent =
                serde_json::from_value(event_value).map_err(|e| {
                    Logger::error("API", &format!("Failed to parse webhook event: {}", e));
                    Status::BadRequest
                })?;

            match UserService::handle_clerk_webhook(pool, webhook_event).await {
                Ok(_) => Ok(Json("Webhook handled successfully".to_string())),
                Err(e) => {
                    Logger::error("API", &format!("Webhook error: {}", e));
                    Err(Status::InternalServerError)
                }
            }
        }
    }
}
