-- 1라운드 협주곡 2곡(하이든 트럼펫 협주곡 3악장, 모차르트 호른 협주곡 4번 론도)에 필요한
-- 독주자 6명, 지휘자 4명, 악단 2곳을 추가한다.
--
-- 202608050065 와 같은 방식이다. authority_entities.id 는 강한 식별자를 정렬해 이은
-- 문자열의 uuid5 다. Wikidata 에 값이 여럿인 식별자는 모두 넣었다. 협주곡 크레딧은
-- 독주자 → 지휘자 → 악단 순이고, 영상 설명에 적힌 이름만 근거로 삼았다.
--
-- 모리스 앙드레의 Wikidata 영문 라벨은 "Maurice Andrés" 로 잘못 적혀 있어 바로잡았다.
-- 벤 골드샤이더는 Wikidata 에 국적과 외부 식별자가 없다. 국적은 음반사(PENTATONE)
-- 소개의 영국 호른 연주자를 따랐고 식별자는 wikidata 하나뿐이다.
-- 트럼펫 연주자는 처음 들어오므로 분류를 trumpeter 로 새로 쓴다.
-- 한국어 라벨이 없는 곳은 음역했다.
--
-- 같은 라운드의 쇼스타코비치 피아노 협주곡 2번(piece 458)은 MBID 가 국제 시드 곡
-- (piece 12515)에 이미 붙어 있어 보류했다. 그 곡에만 필요한 연주자는 넣지 않는다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '4e63d4da-7e2e-5616-a8c3-4d6299340c83', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '4e63d4da-7e2e-5616-a8c3-4d6299340c83');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4e63d4da-7e2e-5616-a8c3-4d6299340c83', 'en', 'canonical', 'Wynton Marsalis', 'wynton marsalis', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4e63d4da-7e2e-5616-a8c3-4d6299340c83' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4e63d4da-7e2e-5616-a8c3-4d6299340c83', 'ko', 'canonical', '윈턴 마샐리스', '윈턴 마샐리스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4e63d4da-7e2e-5616-a8c3-4d6299340c83' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '4e63d4da-7e2e-5616-a8c3-4d6299340c83' AS a, 'gnd' AS n, '119425815' AS v UNION ALL SELECT '4e63d4da-7e2e-5616-a8c3-4d6299340c83' AS a, 'gnd' AS n, '1243188308' AS v UNION ALL SELECT '4e63d4da-7e2e-5616-a8c3-4d6299340c83' AS a, 'isni' AS n, '0000000080969276' AS v UNION ALL SELECT '4e63d4da-7e2e-5616-a8c3-4d6299340c83' AS a, 'isni' AS n, '0000000368492550' AS v UNION ALL SELECT '4e63d4da-7e2e-5616-a8c3-4d6299340c83' AS a, 'musicbrainz_artist' AS n, '0d74dcc7-5684-4695-830f-a9846aad8ba9' AS v UNION ALL SELECT '4e63d4da-7e2e-5616-a8c3-4d6299340c83' AS a, 'viaf' AS n, '17408121' AS v UNION ALL SELECT '4e63d4da-7e2e-5616-a8c3-4d6299340c83' AS a, 'wikidata' AS n, 'Q273076' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '윈턴 마샐리스', 'Wynton Marsalis', 'trumpeter', 'A', '1961', 'United States', '4e63d4da-7e2e-5616-a8c3-4d6299340c83', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '4e63d4da-7e2e-5616-a8c3-4d6299340c83');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '99d5b260-a338-55da-a57c-5aad98d43b65', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '99d5b260-a338-55da-a57c-5aad98d43b65');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '99d5b260-a338-55da-a57c-5aad98d43b65', 'en', 'canonical', 'Adolph Herseth', 'adolph herseth', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '99d5b260-a338-55da-a57c-5aad98d43b65' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '99d5b260-a338-55da-a57c-5aad98d43b65', 'ko', 'canonical', '아돌프 허세스', '아돌프 허세스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '99d5b260-a338-55da-a57c-5aad98d43b65' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '99d5b260-a338-55da-a57c-5aad98d43b65' AS a, 'gnd' AS n, '133169707' AS v UNION ALL SELECT '99d5b260-a338-55da-a57c-5aad98d43b65' AS a, 'isni' AS n, '0000000063210807' AS v UNION ALL SELECT '99d5b260-a338-55da-a57c-5aad98d43b65' AS a, 'musicbrainz_artist' AS n, '2fd37423-3910-46cb-b306-4b7ed1cf9332' AS v UNION ALL SELECT '99d5b260-a338-55da-a57c-5aad98d43b65' AS a, 'viaf' AS n, '11027564' AS v UNION ALL SELECT '99d5b260-a338-55da-a57c-5aad98d43b65' AS a, 'wikidata' AS n, 'Q365397' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '아돌프 허세스', 'Adolph Herseth', 'trumpeter', 'B', '1921', 'United States', '99d5b260-a338-55da-a57c-5aad98d43b65', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '99d5b260-a338-55da-a57c-5aad98d43b65');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '2eafb265-fc06-578f-ac19-20cc543d9cf1', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '2eafb265-fc06-578f-ac19-20cc543d9cf1');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2eafb265-fc06-578f-ac19-20cc543d9cf1', 'en', 'canonical', 'Maurice André', 'maurice andré', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2eafb265-fc06-578f-ac19-20cc543d9cf1' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2eafb265-fc06-578f-ac19-20cc543d9cf1', 'ko', 'canonical', '모리스 앙드레', '모리스 앙드레', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2eafb265-fc06-578f-ac19-20cc543d9cf1' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '2eafb265-fc06-578f-ac19-20cc543d9cf1' AS a, 'gnd' AS n, '124629776' AS v UNION ALL SELECT '2eafb265-fc06-578f-ac19-20cc543d9cf1' AS a, 'isni' AS n, '0000000083981094' AS v UNION ALL SELECT '2eafb265-fc06-578f-ac19-20cc543d9cf1' AS a, 'musicbrainz_artist' AS n, '24568d6a-34bb-44a0-8379-423709aa8ef0' AS v UNION ALL SELECT '2eafb265-fc06-578f-ac19-20cc543d9cf1' AS a, 'viaf' AS n, '84561594' AS v UNION ALL SELECT '2eafb265-fc06-578f-ac19-20cc543d9cf1' AS a, 'wikidata' AS n, 'Q153432' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '모리스 앙드레', 'Maurice André', 'trumpeter', 'A', '1933', 'France', '2eafb265-fc06-578f-ac19-20cc543d9cf1', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '2eafb265-fc06-578f-ac19-20cc543d9cf1');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '1d7d5b44-a69a-5cf6-9e4f-a453bc481362', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '1d7d5b44-a69a-5cf6-9e4f-a453bc481362');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1d7d5b44-a69a-5cf6-9e4f-a453bc481362', 'en', 'canonical', 'Raymond Leppard', 'raymond leppard', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1d7d5b44-a69a-5cf6-9e4f-a453bc481362' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1d7d5b44-a69a-5cf6-9e4f-a453bc481362', 'ko', 'canonical', '레이먼드 레파드', '레이먼드 레파드', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1d7d5b44-a69a-5cf6-9e4f-a453bc481362' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '1d7d5b44-a69a-5cf6-9e4f-a453bc481362' AS a, 'gnd' AS n, '103984100' AS v UNION ALL SELECT '1d7d5b44-a69a-5cf6-9e4f-a453bc481362' AS a, 'isni' AS n, '0000000114767665' AS v UNION ALL SELECT '1d7d5b44-a69a-5cf6-9e4f-a453bc481362' AS a, 'musicbrainz_artist' AS n, '903e2bc4-00a1-4f53-98ef-13dde0b81a2c' AS v UNION ALL SELECT '1d7d5b44-a69a-5cf6-9e4f-a453bc481362' AS a, 'viaf' AS n, '85902840' AS v UNION ALL SELECT '1d7d5b44-a69a-5cf6-9e4f-a453bc481362' AS a, 'wikidata' AS n, 'Q720702' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '레이먼드 레파드', 'Raymond Leppard', 'conductor', 'B', '1927', 'United Kingdom', '1d7d5b44-a69a-5cf6-9e4f-a453bc481362', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '1d7d5b44-a69a-5cf6-9e4f-a453bc481362');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '7fdd0ffc-338a-5bda-b857-f79209e3dd84', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '7fdd0ffc-338a-5bda-b857-f79209e3dd84');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7fdd0ffc-338a-5bda-b857-f79209e3dd84', 'en', 'canonical', 'Claudio Abbado', 'claudio abbado', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7fdd0ffc-338a-5bda-b857-f79209e3dd84' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7fdd0ffc-338a-5bda-b857-f79209e3dd84', 'ko', 'canonical', '클라우디오 아바도', '클라우디오 아바도', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7fdd0ffc-338a-5bda-b857-f79209e3dd84' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '7fdd0ffc-338a-5bda-b857-f79209e3dd84' AS a, 'gnd' AS n, '119150700' AS v UNION ALL SELECT '7fdd0ffc-338a-5bda-b857-f79209e3dd84' AS a, 'isni' AS n, '0000000120959719' AS v UNION ALL SELECT '7fdd0ffc-338a-5bda-b857-f79209e3dd84' AS a, 'musicbrainz_artist' AS n, '39e84597-3e0f-4ccc-89d2-6ee1dd6fb050' AS v UNION ALL SELECT '7fdd0ffc-338a-5bda-b857-f79209e3dd84' AS a, 'viaf' AS n, '39560822' AS v UNION ALL SELECT '7fdd0ffc-338a-5bda-b857-f79209e3dd84' AS a, 'wikidata' AS n, 'Q151608' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '클라우디오 아바도', 'Claudio Abbado', 'conductor', 'S', '1933', 'Italy', '7fdd0ffc-338a-5bda-b857-f79209e3dd84', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '7fdd0ffc-338a-5bda-b857-f79209e3dd84');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'd8623b32-a3d3-5a3f-9526-79d5dc6fff8c', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'd8623b32-a3d3-5a3f-9526-79d5dc6fff8c');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd8623b32-a3d3-5a3f-9526-79d5dc6fff8c', 'en', 'canonical', 'Hans Stadlmair', 'hans stadlmair', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd8623b32-a3d3-5a3f-9526-79d5dc6fff8c' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd8623b32-a3d3-5a3f-9526-79d5dc6fff8c', 'ko', 'canonical', '한스 슈타틀마이어', '한스 슈타틀마이어', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd8623b32-a3d3-5a3f-9526-79d5dc6fff8c' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'd8623b32-a3d3-5a3f-9526-79d5dc6fff8c' AS a, 'gnd' AS n, '124017681' AS v UNION ALL SELECT 'd8623b32-a3d3-5a3f-9526-79d5dc6fff8c' AS a, 'isni' AS n, '0000000081855123' AS v UNION ALL SELECT 'd8623b32-a3d3-5a3f-9526-79d5dc6fff8c' AS a, 'musicbrainz_artist' AS n, '3c1b2224-53b3-494a-8c63-fbc062138991' AS v UNION ALL SELECT 'd8623b32-a3d3-5a3f-9526-79d5dc6fff8c' AS a, 'viaf' AS n, '116602107' AS v UNION ALL SELECT 'd8623b32-a3d3-5a3f-9526-79d5dc6fff8c' AS a, 'wikidata' AS n, 'Q1582611' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '한스 슈타틀마이어', 'Hans Stadlmair', 'conductor', 'B', '1929', 'Austria', 'd8623b32-a3d3-5a3f-9526-79d5dc6fff8c', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'd8623b32-a3d3-5a3f-9526-79d5dc6fff8c');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '5e60b883-4be5-5b84-8e86-2b3e04ab68b3', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '5e60b883-4be5-5b84-8e86-2b3e04ab68b3');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5e60b883-4be5-5b84-8e86-2b3e04ab68b3', 'en', 'canonical', 'National Philharmonic Orchestra', 'national philharmonic orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5e60b883-4be5-5b84-8e86-2b3e04ab68b3' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5e60b883-4be5-5b84-8e86-2b3e04ab68b3', 'ko', 'canonical', '내셔널 필하모닉 오케스트라', '내셔널 필하모닉 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5e60b883-4be5-5b84-8e86-2b3e04ab68b3' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '5e60b883-4be5-5b84-8e86-2b3e04ab68b3' AS a, 'gnd' AS n, '1087184-6' AS v UNION ALL SELECT '5e60b883-4be5-5b84-8e86-2b3e04ab68b3' AS a, 'isni' AS n, '0000000121505778' AS v UNION ALL SELECT '5e60b883-4be5-5b84-8e86-2b3e04ab68b3' AS a, 'isni' AS n, '0000000122601083' AS v UNION ALL SELECT '5e60b883-4be5-5b84-8e86-2b3e04ab68b3' AS a, 'musicbrainz_artist' AS n, 'a94c0f47-7caa-42b6-b9b3-4708f6fbe7de' AS v UNION ALL SELECT '5e60b883-4be5-5b84-8e86-2b3e04ab68b3' AS a, 'viaf' AS n, '151865624' AS v UNION ALL SELECT '5e60b883-4be5-5b84-8e86-2b3e04ab68b3' AS a, 'viaf' AS n, '305860278' AS v UNION ALL SELECT '5e60b883-4be5-5b84-8e86-2b3e04ab68b3' AS a, 'wikidata' AS n, 'Q2394269' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '내셔널 필하모닉 오케스트라', 'National Philharmonic Orchestra', 'orchestra', 'B', '1964', 'United Kingdom', '5e60b883-4be5-5b84-8e86-2b3e04ab68b3', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '5e60b883-4be5-5b84-8e86-2b3e04ab68b3');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'cdbd7ee4-9596-5832-a7ec-df94f6a63052', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'cdbd7ee4-9596-5832-a7ec-df94f6a63052');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cdbd7ee4-9596-5832-a7ec-df94f6a63052', 'en', 'canonical', 'Munich Chamber Orchestra', 'munich chamber orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cdbd7ee4-9596-5832-a7ec-df94f6a63052' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cdbd7ee4-9596-5832-a7ec-df94f6a63052', 'ko', 'canonical', '뮌헨 체임버 오케스트라', '뮌헨 체임버 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cdbd7ee4-9596-5832-a7ec-df94f6a63052' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'cdbd7ee4-9596-5832-a7ec-df94f6a63052' AS a, 'gnd' AS n, '1087180-9' AS v UNION ALL SELECT 'cdbd7ee4-9596-5832-a7ec-df94f6a63052' AS a, 'isni' AS n, '0000000110921450' AS v UNION ALL SELECT 'cdbd7ee4-9596-5832-a7ec-df94f6a63052' AS a, 'musicbrainz_artist' AS n, '6cd8706c-2bf1-4406-8377-187136acb110' AS v UNION ALL SELECT 'cdbd7ee4-9596-5832-a7ec-df94f6a63052' AS a, 'viaf' AS n, '135653005' AS v UNION ALL SELECT 'cdbd7ee4-9596-5832-a7ec-df94f6a63052' AS a, 'wikidata' AS n, 'Q315242' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '뮌헨 체임버 오케스트라', 'Munich Chamber Orchestra', 'orchestra', 'B', '1950', 'Germany', 'cdbd7ee4-9596-5832-a7ec-df94f6a63052', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'cdbd7ee4-9596-5832-a7ec-df94f6a63052');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a74466ec-953f-5f70-a986-897b85f7b33f', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a74466ec-953f-5f70-a986-897b85f7b33f');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a74466ec-953f-5f70-a986-897b85f7b33f', 'en', 'canonical', 'Barry Tuckwell', 'barry tuckwell', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a74466ec-953f-5f70-a986-897b85f7b33f' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a74466ec-953f-5f70-a986-897b85f7b33f', 'ko', 'canonical', '배리 터크웰', '배리 터크웰', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a74466ec-953f-5f70-a986-897b85f7b33f' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a74466ec-953f-5f70-a986-897b85f7b33f' AS a, 'gnd' AS n, '103978747' AS v UNION ALL SELECT 'a74466ec-953f-5f70-a986-897b85f7b33f' AS a, 'isni' AS n, '0000000110863692' AS v UNION ALL SELECT 'a74466ec-953f-5f70-a986-897b85f7b33f' AS a, 'musicbrainz_artist' AS n, 'b26cef7d-29a3-42fa-8179-8e54f42c0e74' AS v UNION ALL SELECT 'a74466ec-953f-5f70-a986-897b85f7b33f' AS a, 'viaf' AS n, '120739963' AS v UNION ALL SELECT 'a74466ec-953f-5f70-a986-897b85f7b33f' AS a, 'wikidata' AS n, 'Q809108' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '배리 터크웰', 'Barry Tuckwell', 'hornist', 'A', '1931', 'Australia', 'a74466ec-953f-5f70-a986-897b85f7b33f', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a74466ec-953f-5f70-a986-897b85f7b33f');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '0074c1c9-c9ed-5c56-acdd-4184959a2032', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '0074c1c9-c9ed-5c56-acdd-4184959a2032');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0074c1c9-c9ed-5c56-acdd-4184959a2032', 'en', 'canonical', 'Günter Högner', 'günter högner', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0074c1c9-c9ed-5c56-acdd-4184959a2032' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0074c1c9-c9ed-5c56-acdd-4184959a2032', 'ko', 'canonical', '귄터 회그너', '귄터 회그너', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0074c1c9-c9ed-5c56-acdd-4184959a2032' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '0074c1c9-c9ed-5c56-acdd-4184959a2032' AS a, 'gnd' AS n, '134407768' AS v UNION ALL SELECT '0074c1c9-c9ed-5c56-acdd-4184959a2032' AS a, 'isni' AS n, '0000000055196961' AS v UNION ALL SELECT '0074c1c9-c9ed-5c56-acdd-4184959a2032' AS a, 'musicbrainz_artist' AS n, '6805012d-9fd7-44f9-9c30-8aa6bb8c6ed4' AS v UNION ALL SELECT '0074c1c9-c9ed-5c56-acdd-4184959a2032' AS a, 'viaf' AS n, '76509290' AS v UNION ALL SELECT '0074c1c9-c9ed-5c56-acdd-4184959a2032' AS a, 'wikidata' AS n, 'Q28966416' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '귄터 회그너', 'Günter Högner', 'hornist', 'B', '1943', 'Austria', '0074c1c9-c9ed-5c56-acdd-4184959a2032', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '0074c1c9-c9ed-5c56-acdd-4184959a2032');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '3f3b1ca6-ec26-5d18-9067-ba506be7e12e', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '3f3b1ca6-ec26-5d18-9067-ba506be7e12e');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3f3b1ca6-ec26-5d18-9067-ba506be7e12e', 'en', 'canonical', 'Ben Goldscheider', 'ben goldscheider', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3f3b1ca6-ec26-5d18-9067-ba506be7e12e' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3f3b1ca6-ec26-5d18-9067-ba506be7e12e', 'ko', 'canonical', '벤 골드샤이더', '벤 골드샤이더', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3f3b1ca6-ec26-5d18-9067-ba506be7e12e' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '3f3b1ca6-ec26-5d18-9067-ba506be7e12e' AS a, 'wikidata' AS n, 'Q133161275' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '벤 골드샤이더', 'Ben Goldscheider', 'hornist', 'Rising', '1997', 'United Kingdom', '3f3b1ca6-ec26-5d18-9067-ba506be7e12e', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '3f3b1ca6-ec26-5d18-9067-ba506be7e12e');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '9988cf01-fc8a-58d8-af2b-010865dea8a7', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '9988cf01-fc8a-58d8-af2b-010865dea8a7');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9988cf01-fc8a-58d8-af2b-010865dea8a7', 'en', 'canonical', 'Karl Böhm', 'karl böhm', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9988cf01-fc8a-58d8-af2b-010865dea8a7' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9988cf01-fc8a-58d8-af2b-010865dea8a7', 'ko', 'canonical', '카를 뵘', '카를 뵘', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9988cf01-fc8a-58d8-af2b-010865dea8a7' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '9988cf01-fc8a-58d8-af2b-010865dea8a7' AS a, 'gnd' AS n, '118512528' AS v UNION ALL SELECT '9988cf01-fc8a-58d8-af2b-010865dea8a7' AS a, 'isni' AS n, '0000000108635957' AS v UNION ALL SELECT '9988cf01-fc8a-58d8-af2b-010865dea8a7' AS a, 'musicbrainz_artist' AS n, '03417ebe-2f05-4a8a-ae3b-9a8a741059d5' AS v UNION ALL SELECT '9988cf01-fc8a-58d8-af2b-010865dea8a7' AS a, 'musicbrainz_artist' AS n, 'cdb34f45-c9d3-4f14-a79a-bc1da62455cc' AS v UNION ALL SELECT '9988cf01-fc8a-58d8-af2b-010865dea8a7' AS a, 'viaf' AS n, '2738761' AS v UNION ALL SELECT '9988cf01-fc8a-58d8-af2b-010865dea8a7' AS a, 'wikidata' AS n, 'Q84241' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '카를 뵘', 'Karl Böhm', 'conductor', 'S', '1894', 'Austria', '9988cf01-fc8a-58d8-af2b-010865dea8a7', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '9988cf01-fc8a-58d8-af2b-010865dea8a7');

