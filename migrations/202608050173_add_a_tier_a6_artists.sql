-- A tier A6 배치에 필요한 소프라노 3명과 반주자 2명을 추가한다.
--
--   글린카 <종달새>: 비슈넵스카야·로스트로포비치 / 고르차코바·게르기예바 / 숙마노바
--   베를리오즈 두 곡(171·172)은 지휘자·악단이 모두 이미 등록돼 있다
--
-- 202608050070 과 같은 방식이다.
--
-- <종달새>는 발라키레프의 피아노 독주 편곡이 검색 상위를 덮는 곡이다. 성악+피아노
-- 원곡판으로 셋을 맞췄다. 반주자는 ACCOMPANIST 로 넣는다 — PIANIST 로 넣으면
-- 적재기가 독주자로 묶는다(04-loading.md).
--
-- 로스트로포비치는 첼리스트이자 지휘자이나 이 녹음에서는 아내인 비슈넵스카야의
-- 피아노 반주다. 분류는 주된 악기를 따라 cellist 로 둔다. 해소는 wikidata 로
-- 하므로 분류와 크레딧 역할이 어긋나도 적재된다.
--
-- 숙마노바 녹음의 반주자는 크레딧에 넣지 않았다. 서브에이전트가 찾아 온
-- wikidata 항목(Q139199024)은 레이블이 "Elena Sukmanova" 하나뿐이고 직업이
-- 대학 교원으로만 적힌 빈약한 항목이라, 이름이 같다는 것 말고 이 녹음의 반주자라는
-- 근거가 없다. 이름만으로 인물을 붙이지 않는다(CLAUDE.md 의 안전 경계).
-- 한 구간 안에서 크레딧 모양이 달라도 된다 — S tier F1 의 히브리 노예들도
-- 셋 중 둘만 합창단이 붙었다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '27c55efc-25a1-5d9a-8e2f-5d87481aadab', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '27c55efc-25a1-5d9a-8e2f-5d87481aadab');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '27c55efc-25a1-5d9a-8e2f-5d87481aadab', 'en', 'canonical', 'Galina Vishnevskaya', 'galina vishnevskaya', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '27c55efc-25a1-5d9a-8e2f-5d87481aadab' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '27c55efc-25a1-5d9a-8e2f-5d87481aadab', 'ko', 'canonical', '갈리나 비슈넵스카야', '갈리나 비슈넵스카야', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '27c55efc-25a1-5d9a-8e2f-5d87481aadab' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '27c55efc-25a1-5d9a-8e2f-5d87481aadab' AS a, 'gnd' AS n, '118812157' AS v UNION ALL SELECT '27c55efc-25a1-5d9a-8e2f-5d87481aadab' AS a, 'isni' AS n, '0000000114452815' AS v UNION ALL SELECT '27c55efc-25a1-5d9a-8e2f-5d87481aadab' AS a, 'musicbrainz_artist' AS n, 'e11d1526-e57e-4d75-b38d-1a3014a8c835' AS v UNION ALL SELECT '27c55efc-25a1-5d9a-8e2f-5d87481aadab' AS a, 'viaf' AS n, '59090317' AS v UNION ALL SELECT '27c55efc-25a1-5d9a-8e2f-5d87481aadab' AS a, 'wikidata' AS n, 'Q230916' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '갈리나 비슈넵스카야', 'Galina Vishnevskaya', 'soprano', 'A', '1926', 'Russia', '27c55efc-25a1-5d9a-8e2f-5d87481aadab', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '27c55efc-25a1-5d9a-8e2f-5d87481aadab');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '360243e4-2f3a-5ae7-af5f-2cc3e974bd76', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '360243e4-2f3a-5ae7-af5f-2cc3e974bd76');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '360243e4-2f3a-5ae7-af5f-2cc3e974bd76', 'en', 'canonical', 'Galina Gorchakova', 'galina gorchakova', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '360243e4-2f3a-5ae7-af5f-2cc3e974bd76' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '360243e4-2f3a-5ae7-af5f-2cc3e974bd76', 'ko', 'canonical', '갈리나 고르차코바', '갈리나 고르차코바', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '360243e4-2f3a-5ae7-af5f-2cc3e974bd76' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '360243e4-2f3a-5ae7-af5f-2cc3e974bd76' AS a, 'gnd' AS n, '134898532' AS v UNION ALL SELECT '360243e4-2f3a-5ae7-af5f-2cc3e974bd76' AS a, 'isni' AS n, '0000000108854826' AS v UNION ALL SELECT '360243e4-2f3a-5ae7-af5f-2cc3e974bd76' AS a, 'musicbrainz_artist' AS n, 'cd3fe2e1-1719-424e-b010-4a9ab5e5e926' AS v UNION ALL SELECT '360243e4-2f3a-5ae7-af5f-2cc3e974bd76' AS a, 'viaf' AS n, '32193102' AS v UNION ALL SELECT '360243e4-2f3a-5ae7-af5f-2cc3e974bd76' AS a, 'wikidata' AS n, 'Q1811349' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '갈리나 고르차코바', 'Galina Gorchakova', 'soprano', 'A', '1962', 'Russia', '360243e4-2f3a-5ae7-af5f-2cc3e974bd76', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '360243e4-2f3a-5ae7-af5f-2cc3e974bd76');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '1a08a374-98b3-5497-a796-96af76bd3a16', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '1a08a374-98b3-5497-a796-96af76bd3a16');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1a08a374-98b3-5497-a796-96af76bd3a16', 'en', 'canonical', 'Julia Sukmanova', 'julia sukmanova', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1a08a374-98b3-5497-a796-96af76bd3a16' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1a08a374-98b3-5497-a796-96af76bd3a16', 'ko', 'canonical', '율리아 숙마노바', '율리아 숙마노바', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1a08a374-98b3-5497-a796-96af76bd3a16' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '1a08a374-98b3-5497-a796-96af76bd3a16' AS a, 'gnd' AS n, '13552198X' AS v UNION ALL SELECT '1a08a374-98b3-5497-a796-96af76bd3a16' AS a, 'isni' AS n, '0000000119368479' AS v UNION ALL SELECT '1a08a374-98b3-5497-a796-96af76bd3a16' AS a, 'musicbrainz_artist' AS n, '0d652332-320f-4de1-8ca8-0d58e85b6907' AS v UNION ALL SELECT '1a08a374-98b3-5497-a796-96af76bd3a16' AS a, 'viaf' AS n, '80239923' AS v UNION ALL SELECT '1a08a374-98b3-5497-a796-96af76bd3a16' AS a, 'wikidata' AS n, 'Q28034881' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '율리아 숙마노바', 'Julia Sukmanova', 'soprano', 'A', '1975', 'Germany', '1a08a374-98b3-5497-a796-96af76bd3a16', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '1a08a374-98b3-5497-a796-96af76bd3a16');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '8c175da6-a09a-5fc7-8155-7530e72d3871', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '8c175da6-a09a-5fc7-8155-7530e72d3871');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8c175da6-a09a-5fc7-8155-7530e72d3871', 'en', 'canonical', 'Mstislav Rostropovich', 'mstislav rostropovich', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8c175da6-a09a-5fc7-8155-7530e72d3871' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8c175da6-a09a-5fc7-8155-7530e72d3871', 'ko', 'canonical', '므스티슬라프 로스트로포비치', '므스티슬라프 로스트로포비치', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8c175da6-a09a-5fc7-8155-7530e72d3871' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '8c175da6-a09a-5fc7-8155-7530e72d3871' AS a, 'gnd' AS n, '11879129X' AS v UNION ALL SELECT '8c175da6-a09a-5fc7-8155-7530e72d3871' AS a, 'isni' AS n, '0000000120231138' AS v UNION ALL SELECT '8c175da6-a09a-5fc7-8155-7530e72d3871' AS a, 'musicbrainz_artist' AS n, 'e2b294b7-f705-4317-a96b-fd94da3719e5' AS v UNION ALL SELECT '8c175da6-a09a-5fc7-8155-7530e72d3871' AS a, 'viaf' AS n, '29719172' AS v UNION ALL SELECT '8c175da6-a09a-5fc7-8155-7530e72d3871' AS a, 'wikidata' AS n, 'Q152043' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '므스티슬라프 로스트로포비치', 'Mstislav Rostropovich', 'cellist', 'S', '1927', 'Russia', '8c175da6-a09a-5fc7-8155-7530e72d3871', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '8c175da6-a09a-5fc7-8155-7530e72d3871');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '14f96826-413c-5e24-bf37-d7381dbb1b6e', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '14f96826-413c-5e24-bf37-d7381dbb1b6e');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '14f96826-413c-5e24-bf37-d7381dbb1b6e', 'en', 'canonical', 'Larisa Gergieva', 'larisa gergieva', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '14f96826-413c-5e24-bf37-d7381dbb1b6e' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '14f96826-413c-5e24-bf37-d7381dbb1b6e', 'ko', 'canonical', '라리사 게르기예바', '라리사 게르기예바', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '14f96826-413c-5e24-bf37-d7381dbb1b6e' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '14f96826-413c-5e24-bf37-d7381dbb1b6e' AS a, 'musicbrainz_artist' AS n, '1ab49ff3-f646-4711-a73c-27d7c66a75fe' AS v UNION ALL SELECT '14f96826-413c-5e24-bf37-d7381dbb1b6e' AS a, 'viaf' AS n, '8759156677170433770001' AS v UNION ALL SELECT '14f96826-413c-5e24-bf37-d7381dbb1b6e' AS a, 'wikidata' AS n, 'Q4137143' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '라리사 게르기예바', 'Larisa Gergieva', 'pianist', 'A', '1952', 'Russia', '14f96826-413c-5e24-bf37-d7381dbb1b6e', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '14f96826-413c-5e24-bf37-d7381dbb1b6e');

