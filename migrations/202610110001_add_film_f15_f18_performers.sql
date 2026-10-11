-- 영화 속 클래식 15~18차(film-f15~f18) 연주에 필요한 연주자·지휘자·악단·합창단 42개를 등록한다.
--
-- 15차: 줄리니, 월렌스타인 · 심포니 오브 디 에어, 유스투스 프란츠, 앨런 와이스, 바순 셋(투네만 · 이 무지치,
--       라츠 · 슐레플리 · 쿠어팔츠 실내관현악단, 헤르만 · 크르체크)
-- 16차: 로델린다(케르메스 · 커티스 · 일 콤플레소 바로코, 크로 · 비켓 · 잉글리시 콘서트, 새퍼 · 맥기건 · 필하모니아 바로크),
--       리게티 레퀴엠(노트 · 런던 보이시스, 외트뵈시 · WDR 방송 합창단 · SWR 보컬앙상블 · WDR 교향악단, 슈투트가르트 방송 교향악단),
--       RV 684(코언 · 아르칸젤로, 갈루 · 단토네 · 아카데미아 비잔티나, 레스네 · 일 세미나리오 무지칼레)
-- 17차: 로델린다(서머스, 갈란테 · 런던 무지치), 룩스 에테르나(로이스 · 카펠라 암스테르담, 바인베르크),
--       파사칼리아(문태국)
--
-- 등록 확인 세 단계(05-pitfalls.md): 39개는 wikidata·gnd·isni·musicbrainz·viaf·lccn 어디로도 artists·external_identifiers 에
-- 걸리는 것이 없어 엔티티부터 만든다(id 는 식별자 집합의 uuid5, 202610070001 과 같은 규칙).
-- 크르체크(ffec06e9-…)와 노트(585864dc-…)는 국제 시드가 만든 엔티티가 있어 빠진 식별자·이름과 artists 행만 더한다.
--
-- WDR 교향악단은 식별자가 없는 옛 manual 행(artists 341, 'WDR Symphony Orchestra', 1947, Germany)이 이미 있다.
-- Wikidata Q829283(쾰른 WDR 교향악단, 1947 창단, 별칭 WDR Sinfonieorchester)과 이름·창단 연도·나라가 같아
-- 같은 악단으로 보고, 새 artists 행을 만들지 않고 엔티티를 만들어 341 에 명시적으로 잇는다(legacy 행 명시 연결과 같은 성격).
-- 341 이 이미 다른 엔티티에 이어져 있거나 이름이 바뀌었으면 건드리지 않는다.
-- 이름으로 겹치는 다른 artists 행은 없다. 카운터테너·콘트랄토는 분류 코드가 없어 '목소리'(성악가), 바순은 기존 값 '바순' 으로 둔다.
-- 생년을 Wikidata 에서 못 찾은 리사 새퍼는 birth_year 를 비운다.

-- 프란티셰크 헤르만 (František Herman, Q12017059) · 바순

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b70d9146-35a5-5709-8891-0a6d410ceda8', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b70d9146-35a5-5709-8891-0a6d410ceda8');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b70d9146-35a5-5709-8891-0a6d410ceda8', 'en', 'canonical', 'František Herman', 'františek herman', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b70d9146-35a5-5709-8891-0a6d410ceda8' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b70d9146-35a5-5709-8891-0a6d410ceda8', 'ko', 'canonical', '프란티셰크 헤르만', '프란티셰크 헤르만', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b70d9146-35a5-5709-8891-0a6d410ceda8' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b70d9146-35a5-5709-8891-0a6d410ceda8' AS a, 'gnd' AS n, '134785150' AS v UNION ALL SELECT 'b70d9146-35a5-5709-8891-0a6d410ceda8' AS a, 'isni' AS n, '0000000077376197' AS v UNION ALL SELECT 'b70d9146-35a5-5709-8891-0a6d410ceda8' AS a, 'lccn' AS n, 'n79001983' AS v UNION ALL SELECT 'b70d9146-35a5-5709-8891-0a6d410ceda8' AS a, 'musicbrainz_artist' AS n, 'a95fa12b-a7c4-4214-8551-f42b10b0db2b' AS v UNION ALL SELECT 'b70d9146-35a5-5709-8891-0a6d410ceda8' AS a, 'viaf' AS n, '100393115' AS v UNION ALL SELECT 'b70d9146-35a5-5709-8891-0a6d410ceda8' AS a, 'wikidata' AS n, 'Q12017059' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '프란티셰크 헤르만', 'František Herman', '바순', 'B', '1942', 'Czech Republic', 'b70d9146-35a5-5709-8891-0a6d410ceda8', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'b70d9146-35a5-5709-8891-0a6d410ceda8');

-- 야로슬라프 크르체크 (Jaroslav Krček, Q6160622) · conductor

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ffec06e9-8221-5228-b51f-97f66af93f9a', 'en', 'canonical', 'Jaroslav Krček', 'jaroslav krček', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ffec06e9-8221-5228-b51f-97f66af93f9a' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ffec06e9-8221-5228-b51f-97f66af93f9a', 'ko', 'canonical', '야로슬라프 크르체크', '야로슬라프 크르체크', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ffec06e9-8221-5228-b51f-97f66af93f9a' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'ffec06e9-8221-5228-b51f-97f66af93f9a' AS a, 'gnd' AS n, '130025291' AS v UNION ALL SELECT 'ffec06e9-8221-5228-b51f-97f66af93f9a' AS a, 'isni' AS n, '0000000118507684' AS v UNION ALL SELECT 'ffec06e9-8221-5228-b51f-97f66af93f9a' AS a, 'isni' AS n, '0000000118507692' AS v UNION ALL SELECT 'ffec06e9-8221-5228-b51f-97f66af93f9a' AS a, 'lccn' AS n, 'n78059661' AS v UNION ALL SELECT 'ffec06e9-8221-5228-b51f-97f66af93f9a' AS a, 'musicbrainz_artist' AS n, '7f52508a-fef9-4a46-91ac-2076ef35340a' AS v UNION ALL SELECT 'ffec06e9-8221-5228-b51f-97f66af93f9a' AS a, 'viaf' AS n, '100318654' AS v UNION ALL SELECT 'ffec06e9-8221-5228-b51f-97f66af93f9a' AS a, 'viaf' AS n, '6026149296286180670001' AS v UNION ALL SELECT 'ffec06e9-8221-5228-b51f-97f66af93f9a' AS a, 'wikidata' AS n, 'Q6160622' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '야로슬라프 크르체크', 'Jaroslav Krček', 'conductor', 'B', '1939', 'Czech Republic', 'ffec06e9-8221-5228-b51f-97f66af93f9a', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'ffec06e9-8221-5228-b51f-97f66af93f9a');

-- 카를로 마리아 줄리니 (Carlo Maria Giulini, Q430829) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'bf1b7652-4193-5151-b841-53c3f1f88835', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'bf1b7652-4193-5151-b841-53c3f1f88835');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bf1b7652-4193-5151-b841-53c3f1f88835', 'en', 'canonical', 'Carlo Maria Giulini', 'carlo maria giulini', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bf1b7652-4193-5151-b841-53c3f1f88835' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bf1b7652-4193-5151-b841-53c3f1f88835', 'ko', 'canonical', '카를로 마리아 줄리니', '카를로 마리아 줄리니', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bf1b7652-4193-5151-b841-53c3f1f88835' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'bf1b7652-4193-5151-b841-53c3f1f88835' AS a, 'gnd' AS n, '119302209' AS v UNION ALL SELECT 'bf1b7652-4193-5151-b841-53c3f1f88835' AS a, 'isni' AS n, '0000000120958484' AS v UNION ALL SELECT 'bf1b7652-4193-5151-b841-53c3f1f88835' AS a, 'lccn' AS n, 'n81055081' AS v UNION ALL SELECT 'bf1b7652-4193-5151-b841-53c3f1f88835' AS a, 'musicbrainz_artist' AS n, '77d09862-c297-40a6-aea5-251a6fc34604' AS v UNION ALL SELECT 'bf1b7652-4193-5151-b841-53c3f1f88835' AS a, 'viaf' AS n, '29718030' AS v UNION ALL SELECT 'bf1b7652-4193-5151-b841-53c3f1f88835' AS a, 'wikidata' AS n, 'Q430829' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '카를로 마리아 줄리니', 'Carlo Maria Giulini', 'conductor', 'A', '1914', 'Italy', 'bf1b7652-4193-5151-b841-53c3f1f88835', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'bf1b7652-4193-5151-b841-53c3f1f88835');

-- 유스투스 프란츠 (Justus Frantz, Q87878) · pianist

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e203ab35-bf7c-5e5e-86fe-1658bff54419', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'e203ab35-bf7c-5e5e-86fe-1658bff54419');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e203ab35-bf7c-5e5e-86fe-1658bff54419', 'en', 'canonical', 'Justus Frantz', 'justus frantz', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e203ab35-bf7c-5e5e-86fe-1658bff54419' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e203ab35-bf7c-5e5e-86fe-1658bff54419', 'ko', 'canonical', '유스투스 프란츠', '유스투스 프란츠', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e203ab35-bf7c-5e5e-86fe-1658bff54419' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'e203ab35-bf7c-5e5e-86fe-1658bff54419' AS a, 'gnd' AS n, '129369586' AS v UNION ALL SELECT 'e203ab35-bf7c-5e5e-86fe-1658bff54419' AS a, 'isni' AS n, '0000000084111330' AS v UNION ALL SELECT 'e203ab35-bf7c-5e5e-86fe-1658bff54419' AS a, 'lccn' AS n, 'n82144219' AS v UNION ALL SELECT 'e203ab35-bf7c-5e5e-86fe-1658bff54419' AS a, 'musicbrainz_artist' AS n, 'ba3b9866-fe0e-44d5-b98c-a3f47f0636de' AS v UNION ALL SELECT 'e203ab35-bf7c-5e5e-86fe-1658bff54419' AS a, 'viaf' AS n, '113908997' AS v UNION ALL SELECT 'e203ab35-bf7c-5e5e-86fe-1658bff54419' AS a, 'wikidata' AS n, 'Q87878' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '유스투스 프란츠', 'Justus Frantz', 'pianist', 'B', '1944', 'Germany', 'e203ab35-bf7c-5e5e-86fe-1658bff54419', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'e203ab35-bf7c-5e5e-86fe-1658bff54419');

