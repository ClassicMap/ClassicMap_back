use super::scheduler::VenueSyncScheduler;
use crate::auth::AdminUser;
use crate::db::DbPool;
use crate::logger::Logger;
use rocket::{http::Status, serde::json::Json, State};
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct SyncResponse {
    pub success: bool,
    pub message: String,
    pub added: i32,
    pub updated: i32,
    pub errors: i32,
}

/// 수동으로 KOPIS 공연장 동기화 트리거
/// Admin 권한 필요
#[post("/kopis/sync")]
pub async fn trigger_venue_sync(
    pool: &State<DbPool>,
    _admin: AdminUser,
) -> Result<Json<SyncResponse>, Status> {
    Logger::info("API", "Manual KOPIS venue sync triggered by admin");

    match VenueSyncScheduler::trigger_sync(pool).await {
        Ok(result) => {
            let response = SyncResponse {
                success: true,
                message: "Sync completed successfully".to_string(),
                added: result.added,
                updated: result.updated,
                errors: result.errors,
            };

            Logger::success(
                "API",
                &format!(
                    "Manual sync completed: {} added, {} updated, {} errors",
                    result.added, result.updated, result.errors
                ),
            );

            Ok(Json(response))
        }
        Err(e) => {
            Logger::error("API", &format!("Manual sync failed: {}", e));

            let response = SyncResponse {
                success: false,
                message: format!("Sync failed: {}", e),
                added: 0,
                updated: 0,
                errors: 0,
            };

            Ok(Json(response))
        }
    }
}
