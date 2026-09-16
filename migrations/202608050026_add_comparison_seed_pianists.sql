-- 비교 영상 시드에 필요한 피아니스트 10명을 추가한다.
--
-- 적재기는 연주자를 external_identifiers.wikidata 로만 해소한다. 이름은 근거가 아니다.
-- S2 를 진행하면서 곡마다 "연주는 멀쩡한데 연주자가 DB 에 없어" 배치를 줄이는 일이
-- 반복돼, 앞으로 쓸 사람을 한 번에 넣는다.
--
-- authority_entities.id 는 파이프라인과 같은 규칙으로 계산했다.
--   uuid5(NAMESPACE_URL, 'classicmap-entity:' || sorted(strong 식별자 'ns:value') join '|')
-- 식별자 집합이 바뀌면 id 도 바뀌므로 Wikidata 에 있는 강한 식별자를 모두 넣는다.
--
-- 안드라스 시프(Q427319)는 이미 artists 208 '안드라시 쉬프'로 있어 제외했다.
--
-- 화면에 나갈 한국어 이름은 국내 표기 관행을 따랐다. Wikidata 한국어 라벨이
-- 헝가리식 어순이거나(시프 언드라시) 관용과 다른 경우가(하티아/카티아) 있다.
-- 국적은 Wikidata 가 소련·중화인민공화국으로 주는 것을 현재 통용 표기로 바꿨다.

-- 파스칼 로제 (Pascal Rogé, Q2525670)
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '1a7008eb-6e3a-5a5d-b501-ad4dda31c0cc', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '1a7008eb-6e3a-5a5d-b501-ad4dda31c0cc'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1a7008eb-6e3a-5a5d-b501-ad4dda31c0cc', 'en', 'canonical', 'Pascal Rogé', 'pascal rogé', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1a7008eb-6e3a-5a5d-b501-ad4dda31c0cc' AND existing.locale = 'en'
      AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1a7008eb-6e3a-5a5d-b501-ad4dda31c0cc', 'ko', 'canonical', '파스칼 로제', '파스칼 로제', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1a7008eb-6e3a-5a5d-b501-ad4dda31c0cc' AND existing.locale = 'ko'
      AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT '1a7008eb-6e3a-5a5d-b501-ad4dda31c0cc' AS a, 'gnd' AS n, '124953999' AS v
    UNION ALL SELECT '1a7008eb-6e3a-5a5d-b501-ad4dda31c0cc', 'isni', '0000000108802268'
    UNION ALL SELECT '1a7008eb-6e3a-5a5d-b501-ad4dda31c0cc', 'musicbrainz_artist', '191df02c-dd85-4197-9f50-4b3ef1486f4e'
    UNION ALL SELECT '1a7008eb-6e3a-5a5d-b501-ad4dda31c0cc', 'viaf', '24788298'
    UNION ALL SELECT '1a7008eb-6e3a-5a5d-b501-ad4dda31c0cc', 'wikidata', 'Q2525670'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '파스칼 로제', 'Pascal Rogé', 'pianist', 'A', '1951', 'France', '1a7008eb-6e3a-5a5d-b501-ad4dda31c0cc', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = '1a7008eb-6e3a-5a5d-b501-ad4dda31c0cc'
);

-- 카티아 부니아티슈빌리 (Khatia Buniatishvili, Q467436)
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '74f34545-f317-518b-a4a7-4d389599fb30', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '74f34545-f317-518b-a4a7-4d389599fb30'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '74f34545-f317-518b-a4a7-4d389599fb30', 'en', 'canonical', 'Khatia Buniatishvili', 'khatia buniatishvili', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '74f34545-f317-518b-a4a7-4d389599fb30' AND existing.locale = 'en'
      AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '74f34545-f317-518b-a4a7-4d389599fb30', 'ko', 'canonical', '카티아 부니아티슈빌리', '카티아 부니아티슈빌리', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '74f34545-f317-518b-a4a7-4d389599fb30' AND existing.locale = 'ko'
      AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT '74f34545-f317-518b-a4a7-4d389599fb30' AS a, 'gnd' AS n, '143635379' AS v
    UNION ALL SELECT '74f34545-f317-518b-a4a7-4d389599fb30', 'isni', '0000000117268191'
    UNION ALL SELECT '74f34545-f317-518b-a4a7-4d389599fb30', 'musicbrainz_artist', 'fce26bb5-6332-4cbe-88c1-0b324301ae10'
    UNION ALL SELECT '74f34545-f317-518b-a4a7-4d389599fb30', 'viaf', '166815724'
    UNION ALL SELECT '74f34545-f317-518b-a4a7-4d389599fb30', 'wikidata', 'Q467436'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '카티아 부니아티슈빌리', 'Khatia Buniatishvili', 'pianist', 'A', '1987', 'Georgia', '74f34545-f317-518b-a4a7-4d389599fb30', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = '74f34545-f317-518b-a4a7-4d389599fb30'
);

