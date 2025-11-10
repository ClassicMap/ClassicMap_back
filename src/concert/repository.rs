use crate::db::DbPool;
use super::model::{Concert, CreateConcert};
use sqlx::Error;

pub struct ConcertRepository;

impl ConcertRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<Concert>, Error> {
        sqlx::query_as::<_, Concert>(
            "SELECT id, title, composer_info, venue_id, 
             DATE_FORMAT(concert_date, '%Y-%m-%d') as concert_date,
             TIME_FORMAT(concert_time, '%H:%i:%s') as concert_time,
             price_info, poster_url, ticket_url, is_recommended, status 
             FROM concerts"
        )
            .fetch_all(pool)
            .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<Concert>, Error> {
        sqlx::query_as::<_, Concert>(
            "SELECT id, title, composer_info, venue_id, 
             DATE_FORMAT(concert_date, '%Y-%m-%d') as concert_date,
             TIME_FORMAT(concert_time, '%H:%i:%s') as concert_time,
             price_info, poster_url, ticket_url, is_recommended, status 
             FROM concerts WHERE id = ?"
        )
            .bind(id)
            .fetch_optional(pool)
            .await
    }

    pub async fn create(pool: &DbPool, concert: CreateConcert) -> Result<i32, Error> {
        let result = sqlx::query(
            "INSERT INTO concerts (title, composer_info, venue_id, concert_date, concert_time, price_info, poster_url, ticket_url, is_recommended, status) 
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        )
        .bind(&concert.title)
        .bind(&concert.composer_info)
        .bind(concert.venue_id)
        .bind(&concert.concert_date)
        .bind(&concert.concert_time)
        .bind(&concert.price_info)
        .bind(&concert.poster_url)
        .bind(&concert.ticket_url)
        .bind(concert.is_recommended)
        .bind(&concert.status)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn delete(pool: &DbPool, id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM concerts WHERE id = ?")
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }
}
