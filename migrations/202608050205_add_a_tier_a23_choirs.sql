-- A tier A23 배치에 필요한 단체 넷을 추가한다.
--   합창  런던 심포니 합창단 · 버밍엄 시립교향악단 합창단 · 바이에른 방송합창단
--   악단  버밍엄 시립교향악단
--
-- 브리튼 전쟁 레퀴엠 1곡 "Requiem aeternam"(piece 358)에 쓴다. **합창이 주역인
-- 곡이라 처음부터 choir 를 넣었다** — A12 의 천인 교향곡에서 빠뜨려 나중에 보탠
-- 일이 있었다.
--
-- 버밍엄 합창단의 wikidata 영어 라벨은 'CBSO Chorus' 인데 배급 표기에 쓰이는 이름인
-- City of Birmingham Symphony Chorus 로 적었다. 식별자가 QID 이므로 표기 차이는
-- 문제가 되지 않는다.
--
-- 런던 심포니 합창단과 버밍엄 합창단은 wikidata 에 나라 진술이 없어 영국으로 적었다.
-- 넷 다 한국어 라벨이 없어 한글 이름을 직접 적었다. 넷 다 항목이 충실하다
-- (클레임 22~66개).
--
-- 202608050203 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '2a241251-07c2-5200-9eda-a52244e19573', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '2a241251-07c2-5200-9eda-a52244e19573');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2a241251-07c2-5200-9eda-a52244e19573', 'en', 'canonical', 'London Symphony Chorus', 'london symphony chorus', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2a241251-07c2-5200-9eda-a52244e19573' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2a241251-07c2-5200-9eda-a52244e19573', 'ko', 'canonical', '런던 심포니 합창단', '런던 심포니 합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2a241251-07c2-5200-9eda-a52244e19573' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '2a241251-07c2-5200-9eda-a52244e19573' AS a, 'gnd' AS n, '801195-3' AS v UNION ALL SELECT '2a241251-07c2-5200-9eda-a52244e19573' AS a, 'isni' AS n, '0000000121960578' AS v UNION ALL SELECT '2a241251-07c2-5200-9eda-a52244e19573' AS a, 'musicbrainz_artist' AS n, '12133eec-2c6c-4689-a102-8a558b82dde9' AS v UNION ALL SELECT '2a241251-07c2-5200-9eda-a52244e19573' AS a, 'viaf' AS n, '153218911' AS v UNION ALL SELECT '2a241251-07c2-5200-9eda-a52244e19573' AS a, 'wikidata' AS n, 'Q6670826' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '런던 심포니 합창단', 'London Symphony Chorus', 'choir', 'A', '1966', 'United Kingdom', '2a241251-07c2-5200-9eda-a52244e19573', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '2a241251-07c2-5200-9eda-a52244e19573');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '867041b6-dee5-59a8-acee-a58a5869a9df', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '867041b6-dee5-59a8-acee-a58a5869a9df');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '867041b6-dee5-59a8-acee-a58a5869a9df', 'en', 'canonical', 'City of Birmingham Symphony Chorus', 'city of birmingham symphony chorus', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '867041b6-dee5-59a8-acee-a58a5869a9df' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '867041b6-dee5-59a8-acee-a58a5869a9df', 'ko', 'canonical', '버밍엄 시립교향악단 합창단', '버밍엄 시립교향악단 합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '867041b6-dee5-59a8-acee-a58a5869a9df' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '867041b6-dee5-59a8-acee-a58a5869a9df' AS a, 'gnd' AS n, '16294271-0' AS v UNION ALL SELECT '867041b6-dee5-59a8-acee-a58a5869a9df' AS a, 'isni' AS n, '0000000121671282' AS v UNION ALL SELECT '867041b6-dee5-59a8-acee-a58a5869a9df' AS a, 'musicbrainz_artist' AS n, '8525e88f-fd6c-46a9-95da-b5b8dd2cd33d' AS v UNION ALL SELECT '867041b6-dee5-59a8-acee-a58a5869a9df' AS a, 'viaf' AS n, '137929231' AS v UNION ALL SELECT '867041b6-dee5-59a8-acee-a58a5869a9df' AS a, 'wikidata' AS n, 'Q5009213' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '버밍엄 시립교향악단 합창단', 'City of Birmingham Symphony Chorus', 'choir', 'A', '1973', 'United Kingdom', '867041b6-dee5-59a8-acee-a58a5869a9df', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '867041b6-dee5-59a8-acee-a58a5869a9df');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '39a6d278-eae5-5f88-9583-374dcbd461ee', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '39a6d278-eae5-5f88-9583-374dcbd461ee');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '39a6d278-eae5-5f88-9583-374dcbd461ee', 'en', 'canonical', 'Bavarian Radio Chorus', 'bavarian radio chorus', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '39a6d278-eae5-5f88-9583-374dcbd461ee' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '39a6d278-eae5-5f88-9583-374dcbd461ee', 'ko', 'canonical', '바이에른 방송합창단', '바이에른 방송합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '39a6d278-eae5-5f88-9583-374dcbd461ee' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '39a6d278-eae5-5f88-9583-374dcbd461ee' AS a, 'gnd' AS n, '10136450-7' AS v UNION ALL SELECT '39a6d278-eae5-5f88-9583-374dcbd461ee' AS a, 'isni' AS n, '0000000119574758' AS v UNION ALL SELECT '39a6d278-eae5-5f88-9583-374dcbd461ee' AS a, 'musicbrainz_artist' AS n, '9a6cdfe0-82ec-4aea-93a5-bcd473d8437d' AS v UNION ALL SELECT '39a6d278-eae5-5f88-9583-374dcbd461ee' AS a, 'viaf' AS n, '141357149' AS v UNION ALL SELECT '39a6d278-eae5-5f88-9583-374dcbd461ee' AS a, 'viaf' AS n, '149053158' AS v UNION ALL SELECT '39a6d278-eae5-5f88-9583-374dcbd461ee' AS a, 'wikidata' AS n, 'Q881144' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '바이에른 방송합창단', 'Bavarian Radio Chorus', 'choir', 'A', '1946', 'Germany', '39a6d278-eae5-5f88-9583-374dcbd461ee', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '39a6d278-eae5-5f88-9583-374dcbd461ee');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '538c8a17-c642-5fee-b546-cbc6846a4c2a', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '538c8a17-c642-5fee-b546-cbc6846a4c2a');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '538c8a17-c642-5fee-b546-cbc6846a4c2a', 'en', 'canonical', 'City of Birmingham Symphony Orchestra', 'city of birmingham symphony orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '538c8a17-c642-5fee-b546-cbc6846a4c2a' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '538c8a17-c642-5fee-b546-cbc6846a4c2a', 'ko', 'canonical', '버밍엄 시립교향악단', '버밍엄 시립교향악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '538c8a17-c642-5fee-b546-cbc6846a4c2a' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '538c8a17-c642-5fee-b546-cbc6846a4c2a' AS a, 'gnd' AS n, '1213000-X' AS v UNION ALL SELECT '538c8a17-c642-5fee-b546-cbc6846a4c2a' AS a, 'isni' AS n, '0000000110142625' AS v UNION ALL SELECT '538c8a17-c642-5fee-b546-cbc6846a4c2a' AS a, 'musicbrainz_artist' AS n, 'ed526a9c-f88d-4e52-9518-6a5ce9a46e61' AS v UNION ALL SELECT '538c8a17-c642-5fee-b546-cbc6846a4c2a' AS a, 'viaf' AS n, '143202284' AS v UNION ALL SELECT '538c8a17-c642-5fee-b546-cbc6846a4c2a' AS a, 'wikidata' AS n, 'Q706774' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '버밍엄 시립교향악단', 'City of Birmingham Symphony Orchestra', 'orchestra', 'A', '1920', 'United Kingdom', '538c8a17-c642-5fee-b546-cbc6846a4c2a', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '538c8a17-c642-5fee-b546-cbc6846a4c2a');