-- 마티아스 라츠 (Matthias Racz, Q1910264) · 바순

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '13ada712-d2e3-5e22-87b9-397aa3ccdf79', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '13ada712-d2e3-5e22-87b9-397aa3ccdf79');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '13ada712-d2e3-5e22-87b9-397aa3ccdf79', 'en', 'canonical', 'Matthias Racz', 'matthias racz', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '13ada712-d2e3-5e22-87b9-397aa3ccdf79' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '13ada712-d2e3-5e22-87b9-397aa3ccdf79', 'ko', 'canonical', '마티아스 라츠', '마티아스 라츠', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '13ada712-d2e3-5e22-87b9-397aa3ccdf79' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '13ada712-d2e3-5e22-87b9-397aa3ccdf79' AS a, 'gnd' AS n, '1028559267' AS v UNION ALL SELECT '13ada712-d2e3-5e22-87b9-397aa3ccdf79' AS a, 'isni' AS n, '0000000078492034' AS v UNION ALL SELECT '13ada712-d2e3-5e22-87b9-397aa3ccdf79' AS a, 'lccn' AS n, 'no2008190225' AS v UNION ALL SELECT '13ada712-d2e3-5e22-87b9-397aa3ccdf79' AS a, 'musicbrainz_artist' AS n, '72b6d479-85b1-49c2-b8e8-2362fb07fe50' AS v UNION ALL SELECT '13ada712-d2e3-5e22-87b9-397aa3ccdf79' AS a, 'viaf' AS n, '264720356' AS v UNION ALL SELECT '13ada712-d2e3-5e22-87b9-397aa3ccdf79' AS a, 'wikidata' AS n, 'Q1910264' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '마티아스 라츠', 'Matthias Racz', '바순', 'B', '1980', 'Germany', '13ada712-d2e3-5e22-87b9-397aa3ccdf79', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '13ada712-d2e3-5e22-87b9-397aa3ccdf79');

-- 요하네스 슐레플리 (Johannes Schlaefli, Q22919356) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '101ffe32-f1c1-56cd-b772-efd9bde9a678', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '101ffe32-f1c1-56cd-b772-efd9bde9a678');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '101ffe32-f1c1-56cd-b772-efd9bde9a678', 'en', 'canonical', 'Johannes Schlaefli', 'johannes schlaefli', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '101ffe32-f1c1-56cd-b772-efd9bde9a678' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '101ffe32-f1c1-56cd-b772-efd9bde9a678', 'ko', 'canonical', '요하네스 슐레플리', '요하네스 슐레플리', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '101ffe32-f1c1-56cd-b772-efd9bde9a678' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '101ffe32-f1c1-56cd-b772-efd9bde9a678' AS a, 'gnd' AS n, '131448846' AS v UNION ALL SELECT '101ffe32-f1c1-56cd-b772-efd9bde9a678' AS a, 'isni' AS n, '000000002050870X' AS v UNION ALL SELECT '101ffe32-f1c1-56cd-b772-efd9bde9a678' AS a, 'lccn' AS n, 'no2014090942' AS v UNION ALL SELECT '101ffe32-f1c1-56cd-b772-efd9bde9a678' AS a, 'musicbrainz_artist' AS n, '89135b62-1eb4-4025-96c2-8c125288db0e' AS v UNION ALL SELECT '101ffe32-f1c1-56cd-b772-efd9bde9a678' AS a, 'viaf' AS n, '15903342' AS v UNION ALL SELECT '101ffe32-f1c1-56cd-b772-efd9bde9a678' AS a, 'wikidata' AS n, 'Q22919356' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '요하네스 슐레플리', 'Johannes Schlaefli', 'conductor', 'B', '1957', 'Switzerland', '101ffe32-f1c1-56cd-b772-efd9bde9a678', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '101ffe32-f1c1-56cd-b772-efd9bde9a678');

-- 쿠어팔츠 실내관현악단 (Kurpfälzisches Kammerorchester, Q1793184) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '6407b869-b746-55c6-a64d-a52c2c4c8fbf', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '6407b869-b746-55c6-a64d-a52c2c4c8fbf');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6407b869-b746-55c6-a64d-a52c2c4c8fbf', 'en', 'canonical', 'Kurpfälzisches Kammerorchester', 'kurpfälzisches kammerorchester', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6407b869-b746-55c6-a64d-a52c2c4c8fbf' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6407b869-b746-55c6-a64d-a52c2c4c8fbf', 'ko', 'canonical', '쿠어팔츠 실내관현악단', '쿠어팔츠 실내관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6407b869-b746-55c6-a64d-a52c2c4c8fbf' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '6407b869-b746-55c6-a64d-a52c2c4c8fbf' AS a, 'gnd' AS n, '5163050-3' AS v UNION ALL SELECT '6407b869-b746-55c6-a64d-a52c2c4c8fbf' AS a, 'lccn' AS n, 'n85133124' AS v UNION ALL SELECT '6407b869-b746-55c6-a64d-a52c2c4c8fbf' AS a, 'musicbrainz_artist' AS n, '8a7558c1-ee68-499e-a585-d425b669bc06' AS v UNION ALL SELECT '6407b869-b746-55c6-a64d-a52c2c4c8fbf' AS a, 'viaf' AS n, '129201414' AS v UNION ALL SELECT '6407b869-b746-55c6-a64d-a52c2c4c8fbf' AS a, 'wikidata' AS n, 'Q1793184' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '쿠어팔츠 실내관현악단', 'Kurpfälzisches Kammerorchester', 'orchestra', 'B', '1952', 'Germany', '6407b869-b746-55c6-a64d-a52c2c4c8fbf', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '6407b869-b746-55c6-a64d-a52c2c4c8fbf');

-- 앨런 와이스 (Alan Weiss, Q2233138) · pianist

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655', 'en', 'canonical', 'Alan Weiss', 'alan weiss', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655', 'ko', 'canonical', '앨런 와이스', '앨런 와이스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655' AS a, 'gnd' AS n, '135193931' AS v UNION ALL SELECT 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655' AS a, 'isni' AS n, '0000000081598753' AS v UNION ALL SELECT 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655' AS a, 'lccn' AS n, 'nr91036415' AS v UNION ALL SELECT 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655' AS a, 'musicbrainz_artist' AS n, 'b3af6739-7913-421c-8e28-1493722c609c' AS v UNION ALL SELECT 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655' AS a, 'viaf' AS n, '80022533' AS v UNION ALL SELECT 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655' AS a, 'wikidata' AS n, 'Q2233138' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '앨런 와이스', 'Alan Weiss', 'pianist', 'B', '1950', 'United States', 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'c3fb0e0f-75bd-5cbc-80bb-25a3761b4655');

-- 클라우스 투네만 (Klaus Thunemann, Q62660) · 바순

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f329a55a-9236-59be-9069-5bd7f1ef0846', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f329a55a-9236-59be-9069-5bd7f1ef0846');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f329a55a-9236-59be-9069-5bd7f1ef0846', 'en', 'canonical', 'Klaus Thunemann', 'klaus thunemann', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f329a55a-9236-59be-9069-5bd7f1ef0846' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f329a55a-9236-59be-9069-5bd7f1ef0846', 'ko', 'canonical', '클라우스 투네만', '클라우스 투네만', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f329a55a-9236-59be-9069-5bd7f1ef0846' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'f329a55a-9236-59be-9069-5bd7f1ef0846' AS a, 'gnd' AS n, '124966594' AS v UNION ALL SELECT 'f329a55a-9236-59be-9069-5bd7f1ef0846' AS a, 'isni' AS n, '0000000063083983' AS v UNION ALL SELECT 'f329a55a-9236-59be-9069-5bd7f1ef0846' AS a, 'lccn' AS n, 'n83129443' AS v UNION ALL SELECT 'f329a55a-9236-59be-9069-5bd7f1ef0846' AS a, 'musicbrainz_artist' AS n, 'a0334525-19cb-4e4e-9581-343372c2324d' AS v UNION ALL SELECT 'f329a55a-9236-59be-9069-5bd7f1ef0846' AS a, 'viaf' AS n, '2658016' AS v UNION ALL SELECT 'f329a55a-9236-59be-9069-5bd7f1ef0846' AS a, 'wikidata' AS n, 'Q62660' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '클라우스 투네만', 'Klaus Thunemann', '바순', 'B', '1937', 'Germany', 'f329a55a-9236-59be-9069-5bd7f1ef0846', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'f329a55a-9236-59be-9069-5bd7f1ef0846');

