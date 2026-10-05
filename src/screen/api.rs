use rocket::{http::Status, serde::json::Json, State};

use super::model::{
    FeaturedScreenCue, PieceScreenCue, ScreenCueStillInput, ScreenStillCandidates,
    ScreenTitleDetail, ScreenTitlePage,
};
use super::repository::{ScreenRepository, KINDS};
use crate::{auth::AdminUser, db::DbPool, logger::Logger, search::SearchText};

fn server_error(context: &str, error: impl std::fmt::Display) -> Status {
    Logger::error("API", &format!("{context}: {error}"));
    Status::InternalServerError
}

/// TMDB 이미지 파일 경로 꼴("/abc123.jpg")만 받는다
fn is_image_path(path: &str) -> bool {
    path.starts_with('/')
        && path.len() <= 100
        && path[1..]
            .bytes()
            .all(|byte| byte.is_ascii_alphanumeric() || matches!(byte, b'.' | b'_' | b'-'))
        && [".jpg", ".png", ".webp"]
            .iter()
            .any(|ext| path.ends_with(ext))
}

#[get("/screen-titles?<kind>&<offset>&<limit>")]
pub async fn get_screen_titles(
    pool: &State<DbPool>,
    kind: Option<&str>,
    offset: Option<u32>,
    limit: Option<u32>,
) -> Result<Json<ScreenTitlePage>, Status> {
    if kind.is_some_and(|kind| !KINDS.contains(&kind)) {
        return Err(Status::BadRequest);
    }
    ScreenRepository::list_titles(pool, kind, offset, limit)
        .await
        .map(Json)
        .map_err(|error| server_error("Failed to list screen titles", error))
}

#[get("/screen-titles/search?<q>&<offset>&<limit>")]
pub async fn search_screen_titles(
    pool: &State<DbPool>,
    q: Option<&str>,
    offset: Option<u32>,
    limit: Option<u32>,
) -> Result<Json<ScreenTitlePage>, Status> {
    let Some(query) = SearchText::parse(q) else {
        return Ok(Json(ScreenTitlePage {
            items: Vec::new(),
            has_more: false,
        }));
    };
    ScreenRepository::search_titles(pool, &query, offset, limit)
        .await
        .map(Json)
        .map_err(|error| server_error("Failed to search screen titles", error))
}

#[get("/screen-titles/<title_id>")]
pub async fn get_screen_title(
    pool: &State<DbPool>,
    title_id: i32,
) -> Result<Json<ScreenTitleDetail>, Status> {
    match ScreenRepository::find_title(pool, title_id).await {
        Ok(Some(title)) => Ok(Json(title)),
        Ok(None) => Err(Status::NotFound),
        Err(error) => Err(server_error(
            &format!("Failed to get screen title {title_id}"),
            error,
        )),
    }
}

#[get("/pieces/<piece_id>/screen-cues")]
pub async fn get_piece_screen_cues(
    pool: &State<DbPool>,
    piece_id: i32,
) -> Result<Json<Vec<PieceScreenCue>>, Status> {
    ScreenRepository::find_piece_cues(pool, piece_id)
        .await
        .map(Json)
        .map_err(|error| {
            server_error(
                &format!("Failed to get screen cues for piece {piece_id}"),
                error,
            )
        })
}

#[get("/screen-cues/featured?<limit>")]
pub async fn get_featured_screen_cues(
    pool: &State<DbPool>,
    limit: Option<u32>,
) -> Result<Json<Vec<FeaturedScreenCue>>, Status> {
    ScreenRepository::find_featured_cues(pool, limit)
        .await
        .map(Json)
        .map_err(|error| server_error("Failed to get featured screen cues", error))
}

#[get("/admin/screen-titles/<title_id>/stills")]
pub async fn get_screen_still_candidates(
    pool: &State<DbPool>,
    _admin: AdminUser,
    title_id: i32,
) -> Result<Json<ScreenStillCandidates>, Status> {
    match ScreenRepository::find_still_candidates(pool, title_id).await {
        Ok(Some(candidates)) => Ok(Json(candidates)),
        Ok(None) => Err(Status::NotFound),
        Err(error) => Err(server_error("Failed to get still candidates", error)),
    }
}

#[put("/admin/screen-cues/<cue_id>/still", data = "<input>")]
pub async fn put_screen_cue_still(
    pool: &State<DbPool>,
    _admin: AdminUser,
    cue_id: u64,
    input: Json<ScreenCueStillInput>,
) -> Result<Status, Status> {
    let still_path = input.still_path.as_deref();
    if still_path.is_some_and(|path| !is_image_path(path)) {
        return Err(Status::BadRequest);
    }
    match ScreenRepository::set_cue_still(pool, cue_id, still_path).await {
        Ok(Some(true)) => Ok(Status::NoContent),
        Ok(Some(false)) => Err(Status::UnprocessableEntity),
        Ok(None) => Err(Status::NotFound),
        Err(error) => Err(server_error("Failed to set cue still", error)),
    }
}

#[cfg(test)]
mod tests {
    use super::is_image_path;

    #[test]
    fn only_tmdb_file_paths_are_accepted() {
        assert!(is_image_path("/kqjL17yufvn9OVLyXYpvtyrFfak.jpg"));
        assert!(!is_image_path("kqjL17yufvn9OVLyXYpvtyrFfak.jpg"));
        assert!(!is_image_path("/../etc/passwd"));
        assert!(!is_image_path("/a/b.jpg"));
        assert!(!is_image_path("https://example.com/a.jpg"));
    }
}
