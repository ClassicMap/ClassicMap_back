use serde_json::{json, Value};
use std::{fs, path::PathBuf, process::Command, time::SystemTime};
use ClassicMap_back::{
    comparison_seed_loader::{
        ComparisonSeedLoadOptions, ComparisonSeedLoader, ComparisonSeedMutationCounts,
    },
    db,
};

const COMPOSER_AUTHORITY_ID: &str = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa";
const ARTIST_AUTHORITY_ID: &str = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb";
const COMPOSER_WIKIDATA_ID: &str = "Q900000001";
const ARTIST_WIKIDATA_ID: &str = "Q900000002";
const WORK_MBID: &str = "11111111-2222-4333-8444-555555555555";

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

async fn prepare_authority_fixture(pool: &db::DbPool) -> (i32, i32, i32, i32) {
    let composer_id = sqlx::query_scalar::<_, i32>("SELECT id FROM composers ORDER BY id LIMIT 1")
        .fetch_one(pool)
        .await
        .expect("legacy composer fixture");
    let piece_id = sqlx::query_scalar::<_, i32>(
        "SELECT id FROM pieces WHERE composer_id = ? ORDER BY id LIMIT 1",
    )
    .bind(composer_id)
    .fetch_one(pool)
    .await
    .expect("legacy piece fixture");
    let artist_id = sqlx::query_scalar::<_, i32>("SELECT id FROM artists ORDER BY id LIMIT 1")
        .fetch_one(pool)
        .await
        .expect("legacy artist fixture");

    sqlx::query(
        "INSERT INTO authority_entities (
            id, entity_kind, editorial_status, origin, editor_locked
         ) VALUES (?, 'person', 'FACTS_VERIFIED', 'seed', FALSE),
                  (?, 'person', 'FACTS_VERIFIED', 'seed', FALSE)",
    )
    .bind(COMPOSER_AUTHORITY_ID)
    .bind(ARTIST_AUTHORITY_ID)
    .execute(pool)
    .await
    .expect("authority fixture");
    sqlx::query("UPDATE composers SET authority_entity_id = ? WHERE id = ?")
        .bind(COMPOSER_AUTHORITY_ID)
        .bind(composer_id)
        .execute(pool)
        .await
        .expect("composer authority 연결");
    sqlx::query("UPDATE artists SET authority_entity_id = ? WHERE id = ?")
        .bind(ARTIST_AUTHORITY_ID)
        .bind(artist_id)
        .execute(pool)
        .await
        .expect("artist authority 연결");
    sqlx::query(
        "INSERT INTO external_identifiers (
            authority_entity_id, namespace, external_id, verified_at
         ) VALUES (?, 'wikidata', ?, CURRENT_TIMESTAMP(6)),
                  (?, 'wikidata', ?, CURRENT_TIMESTAMP(6))",
    )
    .bind(COMPOSER_AUTHORITY_ID)
    .bind(COMPOSER_WIKIDATA_ID)
    .bind(ARTIST_AUTHORITY_ID)
    .bind(ARTIST_WIKIDATA_ID)
    .execute(pool)
    .await
    .expect("Wikidata identifier fixture");
    sqlx::query(
        "INSERT INTO piece_identifiers (
            piece_id, namespace, external_id, verified_at
         ) VALUES (?, 'musicbrainz_work', ?, CURRENT_TIMESTAMP(6))",
    )
    .bind(piece_id)
    .bind(WORK_MBID)
    .execute(pool)
    .await
    .expect("MusicBrainz work fixture");
    let sector = sqlx::query(
        "INSERT INTO performance_sectors (
            piece_id, sector_name, sector_key, sector_type, name_ko, name_en,
            target_min_ms, target_max_ms, editorial_status, origin, editor_locked
         ) VALUES (?, '통합 테스트 수동 전곡', 'whole-work', 'WHOLE_WORK',
                   '통합 테스트 수동 전곡', 'Integration fixture', 30000, 50000,
                   'PUBLISHED', 'manual', TRUE)",
    )
    .bind(piece_id)
    .execute(pool)
    .await
    .expect("manual sector fixture");
    let sector_id = i32::try_from(sector.last_insert_id()).expect("sector ID");
    (composer_id, piece_id, artist_id, sector_id)
}

