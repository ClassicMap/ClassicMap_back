use super::model::{Venue, CreateVenue, UpdateVenue};
use super::repository::VenueRepository;
use crate::db::DbPool;
use crate::logger::Logger;

pub struct VenueService;

impl VenueService {
    pub async fn get_all_venues(pool: &DbPool) -> Result<Vec<Venue>, String> {
        Logger::info("VENUE", "Fetching all venues");
        let venues = VenueRepository::get_all(pool)
            .await
            .map_err(|e| format!("Failed to get venues: {}", e))?;
        Logger::success("VENUE", &format!("Found {} venues", venues.len()));
        Ok(venues)
    }

    pub async fn get_venue_by_id(pool: &DbPool, id: i32) -> Result<Option<Venue>, String> {
        Logger::info("VENUE", &format!("Fetching venue with id: {}", id));
        VenueRepository::get_by_id(pool, id)
            .await
            .map_err(|e| format!("Failed to get venue: {}", e))
    }

    pub async fn create_venue(pool: &DbPool, venue: CreateVenue) -> Result<i32, String> {
        Logger::info("VENUE", &format!("Creating venue: {}", venue.name));
        let id = VenueRepository::create(pool, venue)
            .await
            .map_err(|e| format!("Failed to create venue: {}", e))?;
        Logger::success("VENUE", &format!("Created venue with id: {}", id));
        Ok(id)
    }

    pub async fn update_venue(pool: &DbPool, id: i32, venue: UpdateVenue) -> Result<u64, String> {
        Logger::info("VENUE", &format!("Updating venue with id: {}", id));
        let rows = VenueRepository::update(pool, id, venue)
            .await
            .map_err(|e| format!("Failed to update venue: {}", e))?;
        Logger::success("VENUE", &format!("Updated {} row(s)", rows));
        Ok(rows)
    }

    pub async fn delete_venue(pool: &DbPool, id: i32) -> Result<u64, String> {
        Logger::info("VENUE", &format!("Deleting venue with id: {}", id));
        let rows = VenueRepository::delete(pool, id)
            .await
            .map_err(|e| format!("Failed to delete venue: {}", e))?;
        Logger::success("VENUE", &format!("Deleted {} row(s)", rows));
        Ok(rows)
    }

    pub async fn search_venues(
        pool: &DbPool,
        search_query: Option<String>,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<Venue>, String> {
        VenueRepository::search_venues(
            pool,
            search_query.as_deref(),
            offset,
            limit
        )
        .await
        .map_err(|e| format!("Failed to search venues: {}", e))
    }
}
