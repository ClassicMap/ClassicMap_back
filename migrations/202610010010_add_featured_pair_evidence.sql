-- 추천 비교에도 근거를 남긴다. 연주 노트의 evidence 와 같은 모양이다.
-- 예: [{"kind":"listening","status":"skipped","at":"2026-10-01"}]
-- API 는 내보내지 않는다. 나중에 들어 보고 고칠 대상을 찾는 데 쓴다.

ALTER TABLE sector_featured_pairs
    ADD COLUMN evidence JSON NULL AFTER moments,
    ADD CONSTRAINT chk_featured_pairs_evidence
        CHECK (evidence IS NULL OR JSON_TYPE(evidence) = 'ARRAY');
