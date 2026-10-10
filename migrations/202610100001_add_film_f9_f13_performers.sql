-- 영화 속 클래식 9~13차(film-f9~f13) 연주에 필요한 지휘자·악단·가수 27명을 등록한다.
--
-- 9~13차는 2026-10-07 카탈로그에 넣은 작품(202610070005)과 오디오 정렬로 찾은 대목의 새 구간이다.
-- 고른 연주의 크레딧(대표·지휘자·악단·합창단·가수) 102개 가운데 아래 27개가 artists 에 없다.
--
--   칸타타 BWV 82 「Ich habe genug」(박쥐): 카를 리히터 · 뮌헨 바흐 오케스트라, 로저 노링턴 · 카메라타 잘츠부르크, 하노 뮐러브라흐만
--   BWV 106 소나티나(포핸즈): 구스타프 레온하르트 · 레온하르트 콘소트, 콘라트 융해넬 · 칸투스 쾰른
--   「솔베이그의 노래」(하모니): 예테보리 심포니 오케스트라, 에사페카 살로넨, 카밀라 틸링, 에스토니아 국립 교향악단
--   「요정의 정원」(SKY 캐슬): 로테르담 필하모닉 오케스트라
--   돈 조반니 기사장 장면(아마데우스): 토머스 앨런, 로버트 로이드, 새뮤얼 레이미, 파아타 부르출라제, 마티 살미넨
--   베누스베르크 음악(오페라가 뭐예요, 박사님?): 베를린 슈타츠카펠레, 프란츠 콘비츠니
--   말러 3번 4악장(베니스에서의 죽음): 크리스타 루트비히, 안네 소피 폰 오터
--   죽음의 무도(포핸즈): 레오폴드 스토코프스키
--   「Una voce poco fa」(펜트하우스): 체칠리아 바르톨리, 주세페 파타네, 아그네스 발차
--
-- 등록 확인 세 단계(05-pitfalls.md): 26명은 wikidata·gnd·isni·musicbrainz·viaf·lccn 어디로도
-- artists·external_identifiers 에 걸리는 것이 없어 엔티티부터 만든다(id 는 식별자 집합의 uuid5, 202610070001 과 같은 규칙).
-- 구스타프 레온하르트는 국제 시드가 작곡가(composers 361)로 만든 엔티티(6a49d18e-…)가 있어
-- 그 엔티티에 빠진 lccn 과 artists 행만 더한다. 작곡가 겸 연주자가 엔티티를 함께 쓰는 선례가 있다(두다멜, 이반 피셔).
-- 이름으로 겹치는 artists 행은 없다. 베이스는 분류 코드가 없어 '목소리'(성악가)로 둔다.

-- 카를 리히터 (Karl Richter, Q76735) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '7e7acd33-ddde-55d5-9bfe-e927773d6024', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '7e7acd33-ddde-55d5-9bfe-e927773d6024');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7e7acd33-ddde-55d5-9bfe-e927773d6024', 'en', 'canonical', 'Karl Richter', 'karl richter', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7e7acd33-ddde-55d5-9bfe-e927773d6024' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7e7acd33-ddde-55d5-9bfe-e927773d6024', 'ko', 'canonical', '카를 리히터', '카를 리히터', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7e7acd33-ddde-55d5-9bfe-e927773d6024' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '7e7acd33-ddde-55d5-9bfe-e927773d6024' AS a, 'gnd' AS n, '123094801' AS v UNION ALL SELECT '7e7acd33-ddde-55d5-9bfe-e927773d6024' AS a, 'isni' AS n, '0000000108823501' AS v UNION ALL SELECT '7e7acd33-ddde-55d5-9bfe-e927773d6024' AS a, 'lccn' AS n, 'n80102226' AS v UNION ALL SELECT '7e7acd33-ddde-55d5-9bfe-e927773d6024' AS a, 'musicbrainz_artist' AS n, 'e01ebec7-98c5-450a-bf67-5650f8b4eff0' AS v UNION ALL SELECT '7e7acd33-ddde-55d5-9bfe-e927773d6024' AS a, 'viaf' AS n, '27252947' AS v UNION ALL SELECT '7e7acd33-ddde-55d5-9bfe-e927773d6024' AS a, 'wikidata' AS n, 'Q76735' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '카를 리히터', 'Karl Richter', 'conductor', 'A', '1926', 'Germany', '7e7acd33-ddde-55d5-9bfe-e927773d6024', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '7e7acd33-ddde-55d5-9bfe-e927773d6024');

-- 뮌헨 바흐 오케스트라 (Münchener Bach-Orchester, Q106764138) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '6cdb7f9a-06ce-5ae5-b3bf-0b53f787fc42', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '6cdb7f9a-06ce-5ae5-b3bf-0b53f787fc42');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6cdb7f9a-06ce-5ae5-b3bf-0b53f787fc42', 'en', 'canonical', 'Münchener Bach-Orchester', 'münchener bach-orchester', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6cdb7f9a-06ce-5ae5-b3bf-0b53f787fc42' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6cdb7f9a-06ce-5ae5-b3bf-0b53f787fc42', 'ko', 'canonical', '뮌헨 바흐 오케스트라', '뮌헨 바흐 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6cdb7f9a-06ce-5ae5-b3bf-0b53f787fc42' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '6cdb7f9a-06ce-5ae5-b3bf-0b53f787fc42' AS a, 'musicbrainz_artist' AS n, '0b03ac9e-6647-4fe7-9924-d18f7b2643ee' AS v UNION ALL SELECT '6cdb7f9a-06ce-5ae5-b3bf-0b53f787fc42' AS a, 'viaf' AS n, '133369228' AS v UNION ALL SELECT '6cdb7f9a-06ce-5ae5-b3bf-0b53f787fc42' AS a, 'wikidata' AS n, 'Q106764138' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '뮌헨 바흐 오케스트라', 'Münchener Bach-Orchester', 'orchestra', 'B', '1954', 'Germany', '6cdb7f9a-06ce-5ae5-b3bf-0b53f787fc42', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '6cdb7f9a-06ce-5ae5-b3bf-0b53f787fc42');

