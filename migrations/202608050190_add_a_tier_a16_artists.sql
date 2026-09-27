-- A tier A16 배치에 필요한 인물·단체 12곳을 추가한다.
--
--   피아노  라그나 시르머 · 이사타 카네메이슨 · 루시 파럼
--   지휘    홀리 매시슨
--   악단    로열 리버풀 필하모닉 · BBC 콘서트 오케스트라 · 태즈메이니아 심포니
--   3중주   이시도어 코언(바이올린) · 버나드 그린하우스(첼로) · 보자르 삼중주단
--           베네딕트 클뢰크너(첼로) · 파블로 페란데스(첼로)
--
-- 비제 교향곡 1번(196) · 클라라 슈만 피아노 3중주 G단조(176) · 피아노 협주곡
-- A단조(177)에 쓴다.
--
-- **176 은 피아노 3중주라 세 주자를 다 넣어야 한다.** 배치 정의의 videos[] 가 읽는
-- 딸림 크레딧 키에 3중주 주자를 적을 자리가 없어 후보에는 피아니스트만 들어갔다.
-- 여기서 바이올린·첼로와 3중주단을 보탠다. 202608050186 의 소프라노와 같은 방식이다.
-- 반주가 아니라 대등한 3중주이므로 ACCOMPANIST 가 아니라 VIOLINIST·CELLIST 로
-- 넣는다. 적재기가 악기 역할을 독주자로 묶는 것이 이 곡에서는 맞는 동작이다.
--
-- 보자르 삼중주단은 MusicBrainz 녹음 관계로 확인했다. 1972년 판이라 기유가 아니라
-- 코언이 바이올린이다(instrument 관계에 Cohen violin 1971 · Greenhouse cello 1971,
-- MB 길이 434,000ms 가 영상 434초와 일치).
--
-- **이아손 케라미디스(Q136637393)는 넣지 않는다.** 시르머 판의 바이올린 주자인데
-- wikidata 항목이 라벨 하나(mul 'Iason Keramidis')뿐이고 설명이 없으며 직업이
-- 'musician' 으로만 적혀 있다. 악기 진술이 없고 MusicBrainz 식별자도 없다.
-- 바이올린이라는 근거는 음반사 크레딧 차례뿐이다. A11 에서 같은 모양의 항목
-- (Q139199024)을 버렸고 같은 판단을 한다 — 이름만으로 인물을 병합하지 않는다.
-- 그래서 시르머 판만 크레딧이 피아노·첼로 둘이고 나머지 둘은 셋이다. 비대칭이지만
-- 확인되지 않은 신원을 붙이는 것보다 낫다.
--
-- 클뢰크너와 BBC 콘서트 오케스트라는 wikidata 에 국적·나라 진술이 없어 각각
-- 독일·영국으로 적었다. 매시슨과 파럼은 출생 연도가 없어 NULL 로 둔다.
-- 보자르 삼중주단 외에는 한국어 라벨이 없어 한글 이름을 직접 적었다.
--
-- 202608050188 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '9fcd8343-bb93-5ed3-8051-d41410c3ce84', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '9fcd8343-bb93-5ed3-8051-d41410c3ce84');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9fcd8343-bb93-5ed3-8051-d41410c3ce84', 'en', 'canonical', 'Ragna Schirmer', 'ragna schirmer', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9fcd8343-bb93-5ed3-8051-d41410c3ce84' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9fcd8343-bb93-5ed3-8051-d41410c3ce84', 'ko', 'canonical', '라그나 시르머', '라그나 시르머', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9fcd8343-bb93-5ed3-8051-d41410c3ce84' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '9fcd8343-bb93-5ed3-8051-d41410c3ce84' AS a, 'gnd' AS n, '128390476' AS v UNION ALL SELECT '9fcd8343-bb93-5ed3-8051-d41410c3ce84' AS a, 'isni' AS n, '0000000080959422' AS v UNION ALL SELECT '9fcd8343-bb93-5ed3-8051-d41410c3ce84' AS a, 'musicbrainz_artist' AS n, 'f839c704-7e5b-4524-902d-591ecf075763' AS v UNION ALL SELECT '9fcd8343-bb93-5ed3-8051-d41410c3ce84' AS a, 'viaf' AS n, '17001697' AS v UNION ALL SELECT '9fcd8343-bb93-5ed3-8051-d41410c3ce84' AS a, 'wikidata' AS n, 'Q106486' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '라그나 시르머', 'Ragna Schirmer', 'pianist', 'A', '1972', 'Germany', '9fcd8343-bb93-5ed3-8051-d41410c3ce84', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '9fcd8343-bb93-5ed3-8051-d41410c3ce84');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '790162b6-9fbd-58d6-80f2-0bb965e92478', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '790162b6-9fbd-58d6-80f2-0bb965e92478');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '790162b6-9fbd-58d6-80f2-0bb965e92478', 'en', 'canonical', 'Isata Kanneh-Mason', 'isata kanneh-mason', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '790162b6-9fbd-58d6-80f2-0bb965e92478' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '790162b6-9fbd-58d6-80f2-0bb965e92478', 'ko', 'canonical', '이사타 카네메이슨', '이사타 카네메이슨', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '790162b6-9fbd-58d6-80f2-0bb965e92478' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '790162b6-9fbd-58d6-80f2-0bb965e92478' AS a, 'gnd' AS n, '1259982238' AS v UNION ALL SELECT '790162b6-9fbd-58d6-80f2-0bb965e92478' AS a, 'isni' AS n, '0000000478493335' AS v UNION ALL SELECT '790162b6-9fbd-58d6-80f2-0bb965e92478' AS a, 'musicbrainz_artist' AS n, '72840e82-dd80-4304-a998-bb5096f2b85f' AS v UNION ALL SELECT '790162b6-9fbd-58d6-80f2-0bb965e92478' AS a, 'viaf' AS n, '28156856238949600800' AS v UNION ALL SELECT '790162b6-9fbd-58d6-80f2-0bb965e92478' AS a, 'wikidata' AS n, 'Q100868946' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '이사타 카네메이슨', 'Isata Kanneh-Mason', 'pianist', 'A', '1996', 'United Kingdom', '790162b6-9fbd-58d6-80f2-0bb965e92478', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '790162b6-9fbd-58d6-80f2-0bb965e92478');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '57712071-386f-5317-bb9a-07d14f1e2154', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '57712071-386f-5317-bb9a-07d14f1e2154');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '57712071-386f-5317-bb9a-07d14f1e2154', 'en', 'canonical', 'Lucy Parham', 'lucy parham', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '57712071-386f-5317-bb9a-07d14f1e2154' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '57712071-386f-5317-bb9a-07d14f1e2154', 'ko', 'canonical', '루시 파럼', '루시 파럼', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '57712071-386f-5317-bb9a-07d14f1e2154' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '57712071-386f-5317-bb9a-07d14f1e2154' AS a, 'wikidata' AS n, 'Q62619403' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '루시 파럼', 'Lucy Parham', 'pianist', 'A', NULL, 'United Kingdom', '57712071-386f-5317-bb9a-07d14f1e2154', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '57712071-386f-5317-bb9a-07d14f1e2154');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '7715c94e-4f86-54a5-a101-2ff19af24af6', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '7715c94e-4f86-54a5-a101-2ff19af24af6');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7715c94e-4f86-54a5-a101-2ff19af24af6', 'en', 'canonical', 'Holly Mathieson', 'holly mathieson', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7715c94e-4f86-54a5-a101-2ff19af24af6' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7715c94e-4f86-54a5-a101-2ff19af24af6', 'ko', 'canonical', '홀리 매시슨', '홀리 매시슨', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7715c94e-4f86-54a5-a101-2ff19af24af6' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '7715c94e-4f86-54a5-a101-2ff19af24af6' AS a, 'musicbrainz_artist' AS n, 'ad0c92b3-6b46-4007-981f-f337d1ba637e' AS v UNION ALL SELECT '7715c94e-4f86-54a5-a101-2ff19af24af6' AS a, 'wikidata' AS n, 'Q21998639' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '홀리 매시슨', 'Holly Mathieson', 'conductor', 'A', NULL, 'New Zealand', '7715c94e-4f86-54a5-a101-2ff19af24af6', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '7715c94e-4f86-54a5-a101-2ff19af24af6');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '953b664d-9605-5c74-8dbe-c9966e27b59b', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '953b664d-9605-5c74-8dbe-c9966e27b59b');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '953b664d-9605-5c74-8dbe-c9966e27b59b', 'en', 'canonical', 'Royal Liverpool Philharmonic Orchestra', 'royal liverpool philharmonic orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '953b664d-9605-5c74-8dbe-c9966e27b59b' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '953b664d-9605-5c74-8dbe-c9966e27b59b', 'ko', 'canonical', '로열 리버풀 필하모닉', '로열 리버풀 필하모닉', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '953b664d-9605-5c74-8dbe-c9966e27b59b' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '953b664d-9605-5c74-8dbe-c9966e27b59b' AS a, 'gnd' AS n, '1212787-5' AS v UNION ALL SELECT '953b664d-9605-5c74-8dbe-c9966e27b59b' AS a, 'isni' AS n, '000000012181735X' AS v UNION ALL SELECT '953b664d-9605-5c74-8dbe-c9966e27b59b' AS a, 'musicbrainz_artist' AS n, '887b4dfd-269c-46a8-a42d-32560b417760' AS v UNION ALL SELECT '953b664d-9605-5c74-8dbe-c9966e27b59b' AS a, 'viaf' AS n, '142480117' AS v UNION ALL SELECT '953b664d-9605-5c74-8dbe-c9966e27b59b' AS a, 'wikidata' AS n, 'Q1818979' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '로열 리버풀 필하모닉', 'Royal Liverpool Philharmonic Orchestra', 'orchestra', 'A', '1840', 'United Kingdom', '953b664d-9605-5c74-8dbe-c9966e27b59b', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '953b664d-9605-5c74-8dbe-c9966e27b59b');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '805a9cf8-5b66-54b0-a4de-c6e5e6126499', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '805a9cf8-5b66-54b0-a4de-c6e5e6126499');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '805a9cf8-5b66-54b0-a4de-c6e5e6126499', 'en', 'canonical', 'BBC Concert Orchestra', 'bbc concert orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '805a9cf8-5b66-54b0-a4de-c6e5e6126499' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '805a9cf8-5b66-54b0-a4de-c6e5e6126499', 'ko', 'canonical', 'BBC 콘서트 오케스트라', 'bbc 콘서트 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '805a9cf8-5b66-54b0-a4de-c6e5e6126499' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '805a9cf8-5b66-54b0-a4de-c6e5e6126499' AS a, 'gnd' AS n, '5503566-8' AS v UNION ALL SELECT '805a9cf8-5b66-54b0-a4de-c6e5e6126499' AS a, 'isni' AS n, '0000000107293174' AS v UNION ALL SELECT '805a9cf8-5b66-54b0-a4de-c6e5e6126499' AS a, 'musicbrainz_artist' AS n, 'dfeba5ea-c967-4ad2-9cdd-3cffb4320143' AS v UNION ALL SELECT '805a9cf8-5b66-54b0-a4de-c6e5e6126499' AS a, 'viaf' AS n, '155687728' AS v UNION ALL SELECT '805a9cf8-5b66-54b0-a4de-c6e5e6126499' AS a, 'wikidata' AS n, 'Q2217163' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT 'BBC 콘서트 오케스트라', 'BBC Concert Orchestra', 'orchestra', 'A', '1952', 'United Kingdom', '805a9cf8-5b66-54b0-a4de-c6e5e6126499', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '805a9cf8-5b66-54b0-a4de-c6e5e6126499');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '1369146a-b7ff-5bd6-a7d0-77b71860b0d1', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '1369146a-b7ff-5bd6-a7d0-77b71860b0d1');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1369146a-b7ff-5bd6-a7d0-77b71860b0d1', 'en', 'canonical', 'Tasmanian Symphony Orchestra', 'tasmanian symphony orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1369146a-b7ff-5bd6-a7d0-77b71860b0d1' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1369146a-b7ff-5bd6-a7d0-77b71860b0d1', 'ko', 'canonical', '태즈메이니아 심포니 오케스트라', '태즈메이니아 심포니 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1369146a-b7ff-5bd6-a7d0-77b71860b0d1' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '1369146a-b7ff-5bd6-a7d0-77b71860b0d1' AS a, 'isni' AS n, '0000000110089027' AS v UNION ALL SELECT '1369146a-b7ff-5bd6-a7d0-77b71860b0d1' AS a, 'musicbrainz_artist' AS n, '7e33a84d-0866-4d2c-b578-1ced0150d856' AS v UNION ALL SELECT '1369146a-b7ff-5bd6-a7d0-77b71860b0d1' AS a, 'viaf' AS n, '122485015' AS v UNION ALL SELECT '1369146a-b7ff-5bd6-a7d0-77b71860b0d1' AS a, 'wikidata' AS n, 'Q2263987' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '태즈메이니아 심포니 오케스트라', 'Tasmanian Symphony Orchestra', 'orchestra', 'A', '1948', 'Australia', '1369146a-b7ff-5bd6-a7d0-77b71860b0d1', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '1369146a-b7ff-5bd6-a7d0-77b71860b0d1');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '107734ba-7e47-571d-986c-5fa6b7949608', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '107734ba-7e47-571d-986c-5fa6b7949608');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '107734ba-7e47-571d-986c-5fa6b7949608', 'en', 'canonical', 'Isidore Cohen', 'isidore cohen', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '107734ba-7e47-571d-986c-5fa6b7949608' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '107734ba-7e47-571d-986c-5fa6b7949608', 'ko', 'canonical', '이시도어 코언', '이시도어 코언', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '107734ba-7e47-571d-986c-5fa6b7949608' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '107734ba-7e47-571d-986c-5fa6b7949608' AS a, 'gnd' AS n, '134348990' AS v UNION ALL SELECT '107734ba-7e47-571d-986c-5fa6b7949608' AS a, 'isni' AS n, '000000007141376X' AS v UNION ALL SELECT '107734ba-7e47-571d-986c-5fa6b7949608' AS a, 'musicbrainz_artist' AS n, '9de8d43d-6b9a-4779-bdd2-b552afdc2ab6' AS v UNION ALL SELECT '107734ba-7e47-571d-986c-5fa6b7949608' AS a, 'viaf' AS n, '78342309' AS v UNION ALL SELECT '107734ba-7e47-571d-986c-5fa6b7949608' AS a, 'wikidata' AS n, 'Q6080913' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '이시도어 코언', 'Isidore Cohen', 'violinist', 'A', '1922', 'United States', '107734ba-7e47-571d-986c-5fa6b7949608', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '107734ba-7e47-571d-986c-5fa6b7949608');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'c79f57a4-44e9-5e58-b849-123b2b07786a', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'c79f57a4-44e9-5e58-b849-123b2b07786a');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c79f57a4-44e9-5e58-b849-123b2b07786a', 'en', 'canonical', 'Bernard Greenhouse', 'bernard greenhouse', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c79f57a4-44e9-5e58-b849-123b2b07786a' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c79f57a4-44e9-5e58-b849-123b2b07786a', 'ko', 'canonical', '버나드 그린하우스', '버나드 그린하우스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c79f57a4-44e9-5e58-b849-123b2b07786a' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'c79f57a4-44e9-5e58-b849-123b2b07786a' AS a, 'gnd' AS n, '124086519' AS v UNION ALL SELECT 'c79f57a4-44e9-5e58-b849-123b2b07786a' AS a, 'isni' AS n, '0000000083674238' AS v UNION ALL SELECT 'c79f57a4-44e9-5e58-b849-123b2b07786a' AS a, 'musicbrainz_artist' AS n, '6344f95d-0bd0-4b1e-9ba0-7fbf595d56f6' AS v UNION ALL SELECT 'c79f57a4-44e9-5e58-b849-123b2b07786a' AS a, 'viaf' AS n, '27995569' AS v UNION ALL SELECT 'c79f57a4-44e9-5e58-b849-123b2b07786a' AS a, 'wikidata' AS n, 'Q2625621' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '버나드 그린하우스', 'Bernard Greenhouse', 'cellist', 'A', '1916', 'United States', 'c79f57a4-44e9-5e58-b849-123b2b07786a', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'c79f57a4-44e9-5e58-b849-123b2b07786a');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'ac85aca5-981f-5b77-a9e0-75ddbafbbb64', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'ac85aca5-981f-5b77-a9e0-75ddbafbbb64');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ac85aca5-981f-5b77-a9e0-75ddbafbbb64', 'en', 'canonical', 'Beaux Arts Trio', 'beaux arts trio', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ac85aca5-981f-5b77-a9e0-75ddbafbbb64' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ac85aca5-981f-5b77-a9e0-75ddbafbbb64', 'ko', 'canonical', '보자르 삼중주단', '보자르 삼중주단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ac85aca5-981f-5b77-a9e0-75ddbafbbb64' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'ac85aca5-981f-5b77-a9e0-75ddbafbbb64' AS a, 'gnd' AS n, '1087263-2' AS v UNION ALL SELECT 'ac85aca5-981f-5b77-a9e0-75ddbafbbb64' AS a, 'isni' AS n, '000000010943812X' AS v UNION ALL SELECT 'ac85aca5-981f-5b77-a9e0-75ddbafbbb64' AS a, 'musicbrainz_artist' AS n, '0a7009ab-c02d-4330-81c7-d3894f610f06' AS v UNION ALL SELECT 'ac85aca5-981f-5b77-a9e0-75ddbafbbb64' AS a, 'viaf' AS n, '141914216' AS v UNION ALL SELECT 'ac85aca5-981f-5b77-a9e0-75ddbafbbb64' AS a, 'wikidata' AS n, 'Q813472' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '보자르 삼중주단', 'Beaux Arts Trio', 'ensemble', 'A', '1955', 'United States', 'ac85aca5-981f-5b77-a9e0-75ddbafbbb64', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'ac85aca5-981f-5b77-a9e0-75ddbafbbb64');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '157a02be-bf20-513f-b521-1183c6032ddf', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '157a02be-bf20-513f-b521-1183c6032ddf');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '157a02be-bf20-513f-b521-1183c6032ddf', 'en', 'canonical', 'Benedict Klöckner', 'benedict klöckner', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '157a02be-bf20-513f-b521-1183c6032ddf' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '157a02be-bf20-513f-b521-1183c6032ddf', 'ko', 'canonical', '베네딕트 클뢰크너', '베네딕트 클뢰크너', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '157a02be-bf20-513f-b521-1183c6032ddf' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '157a02be-bf20-513f-b521-1183c6032ddf' AS a, 'gnd' AS n, '133832708' AS v UNION ALL SELECT '157a02be-bf20-513f-b521-1183c6032ddf' AS a, 'isni' AS n, '0000000022782294' AS v UNION ALL SELECT '157a02be-bf20-513f-b521-1183c6032ddf' AS a, 'musicbrainz_artist' AS n, 'f1e2f956-b1d9-4693-9b6d-a306511c1697' AS v UNION ALL SELECT '157a02be-bf20-513f-b521-1183c6032ddf' AS a, 'viaf' AS n, '30739162' AS v UNION ALL SELECT '157a02be-bf20-513f-b521-1183c6032ddf' AS a, 'wikidata' AS n, 'Q33519710' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '베네딕트 클뢰크너', 'Benedict Klöckner', 'cellist', 'A', '1989', 'Germany', '157a02be-bf20-513f-b521-1183c6032ddf', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '157a02be-bf20-513f-b521-1183c6032ddf');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '87ac4201-b187-5189-a62e-7344315541fa', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '87ac4201-b187-5189-a62e-7344315541fa');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '87ac4201-b187-5189-a62e-7344315541fa', 'en', 'canonical', 'Pablo Ferrández', 'pablo ferrández', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '87ac4201-b187-5189-a62e-7344315541fa' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '87ac4201-b187-5189-a62e-7344315541fa', 'ko', 'canonical', '파블로 페란데스', '파블로 페란데스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '87ac4201-b187-5189-a62e-7344315541fa' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '87ac4201-b187-5189-a62e-7344315541fa' AS a, 'gnd' AS n, '1185837248' AS v UNION ALL SELECT '87ac4201-b187-5189-a62e-7344315541fa' AS a, 'isni' AS n, '0000000434678987' AS v UNION ALL SELECT '87ac4201-b187-5189-a62e-7344315541fa' AS a, 'musicbrainz_artist' AS n, 'f0ec175c-fb04-474c-93a8-d8c9882cbdc9' AS v UNION ALL SELECT '87ac4201-b187-5189-a62e-7344315541fa' AS a, 'viaf' AS n, '308777897' AS v UNION ALL SELECT '87ac4201-b187-5189-a62e-7344315541fa' AS a, 'wikidata' AS n, 'Q11061752' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '파블로 페란데스', 'Pablo Ferrández', 'cellist', 'A', '1991', 'Spain', '87ac4201-b187-5189-a62e-7344315541fa', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '87ac4201-b187-5189-a62e-7344315541fa');

