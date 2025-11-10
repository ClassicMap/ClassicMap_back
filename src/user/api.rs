use super::model::{ClerkWebhookEvent, UpdateUser, User};
use super::service::UserService;
use crate::db::DbPool;
use rocket::http::Status;
use rocket::{serde::json::Json, State};

#[get("/users")]
pub async fn get_users(pool: &State<DbPool>) -> Result<Json<Vec<User>>, String> {
    let users = UserService::get_all_users(pool).await?;
    Ok(Json(users))
}

#[get("/users/<id>")]
pub async fn get_user(pool: &State<DbPool>, id: i32) -> Result<Json<Option<User>>, String> {
    let user = UserService::get_user_by_id(pool, id).await?;
    Ok(Json(user))
}

#[get("/users/clerk/<clerk_id>")]
pub async fn get_user_by_clerk_id(
    pool: &State<DbPool>,
    clerk_id: String,
) -> Result<Json<Option<User>>, String> {
    let user = UserService::get_user_by_clerk_id(pool, &clerk_id).await?;
    Ok(Json(user))
}

#[get("/users/email/<email>")]
pub async fn get_user_by_email(
    pool: &State<DbPool>,
    email: String,
) -> Result<Json<Option<User>>, String> {
    let user = UserService::get_user_by_email(pool, &email).await?;
    Ok(Json(user))
}

#[put("/users/<id>", data = "<user>")]
pub async fn update_user(
    pool: &State<DbPool>,
    id: i32,
    user: Json<UpdateUser>,
) -> Result<Json<u64>, String> {
    let rows = UserService::update_user(pool, id, user.into_inner()).await?;
    Ok(Json(rows))
}

#[delete("/users/<id>")]
pub async fn delete_user(pool: &State<DbPool>, id: i32) -> Result<Json<u64>, String> {
    let rows = UserService::delete_user(pool, id).await?;
    Ok(Json(rows))
}

#[post("/users/webhook", data = "<event>")]
pub async fn clerk_webhook(
    pool: &State<DbPool>,
    event: Json<ClerkWebhookEvent>,
) -> Result<Json<String>, Status> {
    match UserService::handle_clerk_webhook(pool, event.into_inner()).await {
        Ok(_) => Ok(Json("Webhook handled successfully".to_string())),
        Err(e) => Err(Status::InternalServerError),
    }
}
