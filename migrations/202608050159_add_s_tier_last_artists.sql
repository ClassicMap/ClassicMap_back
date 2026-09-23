-- S tier 대기열 마지막 배치(<피가로의 결혼> "편지 이중창")에 필요한 소프라노 4명을
-- 추가한다.
--   마거릿 프라이스, 셰릴 스튜더, 실비아 맥네어, 샤를로테 마르히오노
--
-- 202608050151 과 같은 방식이다. 편지 이중창은 백작부인과 수잔나의 이중창이라
-- 지휘자를 주역으로 두고 소프라노 둘을 크레딧으로 붙인다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'cfb19aa8-5e1e-58e1-8534-0217a235364f', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'cfb19aa8-5e1e-58e1-8534-0217a235364f');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cfb19aa8-5e1e-58e1-8534-0217a235364f', 'en', 'canonical', 'Margaret Price', 'margaret price', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cfb19aa8-5e1e-58e1-8534-0217a235364f' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cfb19aa8-5e1e-58e1-8534-0217a235364f', 'ko', 'canonical', '마거릿 프라이스', '마거릿 프라이스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cfb19aa8-5e1e-58e1-8534-0217a235364f' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'cfb19aa8-5e1e-58e1-8534-0217a235364f' AS a, 'gnd' AS n, '13045608X' AS v UNION ALL SELECT 'cfb19aa8-5e1e-58e1-8534-0217a235364f' AS a, 'isni' AS n, '0000000080969305' AS v UNION ALL SELECT 'cfb19aa8-5e1e-58e1-8534-0217a235364f' AS a, 'musicbrainz_artist' AS n, '95759653-a106-4215-a338-a8e21d44c907' AS v UNION ALL SELECT 'cfb19aa8-5e1e-58e1-8534-0217a235364f' AS a, 'viaf' AS n, '17408611' AS v UNION ALL SELECT 'cfb19aa8-5e1e-58e1-8534-0217a235364f' AS a, 'wikidata' AS n, 'Q254781' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '마거릿 프라이스', 'Margaret Price', 'soprano', 'S', '1941', 'United Kingdom', 'cfb19aa8-5e1e-58e1-8534-0217a235364f', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'cfb19aa8-5e1e-58e1-8534-0217a235364f');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'd507a123-7804-51e5-b821-3fdd4632adb7', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'd507a123-7804-51e5-b821-3fdd4632adb7');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd507a123-7804-51e5-b821-3fdd4632adb7', 'en', 'canonical', 'Cheryl Studer', 'cheryl studer', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd507a123-7804-51e5-b821-3fdd4632adb7' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd507a123-7804-51e5-b821-3fdd4632adb7', 'ko', 'canonical', '셰릴 스튜더', '셰릴 스튜더', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd507a123-7804-51e5-b821-3fdd4632adb7' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'd507a123-7804-51e5-b821-3fdd4632adb7' AS a, 'gnd' AS n, '121092623' AS v UNION ALL SELECT 'd507a123-7804-51e5-b821-3fdd4632adb7' AS a, 'isni' AS n, '0000000109535181' AS v UNION ALL SELECT 'd507a123-7804-51e5-b821-3fdd4632adb7' AS a, 'musicbrainz_artist' AS n, 'cedc341e-0def-4e5b-988e-f58df78d872a' AS v UNION ALL SELECT 'd507a123-7804-51e5-b821-3fdd4632adb7' AS a, 'viaf' AS n, '10034840' AS v UNION ALL SELECT 'd507a123-7804-51e5-b821-3fdd4632adb7' AS a, 'wikidata' AS n, 'Q438857' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '셰릴 스튜더', 'Cheryl Studer', 'soprano', 'S', '1955', 'United States', 'd507a123-7804-51e5-b821-3fdd4632adb7', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'd507a123-7804-51e5-b821-3fdd4632adb7');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '2b41e705-3bb7-517c-9ce8-83f44991157e', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '2b41e705-3bb7-517c-9ce8-83f44991157e');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2b41e705-3bb7-517c-9ce8-83f44991157e', 'en', 'canonical', 'Sylvia McNair', 'sylvia mcnair', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2b41e705-3bb7-517c-9ce8-83f44991157e' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2b41e705-3bb7-517c-9ce8-83f44991157e', 'ko', 'canonical', '실비아 맥네어', '실비아 맥네어', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2b41e705-3bb7-517c-9ce8-83f44991157e' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '2b41e705-3bb7-517c-9ce8-83f44991157e' AS a, 'gnd' AS n, '124953514' AS v UNION ALL SELECT '2b41e705-3bb7-517c-9ce8-83f44991157e' AS a, 'isni' AS n, '0000000120201916' AS v UNION ALL SELECT '2b41e705-3bb7-517c-9ce8-83f44991157e' AS a, 'musicbrainz_artist' AS n, 'b34b88f7-9d86-4f5f-bb9d-568cce5c36ef' AS v UNION ALL SELECT '2b41e705-3bb7-517c-9ce8-83f44991157e' AS a, 'viaf' AS n, '5122061' AS v UNION ALL SELECT '2b41e705-3bb7-517c-9ce8-83f44991157e' AS a, 'wikidata' AS n, 'Q469990' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '실비아 맥네어', 'Sylvia McNair', 'soprano', 'A', '1956', 'United States', '2b41e705-3bb7-517c-9ce8-83f44991157e', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '2b41e705-3bb7-517c-9ce8-83f44991157e');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a3579ae5-62f5-5663-8a1c-2cdd639bbc93', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a3579ae5-62f5-5663-8a1c-2cdd639bbc93');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a3579ae5-62f5-5663-8a1c-2cdd639bbc93', 'en', 'canonical', 'Charlotte Margiono', 'charlotte margiono', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a3579ae5-62f5-5663-8a1c-2cdd639bbc93' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a3579ae5-62f5-5663-8a1c-2cdd639bbc93', 'ko', 'canonical', '샤를로테 마르히오노', '샤를로테 마르히오노', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a3579ae5-62f5-5663-8a1c-2cdd639bbc93' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a3579ae5-62f5-5663-8a1c-2cdd639bbc93' AS a, 'gnd' AS n, '134696301' AS v UNION ALL SELECT 'a3579ae5-62f5-5663-8a1c-2cdd639bbc93' AS a, 'isni' AS n, '0000000117115224' AS v UNION ALL SELECT 'a3579ae5-62f5-5663-8a1c-2cdd639bbc93' AS a, 'musicbrainz_artist' AS n, '7eb0db97-c717-4fbb-963f-03cb6460db3b' AS v UNION ALL SELECT 'a3579ae5-62f5-5663-8a1c-2cdd639bbc93' AS a, 'viaf' AS n, '169663061' AS v UNION ALL SELECT 'a3579ae5-62f5-5663-8a1c-2cdd639bbc93' AS a, 'wikidata' AS n, 'Q2607941' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '샤를로테 마르히오노', 'Charlotte Margiono', 'soprano', 'A', '1955', 'Netherlands', 'a3579ae5-62f5-5663-8a1c-2cdd639bbc93', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a3579ae5-62f5-5663-8a1c-2cdd639bbc93');

