use std::time::{SystemTime, UNIX_EPOCH};

use ClassicMap_back::{db, user::service::UserService};

const CLERK_ID: &str = "user-provision-integration";
const RACE_CLERK_ID: &str = "user-provision-integration-race";

fn now() -> i64 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .expect("시계")
        .as_secs() as i64
}

async fn cleanup(pool: &db::DbPool) {
    for table in ["users", "deleted_accounts"] {
        sqlx::query(&format!("DELETE FROM {table} WHERE clerk_id IN (?, ?)"))
            .bind(CLERK_ID)
            .bind(RACE_CLERK_ID)
            .execute(pool)
            .await
            .expect("정리");
    }
}

#[tokio::test]
#[ignore = "격리 MySQL 에서 실행: users·deleted_accounts 표만 있으면 된다"]
async fn first_sign_in_creates_user_once_and_follows_token_email() {
    let pool = db::connect_pool().await.expect("DB 연결");
    cleanup(&pool).await;

    // 이메일 클레임이 없는 토큰도 행을 만든다
    let created = UserService::find_or_provision(&pool, CLERK_ID, None, now())
        .await
        .expect("첫 로그인")
        .expect("행");
    assert_eq!(created.clerk_id, CLERK_ID);
    assert_eq!(created.email, "");
    assert_eq!(created.role, "user");

    // 다시 와도 같은 행
    let again = UserService::find_or_provision(&pool, CLERK_ID, Some("  "), now())
        .await
        .expect("두 번째 요청")
        .expect("행");
    assert_eq!(again.id, created.id);
    assert_eq!(again.email, "");

    // 토큰에 이메일이 실리면 채운다. 목록에 없는 이메일이라 역할은 그대로
    let with_email = UserService::find_or_provision(&pool, CLERK_ID, Some("qa@example.com"), now())
        .await
        .expect("이메일 채우기")
        .expect("행");
    assert_eq!(with_email.id, created.id);
    assert_eq!(with_email.email, "qa@example.com");
    assert_eq!(with_email.role, "user");
    let stored: String = sqlx::query_scalar("SELECT email FROM users WHERE clerk_id = ?")
        .bind(CLERK_ID)
        .fetch_one(&pool)
        .await
        .expect("저장된 이메일");
    assert_eq!(stored, "qa@example.com");

    // 계정을 지우면 그 전에 발급된 토큰으로는 행이 다시 생기지 않는다
    UserService::delete_account(&pool, created.id, CLERK_ID)
        .await
        .expect("계정 삭제");
    let stale = UserService::find_or_provision(&pool, CLERK_ID, None, now() - 60)
        .await
        .expect("지운 뒤 옛 토큰");
    assert!(stale.is_none());
    let rows: i64 = sqlx::query_scalar("SELECT COUNT(*) FROM users WHERE clerk_id = ?")
        .bind(CLERK_ID)
        .fetch_one(&pool)
        .await
        .expect("행 수");
    assert_eq!(rows, 0);

    // 지운 뒤에 발급된 토큰(로그인 계정 삭제가 실패해 남은 경우)은 빈 행을 새로 만든다
    let fresh = UserService::find_or_provision(&pool, CLERK_ID, None, now() + 60)
        .await
        .expect("지운 뒤 새 토큰")
        .expect("새 행");
    assert_ne!(fresh.id, created.id);

    // 같은 계정의 첫 요청이 한꺼번에 와도 한 행만 남는다
    let attempts = (0..8).map(|_| {
        let pool = pool.clone();
        tokio::spawn(async move {
            UserService::find_or_provision(&pool, RACE_CLERK_ID, Some("race@example.com"), now())
                .await
        })
    });
    let mut ids = Vec::new();
    for attempt in attempts {
        ids.push(
            attempt
                .await
                .expect("작업")
                .expect("동시 첫 로그인")
                .expect("행")
                .id,
        );
    }
    ids.sort();
    ids.dedup();
    assert_eq!(ids.len(), 1);

    cleanup(&pool).await;
}

const ROLE_CLERK_ID: &str = "user-provision-integration-role";

#[tokio::test]
#[ignore = "격리 MySQL 에서 실행: users·deleted_accounts 표만 있으면 된다"]
async fn token_email_promotes_role_but_never_demotes() {
    let pool = db::connect_pool().await.expect("DB 연결");
    sqlx::query("DELETE FROM users WHERE clerk_id = ?")
        .bind(ROLE_CLERK_ID)
        .execute(&pool)
        .await
        .expect("정리");
    std::env::set_var("ADMIN_EMAILS", "admin-qa@example.com");

    let created = UserService::find_or_provision(&pool, ROLE_CLERK_ID, None, now())
        .await
        .expect("첫 로그인")
        .expect("행");
    assert_eq!(created.role, "user");

    let promoted =
        UserService::find_or_provision(&pool, ROLE_CLERK_ID, Some("admin-qa@example.com"), now())
            .await
            .expect("이메일 채우기")
            .expect("행");
    assert_eq!(promoted.role, "admin");

    let kept =
        UserService::find_or_provision(&pool, ROLE_CLERK_ID, Some("other@example.com"), now())
            .await
            .expect("이메일 바뀜")
            .expect("행");
    assert_eq!(kept.email, "other@example.com");
    assert_eq!(kept.role, "admin");

    sqlx::query("DELETE FROM users WHERE clerk_id = ?")
        .bind(ROLE_CLERK_ID)
        .execute(&pool)
        .await
        .expect("정리");
}
