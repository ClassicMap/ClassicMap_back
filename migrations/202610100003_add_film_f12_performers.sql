-- 영화 속 클래식 12차(film-f12) 말러 3번 4악장 하이팅크 판의 알토를 등록한다.
--
--   모린 포레스터 (Maureen Forrester, Q263172) — 콘트랄토, 하이팅크 · 로열 콘세르트허바우 판(℗1966)
--
-- 처음 고른 아바도 판(BBC 실황)은 발췌 옮김 비용이 0.0831 로 07-excerpt.md 의 0.06 을 넘어 이 판으로 바꿨다.
-- 등록 확인 세 단계(05-pitfalls.md): wikidata·gnd·isni·musicbrainz·viaf·lccn 어디로도
-- artists·external_identifiers 에 걸리는 것이 없어 엔티티부터 만든다(id 는 식별자 집합의 uuid5, 202610070001 과 같은 규칙).
-- 이름으로 겹치는 artists 행도 없다. 콘트랄토는 분류 코드가 없어 '목소리'(성악가)로 둔다.

-- 모린 포레스터 (Maureen Forrester, Q263172) · 목소리

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa', 'en', 'canonical', 'Maureen Forrester', 'maureen forrester', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa', 'ko', 'canonical', '모린 포레스터', '모린 포레스터', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa' AS a, 'gnd' AS n, '122862597' AS v UNION ALL SELECT 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa' AS a, 'isni' AS n, '0000000108634399' AS v UNION ALL SELECT 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa' AS a, 'lccn' AS n, 'n82101459' AS v UNION ALL SELECT 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa' AS a, 'musicbrainz_artist' AS n, 'c855d631-15c7-4731-9cfd-397796c78416' AS v UNION ALL SELECT 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa' AS a, 'viaf' AS n, '2656093' AS v UNION ALL SELECT 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa' AS a, 'wikidata' AS n, 'Q263172' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '모린 포레스터', 'Maureen Forrester', '목소리', 'B', '1930', 'Canada', 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'f064c8e3-91f4-5eb2-a902-4b0c2016d0fa');
