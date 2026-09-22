-- 국제 시드가 따로 만든 중복 곡의 작품 식별자와 악장 정보를 수동 곡으로 옮긴다.
--
--   쇼스타코비치 피아노 협주곡 2번  piece 12515(seed) → piece 458(manual)
--   프로코피예프 피아노 소나타 7번  piece 11317(seed) → piece 326(manual)
--
-- 같은 작품이 수동 곡과 국제 시드 곡으로 두 번 들어와 있고, MusicBrainz 작품 식별자는
-- 시드 곡에 붙어 있었다. piece_identifiers 의 (namespace, external_id) 는 전역에서
-- 유일하므로 한 곡만 가질 수 있고, 비교 영상 적재기는 이 식별자로 곡을 찾는다.
-- 그래서 비교 영상을 수동 곡에 붙이려면 식별자를 옮겨야 한다.
--
-- 수동 곡을 남기는 이유: 한국어 제목과 편집 데이터가 있고 editor_locked 이며,
-- 비교 영상 큐레이션이 이 곡 번호를 기준으로 짜여 있다. 시드 곡에는 악장 세 개와
-- 별칭뿐이고 연주·구간·즐겨찾기 등 다른 참조는 하나도 없다(확인함).
--
-- 시드 곡 자체는 지우지 않는다. 자동 시드가 다시 만들 수 있고 지우는 것은 되돌리기
-- 어렵다. 식별자를 잃은 시드 곡이 목록에 남는 것은 이미 국제 시드 곡 전반의 문제이며
-- 따로 다룬다.
--
-- 악장은 수동 곡에 복사한다(원본은 그대로 둔다). part_key 는 (piece_id, part_key) 로
-- 유일하므로 같은 키를 그대로 쓴다. 자동 시드가 덮어쓰지 못하게 origin 을 manual 로,
-- editor_locked 를 1 로 둔다.

UPDATE piece_identifiers
SET piece_id = 458
WHERE namespace = 'musicbrainz_work'
  AND external_id = '3ed3ae19-6230-4337-b1f6-b5d2a718cc1a'
  AND piece_id = 12515;

UPDATE piece_identifiers
SET piece_id = 326
WHERE namespace = 'musicbrainz_work'
  AND external_id = '45d6ee5d-b598-4196-9f96-b07aa68ed223'
  AND piece_id = 11317;

INSERT INTO piece_parts
    (piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT * FROM (
    SELECT 458 AS p, 'musicbrainz:df63906c-f51a-301d-9220-58425a2100cb' AS k, 1 AS s, 'I' AS m,
           '1악장 Allegro' AS nk, 'I. Allegro' AS ne, 'FACTS_VERIFIED' AS es, 'manual' AS o, 1 AS l
    UNION ALL SELECT 458, 'musicbrainz:37e6e498-6376-3346-bec1-1d0f9eaeb823', 2, 'II', '2악장 Andante', 'II. Andante', 'FACTS_VERIFIED', 'manual', 1
    UNION ALL SELECT 458, 'musicbrainz:3ca3c170-c8f2-357a-b8f5-2ecdcfe3aa6a', 3, 'III', '3악장 Allegro', 'III. Allegro', 'FACTS_VERIFIED', 'manual', 1
    UNION ALL SELECT 326, 'musicbrainz:1f2e7664-2ff3-36b1-a799-bdbc9cce8f39', 1, 'I', '1악장 Allegro inquieto', 'I. Allegro inquieto', 'FACTS_VERIFIED', 'manual', 1
    UNION ALL SELECT 326, 'musicbrainz:e4dc664d-4767-3ac9-9b43-2a69adcc16fd', 2, 'II', '2악장 Andante caloroso', 'II. Andante caloroso', 'FACTS_VERIFIED', 'manual', 1
    UNION ALL SELECT 326, 'musicbrainz:f0c557ad-95ab-38cd-8c4e-238a9caccbd8', 3, 'III', '3악장 Precipitato', 'III. Precipitato', 'FACTS_VERIFIED', 'manual', 1
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = incoming.p AND existing.part_key = incoming.k
);
