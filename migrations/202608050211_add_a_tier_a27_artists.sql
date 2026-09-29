-- A tier A27 에 필요한 인물·단체 다섯 곳을 등록한다.
--
--   길 샤함            (Q1339670)  바이올린 — piece 360
--   데이비드 크라카워   (Q972261)   클라리넷 — piece 360
--   이본 로리오        (Q235500)   피아노   — piece 362
--   샐리 휘트웰        (Q16205888) 피아노   — piece 354
--   파리 국립오페라 관현악단 (Q3355288)     — piece 362
--
-- A27 의 인물·단체 열셋 가운데 여덟은 이미 등록돼 있었다(프뢰스트 308 · 티보데 573 ·
-- 유자 왕 201 · 올라프손 256 · 샤이 290 · 넬손스 293 · 정명훈 235 · 로열 콘세르트허바우
-- 321 · 보스턴 심포니 324).
--
-- 다섯 다 항목이 충실하다(클레임 27~109개). 식별자는 viaf · gnd · isni ·
-- musicbrainz_artist · lccn · wikidata 여섯을 넣었다. **서른 값 모두 기존 엔티티와
-- 겹치지 않는 것을 확인했다.**
--
-- **파리 국립오페라 관현악단은 wikidata 에 viaf 가 둘 있다**(169029541 · 129144638).
-- 앞의 것만 넣었다. 엔티티 UUID 는 식별자 집합에서 만들므로 뒤에 값을 보태면 UUID 가
-- 바뀐다. 창립 연도 진술이 없어 birth_year 를 1669(파리 오페라 창립)로 적었다.
--
-- 샤함·크라카워·휘트웰은 wikidata 에 한국어 라벨이 없어 직접 적었다.
--
-- **이본 로리오는 메시앙의 아내이자 <투랑갈릴라> 초연 피아니스트다.** 작곡가 본인이
-- 아니므로 01-selection.md 의 "작곡가가 자기 곡을 연주한 판은 쓰지 않는다" 에 걸리지
-- 않는다. 같은 배치 360 에서 **메시앙 본인이 친 1956년 판(`Sn8KcMfkiC8`)은 뺐다.**
--
-- 202608050209 와 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '43502787-d4b6-566b-a6c8-5dede142bd74', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '43502787-d4b6-566b-a6c8-5dede142bd74');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '43502787-d4b6-566b-a6c8-5dede142bd74', 'en', 'canonical', 'Gil Shaham', 'gil shaham', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '43502787-d4b6-566b-a6c8-5dede142bd74' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '43502787-d4b6-566b-a6c8-5dede142bd74', 'ko', 'canonical', '길 샤함', '길 샤함', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '43502787-d4b6-566b-a6c8-5dede142bd74' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '43502787-d4b6-566b-a6c8-5dede142bd74' AS a, 'gnd' AS n, '134687981' AS v UNION ALL SELECT '43502787-d4b6-566b-a6c8-5dede142bd74' AS a, 'isni' AS n, '0000000114620794' AS v UNION ALL SELECT '43502787-d4b6-566b-a6c8-5dede142bd74' AS a, 'lccn' AS n, 'no95047036' AS v UNION ALL SELECT '43502787-d4b6-566b-a6c8-5dede142bd74' AS a, 'musicbrainz_artist' AS n, '7bb53313-9859-45e6-9201-5a922e6059e5' AS v UNION ALL SELECT '43502787-d4b6-566b-a6c8-5dede142bd74' AS a, 'viaf' AS n, '84210450' AS v UNION ALL SELECT '43502787-d4b6-566b-a6c8-5dede142bd74' AS a, 'wikidata' AS n, 'Q1339670' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '길 샤함', 'Gil Shaham', 'violinist', 'A', '1971', 'United States', '43502787-d4b6-566b-a6c8-5dede142bd74', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '43502787-d4b6-566b-a6c8-5dede142bd74');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'fcf557af-5315-56fa-8ec3-76316b7b7317', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'fcf557af-5315-56fa-8ec3-76316b7b7317');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'fcf557af-5315-56fa-8ec3-76316b7b7317', 'en', 'canonical', 'David Krakauer', 'david krakauer', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'fcf557af-5315-56fa-8ec3-76316b7b7317' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'fcf557af-5315-56fa-8ec3-76316b7b7317', 'ko', 'canonical', '데이비드 크라카워', '데이비드 크라카워', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'fcf557af-5315-56fa-8ec3-76316b7b7317' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'fcf557af-5315-56fa-8ec3-76316b7b7317' AS a, 'gnd' AS n, '135039762' AS v UNION ALL SELECT 'fcf557af-5315-56fa-8ec3-76316b7b7317' AS a, 'isni' AS n, '0000000114507011' AS v UNION ALL SELECT 'fcf557af-5315-56fa-8ec3-76316b7b7317' AS a, 'lccn' AS n, 'no90021909' AS v UNION ALL SELECT 'fcf557af-5315-56fa-8ec3-76316b7b7317' AS a, 'musicbrainz_artist' AS n, 'fa2849e4-d560-47bb-9a55-259b9cf0de13' AS v UNION ALL SELECT 'fcf557af-5315-56fa-8ec3-76316b7b7317' AS a, 'viaf' AS n, '85686971' AS v UNION ALL SELECT 'fcf557af-5315-56fa-8ec3-76316b7b7317' AS a, 'wikidata' AS n, 'Q972261' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '데이비드 크라카워', 'David Krakauer', 'clarinetist', 'A', '1956', 'United States', 'fcf557af-5315-56fa-8ec3-76316b7b7317', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'fcf557af-5315-56fa-8ec3-76316b7b7317');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce', 'en', 'canonical', 'Yvonne Loriod', 'yvonne loriod', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce', 'ko', 'canonical', '이본 로리오', '이본 로리오', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce' AS a, 'gnd' AS n, '122126084' AS v UNION ALL SELECT '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce' AS a, 'isni' AS n, '0000000081819376' AS v UNION ALL SELECT '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce' AS a, 'lccn' AS n, 'n81012218' AS v UNION ALL SELECT '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce' AS a, 'musicbrainz_artist' AS n, '755f2d93-e9bb-4dbd-841c-9e8e639d4edf' AS v UNION ALL SELECT '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce' AS a, 'viaf' AS n, '113935614' AS v UNION ALL SELECT '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce' AS a, 'wikidata' AS n, 'Q235500' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '이본 로리오', 'Yvonne Loriod', 'pianist', 'A', '1924', 'France', '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '3e8f2ce0-6895-52b2-926a-1fdc466bb2ce');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '21b9c75e-7a05-5320-a7f3-e0243238aae9', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '21b9c75e-7a05-5320-a7f3-e0243238aae9');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '21b9c75e-7a05-5320-a7f3-e0243238aae9', 'en', 'canonical', 'Sally Whitwell', 'sally whitwell', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '21b9c75e-7a05-5320-a7f3-e0243238aae9' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '21b9c75e-7a05-5320-a7f3-e0243238aae9', 'ko', 'canonical', '샐리 휘트웰', '샐리 휘트웰', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '21b9c75e-7a05-5320-a7f3-e0243238aae9' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '21b9c75e-7a05-5320-a7f3-e0243238aae9' AS a, 'gnd' AS n, '1242955313' AS v UNION ALL SELECT '21b9c75e-7a05-5320-a7f3-e0243238aae9' AS a, 'isni' AS n, '0000000455338789' AS v UNION ALL SELECT '21b9c75e-7a05-5320-a7f3-e0243238aae9' AS a, 'lccn' AS n, 'no2015139840' AS v UNION ALL SELECT '21b9c75e-7a05-5320-a7f3-e0243238aae9' AS a, 'musicbrainz_artist' AS n, 'f62c41fd-e80b-4d79-a318-dacf8c8143ec' AS v UNION ALL SELECT '21b9c75e-7a05-5320-a7f3-e0243238aae9' AS a, 'viaf' AS n, '227144783018445602287' AS v UNION ALL SELECT '21b9c75e-7a05-5320-a7f3-e0243238aae9' AS a, 'wikidata' AS n, 'Q16205888' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '샐리 휘트웰', 'Sally Whitwell', 'pianist', 'A', '1974', 'Australia', '21b9c75e-7a05-5320-a7f3-e0243238aae9', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '21b9c75e-7a05-5320-a7f3-e0243238aae9');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a1ae0083-3843-5df0-af0a-5e2499f74735', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a1ae0083-3843-5df0-af0a-5e2499f74735');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a1ae0083-3843-5df0-af0a-5e2499f74735', 'en', 'canonical', 'Orchestre de l''Opéra national de Paris', 'orchestre de l''opéra national de paris', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a1ae0083-3843-5df0-af0a-5e2499f74735' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a1ae0083-3843-5df0-af0a-5e2499f74735', 'ko', 'canonical', '파리 국립오페라 관현악단', '파리 국립오페라 관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a1ae0083-3843-5df0-af0a-5e2499f74735' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a1ae0083-3843-5df0-af0a-5e2499f74735' AS a, 'gnd' AS n, '10341807-6' AS v UNION ALL SELECT 'a1ae0083-3843-5df0-af0a-5e2499f74735' AS a, 'isni' AS n, '0000000123236161' AS v UNION ALL SELECT 'a1ae0083-3843-5df0-af0a-5e2499f74735' AS a, 'lccn' AS n, 'n83066286' AS v UNION ALL SELECT 'a1ae0083-3843-5df0-af0a-5e2499f74735' AS a, 'musicbrainz_artist' AS n, 'a57a7265-00f6-4d4b-809d-c0e734569796' AS v UNION ALL SELECT 'a1ae0083-3843-5df0-af0a-5e2499f74735' AS a, 'viaf' AS n, '169029541' AS v UNION ALL SELECT 'a1ae0083-3843-5df0-af0a-5e2499f74735' AS a, 'wikidata' AS n, 'Q3355288' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '파리 국립오페라 관현악단', 'Orchestre de l''Opéra national de Paris', 'orchestra', 'A', '1669', 'France', 'a1ae0083-3843-5df0-af0a-5e2499f74735', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a1ae0083-3843-5df0-af0a-5e2499f74735');