-- 이 무지치 (I Musici, Q1655249) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '31d3c4da-24b3-5304-bd6a-c71f0740abda', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '31d3c4da-24b3-5304-bd6a-c71f0740abda');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '31d3c4da-24b3-5304-bd6a-c71f0740abda', 'en', 'canonical', 'I Musici', 'i musici', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '31d3c4da-24b3-5304-bd6a-c71f0740abda' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '31d3c4da-24b3-5304-bd6a-c71f0740abda', 'ko', 'canonical', '이 무지치', '이 무지치', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '31d3c4da-24b3-5304-bd6a-c71f0740abda' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '31d3c4da-24b3-5304-bd6a-c71f0740abda' AS a, 'gnd' AS n, '1213189-1' AS v UNION ALL SELECT '31d3c4da-24b3-5304-bd6a-c71f0740abda' AS a, 'isni' AS n, '0000000119565931' AS v UNION ALL SELECT '31d3c4da-24b3-5304-bd6a-c71f0740abda' AS a, 'lccn' AS n, 'n83129444' AS v UNION ALL SELECT '31d3c4da-24b3-5304-bd6a-c71f0740abda' AS a, 'musicbrainz_artist' AS n, '0febca2d-aeed-48fc-9d44-180f6346e4ab' AS v UNION ALL SELECT '31d3c4da-24b3-5304-bd6a-c71f0740abda' AS a, 'viaf' AS n, '136561694' AS v UNION ALL SELECT '31d3c4da-24b3-5304-bd6a-c71f0740abda' AS a, 'wikidata' AS n, 'Q1655249' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '이 무지치', 'I Musici', 'orchestra', 'A', '1952', 'Italy', '31d3c4da-24b3-5304-bd6a-c71f0740abda', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '31d3c4da-24b3-5304-bd6a-c71f0740abda');

-- 앨프리드 월렌스타인 (Alfred Wallenstein, Q1284004) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21', 'en', 'canonical', 'Alfred Wallenstein', 'alfred wallenstein', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21', 'ko', 'canonical', '앨프리드 월렌스타인', '앨프리드 월렌스타인', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21' AS a, 'gnd' AS n, '134549988' AS v UNION ALL SELECT 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21' AS a, 'isni' AS n, '0000000110792409' AS v UNION ALL SELECT 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21' AS a, 'lccn' AS n, 'n85361002' AS v UNION ALL SELECT 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21' AS a, 'musicbrainz_artist' AS n, '3947fe45-7434-4044-bbe4-e462e8929f57' AS v UNION ALL SELECT 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21' AS a, 'viaf' AS n, '100254111' AS v UNION ALL SELECT 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21' AS a, 'wikidata' AS n, 'Q1284004' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '앨프리드 월렌스타인', 'Alfred Wallenstein', 'conductor', 'B', '1898', 'United States', 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'e4ddcc18-eb2b-5ddf-bd17-2b52e4282e21');

-- 심포니 오브 디 에어 (Symphony of the Air, Q3507910) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '0296d567-75ce-5f98-b572-803e18a3bb04', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '0296d567-75ce-5f98-b572-803e18a3bb04');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0296d567-75ce-5f98-b572-803e18a3bb04', 'en', 'canonical', 'Symphony of the Air', 'symphony of the air', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0296d567-75ce-5f98-b572-803e18a3bb04' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0296d567-75ce-5f98-b572-803e18a3bb04', 'ko', 'canonical', '심포니 오브 디 에어', '심포니 오브 디 에어', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0296d567-75ce-5f98-b572-803e18a3bb04' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '0296d567-75ce-5f98-b572-803e18a3bb04' AS a, 'isni' AS n, '000000012114049X' AS v UNION ALL SELECT '0296d567-75ce-5f98-b572-803e18a3bb04' AS a, 'lccn' AS n, 'n84220601' AS v UNION ALL SELECT '0296d567-75ce-5f98-b572-803e18a3bb04' AS a, 'musicbrainz_artist' AS n, 'de0a29df-428e-4b36-9ed4-14afbf53b8f4' AS v UNION ALL SELECT '0296d567-75ce-5f98-b572-803e18a3bb04' AS a, 'viaf' AS n, '158421754' AS v UNION ALL SELECT '0296d567-75ce-5f98-b572-803e18a3bb04' AS a, 'wikidata' AS n, 'Q3507910' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '심포니 오브 디 에어', 'Symphony of the Air', 'orchestra', 'B', '1954', 'United States', '0296d567-75ce-5f98-b572-803e18a3bb04', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '0296d567-75ce-5f98-b572-803e18a3bb04');

-- SWR 보컬앙상블 (SWR Vokalensemble, Q1167446) · choir

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '194876e5-abad-541f-9126-dab3e2915c04', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '194876e5-abad-541f-9126-dab3e2915c04');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '194876e5-abad-541f-9126-dab3e2915c04', 'en', 'canonical', 'SWR Vokalensemble', 'swr vokalensemble', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '194876e5-abad-541f-9126-dab3e2915c04' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '194876e5-abad-541f-9126-dab3e2915c04', 'ko', 'canonical', 'SWR 보컬앙상블', 'swr 보컬앙상블', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '194876e5-abad-541f-9126-dab3e2915c04' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '194876e5-abad-541f-9126-dab3e2915c04' AS a, 'gnd' AS n, '5297663-4' AS v UNION ALL SELECT '194876e5-abad-541f-9126-dab3e2915c04' AS a, 'isni' AS n, '0000000119550457' AS v UNION ALL SELECT '194876e5-abad-541f-9126-dab3e2915c04' AS a, 'lccn' AS n, 'no2001016435' AS v UNION ALL SELECT '194876e5-abad-541f-9126-dab3e2915c04' AS a, 'musicbrainz_artist' AS n, '22479ae8-67fc-478c-8192-8cac360061fa' AS v UNION ALL SELECT '194876e5-abad-541f-9126-dab3e2915c04' AS a, 'viaf' AS n, '125171077' AS v UNION ALL SELECT '194876e5-abad-541f-9126-dab3e2915c04' AS a, 'wikidata' AS n, 'Q1167446' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT 'SWR 보컬앙상블', 'SWR Vokalensemble', 'choir', 'B', '1946', 'Germany', '194876e5-abad-541f-9126-dab3e2915c04', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '194876e5-abad-541f-9126-dab3e2915c04');

-- 슈투트가르트 방송 교향악단 (Stuttgart Radio Symphony Orchestra, Q262477) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '0fe06d48-f9c8-569e-880f-eba25077f190', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '0fe06d48-f9c8-569e-880f-eba25077f190');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0fe06d48-f9c8-569e-880f-eba25077f190', 'en', 'canonical', 'Stuttgart Radio Symphony Orchestra', 'stuttgart radio symphony orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0fe06d48-f9c8-569e-880f-eba25077f190' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0fe06d48-f9c8-569e-880f-eba25077f190', 'ko', 'canonical', '슈투트가르트 방송 교향악단', '슈투트가르트 방송 교향악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0fe06d48-f9c8-569e-880f-eba25077f190' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '0fe06d48-f9c8-569e-880f-eba25077f190' AS a, 'gnd' AS n, '803757-7' AS v UNION ALL SELECT '0fe06d48-f9c8-569e-880f-eba25077f190' AS a, 'isni' AS n, '0000000114637852' AS v UNION ALL SELECT '0fe06d48-f9c8-569e-880f-eba25077f190' AS a, 'lccn' AS n, 'n81144340' AS v UNION ALL SELECT '0fe06d48-f9c8-569e-880f-eba25077f190' AS a, 'lccn' AS n, 'no00048016' AS v UNION ALL SELECT '0fe06d48-f9c8-569e-880f-eba25077f190' AS a, 'musicbrainz_artist' AS n, '09caaa4a-868f-4434-bcc3-4921ac8539df' AS v UNION ALL SELECT '0fe06d48-f9c8-569e-880f-eba25077f190' AS a, 'viaf' AS n, '151208087' AS v UNION ALL SELECT '0fe06d48-f9c8-569e-880f-eba25077f190' AS a, 'viaf' AS n, '58145911102027060173' AS v UNION ALL SELECT '0fe06d48-f9c8-569e-880f-eba25077f190' AS a, 'wikidata' AS n, 'Q262477' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '슈투트가르트 방송 교향악단', 'Stuttgart Radio Symphony Orchestra', 'orchestra', 'B', '1945', 'Germany', '0fe06d48-f9c8-569e-880f-eba25077f190', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '0fe06d48-f9c8-569e-880f-eba25077f190');

-- 조너선 코언 (Jonathan Cohen, Q15431044) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '42c43d41-634a-527e-8cdc-dc1c5e894b6a', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '42c43d41-634a-527e-8cdc-dc1c5e894b6a');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '42c43d41-634a-527e-8cdc-dc1c5e894b6a', 'en', 'canonical', 'Jonathan Cohen', 'jonathan cohen', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '42c43d41-634a-527e-8cdc-dc1c5e894b6a' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '42c43d41-634a-527e-8cdc-dc1c5e894b6a', 'ko', 'canonical', '조너선 코언', '조너선 코언', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '42c43d41-634a-527e-8cdc-dc1c5e894b6a' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '42c43d41-634a-527e-8cdc-dc1c5e894b6a' AS a, 'gnd' AS n, '141521589' AS v UNION ALL SELECT '42c43d41-634a-527e-8cdc-dc1c5e894b6a' AS a, 'isni' AS n, '000000011490974X' AS v UNION ALL SELECT '42c43d41-634a-527e-8cdc-dc1c5e894b6a' AS a, 'lccn' AS n, 'n2007090966' AS v UNION ALL SELECT '42c43d41-634a-527e-8cdc-dc1c5e894b6a' AS a, 'musicbrainz_artist' AS n, 'fd317d6a-dd6b-4aca-befc-07e70e939f34' AS v UNION ALL SELECT '42c43d41-634a-527e-8cdc-dc1c5e894b6a' AS a, 'viaf' AS n, '43759877' AS v UNION ALL SELECT '42c43d41-634a-527e-8cdc-dc1c5e894b6a' AS a, 'wikidata' AS n, 'Q15431044' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '조너선 코언', 'Jonathan Cohen', 'conductor', 'B', '1977', 'United Kingdom', '42c43d41-634a-527e-8cdc-dc1c5e894b6a', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '42c43d41-634a-527e-8cdc-dc1c5e894b6a');

