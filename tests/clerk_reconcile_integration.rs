use std::time::Duration;

use ClassicMap_back::{
    db,
    user::{
        clerk_reconcile::{
            reconcile_once, AccountRef, ClerkLookup, ClerkUserDirectory, ReconcilePlan,
            MAX_DELETIONS,
        },
        repository::UserRepository,
    },
};

const LIVE_CLERK_ID: &str = "user_reconcileIntegrationLive";
const GONE_CLERK_ID: &str = "user_reconcileIntegrationGone";

/// Clerk 대신 답한다. 이 시험이 만든 계정 말고는 모두 있다(200)고 답해 다른 행은 건드리지 않는다
struct FakeClerk {
    unexpected_for: Option<&'static str>,
}

impl ClerkUserDirectory for FakeClerk {
    async fn lookup(&self, clerk_id: &str) -> ClerkLookup {
        if Some(clerk_id) == self.unexpected_for {
            ClerkLookup::Unexpected("HTTP 503".to_string())
        } else if clerk_id == GONE_CLERK_ID {
            ClerkLookup::Gone
        } else {
            ClerkLookup::Exists
        }
    }
}

async fn cleanup(pool: &db::DbPool) {
    for table in ["users", "deleted_accounts"] {
        sqlx::query(&format!("DELETE FROM {table} WHERE clerk_id IN (?, ?)"))
            .bind(LIVE_CLERK_ID)
            .bind(GONE_CLERK_ID)
            .execute(pool)
            .await
            .expect("정리");
    }
}

async fn user_id(pool: &db::DbPool, clerk_id: &str) -> Option<i32> {
    UserRepository::find_by_clerk_id(pool, clerk_id)
        .await
        .expect("사용자 조회")
        .map(|user| user.id)
}

#[tokio::test]
#[ignore = "격리 MySQL 에서 실행: users·deleted_accounts·user_public_profiles 표만 있으면 된다"]
async fn removes_only_accounts_gone_from_clerk_through_delete_account() {
    let pool = db::connect_pool().await.expect("DB 연결");
    cleanup(&pool).await;

    for clerk_id in [LIVE_CLERK_ID, GONE_CLERK_ID] {
        UserRepository::create_if_absent(&pool, clerk_id, "", "user")
            .await
            .expect("시험 사용자");
    }
    let gone_id = user_id(&pool, GONE_CLERK_ID).await.expect("지울 사용자");
    UserRepository::ensure_public_profile(&pool, gone_id)
        .await
        .expect("딸린 행");

    // 예상 밖 응답이 하나라도 나오면 그 회차는 하나도 지우지 않는다
    let halted = reconcile_once(
        &pool,
        &FakeClerk {
            unexpected_for: Some(LIVE_CLERK_ID),
        },
        Duration::ZERO,
        MAX_DELETIONS,
    )
    .await
    .expect("멈춘 회차");
    assert!(matches!(halted.plan, ReconcilePlan::Halted { .. }));
    assert_eq!(halted.deleted, 0);
    assert_eq!(user_id(&pool, GONE_CLERK_ID).await, Some(gone_id));

    // 404 인 계정만 DELETE /me 와 같은 길로 지운다
    let report = reconcile_once(
        &pool,
        &FakeClerk {
            unexpected_for: None,
        },
        Duration::ZERO,
        MAX_DELETIONS,
    )
    .await
    .expect("정리 회차");
    match &report.plan {
        ReconcilePlan::Delete { targets, .. } => assert_eq!(
            targets,
            &vec![AccountRef {
                user_id: gone_id,
                clerk_id: GONE_CLERK_ID.to_string(),
            }]
        ),
        other => panic!("지울 계획이어야 한다: {other:?}"),
    }
    assert_eq!(report.deleted, 1);
    assert_eq!(report.failed, 0);

    assert_eq!(user_id(&pool, GONE_CLERK_ID).await, None);
    assert!(user_id(&pool, LIVE_CLERK_ID).await.is_some());
    // 딸린 user_* 행은 CASCADE 로 함께 지워진다
    let profiles: i64 =
        sqlx::query_scalar("SELECT COUNT(*) FROM user_public_profiles WHERE user_id = ?")
            .bind(gone_id)
            .fetch_one(&pool)
            .await
            .expect("딸린 행 수");
    assert_eq!(profiles, 0);
    // 지운 기록이 남아, 아직 살아 있는 옛 토큰이 행을 다시 만들지 못한다
    let recorded: i64 =
        sqlx::query_scalar("SELECT COUNT(*) FROM deleted_accounts WHERE clerk_id = ?")
            .bind(GONE_CLERK_ID)
            .fetch_one(&pool)
            .await
            .expect("지운 기록");
    assert_eq!(recorded, 1);

    cleanup(&pool).await;
}
