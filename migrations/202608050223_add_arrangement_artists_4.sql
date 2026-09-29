-- 편곡 비교 배치 4(아디오스 노니노)에 필요한 인물·단체 다섯을 등록한다.
--
--   카렐 크라이엔호프         (Q2463006) 반도네온
--   세르히오 티엠포           (Q943169)  피아노
--   아라벨라 슈타인바허       (Q84934)   바이올린
--   콘세르트헤바우 실내관현악단 (Q2519414)
--   네덜란드 실내합창단       (Q2701020)
--
-- 다섯 다 등록 확인 세 단계에서 3번 자리다 — artists 도 external_identifiers 도
-- 걸리는 것이 없어 엔티티부터 만든다(05-pitfalls.md).
--
-- 항목은 클레임 19~56개다. 콘세르트헤바우 실내관현악단은 gnd 진술이 없어 식별자
-- 다섯만, 크라이엔호프는 lccn 이 없어 다섯만 넣었다. 네덜란드 실내합창단은 viaf 가
-- 둘이라(132664809 · 136672500) 앞의 것만 넣었다.
--
-- **크라이엔호프의 category 를 `bandoneonist` 로 적었다.** 이 표에 없던 값이다.
-- 반도네온은 아코디언 계열이지만 탱고에서 별개 악기로 다루므로 정확한 값을 새로 쓴다.
-- `artists.category` 는 제약이 없는 varchar 이고 이미 서른 갈래가 넘는다.
--
-- 콘세르트헤바우 실내관현악단은 wikidata 에 창립 연도 진술이 없어 1988로 적었다.
-- 넷은 한국어 라벨이 없어 직접 적었다(슈타인바허만 라벨이 있다).
--
-- 202608050219 와 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '4b701a3e-35ce-51dd-85ad-cf37d28a30ec', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '4b701a3e-35ce-51dd-85ad-cf37d28a30ec');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4b701a3e-35ce-51dd-85ad-cf37d28a30ec', 'en', 'canonical', 'Carel Kraayenhof', 'carel kraayenhof', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4b701a3e-35ce-51dd-85ad-cf37d28a30ec' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4b701a3e-35ce-51dd-85ad-cf37d28a30ec', 'ko', 'canonical', '카렐 크라이엔호프', '카렐 크라이엔호프', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4b701a3e-35ce-51dd-85ad-cf37d28a30ec' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '4b701a3e-35ce-51dd-85ad-cf37d28a30ec' AS a, 'gnd' AS n, '135419964' AS v UNION ALL SELECT '4b701a3e-35ce-51dd-85ad-cf37d28a30ec' AS a, 'isni' AS n, '0000000019701078' AS v UNION ALL SELECT '4b701a3e-35ce-51dd-85ad-cf37d28a30ec' AS a, 'musicbrainz_artist' AS n, '8ad33505-e526-4e58-a4fc-4d7f906703ce' AS v UNION ALL SELECT '4b701a3e-35ce-51dd-85ad-cf37d28a30ec' AS a, 'viaf' AS n, '62764471' AS v UNION ALL SELECT '4b701a3e-35ce-51dd-85ad-cf37d28a30ec' AS a, 'wikidata' AS n, 'Q2463006' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '카렐 크라이엔호프', 'Carel Kraayenhof', 'bandoneonist', 'A', '1958', 'Netherlands', '4b701a3e-35ce-51dd-85ad-cf37d28a30ec', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '4b701a3e-35ce-51dd-85ad-cf37d28a30ec');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '610f121d-a906-51f0-825e-b4f92dad9424', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '610f121d-a906-51f0-825e-b4f92dad9424');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '610f121d-a906-51f0-825e-b4f92dad9424', 'en', 'canonical', 'Sergio Tiempo', 'sergio tiempo', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '610f121d-a906-51f0-825e-b4f92dad9424' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '610f121d-a906-51f0-825e-b4f92dad9424', 'ko', 'canonical', '세르히오 티엠포', '세르히오 티엠포', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '610f121d-a906-51f0-825e-b4f92dad9424' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '610f121d-a906-51f0-825e-b4f92dad9424' AS a, 'gnd' AS n, '13528869X' AS v UNION ALL SELECT '610f121d-a906-51f0-825e-b4f92dad9424' AS a, 'isni' AS n, '0000000110857989' AS v UNION ALL SELECT '610f121d-a906-51f0-825e-b4f92dad9424' AS a, 'lccn' AS n, 'n88620073' AS v UNION ALL SELECT '610f121d-a906-51f0-825e-b4f92dad9424' AS a, 'musicbrainz_artist' AS n, '3b8c7098-5005-4ebb-95f1-5f4dec1062fe' AS v UNION ALL SELECT '610f121d-a906-51f0-825e-b4f92dad9424' AS a, 'viaf' AS n, '117841934' AS v UNION ALL SELECT '610f121d-a906-51f0-825e-b4f92dad9424' AS a, 'wikidata' AS n, 'Q943169' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '세르히오 티엠포', 'Sergio Tiempo', 'pianist', 'A', '1972', 'Argentina', '610f121d-a906-51f0-825e-b4f92dad9424', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '610f121d-a906-51f0-825e-b4f92dad9424');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e2755f44-141c-5114-b327-614ebc6ff7e9', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'e2755f44-141c-5114-b327-614ebc6ff7e9');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e2755f44-141c-5114-b327-614ebc6ff7e9', 'en', 'canonical', 'Arabella Steinbacher', 'arabella steinbacher', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e2755f44-141c-5114-b327-614ebc6ff7e9' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e2755f44-141c-5114-b327-614ebc6ff7e9', 'ko', 'canonical', '아라벨라 슈타인바허', '아라벨라 슈타인바허', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e2755f44-141c-5114-b327-614ebc6ff7e9' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'e2755f44-141c-5114-b327-614ebc6ff7e9' AS a, 'gnd' AS n, '130500364' AS v UNION ALL SELECT 'e2755f44-141c-5114-b327-614ebc6ff7e9' AS a, 'isni' AS n, '0000000081884549' AS v UNION ALL SELECT 'e2755f44-141c-5114-b327-614ebc6ff7e9' AS a, 'lccn' AS n, 'no2005107808' AS v UNION ALL SELECT 'e2755f44-141c-5114-b327-614ebc6ff7e9' AS a, 'musicbrainz_artist' AS n, 'afd0c3db-60b4-4932-9496-d8ad34384a77' AS v UNION ALL SELECT 'e2755f44-141c-5114-b327-614ebc6ff7e9' AS a, 'viaf' AS n, '119455928' AS v UNION ALL SELECT 'e2755f44-141c-5114-b327-614ebc6ff7e9' AS a, 'wikidata' AS n, 'Q84934' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '아라벨라 슈타인바허', 'Arabella Steinbacher', 'violinist', 'A', '1981', 'Germany', 'e2755f44-141c-5114-b327-614ebc6ff7e9', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'e2755f44-141c-5114-b327-614ebc6ff7e9');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '67b49451-7db2-5077-a668-5266236785d7', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '67b49451-7db2-5077-a668-5266236785d7');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '67b49451-7db2-5077-a668-5266236785d7', 'en', 'canonical', 'Concertgebouw Chamber Orchestra', 'concertgebouw chamber orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '67b49451-7db2-5077-a668-5266236785d7' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '67b49451-7db2-5077-a668-5266236785d7', 'ko', 'canonical', '콘세르트헤바우 실내관현악단', '콘세르트헤바우 실내관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '67b49451-7db2-5077-a668-5266236785d7' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '67b49451-7db2-5077-a668-5266236785d7' AS a, 'isni' AS n, '0000000106734994' AS v UNION ALL SELECT '67b49451-7db2-5077-a668-5266236785d7' AS a, 'lccn' AS n, 'n83153286' AS v UNION ALL SELECT '67b49451-7db2-5077-a668-5266236785d7' AS a, 'musicbrainz_artist' AS n, 'dd427b31-cb4a-4fce-9105-ed1407bc689e' AS v UNION ALL SELECT '67b49451-7db2-5077-a668-5266236785d7' AS a, 'viaf' AS n, '153353255' AS v UNION ALL SELECT '67b49451-7db2-5077-a668-5266236785d7' AS a, 'wikidata' AS n, 'Q2519414' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '콘세르트헤바우 실내관현악단', 'Concertgebouw Chamber Orchestra', 'orchestra', 'A', '1988', 'Netherlands', '67b49451-7db2-5077-a668-5266236785d7', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '67b49451-7db2-5077-a668-5266236785d7');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '4e29e9ad-f34f-5692-a75a-36d6749df890', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '4e29e9ad-f34f-5692-a75a-36d6749df890');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4e29e9ad-f34f-5692-a75a-36d6749df890', 'en', 'canonical', 'Nederlands Kamerkoor', 'nederlands kamerkoor', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4e29e9ad-f34f-5692-a75a-36d6749df890' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4e29e9ad-f34f-5692-a75a-36d6749df890', 'ko', 'canonical', '네덜란드 실내합창단', '네덜란드 실내합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4e29e9ad-f34f-5692-a75a-36d6749df890' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '4e29e9ad-f34f-5692-a75a-36d6749df890' AS a, 'gnd' AS n, '1099177-3' AS v UNION ALL SELECT '4e29e9ad-f34f-5692-a75a-36d6749df890' AS a, 'isni' AS n, '0000000110898641' AS v UNION ALL SELECT '4e29e9ad-f34f-5692-a75a-36d6749df890' AS a, 'lccn' AS n, 'n83133737' AS v UNION ALL SELECT '4e29e9ad-f34f-5692-a75a-36d6749df890' AS a, 'musicbrainz_artist' AS n, '076a10cd-a7ba-4d79-9ee5-a52ac1e4af57' AS v UNION ALL SELECT '4e29e9ad-f34f-5692-a75a-36d6749df890' AS a, 'viaf' AS n, '132664809' AS v UNION ALL SELECT '4e29e9ad-f34f-5692-a75a-36d6749df890' AS a, 'wikidata' AS n, 'Q2701020' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '네덜란드 실내합창단', 'Nederlands Kamerkoor', 'choir', 'A', '1937', 'Netherlands', '4e29e9ad-f34f-5692-a75a-36d6749df890', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '4e29e9ad-f34f-5692-a75a-36d6749df890');


