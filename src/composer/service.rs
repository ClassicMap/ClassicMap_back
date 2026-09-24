use crate::db::DbPool;
use super::model::{Composer, CreateComposer, UpdateComposer, ComposerWithMajorPieces, ComposerWithPerformance};
use super::repository::ComposerRepository;

pub struct ComposerService;

/// 작곡가 목록 정렬. 지정하지 않으면 기존처럼 연대순이다.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ComposerSort {
    BirthYear,
    Recommended,
}

impl ComposerSort {
    pub fn parse(value: Option<&str>) -> Result<Self, String> {
        match value {
            None | Some("birthYear") => Ok(Self::BirthYear),
            Some("recommended") => Ok(Self::Recommended),
            Some(other) => Err(format!("지원하지 않는 작곡가 정렬: {other}")),
        }
    }
}

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

    pub async fn get_composers_with_performances(
        pool: &DbPool,
        limit: Option<i64>,
    ) -> Result<Vec<ComposerWithPerformance>, String> {
        let limit = limit.unwrap_or(10);
        ComposerRepository::find_with_performances(pool, limit)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn search_composers(
        pool: &DbPool,
        query: Option<String>,
        period: Option<String>,
        offset: Option<i64>,
        limit: Option<i64>,
        sort: ComposerSort,
    ) -> Result<Vec<Composer>, String> {
        let offset = offset.unwrap_or(0);
        let limit = limit.unwrap_or(20);

        ComposerRepository::search_composers(pool, query, period, offset, limit, sort)
            .await
            .map_err(|e| e.to_string())
    }
}

#[cfg(test)]
mod tests {
    use super::ComposerSort;

    #[test]
    fn sort_defaults_to_birth_year() {
        assert_eq!(ComposerSort::parse(None), Ok(ComposerSort::BirthYear));
        assert_eq!(ComposerSort::parse(Some("birthYear")), Ok(ComposerSort::BirthYear));
        assert_eq!(ComposerSort::parse(Some("recommended")), Ok(ComposerSort::Recommended));
    }

    #[test]
    fn unknown_sort_is_rejected() {
        assert!(ComposerSort::parse(Some("tier")).is_err());
    }
}
