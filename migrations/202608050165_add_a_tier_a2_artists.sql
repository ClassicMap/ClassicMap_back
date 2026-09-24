-- A tier A2 배치에 필요한 지휘자 8명·악단 8곳·합창단 2곳을 추가한다.
--
--   C.P.E. 바흐 마니피카트: 라데만·베를린 고음악 아카데미·RIAS 실내합창단 /
--     윌런스·쾰른 아카데미 / 슈나이더·라 스타조네 프랑크푸르트·드레스덴 실내합창단
--   J.C. 바흐 신포니아 B♭장조 Op. 18-2: 진먼·네덜란드 체임버(이미 등록) /
--     뮌힝거·슈투트가르트 체임버 / 판 베이눔·로열 콘세르트허바우(악단은 이미 등록)
--   J.C. 바흐 신포니아 콘체르탄테 C장조: 마이어·콜레기움 아우레움 /
--     홀스테드·하노버 밴드 / 스탠디지·아카데미 오브 에인션트 뮤직
--
-- 202608050070 과 같은 방식이다. 합창단은 영상 채널이 합창단 자체인 두 건만 붙였다.
-- 윌런스 녹음은 채널이 악단이라 합창단을 가릴 수 없어 지휘자·악단만 적었다
-- (S tier F1 의 히브리 노예들도 셋 중 둘만 합창단을 붙였다).
--
-- 라 스타조네 프랑크푸르트는 wikidata 에 창단 연도가 없어 birth_year 를 NULL 로 둔다.
-- 지어내지 않는다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'cffe3536-a36a-5455-b54b-a69a1e1a752e', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'cffe3536-a36a-5455-b54b-a69a1e1a752e');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cffe3536-a36a-5455-b54b-a69a1e1a752e', 'en', 'canonical', 'Hans-Christoph Rademann', 'hans-christoph rademann', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cffe3536-a36a-5455-b54b-a69a1e1a752e' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cffe3536-a36a-5455-b54b-a69a1e1a752e', 'ko', 'canonical', '한스크리스토프 라데만', '한스크리스토프 라데만', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cffe3536-a36a-5455-b54b-a69a1e1a752e' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'cffe3536-a36a-5455-b54b-a69a1e1a752e' AS a, 'gnd' AS n, '12399506X' AS v UNION ALL SELECT 'cffe3536-a36a-5455-b54b-a69a1e1a752e' AS a, 'isni' AS n, '0000000081308496' AS v UNION ALL SELECT 'cffe3536-a36a-5455-b54b-a69a1e1a752e' AS a, 'musicbrainz_artist' AS n, '31b36337-fc02-4b64-a30a-5feda21460cf' AS v UNION ALL SELECT 'cffe3536-a36a-5455-b54b-a69a1e1a752e' AS a, 'viaf' AS n, '51931339' AS v UNION ALL SELECT 'cffe3536-a36a-5455-b54b-a69a1e1a752e' AS a, 'wikidata' AS n, 'Q1576815' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '한스크리스토프 라데만', 'Hans-Christoph Rademann', 'conductor', 'A', '1965', 'Germany', 'cffe3536-a36a-5455-b54b-a69a1e1a752e', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'cffe3536-a36a-5455-b54b-a69a1e1a752e');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '6deb63fe-54cc-5fce-a950-e2bc2f7dfb79', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '6deb63fe-54cc-5fce-a950-e2bc2f7dfb79');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6deb63fe-54cc-5fce-a950-e2bc2f7dfb79', 'en', 'canonical', 'Michael Alexander Willens', 'michael alexander willens', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6deb63fe-54cc-5fce-a950-e2bc2f7dfb79' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6deb63fe-54cc-5fce-a950-e2bc2f7dfb79', 'ko', 'canonical', '마이클 알렉산더 윌런스', '마이클 알렉산더 윌런스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6deb63fe-54cc-5fce-a950-e2bc2f7dfb79' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '6deb63fe-54cc-5fce-a950-e2bc2f7dfb79' AS a, 'gnd' AS n, '135472970' AS v UNION ALL SELECT '6deb63fe-54cc-5fce-a950-e2bc2f7dfb79' AS a, 'viaf' AS n, '78590893' AS v UNION ALL SELECT '6deb63fe-54cc-5fce-a950-e2bc2f7dfb79' AS a, 'wikidata' AS n, 'Q106435900' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '마이클 알렉산더 윌런스', 'Michael Alexander Willens', 'conductor', 'A', '1952', 'United States', '6deb63fe-54cc-5fce-a950-e2bc2f7dfb79', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '6deb63fe-54cc-5fce-a950-e2bc2f7dfb79');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e83e3e71-b802-5c90-945c-cf9ea8e2a545', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'e83e3e71-b802-5c90-945c-cf9ea8e2a545');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e83e3e71-b802-5c90-945c-cf9ea8e2a545', 'en', 'canonical', 'Michael Schneider', 'michael schneider', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e83e3e71-b802-5c90-945c-cf9ea8e2a545' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e83e3e71-b802-5c90-945c-cf9ea8e2a545', 'ko', 'canonical', '미하엘 슈나이더', '미하엘 슈나이더', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e83e3e71-b802-5c90-945c-cf9ea8e2a545' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'e83e3e71-b802-5c90-945c-cf9ea8e2a545' AS a, 'gnd' AS n, '129008516' AS v UNION ALL SELECT 'e83e3e71-b802-5c90-945c-cf9ea8e2a545' AS a, 'isni' AS n, '000000012033126X' AS v UNION ALL SELECT 'e83e3e71-b802-5c90-945c-cf9ea8e2a545' AS a, 'musicbrainz_artist' AS n, 'e7963ffd-4190-4945-ad77-957dd9a5088c' AS v UNION ALL SELECT 'e83e3e71-b802-5c90-945c-cf9ea8e2a545' AS a, 'viaf' AS n, '117122035' AS v UNION ALL SELECT 'e83e3e71-b802-5c90-945c-cf9ea8e2a545' AS a, 'wikidata' AS n, 'Q74931' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '미하엘 슈나이더', 'Michael Schneider', 'conductor', 'A', '1953', 'Germany', 'e83e3e71-b802-5c90-945c-cf9ea8e2a545', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'e83e3e71-b802-5c90-945c-cf9ea8e2a545');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '20a2655d-dfe7-5203-9e1d-5f78b64db429', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '20a2655d-dfe7-5203-9e1d-5f78b64db429');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '20a2655d-dfe7-5203-9e1d-5f78b64db429', 'en', 'canonical', 'Karl Münchinger', 'karl münchinger', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '20a2655d-dfe7-5203-9e1d-5f78b64db429' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '20a2655d-dfe7-5203-9e1d-5f78b64db429', 'ko', 'canonical', '카를 뮌힝거', '카를 뮌힝거', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '20a2655d-dfe7-5203-9e1d-5f78b64db429' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '20a2655d-dfe7-5203-9e1d-5f78b64db429' AS a, 'gnd' AS n, '118735039' AS v UNION ALL SELECT '20a2655d-dfe7-5203-9e1d-5f78b64db429' AS a, 'isni' AS n, '0000000110574102' AS v UNION ALL SELECT '20a2655d-dfe7-5203-9e1d-5f78b64db429' AS a, 'musicbrainz_artist' AS n, 'e2740c56-3109-451f-96c7-95583d3b8669' AS v UNION ALL SELECT '20a2655d-dfe7-5203-9e1d-5f78b64db429' AS a, 'viaf' AS n, '39562770' AS v UNION ALL SELECT '20a2655d-dfe7-5203-9e1d-5f78b64db429' AS a, 'wikidata' AS n, 'Q65295' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '카를 뮌힝거', 'Karl Münchinger', 'conductor', 'A', '1915', 'Germany', '20a2655d-dfe7-5203-9e1d-5f78b64db429', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '20a2655d-dfe7-5203-9e1d-5f78b64db429');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'acc05c71-8ee5-5bdc-972b-c82e07b36123', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'acc05c71-8ee5-5bdc-972b-c82e07b36123');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'acc05c71-8ee5-5bdc-972b-c82e07b36123', 'en', 'canonical', 'Eduard van Beinum', 'eduard van beinum', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'acc05c71-8ee5-5bdc-972b-c82e07b36123' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'acc05c71-8ee5-5bdc-972b-c82e07b36123', 'ko', 'canonical', '에두아르트 판 베이눔', '에두아르트 판 베이눔', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'acc05c71-8ee5-5bdc-972b-c82e07b36123' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'acc05c71-8ee5-5bdc-972b-c82e07b36123' AS a, 'gnd' AS n, '123055466' AS v UNION ALL SELECT 'acc05c71-8ee5-5bdc-972b-c82e07b36123' AS a, 'isni' AS n, '0000000115756482' AS v UNION ALL SELECT 'acc05c71-8ee5-5bdc-972b-c82e07b36123' AS a, 'musicbrainz_artist' AS n, 'b08de38a-93a9-4bf0-8da6-c22ab0bb1ef7' AS v UNION ALL SELECT 'acc05c71-8ee5-5bdc-972b-c82e07b36123' AS a, 'viaf' AS n, '76501737' AS v UNION ALL SELECT 'acc05c71-8ee5-5bdc-972b-c82e07b36123' AS a, 'wikidata' AS n, 'Q508916' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '에두아르트 판 베이눔', 'Eduard van Beinum', 'conductor', 'A', '1900', 'Netherlands', 'acc05c71-8ee5-5bdc-972b-c82e07b36123', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'acc05c71-8ee5-5bdc-972b-c82e07b36123');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '319da357-6dc2-5bde-b30a-6a7bcda64635', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '319da357-6dc2-5bde-b30a-6a7bcda64635');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '319da357-6dc2-5bde-b30a-6a7bcda64635', 'en', 'canonical', 'Franzjosef Maier', 'franzjosef maier', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '319da357-6dc2-5bde-b30a-6a7bcda64635' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '319da357-6dc2-5bde-b30a-6a7bcda64635', 'ko', 'canonical', '프란츠요제프 마이어', '프란츠요제프 마이어', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '319da357-6dc2-5bde-b30a-6a7bcda64635' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '319da357-6dc2-5bde-b30a-6a7bcda64635' AS a, 'gnd' AS n, '134452925' AS v UNION ALL SELECT '319da357-6dc2-5bde-b30a-6a7bcda64635' AS a, 'isni' AS n, '0000000073604172' AS v UNION ALL SELECT '319da357-6dc2-5bde-b30a-6a7bcda64635' AS a, 'musicbrainz_artist' AS n, '6843ee9e-5ba6-4c96-9be1-ba376ece15a7' AS v UNION ALL SELECT '319da357-6dc2-5bde-b30a-6a7bcda64635' AS a, 'musicbrainz_artist' AS n, 'f115522b-891b-4c43-b2da-fd62cd6f09ee' AS v UNION ALL SELECT '319da357-6dc2-5bde-b30a-6a7bcda64635' AS a, 'viaf' AS n, '69116141' AS v UNION ALL SELECT '319da357-6dc2-5bde-b30a-6a7bcda64635' AS a, 'wikidata' AS n, 'Q1450429' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '프란츠요제프 마이어', 'Franzjosef Maier', 'conductor', 'A', '1925', 'Germany', '319da357-6dc2-5bde-b30a-6a7bcda64635', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '319da357-6dc2-5bde-b30a-6a7bcda64635');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '3a7e7aa0-1fb8-5f9a-aeb0-2753f21e3484', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '3a7e7aa0-1fb8-5f9a-aeb0-2753f21e3484');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3a7e7aa0-1fb8-5f9a-aeb0-2753f21e3484', 'en', 'canonical', 'Anthony Halstead', 'anthony halstead', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3a7e7aa0-1fb8-5f9a-aeb0-2753f21e3484' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3a7e7aa0-1fb8-5f9a-aeb0-2753f21e3484', 'ko', 'canonical', '앤서니 홀스테드', '앤서니 홀스테드', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3a7e7aa0-1fb8-5f9a-aeb0-2753f21e3484' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '3a7e7aa0-1fb8-5f9a-aeb0-2753f21e3484' AS a, 'gnd' AS n, '134685466' AS v UNION ALL SELECT '3a7e7aa0-1fb8-5f9a-aeb0-2753f21e3484' AS a, 'isni' AS n, '0000000114951059' AS v UNION ALL SELECT '3a7e7aa0-1fb8-5f9a-aeb0-2753f21e3484' AS a, 'musicbrainz_artist' AS n, 'c00fe6b1-d5f4-4c62-b01d-912a9a434ba0' AS v UNION ALL SELECT '3a7e7aa0-1fb8-5f9a-aeb0-2753f21e3484' AS a, 'viaf' AS n, '90621161' AS v UNION ALL SELECT '3a7e7aa0-1fb8-5f9a-aeb0-2753f21e3484' AS a, 'wikidata' AS n, 'Q4772653' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '앤서니 홀스테드', 'Anthony Halstead', 'conductor', 'A', '1945', 'United Kingdom', '3a7e7aa0-1fb8-5f9a-aeb0-2753f21e3484', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '3a7e7aa0-1fb8-5f9a-aeb0-2753f21e3484');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'd1dbe770-24b9-5ae8-86c3-7b6f86535765', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'd1dbe770-24b9-5ae8-86c3-7b6f86535765');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd1dbe770-24b9-5ae8-86c3-7b6f86535765', 'en', 'canonical', 'Simon Standage', 'simon standage', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd1dbe770-24b9-5ae8-86c3-7b6f86535765' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd1dbe770-24b9-5ae8-86c3-7b6f86535765', 'ko', 'canonical', '사이먼 스탠디지', '사이먼 스탠디지', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd1dbe770-24b9-5ae8-86c3-7b6f86535765' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'd1dbe770-24b9-5ae8-86c3-7b6f86535765' AS a, 'gnd' AS n, '123774039' AS v UNION ALL SELECT 'd1dbe770-24b9-5ae8-86c3-7b6f86535765' AS a, 'isni' AS n, '0000000114767585' AS v UNION ALL SELECT 'd1dbe770-24b9-5ae8-86c3-7b6f86535765' AS a, 'musicbrainz_artist' AS n, '443854bd-016c-499b-a65b-aa6c975b41e1' AS v UNION ALL SELECT 'd1dbe770-24b9-5ae8-86c3-7b6f86535765' AS a, 'viaf' AS n, '85881709' AS v UNION ALL SELECT 'd1dbe770-24b9-5ae8-86c3-7b6f86535765' AS a, 'wikidata' AS n, 'Q323956' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '사이먼 스탠디지', 'Simon Standage', 'conductor', 'A', '1941', 'United Kingdom', 'd1dbe770-24b9-5ae8-86c3-7b6f86535765', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'd1dbe770-24b9-5ae8-86c3-7b6f86535765');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '2e35216a-1e82-52fd-a30c-c0975ab3ce5d', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '2e35216a-1e82-52fd-a30c-c0975ab3ce5d');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2e35216a-1e82-52fd-a30c-c0975ab3ce5d', 'en', 'canonical', 'Akademie für Alte Musik Berlin', 'akademie für alte musik berlin', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2e35216a-1e82-52fd-a30c-c0975ab3ce5d' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2e35216a-1e82-52fd-a30c-c0975ab3ce5d', 'ko', 'canonical', '베를린 고음악 아카데미', '베를린 고음악 아카데미', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2e35216a-1e82-52fd-a30c-c0975ab3ce5d' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '2e35216a-1e82-52fd-a30c-c0975ab3ce5d' AS a, 'gnd' AS n, '5142877-5' AS v UNION ALL SELECT '2e35216a-1e82-52fd-a30c-c0975ab3ce5d' AS a, 'isni' AS n, '000000011010117X' AS v UNION ALL SELECT '2e35216a-1e82-52fd-a30c-c0975ab3ce5d' AS a, 'musicbrainz_artist' AS n, 'ad1b876d-1f4a-4126-8965-7e35076b9962' AS v UNION ALL SELECT '2e35216a-1e82-52fd-a30c-c0975ab3ce5d' AS a, 'viaf' AS n, '126187501' AS v UNION ALL SELECT '2e35216a-1e82-52fd-a30c-c0975ab3ce5d' AS a, 'wikidata' AS n, 'Q414240' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '베를린 고음악 아카데미', 'Akademie für Alte Musik Berlin', 'orchestra', 'A', '1982', 'Germany', '2e35216a-1e82-52fd-a30c-c0975ab3ce5d', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '2e35216a-1e82-52fd-a30c-c0975ab3ce5d');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '1dcb6281-6d1c-555f-9eb1-27df5843466d', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '1dcb6281-6d1c-555f-9eb1-27df5843466d');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1dcb6281-6d1c-555f-9eb1-27df5843466d', 'en', 'canonical', 'Kölner Akademie', 'kölner akademie', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1dcb6281-6d1c-555f-9eb1-27df5843466d' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1dcb6281-6d1c-555f-9eb1-27df5843466d', 'ko', 'canonical', '쾰른 아카데미', '쾰른 아카데미', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1dcb6281-6d1c-555f-9eb1-27df5843466d' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '1dcb6281-6d1c-555f-9eb1-27df5843466d' AS a, 'gnd' AS n, '10340798-4' AS v UNION ALL SELECT '1dcb6281-6d1c-555f-9eb1-27df5843466d' AS a, 'isni' AS n, '000000011456792X' AS v UNION ALL SELECT '1dcb6281-6d1c-555f-9eb1-27df5843466d' AS a, 'musicbrainz_artist' AS n, 'dabfaee3-92db-4448-ab99-ed6a68348557' AS v UNION ALL SELECT '1dcb6281-6d1c-555f-9eb1-27df5843466d' AS a, 'viaf' AS n, '138005645' AS v UNION ALL SELECT '1dcb6281-6d1c-555f-9eb1-27df5843466d' AS a, 'wikidata' AS n, 'Q6453858' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '쾰른 아카데미', 'Kölner Akademie', 'orchestra', 'A', '1996', 'Germany', '1dcb6281-6d1c-555f-9eb1-27df5843466d', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '1dcb6281-6d1c-555f-9eb1-27df5843466d');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '691a05dc-0f41-558c-96a4-84a190493c78', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '691a05dc-0f41-558c-96a4-84a190493c78');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '691a05dc-0f41-558c-96a4-84a190493c78', 'en', 'canonical', 'La Stagione Frankfurt', 'la stagione frankfurt', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '691a05dc-0f41-558c-96a4-84a190493c78' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '691a05dc-0f41-558c-96a4-84a190493c78', 'ko', 'canonical', '라 스타조네 프랑크푸르트', '라 스타조네 프랑크푸르트', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '691a05dc-0f41-558c-96a4-84a190493c78' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '691a05dc-0f41-558c-96a4-84a190493c78' AS a, 'gnd' AS n, '5075019-7' AS v UNION ALL SELECT '691a05dc-0f41-558c-96a4-84a190493c78' AS a, 'isni' AS n, '000000011544725X' AS v UNION ALL SELECT '691a05dc-0f41-558c-96a4-84a190493c78' AS a, 'isni' AS n, '0000000115447268' AS v UNION ALL SELECT '691a05dc-0f41-558c-96a4-84a190493c78' AS a, 'musicbrainz_artist' AS n, '8d8a644e-3466-497b-9988-96d3330bd382' AS v UNION ALL SELECT '691a05dc-0f41-558c-96a4-84a190493c78' AS a, 'viaf' AS n, '268372510' AS v UNION ALL SELECT '691a05dc-0f41-558c-96a4-84a190493c78' AS a, 'wikidata' AS n, 'Q48772265' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '라 스타조네 프랑크푸르트', 'La Stagione Frankfurt', 'orchestra', 'A', NULL, 'Germany', '691a05dc-0f41-558c-96a4-84a190493c78', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '691a05dc-0f41-558c-96a4-84a190493c78');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a18b7ad2-a8e5-5d10-995a-a8f44d758c25', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a18b7ad2-a8e5-5d10-995a-a8f44d758c25');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a18b7ad2-a8e5-5d10-995a-a8f44d758c25', 'en', 'canonical', 'Netherlands Chamber Orchestra', 'netherlands chamber orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a18b7ad2-a8e5-5d10-995a-a8f44d758c25' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a18b7ad2-a8e5-5d10-995a-a8f44d758c25', 'ko', 'canonical', '네덜란드 체임버 오케스트라', '네덜란드 체임버 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a18b7ad2-a8e5-5d10-995a-a8f44d758c25' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a18b7ad2-a8e5-5d10-995a-a8f44d758c25' AS a, 'isni' AS n, '0000000109442188' AS v UNION ALL SELECT 'a18b7ad2-a8e5-5d10-995a-a8f44d758c25' AS a, 'musicbrainz_artist' AS n, 'd6feca46-ae5f-422b-9851-b2b8cf0bf28e' AS v UNION ALL SELECT 'a18b7ad2-a8e5-5d10-995a-a8f44d758c25' AS a, 'viaf' AS n, '131991691' AS v UNION ALL SELECT 'a18b7ad2-a8e5-5d10-995a-a8f44d758c25' AS a, 'wikidata' AS n, 'Q2556468' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '네덜란드 체임버 오케스트라', 'Netherlands Chamber Orchestra', 'orchestra', 'A', '1955', 'Netherlands', 'a18b7ad2-a8e5-5d10-995a-a8f44d758c25', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a18b7ad2-a8e5-5d10-995a-a8f44d758c25');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e67eac56-1bd1-54b2-8588-1b518f27abf6', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'e67eac56-1bd1-54b2-8588-1b518f27abf6');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e67eac56-1bd1-54b2-8588-1b518f27abf6', 'en', 'canonical', 'Stuttgart Chamber Orchestra', 'stuttgart chamber orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e67eac56-1bd1-54b2-8588-1b518f27abf6' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e67eac56-1bd1-54b2-8588-1b518f27abf6', 'ko', 'canonical', '슈투트가르트 체임버 오케스트라', '슈투트가르트 체임버 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e67eac56-1bd1-54b2-8588-1b518f27abf6' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'e67eac56-1bd1-54b2-8588-1b518f27abf6' AS a, 'gnd' AS n, '1212496-5' AS v UNION ALL SELECT 'e67eac56-1bd1-54b2-8588-1b518f27abf6' AS a, 'isni' AS n, '0000000109444722' AS v UNION ALL SELECT 'e67eac56-1bd1-54b2-8588-1b518f27abf6' AS a, 'musicbrainz_artist' AS n, '65c56f38-ee1e-4668-b284-64cc8ba2ad53' AS v UNION ALL SELECT 'e67eac56-1bd1-54b2-8588-1b518f27abf6' AS a, 'viaf' AS n, '268457957' AS v UNION ALL SELECT 'e67eac56-1bd1-54b2-8588-1b518f27abf6' AS a, 'wikidata' AS n, 'Q724513' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '슈투트가르트 체임버 오케스트라', 'Stuttgart Chamber Orchestra', 'orchestra', 'A', '1945', 'Germany', 'e67eac56-1bd1-54b2-8588-1b518f27abf6', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'e67eac56-1bd1-54b2-8588-1b518f27abf6');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'bfc93cd5-f803-5511-9f81-c02c3c1d5246', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'bfc93cd5-f803-5511-9f81-c02c3c1d5246');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bfc93cd5-f803-5511-9f81-c02c3c1d5246', 'en', 'canonical', 'Collegium Aureum', 'collegium aureum', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bfc93cd5-f803-5511-9f81-c02c3c1d5246' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bfc93cd5-f803-5511-9f81-c02c3c1d5246', 'ko', 'canonical', '콜레기움 아우레움', '콜레기움 아우레움', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bfc93cd5-f803-5511-9f81-c02c3c1d5246' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'bfc93cd5-f803-5511-9f81-c02c3c1d5246' AS a, 'gnd' AS n, '1212461-8' AS v UNION ALL SELECT 'bfc93cd5-f803-5511-9f81-c02c3c1d5246' AS a, 'isni' AS n, '0000000123319637' AS v UNION ALL SELECT 'bfc93cd5-f803-5511-9f81-c02c3c1d5246' AS a, 'musicbrainz_artist' AS n, '2cdc12f9-aae5-4b64-a769-6448f2c1c586' AS v UNION ALL SELECT 'bfc93cd5-f803-5511-9f81-c02c3c1d5246' AS a, 'viaf' AS n, '159459849' AS v UNION ALL SELECT 'bfc93cd5-f803-5511-9f81-c02c3c1d5246' AS a, 'wikidata' AS n, 'Q834039' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '콜레기움 아우레움', 'Collegium Aureum', 'orchestra', 'A', '1962', 'Germany', 'bfc93cd5-f803-5511-9f81-c02c3c1d5246', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'bfc93cd5-f803-5511-9f81-c02c3c1d5246');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '86194744-3209-5068-8aae-22a5ba289e72', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '86194744-3209-5068-8aae-22a5ba289e72');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '86194744-3209-5068-8aae-22a5ba289e72', 'en', 'canonical', 'Hanover Band', 'hanover band', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '86194744-3209-5068-8aae-22a5ba289e72' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '86194744-3209-5068-8aae-22a5ba289e72', 'ko', 'canonical', '하노버 밴드', '하노버 밴드', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '86194744-3209-5068-8aae-22a5ba289e72' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '86194744-3209-5068-8aae-22a5ba289e72' AS a, 'gnd' AS n, '672303-2' AS v UNION ALL SELECT '86194744-3209-5068-8aae-22a5ba289e72' AS a, 'isni' AS n, '0000000109453717' AS v UNION ALL SELECT '86194744-3209-5068-8aae-22a5ba289e72' AS a, 'musicbrainz_artist' AS n, 'cb9ff699-5edd-4931-8904-fdcb06f1293a' AS v UNION ALL SELECT '86194744-3209-5068-8aae-22a5ba289e72' AS a, 'viaf' AS n, '151444300' AS v UNION ALL SELECT '86194744-3209-5068-8aae-22a5ba289e72' AS a, 'wikidata' AS n, 'Q2901816' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '하노버 밴드', 'Hanover Band', 'orchestra', 'A', '1980', 'United Kingdom', '86194744-3209-5068-8aae-22a5ba289e72', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '86194744-3209-5068-8aae-22a5ba289e72');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'fdfc946c-606c-54f3-bccd-66a09fbfaad1', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'fdfc946c-606c-54f3-bccd-66a09fbfaad1');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'fdfc946c-606c-54f3-bccd-66a09fbfaad1', 'en', 'canonical', 'Academy of Ancient Music', 'academy of ancient music', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'fdfc946c-606c-54f3-bccd-66a09fbfaad1' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'fdfc946c-606c-54f3-bccd-66a09fbfaad1', 'ko', 'canonical', '아카데미 오브 에인션트 뮤직', '아카데미 오브 에인션트 뮤직', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'fdfc946c-606c-54f3-bccd-66a09fbfaad1' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'fdfc946c-606c-54f3-bccd-66a09fbfaad1' AS a, 'gnd' AS n, '803742-5' AS v UNION ALL SELECT 'fdfc946c-606c-54f3-bccd-66a09fbfaad1' AS a, 'isni' AS n, '0000000119416880' AS v UNION ALL SELECT 'fdfc946c-606c-54f3-bccd-66a09fbfaad1' AS a, 'musicbrainz_artist' AS n, '5c8fd1e4-574d-495f-9a24-2dfaadf2e8c0' AS v UNION ALL SELECT 'fdfc946c-606c-54f3-bccd-66a09fbfaad1' AS a, 'musicbrainz_artist' AS n, 'e6decc3e-99bc-4a99-84d0-b59a905a3587' AS v UNION ALL SELECT 'fdfc946c-606c-54f3-bccd-66a09fbfaad1' AS a, 'viaf' AS n, '146715377' AS v UNION ALL SELECT 'fdfc946c-606c-54f3-bccd-66a09fbfaad1' AS a, 'wikidata' AS n, 'Q337310' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '아카데미 오브 에인션트 뮤직', 'Academy of Ancient Music', 'orchestra', 'A', '1973', 'United Kingdom', 'fdfc946c-606c-54f3-bccd-66a09fbfaad1', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'fdfc946c-606c-54f3-bccd-66a09fbfaad1');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e7d9edc9-8de0-5516-85f3-69a04bc42252', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'e7d9edc9-8de0-5516-85f3-69a04bc42252');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e7d9edc9-8de0-5516-85f3-69a04bc42252', 'en', 'canonical', 'RIAS Kammerchor', 'rias kammerchor', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e7d9edc9-8de0-5516-85f3-69a04bc42252' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e7d9edc9-8de0-5516-85f3-69a04bc42252', 'ko', 'canonical', 'RIAS 실내합창단', 'rias 실내합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e7d9edc9-8de0-5516-85f3-69a04bc42252' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'e7d9edc9-8de0-5516-85f3-69a04bc42252' AS a, 'gnd' AS n, '2181965-8' AS v UNION ALL SELECT 'e7d9edc9-8de0-5516-85f3-69a04bc42252' AS a, 'isni' AS n, '0000000109442735' AS v UNION ALL SELECT 'e7d9edc9-8de0-5516-85f3-69a04bc42252' AS a, 'musicbrainz_artist' AS n, 'f461b350-a814-4341-b427-c8fd59430d1f' AS v UNION ALL SELECT 'e7d9edc9-8de0-5516-85f3-69a04bc42252' AS a, 'viaf' AS n, '124487270' AS v UNION ALL SELECT 'e7d9edc9-8de0-5516-85f3-69a04bc42252' AS a, 'wikidata' AS n, 'Q320444' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT 'RIAS 실내합창단', 'RIAS Kammerchor', 'choir', 'A', '1948', 'Germany', 'e7d9edc9-8de0-5516-85f3-69a04bc42252', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'e7d9edc9-8de0-5516-85f3-69a04bc42252');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '66110941-225e-58dc-bb29-479c93f216c2', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '66110941-225e-58dc-bb29-479c93f216c2');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '66110941-225e-58dc-bb29-479c93f216c2', 'en', 'canonical', 'Dresdner Kammerchor', 'dresdner kammerchor', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '66110941-225e-58dc-bb29-479c93f216c2' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '66110941-225e-58dc-bb29-479c93f216c2', 'ko', 'canonical', '드레스덴 실내합창단', '드레스덴 실내합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '66110941-225e-58dc-bb29-479c93f216c2' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '66110941-225e-58dc-bb29-479c93f216c2' AS a, 'gnd' AS n, '5177442-2' AS v UNION ALL SELECT '66110941-225e-58dc-bb29-479c93f216c2' AS a, 'isni' AS n, '0000000106832316' AS v UNION ALL SELECT '66110941-225e-58dc-bb29-479c93f216c2' AS a, 'musicbrainz_artist' AS n, '186f29bd-aff1-422b-8be7-1434b7c542c4' AS v UNION ALL SELECT '66110941-225e-58dc-bb29-479c93f216c2' AS a, 'viaf' AS n, '127509643' AS v UNION ALL SELECT '66110941-225e-58dc-bb29-479c93f216c2' AS a, 'wikidata' AS n, 'Q1258533' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '드레스덴 실내합창단', 'Dresdner Kammerchor', 'choir', 'A', '1985', 'Germany', '66110941-225e-58dc-bb29-479c93f216c2', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '66110941-225e-58dc-bb29-479c93f216c2');

