use super::model::BoxofficeConcert;
use super::service::BoxofficeService;
use crate::db::DbPool;
use crate::logger::Logger;
use rocket::{http::Status, serde::json::Json, State};

#[get("/concerts/boxoffice/top3?<area_code>&<genre_code>")]
pub async fn get_top3(
    pool: &State<DbPool>,
    area_code: Option<String>,
    genre_code: Option<String>,
) -> Result<Json<Vec<BoxofficeConcert>>, Status> {
    match BoxofficeService::get_top3(pool, area_code, genre_code).await {
        Ok(concerts) => {
            Logger::info(
                "API_RESPONSE",
                &format!("Boxoffice TOP3 returned: {} concerts", concerts.len()),
            );
            Ok(Json(concerts))
        }
        Err(e) => {
            Logger::error("API", &format!("Failed to get boxoffice TOP3: {}", e));
            Err(Status::InternalServerError)
        }
    }
}
