-- 2025-12-09 historical backup을 복원하고 001~006 migration을
-- 순서대로 적용한 전용 테스트 데이터베이스에서만 실행합니다.

DROP PROCEDURE IF EXISTS verify_apple_music_album_backfill_historical;

DELIMITER //

CREATE PROCEDURE verify_apple_music_album_backfill_historical()
BEGIN
    DECLARE recording_count BIGINT DEFAULT 0;
    DECLARE eligible_count BIGINT DEFAULT 0;
    DECLARE distinct_album_count BIGINT DEFAULT 0;
    DECLARE link_count BIGINT DEFAULT 0;
    DECLARE duplicate_review_count BIGINT DEFAULT 0;
    DECLARE source_conflict_count BIGINT DEFAULT 0;
    DECLARE existing_conflict_count BIGINT DEFAULT 0;
    DECLARE invalid_subject_count BIGINT DEFAULT 0;
    DECLARE exact_legacy_match_count BIGINT DEFAULT 0;
    DECLARE sample_count BIGINT DEFAULT 0;

    SELECT COUNT(*)
      INTO recording_count
      FROM recordings;

    SELECT COUNT(*)
      INTO eligible_count
      FROM recordings
     WHERE REGEXP_LIKE(TRIM(apple_music_id), '^[0-9]+$', 'c')
       AND REGEXP_LIKE(
           TRIM(apple_music_url),
           '^https://music[.]apple[.]com/[A-Za-z]{2}/album/[^/?#]+/[0-9]+/?([?#].*)?$',
           'c'
       )
       AND TRIM(apple_music_id) = SUBSTRING_INDEX(
           TRIM(
               TRAILING '/' FROM SUBSTRING_INDEX(
                   SUBSTRING_INDEX(TRIM(apple_music_url), '?', 1),
                   '#',
                   1
               )
           ),
           '/',
           -1
       );

    SELECT COUNT(DISTINCT apple_music_id)
      INTO distinct_album_count
      FROM recordings;

    SELECT COUNT(*)
      INTO link_count
      FROM platform_links
     WHERE platform = 'apple_music';

    SELECT COUNT(*)
      INTO duplicate_review_count
      FROM review_queue
     WHERE reason_code = 'APPLE_ALBUM_DUPLICATE_RECORDING';

    SELECT COUNT(*)
      INTO source_conflict_count
      FROM review_queue
     WHERE reason_code = 'APPLE_ALBUM_SOURCE_CONFLICT';

    SELECT COUNT(*)
      INTO existing_conflict_count
      FROM review_queue
     WHERE reason_code = 'APPLE_ALBUM_EXISTING_LINK_CONFLICT';

    SELECT COUNT(*)
      INTO invalid_subject_count
      FROM platform_links
     WHERE platform = 'apple_music'
       AND (recording_id IS NULL OR track_id IS NOT NULL);

    SELECT COUNT(*)
      INTO exact_legacy_match_count
      FROM platform_links AS link
      JOIN recordings AS recording
        ON recording.id = link.recording_id
     WHERE link.platform = 'apple_music'
       AND link.platform_id = recording.apple_music_id
       AND link.url = recording.apple_music_url;

    SELECT COUNT(*)
      INTO sample_count
      FROM platform_links
     WHERE recording_id = 3538
       AND track_id IS NULL
       AND platform = 'apple_music'
       AND storefront = 'us'
       AND platform_id = '1452313974'
       AND url = 'https://music.apple.com/us/album/debussy/1452313974';

    IF recording_count <> 5434 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'historical recordings count must be 5434';
    END IF;
    IF eligible_count <> 5434 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'historical eligible source count must be 5434';
    END IF;
    IF distinct_album_count <> 4868 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'historical distinct Apple album count must be 4868';
    END IF;
    IF link_count <> 4868 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'normalized Apple album link count must be 4868';
    END IF;
    IF duplicate_review_count <> 566 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'duplicate recording review count must be 566';
    END IF;
    IF source_conflict_count <> 0 OR existing_conflict_count <> 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'clean historical fixture must not have source/manual conflicts';
    END IF;
    IF invalid_subject_count <> 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Apple album links must target recordings only';
    END IF;
    IF exact_legacy_match_count <> 4868 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'normalized links must preserve exact historical ID and URL';
    END IF;
    IF link_count + duplicate_review_count <> eligible_count THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'every eligible recording must be linked or reviewed';
    END IF;
    IF sample_count <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'recording 3538 Apple album sample mismatch';
    END IF;
END//

DELIMITER ;

CALL verify_apple_music_album_backfill_historical();
DROP PROCEDURE verify_apple_music_album_backfill_historical;

SELECT
    (SELECT COUNT(*) FROM recordings) AS recording_count,
    (SELECT COUNT(*) FROM platform_links WHERE platform = 'apple_music') AS link_count,
    (
        SELECT COUNT(*)
        FROM review_queue
        WHERE reason_code = 'APPLE_ALBUM_DUPLICATE_RECORDING'
    ) AS duplicate_review_count;
