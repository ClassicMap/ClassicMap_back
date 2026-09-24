use rocket::{State, serde::json::Json, http::Status};
use crate::auth::ModeratorUser;
use crate::db::DbPool;
use crate::logger::Logger;
use super::model::{Piece, CreatePiece, PieceSearchResult, UpdatePiece};
use super::service::{PieceListRange, PieceService};

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

/// 다른 검색 엔드포인트와 같이 q가 비면 필터 없이 페이지로 준다.
#[get("/pieces/search?<q>&<offset>&<limit>")]
pub async fn search_pieces(
    pool: &State<DbPool>,
    q: Option<&str>,
    offset: Option<i64>,
    limit: Option<i64>,
) -> Result<Json<Vec<PieceSearchResult>>, Status> {
    let range = PieceListRange::parse(Some(offset.unwrap_or(0)), limit)
        .map_err(|_| Status::BadRequest)?;
    let PieceListRange::Page { offset, limit } = range else {
        return Err(Status::BadRequest);
    };

    match PieceService::search_pieces(pool, q, offset, limit).await {
        Ok(pieces) => Ok(Json(pieces)),
        Err(e) => {
            Logger::error("API", &format!("Failed to search pieces: {}", e));
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

/// offset·limit이 없으면 전체를 준다(기존 호출 호환). 하나라도 있으면 페이지로 준다.
#[get("/composers/<composer_id>/pieces?<offset>&<limit>")]
pub async fn get_pieces_by_composer(
    pool: &State<DbPool>,
    composer_id: i32,
    offset: Option<i64>,
    limit: Option<i64>,
) -> Result<Json<Vec<Piece>>, Status> {
    let range = PieceListRange::parse(offset, limit).map_err(|_| Status::BadRequest)?;

    match PieceService::get_pieces_by_composer(pool, composer_id, range).await {
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
