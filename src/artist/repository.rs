use super::category::{stored_values_matching_label, CategoryFilter};
use super::model::{
    Artist, ArtistAward, ArtistWithAwards, CreateArtist, CreateArtistAward, UpdateArtist,
};
use crate::db::DbPool;
use crate::search::SearchText;
use sqlx::Error;

pub struct ArtistRepository;

impl ArtistRepository {
    pub async fn find_all(pool: &DbPool, offset: i64, limit: i64) -> Result<Vec<Artist>, Error> {
        sqlx::query_as::<_, Artist>("SELECT * FROM v_artists_full LIMIT ? OFFSET ?")
            .bind(limit)
            .bind(offset)
            .fetch_all(pool)
            .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<Artist>, Error> {
        sqlx::query_as::<_, Artist>("SELECT * FROM v_artists_full WHERE id = ?")
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
    pub async fn find_by_id_with_awards(
        pool: &DbPool,
        id: i32,
    ) -> Result<Option<ArtistWithAwards>, Error> {
        let artist_opt = Self::find_by_id(pool, id).await?;

        if let Some(artist) = artist_opt {
            let awards = Self::find_awards_by_artist(pool, id).await?;
            Ok(Some(ArtistWithAwards { artist, awards }))
        } else {
            Ok(None)
        }
    }

    // Award CRUD
    pub async fn find_awards_by_artist(
        pool: &DbPool,
        artist_id: i32,
    ) -> Result<Vec<ArtistAward>, Error> {
        sqlx::query_as::<_, ArtistAward>(
            "SELECT * FROM artist_awards WHERE artist_id = ? ORDER BY display_order, year DESC",
        )
        .bind(artist_id)
        .fetch_all(pool)
        .await
    }

    pub async fn create_award(
        pool: &DbPool,
        artist_id: i32,
        award: CreateArtistAward,
    ) -> Result<i32, Error> {
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

    /// Full-text search across artists with pagination.
    /// 검색어가 있으면 이름 관련도(완전 일치 → 접두사 → 포함 → 다른 열)를 먼저 본다.
    pub async fn search_artists_by_text(
        pool: &DbPool,
        search_query: Option<&str>,
        tier: Option<&str>,
        category: Option<&CategoryFilter>,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<Artist>, Error> {
        let search_text = SearchText::parse(search_query);
        // "피아" 같은 검색어가 분류 라벨(피아니스트)에 걸리면 그 분류의 원본 값도 찾는다.
        let label_values = search_query
            .map(stored_values_matching_label)
            .unwrap_or_default();

        let mut query = String::from("SELECT * FROM v_artists_full WHERE 1=1");

        // Text search across multiple fields
        if search_text.is_some() {
            query.push_str(
                " AND (name LIKE ? OR english_name LIKE ? OR category LIKE ? OR nationality LIKE ? OR bio LIKE ? OR style LIKE ?"
            );
            if !label_values.is_empty() {
                query.push_str(&format!(
                    " OR category IN ({})",
                    vec!["?"; label_values.len()].join(", ")
                ));
            }
            query.push(')');
        }

        // Tier filter
        if tier.is_some() {
            query.push_str(" AND tier = ?");
        }

        // Category filter: 코드에 묶인 원본 값 전부를 SQL에서 거른다.
        if let Some(filter) = category {
            query.push_str(" AND ");
            query.push_str(&filter.sql("category"));
        }

        let relevance = search_text
            .as_ref()
            .map(|text| text.name_relevance(&["name", "english_name"]));
        query.push_str(" ORDER BY ");
        if let Some((relevance_sql, _)) = &relevance {
            query.push_str(relevance_sql);
            query.push_str(", ");
        }
        query.push_str("rating DESC, tier ASC, id ASC LIMIT ? OFFSET ?");

        let mut sql_query = sqlx::query_as::<_, Artist>(&query);

        // Bind search query with wildcards
        if let Some(text) = &search_text {
            for _ in 0..6 {
                // name, english_name, category, nationality, bio, style
                sql_query = sql_query.bind(text.contains());
            }
            for value in &label_values {
                sql_query = sql_query.bind(*value);
            }
        }

        // Bind tier filter
        if let Some(t) = tier {
            sql_query = sql_query.bind(t);
        }

        // Bind category filter
        if let Some(filter) = category {
            for value in filter.values() {
                sql_query = sql_query.bind(*value);
            }
        }

        if let Some((_, relevance_binds)) = relevance {
            for value in relevance_binds {
                sql_query = sql_query.bind(value);
            }
        }

        // Bind pagination
        sql_query = sql_query.bind(limit).bind(offset);

        sql_query.fetch_all(pool).await
    }

    /// 아티스트 이름으로 검색 (한국어 이름 또는 영어 이름)
    /// cast 필드에서 추출한 이름으로 매칭할 때 사용
    pub async fn find_by_name(pool: &DbPool, name: &str) -> Result<Option<Artist>, Error> {
        sqlx::query_as::<_, Artist>(
            "SELECT * FROM v_artists_full
             WHERE name = ? OR english_name = ?
             LIMIT 1",
        )
        .bind(name)
        .bind(name)
        .fetch_optional(pool)
        .await
    }
}
