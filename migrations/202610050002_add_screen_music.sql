-- 영화 속 클래식. 영화·드라마·애니(영상 작품)와 그 안에서 쓰인 클래식 곡(큐)을 둔다.
-- 내용은 seed_pipeline/curation/screen-music-*/titles.jsonl 을 load_screen_music 으로 넣고,
-- 포스터·스틸 경로는 refresh_screen_images 가 TMDB 에서 받아 채운다(6개월 안에 다시 받음).

CREATE TABLE screen_titles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    -- 적재 입력의 자연 키. 영어 소문자-하이픈
    slug VARCHAR(100) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    -- MOVIE(실사 영화) · SERIES(드라마·실사 시리즈) · ANIME(애니 영화·시리즈·단편)
    kind VARCHAR(16) NOT NULL,
    title_ko VARCHAR(255) NOT NULL,
    title_original VARCHAR(255) NULL,
    release_year SMALLINT UNSIGNED NULL,
    country_code CHAR(2) CHARACTER SET ascii NULL,
    -- 감독이나 연출·방송사 한 줄
    credit_line VARCHAR(255) NULL,
    -- 모아 보는 화면의 순서. 작을수록 앞
    display_order INT NOT NULL,
    editorial_status VARCHAR(16) NOT NULL DEFAULT 'DRAFT',
    -- TMDB 이미지 파일 경로("/abc.jpg"). 적재기는 건드리지 않고 refresh_screen_images 만 쓴다
    poster_path VARCHAR(255) NULL,
    backdrop_path VARCHAR(255) NULL,
    -- 관리자가 장면 스틸을 고를 후보. ["/a.jpg", …]
    still_paths JSON NULL,
    images_fetched_at TIMESTAMP(6) NULL,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    UNIQUE KEY uq_screen_titles_slug (slug),
    INDEX idx_screen_titles_status_order (editorial_status, display_order),
    CONSTRAINT chk_screen_titles_kind CHECK (kind IN ('MOVIE', 'SERIES', 'ANIME')),
    CONSTRAINT chk_screen_titles_status CHECK (editorial_status IN ('DRAFT', 'PUBLISHED')),
    CONSTRAINT chk_screen_titles_stills CHECK (still_paths IS NULL OR JSON_TYPE(still_paths) = 'ARRAY')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 바깥 ID. piece_identifiers 와 같은 꼴.
-- wikidata · imdb · tmdb_movie · tmdb_tv · kmdb · anilist · musicbrainz_release_group
CREATE TABLE screen_title_identifiers (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    screen_title_id INT NOT NULL,
    namespace VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    external_id VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_screen_title_identifiers_title
        FOREIGN KEY (screen_title_id) REFERENCES screen_titles(id) ON DELETE CASCADE,
    UNIQUE KEY uq_screen_title_identifiers_value (namespace, external_id),
    UNIQUE KEY uq_screen_title_identifiers_title_namespace (screen_title_id, namespace)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 장면 하나에 쓰인 곡 하나 = 큐 하나
CREATE TABLE screen_music_cues (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    screen_title_id INT NOT NULL,
    -- 작품 안의 자연 키. 영어 소문자-하이픈
    cue_key VARCHAR(100) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    display_order SMALLINT UNSIGNED NOT NULL,
    -- 시리즈·애니 회차("S1E1", "E24", "여러 회"). 아는 경우만
    episode_label VARCHAR(32) NULL,
    composer_id INT NULL,
    composer_name VARCHAR(255) NOT NULL,
    -- 큐레이션 작품에만 붙인다. 카탈로그에 없는 곡이면 비워 두고 work_title 로만 보인다
    piece_id INT NULL,
    work_title VARCHAR(255) NOT NULL,
    -- 악장·곡·아리아 이름. '3악장 Finale. Allegro'
    part_label VARCHAR(255) NULL,
    -- 영화에 나온 대목과 같은 비교 구간. 다른 대목이면 비워 둔다
    sector_id INT NULL,
    -- SCORE(배경음악) · SOURCE(화면 속 음악) · PERFORMED(인물이 연주) · TITLES(오프닝·엔딩)
    usage_kind VARCHAR(16) NOT NULL,
    arranged BOOLEAN NOT NULL DEFAULT FALSE,
    approx_at_sec INT UNSIGNED NULL,
    scene_note VARCHAR(400) NOT NULL,
    spoiler BOOLEAN NOT NULL DEFAULT FALSE,
    -- 권리자 공식 YouTube 클립 {videoId, startSec, channel, title}
    official_clip JSON NULL,
    -- 근거 [{grade, kind, url, note}]
    evidence JSON NOT NULL,
    -- 관리자가 고른 장면 스틸(TMDB 파일 경로). 적재기는 건드리지 않는다
    still_path VARCHAR(255) NULL,
    editorial_status VARCHAR(16) NOT NULL DEFAULT 'DRAFT',
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_screen_music_cues_title
        FOREIGN KEY (screen_title_id) REFERENCES screen_titles(id) ON DELETE CASCADE,
    CONSTRAINT fk_screen_music_cues_composer
        FOREIGN KEY (composer_id) REFERENCES composers(id) ON DELETE SET NULL,
    CONSTRAINT fk_screen_music_cues_piece
        FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE SET NULL,
    CONSTRAINT fk_screen_music_cues_sector
        FOREIGN KEY (sector_id) REFERENCES performance_sectors(id) ON DELETE SET NULL,
    UNIQUE KEY uq_screen_music_cues_title_key (screen_title_id, cue_key),
    INDEX idx_screen_music_cues_piece (piece_id, editorial_status),
    CONSTRAINT chk_screen_music_cues_usage
        CHECK (usage_kind IN ('SCORE', 'SOURCE', 'PERFORMED', 'TITLES')),
    CONSTRAINT chk_screen_music_cues_status CHECK (editorial_status IN ('DRAFT', 'PUBLISHED')),
    CONSTRAINT chk_screen_music_cues_evidence CHECK (JSON_TYPE(evidence) = 'ARRAY'),
    CONSTRAINT chk_screen_music_cues_clip
        CHECK (official_clip IS NULL OR JSON_TYPE(official_clip) = 'OBJECT')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
