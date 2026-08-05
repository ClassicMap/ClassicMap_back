-- global-seed-v1 JSONL의 natural key를 실제 MySQL PK와 결정적으로 연결한다.
-- 자연 키 원문과 SHA-256을 함께 보존해 해시 충돌을 자동 병합하지 않는다.

CREATE TABLE seed_natural_keys (
    target_table VARCHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    natural_key_sha256 CHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    natural_key VARCHAR(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    target_id VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    record_fingerprint CHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    first_seed_run_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    last_seed_run_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (target_table, natural_key_sha256),
    CONSTRAINT fk_seed_natural_keys_first_run
        FOREIGN KEY (first_seed_run_id) REFERENCES seed_runs(id) ON DELETE RESTRICT,
    CONSTRAINT fk_seed_natural_keys_last_run
        FOREIGN KEY (last_seed_run_id) REFERENCES seed_runs(id) ON DELETE RESTRICT,
    INDEX idx_seed_natural_keys_target (target_table, target_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
