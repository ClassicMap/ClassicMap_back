use crate::db::DbPool;
use sqlx::Error;
use chrono::NaiveDate;

pub struct BoxofficeRepository;

impl BoxofficeRepository {
    /// 특정 기간의 순위 데이터 삭제 (새 데이터로 교체하기 전)
    pub async fn delete_rankings_for_period(
        pool: &DbPool,
        start_date: &str,
        end_date: &str,
        genre_code: Option<&str>,
        area_code: Option<&str>,
    ) -> Result<u64, Error> {
        let mut query = String::from("DELETE FROM concert_boxoffice_rankings WHERE sync_start_date = ? AND sync_end_date = ?");
        let mut bindings: Vec<String> = vec![start_date.to_string(), end_date.to_string()];

        if let Some(genre) = genre_code {
            query.push_str(" AND kopis_genre_code = ?");
            bindings.push(genre.to_string());
        }

        if let Some(area) = area_code {
            query.push_str(" AND kopis_area_code = ?");
            bindings.push(area.to_string());
        }

        let mut q = sqlx::query(&query);
        for binding in bindings {
            q = q.bind(binding);
        }

        let result = q.execute(pool).await?;
        Ok(result.rows_affected())
    }

    /// 순위 데이터 삽입 (DEPRECATED: upsert_ranking 사용 권장)
    pub async fn insert_ranking(
        pool: &DbPool,
        concert_id: i32,
        kopis_genre_code: Option<&str>,
        genre_name: Option<&str>,
        kopis_area_code: Option<&str>,
        area_name: Option<&str>,
        ranking: i32,
        seat_scale: Option<&str>,
        performance_count: i32,
        venue_name: Option<&str>,
        seat_count: Option<i32>,
        sync_start_date: &str,
        sync_end_date: &str,
    ) -> Result<i64, Error> {
        let result = sqlx::query(
            "INSERT INTO concert_boxoffice_rankings (
                concert_id, kopis_genre_code, genre_name,
                kopis_area_code, area_name, ranking, seat_scale,
                performance_count, venue_name, seat_count,
                sync_start_date, sync_end_date, is_featured
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        )
        .bind(concert_id)
        .bind(kopis_genre_code)
        .bind(genre_name)
        .bind(kopis_area_code)
        .bind(area_name)
        .bind(ranking)
        .bind(seat_scale)
        .bind(performance_count)
        .bind(venue_name)
        .bind(seat_count)
        .bind(sync_start_date)
        .bind(sync_end_date)
        .bind(ranking <= 3) // TOP 3만 featured
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i64)
    }

    /// 순위 데이터 UPSERT (장르/지역별 1, 2, 3등 슬롯 업데이트)
    pub async fn upsert_ranking(
        pool: &DbPool,
        concert_id: i32,
        kopis_genre_code: Option<&str>,
        genre_name: Option<&str>,
        kopis_area_code: Option<&str>,
        area_name: Option<&str>,
        ranking: i32,
        seat_scale: Option<&str>,
        performance_count: i32,
        venue_name: Option<&str>,
        seat_count: Option<i32>,
        sync_start_date: &str,
        sync_end_date: &str,
    ) -> Result<u64, Error> {
        let result = sqlx::query(
            "INSERT INTO concert_boxoffice_rankings (
                concert_id, kopis_genre_code, genre_name,
                kopis_area_code, area_name, ranking, seat_scale,
                performance_count, venue_name, seat_count,
                sync_start_date, sync_end_date, is_featured
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE
                concert_id = VALUES(concert_id),
                genre_name = VALUES(genre_name),
                area_name = VALUES(area_name),
                seat_scale = VALUES(seat_scale),
                performance_count = VALUES(performance_count),
                venue_name = VALUES(venue_name),
                seat_count = VALUES(seat_count),
                sync_start_date = VALUES(sync_start_date),
                sync_end_date = VALUES(sync_end_date),
                is_featured = VALUES(is_featured),
                synced_at = CURRENT_TIMESTAMP"
        )
        .bind(concert_id)
        .bind(kopis_genre_code)
        .bind(genre_name)
        .bind(kopis_area_code)
        .bind(area_name)
        .bind(ranking)
        .bind(seat_scale)
        .bind(performance_count)
        .bind(venue_name)
        .bind(seat_count)
        .bind(sync_start_date)
        .bind(sync_end_date)
        .bind(ranking <= 3) // TOP 3만 featured
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    /// 장르/지역별 현재 주목 공연 (TOP 3) 조회
    pub async fn get_featured_concerts(
        pool: &DbPool,
        genre_code: Option<&str>,
        area_code: Option<&str>,
        limit: i32,
    ) -> Result<Vec<FeaturedConcert>, Error> {
        let mut query = String::from(
            "SELECT
                cbr.id, cbr.concert_id, cbr.ranking,
                cbr.genre_name, cbr.area_name,
                cbr.sync_start_date, cbr.sync_end_date,
                c.title, c.poster_url, c.start_date, c.end_date
             FROM concert_boxoffice_rankings cbr
             JOIN concerts c ON cbr.concert_id = c.id
             WHERE cbr.is_featured = TRUE"
        );

        let mut bindings: Vec<String> = Vec::new();

        if let Some(genre) = genre_code {
            query.push_str(" AND cbr.kopis_genre_code = ?");
            bindings.push(genre.to_string());
        }

        if let Some(area) = area_code {
            query.push_str(" AND cbr.kopis_area_code = ?");
            bindings.push(area.to_string());
        }

        query.push_str(" ORDER BY cbr.ranking ASC LIMIT ?");
        bindings.push(limit.to_string());

        let mut q = sqlx::query_as::<_, FeaturedConcert>(&query);
        for binding in bindings {
            q = q.bind(binding);
        }

        q.fetch_all(pool).await
    }
}

#[derive(Debug, sqlx::FromRow)]
pub struct FeaturedConcert {
    pub id: i32,
    pub concert_id: i32,
    pub ranking: i32,
    pub genre_name: Option<String>,
    pub area_name: Option<String>,
    pub sync_start_date: NaiveDate,
    pub sync_end_date: NaiveDate,
    pub title: String,
    pub poster_url: Option<String>,
    pub start_date: NaiveDate,
    pub end_date: Option<NaiveDate>,
}
