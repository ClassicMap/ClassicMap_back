use rocket::fs::TempFile;
use rocket::http::Status;
use rocket::serde::json::Json;
use serde::{Deserialize, Serialize};
use std::path::PathBuf;
use crate::logger::Logger;

#[derive(Debug, Serialize, Deserialize)]
pub struct UploadResponse {
    pub url: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub enum ImageType {
    Avatar,
    Cover,
    Poster,
}

#[derive(Debug, Serialize, Deserialize)]
pub enum EntityType {
    Composer,
    Artist,
    Concert,
}

pub struct UploadService;

impl UploadService {
    pub fn get_upload_path(
        entity_type: &EntityType,
        image_type: &ImageType,
        filename: &str,
    ) -> PathBuf {
        let entity_folder = match entity_type {
            EntityType::Composer => "composers",
            EntityType::Artist => "artists",
            EntityType::Concert => "concerts",
        };

        let image_folder = match image_type {
            ImageType::Avatar => "avatar",
            ImageType::Cover => "cover",
            ImageType::Poster => "poster",
        };

        PathBuf::from(format!(
            "static/uploads/{}/{}/{}",
            entity_folder, image_folder, filename
        ))
    }

    pub fn get_url(
        entity_type: &EntityType,
        image_type: &ImageType,
        filename: &str,
    ) -> String {
        let entity_folder = match entity_type {
            EntityType::Composer => "composers",
            EntityType::Artist => "artists",
            EntityType::Concert => "concerts",
        };

        let image_folder = match image_type {
            ImageType::Avatar => "avatar",
            ImageType::Cover => "cover",
            ImageType::Poster => "poster",
        };

        format!("/uploads/{}/{}/{}", entity_folder, image_folder, filename)
    }

