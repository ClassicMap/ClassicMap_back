-- 영화 속 클래식에 나온 대목을 새 비교 구간으로 붙일 수동 곡 10 개에 MusicBrainz 작품 식별자를 붙인다.
--
-- 적재기는 곡을 musicbrainz_work 로만 해소한다(comparison_seed_loader.rs resolve_work).
-- 아래 곡들은 A tier 연결(202608050164) 때 식별자가 붙지 않아 연주를 붙일 수 없었다.
--
-- MBID 는 Wikidata 작품 항목의 P435 로 골랐다. MusicBrainz 검색은 같은 작품의 중복·발췌·
-- 편곡 work 이 높은 점수로 섞여 나와서다(메시아만 해도 'Messiah, K. 572' 편곡판이 100점).
-- Wikidata 항목이 없는 탕부랭은 「Pièces de clavecin, Suite in E minor」의 낱곡 work 을 골랐다.
--
-- | 곡 | 수동 | MBID | 근거 |
-- |---|---|---|---|
-- | 바흐 평균율 클라비어곡집(1·2권) | 10 | bd511c33-29d3-332d-b2b7-7753d3cf42af | Q211971 |
-- | 바흐 무반주 첼로 모음곡 | 12 | 4e4b97df-403a-4a27-b9fa-5bd8a8333604 | Q756843 |
-- | 헨델 메시아 HWV 56 | 21 | 426b7e1c-68e7-42cf-9cae-4ba34feddf67 | Q207732 |
-- | 비발디 사계 | 28 | 87886dcf-9776-49cb-b6f5-10104da6e42c | Q12016 |
-- | 라모 탕부랭(E단조 모음곡) | 47 | fc35bfba-5e0d-3de4-bbeb-93af627aa8b6 | MB 부모 work |
-- | 로시니 세비야의 이발사 | 167 | adeb0cf7-4f03-4781-87e5-a9228fdb02a3 | Q208659 |
-- | 푸치니 토스카 | 212 | b3e15438-61c0-4357-aba9-f05e29bb639d | Q192941 |
-- | 생상스 죽음의 무도 Op. 40 | 253 | 640d92c6-7a12-38ca-a331-ac4ccf420536 | Q1164860 |
-- | 엘가 첼로 협주곡 Op. 85 | 266 | 8abd4aec-5d22-3d22-84d2-7f70a54989a4 | Q2487481 |
-- | 바흐 BWV 147 10곡 코랄 | 432 | bb71e7f6-8cd0-37fa-8eef-dac459e03a09 | Q1107553 |
--
-- 평균율과 첼로 모음곡은 국제 시드가 따로 만든 곡(13964, 13814)이 같은 식별자를 쥐고 있다.
-- 둘 다 연주·구간이 없고(performance_sectors 0 건) 시드 곡 자체는 지우지 않는다.
-- 202608050163 처럼 식별자만 수동 곡으로 옮긴다. 13814 의 악장 8 개는 옮기지 않는다.
-- 이번 구간은 곡 전체 MBID 로 해소하고, 악장을 복사하면 같은 악장 MBID 가 두 곡에 생겨
-- 나중에 악장으로 해소할 때 모호해진다.

UPDATE piece_identifiers identifier
JOIN (
    SELECT 13964 AS seed, 10 AS manual, 'bd511c33-29d3-332d-b2b7-7753d3cf42af' AS mbid
    UNION ALL SELECT 13814, 12, '4e4b97df-403a-4a27-b9fa-5bd8a8333604'
) pair ON pair.seed = identifier.piece_id
      AND identifier.namespace = 'musicbrainz_work'
      AND identifier.external_id = pair.mbid
SET identifier.piece_id = pair.manual
WHERE NOT EXISTS (
    SELECT 1 FROM (
        SELECT piece_id, namespace FROM piece_identifiers
    ) existing
    WHERE existing.piece_id = pair.manual AND existing.namespace = 'musicbrainz_work'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 21 AS p, 'musicbrainz_work' AS n, '426b7e1c-68e7-42cf-9cae-4ba34feddf67' AS v
    UNION ALL SELECT 28, 'musicbrainz_work', '87886dcf-9776-49cb-b6f5-10104da6e42c'
    UNION ALL SELECT 47, 'musicbrainz_work', 'fc35bfba-5e0d-3de4-bbeb-93af627aa8b6'
    UNION ALL SELECT 167, 'musicbrainz_work', 'adeb0cf7-4f03-4781-87e5-a9228fdb02a3'
    UNION ALL SELECT 212, 'musicbrainz_work', 'b3e15438-61c0-4357-aba9-f05e29bb639d'
    UNION ALL SELECT 253, 'musicbrainz_work', '640d92c6-7a12-38ca-a331-ac4ccf420536'
    UNION ALL SELECT 266, 'musicbrainz_work', '8abd4aec-5d22-3d22-84d2-7f70a54989a4'
    UNION ALL SELECT 432, 'musicbrainz_work', 'bb71e7f6-8cd0-37fa-8eef-dac459e03a09'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = incoming.n AND taken.external_id = incoming.v
);
