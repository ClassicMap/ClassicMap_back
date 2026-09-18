-- 비교 영상 시드(리스트 헝가리 광시곡 2번)에 필요한 피아니스트 1명(스미노 하야토)을 추가한다.
--
-- 202608050056 과 같은 방식이다. authority_entities.id 는 강한 식별자를 정렬해 이은
-- 문자열의 uuid5 다. Wikidata 에 gnd 는 없다.
--
-- 처음 넣은 로베르토 시돈 녹음은 다른 두 연주와 0.1255 로 걸렸다. 크로마를 구간마다
-- 튜닝 추정하는 탓에 +46센트 조율 녹음이 경계에서 뒤집힌 것이었고, 튜닝을 고정하면
-- 0.08 대로 내려갔다. 연주는 같은 곡 구조였지만 측정이 흔들린 채로 교체가 먼저 진행돼
-- 스미노 하야토 연주가 들어갔다. 스미노 연주도 경계 규칙대로 0.0651~0.0818 로 통과했다.
-- 원곡 카덴차로 친 영상이고, 자작 카덴차판(907초)은 쓰지 않았다.
--
-- 한국어 이름은 Wikidata 라벨(스미노 하야토)을 따랐다. 1995년생 신예라 tier 는 Rising 이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '5c007aab-479a-51df-9987-73bf79586d79', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '5c007aab-479a-51df-9987-73bf79586d79');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5c007aab-479a-51df-9987-73bf79586d79', 'en', 'canonical', 'Hayato Sumino', 'hayato sumino', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5c007aab-479a-51df-9987-73bf79586d79' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5c007aab-479a-51df-9987-73bf79586d79', 'ko', 'canonical', '스미노 하야토', '스미노 하야토', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5c007aab-479a-51df-9987-73bf79586d79' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '5c007aab-479a-51df-9987-73bf79586d79' AS a, 'isni' AS n, '0000000482933006' AS v UNION ALL SELECT '5c007aab-479a-51df-9987-73bf79586d79' AS a, 'musicbrainz_artist' AS n, '32b4ec52-3489-4077-bc71-8e84991f976b' AS v UNION ALL SELECT '5c007aab-479a-51df-9987-73bf79586d79' AS a, 'viaf' AS n, '3227161098967329640001' AS v UNION ALL SELECT '5c007aab-479a-51df-9987-73bf79586d79' AS a, 'wikidata' AS n, 'Q95340089' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '스미노 하야토', 'Hayato Sumino', 'pianist', 'Rising', '1995', 'Japan', '5c007aab-479a-51df-9987-73bf79586d79', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '5c007aab-479a-51df-9987-73bf79586d79');
