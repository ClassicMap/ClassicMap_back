use crate::db::DbPool;
use super::model::{Artist, CreateArtist};
use sqlx::Error;

pub struct ArtistRepository;

impl ArtistRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<Artist>, Error> {
        sqlx::query_as::<_, Artist>(
            "SELECT id, name, english_name, category, tier, CAST(rating AS DOUBLE) as rating, 
             image_url, cover_image_url, birth_year, nationality, bio, style, 
             concert_count, country_count, album_count 
             FROM artists"
        )
            .fetch_all(pool)
            .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<Artist>, Error> {
        sqlx::query_as::<_, Artist>(
            "SELECT id, name, english_name, category, tier, CAST(rating AS DOUBLE) as rating, 
             image_url, cover_image_url, birth_year, nationality, bio, style, 
             concert_count, country_count, album_count 
             FROM artists WHERE id = ?"
        )
            .bind(id)
            .fetch_optional(pool)
            .await
    }

    pub async fn create(pool: &DbPool, artist: CreateArtist) -> Result<i32, Error> {
        let result = sqlx::query(
            "INSERT INTO artists (name, english_name, category, tier, nationality, rating, image_url, cover_image_url, birth_year, bio, style) 
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        )
        .bind(&artist.name)
        .bind(&artist.english_name)
        .bind(&artist.category)
        .bind(&artist.tier)
        .bind(&artist.nationality)
        .bind(artist.rating)
        .bind(&artist.image_url)
        .bind(&artist.cover_image_url)
        .bind(&artist.birth_year)
        .bind(&artist.bio)
        .bind(&artist.style)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn delete(pool: &DbPool, id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM artists WHERE id = ?")
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }
}