-- 아르칸젤로 (Arcangelo, Q28119855) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '52ed4817-d79c-5c5a-98e0-adbcfb89f475', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '52ed4817-d79c-5c5a-98e0-adbcfb89f475');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '52ed4817-d79c-5c5a-98e0-adbcfb89f475', 'en', 'canonical', 'Arcangelo', 'arcangelo', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '52ed4817-d79c-5c5a-98e0-adbcfb89f475' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '52ed4817-d79c-5c5a-98e0-adbcfb89f475', 'ko', 'canonical', '아르칸젤로', '아르칸젤로', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '52ed4817-d79c-5c5a-98e0-adbcfb89f475' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '52ed4817-d79c-5c5a-98e0-adbcfb89f475' AS a, 'gnd' AS n, '1024267849' AS v UNION ALL SELECT '52ed4817-d79c-5c5a-98e0-adbcfb89f475' AS a, 'isni' AS n, '0000000469790602' AS v UNION ALL SELECT '52ed4817-d79c-5c5a-98e0-adbcfb89f475' AS a, 'lccn' AS n, 'no2011172107' AS v UNION ALL SELECT '52ed4817-d79c-5c5a-98e0-adbcfb89f475' AS a, 'musicbrainz_artist' AS n, '93f71f5a-9fad-48de-bd4a-25ffd625b3d6' AS v UNION ALL SELECT '52ed4817-d79c-5c5a-98e0-adbcfb89f475' AS a, 'viaf' AS n, '211758927' AS v UNION ALL SELECT '52ed4817-d79c-5c5a-98e0-adbcfb89f475' AS a, 'wikidata' AS n, 'Q28119855' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '아르칸젤로', 'Arcangelo', 'orchestra', 'B', '2010', 'United Kingdom', '52ed4817-d79c-5c5a-98e0-adbcfb89f475', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '52ed4817-d79c-5c5a-98e0-adbcfb89f475');

-- 리사 새퍼 (Lisa Saffer, Q52617558) · soprano

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '0b851d96-92e1-5625-a84b-9d82479ae5d6', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '0b851d96-92e1-5625-a84b-9d82479ae5d6');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0b851d96-92e1-5625-a84b-9d82479ae5d6', 'en', 'canonical', 'Lisa Saffer', 'lisa saffer', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0b851d96-92e1-5625-a84b-9d82479ae5d6' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0b851d96-92e1-5625-a84b-9d82479ae5d6', 'ko', 'canonical', '리사 새퍼', '리사 새퍼', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0b851d96-92e1-5625-a84b-9d82479ae5d6' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '0b851d96-92e1-5625-a84b-9d82479ae5d6' AS a, 'gnd' AS n, '134833082' AS v UNION ALL SELECT '0b851d96-92e1-5625-a84b-9d82479ae5d6' AS a, 'isni' AS n, '0000000055189948' AS v UNION ALL SELECT '0b851d96-92e1-5625-a84b-9d82479ae5d6' AS a, 'lccn' AS n, 'nr91044009' AS v UNION ALL SELECT '0b851d96-92e1-5625-a84b-9d82479ae5d6' AS a, 'musicbrainz_artist' AS n, '2945b404-a441-42ac-8c5d-85de9a0a9036' AS v UNION ALL SELECT '0b851d96-92e1-5625-a84b-9d82479ae5d6' AS a, 'viaf' AS n, '161366615' AS v UNION ALL SELECT '0b851d96-92e1-5625-a84b-9d82479ae5d6' AS a, 'wikidata' AS n, 'Q52617558' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '리사 새퍼', 'Lisa Saffer', 'soprano', 'B', NULL, 'United States', '0b851d96-92e1-5625-a84b-9d82479ae5d6', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '0b851d96-92e1-5625-a84b-9d82479ae5d6');

-- 니컬러스 맥기건 (Nicholas McGegan, Q3136187) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '2fcdfa41-c4e7-516d-93c0-f16346ca745d', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '2fcdfa41-c4e7-516d-93c0-f16346ca745d');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2fcdfa41-c4e7-516d-93c0-f16346ca745d', 'en', 'canonical', 'Nicholas McGegan', 'nicholas mcgegan', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2fcdfa41-c4e7-516d-93c0-f16346ca745d' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2fcdfa41-c4e7-516d-93c0-f16346ca745d', 'ko', 'canonical', '니컬러스 맥기건', '니컬러스 맥기건', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2fcdfa41-c4e7-516d-93c0-f16346ca745d' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '2fcdfa41-c4e7-516d-93c0-f16346ca745d' AS a, 'gnd' AS n, '124259480' AS v UNION ALL SELECT '2fcdfa41-c4e7-516d-93c0-f16346ca745d' AS a, 'isni' AS n, '0000000109374736' AS v UNION ALL SELECT '2fcdfa41-c4e7-516d-93c0-f16346ca745d' AS a, 'lccn' AS n, 'n82003129' AS v UNION ALL SELECT '2fcdfa41-c4e7-516d-93c0-f16346ca745d' AS a, 'musicbrainz_artist' AS n, 'a642d4b5-31c5-4422-a92c-d8224d7b958c' AS v UNION ALL SELECT '2fcdfa41-c4e7-516d-93c0-f16346ca745d' AS a, 'viaf' AS n, '10145857765423020076' AS v UNION ALL SELECT '2fcdfa41-c4e7-516d-93c0-f16346ca745d' AS a, 'wikidata' AS n, 'Q3136187' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '니컬러스 맥기건', 'Nicholas McGegan', 'conductor', 'B', '1950', 'United Kingdom', '2fcdfa41-c4e7-516d-93c0-f16346ca745d', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '2fcdfa41-c4e7-516d-93c0-f16346ca745d');

-- 필하모니아 바로크 오케스트라 (Philharmonia Baroque Orchestra, Q7183039) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'bdff2612-51c6-5baf-8635-f7b545f86709', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'bdff2612-51c6-5baf-8635-f7b545f86709');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bdff2612-51c6-5baf-8635-f7b545f86709', 'en', 'canonical', 'Philharmonia Baroque Orchestra', 'philharmonia baroque orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bdff2612-51c6-5baf-8635-f7b545f86709' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bdff2612-51c6-5baf-8635-f7b545f86709', 'ko', 'canonical', '필하모니아 바로크 오케스트라', '필하모니아 바로크 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bdff2612-51c6-5baf-8635-f7b545f86709' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'bdff2612-51c6-5baf-8635-f7b545f86709' AS a, 'gnd' AS n, '5047797-3' AS v UNION ALL SELECT 'bdff2612-51c6-5baf-8635-f7b545f86709' AS a, 'isni' AS n, '0000000119399128' AS v UNION ALL SELECT 'bdff2612-51c6-5baf-8635-f7b545f86709' AS a, 'lccn' AS n, 'n87802113' AS v UNION ALL SELECT 'bdff2612-51c6-5baf-8635-f7b545f86709' AS a, 'musicbrainz_artist' AS n, 'b983871c-4d6e-45fe-bf6a-0a8211374c6c' AS v UNION ALL SELECT 'bdff2612-51c6-5baf-8635-f7b545f86709' AS a, 'viaf' AS n, '131442186' AS v UNION ALL SELECT 'bdff2612-51c6-5baf-8635-f7b545f86709' AS a, 'wikidata' AS n, 'Q7183039' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '필하모니아 바로크 오케스트라', 'Philharmonia Baroque Orchestra', 'orchestra', 'B', '1981', 'United States', 'bdff2612-51c6-5baf-8635-f7b545f86709', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'bdff2612-51c6-5baf-8635-f7b545f86709');

-- 제라르 레스네 (Gérard Lesne, Q176713) · 목소리

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'cbfce428-e5a4-573f-86c3-b9ffa3847c37', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'cbfce428-e5a4-573f-86c3-b9ffa3847c37');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cbfce428-e5a4-573f-86c3-b9ffa3847c37', 'en', 'canonical', 'Gérard Lesne', 'gérard lesne', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cbfce428-e5a4-573f-86c3-b9ffa3847c37' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cbfce428-e5a4-573f-86c3-b9ffa3847c37', 'ko', 'canonical', '제라르 레스네', '제라르 레스네', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cbfce428-e5a4-573f-86c3-b9ffa3847c37' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'cbfce428-e5a4-573f-86c3-b9ffa3847c37' AS a, 'gnd' AS n, '123939704' AS v UNION ALL SELECT 'cbfce428-e5a4-573f-86c3-b9ffa3847c37' AS a, 'isni' AS n, '0000000121483943' AS v UNION ALL SELECT 'cbfce428-e5a4-573f-86c3-b9ffa3847c37' AS a, 'lccn' AS n, 'n87825653' AS v UNION ALL SELECT 'cbfce428-e5a4-573f-86c3-b9ffa3847c37' AS a, 'musicbrainz_artist' AS n, '617e7d3b-930d-48c3-9e01-6386179b621d' AS v UNION ALL SELECT 'cbfce428-e5a4-573f-86c3-b9ffa3847c37' AS a, 'viaf' AS n, '114856882' AS v UNION ALL SELECT 'cbfce428-e5a4-573f-86c3-b9ffa3847c37' AS a, 'wikidata' AS n, 'Q176713' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '제라르 레스네', 'Gérard Lesne', '목소리', 'B', '1956', 'France', 'cbfce428-e5a4-573f-86c3-b9ffa3847c37', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'cbfce428-e5a4-573f-86c3-b9ffa3847c37');

