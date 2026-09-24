-- A tier A1 배치에 필요한 독주자 4명·지휘자 3명·악단 3곳을 추가한다.
--
--   C.P.E. 바흐 솔페지에토: 아멜린(이미 등록) / 바렌보임(이미 등록) / 카차리스
--   C.P.E. 바흐 플루트 협주곡 D단조: 파위·피노크·포츠담 실내악 아카데미(파위는 이미 등록) /
--     골웨이·페르버·뷔르템베르크 실내관현악단 / 갈루아·맬런·토론토 체임버
--
-- 202608050070 과 같은 방식이다. 바렌보임은 분류가 conductor 로 등록돼 있으나 이
-- 녹음에서는 피아노 독주다. 해소는 wikidata 로 하므로 분류와 어긋나도 적재된다
-- (S tier A2 의 정명훈과 같은 경우다).
--
-- 맬런·포츠담 실내악 아카데미·토론토 체임버는 wikidata 에 연도가 없어 birth_year 를
-- NULL 로 둔다. 지어내지 않는다.
--
-- 이 배치의 첼로 협주곡 A단조(piece 104)는 발췌가 어긋나 빠졌다. 연주자도 넣지 않는다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '27bc9a4f-3e47-5862-ac7a-fa15e4e88977', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '27bc9a4f-3e47-5862-ac7a-fa15e4e88977');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '27bc9a4f-3e47-5862-ac7a-fa15e4e88977', 'en', 'canonical', 'Cyprien Katsaris', 'cyprien katsaris', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '27bc9a4f-3e47-5862-ac7a-fa15e4e88977' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '27bc9a4f-3e47-5862-ac7a-fa15e4e88977', 'ko', 'canonical', '시프리앵 카차리스', '시프리앵 카차리스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '27bc9a4f-3e47-5862-ac7a-fa15e4e88977' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '27bc9a4f-3e47-5862-ac7a-fa15e4e88977' AS a, 'gnd' AS n, '124953913' AS v UNION ALL SELECT '27bc9a4f-3e47-5862-ac7a-fa15e4e88977' AS a, 'isni' AS n, '0000000063017943' AS v UNION ALL SELECT '27bc9a4f-3e47-5862-ac7a-fa15e4e88977' AS a, 'musicbrainz_artist' AS n, '6c8a4b55-d632-4d1d-91f6-03d7fb0a6979' AS v UNION ALL SELECT '27bc9a4f-3e47-5862-ac7a-fa15e4e88977' AS a, 'viaf' AS n, '238646659' AS v UNION ALL SELECT '27bc9a4f-3e47-5862-ac7a-fa15e4e88977' AS a, 'viaf' AS n, '27252189' AS v UNION ALL SELECT '27bc9a4f-3e47-5862-ac7a-fa15e4e88977' AS a, 'wikidata' AS n, 'Q1148343' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '시프리앵 카차리스', 'Cyprien Katsaris', 'pianist', 'A', '1951', 'France', '27bc9a4f-3e47-5862-ac7a-fa15e4e88977', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '27bc9a4f-3e47-5862-ac7a-fa15e4e88977');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '4daed019-05e5-5a5a-8970-6c9f120245b4', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '4daed019-05e5-5a5a-8970-6c9f120245b4');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4daed019-05e5-5a5a-8970-6c9f120245b4', 'en', 'canonical', 'James Galway', 'james galway', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4daed019-05e5-5a5a-8970-6c9f120245b4' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4daed019-05e5-5a5a-8970-6c9f120245b4', 'ko', 'canonical', '제임스 골웨이', '제임스 골웨이', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4daed019-05e5-5a5a-8970-6c9f120245b4' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '4daed019-05e5-5a5a-8970-6c9f120245b4' AS a, 'gnd' AS n, '124000118' AS v UNION ALL SELECT '4daed019-05e5-5a5a-8970-6c9f120245b4' AS a, 'isni' AS n, '0000000114406261' AS v UNION ALL SELECT '4daed019-05e5-5a5a-8970-6c9f120245b4' AS a, 'musicbrainz_artist' AS n, '84045b93-beb0-4bc8-a855-93266ec6bbdc' AS v UNION ALL SELECT '4daed019-05e5-5a5a-8970-6c9f120245b4' AS a, 'viaf' AS n, '29717952' AS v UNION ALL SELECT '4daed019-05e5-5a5a-8970-6c9f120245b4' AS a, 'wikidata' AS n, 'Q160371' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '제임스 골웨이', 'James Galway', 'flutist', 'A', '1939', 'United Kingdom', '4daed019-05e5-5a5a-8970-6c9f120245b4', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '4daed019-05e5-5a5a-8970-6c9f120245b4');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '25bf37a1-8d5f-596c-888d-1025ccb586a6', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '25bf37a1-8d5f-596c-888d-1025ccb586a6');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '25bf37a1-8d5f-596c-888d-1025ccb586a6', 'en', 'canonical', 'Patrick Gallois', 'patrick gallois', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '25bf37a1-8d5f-596c-888d-1025ccb586a6' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '25bf37a1-8d5f-596c-888d-1025ccb586a6', 'ko', 'canonical', '파트리크 갈루아', '파트리크 갈루아', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '25bf37a1-8d5f-596c-888d-1025ccb586a6' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '25bf37a1-8d5f-596c-888d-1025ccb586a6' AS a, 'gnd' AS n, '129492493' AS v UNION ALL SELECT '25bf37a1-8d5f-596c-888d-1025ccb586a6' AS a, 'isni' AS n, '0000000110061390' AS v UNION ALL SELECT '25bf37a1-8d5f-596c-888d-1025ccb586a6' AS a, 'musicbrainz_artist' AS n, 'fd7ff1bd-cd0b-48da-ae72-9de37c6691e4' AS v UNION ALL SELECT '25bf37a1-8d5f-596c-888d-1025ccb586a6' AS a, 'viaf' AS n, '113917044' AS v UNION ALL SELECT '25bf37a1-8d5f-596c-888d-1025ccb586a6' AS a, 'wikidata' AS n, 'Q1234459' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '파트리크 갈루아', 'Patrick Gallois', 'flutist', 'A', '1956', 'France', '25bf37a1-8d5f-596c-888d-1025ccb586a6', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '25bf37a1-8d5f-596c-888d-1025ccb586a6');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e230a1f1-0dac-5561-accb-0971ac4ba64a', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'e230a1f1-0dac-5561-accb-0971ac4ba64a');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e230a1f1-0dac-5561-accb-0971ac4ba64a', 'en', 'canonical', 'Trevor Pinnock', 'trevor pinnock', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e230a1f1-0dac-5561-accb-0971ac4ba64a' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e230a1f1-0dac-5561-accb-0971ac4ba64a', 'ko', 'canonical', '트레버 피노크', '트레버 피노크', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e230a1f1-0dac-5561-accb-0971ac4ba64a' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'e230a1f1-0dac-5561-accb-0971ac4ba64a' AS a, 'gnd' AS n, '123962927' AS v UNION ALL SELECT 'e230a1f1-0dac-5561-accb-0971ac4ba64a' AS a, 'isni' AS n, '000000011443908X' AS v UNION ALL SELECT 'e230a1f1-0dac-5561-accb-0971ac4ba64a' AS a, 'musicbrainz_artist' AS n, '66d97594-15fd-49b9-8359-0c014dbe8719' AS v UNION ALL SELECT 'e230a1f1-0dac-5561-accb-0971ac4ba64a' AS a, 'viaf' AS n, '51876317' AS v UNION ALL SELECT 'e230a1f1-0dac-5561-accb-0971ac4ba64a' AS a, 'wikidata' AS n, 'Q434774' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '트레버 피노크', 'Trevor Pinnock', 'conductor', 'A', '1946', 'United Kingdom', 'e230a1f1-0dac-5561-accb-0971ac4ba64a', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'e230a1f1-0dac-5561-accb-0971ac4ba64a');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '7ed6d01b-1f09-5be9-b71d-1f110e20a0c4', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '7ed6d01b-1f09-5be9-b71d-1f110e20a0c4');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7ed6d01b-1f09-5be9-b71d-1f110e20a0c4', 'en', 'canonical', 'Jörg Faerber', 'jörg faerber', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7ed6d01b-1f09-5be9-b71d-1f110e20a0c4' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7ed6d01b-1f09-5be9-b71d-1f110e20a0c4', 'ko', 'canonical', '외르크 페르버', '외르크 페르버', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7ed6d01b-1f09-5be9-b71d-1f110e20a0c4' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '7ed6d01b-1f09-5be9-b71d-1f110e20a0c4' AS a, 'gnd' AS n, '123614937' AS v UNION ALL SELECT '7ed6d01b-1f09-5be9-b71d-1f110e20a0c4' AS a, 'isni' AS n, '0000000114803902' AS v UNION ALL SELECT '7ed6d01b-1f09-5be9-b71d-1f110e20a0c4' AS a, 'musicbrainz_artist' AS n, 'f2dcc71c-96b2-4c89-ac42-1116c49df174' AS v UNION ALL SELECT '7ed6d01b-1f09-5be9-b71d-1f110e20a0c4' AS a, 'viaf' AS n, '116059411' AS v UNION ALL SELECT '7ed6d01b-1f09-5be9-b71d-1f110e20a0c4' AS a, 'wikidata' AS n, 'Q111014' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '외르크 페르버', 'Jörg Faerber', 'conductor', 'A', '1929', 'Germany', '7ed6d01b-1f09-5be9-b71d-1f110e20a0c4', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '7ed6d01b-1f09-5be9-b71d-1f110e20a0c4');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '1a37b846-c92b-5e0f-8512-4421d05c7f09', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '1a37b846-c92b-5e0f-8512-4421d05c7f09');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1a37b846-c92b-5e0f-8512-4421d05c7f09', 'en', 'canonical', 'Kevin Mallon', 'kevin mallon', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1a37b846-c92b-5e0f-8512-4421d05c7f09' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1a37b846-c92b-5e0f-8512-4421d05c7f09', 'ko', 'canonical', '케빈 맬런', '케빈 맬런', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1a37b846-c92b-5e0f-8512-4421d05c7f09' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '1a37b846-c92b-5e0f-8512-4421d05c7f09' AS a, 'gnd' AS n, '135214777' AS v UNION ALL SELECT '1a37b846-c92b-5e0f-8512-4421d05c7f09' AS a, 'isni' AS n, '0000000110417289' AS v UNION ALL SELECT '1a37b846-c92b-5e0f-8512-4421d05c7f09' AS a, 'musicbrainz_artist' AS n, '127f351e-0e4d-4940-9184-8933b5f54004' AS v UNION ALL SELECT '1a37b846-c92b-5e0f-8512-4421d05c7f09' AS a, 'viaf' AS n, '17454221' AS v UNION ALL SELECT '1a37b846-c92b-5e0f-8512-4421d05c7f09' AS a, 'wikidata' AS n, 'Q6396843' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '케빈 맬런', 'Kevin Mallon', 'conductor', 'A', NULL, 'Ireland', '1a37b846-c92b-5e0f-8512-4421d05c7f09', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '1a37b846-c92b-5e0f-8512-4421d05c7f09');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'c02152b5-d7cf-5751-92f8-716c82511413', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'c02152b5-d7cf-5751-92f8-716c82511413');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c02152b5-d7cf-5751-92f8-716c82511413', 'en', 'canonical', 'Kammerakademie Potsdam', 'kammerakademie potsdam', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c02152b5-d7cf-5751-92f8-716c82511413' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c02152b5-d7cf-5751-92f8-716c82511413', 'ko', 'canonical', '포츠담 실내악 아카데미', '포츠담 실내악 아카데미', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c02152b5-d7cf-5751-92f8-716c82511413' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'c02152b5-d7cf-5751-92f8-716c82511413' AS a, 'gnd' AS n, '10127677-1' AS v UNION ALL SELECT 'c02152b5-d7cf-5751-92f8-716c82511413' AS a, 'musicbrainz_artist' AS n, '8550a803-d5a1-4ee4-84fb-343389b4313a' AS v UNION ALL SELECT 'c02152b5-d7cf-5751-92f8-716c82511413' AS a, 'viaf' AS n, '140552243' AS v UNION ALL SELECT 'c02152b5-d7cf-5751-92f8-716c82511413' AS a, 'wikidata' AS n, 'Q1723133' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '포츠담 실내악 아카데미', 'Kammerakademie Potsdam', 'orchestra', 'A', NULL, 'Germany', 'c02152b5-d7cf-5751-92f8-716c82511413', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'c02152b5-d7cf-5751-92f8-716c82511413');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'aac9af7b-241e-59f3-98ac-c143f097ee3b', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'aac9af7b-241e-59f3-98ac-c143f097ee3b');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'aac9af7b-241e-59f3-98ac-c143f097ee3b', 'en', 'canonical', 'Württembergisches Kammerorchester Heilbronn', 'württembergisches kammerorchester heilbronn', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'aac9af7b-241e-59f3-98ac-c143f097ee3b' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'aac9af7b-241e-59f3-98ac-c143f097ee3b', 'ko', 'canonical', '뷔르템베르크 실내관현악단 하일브론', '뷔르템베르크 실내관현악단 하일브론', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'aac9af7b-241e-59f3-98ac-c143f097ee3b' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'aac9af7b-241e-59f3-98ac-c143f097ee3b' AS a, 'gnd' AS n, '1212430-8' AS v UNION ALL SELECT 'aac9af7b-241e-59f3-98ac-c143f097ee3b' AS a, 'isni' AS n, '0000000110880409' AS v UNION ALL SELECT 'aac9af7b-241e-59f3-98ac-c143f097ee3b' AS a, 'musicbrainz_artist' AS n, '556a5295-5b20-4da7-a9d1-49833162cb73' AS v UNION ALL SELECT 'aac9af7b-241e-59f3-98ac-c143f097ee3b' AS a, 'viaf' AS n, '265720231' AS v UNION ALL SELECT 'aac9af7b-241e-59f3-98ac-c143f097ee3b' AS a, 'viaf' AS n, '276855779' AS v UNION ALL SELECT 'aac9af7b-241e-59f3-98ac-c143f097ee3b' AS a, 'wikidata' AS n, 'Q679341' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '뷔르템베르크 실내관현악단 하일브론', 'Württembergisches Kammerorchester Heilbronn', 'orchestra', 'A', '1960', 'Germany', 'aac9af7b-241e-59f3-98ac-c143f097ee3b', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'aac9af7b-241e-59f3-98ac-c143f097ee3b');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '41bbfd61-64fe-53ea-965b-40b4f6466ad0', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '41bbfd61-64fe-53ea-965b-40b4f6466ad0');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '41bbfd61-64fe-53ea-965b-40b4f6466ad0', 'en', 'canonical', 'Toronto Chamber Orchestra', 'toronto chamber orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '41bbfd61-64fe-53ea-965b-40b4f6466ad0' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '41bbfd61-64fe-53ea-965b-40b4f6466ad0', 'ko', 'canonical', '토론토 체임버 오케스트라', '토론토 체임버 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '41bbfd61-64fe-53ea-965b-40b4f6466ad0' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '41bbfd61-64fe-53ea-965b-40b4f6466ad0' AS a, 'isni' AS n, '0000000108067152' AS v UNION ALL SELECT '41bbfd61-64fe-53ea-965b-40b4f6466ad0' AS a, 'musicbrainz_artist' AS n, '1ad8ce04-43d0-4a48-a00b-0a01db4a9878' AS v UNION ALL SELECT '41bbfd61-64fe-53ea-965b-40b4f6466ad0' AS a, 'musicbrainz_artist' AS n, 'f7cb7568-a7b6-4779-9ebc-ffcd8a946042' AS v UNION ALL SELECT '41bbfd61-64fe-53ea-965b-40b4f6466ad0' AS a, 'viaf' AS n, '217968708' AS v UNION ALL SELECT '41bbfd61-64fe-53ea-965b-40b4f6466ad0' AS a, 'wikidata' AS n, 'Q7826306' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '토론토 체임버 오케스트라', 'Toronto Chamber Orchestra', 'orchestra', 'A', NULL, 'Canada', '41bbfd61-64fe-53ea-965b-40b4f6466ad0', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '41bbfd61-64fe-53ea-965b-40b4f6466ad0');

