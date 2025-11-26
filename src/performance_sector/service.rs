use sqlx::Error;

use super::model::{CreatePerformanceSector, PerformanceSector, PerformanceSectorWithCount, UpdatePerformanceSector};
use super::repository::{DbPool, PerformanceSectorRepository};

pub struct PerformanceSectorService;

impl PerformanceSectorService {
    /// 특정 곡의 모든 섹터 조회 (연주 개수 포함)
    pub async fn get_sectors_by_piece(
        pool: &DbPool,
        piece_id: i32,
    ) -> Result<Vec<PerformanceSectorWithCount>, Error> {
        let sectors_with_counts = PerformanceSectorRepository::find_by_piece_with_counts(pool, piece_id).await?;

        Ok(sectors_with_counts
            .into_iter()
            .map(|(sector, count)| PerformanceSectorWithCount {
                sector,
                performance_count: count,
            })
            .collect())
    }

    /// ID로 섹터 조회
    pub async fn get_sector(pool: &DbPool, id: i32) -> Result<Option<PerformanceSector>, Error> {
        PerformanceSectorRepository::find_by_id(pool, id).await
    }

    /// 섹터 생성
    pub async fn create_sector(
        pool: &DbPool,
        sector: CreatePerformanceSector,
    ) -> Result<u64, Error> {
        PerformanceSectorRepository::create(pool, sector).await
    }

    /// 섹터 수정
    pub async fn update_sector(
        pool: &DbPool,
        id: i32,
        sector: UpdatePerformanceSector,
    ) -> Result<u64, Error> {
        PerformanceSectorRepository::update(pool, id, sector).await
    }

    /// 섹터 삭제
    pub async fn delete_sector(pool: &DbPool, id: i32) -> Result<u64, Error> {
        PerformanceSectorRepository::delete(pool, id).await
    }
}
