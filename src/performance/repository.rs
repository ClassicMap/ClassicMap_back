use super::model::{CreatePerformance, Performance, UpdatePerformance};
use crate::db::DbPool;
use sqlx::Error;

pub struct PerformanceRepository;

impl PerformanceRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<Performance>, Error> {
        sqlx::query_as::<_, Performance>(
            "SELECT id, piece_id, artist_id, video_platform, video_id, start_time, end_time, 
             characteristic, recording_date, view_count, CAST(rating AS DOUBLE) as rating 
             FROM performances ORDER BY id DESC",
        )
        .fetch_all(pool)
        .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<Performance>, Error> {
        sqlx::query_as::<_, Performance>(
            "SELECT id, piece_id, artist_id, video_platform, video_id, start_time, end_time, 
             characteristic, recording_date, view_count, CAST(rating AS DOUBLE) as rating 
             FROM performances WHERE id = ?",
        )
        .bind(id)
        .fetch_optional(pool)
        .await
    }

    pub async fn find_by_piece(pool: &DbPool, piece_id: i32) -> Result<Vec<Performance>, Error> {
        sqlx::query_as::<_, Performance>(
            "SELECT id, piece_id, artist_id, video_platform, video_id, start_time, end_time, 
             characteristic, recording_date, view_count, CAST(rating AS DOUBLE) as rating 
             FROM performances WHERE piece_id = ? ORDER BY rating DESC",
        )
        .bind(piece_id)
        .fetch_all(pool)
        .await
    }

    pub async fn find_by_artist(pool: &DbPool, artist_id: i32) -> Result<Vec<Performance>, Error> {
        sqlx::query_as::<_, Performance>(
            "SELECT id, piece_id, artist_id, video_platform, video_id, start_time, end_time, 
             characteristic, recording_date, view_count, CAST(rating AS DOUBLE) as rating 
             FROM performances WHERE artist_id = ? ORDER BY id DESC",
        )
        .bind(artist_id)
        .fetch_all(pool)
        .await
    }

    pub async fn create(pool: &DbPool, performance: CreatePerformance) -> Result<u64, Error> {
        let result = sqlx::query(
            "INSERT INTO performances (piece_id, artist_id, video_platform, video_id, 
             start_time, end_time, characteristic, view_count, rating) 
             VALUES (?, ?, ?, ?, ?, ?, ?, 0, 0.0)",
        )
        .bind(performance.piece_id)
        .bind(performance.artist_id)
        .bind(performance.video_platform)
        .bind(performance.video_id)
        .bind(performance.start_time)
        .bind(performance.end_time)
        .bind(performance.characteristic)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id())
    }

    pub async fn update(
        pool: &DbPool,
        id: i32,
        performance: UpdatePerformance,
    ) -> Result<u64, Error> {
        let current = Self::find_by_id(pool, id).await?;
        if current.is_none() {
            return Ok(0);
        }
        let current = current.unwrap();

        let result = sqlx::query(
            "UPDATE performances SET video_platform = ?, video_id = ?, start_time = ?, 
             end_time = ?, characteristic = ?, view_count = ?, rating = ? 
             WHERE id = ?",
        )
        .bind(performance.video_platform.unwrap_or(current.video_platform))
        .bind(performance.video_id.unwrap_or(current.video_id))
        .bind(performance.start_time.unwrap_or(current.start_time))
        .bind(performance.end_time.unwrap_or(current.end_time))
        .bind(performance.characteristic.or(current.characteristic))
        .bind(performance.view_count.unwrap_or(current.view_count))
        .bind(performance.rating.unwrap_or(current.rating))
        .bind(id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete(pool: &DbPool, id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM performances WHERE id = ?")
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }
}
