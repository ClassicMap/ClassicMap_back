-- 추천에 쓰는 작품 속성. 비교할 수 있는 작품마다 한 줄이다.
-- seed_pipeline/curation/<RUN>/features.jsonl 을 load_piece_reco_features 가 넣는다.
-- 처음 값은 큐레이션 초안(DRAFT)이고, 사람이 확인하면 CONFIRMED 로 바꾼다. 추천은 둘 다 쓴다.

CREATE TABLE piece_reco_features (
    piece_id INT NOT NULL PRIMARY KEY,
    -- 주인공 소리. 온보딩 '어떤 소리에 끌려요' 답과 맞춘다
    -- piano / orchestra / strings(바이올린·첼로·기타 등) / winds / voice / ensemble
    lead_sound VARCHAR(16) NOT NULL,
    -- 편성 규모. solo(혼자 또는 반주와 둘) / chamber(작은 앙상블) / large(오케스트라·합창)
    ensemble_scale VARCHAR(16) NOT NULL,
    -- 친숙도. everyone(누구나 아는 곡) / known(들어 본 곡) / deep(애호가 곡)
    familiarity VARCHAR(16) NOT NULL,
    -- 처음 듣는 사람에게 먼저 열 구간. 비우면 화면의 기본 구간을 쓴다
    start_sector_id INT NULL,
    -- 온보딩 '아는 곡' 카드 순서. 비우면 카드에 나오지 않는다. 겹치지 않는지는 적재기가 본다
    onboarding_order SMALLINT UNSIGNED NULL,
    review_status VARCHAR(16) NOT NULL DEFAULT 'DRAFT',
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_piece_reco_features_piece
        FOREIGN KEY (piece_id) REFERENCES pieces(id) ON DELETE CASCADE,
    CONSTRAINT fk_piece_reco_features_start_sector
        FOREIGN KEY (start_sector_id) REFERENCES performance_sectors(id) ON DELETE SET NULL,
    CONSTRAINT chk_piece_reco_features_lead_sound
        CHECK (lead_sound IN ('piano', 'orchestra', 'strings', 'winds', 'voice', 'ensemble')),
    CONSTRAINT chk_piece_reco_features_scale
        CHECK (ensemble_scale IN ('solo', 'chamber', 'large')),
    CONSTRAINT chk_piece_reco_features_familiarity
        CHECK (familiarity IN ('everyone', 'known', 'deep')),
    CONSTRAINT chk_piece_reco_features_review
        CHECK (review_status IN ('DRAFT', 'CONFIRMED'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
