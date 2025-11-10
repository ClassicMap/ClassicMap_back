use rocket::{State, serde::json::Json, http::Status};
use crate::db::DbPool;
use crate::logger::Logger;
use super::model::{Artist, CreateArtist};
use super::service::ArtistService;

#[get("/artists")]
pub async fn get_artists(pool: &State<DbPool>) -> Result<Json<Vec<Artist>>, Status> {
    match ArtistService::get_all_artists(pool).await {
        Ok(artists) => Ok(Json(artists)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get artists: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/artists/<id>")]
pub async fn get_artist(pool: &State<DbPool>, id: i32) -> Result<Json<Option<Artist>>, Status> {
    match ArtistService::get_artist_by_id(pool, id).await {
        Ok(artist) => Ok(Json(artist)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get artist {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/artists", data = "<artist>")]
pub async fn create_artist(pool: &State<DbPool>, artist: Json<CreateArtist>) -> Result<Json<i32>, Status> {
    match ArtistService::create_artist(pool, artist.into_inner()).await {
        Ok(id) => Ok(Json(id)),
        Err(e) => {
            Logger::error("API", &format!("Failed to create artist: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[delete("/artists/<id>")]
pub async fn delete_artist(pool: &State<DbPool>, id: i32) -> Result<Json<u64>, Status> {
    match ArtistService::delete_artist(pool, id).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete artist {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}
