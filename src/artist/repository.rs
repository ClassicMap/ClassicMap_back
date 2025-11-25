use crate::db::DbPool;
use super::model::{Artist, CreateArtist, UpdateArtist, ArtistWithAwards, ArtistAward, CreateArtistAward};
use sqlx::Error;

pub struct ArtistRepository;

impl ArtistRepository {
        pub async fn find_all(pool: &DbPool, offset: i64, limit: i64) -> Result<Vec<Artist>, Error> {
            sqlx::query_as::<_, Artist>(
                "SELECT * FROM v_artists_full LIMIT ? OFFSET ?"
            )
                .bind(limit)
                .bind(offset)
                .fetch_all(pool)
                .await
        }
    
        pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<Artist>, Error> {
            sqlx::query_as::<_, Artist>(
                "SELECT * FROM v_artists_full WHERE id = ?"
            )
            .bind(id)
            .fetch_optional(pool)
            .await
        }
    pub async fn create(pool: &DbPool, artist: CreateArtist) -> Result<i32, Error> {
        let result = sqlx::query(
            "INSERT INTO artists (name, english_name, category, tier, nationality, rating, image_url, cover_image_url, birth_year, bio, style, concert_count, album_count, top_award_id)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
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
        .bind(artist.concert_count.unwrap_or(0))
        .bind(artist.album_count.unwrap_or(0))
        .bind(artist.top_award_id)
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
             concert_count = ?, album_count = ?, top_award_id = ?
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
        .bind(artist.album_count.unwrap_or(current.album_count))
        .bind(artist.top_award_id.or(current.top_award_id))
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

    // Artist with awards
    pub async fn find_by_id_with_awards(pool: &DbPool, id: i32) -> Result<Option<ArtistWithAwards>, Error> {
        let artist_opt = Self::find_by_id(pool, id).await?;

        if let Some(artist) = artist_opt {
            let awards = Self::find_awards_by_artist(pool, id).await?;
            Ok(Some(ArtistWithAwards { artist, awards }))
        } else {
            Ok(None)
        }
    }

    // Award CRUD
    pub async fn find_awards_by_artist(pool: &DbPool, artist_id: i32) -> Result<Vec<ArtistAward>, Error> {
        sqlx::query_as::<_, ArtistAward>(
            "SELECT * FROM artist_awards WHERE artist_id = ? ORDER BY display_order, year DESC"
        )
        .bind(artist_id)
        .fetch_all(pool)
        .await
    }

    pub async fn create_award(pool: &DbPool, artist_id: i32, award: CreateArtistAward) -> Result<i32, Error> {
        let result = sqlx::query(
            "INSERT INTO artist_awards (artist_id, year, award_name, award_type, organization, category, ranking, source, notes, display_order)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        )
        .bind(artist_id)
        .bind(&award.year)
        .bind(&award.award_name)
        .bind(&award.award_type)
        .bind(&award.organization)
        .bind(&award.category)
        .bind(&award.ranking)
        .bind(&award.source)
        .bind(&award.notes)
        .bind(award.display_order.unwrap_or(0))
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn delete_award(pool: &DbPool, award_id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM artist_awards WHERE id = ?")
            .bind(award_id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete_awards_by_artist(pool: &DbPool, artist_id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM artist_awards WHERE artist_id = ?")
            .bind(artist_id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }

    /// Full-text search across artists with pagination
    pub async fn search_artists_by_text(
        pool: &DbPool,
        search_query: Option<&str>,
        tier: Option<&str>,
        category: Option<&str>,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<Artist>, Error> {
        // Prepare search pattern early to avoid lifetime issues
        let search_pattern = search_query
            .filter(|q| !q.trim().is_empty())
            .map(|q| format!("%{}%", q));

        let mut query = String::from(
            "SELECT * FROM v_artists_full WHERE 1=1"
        );

        // Text search across multiple fields
        if search_pattern.is_some() {
            query.push_str(
                " AND (name LIKE ? OR english_name LIKE ? OR category LIKE ? OR nationality LIKE ? OR bio LIKE ? OR style LIKE ?)"
            );
        }

        // Tier filter
        if tier.is_some() {
            query.push_str(" AND tier = ?");
        }

        // Category filter
        if category.is_some() {
            query.push_str(" AND category = ?");
        }

        // Order by rating and tier
        query.push_str(" ORDER BY rating DESC, tier ASC LIMIT ? OFFSET ?");

        let mut sql_query = sqlx::query_as::<_, Artist>(&query);

        // Bind search query with wildcards
        if let Some(ref pattern) = search_pattern {
            sql_query = sql_query
                .bind(pattern) // name
                .bind(pattern) // english_name
                .bind(pattern) // category
                .bind(pattern) // nationality
                .bind(pattern) // bio
                .bind(pattern); // style
        }

        // Bind tier filter
        if let Some(t) = tier {
            sql_query = sql_query.bind(t);
        }

        // Bind category filter
        if let Some(c) = category {
            sql_query = sql_query.bind(c);
        }

        // Bind pagination
        sql_query = sql_query.bind(limit).bind(offset);

        sql_query.fetch_all(pool).await
    }
}
