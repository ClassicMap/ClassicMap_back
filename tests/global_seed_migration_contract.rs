use ClassicMap_back::db::MIGRATOR;

const GLOBAL_SEED_SCHEMA: &str = include_str!("../migrations/202608050001_global_seed_schema.sql");
const COMPARISON_API_SCHEMA: &str =
    include_str!("../migrations/202608050002_comparison_api_contract.sql");
const LEGACY_PERFORMANCE_BACKFILL: &str =
    include_str!("../migrations/202608050003_backfill_legacy_performances.sql");
const CLIP_ASSET_LOADER_SCHEMA: &str =
    include_str!("../migrations/202608050004_clip_asset_loader_contract.sql");
const COMPOSER_PERIOD_SCHEMA: &str =
    include_str!("../migrations/202608050005_expand_composer_periods.sql");
const APPLE_MUSIC_BACKFILL: &str =
    include_str!("../migrations/202608050006_backfill_apple_music_album_links.sql");
const GLOBAL_SEED_LOADER_REGISTRY: &str =
    include_str!("../migrations/202608050007_global_seed_loader_registry.sql");
const BINARY_NORMALIZED_NAME_IDENTITY: &str =
    include_str!("../migrations/202608050008_binary_normalized_name_identity.sql");
const MULTIPLE_AUTHORITY_IDS: &str =
    include_str!("../migrations/202608050009_allow_multiple_authority_ids_per_namespace.sql");

#[test]
fn migrator_embeds_all_global_seed_migrations() {
    assert_eq!(MIGRATOR.iter().count(), 9);
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
    assert!(CLIP_ASSET_LOADER_SCHEMA.contains("ADD COLUMN asset_validated_at"));
    assert!(CLIP_ASSET_LOADER_SCHEMA.contains("ADD COLUMN range_verified_at"));
    assert!(CLIP_ASSET_LOADER_SCHEMA.contains("uq_clip_assets_performance_storage"));
    assert!(COMPOSER_PERIOD_SCHEMA.contains("'중세'"));
    assert!(COMPOSER_PERIOD_SCHEMA.contains("'르네상스'"));
    assert!(APPLE_MUSIC_BACKFILL.contains("INSERT INTO platform_links"));
    assert!(!APPLE_MUSIC_BACKFILL.contains("INSERT IGNORE INTO"));
    assert!(GLOBAL_SEED_LOADER_REGISTRY.contains("CREATE TABLE seed_natural_keys"));
    assert!(GLOBAL_SEED_LOADER_REGISTRY.contains("natural_key_sha256 CHAR(64)"));
    assert!(GLOBAL_SEED_LOADER_REGISTRY.contains("record_fingerprint CHAR(64)"));
    assert!(!GLOBAL_SEED_LOADER_REGISTRY.contains("INSERT IGNORE"));
    assert!(BINARY_NORMALIZED_NAME_IDENTITY.contains("tmp_entity_name_binary_identity"));
    assert!(BINARY_NORMALIZED_NAME_IDENTITY.contains("tmp_piece_alias_binary_identity"));
    assert!(BINARY_NORMALIZED_NAME_IDENTITY.contains("COLLATE utf8mb4_bin"));
    assert!(BINARY_NORMALIZED_NAME_IDENTITY.contains("ADD UNIQUE KEY uq_entity_names_identity"));
    assert!(BINARY_NORMALIZED_NAME_IDENTITY.contains("ADD UNIQUE KEY uq_piece_aliases_identity"));
    assert!(MULTIPLE_AUTHORITY_IDS.contains("DROP INDEX uq_external_identifiers_entity_namespace"));
    assert!(MULTIPLE_AUTHORITY_IDS.contains("ADD INDEX idx_external_identifiers_entity"));
    assert!(!MULTIPLE_AUTHORITY_IDS.contains("DROP INDEX uq_external_identifiers_namespace_value"));
}
