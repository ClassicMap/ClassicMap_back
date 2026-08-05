-- 외부 재생 URL은 홈서버 내부 storage_path와 분리한다.
ALTER TABLE clip_assets
    ADD COLUMN public_url VARCHAR(1000) NULL AFTER storage_path,
    ADD CONSTRAINT chk_clip_assets_published_url CHECK (
        status <> 'PUBLISHED'
        OR (public_url IS NOT NULL AND CHAR_LENGTH(TRIM(public_url)) > 0)
    );
