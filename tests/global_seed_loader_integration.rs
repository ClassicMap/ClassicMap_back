use serde_json::{json, Map, Value};
use std::{fs, path::PathBuf, process::Command, time::SystemTime};
use ClassicMap_back::{
    db,
    global_seed_loader::{GlobalSeedLoadOptions, GlobalSeedLoader},
};

const RUN_ID: &str = "33333333-3333-4333-8333-333333333333";
const INVALID_RUN_ID: &str = "44444444-4444-4444-8444-444444444444";
const SNAPSHOT_KEY: &str =
    "wikidata:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
const COMPOSER_ENTITY_ID: &str = "55555555-5555-4555-8555-555555555555";
const ARTIST_ENTITY_ID: &str = "66666666-6666-4666-8666-666666666666";

fn unique_path(name: &str) -> PathBuf {
    std::env::temp_dir().join(format!(
        "classicmap-{name}-{}-{}.jsonl",
        std::process::id(),
        SystemTime::now()
            .duration_since(SystemTime::UNIX_EPOCH)
            .expect("현재 시각")
            .as_nanos()
    ))
}

fn foreign_key(
    column: &str,
    target_table: &str,
    target_natural_key: &str,
    resolution: &str,
) -> Value {
    json!({
        "column": column,
        "target_table": target_table,
        "target_natural_key": target_natural_key,
        "resolution": resolution
    })
}

fn record(
    seed_run_id: &str,
    table: &str,
    natural_key: &str,
    values: Value,
    foreign_keys: Vec<Value>,
) -> Value {
    json!({
        "db_contract_version": "global-seed-v1",
        "seed_run_id": seed_run_id,
        "table": table,
        "natural_key": natural_key,
        "values": values,
        "foreign_keys": foreign_keys,
        "evidence": {},
        "origin": "seed",
        "editor_locked": false,
        "write_policy": "preserve_manual_or_locked"
    })
}

fn seed_run(seed_run_id: &str) -> Value {
    record(
        seed_run_id,
        "seed_runs",
        seed_run_id,
        json!({
            "id": seed_run_id,
            "run_kind": "global_seed",
            "command": "global seed loader integration",
            "status": "PENDING",
            "dry_run": false,
            "source_code_version": "integration-v1",
            "manifest": {
                "db_contract_version": "global-seed-v1",
                "run_slug": "integration"
            },
            "summary": {}
        }),
        vec![],
    )
}

fn source_record(seed_run_id: &str, source_id: &str, entity_type: &str) -> Value {
    let source_key = format!("{SNAPSHOT_KEY}:{source_id}");
    record(
        seed_run_id,
        "source_records",
        &source_key,
        json!({
            "source_record_id": source_id,
            "entity_type": entity_type,
            "payload_sha256": match source_id {
                "Q-COMPOSER" => "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
                "Q-ARTIST" => "cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc",
                _ => "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"
            },
            "payload": {
                "id": source_id,
                "source": "wikidata",
                "fixture": true
            }
        }),
        vec![foreign_key(
            "snapshot_id",
            "source_snapshots",
            SNAPSHOT_KEY,
            "bundle",
        )],
    )
}

fn authority(entity_id: &str, entity_kind: &str, source_id: &str, seed_run_id: &str) -> Value {
    record(
        seed_run_id,
        "authority_entities",
        entity_id,
        json!({
            "id": entity_id,
            "entity_kind": entity_kind,
            "editorial_status": "IDENTIFIERS_MATCHED",
            "origin": "seed",
            "editor_locked": false
        }),
        vec![foreign_key(
            "canonical_source_record_id",
            "source_records",
            &format!("{SNAPSHOT_KEY}:{source_id}"),
            "bundle",
        )],
    )
}

fn stable_identifier(seed_run_id: &str, entity_id: &str, source_id: &str, mbid: &str) -> Value {
    record(
        seed_run_id,
        "external_identifiers",
        &format!("musicbrainz_artist:{mbid}"),
        json!({
            "namespace": "musicbrainz_artist",
            "external_id": mbid
        }),
        vec![
            foreign_key(
                "authority_entity_id",
                "authority_entities",
                entity_id,
                "bundle",
            ),
            foreign_key(
                "source_record_id",
                "source_records",
                &format!("{SNAPSHOT_KEY}:{source_id}"),
                "bundle",
            ),
        ],
    )
}

