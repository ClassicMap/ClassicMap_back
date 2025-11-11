use rocket::{State, serde::json::Json};
use crate::db::DbPool;
use super::model::{Venue, CreateVenue, UpdateVenue};
use super::service::VenueService;

#[get("/venues")]
pub async fn get_venues(pool: &State<DbPool>) -> Result<Json<Vec<Venue>>, String> {
    let venues = VenueService::get_all_venues(pool).await?;
    Ok(Json(venues))
}

#[get("/venues/<id>")]
pub async fn get_venue(pool: &State<DbPool>, id: i32) -> Result<Json<Option<Venue>>, String> {
    let venue = VenueService::get_venue_by_id(pool, id).await?;
    Ok(Json(venue))
}

#[post("/venues", data = "<venue>")]
pub async fn create_venue(pool: &State<DbPool>, venue: Json<CreateVenue>) -> Result<Json<i32>, String> {
    let id = VenueService::create_venue(pool, venue.into_inner()).await?;
    Ok(Json(id))
}

#[put("/venues/<id>", data = "<venue>")]
pub async fn update_venue(pool: &State<DbPool>, id: i32, venue: Json<UpdateVenue>) -> Result<Json<u64>, String> {
    let rows = VenueService::update_venue(pool, id, venue.into_inner()).await?;
    Ok(Json(rows))
}

#[delete("/venues/<id>")]
pub async fn delete_venue(pool: &State<DbPool>, id: i32) -> Result<Json<u64>, String> {
    let rows = VenueService::delete_venue(pool, id).await?;
    Ok(Json(rows))
}
