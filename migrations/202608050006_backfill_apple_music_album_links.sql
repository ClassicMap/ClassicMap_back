-- 레거시 recordings의 신뢰 가능한 Apple Music 앨범 링크를 정규 platform_links에 연결한다.
-- 레거시 컬럼과 기존 platform_links는 수정하거나 삭제하지 않는다.

DROP TEMPORARY TABLE IF EXISTS tmp_apple_album_source;
CREATE TEMPORARY TABLE tmp_apple_album_source AS
SELECT
    parsed.recording_id,
    parsed.legacy_platform_id,
    parsed.legacy_url,
    parsed.has_platform_id,
    parsed.has_url,
    parsed.valid_platform_id,
    parsed.valid_album_url,
    CASE
        WHEN parsed.valid_album_url THEN SUBSTRING_INDEX(
            TRIM(
                TRAILING '/' FROM SUBSTRING_INDEX(
                    SUBSTRING_INDEX(parsed.legacy_url, '?', 1),
                    '#',
                    1
                )
            ),
            '/',
            -1
        )
        ELSE NULL
    END AS url_platform_id,
    CASE
        WHEN parsed.valid_album_url
            AND REGEXP_LIKE(
                parsed.legacy_url,
                '^https://music[.]apple[.]com/[A-Za-z]{2}/album/',
                'c'
            )
        THEN LOWER(
            SUBSTRING_INDEX(
                SUBSTRING(
                    parsed.legacy_url,
                    LENGTH('https://music.apple.com/') + 1
                ),
                '/',
                1
            )
        )
        ELSE ''
    END AS storefront
FROM (
    SELECT
        id AS recording_id,
        TRIM(apple_music_id) AS legacy_platform_id,
        TRIM(apple_music_url) AS legacy_url,
        apple_music_id IS NOT NULL AND TRIM(apple_music_id) <> '' AS has_platform_id,
        apple_music_url IS NOT NULL AND TRIM(apple_music_url) <> '' AS has_url,
        apple_music_id IS NOT NULL
            AND REGEXP_LIKE(TRIM(apple_music_id), '^[0-9]+$', 'c') AS valid_platform_id,
        apple_music_url IS NOT NULL
            AND REGEXP_LIKE(
                TRIM(apple_music_url),
                '^https://music[.]apple[.]com/([A-Za-z]{2}/)?album/[^/?#]+/[0-9]+/?([?#].*)?$',
                'c'
            ) AS valid_album_url
    FROM recordings
) AS parsed;

ALTER TABLE tmp_apple_album_source
    ADD PRIMARY KEY (recording_id),
    ADD INDEX idx_tmp_apple_source_platform_id (legacy_platform_id),
    ADD INDEX idx_tmp_apple_source_url_platform_id (url_platform_id);

-- 값이 있지만 숫자 앨범 ID나 공식 album URL로 검증할 수 없는 행은 추정하지 않는다.
-- 기존 review_queue 행은 유지하고 같은 recording/reason 조합을 다시 만들지 않는다.
INSERT INTO review_queue (
    target_type,
    target_id,
    reason_code,
    priority,
    evidence
)
SELECT
    'recording',
    CAST(source.recording_id AS CHAR),
    'APPLE_ALBUM_SOURCE_CONFLICT',
    50,
    JSON_OBJECT(
        'migration', '202608050006',
        'legacyAppleMusicId', source.legacy_platform_id,
        'legacyAppleMusicUrl', source.legacy_url,
        'validPlatformId', source.valid_platform_id,
        'validAlbumUrl', source.valid_album_url,
        'urlPlatformId', source.url_platform_id
    )
FROM tmp_apple_album_source AS source
WHERE (
        (source.has_platform_id AND NOT source.valid_platform_id)
        OR (source.has_url AND NOT source.valid_album_url)
        OR (
            source.valid_platform_id
            AND source.valid_album_url
            AND source.legacy_platform_id <> source.url_platform_id
        )
    )
    AND NOT EXISTS (
        SELECT 1
        FROM review_queue AS existing_review
        WHERE existing_review.target_type = 'recording'
          AND existing_review.target_id = CAST(source.recording_id AS CHAR)
          AND existing_review.reason_code = 'APPLE_ALBUM_SOURCE_CONFLICT'
    );

DROP TEMPORARY TABLE IF EXISTS tmp_apple_album_candidates;
CREATE TEMPORARY TABLE tmp_apple_album_candidates AS
SELECT
    source.recording_id,
    CAST('apple_music' AS CHAR(32) CHARACTER SET ascii) AS platform,
    CAST(
        CASE
            WHEN source.valid_album_url THEN source.storefront
            ELSE ''
        END AS CHAR(16) CHARACTER SET ascii
    ) AS storefront,
    CAST(
        CASE
            WHEN source.valid_platform_id THEN source.legacy_platform_id
            ELSE source.url_platform_id
        END AS CHAR(255) CHARACTER SET ascii
    ) AS platform_id,
    CAST(
        CASE
            WHEN source.valid_album_url THEN source.legacy_url
            ELSE CONCAT('https://music.apple.com/album/', source.legacy_platform_id)
        END AS CHAR(1000) CHARACTER SET utf8mb4
    ) AS url
FROM tmp_apple_album_source AS source
WHERE (
        source.valid_platform_id
        AND (
            NOT source.has_url
            OR (
                source.valid_album_url
                AND source.legacy_platform_id = source.url_platform_id
            )
        )
    )
    OR (
        NOT source.has_platform_id
        AND source.valid_album_url
    );

