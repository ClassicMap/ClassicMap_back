use crate::db::DbPool;
use chrono::{DateTime, NaiveDate, NaiveDateTime};
use serde::{Deserialize, Serialize};
use serde_json::{Map, Value};
use sha2::{Digest, Sha256};
use sqlx::{MySql, QueryBuilder, Row, Transaction};
use std::{
    collections::{BTreeMap, HashMap, HashSet},
    fmt,
    fs::File,
    io::{BufRead, BufReader},
    path::PathBuf,
};
use uuid::Uuid;

const CONTRACT_VERSION: &str = "global-seed-v1";
const WRITE_POLICY: &str = "preserve_manual_or_locked";

#[derive(Debug, Clone)]
pub struct GlobalSeedLoadOptions {
    pub bundle_path: PathBuf,
    pub dry_run: bool,
    pub run_id: Option<Uuid>,
    pub resume: bool,
    pub limit: Option<usize>,
}

impl GlobalSeedLoadOptions {
    pub fn new(bundle_path: PathBuf) -> Self {
        Self {
            bundle_path,
            dry_run: false,
            run_id: None,
            resume: true,
            limit: None,
        }
    }
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash, PartialOrd, Ord)]
#[serde(rename_all = "snake_case")]
pub enum LoadTable {
    SeedRuns,
    SourceSnapshots,
    SourceRecords,
    AuthorityEntities,
    EntityNames,
    EntityRoles,
    EntityInstruments,
    EntityCountries,
    EntityImages,
    Composers,
    Artists,
    Pieces,
    PieceAliases,
    PieceIdentifiers,
    PieceParts,
    PieceRelations,
    PieceInstrumentation,
    Recordings,
    ExternalIdentifiers,
    FieldProvenance,
    ReviewQueue,
    RecordingTracks,
    PlatformLinks,
    TrackPieceLinks,
}

impl LoadTable {
    pub const ALL: [Self; 24] = [
        Self::SeedRuns,
        Self::SourceSnapshots,
        Self::SourceRecords,
        Self::AuthorityEntities,
        Self::EntityNames,
        Self::EntityRoles,
        Self::EntityInstruments,
        Self::EntityCountries,
        Self::EntityImages,
        Self::Composers,
        Self::Artists,
        Self::Pieces,
        Self::PieceAliases,
        Self::PieceIdentifiers,
        Self::PieceParts,
        Self::PieceRelations,
        Self::PieceInstrumentation,
        Self::Recordings,
        Self::ExternalIdentifiers,
        Self::FieldProvenance,
        Self::ReviewQueue,
        Self::RecordingTracks,
        Self::PlatformLinks,
        Self::TrackPieceLinks,
    ];

    pub const fn as_str(self) -> &'static str {
        match self {
            Self::SeedRuns => "seed_runs",
            Self::SourceSnapshots => "source_snapshots",
            Self::SourceRecords => "source_records",
            Self::AuthorityEntities => "authority_entities",
            Self::EntityNames => "entity_names",
            Self::EntityRoles => "entity_roles",
            Self::EntityInstruments => "entity_instruments",
            Self::EntityCountries => "entity_countries",
            Self::EntityImages => "entity_images",
            Self::Composers => "composers",
            Self::Artists => "artists",
            Self::Pieces => "pieces",
            Self::PieceAliases => "piece_aliases",
            Self::PieceIdentifiers => "piece_identifiers",
            Self::PieceParts => "piece_parts",
            Self::PieceRelations => "piece_relations",
            Self::PieceInstrumentation => "piece_instrumentation",
            Self::Recordings => "recordings",
            Self::ExternalIdentifiers => "external_identifiers",
            Self::FieldProvenance => "field_provenance",
            Self::ReviewQueue => "review_queue",
            Self::RecordingTracks => "recording_tracks",
            Self::PlatformLinks => "platform_links",
            Self::TrackPieceLinks => "track_piece_links",
        }
    }
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq)]
#[serde(rename_all = "snake_case")]
enum ForeignKeyResolution {
    Bundle,
    BundleOrExisting,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(deny_unknown_fields)]
struct LoadForeignKey {
    column: String,
    target_table: LoadTable,
    target_natural_key: String,
    #[serde(default = "default_fk_resolution")]
    resolution: ForeignKeyResolution,
}

const fn default_fk_resolution() -> ForeignKeyResolution {
    ForeignKeyResolution::Bundle
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(deny_unknown_fields)]
struct CanonicalLoadRecord {
    db_contract_version: String,
    seed_run_id: String,
    table: LoadTable,
    natural_key: String,
    values: Map<String, Value>,
    #[serde(default)]
    foreign_keys: Vec<LoadForeignKey>,
    #[serde(default)]
    evidence: Map<String, Value>,
    #[serde(default = "default_origin")]
    origin: String,
    #[serde(default)]
    editor_locked: bool,
    #[serde(default = "default_write_policy")]
    write_policy: String,
}

fn default_origin() -> String {
    "seed".to_string()
}

fn default_write_policy() -> String {
    WRITE_POLICY.to_string()
}

#[derive(Debug, Clone)]
struct BundleRecord {
    line: usize,
    record: CanonicalLoadRecord,
    fingerprint: String,
}

#[derive(Debug, Clone, Default, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct GlobalSeedMutationCounts {
    pub inserted: u64,
    pub updated: u64,
    pub reused: u64,
    pub protected_reused: u64,
    pub registry_mappings: u64,
    pub total: u64,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct RollbackEntry {
    sequence: usize,
    target_table: String,
    target_id: String,
    reverse_operation: String,
    restore_json: Option<Value>,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct RollbackManifest {
    schema_version: &'static str,
    seed_run_id: String,
    dry_run: bool,
    entries: Vec<RollbackEntry>,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct GlobalSeedLoadReport {
    pub status: &'static str,
    pub contract_version: &'static str,
    pub bundle_path: String,
    pub seed_run_id: String,
    pub row_count: usize,
    pub dry_run: bool,
    pub mutations: GlobalSeedMutationCounts,
    pub planned_mutations: GlobalSeedMutationCounts,
    pub table_mutations: BTreeMap<String, u64>,
    pub rollback_manifest: RollbackManifest,
}

#[derive(Debug)]
pub enum GlobalSeedLoadError {
    Input {
        code: &'static str,
        message: String,
        line: Option<usize>,
    },
    Io(std::io::Error),
    Database(sqlx::Error),
}

impl GlobalSeedLoadError {
    pub const fn code(&self) -> &'static str {
        match self {
            Self::Input { code, .. } => code,
            Self::Io(_) => "INPUT_IO_ERROR",
            Self::Database(_) => "DATABASE_ERROR",
        }
    }

    pub const fn line(&self) -> Option<usize> {
        match self {
            Self::Input { line, .. } => *line,
            Self::Io(_) | Self::Database(_) => None,
        }
    }

    pub const fn exit_code(&self) -> i32 {
        match self {
            Self::Input { .. } | Self::Io(_) => 2,
            Self::Database(_) => 3,
        }
    }

    fn input(code: &'static str, message: impl Into<String>, line: Option<usize>) -> Self {
        Self::Input {
            code,
            message: message.into(),
            line,
        }
    }
}

impl fmt::Display for GlobalSeedLoadError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Input { message, .. } => formatter.write_str(message),
            Self::Io(error) => write!(formatter, "bundle 파일 오류: {error}"),
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
        }
    }
}

impl std::error::Error for GlobalSeedLoadError {}

impl From<std::io::Error> for GlobalSeedLoadError {
    fn from(error: std::io::Error) -> Self {
        Self::Io(error)
    }
}