-- 로저 노링턴 (Roger Norrington, Q537083) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '14328287-223b-5081-b7c4-711944f9e3ca', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '14328287-223b-5081-b7c4-711944f9e3ca');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '14328287-223b-5081-b7c4-711944f9e3ca', 'en', 'canonical', 'Roger Norrington', 'roger norrington', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '14328287-223b-5081-b7c4-711944f9e3ca' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '14328287-223b-5081-b7c4-711944f9e3ca', 'ko', 'canonical', '로저 노링턴', '로저 노링턴', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '14328287-223b-5081-b7c4-711944f9e3ca' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '14328287-223b-5081-b7c4-711944f9e3ca' AS a, 'gnd' AS n, '124259227' AS v UNION ALL SELECT '14328287-223b-5081-b7c4-711944f9e3ca' AS a, 'isni' AS n, '0000000114802643' AS v UNION ALL SELECT '14328287-223b-5081-b7c4-711944f9e3ca' AS a, 'lccn' AS n, 'n81127865' AS v UNION ALL SELECT '14328287-223b-5081-b7c4-711944f9e3ca' AS a, 'musicbrainz_artist' AS n, '2403f8c6-8ccc-48d6-977f-de0baa2d6fed' AS v UNION ALL SELECT '14328287-223b-5081-b7c4-711944f9e3ca' AS a, 'viaf' AS n, '114144996' AS v UNION ALL SELECT '14328287-223b-5081-b7c4-711944f9e3ca' AS a, 'wikidata' AS n, 'Q537083' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '로저 노링턴', 'Roger Norrington', 'conductor', 'A', '1934', 'United Kingdom', '14328287-223b-5081-b7c4-711944f9e3ca', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '14328287-223b-5081-b7c4-711944f9e3ca');

-- 카메라타 잘츠부르크 (Camerata Salzburg, Q392430) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '537d880d-3535-514c-b51e-f477b3e911fe', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '537d880d-3535-514c-b51e-f477b3e911fe');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '537d880d-3535-514c-b51e-f477b3e911fe', 'en', 'canonical', 'Camerata Salzburg', 'camerata salzburg', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '537d880d-3535-514c-b51e-f477b3e911fe' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '537d880d-3535-514c-b51e-f477b3e911fe', 'ko', 'canonical', '카메라타 잘츠부르크', '카메라타 잘츠부르크', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '537d880d-3535-514c-b51e-f477b3e911fe' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '537d880d-3535-514c-b51e-f477b3e911fe' AS a, 'gnd' AS n, '10115929-8' AS v UNION ALL SELECT '537d880d-3535-514c-b51e-f477b3e911fe' AS a, 'isni' AS n, '0000000110928740' AS v UNION ALL SELECT '537d880d-3535-514c-b51e-f477b3e911fe' AS a, 'lccn' AS n, 'n81070862' AS v UNION ALL SELECT '537d880d-3535-514c-b51e-f477b3e911fe' AS a, 'musicbrainz_artist' AS n, 'f83945a5-1612-4eb3-b529-5236c6e6755e' AS v UNION ALL SELECT '537d880d-3535-514c-b51e-f477b3e911fe' AS a, 'viaf' AS n, '142385005' AS v UNION ALL SELECT '537d880d-3535-514c-b51e-f477b3e911fe' AS a, 'wikidata' AS n, 'Q392430' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '카메라타 잘츠부르크', 'Camerata Salzburg', 'orchestra', 'B', '1952', 'Austria', '537d880d-3535-514c-b51e-f477b3e911fe', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '537d880d-3535-514c-b51e-f477b3e911fe');

-- 하노 뮐러브라흐만 (Hanno Müller-Brachmann, Q119296) · bass-baritone

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '40c6b47a-81f0-57fc-979d-e5a863c4d866', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '40c6b47a-81f0-57fc-979d-e5a863c4d866');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '40c6b47a-81f0-57fc-979d-e5a863c4d866', 'en', 'canonical', 'Hanno Müller-Brachmann', 'hanno müller-brachmann', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '40c6b47a-81f0-57fc-979d-e5a863c4d866' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '40c6b47a-81f0-57fc-979d-e5a863c4d866', 'ko', 'canonical', '하노 뮐러브라흐만', '하노 뮐러브라흐만', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '40c6b47a-81f0-57fc-979d-e5a863c4d866' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '40c6b47a-81f0-57fc-979d-e5a863c4d866' AS a, 'gnd' AS n, '123789184' AS v UNION ALL SELECT '40c6b47a-81f0-57fc-979d-e5a863c4d866' AS a, 'isni' AS n, '0000000055162382' AS v UNION ALL SELECT '40c6b47a-81f0-57fc-979d-e5a863c4d866' AS a, 'lccn' AS n, 'n00066442' AS v UNION ALL SELECT '40c6b47a-81f0-57fc-979d-e5a863c4d866' AS a, 'musicbrainz_artist' AS n, '2dd0c97a-3f3f-4ff9-b92a-f2a4405bca19' AS v UNION ALL SELECT '40c6b47a-81f0-57fc-979d-e5a863c4d866' AS a, 'viaf' AS n, '62463961' AS v UNION ALL SELECT '40c6b47a-81f0-57fc-979d-e5a863c4d866' AS a, 'wikidata' AS n, 'Q119296' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '하노 뮐러브라흐만', 'Hanno Müller-Brachmann', 'bass-baritone', 'B', '1970', 'Germany', '40c6b47a-81f0-57fc-979d-e5a863c4d866', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '40c6b47a-81f0-57fc-979d-e5a863c4d866');

