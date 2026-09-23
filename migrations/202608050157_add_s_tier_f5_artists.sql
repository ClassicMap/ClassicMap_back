-- S tier 대기열 F5 (연가곡)에 필요한 연주자 4명을 추가한다.
--   바리톤: 크리스티안 게르하허
--   반주:   게롤트 후버, 그레이엄 존슨, 크리스토프 에셴바흐
--
-- 202608050134 와 같은 방식이다. 가곡의 피아니스트는 category 를 pianist 로 두되
-- 크레딧 역할은 ACCOMPANIST 다(실내악 짝과 구별한다).
--
-- 에셴바흐는 지휘자로도 활동하지만 이 녹음(DG 1979 시인의 사랑)에서는 반주자다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'c028f15a-1843-5b82-812c-6dcc5bd72bed', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'c028f15a-1843-5b82-812c-6dcc5bd72bed');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c028f15a-1843-5b82-812c-6dcc5bd72bed', 'en', 'canonical', 'Christian Gerhaher', 'christian gerhaher', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c028f15a-1843-5b82-812c-6dcc5bd72bed' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c028f15a-1843-5b82-812c-6dcc5bd72bed', 'ko', 'canonical', '크리스티안 게르하허', '크리스티안 게르하허', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c028f15a-1843-5b82-812c-6dcc5bd72bed' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'c028f15a-1843-5b82-812c-6dcc5bd72bed' AS a, 'gnd' AS n, '122321553' AS v UNION ALL SELECT 'c028f15a-1843-5b82-812c-6dcc5bd72bed' AS a, 'isni' AS n, '0000000122825909' AS v UNION ALL SELECT 'c028f15a-1843-5b82-812c-6dcc5bd72bed' AS a, 'musicbrainz_artist' AS n, '8edee8f0-a23b-4c8a-9b26-661062d5e3e3' AS v UNION ALL SELECT 'c028f15a-1843-5b82-812c-6dcc5bd72bed' AS a, 'viaf' AS n, '85768267' AS v UNION ALL SELECT 'c028f15a-1843-5b82-812c-6dcc5bd72bed' AS a, 'wikidata' AS n, 'Q96162' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '크리스티안 게르하허', 'Christian Gerhaher', 'baritone', 'S', '1969', 'Germany', 'c028f15a-1843-5b82-812c-6dcc5bd72bed', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'c028f15a-1843-5b82-812c-6dcc5bd72bed');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '57bfc6d6-a646-51a0-9df0-0d691cdfb4e1', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '57bfc6d6-a646-51a0-9df0-0d691cdfb4e1');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '57bfc6d6-a646-51a0-9df0-0d691cdfb4e1', 'en', 'canonical', 'Gerold Huber', 'gerold huber', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '57bfc6d6-a646-51a0-9df0-0d691cdfb4e1' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '57bfc6d6-a646-51a0-9df0-0d691cdfb4e1', 'ko', 'canonical', '게롤트 후버', '게롤트 후버', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '57bfc6d6-a646-51a0-9df0-0d691cdfb4e1' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '57bfc6d6-a646-51a0-9df0-0d691cdfb4e1' AS a, 'gnd' AS n, '135165032' AS v UNION ALL SELECT '57bfc6d6-a646-51a0-9df0-0d691cdfb4e1' AS a, 'isni' AS n, '0000000081219864' AS v UNION ALL SELECT '57bfc6d6-a646-51a0-9df0-0d691cdfb4e1' AS a, 'musicbrainz_artist' AS n, '0a0564a3-e2af-4ae7-a547-6161d72621dd' AS v UNION ALL SELECT '57bfc6d6-a646-51a0-9df0-0d691cdfb4e1' AS a, 'viaf' AS n, '43055368' AS v UNION ALL SELECT '57bfc6d6-a646-51a0-9df0-0d691cdfb4e1' AS a, 'wikidata' AS n, 'Q99336' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '게롤트 후버', 'Gerold Huber', 'pianist', 'A', '1969', 'Germany', '57bfc6d6-a646-51a0-9df0-0d691cdfb4e1', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '57bfc6d6-a646-51a0-9df0-0d691cdfb4e1');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '349bb826-5c99-5419-bba8-24288a2fd0b1', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '349bb826-5c99-5419-bba8-24288a2fd0b1');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '349bb826-5c99-5419-bba8-24288a2fd0b1', 'en', 'canonical', 'Graham Johnson', 'graham johnson', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '349bb826-5c99-5419-bba8-24288a2fd0b1' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '349bb826-5c99-5419-bba8-24288a2fd0b1', 'ko', 'canonical', '그레이엄 존슨', '그레이엄 존슨', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '349bb826-5c99-5419-bba8-24288a2fd0b1' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '349bb826-5c99-5419-bba8-24288a2fd0b1' AS a, 'gnd' AS n, '123752817' AS v UNION ALL SELECT '349bb826-5c99-5419-bba8-24288a2fd0b1' AS a, 'isni' AS n, '0000000114435695' AS v UNION ALL SELECT '349bb826-5c99-5419-bba8-24288a2fd0b1' AS a, 'musicbrainz_artist' AS n, '79c3088e-8b34-402d-83d9-12e94704610f' AS v UNION ALL SELECT '349bb826-5c99-5419-bba8-24288a2fd0b1' AS a, 'viaf' AS n, '49400324' AS v UNION ALL SELECT '349bb826-5c99-5419-bba8-24288a2fd0b1' AS a, 'wikidata' AS n, 'Q1541946' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '그레이엄 존슨', 'Graham Johnson', 'pianist', 'S', '1950', 'United Kingdom', '349bb826-5c99-5419-bba8-24288a2fd0b1', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '349bb826-5c99-5419-bba8-24288a2fd0b1');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '33618f6e-4f48-5906-ba9f-b8b91e7336de', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '33618f6e-4f48-5906-ba9f-b8b91e7336de');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '33618f6e-4f48-5906-ba9f-b8b91e7336de', 'en', 'canonical', 'Christoph Eschenbach', 'christoph eschenbach', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '33618f6e-4f48-5906-ba9f-b8b91e7336de' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '33618f6e-4f48-5906-ba9f-b8b91e7336de', 'ko', 'canonical', '크리스토프 에셴바흐', '크리스토프 에셴바흐', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '33618f6e-4f48-5906-ba9f-b8b91e7336de' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '33618f6e-4f48-5906-ba9f-b8b91e7336de' AS a, 'gnd' AS n, '11890227X' AS v UNION ALL SELECT '33618f6e-4f48-5906-ba9f-b8b91e7336de' AS a, 'isni' AS n, '0000000108854631' AS v UNION ALL SELECT '33618f6e-4f48-5906-ba9f-b8b91e7336de' AS a, 'musicbrainz_artist' AS n, '67307b9a-5f5c-4611-8d41-d439d343fa84' AS v UNION ALL SELECT '33618f6e-4f48-5906-ba9f-b8b91e7336de' AS a, 'viaf' AS n, '32183095' AS v UNION ALL SELECT '33618f6e-4f48-5906-ba9f-b8b91e7336de' AS a, 'wikidata' AS n, 'Q60814' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '크리스토프 에셴바흐', 'Christoph Eschenbach', 'pianist', 'S', '1940', 'Germany', '33618f6e-4f48-5906-ba9f-b8b91e7336de', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '33618f6e-4f48-5906-ba9f-b8b91e7336de');

