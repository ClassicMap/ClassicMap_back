use ClassicMap_back::{db, user::service::UserService};

const CLERK_ID: &str = "user-provision-integration";
const RACE_CLERK_ID: &str = "user-provision-integration-race";

#[tokio::test]
#[ignore = "격리 MySQL 에서 실행: users 표만 있으면 된다"]
async fn first_sign_in_creates_user_once_and_follows_token_email() {
    let pool = db::connect_pool().await.expect("DB 연결");
    sqlx::query("DELETE FROM users WHERE clerk_id IN (?, ?)")
        .bind(CLERK_ID)
        .bind(RACE_CLERK_ID)
        .execute(&pool)
        .await
        .expect("정리");

    // 이메일 클레임이 없는 토큰도 행을 만든다
    let created = UserService::find_or_provision(&pool, CLERK_ID, None)
        .await
        .expect("첫 로그인");
    assert_eq!(created.clerk_id, CLERK_ID);
    assert_eq!(created.email, "");
    assert_eq!(created.role, "user");

    // 다시 와도 같은 행
    let again = UserService::find_or_provision(&pool, CLERK_ID, Some("  "))
        .await
        .expect("두 번째 요청");
    assert_eq!(again.id, created.id);
    assert_eq!(again.email, "");

    // 토큰에 이메일이 실리면 채운다
    let with_email = UserService::find_or_provision(&pool, CLERK_ID, Some("qa@example.com"))
        .await
        .expect("이메일 채우기");
    assert_eq!(with_email.id, created.id);
    assert_eq!(with_email.email, "qa@example.com");
    let stored: String = sqlx::query_scalar("SELECT email FROM users WHERE clerk_id = ?")
        .bind(CLERK_ID)
        .fetch_one(&pool)
        .await
        .expect("저장된 이메일");
    assert_eq!(stored, "qa@example.com");

    // 같은 계정의 첫 요청이 한꺼번에 와도 한 행만 남는다
    let attempts = (0..8).map(|_| {
        let pool = pool.clone();
        tokio::spawn(async move {
            UserService::find_or_provision(&pool, RACE_CLERK_ID, Some("race@example.com")).await
        })
    });
    let mut ids = Vec::new();
    for attempt in attempts {
        ids.push(attempt.await.expect("작업").expect("동시 첫 로그인").id);
    }
    ids.sort();
    ids.dedup();
    assert_eq!(ids.len(), 1);
    let rows: i64 = sqlx::query_scalar("SELECT COUNT(*) FROM users WHERE clerk_id = ?")
        .bind(RACE_CLERK_ID)
        .fetch_one(&pool)
        .await
        .expect("행 수");
    assert_eq!(rows, 1);

    sqlx::query("DELETE FROM users WHERE clerk_id IN (?, ?)")
        .bind(CLERK_ID)
        .bind(RACE_CLERK_ID)
        .execute(&pool)
        .await
        .expect("정리");
}
