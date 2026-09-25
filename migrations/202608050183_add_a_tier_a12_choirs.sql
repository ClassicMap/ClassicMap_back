-- A tier A12 배치에 필요한 합창단 3곳을 추가한다.
--   빈 국립오페라 합창연합 · 베를린 방송합창단 · 로스앤젤레스 마스터 코랄
--
-- 말러 교향곡 8번 "천인 교향곡"(piece 218)에 쓴다. **이 곡은 합창이 주역이다.**
-- 서브에이전트는 세 합창단이 DB 미등록이라 CHOIR 크레딧을 넣지 않았는데, 곡의
-- 성격상 빼면 안 되는 크레딧이라 등록하고 크레딧을 보탠다. A2 의 C.P.E. 바흐
-- 마니피카트에서도 같은 일을 했다.
--
-- 세 녹음 모두 합창단이 둘씩이다(솔티는 빈 국립오페라 합창연합 + 빈 징페라인,
-- 아바도는 베를린 방송합창단 + 프라하 필하모닉 합창단, 두다멜은 LA 마스터 코랄 +
-- 퍼시픽 코랄). **배급 표기에서 앞에 오는 하나씩만 넣는다** —
-- `build_candidates.py` 의 `choir` 키가 하나라서이고, 크레딧을 둘로 늘리려면
-- 스크립트를 고쳐야 한다. 지금 범위 밖이다.
--
-- 빈 국립오페라 합창연합은 wikidata 에 창단 연도가 없어 birth_year 를 NULL 로 둔다.
--
-- 202608050070 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '979589c1-31ad-50f0-a19a-7594959e0c14', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '979589c1-31ad-50f0-a19a-7594959e0c14');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '979589c1-31ad-50f0-a19a-7594959e0c14', 'en', 'canonical', 'Konzertvereinigung Wiener Staatsopernchor', 'konzertvereinigung wiener staatsopernchor', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '979589c1-31ad-50f0-a19a-7594959e0c14' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '979589c1-31ad-50f0-a19a-7594959e0c14', 'ko', 'canonical', '빈 국립오페라 합창연합', '빈 국립오페라 합창연합', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '979589c1-31ad-50f0-a19a-7594959e0c14' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '979589c1-31ad-50f0-a19a-7594959e0c14' AS a, 'gnd' AS n, '1091515-1' AS v UNION ALL SELECT '979589c1-31ad-50f0-a19a-7594959e0c14' AS a, 'isni' AS n, '0000000123216953' AS v UNION ALL SELECT '979589c1-31ad-50f0-a19a-7594959e0c14' AS a, 'musicbrainz_artist' AS n, '07369521-5567-41ce-a7ed-10af57b76518' AS v UNION ALL SELECT '979589c1-31ad-50f0-a19a-7594959e0c14' AS a, 'musicbrainz_artist' AS n, '4821d3c3-6354-4c7b-b294-79e711f3ff4b' AS v UNION ALL SELECT '979589c1-31ad-50f0-a19a-7594959e0c14' AS a, 'musicbrainz_artist' AS n, 'c3e80c59-7389-4703-a5a7-fea4f2220e29' AS v UNION ALL SELECT '979589c1-31ad-50f0-a19a-7594959e0c14' AS a, 'viaf' AS n, '122048636' AS v UNION ALL SELECT '979589c1-31ad-50f0-a19a-7594959e0c14' AS a, 'wikidata' AS n, 'Q15433427' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '빈 국립오페라 합창연합', 'Konzertvereinigung Wiener Staatsopernchor', 'choir', 'A', NULL, 'Austria', '979589c1-31ad-50f0-a19a-7594959e0c14', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '979589c1-31ad-50f0-a19a-7594959e0c14');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '9603a837-5786-52bc-b2ce-f2f5295b7d7d', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '9603a837-5786-52bc-b2ce-f2f5295b7d7d');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9603a837-5786-52bc-b2ce-f2f5295b7d7d', 'en', 'canonical', 'Rundfunkchor Berlin', 'rundfunkchor berlin', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9603a837-5786-52bc-b2ce-f2f5295b7d7d' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9603a837-5786-52bc-b2ce-f2f5295b7d7d', 'ko', 'canonical', '베를린 방송합창단', '베를린 방송합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9603a837-5786-52bc-b2ce-f2f5295b7d7d' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '9603a837-5786-52bc-b2ce-f2f5295b7d7d' AS a, 'gnd' AS n, '5085598-0' AS v UNION ALL SELECT '9603a837-5786-52bc-b2ce-f2f5295b7d7d' AS a, 'isni' AS n, '0000000109433484' AS v UNION ALL SELECT '9603a837-5786-52bc-b2ce-f2f5295b7d7d' AS a, 'musicbrainz_artist' AS n, 'd0cbe60f-f919-4873-8c64-537fd600a4f5' AS v UNION ALL SELECT '9603a837-5786-52bc-b2ce-f2f5295b7d7d' AS a, 'viaf' AS n, '138554286' AS v UNION ALL SELECT '9603a837-5786-52bc-b2ce-f2f5295b7d7d' AS a, 'wikidata' AS n, 'Q880801' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '베를린 방송합창단', 'Rundfunkchor Berlin', 'choir', 'A', '1925', 'Germany', '9603a837-5786-52bc-b2ce-f2f5295b7d7d', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '9603a837-5786-52bc-b2ce-f2f5295b7d7d');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '39e5ae27-54f5-5e48-b397-9e20d730c248', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '39e5ae27-54f5-5e48-b397-9e20d730c248');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '39e5ae27-54f5-5e48-b397-9e20d730c248', 'en', 'canonical', 'Los Angeles Master Chorale', 'los angeles master chorale', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '39e5ae27-54f5-5e48-b397-9e20d730c248' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '39e5ae27-54f5-5e48-b397-9e20d730c248', 'ko', 'canonical', '로스앤젤레스 마스터 코랄', '로스앤젤레스 마스터 코랄', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '39e5ae27-54f5-5e48-b397-9e20d730c248' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '39e5ae27-54f5-5e48-b397-9e20d730c248' AS a, 'gnd' AS n, '809720-3' AS v UNION ALL SELECT '39e5ae27-54f5-5e48-b397-9e20d730c248' AS a, 'isni' AS n, '0000000109453661' AS v UNION ALL SELECT '39e5ae27-54f5-5e48-b397-9e20d730c248' AS a, 'isni' AS n, '0000000470771329' AS v UNION ALL SELECT '39e5ae27-54f5-5e48-b397-9e20d730c248' AS a, 'musicbrainz_artist' AS n, '1f934bfa-c92e-4e94-a664-a1f857928871' AS v UNION ALL SELECT '39e5ae27-54f5-5e48-b397-9e20d730c248' AS a, 'musicbrainz_artist' AS n, '870a85c6-b05e-4ab0-9bf7-f8a52eb03ef9' AS v UNION ALL SELECT '39e5ae27-54f5-5e48-b397-9e20d730c248' AS a, 'viaf' AS n, '151426535' AS v UNION ALL SELECT '39e5ae27-54f5-5e48-b397-9e20d730c248' AS a, 'wikidata' AS n, 'Q3259708' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '로스앤젤레스 마스터 코랄', 'Los Angeles Master Chorale', 'choir', 'A', '1964', 'United States', '39e5ae27-54f5-5e48-b397-9e20d730c248', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '39e5ae27-54f5-5e48-b397-9e20d730c248');