impl From<sqlx::Error> for GlobalSeedLoadError {
    fn from(error: sqlx::Error) -> Self {
        Self::Database(error)
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum ColumnKind {
    String,
    Signed,
    Unsigned,
    Decimal,
    Boolean,
    Json,
    Timestamp,
    Date,
}

#[derive(Debug, Clone, Copy)]
struct ColumnSpec {
    name: &'static str,
    kind: ColumnKind,
    required: bool,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum IdKind {
    Supplied,
    Auto,
}

#[derive(Debug, Clone, Copy)]
struct TableSpec {
    columns: &'static [ColumnSpec],
    id_kind: IdKind,
    guarded: bool,
    immutable: bool,
}

macro_rules! column {
    ($name:literal, $kind:ident, $required:expr) => {
        ColumnSpec {
            name: $name,
            kind: ColumnKind::$kind,
            required: $required,
        }
    };
}

const SEED_RUN_COLUMNS: &[ColumnSpec] = &[
    column!("id", String, true),
    column!("run_kind", String, true),
    column!("command", String, true),
    column!("status", String, false),
    column!("dry_run", Boolean, false),
    column!("source_code_version", String, false),
    column!("manifest", Json, false),
    column!("summary", Json, false),
    column!("finished_at", Timestamp, false),
];
const SOURCE_SNAPSHOT_COLUMNS: &[ColumnSpec] = &[
    column!("seed_run_id", String, true),
    column!("source", String, true),
    column!("source_uri", String, true),
    column!("retrieved_at", Timestamp, true),
    column!("source_version", String, false),
    column!("license", String, true),
    column!("sha256", String, true),
    column!("row_count", Unsigned, false),
    column!("tool_version", String, true),
    column!("storage_path", String, true),
];
const SOURCE_RECORD_COLUMNS: &[ColumnSpec] = &[
    column!("snapshot_id", Unsigned, true),
    column!("source_record_id", String, true),
    column!("entity_type", String, true),
    column!("payload_sha256", String, true),
    column!("payload", Json, true),
];
const AUTHORITY_COLUMNS: &[ColumnSpec] = &[
    column!("id", String, true),
    column!("entity_kind", String, true),
    column!("editorial_status", String, false),
    column!("origin", String, false),
    column!("editor_locked", Boolean, false),
    column!("canonical_source_record_id", Unsigned, false),
];
const ENTITY_NAME_COLUMNS: &[ColumnSpec] = &[
    column!("authority_entity_id", String, true),
    column!("locale", String, true),
    column!("name_kind", String, true),
    column!("name_value", String, true),
    column!("normalized_value", String, true),
    column!("is_preferred", Boolean, false),
    column!("transliteration_status", String, false),
    column!("origin", String, false),
    column!("editor_locked", Boolean, false),
    column!("source_record_id", Unsigned, false),
];
const ENTITY_ROLE_COLUMNS: &[ColumnSpec] = &[
    column!("authority_entity_id", String, true),
    column!("role_code", String, true),
    column!("is_primary", Boolean, false),
    column!("source_record_id", Unsigned, false),
];
const ENTITY_INSTRUMENT_COLUMNS: &[ColumnSpec] = &[
    column!("authority_entity_id", String, true),
    column!("instrument_code", String, true),
    column!("is_primary", Boolean, false),
    column!("source_record_id", Unsigned, false),
];
const ENTITY_COUNTRY_COLUMNS: &[ColumnSpec] = &[
    column!("authority_entity_id", String, true),
    column!("country_code", String, true),
    column!("relation_type", String, false),
    column!("source_record_id", Unsigned, false),
];
const ENTITY_IMAGE_COLUMNS: &[ColumnSpec] = &[
    column!("authority_entity_id", String, true),
    column!("image_kind", String, false),
    column!("source_url", String, true),
    column!("file_url", String, true),
    column!("author", String, false),
    column!("license", String, false),
    column!("license_url", String, false),
    column!("credit_line", String, false),
    column!("is_primary", Boolean, false),
    column!("editorial_status", String, false),
    column!("source_record_id", Unsigned, false),
];
const EXTERNAL_IDENTIFIER_COLUMNS: &[ColumnSpec] = &[
    column!("authority_entity_id", String, true),
    column!("namespace", String, true),
    column!("external_id", String, true),
    column!("source_record_id", Unsigned, false),
    column!("verified_at", Timestamp, false),
];
const COMPOSER_COLUMNS: &[ColumnSpec] = &[
    column!("name", String, true),
    column!("full_name", String, true),
    column!("english_name", String, true),
    column!("period", String, true),
    column!("tier", String, false),
    column!("birth_year", Signed, true),
    column!("death_year", Signed, false),
    column!("nationality", String, true),
    column!("avatar_url", String, false),
    column!("cover_image_url", String, false),
    column!("bio", String, false),
    column!("style", String, false),
    column!("influence", String, false),
    column!("authority_entity_id", String, false),
    column!("source_record_id", Unsigned, false),
    column!("origin", String, false),
    column!("editor_locked", Boolean, false),
];
const ARTIST_COLUMNS: &[ColumnSpec] = &[
    column!("name", String, true),
    column!("english_name", String, true),
    column!("category", String, true),
    column!("tier", String, false),
    column!("rating", Decimal, false),
    column!("image_url", String, false),
    column!("cover_image_url", String, false),
    column!("birth_year", String, false),
    column!("nationality", String, true),
    column!("bio", String, false),
    column!("style", String, false),
    column!("concert_count", Signed, false),
    column!("album_count", Signed, false),
    column!("top_award_id", Signed, false),
    column!("authority_entity_id", String, false),
    column!("source_record_id", Unsigned, false),
    column!("origin", String, false),
    column!("editor_locked", Boolean, false),
];
const PIECE_COLUMNS: &[ColumnSpec] = &[
    column!("composer_id", Signed, true),
    column!("title", String, true),
    column!("title_en", String, false),
    column!("type", String, false),
    column!("description", String, false),
    column!("opus_number", String, false),
    column!("composition_year", Signed, false),
    column!("difficulty_level", Signed, false),
    column!("duration_minutes", Signed, false),
    column!("spotify_url", String, false),
    column!("apple_music_url", String, false),
    column!("youtube_music_url", String, false),
    column!("catalogue_system", String, false),
    column!("catalogue_number", String, false),
    column!("work_type", String, false),
    column!("composition_date", String, false),
    column!("date_precision", String, false),
    column!("date_qualifier", String, false),
    column!("source_record_id", Unsigned, false),
    column!("origin", String, false),
    column!("editor_locked", Boolean, false),
];
const PIECE_ALIAS_COLUMNS: &[ColumnSpec] = &[
    column!("piece_id", Signed, true),
    column!("locale", String, true),
    column!("alias_kind", String, false),
    column!("alias_value", String, true),
    column!("normalized_value", String, true),
    column!("is_preferred", Boolean, false),
    column!("origin", String, false),
    column!("editor_locked", Boolean, false),
    column!("source_record_id", Unsigned, false),
];
const PIECE_IDENTIFIER_COLUMNS: &[ColumnSpec] = &[
    column!("piece_id", Signed, true),
    column!("namespace", String, true),
    column!("external_id", String, true),
    column!("source_record_id", Unsigned, false),
    column!("verified_at", Timestamp, false),
];
const PIECE_PART_COLUMNS: &[ColumnSpec] = &[
    column!("piece_id", Signed, true),
    column!("parent_part_id", Unsigned, false),
    column!("part_key", String, true),
    column!("sequence_number", Signed, true),
    column!("movement_number", String, false),
    column!("name_ko", String, false),
    column!("name_en", String, false),
    column!("duration_ms", Unsigned, false),
    column!("editorial_status", String, false),
    column!("origin", String, false),
    column!("editor_locked", Boolean, false),
    column!("source_record_id", Unsigned, false),
];
const PIECE_RELATION_COLUMNS: &[ColumnSpec] = &[
    column!("from_piece_id", Signed, true),
    column!("to_piece_id", Signed, true),
    column!("relation_type", String, true),
    column!("source_record_id", Unsigned, false),
];
const PIECE_INSTRUMENTATION_COLUMNS: &[ColumnSpec] = &[
    column!("piece_id", Signed, true),
    column!("instrument_code", String, true),
    column!("instrumentation_role", String, false),
    column!("minimum_count", Unsigned, false),
    column!("maximum_count", Unsigned, false),
    column!("notes", String, false),
    column!("source_record_id", Unsigned, false),
];
const RECORDING_COLUMNS: &[ColumnSpec] = &[
    column!("artist_id", Signed, true),
    column!("title", String, true),
    column!("year", String, true),
    column!("release_date", Date, false),
    column!("label", String, false),
    column!("cover_url", String, false),
    column!("upc", String, false),
    column!("apple_music_id", String, false),
    column!("track_count", Signed, false),
    column!("is_single", Boolean, false),
    column!("is_compilation", Boolean, false),
    column!("genre_names", Json, false),
    column!("copyright", String, false),
    column!("editorial_notes", String, false),
    column!("artwork_width", Signed, false),
    column!("artwork_height", Signed, false),
    column!("spotify_url", String, false),
    column!("apple_music_url", String, false),
    column!("youtube_music_url", String, false),
    column!("external_url", String, false),
    column!("source_record_id", Unsigned, false),
    column!("origin", String, false),
    column!("editor_locked", Boolean, false),
];
const RECORDING_TRACK_COLUMNS: &[ColumnSpec] = &[
    column!("recording_id", Signed, true),
    column!("track_key", String, true),
    column!("disc_number", Unsigned, false),
    column!("track_number", Unsigned, true),
    column!("title", String, true),
    column!("duration_ms", Unsigned, false),
    column!("isrc", String, false),
    column!("source_record_id", Unsigned, false),
    column!("origin", String, false),
    column!("editor_locked", Boolean, false),
];
const TRACK_PIECE_LINK_COLUMNS: &[ColumnSpec] = &[
    column!("track_id", Unsigned, true),
    column!("piece_id", Signed, true),
    column!("piece_part_id", Unsigned, false),
    column!("relation_type", String, false),
    column!("confidence", Decimal, false),
    column!("editorial_status", String, false),
    column!("source_record_id", Unsigned, false),
];
const PLATFORM_LINK_COLUMNS: &[ColumnSpec] = &[
    column!("recording_id", Signed, false),
    column!("track_id", Unsigned, false),
    column!("platform", String, true),
    column!("storefront", String, false),
    column!("platform_id", String, true),
    column!("url", String, true),
    column!("isrc", String, false),
    column!("verified_at", Timestamp, false),
    column!("source_record_id", Unsigned, false),
];
const FIELD_PROVENANCE_COLUMNS: &[ColumnSpec] = &[
    column!("seed_run_id", String, false),
    column!("source_record_id", Unsigned, false),
    column!("target_table", String, true),
    column!("target_id", String, true),
    column!("field_name", String, true),
    column!("origin", String, true),
    column!("confidence", Decimal, false),
    column!("editorial_status", String, false),
    column!("evidence", Json, false),
];
const REVIEW_QUEUE_COLUMNS: &[ColumnSpec] = &[
    column!("seed_run_id", String, false),
    column!("target_type", String, true),
    column!("target_id", String, true),
    column!("reason_code", String, true),
    column!("status", String, false),
    column!("priority", Signed, false),
    column!("evidence", Json, true),
    column!("resolution", Json, false),
    column!("resolved_at", Timestamp, false),
];

fn table_spec(table: LoadTable) -> TableSpec {
    match table {
        LoadTable::SeedRuns => TableSpec {
            columns: SEED_RUN_COLUMNS,
            id_kind: IdKind::Supplied,
            guarded: false,
            immutable: false,
        },
        LoadTable::SourceSnapshots => TableSpec {
            columns: SOURCE_SNAPSHOT_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: true,
        },
        LoadTable::SourceRecords => TableSpec {
            columns: SOURCE_RECORD_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: true,
        },
        LoadTable::AuthorityEntities => TableSpec {
            columns: AUTHORITY_COLUMNS,
            id_kind: IdKind::Supplied,
            guarded: true,
            immutable: false,
        },
        LoadTable::EntityNames => TableSpec {
            columns: ENTITY_NAME_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: true,
            immutable: false,
        },
        LoadTable::EntityRoles => TableSpec {
            columns: ENTITY_ROLE_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: false,
        },
        LoadTable::EntityInstruments => TableSpec {
            columns: ENTITY_INSTRUMENT_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: false,
        },
        LoadTable::EntityCountries => TableSpec {
            columns: ENTITY_COUNTRY_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: false,
        },
        LoadTable::EntityImages => TableSpec {
            columns: ENTITY_IMAGE_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: false,
        },
        LoadTable::Composers => TableSpec {
            columns: COMPOSER_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: true,
            immutable: false,
        },
        LoadTable::Artists => TableSpec {
            columns: ARTIST_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: true,
            immutable: false,
        },
        LoadTable::Pieces => TableSpec {
            columns: PIECE_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: true,
            immutable: false,
        },
        LoadTable::PieceAliases => TableSpec {
            columns: PIECE_ALIAS_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: true,
            immutable: false,
        },
        LoadTable::PieceIdentifiers => TableSpec {
            columns: PIECE_IDENTIFIER_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: false,
        },
        LoadTable::PieceParts => TableSpec {
            columns: PIECE_PART_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: true,
            immutable: false,
        },
        LoadTable::PieceRelations => TableSpec {
            columns: PIECE_RELATION_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: false,
        },
        LoadTable::PieceInstrumentation => TableSpec {
            columns: PIECE_INSTRUMENTATION_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: false,
        },
        LoadTable::Recordings => TableSpec {
            columns: RECORDING_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: true,
            immutable: false,
        },
        LoadTable::ExternalIdentifiers => TableSpec {
            columns: EXTERNAL_IDENTIFIER_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: false,
        },
        LoadTable::FieldProvenance => TableSpec {
            columns: FIELD_PROVENANCE_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: false,
        },
        LoadTable::ReviewQueue => TableSpec {
            columns: REVIEW_QUEUE_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: false,
        },
        LoadTable::RecordingTracks => TableSpec {
            columns: RECORDING_TRACK_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: true,
            immutable: false,
        },
        LoadTable::PlatformLinks => TableSpec {
            columns: PLATFORM_LINK_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: false,
        },
        LoadTable::TrackPieceLinks => TableSpec {
            columns: TRACK_PIECE_LINK_COLUMNS,
            id_kind: IdKind::Auto,
            guarded: false,
            immutable: false,
        },
    }
}

fn column_spec(table: LoadTable, column: &str) -> Option<ColumnSpec> {
    table_spec(table)
        .columns
        .iter()
        .copied()
        .find(|candidate| candidate.name == column)
}

fn expected_fk_target(table: LoadTable, column: &str) -> Option<LoadTable> {
    match (table, column) {
        (LoadTable::SourceSnapshots, "seed_run_id") => Some(LoadTable::SeedRuns),
        (LoadTable::SourceRecords, "snapshot_id") => Some(LoadTable::SourceSnapshots),
        (LoadTable::AuthorityEntities, "canonical_source_record_id") => {
            Some(LoadTable::SourceRecords)
        }
        (
            LoadTable::EntityNames
            | LoadTable::EntityRoles
            | LoadTable::EntityInstruments
            | LoadTable::EntityCountries
            | LoadTable::EntityImages
            | LoadTable::ExternalIdentifiers,
            "authority_entity_id",
        ) => Some(LoadTable::AuthorityEntities),
        (
            LoadTable::EntityNames
            | LoadTable::EntityRoles
            | LoadTable::EntityInstruments
            | LoadTable::EntityCountries
            | LoadTable::EntityImages
            | LoadTable::ExternalIdentifiers
            | LoadTable::Composers
            | LoadTable::Artists
            | LoadTable::Pieces
            | LoadTable::PieceAliases
            | LoadTable::PieceIdentifiers
            | LoadTable::PieceParts
            | LoadTable::PieceRelations
            | LoadTable::PieceInstrumentation
            | LoadTable::Recordings
            | LoadTable::RecordingTracks
            | LoadTable::PlatformLinks
            | LoadTable::TrackPieceLinks
            | LoadTable::FieldProvenance,
            "source_record_id",
        ) => Some(LoadTable::SourceRecords),
        (LoadTable::Composers | LoadTable::Artists, "authority_entity_id") => {
            Some(LoadTable::AuthorityEntities)
        }
        (LoadTable::Pieces, "composer_id") => Some(LoadTable::Composers),
        (
            LoadTable::PieceAliases
            | LoadTable::PieceIdentifiers
            | LoadTable::PieceParts
            | LoadTable::PieceInstrumentation
            | LoadTable::TrackPieceLinks,
            "piece_id",
        ) => Some(LoadTable::Pieces),
        (LoadTable::PieceParts, "parent_part_id") => Some(LoadTable::PieceParts),
        (LoadTable::PieceRelations, "from_piece_id" | "to_piece_id") => Some(LoadTable::Pieces),
        (LoadTable::Recordings, "artist_id") => Some(LoadTable::Artists),
        (LoadTable::RecordingTracks, "recording_id") => Some(LoadTable::Recordings),
        (LoadTable::PlatformLinks, "recording_id") => Some(LoadTable::Recordings),
        (LoadTable::PlatformLinks | LoadTable::TrackPieceLinks, "track_id") => {
            Some(LoadTable::RecordingTracks)
        }
        (LoadTable::TrackPieceLinks, "piece_part_id") => Some(LoadTable::PieceParts),
        (LoadTable::FieldProvenance | LoadTable::ReviewQueue, "seed_run_id") => {
            Some(LoadTable::SeedRuns)
        }
        _ => None,
    }
}

fn fingerprint(record: &CanonicalLoadRecord) -> Result<String, GlobalSeedLoadError> {
    let value = serde_json::json!({
        "db_contract_version": record.db_contract_version,
        "seed_run_id": record.seed_run_id,
        "table": record.table,
        "natural_key": record.natural_key,
        "values": record.values,
        "foreign_keys": record.foreign_keys,
        "origin": record.origin,
        "editor_locked": record.editor_locked,
        "write_policy": record.write_policy,
    });
    let bytes = serde_json::to_vec(&value).map_err(|error| {
        GlobalSeedLoadError::input(
            "FINGERPRINT_SERIALIZATION_ERROR",
            format!("record fingerprint를 만들 수 없음: {error}"),
            None,
        )
    })?;
    Ok(format!("{:x}", Sha256::digest(bytes)))
}

fn natural_key_sha256(value: &str) -> String {
    format!("{:x}", Sha256::digest(value.as_bytes()))
}

fn parse_bundle(options: &GlobalSeedLoadOptions) -> Result<Vec<BundleRecord>, GlobalSeedLoadError> {
    let file = File::open(&options.bundle_path)?;
    let reader = BufReader::new(file);
    let mut records = Vec::new();
    let mut identities = HashSet::new();
    let mut bundle_run_id = None;

    for (line_index, line_result) in reader.lines().enumerate() {
        let line_number = line_index + 1;
        let line = line_result?;
        if line.trim().is_empty() {
            return Err(GlobalSeedLoadError::input(
                "EMPTY_JSONL_LINE",
                "빈 JSONL 행은 허용되지 않음",
                Some(line_number),
            ));
        }
        let record: CanonicalLoadRecord = serde_json::from_str(&line).map_err(|error| {
            GlobalSeedLoadError::input(
                "INVALID_JSONL_RECORD",
                format!("strict global-seed-v1 record가 아님: {error}"),
                Some(line_number),
            )
        })?;
        validate_record(&record, line_number)?;
        let parsed_run_id = Uuid::parse_str(&record.seed_run_id).map_err(|error| {
            GlobalSeedLoadError::input(
                "INVALID_SEED_RUN_ID",
                format!("seed_run_id가 UUID가 아님: {error}"),
                Some(line_number),
            )
        })?;
        if let Some(expected) = options.run_id {
            if parsed_run_id != expected {
                return Err(GlobalSeedLoadError::input(
                    "RUN_ID_MISMATCH",
                    format!("--run-id {expected}와 record seed_run_id {parsed_run_id}가 다름"),
                    Some(line_number),
                ));
            }
        }
        if let Some(expected) = bundle_run_id {
            if parsed_run_id != expected {
                return Err(GlobalSeedLoadError::input(
                    "MIXED_SEED_RUN_IDS",
                    "한 bundle에 서로 다른 seed_run_id가 있음",
                    Some(line_number),
                ));
            }
        } else {
            bundle_run_id = Some(parsed_run_id);
        }
        let identity = (record.table, record.natural_key.clone());
        if !identities.insert(identity) {
            return Err(GlobalSeedLoadError::input(
                "DUPLICATE_NATURAL_KEY",
                format!(
                    "bundle에 중복 natural key가 있음: {}:{}",
                    record.table.as_str(),
                    record.natural_key
                ),
                Some(line_number),
            ));
        }
        let record_fingerprint = fingerprint(&record)?;
        records.push(BundleRecord {
            line: line_number,
            record,
            fingerprint: record_fingerprint,
        });
        if let Some(limit) = options.limit {
            if records.len() > limit {
                return Err(GlobalSeedLoadError::input(
                    "BUNDLE_LIMIT_EXCEEDED",
                    format!("bundle record 수가 --limit {limit}을 초과함"),
                    Some(line_number),
                ));
            }
        }
    }

    if records.is_empty() {
        return Err(GlobalSeedLoadError::input(
            "EMPTY_BUNDLE",
            "bundle에 record가 없음",
            None,
        ));
    }
    let run_id = bundle_run_id.expect("빈 bundle은 앞에서 거절됨");
    let seed_run_key = (LoadTable::SeedRuns, run_id.to_string());
    if !identities.contains(&seed_run_key) {
        return Err(GlobalSeedLoadError::input(
            "SEED_RUN_RECORD_MISSING",
            format!("seed_runs:{run_id} record가 bundle에 없음"),
            None,
        ));
    }

    topological_order(records)
}

fn validate_record(record: &CanonicalLoadRecord, line: usize) -> Result<(), GlobalSeedLoadError> {
    if record.db_contract_version != CONTRACT_VERSION {
        return Err(GlobalSeedLoadError::input(
            "UNSUPPORTED_CONTRACT_VERSION",
            format!(
                "db_contract_version은 {CONTRACT_VERSION}이어야 함: {}",
                record.db_contract_version
            ),
            Some(line),
        ));
    }
    if record.write_policy != WRITE_POLICY {
        return Err(GlobalSeedLoadError::input(
            "UNSUPPORTED_WRITE_POLICY",
            format!("write_policy는 {WRITE_POLICY}이어야 함"),
            Some(line),
        ));
    }
    if record.origin != "seed" || record.editor_locked {
        return Err(GlobalSeedLoadError::input(
            "INVALID_SEED_OWNERSHIP",
            "canonical loader 입력은 origin=seed, editor_locked=false여야 함",
            Some(line),
        ));
    }
    if record.natural_key.is_empty() || record.natural_key.len() > 1000 {
        return Err(GlobalSeedLoadError::input(
            "INVALID_NATURAL_KEY",
            "natural_key는 1~1000 byte 문자열이어야 함",
            Some(line),
        ));
    }
    let spec = table_spec(record.table);
    for column in record.values.keys() {
        if column_spec(record.table, column).is_none() {
            return Err(GlobalSeedLoadError::input(
                "UNKNOWN_TABLE_COLUMN",
                format!(
                    "{}에서 지원하지 않는 values column임: {column}",
                    record.table.as_str()
                ),
                Some(line),
            ));
        }
    }
    let mut fk_columns = HashSet::new();
    for foreign_key in &record.foreign_keys {
        if !fk_columns.insert(foreign_key.column.as_str()) {
            return Err(GlobalSeedLoadError::input(
                "DUPLICATE_FOREIGN_KEY_COLUMN",
                format!("중복 foreign key column임: {}", foreign_key.column),
                Some(line),
            ));
        }
        let expected_target =
            expected_fk_target(record.table, &foreign_key.column).ok_or_else(|| {
                GlobalSeedLoadError::input(
                    "UNSUPPORTED_FOREIGN_KEY",
                    format!(
                        "{}에서 지원하지 않는 foreign key column임: {}",
                        record.table.as_str(),
                        foreign_key.column
                    ),
                    Some(line),
                )
            })?;
        if expected_target != foreign_key.target_table {
            return Err(GlobalSeedLoadError::input(
                "FOREIGN_KEY_TARGET_MISMATCH",
                format!(
                    "{}.{}의 target은 {}이어야 함",
                    record.table.as_str(),
                    foreign_key.column,
                    expected_target.as_str()
                ),
                Some(line),
            ));
        }
        if foreign_key.target_natural_key.is_empty() {
            return Err(GlobalSeedLoadError::input(
                "EMPTY_FOREIGN_KEY_NATURAL_KEY",
                "foreign key target_natural_key가 비어 있음",
                Some(line),
            ));
        }
    }
    for column in spec.columns.iter().filter(|column| column.required) {
        if !record.values.contains_key(column.name) && !fk_columns.contains(column.name) {
            return Err(GlobalSeedLoadError::input(
                "REQUIRED_COLUMN_MISSING",
                format!("{}.{} 필수 값이 없음", record.table.as_str(), column.name),
                Some(line),
            ));
        }
    }
    if spec.id_kind == IdKind::Auto && record.values.contains_key("id") {
        return Err(GlobalSeedLoadError::input(
            "AUTO_ID_NOT_ALLOWED",
            format!("{}는 id를 직접 받을 수 없음", record.table.as_str()),
            Some(line),
        ));
    }
    for (column_name, value) in &record.values {
        validate_value(
            column_spec(record.table, column_name).expect("column은 위에서 확인됨"),
            value,
            record.table,
            line,
        )?;
    }
    if record.table == LoadTable::SeedRuns {
        let id = record.values.get("id").and_then(Value::as_str);
        if id != Some(record.seed_run_id.as_str()) || record.natural_key != record.seed_run_id {
            return Err(GlobalSeedLoadError::input(
                "SEED_RUN_IDENTITY_MISMATCH",
                "seed_runs id, natural_key, seed_run_id가 모두 같아야 함",
                Some(line),
            ));
        }
    }
    if matches!(record.values.get("origin"), Some(Value::String(value)) if value != "seed")
        || matches!(record.values.get("editor_locked"), Some(Value::Bool(true)))
    {
        return Err(GlobalSeedLoadError::input(
            "INVALID_ROW_OWNERSHIP",
            "values의 origin/editor_locked가 seed 보호 계약과 다름",
            Some(line),
        ));
    }
    Ok(())
}

fn validate_value(
    column: ColumnSpec,
    value: &Value,
    table: LoadTable,
    line: usize,
) -> Result<(), GlobalSeedLoadError> {
    if value.is_null() {
        if column.required {
            return Err(GlobalSeedLoadError::input(
                "NULL_REQUIRED_COLUMN",
                format!("{}.{}는 null일 수 없음", table.as_str(), column.name),
                Some(line),
            ));
        }
        return Ok(());
    }
    let valid = match column.kind {
        ColumnKind::String | ColumnKind::Timestamp | ColumnKind::Date => value.is_string(),
        ColumnKind::Signed | ColumnKind::Unsigned => {
            value.as_i64().is_some() || value.as_u64().is_some()
        }
        ColumnKind::Decimal => value.is_number() || value.is_string(),
        ColumnKind::Boolean => value.is_boolean(),
        ColumnKind::Json => true,
    };
    if !valid {
        return Err(GlobalSeedLoadError::input(
            "INVALID_COLUMN_TYPE",
            format!("{}.{} 값 타입이 계약과 다름", table.as_str(), column.name),
            Some(line),
        ));
    }
    if column.kind == ColumnKind::Unsigned && value.as_i64().is_some_and(|number| number < 0) {
        return Err(GlobalSeedLoadError::input(
            "NEGATIVE_UNSIGNED_VALUE",
            format!("{}.{}는 음수일 수 없음", table.as_str(), column.name),
            Some(line),
        ));
    }
    Ok(())
}

fn topological_order(records: Vec<BundleRecord>) -> Result<Vec<BundleRecord>, GlobalSeedLoadError> {
    let positions = records
        .iter()
        .enumerate()
        .map(|(index, item)| ((item.record.table, item.record.natural_key.clone()), index))
        .collect::<HashMap<_, _>>();
    let mut dependencies = vec![Vec::new(); records.len()];
    for (index, item) in records.iter().enumerate() {
        for foreign_key in &item.record.foreign_keys {
            let target = (
                foreign_key.target_table,
                foreign_key.target_natural_key.clone(),
            );
            if let Some(target_index) = positions.get(&target) {
                dependencies[index].push(*target_index);
            } else if foreign_key.resolution == ForeignKeyResolution::Bundle {
                return Err(GlobalSeedLoadError::input(
                    "BUNDLE_FOREIGN_KEY_MISSING",
                    format!(
                        "{}.{}가 bundle target {}:{}를 찾지 못함",
                        item.record.table.as_str(),
                        foreign_key.column,
                        foreign_key.target_table.as_str(),
                        foreign_key.target_natural_key
                    ),
                    Some(item.line),
                ));
            }
        }
    }
    let mut state = vec![0_u8; records.len()];
    let mut ordered = Vec::with_capacity(records.len());
    fn visit(
        index: usize,
        records: &[BundleRecord],
        dependencies: &[Vec<usize>],
        state: &mut [u8],
        ordered: &mut Vec<usize>,
    ) -> Result<(), GlobalSeedLoadError> {
        if state[index] == 2 {
            return Ok(());
        }
        if state[index] == 1 {
            return Err(GlobalSeedLoadError::input(
                "FOREIGN_KEY_CYCLE",
                format!(
                    "bundle foreign key cycle이 있음: {}:{}",
                    records[index].record.table.as_str(),
                    records[index].record.natural_key
                ),
                Some(records[index].line),
            ));
        }
        state[index] = 1;
        for dependency in &dependencies[index] {
            visit(*dependency, records, dependencies, state, ordered)?;
        }
        state[index] = 2;
        ordered.push(index);
        Ok(())
    }
    for index in 0..records.len() {
        visit(index, &records, &dependencies, &mut state, &mut ordered)?;
    }
    Ok(ordered
        .into_iter()
        .map(|index| records[index].clone())
        .collect())
}

#[derive(Debug, Clone)]
struct RegistryState {
    natural_key: String,
    target_id: String,
    record_fingerprint: String,
    first_seed_run_id: String,
    last_seed_run_id: String,
}

#[derive(Debug, Clone)]
struct TargetState {
    origin: Option<String>,
    editor_locked: bool,
    values: Value,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum PlannedAction {
    Insert,
    Update,
    Reuse,
    ProtectedReuse,
}

#[derive(Debug, Clone)]
struct MutationEvent {
    target_table: String,
    target_id: String,
    operation: &'static str,
    before: Option<Value>,
    after: Option<Value>,
}

pub struct GlobalSeedLoader;

impl GlobalSeedLoader {
    pub async fn load(
        pool: &DbPool,
        options: &GlobalSeedLoadOptions,
    ) -> Result<GlobalSeedLoadReport, GlobalSeedLoadError> {
        let records = parse_bundle(options)?;
        let seed_run_id = records[0].record.seed_run_id.clone();
        let mut transaction = pool.begin().await?;
        preflight_existing_foreign_keys(&mut transaction, &records).await?;
        let mut natural_targets: HashMap<(LoadTable, String), String> = HashMap::new();
        let mut planned = GlobalSeedMutationCounts::default();
        let mut table_mutations = BTreeMap::new();
        let mut events = Vec::new();
        let mut planned_rollbacks = Vec::new();

        for item in &records {
            let resolved_values = resolve_values(&mut transaction, item, &natural_targets).await?;
            let registry = fetch_registry(&mut transaction, item).await?;
            let existing_id = if let Some(registry) = &registry {
                Some(registry.target_id.clone())
            } else {
                find_existing_target_id(&mut transaction, item, &resolved_values).await?
            };
            if item.record.table == LoadTable::SeedRuns && existing_id.is_some() && !options.resume
            {
                return Err(GlobalSeedLoadError::input(
                    "SEED_RUN_ALREADY_EXISTS",
                    format!(
                        "seed_runs {}가 이미 존재함. --resume 또는 기본 resume 모드를 사용해야 함",
                        item.record.seed_run_id
                    ),
                    Some(item.line),
                ));
            }
            let (action, target_id, before) = if let Some(target_id) = existing_id {
                let state = fetch_target_state(&mut transaction, item.record.table, &target_id)
                    .await?
                    .ok_or_else(|| {
                        GlobalSeedLoadError::input(
                            "STALE_NATURAL_KEY_MAPPING",
                            format!(
                                "{}:{}가 존재하지 않는 target id {}를 가리킴",
                                item.record.table.as_str(),
                                item.record.natural_key,
                                target_id
                            ),
                            Some(item.line),
                        )
                    })?;
                let exact =
                    managed_values_equal(item.record.table, &resolved_values, &state.values)?;
                let fingerprint_exact = registry
                    .as_ref()
                    .is_some_and(|value| value.record_fingerprint == item.fingerprint);
                if item.record.table == LoadTable::SeedRuns {
                    (PlannedAction::Reuse, target_id, Some(state.values))
                } else if state.origin.as_deref() == Some("manual") || state.editor_locked {
                    if !exact {
                        return Err(GlobalSeedLoadError::input(
                            "MANUAL_ROW_CONFLICT",
                            format!(
                                "{}:{}가 manual/editor_locked 기존 행 {}와 충돌함",
                                item.record.table.as_str(),
                                item.record.natural_key,
                                target_id
                            ),
                            Some(item.line),
                        ));
                    }
                    (PlannedAction::ProtectedReuse, target_id, Some(state.values))
                } else if exact && fingerprint_exact {
                    (PlannedAction::Reuse, target_id, Some(state.values))
                } else if exact {
                    (PlannedAction::Reuse, target_id, Some(state.values))
                } else if table_spec(item.record.table).immutable {
                    return Err(GlobalSeedLoadError::input(
                        "IMMUTABLE_SOURCE_CONFLICT",
                        format!(
                            "immutable {}:{}의 기존 payload가 다름",
                            item.record.table.as_str(),
                            item.record.natural_key
                        ),
                        Some(item.line),
                    ));
                } else if registry.is_none() {
                    return Err(GlobalSeedLoadError::input(
                        "UNOWNED_EXISTING_ROW_CONFLICT",
                        format!(
                            "registry가 없는 {}:{} 기존 행은 자동 update할 수 없음",
                            item.record.table.as_str(),
                            item.record.natural_key
                        ),
                        Some(item.line),
                    ));
                } else {
                    (PlannedAction::Update, target_id, Some(state.values))
                }
            } else {
                (PlannedAction::Insert, planned_target_id(item), None)
            };

            match action {
                PlannedAction::Insert => planned.inserted += 1,
                PlannedAction::Update => planned.updated += 1,
                PlannedAction::Reuse => planned.reused += 1,
                PlannedAction::ProtectedReuse => planned.protected_reused += 1,
            }
            let registry_needs_mutation = registry.as_ref().is_none_or(|state| {
                state.target_id != target_id
                    || state.record_fingerprint != item.fingerprint
                    || state.last_seed_run_id != seed_run_id
            });
            if registry_needs_mutation {
                planned.registry_mappings += 1;
            }
            if matches!(action, PlannedAction::Insert | PlannedAction::Update) {
                *table_mutations
                    .entry(item.record.table.as_str().to_string())
                    .or_insert(0) += 1;
                planned_rollbacks.push(RollbackEntry {
                    sequence: planned_rollbacks.len() + 1,
                    target_table: item.record.table.as_str().to_string(),
                    target_id: target_id.clone(),
                    reverse_operation: if action == PlannedAction::Insert {
                        "DELETE".to_string()
                    } else {
                        "RESTORE".to_string()
                    },
                    restore_json: before.clone(),
                });
            }
            if registry_needs_mutation {
                *table_mutations
                    .entry("seed_natural_keys".to_string())
                    .or_insert(0) += 1;
                planned_rollbacks.push(RollbackEntry {
                    sequence: planned_rollbacks.len() + 1,
                    target_table: "seed_natural_keys".to_string(),
                    target_id: natural_key_sha256(&item.record.natural_key),
                    reverse_operation: if registry.is_none() {
                        "DELETE".to_string()
                    } else {
                        "RESTORE".to_string()
                    },
                    restore_json: registry.as_ref().map(registry_json),
                });
            }

            let actual_target_id = if options.dry_run {
                target_id
            } else {
                let actual_target_id = match action {
                    PlannedAction::Insert => {
                        insert_record(&mut transaction, item, &resolved_values).await?
                    }
                    PlannedAction::Update => {
                        update_record(&mut transaction, item, &target_id, &resolved_values).await?;
                        target_id
                    }
                    PlannedAction::Reuse | PlannedAction::ProtectedReuse => target_id,
                };
                upsert_registry(&mut transaction, item, &actual_target_id, &seed_run_id).await?;
                if matches!(action, PlannedAction::Insert | PlannedAction::Update) {
                    let after =
                        fetch_target_state(&mut transaction, item.record.table, &actual_target_id)
                            .await?
                            .ok_or_else(|| {
                                GlobalSeedLoadError::input(
                                    "MUTATED_ROW_MISSING",
                                    "mutation 직후 target row를 찾지 못함",
                                    Some(item.line),
                                )
                            })?
                            .values;
                    if before.as_ref() != Some(&after) {
                        events.push(MutationEvent {
                            target_table: item.record.table.as_str().to_string(),
                            target_id: actual_target_id.clone(),
                            operation: if action == PlannedAction::Insert {
                                "INSERT"
                            } else {
                                "UPDATE"
                            },
                            before,
                            after: Some(after),
                        });
                    }
                }
                if registry_needs_mutation {
                    let after_registry = RegistryState {
                        natural_key: item.record.natural_key.clone(),
                        target_id: actual_target_id.clone(),
                        record_fingerprint: item.fingerprint.clone(),
                        first_seed_run_id: registry.as_ref().map_or_else(
                            || seed_run_id.clone(),
                            |state| state.first_seed_run_id.clone(),
                        ),
                        last_seed_run_id: seed_run_id.clone(),
                    };
                    events.push(MutationEvent {
                        target_table: "seed_natural_keys".to_string(),
                        target_id: natural_key_sha256(&item.record.natural_key),
                        operation: if registry.is_none() {
                            "INSERT"
                        } else {
                            "UPDATE"
                        },
                        before: registry.as_ref().map(registry_json),
                        after: Some(registry_json(&after_registry)),
                    });
                }
                actual_target_id
            };
            natural_targets.insert(
                (item.record.table, item.record.natural_key.clone()),
                actual_target_id,
            );
        }

        planned.total = planned.inserted + planned.updated + planned.registry_mappings;
        let rollback_manifest =
            rollback_manifest(&seed_run_id, options.dry_run, &events, &planned_rollbacks);
        let mutations = if options.dry_run {
            transaction.rollback().await?;
            GlobalSeedMutationCounts::default()
        } else {
            let mut actual = planned.clone();
            actual.inserted = events
                .iter()
                .filter(|event| {
                    event.operation == "INSERT" && event.target_table != "seed_natural_keys"
                })
                .count() as u64;
            actual.updated = events
                .iter()
                .filter(|event| {
                    event.operation == "UPDATE" && event.target_table != "seed_natural_keys"
                })
                .count() as u64;
            actual.registry_mappings = events
                .iter()
                .filter(|event| event.target_table == "seed_natural_keys")
                .count() as u64;
            actual.total = actual.inserted + actual.updated + actual.registry_mappings;
            finish_seed_run(&mut transaction, &seed_run_id, records.len(), &actual).await?;
            for event in &mut events {
                if event.target_table == LoadTable::SeedRuns.as_str() {
                    event.after =
                        fetch_target_state(&mut transaction, LoadTable::SeedRuns, &event.target_id)
                            .await?
                            .map(|state| state.values);
                }
                insert_mutation(&mut transaction, &seed_run_id, event).await?;
            }
            transaction.commit().await?;
            actual
        };

        Ok(GlobalSeedLoadReport {
            status: "succeeded",
            contract_version: CONTRACT_VERSION,
            bundle_path: options.bundle_path.display().to_string(),
            seed_run_id,
            row_count: records.len(),
            dry_run: options.dry_run,
            mutations,
            planned_mutations: planned,
            table_mutations,
            rollback_manifest,
        })
    }
}

async fn preflight_existing_foreign_keys(
    transaction: &mut Transaction<'_, MySql>,
    records: &[BundleRecord],
) -> Result<(), GlobalSeedLoadError> {
    let bundle_targets = records
        .iter()
        .map(|item| (item.record.table, item.record.natural_key.as_str()))
        .collect::<HashSet<_>>();
    let mut checked = HashSet::new();
    for item in records {
        for foreign_key in &item.record.foreign_keys {
            if foreign_key.resolution != ForeignKeyResolution::BundleOrExisting
                || bundle_targets.contains(&(
                    foreign_key.target_table,
                    foreign_key.target_natural_key.as_str(),
                ))
                || !checked.insert((
                    foreign_key.target_table,
                    foreign_key.target_natural_key.as_str(),
                ))
            {
                continue;
            }
            if resolve_existing_natural_target(
                transaction,
                foreign_key.target_table,
                &foreign_key.target_natural_key,
            )
            .await?
            .is_none()
            {
                return Err(GlobalSeedLoadError::input(
                    "EXISTING_FOREIGN_KEY_MISSING",
                    format!(
                        "bundle_or_existing target이 없음: {}:{}",
                        foreign_key.target_table.as_str(),
                        foreign_key.target_natural_key
                    ),
                    Some(item.line),
                ));
            }
        }
    }
    Ok(())
}

fn planned_target_id(item: &BundleRecord) -> String {
    if table_spec(item.record.table).id_kind == IdKind::Supplied {
        item.record
            .values
            .get("id")
            .and_then(Value::as_str)
            .expect("supplied id는 validation에서 확인됨")
            .to_string()
    } else {
        let hash = natural_key_sha256(&item.record.natural_key);
        let suffix = u64::from_str_radix(&hash[..8], 16).expect("SHA-256 hex") % 100_000_000;
        (1_500_000_000_u64 + suffix).to_string()
    }
}

async fn resolve_values(
    transaction: &mut Transaction<'_, MySql>,
    item: &BundleRecord,
    natural_targets: &HashMap<(LoadTable, String), String>,
) -> Result<Map<String, Value>, GlobalSeedLoadError> {
    let mut values = item.record.values.clone();
    for foreign_key in &item.record.foreign_keys {
        let key = (
            foreign_key.target_table,
            foreign_key.target_natural_key.clone(),
        );
        let target_id = if let Some(target_id) = natural_targets.get(&key) {
            target_id.clone()
        } else if foreign_key.resolution == ForeignKeyResolution::Bundle {
            return Err(GlobalSeedLoadError::input(
                "UNRESOLVED_BUNDLE_FOREIGN_KEY",
                format!(
                    "topological load 중 bundle FK를 resolve하지 못함: {}:{}",
                    foreign_key.target_table.as_str(),
                    foreign_key.target_natural_key
                ),
                Some(item.line),
            ));
        } else {
            resolve_existing_natural_target(
                transaction,
                foreign_key.target_table,
                &foreign_key.target_natural_key,
            )
            .await?
            .ok_or_else(|| {
                GlobalSeedLoadError::input(
                    "EXISTING_FOREIGN_KEY_MISSING",
                    format!(
                        "bundle_or_existing target이 없음: {}:{}",
                        foreign_key.target_table.as_str(),
                        foreign_key.target_natural_key
                    ),
                    Some(item.line),
                )
            })?
        };
        let column = column_spec(item.record.table, &foreign_key.column)
            .expect("foreign key column은 validation에서 확인됨");
        let resolved_value = target_id_value(column, &target_id, item.line)?;
        if let Some(original) = values.get(&foreign_key.column) {
            if !foreign_key_values_equal(original, &resolved_value) {
                return Err(GlobalSeedLoadError::input(
                    "FOREIGN_KEY_VALUE_MISMATCH",
                    format!(
                        "{}.{} values와 resolved FK가 다름",
                        item.record.table.as_str(),
                        foreign_key.column
                    ),
                    Some(item.line),
                ));
            }
        }
        values.insert(foreign_key.column.clone(), resolved_value);
    }
    Ok(values)
}

fn target_id_value(
    column: ColumnSpec,
    target_id: &str,
    line: usize,
) -> Result<Value, GlobalSeedLoadError> {
    match column.kind {
        ColumnKind::Signed => target_id.parse::<i64>().map(Value::from).map_err(|_| {
            GlobalSeedLoadError::input(
                "INVALID_RESOLVED_SIGNED_ID",
                format!(
                    "{} FK target id가 signed integer가 아님: {target_id}",
                    column.name
                ),
                Some(line),
            )
        }),
        ColumnKind::Unsigned => target_id.parse::<u64>().map(Value::from).map_err(|_| {
            GlobalSeedLoadError::input(
                "INVALID_RESOLVED_UNSIGNED_ID",
                format!(
                    "{} FK target id가 unsigned integer가 아님: {target_id}",
                    column.name
                ),
                Some(line),
            )
        }),
        _ => Ok(Value::String(target_id.to_string())),
    }
}

fn foreign_key_values_equal(left: &Value, right: &Value) -> bool {
    left == right
        || left
            .as_str()
            .is_some_and(|value| value == right.to_string().trim_matches('"'))
        || right
            .as_str()
            .is_some_and(|value| value == left.to_string().trim_matches('"'))
}

async fn fetch_registry(
    transaction: &mut Transaction<'_, MySql>,
    item: &BundleRecord,
) -> Result<Option<RegistryState>, GlobalSeedLoadError> {
    let row = sqlx::query(
        "SELECT CAST(natural_key AS CHAR CHARACTER SET utf8mb4) AS natural_key,
                CAST(target_id AS CHAR CHARACTER SET utf8mb4) AS target_id,
                CAST(record_fingerprint AS CHAR CHARACTER SET utf8mb4) AS record_fingerprint,
                CAST(first_seed_run_id AS CHAR CHARACTER SET utf8mb4) AS first_seed_run_id,
                CAST(last_seed_run_id AS CHAR CHARACTER SET utf8mb4) AS last_seed_run_id
         FROM seed_natural_keys
         WHERE target_table = ? AND natural_key_sha256 = ?
         FOR UPDATE",
    )
    .bind(item.record.table.as_str())
    .bind(natural_key_sha256(&item.record.natural_key))
    .fetch_optional(&mut **transaction)
    .await?;
    let Some(row) = row else {
        return Ok(None);
    };
    let stored_key: String = row.try_get("natural_key")?;
    if stored_key != item.record.natural_key {
        return Err(GlobalSeedLoadError::input(
            "NATURAL_KEY_HASH_COLLISION",
            format!(
                "{} natural key SHA-256 collision이 감지됨",
                item.record.table.as_str()
            ),
            Some(item.line),
        ));
    }
    Ok(Some(RegistryState {
        natural_key: stored_key,
        target_id: row.try_get("target_id")?,
        record_fingerprint: row.try_get("record_fingerprint")?,
        first_seed_run_id: row.try_get("first_seed_run_id")?,
        last_seed_run_id: row.try_get("last_seed_run_id")?,
    }))
}

fn registry_json(state: &RegistryState) -> Value {
    serde_json::json!({
        "natural_key": state.natural_key,
        "target_id": state.target_id,
        "record_fingerprint": state.record_fingerprint,
        "first_seed_run_id": state.first_seed_run_id,
        "last_seed_run_id": state.last_seed_run_id,
    })
}

async fn resolve_existing_natural_target(
    transaction: &mut Transaction<'_, MySql>,
    table: LoadTable,
    natural_key: &str,
) -> Result<Option<String>, GlobalSeedLoadError> {
    let hash = natural_key_sha256(natural_key);
    let row = sqlx::query(
        "SELECT CAST(natural_key AS CHAR CHARACTER SET utf8mb4) AS natural_key,
                CAST(target_id AS CHAR CHARACTER SET utf8mb4) AS target_id
         FROM seed_natural_keys
         WHERE target_table = ? AND natural_key_sha256 = ?
         FOR UPDATE",
    )
    .bind(table.as_str())
    .bind(hash)
    .fetch_optional(&mut **transaction)
    .await?;
    if let Some(row) = row {
        let stored_key: String = row.try_get("natural_key")?;
        if stored_key != natural_key {
            return Err(GlobalSeedLoadError::input(
                "NATURAL_KEY_HASH_COLLISION",
                format!("{} natural key SHA-256 collision이 감지됨", table.as_str()),
                None,
            ));
        }
        return Ok(Some(row.try_get("target_id")?));
    }

    if let Some(mbid) = natural_key.strip_prefix("musicbrainz_artist:") {
        let table_name = match table {
            LoadTable::Composers => "composers",
            LoadTable::Artists => "artists",
            _ => "",
        };
        if !table_name.is_empty() {
            let query = format!(
                "SELECT CAST(projection.id AS CHAR) AS target_id
                 FROM {table_name} projection
                 JOIN external_identifiers identifier
                   ON identifier.authority_entity_id = projection.authority_entity_id
                 WHERE identifier.namespace = 'musicbrainz_artist'
                   AND identifier.external_id = ?
                 LIMIT 2
                 FOR UPDATE"
            );
            return fetch_unique_target_id(transaction, &query, mbid).await;
        }
    }
    if table == LoadTable::Pieces {
        if let Some(mbid) = natural_key.strip_prefix("musicbrainz_work:") {
            return fetch_unique_target_id(
                transaction,
                "SELECT CAST(piece_id AS CHAR) AS target_id
                 FROM piece_identifiers
                 WHERE namespace = 'musicbrainz_work' AND external_id = ?
                 LIMIT 2
                 FOR UPDATE",
                mbid,
            )
            .await;
        }
    }
    if table == LoadTable::SeedRuns && Uuid::parse_str(natural_key).is_ok() {
        return fetch_unique_target_id(
            transaction,
            "SELECT CAST(id AS CHAR) AS target_id FROM seed_runs WHERE id = ? LIMIT 2 FOR UPDATE",
            natural_key,
        )
        .await;
    }
    Ok(None)
}

async fn fetch_unique_target_id(
    transaction: &mut Transaction<'_, MySql>,
    query: &str,
    value: &str,
) -> Result<Option<String>, GlobalSeedLoadError> {
    let rows = sqlx::query(query)
        .bind(value)
        .fetch_all(&mut **transaction)
        .await?;
    if rows.len() > 1 {
        return Err(GlobalSeedLoadError::input(
            "AMBIGUOUS_STABLE_IDENTIFIER",
            "stable external identifier가 둘 이상의 target을 가리킴",
            None,
        ));
    }
    rows.first()
        .map(|row| row.try_get("target_id"))
        .transpose()
        .map_err(GlobalSeedLoadError::from)
}

async fn fetch_target_state(
    transaction: &mut Transaction<'_, MySql>,
    table: LoadTable,
    target_id: &str,
) -> Result<Option<TargetState>, GlobalSeedLoadError> {
    let spec = table_spec(table);
    let mut state_expression = String::from("JSON_OBJECT('id', id");
    for column in spec.columns {
        if column.name != "id" {
            state_expression.push_str(&format!(", '{}', {}", column.name, column.name));
        }
    }
    state_expression.push(')');
    let guard_columns = if spec.guarded {
        "CAST(origin AS CHAR CHARACTER SET utf8mb4) AS origin, editor_locked"
    } else {
        "NULL AS origin, FALSE AS editor_locked"
    };
    let query = format!(
        "SELECT {guard_columns}, {state_expression} AS state_json
         FROM {} WHERE CAST(id AS CHAR) = ? FOR UPDATE",
        table.as_str()
    );
    let row = sqlx::query(&query)
        .bind(target_id)
        .fetch_optional(&mut **transaction)
        .await?;
    row.map(|row| {
        let state: sqlx::types::Json<Value> = row.try_get("state_json")?;
        let origin: Option<String> = row.try_get("origin")?;
        let editor_locked: bool = row.try_get("editor_locked")?;
        Ok::<TargetState, sqlx::Error>(TargetState {
            origin,
            editor_locked,
            values: state.0,
        })
    })
    .transpose()
    .map_err(GlobalSeedLoadError::from)
}

fn managed_values_equal(
    table: LoadTable,
    desired: &Map<String, Value>,
    current: &Value,
) -> Result<bool, GlobalSeedLoadError> {
    let current = current.as_object().ok_or_else(|| {
        GlobalSeedLoadError::input(
            "INVALID_DATABASE_STATE_JSON",
            format!("{} state JSON이 object가 아님", table.as_str()),
            None,
        )
    })?;
    for (column_name, desired_value) in desired {
        if table == LoadTable::SeedRuns
            && matches!(
                column_name.as_str(),
                "status" | "summary" | "finished_at" | "dry_run"
            )
        {
            continue;
        }
        let column = column_spec(table, column_name).expect("desired column은 검증됨");
        let Some(current_value) = current.get(column_name) else {
            return Ok(false);
        };
        if !database_values_equal(column, desired_value, current_value)? {
            return Ok(false);
        }
    }
    Ok(true)
}

fn database_values_equal(
    column: ColumnSpec,
    desired: &Value,
    current: &Value,
) -> Result<bool, GlobalSeedLoadError> {
    if desired.is_null() || current.is_null() {
        return Ok(desired.is_null() && current.is_null());
    }
    match column.kind {
        ColumnKind::Boolean => {
            let current_bool = current
                .as_bool()
                .or_else(|| current.as_i64().map(|value| value != 0))
                .or_else(|| current.as_u64().map(|value| value != 0));
            Ok(desired.as_bool() == current_bool)
        }
        ColumnKind::Signed => Ok(desired.as_i64() == current.as_i64()),
        ColumnKind::Unsigned => Ok(desired
            .as_u64()
            .or_else(|| desired.as_i64().and_then(|value| u64::try_from(value).ok()))
            == current
                .as_u64()
                .or_else(|| current.as_i64().and_then(|value| u64::try_from(value).ok()))),
        ColumnKind::Decimal => Ok(decimal_string(desired) == decimal_string(current)),
        ColumnKind::Timestamp => {
            let desired = desired.as_str().and_then(parse_timestamp).ok_or_else(|| {
                GlobalSeedLoadError::input(
                    "INVALID_TIMESTAMP",
                    format!("{} timestamp 형식이 잘못됨", column.name),
                    None,
                )
            })?;
            let current = current.as_str().and_then(parse_timestamp).ok_or_else(|| {
                GlobalSeedLoadError::input(
                    "INVALID_DATABASE_TIMESTAMP",
                    format!("DB {} timestamp 형식이 잘못됨", column.name),
                    None,
                )
            })?;
            Ok(desired == current)
        }
        ColumnKind::Date => {
            let desired = desired
                .as_str()
                .and_then(|value| NaiveDate::parse_from_str(value, "%Y-%m-%d").ok());
            let current = current
                .as_str()
                .and_then(|value| NaiveDate::parse_from_str(value, "%Y-%m-%d").ok());
            Ok(desired == current)
        }
        ColumnKind::String | ColumnKind::Json => Ok(desired == current),
    }
}

fn decimal_string(value: &Value) -> Option<String> {
    value
        .as_str()
        .map(ToOwned::to_owned)
        .or_else(|| value.as_f64().map(|number| number.to_string()))
}

fn parse_timestamp(value: &str) -> Option<NaiveDateTime> {
    DateTime::parse_from_rfc3339(value)
        .map(|value| value.naive_utc())
        .ok()
        .or_else(|| NaiveDateTime::parse_from_str(value, "%Y-%m-%d %H:%M:%S%.f").ok())
}

async fn find_existing_target_id(
    transaction: &mut Transaction<'_, MySql>,
    item: &BundleRecord,
    values: &Map<String, Value>,
) -> Result<Option<String>, GlobalSeedLoadError> {
    if let Some(target_id) =
        resolve_existing_natural_target(transaction, item.record.table, &item.record.natural_key)
            .await?
    {
        return Ok(Some(target_id));
    }
    let predicates = match item.record.table {
        LoadTable::SeedRuns | LoadTable::AuthorityEntities => predicates(values, &["id"], item)?,
        LoadTable::SourceSnapshots => predicates(values, &["source", "sha256"], item)?,
        LoadTable::SourceRecords => predicates(values, &["snapshot_id", "source_record_id"], item)?,
        LoadTable::EntityNames => predicates(
            values,
            &[
                "authority_entity_id",
                "locale",
                "name_kind",
                "normalized_value",
            ],
            item,
        )?,
        LoadTable::EntityRoles => predicates(values, &["authority_entity_id", "role_code"], item)?,
        LoadTable::EntityInstruments => {
            predicates(values, &["authority_entity_id", "instrument_code"], item)?
        }
        LoadTable::EntityCountries => predicates_with_defaults(
            values,
            &[
                ("authority_entity_id", None),
                ("country_code", None),
                (
                    "relation_type",
                    Some(Value::String("nationality".to_string())),
                ),
            ],
            item,
        )?,
        LoadTable::EntityImages => predicates(values, &["authority_entity_id", "file_url"], item)?,
        LoadTable::ExternalIdentifiers => predicates(values, &["namespace", "external_id"], item)?,
        LoadTable::Composers | LoadTable::Artists => {
            if values.get("authority_entity_id").is_none_or(Value::is_null) {
                Vec::new()
            } else {
                predicates(values, &["authority_entity_id"], item)?
            }
        }
        LoadTable::Pieces => Vec::new(),
        LoadTable::PieceAliases => predicates_with_defaults(
            values,
            &[
                ("piece_id", None),
                ("locale", None),
                ("alias_kind", Some(Value::String("alias".to_string()))),
                ("normalized_value", None),
            ],
            item,
        )?,
        LoadTable::PieceIdentifiers => predicates(values, &["namespace", "external_id"], item)?,
        LoadTable::PieceParts => predicates(values, &["piece_id", "part_key"], item)?,
        LoadTable::PieceRelations => predicates(
            values,
            &["from_piece_id", "to_piece_id", "relation_type"],
            item,
        )?,
        LoadTable::PieceInstrumentation => predicates_with_defaults(
            values,
            &[
                ("piece_id", None),
                ("instrument_code", None),
                (
                    "instrumentation_role",
                    Some(Value::String("instrument".to_string())),
                ),
            ],
            item,
        )?,
        LoadTable::Recordings => {
            if values
                .get("apple_music_id")
                .is_some_and(|value| !value.is_null())
            {
                predicates(values, &["apple_music_id"], item)?
            } else if values.get("upc").is_some_and(|value| !value.is_null()) {
                predicates(values, &["upc"], item)?
            } else {
                Vec::new()
            }
        }
        LoadTable::RecordingTracks => predicates(values, &["recording_id", "track_key"], item)?,
        LoadTable::TrackPieceLinks => predicates_with_defaults(
            values,
            &[
                ("track_id", None),
                ("piece_id", None),
                ("piece_part_id", Some(Value::Null)),
                (
                    "relation_type",
                    Some(Value::String("performance_of".to_string())),
                ),
            ],
            item,
        )?,
        LoadTable::PlatformLinks => predicates_with_defaults(
            values,
            &[
                ("platform", None),
                ("storefront", Some(Value::String(String::new()))),
                ("platform_id", None),
            ],
            item,
        )?,
        LoadTable::FieldProvenance => predicates(
            values,
            &[
                "target_table",
                "target_id",
                "field_name",
                "source_record_id",
            ],
            item,
        )?,
        LoadTable::ReviewQueue => Vec::new(),
    };
    if predicates.is_empty() {
        return Ok(None);
    }
    lookup_by_predicates(transaction, item.record.table, &predicates, item.line).await
}

fn predicates(
    values: &Map<String, Value>,
    columns: &[&'static str],
    item: &BundleRecord,
) -> Result<Vec<(&'static str, Value)>, GlobalSeedLoadError> {
    predicates_with_defaults(
        values,
        &columns
            .iter()
            .map(|column| (*column, None))
            .collect::<Vec<_>>(),
        item,
    )
}

fn predicates_with_defaults(
    values: &Map<String, Value>,
    columns: &[(&'static str, Option<Value>)],
    item: &BundleRecord,
) -> Result<Vec<(&'static str, Value)>, GlobalSeedLoadError> {
    columns
        .iter()
        .map(|(column, default)| {
            values
                .get(*column)
                .cloned()
                .or_else(|| default.clone())
                .map(|value| (*column, value))
                .ok_or_else(|| {
                    GlobalSeedLoadError::input(
                        "NATURAL_KEY_COLUMN_MISSING",
                        format!(
                            "{} natural lookup에 {} 값이 없음",
                            item.record.table.as_str(),
                            column
                        ),
                        Some(item.line),
                    )
                })
        })
        .collect()
}

async fn lookup_by_predicates(
    transaction: &mut Transaction<'_, MySql>,
    table: LoadTable,
    predicates: &[(&'static str, Value)],
    line: usize,
) -> Result<Option<String>, GlobalSeedLoadError> {
    let mut builder = QueryBuilder::<MySql>::new(format!(
        "SELECT CAST(id AS CHAR) AS target_id FROM {} WHERE ",
        table.as_str()
    ));
    for (index, (column_name, value)) in predicates.iter().enumerate() {
        if index > 0 {
            builder.push(" AND ");
        }
        if value.is_null() {
            builder.push(format!("{column_name} IS NULL"));
        } else {
            builder.push(format!("{column_name} = "));
            push_bind_value(
                &mut builder,
                column_spec(table, column_name).expect("predicate column은 table spec에 있음"),
                value,
                line,
            )?;
        }
    }
    builder.push(" LIMIT 2 FOR UPDATE");
    let rows = builder.build().fetch_all(&mut **transaction).await?;
    if rows.len() > 1 {
        return Err(GlobalSeedLoadError::input(
            "AMBIGUOUS_NATURAL_KEY",
            format!(
                "{} stable natural key가 둘 이상의 row와 일치함",
                table.as_str()
            ),
            Some(line),
        ));
    }
    rows.first()
        .map(|row| row.try_get("target_id"))
        .transpose()
        .map_err(GlobalSeedLoadError::from)
}

fn push_bind_value<'args>(
    builder: &mut QueryBuilder<'args, MySql>,
    column: ColumnSpec,
    value: &Value,
    line: usize,
) -> Result<(), GlobalSeedLoadError> {
    if value.is_null() {
        builder.push_bind(Option::<String>::None);
        return Ok(());
    }
    match column.kind {
        ColumnKind::String => {
            builder.push_bind(value.as_str().expect("string validation 완료").to_string());
        }
        ColumnKind::Signed => {
            let parsed = value
                .as_i64()
                .or_else(|| value.as_u64().and_then(|number| i64::try_from(number).ok()))
                .ok_or_else(|| {
                    GlobalSeedLoadError::input(
                        "SIGNED_INTEGER_OVERFLOW",
                        format!("{} 값이 signed integer 범위를 벗어남", column.name),
                        Some(line),
                    )
                })?;
            builder.push_bind(parsed);
        }
        ColumnKind::Unsigned => {
            let parsed = value
                .as_u64()
                .or_else(|| value.as_i64().and_then(|number| u64::try_from(number).ok()))
                .ok_or_else(|| {
                    GlobalSeedLoadError::input(
                        "UNSIGNED_INTEGER_OVERFLOW",
                        format!("{} 값이 unsigned integer 범위를 벗어남", column.name),
                        Some(line),
                    )
                })?;
            builder.push_bind(parsed);
        }
        ColumnKind::Decimal => {
            builder.push_bind(decimal_string(value).ok_or_else(|| {
                GlobalSeedLoadError::input(
                    "INVALID_DECIMAL",
                    format!("{} 값이 decimal이 아님", column.name),
                    Some(line),
                )
            })?);
        }
        ColumnKind::Boolean => {
            builder.push_bind(value.as_bool().expect("boolean validation 완료"));
        }
        ColumnKind::Json => {
            builder.push_bind(sqlx::types::Json(value.clone()));
        }
        ColumnKind::Timestamp => {
            let timestamp = value.as_str().and_then(parse_timestamp).ok_or_else(|| {
                GlobalSeedLoadError::input(
                    "INVALID_TIMESTAMP",
                    format!("{} timestamp 형식이 잘못됨", column.name),
                    Some(line),
                )
            })?;
            builder.push_bind(timestamp);
        }
        ColumnKind::Date => {
            let date = value
                .as_str()
                .and_then(|value| NaiveDate::parse_from_str(value, "%Y-%m-%d").ok())
                .ok_or_else(|| {
                    GlobalSeedLoadError::input(
                        "INVALID_DATE",
                        format!("{} date 형식이 잘못됨", column.name),
                        Some(line),
                    )
                })?;
            builder.push_bind(date);
        }
    }
    Ok(())
}

async fn insert_record(
    transaction: &mut Transaction<'_, MySql>,
    item: &BundleRecord,
    values: &Map<String, Value>,
) -> Result<String, GlobalSeedLoadError> {
    let spec = table_spec(item.record.table);
    let ordered_columns = spec
        .columns
        .iter()
        .filter(|column| values.contains_key(column.name))
        .collect::<Vec<_>>();
    let mut builder =
        QueryBuilder::<MySql>::new(format!("INSERT INTO {} (", item.record.table.as_str()));
    {
        let mut separated = builder.separated(", ");
        for column in &ordered_columns {
            separated.push(column.name);
        }
    }
    builder.push(") VALUES (");
    for (index, column) in ordered_columns.iter().enumerate() {
        if index > 0 {
            builder.push(", ");
        }
        let value = values.get(column.name).expect("ordered column value 존재");
        push_bind_value(&mut builder, **column, value, item.line)?;
    }
    builder.push(")");
    let result = builder.build().execute(&mut **transaction).await?;
    match spec.id_kind {
        IdKind::Supplied => Ok(values
            .get("id")
            .and_then(Value::as_str)
            .expect("supplied id validation 완료")
            .to_string()),
        IdKind::Auto => Ok(result.last_insert_id().to_string()),
    }
}

async fn update_record(
    transaction: &mut Transaction<'_, MySql>,
    item: &BundleRecord,
    target_id: &str,
    values: &Map<String, Value>,
) -> Result<(), GlobalSeedLoadError> {
    let spec = table_spec(item.record.table);
    let ordered_columns = spec
        .columns
        .iter()
        .filter(|column| column.name != "id" && values.contains_key(column.name))
        .collect::<Vec<_>>();
    if ordered_columns.is_empty() {
        return Ok(());
    }
    let mut builder =
        QueryBuilder::<MySql>::new(format!("UPDATE {} SET ", item.record.table.as_str()));
    for (index, column) in ordered_columns.iter().enumerate() {
        if index > 0 {
            builder.push(", ");
        }
        builder.push(format!("{} = ", column.name));
        let value = values.get(column.name).expect("ordered column value 존재");
        push_bind_value(&mut builder, **column, value, item.line)?;
    }
    builder.push(" WHERE CAST(id AS CHAR) = ");
    builder.push_bind(target_id.to_string());
    let result = builder.build().execute(&mut **transaction).await?;
    if result.rows_affected() > 1 {
        return Err(GlobalSeedLoadError::input(
            "NON_UNIQUE_TARGET_UPDATE",
            format!(
                "{} target update가 여러 행을 변경함",
                item.record.table.as_str()
            ),
            Some(item.line),
        ));
    }
    Ok(())
}

async fn upsert_registry(
    transaction: &mut Transaction<'_, MySql>,
    item: &BundleRecord,
    target_id: &str,
    seed_run_id: &str,
) -> Result<(), GlobalSeedLoadError> {
    sqlx::query(
        "INSERT INTO seed_natural_keys (
            target_table, natural_key_sha256, natural_key, target_id,
            record_fingerprint, first_seed_run_id, last_seed_run_id
         ) VALUES (?, ?, ?, ?, ?, ?, ?)
         ON DUPLICATE KEY UPDATE
            natural_key = VALUES(natural_key),
            target_id = VALUES(target_id),
            record_fingerprint = VALUES(record_fingerprint),
            last_seed_run_id = VALUES(last_seed_run_id)",
    )
    .bind(item.record.table.as_str())
    .bind(natural_key_sha256(&item.record.natural_key))
    .bind(&item.record.natural_key)
    .bind(target_id)
    .bind(&item.fingerprint)
    .bind(seed_run_id)
    .bind(seed_run_id)
    .execute(&mut **transaction)
    .await?;
    Ok(())
}

async fn finish_seed_run(
    transaction: &mut Transaction<'_, MySql>,
    seed_run_id: &str,
    row_count: usize,
    counts: &GlobalSeedMutationCounts,
) -> Result<(), GlobalSeedLoadError> {
    if counts.total == 0 && counts.registry_mappings == 0 {
        return Ok(());
    }
    let summary = serde_json::json!({
        "contractVersion": CONTRACT_VERSION,
        "rowCount": row_count,
        "inserted": counts.inserted,
        "updated": counts.updated,
        "reused": counts.reused,
        "protectedReused": counts.protected_reused,
        "registryMappings": counts.registry_mappings,
        "mutationCount": counts.total,
    });
    let result = sqlx::query(
        "UPDATE seed_runs
         SET status = 'SUCCEEDED',
             dry_run = FALSE,
             summary = ?,
             finished_at = CURRENT_TIMESTAMP(6)
         WHERE id = ?",
    )
    .bind(sqlx::types::Json(summary))
    .bind(seed_run_id)
    .execute(&mut **transaction)
    .await?;
    if result.rows_affected() != 1 {
        return Err(GlobalSeedLoadError::input(
            "SEED_RUN_FINISH_FAILED",
            format!("seed_runs {seed_run_id} 완료 상태를 기록하지 못함"),
            None,
        ));
    }
    Ok(())
}

async fn insert_mutation(
    transaction: &mut Transaction<'_, MySql>,
    seed_run_id: &str,
    event: &MutationEvent,
) -> Result<(), GlobalSeedLoadError> {
    sqlx::query(
        "INSERT INTO seed_mutations (
            seed_run_id, target_table, target_id, operation,
            before_json, after_json, manual_guard_confirmed
         ) VALUES (?, ?, ?, ?, ?, ?, TRUE)",
    )
    .bind(seed_run_id)
    .bind(&event.target_table)
    .bind(&event.target_id)
    .bind(event.operation)
    .bind(event.before.clone().map(sqlx::types::Json))
    .bind(event.after.clone().map(sqlx::types::Json))
    .execute(&mut **transaction)
    .await?;
    Ok(())
}

fn rollback_manifest(
    seed_run_id: &str,
    dry_run: bool,
    events: &[MutationEvent],
    planned: &[RollbackEntry],
) -> RollbackManifest {
    let entries = if dry_run {
        planned
            .iter()
            .rev()
            .enumerate()
            .map(|(index, entry)| RollbackEntry {
                sequence: index + 1,
                target_table: entry.target_table.clone(),
                target_id: entry.target_id.clone(),
                reverse_operation: entry.reverse_operation.clone(),
                restore_json: entry.restore_json.clone(),
            })
            .collect()
    } else {
        events
            .iter()
            .rev()
            .enumerate()
            .map(|(index, event)| RollbackEntry {
                sequence: index + 1,
                target_table: event.target_table.clone(),
                target_id: event.target_id.clone(),
                reverse_operation: if event.operation == "INSERT" {
                    "DELETE".to_string()
                } else {
                    "RESTORE".to_string()
                },
                restore_json: event.before.clone(),
            })
            .collect()
    };
    RollbackManifest {
        schema_version: "1",
        seed_run_id: seed_run_id.to_string(),
        dry_run,
        entries,
    }
}

#[cfg(test)]
mod tests {
    use super::{parse_bundle, GlobalSeedLoadOptions};
    use serde_json::{json, Value};
    use std::{fs, path::PathBuf, time::SystemTime};

    const RUN_ID: &str = "11111111-1111-4111-8111-111111111111";

    fn temporary_bundle(name: &str, records: &[Value]) -> PathBuf {
        let path = std::env::temp_dir().join(format!(
            "classicmap-global-loader-{name}-{}-{}.jsonl",
            std::process::id(),
            SystemTime::now()
                .duration_since(SystemTime::UNIX_EPOCH)
                .expect("현재 시각")
                .as_nanos()
        ));
        let contents = records
            .iter()
            .map(|record| serde_json::to_string(record).expect("fixture JSON"))
            .collect::<Vec<_>>()
            .join("\n");
        fs::write(&path, format!("{contents}\n")).expect("fixture 작성");
        path
    }

    fn seed_run() -> Value {
        json!({
            "db_contract_version": "global-seed-v1",
            "seed_run_id": RUN_ID,
            "table": "seed_runs",
            "natural_key": RUN_ID,
            "values": {
                "id": RUN_ID,
                "run_kind": "global_seed",
                "command": "integration"
            },
            "foreign_keys": [],
            "evidence": {},
            "origin": "seed",
            "editor_locked": false,
            "write_policy": "preserve_manual_or_locked"
        })
    }

    #[test]
    fn strict_bundle_rejects_unknown_outer_and_table_columns_before_database() {
        for (name, mut record) in [("outer", seed_run()), ("column", seed_run())] {
            if name == "outer" {
                record
                    .as_object_mut()
                    .expect("record object")
                    .insert("bogus".to_string(), json!(true));
            } else {
                record["values"]
                    .as_object_mut()
                    .expect("values object")
                    .insert("bogus_column".to_string(), json!("x"));
            }
            let path = temporary_bundle(name, &[record]);
            let error = parse_bundle(&GlobalSeedLoadOptions::new(path.clone()))
                .expect_err("strict 오류여야 함");
            assert!(matches!(
                error.code(),
                "INVALID_JSONL_RECORD" | "UNKNOWN_TABLE_COLUMN"
            ));
            fs::remove_file(path).expect("fixture 삭제");
        }
    }

    #[test]
    fn required_column_and_bundle_fk_are_rejected_before_database() {
        let mut missing = seed_run();
        missing["values"]
            .as_object_mut()
            .expect("values object")
            .remove("command");
        let missing_path = temporary_bundle("missing", &[missing]);
        let error = parse_bundle(&GlobalSeedLoadOptions::new(missing_path.clone()))
            .expect_err("필수 column 오류여야 함");
        assert_eq!(error.code(), "REQUIRED_COLUMN_MISSING");
        fs::remove_file(missing_path).expect("fixture 삭제");

        let snapshot = json!({
            "db_contract_version": "global-seed-v1",
            "seed_run_id": RUN_ID,
            "table": "source_snapshots",
            "natural_key": "wikidata:snapshot",
            "values": {
                "seed_run_id": RUN_ID,
                "source": "wikidata",
                "source_uri": "https://www.wikidata.org/",
                "retrieved_at": "2026-08-05T00:00:00Z",
                "license": "CC0",
                "sha256": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                "tool_version": "test",
                "storage_path": "fixture.jsonl"
            },
            "foreign_keys": [{
                "column": "seed_run_id",
                "target_table": "seed_runs",
                "target_natural_key": "22222222-2222-4222-8222-222222222222",
                "resolution": "bundle"
            }]
        });
        let fk_path = temporary_bundle("missing-fk", &[seed_run(), snapshot]);
        let error = parse_bundle(&GlobalSeedLoadOptions::new(fk_path.clone()))
            .expect_err("bundle FK 오류여야 함");
        assert_eq!(error.code(), "BUNDLE_FOREIGN_KEY_MISSING");
        fs::remove_file(fk_path).expect("fixture 삭제");
    }
}
