use super::model::{
    ComposerCatalog, ComposerPiece, ComposerPieceQuery, CreatePiece, Piece, PiecePart,
    PieceSearchResult, UpdatePiece,
};
use super::service::{PieceListRange, PieceService};
use crate::auth::ModeratorUser;
use crate::db::DbPool;
use crate::logger::Logger;
use rocket::{http::Status, serde::json::Json, State};

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
    let range =
        PieceListRange::parse(Some(offset.unwrap_or(0)), limit).map_err(|_| Status::BadRequest)?;
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

/// 묶음 작품 안의 곡(악장·번호곡)을 화면 순서로 준다. 자식 part 는 부모 바로 뒤에 온다.
/// 다른 작품 하위 목록(`/pieces/<id>/sectors` 등)처럼 없는 작품이면 빈 목록이다.
#[get("/pieces/<id>/parts")]
pub async fn get_piece_parts(
    pool: &State<DbPool>,
    id: i32,
) -> Result<Json<Vec<PiecePart>>, Status> {
    match PieceService::get_piece_parts(pool, id).await {
        Ok(parts) => Ok(Json(parts)),
        Err(e) => {
            Logger::error(
                "API",
                &format!("Failed to get parts for piece {}: {}", id, e),
            );
            Err(Status::InternalServerError)
        }
    }
}

/// 다른 작품의 part 로 이어진 작품은 묶음 안에서 보이므로 빼고 준다.
/// offset·limit이 없으면 전체를 준다(기존 호출 호환). 하나라도 있으면 페이지로 준다.
/// genre(장르 7종, other 는 장르 없음)·form(형식 키)·notable=1 로 거르고, sort 는
/// listening(기본)·catalogue·year·notable 이다. q 는 제목·작품번호·별칭·세트 안 곡 이름을 찾는다.
#[allow(clippy::too_many_arguments)]
#[get("/composers/<composer_id>/pieces?<offset>&<limit>&<genre>&<form>&<sort>&<q>&<notable>")]
pub async fn get_pieces_by_composer(
    pool: &State<DbPool>,
    composer_id: i32,
    offset: Option<i64>,
    limit: Option<i64>,
    genre: Option<&str>,
    form: Option<&str>,
    sort: Option<&str>,
    q: Option<&str>,
    notable: Option<&str>,
) -> Result<Json<Vec<ComposerPiece>>, Status> {
    let range = PieceListRange::parse(offset, limit).map_err(|_| Status::BadRequest)?;
    let query =
        ComposerPieceQuery::parse(genre, form, sort, q, notable).map_err(|_| Status::BadRequest)?;

    match PieceService::get_pieces_by_composer(pool, composer_id, range, &query).await {
        Ok(pieces) => Ok(Json(pieces)),
        Err(e) => {
            Logger::error(
                "API",
                &format!("Failed to get pieces for composer {}: {}", composer_id, e),
            );
            Err(Status::InternalServerError)
        }
    }
}

/// 작곡가 작품의 갈래·형식별 개수. 작곡가 화면의 갈래 칩과 형식 머리를 그린다.
#[get("/composers/<composer_id>/catalog")]
pub async fn get_composer_catalog(
    pool: &State<DbPool>,
    composer_id: i32,
) -> Result<Json<ComposerCatalog>, Status> {
    match PieceService::get_composer_catalog(pool, composer_id).await {
        Ok(catalog) => Ok(Json(catalog)),
        Err(e) => {
            Logger::error(
                "API",
                &format!("Failed to get catalog for composer {}: {}", composer_id, e),
            );
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
