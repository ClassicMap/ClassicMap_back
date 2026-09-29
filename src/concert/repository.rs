use super::model::{
    Concert, ConcertArtist, ConcertArtistSummary, ConcertBoxofficeRanking, ConcertImage,
    ConcertListItem, ConcertTicketVendor, ConcertWithArtists, ConcertWithDetails, CreateConcert,
    UpdateConcert,
};
use crate::db::DbPool;
use chrono::NaiveDate;
use rust_decimal::Decimal;
use sqlx::Error;

pub struct ConcertRepository;

impl ConcertRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<Concert>, Error> {
        sqlx::query_as::<_, Concert>(
            "SELECT id, title, composer_info, venue_id,
             DATE_FORMAT(start_date, '%Y-%m-%d') as start_date,
             DATE_FORMAT(end_date, '%Y-%m-%d') as end_date,
             concert_time,
             price_info, poster_url, program, status, rating, rating_count,
             kopis_id, DATE_FORMAT(kopis_updated_at, '%Y-%m-%d %H:%i:%s') as kopis_updated_at, data_source, venue_kopis_id,
             genre, area, facility_name, is_open_run,
             cast, crew, runtime, age_restriction, synopsis, performance_schedule,
             production_company, production_company_plan, production_company_agency,
             production_company_host, production_company_sponsor,
             is_visit, is_child, is_daehakro, is_festival
             FROM concerts"
        )
            .fetch_all(pool)
            .await
    }

    // List view with only essential fields for performance
    pub async fn find_all_list_view(
        pool: &DbPool,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<ConcertListItem>, Error> {
        sqlx::query_as::<_, ConcertListItem>(
            "SELECT c.id, c.title, c.venue_id,
             DATE_FORMAT(c.start_date, '%Y-%m-%d') as start_date,
             DATE_FORMAT(c.end_date, '%Y-%m-%d') as end_date,
             c.concert_time,
             c.poster_url, c.status, c.rating, c.rating_count,
             c.genre, c.area, c.facility_name, c.is_open_run, c.is_visit, c.is_festival, c.instrumentation,
             cbr.ranking as boxoffice_ranking
             FROM concerts c
             LEFT JOIN concert_boxoffice_rankings cbr ON c.id = cbr.concert_id
             ORDER BY
               CASE WHEN c.start_date >= DATE(CONVERT_TZ(NOW(), '+00:00', '+09:00')) THEN 0 ELSE 1 END,
               ABS(DATEDIFF(c.start_date, DATE(CONVERT_TZ(NOW(), '+00:00', '+09:00')))) ASC
             LIMIT ? OFFSET ?",
        )
        .bind(limit)
        .bind(offset)
        .fetch_all(pool)
        .await
    }

    pub async fn find_all_with_artists(pool: &DbPool) -> Result<Vec<ConcertWithArtists>, Error> {
        let concerts = Self::find_all(pool).await?;
        let mut result = Vec::new();

        for concert in concerts {
            let artists = Self::find_artists_by_concert(pool, concert.id).await?;
            result.push(ConcertWithArtists { concert, artists });
        }

        Ok(result)
    }

    pub async fn find_artists_by_concert(
        pool: &DbPool,
        concert_id: i32,
    ) -> Result<Vec<ConcertArtist>, Error> {
        sqlx::query_as::<_, ConcertArtist>(
            "SELECT ca.id, ca.concert_id, ca.artist_id, a.name as artist_name, ca.role
             FROM concert_artists ca
             INNER JOIN artists a ON ca.artist_id = a.id
             WHERE ca.concert_id = ?
             ORDER BY ca.id",
        )
        .bind(concert_id)
        .fetch_all(pool)
        .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<Concert>, Error> {
        sqlx::query_as::<_, Concert>(
            "SELECT id, title, composer_info, venue_id,
             DATE_FORMAT(start_date, '%Y-%m-%d') as start_date,
             DATE_FORMAT(end_date, '%Y-%m-%d') as end_date,
             concert_time,
             price_info, poster_url, program, status, rating, rating_count,
             kopis_id, DATE_FORMAT(kopis_updated_at, '%Y-%m-%d %H:%i:%s') as kopis_updated_at, data_source, venue_kopis_id,
             genre, area, facility_name, is_open_run,
             cast, crew, runtime, age_restriction, synopsis, performance_schedule,
             production_company, production_company_plan, production_company_agency,
             production_company_host, production_company_sponsor,
             is_visit, is_child, is_daehakro, is_festival
             FROM concerts WHERE id = ?"
        )
            .bind(id)
            .fetch_optional(pool)
            .await
    }

    pub async fn find_by_id_with_artists(
        pool: &DbPool,
        id: i32,
    ) -> Result<Option<ConcertWithArtists>, Error> {
        let concert_opt = Self::find_by_id(pool, id).await?;

        if let Some(concert) = concert_opt {
            let artists = Self::find_artists_by_concert(pool, id).await?;
            Ok(Some(ConcertWithArtists { concert, artists }))
        } else {
            Ok(None)
        }
    }

    pub async fn find_by_artist(pool: &DbPool, artist_id: i32) -> Result<Vec<Concert>, Error> {
        sqlx::query_as::<_, Concert>(
            "SELECT c.id, c.title, c.composer_info, c.venue_id,
             DATE_FORMAT(c.start_date, '%Y-%m-%d') as start_date,
             DATE_FORMAT(c.end_date, '%Y-%m-%d') as end_date,
             c.concert_time,
             c.price_info, c.poster_url, c.program, c.status, c.rating, c.rating_count,
             c.kopis_id, DATE_FORMAT(c.kopis_updated_at, '%Y-%m-%d %H:%i:%s') as kopis_updated_at, c.data_source, c.venue_kopis_id,
             c.genre, c.area, c.facility_name, c.is_open_run,
             c.cast, c.crew, c.runtime, c.age_restriction, c.synopsis, c.performance_schedule,
             c.production_company, c.production_company_plan, c.production_company_agency,
             c.production_company_host, c.production_company_sponsor,
             c.is_visit, c.is_child, c.is_daehakro, c.is_festival
             FROM concerts c
             INNER JOIN concert_artists ca ON c.id = ca.concert_id
             WHERE ca.artist_id = ?
             AND c.start_date >= DATE_SUB(DATE(CONVERT_TZ(NOW(), '+00:00', '+09:00')), INTERVAL 2 MONTH)
             ORDER BY c.start_date DESC"
        )
            .bind(artist_id)
            .fetch_all(pool)
            .await
    }

    pub async fn create(pool: &DbPool, concert: CreateConcert) -> Result<i32, Error> {
        let result = sqlx::query(
            "INSERT INTO concerts (title, composer_info, venue_id, start_date, end_date, concert_time, price_info, poster_url, program, status, data_source)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'MANUAL')"
        )
        .bind(&concert.title)
        .bind(&concert.composer_info)
        .bind(concert.venue_id)
        .bind(&concert.start_date)
        .bind(&concert.end_date)
        .bind(&concert.concert_time)
        .bind(&concert.price_info)
        .bind(&concert.poster_url)
        .bind(&concert.program)
        .bind(&concert.status)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn update(pool: &DbPool, id: i32, concert: UpdateConcert) -> Result<u64, Error> {
        let current = Self::find_by_id(pool, id).await?;
        if current.is_none() {
            return Ok(0);
        }
        let current = current.unwrap();

        let result = sqlx::query(
            "UPDATE concerts SET title = ?, composer_info = ?, venue_id = ?,
             start_date = ?, end_date = ?, concert_time = ?, price_info = ?, poster_url = ?,
             program = ?, status = ?
             WHERE id = ?",
        )
        .bind(concert.title.unwrap_or(current.title))
        .bind(concert.composer_info.or(current.composer_info))
        .bind(concert.venue_id.unwrap_or(current.venue_id))
        .bind(concert.start_date.unwrap_or(current.start_date))
        .bind(concert.end_date.or(current.end_date))
        .bind(concert.concert_time.or(current.concert_time))
        .bind(concert.price_info.or(current.price_info))
        .bind(concert.poster_url.or(current.poster_url))
        .bind(concert.program.or(current.program))
        .bind(concert.status.unwrap_or(current.status))
        .bind(id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete(pool: &DbPool, id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM concerts WHERE id = ?")
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }

    pub async fn submit_rating(
        pool: &DbPool,
        user_id: i32,
        concert_id: i32,
        rating: f32,
    ) -> Result<(), Error> {
        sqlx::query(
            "INSERT INTO user_concert_ratings (user_id, concert_id, rating)
             VALUES (?, ?, ?)
             ON DUPLICATE KEY UPDATE rating = ?, updated_at = CURRENT_TIMESTAMP",
        )
        .bind(user_id)
        .bind(concert_id)
        .bind(rating)
        .bind(rating)
        .execute(pool)
        .await?;

        // 평균 평점 업데이트
        Self::update_average_rating(pool, concert_id).await?;

        Ok(())
    }

    pub async fn get_user_rating(
        pool: &DbPool,
        user_id: i32,
        concert_id: i32,
    ) -> Result<Option<Decimal>, Error> {
        let result: Option<(Decimal,)> = sqlx::query_as(
            "SELECT rating FROM user_concert_ratings WHERE user_id = ? AND concert_id = ?",
        )
        .bind(user_id)
        .bind(concert_id)
        .fetch_optional(pool)
        .await?;

        Ok(result.map(|(rating,)| rating))
    }

    async fn update_average_rating(pool: &DbPool, concert_id: i32) -> Result<(), Error> {
        sqlx::query(
            "UPDATE concerts c
             SET rating = (SELECT AVG(rating) FROM user_concert_ratings WHERE concert_id = ?),
                 rating_count = (SELECT COUNT(*) FROM user_concert_ratings WHERE concert_id = ?)
             WHERE id = ?",
        )
        .bind(concert_id)
        .bind(concert_id)
        .bind(concert_id)
        .execute(pool)
        .await?;

        Ok(())
    }

    // ============================================
    // KOPIS 연동 전용 메소드
    // ============================================

    /// KOPIS ID로 공연 조회
    pub async fn get_by_kopis_id(pool: &DbPool, kopis_id: &str) -> Result<Option<Concert>, Error> {
        sqlx::query_as::<_, Concert>(
            "SELECT id, title, composer_info, venue_id,
             DATE_FORMAT(start_date, '%Y-%m-%d') as start_date,
             DATE_FORMAT(end_date, '%Y-%m-%d') as end_date,
             concert_time,
             price_info, poster_url, program, status, rating, rating_count,
             kopis_id, DATE_FORMAT(kopis_updated_at, '%Y-%m-%d %H:%i:%s') as kopis_updated_at, data_source, venue_kopis_id,
             genre, area, facility_name, is_open_run,
             cast, crew, runtime, age_restriction, synopsis, performance_schedule,
             production_company, production_company_plan, production_company_agency,
             production_company_host, production_company_sponsor,
             is_visit, is_child, is_daehakro, is_festival
             FROM concerts WHERE kopis_id = ?"
        )
        .bind(kopis_id)
        .fetch_optional(pool)
        .await
    }

    /// venue의 kopis_id로 venue_id 조회
    pub async fn get_venue_id_by_kopis_id(
        pool: &DbPool,
        venue_kopis_id: &str,
    ) -> Result<Option<i32>, Error> {
        let result: Option<(i32,)> = sqlx::query_as("SELECT id FROM venues WHERE kopis_id = ?")
            .bind(venue_kopis_id)
            .fetch_optional(pool)
            .await?;

        Ok(result.map(|(id,)| id))
    }

    /// KOPIS 공연 데이터 upsert (있으면 업데이트, 없으면 삽입)
    pub async fn upsert_kopis_concert(
        pool: &DbPool,
        kopis_id: &str,
        title: &str,
        composer_info: Option<&str>,
        venue_id: i32,
        start_date: &str,
        end_date: Option<&str>,
        concert_time: Option<&str>,
        poster_url: Option<&str>,
        program: Option<&str>,
        price_info: Option<&str>,
        status: &str,
        // KOPIS 추가 필드들
        venue_kopis_id: &str,
        kopis_updated_at: Option<&str>,
        genre: Option<&str>,
        area: Option<&str>,
        facility_name: Option<&str>,
        is_open_run: bool,
        cast: Option<&str>,
        crew: Option<&str>,
        runtime: Option<&str>,
        age_restriction: Option<&str>,
        synopsis: Option<&str>,
        performance_schedule: Option<&str>,
        production_company: Option<&str>,
        production_company_plan: Option<&str>,
        production_company_agency: Option<&str>,
        production_company_host: Option<&str>,
        production_company_sponsor: Option<&str>,
        is_visit: bool,
        is_child: bool,
        is_daehakro: bool,
        is_festival: bool,
    ) -> Result<i32, Error> {
        // 기존 레코드 확인
        let existing = Self::get_by_kopis_id(pool, kopis_id).await?;

        if let Some(concert) = existing {
            // 업데이트
            sqlx::query(
                "UPDATE concerts SET
                 title = ?, composer_info = COALESCE(?, composer_info), venue_id = ?,
                 start_date = ?, end_date = ?, concert_time = ?,
                 poster_url = ?, program = ?, price_info = ?, status = ?,
                 venue_kopis_id = ?, kopis_updated_at = ?,
                 genre = ?, area = ?, facility_name = ?, is_open_run = ?,
                 cast = ?, crew = ?, runtime = ?, age_restriction = ?,
                 synopsis = ?, performance_schedule = ?,
                 production_company = ?, production_company_plan = ?,
                 production_company_agency = ?, production_company_host = ?,
                 production_company_sponsor = ?,
                 is_visit = ?, is_child = ?, is_daehakro = ?, is_festival = ?,
                 updated_at = CURRENT_TIMESTAMP
                 WHERE kopis_id = ?",
            )
            .bind(title)
            .bind(composer_info)
            .bind(venue_id)
            .bind(start_date)
            .bind(end_date)
            .bind(concert_time)
            .bind(poster_url)
            .bind(program)
            .bind(price_info)
            .bind(status)
            .bind(venue_kopis_id)
            .bind(kopis_updated_at)
            .bind(genre)
            .bind(area)
            .bind(facility_name)
            .bind(is_open_run)
            .bind(cast)
            .bind(crew)
            .bind(runtime)
            .bind(age_restriction)
            .bind(synopsis)
            .bind(performance_schedule)
            .bind(production_company)
            .bind(production_company_plan)
            .bind(production_company_agency)
            .bind(production_company_host)
            .bind(production_company_sponsor)
            .bind(is_visit)
            .bind(is_child)
            .bind(is_daehakro)
            .bind(is_festival)
            .bind(kopis_id)
            .execute(pool)
            .await?;

            Ok(concert.id)
        } else {
            // 삽입
            let result = sqlx::query(
                "INSERT INTO concerts (
                    kopis_id, title, composer_info, venue_id,
                    start_date, end_date, concert_time,
                    poster_url, program, price_info, status,
                    venue_kopis_id, kopis_updated_at,
                    genre, area, facility_name, is_open_run,
                    cast, crew, runtime, age_restriction,
                    synopsis, performance_schedule,
                    production_company, production_company_plan,
                    production_company_agency, production_company_host,
                    production_company_sponsor,
                    is_visit, is_child, is_daehakro, is_festival,
                    data_source
                ) VALUES (
                    ?, ?, ?, ?,
                    ?, ?, ?,
                    ?, ?, ?, ?,
                    ?, ?,
                    ?, ?, ?, ?,
                    ?, ?, ?, ?,
                    ?, ?,
                    ?, ?,
                    ?, ?,
                    ?,
                    ?, ?, ?, ?,
                    'KOPIS'
                )",
            )
            .bind(kopis_id)
            .bind(title)
            .bind(composer_info)
            .bind(venue_id)
            .bind(start_date)
            .bind(end_date)
            .bind(concert_time)
            .bind(poster_url)
            .bind(program)
            .bind(price_info)
            .bind(status)
            .bind(venue_kopis_id)
            .bind(kopis_updated_at)
            .bind(genre)
            .bind(area)
            .bind(facility_name)
            .bind(is_open_run)
            .bind(cast)
            .bind(crew)
            .bind(runtime)
            .bind(age_restriction)
            .bind(synopsis)
            .bind(performance_schedule)
            .bind(production_company)
            .bind(production_company_plan)
            .bind(production_company_agency)
            .bind(production_company_host)
            .bind(production_company_sponsor)
            .bind(is_visit)
            .bind(is_child)
            .bind(is_daehakro)
            .bind(is_festival)
            .execute(pool)
            .await?;

            Ok(result.last_insert_id() as i32)
        }
    }

    // ============================================
    // Ticket Vendors 관련 메소드
    // ============================================

    pub async fn find_ticket_vendors_by_concert(
        pool: &DbPool,
        concert_id: i32,
    ) -> Result<Vec<ConcertTicketVendor>, Error> {
        sqlx::query_as::<_, ConcertTicketVendor>(
            "SELECT id, concert_id, vendor_name, vendor_url, display_order
             FROM concert_ticket_vendors
             WHERE concert_id = ?
             ORDER BY display_order",
        )
        .bind(concert_id)
        .fetch_all(pool)
        .await
    }

    // ============================================
    // Concert Images 관련 메소드
    // ============================================

    pub async fn find_images_by_concert(
        pool: &DbPool,
        concert_id: i32,
    ) -> Result<Vec<ConcertImage>, Error> {
        sqlx::query_as::<_, ConcertImage>(
            "SELECT id, concert_id, image_url, image_type, display_order
             FROM concert_images
             WHERE concert_id = ?
             ORDER BY display_order",
        )
        .bind(concert_id)
        .fetch_all(pool)
        .await
    }

    // ============================================
    // Boxoffice Rankings 관련 메소드
    // ============================================

    pub async fn find_boxoffice_ranking_by_concert(
        pool: &DbPool,
        concert_id: i32,
    ) -> Result<Option<ConcertBoxofficeRanking>, Error> {
        sqlx::query_as::<_, ConcertBoxofficeRanking>(
            "SELECT id, concert_id, kopis_genre_code, genre_name, kopis_area_code, area_name,
             ranking, seat_scale, performance_count, venue_name, seat_count,
             DATE_FORMAT(sync_start_date, '%Y-%m-%d') as sync_start_date,
             DATE_FORMAT(sync_end_date, '%Y-%m-%d') as sync_end_date,
             synced_at, is_featured
             FROM concert_boxoffice_rankings
             WHERE concert_id = ?
             ORDER BY synced_at DESC
             LIMIT 1",
        )
        .bind(concert_id)
        .fetch_optional(pool)
        .await
    }

    // ============================================
    // With Details (Full Data) 메소드
    // ============================================

    pub async fn find_by_id_with_details(
        pool: &DbPool,
        id: i32,
    ) -> Result<Option<ConcertWithDetails>, Error> {
        let concert_opt = Self::find_by_id(pool, id).await?;

        if let Some(concert) = concert_opt {
            let artists = Self::find_artists_by_concert(pool, id).await?;
            let ticket_vendors = Self::find_ticket_vendors_by_concert(pool, id).await?;
            let images = Self::find_images_by_concert(pool, id).await?;
            let boxoffice_ranking = Self::find_boxoffice_ranking_by_concert(pool, id).await?;

            Ok(Some(ConcertWithDetails {
                concert,
                artists,
                ticket_vendors,
                images,
                boxoffice_ranking,
            }))
        } else {
            Ok(None)
        }
    }

    // ============================================
    // Featured Concerts (예매 순위 TOP)
    // ============================================

    pub async fn find_featured_concerts(
        pool: &DbPool,
        area_code: Option<&str>,
        limit: i32,
    ) -> Result<Vec<ConcertWithDetails>, Error> {
        // MySQL 8은 SELECT DISTINCT에 없는 컬럼으로 ORDER BY 하면 3065 오류를 낸다.
        // 한 공연이 여러 순위 행(장르·지역)에 걸릴 수 있어 공연별로 묶고 가장 높은 순위로 정렬한다.
        let query = if area_code.is_some() {
            "SELECT c.id
             FROM concerts c
             INNER JOIN concert_boxoffice_rankings cbr ON c.id = cbr.concert_id
             WHERE cbr.is_featured = true
             AND cbr.kopis_area_code = ?
             AND c.start_date >= DATE(CONVERT_TZ(NOW(), '+00:00', '+09:00'))
             GROUP BY c.id
             ORDER BY MIN(cbr.ranking) ASC, c.id ASC
             LIMIT ?"
        } else {
            "SELECT c.id
             FROM concerts c
             INNER JOIN concert_boxoffice_rankings cbr ON c.id = cbr.concert_id
             WHERE cbr.is_featured = true
             AND c.start_date >= DATE(CONVERT_TZ(NOW(), '+00:00', '+09:00'))
             GROUP BY c.id
             ORDER BY MIN(cbr.ranking) ASC, c.id ASC
             LIMIT ?"
        };

        let concert_ids: Vec<(i32,)> = if let Some(code) = area_code {
            sqlx::query_as(query)
                .bind(code)
                .bind(limit)
                .fetch_all(pool)
                .await?
        } else {
            sqlx::query_as(query).bind(limit).fetch_all(pool).await?
        };

        let mut result = Vec::new();
        for (concert_id,) in concert_ids {
            if let Some(concert_details) = Self::find_by_id_with_details(pool, concert_id).await? {
                result.push(concert_details);
            }
        }

        Ok(result)
    }

    // ============================================
    // Upcoming Concerts (다가오는 공연)
    // ============================================

    pub async fn find_upcoming_concerts(
        pool: &DbPool,
        sort_by: &str,
        limit: i32,
    ) -> Result<Vec<ConcertListItem>, Error> {
        let order_clause = match sort_by {
            "rating" => "ORDER BY c.rating DESC, c.start_date ASC",
            "date" | _ => "ORDER BY c.start_date ASC",
        };

        let query = format!(
            "SELECT c.id, c.title, c.venue_id,
             DATE_FORMAT(c.start_date, '%Y-%m-%d') as start_date,
             DATE_FORMAT(c.end_date, '%Y-%m-%d') as end_date,
             c.concert_time,
             c.poster_url, c.status, c.rating, c.rating_count,
             c.genre, c.area, c.facility_name, c.is_open_run, c.is_visit, c.is_festival, c.instrumentation,
             cbr.ranking as boxoffice_ranking
             FROM concerts c
             LEFT JOIN concert_boxoffice_rankings cbr ON c.id = cbr.concert_id
             WHERE c.start_date >= DATE(CONVERT_TZ(NOW(), '+00:00', '+09:00'))
             AND c.status IN ('upcoming', 'ongoing', '공연예정', '공연중')
             {}
             LIMIT ?",
            order_clause
        );

        sqlx::query_as::<_, ConcertListItem>(&query)
            .bind(limit)
            .fetch_all(pool)
            .await
    }

    // ============================================
    // Search/Filter Concerts
    // ============================================

    pub async fn search_concerts(
        pool: &DbPool,
        genre: Option<&str>,
        area: Option<&str>,
        is_visit: Option<bool>,
        is_festival: Option<bool>,
    ) -> Result<Vec<ConcertListItem>, Error> {
        let mut query = String::from(
            "SELECT c.id, c.title, c.venue_id,
             DATE_FORMAT(c.start_date, '%Y-%m-%d') as start_date,
             DATE_FORMAT(c.end_date, '%Y-%m-%d') as end_date,
             c.concert_time,
             c.poster_url, c.status, c.rating, c.rating_count,
             c.genre, c.area, c.facility_name, c.is_open_run, c.is_visit, c.is_festival, c.instrumentation,
             cbr.ranking as boxoffice_ranking
             FROM concerts c
             LEFT JOIN concert_boxoffice_rankings cbr ON c.id = cbr.concert_id
             WHERE 1=1",
        );

        if genre.is_some() {
            query.push_str(" AND c.genre = ?");
        }
        if area.is_some() {
            query.push_str(" AND c.area = ?");
        }
        if is_visit.is_some() {
            query.push_str(" AND c.is_visit = ?");
        }
        if is_festival.is_some() {
            query.push_str(" AND c.is_festival = ?");
        }

        query.push_str(" ORDER BY c.start_date DESC");

        let mut sql_query = sqlx::query_as::<_, ConcertListItem>(&query);

        if let Some(g) = genre {
            sql_query = sql_query.bind(g);
        }
        if let Some(a) = area {
            sql_query = sql_query.bind(a);
        }
        if let Some(v) = is_visit {
            sql_query = sql_query.bind(v);
        }
        if let Some(f) = is_festival {
            sql_query = sql_query.bind(f);
        }

        sql_query.fetch_all(pool).await
    }

    /// 공연 목록 검색. 텍스트·장르·지역·상태에 날짜 범위와 내한·페스티벌 여부를 더해 거른다.
    pub async fn search_concerts_by_text(
        pool: &DbPool,
        filter: &ConcertSearchFilter<'_>,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<ConcertListItem>, Error> {
        let (sql, binds) = filter.to_sql();
        let mut sql_query = sqlx::query_as::<_, ConcertListItem>(&sql);
        for bind in binds {
            sql_query = match bind {
                SearchBind::Text(value) => sql_query.bind(value),
                SearchBind::Date(value) => sql_query.bind(value),
                SearchBind::Flag(value) => sql_query.bind(value),
                SearchBind::Int(value) => sql_query.bind(value),
            };
        }
        sql_query.bind(limit).bind(offset).fetch_all(pool).await
    }

    // ============================================
    // Get Distinct Areas
    // ============================================

    pub async fn get_distinct_areas(pool: &DbPool) -> Result<Vec<String>, Error> {
        let areas = sqlx::query_scalar::<_, String>(
            "SELECT DISTINCT area FROM concerts
             WHERE area IS NOT NULL AND area != ''
             ORDER BY area",
        )
        .fetch_all(pool)
        .await?;

        Ok(areas)
    }

    // ============================================
    // Ticket Vendors 저장 로직
    // ============================================

    /// concert_ticket_vendors 테이블에 예매처 정보 일괄 저장
    /// 기존 데이터는 삭제하고 새로 삽입
    pub async fn upsert_ticket_vendors(
        pool: &DbPool,
        concert_id: i32,
        vendors: Vec<(Option<String>, String)>, // (vendor_name, vendor_url)
    ) -> Result<(), Error> {
        // 1. 기존 데이터 삭제
        sqlx::query("DELETE FROM concert_ticket_vendors WHERE concert_id = ?")
            .bind(concert_id)
            .execute(pool)
            .await?;

        // 2. 새 데이터 삽입
        for (idx, (vendor_name, vendor_url)) in vendors.iter().enumerate() {
            sqlx::query(
                "INSERT INTO concert_ticket_vendors (concert_id, vendor_name, vendor_url, display_order)
                 VALUES (?, ?, ?, ?)"
            )
            .bind(concert_id)
            .bind(vendor_name)
            .bind(vendor_url)
            .bind(idx as i32)
            .execute(pool)
            .await?;
        }

        Ok(())
    }

    // ============================================
    // Concert Artists 저장 로직
    // ============================================

    /// concert_artists 테이블에 아티스트-공연 관계 일괄 저장
    /// 기존 데이터는 삭제하고 새로 삽입
    pub async fn upsert_concert_artists(
        pool: &DbPool,
        concert_id: i32,
        artist_ids: Vec<i32>,
    ) -> Result<(), Error> {
        // 1. 기존 데이터 삭제
        sqlx::query("DELETE FROM concert_artists WHERE concert_id = ?")
            .bind(concert_id)
            .execute(pool)
            .await?;

        // 2. 새 데이터 삽입
        for artist_id in artist_ids {
            sqlx::query(
                "INSERT INTO concert_artists (concert_id, artist_id, role)
                 VALUES (?, ?, NULL)",
            )
            .bind(concert_id)
            .bind(artist_id)
            .execute(pool)
            .await?;
        }

        Ok(())
    }

    /// 오늘 이후(끝나는 날 기준) 공연에 연결된 아티스트와 그 공연 수. 공연이 많은 순.
    pub async fn find_upcoming_concert_artists(
        pool: &DbPool,
        query: Option<&str>,
        limit: i64,
    ) -> Result<Vec<ConcertArtistSummary>, Error> {
        let pattern = query
            .map(str::trim)
            .filter(|q| !q.is_empty())
            .map(|q| format!("%{}%", q));
        let mut sql = String::from(
            "SELECT a.id AS artist_id, a.name, a.english_name, a.image_url, a.category,
                    COUNT(DISTINCT c.id) AS concert_count
             FROM concert_artists ca
             JOIN concerts c ON c.id = ca.concert_id
             JOIN artists a ON a.id = ca.artist_id
             WHERE COALESCE(c.end_date, c.start_date) >= DATE(CONVERT_TZ(NOW(), '+00:00', '+09:00'))
               AND c.status <> 'cancelled'",
        );
        if pattern.is_some() {
            sql.push_str(" AND (a.name LIKE ? OR a.english_name LIKE ?)");
        }
        sql.push_str(
            " GROUP BY a.id, a.name, a.english_name, a.image_url, a.category
              ORDER BY concert_count DESC, a.name ASC
              LIMIT ?",
        );
        let mut sql_query = sqlx::query_as::<_, ConcertArtistSummary>(&sql);
        if let Some(pattern) = pattern {
            sql_query = sql_query.bind(pattern.clone()).bind(pattern);
        }
        sql_query.bind(limit).fetch_all(pool).await
    }

    /// 빠진 공연-아티스트 연결만 더한다. 관리자가 넣은 연결(역할 포함)은 건드리지 않는다.
    pub async fn add_missing_concert_artists(
        pool: &DbPool,
        concert_id: i32,
        artist_ids: &[i32],
    ) -> Result<u64, Error> {
        let mut added = 0;
        for artist_id in artist_ids {
            added += sqlx::query(
                "INSERT INTO concert_artists (concert_id, artist_id, role)
                 SELECT ?, ?, NULL FROM DUAL
                 WHERE NOT EXISTS (
                   SELECT 1 FROM concert_artists WHERE concert_id = ? AND artist_id = ?
                 )",
            )
            .bind(concert_id)
            .bind(artist_id)
            .bind(concert_id)
            .bind(artist_id)
            .execute(pool)
            .await?
            .rows_affected();
        }
        Ok(added)
    }

    /// 공연에 연결된 아티스트의 DB 원본 분류.
    pub async fn linked_artist_categories(
        pool: &DbPool,
        concert_id: i32,
    ) -> Result<Vec<String>, Error> {
        sqlx::query_scalar::<_, String>(
            "SELECT a.category FROM concert_artists ca
             JOIN artists a ON a.id = ca.artist_id
             WHERE ca.concert_id = ?",
        )
        .bind(concert_id)
        .fetch_all(pool)
        .await
    }

    /// 편성을 저장한다. 빈 문자열은 "분류했지만 해당 없음"이라 백필이 다시 보지 않는다.
    pub async fn set_instrumentation(
        pool: &DbPool,
        concert_id: i32,
        value: &str,
    ) -> Result<(), Error> {
        sqlx::query("UPDATE concerts SET instrumentation = ? WHERE id = ?")
            .bind(value)
            .bind(concert_id)
            .execute(pool)
            .await?;
        Ok(())
    }

    /// 아직 편성을 매기지 않은 공연 (id, 제목, 출연진, KOPIS 여부).
    pub async fn find_unenriched(
        pool: &DbPool,
        limit: i64,
    ) -> Result<Vec<(i32, String, Option<String>, bool)>, Error> {
        sqlx::query_as::<_, (i32, String, Option<String>, bool)>(
            "SELECT id, title, cast, COALESCE(data_source = 'KOPIS', FALSE) AS is_kopis
             FROM concerts
             WHERE instrumentation IS NULL
             ORDER BY id
             LIMIT ?",
        )
        .bind(limit)
        .fetch_all(pool)
        .await
    }

    // ============================================
    // Concert Images 저장 로직
    // ============================================

    /// concert_images 테이블에 소개 이미지 정보 일괄 저장
    /// 기존 데이터는 삭제하고 새로 삽입
    pub async fn upsert_concert_images(
        pool: &DbPool,
        concert_id: i32,
        image_urls: Vec<String>,
        image_type: &str, // "introduction", "poster", "other"
    ) -> Result<(), Error> {
        // 1. 기존 동일 타입 이미지 삭제
        sqlx::query("DELETE FROM concert_images WHERE concert_id = ? AND image_type = ?")
            .bind(concert_id)
            .bind(image_type)
            .execute(pool)
            .await?;

        // 2. 새 이미지 삽입
        for (idx, image_url) in image_urls.iter().enumerate() {
            sqlx::query(
                "INSERT INTO concert_images (concert_id, image_url, image_type, display_order)
                 VALUES (?, ?, ?, ?)",
            )
            .bind(concert_id)
            .bind(image_url)
            .bind(image_type)
            .bind(idx as i32)
            .execute(pool)
            .await?;
        }

        Ok(())
    }
}

/// `/concerts/search` 조건. 비어 있는 값은 조건에서 빠진다.
#[derive(Debug, Default)]
pub struct ConcertSearchFilter<'a> {
    pub query: Option<&'a str>,
    pub genre: Option<&'a str>,
    pub area: Option<&'a str>,
    pub status: Option<&'a str>,
    /// 이 날 이후에도 열리는 공연 (끝나는 날, 없으면 시작일 기준)
    pub from: Option<NaiveDate>,
    /// 이 날까지 시작하는 공연
    pub to: Option<NaiveDate>,
    pub visit: Option<bool>,
    pub festival: Option<bool>,
    /// 이 아티스트가 출연진으로 연결된 공연
    pub artist: Option<i32>,
    /// 편성 코드 하나 (`enrichment::INSTRUMENT_CODES`)
    pub instrument: Option<&'a str>,
}

#[derive(Debug, PartialEq)]
pub enum SearchBind {
    Text(String),
    Date(NaiveDate),
    Flag(bool),
    Int(i32),
}

impl ConcertSearchFilter<'_> {
    /// LIMIT/OFFSET 자리표시자로 끝나는 SQL과 그 앞까지의 바인딩 값.
    pub fn to_sql(&self) -> (String, Vec<SearchBind>) {
        // 예매 순위는 기간별로 여러 행이라 조인하면 공연이 겹친다. 가장 높은 순위 하나만 붙인다.
        let mut sql = String::from(
            "SELECT c.id, c.title, c.venue_id,
             DATE_FORMAT(c.start_date, '%Y-%m-%d') as start_date,
             DATE_FORMAT(c.end_date, '%Y-%m-%d') as end_date,
             c.concert_time,
             c.poster_url, c.status, c.rating, c.rating_count,
             c.genre, c.area, c.facility_name, c.is_open_run, c.is_visit, c.is_festival, c.instrumentation,
             (SELECT MIN(cbr.ranking) FROM concert_boxoffice_rankings cbr WHERE cbr.concert_id = c.id) as boxoffice_ranking
             FROM concerts c
             WHERE 1=1",
        );
        let mut binds = Vec::new();

        // composer_info 는 예전 동기화가 출연진을 복사해 둔 값이라 보지 않는다. 곡목은 program·synopsis 에 있다
        if let Some(query) = self.query.map(str::trim).filter(|q| !q.is_empty()) {
            sql.push_str(
                " AND (c.title LIKE ? OR c.cast LIKE ? OR c.facility_name LIKE ? OR c.program LIKE ? OR c.synopsis LIKE ?)",
            );
            let pattern = format!("%{}%", query);
            for _ in 0..5 {
                binds.push(SearchBind::Text(pattern.clone()));
            }
        }
        for (column, value) in [
            ("c.genre", self.genre),
            ("c.area", self.area),
            ("c.status", self.status),
        ] {
            if let Some(value) = value {
                sql.push_str(&format!(" AND {} = ?", column));
                binds.push(SearchBind::Text(value.to_string()));
            }
        }
        if let Some(from) = self.from {
            sql.push_str(" AND COALESCE(c.end_date, c.start_date) >= ?");
            binds.push(SearchBind::Date(from));
        }
        if let Some(to) = self.to {
            sql.push_str(" AND c.start_date <= ?");
            binds.push(SearchBind::Date(to));
        }
        if let Some(visit) = self.visit {
            sql.push_str(" AND COALESCE(c.is_visit, FALSE) = ?");
            binds.push(SearchBind::Flag(visit));
        }
        if let Some(festival) = self.festival {
            sql.push_str(" AND COALESCE(c.is_festival, FALSE) = ?");
            binds.push(SearchBind::Flag(festival));
        }
        if let Some(artist) = self.artist {
            sql.push_str(" AND EXISTS (SELECT 1 FROM concert_artists ca WHERE ca.concert_id = c.id AND ca.artist_id = ?)");
            binds.push(SearchBind::Int(artist));
        }
        if let Some(instrument) = self.instrument {
            sql.push_str(" AND FIND_IN_SET(?, c.instrumentation) > 0");
            binds.push(SearchBind::Text(instrument.to_string()));
        }

        if self.from.is_some() {
            // 기간을 정하면 지난 공연이 없으니 날짜순이 곧 가까운 순이다
            sql.push_str(" ORDER BY c.start_date ASC, c.id ASC LIMIT ? OFFSET ?");
        } else {
            // 오늘 이후 공연 먼저, 그다음 오늘과 가까운 순
            sql.push_str(
                " ORDER BY
               CASE WHEN c.start_date >= DATE(CONVERT_TZ(NOW(), '+00:00', '+09:00')) THEN 0 ELSE 1 END,
               ABS(DATEDIFF(c.start_date, DATE(CONVERT_TZ(NOW(), '+00:00', '+09:00')))) ASC,
               c.id ASC
             LIMIT ? OFFSET ?",
            );
        }
        (sql, binds)
    }
}

#[cfg(test)]
mod search_filter_tests {
    use super::*;

    fn date(value: &str) -> NaiveDate {
        NaiveDate::parse_from_str(value, "%Y-%m-%d").unwrap()
    }

    #[test]
    fn empty_filter_keeps_legacy_order_without_conditions() {
        let (sql, binds) = ConcertSearchFilter::default().to_sql();
        assert!(!sql.contains(" AND "));
        assert!(sql.contains("CASE WHEN c.start_date >="));
        assert!(!sql.contains("LEFT JOIN"));
        assert!(sql.ends_with("LIMIT ? OFFSET ?"));
        assert!(binds.is_empty());
    }

    #[test]
    fn binds_follow_placeholder_order() {
        let filter = ConcertSearchFilter {
            query: Some(" 조성진 "),
            genre: Some("서양음악(클래식)"),
            area: Some("서울특별시"),
            status: None,
            from: Some(date("2026-10-01")),
            to: Some(date("2026-10-31")),
            visit: Some(true),
            festival: Some(false),
            artist: Some(187),
            instrument: Some("piano"),
        };
        let (sql, binds) = filter.to_sql();
        let placeholders = sql.matches('?').count();
        // LIMIT, OFFSET 두 자리는 호출부가 채운다
        assert_eq!(placeholders, binds.len() + 2);
        assert_eq!(binds[0], SearchBind::Text("%조성진%".into()));
        assert_eq!(binds[5], SearchBind::Text("서양음악(클래식)".into()));
        assert_eq!(binds[6], SearchBind::Text("서울특별시".into()));
        assert_eq!(binds[7], SearchBind::Date(date("2026-10-01")));
        assert_eq!(binds[8], SearchBind::Date(date("2026-10-31")));
        assert_eq!(binds[9], SearchBind::Flag(true));
        assert_eq!(binds[10], SearchBind::Flag(false));
        assert_eq!(binds[11], SearchBind::Int(187));
        assert_eq!(binds[12], SearchBind::Text("piano".into()));
        assert!(sql.contains("c.program LIKE ?"));
        assert!(!sql.contains("composer_info LIKE"));
        assert!(sql.contains("ORDER BY c.start_date ASC, c.id ASC"));
    }

    #[test]
    fn blank_query_is_ignored() {
        let (sql, binds) = ConcertSearchFilter {
            query: Some("   "),
            ..Default::default()
        }
        .to_sql();
        assert!(!sql.contains("LIKE"));
        assert!(binds.is_empty());
    }
}

/// 출연진 이름 → 아티스트. 이름(또는 영문명)이 정확히 같고 DB에 그 이름이 하나뿐일 때만 잇는다.
/// 동명이인이 둘 이상이면 어느 쪽인지 알 수 없어 잇지 않는다.
#[derive(Debug, Default)]
pub struct ArtistNameIndex {
    by_name: std::collections::HashMap<String, Option<(i32, String)>>,
}

impl ArtistNameIndex {
    pub async fn load(pool: &DbPool) -> Result<Self, Error> {
        let rows = sqlx::query_as::<_, (i32, String, Option<String>, String)>(
            "SELECT id, name, english_name, category FROM artists",
        )
        .fetch_all(pool)
        .await?;
        Ok(Self::from_rows(rows))
    }

    pub fn from_rows(rows: Vec<(i32, String, Option<String>, String)>) -> Self {
        let mut index = Self::default();
        for (id, name, english_name, category) in rows {
            let mut keys = vec![Self::key(&name)];
            if let Some(english) = english_name
                .as_deref()
                .map(Self::key)
                .filter(|key| !key.is_empty())
            {
                if !keys.contains(&english) {
                    keys.push(english);
                }
            }
            for key in keys {
                if key.is_empty() {
                    continue;
                }
                index
                    .by_name
                    .entry(key)
                    .and_modify(|entry| {
                        if entry.as_ref().map(|(existing, _)| *existing) != Some(id) {
                            *entry = None;
                        }
                    })
                    .or_insert_with(|| Some((id, category.clone())));
            }
        }
        index
    }

    fn key(name: &str) -> String {
        name.split_whitespace()
            .collect::<Vec<_>>()
            .join(" ")
            .to_lowercase()
    }

    /// (아티스트 id, DB 원본 분류)
    pub fn lookup(&self, name: &str) -> Option<(i32, &str)> {
        self.by_name
            .get(&Self::key(name))
            .and_then(|entry| entry.as_ref())
            .map(|(id, category)| (*id, category.as_str()))
    }

    /// 출연진 문자열에서 찾은 아티스트 (중복 없이, 나온 순서).
    pub fn match_cast(&self, cast: &str) -> Vec<(i32, &str)> {
        let mut matched: Vec<(i32, &str)> = Vec::new();
        for name in super::enrichment::split_cast_names(cast) {
            if let Some(hit) = self.lookup(&name) {
                if !matched.iter().any(|(id, _)| *id == hit.0) {
                    matched.push(hit);
                }
            }
        }
        matched
    }
}

#[cfg(test)]
mod artist_name_index_tests {
    use super::ArtistNameIndex;

    fn index() -> ArtistNameIndex {
        ArtistNameIndex::from_rows(vec![
            (
                187,
                "임윤찬".into(),
                Some("Yunchan Lim".into()),
                "pianist".into(),
            ),
            (
                10,
                "김민수".into(),
                Some("Minsoo Kim".into()),
                "violinist".into(),
            ),
            (
                11,
                "김민수".into(),
                Some("Min-Su Kim".into()),
                "cellist".into(),
            ),
            (
                50,
                "서울시립교향악단".into(),
                Some("Seoul Philharmonic Orchestra".into()),
                "orchestra".into(),
            ),
        ])
    }

    #[test]
    fn matches_exact_unique_names_in_cast_order() {
        let index = index();
        assert_eq!(
            index.match_cast("서울시립교향악단, 임윤찬(피아노) 등"),
            vec![(50, "orchestra"), (187, "pianist")]
        );
        assert_eq!(index.match_cast("yunchan  lim"), vec![(187, "pianist")]);
    }

    #[test]
    fn skips_ambiguous_and_partial_names() {
        let index = index();
        assert!(index.match_cast("김민수").is_empty());
        assert!(index.match_cast("임윤").is_empty());
        assert!(index.match_cast("임윤찬 피아노 리사이틀").is_empty());
        assert_eq!(index.match_cast("임윤찬, 임윤찬"), vec![(187, "pianist")]);
    }
}
