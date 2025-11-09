use rocket::{State, serde::json::Json};
use crate::db::DbPool;
use super::model::{Artist, CreateArtist};
use super::service::ArtistService;

#[get("/artists")]
pub async fn get_artists(pool: &State<DbPool>) -> Result<Json<Vec<Artist>>, String> {
    let artists = ArtistService::get_all_artists(pool).await?;
    Ok(Json(artists))
}

#[get("/artists/<id>")]
pub async fn get_artist(pool: &State<DbPool>, id: i32) -> Result<Json<Option<Artist>>, String> {
    let artist = ArtistService::get_artist_by_id(pool, id).await?;
    Ok(Json(artist))
}

#[post("/artists", data = "<artist>")]
pub async fn create_artist(pool: &State<DbPool>, artist: Json<CreateArtist>) -> Result<Json<i32>, String> {
    let id = ArtistService::create_artist(pool, artist.into_inner()).await?;
    Ok(Json(id))
}

#[delete("/artists/<id>")]
pub async fn delete_artist(pool: &State<DbPool>, id: i32) -> Result<Json<u64>, String> {
    let rows = ArtistService::delete_artist(pool, id).await?;
    Ok(Json(rows))
}
