-- 비교 영상 2차 시드(차이콥스키 1번·베토벤 5번·라 캄파넬라)에 필요한 권위 행을 채운다.
--
-- load_comparison_candidates 는 작품을 piece_identifiers.musicbrainz_work 로,
-- 연주자를 external_identifiers.wikidata 로만 해소한다. 이름은 근거로 쓰지 않는다.
-- 해소에 실패하면 후보 적재 전체가 rollback 되므로 적재 전에 먼저 연결해 둔다.
--
-- 추가하는 것은 두 갈래다.
--
-- 1) 연주자 2명 (카를로스 클라이버·드미트리 시시킨)
--    기존 6명(아르헤리치·랑랑·손열음·키신·정명훈·틸레만)은 이미 연결돼 있고
--    이 둘만 artists 에 없다.
--    authority_entities.id 는 파이프라인과 같은 규칙으로 계산했다.
--      uuid5(NAMESPACE_URL, 'classicmap-entity:' || sorted(strong 식별자 'ns:value') join '|')
--    키신·틸레만의 기존 행으로 이 규칙이 그대로 재현되는 것을 확인한 뒤 적용한다.
--    식별자 집합이 바뀌면 id 도 바뀌므로 Wikidata 에 있는 강한 식별자를 모두 넣는다.
--
-- 2) 작품 식별자 3건
--    차이콥스키 피아노 협주곡 1번은 MusicBrainz 에 같은 제목의 work 가 둘 있어
--    연결된 녹음이 47건인 ba27a04b 를 쓴다. 다른 하나(71b01883)는 1건뿐이다.

-- 카를로스 클라이버 -----------------------------------------------------------
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '24dcecf6-8168-5123-9cb6-549bcdf7e8d0', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing
    WHERE existing.id = '24dcecf6-8168-5123-9cb6-549bcdf7e8d0'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '24dcecf6-8168-5123-9cb6-549bcdf7e8d0', 'en', 'canonical', 'Carlos Kleiber', 'carlos kleiber', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '24dcecf6-8168-5123-9cb6-549bcdf7e8d0'
      AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '24dcecf6-8168-5123-9cb6-549bcdf7e8d0', 'ko', 'canonical', '카를로스 클라이버', '카를로스 클라이버', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '24dcecf6-8168-5123-9cb6-549bcdf7e8d0'
      AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT '24dcecf6-8168-5123-9cb6-549bcdf7e8d0' AS a, 'wikidata' AS n, 'Q160706' AS v
    UNION ALL SELECT '24dcecf6-8168-5123-9cb6-549bcdf7e8d0', 'musicbrainz_artist', '9f83001a-fd49-4efb-a835-05ee6922a10d'
    UNION ALL SELECT '24dcecf6-8168-5123-9cb6-549bcdf7e8d0', 'isni', '0000000108600439'
    UNION ALL SELECT '24dcecf6-8168-5123-9cb6-549bcdf7e8d0', 'gnd', '129264989'
    UNION ALL SELECT '24dcecf6-8168-5123-9cb6-549bcdf7e8d0', 'viaf', '110788915'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '카를로스 클라이버', 'Carlos Kleiber', 'conductor', 'S', '1930', 'Austria',
       '24dcecf6-8168-5123-9cb6-549bcdf7e8d0', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = '24dcecf6-8168-5123-9cb6-549bcdf7e8d0'
);

-- 드미트리 시시킨 -------------------------------------------------------------
-- Wikidata 한국어 라벨은 '드미트리 쉬스킨'이지만 국내 공연·음반 표기는 '시시킨'이 일반적이라
-- 화면에 나갈 이름은 후자를 쓰고, Wikidata 표기는 alias 로 남긴다.
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e6f824c0-6dcb-59ce-b00c-ccf2485646d7', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing
    WHERE existing.id = 'e6f824c0-6dcb-59ce-b00c-ccf2485646d7'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e6f824c0-6dcb-59ce-b00c-ccf2485646d7', 'en', 'canonical', 'Dmitry Shishkin', 'dmitry shishkin', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e6f824c0-6dcb-59ce-b00c-ccf2485646d7'
      AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e6f824c0-6dcb-59ce-b00c-ccf2485646d7', 'ko', 'canonical', '드미트리 시시킨', '드미트리 시시킨', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e6f824c0-6dcb-59ce-b00c-ccf2485646d7'
      AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e6f824c0-6dcb-59ce-b00c-ccf2485646d7', 'ko', 'alias', '드미트리 쉬스킨', '드미트리 쉬스킨', 0, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind, name_value FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e6f824c0-6dcb-59ce-b00c-ccf2485646d7'
      AND existing.locale = 'ko' AND existing.name_kind = 'alias'
      AND existing.name_value = '드미트리 쉬스킨'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT 'e6f824c0-6dcb-59ce-b00c-ccf2485646d7' AS a, 'wikidata' AS n, 'Q24053154' AS v
    UNION ALL SELECT 'e6f824c0-6dcb-59ce-b00c-ccf2485646d7', 'musicbrainz_artist', 'ad7850af-3840-4d89-9727-25dd7c2770cf'
    UNION ALL SELECT 'e6f824c0-6dcb-59ce-b00c-ccf2485646d7', 'viaf', '318145541839096601440'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '드미트리 시시킨', 'Dmitry Shishkin', 'pianist', 'B', '1992', 'Russia',
       'e6f824c0-6dcb-59ce-b00c-ccf2485646d7', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = 'e6f824c0-6dcb-59ce-b00c-ccf2485646d7'
);

-- 작품 식별자 -----------------------------------------------------------------
-- 곡 제목이 바뀌었거나 다른 곡이면 아무것도 넣지 않도록 english_name 까지 확인한다.
INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 159 AS p, 'musicbrainz_work' AS n, 'ba27a04b-1a26-4771-909e-81b2f8449ff7' AS v
    UNION ALL SELECT 75, 'musicbrainz_work', 'd03bff61-26fc-301b-98ac-4d8e85771cbc'
    UNION ALL SELECT 140, 'musicbrainz_work', 'b6a880ce-35bc-357e-aade-a251fc021a66'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
