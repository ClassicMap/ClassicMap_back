use ClassicMap_back::db::MIGRATOR;

const GLOBAL_SEED_SCHEMA: &str = include_str!("../migrations/202608050001_global_seed_schema.sql");
const COMPARISON_API_SCHEMA: &str =
    include_str!("../migrations/202608050002_comparison_api_contract.sql");
const LEGACY_PERFORMANCE_BACKFILL: &str =
    include_str!("../migrations/202608050003_backfill_legacy_performances.sql");

#[test]
fn migrator_embeds_all_global_seed_migrations() {
    assert_eq!(MIGRATOR.iter().count(), 3);
}

#[test]
fn global_seed_migration_is_additive() {
    let normalized = GLOBAL_SEED_SCHEMA.to_ascii_uppercase();
    assert!(!normalized.contains("DROP TABLE"));
    assert!(!normalized.contains("TRUNCATE TABLE"));
    assert!(!normalized.contains("RENAME TABLE"));
}

#[test]
fn global_seed_migration_contains_required_contracts() {
    for table in [
        "authority_entities",
        "entity_names",
        "entity_roles",
        "entity_instruments",
        "entity_countries",
        "external_identifiers",
        "entity_images",
        "piece_aliases",
        "piece_identifiers",
        "piece_parts",
        "piece_relations",
        "piece_instrumentation",
        "recording_tracks",
        "recording_contributors",
        "track_piece_links",
        "platform_links",
        "seed_runs",
        "source_snapshots",
        "source_records",
        "field_provenance",
        "review_queue",
        "seed_mutations",
        "performance_sources",
        "performance_credits",
        "performance_candidates",
        "clip_jobs",
        "clip_assets",
    ] {
        assert!(
            GLOBAL_SEED_SCHEMA.contains(&format!("CREATE TABLE {table}")),
            "필수 테이블 누락: {table}"
        );
    }

    assert!(GLOBAL_SEED_SCHEMA.contains("editor_locked BOOLEAN NOT NULL DEFAULT TRUE"));
    assert!(GLOBAL_SEED_SCHEMA.contains("end_ms - start_ms <= 600000"));
    assert!(GLOBAL_SEED_SCHEMA.contains("uq_external_identifiers_namespace_value"));
    assert!(GLOBAL_SEED_SCHEMA.contains("uq_clip_assets_current_performance"));
    assert!(COMPARISON_API_SCHEMA.contains("ADD COLUMN public_url"));
    assert!(LEGACY_PERFORMANCE_BACKFILL.contains("INSERT IGNORE INTO performance_sources"));
    assert!(LEGACY_PERFORMANCE_BACKFILL.contains("INSERT IGNORE INTO performance_credits"));
}
