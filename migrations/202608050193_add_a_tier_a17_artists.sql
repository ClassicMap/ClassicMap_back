-- A tier A17 배치에 필요한 인물·단체 11곳을 추가한다.
--
--   바이올린  살바토레 아카르도 · 슈무엘 아슈케나시 · 크리스토프 바라티
--             리사 바티아슈빌리
--   지휘      헤리베르트 에서 · 레너드 슬래트킨 · 오우에 에이지 · 로런스 포스터
--   악단      빈 교향악단 · NDR 방송교향악단 · 런던 필하모닉 오케스트라
--
-- 클라라 슈만 3개의 로망스 1번(178) · 파가니니 바이올린 협주곡 2번 3악장
-- "라 캄파넬라"(165) · 1번 1악장(166)에 쓴다.
--
-- **런던 필하모닉의 VIAF 를 하나 뺐다.** wikidata 항목(Q863397)에 VIAF 가 둘
-- 붙어 있는데(123799938 · 138254801) 뒤엣것은 이미 DB 의 홍콩 필하모닉
-- (Q778725, artist 354)이 갖고 있다. 홍콩 필은 GND·ISNI·MusicBrainz·VIAF 가
-- 모두 한 벌로 맞고 VIAF 가 138254801 하나뿐인데, 런던 필은 VIAF 가 둘이고 그중
-- 123799938 만 단독이다. **wikidata 쪽의 VIAF 합쳐짐(conflation)으로 보고
-- 138254801 을 빼고 123799938 만 쓴다.** 같은 이름꼴("… Philharmonic Orchestra")
-- 단체끼리 VIAF 가 섞이는 것은 흔하다.
--
-- 엔티티 id 는 식별자 집합의 uuid5 이므로 VIAF 를 빼면 값이 바뀐다. 앞선 실패한
-- 적용에서 옛 id(6b54fa48-381d-5ebb-ae67-fe1fa6aeb834)로 authority_entities 와
-- entity_names 가 먼저 들어갔을 수 있어, 아무도 참조하지 않을 때만 지운다.
-- 새 DB 에서는 이 DELETE 가 아무 일도 하지 않는다.
--
-- 빈 교향악단은 wikidata 영어 라벨이 'Vienna Symphony' 다. 배급 표기에 쓰이는
-- 이름은 Wiener Symphoniker 이지만 식별자가 QID 이므로 표기 차이는 문제가 되지
-- 않는다. **빈 필하모닉(Q154685)과 다른 악단이다.**
--
-- 빈 교향악단과 런던 필하모닉은 wikidata 에 나라 진술이 없어 각각 오스트리아·
-- 영국으로 적었다. 아카르도는 P27 이 이탈리아 왕국·이탈리아 둘인데 현재 국가인
-- 이탈리아로 적었다. 오우에·런던 필하모닉·포스터 외에는 한국어 라벨이 없어
-- 한글 이름을 직접 적었다.
--
-- 열하나 다 wikidata 항목이 충실하다(클레임 20~118개).
--
-- 202608050190 과 같은 방식이다.

DELETE FROM entity_names
WHERE authority_entity_id = '6b54fa48-381d-5ebb-ae67-fe1fa6aeb834'
  AND NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) used
                  WHERE used.authority_entity_id = '6b54fa48-381d-5ebb-ae67-fe1fa6aeb834');