fn candidate(video_id: &str, artist_wikidata_id: &str) -> Value {
    let base = PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("seed_pipeline/curation/pilot-2026-08-05/candidates.jsonl");
    let mut row: Value = serde_json::from_str(
        fs::read_to_string(base)
            .expect("pilot fixture 읽기")
            .lines()
            .next()
            .expect("pilot 첫 행"),
    )
    .expect("pilot JSON");
    row["candidateKey"] = json!(format!("yt:{video_id}:0:40"));
    row["workCandidate"]["naturalKey"] = json!(format!("musicbrainz-work:{WORK_MBID}"));
    row["workCandidate"]["externalIdentifiers"][0]["value"] = json!(WORK_MBID);
    row["workCandidate"]["externalIdentifiers"][0]["sourceUrl"] =
        json!(format!("https://musicbrainz.org/work/{WORK_MBID}"));
    row["workCandidate"]["composer"]["externalIdentifiers"][0]["value"] =
        json!(COMPOSER_WIKIDATA_ID);
    row["workCandidate"]["composer"]["externalIdentifiers"][0]["sourceUrl"] = json!(format!(
        "https://www.wikidata.org/wiki/{COMPOSER_WIKIDATA_ID}"
    ));
    row["source"]["videoId"] = json!(video_id);
    row["source"]["originalUrl"] = json!(format!("https://www.youtube.com/watch?v={video_id}"));
    row["credits"][0]["entityCandidate"]["externalIdentifiers"][0]["value"] =
        json!(artist_wikidata_id);
    row["credits"][0]["entityCandidate"]["externalIdentifiers"][0]["sourceUrl"] = json!(format!(
        "https://www.wikidata.org/wiki/{artist_wikidata_id}"
    ));
    row
}

fn write_bundle(name: &str, rows: &[Value]) -> PathBuf {
    let path = unique_path(name);
    let contents = rows
        .iter()
        .map(Value::to_string)
        .collect::<Vec<_>>()
        .join("\n");
    fs::write(&path, format!("{contents}\n")).expect("bundle fixture 쓰기");
    path
}

fn options(bundle_path: PathBuf, run_id: &str, dry_run: bool) -> ComparisonSeedLoadOptions {
    ComparisonSeedLoadOptions {
        bundle_path,
        run_id: run_id.to_string(),
        dry_run,
        resume: false,
        limit: None,
        source_code_version: Some("integration-test".to_string()),
    }
}