-- 구스타프 레온하르트 (Gustav Leonhardt, Q51584) · conductor

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6a49d18e-6661-5806-9f10-87a2ad7f6921', 'en', 'canonical', 'Gustav Leonhardt', 'gustav leonhardt', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6a49d18e-6661-5806-9f10-87a2ad7f6921' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '6a49d18e-6661-5806-9f10-87a2ad7f6921', 'ko', 'canonical', '구스타프 레온하르트', '구스타프 레온하르트', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '6a49d18e-6661-5806-9f10-87a2ad7f6921' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '6a49d18e-6661-5806-9f10-87a2ad7f6921' AS a, 'gnd' AS n, '124708692' AS v UNION ALL SELECT '6a49d18e-6661-5806-9f10-87a2ad7f6921' AS a, 'isni' AS n, '0000000109371981' AS v UNION ALL SELECT '6a49d18e-6661-5806-9f10-87a2ad7f6921' AS a, 'lccn' AS n, 'n79110146' AS v UNION ALL SELECT '6a49d18e-6661-5806-9f10-87a2ad7f6921' AS a, 'musicbrainz_artist' AS n, '27b0750a-7318-4075-9470-43b82d454ea0' AS v UNION ALL SELECT '6a49d18e-6661-5806-9f10-87a2ad7f6921' AS a, 'viaf' AS n, '113475647' AS v UNION ALL SELECT '6a49d18e-6661-5806-9f10-87a2ad7f6921' AS a, 'wikidata' AS n, 'Q51584' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '구스타프 레온하르트', 'Gustav Leonhardt', 'conductor', 'A', '1928', 'Netherlands', '6a49d18e-6661-5806-9f10-87a2ad7f6921', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '6a49d18e-6661-5806-9f10-87a2ad7f6921');

-- 레온하르트 콘소트 (Leonhardt-Consort, Q340088) · ensemble

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '56db4f7f-3e0f-5e92-963d-b44e20035cf0', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '56db4f7f-3e0f-5e92-963d-b44e20035cf0');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '56db4f7f-3e0f-5e92-963d-b44e20035cf0', 'en', 'canonical', 'Leonhardt-Consort', 'leonhardt-consort', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '56db4f7f-3e0f-5e92-963d-b44e20035cf0' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '56db4f7f-3e0f-5e92-963d-b44e20035cf0', 'ko', 'canonical', '레온하르트 콘소트', '레온하르트 콘소트', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '56db4f7f-3e0f-5e92-963d-b44e20035cf0' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '56db4f7f-3e0f-5e92-963d-b44e20035cf0' AS a, 'gnd' AS n, '5122679-0' AS v UNION ALL SELECT '56db4f7f-3e0f-5e92-963d-b44e20035cf0' AS a, 'isni' AS n, '0000000109398738' AS v UNION ALL SELECT '56db4f7f-3e0f-5e92-963d-b44e20035cf0' AS a, 'lccn' AS n, 'n85067603' AS v UNION ALL SELECT '56db4f7f-3e0f-5e92-963d-b44e20035cf0' AS a, 'musicbrainz_artist' AS n, 'fdcb74c4-2c5f-4d57-a052-b9ae935a3302' AS v UNION ALL SELECT '56db4f7f-3e0f-5e92-963d-b44e20035cf0' AS a, 'viaf' AS n, '121015026' AS v UNION ALL SELECT '56db4f7f-3e0f-5e92-963d-b44e20035cf0' AS a, 'wikidata' AS n, 'Q340088' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '레온하르트 콘소트', 'Leonhardt-Consort', 'ensemble', 'B', '1955', 'Netherlands', '56db4f7f-3e0f-5e92-963d-b44e20035cf0', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '56db4f7f-3e0f-5e92-963d-b44e20035cf0');

-- 콘라트 융해넬 (Konrad Junghänel, Q1782141) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '85eb3103-cc25-5323-9ca7-4f5af6e65fdb', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '85eb3103-cc25-5323-9ca7-4f5af6e65fdb');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '85eb3103-cc25-5323-9ca7-4f5af6e65fdb', 'en', 'canonical', 'Konrad Junghänel', 'konrad junghänel', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '85eb3103-cc25-5323-9ca7-4f5af6e65fdb' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '85eb3103-cc25-5323-9ca7-4f5af6e65fdb', 'ko', 'canonical', '콘라트 융해넬', '콘라트 융해넬', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '85eb3103-cc25-5323-9ca7-4f5af6e65fdb' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '85eb3103-cc25-5323-9ca7-4f5af6e65fdb' AS a, 'gnd' AS n, '128579013' AS v UNION ALL SELECT '85eb3103-cc25-5323-9ca7-4f5af6e65fdb' AS a, 'isni' AS n, '0000000063092492' AS v UNION ALL SELECT '85eb3103-cc25-5323-9ca7-4f5af6e65fdb' AS a, 'lccn' AS n, 'n80057645' AS v UNION ALL SELECT '85eb3103-cc25-5323-9ca7-4f5af6e65fdb' AS a, 'musicbrainz_artist' AS n, 'a7a2487a-8721-4fa7-ab60-8a55a2184f54' AS v UNION ALL SELECT '85eb3103-cc25-5323-9ca7-4f5af6e65fdb' AS a, 'viaf' AS n, '24787548' AS v UNION ALL SELECT '85eb3103-cc25-5323-9ca7-4f5af6e65fdb' AS a, 'wikidata' AS n, 'Q1782141' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '콘라트 융해넬', 'Konrad Junghänel', 'conductor', 'B', '1953', 'Germany', '85eb3103-cc25-5323-9ca7-4f5af6e65fdb', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '85eb3103-cc25-5323-9ca7-4f5af6e65fdb');

-- 칸투스 쾰른 (Cantus Cölln, Q877640) · ensemble

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b5e3f215-2c0e-5e39-9850-c9c9deffb331', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b5e3f215-2c0e-5e39-9850-c9c9deffb331');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b5e3f215-2c0e-5e39-9850-c9c9deffb331', 'en', 'canonical', 'Cantus Cölln', 'cantus cölln', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b5e3f215-2c0e-5e39-9850-c9c9deffb331' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b5e3f215-2c0e-5e39-9850-c9c9deffb331', 'ko', 'canonical', '칸투스 쾰른', '칸투스 쾰른', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b5e3f215-2c0e-5e39-9850-c9c9deffb331' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b5e3f215-2c0e-5e39-9850-c9c9deffb331' AS a, 'gnd' AS n, '5070892-2' AS v UNION ALL SELECT 'b5e3f215-2c0e-5e39-9850-c9c9deffb331' AS a, 'isni' AS n, '0000000109407219' AS v UNION ALL SELECT 'b5e3f215-2c0e-5e39-9850-c9c9deffb331' AS a, 'lccn' AS n, 'n91025712' AS v UNION ALL SELECT 'b5e3f215-2c0e-5e39-9850-c9c9deffb331' AS a, 'musicbrainz_artist' AS n, 'dae66f74-3955-4548-8369-b3182e759f16' AS v UNION ALL SELECT 'b5e3f215-2c0e-5e39-9850-c9c9deffb331' AS a, 'viaf' AS n, '124826742' AS v UNION ALL SELECT 'b5e3f215-2c0e-5e39-9850-c9c9deffb331' AS a, 'wikidata' AS n, 'Q877640' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '칸투스 쾰른', 'Cantus Cölln', 'ensemble', 'B', '1987', 'Germany', 'b5e3f215-2c0e-5e39-9850-c9c9deffb331', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'b5e3f215-2c0e-5e39-9850-c9c9deffb331');

