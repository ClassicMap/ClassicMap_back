use rocket::http::{ContentType, Status};
use rocket::serde::json::Json;
use rocket::State;
use crate::db::DbPool;
use crate::logger::Logger;
use super::service::{ImageProxyService, WarmupResult};

#[get("/image-proxy?<url>")]
pub async fn image_proxy(url: String) -> Result<(ContentType, Vec<u8>), Status> {
    match ImageProxyService::get_or_fetch(&url).await {
        Ok((bytes, content_type)) => {
            let ct = content_type
                .parse::<ContentType>()
                .unwrap_or(ContentType::JPEG);
            Ok((ct, bytes))
        }
        Err(e) => {
            Logger::error("API", &format!("Image proxy failed: {}", e));
            Err(Status::BadRequest)
        }
    }
}

#[post("/image-proxy/warmup?<key>")]
pub async fn warmup_image_cache(
    pool: &State<DbPool>,
    key: String,
) -> Result<Json<WarmupResult>, Status> {
    let internal_key = std::env::var("INTERNAL_API_KEY").unwrap_or_default();

    if key.is_empty() || key != internal_key {
        return Err(Status::Unauthorized);
    }

    match ImageProxyService::warmup_cache(pool).await {
        Ok(result) => Ok(Json(result)),
        Err(e) => {
            Logger::error("API", &format!("Cache warmup failed: {}", e));
            Err(Status::InternalServerError)
        }
    }
}
