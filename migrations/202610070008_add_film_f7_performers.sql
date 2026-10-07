-- 영화 속 클래식 7차(film-f7) BWV 147 10곡 코랄 연주 셋에 필요한 지휘자·악단·합창단 넷을 등록한다.
--
--   잉글리시 바로크 솔로이스츠 (English Baroque Soloists, Q1342808) — 가디너 판 악단
--   퇼츠 소년합창단 (Tölzer Knabenchor, Q565939) — 아르농쿠르 판 합창단
--   필리프 헤레베허 (Philippe Herreweghe, Q168039) — 지휘자
--   콜레기움 보칼레 겐트 (Collegium Vocale Gent, Q1109305) — 헤레베허 판 합창단
--
-- 등록 확인 세 단계(05-pitfalls.md): 앞의 셋은 wikidata·gnd·isni·musicbrainz·viaf·lccn 어디로도
-- artists·external_identifiers 에 걸리는 것이 없어 엔티티부터 만든다(id 는 식별자 집합의 uuid5, 202610070001 과 같은 규칙).
-- 콜레기움 보칼레 겐트는 국제 시드가 만든 엔티티(37251d7c-…)가 이미 있고 artists 행만 없어
-- 한국어 이름·빠진 lccn·artists 행만 더한다. 이름으로 겹치는 artists 행은 없다.

-- 잉글리시 바로크 솔로이스츠 (English Baroque Soloists, Q1342808) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '12faddfd-00bb-5918-8718-ee75a93f18f2', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '12faddfd-00bb-5918-8718-ee75a93f18f2');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '12faddfd-00bb-5918-8718-ee75a93f18f2', 'en', 'canonical', 'English Baroque Soloists', 'english baroque soloists', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '12faddfd-00bb-5918-8718-ee75a93f18f2' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '12faddfd-00bb-5918-8718-ee75a93f18f2', 'ko', 'canonical', '잉글리시 바로크 솔로이스츠', '잉글리시 바로크 솔로이스츠', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '12faddfd-00bb-5918-8718-ee75a93f18f2' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '12faddfd-00bb-5918-8718-ee75a93f18f2' AS a, 'gnd' AS n, '802256-2' AS v UNION ALL SELECT '12faddfd-00bb-5918-8718-ee75a93f18f2' AS a, 'isni' AS n, '0000000119573608' AS v UNION ALL SELECT '12faddfd-00bb-5918-8718-ee75a93f18f2' AS a, 'lccn' AS n, 'n81063051' AS v UNION ALL SELECT '12faddfd-00bb-5918-8718-ee75a93f18f2' AS a, 'musicbrainz_artist' AS n, 'bae23557-5de4-4510-9234-caea078c34b4' AS v UNION ALL SELECT '12faddfd-00bb-5918-8718-ee75a93f18f2' AS a, 'viaf' AS n, '146102661' AS v UNION ALL SELECT '12faddfd-00bb-5918-8718-ee75a93f18f2' AS a, 'wikidata' AS n, 'Q1342808' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '잉글리시 바로크 솔로이스츠', 'English Baroque Soloists', 'orchestra', 'A', '1978', 'United Kingdom', '12faddfd-00bb-5918-8718-ee75a93f18f2', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '12faddfd-00bb-5918-8718-ee75a93f18f2');

