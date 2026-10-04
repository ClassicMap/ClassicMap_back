use ClassicMap_back::{
    db,
    taste::{
        model::{ListeningEventBatch, ListeningEventInput, OnboardingInput, TasteInput},
        repository::TasteRepository,
    },
};

const CLERK_ID: &str = "taste-repository-integration";

fn input(seeds: Vec<i32>, onboarding: Option<&str>, history: Option<bool>) -> TasteInput {
    TasteInput {
        listening_level: Some("player".to_string()),
        sounds: vec!["piano".to_string(), "strings".to_string()],
        instrument: Some("piano".to_string()),
        favorite_periods: vec!["낭만주의".to_string()],
        seed_piece_ids: seeds,
        onboarding: onboarding.map(|status| OnboardingInput {
            status: status.to_string(),
            version: 1,
        }),
        history_enabled: history,
    }
}

fn event(piece_id: i32, kind: &str) -> ListeningEventInput {
    ListeningEventInput {
        piece_id,
        sector_id: None,
        performance_id: None,
        kind: kind.to_string(),
    }
}

#[tokio::test]
#[ignore = "격리 MySQL 에서 실행: scripts/test_global_seed_migration.sh 와 같은 방식"]
async fn taste_profile_events_and_candidates_round_trip() {
    let pool = db::connect_pool().await.expect("DB 연결");
    sqlx::query("DELETE FROM users WHERE clerk_id = ?")
        .bind(CLERK_ID)
        .execute(&pool)
        .await
        .expect("이전 사용자 정리");
    sqlx::query("INSERT INTO users (clerk_id, email) VALUES (?, 'taste@example.com')")
        .bind(CLERK_ID)
        .execute(&pool)
        .await
        .expect("사용자");
    let user_id: i32 = sqlx::query_scalar("SELECT id FROM users WHERE clerk_id = ?")
        .bind(CLERK_ID)
        .fetch_one(&pool)
        .await
        .expect("사용자 id");
    let pieces: Vec<i32> = sqlx::query_scalar("SELECT id FROM pieces ORDER BY id LIMIT 2")
        .fetch_all(&pool)
        .await
        .expect("작품");
    assert_eq!(pieces.len(), 2, "작품이 두 개 이상 있어야 함");
    let (first, second) = (pieces[0], pieces[1]);

    let empty = TasteRepository::find_profile(&pool, user_id)
        .await
        .expect("빈 취향");
    assert!(empty.onboarding.status.is_none());
    assert!(empty.history_enabled);

    // 고른 순서(second → first)와 온보딩 상태가 남는다. 없는 작품은 버린다
    TasteRepository::save_profile(
        &pool,
        user_id,
        &input(vec![second, first, 999_999_999], Some("completed"), None),
    )
    .await
    .expect("저장");
    let saved = TasteRepository::find_profile(&pool, user_id)
        .await
        .expect("읽기");
    assert_eq!(saved.listening_level.as_deref(), Some("player"));
    assert_eq!(saved.sounds, vec!["piano", "strings"]);
    assert_eq!(saved.instrument.as_deref(), Some("piano"));
    assert_eq!(saved.favorite_periods, vec!["낭만주의"]);
    assert_eq!(saved.seed_piece_ids, vec![second, first]);
    assert_eq!(saved.onboarding.status.as_deref(), Some("completed"));
    assert_eq!(saved.onboarding.version, Some(1));
    assert!(saved.history_enabled);

    // 온보딩을 안 주면 그대로 두고, 기록 설정은 줄 때만 바뀐다
    TasteRepository::save_profile(&pool, user_id, &input(vec![first], None, Some(false)))
        .await
        .expect("다시 저장");
    let resaved = TasteRepository::find_profile(&pool, user_id)
        .await
        .expect("다시 읽기");
    assert_eq!(resaved.onboarding.status.as_deref(), Some("completed"));
    assert_eq!(resaved.seed_piece_ids, vec![first]);
    assert!(!resaved.history_enabled);

    // 기록을 끄면 관심 없음만 받는다
    let result = TasteRepository::insert_events(
        &pool,
        user_id,
        false,
        &ListeningEventBatch {
            events: vec![event(first, "finish"), event(second, "not_interested")],
        },
    )
    .await
    .expect("기록 끔");
    assert_eq!((result.accepted, result.ignored), (1, 1));
    let history = TasteRepository::find_history(&pool, user_id, false)
        .await
        .expect("기록 끔 읽기");
    assert!(history.not_interested.contains(&second));
    assert!(history.finished.is_empty());

    let result = TasteRepository::insert_events(
        &pool,
        user_id,
        true,
        &ListeningEventBatch {
            events: vec![
                event(first, "open"),
                event(first, "finish"),
                event(first, "finish"),
                event(second, "skip"),
                event(999_999_999, "open"),
            ],
        },
    )
    .await
    .expect("기록 켬");
    assert_eq!((result.accepted, result.ignored), (4, 1));
    let history = TasteRepository::find_history(&pool, user_id, true)
        .await
        .expect("기록 켬 읽기");
    assert_eq!(history.finished.get(&first), Some(&2));
    assert_eq!(history.skipped.get(&second), Some(&1));
    assert!(history.recent.contains(&first));
    assert!(history.not_interested.contains(&second));

    let deleted =
        TasteRepository::delete_events(&pool, user_id, Some(second), Some("not_interested"))
            .await
            .expect("관심 없음 되돌리기");
    assert_eq!(deleted, 1);
    let deleted = TasteRepository::delete_events(&pool, user_id, None, None)
        .await
        .expect("모두 지우기");
    assert_eq!(deleted, 4);

    TasteRepository::find_candidates(&pool)
        .await
        .expect("추천 후보 쿼리");
    TasteRepository::find_onboarding_pieces(&pool)
        .await
        .expect("온보딩 카드 쿼리");
    TasteRepository::find_favorite_ids(&pool, user_id)
        .await
        .expect("담아 둔 것 쿼리");

    // 사용자를 지우면 취향·고른 곡·기록이 같이 지워진다
    sqlx::query("DELETE FROM users WHERE id = ?")
        .bind(user_id)
        .execute(&pool)
        .await
        .expect("사용자 삭제");
    let left: i64 = sqlx::query_scalar(
        "SELECT (SELECT COUNT(*) FROM user_taste_profiles WHERE user_id = ?)
              + (SELECT COUNT(*) FROM user_taste_seed_pieces WHERE user_id = ?)
              + (SELECT COUNT(*) FROM user_listening_events WHERE user_id = ?)",
    )
    .bind(user_id)
    .bind(user_id)
    .bind(user_id)
    .fetch_one(&pool)
    .await
    .expect("남은 줄");
    assert_eq!(left, 0);
}