-- 예테보리 심포니 오케스트라 (Gothenburg Symphony Orchestra, Q1526031) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'd63ab678-9742-5137-84fe-9d630a30a4d5', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'd63ab678-9742-5137-84fe-9d630a30a4d5');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd63ab678-9742-5137-84fe-9d630a30a4d5', 'en', 'canonical', 'Gothenburg Symphony Orchestra', 'gothenburg symphony orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd63ab678-9742-5137-84fe-9d630a30a4d5' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd63ab678-9742-5137-84fe-9d630a30a4d5', 'ko', 'canonical', '예테보리 심포니 오케스트라', '예테보리 심포니 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd63ab678-9742-5137-84fe-9d630a30a4d5' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'd63ab678-9742-5137-84fe-9d630a30a4d5' AS a, 'gnd' AS n, '1096573-7' AS v UNION ALL SELECT 'd63ab678-9742-5137-84fe-9d630a30a4d5' AS a, 'isni' AS n, '0000000120341097' AS v UNION ALL SELECT 'd63ab678-9742-5137-84fe-9d630a30a4d5' AS a, 'lccn' AS n, 'n81035841' AS v UNION ALL SELECT 'd63ab678-9742-5137-84fe-9d630a30a4d5' AS a, 'musicbrainz_artist' AS n, '4b3f7f35-12a4-4fca-bf23-81b10e860c78' AS v UNION ALL SELECT 'd63ab678-9742-5137-84fe-9d630a30a4d5' AS a, 'viaf' AS n, '133842275' AS v UNION ALL SELECT 'd63ab678-9742-5137-84fe-9d630a30a4d5' AS a, 'wikidata' AS n, 'Q1526031' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '예테보리 심포니 오케스트라', 'Gothenburg Symphony Orchestra', 'orchestra', 'B', '1905', 'Sweden', 'd63ab678-9742-5137-84fe-9d630a30a4d5', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'd63ab678-9742-5137-84fe-9d630a30a4d5');

-- 에사페카 살로넨 (Esa-Pekka Salonen, Q314587) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265', 'en', 'canonical', 'Esa-Pekka Salonen', 'esa-pekka salonen', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265', 'ko', 'canonical', '에사페카 살로넨', '에사페카 살로넨', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265' AS a, 'gnd' AS n, '118874934' AS v UNION ALL SELECT '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265' AS a, 'isni' AS n, '0000000114732673' AS v UNION ALL SELECT '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265' AS a, 'lccn' AS n, 'n85237381' AS v UNION ALL SELECT '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265' AS a, 'musicbrainz_artist' AS n, '66b01c9c-3344-46b1-b5fe-cab3c2834e32' AS v UNION ALL SELECT '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265' AS a, 'viaf' AS n, '59063039' AS v UNION ALL SELECT '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265' AS a, 'wikidata' AS n, 'Q314587' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '에사페카 살로넨', 'Esa-Pekka Salonen', 'conductor', 'A', '1958', 'Finland', '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '38c09bbd-2e7d-5f7a-9e34-cb8616ae1265');

-- 카밀라 틸링 (Camilla Tilling, Q4457269) · soprano

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9', 'en', 'canonical', 'Camilla Tilling', 'camilla tilling', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9', 'ko', 'canonical', '카밀라 틸링', '카밀라 틸링', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9' AS a, 'gnd' AS n, '13523803X' AS v UNION ALL SELECT '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9' AS a, 'isni' AS n, '0000000108902816' AS v UNION ALL SELECT '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9' AS a, 'lccn' AS n, 'no2002090012' AS v UNION ALL SELECT '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9' AS a, 'musicbrainz_artist' AS n, 'c877e315-56ae-42b7-8e83-c73129aff4f8' AS v UNION ALL SELECT '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9' AS a, 'viaf' AS n, '39588718' AS v UNION ALL SELECT '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9' AS a, 'wikidata' AS n, 'Q4457269' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '카밀라 틸링', 'Camilla Tilling', 'soprano', 'B', '1971', 'Sweden', '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '2942c5a6-8341-5eb2-9c77-2d9bcd9e4ab9');

-- 에스토니아 국립 교향악단 (Estonian National Symphony Orchestra, Q1295657) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f44c00c9-a2c4-545b-8bed-a2c74bafe684', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f44c00c9-a2c4-545b-8bed-a2c74bafe684');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f44c00c9-a2c4-545b-8bed-a2c74bafe684', 'en', 'canonical', 'Estonian National Symphony Orchestra', 'estonian national symphony orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f44c00c9-a2c4-545b-8bed-a2c74bafe684' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f44c00c9-a2c4-545b-8bed-a2c74bafe684', 'ko', 'canonical', '에스토니아 국립 교향악단', '에스토니아 국립 교향악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f44c00c9-a2c4-545b-8bed-a2c74bafe684' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'f44c00c9-a2c4-545b-8bed-a2c74bafe684' AS a, 'gnd' AS n, '5288269-X' AS v UNION ALL SELECT 'f44c00c9-a2c4-545b-8bed-a2c74bafe684' AS a, 'isni' AS n, '0000000123481335' AS v UNION ALL SELECT 'f44c00c9-a2c4-545b-8bed-a2c74bafe684' AS a, 'lccn' AS n, 'n96036059' AS v UNION ALL SELECT 'f44c00c9-a2c4-545b-8bed-a2c74bafe684' AS a, 'musicbrainz_artist' AS n, '14648195-8584-4254-818c-b8c77e70e8aa' AS v UNION ALL SELECT 'f44c00c9-a2c4-545b-8bed-a2c74bafe684' AS a, 'viaf' AS n, '142471402' AS v UNION ALL SELECT 'f44c00c9-a2c4-545b-8bed-a2c74bafe684' AS a, 'wikidata' AS n, 'Q1295657' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '에스토니아 국립 교향악단', 'Estonian National Symphony Orchestra', 'orchestra', 'B', '1926', 'Estonia', 'f44c00c9-a2c4-545b-8bed-a2c74bafe684', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'f44c00c9-a2c4-545b-8bed-a2c74bafe684');

