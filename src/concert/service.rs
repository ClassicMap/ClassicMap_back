use crate::db::DbPool;
use super::model::{Concert, CreateConcert, UpdateConcert};
use super::repository::ConcertRepository;
use rust_decimal::Decimal;

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

    pub async fn get_concerts_by_artist(pool: &DbPool, artist_id: i32) -> Result<Vec<Concert>, String> {
        ConcertRepository::find_by_artist(pool, artist_id)
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

    pub async fn submit_rating(pool: &DbPool, user_id: i32, concert_id: i32, rating: f32) -> Result<(), String> {
        if rating < 0.0 || rating > 5.0 {
            return Err("Rating must be between 0.0 and 5.0".to_string());
        }
        ConcertRepository::submit_rating(pool, user_id, concert_id, rating)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_user_rating(pool: &DbPool, user_id: i32, concert_id: i32) -> Result<Option<Decimal>, String> {
        ConcertRepository::get_user_rating(pool, user_id, concert_id)
            .await
            .map_err(|e| e.to_string())
    }
}
