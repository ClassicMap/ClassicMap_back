use super::model::{Artist, CreateArtist, UpdateArtist, ArtistWithAwards, CreateArtistAward};
use super::service::ArtistService;
use crate::auth::ModeratorUser;
use crate::concert::model::Concert;
use crate::concert::service::ConcertService;
use crate::db::DbPool;
use crate::logger::Logger;
use rocket::{http::Status, serde::json::Json, State};

#[get("/artists?<offset>&<limit>")]
pub async fn get_artists(
    pool: &State<DbPool>,
    offset: Option<i64>,
    limit: Option<i64>,
) -> Result<Json<Vec<Artist>>, Status> {
    let offset = offset.unwrap_or(0);
    let limit = limit.unwrap_or(20);

    match ArtistService::get_all_artists(pool, offset, limit).await {
        Ok(artists) => Ok(Json(artists)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get artists: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/artists/<id>")]
pub async fn get_artist(pool: &State<DbPool>, id: i32) -> Result<Json<Option<ArtistWithAwards>>, Status> {
    match ArtistService::get_artist_by_id_with_awards(pool, id).await {
        Ok(artist) => Ok(Json(artist)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get artist {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/artists", data = "<artist>")]
pub async fn create_artist(
    pool: &State<DbPool>,
    artist: Json<CreateArtist>,
    _moderator: ModeratorUser,
) -> Result<Json<i32>, Status> {
    match ArtistService::create_artist(pool, artist.into_inner()).await {
        Ok(id) => Ok(Json(id)),
        Err(e) => {
            Logger::error("API", &format!("Failed to create artist: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[put("/artists/<id>", data = "<artist>")]
pub async fn update_artist(
    pool: &State<DbPool>,
    id: i32,
    artist: Json<UpdateArtist>,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match ArtistService::update_artist(pool, id, artist.into_inner()).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to update artist {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[delete("/artists/<id>")]
pub async fn delete_artist(
    pool: &State<DbPool>,
    id: i32,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match ArtistService::delete_artist(pool, id).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete artist {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/artists/<id>/concerts")]
pub async fn get_artist_concerts(pool: &State<DbPool>, id: i32) -> Result<Json<Vec<Concert>>, Status> {
    match ConcertService::get_concerts_by_artist(pool, id).await {
        Ok(concerts) => Ok(Json(concerts)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get concerts for artist {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/artists/<id>/awards", data = "<award>")]
pub async fn create_artist_award(
    pool: &State<DbPool>,
    id: i32,
    award: Json<CreateArtistAward>,
    _moderator: ModeratorUser,
) -> Result<Json<i32>, Status> {
    match ArtistService::create_artist_award(pool, id, award.into_inner()).await {
        Ok(award_id) => Ok(Json(award_id)),
        Err(e) => {
            Logger::error("API", &format!("Failed to create award for artist {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[delete("/artists/<artist_id>/awards/<award_id>")]
pub async fn delete_artist_award(
    pool: &State<DbPool>,
    artist_id: i32,
    award_id: i32,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match ArtistService::delete_artist_award(pool, award_id).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete award {} for artist {}: {}", award_id, artist_id, e));
            Err(Status::InternalServerError)
        }
    }
}
