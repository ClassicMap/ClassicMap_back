-- S tier 대기열 F2 (베르디 오페라 낱곡)에 필요한 연주자·단체 14곳을 추가한다.
--   지휘:   피에르 조르조 모란디, 이온 마린, 카를로 리치
--   성악:   일레아나 코트루바슈(S), 티치아나 파브리치니(S), 안젤라 게오르기우(S),
--           플라시도 도밍고(T), 로베르토 알라냐(T), 프랭크 로파르도(T)
--   악단:   뮌헨 방송관현악단, 밀라노 주세페 베르디 교향악단, 바이에른 국립관현악단,
--           로열 오페라하우스 관현악단, 산타 체칠리아 국립음악원 관현악단
--
-- 202608050134 와 같은 방식이다.
--
-- <라 트라비아타> "축배의 노래" 의 성악가 크레딧을 붙이기로 해서 여섯이 늘었다.
-- 이 대목은 이중창 + 합창이라 지휘자를 주역으로 두지만, 노래하는 사람이 누구인지가
-- 연주의 정체성에 들어간다. 도밍고·게오르기우·알라냐는 뒤의 오페라 배치에서도
-- 다시 나올 이름이라 지금 등록해 두는 편이 낫다.
--
-- 바이에른 국립관현악단의 창단 연도는 궁정악단으로 거슬러 1523년을 적었다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '465c7a8e-30b9-54da-9261-b65f9eff1e98', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '465c7a8e-30b9-54da-9261-b65f9eff1e98');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '465c7a8e-30b9-54da-9261-b65f9eff1e98', 'en', 'canonical', 'Pier Giorgio Morandi', 'pier giorgio morandi', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '465c7a8e-30b9-54da-9261-b65f9eff1e98' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '465c7a8e-30b9-54da-9261-b65f9eff1e98', 'ko', 'canonical', '피에르 조르조 모란디', '피에르 조르조 모란디', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '465c7a8e-30b9-54da-9261-b65f9eff1e98' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '465c7a8e-30b9-54da-9261-b65f9eff1e98' AS a, 'gnd' AS n, '13549561X' AS v UNION ALL SELECT '465c7a8e-30b9-54da-9261-b65f9eff1e98' AS a, 'isni' AS n, '0000000121279774' AS v UNION ALL SELECT '465c7a8e-30b9-54da-9261-b65f9eff1e98' AS a, 'viaf' AS n, '36788579' AS v UNION ALL SELECT '465c7a8e-30b9-54da-9261-b65f9eff1e98' AS a, 'wikidata' AS n, 'Q106688028' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '피에르 조르조 모란디', 'Pier Giorgio Morandi', 'conductor', 'B', '1958', 'Italy', '465c7a8e-30b9-54da-9261-b65f9eff1e98', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '465c7a8e-30b9-54da-9261-b65f9eff1e98');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'ff51ef2d-6f4e-58cd-8228-cd045cc6bd9e', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'ff51ef2d-6f4e-58cd-8228-cd045cc6bd9e');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ff51ef2d-6f4e-58cd-8228-cd045cc6bd9e', 'en', 'canonical', 'Ion Marin', 'ion marin', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ff51ef2d-6f4e-58cd-8228-cd045cc6bd9e' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ff51ef2d-6f4e-58cd-8228-cd045cc6bd9e', 'ko', 'canonical', '이온 마린', '이온 마린', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ff51ef2d-6f4e-58cd-8228-cd045cc6bd9e' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'ff51ef2d-6f4e-58cd-8228-cd045cc6bd9e' AS a, 'gnd' AS n, '129624411' AS v UNION ALL SELECT 'ff51ef2d-6f4e-58cd-8228-cd045cc6bd9e' AS a, 'isni' AS n, '0000000110379593' AS v UNION ALL SELECT 'ff51ef2d-6f4e-58cd-8228-cd045cc6bd9e' AS a, 'musicbrainz_artist' AS n, '3832d4b1-2c79-4899-8bd1-4526fa1469ab' AS v UNION ALL SELECT 'ff51ef2d-6f4e-58cd-8228-cd045cc6bd9e' AS a, 'viaf' AS n, '10038804' AS v UNION ALL SELECT 'ff51ef2d-6f4e-58cd-8228-cd045cc6bd9e' AS a, 'wikidata' AS n, 'Q4281466' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '이온 마린', 'Ion Marin', 'conductor', 'A', '1960', 'Romania', 'ff51ef2d-6f4e-58cd-8228-cd045cc6bd9e', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'ff51ef2d-6f4e-58cd-8228-cd045cc6bd9e');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '525985d7-c0e4-545b-a3df-7abd3c224273', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '525985d7-c0e4-545b-a3df-7abd3c224273');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '525985d7-c0e4-545b-a3df-7abd3c224273', 'en', 'canonical', 'Münchner Rundfunkorchester', 'münchner rundfunkorchester', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '525985d7-c0e4-545b-a3df-7abd3c224273' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '525985d7-c0e4-545b-a3df-7abd3c224273', 'ko', 'canonical', '뮌헨 방송관현악단', '뮌헨 방송관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '525985d7-c0e4-545b-a3df-7abd3c224273' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '525985d7-c0e4-545b-a3df-7abd3c224273' AS a, 'gnd' AS n, '1082229-X' AS v UNION ALL SELECT '525985d7-c0e4-545b-a3df-7abd3c224273' AS a, 'isni' AS n, '0000000119422113' AS v UNION ALL SELECT '525985d7-c0e4-545b-a3df-7abd3c224273' AS a, 'musicbrainz_artist' AS n, '4167b5b4-4cce-4028-9e7d-614f3fdcb5cd' AS v UNION ALL SELECT '525985d7-c0e4-545b-a3df-7abd3c224273' AS a, 'viaf' AS n, '150732747' AS v UNION ALL SELECT '525985d7-c0e4-545b-a3df-7abd3c224273' AS a, 'wikidata' AS n, 'Q457183' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '뮌헨 방송관현악단', 'Münchner Rundfunkorchester', 'orchestra', 'A', '1952', 'Germany', '525985d7-c0e4-545b-a3df-7abd3c224273', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '525985d7-c0e4-545b-a3df-7abd3c224273');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '7fd98535-5a4a-55a1-9055-b90c22895893', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '7fd98535-5a4a-55a1-9055-b90c22895893');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7fd98535-5a4a-55a1-9055-b90c22895893', 'en', 'canonical', 'Carlo Rizzi', 'carlo rizzi', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7fd98535-5a4a-55a1-9055-b90c22895893' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7fd98535-5a4a-55a1-9055-b90c22895893', 'ko', 'canonical', '카를로 리치', '카를로 리치', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7fd98535-5a4a-55a1-9055-b90c22895893' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '7fd98535-5a4a-55a1-9055-b90c22895893' AS a, 'gnd' AS n, '129552216' AS v UNION ALL SELECT '7fd98535-5a4a-55a1-9055-b90c22895893' AS a, 'isni' AS n, '0000000121485017' AS v UNION ALL SELECT '7fd98535-5a4a-55a1-9055-b90c22895893' AS a, 'musicbrainz_artist' AS n, 'b482d66b-ba57-4507-8553-39bbb91a07ee' AS v UNION ALL SELECT '7fd98535-5a4a-55a1-9055-b90c22895893' AS a, 'viaf' AS n, '115803759' AS v UNION ALL SELECT '7fd98535-5a4a-55a1-9055-b90c22895893' AS a, 'wikidata' AS n, 'Q5041594' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '카를로 리치', 'Carlo Rizzi', 'conductor', 'A', '1960', 'Italy', '7fd98535-5a4a-55a1-9055-b90c22895893', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '7fd98535-5a4a-55a1-9055-b90c22895893');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '1966e898-efa1-51ee-8f89-680180993a41', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '1966e898-efa1-51ee-8f89-680180993a41');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1966e898-efa1-51ee-8f89-680180993a41', 'en', 'canonical', 'Orchestra Sinfonica di Milano Giuseppe Verdi', 'orchestra sinfonica di milano giuseppe verdi', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1966e898-efa1-51ee-8f89-680180993a41' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1966e898-efa1-51ee-8f89-680180993a41', 'ko', 'canonical', '밀라노 주세페 베르디 교향악단', '밀라노 주세페 베르디 교향악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1966e898-efa1-51ee-8f89-680180993a41' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '1966e898-efa1-51ee-8f89-680180993a41' AS a, 'isni' AS n, '0000000120347827' AS v UNION ALL SELECT '1966e898-efa1-51ee-8f89-680180993a41' AS a, 'musicbrainz_artist' AS n, 'da6cb3d5-c5f6-404d-a3d4-ada5ef8f64ab' AS v UNION ALL SELECT '1966e898-efa1-51ee-8f89-680180993a41' AS a, 'viaf' AS n, '140477406' AS v UNION ALL SELECT '1966e898-efa1-51ee-8f89-680180993a41' AS a, 'wikidata' AS n, 'Q384339' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '밀라노 주세페 베르디 교향악단', 'Orchestra Sinfonica di Milano Giuseppe Verdi', 'orchestra', 'A', '1993', 'Italy', '1966e898-efa1-51ee-8f89-680180993a41', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '1966e898-efa1-51ee-8f89-680180993a41');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '530275c9-dce5-5fa7-a317-c19b31c6485d', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '530275c9-dce5-5fa7-a317-c19b31c6485d');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '530275c9-dce5-5fa7-a317-c19b31c6485d', 'en', 'canonical', 'Bayerisches Staatsorchester', 'bayerisches staatsorchester', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '530275c9-dce5-5fa7-a317-c19b31c6485d' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '530275c9-dce5-5fa7-a317-c19b31c6485d', 'ko', 'canonical', '바이에른 국립관현악단', '바이에른 국립관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '530275c9-dce5-5fa7-a317-c19b31c6485d' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '530275c9-dce5-5fa7-a317-c19b31c6485d' AS a, 'gnd' AS n, '1096431-9' AS v UNION ALL SELECT '530275c9-dce5-5fa7-a317-c19b31c6485d' AS a, 'isni' AS n, '0000000121835902' AS v UNION ALL SELECT '530275c9-dce5-5fa7-a317-c19b31c6485d' AS a, 'musicbrainz_artist' AS n, '315899f2-e6b5-4b73-8830-cc2dceb55eac' AS v UNION ALL SELECT '530275c9-dce5-5fa7-a317-c19b31c6485d' AS a, 'viaf' AS n, '124859009' AS v UNION ALL SELECT '530275c9-dce5-5fa7-a317-c19b31c6485d' AS a, 'wikidata' AS n, 'Q683117' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '바이에른 국립관현악단', 'Bayerisches Staatsorchester', 'orchestra', 'S', '1523', 'Germany', '530275c9-dce5-5fa7-a317-c19b31c6485d', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '530275c9-dce5-5fa7-a317-c19b31c6485d');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '884d89ba-5220-5c4d-b380-c43c9804f619', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '884d89ba-5220-5c4d-b380-c43c9804f619');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '884d89ba-5220-5c4d-b380-c43c9804f619', 'en', 'canonical', 'Ileana Cotrubaș', 'ileana cotrubaș', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '884d89ba-5220-5c4d-b380-c43c9804f619' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '884d89ba-5220-5c4d-b380-c43c9804f619', 'ko', 'canonical', '일레아나 코트루바슈', '일레아나 코트루바슈', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '884d89ba-5220-5c4d-b380-c43c9804f619' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '884d89ba-5220-5c4d-b380-c43c9804f619' AS a, 'gnd' AS n, '120726661' AS v UNION ALL SELECT '884d89ba-5220-5c4d-b380-c43c9804f619' AS a, 'isni' AS n, '0000000114802483' AS v UNION ALL SELECT '884d89ba-5220-5c4d-b380-c43c9804f619' AS a, 'musicbrainz_artist' AS n, '9083ed56-19bc-4e3d-8b3a-c86d41833ebb' AS v UNION ALL SELECT '884d89ba-5220-5c4d-b380-c43c9804f619' AS a, 'viaf' AS n, '113885766' AS v UNION ALL SELECT '884d89ba-5220-5c4d-b380-c43c9804f619' AS a, 'wikidata' AS n, 'Q240098' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '일레아나 코트루바슈', 'Ileana Cotrubaș', 'soprano', 'S', '1939', 'Romania', '884d89ba-5220-5c4d-b380-c43c9804f619', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '884d89ba-5220-5c4d-b380-c43c9804f619');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '4eb92d21-1a88-583a-9e35-b22ada656e70', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '4eb92d21-1a88-583a-9e35-b22ada656e70');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4eb92d21-1a88-583a-9e35-b22ada656e70', 'en', 'canonical', 'Plácido Domingo', 'plácido domingo', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4eb92d21-1a88-583a-9e35-b22ada656e70' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4eb92d21-1a88-583a-9e35-b22ada656e70', 'ko', 'canonical', '플라시도 도밍고', '플라시도 도밍고', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4eb92d21-1a88-583a-9e35-b22ada656e70' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '4eb92d21-1a88-583a-9e35-b22ada656e70' AS a, 'gnd' AS n, '118680242' AS v UNION ALL SELECT '4eb92d21-1a88-583a-9e35-b22ada656e70' AS a, 'isni' AS n, '0000000121447141' AS v UNION ALL SELECT '4eb92d21-1a88-583a-9e35-b22ada656e70' AS a, 'musicbrainz_artist' AS n, '521df2bd-01f6-456e-9d5f-f081068819c2' AS v UNION ALL SELECT '4eb92d21-1a88-583a-9e35-b22ada656e70' AS a, 'viaf' AS n, '97777704' AS v UNION ALL SELECT '4eb92d21-1a88-583a-9e35-b22ada656e70' AS a, 'wikidata' AS n, 'Q130853' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '플라시도 도밍고', 'Plácido Domingo', 'tenor', 'S', '1941', 'Spain', '4eb92d21-1a88-583a-9e35-b22ada656e70', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '4eb92d21-1a88-583a-9e35-b22ada656e70');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '205f773a-dcdf-53e9-9b46-572cf2bd5e11', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '205f773a-dcdf-53e9-9b46-572cf2bd5e11');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '205f773a-dcdf-53e9-9b46-572cf2bd5e11', 'en', 'canonical', 'Tiziana Fabbricini', 'tiziana fabbricini', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '205f773a-dcdf-53e9-9b46-572cf2bd5e11' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '205f773a-dcdf-53e9-9b46-572cf2bd5e11', 'ko', 'canonical', '티치아나 파브리치니', '티치아나 파브리치니', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '205f773a-dcdf-53e9-9b46-572cf2bd5e11' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '205f773a-dcdf-53e9-9b46-572cf2bd5e11' AS a, 'gnd' AS n, '132250977' AS v UNION ALL SELECT '205f773a-dcdf-53e9-9b46-572cf2bd5e11' AS a, 'isni' AS n, '0000000114924368' AS v UNION ALL SELECT '205f773a-dcdf-53e9-9b46-572cf2bd5e11' AS a, 'musicbrainz_artist' AS n, '268c8f31-1d3c-4bff-b9e3-ba88348376be' AS v UNION ALL SELECT '205f773a-dcdf-53e9-9b46-572cf2bd5e11' AS a, 'viaf' AS n, '61743089' AS v UNION ALL SELECT '205f773a-dcdf-53e9-9b46-572cf2bd5e11' AS a, 'wikidata' AS n, 'Q3991977' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '티치아나 파브리치니', 'Tiziana Fabbricini', 'soprano', 'B', '1959', 'Italy', '205f773a-dcdf-53e9-9b46-572cf2bd5e11', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '205f773a-dcdf-53e9-9b46-572cf2bd5e11');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'cdb2378f-8450-56df-bf5e-f3a2dd6d362d', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'cdb2378f-8450-56df-bf5e-f3a2dd6d362d');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cdb2378f-8450-56df-bf5e-f3a2dd6d362d', 'en', 'canonical', 'Roberto Alagna', 'roberto alagna', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cdb2378f-8450-56df-bf5e-f3a2dd6d362d' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cdb2378f-8450-56df-bf5e-f3a2dd6d362d', 'ko', 'canonical', '로베르토 알라냐', '로베르토 알라냐', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cdb2378f-8450-56df-bf5e-f3a2dd6d362d' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'cdb2378f-8450-56df-bf5e-f3a2dd6d362d' AS a, 'gnd' AS n, '132411598' AS v UNION ALL SELECT 'cdb2378f-8450-56df-bf5e-f3a2dd6d362d' AS a, 'isni' AS n, '0000000110208129' AS v UNION ALL SELECT 'cdb2378f-8450-56df-bf5e-f3a2dd6d362d' AS a, 'musicbrainz_artist' AS n, '0459517d-082f-4983-b7eb-5680d3913cb4' AS v UNION ALL SELECT 'cdb2378f-8450-56df-bf5e-f3a2dd6d362d' AS a, 'viaf' AS n, '9829352' AS v UNION ALL SELECT 'cdb2378f-8450-56df-bf5e-f3a2dd6d362d' AS a, 'wikidata' AS n, 'Q267617' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '로베르토 알라냐', 'Roberto Alagna', 'tenor', 'S', '1963', 'France', 'cdb2378f-8450-56df-bf5e-f3a2dd6d362d', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'cdb2378f-8450-56df-bf5e-f3a2dd6d362d');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '093267f7-5299-5126-82e1-3fbae961d5c4', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '093267f7-5299-5126-82e1-3fbae961d5c4');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '093267f7-5299-5126-82e1-3fbae961d5c4', 'en', 'canonical', 'Orchestra of the Royal Opera House', 'orchestra of the royal opera house', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '093267f7-5299-5126-82e1-3fbae961d5c4' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '093267f7-5299-5126-82e1-3fbae961d5c4', 'ko', 'canonical', '로열 오페라하우스 관현악단', '로열 오페라하우스 관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '093267f7-5299-5126-82e1-3fbae961d5c4' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '093267f7-5299-5126-82e1-3fbae961d5c4' AS a, 'gnd' AS n, '802299-9' AS v UNION ALL SELECT '093267f7-5299-5126-82e1-3fbae961d5c4' AS a, 'isni' AS n, '0000000121068002' AS v UNION ALL SELECT '093267f7-5299-5126-82e1-3fbae961d5c4' AS a, 'musicbrainz_artist' AS n, '94d7c0dd-1e8e-4579-807b-8b7c86f57a53' AS v UNION ALL SELECT '093267f7-5299-5126-82e1-3fbae961d5c4' AS a, 'viaf' AS n, '128461560' AS v UNION ALL SELECT '093267f7-5299-5126-82e1-3fbae961d5c4' AS a, 'wikidata' AS n, 'Q11350146' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '로열 오페라하우스 관현악단', 'Orchestra of the Royal Opera House', 'orchestra', 'S', '1946', 'United Kingdom', '093267f7-5299-5126-82e1-3fbae961d5c4', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '093267f7-5299-5126-82e1-3fbae961d5c4');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '7272f34d-5275-571f-90c6-e5b3fc67ab2b', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '7272f34d-5275-571f-90c6-e5b3fc67ab2b');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7272f34d-5275-571f-90c6-e5b3fc67ab2b', 'en', 'canonical', 'Angela Gheorghiu', 'angela gheorghiu', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7272f34d-5275-571f-90c6-e5b3fc67ab2b' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7272f34d-5275-571f-90c6-e5b3fc67ab2b', 'ko', 'canonical', '안젤라 게오르기우', '안젤라 게오르기우', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7272f34d-5275-571f-90c6-e5b3fc67ab2b' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '7272f34d-5275-571f-90c6-e5b3fc67ab2b' AS a, 'gnd' AS n, '132441144' AS v UNION ALL SELECT '7272f34d-5275-571f-90c6-e5b3fc67ab2b' AS a, 'isni' AS n, '000000011439722X' AS v UNION ALL SELECT '7272f34d-5275-571f-90c6-e5b3fc67ab2b' AS a, 'musicbrainz_artist' AS n, '875705c2-152d-4ead-bfb2-16982ab419c3' AS v UNION ALL SELECT '7272f34d-5275-571f-90c6-e5b3fc67ab2b' AS a, 'viaf' AS n, '24583225' AS v UNION ALL SELECT '7272f34d-5275-571f-90c6-e5b3fc67ab2b' AS a, 'wikidata' AS n, 'Q159092' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '안젤라 게오르기우', 'Angela Gheorghiu', 'soprano', 'S', '1965', 'Romania', '7272f34d-5275-571f-90c6-e5b3fc67ab2b', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '7272f34d-5275-571f-90c6-e5b3fc67ab2b');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'cdbd16e5-1eca-5ee8-9085-9137a5f00c13', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'cdbd16e5-1eca-5ee8-9085-9137a5f00c13');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cdbd16e5-1eca-5ee8-9085-9137a5f00c13', 'en', 'canonical', 'Frank Lopardo', 'frank lopardo', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cdbd16e5-1eca-5ee8-9085-9137a5f00c13' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cdbd16e5-1eca-5ee8-9085-9137a5f00c13', 'ko', 'canonical', '프랭크 로파르도', '프랭크 로파르도', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cdbd16e5-1eca-5ee8-9085-9137a5f00c13' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'cdbd16e5-1eca-5ee8-9085-9137a5f00c13' AS a, 'gnd' AS n, '133044823' AS v UNION ALL SELECT 'cdbd16e5-1eca-5ee8-9085-9137a5f00c13' AS a, 'isni' AS n, '0000000114598267' AS v UNION ALL SELECT 'cdbd16e5-1eca-5ee8-9085-9137a5f00c13' AS a, 'musicbrainz_artist' AS n, 'c21143a0-426c-4f70-9e39-4ce2024a5e09' AS v UNION ALL SELECT 'cdbd16e5-1eca-5ee8-9085-9137a5f00c13' AS a, 'viaf' AS n, '12491947' AS v UNION ALL SELECT 'cdbd16e5-1eca-5ee8-9085-9137a5f00c13' AS a, 'wikidata' AS n, 'Q5488007' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '프랭크 로파르도', 'Frank Lopardo', 'tenor', 'A', '1957', 'United States', 'cdbd16e5-1eca-5ee8-9085-9137a5f00c13', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'cdbd16e5-1eca-5ee8-9085-9137a5f00c13');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '029bb6fe-50e3-5417-9932-b1dba6e81387', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '029bb6fe-50e3-5417-9932-b1dba6e81387');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '029bb6fe-50e3-5417-9932-b1dba6e81387', 'en', 'canonical', 'Orchestra dell''Accademia Nazionale di Santa Cecilia', 'orchestra dell''accademia nazionale di santa cecilia', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '029bb6fe-50e3-5417-9932-b1dba6e81387' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '029bb6fe-50e3-5417-9932-b1dba6e81387', 'ko', 'canonical', '산타 체칠리아 국립음악원 관현악단', '산타 체칠리아 국립음악원 관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '029bb6fe-50e3-5417-9932-b1dba6e81387' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '029bb6fe-50e3-5417-9932-b1dba6e81387' AS a, 'gnd' AS n, '1212475-8' AS v UNION ALL SELECT '029bb6fe-50e3-5417-9932-b1dba6e81387' AS a, 'isni' AS n, '0000000119410438' AS v UNION ALL SELECT '029bb6fe-50e3-5417-9932-b1dba6e81387' AS a, 'musicbrainz_artist' AS n, '8a5cda43-8147-474e-95ad-7d97414b69bb' AS v UNION ALL SELECT '029bb6fe-50e3-5417-9932-b1dba6e81387' AS a, 'viaf' AS n, '141907407' AS v UNION ALL SELECT '029bb6fe-50e3-5417-9932-b1dba6e81387' AS a, 'viaf' AS n, '143218147' AS v UNION ALL SELECT '029bb6fe-50e3-5417-9932-b1dba6e81387' AS a, 'wikidata' AS n, 'Q1328398' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '산타 체칠리아 국립음악원 관현악단', 'Orchestra dell''Accademia Nazionale di Santa Cecilia', 'orchestra', 'S', '1908', 'Italy', '029bb6fe-50e3-5417-9932-b1dba6e81387', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '029bb6fe-50e3-5417-9932-b1dba6e81387');

