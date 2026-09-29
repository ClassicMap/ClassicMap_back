-- A tier A30 에 필요한 인물·단체 일곱 곳을 등록한다.
--
--   자샤 괴첼            (Q112551)   지휘 — piece 383
--   보루산 이스탄불 필하모닉 (Q894268)       — piece 383
--   아나톨 피스툴라리     (Q487710)   지휘 — piece 383
--   리디아 모르드코비치   (Q4302514)  바이올린 — piece 383
--   네메 예르비          (Q356161)   지휘 — piece 383 · 384
--   왕립 스코틀랜드 국립 관현악단 (Q2002502)  — piece 383 · 384
--   스탠리 블랙          (Q3129963)  지휘 — piece 384
--
-- 이미 등록돼 있던 것 — 라둘로비치 724 · 리치 549 · 런던 필하모닉 780 ·
-- 체크나보리안 810 · 아르메니아 필하모닉 811 · 런던 심포니 320.
--
-- 일곱 다 항목이 충실하다(클레임 19~109개). 식별자 마흔한 값 모두 기존 엔티티와
-- 겹치지 않는 것을 확인했다. 보루산 이스탄불 필하모닉은 isni 진술이 없어 다섯 값만 넣었다.
--
-- **네메 예르비(Q356161)는 이미 등록된 파보 예르비(583, Q700791)와 다른 사람이다.**
-- 아버지와 아들이다. 이름으로 고르면 뒤섞인다.
--
-- **스탠리 블랙은 위키데이터에 동명 항목이 넷이다**(공구 회사 Stanley Black & Decker
-- 포함). 1913~2002년 영국 지휘자·작곡가 Q3129963 을 골랐다 — 배급 표기의 런던 심포니
-- 데카 녹음 시기와 맞는다.
--
-- 202608050213 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '7f7a9334-8d8c-5371-a618-75e76472d9bd', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '7f7a9334-8d8c-5371-a618-75e76472d9bd');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7f7a9334-8d8c-5371-a618-75e76472d9bd', 'en', 'canonical', 'Sascha Goetzel', 'sascha goetzel', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7f7a9334-8d8c-5371-a618-75e76472d9bd' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7f7a9334-8d8c-5371-a618-75e76472d9bd', 'ko', 'canonical', '자샤 괴첼', '자샤 괴첼', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7f7a9334-8d8c-5371-a618-75e76472d9bd' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '7f7a9334-8d8c-5371-a618-75e76472d9bd' AS a, 'gnd' AS n, '135193222' AS v UNION ALL SELECT '7f7a9334-8d8c-5371-a618-75e76472d9bd' AS a, 'isni' AS n, '0000000057961153' AS v UNION ALL SELECT '7f7a9334-8d8c-5371-a618-75e76472d9bd' AS a, 'lccn' AS n, 'no2008061083' AS v UNION ALL SELECT '7f7a9334-8d8c-5371-a618-75e76472d9bd' AS a, 'musicbrainz_artist' AS n, '93765f62-0969-4512-9163-1526f6d28d56' AS v UNION ALL SELECT '7f7a9334-8d8c-5371-a618-75e76472d9bd' AS a, 'viaf' AS n, '80022023' AS v UNION ALL SELECT '7f7a9334-8d8c-5371-a618-75e76472d9bd' AS a, 'wikidata' AS n, 'Q112551' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '자샤 괴첼', 'Sascha Goetzel', 'conductor', 'A', '1970', 'Austria', '7f7a9334-8d8c-5371-a618-75e76472d9bd', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '7f7a9334-8d8c-5371-a618-75e76472d9bd');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'd343a249-a841-58a3-8f4d-484060570f8c', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'd343a249-a841-58a3-8f4d-484060570f8c');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd343a249-a841-58a3-8f4d-484060570f8c', 'en', 'canonical', 'Borusan Istanbul Philharmonic Orchestra', 'borusan istanbul philharmonic orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd343a249-a841-58a3-8f4d-484060570f8c' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd343a249-a841-58a3-8f4d-484060570f8c', 'ko', 'canonical', '보루산 이스탄불 필하모닉 오케스트라', '보루산 이스탄불 필하모닉 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd343a249-a841-58a3-8f4d-484060570f8c' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'd343a249-a841-58a3-8f4d-484060570f8c' AS a, 'gnd' AS n, '1044486376' AS v UNION ALL SELECT 'd343a249-a841-58a3-8f4d-484060570f8c' AS a, 'lccn' AS n, 'no2010093937' AS v UNION ALL SELECT 'd343a249-a841-58a3-8f4d-484060570f8c' AS a, 'musicbrainz_artist' AS n, '73d90080-4ac6-45e3-933c-445978777b6c' AS v UNION ALL SELECT 'd343a249-a841-58a3-8f4d-484060570f8c' AS a, 'viaf' AS n, '143483904' AS v UNION ALL SELECT 'd343a249-a841-58a3-8f4d-484060570f8c' AS a, 'wikidata' AS n, 'Q894268' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '보루산 이스탄불 필하모닉 오케스트라', 'Borusan Istanbul Philharmonic Orchestra', 'orchestra', 'A', '1993', 'Turkey', 'd343a249-a841-58a3-8f4d-484060570f8c', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'd343a249-a841-58a3-8f4d-484060570f8c');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f372ba96-f850-5317-92d5-aa3a1245def3', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f372ba96-f850-5317-92d5-aa3a1245def3');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f372ba96-f850-5317-92d5-aa3a1245def3', 'en', 'canonical', 'Royal Scottish National Orchestra', 'royal scottish national orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f372ba96-f850-5317-92d5-aa3a1245def3' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f372ba96-f850-5317-92d5-aa3a1245def3', 'ko', 'canonical', '왕립 스코틀랜드 국립 관현악단', '왕립 스코틀랜드 국립 관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f372ba96-f850-5317-92d5-aa3a1245def3' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'f372ba96-f850-5317-92d5-aa3a1245def3' AS a, 'gnd' AS n, '1213340-1' AS v UNION ALL SELECT 'f372ba96-f850-5317-92d5-aa3a1245def3' AS a, 'isni' AS n, '0000000110341659' AS v UNION ALL SELECT 'f372ba96-f850-5317-92d5-aa3a1245def3' AS a, 'lccn' AS n, 'n99271083' AS v UNION ALL SELECT 'f372ba96-f850-5317-92d5-aa3a1245def3' AS a, 'musicbrainz_artist' AS n, 'c6c4103b-cf07-42ad-91a7-b7eab7586e56' AS v UNION ALL SELECT 'f372ba96-f850-5317-92d5-aa3a1245def3' AS a, 'viaf' AS n, '128337679' AS v UNION ALL SELECT 'f372ba96-f850-5317-92d5-aa3a1245def3' AS a, 'wikidata' AS n, 'Q2002502' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '왕립 스코틀랜드 국립 관현악단', 'Royal Scottish National Orchestra', 'orchestra', 'A', '1891', 'Scotland', 'f372ba96-f850-5317-92d5-aa3a1245def3', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'f372ba96-f850-5317-92d5-aa3a1245def3');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '27cffba8-9c1f-55b6-a3ce-a191aee1a84f', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '27cffba8-9c1f-55b6-a3ce-a191aee1a84f');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '27cffba8-9c1f-55b6-a3ce-a191aee1a84f', 'en', 'canonical', 'Anatole Fistoulari', 'anatole fistoulari', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '27cffba8-9c1f-55b6-a3ce-a191aee1a84f' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '27cffba8-9c1f-55b6-a3ce-a191aee1a84f', 'ko', 'canonical', '아나톨 피스툴라리', '아나톨 피스툴라리', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '27cffba8-9c1f-55b6-a3ce-a191aee1a84f' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '27cffba8-9c1f-55b6-a3ce-a191aee1a84f' AS a, 'gnd' AS n, '133415023' AS v UNION ALL SELECT '27cffba8-9c1f-55b6-a3ce-a191aee1a84f' AS a, 'isni' AS n, '0000000108710224' AS v UNION ALL SELECT '27cffba8-9c1f-55b6-a3ce-a191aee1a84f' AS a, 'lccn' AS n, 'nr90002519' AS v UNION ALL SELECT '27cffba8-9c1f-55b6-a3ce-a191aee1a84f' AS a, 'musicbrainz_artist' AS n, '8967f5da-ab20-4eb8-a00d-1855f9110f58' AS v UNION ALL SELECT '27cffba8-9c1f-55b6-a3ce-a191aee1a84f' AS a, 'viaf' AS n, '12491297' AS v UNION ALL SELECT '27cffba8-9c1f-55b6-a3ce-a191aee1a84f' AS a, 'wikidata' AS n, 'Q487710' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '아나톨 피스툴라리', 'Anatole Fistoulari', 'conductor', 'A', '1907', 'United Kingdom', '27cffba8-9c1f-55b6-a3ce-a191aee1a84f', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '27cffba8-9c1f-55b6-a3ce-a191aee1a84f');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '78d75306-1e27-5b52-a23e-b1aa1cd528d4', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '78d75306-1e27-5b52-a23e-b1aa1cd528d4');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '78d75306-1e27-5b52-a23e-b1aa1cd528d4', 'en', 'canonical', 'Lydia Mordkovitch', 'lydia mordkovitch', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '78d75306-1e27-5b52-a23e-b1aa1cd528d4' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '78d75306-1e27-5b52-a23e-b1aa1cd528d4', 'ko', 'canonical', '리디아 모르드코비치', '리디아 모르드코비치', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '78d75306-1e27-5b52-a23e-b1aa1cd528d4' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '78d75306-1e27-5b52-a23e-b1aa1cd528d4' AS a, 'gnd' AS n, '134705084' AS v UNION ALL SELECT '78d75306-1e27-5b52-a23e-b1aa1cd528d4' AS a, 'isni' AS n, '0000000114686654' AS v UNION ALL SELECT '78d75306-1e27-5b52-a23e-b1aa1cd528d4' AS a, 'lccn' AS n, 'n86145237' AS v UNION ALL SELECT '78d75306-1e27-5b52-a23e-b1aa1cd528d4' AS a, 'musicbrainz_artist' AS n, '03b9caf2-523c-4af2-be47-b6ffc632d75e' AS v UNION ALL SELECT '78d75306-1e27-5b52-a23e-b1aa1cd528d4' AS a, 'viaf' AS n, '19866325' AS v UNION ALL SELECT '78d75306-1e27-5b52-a23e-b1aa1cd528d4' AS a, 'wikidata' AS n, 'Q4302514' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '리디아 모르드코비치', 'Lydia Mordkovitch', 'violinist', 'A', '1944', 'United Kingdom', '78d75306-1e27-5b52-a23e-b1aa1cd528d4', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '78d75306-1e27-5b52-a23e-b1aa1cd528d4');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '81883226-fa1e-5ac5-8723-eedc183b7724', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '81883226-fa1e-5ac5-8723-eedc183b7724');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '81883226-fa1e-5ac5-8723-eedc183b7724', 'en', 'canonical', 'Neeme Järvi', 'neeme järvi', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '81883226-fa1e-5ac5-8723-eedc183b7724' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '81883226-fa1e-5ac5-8723-eedc183b7724', 'ko', 'canonical', '네메 예르비', '네메 예르비', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '81883226-fa1e-5ac5-8723-eedc183b7724' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '81883226-fa1e-5ac5-8723-eedc183b7724' AS a, 'gnd' AS n, '122791681' AS v UNION ALL SELECT '81883226-fa1e-5ac5-8723-eedc183b7724' AS a, 'isni' AS n, '0000000110203918' AS v UNION ALL SELECT '81883226-fa1e-5ac5-8723-eedc183b7724' AS a, 'lccn' AS n, 'n83191552' AS v UNION ALL SELECT '81883226-fa1e-5ac5-8723-eedc183b7724' AS a, 'musicbrainz_artist' AS n, '8a1d9496-603f-40b1-a38d-2e8985834940' AS v UNION ALL SELECT '81883226-fa1e-5ac5-8723-eedc183b7724' AS a, 'viaf' AS n, '5117948' AS v UNION ALL SELECT '81883226-fa1e-5ac5-8723-eedc183b7724' AS a, 'wikidata' AS n, 'Q356161' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '네메 예르비', 'Neeme Järvi', 'conductor', 'A', '1937', 'Estonia', '81883226-fa1e-5ac5-8723-eedc183b7724', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '81883226-fa1e-5ac5-8723-eedc183b7724');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '079bade0-802a-58f7-b009-d34bfbbb5643', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '079bade0-802a-58f7-b009-d34bfbbb5643');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '079bade0-802a-58f7-b009-d34bfbbb5643', 'en', 'canonical', 'Stanley Black', 'stanley black', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '079bade0-802a-58f7-b009-d34bfbbb5643' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '079bade0-802a-58f7-b009-d34bfbbb5643', 'ko', 'canonical', '스탠리 블랙', '스탠리 블랙', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '079bade0-802a-58f7-b009-d34bfbbb5643' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '079bade0-802a-58f7-b009-d34bfbbb5643' AS a, 'gnd' AS n, '134330269' AS v UNION ALL SELECT '079bade0-802a-58f7-b009-d34bfbbb5643' AS a, 'isni' AS n, '0000000121422737' AS v UNION ALL SELECT '079bade0-802a-58f7-b009-d34bfbbb5643' AS a, 'lccn' AS n, 'n82162716' AS v UNION ALL SELECT '079bade0-802a-58f7-b009-d34bfbbb5643' AS a, 'musicbrainz_artist' AS n, 'c1632a1f-2c7c-4da4-a4f6-ba05d9690055' AS v UNION ALL SELECT '079bade0-802a-58f7-b009-d34bfbbb5643' AS a, 'viaf' AS n, '85849843' AS v UNION ALL SELECT '079bade0-802a-58f7-b009-d34bfbbb5643' AS a, 'wikidata' AS n, 'Q3129963' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '스탠리 블랙', 'Stanley Black', 'conductor', 'A', '1913', 'United Kingdom', '079bade0-802a-58f7-b009-d34bfbbb5643', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '079bade0-802a-58f7-b009-d34bfbbb5643');


