use crate::db::DbPool;
use super::model::{Performance, CreatePerformance, UpdatePerformance};
use super::repository::PerformanceRepository;

pub struct PerformanceService;

impl PerformanceService {
    pub async fn get_all_performances(pool: &DbPool) -> Result<Vec<Performance>, String> {
        PerformanceRepository::find_all(pool)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_performance(pool: &DbPool, id: i32) -> Result<Option<Performance>, String> {
        PerformanceRepository::find_by_id(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_performances_by_sector(pool: &DbPool, sector_id: i32) -> Result<Vec<Performance>, String> {
        PerformanceRepository::find_by_sector(pool, sector_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_performances_by_piece(pool: &DbPool, piece_id: i32) -> Result<Vec<Performance>, String> {
        PerformanceRepository::find_by_piece(pool, piece_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_performances_by_artist(pool: &DbPool, artist_id: i32) -> Result<Vec<Performance>, String> {
        PerformanceRepository::find_by_artist(pool, artist_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn create_performance(pool: &DbPool, performance: CreatePerformance) -> Result<u64, String> {
        PerformanceRepository::create(pool, performance)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn update_performance(pool: &DbPool, id: i32, performance: UpdatePerformance) -> Result<u64, String> {
        PerformanceRepository::update(pool, id, performance)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_performance(pool: &DbPool, id: i32) -> Result<u64, String> {
        PerformanceRepository::delete(pool, id)
            .await
            .map_err(|e| e.to_string())
    }
}
