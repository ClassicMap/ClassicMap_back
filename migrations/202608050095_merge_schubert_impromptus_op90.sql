-- 슈베르트 4개의 즉흥곡 Op. 90, D. 899 의 작품 식별자와 악장을 수동 곡으로 옮긴다.
--
--   piece 13100(seed) → piece 121(manual)
--
-- 202608050081 과 같은 이유와 같은 방식이다. 같은 작품이 수동 곡과 국제 시드 곡으로 두 번
-- 들어와 있고 식별자는 시드 곡에 있었다. 시드 곡에는 악장 넷뿐이고 연주·구간·별칭·관계가
-- 하나도 없다(확인함). 수동 곡에는 한국어 제목이 있고 editor_locked 다.
--
-- 시드 곡 자체는 지우지 않는다. 악장은 복사하고 원본은 그대로 둔다. 자동 시드가 덮어쓰지
-- 못하게 origin 을 manual, editor_locked 를 1 로 둔다.

UPDATE piece_identifiers
SET piece_id = 121
WHERE namespace = 'musicbrainz_work'
  AND external_id = '9d1fcbf9-9bd2-427b-9abb-e550c24052f8'
  AND piece_id = 13100;

INSERT INTO piece_parts
    (piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT * FROM (
    SELECT 121 AS p, 'musicbrainz:e76801c4-2beb-32a9-b38d-5864d03de62f' AS k, 1 AS s, '1' AS m,
           '1번 C단조 Allegro molto moderato' AS nk,
           'No. 1 in C minor. Allegro molto moderato' AS ne,
           'FACTS_VERIFIED' AS es, 'manual' AS o, 1 AS l
    UNION ALL SELECT 121, 'musicbrainz:f37476cb-7795-3554-88e4-79154d188def', 2, '2',
           '2번 E♭장조 Allegro', 'No. 2 in E-flat major. Allegro', 'FACTS_VERIFIED', 'manual', 1
    UNION ALL SELECT 121, 'musicbrainz:3d6466d1-2f34-3166-8dbf-61c59ff8eca0', 3, '3',
           '3번 G♭장조 Andante', 'No. 3 in G-flat major. Andante', 'FACTS_VERIFIED', 'manual', 1
    UNION ALL SELECT 121, 'musicbrainz:9f0b1f53-e4c9-30ba-8582-76410a5189ac', 4, '4',
           '4번 A♭장조 Allegretto', 'No. 4 in A-flat major. Allegretto', 'FACTS_VERIFIED', 'manual', 1
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = incoming.p AND existing.part_key = incoming.k
);