-- 퇼츠 소년합창단 (Tölzer Knabenchor, Q565939) · choir

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '130ab3a4-23b5-52fe-afd7-b92dccb2b137', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '130ab3a4-23b5-52fe-afd7-b92dccb2b137');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '130ab3a4-23b5-52fe-afd7-b92dccb2b137', 'en', 'canonical', 'Tölzer Knabenchor', 'tölzer knabenchor', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '130ab3a4-23b5-52fe-afd7-b92dccb2b137' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '130ab3a4-23b5-52fe-afd7-b92dccb2b137', 'ko', 'canonical', '퇼츠 소년합창단', '퇼츠 소년합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '130ab3a4-23b5-52fe-afd7-b92dccb2b137' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '130ab3a4-23b5-52fe-afd7-b92dccb2b137' AS a, 'gnd' AS n, '815203-2' AS v UNION ALL SELECT '130ab3a4-23b5-52fe-afd7-b92dccb2b137' AS a, 'isni' AS n, '0000000109400279' AS v UNION ALL SELECT '130ab3a4-23b5-52fe-afd7-b92dccb2b137' AS a, 'lccn' AS n, 'n81089320' AS v UNION ALL SELECT '130ab3a4-23b5-52fe-afd7-b92dccb2b137' AS a, 'musicbrainz_artist' AS n, '5d0be92a-f79e-4ea9-a61a-493b5573eece' AS v UNION ALL SELECT '130ab3a4-23b5-52fe-afd7-b92dccb2b137' AS a, 'viaf' AS n, '121660375' AS v UNION ALL SELECT '130ab3a4-23b5-52fe-afd7-b92dccb2b137' AS a, 'wikidata' AS n, 'Q565939' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '퇼츠 소년합창단', 'Tölzer Knabenchor', 'choir', 'B', '1956', 'Germany', '130ab3a4-23b5-52fe-afd7-b92dccb2b137', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '130ab3a4-23b5-52fe-afd7-b92dccb2b137');

-- 필리프 헤레베허 (Philippe Herreweghe, Q168039) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1', 'en', 'canonical', 'Philippe Herreweghe', 'philippe herreweghe', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1', 'ko', 'canonical', '필리프 헤레베허', '필리프 헤레베허', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1' AS a, 'gnd' AS n, '12306385X' AS v UNION ALL SELECT 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1' AS a, 'isni' AS n, '0000000116489531' AS v UNION ALL SELECT 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1' AS a, 'lccn' AS n, 'n78072449' AS v UNION ALL SELECT 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1' AS a, 'musicbrainz_artist' AS n, '411bdab3-0606-46ef-81c6-92390211fc6e' AS v UNION ALL SELECT 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1' AS a, 'viaf' AS n, '56796410' AS v UNION ALL SELECT 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1' AS a, 'wikidata' AS n, 'Q168039' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '필리프 헤레베허', 'Philippe Herreweghe', 'conductor', 'A', '1947', 'Belgium', 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'ac7f3b46-c314-5403-bb70-9f8c5b90cbc1');

-- 콜레기움 보칼레 겐트 (Collegium Vocale Gent, Q1109305) · choir

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '37251d7c-ce1e-56a1-9f7c-9e4f9ea0d7e9', 'en', 'canonical', 'Collegium Vocale Gent', 'collegium vocale gent', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '37251d7c-ce1e-56a1-9f7c-9e4f9ea0d7e9' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '37251d7c-ce1e-56a1-9f7c-9e4f9ea0d7e9', 'ko', 'canonical', '콜레기움 보칼레 겐트', '콜레기움 보칼레 겐트', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '37251d7c-ce1e-56a1-9f7c-9e4f9ea0d7e9' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '37251d7c-ce1e-56a1-9f7c-9e4f9ea0d7e9' AS a, 'gnd' AS n, '811824-3' AS v UNION ALL SELECT '37251d7c-ce1e-56a1-9f7c-9e4f9ea0d7e9' AS a, 'isni' AS n, '000000012353867X' AS v UNION ALL SELECT '37251d7c-ce1e-56a1-9f7c-9e4f9ea0d7e9' AS a, 'lccn' AS n, 'n78072448' AS v UNION ALL SELECT '37251d7c-ce1e-56a1-9f7c-9e4f9ea0d7e9' AS a, 'musicbrainz_artist' AS n, '95790653-fbba-495b-8701-c857a815880d' AS v UNION ALL SELECT '37251d7c-ce1e-56a1-9f7c-9e4f9ea0d7e9' AS a, 'viaf' AS n, '158969113' AS v UNION ALL SELECT '37251d7c-ce1e-56a1-9f7c-9e4f9ea0d7e9' AS a, 'wikidata' AS n, 'Q1109305' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '콜레기움 보칼레 겐트', 'Collegium Vocale Gent', 'choir', 'A', '1970', 'Belgium', '37251d7c-ce1e-56a1-9f7c-9e4f9ea0d7e9', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '37251d7c-ce1e-56a1-9f7c-9e4f9ea0d7e9');
