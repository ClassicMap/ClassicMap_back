-- 묶음 작품 part API 통합 테스트용 최소 표. 조회가 읽는 열과 운영 표의 NOT NULL 열만 둔다.
-- 옛 백업에 전체 migration 을 얹으면 202608050219 가 실데이터에 기대 실패해서 따로 둔다.
-- piece_parts 는 202608050001 의 정의에서 source_records FK 만 빼고 그대로 두어 새 migration 을 그 위에 얹는다.
-- composers·pieces 의 hidden_reason 은 표에 두지 않고 202610120035 migration 으로 얹어 migration 도 함께 검증한다.
CREATE TABLE composers (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100) NOT NULL, full_name VARCHAR(200) NOT NULL,
  english_name VARCHAR(200) NOT NULL, period VARCHAR(16) NOT NULL, tier VARCHAR(1) NULL DEFAULT 'B', birth_year INT NOT NULL,
  death_year INT NULL, nationality VARCHAR(50) NOT NULL, avatar_url VARCHAR(500) NULL, cover_image_url VARCHAR(500) NULL,
  bio TEXT NULL, style TEXT NULL, influence TEXT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE pieces (id INT AUTO_INCREMENT PRIMARY KEY, composer_id INT NOT NULL, title VARCHAR(300) NOT NULL,
  title_en VARCHAR(300) NULL, type VARCHAR(16) NOT NULL DEFAULT 'song', description TEXT NULL, opus_number VARCHAR(50) NULL,
  composition_year INT NULL, difficulty_level INT NULL, duration_minutes INT NULL, spotify_url VARCHAR(500) NULL,
  apple_music_url VARCHAR(500) NULL, youtube_music_url VARCHAR(500) NULL, catalogue_system VARCHAR(64) NULL,
  catalogue_number VARCHAR(100) NULL,
  CONSTRAINT fk_pieces_composer FOREIGN KEY (composer_id) REFERENCES composers(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE composer_major_pieces (id INT AUTO_INCREMENT PRIMARY KEY, composer_id INT NOT NULL, piece_id INT NOT NULL,
  display_order INT DEFAULT 0) ENGINE=InnoDB;
CREATE VIEW v_composers_full AS
  SELECT c.id, c.name, c.full_name, c.english_name, c.period, c.tier, c.birth_year, c.death_year, c.nationality,
         c.avatar_url, c.cover_image_url, c.bio, c.style, c.influence,
         GROUP_CONCAT(DISTINCT CONCAT(p.id, ':', p.title) ORDER BY cmp.display_order SEPARATOR '|') AS major_pieces
  FROM composers c
  LEFT JOIN composer_major_pieces cmp ON c.id = cmp.composer_id
  LEFT JOIN pieces p ON cmp.piece_id = p.id
  GROUP BY c.id;
CREATE TABLE piece_aliases (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, piece_id INT NOT NULL,
  alias_value VARCHAR(500) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
    CONSTRAINT fk_piece_parts_piece
        FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    CONSTRAINT fk_piece_parts_parent
        FOREIGN KEY (parent_part_id, piece_id)
        REFERENCES piece_parts(id, piece_id) ON DELETE CASCADE,
    UNIQUE KEY uq_piece_parts_piece_key (piece_id, part_key),
    UNIQUE KEY uq_piece_parts_id_piece (id, piece_id),
    INDEX idx_piece_parts_order (piece_id, parent_part_id, sequence_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE artists (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100) NOT NULL, english_name VARCHAR(200) NOT NULL,
  category VARCHAR(50) NOT NULL, nationality VARCHAR(50) NOT NULL, image_url VARCHAR(500) NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE performance_sectors (id INT AUTO_INCREMENT PRIMARY KEY, piece_id INT NOT NULL, sector_name VARCHAR(200) NOT NULL,
  editorial_status VARCHAR(32) NOT NULL DEFAULT 'DISCOVERED') ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE performance_sources (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, provider VARCHAR(32) NOT NULL,
  provider_video_id VARCHAR(255) NOT NULL) ENGINE=InnoDB;
CREATE TABLE performance_credits (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, performance_source_id BIGINT UNSIGNED NOT NULL,
  artist_id INT NOT NULL, role_code VARCHAR(64) NOT NULL, is_primary BOOLEAN NOT NULL DEFAULT FALSE) ENGINE=InnoDB;
CREATE TABLE performances (id INT AUTO_INCREMENT PRIMARY KEY, piece_id INT NOT NULL, sector_id INT NOT NULL, artist_id INT NOT NULL,
  video_id VARCHAR(100) NOT NULL, performance_source_id BIGINT UNSIGNED NULL, start_ms INT UNSIGNED NULL, end_ms INT UNSIGNED NULL,
  publish_status VARCHAR(32) NOT NULL DEFAULT 'PUBLISHED') ENGINE=InnoDB;
CREATE TABLE clip_jobs (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, performance_id INT NOT NULL, status VARCHAR(32) NOT NULL,
  output_key VARCHAR(500) NOT NULL, encoding_profile_version VARCHAR(64) NOT NULL) ENGINE=InnoDB;
CREATE TABLE clip_assets (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, performance_id INT NOT NULL,
  clip_job_id BIGINT UNSIGNED NOT NULL, status VARCHAR(32) NOT NULL, storage_path VARCHAR(1000) NOT NULL,
  public_url VARCHAR(1000) NULL, encoding_profile_version VARCHAR(64) NOT NULL, file_size BIGINT UNSIGNED NULL,
  duration_ms INT UNSIGNED NULL, sha256 CHAR(64) NULL, ffprobe_result JSON NULL,
  range_verified BOOLEAN NOT NULL DEFAULT FALSE, is_current BOOLEAN NOT NULL DEFAULT FALSE) ENGINE=InnoDB;
