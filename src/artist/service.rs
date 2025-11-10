use crate::db::DbPool;
use super::model::{Artist, CreateArtist, UpdateArtist};
use super::repository::ArtistRepository;

pub struct ArtistService;

impl ArtistService {
    pub async fn get_all_artists(pool: &DbPool) -> Result<Vec<Artist>, String> {
        ArtistRepository::find_all(pool)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_artist_by_id(pool: &DbPool, id: i32) -> Result<Option<Artist>, String> {
        ArtistRepository::find_by_id(pool, id)
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
}
