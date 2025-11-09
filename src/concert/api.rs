use rocket::{State, serde::json::Json};
use crate::db::DbPool;
use super::model::{Concert, CreateConcert};
use super::service::ConcertService;

#[get("/concerts")]
pub async fn get_concerts(pool: &State<DbPool>) -> Result<Json<Vec<Concert>>, String> {
    let concerts = ConcertService::get_all_concerts(pool).await?;
    Ok(Json(concerts))
}

#[get("/concerts/<id>")]
pub async fn get_concert(pool: &State<DbPool>, id: i32) -> Result<Json<Option<Concert>>, String> {
    let concert = ConcertService::get_concert_by_id(pool, id).await?;
    Ok(Json(concert))
}

#[post("/concerts", data = "<concert>")]
pub async fn create_concert(pool: &State<DbPool>, concert: Json<CreateConcert>) -> Result<Json<i32>, String> {
    let id = ConcertService::create_concert(pool, concert.into_inner()).await?;
    Ok(Json(id))
}

#[delete("/concerts/<id>")]
pub async fn delete_concert(pool: &State<DbPool>, id: i32) -> Result<Json<u64>, String> {
    let rows = ConcertService::delete_concert(pool, id).await?;
    Ok(Json(rows))
}
