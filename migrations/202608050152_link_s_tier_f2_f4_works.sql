-- F2·F4 여섯 곡의 작품 식별자를 채운다.
--
--   149 베르디 <리골레토>            150 베르디 <아이다>
--   148 베르디 <라 트라비아타>       71  모차르트 레퀴엠 K. 626
--   152 베르디 레퀴엠                157 브람스 독일 레퀴엠 Op. 45
--
-- 오페라·레퀴엠 전곡을 곡으로 두고 낱 번호는 sector 로 붙인다. MusicBrainz 에는 낱
-- 번호도 따로 work 으로 있으나 쓰지 않는다. 한 작품 안의 다른 대목을 나중에 더 붙이려면
-- 전곡에 sector 를 더하는 편이 낫기 때문이다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 149 AS p, 'musicbrainz_work' AS n, '2dc7fb62-ae9b-4e0d-9296-42c9234923f5' AS v
    UNION ALL SELECT 148, 'musicbrainz_work', '24df0a9b-7977-4ff6-a4dc-7ad71db6972c'
    UNION ALL SELECT 150, 'musicbrainz_work', '6675ed9c-9b8b-43f0-9cd7-3df843b6e8d8'
    UNION ALL SELECT 71,  'musicbrainz_work', 'e3442502-1d20-44ec-9c39-2655956840e2'
    UNION ALL SELECT 152, 'musicbrainz_work', '2d73a8a6-cead-4464-bd6f-5a55d8ad2752'
    UNION ALL SELECT 157, 'musicbrainz_work', '362813da-c202-4c15-86af-5dcea05242de'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
