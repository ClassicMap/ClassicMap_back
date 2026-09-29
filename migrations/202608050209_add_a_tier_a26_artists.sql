-- A tier A26 에 필요한 인물·단체 여섯 곳을 등록한다.
--
--   크리스토프 폰 도흐나니 (Q58039)   지휘 — piece 367 · 369
--   피에르 불레즈          (Q156193)  지휘 — piece 367
--   한스 로스바우트        (Q89527)   지휘 — piece 369
--   아르디티 4중주단       (Q639552)  — piece 368
--   줄리아드 현악 4중주단  (Q1413537) — piece 368
--   이탈리아 4중주단       (Q930494)  — piece 368
--
-- A26 의 인물·단체 열한 곳 가운데 다섯은 이미 등록돼 있었다(카라얀 422 · 베를린필 318 ·
-- 클리블랜드 358 · 런던심포니 320 · SWR 바덴바덴·프라이부르크 787).
--
-- 여섯 다 항목이 충실하다(클레임 37~237개). 식별자는 viaf · gnd · isni ·
-- musicbrainz_artist · lccn · wikidata 여섯을 넣었다. **서른여섯 값 모두 기존 엔티티와
-- 겹치지 않는 것을 확인했다** — 202608050193 에서 런던 필하모닉의 viaf 가 홍콩
-- 필하모닉 것과 겹쳐 유니크 제약을 깬 일이 있어 등록 전에 늘 확인한다.
--
-- **불레즈는 지휘자이면서 작곡가다.** 01-selection.md 가 경고한 "지휘자 QID 가 작곡가
-- QID 와 같아 작곡가 엔티티가 연주자로 붙는" 자리인데, A26 의 작곡가는 베베른
-- (Q190933)이라 겹치지 않는다. 불레즈 자신의 곡을 시드할 때는 다시 확인해야 한다.
--
-- 값이 여럿인 식별자는 앞의 것만 넣었다. **엔티티 UUID 는 식별자 집합에서 만들므로
-- 뒤에 값을 보태면 UUID 가 바뀐다.**
--
--   줄리아드 현악 4중주단 musicbrainz_artist — 8ee62ca4… 와 dea4fe6a… 둘
--   이탈리아 4중주단 viaf — 155783044 와 205149108525368780004 둘
--
-- 아르디티 4중주단과 이탈리아 4중주단은 wikidata 에 나라 진술이 없어 영국·이탈리아로
-- 적었다. 한국어 라벨이 있는 것은 불레즈와 로스바우트뿐이고 나머지 넷은 직접 적었다.
-- 4중주단 이름은 에머슨·알반 베르크·라살 4중주단의 표기에 맞췄다.
--
-- **entity_kind 는 person 과 ensemble 둘뿐이다.** 4중주단은 ensemble 이다
-- (202608050207 에서 group 으로 적어 chk_authority_entities_kind 를 깬 일이 있다).
--
-- 202608050207 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '50e3cc0f-8ce5-5e36-befc-6e12c930a419', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '50e3cc0f-8ce5-5e36-befc-6e12c930a419');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '50e3cc0f-8ce5-5e36-befc-6e12c930a419', 'en', 'canonical', 'Christoph von Dohnányi', 'christoph von dohnányi', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '50e3cc0f-8ce5-5e36-befc-6e12c930a419' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '50e3cc0f-8ce5-5e36-befc-6e12c930a419', 'ko', 'canonical', '크리스토프 폰 도흐나니', '크리스토프 폰 도흐나니', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '50e3cc0f-8ce5-5e36-befc-6e12c930a419' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '50e3cc0f-8ce5-5e36-befc-6e12c930a419' AS a, 'gnd' AS n, '118526448' AS v UNION ALL SELECT '50e3cc0f-8ce5-5e36-befc-6e12c930a419' AS a, 'isni' AS n, '0000000081818146' AS v UNION ALL SELECT '50e3cc0f-8ce5-5e36-befc-6e12c930a419' AS a, 'lccn' AS n, 'n81072539' AS v UNION ALL SELECT '50e3cc0f-8ce5-5e36-befc-6e12c930a419' AS a, 'musicbrainz_artist' AS n, '39a2d137-0183-4d73-9948-28cc30c16eca' AS v UNION ALL SELECT '50e3cc0f-8ce5-5e36-befc-6e12c930a419' AS a, 'viaf' AS n, '113843139' AS v UNION ALL SELECT '50e3cc0f-8ce5-5e36-befc-6e12c930a419' AS a, 'wikidata' AS n, 'Q58039' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '크리스토프 폰 도흐나니', 'Christoph von Dohnányi', 'conductor', 'A', '1929', 'Germany', '50e3cc0f-8ce5-5e36-befc-6e12c930a419', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '50e3cc0f-8ce5-5e36-befc-6e12c930a419');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'ef456133-85e7-508f-894b-b26b5a126745', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'ef456133-85e7-508f-894b-b26b5a126745');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ef456133-85e7-508f-894b-b26b5a126745', 'en', 'canonical', 'Pierre Boulez', 'pierre boulez', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ef456133-85e7-508f-894b-b26b5a126745' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ef456133-85e7-508f-894b-b26b5a126745', 'ko', 'canonical', '피에르 불레즈', '피에르 불레즈', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ef456133-85e7-508f-894b-b26b5a126745' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'ef456133-85e7-508f-894b-b26b5a126745' AS a, 'gnd' AS n, '118514024' AS v UNION ALL SELECT 'ef456133-85e7-508f-894b-b26b5a126745' AS a, 'isni' AS n, '0000000121468794' AS v UNION ALL SELECT 'ef456133-85e7-508f-894b-b26b5a126745' AS a, 'lccn' AS n, 'n50042119' AS v UNION ALL SELECT 'ef456133-85e7-508f-894b-b26b5a126745' AS a, 'musicbrainz_artist' AS n, '3bce590b-479f-42ca-b9e0-82883e0db9a2' AS v UNION ALL SELECT 'ef456133-85e7-508f-894b-b26b5a126745' AS a, 'viaf' AS n, '108239968' AS v UNION ALL SELECT 'ef456133-85e7-508f-894b-b26b5a126745' AS a, 'wikidata' AS n, 'Q156193' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '피에르 불레즈', 'Pierre Boulez', 'conductor', 'A', '1925', 'France', 'ef456133-85e7-508f-894b-b26b5a126745', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'ef456133-85e7-508f-894b-b26b5a126745');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '61a968a2-f3a7-58e1-9507-4e8dd791c590', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '61a968a2-f3a7-58e1-9507-4e8dd791c590');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '61a968a2-f3a7-58e1-9507-4e8dd791c590', 'en', 'canonical', 'Hans Rosbaud', 'hans rosbaud', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '61a968a2-f3a7-58e1-9507-4e8dd791c590' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '61a968a2-f3a7-58e1-9507-4e8dd791c590', 'ko', 'canonical', '한스 로스바우트', '한스 로스바우트', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '61a968a2-f3a7-58e1-9507-4e8dd791c590' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '61a968a2-f3a7-58e1-9507-4e8dd791c590' AS a, 'gnd' AS n, '119329751' AS v UNION ALL SELECT '61a968a2-f3a7-58e1-9507-4e8dd791c590' AS a, 'isni' AS n, '000000011047542X' AS v UNION ALL SELECT '61a968a2-f3a7-58e1-9507-4e8dd791c590' AS a, 'lccn' AS n, 'no88003264' AS v UNION ALL SELECT '61a968a2-f3a7-58e1-9507-4e8dd791c590' AS a, 'musicbrainz_artist' AS n, '778d0619-d9fb-400c-8bfe-bdec2c90eec3' AS v UNION ALL SELECT '61a968a2-f3a7-58e1-9507-4e8dd791c590' AS a, 'viaf' AS n, '27252981' AS v UNION ALL SELECT '61a968a2-f3a7-58e1-9507-4e8dd791c590' AS a, 'wikidata' AS n, 'Q89527' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '한스 로스바우트', 'Hans Rosbaud', 'conductor', 'A', '1895', 'Austria', '61a968a2-f3a7-58e1-9507-4e8dd791c590', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '61a968a2-f3a7-58e1-9507-4e8dd791c590');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5', 'en', 'canonical', 'Arditti Quartet', 'arditti quartet', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5', 'ko', 'canonical', '아르디티 4중주단', '아르디티 4중주단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5' AS a, 'gnd' AS n, '5050564-6' AS v UNION ALL SELECT '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5' AS a, 'isni' AS n, '0000000121494300' AS v UNION ALL SELECT '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5' AS a, 'lccn' AS n, 'n80147597' AS v UNION ALL SELECT '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5' AS a, 'musicbrainz_artist' AS n, 'f29493f6-3407-4a96-945b-cdd9642b6e33' AS v UNION ALL SELECT '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5' AS a, 'viaf' AS n, '121315916' AS v UNION ALL SELECT '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5' AS a, 'wikidata' AS n, 'Q639552' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '아르디티 4중주단', 'Arditti Quartet', 'ensemble', 'A', '1974', 'United Kingdom', '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '9c8b9f24-e6af-53ac-8797-8efabdcfa6b5');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e', 'en', 'canonical', 'Juilliard String Quartet', 'juilliard string quartet', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e', 'ko', 'canonical', '줄리아드 현악 4중주단', '줄리아드 현악 4중주단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e' AS a, 'gnd' AS n, '1091505-9' AS v UNION ALL SELECT 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e' AS a, 'isni' AS n, '0000000110887360' AS v UNION ALL SELECT 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e' AS a, 'lccn' AS n, 'n84088423' AS v UNION ALL SELECT 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e' AS a, 'musicbrainz_artist' AS n, '8ee62ca4-6407-4564-b5b4-a8f87427be2d' AS v UNION ALL SELECT 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e' AS a, 'viaf' AS n, '130300106' AS v UNION ALL SELECT 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e' AS a, 'wikidata' AS n, 'Q1413537' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '줄리아드 현악 4중주단', 'Juilliard String Quartet', 'ensemble', 'A', '1946', 'United States', 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'b7712e9b-8fb2-5bec-a95e-c6a6bf7f341e');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '9aebb288-51b7-5938-8490-ff7c2503100b', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '9aebb288-51b7-5938-8490-ff7c2503100b');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9aebb288-51b7-5938-8490-ff7c2503100b', 'en', 'canonical', 'Quartetto Italiano', 'quartetto italiano', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9aebb288-51b7-5938-8490-ff7c2503100b' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9aebb288-51b7-5938-8490-ff7c2503100b', 'ko', 'canonical', '이탈리아 4중주단', '이탈리아 4중주단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9aebb288-51b7-5938-8490-ff7c2503100b' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '9aebb288-51b7-5938-8490-ff7c2503100b' AS a, 'gnd' AS n, '5091615-4' AS v UNION ALL SELECT '9aebb288-51b7-5938-8490-ff7c2503100b' AS a, 'isni' AS n, '0000000104145993' AS v UNION ALL SELECT '9aebb288-51b7-5938-8490-ff7c2503100b' AS a, 'lccn' AS n, 'n82056799' AS v UNION ALL SELECT '9aebb288-51b7-5938-8490-ff7c2503100b' AS a, 'musicbrainz_artist' AS n, 'a6f6b23b-9b21-440a-b1df-72462daabbe1' AS v UNION ALL SELECT '9aebb288-51b7-5938-8490-ff7c2503100b' AS a, 'viaf' AS n, '155783044' AS v UNION ALL SELECT '9aebb288-51b7-5938-8490-ff7c2503100b' AS a, 'wikidata' AS n, 'Q930494' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '이탈리아 4중주단', 'Quartetto Italiano', 'ensemble', 'A', '1945', 'Italy', '9aebb288-51b7-5938-8490-ff7c2503100b', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '9aebb288-51b7-5938-8490-ff7c2503100b');


