
-- ClassicMap 데이터베이스 스키마
-- MariaDB 10.5+

-- 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS classicmap CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE classicmap;

-- ============================================
-- 기존 테이블 및 뷰 삭제
-- ============================================
DROP VIEW IF EXISTS v_pieces_with_performances;
DROP VIEW IF EXISTS v_concerts_full;
DROP VIEW IF EXISTS v_artists_full;
DROP VIEW IF EXISTS v_composers_full;

DROP TABLE IF EXISTS popular_comparisons;
DROP TABLE IF EXISTS user_favorite_pieces;
DROP TABLE IF EXISTS user_favorite_artists;
DROP TABLE IF EXISTS user_favorite_composers;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS performances;
DROP TABLE IF EXISTS concert_artists;
DROP TABLE IF EXISTS concerts;
DROP TABLE IF EXISTS venues;
DROP TABLE IF EXISTS recordings;
DROP TABLE IF EXISTS artist_awards;
DROP TABLE IF EXISTS artist_specialties;
DROP TABLE IF EXISTS artists;
DROP TABLE IF EXISTS composer_major_pieces;
DROP TABLE IF EXISTS pieces;
DROP TABLE IF EXISTS composers;

-- ============================================
-- 1. 작곡가 (Composers) 테이블
-- ============================================
CREATE TABLE composers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL COMMENT '한글명',
    full_name VARCHAR(200) NOT NULL COMMENT '전체 한글명',
    english_name VARCHAR(200) NOT NULL COMMENT '영문명',
    period ENUM('바로크', '고전주의', '낭만주의', '근현대') NOT NULL COMMENT '시대',
    tier ENUM('S', 'A', 'B', 'C') DEFAULT 'B' COMMENT '티어',
    birth_year INT NOT NULL,
    death_year INT,
    nationality VARCHAR(50) NOT NULL COMMENT '국적',
    image_url VARCHAR(500) COMMENT '프로필 이미지 URL',
    avatar_url VARCHAR(500) COMMENT '아바타 이미지 URL',
    cover_image_url VARCHAR(500) COMMENT '커버 이미지 URL',
    bio TEXT COMMENT '소개',
    style TEXT COMMENT '음악 스타일',
    influence TEXT COMMENT '영향력',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_period (period),
    INDEX idx_tier (tier),
    INDEX idx_birth_year (birth_year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 2. 곡 (Pieces) 테이블
-- ============================================
CREATE TABLE pieces (
    id INT AUTO_INCREMENT PRIMARY KEY,
    composer_id INT NOT NULL,
    title VARCHAR(300) NOT NULL COMMENT '곡 제목',
    description TEXT COMMENT '곡 설명',
    opus_number VARCHAR(50) COMMENT 'Opus 번호',
    composition_year INT COMMENT '작곡 연도',
    difficulty_level INT COMMENT '난이도 (1-10)',
    duration_minutes INT COMMENT '연주 시간 (분)',
    spotify_url VARCHAR(500) COMMENT 'Spotify 링크',
    apple_music_url VARCHAR(500) COMMENT 'Apple Music 링크',
    youtube_music_url VARCHAR(500) COMMENT 'YouTube Music 링크',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (composer_id) REFERENCES composers(id) ON DELETE CASCADE,
    INDEX idx_composer_id (composer_id),
    INDEX idx_difficulty_level (difficulty_level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 3. 작곡가 주요 곡 연결 (Composer Major Pieces) 테이블
-- ============================================
CREATE TABLE composer_major_pieces (
    id INT AUTO_INCREMENT PRIMARY KEY,
    composer_id INT NOT NULL,
    piece_id INT NOT NULL,
    display_order INT DEFAULT 0 COMMENT '표시 순서',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (composer_id) REFERENCES composers(id) ON DELETE CASCADE,
    FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    UNIQUE KEY unique_composer_piece (composer_id, piece_id),
    INDEX idx_composer_id (composer_id),
    INDEX idx_piece_id (piece_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 4. 아티스트/연주자 (Artists) 테이블
-- ============================================
CREATE TABLE artists (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL COMMENT '한글명',
    english_name VARCHAR(200) NOT NULL COMMENT '영문명',
    category VARCHAR(50) NOT NULL COMMENT '악기/분야 (피아니스트, 바이올리니스트 등)',
    tier ENUM('S', 'A', 'B', 'Rising') NOT NULL DEFAULT 'B' COMMENT '티어',
    rating DECIMAL(2,1) DEFAULT 0.0 COMMENT '평점 (0.0-5.0)',
    image_url VARCHAR(500) COMMENT '프로필 이미지 URL',
    cover_image_url VARCHAR(500) COMMENT '커버 이미지 URL',
    birth_year VARCHAR(10) COMMENT '출생연도',
    nationality VARCHAR(50) NOT NULL COMMENT '국적',
    bio TEXT COMMENT '소개',
    style TEXT COMMENT '연주 스타일',
    concert_count INT DEFAULT 0 COMMENT '공연 횟수',
    country_count INT DEFAULT 0 COMMENT '공연 국가 수',
    album_count INT DEFAULT 0 COMMENT '음반 수',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_tier (tier),
    INDEX idx_rating (rating)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 5. 아티스트 전문 분야 (Artist Specialties) 테이블
-- ============================================
CREATE TABLE artist_specialties (
    id INT AUTO_INCREMENT PRIMARY KEY,
    artist_id INT NOT NULL,
    specialty VARCHAR(100) NOT NULL COMMENT '전문 작곡가/레퍼토리',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE,
    INDEX idx_artist_id (artist_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 6. 아티스트 수상 내역 (Artist Awards) 테이블
-- ============================================
CREATE TABLE artist_awards (
    id INT AUTO_INCREMENT PRIMARY KEY,
    artist_id INT NOT NULL,
    year VARCHAR(10) NOT NULL COMMENT '수상 연도',
    award_name VARCHAR(300) NOT NULL COMMENT '상 이름',
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE,
    INDEX idx_artist_id (artist_id),
    INDEX idx_year (year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 7. 음반 (Recordings) 테이블
-- ============================================
CREATE TABLE recordings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    artist_id INT NOT NULL,
    title VARCHAR(300) NOT NULL COMMENT '음반 제목',
    year VARCHAR(10) NOT NULL COMMENT '발매 연도',
    label VARCHAR(100) COMMENT '레이블',
    cover_url VARCHAR(500) COMMENT '커버 이미지 URL',
    spotify_url VARCHAR(500) COMMENT 'Spotify 링크',
    apple_music_url VARCHAR(500) COMMENT 'Apple Music 링크',
    youtube_music_url VARCHAR(500) COMMENT 'YouTube Music 링크',
    external_url VARCHAR(500) COMMENT '기타 외부 링크',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE,
    INDEX idx_artist_id (artist_id),
    INDEX idx_year (year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 8. 공연장 (Venues) 테이블
-- ============================================
CREATE TABLE venues (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL COMMENT '공연장명',
    address VARCHAR(500) COMMENT '주소',
    city VARCHAR(100) COMMENT '도시',
    country VARCHAR(50) COMMENT '국가',
    capacity INT COMMENT '수용 인원',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_city (city)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 9. 공연 (Concerts) 테이블
-- ============================================
CREATE TABLE concerts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(300) NOT NULL COMMENT '공연 제목',
    composer_info TEXT COMMENT '작곡가/곡목',
    venue_id INT NOT NULL COMMENT '공연장 ID',
    concert_date DATE NOT NULL COMMENT '공연 날짜',
    concert_time TIME COMMENT '공연 시간',
    price_info VARCHAR(200) COMMENT '가격 정보',
    poster_url VARCHAR(500) COMMENT '포스터 이미지 URL',
    program TEXT COMMENT '프로그램 상세',
    ticket_url VARCHAR(500) COMMENT '예매 링크',
    status ENUM('upcoming', 'ongoing', 'completed', 'cancelled') DEFAULT 'upcoming',
    rating DECIMAL(2,1) DEFAULT 0.0 COMMENT '평균 평점 (0.0-5.0)',
    rating_count INT DEFAULT 0 COMMENT '평점 개수',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (venue_id) REFERENCES venues(id) ON DELETE RESTRICT,
    INDEX idx_concert_date (concert_date),
    INDEX idx_status (status),
    INDEX idx_rating (rating)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 10. 공연-아티스트 연결 (Concert Artists) 테이블
-- ============================================
CREATE TABLE concert_artists (
    id INT AUTO_INCREMENT PRIMARY KEY,
    concert_id INT NOT NULL,
    artist_id INT NOT NULL,
    role VARCHAR(100) COMMENT '역할 (solo, conductor, ensemble 등)',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (concert_id) REFERENCES concerts(id) ON DELETE CASCADE,
    FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE,
    INDEX idx_concert_id (concert_id),
    INDEX idx_artist_id (artist_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 11. 연주 영상 (Performances) 테이블
-- ============================================
CREATE TABLE performances (
    id INT AUTO_INCREMENT PRIMARY KEY,
    piece_id INT NOT NULL,
    artist_id INT NOT NULL,
    video_platform ENUM('youtube', 'vimeo', 'other') DEFAULT 'youtube',
    video_id VARCHAR(100) NOT NULL COMMENT '플랫폼별 비디오 ID',
    start_time INT DEFAULT 0 COMMENT '시작 시간 (초)',
    end_time INT DEFAULT 0 COMMENT '종료 시간 (초)',
    characteristic TEXT COMMENT '연주 특징',
    recording_date DATE COMMENT '녹음/녹화 날짜',
    view_count INT DEFAULT 0 COMMENT '조회수',
    rating DECIMAL(2,1) DEFAULT 0.0 COMMENT '평점',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE,
    INDEX idx_piece_id (piece_id),
    INDEX idx_artist_id (artist_id),
    INDEX idx_rating (rating)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 12. 사용자 (Users) 테이블 - Clerk 연동용 추가 프로필
-- ============================================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    clerk_id VARCHAR(100) UNIQUE NOT NULL COMMENT 'Clerk User ID',
    email VARCHAR(255) NOT NULL,
    role ENUM('user', 'moderator', 'admin') NOT NULL DEFAULT 'user' COMMENT '권한: 사용자, 중간관리자, 관리자',
    is_first_visit BOOLEAN DEFAULT TRUE COMMENT '처음 방문 여부',
    favorite_era VARCHAR(50) COMMENT '선호 시대',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_clerk_id (clerk_id),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 13. 사용자 즐겨찾기 - 작곡가 (User Favorite Composers)
-- ============================================
CREATE TABLE user_favorite_composers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    composer_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (composer_id) REFERENCES composers(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_composer (user_id, composer_id),
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 14. 사용자 즐겨찾기 - 아티스트 (User Favorite Artists)
-- ============================================
CREATE TABLE user_favorite_artists (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    artist_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_artist (user_id, artist_id),
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 15. 사용자 즐겨찾기 - 곡 (User Favorite Pieces)
-- ============================================
CREATE TABLE user_favorite_pieces (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    piece_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_piece (user_id, piece_id),
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 16. 인기 비교 (Popular Comparisons) 테이블
-- ============================================
CREATE TABLE popular_comparisons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    piece_id INT NOT NULL,
    comparison_title VARCHAR(300) NOT NULL COMMENT '비교 제목 (예: 아르헤리치 vs 임윤찬)',
    view_count INT DEFAULT 0 COMMENT '조회수',
    is_featured BOOLEAN DEFAULT FALSE COMMENT '메인 노출 여부',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    INDEX idx_view_count (view_count),
    INDEX idx_featured (is_featured)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 17. 사용자 공연 평점 (User Concert Ratings) 테이블
-- ============================================
CREATE TABLE user_concert_ratings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    concert_id INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL COMMENT '평점 (0.0-5.0)',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (concert_id) REFERENCES concerts(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_concert (user_id, concert_id),
    INDEX idx_user_id (user_id),
    INDEX idx_concert_id (concert_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 샘플 데이터 삽입
-- ============================================

-- 공연장 샘플 데이터
INSERT INTO venues (name, city, country, capacity) VALUES
('롯데콘서트홀', '서울', '대한민국', 2036),
('예술의전당 콘서트홀', '서울', '대한민국', 2600),
('세종문화회관', '서울', '대한민국', 3822);

-- 작곡가 샘플 데이터
INSERT INTO composers (name, full_name, english_name, period, birth_year, death_year, nationality, bio, style, influence) VALUES
('바흐', '요한 제바스티안 바흐', 'Johann Sebastian Bach', '바로크', 1685, 1750, '독일',
 '바로크 시대의 가장 위대한 작곡가 중 한 명. 대위법의 대가로, 종교 음악과 기악 음악 모든 분야에서 뛰어난 작품을 남겼습니다.',
 '정교한 대위법, 깊은 종교성, 수학적 구조미',
 '모차르트, 베토벤, 멘델스존 등 후대 작곡가들에게 지대한 영향'),

('모차르트', '볼프강 아마데우스 모차르트', 'Wolfgang Amadeus Mozart', '고전주의', 1756, 1791, '오스트리아',
 '천재 음악가의 대명사. 35년이라는 짧은 생애 동안 600곡이 넘는 작품을 남겼으며, 오페라, 교향곡, 협주곡 모든 분야에서 걸작을 창조했습니다.',
 '완벽한 형식미, 맑고 우아한 선율, 균형잡힌 구조',
 '고전주의 음악의 정점, 베토벤과 슈베르트에게 큰 영향'),

('쇼팽', '프레데리크 쇼팽', 'Frédéric Chopin', '낭만주의', 1810, 1849, '폴란드',
 '피아노의 시인. 거의 모든 작품을 피아노를 위해 작곡했으며, 피아노 음악의 가능성을 극대화한 작곡가입니다.',
 '서정적 선율, 섬세한 화성, 폴란드 민족 정서',
 '피아노 음악의 혁명, 리스트, 드뷔시 등에게 영향');

-- 곡 샘플 데이터
INSERT INTO pieces (composer_id, title, description, opus_number, composition_year) VALUES
(1, '마태 수난곡', '바흐의 대표적인 종교 음악 작품', 'BWV 244', 1727),
(1, '브란덴부르크 협주곡', '6곡으로 이루어진 협주곡 모음', 'BWV 1046-1051', 1721),
(1, '골드베르크 변주곡', '30개의 변주로 이루어진 피아노 작품', 'BWV 988', 1741),
(2, '피가로의 결혼', '모차르트의 대표 오페라', 'K. 492', 1786),
(2, '돈 조반니', '드라마 지오코소 오페라', 'K. 527', 1787),
(2, '교향곡 40번', '모차르트의 대표적인 교향곡', 'K. 550', 1788),
(3, '발라드 1번', '쇼팽의 첫 번째 발라드', 'Op. 23', 1835),
(3, '녹턴 작품 9-2', '쇼팽의 가장 유명한 녹턴', 'Op. 9 No. 2', 1832),
(3, '에튀드 작품 10, 25', '쇼팽의 혁명적인 연습곡', 'Op. 10, Op. 25', 1833);

-- 작곡가 주요 곡 연결
INSERT INTO composer_major_pieces (composer_id, piece_id, display_order) VALUES
(1, 1, 1),
(1, 2, 2),
(1, 3, 3),
(2, 4, 1),
(2, 5, 2),
(2, 6, 3),
(3, 7, 1),
(3, 8, 2),
(3, 9, 3);

-- 아티스트 샘플 데이터
INSERT INTO artists (name, english_name, category, tier, rating, nationality, bio, style, concert_count, country_count, album_count) VALUES
('조성진', 'Seong-Jin Cho', '피아니스트', 'S', 4.9, '대한민국',
 '2015년 쇼팽 콩쿠르 우승자로, 섬세하고 깊이 있는 해석으로 전 세계 클래식 음악 팬들의 사랑을 받고 있습니다.',
 '섬세하고 시적인 표현, 명료한 터치, 깊이 있는 음악성',
 120, 35, 8),

('임윤찬', 'Yunchan Lim', '피아니스트', 'Rising', 4.8, '대한민국',
 '2022년 반 클라이번 콩쿠르 최연소 우승자. 압도적인 기교와 깊은 음악성으로 세계를 놀라게 한 신성입니다.',
 '압도적 기교, 성숙한 음악성, 깊이 있는 해석',
 50, 15, 2);

-- 아티스트 전문 분야
INSERT INTO artist_specialties (artist_id, specialty) VALUES
(1, '쇼팽'),
(1, '드뷔시'),
(1, '라벨'),
(2, '라흐마니노프'),
(2, '베토벤'),
(2, '리스트');

-- 아티스트 수상 내역
INSERT INTO artist_awards (artist_id, year, award_name, display_order) VALUES
(1, '2015', '쇼팽 국제 피아노 콩쿠르 1위', 1),
(1, '2011', '차이콥스키 국제 콩쿠르 3위', 2),
(2, '2022', '반 클라이번 국제 피아노 콩쿠르 1위', 1);


  -- ============================================
  -- 아티스트 앨범 (Recordings) 샘플 데이터
  -- ============================================

  -- 조성진 음반
  INSERT INTO recordings (artist_id, title, year, label, spotify_url, apple_music_url) VALUES
  (1, 'Chopin: Piano Concerto No.1', '2016', 'Deutsche Grammophon', 'https://open.spotify.com/album/...', 'https://music.apple.com/album/...'),
  (1, 'Chopin: Ballades & Scherzos', '2017', 'Deutsche Grammophon', 'https://open.spotify.com/album/...', 'https://music.apple.com/album/...'),
  (1, 'Debussy', '2019', 'Deutsche Grammophon', 'https://open.spotify.com/album/...', 'https://music.apple.com/album/...'),
  (1, 'Mozart: Piano Concertos Nos. 20 & 21', '2020', 'Deutsche Grammophon', 'https://open.spotify.com/album/...', 'https://music.apple.com/album/...'),
  (1, 'The Wanderer', '2021', 'Deutsche Grammophon', 'https://open.spotify.com/album/...', 'https://music.apple.com/album/...');

  -- 임윤찬 음반
  INSERT INTO recordings (artist_id, title, year, label, spotify_url, apple_music_url) VALUES
  (2, 'Cliburn 2022: Yunchan Lim', '2022', 'Decca', 'https://open.spotify.com/album/...', 'https://music.apple.com/album/...'),
  (2, 'Chopin: Etudes', '2023', 'Decca', 'https://open.spotify.com/album/...', 'https://music.apple.com/album/...'),
  (2, 'Liszt: Transcendental Etudes', '2024', 'Decca', 'https://open.spotify.com/album/...', 'https://music.apple.com/album/...');

  -- ============================================
  -- 공연-아티스트 연결 데이터
  -- ============================================

  -- 기존 공연에 아티스트 연결
  INSERT INTO concert_artists (concert_id, artist_id, role) VALUES
  (1, 1, 'solo'),      -- 조성진 피아노 리사이틀
  (3, 2, 'solo');      -- 임윤찬과 서울시향

  -- ============================================
  -- 추가 공연 샘플 데이터 (최근 공연 더 추가)
  -- ============================================

  INSERT INTO concerts (title, composer_info, venue_id, concert_date, concert_time, price_info, is_recommended, status) VALUES
  ('조성진 드뷔시 스페셜', '드뷔시, 라벨', 2, '2025-02-20', '19:30:00', '90,000원~', FALSE, 'upcoming'),
  ('임윤찬 베토벤 소나타 전곡', '베토벤 피아노 소나타', 1, '2025-06-15', '19:00:00', '120,000원~', TRUE, 'upcoming'),
  ('조성진 & 바이에른 방송교향악단', '모차르트 피아노 협주곡 23번', 3, '2024-12-10', '20:00:00', '150,000원~', FALSE, 'completed'),
  ('임윤찬 리사이틀', '라흐마니노프, 쇼팽', 2, '2024-11-05', '19:30:00', '100,000원~', FALSE, 'completed');

  -- 추가 공연에 아티스트 연결
  INSERT INTO concert_artists (concert_id, artist_id, role) VALUES
  (4, 1, 'solo'),      -- 조성진 드뷔시 스페셜
  (5, 2, 'solo'),      -- 임윤찬 베토벤 소나타 전곡
  (6, 1, 'solo'),      -- 조성진 & 바이에른 방송교향악단
  (7, 2, 'solo');      -- 임윤찬 리사이틀

-- ============================================
-- API용 뷰 (Views) 생성
-- ============================================

-- 작곡가 전체 정보 뷰 (주요 곡 포함)
CREATE VIEW v_composers_full AS
SELECT 
    c.*,
    GROUP_CONCAT(DISTINCT CONCAT(p.id, ':', p.title) ORDER BY cmp.display_order SEPARATOR '|') as major_pieces
FROM composers c
LEFT JOIN composer_major_pieces cmp ON c.id = cmp.composer_id
LEFT JOIN pieces p ON cmp.piece_id = p.id
GROUP BY c.id;

-- 아티스트 전체 정보 뷰
CREATE VIEW v_artists_full AS
SELECT 
    a.*,
    GROUP_CONCAT(DISTINCT s.specialty ORDER BY s.specialty SEPARATOR '|') as specialties,
    GROUP_CONCAT(DISTINCT CONCAT(aw.year, ':', aw.award_name) ORDER BY aw.display_order SEPARATOR '|') as awards
FROM artists a
LEFT JOIN artist_specialties s ON a.id = s.artist_id
LEFT JOIN artist_awards aw ON a.id = aw.artist_id
GROUP BY a.id;

-- 공연 전체 정보 뷰
CREATE VIEW v_concerts_full AS
SELECT 
    c.*,
    v.name as venue_name,
    v.city as venue_city,
    GROUP_CONCAT(DISTINCT a.name ORDER BY a.name SEPARATOR ', ') as artists
FROM concerts c
JOIN venues v ON c.venue_id = v.id
LEFT JOIN concert_artists ca ON c.id = ca.concert_id
LEFT JOIN artists a ON ca.artist_id = a.id
GROUP BY c.id;

-- 곡과 연주 정보 뷰
CREATE VIEW v_pieces_with_performances AS
SELECT 
    p.*,
    c.name as composer_name,
    c.period as composer_period,
    COUNT(DISTINCT perf.id) as performance_count
FROM pieces p
JOIN composers c ON p.composer_id = c.id
LEFT JOIN performances perf ON p.id = perf.piece_id
GROUP BY p.id;