-- 로테르담 필하모닉 오케스트라 (Rotterdam Philharmonic Orchestra, Q2270779) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '09541000-aace-5e86-ba60-9f19af16772c', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '09541000-aace-5e86-ba60-9f19af16772c');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '09541000-aace-5e86-ba60-9f19af16772c', 'en', 'canonical', 'Rotterdam Philharmonic Orchestra', 'rotterdam philharmonic orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '09541000-aace-5e86-ba60-9f19af16772c' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '09541000-aace-5e86-ba60-9f19af16772c', 'ko', 'canonical', '로테르담 필하모닉 오케스트라', '로테르담 필하모닉 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '09541000-aace-5e86-ba60-9f19af16772c' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '09541000-aace-5e86-ba60-9f19af16772c' AS a, 'gnd' AS n, '3006832-0' AS v UNION ALL SELECT '09541000-aace-5e86-ba60-9f19af16772c' AS a, 'isni' AS n, '0000000092125089' AS v UNION ALL SELECT '09541000-aace-5e86-ba60-9f19af16772c' AS a, 'lccn' AS n, 'n81081318' AS v UNION ALL SELECT '09541000-aace-5e86-ba60-9f19af16772c' AS a, 'musicbrainz_artist' AS n, 'c5958778-9c97-4970-9e63-0072ab2c4189' AS v UNION ALL SELECT '09541000-aace-5e86-ba60-9f19af16772c' AS a, 'viaf' AS n, '135012026' AS v UNION ALL SELECT '09541000-aace-5e86-ba60-9f19af16772c' AS a, 'wikidata' AS n, 'Q2270779' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '로테르담 필하모닉 오케스트라', 'Rotterdam Philharmonic Orchestra', 'orchestra', 'B', '1918', 'Netherlands', '09541000-aace-5e86-ba60-9f19af16772c', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '09541000-aace-5e86-ba60-9f19af16772c');

-- 토머스 앨런 (Thomas Allen, Q953628) · baritone

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0', 'en', 'canonical', 'Thomas Allen', 'thomas allen', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0', 'ko', 'canonical', '토머스 앨런', '토머스 앨런', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0' AS a, 'gnd' AS n, '119198665' AS v UNION ALL SELECT '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0' AS a, 'gnd' AS n, '1326936336' AS v UNION ALL SELECT '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0' AS a, 'isni' AS n, '0000000110633483' AS v UNION ALL SELECT '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0' AS a, 'lccn' AS n, 'n82048938' AS v UNION ALL SELECT '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0' AS a, 'musicbrainz_artist' AS n, '9483f10d-06c1-425f-bfa0-2ba0911e5853' AS v UNION ALL SELECT '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0' AS a, 'viaf' AS n, '54331491' AS v UNION ALL SELECT '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0' AS a, 'wikidata' AS n, 'Q953628' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '토머스 앨런', 'Thomas Allen', 'baritone', 'B', '1944', 'United Kingdom', '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '5ea88f42-ffd0-5bc3-92c1-f32d5eeefef0');

-- 로버트 로이드 (Robert Lloyd, Q326331) · 목소리

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '89ae0172-2fa8-5684-9c25-bf9429bba62a', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '89ae0172-2fa8-5684-9c25-bf9429bba62a');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '89ae0172-2fa8-5684-9c25-bf9429bba62a', 'en', 'canonical', 'Robert Lloyd', 'robert lloyd', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '89ae0172-2fa8-5684-9c25-bf9429bba62a' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '89ae0172-2fa8-5684-9c25-bf9429bba62a', 'ko', 'canonical', '로버트 로이드', '로버트 로이드', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '89ae0172-2fa8-5684-9c25-bf9429bba62a' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '89ae0172-2fa8-5684-9c25-bf9429bba62a' AS a, 'gnd' AS n, '124204198' AS v UNION ALL SELECT '89ae0172-2fa8-5684-9c25-bf9429bba62a' AS a, 'isni' AS n, '000000011440352X' AS v UNION ALL SELECT '89ae0172-2fa8-5684-9c25-bf9429bba62a' AS a, 'lccn' AS n, 'n83043595' AS v UNION ALL SELECT '89ae0172-2fa8-5684-9c25-bf9429bba62a' AS a, 'musicbrainz_artist' AS n, '190f113b-dc08-4e0a-b0d7-7f7700308419' AS v UNION ALL SELECT '89ae0172-2fa8-5684-9c25-bf9429bba62a' AS a, 'viaf' AS n, '27252428' AS v UNION ALL SELECT '89ae0172-2fa8-5684-9c25-bf9429bba62a' AS a, 'wikidata' AS n, 'Q326331' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '로버트 로이드', 'Robert Lloyd', '목소리', 'B', '1940', 'United Kingdom', '89ae0172-2fa8-5684-9c25-bf9429bba62a', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '89ae0172-2fa8-5684-9c25-bf9429bba62a');

