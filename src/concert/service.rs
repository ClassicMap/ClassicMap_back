use crate::db::DbPool;
use super::model::{Concert, CreateConcert, UpdateConcert};
use super::repository::ConcertRepository;

pub struct ConcertService;

impl ConcertService {
    pub async fn get_all_concerts(pool: &DbPool) -> Result<Vec<Concert>, String> {
        ConcertRepository::find_all(pool)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_concert_by_id(pool: &DbPool, id: i32) -> Result<Option<Concert>, String> {
        ConcertRepository::find_by_id(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn create_concert(pool: &DbPool, concert: CreateConcert) -> Result<i32, String> {
        ConcertRepository::create(pool, concert)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn update_concert(pool: &DbPool, id: i32, concert: UpdateConcert) -> Result<u64, String> {
        ConcertRepository::update(pool, id, concert)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_concert(pool: &DbPool, id: i32) -> Result<u64, String> {
        ConcertRepository::delete(pool, id)
            .await
            .map_err(|e| e.to_string())
    }
}