    pub fn validate_image_extension(filename: &str) -> bool {
        let valid_extensions = ["jpg", "jpeg", "png", "webp", "gif", "heic", "heif"];
        if let Some(ext) = filename.split('.').last() {
            valid_extensions.contains(&ext.to_lowercase().as_str())
        } else {
            false
        }
    }
}

// Composer Avatar Upload
#[post("/upload/composer/avatar", data = "<file>")]
pub async fn upload_composer_avatar(mut file: TempFile<'_>) -> Result<Json<UploadResponse>, Status> {
    let filename = file.name().unwrap_or("unknown").to_string();
    
    if !UploadService::validate_image_extension(&filename) {
        Logger::error("UPLOAD", &format!("Invalid file extension: {}", filename));
        return Err(Status::BadRequest);
    }

    let kst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
    let timestamp = chrono::Utc::now().with_timezone(&kst).timestamp();
    let unique_filename = format!("{}_{}", timestamp, filename);
    let path = UploadService::get_upload_path(&EntityType::Composer, &ImageType::Avatar, &unique_filename);

    match file.persist_to(&path).await {
        Ok(_) => {
            let url = UploadService::get_url(&EntityType::Composer, &ImageType::Avatar, &unique_filename);
            Logger::success("UPLOAD", &format!("Composer avatar uploaded: {}", url));
            Ok(Json(UploadResponse { url }))
        }
        Err(e) => {
            Logger::error("UPLOAD", &format!("Failed to save file: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

// Composer Cover Upload
#[post("/upload/composer/cover", data = "<file>")]
pub async fn upload_composer_cover(mut file: TempFile<'_>) -> Result<Json<UploadResponse>, Status> {
    let filename = file.name().unwrap_or("unknown").to_string();
    
    if !UploadService::validate_image_extension(&filename) {
        Logger::error("UPLOAD", &format!("Invalid file extension: {}", filename));
        return Err(Status::BadRequest);
    }

    let kst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
    let timestamp = chrono::Utc::now().with_timezone(&kst).timestamp();
    let unique_filename = format!("{}_{}", timestamp, filename);
    let path = UploadService::get_upload_path(&EntityType::Composer, &ImageType::Cover, &unique_filename);

    match file.persist_to(&path).await {
        Ok(_) => {
            let url = UploadService::get_url(&EntityType::Composer, &ImageType::Cover, &unique_filename);
            Logger::success("UPLOAD", &format!("Composer cover uploaded: {}", url));
            Ok(Json(UploadResponse { url }))
        }
        Err(e) => {
            Logger::error("UPLOAD", &format!("Failed to save file: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

// Artist Avatar Upload
#[post("/upload/artist/avatar", data = "<file>")]
pub async fn upload_artist_avatar(mut file: TempFile<'_>) -> Result<Json<UploadResponse>, Status> {
    let filename = file.name().unwrap_or("unknown").to_string();
    
    if !UploadService::validate_image_extension(&filename) {
        Logger::error("UPLOAD", &format!("Invalid file extension: {}", filename));
        return Err(Status::BadRequest);
    }

    let kst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
    let timestamp = chrono::Utc::now().with_timezone(&kst).timestamp();
    let unique_filename = format!("{}_{}", timestamp, filename);
    let path = UploadService::get_upload_path(&EntityType::Artist, &ImageType::Avatar, &unique_filename);

    match file.persist_to(&path).await {
        Ok(_) => {
            let url = UploadService::get_url(&EntityType::Artist, &ImageType::Avatar, &unique_filename);
            Logger::success("UPLOAD", &format!("Artist avatar uploaded: {}", url));
            Ok(Json(UploadResponse { url }))
        }
        Err(e) => {
            Logger::error("UPLOAD", &format!("Failed to save file: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

// Artist Cover Upload
#[post("/upload/artist/cover", data = "<file>")]
pub async fn upload_artist_cover(mut file: TempFile<'_>) -> Result<Json<UploadResponse>, Status> {
    let filename = file.name().unwrap_or("unknown").to_string();
    
    if !UploadService::validate_image_extension(&filename) {
        Logger::error("UPLOAD", &format!("Invalid file extension: {}", filename));
        return Err(Status::BadRequest);
    }

    let kst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
    let timestamp = chrono::Utc::now().with_timezone(&kst).timestamp();
    let unique_filename = format!("{}_{}", timestamp, filename);
    let path = UploadService::get_upload_path(&EntityType::Artist, &ImageType::Cover, &unique_filename);

    match file.persist_to(&path).await {
        Ok(_) => {
            let url = UploadService::get_url(&EntityType::Artist, &ImageType::Cover, &unique_filename);
            Logger::success("UPLOAD", &format!("Artist cover uploaded: {}", url));
            Ok(Json(UploadResponse { url }))
        }
        Err(e) => {
            Logger::error("UPLOAD", &format!("Failed to save file: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

// Concert Poster Upload
#[post("/upload/concert/poster", data = "<file>")]
pub async fn upload_concert_poster(mut file: TempFile<'_>) -> Result<Json<UploadResponse>, Status> {
    let filename = file.name().unwrap_or("unknown").to_string();
    
    if !UploadService::validate_image_extension(&filename) {
        Logger::error("UPLOAD", &format!("Invalid file extension: {}", filename));
        return Err(Status::BadRequest);
    }

    let kst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
    let timestamp = chrono::Utc::now().with_timezone(&kst).timestamp();
    let unique_filename = format!("{}_{}", timestamp, filename);
    let path = UploadService::get_upload_path(&EntityType::Concert, &ImageType::Poster, &unique_filename);

    match file.persist_to(&path).await {
        Ok(_) => {
            let url = UploadService::get_url(&EntityType::Concert, &ImageType::Poster, &unique_filename);
            Logger::success("UPLOAD", &format!("Concert poster uploaded: {}", url));
            Ok(Json(UploadResponse { url }))
        }
        Err(e) => {
            Logger::error("UPLOAD", &format!("Failed to save file: {}", e));
            Err(Status::InternalServerError)
        }
    }
}