-- 니콜라이 루간스키 (Nikolai Lugansky, Q706497)
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '66ab1c1e-bf3e-592c-ab95-8cc9a1fc7fa5', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '66ab1c1e-bf3e-592c-ab95-8cc9a1fc7fa5'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '66ab1c1e-bf3e-592c-ab95-8cc9a1fc7fa5', 'en', 'canonical', 'Nikolai Lugansky', 'nikolai lugansky', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '66ab1c1e-bf3e-592c-ab95-8cc9a1fc7fa5' AND existing.locale = 'en'
      AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '66ab1c1e-bf3e-592c-ab95-8cc9a1fc7fa5', 'ko', 'canonical', '니콜라이 루간스키', '니콜라이 루간스키', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '66ab1c1e-bf3e-592c-ab95-8cc9a1fc7fa5' AND existing.locale = 'ko'
      AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT '66ab1c1e-bf3e-592c-ab95-8cc9a1fc7fa5' AS a, 'gnd' AS n, '129413631' AS v
    UNION ALL SELECT '66ab1c1e-bf3e-592c-ab95-8cc9a1fc7fa5', 'isni', '000000007839723X'
    UNION ALL SELECT '66ab1c1e-bf3e-592c-ab95-8cc9a1fc7fa5', 'musicbrainz_artist', 'cd909fcb-7c80-4988-9b91-930c06d18d27'
    UNION ALL SELECT '66ab1c1e-bf3e-592c-ab95-8cc9a1fc7fa5', 'viaf', '85117484'
    UNION ALL SELECT '66ab1c1e-bf3e-592c-ab95-8cc9a1fc7fa5', 'wikidata', 'Q706497'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '니콜라이 루간스키', 'Nikolai Lugansky', 'pianist', 'A', '1972', 'Russia', '66ab1c1e-bf3e-592c-ab95-8cc9a1fc7fa5', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = '66ab1c1e-bf3e-592c-ab95-8cc9a1fc7fa5'
);

-- 다비드 프레 (David Fray, Q325030)
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '29d7c031-513f-50e1-8c39-63612932696f', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '29d7c031-513f-50e1-8c39-63612932696f'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '29d7c031-513f-50e1-8c39-63612932696f', 'en', 'canonical', 'David Fray', 'david fray', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '29d7c031-513f-50e1-8c39-63612932696f' AND existing.locale = 'en'
      AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '29d7c031-513f-50e1-8c39-63612932696f', 'ko', 'canonical', '다비드 프레', '다비드 프레', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '29d7c031-513f-50e1-8c39-63612932696f' AND existing.locale = 'ko'
      AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT '29d7c031-513f-50e1-8c39-63612932696f' AS a, 'gnd' AS n, '132827506' AS v
    UNION ALL SELECT '29d7c031-513f-50e1-8c39-63612932696f', 'isni', '0000000073700287'
    UNION ALL SELECT '29d7c031-513f-50e1-8c39-63612932696f', 'musicbrainz_artist', '2955be8c-03e6-48e6-b902-e034e307406c'
    UNION ALL SELECT '29d7c031-513f-50e1-8c39-63612932696f', 'viaf', '51980382'
    UNION ALL SELECT '29d7c031-513f-50e1-8c39-63612932696f', 'wikidata', 'Q325030'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '다비드 프레', 'David Fray', 'pianist', 'B', '1981', 'France', '29d7c031-513f-50e1-8c39-63612932696f', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = '29d7c031-513f-50e1-8c39-63612932696f'
);

-- 발렌티나 리시차 (Valentina Lisitsa, Q253233)
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f6319074-b1cc-5f6b-9705-71d7ee650adb', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f6319074-b1cc-5f6b-9705-71d7ee650adb'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f6319074-b1cc-5f6b-9705-71d7ee650adb', 'en', 'canonical', 'Valentina Lisitsa', 'valentina lisitsa', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f6319074-b1cc-5f6b-9705-71d7ee650adb' AND existing.locale = 'en'
      AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f6319074-b1cc-5f6b-9705-71d7ee650adb', 'ko', 'canonical', '발렌티나 리시차', '발렌티나 리시차', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f6319074-b1cc-5f6b-9705-71d7ee650adb' AND existing.locale = 'ko'
      AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT 'f6319074-b1cc-5f6b-9705-71d7ee650adb' AS a, 'gnd' AS n, '1028751168' AS v
    UNION ALL SELECT 'f6319074-b1cc-5f6b-9705-71d7ee650adb', 'isni', '0000000044615868'
    UNION ALL SELECT 'f6319074-b1cc-5f6b-9705-71d7ee650adb', 'musicbrainz_artist', '81c9ae67-9eaf-4e47-836a-62b7bbc91664'
    UNION ALL SELECT 'f6319074-b1cc-5f6b-9705-71d7ee650adb', 'viaf', '66191180'
    UNION ALL SELECT 'f6319074-b1cc-5f6b-9705-71d7ee650adb', 'wikidata', 'Q253233'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '발렌티나 리시차', 'Valentina Lisitsa', 'pianist', 'B', '1970', 'Ukraine', 'f6319074-b1cc-5f6b-9705-71d7ee650adb', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = 'f6319074-b1cc-5f6b-9705-71d7ee650adb'
);

