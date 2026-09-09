-- 검수 큐(APPLE_ALBUM_DUPLICATE_RECORDING) 566건을 recording_contributors 로 통합한다.
--
-- 배경: 같은 앨범이 참여 아티스트마다 따로 recording 으로 등록돼 있었다.
-- 클래식 앨범은 지휘자·독주자·오케스트라가 함께 참여해 이 중복이 생긴다.
-- 202608050006 이 MIN(recording_id) 를 winner 로 골라 platform_links 에 하나만 넣고
-- 나머지를 큐에 남겨 뒀다.
--
-- 이 마이그레이션은 참여 관계를 recording_contributors 로 옮긴다.
--   - loser 가 아닌 recording  → 자기 artist_id 를 is_primary=1 로 등록
--   - loser 의 artist_id       → winner recording 에 is_primary=0 으로 등록
-- loser recording 행 자체는 지우지 않는다. 되돌릴 수 있어야 하고,
-- /recordings/<id> 직접 조회도 그대로 동작해야 한다.
--
-- role_code 는 legacy 데이터에 역할 정보가 없어 'primary_performer' 하나로 둔다
-- (202608050003 이 performance_credits 에 쓴 값과 같다).
-- 역할 세분화는 국제 시드의 MusicBrainz relation 이 채운다.

-- 1) loser 가 아닌 recording 의 주 아티스트
INSERT IGNORE INTO recording_contributors (
    recording_id, track_id, artist_id, role_code, is_primary, display_order
)
SELECT
    recording.id,
    NULL,
    recording.artist_id,
    'primary_performer',
    TRUE,
    0
FROM recordings recording
WHERE NOT EXISTS (
    SELECT 1 FROM review_queue queue
    WHERE queue.status = 'OPEN'
      AND queue.reason_code = 'APPLE_ALBUM_DUPLICATE_RECORDING'
      AND CAST(queue.target_id AS UNSIGNED) = recording.id
);

-- 2) 중복으로 밀려난 recording 의 아티스트를 winner 의 참여자로 옮긴다
INSERT IGNORE INTO recording_contributors (
    recording_id, track_id, artist_id, role_code, is_primary, display_order
)
SELECT
    duplicate.winner_id,
    NULL,
    duplicate.artist_id,
    'primary_performer',
    FALSE,
    duplicate.display_order
FROM (
    SELECT
        CAST(JSON_UNQUOTE(JSON_EXTRACT(queue.evidence, '$.winnerRecordingId')) AS UNSIGNED) AS winner_id,
        loser.artist_id,
        ROW_NUMBER() OVER (
            PARTITION BY CAST(JSON_UNQUOTE(JSON_EXTRACT(queue.evidence, '$.winnerRecordingId')) AS UNSIGNED)
            ORDER BY loser.artist_id
        ) AS display_order
    FROM review_queue queue
    JOIN recordings loser ON loser.id = CAST(queue.target_id AS UNSIGNED)
    WHERE queue.status = 'OPEN'
      AND queue.reason_code = 'APPLE_ALBUM_DUPLICATE_RECORDING'
) duplicate;

-- 3) 처리한 큐 항목을 종결한다
UPDATE review_queue queue
SET queue.status = 'APPROVED',
    queue.resolved_at = CURRENT_TIMESTAMP(6),
    queue.resolution = JSON_OBJECT(
        'action', 'merged_into_recording_contributors',
        'migration', '202608050011',
        'winnerRecordingId', CAST(JSON_UNQUOTE(JSON_EXTRACT(queue.evidence, '$.winnerRecordingId')) AS UNSIGNED),
        'loserRecordingId', CAST(queue.target_id AS UNSIGNED),
        'loserRecordingKept', TRUE
    )
WHERE queue.status = 'OPEN'
  AND queue.reason_code = 'APPLE_ALBUM_DUPLICATE_RECORDING';
