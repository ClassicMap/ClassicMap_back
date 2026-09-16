-- 비교 영상 시드에 필요한 지휘자 1명(주빈 메타)을 추가한다.
--
-- 202608050031 과 같은 방식이다. 적재기는 연주자를 external_identifiers.wikidata
-- 로만 해소하므로 적재 전에 넣어야 한다.
--
-- authority_entities.id 는 파이프라인과 같은 규칙으로 계산했다.
--   uuid5(NAMESPACE_URL, 'classicmap-entity:' || sorted(strong 식별자 'ns:value') join '|')
--
-- 박쥐 서곡의 세 번째 연주(빈 필하모닉)로 쓴다. 나머지 둘이 카라얀·클라이버라
-- 지휘자가 겹치지 않는 연주가 필요했다.
--
-- 한국어 이름은 Wikidata 라벨(주빈 메타)이 국내 표기와 같아 그대로 썼다.
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e727a4db-00ef-566c-ad0e-38b17d19f741', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing
    WHERE existing.id = 'e727a4db-00ef-566c-ad0e-38b17d19f741'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e727a4db-00ef-566c-ad0e-38b17d19f741', 'en', 'canonical',
       'Zubin Mehta', 'zubin mehta', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e727a4db-00ef-566c-ad0e-38b17d19f741'
      AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e727a4db-00ef-566c-ad0e-38b17d19f741', 'ko', 'canonical',
       '주빈 메타', '주빈 메타', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e727a4db-00ef-566c-ad0e-38b17d19f741'
      AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT 'e727a4db-00ef-566c-ad0e-38b17d19f741' AS a, 'gnd' AS n, '12339967X' AS v
    UNION ALL SELECT 'e727a4db-00ef-566c-ad0e-38b17d19f741', 'isni', '0000000114719794'
    UNION ALL SELECT 'e727a4db-00ef-566c-ad0e-38b17d19f741', 'musicbrainz_artist',
        'b83bb7b8-1b89-4b12-9af6-fd7ac29e2fae'
    UNION ALL SELECT 'e727a4db-00ef-566c-ad0e-38b17d19f741', 'viaf', '46947160'
    UNION ALL SELECT 'e727a4db-00ef-566c-ad0e-38b17d19f741', 'wikidata', 'Q157635'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '주빈 메타', 'Zubin Mehta', 'conductor', 'S', '1936', 'India',
       'e727a4db-00ef-566c-ad0e-38b17d19f741', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = 'e727a4db-00ef-566c-ad0e-38b17d19f741'
);
