use sqlx::{Error, MySqlPool};

use super::model::{CreatePerformanceSector, PerformanceSector, UpdatePerformanceSector};

pub type DbPool = MySqlPool;

pub struct PerformanceSectorRepository;

impl PerformanceSectorRepository {
    /// 특정 곡의 모든 섹터 조회 (display_order순)
    pub async fn find_by_piece(
        pool: &DbPool,
        piece_id: i32,
    ) -> Result<Vec<PerformanceSector>, Error> {
        sqlx::query_as!(
            PerformanceSector,
            r#"
            SELECT id, piece_id, sector_name, description, display_order
            FROM performance_sectors
            WHERE piece_id = ?
            ORDER BY display_order ASC, id ASC
            "#,
            piece_id
        )
        .fetch_all(pool)
        .await
    }

    /// 특정 곡의 섹터 조회 (연주 개수 포함)
    pub async fn find_by_piece_with_counts(
        pool: &DbPool,
        piece_id: i32,
    ) -> Result<Vec<(PerformanceSector, i32)>, Error> {
        struct SectorWithCount {
            id: i32,
            piece_id: i32,
            sector_name: String,
            description: Option<String>,
            display_order: Option<i32>,
            performance_count: i32,
        }
        let results: Vec<SectorWithCount> = sqlx::query_as!(
            SectorWithCount,
            r#"
            SELECT
                ps.id,
                ps.piece_id,
                ps.sector_name,
                ps.description,
                ps.display_order,
                COALESCE(COUNT(p.id), 0) as `performance_count!: i32`
            FROM performance_sectors ps
            LEFT JOIN performances p ON ps.id = p.sector_id
            WHERE ps.piece_id = ?
            GROUP BY ps.id, ps.piece_id, ps.sector_name, ps.description, ps.display_order
            ORDER BY ps.display_order ASC, ps.id ASC
            "#,
            piece_id
        )
        .fetch_all(pool)
        .await?;

        Ok(results
            .into_iter()
            .map(|r| {
                (
                    PerformanceSector {
                        id: r.id,
                        piece_id: r.piece_id,
                        sector_name: r.sector_name,
                        description: r.description,
                        display_order: r.display_order,
                    },
                    r.performance_count,
                )
            })
            .collect())
    }

    /// ID로 섹터 조회
    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<PerformanceSector>, Error> {
        sqlx::query_as!(
            PerformanceSector,
            r#"
            SELECT id, piece_id, sector_name, description, display_order
            FROM performance_sectors
            WHERE id = ?
            "#,
            id
        )
        .fetch_optional(pool)
        .await
    }

    /// 섹터 생성
    pub async fn create(pool: &DbPool, sector: CreatePerformanceSector) -> Result<u64, Error> {
        let display_order = sector.display_order.unwrap_or(0);

        let result = sqlx::query!(
            r#"
            INSERT INTO performance_sectors (piece_id, sector_name, description, display_order)
            VALUES (?, ?, ?, ?)
            "#,
            sector.piece_id,
            sector.sector_name,
            sector.description,
            display_order
        )
        .execute(pool)
        .await?;

        Ok(result.last_insert_id())
    }

    /// 섹터 수정
    pub async fn update(
        pool: &DbPool,
        id: i32,
        sector: UpdatePerformanceSector,
    ) -> Result<u64, Error> {
        // 기존 섹터 조회
        let existing = Self::find_by_id(pool, id).await?;

        if existing.is_none() {
            return Err(Error::RowNotFound);
        }

        let existing = existing.unwrap();

        // 변경되지 않은 필드는 기존 값 유지
        let sector_name = sector.sector_name.unwrap_or(existing.sector_name);
        let description = sector.description.or(existing.description);
        let display_order = Some(sector.display_order).unwrap_or(existing.display_order);

        let result = sqlx::query!(
            r#"
            UPDATE performance_sectors
            SET sector_name = ?, description = ?, display_order = ?
            WHERE id = ?
            "#,
            sector_name,
            description,
            display_order,
            id
        )
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    /// 섹터 삭제 (CASCADE로 연결된 performances도 자동 삭제)
    pub async fn delete(pool: &DbPool, id: i32) -> Result<u64, Error> {
        let result = sqlx::query!(
            r#"
            DELETE FROM performance_sectors
            WHERE id = ?
            "#,
            id
        )
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    /// 특정 곡의 섹터 개수
    pub async fn count_by_piece(pool: &DbPool, piece_id: i32) -> Result<i64, Error> {
        let result = sqlx::query!(
            r#"
            SELECT COUNT(*) as `count!: i64`
            FROM performance_sectors
            WHERE piece_id = ?
            "#,
            piece_id
        )
        .fetch_one(pool)
        .await?;

        Ok(result.count)
    }
}
