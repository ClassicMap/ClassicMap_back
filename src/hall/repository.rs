use sqlx::MySqlPool;
use super::model::{Hall, CreateHall};

pub struct HallRepository;

impl HallRepository {
    pub async fn get_all(pool: &MySqlPool) -> Result<Vec<Hall>, sqlx::Error> {
        sqlx::query_as::<_, Hall>("SELECT * FROM halls ORDER BY name")
            .fetch_all(pool)
            .await
    }

    pub async fn get_by_id(pool: &MySqlPool, id: i32) -> Result<Option<Hall>, sqlx::Error> {
        sqlx::query_as::<_, Hall>("SELECT * FROM halls WHERE id = ?")
            .bind(id)
            .fetch_optional(pool)
            .await
    }

    pub async fn get_by_venue_id(pool: &MySqlPool, venue_id: i32) -> Result<Vec<Hall>, sqlx::Error> {
        sqlx::query_as::<_, Hall>("SELECT * FROM halls WHERE venue_id = ? ORDER BY name")
            .bind(venue_id)
            .fetch_all(pool)
            .await
    }

    pub async fn get_by_kopis_id(pool: &MySqlPool, kopis_id: &str) -> Result<Option<Hall>, sqlx::Error> {
        sqlx::query_as::<_, Hall>("SELECT * FROM halls WHERE kopis_id = ?")
            .bind(kopis_id)
            .fetch_optional(pool)
            .await
    }

    pub async fn create(pool: &MySqlPool, hall: CreateHall) -> Result<i32, sqlx::Error> {
        let result = sqlx::query(
            "INSERT INTO halls (venue_id, kopis_id, name, seats, is_active) VALUES (?, ?, ?, ?, ?)"
        )
        .bind(hall.venue_id)
        .bind(&hall.kopis_id)
        .bind(&hall.name)
        .bind(hall.seats)
        .bind(hall.is_active.unwrap_or(true))
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn upsert(pool: &MySqlPool, hall: CreateHall) -> Result<i32, sqlx::Error> {
        // kopis_id가 있으면 해당 레코드를 업데이트하고, 없으면 새로 생성
        if let Some(ref kopis_id) = hall.kopis_id {
            let existing = Self::get_by_kopis_id(pool, kopis_id).await?;

            if let Some(existing_hall) = existing {
                // 업데이트
                sqlx::query(
                    "UPDATE halls SET venue_id = ?, name = ?, seats = ?, is_active = ? WHERE kopis_id = ?"
                )
                .bind(hall.venue_id)
                .bind(&hall.name)
                .bind(hall.seats)
                .bind(hall.is_active.unwrap_or(true))
                .bind(kopis_id)
                .execute(pool)
                .await?;

                return Ok(existing_hall.id);
            }
        }

        // 새로 생성
        Self::create(pool, hall).await
    }

    pub async fn delete_by_venue_id(pool: &MySqlPool, venue_id: i32) -> Result<u64, sqlx::Error> {
        let result = sqlx::query("DELETE FROM halls WHERE venue_id = ?")
            .bind(venue_id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }
}