-- 일 세미나리오 무지칼레 (Il Seminario Musicale, Q3148472) · ensemble

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '6d5f65b5-377e-5681-98da-ac99e5ead481', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '6d5f65b5-377e-5681-98da-ac99e5ead481');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6d5f65b5-377e-5681-98da-ac99e5ead481', 'en', 'canonical', 'Il Seminario Musicale', 'il seminario musicale', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6d5f65b5-377e-5681-98da-ac99e5ead481' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6d5f65b5-377e-5681-98da-ac99e5ead481', 'ko', 'canonical', '일 세미나리오 무지칼레', '일 세미나리오 무지칼레', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6d5f65b5-377e-5681-98da-ac99e5ead481' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '6d5f65b5-377e-5681-98da-ac99e5ead481' AS a, 'gnd' AS n, '5167575-4' AS v UNION ALL SELECT '6d5f65b5-377e-5681-98da-ac99e5ead481' AS a, 'isni' AS n, '0000000122427302' AS v UNION ALL SELECT '6d5f65b5-377e-5681-98da-ac99e5ead481' AS a, 'lccn' AS n, 'n87132015' AS v UNION ALL SELECT '6d5f65b5-377e-5681-98da-ac99e5ead481' AS a, 'musicbrainz_artist' AS n, '764d285e-a7a7-43f0-a7fb-fb0a32157320' AS v UNION ALL SELECT '6d5f65b5-377e-5681-98da-ac99e5ead481' AS a, 'viaf' AS n, '124488277' AS v UNION ALL SELECT '6d5f65b5-377e-5681-98da-ac99e5ead481' AS a, 'wikidata' AS n, 'Q3148472' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '일 세미나리오 무지칼레', 'Il Seminario Musicale', 'ensemble', 'B', '1985', 'France', '6d5f65b5-377e-5681-98da-ac99e5ead481', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '6d5f65b5-377e-5681-98da-ac99e5ead481');

-- 조너선 노트 (Jonathan Nott, Q657928) · conductor

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '585864dc-cf5c-5ada-a3a6-5e15d8791220', 'en', 'canonical', 'Jonathan Nott', 'jonathan nott', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '585864dc-cf5c-5ada-a3a6-5e15d8791220' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '585864dc-cf5c-5ada-a3a6-5e15d8791220', 'ko', 'canonical', '조너선 노트', '조너선 노트', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '585864dc-cf5c-5ada-a3a6-5e15d8791220' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '585864dc-cf5c-5ada-a3a6-5e15d8791220' AS a, 'gnd' AS n, '134820045' AS v UNION ALL SELECT '585864dc-cf5c-5ada-a3a6-5e15d8791220' AS a, 'isni' AS n, '0000000078391786' AS v UNION ALL SELECT '585864dc-cf5c-5ada-a3a6-5e15d8791220' AS a, 'lccn' AS n, 'nr96027120' AS v UNION ALL SELECT '585864dc-cf5c-5ada-a3a6-5e15d8791220' AS a, 'musicbrainz_artist' AS n, 'bc177ef8-db80-4209-85e0-4bfa8681dbd4' AS v UNION ALL SELECT '585864dc-cf5c-5ada-a3a6-5e15d8791220' AS a, 'viaf' AS n, '27262241' AS v UNION ALL SELECT '585864dc-cf5c-5ada-a3a6-5e15d8791220' AS a, 'wikidata' AS n, 'Q657928' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '조너선 노트', 'Jonathan Nott', 'conductor', 'A', '1962', 'United Kingdom', '585864dc-cf5c-5ada-a3a6-5e15d8791220', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '585864dc-cf5c-5ada-a3a6-5e15d8791220');

-- 런던 보이시스 (London Voices, Q9023617) · choir

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '03aed333-9c82-59ce-8cb0-bd06221da410', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '03aed333-9c82-59ce-8cb0-bd06221da410');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '03aed333-9c82-59ce-8cb0-bd06221da410', 'en', 'canonical', 'London Voices', 'london voices', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '03aed333-9c82-59ce-8cb0-bd06221da410' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '03aed333-9c82-59ce-8cb0-bd06221da410', 'ko', 'canonical', '런던 보이시스', '런던 보이시스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '03aed333-9c82-59ce-8cb0-bd06221da410' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '03aed333-9c82-59ce-8cb0-bd06221da410' AS a, 'gnd' AS n, '1091521-7' AS v UNION ALL SELECT '03aed333-9c82-59ce-8cb0-bd06221da410' AS a, 'isni' AS n, '0000000110096921' AS v UNION ALL SELECT '03aed333-9c82-59ce-8cb0-bd06221da410' AS a, 'lccn' AS n, 'n81008088' AS v UNION ALL SELECT '03aed333-9c82-59ce-8cb0-bd06221da410' AS a, 'musicbrainz_artist' AS n, '36c14a29-956e-4ea0-b5e6-5593ef044881' AS v UNION ALL SELECT '03aed333-9c82-59ce-8cb0-bd06221da410' AS a, 'viaf' AS n, '121660784' AS v UNION ALL SELECT '03aed333-9c82-59ce-8cb0-bd06221da410' AS a, 'viaf' AS n, '123288893' AS v UNION ALL SELECT '03aed333-9c82-59ce-8cb0-bd06221da410' AS a, 'wikidata' AS n, 'Q9023617' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '런던 보이시스', 'London Voices', 'choir', 'B', '1973', 'United Kingdom', '03aed333-9c82-59ce-8cb0-bd06221da410', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '03aed333-9c82-59ce-8cb0-bd06221da410');

-- 델핀 갈루 (Delphine Galou, Q5254425) · 목소리

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8', 'en', 'canonical', 'Delphine Galou', 'delphine galou', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8', 'ko', 'canonical', '델핀 갈루', '델핀 갈루', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8' AS a, 'gnd' AS n, '1051986982' AS v UNION ALL SELECT '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8' AS a, 'isni' AS n, '0000000003505515' AS v UNION ALL SELECT '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8' AS a, 'lccn' AS n, 'no2007085515' AS v UNION ALL SELECT '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8' AS a, 'musicbrainz_artist' AS n, 'c8998900-7f99-420e-a652-5a04ab30f023' AS v UNION ALL SELECT '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8' AS a, 'viaf' AS n, '44509442' AS v UNION ALL SELECT '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8' AS a, 'wikidata' AS n, 'Q5254425' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '델핀 갈루', 'Delphine Galou', '목소리', 'B', '1977', 'France', '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '8f1f5714-7f5b-53bf-9585-0a4f4633d5a8');

-- 오타비오 단토네 (Ottavio Dantone, Q963831) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '40d17fdb-9fbb-5808-b88b-499f83de9cdf', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '40d17fdb-9fbb-5808-b88b-499f83de9cdf');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '40d17fdb-9fbb-5808-b88b-499f83de9cdf', 'en', 'canonical', 'Ottavio Dantone', 'ottavio dantone', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '40d17fdb-9fbb-5808-b88b-499f83de9cdf' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '40d17fdb-9fbb-5808-b88b-499f83de9cdf', 'ko', 'canonical', '오타비오 단토네', '오타비오 단토네', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '40d17fdb-9fbb-5808-b88b-499f83de9cdf' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '40d17fdb-9fbb-5808-b88b-499f83de9cdf' AS a, 'gnd' AS n, '135045878' AS v UNION ALL SELECT '40d17fdb-9fbb-5808-b88b-499f83de9cdf' AS a, 'isni' AS n, '0000000055191757' AS v UNION ALL SELECT '40d17fdb-9fbb-5808-b88b-499f83de9cdf' AS a, 'lccn' AS n, 'nr98006822' AS v UNION ALL SELECT '40d17fdb-9fbb-5808-b88b-499f83de9cdf' AS a, 'musicbrainz_artist' AS n, 'c4787634-90ec-4cef-b2cc-aa7536625570' AS v UNION ALL SELECT '40d17fdb-9fbb-5808-b88b-499f83de9cdf' AS a, 'viaf' AS n, '66674944' AS v UNION ALL SELECT '40d17fdb-9fbb-5808-b88b-499f83de9cdf' AS a, 'wikidata' AS n, 'Q963831' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '오타비오 단토네', 'Ottavio Dantone', 'conductor', 'B', '1960', 'Italy', '40d17fdb-9fbb-5808-b88b-499f83de9cdf', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '40d17fdb-9fbb-5808-b88b-499f83de9cdf');

