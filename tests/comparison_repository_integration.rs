use ClassicMap_back::{
    comparison::repository::{
        ComparisonContractError, ComparisonPageRequest, ComparisonRepository,
    },
    db,
};

async fn prepare_seed_publication_gate(pool: &db::DbPool, performance_id: i32, rights_mode: &str) {
    sqlx::query(
        "UPDATE performances
         SET origin = 'seed', editor_locked = FALSE, publish_status = 'DRAFT'
         WHERE id = ?",
    )
    .bind(performance_id)
    .execute(pool)
    .await
    .expect("seed performance 상태 준비");
    sqlx::query(
        "UPDATE performance_sources source
         JOIN performances performance ON performance.performance_source_id = source.id
         SET source.availability_status = 'AVAILABLE', source.rights_mode = ?
         WHERE performance.id = ?",
    )
    .bind(rights_mode)
    .bind(performance_id)
    .execute(pool)
    .await
    .expect("performance source 권리 상태 준비");
    sqlx::query(
        "UPDATE performance_sectors sector
         JOIN performances performance ON performance.sector_id = sector.id
         SET sector.editorial_status = 'EDITOR_REVIEWED'
         WHERE performance.id = ?",
    )
    .bind(performance_id)
    .execute(pool)
    .await
    .expect("sector 편집 승인 준비");
    sqlx::query(
        "INSERT INTO performance_candidates (
            sector_id, performance_source_id, proposed_start_ms, proposed_end_ms,
            candidate_status, evidence
         )
         SELECT sector_id, performance_source_id, start_ms, end_ms,
                'APPROVED', JSON_OBJECT('fixture', 'comparison_repository_integration')
         FROM performances
         WHERE id = ?
         ON DUPLICATE KEY UPDATE candidate_status = 'APPROVED'",
    )
    .bind(performance_id)
    .execute(pool)
    .await
    .expect("승인 performance candidate 준비");
}

async fn restore_legacy_publication_fixture(pool: &db::DbPool, performance_id: i32) {
    sqlx::query(
        "DELETE candidate
         FROM performance_candidates candidate
         JOIN performances performance
           ON performance.sector_id = candidate.sector_id
          AND performance.performance_source_id = candidate.performance_source_id
          AND performance.start_ms = candidate.proposed_start_ms
          AND performance.end_ms = candidate.proposed_end_ms
         WHERE performance.id = ?",
    )
    .bind(performance_id)
    .execute(pool)
    .await
    .expect("승인 candidate fixture 정리");
    sqlx::query(
        "UPDATE performance_sources source
         JOIN performances performance ON performance.performance_source_id = source.id
         SET source.rights_mode = 'unknown'
         WHERE performance.id = ?",
    )
    .bind(performance_id)
    .execute(pool)
    .await
    .expect("legacy source 권리 상태 복구");
    sqlx::query(
        "UPDATE performance_sectors sector
         JOIN performances performance ON performance.sector_id = sector.id
         SET sector.editorial_status = 'PUBLISHED'
         WHERE performance.id = ?",
    )
    .bind(performance_id)
    .execute(pool)
    .await
    .expect("legacy sector 상태 복구");
    sqlx::query(
        "UPDATE performances
         SET origin = 'manual', editor_locked = TRUE
         WHERE id = ?",
    )
    .bind(performance_id)
    .execute(pool)
    .await
    .expect("legacy performance 잠금 복구");
}

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
    prepare_seed_publication_gate(&pool, performance_id, "unknown").await;

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

    let unknown_rights =
        ComparisonRepository::publish_ready_performance(&pool, performance_id).await;
    assert!(matches!(
        unknown_rights,
        Err(ComparisonContractError::PublicationGateNotSatisfied)
    ));

    sqlx::query(
        "UPDATE performance_sources source
         JOIN performances performance ON performance.performance_source_id = source.id
         SET source.rights_mode = 'youtube_embed_only'
         WHERE performance.id = ?",
    )
    .bind(performance_id)
    .execute(&pool)
    .await
    .expect("embed-only 권리 상태 준비");
    let embed_only = ComparisonRepository::publish_ready_performance(&pool, performance_id).await;
    assert!(matches!(
        embed_only,
        Err(ComparisonContractError::PublicationGateNotSatisfied)
    ));

    sqlx::query(
        "UPDATE performance_sources source
         JOIN performances performance ON performance.performance_source_id = source.id
         SET source.rights_mode = 'licensed_self_hosted'
         WHERE performance.id = ?",
    )
    .bind(performance_id)
    .execute(&pool)
    .await
    .expect("self-hosted 권리 상태 승인");
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
    restore_legacy_publication_fixture(&pool, performance_id).await;
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
