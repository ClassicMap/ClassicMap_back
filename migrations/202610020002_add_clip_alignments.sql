-- 정렬 지도: 같은 구간의 연주를 기준 연주에 맞춰 둔 같은 지점 표.
-- scripts/build_alignment_maps.py 가 만들고 load_clip_alignments 가 넣는다.
-- 기준 클립의 step_ms 마다 이 클립의 같은 지점(ms)을 positions_ms 에 둔다. 기준 클립 자신은 그대로다.
-- 두 클립의 해시가 지금 클립과 같고 비용이 임계 안일 때만 API 가 내보낸다. 아니면 화면은 비율로 맞춘다.

CREATE TABLE clip_alignments (
    clip_asset_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    reference_clip_asset_id BIGINT UNSIGNED NOT NULL,
    -- 'chroma-dtw-v1'. 맞추는 방식이 바뀌면 올린다
    analyzer_version VARCHAR(32) NOT NULL,
    clip_sha256 CHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    reference_clip_sha256 CHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    step_ms SMALLINT UNSIGNED NOT NULL,
    duration_ms INT UNSIGNED NOT NULL,
    reference_duration_ms INT UNSIGNED NOT NULL,
    -- 기준 클립 step_ms 마다 이 클립의 시점(ms). 늘 커지거나 같다
    positions_ms JSON NOT NULL,
    -- DTW 경로 길이로 나눈 남은 거리(코사인). 클수록 덜 맞는다
    cost DECIMAL(5,4) NOT NULL,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_clip_alignments_clip
        FOREIGN KEY (clip_asset_id) REFERENCES clip_assets(id) ON DELETE CASCADE,
    CONSTRAINT fk_clip_alignments_reference
        FOREIGN KEY (reference_clip_asset_id) REFERENCES clip_assets(id) ON DELETE CASCADE,
    CONSTRAINT chk_clip_alignments_positions
        CHECK (JSON_TYPE(positions_ms) = 'ARRAY'),
    CONSTRAINT chk_clip_alignments_step
        CHECK (step_ms > 0),
    CONSTRAINT chk_clip_alignments_cost
        CHECK (cost >= 0),
    INDEX idx_clip_alignments_reference (reference_clip_asset_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
