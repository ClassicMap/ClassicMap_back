-- 멘델스존 "핑갈의 동굴"(piece 126) 비교 영상에 필요한 지휘자 3명과 악단 1곳을 추가한다.
--
-- 202608050070 과 같은 방식이다. 핑갈의 동굴은 대부분 연주가 10분을 넘어 600초 이하
-- 영상만 골랐고, 그 조건에서 DB 에 등록된 지휘자의 영상은 없었다.
--
-- 레너드 번스타인은 작곡가로 이미 들어와 있다(authority_entities a4ecaa7e-…, 국제 시드).
-- 새 엔티티를 만들면 식별자가 겹치므로 그 엔티티에 artists 행만 붙인다. 작곡가와
-- 엔티티를 공유하는 아티스트는 이미 여럿 있다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '968998a3-3a63-50bb-8db0-15bb54c3c6e8', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '968998a3-3a63-50bb-8db0-15bb54c3c6e8');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '968998a3-3a63-50bb-8db0-15bb54c3c6e8', 'en', 'canonical', 'Kurt Masur', 'kurt masur', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '968998a3-3a63-50bb-8db0-15bb54c3c6e8' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '968998a3-3a63-50bb-8db0-15bb54c3c6e8', 'ko', 'canonical', '쿠르트 마주어', '쿠르트 마주어', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '968998a3-3a63-50bb-8db0-15bb54c3c6e8' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '968998a3-3a63-50bb-8db0-15bb54c3c6e8' AS a, 'gnd' AS n, '118578766' AS v UNION ALL SELECT '968998a3-3a63-50bb-8db0-15bb54c3c6e8' AS a, 'isni' AS n, '0000000363127255' AS v UNION ALL SELECT '968998a3-3a63-50bb-8db0-15bb54c3c6e8' AS a, 'musicbrainz_artist' AS n, 'a46387cc-ae5b-4232-9522-045d561c3b89' AS v UNION ALL SELECT '968998a3-3a63-50bb-8db0-15bb54c3c6e8' AS a, 'viaf' AS n, '226810696' AS v UNION ALL SELECT '968998a3-3a63-50bb-8db0-15bb54c3c6e8' AS a, 'wikidata' AS n, 'Q157921' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '쿠르트 마주어', 'Kurt Masur', 'conductor', 'A', '1927', 'Germany', '968998a3-3a63-50bb-8db0-15bb54c3c6e8', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '968998a3-3a63-50bb-8db0-15bb54c3c6e8');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'bef19c1f-8555-5ab3-8070-4c3fe56d92b1', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'bef19c1f-8555-5ab3-8070-4c3fe56d92b1');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bef19c1f-8555-5ab3-8070-4c3fe56d92b1', 'en', 'canonical', 'John Eliot Gardiner', 'john eliot gardiner', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bef19c1f-8555-5ab3-8070-4c3fe56d92b1' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bef19c1f-8555-5ab3-8070-4c3fe56d92b1', 'ko', 'canonical', '존 엘리엇 가디너', '존 엘리엇 가디너', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bef19c1f-8555-5ab3-8070-4c3fe56d92b1' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'bef19c1f-8555-5ab3-8070-4c3fe56d92b1' AS a, 'gnd' AS n, '123592704' AS v UNION ALL SELECT 'bef19c1f-8555-5ab3-8070-4c3fe56d92b1' AS a, 'isni' AS n, '0000000121039156' AS v UNION ALL SELECT 'bef19c1f-8555-5ab3-8070-4c3fe56d92b1' AS a, 'musicbrainz_artist' AS n, 'eb4fb6c3-f8e5-4923-aea9-436fcf3cf2c0' AS v UNION ALL SELECT 'bef19c1f-8555-5ab3-8070-4c3fe56d92b1' AS a, 'viaf' AS n, '113713740' AS v UNION ALL SELECT 'bef19c1f-8555-5ab3-8070-4c3fe56d92b1' AS a, 'wikidata' AS n, 'Q160325' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '존 엘리엇 가디너', 'John Eliot Gardiner', 'conductor', 'A', '1943', 'United Kingdom', 'bef19c1f-8555-5ab3-8070-4c3fe56d92b1', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'bef19c1f-8555-5ab3-8070-4c3fe56d92b1');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '857553e6-1762-5fcc-98e7-6df6684c6afa', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '857553e6-1762-5fcc-98e7-6df6684c6afa');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '857553e6-1762-5fcc-98e7-6df6684c6afa', 'en', 'canonical', 'Israel Philharmonic Orchestra', 'israel philharmonic orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '857553e6-1762-5fcc-98e7-6df6684c6afa' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '857553e6-1762-5fcc-98e7-6df6684c6afa', 'ko', 'canonical', '이스라엘 필하모닉 오케스트라', '이스라엘 필하모닉 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '857553e6-1762-5fcc-98e7-6df6684c6afa' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '857553e6-1762-5fcc-98e7-6df6684c6afa' AS a, 'gnd' AS n, '5287020-0' AS v UNION ALL SELECT '857553e6-1762-5fcc-98e7-6df6684c6afa' AS a, 'isni' AS n, '0000000109465312' AS v UNION ALL SELECT '857553e6-1762-5fcc-98e7-6df6684c6afa' AS a, 'musicbrainz_artist' AS n, 'c8a88cc7-c93e-42b5-ba29-68859b5716e3' AS v UNION ALL SELECT '857553e6-1762-5fcc-98e7-6df6684c6afa' AS a, 'viaf' AS n, '145422279' AS v UNION ALL SELECT '857553e6-1762-5fcc-98e7-6df6684c6afa' AS a, 'viaf' AS n, '159374172' AS v UNION ALL SELECT '857553e6-1762-5fcc-98e7-6df6684c6afa' AS a, 'wikidata' AS n, 'Q1062617' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '이스라엘 필하모닉 오케스트라', 'Israel Philharmonic Orchestra', 'orchestra', 'A', '1936', 'Israel', '857553e6-1762-5fcc-98e7-6df6684c6afa', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '857553e6-1762-5fcc-98e7-6df6684c6afa');

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '레너드 번스타인', 'Leonard Bernstein', 'conductor', 'S', '1918', 'United States', 'a4ecaa7e-0a45-5ab2-a632-ff3bdf9372a1', 'manual', 1
WHERE EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) target WHERE target.id = 'a4ecaa7e-0a45-5ab2-a632-ff3bdf9372a1')
  AND NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a4ecaa7e-0a45-5ab2-a632-ff3bdf9372a1');
