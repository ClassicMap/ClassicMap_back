use crate::db::DbPool;
use super::model::{Composer, CreateComposer, UpdateComposer, ComposerWithMajorPieces};
use sqlx::Error;

pub struct ComposerRepository;

impl ComposerRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<Composer>, Error> {
        sqlx::query_as::<_, Composer>("SELECT * FROM composers")
            .fetch_all(pool)
            .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<ComposerWithMajorPieces>, Error> {
        sqlx::query_as::<_, ComposerWithMajorPieces>("SELECT * FROM v_composers_full WHERE id = ?")
            .bind(id)
            .fetch_optional(pool)
            .await
    }

    pub async fn create(pool: &DbPool, composer: CreateComposer) -> Result<i32, Error> {
        let result = sqlx::query(
            "INSERT INTO composers (name, full_name, english_name, period, tier, birth_year, death_year, nationality, avatar_url, cover_image_url, bio, style, influence)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        )
        .bind(&composer.name)
        .bind(&composer.full_name)
        .bind(&composer.english_name)
        .bind(&composer.period)
        .bind(&composer.tier)
        .bind(composer.birth_year)
        .bind(composer.death_year)
        .bind(&composer.nationality)
        .bind(&composer.avatar_url)
        .bind(&composer.cover_image_url)
        .bind(&composer.bio)
        .bind(&composer.style)
        .bind(&composer.influence)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn update(pool: &DbPool, id: i32, composer: UpdateComposer) -> Result<u64, Error> {
        let current = Self::find_by_id(pool, id).await?;
        if current.is_none() {
            return Ok(0);
        }
        let current = current.unwrap();

        let result = sqlx::query(
            "UPDATE composers SET name = ?, full_name = ?, english_name = ?, period = ?, tier = ?,
             birth_year = ?, death_year = ?, nationality = ?, avatar_url = ?,
             cover_image_url = ?, bio = ?, style = ?, influence = ?
             WHERE id = ?"
        )
        .bind(composer.name.unwrap_or(current.name))
        .bind(composer.full_name.unwrap_or(current.full_name))
        .bind(composer.english_name.unwrap_or(current.english_name))
        .bind(composer.period.unwrap_or(current.period))
        .bind(composer.tier.or(current.tier))
        .bind(composer.birth_year.unwrap_or(current.birth_year))
        .bind(composer.death_year.or(current.death_year))
        .bind(composer.nationality.unwrap_or(current.nationality))
        .bind(composer.avatar_url.or(current.avatar_url))
        .bind(composer.cover_image_url.or(current.cover_image_url))
        .bind(composer.bio.or(current.bio))
        .bind(composer.style.or(current.style))
        .bind(composer.influence.or(current.influence))
        .bind(id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete(pool: &DbPool, id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM composers WHERE id = ?")
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }
}
