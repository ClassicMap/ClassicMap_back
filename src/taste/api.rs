use chrono::Utc;
use rocket::{http::Status, serde::json::Json, State};

use super::model::{
    GuestRecommendationRequest, HomeRecommendations, ListeningEventBatch, ListeningEventResult,
    OnboardingPiece, TasteInput, TasteProfile, EVENT_KINDS,
};
use super::recommend::{recommend_home, History, Signals};
use super::repository::TasteRepository;
use crate::{auth::AuthenticatedUser, db::DbPool, logger::Logger};

const KST_OFFSET_SECONDS: i64 = 9 * 3_600;

/// 한국 날짜의 일 번호. 오늘의 비교는 자정(한국 시각)에 바뀐다
fn kst_day() -> i64 {
    (Utc::now().timestamp() + KST_OFFSET_SECONDS).div_euclid(86_400)
}

fn server_error(context: &str, error: impl std::fmt::Display) -> Status {
    Logger::error("API", &format!("{context}: {error}"));
    Status::InternalServerError
}

fn bad_request(context: &str, message: &str) -> Status {
    Logger::warn("API", &format!("{context}: {message}"));
    Status::BadRequest
}

#[get("/me/taste")]
pub async fn get_my_taste(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
) -> Result<Json<TasteProfile>, Status> {
    TasteRepository::find_profile(pool, user.user.id)
        .await
        .map(Json)
        .map_err(|error| server_error("Failed to get taste", error))
}

#[put("/me/taste", data = "<input>")]
pub async fn put_my_taste(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
    input: Json<TasteInput>,
) -> Result<Json<TasteProfile>, Status> {
    input
        .validate()
        .map_err(|message| bad_request("Invalid taste", &message))?;
    TasteRepository::save_profile(pool, user.user.id, &input)
        .await
        .map_err(|error| server_error("Failed to save taste", error))?;
    TasteRepository::find_profile(pool, user.user.id)
        .await
        .map(Json)
        .map_err(|error| server_error("Failed to reload taste", error))
}

#[get("/taste/onboarding-pieces")]
pub async fn get_onboarding_pieces(
    pool: &State<DbPool>,
) -> Result<Json<Vec<OnboardingPiece>>, Status> {
    TasteRepository::find_onboarding_pieces(pool)
        .await
        .map(Json)
        .map_err(|error| server_error("Failed to get onboarding pieces", error))
}

#[post("/me/listening-events", data = "<batch>")]
pub async fn post_my_listening_events(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
    batch: Json<ListeningEventBatch>,
) -> Result<Json<ListeningEventResult>, Status> {
    batch
        .validate()
        .map_err(|message| bad_request("Invalid listening events", &message))?;
    let profile = TasteRepository::find_profile(pool, user.user.id)
        .await
        .map_err(|error| server_error("Failed to get taste", error))?;
    TasteRepository::insert_events(pool, user.user.id, profile.history_enabled, &batch)
        .await
        .map(Json)
        .map_err(|error| server_error("Failed to save listening events", error))
}

#[delete("/me/listening-events?<piece_id>&<kind>")]
pub async fn delete_my_listening_events(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
    piece_id: Option<i32>,
    kind: Option<&str>,
) -> Result<Status, Status> {
    if kind.is_some_and(|kind| !EVENT_KINDS.contains(&kind)) {
        return Err(bad_request(
            "Invalid listening event kind",
            kind.unwrap_or_default(),
        ));
    }
    TasteRepository::delete_events(pool, user.user.id, piece_id, kind)
        .await
        .map(|_| Status::NoContent)
        .map_err(|error| server_error("Failed to delete listening events", error))
}

#[get("/me/recommendations/home")]
pub async fn get_my_home_recommendations(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
) -> Result<Json<HomeRecommendations>, Status> {
    let user_id = user.user.id;
    let taste = TasteRepository::find_profile(pool, user_id)
        .await
        .map_err(|error| server_error("Failed to get taste", error))?;
    let (favorite_composer_ids, favorite_artist_ids, favorite_piece_ids) =
        TasteRepository::find_favorite_ids(pool, user_id)
            .await
            .map_err(|error| server_error("Failed to get favorites", error))?;
    let history = TasteRepository::find_history(pool, user_id, taste.history_enabled)
        .await
        .map_err(|error| server_error("Failed to get listening history", error))?;
    let candidates = TasteRepository::find_candidates(pool)
        .await
        .map_err(|error| server_error("Failed to get recommendation candidates", error))?;
    let signals = Signals {
        taste,
        favorite_composer_ids,
        favorite_artist_ids,
        favorite_piece_ids,
        history,
    };
    Ok(Json(recommend_home(&candidates, &signals, kst_day())))
}

/// 로그인하지 않은 사람. 기기에 둔 답을 받아 계산만 하고 저장하지 않는다
#[post("/recommendations/home", data = "<request>")]
pub async fn post_guest_home_recommendations(
    pool: &State<DbPool>,
    request: Json<GuestRecommendationRequest>,
) -> Result<Json<HomeRecommendations>, Status> {
    request
        .validate()
        .map_err(|message| bad_request("Invalid guest recommendation request", &message))?;
    let request = request.into_inner();
    let candidates = TasteRepository::find_candidates(pool)
        .await
        .map_err(|error| server_error("Failed to get recommendation candidates", error))?;
    let taste = TasteProfile {
        listening_level: request.taste.listening_level,
        sounds: request.taste.sounds,
        instrument: request.taste.instrument,
        favorite_periods: request.taste.favorite_periods,
        seed_piece_ids: request.taste.seed_piece_ids,
        ..TasteProfile::default()
    };
    let history = History {
        recent: request.recent_piece_ids.into_iter().collect(),
        not_interested: request.not_interested_piece_ids.into_iter().collect(),
        ..History::default()
    };
    let signals = Signals {
        taste,
        favorite_composer_ids: request.favorite_composer_ids.into_iter().collect(),
        favorite_artist_ids: request.favorite_artist_ids.into_iter().collect(),
        favorite_piece_ids: Default::default(),
        history,
    };
    Ok(Json(recommend_home(&candidates, &signals, kst_day())))
}
