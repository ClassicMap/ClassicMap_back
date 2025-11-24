use crate::db::DbPool;
use super::model::{Artist, CreateArtist, UpdateArtist, ArtistWithAwards, CreateArtistAward};
use super::repository::ArtistRepository;

pub struct ArtistService;

impl ArtistService {
    pub async fn get_all_artists(pool: &DbPool, offset: i64, limit: i64) -> Result<Vec<Artist>, String> {
        ArtistRepository::find_all(pool, offset, limit)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_artist_by_id(pool: &DbPool, id: i32) -> Result<Option<Artist>, String> {
        ArtistRepository::find_by_id(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_artist_by_id_with_awards(pool: &DbPool, id: i32) -> Result<Option<ArtistWithAwards>, String> {
        ArtistRepository::find_by_id_with_awards(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn create_artist(pool: &DbPool, artist: CreateArtist) -> Result<i32, String> {
        ArtistRepository::create(pool, artist)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn update_artist(pool: &DbPool, id: i32, artist: UpdateArtist) -> Result<u64, String> {
        ArtistRepository::update(pool, id, artist)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_artist(pool: &DbPool, id: i32) -> Result<u64, String> {
        ArtistRepository::delete(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn create_artist_award(pool: &DbPool, artist_id: i32, award: CreateArtistAward) -> Result<i32, String> {
        ArtistRepository::create_award(pool, artist_id, award)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_artist_award(pool: &DbPool, award_id: i32) -> Result<u64, String> {
        ArtistRepository::delete_award(pool, award_id)
            .await
            .map_err(|e| e.to_string())
    }
}
