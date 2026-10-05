-- 영화 속 클래식 통합 테스트용 최소 표. 운영 표 중 적재기·조회가 읽는 열만 둔다.
-- 옛 백업에 전체 migration 을 얹으면 202608050219 가 실데이터에 기대 실패해서 따로 둔다.
CREATE TABLE composers (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE pieces (id INT AUTO_INCREMENT PRIMARY KEY, composer_id INT NOT NULL, title VARCHAR(300) NOT NULL,
  spotify_url VARCHAR(500) NULL, apple_music_url VARCHAR(500) NULL, youtube_music_url VARCHAR(500) NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE performance_sectors (id INT AUTO_INCREMENT PRIMARY KEY, piece_id INT NOT NULL, sector_name VARCHAR(200) NOT NULL,
  sector_key VARCHAR(150) NULL, display_order INT NULL, editorial_status VARCHAR(32) NOT NULL DEFAULT 'PUBLISHED', name_ko VARCHAR(200) NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE performances (id INT AUTO_INCREMENT PRIMARY KEY, sector_id INT NOT NULL, piece_id INT NOT NULL, performance_source_id BIGINT NULL,
  start_ms INT NULL, end_ms INT NULL, publish_status VARCHAR(32) NOT NULL DEFAULT 'PUBLISHED') ENGINE=InnoDB;
CREATE TABLE clip_assets (id INT AUTO_INCREMENT PRIMARY KEY, performance_id INT NOT NULL, is_current BOOLEAN NOT NULL, status VARCHAR(32) NOT NULL, public_url VARCHAR(500) NULL) ENGINE=InnoDB;
CREATE TABLE performance_credits (id INT AUTO_INCREMENT PRIMARY KEY, performance_source_id BIGINT NOT NULL, artist_id INT NOT NULL, is_primary BOOLEAN NOT NULL) ENGINE=InnoDB;
INSERT INTO composers (id, name) VALUES (16, '하이든');
INSERT INTO pieces (id, composer_id, title) VALUES (88, 16, '트럼펫 협주곡 E♭장조');
