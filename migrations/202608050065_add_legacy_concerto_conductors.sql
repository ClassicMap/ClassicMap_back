-- 레거시 라흐마니노프 협주곡 재수집에 필요한 지휘자 3명과 악단 2곳을 추가한다.
--
-- 202608050059 와 같은 방식이다. authority_entities.id 는 강한 식별자를 정렬해 이은
-- 문자열의 uuid5 다. 협주곡 크레딧은 독주자 → 지휘자 → 악단 순이고, 영상 설명에 적힌
-- 것만 근거로 삼았다.
--   DPJL488cfRw 임윤찬: "Fort Worth Symphony Orchestra / Marin Alsop, conductor" (The Cliburn)
--   5bX_yRzCuM4 유자 왕: "Wiener Philharmoniker conducted by Andrés Orozco-Estrada"
--   rEGOihjqO9w 페도로바: "Nordwestdeutsche Philharmonie led by Martin Panteleev" (AVROTROS)
--   NsqXCO0ADwM 유자 왕: "Mariinsky Theatre Orchestra conducted by Valery Gergiev" (이미 등록)
--
-- 마르틴 판텔레예프는 영문 검색에 걸리지 않았고 러시아어 표기로 찾았다. Wikidata 영문
-- 라벨의 e 가 키릴 문자라 영문 이름은 라틴 문자로 다시 썼다.
-- 한국어 라벨이 없는 곳은 음역했다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '025d0dde-c571-582f-8171-a561cdcf591c', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '025d0dde-c571-582f-8171-a561cdcf591c');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '025d0dde-c571-582f-8171-a561cdcf591c', 'en', 'canonical', 'Marin Alsop', 'marin alsop', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '025d0dde-c571-582f-8171-a561cdcf591c' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '025d0dde-c571-582f-8171-a561cdcf591c', 'ko', 'canonical', '마린 올솝', '마린 올솝', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '025d0dde-c571-582f-8171-a561cdcf591c' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '025d0dde-c571-582f-8171-a561cdcf591c' AS a, 'gnd' AS n, '133513440' AS v UNION ALL SELECT '025d0dde-c571-582f-8171-a561cdcf591c' AS a, 'isni' AS n, '0000000114663428' AS v UNION ALL SELECT '025d0dde-c571-582f-8171-a561cdcf591c' AS a, 'musicbrainz_artist' AS n, '085a100e-4233-4030-a30b-8789e63a3057' AS v UNION ALL SELECT '025d0dde-c571-582f-8171-a561cdcf591c' AS a, 'viaf' AS n, '3664724' AS v UNION ALL SELECT '025d0dde-c571-582f-8171-a561cdcf591c' AS a, 'wikidata' AS n, 'Q242931' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '마린 올솝', 'Marin Alsop', 'conductor', 'A', '1956', 'United States', '025d0dde-c571-582f-8171-a561cdcf591c', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '025d0dde-c571-582f-8171-a561cdcf591c');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'c68065e5-d343-556d-94f6-eca59b7c2add', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'c68065e5-d343-556d-94f6-eca59b7c2add');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c68065e5-d343-556d-94f6-eca59b7c2add', 'en', 'canonical', 'Fort Worth Symphony Orchestra', 'fort worth symphony orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c68065e5-d343-556d-94f6-eca59b7c2add' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c68065e5-d343-556d-94f6-eca59b7c2add', 'ko', 'canonical', '포트워스 심포니 오케스트라', '포트워스 심포니 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c68065e5-d343-556d-94f6-eca59b7c2add' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'c68065e5-d343-556d-94f6-eca59b7c2add' AS a, 'isni' AS n, '0000000110151492' AS v UNION ALL SELECT 'c68065e5-d343-556d-94f6-eca59b7c2add' AS a, 'musicbrainz_artist' AS n, '0fea0ddf-3882-45e2-bab9-c7fcea502deb' AS v UNION ALL SELECT 'c68065e5-d343-556d-94f6-eca59b7c2add' AS a, 'viaf' AS n, '146211420' AS v UNION ALL SELECT 'c68065e5-d343-556d-94f6-eca59b7c2add' AS a, 'wikidata' AS n, 'Q5472407' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '포트워스 심포니 오케스트라', 'Fort Worth Symphony Orchestra', 'orchestra', 'B', '1925', 'United States', 'c68065e5-d343-556d-94f6-eca59b7c2add', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'c68065e5-d343-556d-94f6-eca59b7c2add');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '0b069b24-99f1-5073-b8b4-72ffa9de76ad', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '0b069b24-99f1-5073-b8b4-72ffa9de76ad');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0b069b24-99f1-5073-b8b4-72ffa9de76ad', 'en', 'canonical', 'Andrés Orozco-Estrada', 'andrés orozco-estrada', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0b069b24-99f1-5073-b8b4-72ffa9de76ad' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0b069b24-99f1-5073-b8b4-72ffa9de76ad', 'ko', 'canonical', '안드레스 오로스코에스트라다', '안드레스 오로스코에스트라다', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0b069b24-99f1-5073-b8b4-72ffa9de76ad' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '0b069b24-99f1-5073-b8b4-72ffa9de76ad' AS a, 'gnd' AS n, '1020642564' AS v UNION ALL SELECT '0b069b24-99f1-5073-b8b4-72ffa9de76ad' AS a, 'isni' AS n, '0000000383007461' AS v UNION ALL SELECT '0b069b24-99f1-5073-b8b4-72ffa9de76ad' AS a, 'musicbrainz_artist' AS n, '4a9876f5-dddd-4ca9-ae3c-edc065ea2718' AS v UNION ALL SELECT '0b069b24-99f1-5073-b8b4-72ffa9de76ad' AS a, 'viaf' AS n, '267302106' AS v UNION ALL SELECT '0b069b24-99f1-5073-b8b4-72ffa9de76ad' AS a, 'wikidata' AS n, 'Q946712' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '안드레스 오로스코에스트라다', 'Andrés Orozco-Estrada', 'conductor', 'B', '1977', 'Colombia', '0b069b24-99f1-5073-b8b4-72ffa9de76ad', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '0b069b24-99f1-5073-b8b4-72ffa9de76ad');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '9c88ea0b-d881-5365-bcec-abbe5b031894', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '9c88ea0b-d881-5365-bcec-abbe5b031894');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9c88ea0b-d881-5365-bcec-abbe5b031894', 'en', 'canonical', 'Nordwestdeutsche Philharmonie', 'nordwestdeutsche philharmonie', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9c88ea0b-d881-5365-bcec-abbe5b031894' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9c88ea0b-d881-5365-bcec-abbe5b031894', 'ko', 'canonical', '북서독일 필하모니', '북서독일 필하모니', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9c88ea0b-d881-5365-bcec-abbe5b031894' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '9c88ea0b-d881-5365-bcec-abbe5b031894' AS a, 'gnd' AS n, '5068043-2' AS v UNION ALL SELECT '9c88ea0b-d881-5365-bcec-abbe5b031894' AS a, 'isni' AS n, '0000000123758808' AS v UNION ALL SELECT '9c88ea0b-d881-5365-bcec-abbe5b031894' AS a, 'musicbrainz_artist' AS n, '4df83d02-3eb3-4929-aaa5-d0782b64e144' AS v UNION ALL SELECT '9c88ea0b-d881-5365-bcec-abbe5b031894' AS a, 'viaf' AS n, '159577067' AS v UNION ALL SELECT '9c88ea0b-d881-5365-bcec-abbe5b031894' AS a, 'wikidata' AS n, 'Q318022' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '북서독일 필하모니', 'Nordwestdeutsche Philharmonie', 'orchestra', 'B', '1950', 'Germany', '9c88ea0b-d881-5365-bcec-abbe5b031894', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '9c88ea0b-d881-5365-bcec-abbe5b031894');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b1fabcb3-caf5-54b8-b639-a694c9314c08', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b1fabcb3-caf5-54b8-b639-a694c9314c08');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b1fabcb3-caf5-54b8-b639-a694c9314c08', 'en', 'canonical', 'Martin Panteleev', 'martin panteleev', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b1fabcb3-caf5-54b8-b639-a694c9314c08' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b1fabcb3-caf5-54b8-b639-a694c9314c08', 'ko', 'canonical', '마르틴 판텔레예프', '마르틴 판텔레예프', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b1fabcb3-caf5-54b8-b639-a694c9314c08' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b1fabcb3-caf5-54b8-b639-a694c9314c08' AS a, 'gnd' AS n, '135409829' AS v UNION ALL SELECT 'b1fabcb3-caf5-54b8-b639-a694c9314c08' AS a, 'viaf' AS n, '80166010' AS v UNION ALL SELECT 'b1fabcb3-caf5-54b8-b639-a694c9314c08' AS a, 'wikidata' AS n, 'Q21474595' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '마르틴 판텔레예프', 'Martin Panteleev', 'conductor', 'B', '1976', 'Bulgaria', 'b1fabcb3-caf5-54b8-b639-a694c9314c08', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'b1fabcb3-caf5-54b8-b639-a694c9314c08');
