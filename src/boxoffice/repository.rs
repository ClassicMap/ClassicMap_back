use crate::db::DbPool;
use chrono::NaiveDate;
use sqlx::Error;

pub struct BoxofficeRepository;

/// 한 지역 순위 칸 하나. ranking 은 KOPIS 순위를 그대로 둔다(앞 순위가 빠지면 4위 이상일 수 있다)
#[derive(Debug, Clone)]
pub struct RankingSlot {
    pub concert_id: i32,
    pub ranking: i32,
    pub genre_name: String,
    pub area_name: String,
    pub performance_count: i32,
    pub venue_name: String,
    pub seat_count: Option<i32>,
}

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

    /// 한 장르·지역의 순위 칸을 통째로 바꾼다. 새 순위에 없는 옛 공연이 남지 않게 지우고 넣는다.
    /// slots 가 비어 있으면 그 지역 순위는 비운다
    pub async fn replace_area_rankings(
        pool: &DbPool,
        kopis_genre_code: &str,
        kopis_area_code: &str,
        slots: &[RankingSlot],
        sync_start_date: &str,
        sync_end_date: &str,
    ) -> Result<(), Error> {
        let mut tx = pool.begin().await?;
        sqlx::query(
            "DELETE FROM concert_boxoffice_rankings WHERE kopis_genre_code = ? AND kopis_area_code = ?",
        )
        .bind(kopis_genre_code)
        .bind(kopis_area_code)
        .execute(&mut *tx)
        .await?;
        for slot in slots {
            sqlx::query(
                "INSERT INTO concert_boxoffice_rankings (
                    concert_id, kopis_genre_code, genre_name,
                    kopis_area_code, area_name, ranking,
                    performance_count, venue_name, seat_count,
                    sync_start_date, sync_end_date, is_featured
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, TRUE)",
            )
            .bind(slot.concert_id)
            .bind(kopis_genre_code)
            .bind(&slot.genre_name)
            .bind(kopis_area_code)
            .bind(&slot.area_name)
            .bind(slot.ranking)
            .bind(slot.performance_count)
            .bind(&slot.venue_name)
            .bind(slot.seat_count)
            .bind(sync_start_date)
            .bind(sync_end_date)
            .execute(&mut *tx)
            .await?;
        }
        tx.commit().await
    }

    /// 순위 데이터 UPSERT (장르/지역별 1, 2, 3등 슬롯 업데이트)
    #[allow(clippy::too_many_arguments)] // KOPIS 순위 칸을 그대로 받는다
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
                synced_at = CURRENT_TIMESTAMP",
        )
        .bind(concert_id)
        .bind(kopis_genre_code)
        .bind(genre_name)
        .bind(kopis_area_code.unwrap_or("00"))
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

        println!(
            "concert_id: {}, kopis_genre_code: {:?}, kopis_area_code: {:?}, ranking: {}",
            concert_id,
            kopis_genre_code,
            kopis_area_code.unwrap_or("00"),
            ranking,
        );

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
             WHERE cbr.is_featured = TRUE",
        );

        let mut bindings: Vec<String> = Vec::new();

        if let Some(genre) = genre_code {
            query.push_str(" AND cbr.kopis_genre_code = ?");
            bindings.push(genre.to_string());
        }

        // Area filter
        if let Some(area) = area_code {
            // 특정 지역 필터
            query.push_str(" AND cbr.kopis_area_code = ?");
            bindings.push(area.to_string());
        } else {
            // area_code가 없으면 전국 순위만 (area_code가 NULL인 레코드)
            query.push_str(" AND cbr.kopis_area_code IS NULL");
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