-- 윤디 리 (Yundi Li, Q557244)
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '6f6fa5c8-dcbd-5fce-a945-553be8ef80b2', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '6f6fa5c8-dcbd-5fce-a945-553be8ef80b2'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6f6fa5c8-dcbd-5fce-a945-553be8ef80b2', 'en', 'canonical', 'Yundi Li', 'yundi li', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6f6fa5c8-dcbd-5fce-a945-553be8ef80b2' AND existing.locale = 'en'
      AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6f6fa5c8-dcbd-5fce-a945-553be8ef80b2', 'ko', 'canonical', '윤디 리', '윤디 리', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6f6fa5c8-dcbd-5fce-a945-553be8ef80b2' AND existing.locale = 'ko'
      AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT '6f6fa5c8-dcbd-5fce-a945-553be8ef80b2' AS a, 'gnd' AS n, '135279194' AS v
    UNION ALL SELECT '6f6fa5c8-dcbd-5fce-a945-553be8ef80b2', 'isni', '0000000109218194'
    UNION ALL SELECT '6f6fa5c8-dcbd-5fce-a945-553be8ef80b2', 'musicbrainz_artist', '30112b10-43cc-40bc-a6fc-537f09413eb6'
    UNION ALL SELECT '6f6fa5c8-dcbd-5fce-a945-553be8ef80b2', 'viaf', '85686475'
    UNION ALL SELECT '6f6fa5c8-dcbd-5fce-a945-553be8ef80b2', 'wikidata', 'Q557244'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '윤디 리', 'Yundi Li', 'pianist', 'A', '1982', 'China', '6f6fa5c8-dcbd-5fce-a945-553be8ef80b2', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = '6f6fa5c8-dcbd-5fce-a945-553be8ef80b2'
);

-- 알리스 사라 오트 (Alice Sara Ott, Q76387)
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f90df1fd-a2b2-5e9f-a053-7b40c86994f6', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f90df1fd-a2b2-5e9f-a053-7b40c86994f6'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f90df1fd-a2b2-5e9f-a053-7b40c86994f6', 'en', 'canonical', 'Alice Sara Ott', 'alice sara ott', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f90df1fd-a2b2-5e9f-a053-7b40c86994f6' AND existing.locale = 'en'
      AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f90df1fd-a2b2-5e9f-a053-7b40c86994f6', 'ko', 'canonical', '알리스 사라 오트', '알리스 사라 오트', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f90df1fd-a2b2-5e9f-a053-7b40c86994f6' AND existing.locale = 'ko'
      AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT 'f90df1fd-a2b2-5e9f-a053-7b40c86994f6' AS a, 'gnd' AS n, '134292170' AS v
    UNION ALL SELECT 'f90df1fd-a2b2-5e9f-a053-7b40c86994f6', 'isni', '0000000078537159'
    UNION ALL SELECT 'f90df1fd-a2b2-5e9f-a053-7b40c86994f6', 'musicbrainz_artist', '67fe97e3-3d7b-4b8f-ad14-b753f73e6515'
    UNION ALL SELECT 'f90df1fd-a2b2-5e9f-a053-7b40c86994f6', 'viaf', '60294981'
    UNION ALL SELECT 'f90df1fd-a2b2-5e9f-a053-7b40c86994f6', 'wikidata', 'Q76387'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '알리스 사라 오트', 'Alice Sara Ott', 'pianist', 'A', '1988', 'Germany', 'f90df1fd-a2b2-5e9f-a053-7b40c86994f6', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = 'f90df1fd-a2b2-5e9f-a053-7b40c86994f6'
);

