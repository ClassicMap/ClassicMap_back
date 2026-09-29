use crate::db::DbPool;
use super::model::{Concert, CreateConcert, UpdateConcert, ConcertWithArtists, ConcertWithDetails, ConcertListItem, ConcertTicketVendor, ConcertArtistSummary};
use super::enrichment::{classify_instrumentation, instrumentation_value};
use super::repository::{ArtistNameIndex, ConcertRepository, ConcertSearchFilter};
use crate::logger::Logger;
use rust_decimal::Decimal;

pub struct ConcertService;

impl ConcertService {
    pub async fn get_all_concerts(pool: &DbPool) -> Result<Vec<Concert>, String> {
        ConcertRepository::find_all(pool)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_all_concerts_with_artists(pool: &DbPool) -> Result<Vec<ConcertWithArtists>, String> {
        ConcertRepository::find_all_with_artists(pool)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_concert_by_id(pool: &DbPool, id: i32) -> Result<Option<Concert>, String> {
        ConcertRepository::find_by_id(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_concert_by_id_with_artists(pool: &DbPool, id: i32) -> Result<Option<ConcertWithArtists>, String> {
        ConcertRepository::find_by_id_with_artists(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_concerts_by_artist(pool: &DbPool, artist_id: i32) -> Result<Vec<Concert>, String> {
        ConcertRepository::find_by_artist(pool, artist_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn create_concert(pool: &DbPool, concert: CreateConcert) -> Result<i32, String> {
        ConcertRepository::create(pool, concert)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn update_concert(pool: &DbPool, id: i32, concert: UpdateConcert) -> Result<u64, String> {
        ConcertRepository::update(pool, id, concert)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_concert(pool: &DbPool, id: i32) -> Result<u64, String> {
        ConcertRepository::delete(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn submit_rating(pool: &DbPool, user_id: i32, concert_id: i32, rating: f32) -> Result<(), String> {
        if rating < 0.0 || rating > 5.0 {
            return Err("Rating must be between 0.0 and 5.0".to_string());
        }
        ConcertRepository::submit_rating(pool, user_id, concert_id, rating)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_user_rating(pool: &DbPool, user_id: i32, concert_id: i32) -> Result<Option<Decimal>, String> {
        ConcertRepository::get_user_rating(pool, user_id, concert_id)
            .await
            .map_err(|e| e.to_string())
    }

    // ============================================
    // New methods for enhanced features
    // ============================================

    pub async fn get_all_concerts_list_view(pool: &DbPool, offset: Option<i64>, limit: Option<i64>) -> Result<Vec<ConcertListItem>, String> {
        let offset_val = offset.unwrap_or(0);
        let limit_val = limit.unwrap_or(20);
        ConcertRepository::find_all_list_view(pool, offset_val, limit_val)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_concert_with_details(pool: &DbPool, id: i32) -> Result<Option<ConcertWithDetails>, String> {
        ConcertRepository::find_by_id_with_details(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_featured_concerts(pool: &DbPool, area_code: Option<String>, limit: Option<i32>) -> Result<Vec<ConcertWithDetails>, String> {
        let limit_val = limit.unwrap_or(3);
        ConcertRepository::find_featured_concerts(pool, area_code.as_deref(), limit_val)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_upcoming_concerts(pool: &DbPool, sort_by: Option<String>, limit: Option<i32>) -> Result<Vec<ConcertListItem>, String> {
        let sort = sort_by.as_deref().unwrap_or("date");
        let limit_val = limit.unwrap_or(20);
        ConcertRepository::find_upcoming_concerts(pool, sort, limit_val)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn search_concerts(
        pool: &DbPool,
        genre: Option<String>,
        area: Option<String>,
        is_visit: Option<bool>,
        is_festival: Option<bool>,
    ) -> Result<Vec<ConcertListItem>, String> {
        ConcertRepository::search_concerts(
            pool,
            genre.as_deref(),
            area.as_deref(),
            is_visit,
            is_festival,
        )
        .await
        .map_err(|e| e.to_string())
    }

    pub async fn search_concerts_by_text(
        pool: &DbPool,
        filter: &ConcertSearchFilter<'_>,
        offset: Option<i64>,
        limit: Option<i64>,
    ) -> Result<Vec<ConcertListItem>, String> {
        ConcertRepository::search_concerts_by_text(pool, filter, offset.unwrap_or(0), limit.unwrap_or(20))
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_ticket_vendors(pool: &DbPool, concert_id: i32) -> Result<Vec<ConcertTicketVendor>, String> {
        ConcertRepository::find_ticket_vendors_by_concert(pool, concert_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_available_areas(pool: &DbPool) -> Result<Vec<String>, String> {
        ConcertRepository::get_distinct_areas(pool)
            .await
            .map_err(|e| e.to_string())
    }

    /// 앞으로 열릴 공연의 출연 아티스트. limit 은 기본 20, 최대 50.
    pub async fn get_upcoming_concert_artists(
        pool: &DbPool,
        query: Option<&str>,
        limit: Option<i64>,
    ) -> Result<Vec<ConcertArtistSummary>, String> {
        let limit = limit.unwrap_or(20).clamp(1, 50);
        ConcertRepository::find_upcoming_concert_artists(pool, query, limit)
            .await
            .map_err(|e| e.to_string())
    }

    /// 공연 하나를 보강한다. KOPIS 공연이면 출연진에서 아티스트를 찾아 빠진 연결을 더하고,
    /// 제목과 연결된 아티스트 분류로 편성을 다시 매긴다. 더한 연결 수를 돌려준다.
    pub async fn enrich_concert(
        pool: &DbPool,
        index: &ArtistNameIndex,
        concert_id: i32,
        title: &str,
        cast: Option<&str>,
        match_cast: bool,
    ) -> Result<u64, sqlx::Error> {
        let mut added = 0;
        if match_cast {
            if let Some(cast) = cast {
                let artist_ids: Vec<i32> = index.match_cast(cast).into_iter().map(|(id, _)| id).collect();
                if !artist_ids.is_empty() {
                    added = ConcertRepository::add_missing_concert_artists(pool, concert_id, &artist_ids).await?;
                }
            }
        }
        let categories = ConcertRepository::linked_artist_categories(pool, concert_id).await?;
        let category_refs: Vec<&str> = categories.iter().map(String::as_str).collect();
        let codes = classify_instrumentation(title, &category_refs);
        ConcertRepository::set_instrumentation(pool, concert_id, &instrumentation_value(&codes)).await?;
        Ok(added)
    }

    /// 편성이 비어 있는(NULL) 공연을 모두 보강한다. 한 번 매긴 공연은 다시 보지 않아 여러 번 돌려도 같다.
    pub async fn backfill_enrichment(pool: &DbPool) -> Result<(u64, u64), sqlx::Error> {
        const BATCH: i64 = 200;
        let index = ArtistNameIndex::load(pool).await?;
        let (mut enriched, mut linked) = (0u64, 0u64);
        loop {
            let rows = ConcertRepository::find_unenriched(pool, BATCH).await?;
            if rows.is_empty() {
                break;
            }
            for (id, title, cast, is_kopis) in rows {
                linked += Self::enrich_concert(pool, &index, id, &title, cast.as_deref(), is_kopis).await?;
                enriched += 1;
            }
        }
        Ok((enriched, linked))
    }

    /// 서버 시작 뒤 백그라운드에서 한 번 돈다. 실패해도 서버는 계속 뜬다.
    pub fn spawn_enrichment_backfill(pool: DbPool) {
        tokio::spawn(async move {
            match Self::backfill_enrichment(&pool).await {
                Ok((0, _)) => {}
                Ok((enriched, linked)) => Logger::success(
                    "CONCERT",
                    &format!("공연 편성 {}건을 매기고 출연 아티스트 연결 {}건을 더함", enriched, linked),
                ),
                Err(e) => Logger::error("CONCERT", &format!("공연 보강 백필 실패: {}", e)),
            }
        });
    }
}
