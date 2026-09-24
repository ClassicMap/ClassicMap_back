-- A tier A11 배치에 필요한 합창단 3곳과 지휘자 2명을 추가한다.
--   몬테베르디 합창단 · 폴리포니 · 라트비아 방송합창단
--   스티븐 레이턴 · 시그바르스 클라바
--
-- 브루크너 모테트 <Locus iste>(piece 184)에 쓴다. 이 곡은 아마추어 합창단 영상이
-- 쏟아지는 곡이라 음반 트랙만 남겼는데, **DB 에 등록된 합창단 넷(RIAS·드레스덴
-- 실내합창단·라 스칼라·암브로시안)에는 이 곡 음반 트랙이 없었다.** 그래서
-- wikidata 항목은 있으나 DB 미등록인 셋을 골랐다. 셋 다 무반주 원곡판이고
-- 오르간 반주판은 후보에 넣지 않았다.
--
-- 가드너(Q160325)는 이미 등록돼 있다. 215·216 의 지휘자 여섯과 악단 여섯도
-- 모두 등록돼 있다.
--
-- 202608050070 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '8c05cbd8-0f3a-5f74-a169-5b52b138a710', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '8c05cbd8-0f3a-5f74-a169-5b52b138a710');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8c05cbd8-0f3a-5f74-a169-5b52b138a710', 'en', 'canonical', 'Monteverdi Choir', 'monteverdi choir', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8c05cbd8-0f3a-5f74-a169-5b52b138a710' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8c05cbd8-0f3a-5f74-a169-5b52b138a710', 'ko', 'canonical', '몬테베르디 합창단', '몬테베르디 합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8c05cbd8-0f3a-5f74-a169-5b52b138a710' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '8c05cbd8-0f3a-5f74-a169-5b52b138a710' AS a, 'gnd' AS n, '1099157-8' AS v UNION ALL SELECT '8c05cbd8-0f3a-5f74-a169-5b52b138a710' AS a, 'isni' AS n, '0000000122601585' AS v UNION ALL SELECT '8c05cbd8-0f3a-5f74-a169-5b52b138a710' AS a, 'musicbrainz_artist' AS n, 'a3016390-1ea7-41e2-afac-8d3d3d021fe0' AS v UNION ALL SELECT '8c05cbd8-0f3a-5f74-a169-5b52b138a710' AS a, 'viaf' AS n, '158201004' AS v UNION ALL SELECT '8c05cbd8-0f3a-5f74-a169-5b52b138a710' AS a, 'wikidata' AS n, 'Q372854' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '몬테베르디 합창단', 'Monteverdi Choir', 'choir', 'S', '1964', 'United Kingdom', '8c05cbd8-0f3a-5f74-a169-5b52b138a710', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '8c05cbd8-0f3a-5f74-a169-5b52b138a710');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'c62d4145-aa52-54db-aaa7-3b689aef2c21', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'c62d4145-aa52-54db-aaa7-3b689aef2c21');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c62d4145-aa52-54db-aaa7-3b689aef2c21', 'en', 'canonical', 'Polyphony', 'polyphony', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c62d4145-aa52-54db-aaa7-3b689aef2c21' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c62d4145-aa52-54db-aaa7-3b689aef2c21', 'ko', 'canonical', '폴리포니', '폴리포니', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c62d4145-aa52-54db-aaa7-3b689aef2c21' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'c62d4145-aa52-54db-aaa7-3b689aef2c21' AS a, 'gnd' AS n, '1246219-6' AS v UNION ALL SELECT 'c62d4145-aa52-54db-aaa7-3b689aef2c21' AS a, 'isni' AS n, '0000000123320523' AS v UNION ALL SELECT 'c62d4145-aa52-54db-aaa7-3b689aef2c21' AS a, 'musicbrainz_artist' AS n, '9c057079-ab73-4157-8c8d-52360e181486' AS v UNION ALL SELECT 'c62d4145-aa52-54db-aaa7-3b689aef2c21' AS a, 'viaf' AS n, '144441887' AS v UNION ALL SELECT 'c62d4145-aa52-54db-aaa7-3b689aef2c21' AS a, 'wikidata' AS n, 'Q7226756' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '폴리포니', 'Polyphony', 'choir', 'A', '1986', 'United Kingdom', 'c62d4145-aa52-54db-aaa7-3b689aef2c21', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'c62d4145-aa52-54db-aaa7-3b689aef2c21');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '647e90cd-a38a-5381-85dd-e79a891e0dd0', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '647e90cd-a38a-5381-85dd-e79a891e0dd0');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '647e90cd-a38a-5381-85dd-e79a891e0dd0', 'en', 'canonical', 'Latvian Radio Choir', 'latvian radio choir', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '647e90cd-a38a-5381-85dd-e79a891e0dd0' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '647e90cd-a38a-5381-85dd-e79a891e0dd0', 'ko', 'canonical', '라트비아 방송합창단', '라트비아 방송합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '647e90cd-a38a-5381-85dd-e79a891e0dd0' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '647e90cd-a38a-5381-85dd-e79a891e0dd0' AS a, 'isni' AS n, '0000000110149122' AS v UNION ALL SELECT '647e90cd-a38a-5381-85dd-e79a891e0dd0' AS a, 'musicbrainz_artist' AS n, '5f906627-4601-4d07-8311-27521225cb63' AS v UNION ALL SELECT '647e90cd-a38a-5381-85dd-e79a891e0dd0' AS a, 'viaf' AS n, '145850229' AS v UNION ALL SELECT '647e90cd-a38a-5381-85dd-e79a891e0dd0' AS a, 'wikidata' AS n, 'Q16361547' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '라트비아 방송합창단', 'Latvian Radio Choir', 'choir', 'A', '1940', 'Latvia', '647e90cd-a38a-5381-85dd-e79a891e0dd0', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '647e90cd-a38a-5381-85dd-e79a891e0dd0');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e3d3ef16-1223-5a3d-9eab-2ce8684c5fbb', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'e3d3ef16-1223-5a3d-9eab-2ce8684c5fbb');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e3d3ef16-1223-5a3d-9eab-2ce8684c5fbb', 'en', 'canonical', 'Stephen Layton', 'stephen layton', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e3d3ef16-1223-5a3d-9eab-2ce8684c5fbb' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e3d3ef16-1223-5a3d-9eab-2ce8684c5fbb', 'ko', 'canonical', '스티븐 레이턴', '스티븐 레이턴', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e3d3ef16-1223-5a3d-9eab-2ce8684c5fbb' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'e3d3ef16-1223-5a3d-9eab-2ce8684c5fbb' AS a, 'isni' AS n, '0000000356837224' AS v UNION ALL SELECT 'e3d3ef16-1223-5a3d-9eab-2ce8684c5fbb' AS a, 'musicbrainz_artist' AS n, '141f1185-d0f7-47e6-b049-47f054caf82a' AS v UNION ALL SELECT 'e3d3ef16-1223-5a3d-9eab-2ce8684c5fbb' AS a, 'viaf' AS n, '192787268' AS v UNION ALL SELECT 'e3d3ef16-1223-5a3d-9eab-2ce8684c5fbb' AS a, 'wikidata' AS n, 'Q7609766' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '스티븐 레이턴', 'Stephen Layton', 'conductor', 'A', '1966', 'United Kingdom', 'e3d3ef16-1223-5a3d-9eab-2ce8684c5fbb', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'e3d3ef16-1223-5a3d-9eab-2ce8684c5fbb');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '4d2cb664-75fa-508c-ad06-d9c17bf38671', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '4d2cb664-75fa-508c-ad06-d9c17bf38671');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4d2cb664-75fa-508c-ad06-d9c17bf38671', 'en', 'canonical', 'Sigvards Kļava', 'sigvards kļava', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4d2cb664-75fa-508c-ad06-d9c17bf38671' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4d2cb664-75fa-508c-ad06-d9c17bf38671', 'ko', 'canonical', '시그바르스 클라바', '시그바르스 클라바', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4d2cb664-75fa-508c-ad06-d9c17bf38671' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '4d2cb664-75fa-508c-ad06-d9c17bf38671' AS a, 'gnd' AS n, '135467659' AS v UNION ALL SELECT '4d2cb664-75fa-508c-ad06-d9c17bf38671' AS a, 'isni' AS n, '0000000055233849' AS v UNION ALL SELECT '4d2cb664-75fa-508c-ad06-d9c17bf38671' AS a, 'musicbrainz_artist' AS n, 'd99cdcb4-5f61-43e2-afb8-50ea012945c9' AS v UNION ALL SELECT '4d2cb664-75fa-508c-ad06-d9c17bf38671' AS a, 'viaf' AS n, '27377753' AS v UNION ALL SELECT '4d2cb664-75fa-508c-ad06-d9c17bf38671' AS a, 'wikidata' AS n, 'Q16299912' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '시그바르스 클라바', 'Sigvards Kļava', 'conductor', 'A', '1962', 'Latvia', '4d2cb664-75fa-508c-ad06-d9c17bf38671', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '4d2cb664-75fa-508c-ad06-d9c17bf38671');

