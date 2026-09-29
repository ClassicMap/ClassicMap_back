-- A tier A29 에 필요한 인물·단체 셋을 등록한다.
--
--   겐나디 로즈데스트벤스키   (Q437262)   지휘
--   로리스 체크나보리안       (Q2984588)  지휘
--   아르메니아 필하모닉 오케스트라 (Q3267972)
--
-- A29 는 발행분이 381 <칼춤> 한 곡뿐이다(377 은 막았다). 나머지 둘(오르만디 752 ·
-- 필라델피아 오케스트라 357)은 이미 등록돼 있었다.
--
-- 셋 다 항목이 충실하다(클레임 31~130개). 식별자 열여덟 값 모두 기존 엔티티와 겹치지
-- 않는 것을 확인했다.
--
-- **로즈데스트벤스키는 wikidata 에 viaf 가 둘이다**(218144783034082019009 · 2657606).
-- 앞의 것만 넣었다. 엔티티 UUID 는 식별자 집합에서 만들므로 뒤에 값을 보태면 UUID 가
-- 바뀐다.
--
-- nationality 는 wikidata 진술을 그대로 쓰지 않았다. 로즈데스트벤스키의 진술이
-- "Soviet Union", 체크나보리안이 "Pahlavi Iran" 으로 지금 없는 나라다. 화면에 뜨는
-- 값이므로 Russia · Armenia 로 적었다. 아르메니아 필하모닉은 진술이 없어 Armenia 로 적었다.
--
-- **레닌그라드 필하모닉은 새로 등록하지 않았다.** 상트페테르부르크 필하모닉(artist 345,
-- Q1373970)과 같은 악단이 이름만 바뀐 것이다. 배급 표기는 "Leningrad Philharmonic
-- Orchestra" 인데 QID 로 해소되므로 등록된 이름을 쓴다. 202608050209 에서 SWF 바덴바덴
-- 교향악단을 SWR 바덴바덴·프라이부르크(787)로 해소한 것과 같다.
--
-- 202608050211 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '990d8d23-031b-5088-b34a-f373087a0055', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '990d8d23-031b-5088-b34a-f373087a0055');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '990d8d23-031b-5088-b34a-f373087a0055', 'en', 'canonical', 'Gennadi Rozhdestvensky', 'gennadi rozhdestvensky', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '990d8d23-031b-5088-b34a-f373087a0055' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '990d8d23-031b-5088-b34a-f373087a0055', 'ko', 'canonical', '겐나디 로즈데스트벤스키', '겐나디 로즈데스트벤스키', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '990d8d23-031b-5088-b34a-f373087a0055' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '990d8d23-031b-5088-b34a-f373087a0055' AS a, 'gnd' AS n, '124075991' AS v UNION ALL SELECT '990d8d23-031b-5088-b34a-f373087a0055' AS a, 'isni' AS n, '0000000108634479' AS v UNION ALL SELECT '990d8d23-031b-5088-b34a-f373087a0055' AS a, 'lccn' AS n, 'n81080024' AS v UNION ALL SELECT '990d8d23-031b-5088-b34a-f373087a0055' AS a, 'musicbrainz_artist' AS n, '90595f34-e23e-4d0c-97cd-7d69b66e0727' AS v UNION ALL SELECT '990d8d23-031b-5088-b34a-f373087a0055' AS a, 'viaf' AS n, '218144783034082019009' AS v UNION ALL SELECT '990d8d23-031b-5088-b34a-f373087a0055' AS a, 'wikidata' AS n, 'Q437262' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '겐나디 로즈데스트벤스키', 'Gennadi Rozhdestvensky', 'conductor', 'A', '1931', 'Russia', '990d8d23-031b-5088-b34a-f373087a0055', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '990d8d23-031b-5088-b34a-f373087a0055');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'da237aa3-a800-563f-991a-36aa7a1c0acd', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'da237aa3-a800-563f-991a-36aa7a1c0acd');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'da237aa3-a800-563f-991a-36aa7a1c0acd', 'en', 'canonical', 'Loris Tjeknavorian', 'loris tjeknavorian', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'da237aa3-a800-563f-991a-36aa7a1c0acd' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'da237aa3-a800-563f-991a-36aa7a1c0acd', 'ko', 'canonical', '로리스 체크나보리안', '로리스 체크나보리안', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'da237aa3-a800-563f-991a-36aa7a1c0acd' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'da237aa3-a800-563f-991a-36aa7a1c0acd' AS a, 'gnd' AS n, '123840147' AS v UNION ALL SELECT 'da237aa3-a800-563f-991a-36aa7a1c0acd' AS a, 'isni' AS n, '000000011879680X' AS v UNION ALL SELECT 'da237aa3-a800-563f-991a-36aa7a1c0acd' AS a, 'lccn' AS n, 'n83134103' AS v UNION ALL SELECT 'da237aa3-a800-563f-991a-36aa7a1c0acd' AS a, 'musicbrainz_artist' AS n, '234555f9-e756-474b-b3a7-bb2eed4177af' AS v UNION ALL SELECT 'da237aa3-a800-563f-991a-36aa7a1c0acd' AS a, 'viaf' AS n, '95123118' AS v UNION ALL SELECT 'da237aa3-a800-563f-991a-36aa7a1c0acd' AS a, 'wikidata' AS n, 'Q2984588' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '로리스 체크나보리안', 'Loris Tjeknavorian', 'conductor', 'A', '1937', 'Armenia', 'da237aa3-a800-563f-991a-36aa7a1c0acd', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'da237aa3-a800-563f-991a-36aa7a1c0acd');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '7994bcc2-22de-5775-a6ce-0228160021f8', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '7994bcc2-22de-5775-a6ce-0228160021f8');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7994bcc2-22de-5775-a6ce-0228160021f8', 'en', 'canonical', 'Armenian Philharmonic Orchestra', 'armenian philharmonic orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7994bcc2-22de-5775-a6ce-0228160021f8' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7994bcc2-22de-5775-a6ce-0228160021f8', 'ko', 'canonical', '아르메니아 필하모닉 오케스트라', '아르메니아 필하모닉 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7994bcc2-22de-5775-a6ce-0228160021f8' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '7994bcc2-22de-5775-a6ce-0228160021f8' AS a, 'gnd' AS n, '1245859-4' AS v UNION ALL SELECT '7994bcc2-22de-5775-a6ce-0228160021f8' AS a, 'isni' AS n, '0000000121699613' AS v UNION ALL SELECT '7994bcc2-22de-5775-a6ce-0228160021f8' AS a, 'lccn' AS n, 'n79023382' AS v UNION ALL SELECT '7994bcc2-22de-5775-a6ce-0228160021f8' AS a, 'musicbrainz_artist' AS n, '49ee9267-e14c-4b3e-99ad-e70f19c1c75d' AS v UNION ALL SELECT '7994bcc2-22de-5775-a6ce-0228160021f8' AS a, 'viaf' AS n, '139774076' AS v UNION ALL SELECT '7994bcc2-22de-5775-a6ce-0228160021f8' AS a, 'wikidata' AS n, 'Q3267972' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '아르메니아 필하모닉 오케스트라', 'Armenian Philharmonic Orchestra', 'orchestra', 'A', '1925', 'Armenia', '7994bcc2-22de-5775-a6ce-0228160021f8', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '7994bcc2-22de-5775-a6ce-0228160021f8');


