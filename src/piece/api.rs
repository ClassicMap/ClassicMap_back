use rocket::{State, serde::json::Json};
use crate::db::DbPool;
use super::model::{Piece, CreatePiece};
use super::service::PieceService;

#[get("/pieces")]
pub async fn get_pieces(pool: &State<DbPool>) -> Result<Json<Vec<Piece>>, String> {
    let pieces = PieceService::get_all_pieces(pool).await?;
    Ok(Json(pieces))
}

#[get("/pieces/<id>")]
pub async fn get_piece(pool: &State<DbPool>, id: i32) -> Result<Json<Option<Piece>>, String> {
    let piece = PieceService::get_piece_by_id(pool, id).await?;
    Ok(Json(piece))
}

#[get("/composers/<composer_id>/pieces")]
pub async fn get_pieces_by_composer(pool: &State<DbPool>, composer_id: i32) -> Result<Json<Vec<Piece>>, String> {
    let pieces = PieceService::get_pieces_by_composer(pool, composer_id).await?;
    Ok(Json(pieces))
}

#[post("/pieces", data = "<piece>")]
pub async fn create_piece(pool: &State<DbPool>, piece: Json<CreatePiece>) -> Result<Json<i32>, String> {
    let id = PieceService::create_piece(pool, piece.into_inner()).await?;
    Ok(Json(id))
}

#[delete("/pieces/<id>")]
pub async fn delete_piece(pool: &State<DbPool>, id: i32) -> Result<Json<u64>, String> {
    let rows = PieceService::delete_piece(pool, id).await?;
    Ok(Json(rows))
}
