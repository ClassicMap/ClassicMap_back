use crate::db::DbPool;
use super::model::{Composer, CreateComposer, UpdateComposer, ComposerWithMajorPieces};
use super::repository::ComposerRepository;

pub struct ComposerService;

impl ComposerService {
    pub async fn get_all_composers(pool: &DbPool, offset: i64, limit: i64) -> Result<Vec<Composer>, String> {
        ComposerRepository::find_all(pool, offset, limit)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_composer_by_id(pool: &DbPool, id: i32) -> Result<Option<ComposerWithMajorPieces>, String> {
        ComposerRepository::find_by_id(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn create_composer(pool: &DbPool, composer: CreateComposer) -> Result<i32, String> {
        ComposerRepository::create(pool, composer)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn update_composer(pool: &DbPool, id: i32, composer: UpdateComposer) -> Result<u64, String> {
        ComposerRepository::update(pool, id, composer)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_composer(pool: &DbPool, id: i32) -> Result<u64, String> {
        ComposerRepository::delete(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn search_composers(
        pool: &DbPool,
        query: Option<String>,
        period: Option<String>,
        offset: Option<i64>,
        limit: Option<i64>,
    ) -> Result<Vec<Composer>, String> {
        let offset = offset.unwrap_or(0);
        let limit = limit.unwrap_or(20);

        ComposerRepository::search_composers(pool, query, period, offset, limit)
            .await
            .map_err(|e| e.to_string())
    }
}
