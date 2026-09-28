-- A tier A19 의 <목신의 오후에의 전주곡>(piece 221)에 플루트 독주자 크레딧을 보탠다.
-- 티모시 허친스를 새로 등록하고, 엠마누엘 파후드(artist 305)는 이미 등록돼 있다.
--
-- **이 구간은 무반주 플루트 독주로 시작한다.** 배급 표기가 셋 중 둘에서 플루트
-- 수석을 맨 앞에 적는다 — 아바도판 `aCphwVnD_hM` 은 Emmanuel Pahud,
-- 뒤투아판 `yHy64Bg_hGs` 은 Timothy Hutchins 다. 이 구간에서 실제로 비교되는
-- 것이 플루트이므로 A14 의 Pie Jesu 소프라노와 같은 판단으로 보탠다.
--
-- **하이팅크판 `Xa_9hF3L6fQ` 은 비운다.** 배급 표기에 플루트 주자가 없다. 다른
-- 자료로 짐작하지 않는다 — 크레딧이 비대칭(둘은 셋, 하나는 둘)이 되지만 확인되지
-- 않은 신원을 붙이는 것보다 낫다. A16 에서 같은 판단을 했다.
--
-- **role_code 는 'soloist' 다.** 적재기는 크레딧 역할을 여섯 갈래로 정규화해
-- 넣는다 — conductor · orchestra · soloist · vocalist · ensemble · accompanist.
-- 악기 역할(FLUTIST·VIOLINIST 등)은 모두 soloist 로 묶이고, A14 의 SOPRANO 는
-- vocalist 가 됐다. 여기서는 적재기를 거치지 않고 직접 넣으므로 **그 정규화를
-- 손으로 맞춘다.** 'FLUTIST' 로 넣으면 이 표에서 유일하게 튀는 값이 된다.
--
-- 차례는 conductor(0) → soloist(1) → orchestra(2) 다. 이미 들어간 orchestra 의
-- display_order 를 1 에서 2 로 밀고 그 자리에 플루트를 넣는다. A12 의 합창단이
-- conductor → choir → orchestra 였던 것과 같은 자리다.
--
-- 두 사람 다 wikidata 에 악기 진술(P1303 = 플루트)과 직업(P106 = flautist)이
-- 있다. 파후드는 클레임 89개에 베를린 필 소속(P463)까지 적혀 있어 아바도판의
-- 수석이 맞고, 허친스는 클레임 12개로 얇지만 악기·직업·MusicBrainz 식별자가 있다.
-- **A16 에서 버린 항목(악기 진술도 MusicBrainz 도 없고 직업이 'musician' 뿐)과
-- 다르다.** 허친스는 wikidata 에 출생일이 없어 birth_year 를 NULL 로 둔다.
--
-- 이미 발행된 연주에 크레딧을 보태므로 performance_credits 에 직접 넣는다.
-- 적재기를 다시 돌리면 같은 candidate_key 로 중복이 생긴다. 멱등하게 쓴다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '1e280e8d-1003-5ea6-86a8-91fedab84471', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '1e280e8d-1003-5ea6-86a8-91fedab84471');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1e280e8d-1003-5ea6-86a8-91fedab84471', 'en', 'canonical', 'Timothy Hutchins', 'timothy hutchins', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1e280e8d-1003-5ea6-86a8-91fedab84471' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1e280e8d-1003-5ea6-86a8-91fedab84471', 'ko', 'canonical', '티모시 허친스', '티모시 허친스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1e280e8d-1003-5ea6-86a8-91fedab84471' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '1e280e8d-1003-5ea6-86a8-91fedab84471' AS a, 'musicbrainz_artist' AS n, '654554fb-4088-4920-bac4-e0a6e2ac70e8' AS v UNION ALL SELECT '1e280e8d-1003-5ea6-86a8-91fedab84471' AS a, 'wikidata' AS n, 'Q7807265' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '티모시 허친스', 'Timothy Hutchins', 'flutist', 'A', NULL, 'Canada', '1e280e8d-1003-5ea6-86a8-91fedab84471', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '1e280e8d-1003-5ea6-86a8-91fedab84471');


-- 역할 이름을 적재기의 정규화에 맞춘다. 처음 적용에서 'FLUTIST' 로 들어간 것을
-- 되돌린다. 새 DB 에서는 이 UPDATE 가 아무 일도 하지 않는다.
UPDATE performance_credits
SET role_code = 'soloist'
WHERE role_code = 'FLUTIST';

-- orchestra 를 2번으로 밀어 플루트 자리를 만든다.
UPDATE performance_credits credit
SET credit.display_order = 2
WHERE credit.role_code = 'orchestra'
  AND credit.display_order = 1
  AND credit.performance_source_id IN (
      SELECT id FROM (
          SELECT id FROM performance_sources
          WHERE provider = 'youtube'
            AND provider_video_id IN ('aCphwVnD_hM', 'yHy64Bg_hGs')
      ) matched
  );

INSERT INTO performance_credits
    (performance_source_id, artist_id, role_code, is_primary, display_order)
SELECT source.id, artist.id, 'soloist', 0, 1
FROM (SELECT id, provider_video_id FROM performance_sources
      WHERE provider = 'youtube') source
JOIN (
    SELECT a.id, identifier.external_id
    FROM artists a
    JOIN external_identifiers identifier
      ON identifier.authority_entity_id = a.authority_entity_id
     AND identifier.namespace = 'wikidata'
) artist
  ON (source.provider_video_id = 'aCphwVnD_hM' AND artist.external_id = 'Q115764')
  OR (source.provider_video_id = 'yHy64Bg_hGs' AND artist.external_id = 'Q7807265')
WHERE NOT EXISTS (
    SELECT 1 FROM (
        SELECT performance_source_id, artist_id FROM performance_credits
    ) existing
    WHERE existing.performance_source_id = source.id
      AND existing.artist_id = artist.id
);