fn valid_bundle() -> Vec<Value> {
    let composer_source = format!("{SNAPSHOT_KEY}:Q-COMPOSER");
    let artist_source = format!("{SNAPSHOT_KEY}:Q-ARTIST");
    let work_source = format!("{SNAPSHOT_KEY}:W-WORK");
    vec![
        seed_run(RUN_ID),
        record(
            RUN_ID,
            "source_snapshots",
            SNAPSHOT_KEY,
            json!({
                "seed_run_id": RUN_ID,
                "source": "wikidata",
                "source_uri": "https://www.wikidata.org/",
                "retrieved_at": "2026-08-05T00:00:00Z",
                "source_version": "fixture-v1",
                "license": "CC0-1.0",
                "sha256": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                "row_count": 3,
                "tool_version": "integration-v1",
                "storage_path": "integration-wikidata.jsonl"
            }),
            vec![foreign_key("seed_run_id", "seed_runs", RUN_ID, "bundle")],
        ),
        source_record(RUN_ID, "Q-COMPOSER", "person"),
        source_record(RUN_ID, "Q-ARTIST", "person"),
        source_record(RUN_ID, "W-WORK", "work"),
        authority(COMPOSER_ENTITY_ID, "person", "Q-COMPOSER", RUN_ID),
        authority(ARTIST_ENTITY_ID, "person", "Q-ARTIST", RUN_ID),
        stable_identifier(RUN_ID, COMPOSER_ENTITY_ID, "Q-COMPOSER", "composer-mbid"),
        stable_identifier(RUN_ID, ARTIST_ENTITY_ID, "Q-ARTIST", "artist-mbid"),
        record(
            RUN_ID,
            "entity_names",
            &format!("{COMPOSER_ENTITY_ID}:en:canonical:fixture composer"),
            json!({
                "locale": "en",
                "name_kind": "canonical",
                "name_value": "Fixture Composer",
                "normalized_value": "fixture composer",
                "is_preferred": true,
                "origin": "seed",
                "editor_locked": false
            }),
            vec![
                foreign_key(
                    "authority_entity_id",
                    "authority_entities",
                    COMPOSER_ENTITY_ID,
                    "bundle",
                ),
                foreign_key(
                    "source_record_id",
                    "source_records",
                    &composer_source,
                    "bundle",
                ),
            ],
        ),
        record(
            RUN_ID,
            "composers",
            "musicbrainz_artist:composer-mbid",
            json!({
                "name": "테스트 작곡가",
                "full_name": "테스트 작곡가",
                "english_name": "Fixture Composer",
                "period": "낭만주의",
                "birth_year": 1810,
                "death_year": 1870,
                "nationality": "독일",
                "origin": "seed",
                "editor_locked": false
            }),
            vec![
                foreign_key(
                    "authority_entity_id",
                    "authority_entities",
                    COMPOSER_ENTITY_ID,
                    "bundle",
                ),
                foreign_key(
                    "source_record_id",
                    "source_records",
                    &composer_source,
                    "bundle",
                ),
            ],
        ),
        record(
            RUN_ID,
            "artists",
            "musicbrainz_artist:artist-mbid",
            json!({
                "name": "테스트 연주자",
                "english_name": "Fixture Artist",
                "category": "피아니스트",
                "nationality": "대한민국",
                "origin": "seed",
                "editor_locked": false
            }),
            vec![
                foreign_key(
                    "authority_entity_id",
                    "authority_entities",
                    ARTIST_ENTITY_ID,
                    "bundle",
                ),
                foreign_key(
                    "source_record_id",
                    "source_records",
                    &artist_source,
                    "bundle",
                ),
            ],
        ),
        record(
            RUN_ID,
            "pieces",
            "musicbrainz_work:work-mbid",
            json!({
                "title": "Fixture Concerto",
                "title_en": "Fixture Concerto",
                "type": "song",
                "work_type": "Concerto",
                "origin": "seed",
                "editor_locked": false
            }),
            vec![
                foreign_key(
                    "composer_id",
                    "composers",
                    "musicbrainz_artist:composer-mbid",
                    "bundle_or_existing",
                ),
                foreign_key("source_record_id", "source_records", &work_source, "bundle"),
            ],
        ),
        record(
            RUN_ID,
            "piece_identifiers",
            "musicbrainz_work:work-mbid",
            json!({
                "namespace": "musicbrainz_work",
                "external_id": "work-mbid"
            }),
            vec![
                foreign_key("piece_id", "pieces", "musicbrainz_work:work-mbid", "bundle"),
                foreign_key("source_record_id", "source_records", &work_source, "bundle"),
            ],
        ),
        record(
            RUN_ID,
            "field_provenance",
            "pieces:musicbrainz_work:work-mbid:title:W-WORK",
            json!({
                "seed_run_id": RUN_ID,
                "target_table": "pieces",
                "target_id": "musicbrainz_work:work-mbid",
                "field_name": "title",
                "origin": "seed",
                "editorial_status": "IDENTIFIERS_MATCHED",
                "evidence": {"fixture": true}
            }),
            vec![
                foreign_key("seed_run_id", "seed_runs", RUN_ID, "bundle"),
                foreign_key("source_record_id", "source_records", &work_source, "bundle"),
            ],
        ),
    ]
}

