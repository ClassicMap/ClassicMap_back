use rocket::http::{ContentType, Status};
use rocket::serde::json::Json;
use rocket::State;
use crate::auth::AdminUser;
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

#[post("/image-proxy/warmup")]
pub async fn warmup_image_cache(
    pool: &State<DbPool>,
    _admin: AdminUser,
) -> Result<Json<WarmupResult>, Status> {
    match ImageProxyService::warmup_cache(pool).await {
        Ok(result) => Ok(Json(result)),
        Err(e) => {
            Logger::error("API", &format!("Cache warmup failed: {}", e));
            Err(Status::InternalServerError)
        }
    }
}
