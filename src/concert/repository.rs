use crate::db::DbPool;
use super::model::{Concert, CreateConcert, UpdateConcert};
use sqlx::Error;

pub struct ConcertRepository;

impl ConcertRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<Concert>, Error> {
        sqlx::query_as::<_, Concert>(
            "SELECT id, title, composer_info, venue_id, 
             DATE_FORMAT(concert_date, '%Y-%m-%d') as concert_date,
             TIME_FORMAT(concert_time, '%H:%i:%s') as concert_time,
             price_info, poster_url, program, ticket_url, is_recommended, status, rating, rating_count 
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
             price_info, poster_url, program, ticket_url, is_recommended, status, rating, rating_count 
             FROM concerts WHERE id = ?"
        )
            .bind(id)
            .fetch_optional(pool)
            .await
    }

    pub async fn create(pool: &DbPool, concert: CreateConcert) -> Result<i32, Error> {
        let result = sqlx::query(
            "INSERT INTO concerts (title, composer_info, venue_id, concert_date, concert_time, price_info, poster_url, program, ticket_url, is_recommended, status) 
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        )
        .bind(&concert.title)
        .bind(&concert.composer_info)
        .bind(concert.venue_id)
        .bind(&concert.concert_date)
        .bind(&concert.concert_time)
        .bind(&concert.price_info)
        .bind(&concert.poster_url)
        .bind(&concert.program)
        .bind(&concert.ticket_url)
        .bind(concert.is_recommended)
        .bind(&concert.status)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn update(pool: &DbPool, id: i32, concert: UpdateConcert) -> Result<u64, Error> {
        let current = Self::find_by_id(pool, id).await?;
        if current.is_none() {
            return Ok(0);
        }
        let current = current.unwrap();

        let result = sqlx::query(
            "UPDATE concerts SET title = ?, composer_info = ?, venue_id = ?, 
             concert_date = ?, concert_time = ?, price_info = ?, poster_url = ?, 
             program = ?, ticket_url = ?, is_recommended = ?, status = ?
             WHERE id = ?"
        )
        .bind(concert.title.unwrap_or(current.title))
        .bind(concert.composer_info.or(current.composer_info))
        .bind(concert.venue_id.unwrap_or(current.venue_id))
        .bind(concert.concert_date.unwrap_or(current.concert_date))
        .bind(concert.concert_time.or(current.concert_time))
        .bind(concert.price_info.or(current.price_info))
        .bind(concert.poster_url.or(current.poster_url))
        .bind(concert.program.or(current.program))
        .bind(concert.ticket_url.or(current.ticket_url))
        .bind(concert.is_recommended.unwrap_or(current.is_recommended))
        .bind(concert.status.unwrap_or(current.status))
        .bind(id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete(pool: &DbPool, id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM concerts WHERE id = ?")
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }
}