#[tokio::test]
#[ignore = "scripts/test_comparison_candidate_loader.sh에서 격리 MySQL로 실행"]
async fn load_is_atomic_idempotent_and_rights_gated() {
    let pool = db::create_pool().await.expect("격리 테스트 DB 연결");
    let (_composer_id, piece_id, artist_id, sector_id) = prepare_authority_fixture(&pool).await;
    let manual_sector_before = sqlx::query_as::<_, (String, String, bool)>(
        "SELECT sector_name, origin, editor_locked FROM performance_sectors WHERE id = ?",
    )
    .bind(sector_id)
    .fetch_one(&pool)
    .await
    .expect("manual sector snapshot");

    let dry_video = "dryvideo001";
    let dry_bundle = write_bundle(
        "comparison-dry.jsonl",
        &[candidate(dry_video, ARTIST_WIKIDATA_ID)],
    );
    let dry = ComparisonSeedLoader::load(
        &pool,
        &options(
            dry_bundle.clone(),
            "10000000-0000-4000-8000-000000000001",
            true,
        ),
    )
    .await
    .expect("dry-run");
    assert_eq!(dry.mutations, ComparisonSeedMutationCounts::default());
    assert_eq!(dry.planned_mutations.total, 5);
    let dry_persisted = sqlx::query_scalar::<_, i64>(
        "SELECT COUNT(*) FROM performance_sources WHERE provider_video_id = ?",
    )
    .bind(dry_video)
    .fetch_one(&pool)
    .await
    .expect("dry-run rollback 확인");
    assert_eq!(dry_persisted, 0);

    let video_id = "seedvideo01";
    let bundle = write_bundle(
        "comparison-valid.jsonl",
        &[candidate(video_id, ARTIST_WIKIDATA_ID)],
    );
    let first = ComparisonSeedLoader::load(
        &pool,
        &options(
            bundle.clone(),
            "20000000-0000-4000-8000-000000000001",
            false,
        ),
    )
    .await
    .expect("첫 적재");
    assert_eq!(first.mutations.total, 5);

    let states = sqlx::query_as::<_, (String, String, String, String, String, i32, i32)>(
        "SELECT
            CAST(candidate.candidate_status AS CHAR CHARACTER SET utf8mb4),
            CAST(performance.publish_status AS CHAR CHARACTER SET utf8mb4),
            CAST(job.status AS CHAR CHARACTER SET utf8mb4),
            CAST(source.rights_mode AS CHAR CHARACTER SET utf8mb4),
            CAST(credit.role_code AS CHAR CHARACTER SET utf8mb4),
            performance.piece_id,
            performance.artist_id
         FROM performance_candidates candidate
         JOIN performance_sources source ON source.id = candidate.performance_source_id
         JOIN performances performance
           ON performance.performance_source_id = source.id
          AND performance.start_ms = candidate.proposed_start_ms
          AND performance.end_ms = candidate.proposed_end_ms
         JOIN clip_jobs job ON job.performance_id = performance.id
         JOIN performance_credits credit
           ON credit.performance_source_id = source.id AND credit.is_primary = TRUE
         WHERE source.provider_video_id = ?",
    )
    .bind(video_id)
    .fetch_one(&pool)
    .await
    .expect("권리 gate 상태");
    assert_eq!(states.0, "REVIEW_REQUIRED");
    assert_eq!(states.1, "DRAFT");
    assert_eq!(states.2, "PENDING");
    assert_eq!(states.3, "unknown");
    assert_eq!(states.4, "soloist");
    assert_eq!(states.5, piece_id);
    assert_eq!(states.6, artist_id);
    let no_assets = sqlx::query_scalar::<_, i64>(
        "SELECT COUNT(*) FROM clip_assets asset
         JOIN performances performance ON performance.id = asset.performance_id
         JOIN performance_sources source ON source.id = performance.performance_source_id
         WHERE source.provider_video_id = ?",
    )
    .bind(video_id)
    .fetch_one(&pool)
    .await
    .expect("클립 미생성 확인");
    assert_eq!(no_assets, 0);

    let second = ComparisonSeedLoader::load(
        &pool,
        &options(
            bundle.clone(),
            "20000000-0000-4000-8000-000000000002",
            false,
        ),
    )
    .await
    .expect("재실행");
    assert_eq!(second.mutations.total, 0);
    let second_mutations =
        sqlx::query_scalar::<_, i64>("SELECT COUNT(*) FROM seed_mutations WHERE seed_run_id = ?")
            .bind("20000000-0000-4000-8000-000000000002")
            .fetch_one(&pool)
            .await
            .expect("재실행 mutation 확인");
    assert_eq!(second_mutations, 0);
    let cli = Command::new(env!("CARGO_BIN_EXE_load_comparison_candidates"))
        .args([
            "--bundle",
            bundle.to_str().expect("bundle UTF-8 경로"),
            "--run-id",
            "20000000-0000-4000-8000-000000000003",
            "--resume",
        ])
        .output()
        .expect("comparison candidate CLI 실행");
    assert!(
        cli.status.success(),
        "CLI 실패: {}",
        String::from_utf8_lossy(&cli.stderr)
    );
    let cli_report: Value = serde_json::from_slice(&cli.stdout).expect("CLI JSON report");
    assert_eq!(cli_report["mutations"]["total"], 0);

    let atomic_video = "atomicvid01";
    let missing_video = "missingvid1";
    let atomic_bundle = write_bundle(
        "comparison-atomic.jsonl",
        &[
            candidate(atomic_video, ARTIST_WIKIDATA_ID),
            candidate(missing_video, "Q999999999"),
        ],
    );
    let error = ComparisonSeedLoader::load(
        &pool,
        &options(
            atomic_bundle.clone(),
            "30000000-0000-4000-8000-000000000001",
            false,
        ),
    )
    .await
    .expect_err("미해소 artist 전체 rollback");
    assert_eq!(error.code(), "UNRESOLVED_ARTIST_IDENTIFIER");
    let atomic_sources = sqlx::query_scalar::<_, i64>(
        "SELECT COUNT(*) FROM performance_sources WHERE provider_video_id IN (?, ?)",
    )
    .bind(atomic_video)
    .bind(missing_video)
    .fetch_one(&pool)
    .await
    .expect("원자 rollback 확인");
    assert_eq!(atomic_sources, 0);
    let failure_audit = sqlx::query_as::<_, (String, i64, i64)>(
        "SELECT
            CAST(run.status AS CHAR CHARACTER SET utf8mb4),
            (SELECT COUNT(*) FROM seed_mutations mutation WHERE mutation.seed_run_id = run.id),
            (SELECT COUNT(*) FROM review_queue review WHERE review.seed_run_id = run.id)
         FROM seed_runs run WHERE run.id = ?",
    )
    .bind("30000000-0000-4000-8000-000000000001")
    .fetch_one(&pool)
    .await
    .expect("실패 audit 확인");
    assert_eq!(failure_audit.0, "FAILED");
    assert_eq!(failure_audit.1, 0);
    assert_eq!(failure_audit.2, 1);

    let manual_sector_after = sqlx::query_as::<_, (String, String, bool)>(
        "SELECT sector_name, origin, editor_locked FROM performance_sectors WHERE id = ?",
    )
    .bind(sector_id)
    .fetch_one(&pool)
    .await
    .expect("manual sector 재확인");
    assert_eq!(manual_sector_after, manual_sector_before);

    fs::remove_file(dry_bundle).expect("dry bundle 삭제");
    fs::remove_file(bundle).expect("valid bundle 삭제");
    fs::remove_file(atomic_bundle).expect("atomic bundle 삭제");
}
