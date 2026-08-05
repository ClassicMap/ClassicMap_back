use serde_json::{json, Value};
use std::{fs, path::PathBuf, process::Command, time::SystemTime};
use uuid::Uuid;
use ClassicMap_back::{
    db,
    global_seed_loader::{AuthorityBootstrapOptions, GlobalSeedLoadOptions, GlobalSeedLoader},
    legacy_authority_linker::{LegacyAuthorityLinkOptions, LegacyAuthorityLinker},
};

const GLOBAL_RUN_ID: &str = "88888888-8888-4888-8888-888888888888";
const LINK_RUN_ID: &str = "99999999-9999-4999-8999-999999999999";
const ATOMIC_FAILURE_RUN_ID: &str = "f0f0f0f0-f0f0-40f0-80f0-f0f0f0f0f0f0";
const MISMATCH_RUN_ID: &str = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa";
const CONFLICT_RUN_ID: &str = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb";
const COMPOSER_AUTHORITY_ID: &str = "cccccccc-cccc-4ccc-8ccc-cccccccccccc";
const ARTIST_AUTHORITY_ID: &str = "dddddddd-dddd-4ddd-8ddd-dddddddddddd";
const CONFLICT_AUTHORITY_ID: &str = "eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee";
const COMPOSER_MBID: &str = "11111111-2222-4333-8444-555555555555";
const ARTIST_MBID: &str = "22222222-3333-4444-8555-666666666666";
const SNAPSHOT_KEY: &str =
    "wikidata:f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1";

#[derive(Debug, Clone)]
struct ManualFixture {
    id: i32,
    name: String,
    english_name: String,
    birth_year: String,
}

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

fn foreign_key(column: &str, table: &str, natural_key: &str) -> Value {
    json!({
        "column": column,
        "target_table": table,
        "target_natural_key": natural_key,
        "resolution": "bundle"
    })
}

