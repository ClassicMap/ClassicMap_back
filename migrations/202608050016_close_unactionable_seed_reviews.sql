-- 사람이 판단할 수 없는 검수 항목을 종결한다.
--
-- 국제 시드를 적재하면서 검수 큐가 74,804 건까지 쌓였다. 성격을 나눠 보면
-- 대부분은 "검수자가 결정할 사안"이 아니라 "적재하지 못한 이유의 기록"이다.
-- 사람이 열어도 할 수 있는 조치가 없고, 다음 수집에서 근거가 갖춰지면
-- 그때 새 항목으로 다시 올라온다.
--
--   WORK_PARENT_NOT_IN_BUNDLE   34,370  상위 작품을 이번 번들에 담지 않았다
--   WORK_COMPOSER_UNAVAILABLE   27,771  작곡가가 authority 에 없다
--   NAME_ONLY_MATCH_FORBIDDEN    7,568  이름만 같아 자동 병합을 거부했다(설계대로)
--   WORK_COMPOSER_NOT_UNIQUE     3,783  작곡가가 여럿이라 특정할 수 없다
--   MULTIPLE_WORK_PARENTS          692  상위 작품이 여럿이다
--   LEGACY_*_REQUIRED_FIELDS_MISSING 620  표시 필수 필드가 원본에 없다
--
-- 표시 필드 결측 620 건은 따로 살펴봤다. 이름이 아예 없는 건이 9 건,
-- musicbrainz_artist 가 없어 음반·작품을 연결할 수 없는 건이 271 건이다.
-- legacy 행을 만들어도 눌러서 볼 것이 없고, artists·composers 의
-- nationality·category 는 NOT NULL 이라 빈 값으로 넣을 수도 없다.
-- authority_entities 와 외부 식별자는 그대로 남으므로, 나중에 표시 필드를
-- 갖추면 그때 legacy 행을 만들면 된다.
--
-- 이름만 겹쳐 거부한 건과 표시 필드가 없는 건은 판정이 끝난 것이므로 REJECTED,
-- 근거가 갖춰지면 다시 시도할 수 있는 건은 CANCELLED 로 남긴다.

UPDATE review_queue queue
SET queue.status = 'REJECTED',
    queue.resolved_at = CURRENT_TIMESTAMP(6),
    queue.resolution = JSON_OBJECT(
        'action', 'rejected_no_actionable_evidence',
        'migration', '202608050016',
        'note', '이름만 일치하거나 표시 필수 필드가 공식 원본에 없어 판정이 끝난 항목'
    )
WHERE queue.status = 'OPEN'
  AND queue.reason_code IN (
      'NAME_ONLY_MATCH_FORBIDDEN',
      'LEGACY_COMPOSER_REQUIRED_FIELDS_MISSING',
      'LEGACY_ARTIST_REQUIRED_FIELDS_MISSING'
  );

UPDATE review_queue queue
SET queue.status = 'CANCELLED',
    queue.resolved_at = CURRENT_TIMESTAMP(6),
    queue.resolution = JSON_OBJECT(
        'action', 'cancelled_pending_future_seed',
        'migration', '202608050016',
        'note', '이번 번들의 범위 밖이라 적재하지 못한 기록. 근거가 갖춰지면 새 항목으로 다시 올라온다'
    )
WHERE queue.status = 'OPEN'
  AND queue.reason_code IN (
      'WORK_PARENT_NOT_IN_BUNDLE',
      'WORK_COMPOSER_UNAVAILABLE',
      'WORK_COMPOSER_NOT_UNIQUE',
      'MULTIPLE_WORK_PARENTS'
  );
