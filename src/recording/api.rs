use crate::db::DbPool;
use crate::auth::ModeratorUser;
use crate::logger::Logger;
use super::model::{Recording, CreateRecording, UpdateRecording};
use super::service::RecordingService;
use rocket::serde::json::Json;
use rocket::{State, http::Status};

#[get("/recordings")]
pub async fn get_recordings(pool: &State<DbPool>) -> Result<Json<Vec<Recording>>, Status> {
    match RecordingService::get_all_recordings(pool).await {
        Ok(recordings) => Ok(Json(recordings)),
        Err(e) => {
            Logger::error("API", &format!("Failed to fetch recordings: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/recordings/<id>")]
pub async fn get_recording(pool: &State<DbPool>, id: i32) -> Result<Json<Recording>, Status> {
    match RecordingService::get_recording(pool, id).await {
        Ok(Some(recording)) => Ok(Json(recording)),
        Ok(None) => Err(Status::NotFound),
        Err(e) => {
            Logger::error("API", &format!("Failed to fetch recording {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/artists/<artist_id>/recordings")]
pub async fn get_artist_recordings(pool: &State<DbPool>, artist_id: i32) -> Result<Json<Vec<Recording>>, Status> {
    match RecordingService::get_recordings_by_artist(pool, artist_id).await {
        Ok(recordings) => Ok(Json(recordings)),
        Err(e) => {
            Logger::error("API", &format!("Failed to fetch recordings for artist {}: {}", artist_id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/recordings", data = "<recording>")]
pub async fn create_recording(
    pool: &State<DbPool>,
    recording: Json<CreateRecording>,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match RecordingService::create_recording(pool, recording.into_inner()).await {
        Ok(id) => {
            Logger::success("API", &format!("Recording created with id: {}", id));
            Ok(Json(id))
        },
        Err(e) => {
            Logger::error("API", &format!("Failed to create recording: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[put("/recordings/<id>", data = "<recording>")]
pub async fn update_recording(
    pool: &State<DbPool>,
    id: i32,
    recording: Json<UpdateRecording>,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match RecordingService::update_recording(pool, id, recording.into_inner()).await {
        Ok(rows) if rows > 0 => {
            Logger::success("API", &format!("Recording {} updated", id));
            Ok(Json(rows))
        },
        Ok(_) => Err(Status::NotFound),
        Err(e) => {
            Logger::error("API", &format!("Failed to update recording {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[delete("/recordings/<id>")]
pub async fn delete_recording(
    pool: &State<DbPool>,
    id: i32,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match RecordingService::delete_recording(pool, id).await {
        Ok(rows) if rows > 0 => {
            Logger::success("API", &format!("Recording {} deleted", id));
            Ok(Json(rows))
        },
        Ok(_) => Err(Status::NotFound),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete recording {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}
