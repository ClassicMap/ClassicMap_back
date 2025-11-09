use crate::db::DbPool;
use super::model::{Piece, CreatePiece};
use super::repository::PieceRepository;

pub struct PieceService;

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

    pub async fn get_pieces_by_composer(pool: &DbPool, composer_id: i32) -> Result<Vec<Piece>, String> {
        PieceRepository::find_by_composer_id(pool, composer_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn create_piece(pool: &DbPool, piece: CreatePiece) -> Result<i32, String> {
        PieceRepository::create(pool, piece)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_piece(pool: &DbPool, id: i32) -> Result<u64, String> {
        PieceRepository::delete(pool, id)
            .await
            .map_err(|e| e.to_string())
    }
}
