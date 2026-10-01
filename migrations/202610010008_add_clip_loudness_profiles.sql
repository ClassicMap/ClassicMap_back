-- 클립 음량 곡선. 클립 파일마다 하나이고, 클립을 다시 만들면 다시 잰다.
-- scripts/measure_loudness.py 가 재고 load_loudness_profiles 가 넣는다.
-- 곡선은 EBU R128 단기 음량을 step_ms 간격으로 뽑아 가장 센 곳을 0dB 로 둔 상대값이다.
-- 녹음마다 전체 레벨이 크게 달라 절대값은 두지 않는다.
-- clip_sha256 은 잰 파일의 해시다. 지금 클립과 다르면 API 가 곡선을 내보내지 않는다.

CREATE TABLE clip_loudness_profiles (
    clip_asset_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    -- 'ebur128-short-v1'. 재는 방식이 바뀌면 올린다
    analyzer_version VARCHAR(32) NOT NULL,
    clip_sha256 CHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    step_ms SMALLINT UNSIGNED NOT NULL,
    duration_ms INT UNSIGNED NOT NULL,
    -- 가장 센 곳 = 0, 바닥 -60
    curve_rel_db JSON NOT NULL,
    -- 처음 5초 평균
    start_rel_db DECIMAL(4,1) NOT NULL,
    -- 가장 센 곳의 클립 안 시점과 진행률
    peak_ms INT UNSIGNED NOT NULL,
    peak_ratio DECIMAL(4,3) NOT NULL,
    -- 곡선 폭(90분위 - 10분위). 2 미만이면 평평해서 근거로 쓰지 않는다
    range_db DECIMAL(4,1) NOT NULL,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_loudness_profiles_clip
        FOREIGN KEY (clip_asset_id) REFERENCES clip_assets(id) ON DELETE CASCADE,
    CONSTRAINT chk_loudness_profiles_curve
        CHECK (JSON_TYPE(curve_rel_db) = 'ARRAY'),
    CONSTRAINT chk_loudness_profiles_step
        CHECK (step_ms > 0),
    CONSTRAINT chk_loudness_profiles_peak_ratio
        CHECK (peak_ratio BETWEEN 0 AND 1),
    CONSTRAINT chk_loudness_profiles_range
        CHECK (range_db >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