-- 새뮤얼 레이미 (Samuel Ramey, Q951556) · 목소리

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '17ae5f62-0561-506b-99f2-e1c984e447b1', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '17ae5f62-0561-506b-99f2-e1c984e447b1');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '17ae5f62-0561-506b-99f2-e1c984e447b1', 'en', 'canonical', 'Samuel Ramey', 'samuel ramey', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '17ae5f62-0561-506b-99f2-e1c984e447b1' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '17ae5f62-0561-506b-99f2-e1c984e447b1', 'ko', 'canonical', '새뮤얼 레이미', '새뮤얼 레이미', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '17ae5f62-0561-506b-99f2-e1c984e447b1' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '17ae5f62-0561-506b-99f2-e1c984e447b1' AS a, 'gnd' AS n, '122480740' AS v UNION ALL SELECT '17ae5f62-0561-506b-99f2-e1c984e447b1' AS a, 'isni' AS n, '0000000108664184' AS v UNION ALL SELECT '17ae5f62-0561-506b-99f2-e1c984e447b1' AS a, 'lccn' AS n, 'n81071447' AS v UNION ALL SELECT '17ae5f62-0561-506b-99f2-e1c984e447b1' AS a, 'musicbrainz_artist' AS n, '60bf649b-abb0-4588-b204-4d8cdbcbf6a2' AS v UNION ALL SELECT '17ae5f62-0561-506b-99f2-e1c984e447b1' AS a, 'viaf' AS n, '7373345' AS v UNION ALL SELECT '17ae5f62-0561-506b-99f2-e1c984e447b1' AS a, 'wikidata' AS n, 'Q951556' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '새뮤얼 레이미', 'Samuel Ramey', '목소리', 'A', '1942', 'United States', '17ae5f62-0561-506b-99f2-e1c984e447b1', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '17ae5f62-0561-506b-99f2-e1c984e447b1');

-- 파아타 부르출라제 (Paata Burchuladze, Q747956) · 목소리

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'bd54ceca-82ae-5ce8-9eca-36064439f338', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'bd54ceca-82ae-5ce8-9eca-36064439f338');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bd54ceca-82ae-5ce8-9eca-36064439f338', 'en', 'canonical', 'Paata Burchuladze', 'paata burchuladze', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bd54ceca-82ae-5ce8-9eca-36064439f338' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bd54ceca-82ae-5ce8-9eca-36064439f338', 'ko', 'canonical', '파아타 부르출라제', '파아타 부르출라제', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bd54ceca-82ae-5ce8-9eca-36064439f338' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'bd54ceca-82ae-5ce8-9eca-36064439f338' AS a, 'gnd' AS n, '132325381' AS v UNION ALL SELECT 'bd54ceca-82ae-5ce8-9eca-36064439f338' AS a, 'isni' AS n, '0000000118505291' AS v UNION ALL SELECT 'bd54ceca-82ae-5ce8-9eca-36064439f338' AS a, 'lccn' AS n, 'n86856205' AS v UNION ALL SELECT 'bd54ceca-82ae-5ce8-9eca-36064439f338' AS a, 'musicbrainz_artist' AS n, 'd186dd8f-67a5-4bb0-bd82-6934e0ffcfd3' AS v UNION ALL SELECT 'bd54ceca-82ae-5ce8-9eca-36064439f338' AS a, 'viaf' AS n, '84228078' AS v UNION ALL SELECT 'bd54ceca-82ae-5ce8-9eca-36064439f338' AS a, 'wikidata' AS n, 'Q747956' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '파아타 부르출라제', 'Paata Burchuladze', '목소리', 'B', '1955', 'Georgia', 'bd54ceca-82ae-5ce8-9eca-36064439f338', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'bd54ceca-82ae-5ce8-9eca-36064439f338');

-- 마티 살미넨 (Matti Salminen, Q712805) · 목소리

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'd8333fcc-fb96-5676-bcb5-cbda64885d2c', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'd8333fcc-fb96-5676-bcb5-cbda64885d2c');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd8333fcc-fb96-5676-bcb5-cbda64885d2c', 'en', 'canonical', 'Matti Salminen', 'matti salminen', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd8333fcc-fb96-5676-bcb5-cbda64885d2c' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd8333fcc-fb96-5676-bcb5-cbda64885d2c', 'ko', 'canonical', '마티 살미넨', '마티 살미넨', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd8333fcc-fb96-5676-bcb5-cbda64885d2c' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'd8333fcc-fb96-5676-bcb5-cbda64885d2c' AS a, 'gnd' AS n, '119351013' AS v UNION ALL SELECT 'd8333fcc-fb96-5676-bcb5-cbda64885d2c' AS a, 'isni' AS n, '000000010872604X' AS v UNION ALL SELECT 'd8333fcc-fb96-5676-bcb5-cbda64885d2c' AS a, 'lccn' AS n, 'n82020535' AS v UNION ALL SELECT 'd8333fcc-fb96-5676-bcb5-cbda64885d2c' AS a, 'musicbrainz_artist' AS n, '5db7d778-be9e-42b4-92eb-49b6f36ba5f0' AS v UNION ALL SELECT 'd8333fcc-fb96-5676-bcb5-cbda64885d2c' AS a, 'viaf' AS n, '14959513' AS v UNION ALL SELECT 'd8333fcc-fb96-5676-bcb5-cbda64885d2c' AS a, 'wikidata' AS n, 'Q712805' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '마티 살미넨', 'Matti Salminen', '목소리', 'B', '1945', 'Finland', 'd8333fcc-fb96-5676-bcb5-cbda64885d2c', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'd8333fcc-fb96-5676-bcb5-cbda64885d2c');

-- 베를린 슈타츠카펠레 (Berlin Staatskapelle, Q708538) · orchestra

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '02cf1018-945c-5a42-ae24-9d3fe822ab61', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '02cf1018-945c-5a42-ae24-9d3fe822ab61');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '02cf1018-945c-5a42-ae24-9d3fe822ab61', 'en', 'canonical', 'Berlin Staatskapelle', 'berlin staatskapelle', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '02cf1018-945c-5a42-ae24-9d3fe822ab61' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '02cf1018-945c-5a42-ae24-9d3fe822ab61', 'ko', 'canonical', '베를린 슈타츠카펠레', '베를린 슈타츠카펠레', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '02cf1018-945c-5a42-ae24-9d3fe822ab61' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '02cf1018-945c-5a42-ae24-9d3fe822ab61' AS a, 'gnd' AS n, '5074733-2' AS v UNION ALL SELECT '02cf1018-945c-5a42-ae24-9d3fe822ab61' AS a, 'isni' AS n, '0000000110159371' AS v UNION ALL SELECT '02cf1018-945c-5a42-ae24-9d3fe822ab61' AS a, 'lccn' AS n, 'n81109044' AS v UNION ALL SELECT '02cf1018-945c-5a42-ae24-9d3fe822ab61' AS a, 'musicbrainz_artist' AS n, '3b67833c-fd91-4387-90f5-d34ca131f886' AS v UNION ALL SELECT '02cf1018-945c-5a42-ae24-9d3fe822ab61' AS a, 'viaf' AS n, '133248134' AS v UNION ALL SELECT '02cf1018-945c-5a42-ae24-9d3fe822ab61' AS a, 'viaf' AS n, '147899598' AS v UNION ALL SELECT '02cf1018-945c-5a42-ae24-9d3fe822ab61' AS a, 'wikidata' AS n, 'Q708538' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '베를린 슈타츠카펠레', 'Berlin Staatskapelle', 'orchestra', 'A', '1570', 'Germany', '02cf1018-945c-5a42-ae24-9d3fe822ab61', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '02cf1018-945c-5a42-ae24-9d3fe822ab61');

