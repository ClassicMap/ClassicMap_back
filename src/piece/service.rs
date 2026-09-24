use crate::db::DbPool;
use super::model::{Piece, CreatePiece, UpdatePiece};
use super::repository::PieceRepository;

pub struct PieceService;

pub const DEFAULT_PIECE_PAGE_SIZE: i64 = 20;
pub const MAX_PIECE_PAGE_SIZE: i64 = 100;

/// 작품 목록 페이지 범위. 둘 다 없으면 기존 호출과 같이 전체를 준다.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum PieceListRange {
    All,
    Page { offset: i64, limit: i64 },
}

impl PieceListRange {
    pub fn parse(offset: Option<i64>, limit: Option<i64>) -> Result<Self, String> {
        if offset.is_none() && limit.is_none() {
            return Ok(Self::All);
        }

        let offset = offset.unwrap_or(0);
        if offset < 0 {
            return Err(format!("offset은 0 이상이어야 합니다: {offset}"));
        }
        let limit = limit
            .unwrap_or(DEFAULT_PIECE_PAGE_SIZE)
            .clamp(1, MAX_PIECE_PAGE_SIZE);

        Ok(Self::Page { offset, limit })
    }
}

impl PieceService {
    pub async fn get_all_pieces(pool: &DbPool) -> Result<Vec<Piece>, String> {
        PieceRepository::find_all(pool)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_piece_by_id(pool: &DbPool, id: i32) -> Result<Option<Piece>, String> {
        PieceRepository::find_by_id(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_pieces_by_composer(
        pool: &DbPool,
        composer_id: i32,
        range: PieceListRange,
    ) -> Result<Vec<Piece>, String> {
        let pieces = match range {
            PieceListRange::All => PieceRepository::find_by_composer_id(pool, composer_id).await,
            PieceListRange::Page { offset, limit } => {
                PieceRepository::find_page_by_composer_id(pool, composer_id, offset, limit).await
            }
        };

        pieces.map_err(|e| e.to_string())
    }

    pub async fn create_piece(pool: &DbPool, piece: CreatePiece) -> Result<i32, String> {
        PieceRepository::create(pool, piece)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn update_piece(pool: &DbPool, id: i32, piece: UpdatePiece) -> Result<u64, String> {
        PieceRepository::update(pool, id, piece)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_piece(pool: &DbPool, id: i32) -> Result<u64, String> {
        PieceRepository::delete(pool, id)
            .await
            .map_err(|e| e.to_string())
    }
}

#[cfg(test)]
mod tests {
    use super::PieceListRange;

    #[test]
    fn no_page_params_keep_full_list() {
        assert_eq!(PieceListRange::parse(None, None), Ok(PieceListRange::All));
    }

    #[test]
    fn page_params_apply_defaults_and_limits() {
        assert_eq!(
            PieceListRange::parse(Some(40), None),
            Ok(PieceListRange::Page { offset: 40, limit: 20 })
        );
        assert_eq!(
            PieceListRange::parse(None, Some(500)),
            Ok(PieceListRange::Page { offset: 0, limit: 100 })
        );
        assert_eq!(
            PieceListRange::parse(None, Some(0)),
            Ok(PieceListRange::Page { offset: 0, limit: 1 })
        );
    }

    #[test]
    fn negative_offset_is_rejected() {
        assert!(PieceListRange::parse(Some(-1), Some(20)).is_err());
    }
}
