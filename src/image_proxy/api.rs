use rocket::http::{ContentType, Status};
use crate::logger::Logger;
use super::service::ImageProxyService;

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