fn write_bundle(name: &str, records: &[Value]) -> PathBuf {
    let path = unique_path(name);
    let contents = records
        .iter()
        .map(|record| serde_json::to_string(record).expect("fixture 직렬화"))
        .collect::<Vec<_>>()
        .join("\n");
    fs::write(&path, format!("{contents}\n")).expect("bundle 작성");
    path
}

async fn manual_composer_state(pool: &db::DbPool) -> (String, String, String, bool) {
    sqlx::query_as(
        "SELECT CAST(id AS CHAR), name, origin, editor_locked
         FROM composers WHERE origin = 'manual' ORDER BY id LIMIT 1",
    )
    .fetch_one(pool)
    .await
    .expect("manual composer fixture")
}

#[tokio::test]
#[ignore = "scripts/test_global_seed_migration.sh에서 격리 MySQL로 실행"]
async fn canonical_bundle_is_atomic_manual_safe_and_idempotent() {
    let pool = db::create_pool().await.expect("격리 테스트 DB 연결");
    let manual_before = manual_composer_state(&pool).await;
    let bundle_path = write_bundle("global-seed-valid", &valid_bundle());

    let mut dry_options = GlobalSeedLoadOptions::new(bundle_path.clone());
    dry_options.dry_run = true;
    let dry_report = GlobalSeedLoader::load(&pool, &dry_options)
        .await
        .expect("첫 dry-run");
    assert_eq!(dry_report.mutations.total, 0);
    assert!(dry_report.planned_mutations.total > 0);
    assert_eq!(
        sqlx::query_scalar::<_, i64>("SELECT COUNT(*) FROM seed_runs WHERE id = ?")
            .bind(RUN_ID)
            .fetch_one(&pool)
            .await
            .expect("dry-run zero write"),
        0
    );

    let load_options = GlobalSeedLoadOptions::new(bundle_path.clone());
    let loaded = GlobalSeedLoader::load(&pool, &load_options)
        .await
        .expect("실제 bundle 적재");
    assert!(loaded.mutations.total > 0);
    assert_eq!(manual_composer_state(&pool).await, manual_before);

    let linked_rows = sqlx::query_scalar::<_, i64>(
        "SELECT COUNT(*)
         FROM pieces piece
         JOIN composers composer ON composer.id = piece.composer_id
         JOIN authority_entities authority ON authority.id = composer.authority_entity_id
         JOIN piece_identifiers identifier ON identifier.piece_id = piece.id
         WHERE authority.id = ?
           AND identifier.namespace = 'musicbrainz_work'
           AND identifier.external_id = 'work-mbid'",
    )
    .bind(COMPOSER_ENTITY_ID)
    .fetch_one(&pool)
    .await
    .expect("composer-piece FK");
    assert_eq!(linked_rows, 1);
    let duplicate_counts: (i64, i64, i64) = sqlx::query_as(
        "SELECT
            (SELECT COUNT(*) FROM composers WHERE authority_entity_id = ?),
            (SELECT COUNT(*) FROM artists WHERE authority_entity_id = ?),
            (SELECT COUNT(*) FROM piece_identifiers
             WHERE namespace = 'musicbrainz_work' AND external_id = 'work-mbid')",
    )
    .bind(COMPOSER_ENTITY_ID)
    .bind(ARTIST_ENTITY_ID)
    .fetch_one(&pool)
    .await
    .expect("stable key duplicate");
    assert_eq!(duplicate_counts, (1, 1, 1));

    let mutation_count_before =
        sqlx::query_scalar::<_, i64>("SELECT COUNT(*) FROM seed_mutations WHERE seed_run_id = ?")
            .bind(RUN_ID)
            .fetch_one(&pool)
            .await
            .expect("첫 mutation count");
    assert_eq!(mutation_count_before, loaded.mutations.total as i64);
    let guards = sqlx::query_scalar::<_, i64>(
        "SELECT COUNT(*) FROM seed_mutations
         WHERE seed_run_id = ? AND manual_guard_confirmed = FALSE",
    )
    .bind(RUN_ID)
    .fetch_one(&pool)
    .await
    .expect("manual guard 기록");
    assert_eq!(guards, 0);

    let rerun = GlobalSeedLoader::load(&pool, &load_options)
        .await
        .expect("동일 bundle 재적재");
    assert_eq!(rerun.mutations.total, 0);
    assert_eq!(rerun.planned_mutations.total, 0);
    let second_dry = GlobalSeedLoader::load(&pool, &dry_options)
        .await
        .expect("두 번째 dry-run");
    assert_eq!(second_dry.mutations.total, 0);
    assert_eq!(second_dry.planned_mutations.total, 0);
    let mutation_count_after =
        sqlx::query_scalar::<_, i64>("SELECT COUNT(*) FROM seed_mutations WHERE seed_run_id = ?")
            .bind(RUN_ID)
            .fetch_one(&pool)
            .await
            .expect("재실행 mutation count");
    assert_eq!(mutation_count_after, mutation_count_before);

    let cli_output = Command::new(env!("CARGO_BIN_EXE_load_global_seed"))
        .args([
            "--bundle",
            bundle_path.to_str().expect("bundle UTF-8 경로"),
            "--run-id",
            RUN_ID,
            "--resume",
        ])
        .output()
        .expect("load_global_seed CLI");
    assert!(cli_output.status.success());
    let cli_report: Value = serde_json::from_slice(&cli_output.stdout).expect("CLI JSON report");
    assert_eq!(cli_report["mutations"]["total"], 0);

    let mut invalid_authority = authority(
        "77777777-7777-4777-8777-777777777777",
        "invalid-kind",
        "Q-INVALID",
        INVALID_RUN_ID,
    );
    invalid_authority["foreign_keys"] = Value::Array(vec![]);
    let mut invalid_values = Map::new();
    invalid_values.insert(
        "id".to_string(),
        Value::String("77777777-7777-4777-8777-777777777777".to_string()),
    );
    invalid_values.insert(
        "entity_kind".to_string(),
        Value::String("invalid-kind".to_string()),
    );
    invalid_values.insert("origin".to_string(), Value::String("seed".to_string()));
    invalid_values.insert("editor_locked".to_string(), Value::Bool(false));
    invalid_authority["values"] = Value::Object(invalid_values);
    let invalid_path = write_bundle(
        "global-seed-invalid-later",
        &[seed_run(INVALID_RUN_ID), invalid_authority],
    );
    let invalid_options = GlobalSeedLoadOptions::new(invalid_path.clone());
    assert!(GlobalSeedLoader::load(&pool, &invalid_options)
        .await
        .is_err());
    let rolled_back: (i64, i64, i64) = sqlx::query_as(
        "SELECT
            (SELECT COUNT(*) FROM seed_runs WHERE id = ?),
            (SELECT COUNT(*) FROM authority_entities
             WHERE id = '77777777-7777-4777-8777-777777777777'),
            (SELECT COUNT(*) FROM seed_natural_keys WHERE last_seed_run_id = ?)",
    )
    .bind(INVALID_RUN_ID)
    .bind(INVALID_RUN_ID)
    .fetch_one(&pool)
    .await
    .expect("full rollback");
    assert_eq!(rolled_back, (0, 0, 0));

    fs::remove_file(bundle_path).expect("valid bundle 삭제");
    fs::remove_file(invalid_path).expect("invalid bundle 삭제");
}
