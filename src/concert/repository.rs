use super::model::{Concert, CreateConcert, UpdateConcert, ConcertWithArtists, ConcertArtist};
use crate::db::DbPool;
use rust_decimal::Decimal;
use sqlx::Error;

pub struct ConcertRepository;

impl ConcertRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<Concert>, Error> {
        sqlx::query_as::<_, Concert>(
            "SELECT id, title, composer_info, venue_id,
             DATE_FORMAT(concert_date, '%Y-%m-%d') as concert_date,
             TIME_FORMAT(concert_time, '%H:%i') as concert_time,
             price_info, poster_url, program, ticket_url, status, rating, rating_count
             FROM concerts"
        )
            .fetch_all(pool)
            .await
    }

    pub async fn find_all_with_artists(pool: &DbPool) -> Result<Vec<ConcertWithArtists>, Error> {
        let concerts = Self::find_all(pool).await?;
        let mut result = Vec::new();

        for concert in concerts {
            let artists = Self::find_artists_by_concert(pool, concert.id).await?;
            result.push(ConcertWithArtists { concert, artists });
        }

        Ok(result)
    }

    pub async fn find_artists_by_concert(pool: &DbPool, concert_id: i32) -> Result<Vec<ConcertArtist>, Error> {
        sqlx::query_as::<_, ConcertArtist>(
            "SELECT ca.id, ca.concert_id, ca.artist_id, a.name as artist_name, ca.role
             FROM concert_artists ca
             INNER JOIN artists a ON ca.artist_id = a.id
             WHERE ca.concert_id = ?
             ORDER BY ca.id"
        )
        .bind(concert_id)
        .fetch_all(pool)
        .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<Concert>, Error> {
        sqlx::query_as::<_, Concert>(
            "SELECT id, title, composer_info, venue_id,
             DATE_FORMAT(concert_date, '%Y-%m-%d') as concert_date,
             TIME_FORMAT(concert_time, '%H:%i') as concert_time,
             price_info, poster_url, program, ticket_url, status, rating, rating_count
             FROM concerts WHERE id = ?"
        )
            .bind(id)
            .fetch_optional(pool)
            .await
    }

    pub async fn find_by_id_with_artists(pool: &DbPool, id: i32) -> Result<Option<ConcertWithArtists>, Error> {
        let concert_opt = Self::find_by_id(pool, id).await?;

        if let Some(concert) = concert_opt {
            let artists = Self::find_artists_by_concert(pool, id).await?;
            Ok(Some(ConcertWithArtists { concert, artists }))
        } else {
            Ok(None)
        }
    }

    pub async fn find_by_artist(pool: &DbPool, artist_id: i32) -> Result<Vec<Concert>, Error> {
        sqlx::query_as::<_, Concert>(
            "SELECT c.id, c.title, c.composer_info, c.venue_id,
             DATE_FORMAT(c.concert_date, '%Y-%m-%d') as concert_date,
             TIME_FORMAT(c.concert_time, '%H:%i') as concert_time,
             c.price_info, c.poster_url, c.program, c.ticket_url, c.status, c.rating, c.rating_count
             FROM concerts c
             INNER JOIN concert_artists ca ON c.id = ca.concert_id
             WHERE ca.artist_id = ?
             AND c.concert_date >= DATE_SUB(CURDATE(), INTERVAL 2 MONTH)
             ORDER BY c.concert_date DESC"
        )
            .bind(artist_id)
            .fetch_all(pool)
            .await
    }

    pub async fn create(pool: &DbPool, concert: CreateConcert) -> Result<i32, Error> {
        let result = sqlx::query(
            "INSERT INTO concerts (title, composer_info, venue_id, concert_date, concert_time, price_info, poster_url, program, ticket_url, status)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
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
             program = ?, ticket_url = ?, status = ?
             WHERE id = ?",
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

    pub async fn submit_rating(
        pool: &DbPool,
        user_id: i32,
        concert_id: i32,
        rating: f32,
    ) -> Result<(), Error> {
        sqlx::query(
            "INSERT INTO user_concert_ratings (user_id, concert_id, rating)
             VALUES (?, ?, ?)
             ON DUPLICATE KEY UPDATE rating = ?, updated_at = CURRENT_TIMESTAMP",
        )
        .bind(user_id)
        .bind(concert_id)
        .bind(rating)
        .bind(rating)
        .execute(pool)
        .await?;

        // 평균 평점 업데이트
        Self::update_average_rating(pool, concert_id).await?;

        Ok(())
    }

    pub async fn get_user_rating(
        pool: &DbPool,
        user_id: i32,
        concert_id: i32,
    ) -> Result<Option<Decimal>, Error> {
        let result: Option<(Decimal,)> = sqlx::query_as(
            "SELECT rating FROM user_concert_ratings WHERE user_id = ? AND concert_id = ?",
        )
        .bind(user_id)
        .bind(concert_id)
        .fetch_optional(pool)
        .await?;

        Ok(result.map(|(rating,)| rating))
    }

    async fn update_average_rating(pool: &DbPool, concert_id: i32) -> Result<(), Error> {
        sqlx::query(
            "UPDATE concerts c
             SET rating = (SELECT AVG(rating) FROM user_concert_ratings WHERE concert_id = ?),
                 rating_count = (SELECT COUNT(*) FROM user_concert_ratings WHERE concert_id = ?)
             WHERE id = ?",
        )
        .bind(concert_id)
        .bind(concert_id)
        .bind(concert_id)
        .execute(pool)
        .await?;

        Ok(())
    }
}
