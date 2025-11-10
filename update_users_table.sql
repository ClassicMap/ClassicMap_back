-- users 테이블에 role과 is_first_visit 필드 추가

-- role 컬럼 추가 (기본값: user)
ALTER TABLE users 
ADD COLUMN role ENUM('user', 'moderator', 'admin') NOT NULL DEFAULT 'user' COMMENT '권한: 사용자, 중간관리자, 관리자' AFTER email;

-- is_first_visit 컬럼 추가 (기본값: TRUE)
ALTER TABLE users 
ADD COLUMN is_first_visit BOOLEAN DEFAULT TRUE COMMENT '처음 방문 여부' AFTER role;

-- role 인덱스 추가
ALTER TABLE users 
ADD INDEX idx_role (role);

-- 기존 유저들은 is_first_visit를 FALSE로 설정 (이미 가입된 유저이므로)
UPDATE users SET is_first_visit = FALSE WHERE created_at < NOW();
