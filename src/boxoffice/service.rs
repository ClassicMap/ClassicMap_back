use super::model::BoxofficeConcert;
use crate::db::DbPool;
use sqlx::Error;

pub struct BoxofficeService;

impl BoxofficeService {
    /// Get TOP 3 boxoffice concerts
    /// If area_code is None, returns national TOP 3
    /// If area_code is provided, returns TOP 3 for that area
    pub async fn get_top3(
        pool: &DbPool,
        area_code: Option<String>,
        genre_code: Option<String>,
    ) -> Result<Vec<BoxofficeConcert>, Error> {
        let mut query = String::from(
            "SELECT
                cbr.id,
                cbr.concert_id,
                cbr.ranking,
                cbr.genre_name,
                cbr.area_name,
                DATE_FORMAT(cbr.sync_start_date, '%Y-%m-%d') as sync_start_date,
                DATE_FORMAT(cbr.sync_end_date, '%Y-%m-%d') as sync_end_date,
                c.title,
                c.poster_url,
                DATE_FORMAT(c.start_date, '%Y-%m-%d') as start_date,
                DATE_FORMAT(c.end_date, '%Y-%m-%d') as end_date,
                c.concert_time,
                c.facility_name,
                c.status,
                c.rating,
                c.rating_count,
                c.genre,
                c.area
             FROM concert_boxoffice_rankings cbr
             JOIN concerts c ON cbr.concert_id = c.id
             WHERE cbr.is_featured = TRUE
               AND c.status IN ('upcoming', 'ongoing')
               AND c.start_date >= CURDATE()"
        );

        let mut bindings: Vec<String> = Vec::new();

        // Genre filter (default: CCCA for 클래식)
        let genre = genre_code.unwrap_or_else(|| "CCCA".to_string());
        query.push_str(" AND cbr.kopis_genre_code = ?");
        bindings.push(genre);

        // Area filter
        if let Some(area) = area_code {
            // 특정 지역 필터
            query.push_str(" AND cbr.kopis_area_code = ?");
            bindings.push(area);
        } else {
            // area_code가 없으면 전국 순위만 (area_code가 NULL인 레코드)
            query.push_str(" AND cbr.kopis_area_code IS NULL");
        }

        query.push_str(" ORDER BY cbr.ranking ASC LIMIT 3");

        let mut q = sqlx::query_as::<_, BoxofficeConcert>(&query);
        for binding in bindings {
            q = q.bind(binding);
        }

        q.fetch_all(pool).await
    }
}
