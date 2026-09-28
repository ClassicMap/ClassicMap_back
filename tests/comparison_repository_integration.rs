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

async fn insert_verified_clip(pool: &db::DbPool, performance_id: i32) {
    let duration_ms =
        sqlx::query_scalar::<_, u32>("SELECT end_ms - start_ms FROM performances WHERE id = ?")
            .bind(performance_id)
            .fetch_one(pool)
            .await
            .expect("performance 구간 길이");

    let output_key = format!("integration-{performance_id}-v1.mp4");
    let job_id = sqlx::query(
        "INSERT INTO clip_jobs (
            performance_id, status, output_key, encoding_profile_version, attempts
         ) VALUES (?, 'READY', ?, 'integration-v1', 1)",
    )
    .bind(performance_id)
    .bind(&output_key)
    .execute(pool)
    .await
    .expect("clip job 생성")
    .last_insert_id();

    sqlx::query(
        "INSERT INTO clip_assets (
            performance_id, clip_job_id, status, storage_path, public_url,
            encoding_profile_version, file_size, duration_ms, sha256,
            ffprobe_result, range_verified, is_current, generated_at
         ) VALUES (
            ?, ?, 'READY', ?, ?, 'integration-v1', 1024, ?, ?,
            JSON_OBJECT('durationMs', ?), TRUE, TRUE, CURRENT_TIMESTAMP(6)
         )",
    )
    .bind(performance_id)
    .bind(job_id)
    .bind(format!("/integration/{output_key}"))
    .bind(format!("https://media.example.test/{output_key}"))
    .bind(duration_ms)
    .bind("a".repeat(64))
    .bind(duration_ms)
    .execute(pool)
    .await
    .expect("검증된 clip asset 생성");
}

/// 같은 섹터에서 서로 다른 연주자의 역채움 performance 3건을 고른다.
/// 가장 큰 id는 공개 URL 없는 클립 테스트가 쓰므로 뺀다.
async fn find_three_artist_sector(pool: &db::DbPool) -> (i32, i32, Vec<(i32, i32)>) {
    let (sector_id, piece_id) = sqlx::query_as::<_, (i32, i32)>(
        "SELECT performance.sector_id, performance.piece_id
         FROM performances performance
         JOIN performance_sectors sector
           ON sector.id = performance.sector_id
          AND sector.piece_id = performance.piece_id
         WHERE performance.performance_source_id IS NOT NULL
           AND performance.id < (
               SELECT MAX(id) FROM performances WHERE performance_source_id IS NOT NULL
           )
         GROUP BY performance.sector_id, performance.piece_id
         HAVING COUNT(DISTINCT performance.artist_id) >= 3
            AND COUNT(DISTINCT performance.performance_source_id) >= 3
         ORDER BY performance.sector_id
         LIMIT 1",
    )
    .fetch_one(pool)
    .await
    .expect("연주자 3명 이상인 역채움 섹터");

    let performances = sqlx::query_as::<_, (i32, i32)>(
        "SELECT MIN(id), artist_id
         FROM performances
         WHERE sector_id = ?
           AND performance_source_id IS NOT NULL
           AND id < (
               SELECT MAX(id) FROM performances WHERE performance_source_id IS NOT NULL
           )
         GROUP BY artist_id
         ORDER BY MIN(id)
         LIMIT 3",
    )
    .bind(sector_id)
    .fetch_all(pool)
    .await
    .expect("섹터 performance 3건");
    assert_eq!(performances.len(), 3);

    (sector_id, piece_id, performances)
}

