use sha2::{Digest, Sha256};
use std::{fs, path::PathBuf, process::Command, time::SystemTime};

const SEED_RUN_ID: &str = "11111111-1111-4111-8111-111111111111";
use ClassicMap_back::{
    clip_asset_loader::{ClipAssetLoadOptions, ClipAssetLoader},
    db,
};

#[derive(Debug, sqlx::FromRow)]
struct PerformanceFixture {
    performance_id: i32,
    video_id: String,
    start_ms: u32,
    end_ms: u32,
}

#[derive(Debug)]
struct AssetFixture {
    file_size: usize,
    sha256: String,
}

fn unique_path(name: &str) -> PathBuf {
    std::env::temp_dir().join(format!(
        "classicmap-{name}-{}-{}",
        std::process::id(),
        SystemTime::now()
            .duration_since(SystemTime::UNIX_EPOCH)
            .expect("현재 시각")
            .as_nanos()
    ))
}

fn bundle_path(name: &str) -> PathBuf {
    unique_path(&format!("{name}.jsonl"))
}

fn create_cache() -> PathBuf {
    let path = unique_path("loader-cache");
    fs::create_dir(&path).expect("cache fixture 생성");
    path
}

fn write_verified_asset(
    cache: &std::path::Path,
    fixture: &PerformanceFixture,
    storage_key: &str,
    probed_duration_ms: u32,
) -> AssetFixture {
    let contents = format!(
        "verified clip bytes for performance {}",
        fixture.performance_id
    );
    let sha256 = format!("{:x}", Sha256::digest(contents.as_bytes()));
    fs::write(cache.join(storage_key), contents.as_bytes()).expect("클립 fixture 작성");
    let metadata_key = format!(
        "{}.metadata.json",
        storage_key.strip_suffix(".mp4").expect("MP4 storage key")
    );
    fs::write(
        cache.join(metadata_key),
        format!(
            "{{\"metadataVersion\":1,\"storageKey\":\"{storage_key}\",\"encodingProfileVersion\":\"integration-v1\",\"startMs\":{},\"durationMs\":{},\"fileSize\":{},\"probedDurationMs\":{probed_duration_ms},\"sha256\":\"{sha256}\",\"assetValidatedAt\":\"2026-08-05T00:00:00.000Z\",\"videoCodec\":\"h264\",\"audioCodec\":\"aac\"}}",
            fixture.start_ms,
            fixture.end_ms - fixture.start_ms,
            contents.len(),
        ),
    )
    .expect("sidecar fixture 작성");
    AssetFixture {
        file_size: contents.len(),
        sha256,
    }
}

fn bundle_row(
    fixture: &PerformanceFixture,
    storage_key: &str,
    duration_ms: u32,
    asset: &AssetFixture,
) -> String {
    let start = fixture.start_ms as f64 / 1000.0;
    let end = fixture.end_ms as f64 / 1000.0;
    format!(
        "{{\"performanceId\":{},\"storageKey\":\"{}\",\"publicUrl\":\"https://media.example.test/classicmap/clips/{}?end={}&profile=integration-v1&start={}\",\"sha256\":\"{}\",\"fileSize\":{},\"probedDurationMs\":{},\"encodingProfileVersion\":\"integration-v1\",\"assetValidatedAt\":\"2026-08-05T00:00:00.000Z\",\"rangeVerifiedAt\":\"2026-08-05T00:00:01.000Z\"}}",
        fixture.performance_id,
        storage_key,
        fixture.video_id,
        end,
        start,
        asset.sha256,
        asset.file_size,
        duration_ms,
    )
}

async fn available_performances(pool: &db::DbPool, limit: u32) -> Vec<PerformanceFixture> {
    sqlx::query_as::<_, PerformanceFixture>(
        "SELECT performance.id AS performance_id,
                CAST(source.provider_video_id AS CHAR CHARACTER SET utf8mb4) AS video_id,
                performance.start_ms,
                performance.end_ms
         FROM performances performance
         JOIN performance_sources source ON source.id = performance.performance_source_id
         WHERE CHAR_LENGTH(source.provider_video_id) = 11
           AND performance.start_ms IS NOT NULL
           AND performance.end_ms IS NOT NULL
           AND NOT EXISTS (
               SELECT 1 FROM clip_assets asset
               WHERE asset.performance_id = performance.id
           )
         ORDER BY performance.id
         LIMIT ?",
    )
    .bind(limit)
    .fetch_all(pool)
    .await
    .expect("사용 가능한 performance fixture")
}

