-- 베토벤 피아노 3중주 7번 "대공" Op. 97(piece 441), 슈만 피아노 5중주 Op. 44(piece 448),
-- 멘델스존 피아노 3중주 1번 Op. 49(piece 449)의 작품 식별자를 채운다.
--
-- 셋 다 전곡 work 이고 발췌는 sector 로 붙는다. 적재 직전에 같은 MBID 를 쥔 시드 곡이
-- 있는지 확인했으며 셋 다 어디에도 붙어 있지 않았다.
--
-- 실내악은 MusicBrainz 의 work 검색에서 전곡 work 이 악장 행에 밀린다(악장이 점수 100,
-- 전곡이 78~91). 제목에 악장 표시가 있는 행을 걸러내고 골랐다. type:trio 와
-- type:quintet 은 걸리지 않으므로 type 없이 찾았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 441 AS p, 'musicbrainz_work' AS n, '53ac5ed4-77f8-41cf-8d3e-f9e5c6643220' AS v
    UNION ALL SELECT 448, 'musicbrainz_work', '9e6cbe3d-ac22-4255-aece-07df8edc5d6f'
    UNION ALL SELECT 449, 'musicbrainz_work', 'ea02583a-af2d-4d81-bc64-5d0b7778271a'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