-- 프란츠 콘비츠니 (Franz Konwitschny, Q63454) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '876a80d9-9a52-589c-8a4d-13a663cdbf28', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '876a80d9-9a52-589c-8a4d-13a663cdbf28');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '876a80d9-9a52-589c-8a4d-13a663cdbf28', 'en', 'canonical', 'Franz Konwitschny', 'franz konwitschny', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '876a80d9-9a52-589c-8a4d-13a663cdbf28' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '876a80d9-9a52-589c-8a4d-13a663cdbf28', 'ko', 'canonical', '프란츠 콘비츠니', '프란츠 콘비츠니', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '876a80d9-9a52-589c-8a4d-13a663cdbf28' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '876a80d9-9a52-589c-8a4d-13a663cdbf28' AS a, 'gnd' AS n, '116331631' AS v UNION ALL SELECT '876a80d9-9a52-589c-8a4d-13a663cdbf28' AS a, 'isni' AS n, '0000000122817108' AS v UNION ALL SELECT '876a80d9-9a52-589c-8a4d-13a663cdbf28' AS a, 'lccn' AS n, 'n82082891' AS v UNION ALL SELECT '876a80d9-9a52-589c-8a4d-13a663cdbf28' AS a, 'musicbrainz_artist' AS n, '9eed3166-cbd6-4943-bbec-167a6f7bf4c6' AS v UNION ALL SELECT '876a80d9-9a52-589c-8a4d-13a663cdbf28' AS a, 'viaf' AS n, '71578471' AS v UNION ALL SELECT '876a80d9-9a52-589c-8a4d-13a663cdbf28' AS a, 'wikidata' AS n, 'Q63454' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '프란츠 콘비츠니', 'Franz Konwitschny', 'conductor', 'B', '1901', 'Germany', '876a80d9-9a52-589c-8a4d-13a663cdbf28', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '876a80d9-9a52-589c-8a4d-13a663cdbf28');

-- 크리스타 루트비히 (Christa Ludwig, Q241005) · mezzo_soprano

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '59bb82e9-5275-53b5-8f3d-2083ee08a4f3', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '59bb82e9-5275-53b5-8f3d-2083ee08a4f3');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '59bb82e9-5275-53b5-8f3d-2083ee08a4f3', 'en', 'canonical', 'Christa Ludwig', 'christa ludwig', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '59bb82e9-5275-53b5-8f3d-2083ee08a4f3' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '59bb82e9-5275-53b5-8f3d-2083ee08a4f3', 'ko', 'canonical', '크리스타 루트비히', '크리스타 루트비히', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '59bb82e9-5275-53b5-8f3d-2083ee08a4f3' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '59bb82e9-5275-53b5-8f3d-2083ee08a4f3' AS a, 'gnd' AS n, '118729489' AS v UNION ALL SELECT '59bb82e9-5275-53b5-8f3d-2083ee08a4f3' AS a, 'isni' AS n, '0000000108743333' AS v UNION ALL SELECT '59bb82e9-5275-53b5-8f3d-2083ee08a4f3' AS a, 'lccn' AS n, 'n83071527' AS v UNION ALL SELECT '59bb82e9-5275-53b5-8f3d-2083ee08a4f3' AS a, 'musicbrainz_artist' AS n, '19511fc8-9262-4f69-9aa4-9e454d1dce2e' AS v UNION ALL SELECT '59bb82e9-5275-53b5-8f3d-2083ee08a4f3' AS a, 'viaf' AS n, '17210301' AS v UNION ALL SELECT '59bb82e9-5275-53b5-8f3d-2083ee08a4f3' AS a, 'wikidata' AS n, 'Q241005' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '크리스타 루트비히', 'Christa Ludwig', 'mezzo_soprano', 'A', '1928', 'Germany', '59bb82e9-5275-53b5-8f3d-2083ee08a4f3', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '59bb82e9-5275-53b5-8f3d-2083ee08a4f3');

-- 안네 소피 폰 오터 (Anne Sofie von Otter, Q234973) · mezzo_soprano

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f', 'en', 'canonical', 'Anne Sofie von Otter', 'anne sofie von otter', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f', 'ko', 'canonical', '안네 소피 폰 오터', '안네 소피 폰 오터', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f' AS a, 'gnd' AS n, '123980461' AS v UNION ALL SELECT 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f' AS a, 'isni' AS n, '0000000114802504' AS v UNION ALL SELECT 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f' AS a, 'lccn' AS n, 'n84040868' AS v UNION ALL SELECT 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f' AS a, 'musicbrainz_artist' AS n, 'da7c775b-ea4e-4e5f-a9a4-878574ca2c75' AS v UNION ALL SELECT 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f' AS a, 'viaf' AS n, '113888949' AS v UNION ALL SELECT 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f' AS a, 'wikidata' AS n, 'Q234973' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '안네 소피 폰 오터', 'Anne Sofie von Otter', 'mezzo_soprano', 'A', '1955', 'Sweden', 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'b1fc4d37-eb84-5c08-a64a-ac55f39ccf5f');