-- 아카데미아 비잔티나 (Accademia Bizantina, Q3603929) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '10412343-251e-548b-82f5-ace144787346', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '10412343-251e-548b-82f5-ace144787346');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '10412343-251e-548b-82f5-ace144787346', 'en', 'canonical', 'Accademia Bizantina', 'accademia bizantina', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '10412343-251e-548b-82f5-ace144787346' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '10412343-251e-548b-82f5-ace144787346', 'ko', 'canonical', '아카데미아 비잔티나', '아카데미아 비잔티나', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '10412343-251e-548b-82f5-ace144787346' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '10412343-251e-548b-82f5-ace144787346' AS a, 'gnd' AS n, '5197098-3' AS v UNION ALL SELECT '10412343-251e-548b-82f5-ace144787346' AS a, 'isni' AS n, '0000000110888611' AS v UNION ALL SELECT '10412343-251e-548b-82f5-ace144787346' AS a, 'lccn' AS n, 'n96046173' AS v UNION ALL SELECT '10412343-251e-548b-82f5-ace144787346' AS a, 'musicbrainz_artist' AS n, '2c422cb3-2c82-483d-8815-d38b388d1ee5' AS v UNION ALL SELECT '10412343-251e-548b-82f5-ace144787346' AS a, 'viaf' AS n, '130683639' AS v UNION ALL SELECT '10412343-251e-548b-82f5-ace144787346' AS a, 'wikidata' AS n, 'Q3603929' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '아카데미아 비잔티나', 'Accademia Bizantina', 'orchestra', 'B', '1983', 'Italy', '10412343-251e-548b-82f5-ace144787346', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '10412343-251e-548b-82f5-ace144787346');

-- 페테르 외트뵈시 (Péter Eötvös, Q389851) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '5591d335-525a-5e93-93ac-f3dc18c09411', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '5591d335-525a-5e93-93ac-f3dc18c09411');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5591d335-525a-5e93-93ac-f3dc18c09411', 'en', 'canonical', 'Péter Eötvös', 'péter eötvös', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5591d335-525a-5e93-93ac-f3dc18c09411' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5591d335-525a-5e93-93ac-f3dc18c09411', 'ko', 'canonical', '페테르 외트뵈시', '페테르 외트뵈시', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5591d335-525a-5e93-93ac-f3dc18c09411' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '5591d335-525a-5e93-93ac-f3dc18c09411' AS a, 'gnd' AS n, '123561949' AS v UNION ALL SELECT '5591d335-525a-5e93-93ac-f3dc18c09411' AS a, 'isni' AS n, '0000000110591965' AS v UNION ALL SELECT '5591d335-525a-5e93-93ac-f3dc18c09411' AS a, 'lccn' AS n, 'n84181304' AS v UNION ALL SELECT '5591d335-525a-5e93-93ac-f3dc18c09411' AS a, 'musicbrainz_artist' AS n, 'bc807a53-e825-4452-960e-3c87e3bc95f7' AS v UNION ALL SELECT '5591d335-525a-5e93-93ac-f3dc18c09411' AS a, 'viaf' AS n, '42025155' AS v UNION ALL SELECT '5591d335-525a-5e93-93ac-f3dc18c09411' AS a, 'wikidata' AS n, 'Q389851' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '페테르 외트뵈시', 'Péter Eötvös', 'conductor', 'A', '1944', 'Hungary', '5591d335-525a-5e93-93ac-f3dc18c09411', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '5591d335-525a-5e93-93ac-f3dc18c09411');

-- WDR 방송 합창단 (WDR Rundfunkchor, Q2537040) · choir

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'bb3939cc-5d5f-5189-af7f-2324839c4e2f', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'bb3939cc-5d5f-5189-af7f-2324839c4e2f');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bb3939cc-5d5f-5189-af7f-2324839c4e2f', 'en', 'canonical', 'WDR Rundfunkchor', 'wdr rundfunkchor', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bb3939cc-5d5f-5189-af7f-2324839c4e2f' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bb3939cc-5d5f-5189-af7f-2324839c4e2f', 'ko', 'canonical', 'WDR 방송 합창단', 'wdr 방송 합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bb3939cc-5d5f-5189-af7f-2324839c4e2f' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'bb3939cc-5d5f-5189-af7f-2324839c4e2f' AS a, 'gnd' AS n, '10322855-X' AS v UNION ALL SELECT 'bb3939cc-5d5f-5189-af7f-2324839c4e2f' AS a, 'isni' AS n, '0000000107209913' AS v UNION ALL SELECT 'bb3939cc-5d5f-5189-af7f-2324839c4e2f' AS a, 'lccn' AS n, 'n82073049' AS v UNION ALL SELECT 'bb3939cc-5d5f-5189-af7f-2324839c4e2f' AS a, 'lccn' AS n, 'no2002064180' AS v UNION ALL SELECT 'bb3939cc-5d5f-5189-af7f-2324839c4e2f' AS a, 'musicbrainz_artist' AS n, '60583943-e7dc-4d41-bc79-45a80420865d' AS v UNION ALL SELECT 'bb3939cc-5d5f-5189-af7f-2324839c4e2f' AS a, 'viaf' AS n, '125510717' AS v UNION ALL SELECT 'bb3939cc-5d5f-5189-af7f-2324839c4e2f' AS a, 'viaf' AS n, '153744931' AS v UNION ALL SELECT 'bb3939cc-5d5f-5189-af7f-2324839c4e2f' AS a, 'wikidata' AS n, 'Q2537040' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT 'WDR 방송 합창단', 'WDR Rundfunkchor', 'choir', 'B', '1947', 'Germany', 'bb3939cc-5d5f-5189-af7f-2324839c4e2f', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'bb3939cc-5d5f-5189-af7f-2324839c4e2f');

-- 시모네 케르메스 (Simone Kermes, Q454282) · soprano

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '25598f0a-d934-5574-9fd1-9720ace787da', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '25598f0a-d934-5574-9fd1-9720ace787da');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '25598f0a-d934-5574-9fd1-9720ace787da', 'en', 'canonical', 'Simone Kermes', 'simone kermes', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '25598f0a-d934-5574-9fd1-9720ace787da' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '25598f0a-d934-5574-9fd1-9720ace787da', 'ko', 'canonical', '시모네 케르메스', '시모네 케르메스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '25598f0a-d934-5574-9fd1-9720ace787da' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '25598f0a-d934-5574-9fd1-9720ace787da' AS a, 'gnd' AS n, '12877245X' AS v UNION ALL SELECT '25598f0a-d934-5574-9fd1-9720ace787da' AS a, 'isni' AS n, '0000000041276039' AS v UNION ALL SELECT '25598f0a-d934-5574-9fd1-9720ace787da' AS a, 'lccn' AS n, 'no99023873' AS v UNION ALL SELECT '25598f0a-d934-5574-9fd1-9720ace787da' AS a, 'musicbrainz_artist' AS n, '1e48e74f-7162-4232-80e0-fe8998fd9dfc' AS v UNION ALL SELECT '25598f0a-d934-5574-9fd1-9720ace787da' AS a, 'viaf' AS n, '46966586' AS v UNION ALL SELECT '25598f0a-d934-5574-9fd1-9720ace787da' AS a, 'wikidata' AS n, 'Q454282' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '시모네 케르메스', 'Simone Kermes', 'soprano', 'B', '1965', 'Germany', '25598f0a-d934-5574-9fd1-9720ace787da', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '25598f0a-d934-5574-9fd1-9720ace787da');

-- 앨런 커티스 (Alan Curtis, Q965256) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '792bd257-d239-5176-be25-e8237ae0d1f3', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '792bd257-d239-5176-be25-e8237ae0d1f3');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '792bd257-d239-5176-be25-e8237ae0d1f3', 'en', 'canonical', 'Alan Curtis', 'alan curtis', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '792bd257-d239-5176-be25-e8237ae0d1f3' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '792bd257-d239-5176-be25-e8237ae0d1f3', 'ko', 'canonical', '앨런 커티스', '앨런 커티스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '792bd257-d239-5176-be25-e8237ae0d1f3' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '792bd257-d239-5176-be25-e8237ae0d1f3' AS a, 'gnd' AS n, '124456421' AS v UNION ALL SELECT '792bd257-d239-5176-be25-e8237ae0d1f3' AS a, 'isni' AS n, '0000000109379457' AS v UNION ALL SELECT '792bd257-d239-5176-be25-e8237ae0d1f3' AS a, 'lccn' AS n, 'n83047125' AS v UNION ALL SELECT '792bd257-d239-5176-be25-e8237ae0d1f3' AS a, 'musicbrainz_artist' AS n, '39aeb16b-5f01-4349-82ff-4f3f747403c9' AS v UNION ALL SELECT '792bd257-d239-5176-be25-e8237ae0d1f3' AS a, 'viaf' AS n, '114896592' AS v UNION ALL SELECT '792bd257-d239-5176-be25-e8237ae0d1f3' AS a, 'wikidata' AS n, 'Q965256' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '앨런 커티스', 'Alan Curtis', 'conductor', 'B', '1934', 'United States', '792bd257-d239-5176-be25-e8237ae0d1f3', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '792bd257-d239-5176-be25-e8237ae0d1f3');

-- 일 콤플레소 바로코 (Il Complesso Barocco, Q16215310) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '3971319f-1363-5973-af23-54d78069e03a', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '3971319f-1363-5973-af23-54d78069e03a');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3971319f-1363-5973-af23-54d78069e03a', 'en', 'canonical', 'Il Complesso Barocco', 'il complesso barocco', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3971319f-1363-5973-af23-54d78069e03a' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3971319f-1363-5973-af23-54d78069e03a', 'ko', 'canonical', '일 콤플레소 바로코', '일 콤플레소 바로코', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3971319f-1363-5973-af23-54d78069e03a' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '3971319f-1363-5973-af23-54d78069e03a' AS a, 'gnd' AS n, '5252557-0' AS v UNION ALL SELECT '3971319f-1363-5973-af23-54d78069e03a' AS a, 'isni' AS n, '0000000123242131' AS v UNION ALL SELECT '3971319f-1363-5973-af23-54d78069e03a' AS a, 'lccn' AS n, 'n79024739' AS v UNION ALL SELECT '3971319f-1363-5973-af23-54d78069e03a' AS a, 'musicbrainz_artist' AS n, '54042b5e-1e72-4651-9aa3-ba81e57fa155' AS v UNION ALL SELECT '3971319f-1363-5973-af23-54d78069e03a' AS a, 'viaf' AS n, '312659734' AS v UNION ALL SELECT '3971319f-1363-5973-af23-54d78069e03a' AS a, 'wikidata' AS n, 'Q16215310' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '일 콤플레소 바로코', 'Il Complesso Barocco', 'orchestra', 'B', '1977', 'Italy', '3971319f-1363-5973-af23-54d78069e03a', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '3971319f-1363-5973-af23-54d78069e03a');

