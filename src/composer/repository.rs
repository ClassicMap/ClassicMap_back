use crate::db::DbPool;
use super::model::{Composer, CreateComposer};
use sqlx::Error;

pub struct ComposerRepository;

impl ComposerRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<Composer>, Error> {
        sqlx::query_as::<_, Composer>("SELECT * FROM composers")
            .fetch_all(pool)
            .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<Composer>, Error> {
        sqlx::query_as::<_, Composer>("SELECT * FROM composers WHERE id = ?")
            .bind(id)
            .fetch_optional(pool)
            .await
    }

    pub async fn create(pool: &DbPool, composer: CreateComposer) -> Result<i32, Error> {
        let result = sqlx::query(
            "INSERT INTO composers (name, full_name, english_name, period, birth_year, death_year, nationality, image_url, avatar_url, cover_image_url, bio, style, influence) 
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        )
        .bind(&composer.name)
        .bind(&composer.full_name)
        .bind(&composer.english_name)
        .bind(&composer.period)
        .bind(composer.birth_year)
        .bind(composer.death_year)
        .bind(&composer.nationality)
        .bind(&composer.image_url)
        .bind(&composer.avatar_url)
        .bind(&composer.cover_image_url)
        .bind(&composer.bio)
        .bind(&composer.style)
        .bind(&composer.influence)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn delete(pool: &DbPool, id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM composers WHERE id = ?")
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }
}
