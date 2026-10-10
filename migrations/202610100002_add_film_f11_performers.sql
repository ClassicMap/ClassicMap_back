-- 영화 속 클래식 11차(film-f11) BWV 106 소나티나 연주에 필요한 지휘자·앙상블 둘을 등록한다.
--
--   세바스티앵 도세 (Sébastien Daucé, Q16841392) — 지휘자
--   앙상블 코레스퐁당스 (Ensemble Correspondances, Q17154333) — 도세 판 앙상블
--
-- 처음 고른 융해넬 · 칸투스 쾰른 판이 반음 높게 울려(1반음 회전에서 0.06) 이 판으로 바꿨다.
-- 융해넬·칸투스 쾰른은 202610100001 로 이미 등록돼 있어 그대로 둔다.
--
-- 등록 확인 세 단계(05-pitfalls.md): 둘 다 wikidata·gnd·isni·musicbrainz·viaf·lccn 어디로도
-- artists·external_identifiers 에 걸리는 것이 없어 엔티티부터 만든다(id 는 식별자 집합의 uuid5, 202610070001 과 같은 규칙).
-- 이름으로 겹치는 artists 행도 없다. 코레스퐁당스는 Wikidata 에 gnd·isni 가 없다.

-- 세바스티앵 도세 (Sébastien Daucé, Q16841392) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '23840b81-f3cf-5df9-a28c-aa4b0f37ae31', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '23840b81-f3cf-5df9-a28c-aa4b0f37ae31');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '23840b81-f3cf-5df9-a28c-aa4b0f37ae31', 'en', 'canonical', 'Sébastien Daucé', 'sébastien daucé', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '23840b81-f3cf-5df9-a28c-aa4b0f37ae31' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '23840b81-f3cf-5df9-a28c-aa4b0f37ae31', 'ko', 'canonical', '세바스티앵 도세', '세바스티앵 도세', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '23840b81-f3cf-5df9-a28c-aa4b0f37ae31' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '23840b81-f3cf-5df9-a28c-aa4b0f37ae31' AS a, 'gnd' AS n, '1043398066' AS v UNION ALL SELECT '23840b81-f3cf-5df9-a28c-aa4b0f37ae31' AS a, 'isni' AS n, '0000000040840750' AS v UNION ALL SELECT '23840b81-f3cf-5df9-a28c-aa4b0f37ae31' AS a, 'lccn' AS n, 'n2006092024' AS v UNION ALL SELECT '23840b81-f3cf-5df9-a28c-aa4b0f37ae31' AS a, 'musicbrainz_artist' AS n, '2f4f0b48-19e8-4468-85f8-3f49119e697c' AS v UNION ALL SELECT '23840b81-f3cf-5df9-a28c-aa4b0f37ae31' AS a, 'viaf' AS n, '34781907' AS v UNION ALL SELECT '23840b81-f3cf-5df9-a28c-aa4b0f37ae31' AS a, 'wikidata' AS n, 'Q16841392' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '세바스티앵 도세', 'Sébastien Daucé', 'conductor', 'B', '1980', 'France', '23840b81-f3cf-5df9-a28c-aa4b0f37ae31', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '23840b81-f3cf-5df9-a28c-aa4b0f37ae31');

-- 앙상블 코레스퐁당스 (Ensemble Correspondances, Q17154333) · ensemble

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '5335d91d-87f9-5b71-95d7-02273a0b3dd4', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '5335d91d-87f9-5b71-95d7-02273a0b3dd4');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5335d91d-87f9-5b71-95d7-02273a0b3dd4', 'en', 'canonical', 'Ensemble Correspondances', 'ensemble correspondances', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5335d91d-87f9-5b71-95d7-02273a0b3dd4' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5335d91d-87f9-5b71-95d7-02273a0b3dd4', 'ko', 'canonical', '앙상블 코레스퐁당스', '앙상블 코레스퐁당스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5335d91d-87f9-5b71-95d7-02273a0b3dd4' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '5335d91d-87f9-5b71-95d7-02273a0b3dd4' AS a, 'lccn' AS n, 'no2010186436' AS v UNION ALL SELECT '5335d91d-87f9-5b71-95d7-02273a0b3dd4' AS a, 'musicbrainz_artist' AS n, 'a55daa37-9bf1-4f36-ac1e-c60b79d7703c' AS v UNION ALL SELECT '5335d91d-87f9-5b71-95d7-02273a0b3dd4' AS a, 'viaf' AS n, '160437887' AS v UNION ALL SELECT '5335d91d-87f9-5b71-95d7-02273a0b3dd4' AS a, 'wikidata' AS n, 'Q17154333' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '앙상블 코레스퐁당스', 'Ensemble Correspondances', 'ensemble', 'B', '2009', 'France', '5335d91d-87f9-5b71-95d7-02273a0b3dd4', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '5335d91d-87f9-5b71-95d7-02273a0b3dd4');