-- 루시 크로 (Lucy Crowe, Q15428992) · soprano

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'dec8b853-5db5-5e0a-9c14-434afc7ad804', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'dec8b853-5db5-5e0a-9c14-434afc7ad804');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'dec8b853-5db5-5e0a-9c14-434afc7ad804', 'en', 'canonical', 'Lucy Crowe', 'lucy crowe', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'dec8b853-5db5-5e0a-9c14-434afc7ad804' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'dec8b853-5db5-5e0a-9c14-434afc7ad804', 'ko', 'canonical', '루시 크로', '루시 크로', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'dec8b853-5db5-5e0a-9c14-434afc7ad804' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'dec8b853-5db5-5e0a-9c14-434afc7ad804' AS a, 'gnd' AS n, '140332103' AS v UNION ALL SELECT 'dec8b853-5db5-5e0a-9c14-434afc7ad804' AS a, 'isni' AS n, '0000000076068598' AS v UNION ALL SELECT 'dec8b853-5db5-5e0a-9c14-434afc7ad804' AS a, 'lccn' AS n, 'no2003033897' AS v UNION ALL SELECT 'dec8b853-5db5-5e0a-9c14-434afc7ad804' AS a, 'musicbrainz_artist' AS n, 'bf5526da-4c85-4860-ae6f-0e815bb99a06' AS v UNION ALL SELECT 'dec8b853-5db5-5e0a-9c14-434afc7ad804' AS a, 'viaf' AS n, '103859509' AS v UNION ALL SELECT 'dec8b853-5db5-5e0a-9c14-434afc7ad804' AS a, 'wikidata' AS n, 'Q15428992' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '루시 크로', 'Lucy Crowe', 'soprano', 'B', '1979', 'United Kingdom', 'dec8b853-5db5-5e0a-9c14-434afc7ad804', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'dec8b853-5db5-5e0a-9c14-434afc7ad804');

-- 해리 비켓 (Harry Bicket, Q1165541) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'c998b493-3dc1-5ed8-bf30-83f3cd960a33', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'c998b493-3dc1-5ed8-bf30-83f3cd960a33');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c998b493-3dc1-5ed8-bf30-83f3cd960a33', 'en', 'canonical', 'Harry Bicket', 'harry bicket', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c998b493-3dc1-5ed8-bf30-83f3cd960a33' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c998b493-3dc1-5ed8-bf30-83f3cd960a33', 'ko', 'canonical', '해리 비켓', '해리 비켓', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c998b493-3dc1-5ed8-bf30-83f3cd960a33' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'c998b493-3dc1-5ed8-bf30-83f3cd960a33' AS a, 'gnd' AS n, '134734882' AS v UNION ALL SELECT 'c998b493-3dc1-5ed8-bf30-83f3cd960a33' AS a, 'isni' AS n, '0000000081893664' AS v UNION ALL SELECT 'c998b493-3dc1-5ed8-bf30-83f3cd960a33' AS a, 'lccn' AS n, 'n92035590' AS v UNION ALL SELECT 'c998b493-3dc1-5ed8-bf30-83f3cd960a33' AS a, 'musicbrainz_artist' AS n, 'bb9d0615-5976-4dbc-8503-c63b9cf4708f' AS v UNION ALL SELECT 'c998b493-3dc1-5ed8-bf30-83f3cd960a33' AS a, 'viaf' AS n, '120631875' AS v UNION ALL SELECT 'c998b493-3dc1-5ed8-bf30-83f3cd960a33' AS a, 'wikidata' AS n, 'Q1165541' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '해리 비켓', 'Harry Bicket', 'conductor', 'B', '1961', 'United Kingdom', 'c998b493-3dc1-5ed8-bf30-83f3cd960a33', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'c998b493-3dc1-5ed8-bf30-83f3cd960a33');

-- 잉글리시 콘서트 (The English Concert, Q926326) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'd2a10394-1526-5ffc-aa96-d8191e28c230', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'd2a10394-1526-5ffc-aa96-d8191e28c230');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd2a10394-1526-5ffc-aa96-d8191e28c230', 'en', 'canonical', 'The English Concert', 'the english concert', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd2a10394-1526-5ffc-aa96-d8191e28c230' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd2a10394-1526-5ffc-aa96-d8191e28c230', 'ko', 'canonical', '잉글리시 콘서트', '잉글리시 콘서트', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd2a10394-1526-5ffc-aa96-d8191e28c230' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'd2a10394-1526-5ffc-aa96-d8191e28c230' AS a, 'gnd' AS n, '1098964-X' AS v UNION ALL SELECT 'd2a10394-1526-5ffc-aa96-d8191e28c230' AS a, 'isni' AS n, '000000012348662X' AS v UNION ALL SELECT 'd2a10394-1526-5ffc-aa96-d8191e28c230' AS a, 'lccn' AS n, 'n78096796' AS v UNION ALL SELECT 'd2a10394-1526-5ffc-aa96-d8191e28c230' AS a, 'lccn' AS n, 'n86856203' AS v UNION ALL SELECT 'd2a10394-1526-5ffc-aa96-d8191e28c230' AS a, 'musicbrainz_artist' AS n, '8af55e27-c6ad-44f3-a6d2-53df5462798c' AS v UNION ALL SELECT 'd2a10394-1526-5ffc-aa96-d8191e28c230' AS a, 'musicbrainz_artist' AS n, 'd522c2c9-0174-43d9-b4eb-89ac98bb0aa0' AS v UNION ALL SELECT 'd2a10394-1526-5ffc-aa96-d8191e28c230' AS a, 'viaf' AS n, '150233285' AS v UNION ALL SELECT 'd2a10394-1526-5ffc-aa96-d8191e28c230' AS a, 'wikidata' AS n, 'Q926326' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '잉글리시 콘서트', 'The English Concert', 'orchestra', 'B', '1972', 'United Kingdom', 'd2a10394-1526-5ffc-aa96-d8191e28c230', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'd2a10394-1526-5ffc-aa96-d8191e28c230');

-- 다니엘 로이스 (Daniël Reuss, Q592648) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '397d9c15-475f-5425-867b-a814e0601454', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '397d9c15-475f-5425-867b-a814e0601454');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '397d9c15-475f-5425-867b-a814e0601454', 'en', 'canonical', 'Daniël Reuss', 'daniël reuss', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '397d9c15-475f-5425-867b-a814e0601454' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '397d9c15-475f-5425-867b-a814e0601454', 'ko', 'canonical', '다니엘 로이스', '다니엘 로이스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '397d9c15-475f-5425-867b-a814e0601454' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '397d9c15-475f-5425-867b-a814e0601454' AS a, 'gnd' AS n, '13504085X' AS v UNION ALL SELECT '397d9c15-475f-5425-867b-a814e0601454' AS a, 'isni' AS n, '0000000084156301' AS v UNION ALL SELECT '397d9c15-475f-5425-867b-a814e0601454' AS a, 'lccn' AS n, 'n97099243' AS v UNION ALL SELECT '397d9c15-475f-5425-867b-a814e0601454' AS a, 'musicbrainz_artist' AS n, 'a910a8f2-5927-41e5-8ade-f7b5cb0fda27' AS v UNION ALL SELECT '397d9c15-475f-5425-867b-a814e0601454' AS a, 'viaf' AS n, '254142163' AS v UNION ALL SELECT '397d9c15-475f-5425-867b-a814e0601454' AS a, 'wikidata' AS n, 'Q592648' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '다니엘 로이스', 'Daniël Reuss', 'conductor', 'B', '1961', 'Netherlands', '397d9c15-475f-5425-867b-a814e0601454', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '397d9c15-475f-5425-867b-a814e0601454');

-- 카펠라 암스테르담 (Cappella Amsterdam, Q579493) · choir

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '78560004-29d7-51f7-a581-387e170572ae', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '78560004-29d7-51f7-a581-387e170572ae');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '78560004-29d7-51f7-a581-387e170572ae', 'en', 'canonical', 'Cappella Amsterdam', 'cappella amsterdam', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '78560004-29d7-51f7-a581-387e170572ae' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '78560004-29d7-51f7-a581-387e170572ae', 'ko', 'canonical', '카펠라 암스테르담', '카펠라 암스테르담', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '78560004-29d7-51f7-a581-387e170572ae' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '78560004-29d7-51f7-a581-387e170572ae' AS a, 'gnd' AS n, '10018739-0' AS v UNION ALL SELECT '78560004-29d7-51f7-a581-387e170572ae' AS a, 'isni' AS n, '0000000102392720' AS v UNION ALL SELECT '78560004-29d7-51f7-a581-387e170572ae' AS a, 'lccn' AS n, 'n97099247' AS v UNION ALL SELECT '78560004-29d7-51f7-a581-387e170572ae' AS a, 'musicbrainz_artist' AS n, '3a1216e4-c66e-41c9-a92f-465f5bb07beb' AS v UNION ALL SELECT '78560004-29d7-51f7-a581-387e170572ae' AS a, 'viaf' AS n, '152724170' AS v UNION ALL SELECT '78560004-29d7-51f7-a581-387e170572ae' AS a, 'wikidata' AS n, 'Q579493' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '카펠라 암스테르담', 'Cappella Amsterdam', 'choir', 'B', '1970', 'Netherlands', '78560004-29d7-51f7-a581-387e170572ae', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '78560004-29d7-51f7-a581-387e170572ae');

