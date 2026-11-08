use super::{
    model::{
        summarize_genres, ComparisonGenreSummary, ComparisonPerformance, ComparisonPerformancePage,
        ComparisonPiece, ComparisonSector,
    },
    repository::{ComparisonContractError, ComparisonPageRequest, ComparisonRepository},
};
use crate::db::DbPool;

pub struct ComparisonService;

impl ComparisonService {
    pub async fn get_artist_performances(
        pool: &DbPool,
        artist_id: i32,
        cursor: Option<&str>,
        limit: Option<u32>,
    ) -> Result<ComparisonPerformancePage, ComparisonContractError> {
        let page = ComparisonPageRequest::parse(cursor, limit)?;
        ComparisonRepository::find_published_by_artist(pool, artist_id, page).await
    }

    pub async fn get_piece_sectors(
        pool: &DbPool,
        piece_id: i32,
    ) -> Result<Option<Vec<ComparisonSector>>, ComparisonContractError> {
        ComparisonRepository::find_public_sectors_by_piece(pool, piece_id).await
    }

    pub async fn get_sector_performances(
        pool: &DbPool,
        sector_id: i32,
    ) -> Result<Option<Vec<ComparisonPerformance>>, ComparisonContractError> {
        ComparisonRepository::find_public_performances_by_sector(pool, sector_id).await
    }

    /// 장르마다 공개 비교 작품 수와 대표 초상
    pub async fn get_genre_summaries(
        pool: &DbPool,
    ) -> Result<Vec<ComparisonGenreSummary>, ComparisonContractError> {
        let rows = ComparisonRepository::find_public_genre_pieces(pool).await?;
        Ok(summarize_genres(&rows))
    }

    pub async fn get_public_pieces(
        pool: &DbPool,
        composer_id: Option<i32>,
        genre: Option<&str>,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<ComparisonPiece>, ComparisonContractError> {
        ComparisonRepository::find_public_pieces_by(pool, composer_id, genre, offset, limit).await
    }
}