ALTER TABLE tmp_apple_album_candidates
    MODIFY COLUMN platform VARCHAR(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    MODIFY COLUMN storefront VARCHAR(16) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    MODIFY COLUMN platform_id VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    MODIFY COLUMN url VARCHAR(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    ADD PRIMARY KEY (recording_id),
    ADD INDEX idx_tmp_apple_candidate_key (platform, storefront, platform_id);

-- 같은 Apple album key가 이미 수동 링크에 연결되어 있으면 수동 행을 보존한다.
-- 대상 recording 또는 URL이 다른 후보는 검토 큐에 남기고 자동 수정하지 않는다.
INSERT INTO review_queue (
    target_type,
    target_id,
    reason_code,
    priority,
    evidence
)
SELECT
    'recording',
    CAST(candidate.recording_id AS CHAR),
    'APPLE_ALBUM_EXISTING_LINK_CONFLICT',
    70,
    JSON_OBJECT(
        'migration', '202608050006',
        'platform', candidate.platform,
        'storefront', candidate.storefront,
        'platformId', candidate.platform_id,
        'candidateUrl', candidate.url,
        'existingLinkId', existing_link.id,
        'existingRecordingId', existing_link.recording_id,
        'existingTrackId', existing_link.track_id,
        'existingUrl', existing_link.url
    )
FROM tmp_apple_album_candidates AS candidate
JOIN platform_links AS existing_link
  ON existing_link.platform = candidate.platform
 AND existing_link.storefront = candidate.storefront
 AND existing_link.platform_id = candidate.platform_id
WHERE NOT (
        existing_link.recording_id = candidate.recording_id
        AND existing_link.track_id IS NULL
        AND existing_link.url = candidate.url
    )
    AND NOT EXISTS (
        SELECT 1
        FROM review_queue AS existing_review
        WHERE existing_review.target_type = 'recording'
          AND existing_review.target_id = CAST(candidate.recording_id AS CHAR)
          AND existing_review.reason_code = 'APPLE_ALBUM_EXISTING_LINK_CONFLICT'
    )
    AND NOT EXISTS (
        SELECT 1
        FROM review_queue AS duplicate_review
        WHERE duplicate_review.target_type = 'recording'
          AND duplicate_review.target_id = CAST(candidate.recording_id AS CHAR)
          AND duplicate_review.reason_code = 'APPLE_ALBUM_DUPLICATE_RECORDING'
    );

DROP TEMPORARY TABLE IF EXISTS tmp_apple_album_winners;
CREATE TEMPORARY TABLE tmp_apple_album_winners AS
SELECT
    candidate.platform,
    candidate.storefront,
    candidate.platform_id,
    MIN(candidate.recording_id) AS recording_id
FROM tmp_apple_album_candidates AS candidate
LEFT JOIN platform_links AS existing_link
  ON existing_link.platform = candidate.platform
 AND existing_link.storefront = candidate.storefront
 AND existing_link.platform_id = candidate.platform_id
WHERE existing_link.id IS NULL
GROUP BY candidate.platform, candidate.storefront, candidate.platform_id;

ALTER TABLE tmp_apple_album_winners
    MODIFY COLUMN platform VARCHAR(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    MODIFY COLUMN storefront VARCHAR(16) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    MODIFY COLUMN platform_id VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    ADD PRIMARY KEY (platform, storefront, platform_id);

-- platform_links의 고유 키가 한 Apple album을 하나의 subject에만 연결한다.
-- 기존 링크가 없는 중복 그룹에서는 가장 작은 recording_id만 결정적으로 적재하고
-- 나머지는 무손실 검토 대상으로 기록한다. 레거시 recordings 컬럼은 그대로 남는다.
INSERT INTO review_queue (
    target_type,
    target_id,
    reason_code,
    priority,
    evidence
)
SELECT
    'recording',
    CAST(candidate.recording_id AS CHAR),
    'APPLE_ALBUM_DUPLICATE_RECORDING',
    60,
    JSON_OBJECT(
        'migration', '202608050006',
        'platform', candidate.platform,
        'storefront', candidate.storefront,
        'platformId', candidate.platform_id,
        'candidateUrl', candidate.url,
        'winnerRecordingId', winner.recording_id
    )
FROM tmp_apple_album_candidates AS candidate
JOIN tmp_apple_album_winners AS winner
  ON winner.platform = candidate.platform
 AND winner.storefront = candidate.storefront
 AND winner.platform_id = candidate.platform_id
WHERE candidate.recording_id <> winner.recording_id
  AND NOT EXISTS (
      SELECT 1
      FROM review_queue AS existing_review
      WHERE existing_review.target_type = 'recording'
        AND existing_review.target_id = CAST(candidate.recording_id AS CHAR)
        AND existing_review.reason_code = 'APPLE_ALBUM_DUPLICATE_RECORDING'
  );

-- INSERT IGNORE를 사용하지 않는다. 고유 키 충돌은 위에서 검토 큐에 기록하며,
-- 기존 키가 없는 그룹의 결정적 winner만 적재하므로 재실행 시 INSERT 대상이 0건이다.
INSERT INTO platform_links (
    recording_id,
    track_id,
    platform,
    storefront,
    platform_id,
    url,
    isrc,
    verified_at,
    source_record_id
)
SELECT
    candidate.recording_id,
    NULL,
    candidate.platform,
    candidate.storefront,
    candidate.platform_id,
    candidate.url,
    NULL,
    NULL,
    NULL
FROM tmp_apple_album_candidates AS candidate
JOIN tmp_apple_album_winners AS winner
  ON winner.platform = candidate.platform
 AND winner.storefront = candidate.storefront
 AND winner.platform_id = candidate.platform_id
 AND winner.recording_id = candidate.recording_id;

DROP TEMPORARY TABLE IF EXISTS tmp_apple_album_winners;
DROP TEMPORARY TABLE IF EXISTS tmp_apple_album_candidates;
DROP TEMPORARY TABLE IF EXISTS tmp_apple_album_source;
