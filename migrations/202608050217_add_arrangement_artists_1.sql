-- 편곡 비교 배치 1(리베르탱고)에 필요한 인물·단체 둘을 등록한다.
--
--   앨리슨 발솜   (Q451849)   트럼펫
--   에벤 4중주단  (Q3413743)  현악 4중주
--
-- **요요 마(Q234891)는 이미 등록돼 있다**(artist 215). 적재기가 QID 로 해소하므로
-- 새로 넣지 않는다. **넣으려다 막혔다** — 215 의 authority_entity_id 가
-- f01f8964-7a1e-5ae3-8576-8c2da4a0d0e4 인데 지금 식별자 여섯으로 계산한 uuid5 는
-- 19d6ea93-c7fb-50be-a86d-ff6653bb8998 이다. 식별자 집합이 달라 값이 다르고, 그대로
-- 넣으면 같은 viaf·gnd·isni·musicbrainz·lccn 이 두 엔티티에 붙어 external_identifiers
-- 의 유니크 제약을 깬다. **등록 여부를 QID 로 먼저 확인한 뒤에 uuid5 를 계산해야 한다.**
--
-- 둘 다 항목이 충실하다(클레임 62·74개). 식별자 열두 값 모두 기존 엔티티와 겹치지
-- 않는 것을 확인했다. 에벤 4중주단은 wikidata 에 한국어 라벨과 나라 진술이 없어
-- 다른 4중주단 표기에 맞춰 적고 프랑스로 두었다.
--
-- 202608050215 와 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b958160d-aae3-5ff1-8e45-36f96182b288', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b958160d-aae3-5ff1-8e45-36f96182b288');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b958160d-aae3-5ff1-8e45-36f96182b288', 'en', 'canonical', 'Alison Balsom', 'alison balsom', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b958160d-aae3-5ff1-8e45-36f96182b288' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b958160d-aae3-5ff1-8e45-36f96182b288', 'ko', 'canonical', '앨리슨 발솜', '앨리슨 발솜', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b958160d-aae3-5ff1-8e45-36f96182b288' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b958160d-aae3-5ff1-8e45-36f96182b288' AS a, 'gnd' AS n, '135358434' AS v UNION ALL SELECT 'b958160d-aae3-5ff1-8e45-36f96182b288' AS a, 'isni' AS n, '0000000078514248' AS v UNION ALL SELECT 'b958160d-aae3-5ff1-8e45-36f96182b288' AS a, 'lccn' AS n, 'no2003129705' AS v UNION ALL SELECT 'b958160d-aae3-5ff1-8e45-36f96182b288' AS a, 'musicbrainz_artist' AS n, 'c9f87c8b-b6aa-42d1-9494-c74da4142db8' AS v UNION ALL SELECT 'b958160d-aae3-5ff1-8e45-36f96182b288' AS a, 'viaf' AS n, '76018440' AS v UNION ALL SELECT 'b958160d-aae3-5ff1-8e45-36f96182b288' AS a, 'wikidata' AS n, 'Q451849' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '앨리슨 발솜', 'Alison Balsom', 'trumpeter', 'A', '1978', 'United Kingdom', 'b958160d-aae3-5ff1-8e45-36f96182b288', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'b958160d-aae3-5ff1-8e45-36f96182b288');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4', 'en', 'canonical', 'Quatuor Ébène', 'quatuor ébène', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4', 'ko', 'canonical', '에벤 4중주단', '에벤 4중주단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4' AS a, 'gnd' AS n, '10130780-9' AS v UNION ALL SELECT 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4' AS a, 'isni' AS n, '0000000101816026' AS v UNION ALL SELECT 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4' AS a, 'lccn' AS n, 'n2007026930' AS v UNION ALL SELECT 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4' AS a, 'musicbrainz_artist' AS n, 'cbafa017-eee7-4016-bec1-60267313b8d2' AS v UNION ALL SELECT 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4' AS a, 'viaf' AS n, '151689018' AS v UNION ALL SELECT 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4' AS a, 'wikidata' AS n, 'Q3413743' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '에벤 4중주단', 'Quatuor Ébène', 'ensemble', 'A', '1999', 'France', 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'ac279a95-a45f-5ac2-a7a7-f562ff3583c4');