-- 알도 치콜리니 (Aldo Ciccolini, Q2185247)
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '4e2a04e6-fd2c-5edc-a9ac-982f9fe9d2c0', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '4e2a04e6-fd2c-5edc-a9ac-982f9fe9d2c0'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4e2a04e6-fd2c-5edc-a9ac-982f9fe9d2c0', 'en', 'canonical', 'Aldo Ciccolini', 'aldo ciccolini', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4e2a04e6-fd2c-5edc-a9ac-982f9fe9d2c0' AND existing.locale = 'en'
      AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4e2a04e6-fd2c-5edc-a9ac-982f9fe9d2c0', 'ko', 'canonical', '알도 치콜리니', '알도 치콜리니', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4e2a04e6-fd2c-5edc-a9ac-982f9fe9d2c0' AND existing.locale = 'ko'
      AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT '4e2a04e6-fd2c-5edc-a9ac-982f9fe9d2c0' AS a, 'gnd' AS n, '122361067' AS v
    UNION ALL SELECT '4e2a04e6-fd2c-5edc-a9ac-982f9fe9d2c0', 'isni', '0000000108633564'
    UNION ALL SELECT '4e2a04e6-fd2c-5edc-a9ac-982f9fe9d2c0', 'musicbrainz_artist', 'f546711c-dda9-41cc-8bb8-6f7e7ddd71bd'
    UNION ALL SELECT '4e2a04e6-fd2c-5edc-a9ac-982f9fe9d2c0', 'viaf', '2628892'
    UNION ALL SELECT '4e2a04e6-fd2c-5edc-a9ac-982f9fe9d2c0', 'wikidata', 'Q2185247'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '알도 치콜리니', 'Aldo Ciccolini', 'pianist', 'A', '1925', 'France', '4e2a04e6-fd2c-5edc-a9ac-982f9fe9d2c0', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = '4e2a04e6-fd2c-5edc-a9ac-982f9fe9d2c0'
);

-- 메나헴 프레슬러 (Menahem Pressler, Q70142)
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f14a9568-fdf5-5747-8e12-59431869271c', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f14a9568-fdf5-5747-8e12-59431869271c'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f14a9568-fdf5-5747-8e12-59431869271c', 'en', 'canonical', 'Menahem Pressler', 'menahem pressler', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f14a9568-fdf5-5747-8e12-59431869271c' AND existing.locale = 'en'
      AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f14a9568-fdf5-5747-8e12-59431869271c', 'ko', 'canonical', '메나헴 프레슬러', '메나헴 프레슬러', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f14a9568-fdf5-5747-8e12-59431869271c' AND existing.locale = 'ko'
      AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT 'f14a9568-fdf5-5747-8e12-59431869271c' AS a, 'gnd' AS n, '134867645' AS v
    UNION ALL SELECT 'f14a9568-fdf5-5747-8e12-59431869271c', 'isni', '0000000110625002'
    UNION ALL SELECT 'f14a9568-fdf5-5747-8e12-59431869271c', 'musicbrainz_artist', '5fb1ff5b-8807-4d68-9841-3cae57609f1b'
    UNION ALL SELECT 'f14a9568-fdf5-5747-8e12-59431869271c', 'viaf', '51879730'
    UNION ALL SELECT 'f14a9568-fdf5-5747-8e12-59431869271c', 'wikidata', 'Q70142'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '메나헴 프레슬러', 'Menahem Pressler', 'pianist', 'A', '1923', 'United States', 'f14a9568-fdf5-5747-8e12-59431869271c', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = 'f14a9568-fdf5-5747-8e12-59431869271c'
);

-- 올가 셰프스 (Olga Scheps, Q2019718)
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '4205d40c-00c3-5ea8-8ee6-d691501f8dec', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '4205d40c-00c3-5ea8-8ee6-d691501f8dec'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4205d40c-00c3-5ea8-8ee6-d691501f8dec', 'en', 'canonical', 'Olga Scheps', 'olga scheps', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4205d40c-00c3-5ea8-8ee6-d691501f8dec' AND existing.locale = 'en'
      AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4205d40c-00c3-5ea8-8ee6-d691501f8dec', 'ko', 'canonical', '올가 셰프스', '올가 셰프스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4205d40c-00c3-5ea8-8ee6-d691501f8dec' AND existing.locale = 'ko'
      AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT '4205d40c-00c3-5ea8-8ee6-d691501f8dec' AS a, 'gnd' AS n, '138942846' AS v
    UNION ALL SELECT '4205d40c-00c3-5ea8-8ee6-d691501f8dec', 'isni', '0000000371984484'
    UNION ALL SELECT '4205d40c-00c3-5ea8-8ee6-d691501f8dec', 'musicbrainz_artist', '563783f7-f29c-42a1-8bc2-69a0e724b1d2'
    UNION ALL SELECT '4205d40c-00c3-5ea8-8ee6-d691501f8dec', 'viaf', '95550126'
    UNION ALL SELECT '4205d40c-00c3-5ea8-8ee6-d691501f8dec', 'wikidata', 'Q2019718'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '올가 셰프스', 'Olga Scheps', 'pianist', 'B', '1986', 'Germany', '4205d40c-00c3-5ea8-8ee6-d691501f8dec', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = '4205d40c-00c3-5ea8-8ee6-d691501f8dec'
);
