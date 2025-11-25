use crate::db::DbPool;
use super::model::{Concert, CreateConcert, UpdateConcert, ConcertWithArtists, ConcertWithDetails, ConcertListItem, ConcertTicketVendor};
use super::repository::ConcertRepository;
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
        search_query: Option<String>,
        genre: Option<String>,
        area: Option<String>,
        status: Option<String>,
        offset: Option<i64>,
        limit: Option<i64>,
    ) -> Result<Vec<ConcertListItem>, String> {
        let offset_val = offset.unwrap_or(0);
        let limit_val = limit.unwrap_or(20);

        ConcertRepository::search_concerts_by_text(
            pool,
            search_query.as_deref(),
            genre.as_deref(),
            area.as_deref(),
            status.as_deref(),
            offset_val,
            limit_val,
        )
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
}
