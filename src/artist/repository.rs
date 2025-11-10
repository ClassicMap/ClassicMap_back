use crate::db::DbPool;
use super::model::{Artist, CreateArtist, UpdateArtist};
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

    pub async fn update(pool: &DbPool, id: i32, artist: UpdateArtist) -> Result<u64, Error> {
        let current = Self::find_by_id(pool, id).await?;
        if current.is_none() {
            return Ok(0);
        }
        let current = current.unwrap();

        let result = sqlx::query(
            "UPDATE artists SET name = ?, english_name = ?, category = ?, tier = ?, nationality = ?, 
             rating = ?, image_url = ?, cover_image_url = ?, birth_year = ?, bio = ?, style = ?,
             concert_count = ?, country_count = ?, album_count = ?
             WHERE id = ?"
        )
        .bind(artist.name.unwrap_or(current.name))
        .bind(artist.english_name.unwrap_or(current.english_name))
        .bind(artist.category.unwrap_or(current.category))
        .bind(artist.tier.unwrap_or(current.tier))
        .bind(artist.nationality.unwrap_or(current.nationality))
        .bind(artist.rating.or(current.rating))
        .bind(artist.image_url.or(current.image_url))
        .bind(artist.cover_image_url.or(current.cover_image_url))
        .bind(artist.birth_year.or(current.birth_year))
        .bind(artist.bio.or(current.bio))
        .bind(artist.style.or(current.style))
        .bind(artist.concert_count.unwrap_or(current.concert_count))
        .bind(artist.country_count.unwrap_or(current.country_count))
        .bind(artist.album_count.unwrap_or(current.album_count))
        .bind(id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete(pool: &DbPool, id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM artists WHERE id = ?")
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }
}
