-- 영화 속 클래식 4차(film-f4) 레퀴엠 「Confutatis」 카라얀 판에 필요한 합창단 하나를 등록한다.
--
--   빈 악우협회 합창단 (Wiener Singverein, Q313692)
--
-- 등록 확인 세 단계(05-pitfalls.md)에서 3번 자리다 — wikidata 로도, gnd·isni·musicbrainz·viaf·lccn 으로도
-- artists·external_identifiers 에 걸리는 것이 없어 엔티티부터 만든다.
-- 엔티티 id 는 식별자 집합의 uuid5 다(202608050223 과 같은 규칙).
-- 한국어 이름은 wikidata 한국어 라벨을 따랐다. 창립 1858, 오스트리아.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '90ac7161-919e-5290-a7a3-644b0e6f9373', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '90ac7161-919e-5290-a7a3-644b0e6f9373');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '90ac7161-919e-5290-a7a3-644b0e6f9373', 'en', 'canonical', 'Wiener Singverein', 'wiener singverein', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '90ac7161-919e-5290-a7a3-644b0e6f9373' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '90ac7161-919e-5290-a7a3-644b0e6f9373', 'ko', 'canonical', '빈 악우협회 합창단', '빈 악우협회 합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '90ac7161-919e-5290-a7a3-644b0e6f9373' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '90ac7161-919e-5290-a7a3-644b0e6f9373' AS a, 'gnd' AS n, '1088734-9' AS v UNION ALL SELECT '90ac7161-919e-5290-a7a3-644b0e6f9373' AS a, 'isni' AS n, '0000000109442305' AS v UNION ALL SELECT '90ac7161-919e-5290-a7a3-644b0e6f9373' AS a, 'lccn' AS n, 'n82119509' AS v UNION ALL SELECT '90ac7161-919e-5290-a7a3-644b0e6f9373' AS a, 'musicbrainz_artist' AS n, '18dc8071-2248-4c25-ba94-c92e288bd4ae' AS v UNION ALL SELECT '90ac7161-919e-5290-a7a3-644b0e6f9373' AS a, 'viaf' AS n, '247111890' AS v UNION ALL SELECT '90ac7161-919e-5290-a7a3-644b0e6f9373' AS a, 'wikidata' AS n, 'Q313692' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '빈 악우협회 합창단', 'Wiener Singverein', 'choir', 'A', '1858', 'Austria', '90ac7161-919e-5290-a7a3-644b0e6f9373', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '90ac7161-919e-5290-a7a3-644b0e6f9373');