-- 레오폴드 스토코프스키 (Leopold Stokowski, Q297562) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b823edfe-71a3-595e-90b1-5b5830c16381', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b823edfe-71a3-595e-90b1-5b5830c16381');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b823edfe-71a3-595e-90b1-5b5830c16381', 'en', 'canonical', 'Leopold Stokowski', 'leopold stokowski', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b823edfe-71a3-595e-90b1-5b5830c16381' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b823edfe-71a3-595e-90b1-5b5830c16381', 'ko', 'canonical', '레오폴드 스토코프스키', '레오폴드 스토코프스키', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b823edfe-71a3-595e-90b1-5b5830c16381' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b823edfe-71a3-595e-90b1-5b5830c16381' AS a, 'gnd' AS n, '117267384' AS v UNION ALL SELECT 'b823edfe-71a3-595e-90b1-5b5830c16381' AS a, 'isni' AS n, '0000000121247385' AS v UNION ALL SELECT 'b823edfe-71a3-595e-90b1-5b5830c16381' AS a, 'lccn' AS n, 'n80050012' AS v UNION ALL SELECT 'b823edfe-71a3-595e-90b1-5b5830c16381' AS a, 'musicbrainz_artist' AS n, 'cf446851-7c71-4822-a3b9-333b87ff2b60' AS v UNION ALL SELECT 'b823edfe-71a3-595e-90b1-5b5830c16381' AS a, 'viaf' AS n, '24788527' AS v UNION ALL SELECT 'b823edfe-71a3-595e-90b1-5b5830c16381' AS a, 'wikidata' AS n, 'Q297562' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '레오폴드 스토코프스키', 'Leopold Stokowski', 'conductor', 'A', '1882', 'United States', 'b823edfe-71a3-595e-90b1-5b5830c16381', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'b823edfe-71a3-595e-90b1-5b5830c16381');

-- 체칠리아 바르톨리 (Cecilia Bartoli, Q18828) · mezzo_soprano

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb', 'en', 'canonical', 'Cecilia Bartoli', 'cecilia bartoli', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb', 'ko', 'canonical', '체칠리아 바르톨리', '체칠리아 바르톨리', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb' AS a, 'gnd' AS n, '119506289' AS v UNION ALL SELECT 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb' AS a, 'isni' AS n, '0000000117984710' AS v UNION ALL SELECT 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb' AS a, 'lccn' AS n, 'n92037927' AS v UNION ALL SELECT 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb' AS a, 'musicbrainz_artist' AS n, '043a40c7-fb90-42f7-89a8-077a8ff61db6' AS v UNION ALL SELECT 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb' AS a, 'viaf' AS n, '219059201' AS v UNION ALL SELECT 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb' AS a, 'viaf' AS n, '308744069' AS v UNION ALL SELECT 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb' AS a, 'wikidata' AS n, 'Q18828' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '체칠리아 바르톨리', 'Cecilia Bartoli', 'mezzo_soprano', 'A', '1966', 'Italy', 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'c5a42b09-9734-5ffd-8fc5-73dfd3d1e6cb');

-- 주세페 파타네 (Giuseppe Patanè, Q284248) · conductor

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'cf8f9740-2e98-56b2-9d2b-65f783c878ea', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'cf8f9740-2e98-56b2-9d2b-65f783c878ea');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cf8f9740-2e98-56b2-9d2b-65f783c878ea', 'en', 'canonical', 'Giuseppe Patanè', 'giuseppe patanè', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cf8f9740-2e98-56b2-9d2b-65f783c878ea' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cf8f9740-2e98-56b2-9d2b-65f783c878ea', 'ko', 'canonical', '주세페 파타네', '주세페 파타네', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cf8f9740-2e98-56b2-9d2b-65f783c878ea' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'cf8f9740-2e98-56b2-9d2b-65f783c878ea' AS a, 'gnd' AS n, '124893155' AS v UNION ALL SELECT 'cf8f9740-2e98-56b2-9d2b-65f783c878ea' AS a, 'isni' AS n, '0000000081232954' AS v UNION ALL SELECT 'cf8f9740-2e98-56b2-9d2b-65f783c878ea' AS a, 'lccn' AS n, 'n82132929' AS v UNION ALL SELECT 'cf8f9740-2e98-56b2-9d2b-65f783c878ea' AS a, 'musicbrainz_artist' AS n, '94832e33-16f7-46bb-84de-8d8386161a67' AS v UNION ALL SELECT 'cf8f9740-2e98-56b2-9d2b-65f783c878ea' AS a, 'viaf' AS n, '44486105' AS v UNION ALL SELECT 'cf8f9740-2e98-56b2-9d2b-65f783c878ea' AS a, 'wikidata' AS n, 'Q284248' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '주세페 파타네', 'Giuseppe Patanè', 'conductor', 'B', '1932', 'Italy', 'cf8f9740-2e98-56b2-9d2b-65f783c878ea', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'cf8f9740-2e98-56b2-9d2b-65f783c878ea');

-- 아그네스 발차 (Agnes Baltsa, Q235679) · mezzo_soprano

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '98672ef0-ba26-594f-8826-0364873c96b7', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '98672ef0-ba26-594f-8826-0364873c96b7');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '98672ef0-ba26-594f-8826-0364873c96b7', 'en', 'canonical', 'Agnes Baltsa', 'agnes baltsa', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '98672ef0-ba26-594f-8826-0364873c96b7' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '98672ef0-ba26-594f-8826-0364873c96b7', 'ko', 'canonical', '아그네스 발차', '아그네스 발차', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '98672ef0-ba26-594f-8826-0364873c96b7' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '98672ef0-ba26-594f-8826-0364873c96b7' AS a, 'gnd' AS n, '118881256' AS v UNION ALL SELECT '98672ef0-ba26-594f-8826-0364873c96b7' AS a, 'isni' AS n, '0000000121275546' AS v UNION ALL SELECT '98672ef0-ba26-594f-8826-0364873c96b7' AS a, 'lccn' AS n, 'n81089378' AS v UNION ALL SELECT '98672ef0-ba26-594f-8826-0364873c96b7' AS a, 'musicbrainz_artist' AS n, '34ecc297-1473-49a0-87b5-0b52e632db58' AS v UNION ALL SELECT '98672ef0-ba26-594f-8826-0364873c96b7' AS a, 'viaf' AS n, '34642475' AS v UNION ALL SELECT '98672ef0-ba26-594f-8826-0364873c96b7' AS a, 'wikidata' AS n, 'Q235679' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '아그네스 발차', 'Agnes Baltsa', 'mezzo_soprano', 'A', '1944', 'Greece', '98672ef0-ba26-594f-8826-0364873c96b7', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '98672ef0-ba26-594f-8826-0364873c96b7');
