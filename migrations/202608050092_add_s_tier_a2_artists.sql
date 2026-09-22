-- S tier 대기열 A2 에 필요한 지휘자 1명과 피아니스트 1명을 추가한다.
--   쇼스타코비치 왈츠 2번(piece 319) 싱가포르 교향악단 연주: 앤드루 리턴
--   모차르트 K.265(piece 436): 클라라 하스킬
--
-- 202608050070 과 같은 방식이다. 앤드루 리턴은 Wikidata 에 한국어 라벨이 없어 음역했다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'cb93d095-a4e0-53eb-bba5-667ad9ad6b0f', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'cb93d095-a4e0-53eb-bba5-667ad9ad6b0f');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cb93d095-a4e0-53eb-bba5-667ad9ad6b0f', 'en', 'canonical', 'Andrew Litton', 'andrew litton', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cb93d095-a4e0-53eb-bba5-667ad9ad6b0f' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cb93d095-a4e0-53eb-bba5-667ad9ad6b0f', 'ko', 'canonical', '앤드루 리턴', '앤드루 리턴', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cb93d095-a4e0-53eb-bba5-667ad9ad6b0f' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'cb93d095-a4e0-53eb-bba5-667ad9ad6b0f' AS a, 'gnd' AS n, '134446372' AS v UNION ALL SELECT 'cb93d095-a4e0-53eb-bba5-667ad9ad6b0f' AS a, 'isni' AS n, '0000000114695868' AS v UNION ALL SELECT 'cb93d095-a4e0-53eb-bba5-667ad9ad6b0f' AS a, 'musicbrainz_artist' AS n, 'bd6eaa9f-a581-4e9b-bc53-9a0d80b57898' AS v UNION ALL SELECT 'cb93d095-a4e0-53eb-bba5-667ad9ad6b0f' AS a, 'viaf' AS n, '27252416' AS v UNION ALL SELECT 'cb93d095-a4e0-53eb-bba5-667ad9ad6b0f' AS a, 'wikidata' AS n, 'Q2133568' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '앤드루 리턴', 'Andrew Litton', 'conductor', 'B', '1959', 'United States', 'cb93d095-a4e0-53eb-bba5-667ad9ad6b0f', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'cb93d095-a4e0-53eb-bba5-667ad9ad6b0f');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '01c25980-f86d-557e-9188-25ccf884faa8', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '01c25980-f86d-557e-9188-25ccf884faa8');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '01c25980-f86d-557e-9188-25ccf884faa8', 'en', 'canonical', 'Clara Haskil', 'clara haskil', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '01c25980-f86d-557e-9188-25ccf884faa8' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '01c25980-f86d-557e-9188-25ccf884faa8', 'ko', 'canonical', '클라라 하스킬', '클라라 하스킬', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '01c25980-f86d-557e-9188-25ccf884faa8' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '01c25980-f86d-557e-9188-25ccf884faa8' AS a, 'gnd' AS n, '118546635' AS v UNION ALL SELECT '01c25980-f86d-557e-9188-25ccf884faa8' AS a, 'isni' AS n, '0000000081323960' AS v UNION ALL SELECT '01c25980-f86d-557e-9188-25ccf884faa8' AS a, 'musicbrainz_artist' AS n, '1537563a-8c38-492c-aafd-54b4b6271327' AS v UNION ALL SELECT '01c25980-f86d-557e-9188-25ccf884faa8' AS a, 'viaf' AS n, '54157683' AS v UNION ALL SELECT '01c25980-f86d-557e-9188-25ccf884faa8' AS a, 'wikidata' AS n, 'Q123463' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '클라라 하스킬', 'Clara Haskil', 'pianist', 'A', '1895', 'Switzerland', '01c25980-f86d-557e-9188-25ccf884faa8', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '01c25980-f86d-557e-9188-25ccf884faa8');

