use super::model::{
    ClerkDeleteWebhookEvent, ClerkWebhookEvent, FavoriteArtistItem, FavoriteArtistRequest,
    FavoriteComposerItem, FavoriteComposerRequest, FavoriteConcertItem, FavoriteConcertRequest,
    FavoritePieceItem, FavoritePieceRequest, PublicProfileResponse, RatedConcertListItem,
    UpdateProfileVisibility, UpdateUser, User, UserPublicProfile,
};
use super::service::UserService;
use crate::auth::{AdminUser, AuthenticatedUser};
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
    _admin: AdminUser,
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
pub async fn delete_user(
    pool: &State<DbPool>,
    _admin: AdminUser,
    id: i32,
) -> Result<Json<u64>, Status> {
    match UserService::delete_user(pool, id).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete user {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

fn mutation_status(result: Result<u64, String>, action: &str) -> Result<Status, Status> {
    match result {
        Ok(_) => Ok(Status::Ok),
        Err(e) => {
            Logger::error("API", &format!("Failed to {}: {}", action, e));
            if e.contains("must be positive") {
                Err(Status::BadRequest)
            } else {
                Err(Status::InternalServerError)
            }
        }
    }
}

#[get("/me/ratings")]
pub async fn get_my_ratings(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
) -> Result<Json<Vec<RatedConcertListItem>>, Status> {
    match UserService::get_my_ratings(pool, user.user.id).await {
        Ok(ratings) => Ok(Json(ratings)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get my ratings: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/me/favorites/concerts")]
pub async fn get_my_favorite_concerts(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
) -> Result<Json<Vec<FavoriteConcertItem>>, Status> {
    match UserService::get_favorite_concerts(pool, user.user.id).await {
        Ok(favorites) => Ok(Json(favorites)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get favorite concerts: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/me/favorites/concerts", data = "<favorite>")]
pub async fn add_my_favorite_concert(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
    favorite: Json<FavoriteConcertRequest>,
) -> Result<Status, Status> {
    mutation_status(
        UserService::add_favorite_concert(pool, user.user.id, favorite.concert_id).await,
        "add favorite concert",
    )
}

#[delete("/me/favorites/concerts/<concert_id>")]
pub async fn delete_my_favorite_concert(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
    concert_id: i32,
) -> Result<Status, Status> {
    match UserService::delete_favorite_concert(pool, user.user.id, concert_id).await {
        Ok(_) => Ok(Status::NoContent),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete favorite concert: {}", e));
            if e.contains("must be positive") {
                Err(Status::BadRequest)
            } else {
                Err(Status::InternalServerError)
            }
        }
    }
}

#[get("/me/favorites/artists")]
pub async fn get_my_favorite_artists(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
) -> Result<Json<Vec<FavoriteArtistItem>>, Status> {
    match UserService::get_favorite_artists(pool, user.user.id).await {
        Ok(favorites) => Ok(Json(favorites)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get favorite artists: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/me/favorites/artists", data = "<favorite>")]
pub async fn add_my_favorite_artist(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
    favorite: Json<FavoriteArtistRequest>,
) -> Result<Status, Status> {
    mutation_status(
        UserService::add_favorite_artist(pool, user.user.id, favorite.artist_id).await,
        "add favorite artist",
    )
}

#[delete("/me/favorites/artists/<artist_id>")]
pub async fn delete_my_favorite_artist(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
    artist_id: i32,
) -> Result<Status, Status> {
    match UserService::delete_favorite_artist(pool, user.user.id, artist_id).await {
        Ok(_) => Ok(Status::NoContent),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete favorite artist: {}", e));
            if e.contains("must be positive") {
                Err(Status::BadRequest)
            } else {
                Err(Status::InternalServerError)
            }
        }
    }
}

#[get("/me/favorites/composers")]
pub async fn get_my_favorite_composers(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
) -> Result<Json<Vec<FavoriteComposerItem>>, Status> {
    match UserService::get_favorite_composers(pool, user.user.id).await {
        Ok(favorites) => Ok(Json(favorites)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get favorite composers: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/me/favorites/composers", data = "<favorite>")]
pub async fn add_my_favorite_composer(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
    favorite: Json<FavoriteComposerRequest>,
) -> Result<Status, Status> {
    mutation_status(
        UserService::add_favorite_composer(pool, user.user.id, favorite.composer_id).await,
        "add favorite composer",
    )
}

#[delete("/me/favorites/composers/<composer_id>")]
pub async fn delete_my_favorite_composer(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
    composer_id: i32,
) -> Result<Status, Status> {
    match UserService::delete_favorite_composer(pool, user.user.id, composer_id).await {
        Ok(_) => Ok(Status::NoContent),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete favorite composer: {}", e));
            if e.contains("must be positive") {
                Err(Status::BadRequest)
            } else {
                Err(Status::InternalServerError)
            }
        }
    }
}

#[get("/me/favorites/pieces")]
pub async fn get_my_favorite_pieces(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
) -> Result<Json<Vec<FavoritePieceItem>>, Status> {
    match UserService::get_favorite_pieces(pool, user.user.id).await {
        Ok(favorites) => Ok(Json(favorites)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get favorite pieces: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/me/favorites/pieces", data = "<favorite>")]
pub async fn add_my_favorite_piece(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
    favorite: Json<FavoritePieceRequest>,
) -> Result<Status, Status> {
    mutation_status(
        UserService::add_favorite_piece(pool, user.user.id, favorite.piece_id).await,
        "add favorite piece",
    )
}

#[delete("/me/favorites/pieces/<piece_id>")]
pub async fn delete_my_favorite_piece(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
    piece_id: i32,
) -> Result<Status, Status> {
    match UserService::delete_favorite_piece(pool, user.user.id, piece_id).await {
        Ok(_) => Ok(Status::NoContent),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete favorite piece: {}", e));
            if e.contains("must be positive") {
                Err(Status::BadRequest)
            } else {
                Err(Status::InternalServerError)
            }
        }
    }
}

#[get("/me/profile-visibility")]
pub async fn get_my_profile_visibility(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
) -> Result<Json<UserPublicProfile>, Status> {
    match UserService::get_profile_visibility(pool, user.user.id).await {
        Ok(profile) => Ok(Json(profile)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get profile visibility: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[put("/me/profile-visibility", data = "<profile>")]
pub async fn update_my_profile_visibility(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
    profile: Json<UpdateProfileVisibility>,
) -> Result<Json<UserPublicProfile>, Status> {
    match UserService::update_profile_visibility(pool, user.user.id, profile.into_inner()).await {
        Ok(updated) => Ok(Json(updated)),
        Err(e) => {
            Logger::error(
                "API",
                &format!("Failed to update profile visibility: {}", e),
            );
            Err(Status::InternalServerError)
        }
    }
}

#[get("/users/<id>/public-profile")]
pub async fn get_public_profile(
    pool: &State<DbPool>,
    id: i32,
) -> Result<Json<Option<PublicProfileResponse>>, Status> {
    match UserService::get_public_profile(pool, id).await {
        Ok(profile) => Ok(Json(profile)),
        Err(e) => {
            Logger::error(
                "API",
                &format!("Failed to get public profile {}: {}", id, e),
            );
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
