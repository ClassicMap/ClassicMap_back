-- 검증 번들의 자산 메타데이터와 시드 실행 출처를 보존한다.
ALTER TABLE clip_jobs
    ADD COLUMN seed_run_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NULL AFTER performance_id,
    ADD CONSTRAINT fk_clip_jobs_seed_run
        FOREIGN KEY (seed_run_id) REFERENCES seed_runs(id) ON DELETE RESTRICT;

ALTER TABLE clip_assets
    ADD COLUMN seed_run_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NULL AFTER clip_job_id,
    ADD COLUMN asset_validated_at TIMESTAMP(6) NULL AFTER range_verified,
    ADD COLUMN range_verified_at TIMESTAMP(6) NULL AFTER asset_validated_at,
    ADD CONSTRAINT fk_clip_assets_seed_run
        FOREIGN KEY (seed_run_id) REFERENCES seed_runs(id) ON DELETE RESTRICT;

-- 하나의 물리 클립은 여러 performance가 공유할 수 있다. 논리 자산의 중복만 막는다.
ALTER TABLE clip_jobs
    DROP INDEX uq_clip_jobs_output_key,
    ADD UNIQUE KEY uq_clip_jobs_performance_output (performance_id, output_key(255));

ALTER TABLE clip_assets
    DROP INDEX uq_clip_assets_storage_path,
    ADD UNIQUE KEY uq_clip_assets_performance_storage (performance_id, storage_path(255));
