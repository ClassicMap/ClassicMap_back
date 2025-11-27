use crate::db::DbPool;
use super::model::{Composer, CreateComposer, UpdateComposer, ComposerWithMajorPieces};
use sqlx::Error;

pub struct ComposerRepository;

impl ComposerRepository {
    pub async fn find_all(pool: &DbPool, offset: i64, limit: i64) -> Result<Vec<Composer>, Error> {
        sqlx::query_as::<_, Composer>(
            "SELECT c.*, COUNT(p.id) as piece_count
             FROM composers c
             LEFT JOIN pieces p ON c.id = p.composer_id
             GROUP BY c.id
             ORDER BY c.birth_year ASC
             LIMIT ? OFFSET ?"
        )
            .bind(limit)
            .bind(offset)
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

    pub async fn search_composers(
        pool: &DbPool,
        query: Option<String>,
        period: Option<String>,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<Composer>, Error> {
        let mut sql = String::from(
            "SELECT c.*, COUNT(p.id) as piece_count
             FROM composers c
             LEFT JOIN pieces p ON c.id = p.composer_id"
        );

        let mut where_clauses = Vec::new();
        let mut bind_values: Vec<String> = Vec::new();

        // Add search condition if query provided
        if let Some(q) = query {
            let trimmed = q.trim();
            if !trimmed.is_empty() {
                where_clauses.push(
                    "(c.name LIKE ? OR c.full_name LIKE ? OR c.english_name LIKE ?)".to_string()
                );
                let search_pattern = format!("%{}%", trimmed);
                bind_values.push(search_pattern.clone());
                bind_values.push(search_pattern.clone());
                bind_values.push(search_pattern);
            }
        }

        // Add period filter if provided and not 'all'
        if let Some(p) = period {
            if p != "all" {
                where_clauses.push("c.period = ?".to_string());
                bind_values.push(p);
            }
        }

        // Append WHERE clause if conditions exist
        if !where_clauses.is_empty() {
            sql.push_str(&format!(" WHERE {}", where_clauses.join(" AND ")));
        }

        sql.push_str(" GROUP BY c.id ORDER BY c.birth_year ASC LIMIT ? OFFSET ?");

        // Build query with dynamic bindings
        let mut query = sqlx::query_as::<_, Composer>(&sql);

        // Bind all search/filter values
        for value in bind_values {
            query = query.bind(value);
        }

        // Bind limit and offset
        query = query.bind(limit).bind(offset);

        query.fetch_all(pool).await
    }
}
