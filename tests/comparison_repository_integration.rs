use ClassicMap_back::{
    comparison::repository::{
        ComparisonContractError, ComparisonPageRequest, ComparisonRepository,
    },
    db,
};

#[tokio::test]
#[ignore = "scripts/test_global_seed_migration.sh에서 격리 MySQL로 실행"]
async fn ready_clip_is_exposed_with_video_and_credit_contract() {
    let pool = db::create_pool().await.expect("격리 테스트 DB 연결");
    let (performance_id, artist_id, duration_ms) = sqlx::query_as::<_, (i32, i32, u32)>(
        "SELECT id, artist_id, end_ms - start_ms
         FROM performances
         WHERE performance_source_id IS NOT NULL
         ORDER BY id
         LIMIT 1",
    )
    .fetch_one(&pool)
    .await
    .expect("legacy performance backfill");

    let output_key = format!("integration-{performance_id}-v1.mp4");
    let job_id = sqlx::query(
        "INSERT INTO clip_jobs (
            performance_id, status, output_key, encoding_profile_version, attempts
         ) VALUES (?, 'READY', ?, 'integration-v1', 1)",
    )
    .bind(performance_id)
    .bind(&output_key)
    .execute(&pool)
    .await
    .expect("clip job 생성")
    .last_insert_id();

    sqlx::query(
        "INSERT INTO clip_assets (
            performance_id, clip_job_id, status, storage_path, public_url,
            encoding_profile_version, file_size, duration_ms, sha256,
            ffprobe_result, range_verified, is_current, generated_at
         ) VALUES (
            ?, ?, 'READY', ?, 'https://media.example.test/comparison.mp4',
            'integration-v1', 1024, ?, ?, JSON_OBJECT('durationMs', ?),
            TRUE, TRUE, CURRENT_TIMESTAMP(6)
         )",
    )
    .bind(performance_id)
    .bind(job_id)
    .bind(format!("/integration/{output_key}"))
    .bind(duration_ms)
    .bind("a".repeat(64))
    .bind(duration_ms)
    .execute(&pool)
    .await
    .expect("검증된 clip asset 생성");

    ComparisonRepository::publish_ready_performance(&pool, performance_id)
        .await
        .expect("public URL이 있는 READY clip 발행");

    let page = ComparisonRepository::find_published_by_artist(
        &pool,
        artist_id,
        ComparisonPageRequest::parse(None, Some(50)).expect("page request"),
    )
    .await
    .expect("artist comparison 조회");
    let item = page
        .items
        .iter()
        .find(|item| item.id == performance_id)
        .expect("READY performance 노출");

    assert_eq!(item.clip_status, "ready");
    assert!(item.credits.iter().all(|credit| matches!(
        credit.role.as_str(),
        "soloist" | "conductor" | "orchestra" | "ensemble" | "accompanist" | "vocalist" | "other"
    )));
    assert_eq!(
        item.clip_url.as_deref(),
        Some("https://media.example.test/comparison.mp4")
    );
    assert!(item.video_id.is_some());
    assert!(item
        .credits
        .iter()
        .any(|credit| credit.artist_id == artist_id && credit.is_primary));
}

#[tokio::test]
#[ignore = "scripts/test_global_seed_migration.sh에서 격리 MySQL로 실행"]
async fn clip_without_public_url_cannot_be_published() {
    let pool = db::create_pool().await.expect("격리 테스트 DB 연결");
    let (performance_id, duration_ms) = sqlx::query_as::<_, (i32, u32)>(
        "SELECT id, end_ms - start_ms
         FROM performances
         WHERE performance_source_id IS NOT NULL
         ORDER BY id DESC
         LIMIT 1",
    )
    .fetch_one(&pool)
    .await
    .expect("legacy performance backfill");

    let output_key = format!("integration-no-url-{performance_id}-v1.mp4");
    let job_id = sqlx::query(
        "INSERT INTO clip_jobs (
            performance_id, status, output_key, encoding_profile_version, attempts
         ) VALUES (?, 'READY', ?, 'integration-no-url-v1', 1)",
    )
    .bind(performance_id)
    .bind(&output_key)
    .execute(&pool)
    .await
    .expect("clip job 생성")
    .last_insert_id();

    sqlx::query(
        "INSERT INTO clip_assets (
            performance_id, clip_job_id, status, storage_path,
            encoding_profile_version, file_size, duration_ms, sha256,
            ffprobe_result, range_verified, is_current, generated_at
         ) VALUES (
            ?, ?, 'READY', ?, 'integration-no-url-v1', 1024, ?, ?,
            JSON_OBJECT('durationMs', ?), TRUE, TRUE, CURRENT_TIMESTAMP(6)
         )",
    )
    .bind(performance_id)
    .bind(job_id)
    .bind(format!("/integration/{output_key}"))
    .bind(duration_ms)
    .bind("b".repeat(64))
    .bind(duration_ms)
    .execute(&pool)
    .await
    .expect("public URL 없는 내부 READY asset 생성");

    let result = ComparisonRepository::publish_ready_performance(&pool, performance_id).await;
    assert!(matches!(result, Err(ComparisonContractError::ClipNotReady)));
}
