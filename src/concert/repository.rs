use super::model::{
    Concert, ConcertArtist, ConcertBoxofficeRanking, ConcertImage, ConcertListItem,
    ConcertTicketVendor, ConcertWithArtists, ConcertWithDetails, CreateConcert, UpdateConcert,
};
use crate::db::DbPool;
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
             c.genre, c.area, c.facility_name, c.is_open_run, c.is_visit, c.is_festival,
             cbr.ranking as boxoffice_ranking
             FROM concerts c
             LEFT JOIN concert_boxoffice_rankings cbr ON c.id = cbr.concert_id
             ORDER BY
               CASE WHEN c.start_date >= CURDATE() THEN 0 ELSE 1 END,
               ABS(DATEDIFF(c.start_date, CURDATE())) ASC
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
             AND c.start_date >= DATE_SUB(CURDATE(), INTERVAL 2 MONTH)
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
                 title = ?, composer_info = ?, venue_id = ?,
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
        let query = if let Some(code) = area_code {
            format!(
                "SELECT DISTINCT c.id
                 FROM concerts c
                 INNER JOIN concert_boxoffice_rankings cbr ON c.id = cbr.concert_id
                 WHERE cbr.is_featured = true
                 AND cbr.kopis_area_code = ?
                 AND c.start_date >= CURDATE()
                 ORDER BY cbr.ranking ASC
                 LIMIT ?"
            )
        } else {
            format!(
                "SELECT DISTINCT c.id
                 FROM concerts c
                 INNER JOIN concert_boxoffice_rankings cbr ON c.id = cbr.concert_id
                 WHERE cbr.is_featured = true
                 AND c.start_date >= CURDATE()
                 ORDER BY cbr.ranking ASC
                 LIMIT ?"
            )
        };

        let concert_ids: Vec<(i32,)> = if let Some(code) = area_code {
            sqlx::query_as(&query)
                .bind(code)
                .bind(limit)
                .fetch_all(pool)
                .await?
        } else {
            sqlx::query_as(&query).bind(limit).fetch_all(pool).await?
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
             c.genre, c.area, c.facility_name, c.is_open_run, c.is_visit, c.is_festival,
             cbr.ranking as boxoffice_ranking
             FROM concerts c
             LEFT JOIN concert_boxoffice_rankings cbr ON c.id = cbr.concert_id
             WHERE c.start_date >= CURDATE()
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
             c.genre, c.area, c.facility_name, c.is_open_run, c.is_visit, c.is_festival,
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

    /// Full-text search across concerts with pagination
    pub async fn search_concerts_by_text(
        pool: &DbPool,
        search_query: Option<&str>,
        genre: Option<&str>,
        area: Option<&str>,
        status: Option<&str>,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<ConcertListItem>, Error> {
        // Prepare search pattern early to avoid lifetime issues
        let search_pattern = search_query
            .filter(|q| !q.trim().is_empty())
            .map(|q| format!("%{}%", q));

        let mut query = String::from(
            "SELECT c.id, c.title, c.venue_id,
             DATE_FORMAT(c.start_date, '%Y-%m-%d') as start_date,
             DATE_FORMAT(c.end_date, '%Y-%m-%d') as end_date,
             c.concert_time,
             c.poster_url, c.status, c.rating, c.rating_count,
             c.genre, c.area, c.facility_name, c.is_open_run, c.is_visit, c.is_festival,
             cbr.ranking as boxoffice_ranking
             FROM concerts c
             LEFT JOIN concert_boxoffice_rankings cbr ON c.id = cbr.concert_id
             WHERE 1=1",
        );

        // Text search across multiple fields
        if search_pattern.is_some() {
            query.push_str(
                " AND (c.title LIKE ? OR c.composer_info LIKE ? OR c.cast LIKE ? OR c.facility_name LIKE ?)"
            );
        }

        // Additional filters
        if genre.is_some() {
            query.push_str(" AND c.genre = ?");
        }
        if area.is_some() {
            query.push_str(" AND c.area = ?");
        }
        if status.is_some() {
            query.push_str(" AND c.status = ?");
        }

        // Sort by proximity to today (upcoming first, then past)
        query.push_str(
            " ORDER BY
               CASE WHEN c.start_date >= CURDATE() THEN 0 ELSE 1 END,
               ABS(DATEDIFF(c.start_date, CURDATE())) ASC
             LIMIT ? OFFSET ?",
        );

        let mut sql_query = sqlx::query_as::<_, ConcertListItem>(&query);

        // Bind search query with wildcards
        if let Some(ref pattern) = search_pattern {
            sql_query = sql_query
                .bind(pattern) // title
                .bind(pattern) // composer_info
                .bind(pattern) // cast
                .bind(pattern); // facility_name
        }

        // Bind filter parameters
        if let Some(g) = genre {
            sql_query = sql_query.bind(g);
        }
        if let Some(a) = area {
            sql_query = sql_query.bind(a);
        }
        if let Some(s) = status {
            sql_query = sql_query.bind(s);
        }

        // Bind pagination
        sql_query = sql_query.bind(limit).bind(offset);

        sql_query.fetch_all(pool).await
    }

    // ============================================
    // Get Distinct Areas
    // ============================================

    pub async fn get_distinct_areas(pool: &DbPool) -> Result<Vec<String>, Error> {
        let areas = sqlx::query_scalar::<_, String>(
            "SELECT DISTINCT area FROM concerts
             WHERE area IS NOT NULL AND area != ''
             ORDER BY area"
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
