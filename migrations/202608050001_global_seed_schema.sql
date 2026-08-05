-- ClassicMap 국제 초기 시드 v1 정규 스키마
-- 기존 테이블과 컬럼은 제거하거나 이름을 변경하지 않는다.

CREATE TABLE seed_runs (
    id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin PRIMARY KEY,
    run_kind VARCHAR(50) NOT NULL,
    command VARCHAR(255) NOT NULL,
    status VARCHAR(32) NOT NULL DEFAULT 'PENDING',
    dry_run BOOLEAN NOT NULL DEFAULT FALSE,
    source_code_version VARCHAR(100),
    manifest JSON,
    summary JSON,
    started_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    finished_at TIMESTAMP(6),
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_seed_runs_status CHECK (
        status IN ('PENDING', 'RUNNING', 'SUCCEEDED', 'FAILED', 'ROLLED_BACK')
    ),
    INDEX idx_seed_runs_status_started (status, started_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE source_snapshots (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    seed_run_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    source VARCHAR(64) NOT NULL,
    source_uri VARCHAR(1000) NOT NULL,
    retrieved_at TIMESTAMP(6) NOT NULL,
    source_version VARCHAR(255),
    license VARCHAR(255) NOT NULL,
    sha256 CHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    row_count BIGINT UNSIGNED,
    tool_version VARCHAR(100) NOT NULL,
    storage_path VARCHAR(1000) NOT NULL,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_source_snapshots_seed_run
        FOREIGN KEY (seed_run_id) REFERENCES seed_runs(id) ON DELETE RESTRICT,
    UNIQUE KEY uq_source_snapshots_source_sha (source, sha256),
    INDEX idx_source_snapshots_seed_run (seed_run_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE source_records (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    snapshot_id BIGINT UNSIGNED NOT NULL,
    source_record_id VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    entity_type VARCHAR(64) NOT NULL,
    payload_sha256 CHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    payload JSON NOT NULL,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_source_records_snapshot
        FOREIGN KEY (snapshot_id) REFERENCES source_snapshots(id) ON DELETE RESTRICT,
    UNIQUE KEY uq_source_records_snapshot_record (snapshot_id, source_record_id),
    INDEX idx_source_records_entity_type (entity_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE authority_entities (
    id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin PRIMARY KEY,
    entity_kind VARCHAR(32) NOT NULL,
    editorial_status VARCHAR(32) NOT NULL DEFAULT 'DISCOVERED',
    origin VARCHAR(16) NOT NULL DEFAULT 'seed',
    editor_locked BOOLEAN NOT NULL DEFAULT FALSE,
    canonical_source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_authority_entities_kind CHECK (
        entity_kind IN ('person', 'ensemble', 'orchestra', 'choir', 'organization')
    ),
    CONSTRAINT chk_authority_entities_status CHECK (
        editorial_status IN (
            'DISCOVERED', 'IDENTIFIERS_MATCHED', 'FACTS_VERIFIED',
            'EDITOR_REVIEWED', 'PUBLISHED', 'REVIEW_REQUIRED'
        )
    ),
    CONSTRAINT chk_authority_entities_origin CHECK (origin IN ('manual', 'seed')),
    CONSTRAINT fk_authority_entities_source_record
        FOREIGN KEY (canonical_source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    INDEX idx_authority_entities_status (editorial_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE entity_names (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    authority_entity_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    locale VARCHAR(35) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    name_kind VARCHAR(32) NOT NULL,
    name_value VARCHAR(300) NOT NULL,
    normalized_value VARCHAR(300) NOT NULL,
    is_preferred BOOLEAN NOT NULL DEFAULT FALSE,
    transliteration_status VARCHAR(32),
    origin VARCHAR(16) NOT NULL DEFAULT 'seed',
    editor_locked BOOLEAN NOT NULL DEFAULT FALSE,
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_entity_names_kind CHECK (
        name_kind IN ('canonical', 'alias', 'transliteration', 'former')
    ),
    CONSTRAINT chk_entity_names_origin CHECK (origin IN ('manual', 'seed')),
    CONSTRAINT chk_entity_names_transliteration CHECK (
        transliteration_status IS NULL
        OR transliteration_status IN ('generated', 'review_required', 'verified')
    ),
    CONSTRAINT fk_entity_names_authority
        FOREIGN KEY (authority_entity_id) REFERENCES authority_entities(id) ON DELETE CASCADE,
    CONSTRAINT fk_entity_names_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_entity_names_identity (
        authority_entity_id, locale, name_kind, normalized_value
    ),
    INDEX idx_entity_names_lookup (locale, normalized_value)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE entity_roles (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    authority_entity_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    role_code VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_entity_roles_authority
        FOREIGN KEY (authority_entity_id) REFERENCES authority_entities(id) ON DELETE CASCADE,
    CONSTRAINT fk_entity_roles_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_entity_roles_entity_role (authority_entity_id, role_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE entity_instruments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    authority_entity_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    instrument_code VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_entity_instruments_authority
        FOREIGN KEY (authority_entity_id) REFERENCES authority_entities(id) ON DELETE CASCADE,
    CONSTRAINT fk_entity_instruments_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_entity_instruments_entity_instrument (
        authority_entity_id, instrument_code
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE entity_countries (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    authority_entity_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    country_code CHAR(2) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    relation_type VARCHAR(32) NOT NULL DEFAULT 'nationality',
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_entity_countries_relation CHECK (
        relation_type IN ('nationality', 'birth', 'death', 'residence', 'activity')
    ),
    CONSTRAINT fk_entity_countries_authority
        FOREIGN KEY (authority_entity_id) REFERENCES authority_entities(id) ON DELETE CASCADE,
    CONSTRAINT fk_entity_countries_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_entity_countries_relation (
        authority_entity_id, country_code, relation_type
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE external_identifiers (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    authority_entity_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    namespace VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    external_id VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    source_record_id BIGINT UNSIGNED,
    verified_at TIMESTAMP(6),
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_external_identifiers_authority
        FOREIGN KEY (authority_entity_id) REFERENCES authority_entities(id) ON DELETE CASCADE,
    CONSTRAINT fk_external_identifiers_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_external_identifiers_namespace_value (namespace, external_id),
    UNIQUE KEY uq_external_identifiers_entity_namespace (authority_entity_id, namespace)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE entity_images (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    authority_entity_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    image_kind VARCHAR(32) NOT NULL DEFAULT 'profile',
    source_url VARCHAR(1000) NOT NULL,
    file_url VARCHAR(1000) NOT NULL,
    author VARCHAR(500),
    license VARCHAR(255),
    license_url VARCHAR(1000),
    credit_line TEXT,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    editorial_status VARCHAR(32) NOT NULL DEFAULT 'REVIEW_REQUIRED',
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_entity_images_status CHECK (
        editorial_status IN ('REVIEW_REQUIRED', 'RIGHTS_VERIFIED', 'PUBLISHED', 'RETIRED')
    ),
    CONSTRAINT fk_entity_images_authority
        FOREIGN KEY (authority_entity_id) REFERENCES authority_entities(id) ON DELETE CASCADE,
    CONSTRAINT fk_entity_images_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_entity_images_entity_file (authority_entity_id, file_url(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE composers
    ADD COLUMN authority_entity_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NULL,
    ADD COLUMN source_record_id BIGINT UNSIGNED NULL,
    ADD COLUMN origin VARCHAR(16) NOT NULL DEFAULT 'manual',
    ADD COLUMN editor_locked BOOLEAN NOT NULL DEFAULT TRUE,
    ADD CONSTRAINT chk_composers_origin CHECK (origin IN ('manual', 'seed')),
    ADD CONSTRAINT fk_composers_authority
        FOREIGN KEY (authority_entity_id) REFERENCES authority_entities(id) ON DELETE SET NULL,
    ADD CONSTRAINT fk_composers_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    ADD UNIQUE KEY uq_composers_authority (authority_entity_id),
    ADD INDEX idx_composers_source_record (source_record_id);

ALTER TABLE artists
    ADD COLUMN authority_entity_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NULL,
    ADD COLUMN source_record_id BIGINT UNSIGNED NULL,
    ADD COLUMN origin VARCHAR(16) NOT NULL DEFAULT 'manual',
    ADD COLUMN editor_locked BOOLEAN NOT NULL DEFAULT TRUE,
    ADD CONSTRAINT chk_artists_origin CHECK (origin IN ('manual', 'seed')),
    ADD CONSTRAINT fk_artists_authority
        FOREIGN KEY (authority_entity_id) REFERENCES authority_entities(id) ON DELETE SET NULL,
    ADD CONSTRAINT fk_artists_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    ADD UNIQUE KEY uq_artists_authority (authority_entity_id),
    ADD INDEX idx_artists_source_record (source_record_id);

CREATE TABLE piece_aliases (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    piece_id INT NOT NULL,
    locale VARCHAR(35) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    alias_kind VARCHAR(32) NOT NULL DEFAULT 'alias',
    alias_value VARCHAR(500) NOT NULL,
    normalized_value VARCHAR(500) NOT NULL,
    is_preferred BOOLEAN NOT NULL DEFAULT FALSE,
    origin VARCHAR(16) NOT NULL DEFAULT 'seed',
    editor_locked BOOLEAN NOT NULL DEFAULT FALSE,
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_piece_aliases_origin CHECK (origin IN ('manual', 'seed')),
    CONSTRAINT fk_piece_aliases_piece
        FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    CONSTRAINT fk_piece_aliases_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_piece_aliases_identity (
        piece_id, locale, alias_kind, normalized_value(255)
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE piece_identifiers (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    piece_id INT NOT NULL,
    namespace VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    external_id VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    source_record_id BIGINT UNSIGNED,
    verified_at TIMESTAMP(6),
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_piece_identifiers_piece
        FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    CONSTRAINT fk_piece_identifiers_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_piece_identifiers_namespace_value (namespace, external_id),
    UNIQUE KEY uq_piece_identifiers_piece_namespace (piece_id, namespace)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE piece_parts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    piece_id INT NOT NULL,
    parent_part_id BIGINT UNSIGNED,
    part_key VARCHAR(150) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    sequence_number INT NOT NULL,
    movement_number VARCHAR(32),
    name_ko VARCHAR(500),
    name_en VARCHAR(500),
    duration_ms INT UNSIGNED,
    editorial_status VARCHAR(32) NOT NULL DEFAULT 'DISCOVERED',
    origin VARCHAR(16) NOT NULL DEFAULT 'seed',
    editor_locked BOOLEAN NOT NULL DEFAULT FALSE,
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_piece_parts_status CHECK (
        editorial_status IN (
            'DISCOVERED', 'IDENTIFIERS_MATCHED', 'FACTS_VERIFIED',
            'EDITOR_REVIEWED', 'PUBLISHED', 'REVIEW_REQUIRED'
        )
    ),
    CONSTRAINT chk_piece_parts_origin CHECK (origin IN ('manual', 'seed')),
    CONSTRAINT fk_piece_parts_piece
        FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    CONSTRAINT fk_piece_parts_parent
        FOREIGN KEY (parent_part_id, piece_id)
        REFERENCES piece_parts(id, piece_id) ON DELETE CASCADE,
    CONSTRAINT fk_piece_parts_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_piece_parts_piece_key (piece_id, part_key),
    UNIQUE KEY uq_piece_parts_id_piece (id, piece_id),
    INDEX idx_piece_parts_order (piece_id, parent_part_id, sequence_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE piece_relations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    from_piece_id INT NOT NULL,
    to_piece_id INT NOT NULL,
    relation_type VARCHAR(32) NOT NULL,
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_piece_relations_distinct CHECK (from_piece_id <> to_piece_id),
    CONSTRAINT chk_piece_relations_type CHECK (
        relation_type IN ('arrangement_of', 'revision_of', 'version_of', 'part_of', 'based_on')
    ),
    CONSTRAINT fk_piece_relations_from
        FOREIGN KEY (from_piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    CONSTRAINT fk_piece_relations_to
        FOREIGN KEY (to_piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    CONSTRAINT fk_piece_relations_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_piece_relations_identity (from_piece_id, to_piece_id, relation_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE piece_instrumentation (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    piece_id INT NOT NULL,
    instrument_code VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    instrumentation_role VARCHAR(32) NOT NULL DEFAULT 'instrument',
    minimum_count SMALLINT UNSIGNED,
    maximum_count SMALLINT UNSIGNED,
    notes VARCHAR(500),
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_piece_instrumentation_count CHECK (
        maximum_count IS NULL OR minimum_count IS NULL OR maximum_count >= minimum_count
    ),
    CONSTRAINT fk_piece_instrumentation_piece
        FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    CONSTRAINT fk_piece_instrumentation_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_piece_instrumentation_identity (
        piece_id, instrument_code, instrumentation_role
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE pieces
    ADD COLUMN catalogue_system VARCHAR(64) NULL,
    ADD COLUMN catalogue_number VARCHAR(100) NULL,
    ADD COLUMN work_type VARCHAR(64) NULL,
    ADD COLUMN composition_date VARCHAR(32) NULL,
    ADD COLUMN date_precision VARCHAR(16) NULL,
    ADD COLUMN date_qualifier VARCHAR(32) NULL,
    ADD COLUMN source_record_id BIGINT UNSIGNED NULL,
    ADD COLUMN origin VARCHAR(16) NOT NULL DEFAULT 'manual',
    ADD COLUMN editor_locked BOOLEAN NOT NULL DEFAULT TRUE,
    ADD CONSTRAINT chk_pieces_origin CHECK (origin IN ('manual', 'seed')),
    ADD CONSTRAINT fk_pieces_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    ADD INDEX idx_pieces_catalogue (composer_id, catalogue_system, catalogue_number),
    ADD INDEX idx_pieces_source_record (source_record_id);

CREATE TABLE recording_tracks (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    recording_id INT NOT NULL,
    track_key VARCHAR(100) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    disc_number SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    track_number SMALLINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    duration_ms INT UNSIGNED,
    isrc CHAR(12) CHARACTER SET ascii COLLATE ascii_bin,
    source_record_id BIGINT UNSIGNED,
    origin VARCHAR(16) NOT NULL DEFAULT 'seed',
    editor_locked BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_recording_tracks_origin CHECK (origin IN ('manual', 'seed')),
    CONSTRAINT fk_recording_tracks_recording
        FOREIGN KEY (recording_id) REFERENCES recordings(id) ON DELETE CASCADE,
    CONSTRAINT fk_recording_tracks_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_recording_tracks_recording_key (recording_id, track_key),
    UNIQUE KEY uq_recording_tracks_id_recording (id, recording_id),
    INDEX idx_recording_tracks_isrc (isrc),
    INDEX idx_recording_tracks_order (recording_id, disc_number, track_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE recording_contributors (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    recording_id INT NOT NULL,
    track_id BIGINT UNSIGNED,
    track_scope_id BIGINT UNSIGNED GENERATED ALWAYS AS (COALESCE(track_id, 0)) STORED,
    artist_id INT NOT NULL,
    role_code VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    display_order INT NOT NULL DEFAULT 0,
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_recording_contributors_recording
        FOREIGN KEY (recording_id) REFERENCES recordings(id) ON DELETE CASCADE,
    CONSTRAINT fk_recording_contributors_track_recording
        FOREIGN KEY (track_id, recording_id)
        REFERENCES recording_tracks(id, recording_id) ON DELETE RESTRICT,
    CONSTRAINT fk_recording_contributors_artist
        FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE,
    CONSTRAINT fk_recording_contributors_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_recording_contributors_identity (
        recording_id, track_scope_id, artist_id, role_code
    ),
    INDEX idx_recording_contributors_artist (artist_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE track_piece_links (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    track_id BIGINT UNSIGNED NOT NULL,
    piece_id INT NOT NULL,
    piece_part_id BIGINT UNSIGNED,
    part_scope_id BIGINT UNSIGNED GENERATED ALWAYS AS (COALESCE(piece_part_id, 0)) STORED,
    relation_type VARCHAR(32) NOT NULL DEFAULT 'performance_of',
    confidence DECIMAL(5,4),
    editorial_status VARCHAR(32) NOT NULL DEFAULT 'DISCOVERED',
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_track_piece_links_confidence CHECK (
        confidence IS NULL OR (confidence >= 0 AND confidence <= 1)
    ),
    CONSTRAINT chk_track_piece_links_status CHECK (
        editorial_status IN (
            'DISCOVERED', 'IDENTIFIERS_MATCHED', 'FACTS_VERIFIED',
            'EDITOR_REVIEWED', 'PUBLISHED', 'REVIEW_REQUIRED'
        )
    ),
    CONSTRAINT fk_track_piece_links_track
        FOREIGN KEY (track_id) REFERENCES recording_tracks(id) ON DELETE CASCADE,
    CONSTRAINT fk_track_piece_links_piece
        FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    CONSTRAINT fk_track_piece_links_part_piece
        FOREIGN KEY (piece_part_id, piece_id) REFERENCES piece_parts(id, piece_id) ON DELETE RESTRICT,
    CONSTRAINT fk_track_piece_links_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_track_piece_links_identity (track_id, piece_id, part_scope_id, relation_type),
    INDEX idx_track_piece_links_piece (piece_id, piece_part_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE platform_links (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    recording_id INT,
    track_id BIGINT UNSIGNED,
    platform VARCHAR(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    storefront VARCHAR(16) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
    platform_id VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    url VARCHAR(1000) NOT NULL,
    isrc CHAR(12) CHARACTER SET ascii COLLATE ascii_bin,
    verified_at TIMESTAMP(6),
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_platform_links_subject CHECK (
        (recording_id IS NOT NULL AND track_id IS NULL)
        OR (recording_id IS NULL AND track_id IS NOT NULL)
    ),
    CONSTRAINT fk_platform_links_recording
        FOREIGN KEY (recording_id) REFERENCES recordings(id) ON DELETE CASCADE,
    CONSTRAINT fk_platform_links_track
        FOREIGN KEY (track_id) REFERENCES recording_tracks(id) ON DELETE CASCADE,
    CONSTRAINT fk_platform_links_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_platform_links_platform_id (platform, storefront, platform_id),
    INDEX idx_platform_links_recording (recording_id),
    INDEX idx_platform_links_track (track_id),
    INDEX idx_platform_links_isrc (isrc)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE recordings
    ADD COLUMN source_record_id BIGINT UNSIGNED NULL,
    ADD COLUMN origin VARCHAR(16) NOT NULL DEFAULT 'manual',
    ADD COLUMN editor_locked BOOLEAN NOT NULL DEFAULT TRUE,
    ADD CONSTRAINT chk_recordings_origin CHECK (origin IN ('manual', 'seed')),
    ADD CONSTRAINT fk_recordings_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    ADD INDEX idx_recordings_source_record (source_record_id);

CREATE TABLE field_provenance (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    seed_run_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin,
    source_record_id BIGINT UNSIGNED,
    target_table VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    target_id VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    field_name VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    origin VARCHAR(16) NOT NULL,
    confidence DECIMAL(5,4),
    editorial_status VARCHAR(32) NOT NULL DEFAULT 'DISCOVERED',
    evidence JSON,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_field_provenance_origin CHECK (origin IN ('manual', 'seed')),
    CONSTRAINT chk_field_provenance_confidence CHECK (
        confidence IS NULL OR (confidence >= 0 AND confidence <= 1)
    ),
    CONSTRAINT chk_field_provenance_status CHECK (
        editorial_status IN (
            'DISCOVERED', 'IDENTIFIERS_MATCHED', 'FACTS_VERIFIED',
            'EDITOR_REVIEWED', 'PUBLISHED', 'REVIEW_REQUIRED'
        )
    ),
    CONSTRAINT fk_field_provenance_seed_run
        FOREIGN KEY (seed_run_id) REFERENCES seed_runs(id) ON DELETE RESTRICT,
    CONSTRAINT fk_field_provenance_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE RESTRICT,
    UNIQUE KEY uq_field_provenance_evidence (
        target_table, target_id, field_name, source_record_id
    ),
    INDEX idx_field_provenance_target (target_table, target_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE review_queue (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    seed_run_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin,
    target_type VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    target_id VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    reason_code VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    status VARCHAR(32) NOT NULL DEFAULT 'OPEN',
    priority SMALLINT NOT NULL DEFAULT 0,
    evidence JSON NOT NULL,
    resolution JSON,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    resolved_at TIMESTAMP(6),
    CONSTRAINT chk_review_queue_status CHECK (
        status IN ('OPEN', 'IN_REVIEW', 'APPROVED', 'REJECTED', 'CANCELLED')
    ),
    CONSTRAINT fk_review_queue_seed_run
        FOREIGN KEY (seed_run_id) REFERENCES seed_runs(id) ON DELETE RESTRICT,
    INDEX idx_review_queue_status_priority (status, priority, created_at),
    INDEX idx_review_queue_target (target_type, target_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE seed_mutations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    seed_run_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    target_table VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    target_id VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    operation VARCHAR(16) NOT NULL,
    before_json JSON,
    after_json JSON,
    manual_guard_confirmed BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_seed_mutations_operation CHECK (operation IN ('INSERT', 'UPDATE', 'DELETE')),
    CONSTRAINT fk_seed_mutations_seed_run
        FOREIGN KEY (seed_run_id) REFERENCES seed_runs(id) ON DELETE RESTRICT,
    INDEX idx_seed_mutations_run_target (seed_run_id, target_table, target_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE performance_sources (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    provider VARCHAR(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    provider_video_id VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    source_url VARCHAR(1000),
    source_duration_ms INT UNSIGNED,
    availability_status VARCHAR(32) NOT NULL DEFAULT 'UNKNOWN',
    rights_mode VARCHAR(32) NOT NULL DEFAULT 'unknown',
    last_checked_at TIMESTAMP(6),
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_performance_sources_availability CHECK (
        availability_status IN ('UNKNOWN', 'AVAILABLE', 'UNAVAILABLE', 'REGION_BLOCKED', 'REMOVED')
    ),
    CONSTRAINT chk_performance_sources_rights CHECK (
        rights_mode IN (
            'youtube_embed_only', 'licensed_self_hosted', 'public_domain',
            'permission_granted', 'unknown'
        )
    ),
    CONSTRAINT fk_performance_sources_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_performance_sources_provider_video (provider, provider_video_id),
    INDEX idx_performance_sources_availability (availability_status, last_checked_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE performance_sectors
    ADD COLUMN piece_part_id BIGINT UNSIGNED NULL,
    ADD COLUMN sector_key VARCHAR(150) CHARACTER SET ascii COLLATE ascii_bin NULL,
    ADD COLUMN sector_type VARCHAR(32) NULL,
    ADD COLUMN name_ko VARCHAR(200) NULL,
    ADD COLUMN name_en VARCHAR(300) NULL,
    ADD COLUMN measure_start VARCHAR(32) NULL,
    ADD COLUMN measure_end VARCHAR(32) NULL,
    ADD COLUMN start_cue TEXT NULL,
    ADD COLUMN end_cue TEXT NULL,
    ADD COLUMN target_min_ms INT UNSIGNED NULL,
    ADD COLUMN target_max_ms INT UNSIGNED NULL,
    ADD COLUMN editorial_status VARCHAR(32) NOT NULL DEFAULT 'PUBLISHED',
    ADD COLUMN source_record_id BIGINT UNSIGNED NULL,
    ADD COLUMN origin VARCHAR(16) NOT NULL DEFAULT 'manual',
    ADD COLUMN editor_locked BOOLEAN NOT NULL DEFAULT TRUE,
    ADD CONSTRAINT chk_performance_sectors_target CHECK (
        (target_min_ms IS NULL OR target_min_ms > 0)
        AND (target_max_ms IS NULL OR target_max_ms <= 600000)
        AND (
            target_min_ms IS NULL OR target_max_ms IS NULL
            OR target_max_ms >= target_min_ms
        )
    ),
    ADD CONSTRAINT chk_performance_sectors_status CHECK (
        editorial_status IN (
            'DISCOVERED', 'IDENTIFIERS_MATCHED', 'FACTS_VERIFIED',
            'EDITOR_REVIEWED', 'PUBLISHED', 'REVIEW_REQUIRED'
        )
    ),
    ADD CONSTRAINT chk_performance_sectors_origin CHECK (origin IN ('manual', 'seed')),
    ADD CONSTRAINT fk_performance_sectors_part_piece
        FOREIGN KEY (piece_part_id, piece_id) REFERENCES piece_parts(id, piece_id) ON DELETE RESTRICT,
    ADD CONSTRAINT fk_performance_sectors_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    ADD UNIQUE KEY uq_performance_sectors_piece_key (piece_id, sector_key),
    ADD INDEX idx_performance_sectors_part (piece_part_id);

CREATE TABLE performance_candidates (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    sector_id INT NOT NULL,
    performance_source_id BIGINT UNSIGNED NOT NULL,
    proposed_start_ms INT UNSIGNED NOT NULL,
    proposed_end_ms INT UNSIGNED NOT NULL,
    candidate_status VARCHAR(32) NOT NULL DEFAULT 'DISCOVERED',
    evidence JSON,
    seed_run_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_performance_candidates_duration CHECK (
        proposed_end_ms > proposed_start_ms
        AND proposed_end_ms - proposed_start_ms <= 600000
    ),
    CONSTRAINT chk_performance_candidates_status CHECK (
        candidate_status IN (
            'DISCOVERED', 'REVIEW_REQUIRED', 'APPROVED', 'REJECTED', 'PUBLISHED'
        )
    ),
    CONSTRAINT fk_performance_candidates_sector
        FOREIGN KEY (sector_id) REFERENCES performance_sectors(id) ON DELETE CASCADE,
    CONSTRAINT fk_performance_candidates_source
        FOREIGN KEY (performance_source_id) REFERENCES performance_sources(id) ON DELETE CASCADE,
    CONSTRAINT fk_performance_candidates_seed_run
        FOREIGN KEY (seed_run_id) REFERENCES seed_runs(id) ON DELETE RESTRICT,
    UNIQUE KEY uq_performance_candidates_clip (
        sector_id, performance_source_id, proposed_start_ms, proposed_end_ms
    ),
    INDEX idx_performance_candidates_status (candidate_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE performance_credits (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    performance_source_id BIGINT UNSIGNED NOT NULL,
    artist_id INT NOT NULL,
    role_code VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    display_order INT NOT NULL DEFAULT 0,
    source_record_id BIGINT UNSIGNED,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_performance_credits_source
        FOREIGN KEY (performance_source_id) REFERENCES performance_sources(id) ON DELETE CASCADE,
    CONSTRAINT fk_performance_credits_artist
        FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE,
    CONSTRAINT fk_performance_credits_source_record
        FOREIGN KEY (source_record_id) REFERENCES source_records(id) ON DELETE SET NULL,
    UNIQUE KEY uq_performance_credits_source_artist_role (
        performance_source_id, artist_id, role_code
    ),
    INDEX idx_performance_credits_artist (artist_id, is_primary)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE performances
    ADD COLUMN performance_source_id BIGINT UNSIGNED NULL,
    ADD COLUMN start_ms INT UNSIGNED NULL,
    ADD COLUMN end_ms INT UNSIGNED NULL,
    ADD COLUMN publish_status VARCHAR(32) NOT NULL DEFAULT 'PUBLISHED',
    ADD COLUMN seed_run_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NULL,
    ADD COLUMN origin VARCHAR(16) NOT NULL DEFAULT 'manual',
    ADD COLUMN editor_locked BOOLEAN NOT NULL DEFAULT TRUE,
    ADD CONSTRAINT chk_performances_clip_range CHECK (
        (start_ms IS NULL AND end_ms IS NULL)
        OR (
            start_ms IS NOT NULL AND end_ms IS NOT NULL
            AND end_ms > start_ms
            AND end_ms - start_ms <= 600000
        )
    ),
    ADD CONSTRAINT chk_performances_publish_status CHECK (
        publish_status IN ('DRAFT', 'READY', 'PUBLISHED', 'RETIRED')
    ),
    ADD CONSTRAINT chk_performances_origin CHECK (origin IN ('manual', 'seed')),
    ADD CONSTRAINT fk_performances_source
        FOREIGN KEY (performance_source_id) REFERENCES performance_sources(id) ON DELETE RESTRICT,
    ADD CONSTRAINT fk_performances_seed_run
        FOREIGN KEY (seed_run_id) REFERENCES seed_runs(id) ON DELETE RESTRICT,
    ADD INDEX idx_performances_source (performance_source_id),
    ADD INDEX idx_performances_publish_status (publish_status);

CREATE TABLE clip_jobs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    performance_id INT NOT NULL,
    status VARCHAR(32) NOT NULL DEFAULT 'PENDING',
    output_key VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    encoding_profile_version VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    attempts SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    priority SMALLINT NOT NULL DEFAULT 0,
    error_code VARCHAR(64),
    error_message TEXT,
    queued_at TIMESTAMP(6),
    started_at TIMESTAMP(6),
    finished_at TIMESTAMP(6),
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_clip_jobs_status CHECK (
        status IN ('PENDING', 'QUEUED', 'GENERATING', 'READY', 'FAILED', 'RETIRED')
    ),
    CONSTRAINT fk_clip_jobs_performance
        FOREIGN KEY (performance_id) REFERENCES performances(id) ON DELETE RESTRICT,
    UNIQUE KEY uq_clip_jobs_output_key (output_key(255)),
    INDEX idx_clip_jobs_queue (status, priority, queued_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE clip_assets (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    performance_id INT NOT NULL,
    clip_job_id BIGINT UNSIGNED NOT NULL,
    status VARCHAR(32) NOT NULL DEFAULT 'PENDING',
    storage_path VARCHAR(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    encoding_profile_version VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    file_size BIGINT UNSIGNED,
    duration_ms INT UNSIGNED,
    sha256 CHAR(64) CHARACTER SET ascii COLLATE ascii_bin,
    ffprobe_result JSON,
    range_verified BOOLEAN NOT NULL DEFAULT FALSE,
    is_current BOOLEAN NOT NULL DEFAULT FALSE,
    current_performance_id INT GENERATED ALWAYS AS (
        CASE WHEN is_current THEN performance_id ELSE NULL END
    ) STORED,
    generated_at TIMESTAMP(6),
    published_at TIMESTAMP(6),
    retired_at TIMESTAMP(6),
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT chk_clip_assets_status CHECK (
        status IN ('PENDING', 'QUEUED', 'GENERATING', 'READY', 'PUBLISHED', 'FAILED', 'RETIRED')
    ),
    CONSTRAINT chk_clip_assets_duration CHECK (
        duration_ms IS NULL OR (duration_ms > 0 AND duration_ms <= 600000)
    ),
    CONSTRAINT chk_clip_assets_ready CHECK (
        status NOT IN ('READY', 'PUBLISHED')
        OR (
            file_size IS NOT NULL AND file_size > 0
            AND duration_ms IS NOT NULL
            AND sha256 IS NOT NULL
            AND ffprobe_result IS NOT NULL
            AND range_verified = TRUE
        )
    ),
    CONSTRAINT chk_clip_assets_current CHECK (
        is_current = FALSE OR status IN ('READY', 'PUBLISHED')
    ),
    CONSTRAINT fk_clip_assets_performance
        FOREIGN KEY (performance_id) REFERENCES performances(id) ON DELETE RESTRICT,
    CONSTRAINT fk_clip_assets_job
        FOREIGN KEY (clip_job_id) REFERENCES clip_jobs(id) ON DELETE RESTRICT,
    UNIQUE KEY uq_clip_assets_storage_path (storage_path(255)),
    UNIQUE KEY uq_clip_assets_current_performance (current_performance_id),
    INDEX idx_clip_assets_status (status),
    INDEX idx_clip_assets_performance (performance_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
