-- 레거시 비교 영상 source 11건의 영상 길이를 채운다.
--
-- 라흐마니노프 협주곡 2·3번과 쇼팽 발라드 1번의 레거시 연주는 클립 자산 없이 수동으로
-- 넣었고 source_duration_ms 가 비어 있다. 같은 영상과 사람이 잡은 발췌 경계로 다시
-- 수집하면 적재기는 기존 source 를 재사용하는데, 상태·권리·URL·길이가 후보와 모두 같을
-- 때만 재사용하고 다르면 SOURCE_STATE_CONFLICT 로 멈춘다. 다른 값은 이미 같고 길이만
-- 비어 있다.
--
-- 길이는 2026-09-17 에 yt-dlp 메타로 확인한 값이다. 11개 모두 public 이었다.
-- 비어 있는 행만 채운다.

UPDATE performance_sources source
JOIN (
    SELECT 'DPJL488cfRw' AS video, 2601 AS seconds
    UNION ALL SELECT 'KUbi0nEnUi4', 2577
    UNION ALL SELECT '5bX_yRzCuM4', 2642
    UNION ALL SELECT 'rEGOihjqO9w', 2269
    UNION ALL SELECT 'YviN1tuXbzc', 2160
    UNION ALL SELECT 'NsqXCO0ADwM', 1982
    UNION ALL SELECT 'YYUu4Rl7EdE', 579
    UNION ALL SELECT 'taY5oHleS4I', 628
    UNION ALL SELECT 'eG1Olvh7vCU', 539
    UNION ALL SELECT 'l7GtUKE-Ju0', 563
    UNION ALL SELECT 'SlJEjza0-FQ', 596
) measured ON measured.video = source.provider_video_id
SET source.source_duration_ms = measured.seconds * 1000
WHERE source.provider = 'youtube'
  AND source.source_duration_ms IS NULL;
