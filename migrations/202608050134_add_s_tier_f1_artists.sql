-- S tier 대기열 F1 (성악 표본)에 필요한 연주자·단체 12곳을 추가한다.
--   성악:   피셔디스카우, 브린 터펠, 마티아스 괴르네
--   반주:   제럴드 무어, 맬컴 마티노, 안드레아스 헤플리거
--   지휘:   라파엘 프뤼베크 데 부르고스
--   합창단: 암브로시안 싱어스, 라 스칼라 극장 합창단
--   악단:   라 스칼라 극장 관현악단, 라 페니체 극장 관현악단, 바이로이트 축제 관현악단
--
-- 202608050112 와 같은 방식이다. 성부는 category 에 그대로 적는다. comparison/repository.rs
-- 가 baritone·soprano·tenor·mezzo·vocal 을 vocalist 로, choir·ensemble 을 ensemble 로
-- 접으므로 bass-baritone 과 choir 도 올바르게 분류된다.
--
-- 가곡의 피아니스트는 category 를 pianist 로 두되 크레딧 역할은 ACCOMPANIST 다.
-- 반주자와 실내악 짝을 구별하기 위한 것이다(202608050121 의 램버트 오키스와 다르다).

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '11e76501-4e39-5509-b74c-34ad056794f1', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '11e76501-4e39-5509-b74c-34ad056794f1');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '11e76501-4e39-5509-b74c-34ad056794f1', 'en', 'canonical', 'Dietrich Fischer-Dieskau', 'dietrich fischer-dieskau', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '11e76501-4e39-5509-b74c-34ad056794f1' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '11e76501-4e39-5509-b74c-34ad056794f1', 'ko', 'canonical', '디트리히 피셔디스카우', '디트리히 피셔디스카우', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '11e76501-4e39-5509-b74c-34ad056794f1' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '11e76501-4e39-5509-b74c-34ad056794f1' AS a, 'gnd' AS n, '118691457' AS v UNION ALL SELECT '11e76501-4e39-5509-b74c-34ad056794f1' AS a, 'isni' AS n, '0000000121424409' AS v UNION ALL SELECT '11e76501-4e39-5509-b74c-34ad056794f1' AS a, 'musicbrainz_artist' AS n, '1bdc5968-3ca3-497f-b0c1-6de471b26b00' AS v UNION ALL SELECT '11e76501-4e39-5509-b74c-34ad056794f1' AS a, 'viaf' AS n, '86853968' AS v UNION ALL SELECT '11e76501-4e39-5509-b74c-34ad056794f1' AS a, 'wikidata' AS n, 'Q77060' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '디트리히 피셔디스카우', 'Dietrich Fischer-Dieskau', 'baritone', 'S', '1925', 'Germany', '11e76501-4e39-5509-b74c-34ad056794f1', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '11e76501-4e39-5509-b74c-34ad056794f1');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b90631b8-325d-5187-81bb-3d4bc11b958a', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b90631b8-325d-5187-81bb-3d4bc11b958a');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b90631b8-325d-5187-81bb-3d4bc11b958a', 'en', 'canonical', 'Gerald Moore', 'gerald moore', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b90631b8-325d-5187-81bb-3d4bc11b958a' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b90631b8-325d-5187-81bb-3d4bc11b958a', 'ko', 'canonical', '제럴드 무어', '제럴드 무어', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b90631b8-325d-5187-81bb-3d4bc11b958a' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b90631b8-325d-5187-81bb-3d4bc11b958a' AS a, 'gnd' AS n, '118583867' AS v UNION ALL SELECT 'b90631b8-325d-5187-81bb-3d4bc11b958a' AS a, 'isni' AS n, '0000000109287288' AS v UNION ALL SELECT 'b90631b8-325d-5187-81bb-3d4bc11b958a' AS a, 'musicbrainz_artist' AS n, '5978ca05-f0dd-42ef-b716-4ec0cbf659f8' AS v UNION ALL SELECT 'b90631b8-325d-5187-81bb-3d4bc11b958a' AS a, 'viaf' AS n, '100252839' AS v UNION ALL SELECT 'b90631b8-325d-5187-81bb-3d4bc11b958a' AS a, 'wikidata' AS n, 'Q712017' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '제럴드 무어', 'Gerald Moore', 'pianist', 'S', '1899', 'United Kingdom', 'b90631b8-325d-5187-81bb-3d4bc11b958a', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'b90631b8-325d-5187-81bb-3d4bc11b958a');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e944f71b-1c99-59eb-916e-ae5b904c1e67', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'e944f71b-1c99-59eb-916e-ae5b904c1e67');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e944f71b-1c99-59eb-916e-ae5b904c1e67', 'en', 'canonical', 'Bryn Terfel', 'bryn terfel', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e944f71b-1c99-59eb-916e-ae5b904c1e67' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e944f71b-1c99-59eb-916e-ae5b904c1e67', 'ko', 'canonical', '브린 터펠', '브린 터펠', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e944f71b-1c99-59eb-916e-ae5b904c1e67' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'e944f71b-1c99-59eb-916e-ae5b904c1e67' AS a, 'gnd' AS n, '124129536' AS v UNION ALL SELECT 'e944f71b-1c99-59eb-916e-ae5b904c1e67' AS a, 'isni' AS n, '0000000109645962' AS v UNION ALL SELECT 'e944f71b-1c99-59eb-916e-ae5b904c1e67' AS a, 'musicbrainz_artist' AS n, '4b4dea0b-f5a1-4f55-a870-24ad4cdc0840' AS v UNION ALL SELECT 'e944f71b-1c99-59eb-916e-ae5b904c1e67' AS a, 'viaf' AS n, '37106483' AS v UNION ALL SELECT 'e944f71b-1c99-59eb-916e-ae5b904c1e67' AS a, 'wikidata' AS n, 'Q322211' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '브린 터펠', 'Bryn Terfel', 'bass-baritone', 'S', '1965', 'United Kingdom', 'e944f71b-1c99-59eb-916e-ae5b904c1e67', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'e944f71b-1c99-59eb-916e-ae5b904c1e67');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'ce2693b5-6ec0-5615-b5e3-e619425faf5f', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'ce2693b5-6ec0-5615-b5e3-e619425faf5f');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ce2693b5-6ec0-5615-b5e3-e619425faf5f', 'en', 'canonical', 'Malcolm Martineau', 'malcolm martineau', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ce2693b5-6ec0-5615-b5e3-e619425faf5f' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ce2693b5-6ec0-5615-b5e3-e619425faf5f', 'ko', 'canonical', '맬컴 마티노', '맬컴 마티노', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ce2693b5-6ec0-5615-b5e3-e619425faf5f' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'ce2693b5-6ec0-5615-b5e3-e619425faf5f' AS a, 'gnd' AS n, '134769236' AS v UNION ALL SELECT 'ce2693b5-6ec0-5615-b5e3-e619425faf5f' AS a, 'isni' AS n, '0000000114937740' AS v UNION ALL SELECT 'ce2693b5-6ec0-5615-b5e3-e619425faf5f' AS a, 'musicbrainz_artist' AS n, '872813e0-1cab-41d0-9fd2-b5499b621720' AS v UNION ALL SELECT 'ce2693b5-6ec0-5615-b5e3-e619425faf5f' AS a, 'viaf' AS n, '76512451' AS v UNION ALL SELECT 'ce2693b5-6ec0-5615-b5e3-e619425faf5f' AS a, 'wikidata' AS n, 'Q6742481' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '맬컴 마티노', 'Malcolm Martineau', 'pianist', 'A', '1960', 'United Kingdom', 'ce2693b5-6ec0-5615-b5e3-e619425faf5f', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'ce2693b5-6ec0-5615-b5e3-e619425faf5f');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'af3e96c2-008d-5dbc-b225-c50f642726bc', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'af3e96c2-008d-5dbc-b225-c50f642726bc');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'af3e96c2-008d-5dbc-b225-c50f642726bc', 'en', 'canonical', 'Matthias Goerne', 'matthias goerne', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'af3e96c2-008d-5dbc-b225-c50f642726bc' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'af3e96c2-008d-5dbc-b225-c50f642726bc', 'ko', 'canonical', '마티아스 괴르네', '마티아스 괴르네', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'af3e96c2-008d-5dbc-b225-c50f642726bc' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'af3e96c2-008d-5dbc-b225-c50f642726bc' AS a, 'gnd' AS n, '123053552' AS v UNION ALL SELECT 'af3e96c2-008d-5dbc-b225-c50f642726bc' AS a, 'isni' AS n, '0000000114499584' AS v UNION ALL SELECT 'af3e96c2-008d-5dbc-b225-c50f642726bc' AS a, 'musicbrainz_artist' AS n, '246fa33b-223d-45c3-98a7-fe95196492b7' AS v UNION ALL SELECT 'af3e96c2-008d-5dbc-b225-c50f642726bc' AS a, 'viaf' AS n, '84234416' AS v UNION ALL SELECT 'af3e96c2-008d-5dbc-b225-c50f642726bc' AS a, 'wikidata' AS n, 'Q70390' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '마티아스 괴르네', 'Matthias Goerne', 'baritone', 'S', '1967', 'Germany', 'af3e96c2-008d-5dbc-b225-c50f642726bc', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'af3e96c2-008d-5dbc-b225-c50f642726bc');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '884d5894-75de-5fea-8787-685a6f681863', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '884d5894-75de-5fea-8787-685a6f681863');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '884d5894-75de-5fea-8787-685a6f681863', 'en', 'canonical', 'Andreas Haefliger', 'andreas haefliger', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '884d5894-75de-5fea-8787-685a6f681863' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '884d5894-75de-5fea-8787-685a6f681863', 'ko', 'canonical', '안드레아스 헤플리거', '안드레아스 헤플리거', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '884d5894-75de-5fea-8787-685a6f681863' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '884d5894-75de-5fea-8787-685a6f681863' AS a, 'gnd' AS n, '133335615' AS v UNION ALL SELECT '884d5894-75de-5fea-8787-685a6f681863' AS a, 'isni' AS n, '0000000034578661' AS v UNION ALL SELECT '884d5894-75de-5fea-8787-685a6f681863' AS a, 'musicbrainz_artist' AS n, '04f619dd-39f8-4591-b161-e73ce509a9bf' AS v UNION ALL SELECT '884d5894-75de-5fea-8787-685a6f681863' AS a, 'viaf' AS n, '201459' AS v UNION ALL SELECT '884d5894-75de-5fea-8787-685a6f681863' AS a, 'wikidata' AS n, 'Q388020' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '안드레아스 헤플리거', 'Andreas Haefliger', 'pianist', 'A', '1962', 'Switzerland', '884d5894-75de-5fea-8787-685a6f681863', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '884d5894-75de-5fea-8787-685a6f681863');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '07a7e85c-a7e5-5a95-ab93-8a9a1ea7d930', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '07a7e85c-a7e5-5a95-ab93-8a9a1ea7d930');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '07a7e85c-a7e5-5a95-ab93-8a9a1ea7d930', 'en', 'canonical', 'Rafael Frühbeck de Burgos', 'rafael frühbeck de burgos', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '07a7e85c-a7e5-5a95-ab93-8a9a1ea7d930' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '07a7e85c-a7e5-5a95-ab93-8a9a1ea7d930', 'ko', 'canonical', '라파엘 프뤼베크 데 부르고스', '라파엘 프뤼베크 데 부르고스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '07a7e85c-a7e5-5a95-ab93-8a9a1ea7d930' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '07a7e85c-a7e5-5a95-ab93-8a9a1ea7d930' AS a, 'gnd' AS n, '132686147' AS v UNION ALL SELECT '07a7e85c-a7e5-5a95-ab93-8a9a1ea7d930' AS a, 'isni' AS n, '0000000121422788' AS v UNION ALL SELECT '07a7e85c-a7e5-5a95-ab93-8a9a1ea7d930' AS a, 'musicbrainz_artist' AS n, '3dc93820-2336-455d-82db-215b06662835' AS v UNION ALL SELECT '07a7e85c-a7e5-5a95-ab93-8a9a1ea7d930' AS a, 'viaf' AS n, '85851577' AS v UNION ALL SELECT '07a7e85c-a7e5-5a95-ab93-8a9a1ea7d930' AS a, 'wikidata' AS n, 'Q549617' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '라파엘 프뤼베크 데 부르고스', 'Rafael Frühbeck de Burgos', 'conductor', 'S', '1933', 'Spain', '07a7e85c-a7e5-5a95-ab93-8a9a1ea7d930', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '07a7e85c-a7e5-5a95-ab93-8a9a1ea7d930');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613', 'en', 'canonical', 'Ambrosian Singers', 'ambrosian singers', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613', 'ko', 'canonical', '암브로시안 싱어스', '암브로시안 싱어스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613' AS a, 'isni' AS n, '0000000094505050' AS v UNION ALL SELECT '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613' AS a, 'isni' AS n, '0000000109426524' AS v UNION ALL SELECT '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613' AS a, 'musicbrainz_artist' AS n, '8f169b84-95d6-4797-bc00-4cd601fb631e' AS v UNION ALL SELECT '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613' AS a, 'viaf' AS n, '121829656' AS v UNION ALL SELECT '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613' AS a, 'viaf' AS n, '135979879' AS v UNION ALL SELECT '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613' AS a, 'wikidata' AS n, 'Q2588958' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '암브로시안 싱어스', 'Ambrosian Singers', 'choir', 'A', '1951', 'United Kingdom', '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '4b51faa6-e7fc-5bdd-b4d4-6b851a4db613');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a68659f9-5809-5572-a113-e3d1a7d7ec0c', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a68659f9-5809-5572-a113-e3d1a7d7ec0c');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a68659f9-5809-5572-a113-e3d1a7d7ec0c', 'en', 'canonical', 'Coro del Teatro alla Scala', 'coro del teatro alla scala', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a68659f9-5809-5572-a113-e3d1a7d7ec0c' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a68659f9-5809-5572-a113-e3d1a7d7ec0c', 'ko', 'canonical', '라 스칼라 극장 합창단', '라 스칼라 극장 합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a68659f9-5809-5572-a113-e3d1a7d7ec0c' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a68659f9-5809-5572-a113-e3d1a7d7ec0c' AS a, 'gnd' AS n, '800580-1' AS v UNION ALL SELECT 'a68659f9-5809-5572-a113-e3d1a7d7ec0c' AS a, 'isni' AS n, '0000000122880668' AS v UNION ALL SELECT 'a68659f9-5809-5572-a113-e3d1a7d7ec0c' AS a, 'musicbrainz_artist' AS n, 'c2431abf-0fef-48eb-b1fe-3bf3b506c432' AS v UNION ALL SELECT 'a68659f9-5809-5572-a113-e3d1a7d7ec0c' AS a, 'viaf' AS n, '133849697' AS v UNION ALL SELECT 'a68659f9-5809-5572-a113-e3d1a7d7ec0c' AS a, 'wikidata' AS n, 'Q3923908' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '라 스칼라 극장 합창단', 'Coro del Teatro alla Scala', 'choir', 'S', '1778', 'Italy', 'a68659f9-5809-5572-a113-e3d1a7d7ec0c', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a68659f9-5809-5572-a113-e3d1a7d7ec0c');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '11dee5c7-058f-50cf-bd53-8b7dfd70c60a', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '11dee5c7-058f-50cf-bd53-8b7dfd70c60a');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '11dee5c7-058f-50cf-bd53-8b7dfd70c60a', 'en', 'canonical', 'Orchestra del Teatro alla Scala', 'orchestra del teatro alla scala', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '11dee5c7-058f-50cf-bd53-8b7dfd70c60a' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '11dee5c7-058f-50cf-bd53-8b7dfd70c60a', 'ko', 'canonical', '라 스칼라 극장 관현악단', '라 스칼라 극장 관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '11dee5c7-058f-50cf-bd53-8b7dfd70c60a' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '11dee5c7-058f-50cf-bd53-8b7dfd70c60a' AS a, 'gnd' AS n, '800581-3' AS v UNION ALL SELECT '11dee5c7-058f-50cf-bd53-8b7dfd70c60a' AS a, 'isni' AS n, '0000000121612346' AS v UNION ALL SELECT '11dee5c7-058f-50cf-bd53-8b7dfd70c60a' AS a, 'musicbrainz_artist' AS n, 'a8a96598-a77f-4e34-9860-f5f663d33b25' AS v UNION ALL SELECT '11dee5c7-058f-50cf-bd53-8b7dfd70c60a' AS a, 'viaf' AS n, '132668230' AS v UNION ALL SELECT '11dee5c7-058f-50cf-bd53-8b7dfd70c60a' AS a, 'wikidata' AS n, 'Q913873' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '라 스칼라 극장 관현악단', 'Orchestra del Teatro alla Scala', 'orchestra', 'S', '1778', 'Italy', '11dee5c7-058f-50cf-bd53-8b7dfd70c60a', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '11dee5c7-058f-50cf-bd53-8b7dfd70c60a');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e595b40d-262c-521c-a303-52b8011b9b11', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'e595b40d-262c-521c-a303-52b8011b9b11');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e595b40d-262c-521c-a303-52b8011b9b11', 'en', 'canonical', 'Orchestra del Teatro La Fenice', 'orchestra del teatro la fenice', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e595b40d-262c-521c-a303-52b8011b9b11' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e595b40d-262c-521c-a303-52b8011b9b11', 'ko', 'canonical', '라 페니체 극장 관현악단', '라 페니체 극장 관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e595b40d-262c-521c-a303-52b8011b9b11' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'e595b40d-262c-521c-a303-52b8011b9b11' AS a, 'viaf' AS n, '129513846' AS v UNION ALL SELECT 'e595b40d-262c-521c-a303-52b8011b9b11' AS a, 'wikidata' AS n, 'Q102281356' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '라 페니체 극장 관현악단', 'Orchestra del Teatro La Fenice', 'orchestra', 'A', '1792', 'Italy', 'e595b40d-262c-521c-a303-52b8011b9b11', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'e595b40d-262c-521c-a303-52b8011b9b11');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '34c599ab-5f66-52f9-9b39-c3ef6d17366c', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '34c599ab-5f66-52f9-9b39-c3ef6d17366c');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '34c599ab-5f66-52f9-9b39-c3ef6d17366c', 'en', 'canonical', 'Bayreuther Festspielorchester', 'bayreuther festspielorchester', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '34c599ab-5f66-52f9-9b39-c3ef6d17366c' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '34c599ab-5f66-52f9-9b39-c3ef6d17366c', 'ko', 'canonical', '바이로이트 축제 관현악단', '바이로이트 축제 관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '34c599ab-5f66-52f9-9b39-c3ef6d17366c' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '34c599ab-5f66-52f9-9b39-c3ef6d17366c' AS a, 'isni' AS n, '0000000119418763' AS v UNION ALL SELECT '34c599ab-5f66-52f9-9b39-c3ef6d17366c' AS a, 'musicbrainz_artist' AS n, 'd90e3313-7a9e-43ee-aae8-769a53f65e92' AS v UNION ALL SELECT '34c599ab-5f66-52f9-9b39-c3ef6d17366c' AS a, 'viaf' AS n, '147770772' AS v UNION ALL SELECT '34c599ab-5f66-52f9-9b39-c3ef6d17366c' AS a, 'wikidata' AS n, 'Q11327489' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '바이로이트 축제 관현악단', 'Bayreuther Festspielorchester', 'orchestra', 'S', '1876', 'Germany', '34c599ab-5f66-52f9-9b39-c3ef6d17366c', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '34c599ab-5f66-52f9-9b39-c3ef6d17366c');

