use rocket::{State, serde::json::Json};
use crate::db::DbPool;
use super::model::{Composer, CreateComposer};
use super::service::ComposerService;

#[get("/composers")]
pub async fn get_composers(pool: &State<DbPool>) -> Result<Json<Vec<Composer>>, String> {
    let composers = ComposerService::get_all_composers(pool).await?;
    Ok(Json(composers))
}

#[get("/composers/<id>")]
pub async fn get_composer(pool: &State<DbPool>, id: i32) -> Result<Json<Option<Composer>>, String> {
    let composer = ComposerService::get_composer_by_id(pool, id).await?;
    Ok(Json(composer))
}

#[post("/composers", data = "<composer>")]
pub async fn create_composer(pool: &State<DbPool>, composer: Json<CreateComposer>) -> Result<Json<i32>, String> {
    let id = ComposerService::create_composer(pool, composer.into_inner()).await?;
    Ok(Json(id))
}

#[delete("/composers/<id>")]
pub async fn delete_composer(pool: &State<DbPool>, id: i32) -> Result<Json<u64>, String> {
    let rows = ComposerService::delete_composer(pool, id).await?;
    Ok(Json(rows))
}
