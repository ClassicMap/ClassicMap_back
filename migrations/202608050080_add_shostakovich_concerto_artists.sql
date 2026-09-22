-- 쇼스타코비치 피아노 협주곡 2번 2악장(piece 458) 비교 영상에 필요한 피아니스트 1명,
-- 지휘자 2명, 악단 2곳을 추가한다.
--
-- 202608050070 에서 이 곡을 보류하며 빼 두었던 연주자다. 202608050081 에서 곡을 합치고
-- 적재한다. 방식은 202608050070 과 같다. 한국어 라벨이 없는 곳은 음역했다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f7847d13-3e7b-56ee-92ad-fd3a29f05815', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f7847d13-3e7b-56ee-92ad-fd3a29f05815');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f7847d13-3e7b-56ee-92ad-fd3a29f05815', 'en', 'canonical', 'Elisabeth Leonskaja', 'elisabeth leonskaja', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f7847d13-3e7b-56ee-92ad-fd3a29f05815' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f7847d13-3e7b-56ee-92ad-fd3a29f05815', 'ko', 'canonical', '엘리자베트 레온스카야', '엘리자베트 레온스카야', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f7847d13-3e7b-56ee-92ad-fd3a29f05815' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'f7847d13-3e7b-56ee-92ad-fd3a29f05815' AS a, 'gnd' AS n, '130219584' AS v UNION ALL SELECT 'f7847d13-3e7b-56ee-92ad-fd3a29f05815' AS a, 'isni' AS n, '0000000078391938' AS v UNION ALL SELECT 'f7847d13-3e7b-56ee-92ad-fd3a29f05815' AS a, 'musicbrainz_artist' AS n, 'db511542-7e53-4dfb-b513-504d52a0446f' AS v UNION ALL SELECT 'f7847d13-3e7b-56ee-92ad-fd3a29f05815' AS a, 'viaf' AS n, '29718547' AS v UNION ALL SELECT 'f7847d13-3e7b-56ee-92ad-fd3a29f05815' AS a, 'wikidata' AS n, 'Q447946' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '엘리자베트 레온스카야', 'Elisabeth Leonskaja', 'pianist', 'A', '1945', 'Austria', 'f7847d13-3e7b-56ee-92ad-fd3a29f05815', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'f7847d13-3e7b-56ee-92ad-fd3a29f05815');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '4f252f4f-9645-5d35-a6bc-7bb87f9c2ca5', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '4f252f4f-9645-5d35-a6bc-7bb87f9c2ca5');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4f252f4f-9645-5d35-a6bc-7bb87f9c2ca5', 'en', 'canonical', 'Teodor Currentzis', 'teodor currentzis', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4f252f4f-9645-5d35-a6bc-7bb87f9c2ca5' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4f252f4f-9645-5d35-a6bc-7bb87f9c2ca5', 'ko', 'canonical', '테오도르 쿠렌치스', '테오도르 쿠렌치스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4f252f4f-9645-5d35-a6bc-7bb87f9c2ca5' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '4f252f4f-9645-5d35-a6bc-7bb87f9c2ca5' AS a, 'gnd' AS n, '139276645' AS v UNION ALL SELECT '4f252f4f-9645-5d35-a6bc-7bb87f9c2ca5' AS a, 'isni' AS n, '0000000086196905' AS v UNION ALL SELECT '4f252f4f-9645-5d35-a6bc-7bb87f9c2ca5' AS a, 'musicbrainz_artist' AS n, 'a68eae98-e3b3-422f-9c51-932fd1032c0d' AS v UNION ALL SELECT '4f252f4f-9645-5d35-a6bc-7bb87f9c2ca5' AS a, 'viaf' AS n, '119169905' AS v UNION ALL SELECT '4f252f4f-9645-5d35-a6bc-7bb87f9c2ca5' AS a, 'wikidata' AS n, 'Q536185' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '테오도르 쿠렌치스', 'Teodor Currentzis', 'conductor', 'A', '1972', 'Greece', '4f252f4f-9645-5d35-a6bc-7bb87f9c2ca5', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '4f252f4f-9645-5d35-a6bc-7bb87f9c2ca5');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b2c3e92c-b3e0-5abe-bad3-d91a320865d8', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b2c3e92c-b3e0-5abe-bad3-d91a320865d8');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b2c3e92c-b3e0-5abe-bad3-d91a320865d8', 'en', 'canonical', 'Hugh Wolff', 'hugh wolff', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b2c3e92c-b3e0-5abe-bad3-d91a320865d8' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b2c3e92c-b3e0-5abe-bad3-d91a320865d8', 'ko', 'canonical', '휴 울프', '휴 울프', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b2c3e92c-b3e0-5abe-bad3-d91a320865d8' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b2c3e92c-b3e0-5abe-bad3-d91a320865d8' AS a, 'gnd' AS n, '123323355' AS v UNION ALL SELECT 'b2c3e92c-b3e0-5abe-bad3-d91a320865d8' AS a, 'isni' AS n, '0000000114505593' AS v UNION ALL SELECT 'b2c3e92c-b3e0-5abe-bad3-d91a320865d8' AS a, 'musicbrainz_artist' AS n, '9f1bc551-0a38-4ab8-900c-f8b3c2039e1e' AS v UNION ALL SELECT 'b2c3e92c-b3e0-5abe-bad3-d91a320865d8' AS a, 'viaf' AS n, '85500972' AS v UNION ALL SELECT 'b2c3e92c-b3e0-5abe-bad3-d91a320865d8' AS a, 'wikidata' AS n, 'Q320019' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '휴 울프', 'Hugh Wolff', 'conductor', 'B', '1953', 'United States', 'b2c3e92c-b3e0-5abe-bad3-d91a320865d8', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'b2c3e92c-b3e0-5abe-bad3-d91a320865d8');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a49449d4-2e76-5411-8baa-3965e19620d8', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a49449d4-2e76-5411-8baa-3965e19620d8');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a49449d4-2e76-5411-8baa-3965e19620d8', 'en', 'canonical', 'Mahler Chamber Orchestra', 'mahler chamber orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a49449d4-2e76-5411-8baa-3965e19620d8' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a49449d4-2e76-5411-8baa-3965e19620d8', 'ko', 'canonical', '말러 체임버 오케스트라', '말러 체임버 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a49449d4-2e76-5411-8baa-3965e19620d8' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a49449d4-2e76-5411-8baa-3965e19620d8' AS a, 'gnd' AS n, '5540228-8' AS v UNION ALL SELECT 'a49449d4-2e76-5411-8baa-3965e19620d8' AS a, 'isni' AS n, '0000000104422532' AS v UNION ALL SELECT 'a49449d4-2e76-5411-8baa-3965e19620d8' AS a, 'musicbrainz_artist' AS n, '744b6526-77ce-484e-8816-d06aaebccfa1' AS v UNION ALL SELECT 'a49449d4-2e76-5411-8baa-3965e19620d8' AS a, 'viaf' AS n, '156227151' AS v UNION ALL SELECT 'a49449d4-2e76-5411-8baa-3965e19620d8' AS a, 'wikidata' AS n, 'Q573902' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '말러 체임버 오케스트라', 'Mahler Chamber Orchestra', 'orchestra', 'A', '1997', 'Germany', 'a49449d4-2e76-5411-8baa-3965e19620d8', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a49449d4-2e76-5411-8baa-3965e19620d8');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f0ec02a5-72cc-533b-9976-298c85c962b7', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f0ec02a5-72cc-533b-9976-298c85c962b7');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f0ec02a5-72cc-533b-9976-298c85c962b7', 'en', 'canonical', 'Saint Paul Chamber Orchestra', 'saint paul chamber orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f0ec02a5-72cc-533b-9976-298c85c962b7' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f0ec02a5-72cc-533b-9976-298c85c962b7', 'ko', 'canonical', '세인트폴 체임버 오케스트라', '세인트폴 체임버 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f0ec02a5-72cc-533b-9976-298c85c962b7' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'f0ec02a5-72cc-533b-9976-298c85c962b7' AS a, 'isni' AS n, '0000000107247274' AS v UNION ALL SELECT 'f0ec02a5-72cc-533b-9976-298c85c962b7' AS a, 'musicbrainz_artist' AS n, 'd6653a8f-90c4-49a1-ae66-0b2e180e3bb5' AS v UNION ALL SELECT 'f0ec02a5-72cc-533b-9976-298c85c962b7' AS a, 'viaf' AS n, '125999712' AS v UNION ALL SELECT 'f0ec02a5-72cc-533b-9976-298c85c962b7' AS a, 'viaf' AS n, '140400484' AS v UNION ALL SELECT 'f0ec02a5-72cc-533b-9976-298c85c962b7' AS a, 'wikidata' AS n, 'Q2905648' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '세인트폴 체임버 오케스트라', 'Saint Paul Chamber Orchestra', 'orchestra', 'B', '1959', 'United States', 'f0ec02a5-72cc-533b-9976-298c85c962b7', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'f0ec02a5-72cc-533b-9976-298c85c962b7');

