-- A tier A25 에 필요한 단체 둘을 등록한다.
--
--   세인트루이스 교향악단 (Q2212932)  — piece 373 슬래트킨 판의 악단
--   라살 4중주단        (Q979718)   — piece 366 세 번째 연주
--
-- A25 의 인물·단체 열일곱 곳 가운데 열다섯은 이미 등록돼 있었고 이 둘만 없었다.
--
-- 두 항목 다 충실하다(클레임 51개 · 28개). 식별자는 viaf · gnd · isni ·
-- musicbrainz_artist · lccn · wikidata 여섯을 넣었다. **여섯 값 모두 기존 엔티티와
-- 겹치지 않는 것을 확인했다** — 202608050193 에서 런던 필하모닉의 viaf 가 홍콩
-- 필하모닉 것과 겹쳐 유니크 제약을 깬 일이 있어 등록 전에 늘 확인한다.
--
-- 라살 4중주단은 wikidata 에 musicbrainz_artist 가 둘 있다
-- (9b262922-2377-45df-abec-54cbb1f02c3b · bb1eb624-f0a5-4104-bbba-dabedba7c1ff).
-- 뒤쪽은 musicbrainz 의 중복 항목으로 보여 앞의 것만 넣었다. **엔티티 UUID 는
-- 식별자 집합에서 만들므로 뒤에 값을 보태면 UUID 가 바뀐다.**
--
-- 라살 4중주단은 wikidata 에 한국어 라벨과 나라 진술이 둘 다 없다. 1946년 줄리아드에서
-- 결성돼 신시내티에 자리 잡은 미국 단체라 nationality 를 United States 로, 한글 이름은
-- 에머슨·알반 베르크 4중주단의 표기에 맞춰 적었다.
--
-- 202608050203 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '2c5d78b9-79ae-589e-bd94-1ccc7119c02a', 'group', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '2c5d78b9-79ae-589e-bd94-1ccc7119c02a');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2c5d78b9-79ae-589e-bd94-1ccc7119c02a', 'en', 'canonical', 'Saint Louis Symphony Orchestra', 'saint louis symphony orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2c5d78b9-79ae-589e-bd94-1ccc7119c02a' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2c5d78b9-79ae-589e-bd94-1ccc7119c02a', 'ko', 'canonical', '세인트루이스 교향악단', '세인트루이스 교향악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2c5d78b9-79ae-589e-bd94-1ccc7119c02a' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '2c5d78b9-79ae-589e-bd94-1ccc7119c02a' AS a, 'gnd' AS n, '1217683-7' AS v UNION ALL SELECT '2c5d78b9-79ae-589e-bd94-1ccc7119c02a' AS a, 'isni' AS n, '0000000085844720' AS v UNION ALL SELECT '2c5d78b9-79ae-589e-bd94-1ccc7119c02a' AS a, 'lccn' AS n, 'n82033036' AS v UNION ALL SELECT '2c5d78b9-79ae-589e-bd94-1ccc7119c02a' AS a, 'musicbrainz_artist' AS n, '851b24ee-d28f-4535-ab0a-08c95862ba8a' AS v UNION ALL SELECT '2c5d78b9-79ae-589e-bd94-1ccc7119c02a' AS a, 'viaf' AS n, '124161812' AS v UNION ALL SELECT '2c5d78b9-79ae-589e-bd94-1ccc7119c02a' AS a, 'wikidata' AS n, 'Q2212932' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '세인트루이스 교향악단', 'Saint Louis Symphony Orchestra', 'orchestra', 'A', '1880', 'United States', '2c5d78b9-79ae-589e-bd94-1ccc7119c02a', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '2c5d78b9-79ae-589e-bd94-1ccc7119c02a');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '1d5f1a14-31f6-54db-80e6-9514f9049ff9', 'group', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '1d5f1a14-31f6-54db-80e6-9514f9049ff9');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1d5f1a14-31f6-54db-80e6-9514f9049ff9', 'en', 'canonical', 'LaSalle Quartet', 'lasalle quartet', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1d5f1a14-31f6-54db-80e6-9514f9049ff9' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1d5f1a14-31f6-54db-80e6-9514f9049ff9', 'ko', 'canonical', '라살 4중주단', '라살 4중주단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1d5f1a14-31f6-54db-80e6-9514f9049ff9' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '1d5f1a14-31f6-54db-80e6-9514f9049ff9' AS a, 'gnd' AS n, '1212841-7' AS v UNION ALL SELECT '1d5f1a14-31f6-54db-80e6-9514f9049ff9' AS a, 'isni' AS n, '0000000110149368' AS v UNION ALL SELECT '1d5f1a14-31f6-54db-80e6-9514f9049ff9' AS a, 'lccn' AS n, 'n81140238' AS v UNION ALL SELECT '1d5f1a14-31f6-54db-80e6-9514f9049ff9' AS a, 'musicbrainz_artist' AS n, '9b262922-2377-45df-abec-54cbb1f02c3b' AS v UNION ALL SELECT '1d5f1a14-31f6-54db-80e6-9514f9049ff9' AS a, 'viaf' AS n, '131854011' AS v UNION ALL SELECT '1d5f1a14-31f6-54db-80e6-9514f9049ff9' AS a, 'wikidata' AS n, 'Q979718' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '라살 4중주단', 'LaSalle Quartet', 'ensemble', 'A', '1946', 'United States', '1d5f1a14-31f6-54db-80e6-9514f9049ff9', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '1d5f1a14-31f6-54db-80e6-9514f9049ff9');