fn canonical_record(
    table: &str,
    natural_key: &str,
    values: Value,
    foreign_keys: Vec<Value>,
) -> Value {
    json!({
        "db_contract_version": "global-seed-v1",
        "seed_run_id": GLOBAL_RUN_ID,
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

fn source_key(source_id: &str) -> String {
    format!("{SNAPSHOT_KEY}:{source_id}")
}

fn source_record(source_id: &str) -> Value {
    canonical_record(
        "source_records",
        &source_key(source_id),
        json!({
            "source_record_id": source_id,
            "entity_type": "person",
            "payload_sha256": match source_id {
                "Q-COMPOSER" => "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
                "Q-ARTIST" => "cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc",
                _ => "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"
            },
            "payload": {"id": source_id, "fixture": true}
        }),
        vec![foreign_key("snapshot_id", "source_snapshots", SNAPSHOT_KEY)],
    )
}

fn authority(entity_id: &str, source_id: &str) -> Value {
    canonical_record(
        "authority_entities",
        entity_id,
        json!({
            "id": entity_id,
            "entity_kind": "person",
            "editorial_status": "IDENTIFIERS_MATCHED",
            "origin": "seed",
            "editor_locked": false
        }),
        vec![foreign_key(
            "canonical_source_record_id",
            "source_records",
            &source_key(source_id),
        )],
    )
}

fn identifier(authority_id: &str, source_id: &str, namespace: &str, external_id: &str) -> Value {
    canonical_record(
        "external_identifiers",
        &format!("{namespace}:{external_id}"),
        json!({"namespace": namespace, "external_id": external_id}),
        vec![
            foreign_key("authority_entity_id", "authority_entities", authority_id),
            foreign_key("source_record_id", "source_records", &source_key(source_id)),
        ],
    )
}

fn full_canonical_bundle() -> Vec<Value> {
    vec![
        canonical_record(
            "seed_runs",
            GLOBAL_RUN_ID,
            json!({
                "id": GLOBAL_RUN_ID,
                "run_kind": "global_seed",
                "command": "legacy linkage integration fixture",
                "status": "PENDING",
                "dry_run": false,
                "source_code_version": "integration-v1",
                "manifest": {"fixture": "legacy-linkage"},
                "summary": {}
            }),
            vec![],
        ),
        canonical_record(
            "source_snapshots",
            SNAPSHOT_KEY,
            json!({
                "source": "wikidata",
                "source_uri": "https://www.wikidata.org/",
                "retrieved_at": "2026-08-05T00:00:00Z",
                "source_version": "fixture",
                "license": "CC0-1.0",
                "sha256": "f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1",
                "row_count": 3,
                "tool_version": "integration-v1",
                "storage_path": "/fixture/wikidata.jsonl"
            }),
            vec![foreign_key("seed_run_id", "seed_runs", GLOBAL_RUN_ID)],
        ),
        source_record("Q-COMPOSER"),
        source_record("Q-ARTIST"),
        source_record("Q-CONFLICT"),
        authority(COMPOSER_AUTHORITY_ID, "Q-COMPOSER"),
        authority(ARTIST_AUTHORITY_ID, "Q-ARTIST"),
        authority(CONFLICT_AUTHORITY_ID, "Q-CONFLICT"),
        identifier(COMPOSER_AUTHORITY_ID, "Q-COMPOSER", "wikidata", "Q1339"),
        identifier(
            COMPOSER_AUTHORITY_ID,
            "Q-COMPOSER",
            "musicbrainz_artist",
            COMPOSER_MBID,
        ),
        identifier(
            ARTIST_AUTHORITY_ID,
            "Q-ARTIST",
            "musicbrainz_artist",
            ARTIST_MBID,
        ),
        identifier(
            CONFLICT_AUTHORITY_ID,
            "Q-CONFLICT",
            "wikidata",
            "Q999999999",
        ),
        canonical_record(
            "composers",
            &format!("musicbrainz_artist:{COMPOSER_MBID}"),
            json!({
                "name": "시드 표시명",
                "full_name": "시드 전체 표시명",
                "english_name": "Seed Composer Display",
                "period": "근현대",
                "tier": "B",
                "birth_year": 1900,
                "death_year": 2000,
                "nationality": "Seed",
                "origin": "seed",
                "editor_locked": false
            }),
            vec![
                foreign_key(
                    "authority_entity_id",
                    "authority_entities",
                    COMPOSER_AUTHORITY_ID,
                ),
                foreign_key(
                    "source_record_id",
                    "source_records",
                    &source_key("Q-COMPOSER"),
                ),
            ],
        ),
        canonical_record(
            "artists",
            &format!("musicbrainz_artist:{ARTIST_MBID}"),
            json!({
                "name": "시드 아티스트 표시명",
                "english_name": "Seed Artist Display",
                "category": "pianist",
                "tier": "B",
                "birth_year": "1900",
                "nationality": "Seed",
                "origin": "seed",
                "editor_locked": false
            }),
            vec![
                foreign_key(
                    "authority_entity_id",
                    "authority_entities",
                    ARTIST_AUTHORITY_ID,
                ),
                foreign_key(
                    "source_record_id",
                    "source_records",
                    &source_key("Q-ARTIST"),
                ),
            ],
        ),
    ]
}

fn write_jsonl(name: &str, records: &[Value]) -> PathBuf {
    let path = unique_path(name);
    let contents = records
        .iter()
        .map(|record| serde_json::to_string(record).expect("fixture 직렬화"))
        .collect::<Vec<_>>()
        .join("\n");
    fs::write(&path, format!("{contents}\n")).expect("fixture 작성");
    path
}

fn linkage_record(
    entity_type: &str,
    fixture: &ManualFixture,
    namespace: &str,
    value: &str,
) -> Value {
    json!({
        "entityType": entity_type,
        "legacyId": fixture.id,
        "expectedFingerprint": {
            "name": fixture.name,
            "englishName": fixture.english_name,
            "birthYear": fixture.birth_year
        },
        "authorityIdentifier": {"namespace": namespace, "value": value},
        "reviewedAt": "2026-08-05T00:00:00Z",
        "reviewer": "integration-reviewer",
        "evidence": {
            "url": "https://www.wikidata.org/",
            "note": "명시적 외부 식별자 검수 fixture"
        }
    })
}

async fn manual_fixture(pool: &db::DbPool, table: &str) -> ManualFixture {
    let query = format!(
        "SELECT id, name, english_name, CAST(birth_year AS CHAR) AS birth_year
         FROM {table}
         WHERE origin='manual' AND editor_locked=TRUE
           AND authority_entity_id IS NULL
           AND english_name IS NOT NULL AND english_name <> ''
           AND birth_year IS NOT NULL
         ORDER BY id LIMIT 1"
    );
    let row: (i32, String, String, String) = sqlx::query_as(&query)
        .fetch_one(pool)
        .await
        .expect("manual fixture");
    ManualFixture {
        id: row.0,
        name: row.1,
        english_name: row.2,
        birth_year: row.3,
    }
}

async fn checksums(pool: &db::DbPool, composer_id: i32, artist_id: i32) -> (String, String) {
    sqlx::query_as(
        "SELECT
            SHA2(CAST(JSON_OBJECT(
                'composer', JSON_OBJECT(
                    'id', composer.id, 'name', composer.name,
                    'full_name', composer.full_name, 'english_name', composer.english_name,
                    'period', composer.period, 'tier', composer.tier,
                    'birth_year', composer.birth_year, 'death_year', composer.death_year,
                    'nationality', composer.nationality, 'avatar_url', composer.avatar_url,
                    'cover_image_url', composer.cover_image_url, 'bio', composer.bio,
                    'style', composer.style, 'influence', composer.influence,
                    'origin', composer.origin, 'editor_locked', composer.editor_locked
                ),
                'artist', JSON_OBJECT(
                    'id', artist.id, 'name', artist.name,
                    'english_name', artist.english_name, 'category', artist.category,
                    'tier', artist.tier, 'rating', artist.rating,
                    'image_url', artist.image_url, 'cover_image_url', artist.cover_image_url,
                    'birth_year', artist.birth_year, 'nationality', artist.nationality,
                    'bio', artist.bio, 'style', artist.style,
                    'concert_count', artist.concert_count, 'album_count', artist.album_count,
                    'top_award_id', artist.top_award_id,
                    'origin', artist.origin, 'editor_locked', artist.editor_locked
                )
            ) AS CHAR), 256),
            SHA2(CONCAT_WS('|',
                composer.id, COALESCE(composer.authority_entity_id, ''),
                COALESCE(composer.source_record_id, ''), artist.id,
                COALESCE(artist.authority_entity_id, ''),
                COALESCE(artist.source_record_id, '')
            ), 256)
         FROM composers composer JOIN artists artist
         WHERE composer.id=? AND artist.id=?",
    )
    .bind(composer_id)
    .bind(artist_id)
    .fetch_one(pool)
    .await
    .expect("manual checksum")
}

async fn database_state(pool: &db::DbPool, composer_id: i32, artist_id: i32) -> String {
    sqlx::query_scalar(
        "SELECT CONCAT(
            (SELECT COUNT(*) FROM seed_runs), ':',
            (SELECT COUNT(*) FROM seed_mutations), ':',
            (SELECT COALESCE(CAST(authority_entity_id AS CHAR CHARACTER SET utf8mb4), '')
             FROM composers WHERE id=?), ':',
            (SELECT COALESCE(CAST(authority_entity_id AS CHAR CHARACTER SET utf8mb4), '')
             FROM artists WHERE id=?)
         )",
    )
    .bind(composer_id)
    .bind(artist_id)
    .fetch_one(pool)
    .await
    .expect("DB state")
}

#[tokio::test]
#[ignore = "scripts/test_global_seed_migration.sh에서 격리 MySQL로 실행"]
async fn explicit_linkage_is_atomic_idempotent_and_manual_safe() {
    let pool = db::create_pool().await.expect("격리 테스트 DB 연결");
    let composer = manual_fixture(&pool, "composers").await;
    let artist = manual_fixture(&pool, "artists").await;
    let display_before = checksums(&pool, composer.id, artist.id).await;
    let full_bundle = write_jsonl("legacy-link-full", &full_canonical_bundle());
    let bootstrap_bundle = unique_path("legacy-link-bootstrap");

    let mut prepare = AuthorityBootstrapOptions::new(full_bundle.clone(), bootstrap_bundle.clone());
    prepare.run_id = Some(Uuid::parse_str(GLOBAL_RUN_ID).expect("global UUID"));
    prepare.dry_run = true;
    let dry_prepare =
        GlobalSeedLoader::prepare_authority_bootstrap(&prepare).expect("bootstrap dry-run");
    assert!(!dry_prepare.written);
    assert!(!bootstrap_bundle.exists());
    assert_eq!(dry_prepare.table_counts.get("composers"), None);
    assert_eq!(dry_prepare.table_counts.get("artists"), None);

    prepare.dry_run = false;
    let prepared = GlobalSeedLoader::prepare_authority_bootstrap(&prepare).expect("bootstrap 생성");
    assert!(prepared.written);
    let prepared_again =
        GlobalSeedLoader::prepare_authority_bootstrap(&prepare).expect("bootstrap 결정적 재사용");
    assert!(!prepared_again.written);
    assert_eq!(prepared.output_sha256, prepared_again.output_sha256);

    let bootstrap_options = GlobalSeedLoadOptions::new(bootstrap_bundle.clone());
    GlobalSeedLoader::load(&pool, &bootstrap_options)
        .await
        .expect("authority bootstrap 적재");
    let projection_count: i64 = sqlx::query_scalar(
        "SELECT
            (SELECT COUNT(*) FROM composers WHERE authority_entity_id IN (?, ?))
            +
            (SELECT COUNT(*) FROM artists WHERE authority_entity_id IN (?, ?))",
    )
    .bind(COMPOSER_AUTHORITY_ID)
    .bind(ARTIST_AUTHORITY_ID)
    .bind(COMPOSER_AUTHORITY_ID)
    .bind(ARTIST_AUTHORITY_ID)
    .fetch_one(&pool)
    .await
    .expect("bootstrap projection 없음");
    assert_eq!(projection_count, 0);

    let links = vec![
        linkage_record("composer", &composer, "wikidata", "Q1339"),
        linkage_record("artist", &artist, "musicbrainz_artist", ARTIST_MBID),
    ];
    let link_bundle = write_jsonl("legacy-links", &links);
    let mut atomic_failure_records = links.clone();
    atomic_failure_records[1]["expectedFingerprint"]["name"] = json!("잘못된 이름");
    let atomic_failure_bundle = write_jsonl("legacy-link-atomic-failure", &atomic_failure_records);
    let before_atomic_failure = database_state(&pool, composer.id, artist.id).await;
    let atomic_failure_options = LegacyAuthorityLinkOptions::new(
        atomic_failure_bundle.clone(),
        Uuid::parse_str(ATOMIC_FAILURE_RUN_ID).expect("atomic failure UUID"),
    );
    let atomic_failure = LegacyAuthorityLinker::link(&pool, &atomic_failure_options)
        .await
        .expect_err("후반 fingerprint mismatch");
    assert_eq!(atomic_failure.code(), "LEGACY_FINGERPRINT_MISMATCH");
    assert_eq!(
        database_state(&pool, composer.id, artist.id).await,
        before_atomic_failure
    );

    let mut link_options = LegacyAuthorityLinkOptions::new(
        link_bundle.clone(),
        Uuid::parse_str(LINK_RUN_ID).expect("link UUID"),
    );
    link_options.dry_run = true;
    let dry_link = LegacyAuthorityLinker::link(&pool, &link_options)
        .await
        .expect("link dry-run");
    assert_eq!(dry_link.mutations.total, 0);
    assert_eq!(dry_link.planned_mutations.total, 2);
    assert_eq!(
        checksums(&pool, composer.id, artist.id).await,
        display_before
    );

    link_options.dry_run = false;
    let linked = LegacyAuthorityLinker::link(&pool, &link_options)
        .await
        .expect("명시 link");
    assert_eq!(linked.mutations.total, 2);
    assert_eq!(linked.mutations.source_record_linked, 2);
    let after_link = checksums(&pool, composer.id, artist.id).await;
    assert_eq!(after_link.0, display_before.0);
    assert_ne!(after_link.1, display_before.1);
    let linked_guards: (String, bool, String, bool) = sqlx::query_as(
        "SELECT composer.origin, composer.editor_locked, artist.origin, artist.editor_locked
         FROM composers composer JOIN artists artist
         WHERE composer.id=? AND artist.id=?",
    )
    .bind(composer.id)
    .bind(artist.id)
    .fetch_one(&pool)
    .await
    .expect("manual guard 유지");
    assert_eq!(
        linked_guards,
        ("manual".to_string(), true, "manual".to_string(), true)
    );
    let audit_count: i64 = sqlx::query_scalar(
        "SELECT COUNT(*) FROM seed_mutations
         WHERE seed_run_id=? AND manual_guard_confirmed=TRUE",
    )
    .bind(LINK_RUN_ID)
    .fetch_one(&pool)
    .await
    .expect("link audit");
    assert_eq!(audit_count, 2);

    let rerun = LegacyAuthorityLinker::link(&pool, &link_options)
        .await
        .expect("link 재실행");
    assert_eq!(rerun.mutations.total, 0);
    assert_eq!(rerun.planned_mutations.total, 0);

    sqlx::query("UPDATE artists SET authority_entity_id=NULL, source_record_id=NULL WHERE id=?")
        .bind(artist.id)
        .execute(&pool)
        .await
        .expect("resume 복구 fixture");
    let repaired = LegacyAuthorityLinker::link(&pool, &link_options)
        .await
        .expect("동일 run resume 복구");
    assert_eq!(repaired.mutations.total, 1);
    let audit_rollbacks = repaired
        .rollback_manifest
        .entries
        .iter()
        .filter(|entry| entry.target_table == "seed_mutations")
        .collect::<Vec<_>>();
    assert_eq!(audit_rollbacks.len(), 1);
    assert_eq!(audit_rollbacks[0].reverse_operation, "DELETE");
    assert!(audit_rollbacks[0].target_id.parse::<u64>().is_ok());
    let repaired_audit_count: i64 =
        sqlx::query_scalar("SELECT COUNT(*) FROM seed_mutations WHERE seed_run_id=?")
            .bind(LINK_RUN_ID)
            .fetch_one(&pool)
            .await
            .expect("resume audit");
    assert_eq!(repaired_audit_count, 3);

    link_options.dry_run = true;
    let second_dry = LegacyAuthorityLinker::link(&pool, &link_options)
        .await
        .expect("link 두 번째 dry-run");
    assert_eq!(second_dry.planned_mutations.total, 0);

    let full_options = GlobalSeedLoadOptions::new(full_bundle.clone());
    GlobalSeedLoader::load(&pool, &full_options)
        .await
        .expect("명시 link 뒤 full canonical 적재");
    assert_eq!(
        checksums(&pool, composer.id, artist.id).await.0,
        display_before.0
    );
    let projection_duplicates: (i64, i64) = sqlx::query_as(
        "SELECT
            (SELECT COUNT(*) FROM composers WHERE authority_entity_id=?),
            (SELECT COUNT(*) FROM artists WHERE authority_entity_id=?)",
    )
    .bind(COMPOSER_AUTHORITY_ID)
    .bind(ARTIST_AUTHORITY_ID)
    .fetch_one(&pool)
    .await
    .expect("projection 중복");
    assert_eq!(projection_duplicates, (1, 1));
    let full_rerun = GlobalSeedLoader::load(&pool, &full_options)
        .await
        .expect("full canonical 재실행");
    assert_eq!(full_rerun.mutations.total, 0);

    let mut mismatch = linkage_record("composer", &composer, "wikidata", "Q1339");
    mismatch["expectedFingerprint"]["name"] = json!("잘못된 이름");
    let mismatch_bundle = write_jsonl("legacy-link-mismatch", &[mismatch]);
    let before_failure = database_state(&pool, composer.id, artist.id).await;
    let mismatch_options = LegacyAuthorityLinkOptions::new(
        mismatch_bundle.clone(),
        Uuid::parse_str(MISMATCH_RUN_ID).expect("mismatch UUID"),
    );
    let mismatch_error = LegacyAuthorityLinker::link(&pool, &mismatch_options)
        .await
        .expect_err("fingerprint mismatch");
    assert_eq!(mismatch_error.code(), "LEGACY_FINGERPRINT_MISMATCH");
    assert_eq!(
        database_state(&pool, composer.id, artist.id).await,
        before_failure
    );

    let conflict = linkage_record("composer", &composer, "wikidata", "Q999999999");
    let conflict_bundle = write_jsonl("legacy-link-conflict", &[conflict]);
    let conflict_options = LegacyAuthorityLinkOptions::new(
        conflict_bundle.clone(),
        Uuid::parse_str(CONFLICT_RUN_ID).expect("conflict UUID"),
    );
    let conflict_error = LegacyAuthorityLinker::link(&pool, &conflict_options)
        .await
        .expect_err("다른 authority 충돌");
    assert_eq!(conflict_error.code(), "LEGACY_AUTHORITY_CONFLICT");
    assert_eq!(
        database_state(&pool, composer.id, artist.id).await,
        before_failure
    );

    let cli_help = Command::new(env!("CARGO_BIN_EXE_link_legacy_authorities"))
        .arg("--help")
        .output()
        .expect("link CLI help");
    assert!(cli_help.status.success());
    let prepare_help = Command::new(env!("CARGO_BIN_EXE_prepare_legacy_authority_bootstrap"))
        .arg("--help")
        .output()
        .expect("prepare CLI help");
    assert!(prepare_help.status.success());

    for path in [
        full_bundle,
        bootstrap_bundle,
        link_bundle,
        atomic_failure_bundle,
        mismatch_bundle,
        conflict_bundle,
    ] {
        fs::remove_file(path).expect("fixture 삭제");
    }
}