async fn prepare_seed_performance(pool: &db::DbPool, performance_id: i32) {
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
         SET source.availability_status = 'AVAILABLE',
             source.rights_mode = 'licensed_self_hosted'
         WHERE performance.id = ?",
    )
    .bind(performance_id)
    .execute(pool)
    .await
    .expect("self-hosted source 권리 준비");
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
                'APPROVED', JSON_OBJECT('fixture', 'clip_asset_loader_integration')
         FROM performances
         WHERE id = ?
         ON DUPLICATE KEY UPDATE candidate_status = 'APPROVED'",
    )
    .bind(performance_id)
    .execute(pool)
    .await
    .expect("승인 performance candidate 준비");
}

async fn restore_legacy_performance(pool: &db::DbPool, performance_id: i32) {
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

fn options(
    path: PathBuf,
    cache_dir: PathBuf,
    dry_run: bool,
    publish: bool,
) -> ClipAssetLoadOptions {
    let mut options = ClipAssetLoadOptions::with_defaults(
        path,
        "https://media.example.test/classicmap/clips".to_string(),
    );
    options.cache_dir = cache_dir;
    options.dry_run = dry_run;
    options.publish = publish;
    options.seed_run_id = Some(SEED_RUN_ID.to_string());
    options
}

#[tokio::test]
#[ignore = "scripts/test_global_seed_migration.sh에서 격리 MySQL로 실행"]
async fn bundle_load_is_atomic_idempotent_and_publishable() {
    let pool = db::create_pool().await.expect("격리 테스트 DB 연결");
    sqlx::query(
        "INSERT INTO seed_runs (id, run_kind, command, status)
         VALUES (?, 'clip_asset_load', 'integration-test', 'RUNNING')",
    )
    .bind(SEED_RUN_ID)
    .execute(&pool)
    .await
    .expect("seed run fixture 생성");
    let fixtures = available_performances(&pool, 4).await;
    assert_eq!(fixtures.len(), 4, "integration fixture가 부족함");
    for fixture in &fixtures[..3] {
        prepare_seed_performance(&pool, fixture.performance_id).await;
    }
    let cache = create_cache();

    let fixture = &fixtures[0];
    let storage_key = format!("loader-{}-integration-v1.mp4", fixture.performance_id);
    let duration_ms = fixture.end_ms - fixture.start_ms;
    let asset = write_verified_asset(&cache, fixture, &storage_key, duration_ms);
    let path = bundle_path("clip-loader-valid");
    fs::write(
        &path,
        format!(
            "{}\n",
            bundle_row(fixture, &storage_key, duration_ms, &asset)
        ),
    )
    .expect("bundle 작성");

    let dry_run = ClipAssetLoader::load(&pool, &options(path.clone(), cache.clone(), true, false))
        .await
        .expect("dry-run 검증");
    assert_eq!(dry_run.mutations.total, 0);
    assert!(dry_run.planned_mutations.total > 0);
    let persisted_after_dry_run =
        sqlx::query_scalar::<_, i64>("SELECT COUNT(*) FROM clip_assets WHERE performance_id = ?")
            .bind(fixture.performance_id)
            .fetch_one(&pool)
            .await
            .expect("dry-run write 확인");
    assert_eq!(persisted_after_dry_run, 0);

    let loaded = ClipAssetLoader::load(&pool, &options(path.clone(), cache.clone(), false, false))
        .await
        .expect("READY 적재");
    assert!(loaded.mutations.total > 0);
    let state = sqlx::query_as::<_, (String, String, String)>(
        "SELECT performance.publish_status, asset.status,
                CAST(asset.storage_path AS CHAR CHARACTER SET utf8mb4) AS storage_path
         FROM performances performance
         JOIN clip_assets asset
           ON asset.performance_id = performance.id AND asset.is_current = TRUE
         WHERE performance.id = ?",
    )
    .bind(fixture.performance_id)
    .fetch_one(&pool)
    .await
    .expect("READY 상태 확인");
    assert_eq!(state.0, "READY");
    assert_eq!(state.1, "READY");
    assert_eq!(
        state.2,
        cache
            .canonicalize()
            .expect("cache canonical 경로")
            .join(&storage_key)
            .display()
            .to_string()
    );
    let seeded_rows = sqlx::query_scalar::<_, i64>(
        "SELECT COUNT(*)
         FROM clip_assets asset
         JOIN clip_jobs job ON job.id = asset.clip_job_id
         WHERE asset.performance_id = ?
           AND asset.seed_run_id = ?
           AND job.seed_run_id = ?",
    )
    .bind(fixture.performance_id)
    .bind(SEED_RUN_ID)
    .bind(SEED_RUN_ID)
    .fetch_one(&pool)
    .await
    .expect("seed run 출처 확인");
    assert_eq!(seeded_rows, 1);

    let second = ClipAssetLoader::load(&pool, &options(path.clone(), cache.clone(), false, false))
        .await
        .expect("동일 bundle 재실행");
    assert_eq!(second.mutations.total, 0);

    let published =
        ClipAssetLoader::load(&pool, &options(path.clone(), cache.clone(), false, true))
            .await
            .expect("원자 발행");
    assert_eq!(published.mutations.publish_transitions, 2);
    let published_again =
        ClipAssetLoader::load(&pool, &options(path.clone(), cache.clone(), false, true))
            .await
            .expect("발행 bundle 재실행");
    assert_eq!(published_again.mutations.total, 0);
    let cli_output = Command::new(env!("CARGO_BIN_EXE_load_clip_assets"))
        .args([
            "--bundle",
            path.to_str().expect("bundle UTF-8 경로"),
            "--cache-dir",
            cache.to_str().expect("cache UTF-8 경로"),
            "--public-base-url",
            "https://media.example.test/classicmap/clips",
            "--seed-run-id",
            SEED_RUN_ID,
            "--publish",
        ])
        .output()
        .expect("load_clip_assets CLI 실행");
    assert!(cli_output.status.success());
    let cli_report: serde_json::Value =
        serde_json::from_slice(&cli_output.stdout).expect("CLI JSON report");
    assert_eq!(cli_report["status"], "succeeded");
    assert_eq!(cli_report["mutations"]["total"], 0);

    let valid_fixture = &fixtures[1];
    let invalid_fixture = &fixtures[2];
    let valid_storage_key = format!("loader-{}-atomic-v1.mp4", valid_fixture.performance_id);
    let invalid_storage_key = format!("loader-{}-invalid-v1.mp4", invalid_fixture.performance_id);
    let valid_duration = valid_fixture.end_ms - valid_fixture.start_ms;
    let valid_asset =
        write_verified_asset(&cache, valid_fixture, &valid_storage_key, valid_duration);
    let invalid_asset = write_verified_asset(&cache, invalid_fixture, &invalid_storage_key, 1);
    let atomic_path = bundle_path("clip-loader-atomic");
    fs::write(
        &atomic_path,
        format!(
            "{}\n{}\n",
            bundle_row(
                valid_fixture,
                &valid_storage_key,
                valid_duration,
                &valid_asset,
            ),
            bundle_row(invalid_fixture, &invalid_storage_key, 1, &invalid_asset),
        ),
    )
    .expect("atomic bundle 작성");
    assert!(ClipAssetLoader::load(
        &pool,
        &options(atomic_path.clone(), cache.clone(), false, false)
    )
    .await
    .is_err());
    let atomic_writes = sqlx::query_scalar::<_, i64>(
        "SELECT COUNT(*) FROM clip_assets WHERE performance_id IN (?, ?)",
    )
    .bind(valid_fixture.performance_id)
    .bind(invalid_fixture.performance_id)
    .fetch_one(&pool)
    .await
    .expect("원자 rollback 확인");
    assert_eq!(atomic_writes, 0);

    let manual_fixture = &fixtures[3];
    let manual_storage_key = format!(
        "loader-{}-manual-locked-v1.mp4",
        manual_fixture.performance_id
    );
    let manual_duration = manual_fixture.end_ms - manual_fixture.start_ms;
    let manual_asset =
        write_verified_asset(&cache, manual_fixture, &manual_storage_key, manual_duration);
    let manual_path = bundle_path("clip-loader-manual-locked");
    fs::write(
        &manual_path,
        format!(
            "{}\n",
            bundle_row(
                manual_fixture,
                &manual_storage_key,
                manual_duration,
                &manual_asset,
            )
        ),
    )
    .expect("manual performance bundle 작성");
    let manual_error = ClipAssetLoader::load(
        &pool,
        &options(manual_path.clone(), cache.clone(), false, false),
    )
    .await
    .expect_err("manual/editor_locked performance 적재 거부");
    assert_eq!(manual_error.code(), "MANUAL_OR_LOCKED_PERFORMANCE");
    let manual_writes = sqlx::query_scalar::<_, i64>(
        "SELECT COUNT(*)
         FROM clip_assets
         WHERE performance_id = ?",
    )
    .bind(manual_fixture.performance_id)
    .fetch_one(&pool)
    .await
    .expect("manual performance write 차단 확인");
    assert_eq!(manual_writes, 0);

    for fixture in &fixtures[..3] {
        restore_legacy_performance(&pool, fixture.performance_id).await;
    }

    fs::remove_file(path).expect("bundle 삭제");
    fs::remove_file(atomic_path).expect("atomic bundle 삭제");
    fs::remove_file(manual_path).expect("manual bundle 삭제");
    fs::remove_dir_all(cache).expect("cache fixture 삭제");
}
