-- A tier A15 배치에 필요한 인물 6명을 추가한다.
--   유진 오르만디(지휘) · 바버라 헨드릭스(소프라노)
--   알렉상드르 타로 · 미셸 달베르토 · 파스칼 드부아용 · 캐스린 스톳 (모두 반주 피아노)
--
-- 포레 파반느(207) · 시칠리엔(208) · <꿈을 꾼 후에>(209)에 쓴다.
--
-- 반주 피아니스트 넷은 category 를 pianist 로 두지만 **크레딧 역할은 ACCOMPANIST 다.**
-- PIANIST 로 넣으면 적재기가 악기 역할을 모두 독주자로 묶어 첼리스트·성악가와
-- 나란히 뜬다(04-loading.md). 달베르토는 208 카퓌송과 209 헨드릭스 양쪽에 든다.
--
-- 드부아용·달베르토·스톳은 wikidata 에 한국어 라벨이 없어 한글 이름을 직접 적었다.
-- 여섯 다 항목이 충실하다(클레임 44~152개).
--
-- 202608050186 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f7b21011-14c3-5169-a626-2a9f0becacab', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f7b21011-14c3-5169-a626-2a9f0becacab');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f7b21011-14c3-5169-a626-2a9f0becacab', 'en', 'canonical', 'Eugene Ormandy', 'eugene ormandy', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f7b21011-14c3-5169-a626-2a9f0becacab' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f7b21011-14c3-5169-a626-2a9f0becacab', 'ko', 'canonical', '유진 오르만디', '유진 오르만디', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f7b21011-14c3-5169-a626-2a9f0becacab' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'f7b21011-14c3-5169-a626-2a9f0becacab' AS a, 'gnd' AS n, '12414652X' AS v UNION ALL SELECT 'f7b21011-14c3-5169-a626-2a9f0becacab' AS a, 'isni' AS n, '0000000109110853' AS v UNION ALL SELECT 'f7b21011-14c3-5169-a626-2a9f0becacab' AS a, 'isni' AS n, '000000036855597X' AS v UNION ALL SELECT 'f7b21011-14c3-5169-a626-2a9f0becacab' AS a, 'musicbrainz_artist' AS n, 'c70e7c06-65e9-42bd-9059-4973fd20e127' AS v UNION ALL SELECT 'f7b21011-14c3-5169-a626-2a9f0becacab' AS a, 'viaf' AS n, '66652639' AS v UNION ALL SELECT 'f7b21011-14c3-5169-a626-2a9f0becacab' AS a, 'wikidata' AS n, 'Q344023' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '유진 오르만디', 'Eugene Ormandy', 'conductor', 'A', '1899', 'Hungary', 'f7b21011-14c3-5169-a626-2a9f0becacab', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'f7b21011-14c3-5169-a626-2a9f0becacab');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a567c24c-8c53-570b-b5b5-068061fb3109', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a567c24c-8c53-570b-b5b5-068061fb3109');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a567c24c-8c53-570b-b5b5-068061fb3109', 'en', 'canonical', 'Barbara Hendricks', 'barbara hendricks', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a567c24c-8c53-570b-b5b5-068061fb3109' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a567c24c-8c53-570b-b5b5-068061fb3109', 'ko', 'canonical', '바버라 헨드릭스', '바버라 헨드릭스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a567c24c-8c53-570b-b5b5-068061fb3109' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a567c24c-8c53-570b-b5b5-068061fb3109' AS a, 'gnd' AS n, '123053617' AS v UNION ALL SELECT 'a567c24c-8c53-570b-b5b5-068061fb3109' AS a, 'isni' AS n, '0000000121419335' AS v UNION ALL SELECT 'a567c24c-8c53-570b-b5b5-068061fb3109' AS a, 'musicbrainz_artist' AS n, '21b3c493-68fd-4d56-bd93-bed911d21de5' AS v UNION ALL SELECT 'a567c24c-8c53-570b-b5b5-068061fb3109' AS a, 'viaf' AS n, '85092418' AS v UNION ALL SELECT 'a567c24c-8c53-570b-b5b5-068061fb3109' AS a, 'wikidata' AS n, 'Q807482' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '바버라 헨드릭스', 'Barbara Hendricks', 'soprano', 'A', '1948', 'United States', 'a567c24c-8c53-570b-b5b5-068061fb3109', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a567c24c-8c53-570b-b5b5-068061fb3109');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '163de46b-befb-551f-9eb1-ad0879e53f55', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '163de46b-befb-551f-9eb1-ad0879e53f55');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '163de46b-befb-551f-9eb1-ad0879e53f55', 'en', 'canonical', 'Alexandre Tharaud', 'alexandre tharaud', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '163de46b-befb-551f-9eb1-ad0879e53f55' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '163de46b-befb-551f-9eb1-ad0879e53f55', 'ko', 'canonical', '알렉상드르 타로', '알렉상드르 타로', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '163de46b-befb-551f-9eb1-ad0879e53f55' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '163de46b-befb-551f-9eb1-ad0879e53f55' AS a, 'gnd' AS n, '123656109' AS v UNION ALL SELECT '163de46b-befb-551f-9eb1-ad0879e53f55' AS a, 'isni' AS n, '0000000114756712' AS v UNION ALL SELECT '163de46b-befb-551f-9eb1-ad0879e53f55' AS a, 'musicbrainz_artist' AS n, '83b74911-aa21-4e31-ad1c-5eb505248f5a' AS v UNION ALL SELECT '163de46b-befb-551f-9eb1-ad0879e53f55' AS a, 'viaf' AS n, '79171997' AS v UNION ALL SELECT '163de46b-befb-551f-9eb1-ad0879e53f55' AS a, 'wikidata' AS n, 'Q954028' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '알렉상드르 타로', 'Alexandre Tharaud', 'pianist', 'A', '1968', 'France', '163de46b-befb-551f-9eb1-ad0879e53f55', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '163de46b-befb-551f-9eb1-ad0879e53f55');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '76c07ffd-f4fa-5c80-a175-046369101482', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '76c07ffd-f4fa-5c80-a175-046369101482');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '76c07ffd-f4fa-5c80-a175-046369101482', 'en', 'canonical', 'Michel Dalberto', 'michel dalberto', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '76c07ffd-f4fa-5c80-a175-046369101482' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '76c07ffd-f4fa-5c80-a175-046369101482', 'ko', 'canonical', '미셸 달베르토', '미셸 달베르토', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '76c07ffd-f4fa-5c80-a175-046369101482' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '76c07ffd-f4fa-5c80-a175-046369101482' AS a, 'gnd' AS n, '133854728' AS v UNION ALL SELECT '76c07ffd-f4fa-5c80-a175-046369101482' AS a, 'isni' AS n, '000000008181935X' AS v UNION ALL SELECT '76c07ffd-f4fa-5c80-a175-046369101482' AS a, 'musicbrainz_artist' AS n, 'c4ee8d52-510b-429d-a33d-6e9adcbb978b' AS v UNION ALL SELECT '76c07ffd-f4fa-5c80-a175-046369101482' AS a, 'viaf' AS n, '113934467' AS v UNION ALL SELECT '76c07ffd-f4fa-5c80-a175-046369101482' AS a, 'wikidata' AS n, 'Q704544' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '미셸 달베르토', 'Michel Dalberto', 'pianist', 'A', '1955', 'France', '76c07ffd-f4fa-5c80-a175-046369101482', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '76c07ffd-f4fa-5c80-a175-046369101482');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '666a7ce7-5640-5c70-b341-63afcca13902', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '666a7ce7-5640-5c70-b341-63afcca13902');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '666a7ce7-5640-5c70-b341-63afcca13902', 'en', 'canonical', 'Pascal Devoyon', 'pascal devoyon', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '666a7ce7-5640-5c70-b341-63afcca13902' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '666a7ce7-5640-5c70-b341-63afcca13902', 'ko', 'canonical', '파스칼 드부아용', '파스칼 드부아용', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '666a7ce7-5640-5c70-b341-63afcca13902' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '666a7ce7-5640-5c70-b341-63afcca13902' AS a, 'gnd' AS n, '123706084' AS v UNION ALL SELECT '666a7ce7-5640-5c70-b341-63afcca13902' AS a, 'isni' AS n, '0000000081116144' AS v UNION ALL SELECT '666a7ce7-5640-5c70-b341-63afcca13902' AS a, 'musicbrainz_artist' AS n, '0b66cfaa-9372-4373-94e0-6bcbb7e78027' AS v UNION ALL SELECT '666a7ce7-5640-5c70-b341-63afcca13902' AS a, 'viaf' AS n, '32182968' AS v UNION ALL SELECT '666a7ce7-5640-5c70-b341-63afcca13902' AS a, 'wikidata' AS n, 'Q1671133' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '파스칼 드부아용', 'Pascal Devoyon', 'pianist', 'A', '1953', 'France', '666a7ce7-5640-5c70-b341-63afcca13902', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '666a7ce7-5640-5c70-b341-63afcca13902');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'ca8fe137-de09-5383-9b07-6bcabce83f71', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'ca8fe137-de09-5383-9b07-6bcabce83f71');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ca8fe137-de09-5383-9b07-6bcabce83f71', 'en', 'canonical', 'Kathryn Stott', 'kathryn stott', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ca8fe137-de09-5383-9b07-6bcabce83f71' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ca8fe137-de09-5383-9b07-6bcabce83f71', 'ko', 'canonical', '캐스린 스톳', '캐스린 스톳', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ca8fe137-de09-5383-9b07-6bcabce83f71' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'ca8fe137-de09-5383-9b07-6bcabce83f71' AS a, 'gnd' AS n, '134766318' AS v UNION ALL SELECT 'ca8fe137-de09-5383-9b07-6bcabce83f71' AS a, 'isni' AS n, '0000000114507345' AS v UNION ALL SELECT 'ca8fe137-de09-5383-9b07-6bcabce83f71' AS a, 'musicbrainz_artist' AS n, '29561415-1e42-4f3f-b459-e73660587b45' AS v UNION ALL SELECT 'ca8fe137-de09-5383-9b07-6bcabce83f71' AS a, 'viaf' AS n, '85750797' AS v UNION ALL SELECT 'ca8fe137-de09-5383-9b07-6bcabce83f71' AS a, 'wikidata' AS n, 'Q6377130' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '캐스린 스톳', 'Kathryn Stott', 'pianist', 'A', '1958', 'United Kingdom', 'ca8fe137-de09-5383-9b07-6bcabce83f71', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'ca8fe137-de09-5383-9b07-6bcabce83f71');

