-- 비교 영상 시드(아이네 클라이네 나흐트무지크 1악장)에 필요한 지휘자 2명과 악단 2곳을 추가한다.
--
-- 202608050036 과 같은 방식이다. authority_entities.id 는 강한 식별자
-- (gnd·isni·musicbrainz_artist·viaf·wikidata)를 정렬해 이은 문자열의 uuid5 다.
--
-- 처음 넣으려던 카라얀·베를린필 연주는 다른 연주 넷 중 셋과 0.110~0.136 으로
-- 어긋났고 곡선이 평평해 판본·연주 차이로 보고 뺐다. 대신 들어간 두 연주의
-- 지휘자·악단이 등록돼 있지 않아 추가한다.
--
-- 한국어 이름
--   네빌 마리너: Wikidata 라벨은 "네빌 매리너"이나 국내 음반 표기를 따랐다
--   아카데미 오브 세인트 마틴 인 더 필즈: Wikidata 라벨은 "세인트 마틴 인 더 필즈 아카데미
--     실내 관현악단"이나 국내 통용 표기를 따랐다
--   볼프강 조보트카: Wikidata 라벨을 따랐다. Wikidata 설명은 오스트리아 정치인이지만
--     직업에 지휘자가 있고, 연결된 MusicBrainz 아티스트의 녹음이 Capella Istropolitana 와의
--     이 곡 녹음을 포함해 같은 사람으로 보았다
--   카펠라 이스트로폴리타나: Wikidata 에 한국어 라벨이 없다. 영상의 Naxos 표기(Capella)를
--     영문명으로 쓰고 음역했다. Wikidata 영문 라벨은 Cappella 다

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '72a90fbf-0711-50f1-9489-30338c256dcb', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '72a90fbf-0711-50f1-9489-30338c256dcb');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '72a90fbf-0711-50f1-9489-30338c256dcb', 'en', 'canonical', 'Neville Marriner', 'neville marriner', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '72a90fbf-0711-50f1-9489-30338c256dcb' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '72a90fbf-0711-50f1-9489-30338c256dcb', 'ko', 'canonical', '네빌 마리너', '네빌 마리너', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '72a90fbf-0711-50f1-9489-30338c256dcb' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '72a90fbf-0711-50f1-9489-30338c256dcb' AS a, 'gnd' AS n, '123186188' AS v UNION ALL SELECT '72a90fbf-0711-50f1-9489-30338c256dcb' AS a, 'isni' AS n, '0000000121174593' AS v UNION ALL SELECT '72a90fbf-0711-50f1-9489-30338c256dcb' AS a, 'musicbrainz_artist' AS n, 'afb8d624-52d7-4a72-8d0b-62fff3e29f79' AS v UNION ALL SELECT '72a90fbf-0711-50f1-9489-30338c256dcb' AS a, 'viaf' AS n, '197041' AS v UNION ALL SELECT '72a90fbf-0711-50f1-9489-30338c256dcb' AS a, 'wikidata' AS n, 'Q318636' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '네빌 마리너', 'Neville Marriner', 'conductor', 'A', '1924', 'United Kingdom', '72a90fbf-0711-50f1-9489-30338c256dcb', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '72a90fbf-0711-50f1-9489-30338c256dcb');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'aff0bd60-d6c0-5da6-8649-1f8ee19e0e24', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'aff0bd60-d6c0-5da6-8649-1f8ee19e0e24');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'aff0bd60-d6c0-5da6-8649-1f8ee19e0e24', 'en', 'canonical', 'Academy of St Martin in the Fields', 'academy of st martin in the fields', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'aff0bd60-d6c0-5da6-8649-1f8ee19e0e24' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'aff0bd60-d6c0-5da6-8649-1f8ee19e0e24', 'ko', 'canonical', '아카데미 오브 세인트 마틴 인 더 필즈', '아카데미 오브 세인트 마틴 인 더 필즈', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'aff0bd60-d6c0-5da6-8649-1f8ee19e0e24' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'aff0bd60-d6c0-5da6-8649-1f8ee19e0e24' AS a, 'gnd' AS n, '1087377-6' AS v UNION ALL SELECT 'aff0bd60-d6c0-5da6-8649-1f8ee19e0e24' AS a, 'isni' AS n, '0000000121832437' AS v UNION ALL SELECT 'aff0bd60-d6c0-5da6-8649-1f8ee19e0e24' AS a, 'musicbrainz_artist' AS n, 'f0ac992d-edd9-4672-ac23-ba0ca93f6539' AS v UNION ALL SELECT 'aff0bd60-d6c0-5da6-8649-1f8ee19e0e24' AS a, 'viaf' AS n, '149879067' AS v UNION ALL SELECT 'aff0bd60-d6c0-5da6-8649-1f8ee19e0e24' AS a, 'wikidata' AS n, 'Q337362' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '아카데미 오브 세인트 마틴 인 더 필즈', 'Academy of St Martin in the Fields', 'orchestra', 'A', '1959', 'United Kingdom', 'aff0bd60-d6c0-5da6-8649-1f8ee19e0e24', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'aff0bd60-d6c0-5da6-8649-1f8ee19e0e24');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f6da024e-d235-5929-b7da-1281edfb26a8', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f6da024e-d235-5929-b7da-1281edfb26a8');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f6da024e-d235-5929-b7da-1281edfb26a8', 'en', 'canonical', 'Wolfgang Sobotka', 'wolfgang sobotka', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f6da024e-d235-5929-b7da-1281edfb26a8' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f6da024e-d235-5929-b7da-1281edfb26a8', 'ko', 'canonical', '볼프강 조보트카', '볼프강 조보트카', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f6da024e-d235-5929-b7da-1281edfb26a8' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'f6da024e-d235-5929-b7da-1281edfb26a8' AS a, 'gnd' AS n, '129030538' AS v UNION ALL SELECT 'f6da024e-d235-5929-b7da-1281edfb26a8' AS a, 'isni' AS n, '0000000382592005' AS v UNION ALL SELECT 'f6da024e-d235-5929-b7da-1281edfb26a8' AS a, 'musicbrainz_artist' AS n, '8f217f84-ae75-4a9a-a783-466a52dffbc8' AS v UNION ALL SELECT 'f6da024e-d235-5929-b7da-1281edfb26a8' AS a, 'viaf' AS n, '265309464' AS v UNION ALL SELECT 'f6da024e-d235-5929-b7da-1281edfb26a8' AS a, 'wikidata' AS n, 'Q2591433' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '볼프강 조보트카', 'Wolfgang Sobotka', 'conductor', 'B', '1956', 'Austria', 'f6da024e-d235-5929-b7da-1281edfb26a8', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'f6da024e-d235-5929-b7da-1281edfb26a8');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '0095cf82-1cc9-570f-9101-a78a7c66dc5b', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '0095cf82-1cc9-570f-9101-a78a7c66dc5b');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0095cf82-1cc9-570f-9101-a78a7c66dc5b', 'en', 'canonical', 'Capella Istropolitana', 'capella istropolitana', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0095cf82-1cc9-570f-9101-a78a7c66dc5b' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0095cf82-1cc9-570f-9101-a78a7c66dc5b', 'ko', 'canonical', '카펠라 이스트로폴리타나', '카펠라 이스트로폴리타나', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0095cf82-1cc9-570f-9101-a78a7c66dc5b' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '0095cf82-1cc9-570f-9101-a78a7c66dc5b' AS a, 'gnd' AS n, '10293993-7' AS v UNION ALL SELECT '0095cf82-1cc9-570f-9101-a78a7c66dc5b' AS a, 'isni' AS n, '0000000123483306' AS v UNION ALL SELECT '0095cf82-1cc9-570f-9101-a78a7c66dc5b' AS a, 'musicbrainz_artist' AS n, '2e7119b5-a3a0-4d78-b8c8-55778f8b618c' AS v UNION ALL SELECT '0095cf82-1cc9-570f-9101-a78a7c66dc5b' AS a, 'viaf' AS n, '149128655' AS v UNION ALL SELECT '0095cf82-1cc9-570f-9101-a78a7c66dc5b' AS a, 'wikidata' AS n, 'Q2937553' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '카펠라 이스트로폴리타나', 'Capella Istropolitana', 'orchestra', 'B', NULL, 'Slovakia', '0095cf82-1cc9-570f-9101-a78a7c66dc5b', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '0095cf82-1cc9-570f-9101-a78a7c66dc5b');
