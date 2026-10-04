-- 들은 기록. 추천을 사용자에 맞게 고쳐 가는 데만 쓴다.
-- 작품을 열었는지(open), 연주를 끝까지 들었는지(finish), 몇 초 만에 넘겼는지(skip),
-- 추천 카드에서 관심 없음을 눌렀는지(not_interested)만 남긴다.
-- 설정에서 기록을 끄면 open·finish·skip 은 받지 않고, 지우면 모두 지운다. 탈퇴하면 같이 지워진다.

CREATE TABLE user_listening_events (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    piece_id INT NOT NULL,
    sector_id INT NULL,
    performance_id INT NULL,
    kind VARCHAR(16) NOT NULL,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_user_listening_events_user
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_listening_events_piece
        FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_listening_events_sector
        FOREIGN KEY (sector_id) REFERENCES performance_sectors(id) ON DELETE SET NULL,
    CONSTRAINT fk_user_listening_events_performance
        FOREIGN KEY (performance_id) REFERENCES performances(id) ON DELETE SET NULL,
    CONSTRAINT chk_user_listening_events_kind
        CHECK (kind IN ('open', 'finish', 'skip', 'not_interested')),
    INDEX idx_user_listening_events_user_time (user_id, created_at),
    INDEX idx_user_listening_events_user_piece (user_id, piece_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
