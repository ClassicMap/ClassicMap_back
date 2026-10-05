-- 계정을 지운 뒤에도 그 계정의 세션 토큰은 만료(1분 안팎)까지 유효하다.
-- 그 사이 들어온 요청이 사용자 행을 다시 만들지 않게, 지운 계정과 지운 시각을 잠깐 남긴다.
-- 지운 시각보다 먼저 발급된 토큰으로는 행을 만들지 않는다. 하루 지난 기록은 다음 삭제 때 지운다.

CREATE TABLE deleted_accounts (
    clerk_id VARCHAR(100) NOT NULL PRIMARY KEY,
    deleted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_deleted_accounts_time (deleted_at)
);
