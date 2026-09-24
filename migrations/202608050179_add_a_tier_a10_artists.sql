-- A tier A10 배치에 필요한 피아니스트 2명을 추가한다.
--   루돌프 피르쿠슈니 · 모라 림파니
--
-- 드보르자크 유모레스크 7번(piece 201)에 쓴다. 이 곡은 **편곡이 원곡을 덮은 곡**이다.
-- MusicBrainz 의 동명 work 열한 건이 전부 크라이슬러·하이페츠·왁스먼·엘만의
-- 바이올린 편곡이고, 검색 상위도 바이올린·첼로·비올라 편곡이 차지한다. 배급 표기에
-- `Piano: <연주자>` 가 박힌 피아노 독주 원곡만 골랐다.
--
-- **이미 등록된 피아니스트 중 이 곡 녹음이 있는 사람은 바렌보임뿐이었다.**
-- 검색을 네 번 돌렸고 나머지 후보(티파니 푼·레너드 페나리오·이보 카하네크·
-- 줄리언 제이컵슨)도 전부 미등록이다.
--
-- 피르쿠슈니는 미국·체코슬로바키아 국적을 함께 갖고 있어 출생지를 따라 체코로,
-- 림파니는 두 표기가 모두 영국이라 United Kingdom 으로 적었다.
--
-- 202608050070 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b3cb7498-cd18-5d24-8c35-17bbb4190b67', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b3cb7498-cd18-5d24-8c35-17bbb4190b67');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b3cb7498-cd18-5d24-8c35-17bbb4190b67', 'en', 'canonical', 'Rudolf Firkušný', 'rudolf firkušný', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b3cb7498-cd18-5d24-8c35-17bbb4190b67' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b3cb7498-cd18-5d24-8c35-17bbb4190b67', 'ko', 'canonical', '루돌프 피르쿠슈니', '루돌프 피르쿠슈니', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b3cb7498-cd18-5d24-8c35-17bbb4190b67' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b3cb7498-cd18-5d24-8c35-17bbb4190b67' AS a, 'gnd' AS n, '119297647' AS v UNION ALL SELECT 'b3cb7498-cd18-5d24-8c35-17bbb4190b67' AS a, 'isni' AS n, '000000011084650X' AS v UNION ALL SELECT 'b3cb7498-cd18-5d24-8c35-17bbb4190b67' AS a, 'musicbrainz_artist' AS n, '93d4913c-a766-4751-908a-a2706576e347' AS v UNION ALL SELECT 'b3cb7498-cd18-5d24-8c35-17bbb4190b67' AS a, 'viaf' AS n, '114141339' AS v UNION ALL SELECT 'b3cb7498-cd18-5d24-8c35-17bbb4190b67' AS a, 'wikidata' AS n, 'Q2142506' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '루돌프 피르쿠슈니', 'Rudolf Firkušný', 'pianist', 'A', '1912', 'Czechia', 'b3cb7498-cd18-5d24-8c35-17bbb4190b67', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'b3cb7498-cd18-5d24-8c35-17bbb4190b67');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '214ffdc1-5530-5817-98ea-a6fe5a8acade', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '214ffdc1-5530-5817-98ea-a6fe5a8acade');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '214ffdc1-5530-5817-98ea-a6fe5a8acade', 'en', 'canonical', 'Moura Lympany', 'moura lympany', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '214ffdc1-5530-5817-98ea-a6fe5a8acade' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '214ffdc1-5530-5817-98ea-a6fe5a8acade', 'ko', 'canonical', '모라 림파니', '모라 림파니', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '214ffdc1-5530-5817-98ea-a6fe5a8acade' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '214ffdc1-5530-5817-98ea-a6fe5a8acade' AS a, 'gnd' AS n, '119101327' AS v UNION ALL SELECT '214ffdc1-5530-5817-98ea-a6fe5a8acade' AS a, 'isni' AS n, '0000000114630490' AS v UNION ALL SELECT '214ffdc1-5530-5817-98ea-a6fe5a8acade' AS a, 'musicbrainz_artist' AS n, 'b0b2c58a-d983-4a8e-a779-66e08dbd4591' AS v UNION ALL SELECT '214ffdc1-5530-5817-98ea-a6fe5a8acade' AS a, 'viaf' AS n, '104144567' AS v UNION ALL SELECT '214ffdc1-5530-5817-98ea-a6fe5a8acade' AS a, 'wikidata' AS n, 'Q435639' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '모라 림파니', 'Moura Lympany', 'pianist', 'A', '1916', 'United Kingdom', '214ffdc1-5530-5817-98ea-a6fe5a8acade', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '214ffdc1-5530-5817-98ea-a6fe5a8acade');

