-- A tier A24 배치에 필요한 인물·단체 일곱 곳을 추가한다.
--   지휘  미하엘 길렌
--   피아노 피에르로랑 에마르
--   악단  SWR 바덴바덴·프라이부르크 교향악단 · 댈러스 심포니 오케스트라
--   합창  댈러스 심포니 합창단 · 샌프란시스코 심포니 합창단 · 탱글우드 페스티벌 합창단
--
-- 아이브스 <대답 없는 질문>(370) · 교향곡 4번(371) · 콩코드 소나타(372)에 쓴다.
--
-- **371 교향곡 4번은 1악장 Prelude 에 합창이 든다.** 합창단 셋을 처음부터 넣었다 —
-- A12 의 천인 교향곡에서 빠뜨려 나중에 보탠 일이 있었다.
--
-- **길렌은 370 에서 슬래트킨을 교체한 자리다.** 슬래트킨이 낀 두 쌍만 임계를 넘었고
-- (0.1465 · 0.1310, 나머지 한 쌍은 0.0905) 회전 최저가 0반음이고 시작점 훑기가
-- 평평했다. "한 연주만 바깥" 모양이라 교체했다. 사유는 202608050204 에 적는다.
--
-- SWR 악단의 wikidata 영어 라벨은 'Southwest German Radio Symphony Orchestra' 이고
-- 한국어 라벨은 '바덴바덴과 프라이부르크…' 로 잘려 있다. 배급 표기에 쓰이는 이름인
-- SWR Sinfonieorchester Baden-Baden und Freiburg 로 적었다 — 식별자가 QID 이므로
-- 표기 차이는 문제가 되지 않는다.
--
-- 댈러스 심포니 합창단과 탱글우드 페스티벌 합창단은 wikidata 에 나라 진술이 없어
-- 미국으로 적었다. 에마르 외에는 한국어 라벨이 없거나 잘려 있어 한글 이름을 직접 적었다.
--
-- 일곱 다 항목이 충실하다(클레임 19~117개).
--
-- 202608050200 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '9df0b6e9-7133-5507-a16a-b916a31c7264', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '9df0b6e9-7133-5507-a16a-b916a31c7264');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9df0b6e9-7133-5507-a16a-b916a31c7264', 'en', 'canonical', 'Michael Gielen', 'michael gielen', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9df0b6e9-7133-5507-a16a-b916a31c7264' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9df0b6e9-7133-5507-a16a-b916a31c7264', 'ko', 'canonical', '미하엘 길렌', '미하엘 길렌', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9df0b6e9-7133-5507-a16a-b916a31c7264' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '9df0b6e9-7133-5507-a16a-b916a31c7264' AS a, 'gnd' AS n, '118539159' AS v UNION ALL SELECT '9df0b6e9-7133-5507-a16a-b916a31c7264' AS a, 'isni' AS n, '0000000108854658' AS v UNION ALL SELECT '9df0b6e9-7133-5507-a16a-b916a31c7264' AS a, 'musicbrainz_artist' AS n, 'bc3d8e10-1959-4e95-a903-3fc4616836c2' AS v UNION ALL SELECT '9df0b6e9-7133-5507-a16a-b916a31c7264' AS a, 'viaf' AS n, '32183244' AS v UNION ALL SELECT '9df0b6e9-7133-5507-a16a-b916a31c7264' AS a, 'wikidata' AS n, 'Q213913' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '미하엘 길렌', 'Michael Gielen', 'conductor', 'A', '1927', 'Austria', '9df0b6e9-7133-5507-a16a-b916a31c7264', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '9df0b6e9-7133-5507-a16a-b916a31c7264');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '4597f78f-1763-5ef8-80ca-32c911a37fc7', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '4597f78f-1763-5ef8-80ca-32c911a37fc7');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4597f78f-1763-5ef8-80ca-32c911a37fc7', 'en', 'canonical', 'Pierre-Laurent Aimard', 'pierre-laurent aimard', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4597f78f-1763-5ef8-80ca-32c911a37fc7' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4597f78f-1763-5ef8-80ca-32c911a37fc7', 'ko', 'canonical', '피에르로랑 에마르', '피에르로랑 에마르', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4597f78f-1763-5ef8-80ca-32c911a37fc7' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '4597f78f-1763-5ef8-80ca-32c911a37fc7' AS a, 'gnd' AS n, '123682827' AS v UNION ALL SELECT '4597f78f-1763-5ef8-80ca-32c911a37fc7' AS a, 'isni' AS n, '0000000110425983' AS v UNION ALL SELECT '4597f78f-1763-5ef8-80ca-32c911a37fc7' AS a, 'musicbrainz_artist' AS n, 'bfc4370b-c0d9-46c7-825b-bf09f9b65264' AS v UNION ALL SELECT '4597f78f-1763-5ef8-80ca-32c911a37fc7' AS a, 'viaf' AS n, '19864363' AS v UNION ALL SELECT '4597f78f-1763-5ef8-80ca-32c911a37fc7' AS a, 'wikidata' AS n, 'Q561097' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '피에르로랑 에마르', 'Pierre-Laurent Aimard', 'pianist', 'A', '1957', 'France', '4597f78f-1763-5ef8-80ca-32c911a37fc7', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '4597f78f-1763-5ef8-80ca-32c911a37fc7');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '6e896418-2ef4-57bc-831c-3aa97dcd9c70', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '6e896418-2ef4-57bc-831c-3aa97dcd9c70');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6e896418-2ef4-57bc-831c-3aa97dcd9c70', 'en', 'canonical', 'SWR Sinfonieorchester Baden-Baden und Freiburg', 'swr sinfonieorchester baden-baden und freiburg', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6e896418-2ef4-57bc-831c-3aa97dcd9c70' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6e896418-2ef4-57bc-831c-3aa97dcd9c70', 'ko', 'canonical', 'SWR 바덴바덴·프라이부르크 교향악단', 'swr 바덴바덴·프라이부르크 교향악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6e896418-2ef4-57bc-831c-3aa97dcd9c70' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '6e896418-2ef4-57bc-831c-3aa97dcd9c70' AS a, 'gnd' AS n, '5297665-8' AS v UNION ALL SELECT '6e896418-2ef4-57bc-831c-3aa97dcd9c70' AS a, 'isni' AS n, '0000000472125013' AS v UNION ALL SELECT '6e896418-2ef4-57bc-831c-3aa97dcd9c70' AS a, 'musicbrainz_artist' AS n, 'abba0820-a20e-407f-84ff-2c53dacb3cea' AS v UNION ALL SELECT '6e896418-2ef4-57bc-831c-3aa97dcd9c70' AS a, 'viaf' AS n, '144910849' AS v UNION ALL SELECT '6e896418-2ef4-57bc-831c-3aa97dcd9c70' AS a, 'viaf' AS n, '150983356' AS v UNION ALL SELECT '6e896418-2ef4-57bc-831c-3aa97dcd9c70' AS a, 'viaf' AS n, '160226972' AS v UNION ALL SELECT '6e896418-2ef4-57bc-831c-3aa97dcd9c70' AS a, 'viaf' AS n, '4496149296198680670001' AS v UNION ALL SELECT '6e896418-2ef4-57bc-831c-3aa97dcd9c70' AS a, 'wikidata' AS n, 'Q700103' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT 'SWR 바덴바덴·프라이부르크 교향악단', 'SWR Sinfonieorchester Baden-Baden und Freiburg', 'orchestra', 'A', '1946', 'Germany', '6e896418-2ef4-57bc-831c-3aa97dcd9c70', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '6e896418-2ef4-57bc-831c-3aa97dcd9c70');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f96971e4-7bf5-5e2e-a87f-f35cee3b294a', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f96971e4-7bf5-5e2e-a87f-f35cee3b294a');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f96971e4-7bf5-5e2e-a87f-f35cee3b294a', 'en', 'canonical', 'Dallas Symphony Orchestra', 'dallas symphony orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f96971e4-7bf5-5e2e-a87f-f35cee3b294a' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f96971e4-7bf5-5e2e-a87f-f35cee3b294a', 'ko', 'canonical', '댈러스 심포니 오케스트라', '댈러스 심포니 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f96971e4-7bf5-5e2e-a87f-f35cee3b294a' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'f96971e4-7bf5-5e2e-a87f-f35cee3b294a' AS a, 'gnd' AS n, '804901-4' AS v UNION ALL SELECT 'f96971e4-7bf5-5e2e-a87f-f35cee3b294a' AS a, 'isni' AS n, '0000000404368160' AS v UNION ALL SELECT 'f96971e4-7bf5-5e2e-a87f-f35cee3b294a' AS a, 'musicbrainz_artist' AS n, 'e7636d63-65e4-492d-bc57-2ab552df4d57' AS v UNION ALL SELECT 'f96971e4-7bf5-5e2e-a87f-f35cee3b294a' AS a, 'viaf' AS n, '132657488' AS v UNION ALL SELECT 'f96971e4-7bf5-5e2e-a87f-f35cee3b294a' AS a, 'wikidata' AS n, 'Q597572' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '댈러스 심포니 오케스트라', 'Dallas Symphony Orchestra', 'orchestra', 'A', '1900', 'United States', 'f96971e4-7bf5-5e2e-a87f-f35cee3b294a', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'f96971e4-7bf5-5e2e-a87f-f35cee3b294a');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '9b5fb2e6-c500-5ebc-bb74-73e810ef568c', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '9b5fb2e6-c500-5ebc-bb74-73e810ef568c');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9b5fb2e6-c500-5ebc-bb74-73e810ef568c', 'en', 'canonical', 'Dallas Symphony Chorus', 'dallas symphony chorus', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9b5fb2e6-c500-5ebc-bb74-73e810ef568c' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9b5fb2e6-c500-5ebc-bb74-73e810ef568c', 'ko', 'canonical', '댈러스 심포니 합창단', '댈러스 심포니 합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9b5fb2e6-c500-5ebc-bb74-73e810ef568c' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '9b5fb2e6-c500-5ebc-bb74-73e810ef568c' AS a, 'gnd' AS n, '16037762-6' AS v UNION ALL SELECT '9b5fb2e6-c500-5ebc-bb74-73e810ef568c' AS a, 'isni' AS n, '000000011940031X' AS v UNION ALL SELECT '9b5fb2e6-c500-5ebc-bb74-73e810ef568c' AS a, 'musicbrainz_artist' AS n, 'b8f8333a-0452-4e2c-affb-c256394cb082' AS v UNION ALL SELECT '9b5fb2e6-c500-5ebc-bb74-73e810ef568c' AS a, 'viaf' AS n, '134764166' AS v UNION ALL SELECT '9b5fb2e6-c500-5ebc-bb74-73e810ef568c' AS a, 'wikidata' AS n, 'Q5211422' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '댈러스 심포니 합창단', 'Dallas Symphony Chorus', 'choir', 'A', '1977', 'United States', '9b5fb2e6-c500-5ebc-bb74-73e810ef568c', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '9b5fb2e6-c500-5ebc-bb74-73e810ef568c');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'bf70d692-c34a-5d97-a07b-ff24cbb3ab2f', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'bf70d692-c34a-5d97-a07b-ff24cbb3ab2f');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bf70d692-c34a-5d97-a07b-ff24cbb3ab2f', 'en', 'canonical', 'San Francisco Symphony Chorus', 'san francisco symphony chorus', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bf70d692-c34a-5d97-a07b-ff24cbb3ab2f' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bf70d692-c34a-5d97-a07b-ff24cbb3ab2f', 'ko', 'canonical', '샌프란시스코 심포니 합창단', '샌프란시스코 심포니 합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bf70d692-c34a-5d97-a07b-ff24cbb3ab2f' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'bf70d692-c34a-5d97-a07b-ff24cbb3ab2f' AS a, 'gnd' AS n, '5124824-4' AS v UNION ALL SELECT 'bf70d692-c34a-5d97-a07b-ff24cbb3ab2f' AS a, 'isni' AS n, '0000000106716198' AS v UNION ALL SELECT 'bf70d692-c34a-5d97-a07b-ff24cbb3ab2f' AS a, 'musicbrainz_artist' AS n, '568d7c51-0573-4c65-9211-65bf8c8470c7' AS v UNION ALL SELECT 'bf70d692-c34a-5d97-a07b-ff24cbb3ab2f' AS a, 'viaf' AS n, '149068103' AS v UNION ALL SELECT 'bf70d692-c34a-5d97-a07b-ff24cbb3ab2f' AS a, 'wikidata' AS n, 'Q7414119' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '샌프란시스코 심포니 합창단', 'San Francisco Symphony Chorus', 'choir', 'A', '1972', 'United States', 'bf70d692-c34a-5d97-a07b-ff24cbb3ab2f', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'bf70d692-c34a-5d97-a07b-ff24cbb3ab2f');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f96fed61-c5b6-5cbc-8cac-7a4f72459fba', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f96fed61-c5b6-5cbc-8cac-7a4f72459fba');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f96fed61-c5b6-5cbc-8cac-7a4f72459fba', 'en', 'canonical', 'Tanglewood Festival Chorus', 'tanglewood festival chorus', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f96fed61-c5b6-5cbc-8cac-7a4f72459fba' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f96fed61-c5b6-5cbc-8cac-7a4f72459fba', 'ko', 'canonical', '탱글우드 페스티벌 합창단', '탱글우드 페스티벌 합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f96fed61-c5b6-5cbc-8cac-7a4f72459fba' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'f96fed61-c5b6-5cbc-8cac-7a4f72459fba' AS a, 'isni' AS n, '0000000119549114' AS v UNION ALL SELECT 'f96fed61-c5b6-5cbc-8cac-7a4f72459fba' AS a, 'musicbrainz_artist' AS n, 'd8002af8-7959-4cd5-95a0-eeadb2a638c7' AS v UNION ALL SELECT 'f96fed61-c5b6-5cbc-8cac-7a4f72459fba' AS a, 'viaf' AS n, '123297669' AS v UNION ALL SELECT 'f96fed61-c5b6-5cbc-8cac-7a4f72459fba' AS a, 'wikidata' AS n, 'Q7683038' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '탱글우드 페스티벌 합창단', 'Tanglewood Festival Chorus', 'choir', 'A', '1970', 'United States', 'f96fed61-c5b6-5cbc-8cac-7a4f72459fba', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'f96fed61-c5b6-5cbc-8cac-7a4f72459fba');

