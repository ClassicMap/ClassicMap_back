-- 기존 performance의 원본 영상, 밀리초 구간, primary credit을 보존한다.
-- 모든 INSERT는 natural key의 UNIQUE 제약과 INSERT IGNORE를 사용해 재실행 가능하다.
INSERT IGNORE INTO performance_sources (
    provider,
    provider_video_id,
    source_url,
    availability_status,
    rights_mode
)
SELECT DISTINCT
    performance.video_platform,
    performance.video_id,
    CASE
        WHEN performance.video_platform = 'youtube'
            THEN CONCAT('https://www.youtube.com/watch?v=', performance.video_id)
        ELSE NULL
    END,
    'AVAILABLE',
    'unknown'
FROM performances performance;

UPDATE performances performance
JOIN performance_sources source
  ON source.provider = performance.video_platform
 AND source.provider_video_id = performance.video_id
SET performance.performance_source_id = COALESCE(performance.performance_source_id, source.id),
    performance.start_ms = COALESCE(performance.start_ms, performance.start_time * 1000),
    performance.end_ms = COALESCE(performance.end_ms, performance.end_time * 1000)
WHERE performance.performance_source_id IS NULL
   OR performance.start_ms IS NULL
   OR performance.end_ms IS NULL;

INSERT IGNORE INTO performance_credits (
    performance_source_id,
    artist_id,
    role_code,
    is_primary,
    display_order
)
SELECT DISTINCT
    performance.performance_source_id,
    performance.artist_id,
    'primary_performer',
    TRUE,
    0
FROM performances performance
WHERE performance.performance_source_id IS NOT NULL;