DELETE FROM authority_entities
WHERE id = '6b54fa48-381d-5ebb-ae67-fe1fa6aeb834'
  AND NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) used
                  WHERE used.authority_entity_id = '6b54fa48-381d-5ebb-ae67-fe1fa6aeb834')
  AND NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM entity_names) used
                  WHERE used.authority_entity_id = '6b54fa48-381d-5ebb-ae67-fe1fa6aeb834');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'c4591013-6596-5419-9dee-2e196923e1ef', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'c4591013-6596-5419-9dee-2e196923e1ef');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c4591013-6596-5419-9dee-2e196923e1ef', 'en', 'canonical', 'Salvatore Accardo', 'salvatore accardo', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c4591013-6596-5419-9dee-2e196923e1ef' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c4591013-6596-5419-9dee-2e196923e1ef', 'ko', 'canonical', '살바토레 아카르도', '살바토레 아카르도', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c4591013-6596-5419-9dee-2e196923e1ef' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'c4591013-6596-5419-9dee-2e196923e1ef' AS a, 'gnd' AS n, '118853333' AS v UNION ALL SELECT 'c4591013-6596-5419-9dee-2e196923e1ef' AS a, 'isni' AS n, '0000000385044143' AS v UNION ALL SELECT 'c4591013-6596-5419-9dee-2e196923e1ef' AS a, 'musicbrainz_artist' AS n, '77e13fe3-a607-4ede-b94e-fa66d1050797' AS v UNION ALL SELECT 'c4591013-6596-5419-9dee-2e196923e1ef' AS a, 'viaf' AS n, '2895311' AS v UNION ALL SELECT 'c4591013-6596-5419-9dee-2e196923e1ef' AS a, 'wikidata' AS n, 'Q373703' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '살바토레 아카르도', 'Salvatore Accardo', 'violinist', 'A', '1941', 'Italy', 'c4591013-6596-5419-9dee-2e196923e1ef', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'c4591013-6596-5419-9dee-2e196923e1ef');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '7abb9b3b-aa62-5ca2-b5de-8d2cf4bdc2dc', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '7abb9b3b-aa62-5ca2-b5de-8d2cf4bdc2dc');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7abb9b3b-aa62-5ca2-b5de-8d2cf4bdc2dc', 'en', 'canonical', 'Shmuel Ashkenasi', 'shmuel ashkenasi', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7abb9b3b-aa62-5ca2-b5de-8d2cf4bdc2dc' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7abb9b3b-aa62-5ca2-b5de-8d2cf4bdc2dc', 'ko', 'canonical', '슈무엘 아슈케나시', '슈무엘 아슈케나시', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7abb9b3b-aa62-5ca2-b5de-8d2cf4bdc2dc' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '7abb9b3b-aa62-5ca2-b5de-8d2cf4bdc2dc' AS a, 'gnd' AS n, '134632508' AS v UNION ALL SELECT '7abb9b3b-aa62-5ca2-b5de-8d2cf4bdc2dc' AS a, 'isni' AS n, '0000000078391727' AS v UNION ALL SELECT '7abb9b3b-aa62-5ca2-b5de-8d2cf4bdc2dc' AS a, 'musicbrainz_artist' AS n, '397c9d8d-d614-477f-a3cd-6b2fc01da212' AS v UNION ALL SELECT '7abb9b3b-aa62-5ca2-b5de-8d2cf4bdc2dc' AS a, 'viaf' AS n, '27255187' AS v UNION ALL SELECT '7abb9b3b-aa62-5ca2-b5de-8d2cf4bdc2dc' AS a, 'wikidata' AS n, 'Q321539' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '슈무엘 아슈케나시', 'Shmuel Ashkenasi', 'violinist', 'A', '1941', 'Israel', '7abb9b3b-aa62-5ca2-b5de-8d2cf4bdc2dc', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '7abb9b3b-aa62-5ca2-b5de-8d2cf4bdc2dc');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '6dc7ec03-152a-5bd4-aeaa-383a16e388de', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '6dc7ec03-152a-5bd4-aeaa-383a16e388de');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6dc7ec03-152a-5bd4-aeaa-383a16e388de', 'en', 'canonical', 'Kristóf Baráti', 'kristóf baráti', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6dc7ec03-152a-5bd4-aeaa-383a16e388de' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6dc7ec03-152a-5bd4-aeaa-383a16e388de', 'ko', 'canonical', '크리스토프 바라티', '크리스토프 바라티', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6dc7ec03-152a-5bd4-aeaa-383a16e388de' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '6dc7ec03-152a-5bd4-aeaa-383a16e388de' AS a, 'gnd' AS n, '138119783' AS v UNION ALL SELECT '6dc7ec03-152a-5bd4-aeaa-383a16e388de' AS a, 'isni' AS n, '0000000078399657' AS v UNION ALL SELECT '6dc7ec03-152a-5bd4-aeaa-383a16e388de' AS a, 'musicbrainz_artist' AS n, '2a9a5cc6-3aae-4200-80ee-0392ef727aac' AS v UNION ALL SELECT '6dc7ec03-152a-5bd4-aeaa-383a16e388de' AS a, 'viaf' AS n, '2679796' AS v UNION ALL SELECT '6dc7ec03-152a-5bd4-aeaa-383a16e388de' AS a, 'wikidata' AS n, 'Q791092' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '크리스토프 바라티', 'Kristóf Baráti', 'violinist', 'A', '1979', 'Hungary', '6dc7ec03-152a-5bd4-aeaa-383a16e388de', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '6dc7ec03-152a-5bd4-aeaa-383a16e388de');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '990cab6f-f7b5-5ab6-af83-0308f0f7c133', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '990cab6f-f7b5-5ab6-af83-0308f0f7c133');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '990cab6f-f7b5-5ab6-af83-0308f0f7c133', 'en', 'canonical', 'Lisa Batiashvili', 'lisa batiashvili', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '990cab6f-f7b5-5ab6-af83-0308f0f7c133' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '990cab6f-f7b5-5ab6-af83-0308f0f7c133', 'ko', 'canonical', '리사 바티아슈빌리', '리사 바티아슈빌리', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '990cab6f-f7b5-5ab6-af83-0308f0f7c133' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '990cab6f-f7b5-5ab6-af83-0308f0f7c133' AS a, 'gnd' AS n, '129773166' AS v UNION ALL SELECT '990cab6f-f7b5-5ab6-af83-0308f0f7c133' AS a, 'isni' AS n, '0000000120369612' AS v UNION ALL SELECT '990cab6f-f7b5-5ab6-af83-0308f0f7c133' AS a, 'musicbrainz_artist' AS n, '4b0f0c8b-d661-4d1e-96e0-eed0f68ef495' AS v UNION ALL SELECT '990cab6f-f7b5-5ab6-af83-0308f0f7c133' AS a, 'viaf' AS n, '11963087' AS v UNION ALL SELECT '990cab6f-f7b5-5ab6-af83-0308f0f7c133' AS a, 'wikidata' AS n, 'Q271429' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '리사 바티아슈빌리', 'Lisa Batiashvili', 'violinist', 'A', '1979', 'Georgia', '990cab6f-f7b5-5ab6-af83-0308f0f7c133', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '990cab6f-f7b5-5ab6-af83-0308f0f7c133');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '3362ab7d-825f-54e3-9053-34a0411ee6f4', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '3362ab7d-825f-54e3-9053-34a0411ee6f4');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3362ab7d-825f-54e3-9053-34a0411ee6f4', 'en', 'canonical', 'Heribert Esser', 'heribert esser', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3362ab7d-825f-54e3-9053-34a0411ee6f4' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3362ab7d-825f-54e3-9053-34a0411ee6f4', 'ko', 'canonical', '헤리베르트 에서', '헤리베르트 에서', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3362ab7d-825f-54e3-9053-34a0411ee6f4' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '3362ab7d-825f-54e3-9053-34a0411ee6f4' AS a, 'gnd' AS n, '134674049' AS v UNION ALL SELECT '3362ab7d-825f-54e3-9053-34a0411ee6f4' AS a, 'isni' AS n, '0000000055150015' AS v UNION ALL SELECT '3362ab7d-825f-54e3-9053-34a0411ee6f4' AS a, 'viaf' AS n, '69118657' AS v UNION ALL SELECT '3362ab7d-825f-54e3-9053-34a0411ee6f4' AS a, 'wikidata' AS n, 'Q16264579' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '헤리베르트 에서', 'Heribert Esser', 'conductor', 'A', '1929', 'Germany', '3362ab7d-825f-54e3-9053-34a0411ee6f4', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '3362ab7d-825f-54e3-9053-34a0411ee6f4');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '8f34308e-3e98-58b6-8d84-b4a3e4c17e92', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '8f34308e-3e98-58b6-8d84-b4a3e4c17e92');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8f34308e-3e98-58b6-8d84-b4a3e4c17e92', 'en', 'canonical', 'Leonard Slatkin', 'leonard slatkin', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8f34308e-3e98-58b6-8d84-b4a3e4c17e92' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8f34308e-3e98-58b6-8d84-b4a3e4c17e92', 'ko', 'canonical', '레너드 슬래트킨', '레너드 슬래트킨', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8f34308e-3e98-58b6-8d84-b4a3e4c17e92' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '8f34308e-3e98-58b6-8d84-b4a3e4c17e92' AS a, 'gnd' AS n, '134523911' AS v UNION ALL SELECT '8f34308e-3e98-58b6-8d84-b4a3e4c17e92' AS a, 'isni' AS n, '0000000116316913' AS v UNION ALL SELECT '8f34308e-3e98-58b6-8d84-b4a3e4c17e92' AS a, 'musicbrainz_artist' AS n, '97e78ecf-0d07-461f-817d-16765bc9da25' AS v UNION ALL SELECT '8f34308e-3e98-58b6-8d84-b4a3e4c17e92' AS a, 'viaf' AS n, '44486413' AS v UNION ALL SELECT '8f34308e-3e98-58b6-8d84-b4a3e4c17e92' AS a, 'wikidata' AS n, 'Q509870' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '레너드 슬래트킨', 'Leonard Slatkin', 'conductor', 'A', '1944', 'United States', '8f34308e-3e98-58b6-8d84-b4a3e4c17e92', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '8f34308e-3e98-58b6-8d84-b4a3e4c17e92');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'cb8a4aea-7436-5e8c-a59e-88b8456ad1b9', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'cb8a4aea-7436-5e8c-a59e-88b8456ad1b9');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cb8a4aea-7436-5e8c-a59e-88b8456ad1b9', 'en', 'canonical', 'Eiji Oue', 'eiji oue', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cb8a4aea-7436-5e8c-a59e-88b8456ad1b9' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cb8a4aea-7436-5e8c-a59e-88b8456ad1b9', 'ko', 'canonical', '오우에 에이지', '오우에 에이지', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cb8a4aea-7436-5e8c-a59e-88b8456ad1b9' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'cb8a4aea-7436-5e8c-a59e-88b8456ad1b9' AS a, 'gnd' AS n, '13501395X' AS v UNION ALL SELECT 'cb8a4aea-7436-5e8c-a59e-88b8456ad1b9' AS a, 'isni' AS n, '0000000115883510' AS v UNION ALL SELECT 'cb8a4aea-7436-5e8c-a59e-88b8456ad1b9' AS a, 'musicbrainz_artist' AS n, '19caa619-9305-43f2-a7fd-cc0a4f6d8408' AS v UNION ALL SELECT 'cb8a4aea-7436-5e8c-a59e-88b8456ad1b9' AS a, 'viaf' AS n, '5143416' AS v UNION ALL SELECT 'cb8a4aea-7436-5e8c-a59e-88b8456ad1b9' AS a, 'wikidata' AS n, 'Q650184' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '오우에 에이지', 'Eiji Oue', 'conductor', 'A', '1957', 'Japan', 'cb8a4aea-7436-5e8c-a59e-88b8456ad1b9', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'cb8a4aea-7436-5e8c-a59e-88b8456ad1b9');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '24ba2b3c-52ff-5476-8396-01222da73113', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '24ba2b3c-52ff-5476-8396-01222da73113');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '24ba2b3c-52ff-5476-8396-01222da73113', 'en', 'canonical', 'Lawrence Foster', 'lawrence foster', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '24ba2b3c-52ff-5476-8396-01222da73113' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '24ba2b3c-52ff-5476-8396-01222da73113', 'ko', 'canonical', '로런스 포스터', '로런스 포스터', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '24ba2b3c-52ff-5476-8396-01222da73113' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '24ba2b3c-52ff-5476-8396-01222da73113' AS a, 'gnd' AS n, '123689260' AS v UNION ALL SELECT '24ba2b3c-52ff-5476-8396-01222da73113' AS a, 'isni' AS n, '0000000118812208' AS v UNION ALL SELECT '24ba2b3c-52ff-5476-8396-01222da73113' AS a, 'musicbrainz_artist' AS n, '3399965c-b62a-4f53-b4c4-32feeedba876' AS v UNION ALL SELECT '24ba2b3c-52ff-5476-8396-01222da73113' AS a, 'viaf' AS n, '115933141' AS v UNION ALL SELECT '24ba2b3c-52ff-5476-8396-01222da73113' AS a, 'wikidata' AS n, 'Q980815' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '로런스 포스터', 'Lawrence Foster', 'conductor', 'A', '1941', 'United States', '24ba2b3c-52ff-5476-8396-01222da73113', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '24ba2b3c-52ff-5476-8396-01222da73113');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'baecacef-cb3b-54ea-bc3a-02a193a79f6d', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'baecacef-cb3b-54ea-bc3a-02a193a79f6d');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'baecacef-cb3b-54ea-bc3a-02a193a79f6d', 'en', 'canonical', 'Vienna Symphony', 'vienna symphony', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'baecacef-cb3b-54ea-bc3a-02a193a79f6d' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'baecacef-cb3b-54ea-bc3a-02a193a79f6d', 'ko', 'canonical', '빈 교향악단', '빈 교향악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'baecacef-cb3b-54ea-bc3a-02a193a79f6d' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'baecacef-cb3b-54ea-bc3a-02a193a79f6d' AS a, 'gnd' AS n, '2026867-1' AS v UNION ALL SELECT 'baecacef-cb3b-54ea-bc3a-02a193a79f6d' AS a, 'isni' AS n, '0000000121090760' AS v UNION ALL SELECT 'baecacef-cb3b-54ea-bc3a-02a193a79f6d' AS a, 'musicbrainz_artist' AS n, 'fdec141a-f2a7-4b07-9257-8909c294546b' AS v UNION ALL SELECT 'baecacef-cb3b-54ea-bc3a-02a193a79f6d' AS a, 'viaf' AS n, '126591981' AS v UNION ALL SELECT 'baecacef-cb3b-54ea-bc3a-02a193a79f6d' AS a, 'wikidata' AS n, 'Q686887' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '빈 교향악단', 'Vienna Symphony', 'orchestra', 'A', '1900', 'Austria', 'baecacef-cb3b-54ea-bc3a-02a193a79f6d', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'baecacef-cb3b-54ea-bc3a-02a193a79f6d');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '5602625f-c41c-58ce-9d0d-e5891a0049fb', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '5602625f-c41c-58ce-9d0d-e5891a0049fb');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5602625f-c41c-58ce-9d0d-e5891a0049fb', 'en', 'canonical', 'NDR Radiophilharmonie', 'ndr radiophilharmonie', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5602625f-c41c-58ce-9d0d-e5891a0049fb' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5602625f-c41c-58ce-9d0d-e5891a0049fb', 'ko', 'canonical', 'NDR 방송교향악단', 'ndr 방송교향악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5602625f-c41c-58ce-9d0d-e5891a0049fb' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '5602625f-c41c-58ce-9d0d-e5891a0049fb' AS a, 'gnd' AS n, '1244780-8' AS v UNION ALL SELECT '5602625f-c41c-58ce-9d0d-e5891a0049fb' AS a, 'isni' AS n, '0000000109435412' AS v UNION ALL SELECT '5602625f-c41c-58ce-9d0d-e5891a0049fb' AS a, 'musicbrainz_artist' AS n, '542c12a0-b304-47cf-b09f-23f27228ae4d' AS v UNION ALL SELECT '5602625f-c41c-58ce-9d0d-e5891a0049fb' AS a, 'viaf' AS n, '139750985' AS v UNION ALL SELECT '5602625f-c41c-58ce-9d0d-e5891a0049fb' AS a, 'wikidata' AS n, 'Q830510' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT 'NDR 방송교향악단', 'NDR Radiophilharmonie', 'orchestra', 'A', '1950', 'Germany', '5602625f-c41c-58ce-9d0d-e5891a0049fb', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '5602625f-c41c-58ce-9d0d-e5891a0049fb');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'c4e77dfc-fbed-5d17-9dd7-62a93529ee39', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'c4e77dfc-fbed-5d17-9dd7-62a93529ee39');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c4e77dfc-fbed-5d17-9dd7-62a93529ee39', 'en', 'canonical', 'London Philharmonic Orchestra', 'london philharmonic orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c4e77dfc-fbed-5d17-9dd7-62a93529ee39' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c4e77dfc-fbed-5d17-9dd7-62a93529ee39', 'ko', 'canonical', '런던 필하모닉 오케스트라', '런던 필하모닉 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c4e77dfc-fbed-5d17-9dd7-62a93529ee39' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'c4e77dfc-fbed-5d17-9dd7-62a93529ee39' AS a, 'gnd' AS n, '1092710-4' AS v UNION ALL SELECT 'c4e77dfc-fbed-5d17-9dd7-62a93529ee39' AS a, 'isni' AS n, '0000000121677377' AS v UNION ALL SELECT 'c4e77dfc-fbed-5d17-9dd7-62a93529ee39' AS a, 'musicbrainz_artist' AS n, 'fa37018e-3557-4cb7-973f-555003c30174' AS v UNION ALL SELECT 'c4e77dfc-fbed-5d17-9dd7-62a93529ee39' AS a, 'viaf' AS n, '123799938' AS v UNION ALL SELECT 'c4e77dfc-fbed-5d17-9dd7-62a93529ee39' AS a, 'wikidata' AS n, 'Q863397' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '런던 필하모닉 오케스트라', 'London Philharmonic Orchestra', 'orchestra', 'A', '1932', 'United Kingdom', 'c4e77dfc-fbed-5d17-9dd7-62a93529ee39', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'c4e77dfc-fbed-5d17-9dd7-62a93529ee39');