#[tokio::test]
#[ignore = "scripts/test_global_seed_migration.sh에서 격리 MySQL로 실행"]
async fn ready_clip_is_exposed_with_video_and_credit_contract() {
    let pool = db::create_pool().await.expect("격리 테스트 DB 연결");
    let (sector_id, piece_id, performances) = find_three_artist_sector(&pool).await;
    let (performance_id, artist_id) = performances[0];

    prepare_seed_publication_gate(&pool, performance_id, "unknown").await;
    insert_verified_clip(&pool, performance_id).await;

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

    // 발행된 연주가 한 명뿐이면 섹터는 아직 비교 대상이 아니다.
    let sectors = ComparisonRepository::find_public_sectors_by_piece(&pool, piece_id)
        .await
        .expect("공개 섹터 조회")
        .expect("작품 존재");
    assert!(sectors.iter().all(|sector| sector.id != sector_id));
    let hidden = ComparisonRepository::find_public_performances_by_sector(&pool, sector_id)
        .await
        .expect("섹터 performance 조회")
        .expect("섹터 존재");
    assert!(hidden.is_empty());

    for &(other_performance_id, _) in &performances[1..] {
        prepare_seed_publication_gate(&pool, other_performance_id, "licensed_self_hosted").await;
        insert_verified_clip(&pool, other_performance_id).await;
        ComparisonRepository::publish_ready_performance(&pool, other_performance_id)
            .await
            .expect("나머지 연주 발행");
    }

    let sectors = ComparisonRepository::find_public_sectors_by_piece(&pool, piece_id)
        .await
        .expect("공개 섹터 조회")
        .expect("작품 존재");
    let sector = sectors
        .iter()
        .find(|sector| sector.id == sector_id)
        .expect("연주자 3명이 모이면 섹터 공개");
    assert_eq!(sector.piece_id, piece_id);
    assert_eq!(sector.ready_performance_count, 3);
    assert_eq!(sector.primary_artist_count, 3);

    let sector_performances =
        ComparisonRepository::find_public_performances_by_sector(&pool, sector_id)
            .await
            .expect("섹터 performance 조회")
            .expect("섹터 존재");
    let mut exposed_ids = sector_performances
        .iter()
        .map(|item| item.id)
        .collect::<Vec<_>>();
    exposed_ids.sort_unstable();
    let mut expected_ids = performances.iter().map(|(id, _)| *id).collect::<Vec<_>>();
    expected_ids.sort_unstable();
    assert_eq!(exposed_ids, expected_ids);
    assert!(sector_performances
        .iter()
        .all(|item| item.sector_id == sector_id && item.piece_id == piece_id));

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
        Some(format!("https://media.example.test/integration-{performance_id}-v1.mp4").as_str())
    );
    assert!(item.video_id.is_some());
    assert!(item
        .credits
        .iter()
        .any(|credit| credit.artist_id == artist_id && credit.is_primary));

    // 비교 카탈로그: 공개 섹터가 생긴 작품이 연주자 얼굴과 함께 나온다.
    let catalog = ComparisonRepository::find_public_pieces(&pool, None, 0, 50)
        .await
        .expect("비교 카탈로그 조회");
    let entry = catalog
        .iter()
        .find(|item| item.piece_id == piece_id)
        .expect("공개 섹터가 있는 작품은 카탈로그에 나온다");
    assert!(entry.sector_count >= 1);
    assert!(entry.performer_count >= 3);
    assert!(!entry.performers.is_empty() && entry.performers.len() <= 4);
    assert!(entry
        .performers
        .iter()
        .all(|performer| performer.piece_id == piece_id));
    let by_composer =
        ComparisonRepository::find_public_pieces(&pool, Some(entry.composer_id), 0, 50)
            .await
            .expect("작곡가별 카탈로그 조회");
    assert!(by_composer
        .iter()
        .all(|item| item.composer_id == entry.composer_id));
    assert!(by_composer.iter().any(|item| item.piece_id == piece_id));

    let missing_piece = ComparisonRepository::find_public_sectors_by_piece(&pool, i32::MAX)
        .await
        .expect("없는 작품 조회");
    assert!(missing_piece.is_none());
    let missing_sector = ComparisonRepository::find_public_performances_by_sector(&pool, i32::MAX)
        .await
        .expect("없는 섹터 조회");
    assert!(missing_sector.is_none());

    for (published_id, _) in performances {
        restore_legacy_publication_fixture(&pool, published_id).await;
    }
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
