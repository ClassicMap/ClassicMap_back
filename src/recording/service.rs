use crate::db::DbPool;
use super::model::{Recording, CreateRecording, UpdateRecording};
use super::repository::RecordingRepository;

pub struct RecordingService;

impl RecordingService {
    pub async fn get_all_recordings(pool: &DbPool) -> Result<Vec<Recording>, String> {
        RecordingRepository::find_all(pool)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_recording(pool: &DbPool, id: i32) -> Result<Option<Recording>, String> {
        RecordingRepository::find_by_id(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_recordings_by_artist(pool: &DbPool, artist_id: i32) -> Result<Vec<Recording>, String> {
        RecordingRepository::find_by_artist(pool, artist_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn create_recording(pool: &DbPool, recording: CreateRecording) -> Result<u64, String> {
        RecordingRepository::create(pool, recording)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn update_recording(pool: &DbPool, id: i32, recording: UpdateRecording) -> Result<u64, String> {
        RecordingRepository::update(pool, id, recording)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_recording(pool: &DbPool, id: i32) -> Result<u64, String> {
        RecordingRepository::delete(pool, id)
            .await
            .map_err(|e| e.to_string())
    }
}