-- 유발 바인베르크 (Yuval Weinberg, Q42404859) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a5233752-6593-5c81-acf3-b708dc1ee339', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a5233752-6593-5c81-acf3-b708dc1ee339');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a5233752-6593-5c81-acf3-b708dc1ee339', 'en', 'canonical', 'Yuval Weinberg', 'yuval weinberg', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a5233752-6593-5c81-acf3-b708dc1ee339' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a5233752-6593-5c81-acf3-b708dc1ee339', 'ko', 'canonical', '유발 바인베르크', '유발 바인베르크', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a5233752-6593-5c81-acf3-b708dc1ee339' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a5233752-6593-5c81-acf3-b708dc1ee339' AS a, 'gnd' AS n, '119320920X' AS v UNION ALL SELECT 'a5233752-6593-5c81-acf3-b708dc1ee339' AS a, 'musicbrainz_artist' AS n, 'ada5dc03-ba6b-424a-ab35-a80b846e3298' AS v UNION ALL SELECT 'a5233752-6593-5c81-acf3-b708dc1ee339' AS a, 'viaf' AS n, '5380156677162333770007' AS v UNION ALL SELECT 'a5233752-6593-5c81-acf3-b708dc1ee339' AS a, 'wikidata' AS n, 'Q42404859' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '유발 바인베르크', 'Yuval Weinberg', 'conductor', 'B', '1990', 'Israel', 'a5233752-6593-5c81-acf3-b708dc1ee339', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a5233752-6593-5c81-acf3-b708dc1ee339');

-- 이네사 갈란테 (Inese Galante, Q540714) · soprano

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5', 'en', 'canonical', 'Inese Galante', 'inese galante', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5', 'ko', 'canonical', '이네사 갈란테', '이네사 갈란테', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5' AS a, 'gnd' AS n, '122829050' AS v UNION ALL SELECT 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5' AS a, 'isni' AS n, '0000000066799215' AS v UNION ALL SELECT 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5' AS a, 'lccn' AS n, 'no97063164' AS v UNION ALL SELECT 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5' AS a, 'musicbrainz_artist' AS n, 'd483e87b-bf31-4492-88cb-a90399e2a4f9' AS v UNION ALL SELECT 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5' AS a, 'viaf' AS n, '16833358' AS v UNION ALL SELECT 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5' AS a, 'viaf' AS n, '276309890' AS v UNION ALL SELECT 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5' AS a, 'wikidata' AS n, 'Q540714' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '이네사 갈란테', 'Inese Galante', 'soprano', 'B', '1954', 'Latvia', 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a0c86bc5-e36b-5e76-b82b-d97668bd73e5');

-- 런던 무지치 (London Musici, Q27817675) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '3653e837-cd95-5278-ac91-6d4e023a63a7', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '3653e837-cd95-5278-ac91-6d4e023a63a7');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3653e837-cd95-5278-ac91-6d4e023a63a7', 'en', 'canonical', 'London Musici', 'london musici', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3653e837-cd95-5278-ac91-6d4e023a63a7' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3653e837-cd95-5278-ac91-6d4e023a63a7', 'ko', 'canonical', '런던 무지치', '런던 무지치', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3653e837-cd95-5278-ac91-6d4e023a63a7' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '3653e837-cd95-5278-ac91-6d4e023a63a7' AS a, 'gnd' AS n, '10018750-X' AS v UNION ALL SELECT '3653e837-cd95-5278-ac91-6d4e023a63a7' AS a, 'isni' AS n, '0000000110904810' AS v UNION ALL SELECT '3653e837-cd95-5278-ac91-6d4e023a63a7' AS a, 'lccn' AS n, 'n91032698' AS v UNION ALL SELECT '3653e837-cd95-5278-ac91-6d4e023a63a7' AS a, 'musicbrainz_artist' AS n, 'f127e8e1-e1e1-4b2c-bbc9-109840d89ca6' AS v UNION ALL SELECT '3653e837-cd95-5278-ac91-6d4e023a63a7' AS a, 'viaf' AS n, '142393453' AS v UNION ALL SELECT '3653e837-cd95-5278-ac91-6d4e023a63a7' AS a, 'wikidata' AS n, 'Q27817675' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '런던 무지치', 'London Musici', 'orchestra', 'B', '1988', 'United Kingdom', '3653e837-cd95-5278-ac91-6d4e023a63a7', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '3653e837-cd95-5278-ac91-6d4e023a63a7');

-- 패트릭 서머스 (Patrick Summers, Q16195351) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e', 'en', 'canonical', 'Patrick Summers', 'patrick summers', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e', 'ko', 'canonical', '패트릭 서머스', '패트릭 서머스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e' AS a, 'gnd' AS n, '135264642' AS v UNION ALL SELECT '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e' AS a, 'isni' AS n, '0000000055162921' AS v UNION ALL SELECT '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e' AS a, 'lccn' AS n, 'no99044053' AS v UNION ALL SELECT '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e' AS a, 'musicbrainz_artist' AS n, '2b8db7e3-ab89-44ba-8b02-1c3f6627100a' AS v UNION ALL SELECT '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e' AS a, 'viaf' AS n, '17434486' AS v UNION ALL SELECT '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e' AS a, 'wikidata' AS n, 'Q16195351' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '패트릭 서머스', 'Patrick Summers', 'conductor', 'B', '1960', 'United States', '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '8a0a5e4a-85d2-5c4a-9aeb-11d2ccefb95e');

-- 문태국 (Taeguk Mun, Q114869541) · cellist

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '1963d09f-2971-5c3a-92c6-36d01bb50b92', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '1963d09f-2971-5c3a-92c6-36d01bb50b92');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1963d09f-2971-5c3a-92c6-36d01bb50b92', 'en', 'canonical', 'Taeguk Mun', 'taeguk mun', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1963d09f-2971-5c3a-92c6-36d01bb50b92' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1963d09f-2971-5c3a-92c6-36d01bb50b92', 'ko', 'canonical', '문태국', '문태국', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1963d09f-2971-5c3a-92c6-36d01bb50b92' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '1963d09f-2971-5c3a-92c6-36d01bb50b92' AS a, 'isni' AS n, '0000000483083912' AS v UNION ALL SELECT '1963d09f-2971-5c3a-92c6-36d01bb50b92' AS a, 'musicbrainz_artist' AS n, 'f47127a3-5d08-405d-b2ae-345128f88abd' AS v UNION ALL SELECT '1963d09f-2971-5c3a-92c6-36d01bb50b92' AS a, 'viaf' AS n, '30159105574506402400' AS v UNION ALL SELECT '1963d09f-2971-5c3a-92c6-36d01bb50b92' AS a, 'wikidata' AS n, 'Q114869541' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '문태국', 'Taeguk Mun', 'cellist', 'B', '1994', 'South Korea', '1963d09f-2971-5c3a-92c6-36d01bb50b92', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '1963d09f-2971-5c3a-92c6-36d01bb50b92');

-- WDR 교향악단: 옛 manual 행 341 에 엔티티를 잇는다
-- WDR 교향악단 (WDR Symphony Orchestra, Q829283) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'eb645e63-5d33-5c47-add3-150e572dc39d', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'eb645e63-5d33-5c47-add3-150e572dc39d');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'eb645e63-5d33-5c47-add3-150e572dc39d', 'en', 'canonical', 'WDR Symphony Orchestra', 'wdr symphony orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'eb645e63-5d33-5c47-add3-150e572dc39d' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'eb645e63-5d33-5c47-add3-150e572dc39d', 'ko', 'canonical', 'WDR 교향악단', 'wdr 교향악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'eb645e63-5d33-5c47-add3-150e572dc39d' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'eb645e63-5d33-5c47-add3-150e572dc39d' AS a, 'gnd' AS n, '10322853-6' AS v UNION ALL SELECT 'eb645e63-5d33-5c47-add3-150e572dc39d' AS a, 'isni' AS n, '0000000106612663' AS v UNION ALL SELECT 'eb645e63-5d33-5c47-add3-150e572dc39d' AS a, 'lccn' AS n, 'no2002065542' AS v UNION ALL SELECT 'eb645e63-5d33-5c47-add3-150e572dc39d' AS a, 'musicbrainz_artist' AS n, '8324aebd-deba-449d-aa19-7faca14217f0' AS v UNION ALL SELECT 'eb645e63-5d33-5c47-add3-150e572dc39d' AS a, 'viaf' AS n, '131486842' AS v UNION ALL SELECT 'eb645e63-5d33-5c47-add3-150e572dc39d' AS a, 'viaf' AS n, '157741757' AS v UNION ALL SELECT 'eb645e63-5d33-5c47-add3-150e572dc39d' AS a, 'wikidata' AS n, 'Q829283' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

UPDATE artists artist
SET artist.authority_entity_id = 'eb645e63-5d33-5c47-add3-150e572dc39d'
WHERE artist.id = 341 AND artist.authority_entity_id IS NULL
  AND artist.english_name = 'WDR Symphony Orchestra' AND artist.origin = 'manual'
  AND NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) linked WHERE linked.authority_entity_id = 'eb645e63-5d33-5c47-add3-150e572dc39d');
