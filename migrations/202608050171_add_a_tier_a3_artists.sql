-- A tier A3 배치에 필요한 독주자 4명·지휘자 2명·악단 2곳을 추가한다.
--
--   J.C. 바흐(카자드쉬 위작) 비올라 협주곡 C단조: 크리스트·뮐러브륄·쾰른 실내 /
--     라둘로비치 / 말리·프라하 실내
--   요한 슈타미츠 클라리넷 협주곡 B♭장조: 마이어·브라운·ASMF(마이어·ASMF 는 이미 등록) /
--     브루너·슈타틀마이어·뮌헨 체임버(모두 이미 등록) / 오텐잠머·포츠담(악단은 이미 등록)
--
-- 202608050070 과 같은 방식이다.
--
-- 프라하 실내관현악단은 wikidata 에 창단 연도가 없어 birth_year 를 NULL 로 둔다.
-- 지어내지 않는다.
--
-- 라둘로비치는 프랑스·세르비아 국적을 함께 갖고 있어 출생지를 따라 세르비아로 적었다.
-- 말리는 국적이 체코슬로바키아로 되어 있으나 현재 국가명인 체코로 적었다.
--
-- 이 배치의 트럼펫 협주곡(piece 112)은 빠졌다. 그 곡 녹음 넷 중 하르덴베르거 말고는
-- 연주자에게 wikidata 항목이 아예 없어 크레딧을 해소할 수 없다. 연주자도 넣지 않는다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '77f1277e-3711-5ab0-b59e-f89d328ee447', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '77f1277e-3711-5ab0-b59e-f89d328ee447');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '77f1277e-3711-5ab0-b59e-f89d328ee447', 'en', 'canonical', 'Wolfram Christ', 'wolfram christ', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '77f1277e-3711-5ab0-b59e-f89d328ee447' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '77f1277e-3711-5ab0-b59e-f89d328ee447', 'ko', 'canonical', '볼프람 크리스트', '볼프람 크리스트', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '77f1277e-3711-5ab0-b59e-f89d328ee447' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '77f1277e-3711-5ab0-b59e-f89d328ee447' AS a, 'gnd' AS n, '134346912' AS v UNION ALL SELECT '77f1277e-3711-5ab0-b59e-f89d328ee447' AS a, 'isni' AS n, '0000000063112510' AS v UNION ALL SELECT '77f1277e-3711-5ab0-b59e-f89d328ee447' AS a, 'musicbrainz_artist' AS n, '57336cb8-b1e7-431a-a041-292e2d557f96' AS v UNION ALL SELECT '77f1277e-3711-5ab0-b59e-f89d328ee447' AS a, 'viaf' AS n, '74043412' AS v UNION ALL SELECT '77f1277e-3711-5ab0-b59e-f89d328ee447' AS a, 'wikidata' AS n, 'Q1696454' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '볼프람 크리스트', 'Wolfram Christ', 'violist', 'A', '1955', 'Germany', '77f1277e-3711-5ab0-b59e-f89d328ee447', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '77f1277e-3711-5ab0-b59e-f89d328ee447');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '765964fa-b966-5d09-a8ac-84f2be2f84f5', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '765964fa-b966-5d09-a8ac-84f2be2f84f5');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '765964fa-b966-5d09-a8ac-84f2be2f84f5', 'en', 'canonical', 'Nemanja Radulović', 'nemanja radulović', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '765964fa-b966-5d09-a8ac-84f2be2f84f5' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '765964fa-b966-5d09-a8ac-84f2be2f84f5', 'ko', 'canonical', '네마냐 라둘로비치', '네마냐 라둘로비치', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '765964fa-b966-5d09-a8ac-84f2be2f84f5' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '765964fa-b966-5d09-a8ac-84f2be2f84f5' AS a, 'gnd' AS n, '1069609870' AS v UNION ALL SELECT '765964fa-b966-5d09-a8ac-84f2be2f84f5' AS a, 'isni' AS n, '000000037201026X' AS v UNION ALL SELECT '765964fa-b966-5d09-a8ac-84f2be2f84f5' AS a, 'musicbrainz_artist' AS n, 'c5ee7c2c-97b2-4b5a-96c8-b6a32102c9e9' AS v UNION ALL SELECT '765964fa-b966-5d09-a8ac-84f2be2f84f5' AS a, 'viaf' AS n, '12555599' AS v UNION ALL SELECT '765964fa-b966-5d09-a8ac-84f2be2f84f5' AS a, 'wikidata' AS n, 'Q3337983' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '네마냐 라둘로비치', 'Nemanja Radulović', 'violist', 'A', '1985', 'Serbia', '765964fa-b966-5d09-a8ac-84f2be2f84f5', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '765964fa-b966-5d09-a8ac-84f2be2f84f5');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '49d46c91-535b-581c-9e4f-0daf1957e2e7', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '49d46c91-535b-581c-9e4f-0daf1957e2e7');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '49d46c91-535b-581c-9e4f-0daf1957e2e7', 'en', 'canonical', 'Lubomír Malý', 'lubomír malý', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '49d46c91-535b-581c-9e4f-0daf1957e2e7' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '49d46c91-535b-581c-9e4f-0daf1957e2e7', 'ko', 'canonical', '루보미르 말리', '루보미르 말리', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '49d46c91-535b-581c-9e4f-0daf1957e2e7' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '49d46c91-535b-581c-9e4f-0daf1957e2e7' AS a, 'gnd' AS n, '134927796' AS v UNION ALL SELECT '49d46c91-535b-581c-9e4f-0daf1957e2e7' AS a, 'isni' AS n, '0000000109223890' AS v UNION ALL SELECT '49d46c91-535b-581c-9e4f-0daf1957e2e7' AS a, 'musicbrainz_artist' AS n, '7a7939ac-1089-422e-b6c1-65dde0accc38' AS v UNION ALL SELECT '49d46c91-535b-581c-9e4f-0daf1957e2e7' AS a, 'viaf' AS n, '87697728' AS v UNION ALL SELECT '49d46c91-535b-581c-9e4f-0daf1957e2e7' AS a, 'wikidata' AS n, 'Q12034092' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '루보미르 말리', 'Lubomír Malý', 'violist', 'A', '1938', 'Czechia', '49d46c91-535b-581c-9e4f-0daf1957e2e7', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '49d46c91-535b-581c-9e4f-0daf1957e2e7');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '158746d8-a7d3-53c8-b532-d126a572a570', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '158746d8-a7d3-53c8-b532-d126a572a570');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '158746d8-a7d3-53c8-b532-d126a572a570', 'en', 'canonical', 'Andreas Ottensamer', 'andreas ottensamer', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '158746d8-a7d3-53c8-b532-d126a572a570' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '158746d8-a7d3-53c8-b532-d126a572a570', 'ko', 'canonical', '안드레아스 오텐잠머', '안드레아스 오텐잠머', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '158746d8-a7d3-53c8-b532-d126a572a570' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '158746d8-a7d3-53c8-b532-d126a572a570' AS a, 'gnd' AS n, '1036548031' AS v UNION ALL SELECT '158746d8-a7d3-53c8-b532-d126a572a570' AS a, 'isni' AS n, '0000000133439683' AS v UNION ALL SELECT '158746d8-a7d3-53c8-b532-d126a572a570' AS a, 'musicbrainz_artist' AS n, '1f38c451-563f-4c6e-8b76-09cbf33bc830' AS v UNION ALL SELECT '158746d8-a7d3-53c8-b532-d126a572a570' AS a, 'viaf' AS n, '304895530' AS v UNION ALL SELECT '158746d8-a7d3-53c8-b532-d126a572a570' AS a, 'wikidata' AS n, 'Q499840' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '안드레아스 오텐잠머', 'Andreas Ottensamer', 'clarinetist', 'A', '1989', 'Austria', '158746d8-a7d3-53c8-b532-d126a572a570', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '158746d8-a7d3-53c8-b532-d126a572a570');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '617b7a3a-4428-53a1-b87c-8e8aec0f659c', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '617b7a3a-4428-53a1-b87c-8e8aec0f659c');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '617b7a3a-4428-53a1-b87c-8e8aec0f659c', 'en', 'canonical', 'Helmut Müller-Brühl', 'helmut müller-brühl', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '617b7a3a-4428-53a1-b87c-8e8aec0f659c' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '617b7a3a-4428-53a1-b87c-8e8aec0f659c', 'ko', 'canonical', '헬무트 뮐러브륄', '헬무트 뮐러브륄', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '617b7a3a-4428-53a1-b87c-8e8aec0f659c' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '617b7a3a-4428-53a1-b87c-8e8aec0f659c' AS a, 'gnd' AS n, '189558806' AS v UNION ALL SELECT '617b7a3a-4428-53a1-b87c-8e8aec0f659c' AS a, 'isni' AS n, '0000000083723706' AS v UNION ALL SELECT '617b7a3a-4428-53a1-b87c-8e8aec0f659c' AS a, 'musicbrainz_artist' AS n, '3e90054d-5055-49e6-a04a-b06958ba7917' AS v UNION ALL SELECT '617b7a3a-4428-53a1-b87c-8e8aec0f659c' AS a, 'viaf' AS n, '35626608' AS v UNION ALL SELECT '617b7a3a-4428-53a1-b87c-8e8aec0f659c' AS a, 'wikidata' AS n, 'Q77898' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '헬무트 뮐러브륄', 'Helmut Müller-Brühl', 'conductor', 'A', '1933', 'Germany', '617b7a3a-4428-53a1-b87c-8e8aec0f659c', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '617b7a3a-4428-53a1-b87c-8e8aec0f659c');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'cd69f7d8-4a84-5617-bd30-3043b479d93b', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'cd69f7d8-4a84-5617-bd30-3043b479d93b');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cd69f7d8-4a84-5617-bd30-3043b479d93b', 'en', 'canonical', 'Iona Brown', 'iona brown', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cd69f7d8-4a84-5617-bd30-3043b479d93b' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cd69f7d8-4a84-5617-bd30-3043b479d93b', 'ko', 'canonical', '아이오나 브라운', '아이오나 브라운', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cd69f7d8-4a84-5617-bd30-3043b479d93b' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'cd69f7d8-4a84-5617-bd30-3043b479d93b' AS a, 'gnd' AS n, '129255947' AS v UNION ALL SELECT 'cd69f7d8-4a84-5617-bd30-3043b479d93b' AS a, 'isni' AS n, '0000000063041943' AS v UNION ALL SELECT 'cd69f7d8-4a84-5617-bd30-3043b479d93b' AS a, 'musicbrainz_artist' AS n, '4c19e018-a94d-4a54-bddd-807a1123c2d8' AS v UNION ALL SELECT 'cd69f7d8-4a84-5617-bd30-3043b479d93b' AS a, 'viaf' AS n, '59268911' AS v UNION ALL SELECT 'cd69f7d8-4a84-5617-bd30-3043b479d93b' AS a, 'wikidata' AS n, 'Q434489' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '아이오나 브라운', 'Iona Brown', 'conductor', 'A', '1941', 'United Kingdom', 'cd69f7d8-4a84-5617-bd30-3043b479d93b', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'cd69f7d8-4a84-5617-bd30-3043b479d93b');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '69123e2b-9896-59ae-96c6-766eacd4eccc', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '69123e2b-9896-59ae-96c6-766eacd4eccc');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '69123e2b-9896-59ae-96c6-766eacd4eccc', 'en', 'canonical', 'Cologne Chamber Orchestra', 'cologne chamber orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '69123e2b-9896-59ae-96c6-766eacd4eccc' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '69123e2b-9896-59ae-96c6-766eacd4eccc', 'ko', 'canonical', '쾰른 실내관현악단', '쾰른 실내관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '69123e2b-9896-59ae-96c6-766eacd4eccc' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '69123e2b-9896-59ae-96c6-766eacd4eccc' AS a, 'isni' AS n, '0000000109433820' AS v UNION ALL SELECT '69123e2b-9896-59ae-96c6-766eacd4eccc' AS a, 'musicbrainz_artist' AS n, 'b93816c3-b729-439c-95f3-d9976e0620cc' AS v UNION ALL SELECT '69123e2b-9896-59ae-96c6-766eacd4eccc' AS a, 'viaf' AS n, '138977589' AS v UNION ALL SELECT '69123e2b-9896-59ae-96c6-766eacd4eccc' AS a, 'wikidata' AS n, 'Q111795682' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '쾰른 실내관현악단', 'Cologne Chamber Orchestra', 'orchestra', 'A', '1923', 'Germany', '69123e2b-9896-59ae-96c6-766eacd4eccc', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '69123e2b-9896-59ae-96c6-766eacd4eccc');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '567a15fd-9540-5f4f-91c2-3ce848507691', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '567a15fd-9540-5f4f-91c2-3ce848507691');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '567a15fd-9540-5f4f-91c2-3ce848507691', 'en', 'canonical', 'Prague Chamber Orchestra', 'prague chamber orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '567a15fd-9540-5f4f-91c2-3ce848507691' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '567a15fd-9540-5f4f-91c2-3ce848507691', 'ko', 'canonical', '프라하 실내관현악단', '프라하 실내관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '567a15fd-9540-5f4f-91c2-3ce848507691' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '567a15fd-9540-5f4f-91c2-3ce848507691' AS a, 'isni' AS n, '0000000120344263' AS v UNION ALL SELECT '567a15fd-9540-5f4f-91c2-3ce848507691' AS a, 'musicbrainz_artist' AS n, '1907a467-fabb-42be-9aaf-9baa488376bc' AS v UNION ALL SELECT '567a15fd-9540-5f4f-91c2-3ce848507691' AS a, 'viaf' AS n, '142050442' AS v UNION ALL SELECT '567a15fd-9540-5f4f-91c2-3ce848507691' AS a, 'wikidata' AS n, 'Q11335518' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '프라하 실내관현악단', 'Prague Chamber Orchestra', 'orchestra', 'A', NULL, 'Czechia', '567a15fd-9540-5f4f-91c2-3ce848507691', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '567a15fd-9540-5f4f-91c2-3ce848507691');

