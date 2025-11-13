use rocket::{State, serde::json::Json, http::Status};
use crate::auth::ModeratorUser;
use crate::db::DbPool;
use crate::logger::Logger;
use super::model::{Piece, CreatePiece, UpdatePiece};
use super::service::PieceService;

#[get("/pieces")]
pub async fn get_pieces(pool: &State<DbPool>) -> Result<Json<Vec<Piece>>, Status> {
    match PieceService::get_all_pieces(pool).await {
        Ok(pieces) => Ok(Json(pieces)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get pieces: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/pieces/<id>")]
pub async fn get_piece(pool: &State<DbPool>, id: i32) -> Result<Json<Option<Piece>>, Status> {
    match PieceService::get_piece_by_id(pool, id).await {
        Ok(piece) => Ok(Json(piece)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get piece {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[get("/composers/<composer_id>/pieces")]
pub async fn get_pieces_by_composer(pool: &State<DbPool>, composer_id: i32) -> Result<Json<Vec<Piece>>, Status> {
    match PieceService::get_pieces_by_composer(pool, composer_id).await {
        Ok(pieces) => Ok(Json(pieces)),
        Err(e) => {
            Logger::error("API", &format!("Failed to get pieces for composer {}: {}", composer_id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[post("/pieces", data = "<piece>")]
pub async fn create_piece(
    pool: &State<DbPool>,
    piece: Json<CreatePiece>,
    _moderator: ModeratorUser,
) -> Result<Json<i32>, Status> {
    match PieceService::create_piece(pool, piece.into_inner()).await {
        Ok(id) => Ok(Json(id)),
        Err(e) => {
            Logger::error("API", &format!("Failed to create piece: {}", e));
            Err(Status::InternalServerError)
        }
    }
}

#[put("/pieces/<id>", data = "<piece>")]
pub async fn update_piece(
    pool: &State<DbPool>,
    id: i32,
    piece: Json<UpdatePiece>,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match PieceService::update_piece(pool, id, piece.into_inner()).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to update piece {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}

#[delete("/pieces/<id>")]
pub async fn delete_piece(
    pool: &State<DbPool>,
    id: i32,
    _moderator: ModeratorUser,
) -> Result<Json<u64>, Status> {
    match PieceService::delete_piece(pool, id).await {
        Ok(rows) => Ok(Json(rows)),
        Err(e) => {
            Logger::error("API", &format!("Failed to delete piece {}: {}", id, e));
            Err(Status::InternalServerError)
        }
    }
}
