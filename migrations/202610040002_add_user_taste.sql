-- 사용자 취향. 온보딩 답과 설정 '내 취향'이 여기에 저장된다.
-- 예전에는 기기 저장소에만 있었고 users.favorite_era 는 쓰이지 않았다.

CREATE TABLE user_taste_profiles (
    user_id INT NOT NULL PRIMARY KEY,
    -- 클래식을 얼마나 듣는지. new / some / often / player(직접 연주)
    listening_level VARCHAR(16) NULL,
    -- 끌리는 소리. ["piano", "strings"] 처럼 piece_reco_features.lead_sound 값 중에서
    sounds JSON NOT NULL,
    -- 직접 연주하는 악기. listening_level = player 일 때만
    instrument VARCHAR(16) NULL,
    -- 좋아하는 시대. 온보딩에서는 묻지 않고 설정에서만 고른다
    favorite_periods JSON NOT NULL,
    -- 온보딩을 끝냈는지(completed) 건너뛰었는지(skipped). 비어 있으면 아직 안 봤다
    onboarding_status VARCHAR(16) NULL,
    onboarding_version SMALLINT UNSIGNED NULL,
    onboarding_at TIMESTAMP(6) NULL,
    -- 들은 기록을 모아 추천에 쓸지. 설정에서 끈다
    history_enabled BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_user_taste_profiles_user
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT chk_user_taste_profiles_level
        CHECK (listening_level IS NULL OR listening_level IN ('new', 'some', 'often', 'player')),
    CONSTRAINT chk_user_taste_profiles_sounds
        CHECK (JSON_TYPE(sounds) = 'ARRAY'),
    CONSTRAINT chk_user_taste_profiles_periods
        CHECK (JSON_TYPE(favorite_periods) = 'ARRAY'),
    CONSTRAINT chk_user_taste_profiles_onboarding
        CHECK (onboarding_status IS NULL OR onboarding_status IN ('completed', 'skipped'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 온보딩 '아는 곡'에서 고른 작품
CREATE TABLE user_taste_seed_pieces (
    user_id INT NOT NULL,
    piece_id INT NOT NULL,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (user_id, piece_id),
    CONSTRAINT fk_user_taste_seed_pieces_user
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_taste_seed_pieces_piece
        FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
