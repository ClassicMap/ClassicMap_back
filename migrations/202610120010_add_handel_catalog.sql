-- 헨델 작품을 출판 단위로 채운다(카탈로그: HWV). 작품 377개(묶음 17, 다악장 50, 낱곡 310),
-- 새 작품 373개, 기존 작품 4개, part 405개, 그 아래 443개, 기존 낱곡 연결 1개.
--
-- 정한 것
--   오페라·오라토리오·칸타타는 part 없이 둔다. 출판 세트(Op. 1–7, 하프시코드 모음곡 1720·1733, <수상 음악>, <대관식 찬가>, <챈도스 찬가> 등)는 묶음이다.
--   27 「대관식 찬가 <사제 차독>」은 <대관식 찬가> 묶음 1번 part 로 잇는다. 대목 작품(24·25·26·433)과 할보르센 편곡(26057)은 그대로 둔다.
--   Op. 1 은 Walsh 1732년판 12곡(위작 의심 2곡 포함, 출판 번호 유지). <에스더> 가면극·오라토리오판, 헨델 음악만으로 된 파스티치오 3편은 넣는다.
--
-- 공통: 자료는 seed_pipeline/curation/catalog-wave2-2026-10-12/<작곡가>/catalog.json 이고, 본문은 그 폴더의
-- gen_catalog.py 가 만든다. 위키백과 영어판 작품 목록을 기준으로 MusicBrainz work 와 맞췄다.
--   단위: 한 작품번호 아래 함께 출판된 곡은 묶음(작품 하나 + part), 악장으로 나뉜 작품은 악장을 part 로,
--     묶음 안 곡이 다시 악장으로 나뉘면 그 아래 part(parent_part_id)로 둔다. 오페라·발레·오라토리오 같은
--     무대·대형 성악 작품은 이번에는 part 없이 둔다.
--   이름: 묶음 제목은 갈래만으로 구별이 안 되면 끝에 카탈로그를 넣고("현악 4중주 Op. 18") opus_number 를
--     비운 채 catalogue_system·catalogue_number 를 채운다. 낱곡·다악장은 opus_number 에 카탈로그를 둔다.
--     part 이름에는 "1번"·"1악장" 을 넣지 않는다(번호는 sequence_number). 악장만 movement_number 를 채운다.
--     가곡 제목은 널리 쓰는 우리말이 확실할 때만 "우리말 (원제)", 아니면 원제다.
--   빼는 것: 위작(의심만 붙은 곡은 작곡가별로 아래에 적었다), 소실, 단편·스케치, 남의 작품 편곡, 민요 편곡, 같은 곡의 옛 판.
--   기존 작품: MBID 로 먼저, 없으면 카탈로그 번호로 맞춘다. 기존 작품의 제목·설명·링크는 바꾸지 않고, 비어 있는
--     작품번호·연도만 채운다. 기존 작품에 없는 다른 판 MBID(원곡 work 등)는 식별자로 더하고 기존 식별자는 그대로 둔다.
--     따로 있던 낱곡이 새 묶음 안 곡이면 part.linked_piece_id 로 잇는다.
--   part 는 EDITOR_REVIEWED 로 넣는다. 같은 MBID 가 이미 다른 작품에 있으면 작품도 식별자도 넣지 않는다.
--   방금 넣은 작품은 (작곡가, 제목, origin='manual') 로 찾는다. 두 번 돌려도 같다.

-- HWV 1 오페라 <알미라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <알미라>', 'Opera <Almira>', 'song', 'HWV 1', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <알미라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7213e4fd-7704-415e-946d-e9586b933c44'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7213e4fd-7704-415e-946d-e9586b933c44'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <알미라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7213e4fd-7704-415e-946d-e9586b933c44'
);


-- HWV 5 오페라 <로드리고>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <로드리고>', 'Opera <Rodrigo>', 'song', 'HWV 5', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <로드리고>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e57acec-d06d-4e4b-8adf-315c8ac2541d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0e57acec-d06d-4e4b-8adf-315c8ac2541d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <로드리고>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e57acec-d06d-4e4b-8adf-315c8ac2541d'
);


-- HWV 6 오페라 <아그리피나>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아그리피나>', 'Opera <Agrippina>', 'song', 'HWV 6', NULL, NULL, 1709, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아그리피나>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1307bc94-8e54-4396-a947-1ad7cfff4016'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1307bc94-8e54-4396-a947-1ad7cfff4016'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <아그리피나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1307bc94-8e54-4396-a947-1ad7cfff4016'
);


-- HWV 7 오페라 <리날도>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <리날도>', 'Opera <Rinaldo>', 'song', 'HWV 7', NULL, NULL, 1711, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <리날도>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b57e6315-eb10-4979-8cb8-5f24f3cc5687'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b57e6315-eb10-4979-8cb8-5f24f3cc5687'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <리날도>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b57e6315-eb10-4979-8cb8-5f24f3cc5687'
);


-- HWV 8 오페라 <충실한 양치기>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <충실한 양치기>', 'Opera <Il pastor fido>', 'song', 'HWV 8', NULL, NULL, 1712, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <충실한 양치기>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f5270c2-3d75-4ce5-8e1d-0f70903acbf7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8f5270c2-3d75-4ce5-8e1d-0f70903acbf7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <충실한 양치기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f5270c2-3d75-4ce5-8e1d-0f70903acbf7'
);


-- HWV 9 오페라 <테세오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <테세오>', 'Opera <Teseo>', 'song', 'HWV 9', NULL, NULL, 1713, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <테세오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f91f8ced-f4c3-4acb-b784-2ca75e525757'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f91f8ced-f4c3-4acb-b784-2ca75e525757'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <테세오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f91f8ced-f4c3-4acb-b784-2ca75e525757'
);


-- HWV 10 오페라 <실라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <실라>', 'Opera <Silla>', 'song', 'HWV 10', NULL, NULL, 1713, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <실라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17f3515a-837c-4f93-ad7e-b4865c4f981f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17f3515a-837c-4f93-ad7e-b4865c4f981f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <실라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17f3515a-837c-4f93-ad7e-b4865c4f981f'
);


-- HWV 11 오페라 <가울라의 아마디지>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <가울라의 아마디지>', 'Opera <Amadigi di Gaula>', 'song', 'HWV 11', NULL, NULL, 1715, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <가울라의 아마디지>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69df935c-dbd3-492f-a32b-b00cc607a9a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '69df935c-dbd3-492f-a32b-b00cc607a9a4'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <가울라의 아마디지>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69df935c-dbd3-492f-a32b-b00cc607a9a4'
);


-- HWV 12 오페라 <라다미스토>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <라다미스토>', 'Opera <Radamisto>', 'song', 'HWV 12', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <라다미스토>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '63b760ca-db61-4ab4-b6e9-448fafa123eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '63b760ca-db61-4ab4-b6e9-448fafa123eb'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <라다미스토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '63b760ca-db61-4ab4-b6e9-448fafa123eb'
);


-- HWV 13 오페라 <무치오 셰볼라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <무치오 셰볼라>', 'Opera <Muzio Scevola> (Act III)', 'song', 'HWV 13', NULL, NULL, 1721, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <무치오 셰볼라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4e48fa2-3b1a-44bd-b58b-45b965a8d554'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4e48fa2-3b1a-44bd-b58b-45b965a8d554'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <무치오 셰볼라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4e48fa2-3b1a-44bd-b58b-45b965a8d554'
);


-- HWV 14 오페라 <플로리단테>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <플로리단테>', 'Opera <Floridante>', 'song', 'HWV 14', NULL, NULL, 1721, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <플로리단테>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc1c68c2-59c4-4a15-a362-119828929041'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc1c68c2-59c4-4a15-a362-119828929041'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <플로리단테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc1c68c2-59c4-4a15-a362-119828929041'
);


-- HWV 15 오페라 <오토네>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <오토네>', 'Opera <Ottone>', 'song', 'HWV 15', NULL, NULL, 1723, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <오토네>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49af6f4d-373b-4072-a6a5-d13c6434424b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '49af6f4d-373b-4072-a6a5-d13c6434424b'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <오토네>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49af6f4d-373b-4072-a6a5-d13c6434424b'
);


-- HWV 16 오페라 <플라비오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <플라비오>', 'Opera <Flavio>', 'song', 'HWV 16', NULL, NULL, 1723, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <플라비오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b372cf05-32d4-4b45-b7f4-90a0369e1d99'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b372cf05-32d4-4b45-b7f4-90a0369e1d99'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <플라비오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b372cf05-32d4-4b45-b7f4-90a0369e1d99'
);


-- HWV 17 오페라 <줄리오 체사레>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <줄리오 체사레>', 'Opera <Giulio Cesare in Egitto>', 'song', 'HWV 17', NULL, NULL, 1724, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <줄리오 체사레>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e600063c-b8bc-4141-a6ce-482c5d1f86b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e600063c-b8bc-4141-a6ce-482c5d1f86b3'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <줄리오 체사레>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e600063c-b8bc-4141-a6ce-482c5d1f86b3'
);


-- HWV 18 오페라 <타메를라노>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <타메를라노>', 'Opera <Tamerlano>', 'song', 'HWV 18', NULL, NULL, 1724, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <타메를라노>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41c450cf-80e6-4f46-bd0f-e7a413d36455'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '41c450cf-80e6-4f46-bd0f-e7a413d36455'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <타메를라노>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41c450cf-80e6-4f46-bd0f-e7a413d36455'
);


-- HWV 20 오페라 <시피오네>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <시피오네>', 'Opera <Scipione>', 'song', 'HWV 20', NULL, NULL, 1726, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <시피오네>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b6f304c-8412-4fe7-91fc-5283e4687849'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b6f304c-8412-4fe7-91fc-5283e4687849'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <시피오네>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b6f304c-8412-4fe7-91fc-5283e4687849'
);


-- HWV 21 오페라 <알레산드로>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <알레산드로>', 'Opera <Alessandro>', 'song', 'HWV 21', NULL, NULL, 1726, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <알레산드로>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00d9ae86-d9e9-4a61-8961-a6d35a064b20'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '00d9ae86-d9e9-4a61-8961-a6d35a064b20'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <알레산드로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00d9ae86-d9e9-4a61-8961-a6d35a064b20'
);


-- HWV 22 오페라 <아드메토>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아드메토>', 'Opera <Admeto>', 'song', 'HWV 22', NULL, NULL, 1727, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아드메토>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4187e2b5-cb2b-4058-95d7-25d8e71ec9ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4187e2b5-cb2b-4058-95d7-25d8e71ec9ba'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <아드메토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4187e2b5-cb2b-4058-95d7-25d8e71ec9ba'
);


-- HWV 23 오페라 <리카르도 1세>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <리카르도 1세>', 'Opera <Riccardo Primo>', 'song', 'HWV 23', NULL, NULL, 1727, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <리카르도 1세>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99460aa1-35e0-48c0-a71e-dc472b072cee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '99460aa1-35e0-48c0-a71e-dc472b072cee'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <리카르도 1세>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99460aa1-35e0-48c0-a71e-dc472b072cee'
);


-- HWV 24 오페라 <시로에>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <시로에>', 'Opera <Siroe>', 'song', 'HWV 24', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <시로에>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7bce2d6-5a0c-4723-8f51-3f31b735d2d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7bce2d6-5a0c-4723-8f51-3f31b735d2d5'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <시로에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7bce2d6-5a0c-4723-8f51-3f31b735d2d5'
);


-- HWV 25 오페라 <톨로메오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <톨로메오>', 'Opera <Tolomeo>', 'song', 'HWV 25', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <톨로메오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c52c9f9-aa51-4036-af85-9c4c8b49914a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c52c9f9-aa51-4036-af85-9c4c8b49914a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <톨로메오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c52c9f9-aa51-4036-af85-9c4c8b49914a'
);


-- HWV 26 오페라 <로타리오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <로타리오>', 'Opera <Lotario>', 'song', 'HWV 26', NULL, NULL, 1729, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <로타리오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f15cda35-94ad-43fd-a8bf-18ccbe013cf9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f15cda35-94ad-43fd-a8bf-18ccbe013cf9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <로타리오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f15cda35-94ad-43fd-a8bf-18ccbe013cf9'
);


-- HWV 27 오페라 <파르테노페>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <파르테노페>', 'Opera <Partenope>', 'song', 'HWV 27', NULL, NULL, 1730, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <파르테노페>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7401a421-18e5-4e46-8b49-8a7381dce059'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7401a421-18e5-4e46-8b49-8a7381dce059'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <파르테노페>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7401a421-18e5-4e46-8b49-8a7381dce059'
);


-- HWV 28 오페라 <포로>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <포로>', 'Opera <Poro>', 'song', 'HWV 28', NULL, NULL, 1731, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <포로>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0dc37fe-94a4-4784-87e7-6929fd511994'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c0dc37fe-94a4-4784-87e7-6929fd511994'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <포로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0dc37fe-94a4-4784-87e7-6929fd511994'
);


-- HWV 29 오페라 <에치오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <에치오>', 'Opera <Ezio>', 'song', 'HWV 29', NULL, NULL, 1732, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <에치오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ce8f17f-6250-482c-9ad2-8a2d95e562bb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ce8f17f-6250-482c-9ad2-8a2d95e562bb'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <에치오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ce8f17f-6250-482c-9ad2-8a2d95e562bb'
);


-- HWV 30 오페라 <소사르메>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <소사르메>', 'Opera <Sosarme>', 'song', 'HWV 30', NULL, NULL, 1732, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <소사르메>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c606c809-148b-4aaf-a580-edddb8a6f1e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c606c809-148b-4aaf-a580-edddb8a6f1e9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <소사르메>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c606c809-148b-4aaf-a580-edddb8a6f1e9'
);


-- HWV 31 오페라 <오를란도>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <오를란도>', 'Opera <Orlando>', 'song', 'HWV 31', NULL, NULL, 1733, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <오를란도>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6301c6e6-c072-40dc-ae00-3de80bacba68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6301c6e6-c072-40dc-ae00-3de80bacba68'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <오를란도>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6301c6e6-c072-40dc-ae00-3de80bacba68'
);


-- HWV 32 오페라 <크레타의 아리안나>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <크레타의 아리안나>', 'Opera <Arianna in Creta>', 'song', 'HWV 32', NULL, NULL, 1734, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <크레타의 아리안나>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5ba42d7-3013-4973-9579-ddb3579ac414'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5ba42d7-3013-4973-9579-ddb3579ac414'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <크레타의 아리안나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5ba42d7-3013-4973-9579-ddb3579ac414'
);


-- HWV A11 오페라 <오레스테>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <오레스테>', 'Opera <Oreste>', 'song', 'HWV A11', NULL, NULL, 1734, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <오레스테>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdf42e54-ac85-4101-85e1-2f12f7e07e41'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fdf42e54-ac85-4101-85e1-2f12f7e07e41'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <오레스테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdf42e54-ac85-4101-85e1-2f12f7e07e41'
);


-- HWV 33 오페라 <아리오단테>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아리오단테>', 'Opera <Ariodante>', 'song', 'HWV 33', NULL, NULL, 1735, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아리오단테>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dac625fa-bddc-4f45-8119-74239ef2a416'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dac625fa-bddc-4f45-8119-74239ef2a416'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <아리오단테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dac625fa-bddc-4f45-8119-74239ef2a416'
);


-- HWV 34 오페라 <알치나>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <알치나>', 'Opera <Alcina>', 'song', 'HWV 34', NULL, NULL, 1735, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <알치나>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf8b01c1-3ea9-4aeb-81e0-efcfc6773c9e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bf8b01c1-3ea9-4aeb-81e0-efcfc6773c9e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <알치나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf8b01c1-3ea9-4aeb-81e0-efcfc6773c9e'
);


-- HWV 35 오페라 <아탈란타>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아탈란타>', 'Opera <Atalanta>', 'song', 'HWV 35', NULL, NULL, 1736, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아탈란타>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '96f4182d-9065-446c-ba9b-a6a116294e81'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '96f4182d-9065-446c-ba9b-a6a116294e81'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <아탈란타>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '96f4182d-9065-446c-ba9b-a6a116294e81'
);


-- HWV 36 오페라 <아르미니오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아르미니오>', 'Opera <Arminio>', 'song', 'HWV 36', NULL, NULL, 1737, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아르미니오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8687c79e-698d-465b-acf2-e932044040c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8687c79e-698d-465b-acf2-e932044040c6'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <아르미니오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8687c79e-698d-465b-acf2-e932044040c6'
);


-- HWV 37 오페라 <주스티노>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <주스티노>', 'Opera <Giustino>', 'song', 'HWV 37', NULL, NULL, 1737, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <주스티노>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7d70810-bb65-4a0f-b68f-d290f88756dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f7d70810-bb65-4a0f-b68f-d290f88756dc'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <주스티노>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7d70810-bb65-4a0f-b68f-d290f88756dc'
);


-- HWV 38 오페라 <베레니체>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <베레니체>', 'Opera <Berenice>', 'song', 'HWV 38', NULL, NULL, 1737, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <베레니체>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc0d4878-e485-424c-ab14-d5d282b06c81'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc0d4878-e485-424c-ab14-d5d282b06c81'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <베레니체>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc0d4878-e485-424c-ab14-d5d282b06c81'
);


-- HWV 39 오페라 <파라몬도>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <파라몬도>', 'Opera <Faramondo>', 'song', 'HWV 39', NULL, NULL, 1738, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <파라몬도>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e26cd08-fa83-4f06-8f77-214ad10245d6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1e26cd08-fa83-4f06-8f77-214ad10245d6'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <파라몬도>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e26cd08-fa83-4f06-8f77-214ad10245d6'
);


-- HWV A13 오페라 <알레산드로 세베로>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <알레산드로 세베로>', 'Opera <Alessandro Severo>', 'song', 'HWV A13', NULL, NULL, 1738, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <알레산드로 세베로>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e822d3b8-ce54-4379-a498-45cb83d7b933'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e822d3b8-ce54-4379-a498-45cb83d7b933'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <알레산드로 세베로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e822d3b8-ce54-4379-a498-45cb83d7b933'
);


-- HWV 40 오페라 <세르세>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <세르세>', 'Opera <Serse>', 'song', 'HWV 40', NULL, NULL, 1738, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <세르세>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '813a0567-48aa-40d1-8171-074cd9a7647d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '813a0567-48aa-40d1-8171-074cd9a7647d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <세르세>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '813a0567-48aa-40d1-8171-074cd9a7647d'
);


-- HWV A14 오페라 <아르고의 조베>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아르고의 조베>', 'Opera <Giove in Argo>', 'song', 'HWV A14', NULL, NULL, 1739, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아르고의 조베>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08b3269c-fd90-4378-b1f6-ef0035f4e379'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '08b3269c-fd90-4378-b1f6-ef0035f4e379'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <아르고의 조베>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08b3269c-fd90-4378-b1f6-ef0035f4e379'
);


-- HWV 41 오페라 <이메네오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <이메네오>', 'Opera <Imeneo>', 'song', 'HWV 41', NULL, NULL, 1740, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <이메네오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0af2d9a-409f-491f-aa73-efdd83a07514'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a0af2d9a-409f-491f-aa73-efdd83a07514'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <이메네오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0af2d9a-409f-491f-aa73-efdd83a07514'
);


-- HWV 42 오페라 <데이다미아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <데이다미아>', 'Opera <Deidamia>', 'song', 'HWV 42', NULL, NULL, 1741, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <데이다미아>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fce0602a-b948-4bd3-9653-b8fc47bc95c3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fce0602a-b948-4bd3-9653-b8fc47bc95c3'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오페라 <데이다미아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fce0602a-b948-4bd3-9653-b8fc47bc95c3'
);


-- HWV 44 부수음악 <코머스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <코머스>', 'Incidental Music <Comus>', 'song', 'HWV 44', NULL, NULL, 1745, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <코머스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed1c98a7-9afb-4930-9a99-91a4038ad01b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed1c98a7-9afb-4930-9a99-91a4038ad01b'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '부수음악 <코머스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed1c98a7-9afb-4930-9a99-91a4038ad01b'
);


-- HWV 45 부수음악 <알체스테>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <알체스테>', 'Incidental Music <Alceste>', 'song', 'HWV 45', NULL, NULL, 1750, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <알체스테>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef184d24-d160-4719-90d4-1663be189bf1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ef184d24-d160-4719-90d4-1663be189bf1'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '부수음악 <알체스테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef184d24-d160-4719-90d4-1663be189bf1'
);


-- HWV 218 가곡 <Love's but the frailty of the mind>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Love''s but the frailty of the mind>', 'Song <Love''s but the frailty of the mind>', 'song', 'HWV 218', NULL, NULL, 1740, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Love''s but the frailty of the mind>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '893af1b5-c5f0-4c63-b3c5-cec3d47adfdb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '893af1b5-c5f0-4c63-b3c5-cec3d47adfdb'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '가곡 <Love''s but the frailty of the mind>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '893af1b5-c5f0-4c63-b3c5-cec3d47adfdb'
);


-- HWV 46a 오라토리오 <시간과 깨달음의 승리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <시간과 깨달음의 승리>', 'Oratorio <Il trionfo del Tempo e del Disinganno>', 'song', 'HWV 46a', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <시간과 깨달음의 승리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08d743b7-159a-4176-bc1f-a4dc5aeb84c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '08d743b7-159a-4176-bc1f-a4dc5aeb84c6'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <시간과 깨달음의 승리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08d743b7-159a-4176-bc1f-a4dc5aeb84c6'
);


-- HWV 47 오라토리오 <부활>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <부활>', 'Oratorio <La resurrezione>', 'song', 'HWV 47', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <부활>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c650cc06-0db6-46b2-b759-1890d3b84483'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c650cc06-0db6-46b2-b759-1890d3b84483'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <부활>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c650cc06-0db6-46b2-b759-1890d3b84483'
);


-- HWV 48 브로케스 수난곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '브로케스 수난곡', 'Brockes Passion', 'song', 'HWV 48', NULL, NULL, 1719, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '브로케스 수난곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df0b7a5f-0534-4deb-aa85-b6ad7720a62c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df0b7a5f-0534-4deb-aa85-b6ad7720a62c'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '브로케스 수난곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df0b7a5f-0534-4deb-aa85-b6ad7720a62c'
);


-- HWV 50a 가면극 <에스더>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가면극 <에스더>', 'Masque <Esther>', 'song', 'HWV 50a', NULL, NULL, 1718, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가면극 <에스더>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ec22666-2dd4-45ea-bb75-6fa49b366dc7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8ec22666-2dd4-45ea-bb75-6fa49b366dc7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '가면극 <에스더>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ec22666-2dd4-45ea-bb75-6fa49b366dc7'
);


-- HWV 50b 오라토리오 <에스더>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <에스더>', 'Oratorio <Esther>', 'song', 'HWV 50b', NULL, NULL, 1732, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <에스더>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '840d4261-d2e3-4311-b0e4-4b5cbad50335'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '840d4261-d2e3-4311-b0e4-4b5cbad50335'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <에스더>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '840d4261-d2e3-4311-b0e4-4b5cbad50335'
);


-- HWV 51 오라토리오 <드보라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <드보라>', 'Oratorio <Deborah>', 'song', 'HWV 51', NULL, NULL, 1733, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <드보라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '795539ca-12a8-4b46-9e28-56f6dcb7e1c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '795539ca-12a8-4b46-9e28-56f6dcb7e1c8'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <드보라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '795539ca-12a8-4b46-9e28-56f6dcb7e1c8'
);


-- HWV 52 오라토리오 <아탈리아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <아탈리아>', 'Oratorio <Athalia>', 'song', 'HWV 52', NULL, NULL, 1733, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <아탈리아>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69ca10b0-ae9b-436c-b000-b6c34f587377'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '69ca10b0-ae9b-436c-b000-b6c34f587377'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <아탈리아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69ca10b0-ae9b-436c-b000-b6c34f587377'
);


-- HWV 53 오라토리오 <사울>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <사울>', 'Oratorio <Saul>', 'song', 'HWV 53', NULL, NULL, 1739, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <사울>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04c12f4d-599c-4d27-aa29-a98005c1bdd6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '04c12f4d-599c-4d27-aa29-a98005c1bdd6'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <사울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04c12f4d-599c-4d27-aa29-a98005c1bdd6'
);


-- HWV 54 오라토리오 <이집트의 이스라엘인>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <이집트의 이스라엘인>', 'Oratorio <Israel in Egypt>', 'song', 'HWV 54', NULL, NULL, 1739, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <이집트의 이스라엘인>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69bbb63f-f19d-4eb7-9b6a-19cbc407935c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '69bbb63f-f19d-4eb7-9b6a-19cbc407935c'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <이집트의 이스라엘인>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69bbb63f-f19d-4eb7-9b6a-19cbc407935c'
);


-- HWV 55 오라토리오 <L'Allegro, il Penseroso ed il Moderato>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <L''Allegro, il Penseroso ed il Moderato>', 'Oratorio <L''Allegro, il Penseroso ed il Moderato>', 'song', 'HWV 55', NULL, NULL, 1740, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <L''Allegro, il Penseroso ed il Moderato>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a50d8fc9-a899-4bcd-8c20-865e75a473bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a50d8fc9-a899-4bcd-8c20-865e75a473bf'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <L''Allegro, il Penseroso ed il Moderato>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a50d8fc9-a899-4bcd-8c20-865e75a473bf'
);


-- HWV 57 오라토리오 <삼손>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <삼손>', 'Oratorio <Samson>', 'song', 'HWV 57', NULL, NULL, 1743, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <삼손>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9990fe5-f40b-4226-b10f-ac090cc79440'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd9990fe5-f40b-4226-b10f-ac090cc79440'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <삼손>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9990fe5-f40b-4226-b10f-ac090cc79440'
);


-- HWV 58 오라토리오 <세멜레>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <세멜레>', 'Oratorio <Semele>', 'song', 'HWV 58', NULL, NULL, 1744, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <세멜레>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '232d9cf8-792b-4128-8e21-9bd1d0a45dba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '232d9cf8-792b-4128-8e21-9bd1d0a45dba'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <세멜레>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '232d9cf8-792b-4128-8e21-9bd1d0a45dba'
);


-- HWV 59 오라토리오 <요셉과 그 형제들>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <요셉과 그 형제들>', 'Oratorio <Joseph and his Brethren>', 'song', 'HWV 59', NULL, NULL, 1744, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <요셉과 그 형제들>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed996919-8bd9-4311-9583-08da159d5edd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed996919-8bd9-4311-9583-08da159d5edd'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <요셉과 그 형제들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed996919-8bd9-4311-9583-08da159d5edd'
);


-- HWV 60 오라토리오 <헤라클레스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <헤라클레스>', 'Oratorio <Hercules>', 'song', 'HWV 60', NULL, NULL, 1745, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <헤라클레스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb0f49e5-5f32-4d38-a8ce-e2f5a75c0cef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb0f49e5-5f32-4d38-a8ce-e2f5a75c0cef'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <헤라클레스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb0f49e5-5f32-4d38-a8ce-e2f5a75c0cef'
);


-- HWV 61 오라토리오 <벨사살>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <벨사살>', 'Oratorio <Belshazzar>', 'song', 'HWV 61', NULL, NULL, 1745, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <벨사살>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e0fdf2a-084c-4f32-acd2-040f1073cd51'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e0fdf2a-084c-4f32-acd2-040f1073cd51'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <벨사살>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e0fdf2a-084c-4f32-acd2-040f1073cd51'
);


-- HWV 62 오라토리오 <The Occasional Oratorio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <The Occasional Oratorio>', 'Oratorio <The Occasional Oratorio>', 'song', 'HWV 62', NULL, NULL, 1746, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <The Occasional Oratorio>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86e32a61-bd63-46ed-86b0-454dcb583437'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86e32a61-bd63-46ed-86b0-454dcb583437'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <The Occasional Oratorio>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86e32a61-bd63-46ed-86b0-454dcb583437'
);


-- HWV 63 오라토리오 <유다스 마카베우스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <유다스 마카베우스>', 'Oratorio <Judas Maccabaeus>', 'song', 'HWV 63', NULL, NULL, 1747, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <유다스 마카베우스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54c55f97-7fbb-4f2f-9c39-5c02b0624131'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '54c55f97-7fbb-4f2f-9c39-5c02b0624131'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <유다스 마카베우스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54c55f97-7fbb-4f2f-9c39-5c02b0624131'
);


-- HWV 64 오라토리오 <여호수아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <여호수아>', 'Oratorio <Joshua>', 'song', 'HWV 64', NULL, NULL, 1748, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <여호수아>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b17cc510-97de-4d93-82c4-c3e2c5f22a32'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b17cc510-97de-4d93-82c4-c3e2c5f22a32'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <여호수아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b17cc510-97de-4d93-82c4-c3e2c5f22a32'
);


-- HWV 65 오라토리오 <알렉산더 발루스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <알렉산더 발루스>', 'Oratorio <Alexander Balus>', 'song', 'HWV 65', NULL, NULL, 1748, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <알렉산더 발루스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e110c16-5965-4a1f-8cbf-58711e707c8f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8e110c16-5965-4a1f-8cbf-58711e707c8f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <알렉산더 발루스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e110c16-5965-4a1f-8cbf-58711e707c8f'
);


-- HWV 66 오라토리오 <수산나>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <수산나>', 'Oratorio <Susanna>', 'song', 'HWV 66', NULL, NULL, 1749, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <수산나>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ca0c5c8-e2c0-4a57-81ac-a33ddfd8d217'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ca0c5c8-e2c0-4a57-81ac-a33ddfd8d217'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <수산나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ca0c5c8-e2c0-4a57-81ac-a33ddfd8d217'
);


-- HWV 67 오라토리오 <솔로몬>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <솔로몬>', 'Oratorio <Solomon>', 'song', 'HWV 67', NULL, NULL, 1749, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <솔로몬>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49f69c8f-e187-4210-8798-2f9a52280ea4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '49f69c8f-e187-4210-8798-2f9a52280ea4'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <솔로몬>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49f69c8f-e187-4210-8798-2f9a52280ea4'
);


-- HWV 68 오라토리오 <테오도라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <테오도라>', 'Oratorio <Theodora>', 'song', 'HWV 68', NULL, NULL, 1750, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <테오도라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '500f2074-f9af-4b7f-b03a-e2ebba8c6ae1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '500f2074-f9af-4b7f-b03a-e2ebba8c6ae1'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <테오도라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '500f2074-f9af-4b7f-b03a-e2ebba8c6ae1'
);


-- HWV 69 오라토리오 <헤라클레스의 선택>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <헤라클레스의 선택>', 'Oratorio <The Choice of Hercules>', 'song', 'HWV 69', NULL, NULL, 1751, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <헤라클레스의 선택>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64d1830d-2b3f-4d5c-8880-2e17d5f437e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64d1830d-2b3f-4d5c-8880-2e17d5f437e1'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <헤라클레스의 선택>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64d1830d-2b3f-4d5c-8880-2e17d5f437e1'
);


-- HWV 70 오라토리오 <입다>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <입다>', 'Oratorio <Jephtha>', 'song', 'HWV 70', NULL, NULL, 1752, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <입다>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b36b3ee-5e1d-4f75-a7f2-ee68dafe8106'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6b36b3ee-5e1d-4f75-a7f2-ee68dafe8106'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <입다>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b36b3ee-5e1d-4f75-a7f2-ee68dafe8106'
);


-- HWV 71 오라토리오 <시간과 진리의 승리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <시간과 진리의 승리>', 'Oratorio <The Triumph of Time and Truth>', 'song', 'HWV 71', NULL, NULL, 1757, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <시간과 진리의 승리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2242c03-e7f1-4a17-aba8-192f24be9400'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b2242c03-e7f1-4a17-aba8-192f24be9400'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오라토리오 <시간과 진리의 승리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2242c03-e7f1-4a17-aba8-192f24be9400'
);


-- HWV 49a 가면극 <아시스와 갈라테아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가면극 <아시스와 갈라테아>', 'Masque <Acis and Galatea>', 'song', 'HWV 49a', NULL, NULL, 1718, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가면극 <아시스와 갈라테아>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecfd048e-1604-4abc-8494-0ab9732c155c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ecfd048e-1604-4abc-8494-0ab9732c155c'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '가면극 <아시스와 갈라테아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecfd048e-1604-4abc-8494-0ab9732c155c'
);


-- HWV 72 세레나타 <아치, 갈라테아와 폴리페모>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나타 <아치, 갈라테아와 폴리페모>', 'Serenata <Aci, Galatea e Polifemo>', 'song', 'HWV 72', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나타 <아치, 갈라테아와 폴리페모>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47ae9efa-064c-4cf9-996a-a0e1853eb38f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47ae9efa-064c-4cf9-996a-a0e1853eb38f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '세레나타 <아치, 갈라테아와 폴리페모>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47ae9efa-064c-4cf9-996a-a0e1853eb38f'
);


-- HWV 73 세레나타 <파르나소스의 축제>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나타 <파르나소스의 축제>', 'Serenata <Parnasso in festa>', 'song', 'HWV 73', NULL, NULL, 1734, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나타 <파르나소스의 축제>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da91d08f-23bf-4986-aa6f-0af520ae55e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'da91d08f-23bf-4986-aa6f-0af520ae55e9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '세레나타 <파르나소스의 축제>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da91d08f-23bf-4986-aa6f-0af520ae55e9'
);


-- HWV 74 앤 여왕 탄신 송가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앤 여왕 탄신 송가', 'Ode for the Birthday of Queen Anne', 'song', 'HWV 74', NULL, NULL, 1713, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앤 여왕 탄신 송가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38a807f2-eb4c-4799-8385-5b8d0fa111c5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38a807f2-eb4c-4799-8385-5b8d0fa111c5'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '앤 여왕 탄신 송가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38a807f2-eb4c-4799-8385-5b8d0fa111c5'
);


-- HWV 75 송가 <알렉산더의 향연>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '송가 <알렉산더의 향연>', 'Ode <Alexander''s Feast>', 'song', 'HWV 75', NULL, NULL, 1736, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '송가 <알렉산더의 향연>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd885e574-bb83-437b-9058-7a69d96911ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd885e574-bb83-437b-9058-7a69d96911ff'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '송가 <알렉산더의 향연>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd885e574-bb83-437b-9058-7a69d96911ff'
);


-- HWV 76 성 체칠리아의 날을 위한 송가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성 체칠리아의 날을 위한 송가', 'Ode for St. Cecilia''s Day', 'song', 'HWV 76', NULL, NULL, 1739, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성 체칠리아의 날을 위한 송가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bc6eabf-0495-43c1-ac5c-193c216ef5f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5bc6eabf-0495-43c1-ac5c-193c216ef5f8'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '성 체칠리아의 날을 위한 송가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bc6eabf-0495-43c1-ac5c-193c216ef5f8'
);


-- HWV 77 칸타타 <Ah che pur troppo è vero>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Ah che pur troppo è vero>', 'Cantata <Ah che pur troppo è vero>', 'song', 'HWV 77', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Ah che pur troppo è vero>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6df14ff-b1ee-4913-82bb-8dd0fdce7f7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e6df14ff-b1ee-4913-82bb-8dd0fdce7f7d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Ah che pur troppo è vero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6df14ff-b1ee-4913-82bb-8dd0fdce7f7d'
);


-- HWV 78 칸타타 <Ah! crudel, nel pianto mio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Ah! crudel, nel pianto mio>', 'Cantata <Ah! crudel, nel pianto mio>', 'song', 'HWV 78', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Ah! crudel, nel pianto mio>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a229192-7c2f-4d96-8403-90f7a22226d0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7a229192-7c2f-4d96-8403-90f7a22226d0'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Ah! crudel, nel pianto mio>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a229192-7c2f-4d96-8403-90f7a22226d0'
);


-- HWV 79 칸타타 <Diana cacciatrice>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Diana cacciatrice>', 'Cantata <Diana cacciatrice>', 'song', 'HWV 79', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Diana cacciatrice>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4bc7ee7-8d3c-43fc-b202-8931d4853139'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c4bc7ee7-8d3c-43fc-b202-8931d4853139'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Diana cacciatrice>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4bc7ee7-8d3c-43fc-b202-8931d4853139'
);


-- HWV 80 칸타타 <Allor ch'io dissi addio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Allor ch''io dissi addio>', 'Cantata <Allor ch''io dissi addio>', 'song', 'HWV 80', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Allor ch''io dissi addio>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '056e9dbb-ae3d-4eb0-a2ed-9b4f705785ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '056e9dbb-ae3d-4eb0-a2ed-9b4f705785ff'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Allor ch''io dissi addio>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '056e9dbb-ae3d-4eb0-a2ed-9b4f705785ff'
);


-- HWV 81 칸타타 <Alpestre monte>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Alpestre monte>', 'Cantata <Alpestre monte>', 'song', 'HWV 81', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Alpestre monte>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc0accff-e1cf-44a0-bed7-6f186959480a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc0accff-e1cf-44a0-bed7-6f186959480a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Alpestre monte>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc0accff-e1cf-44a0-bed7-6f186959480a'
);


-- HWV 82 칸타타 <Amarilli vezzosa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Amarilli vezzosa>', 'Cantata <Amarilli vezzosa>', 'song', 'HWV 82', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Amarilli vezzosa>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29126e4b-f566-4990-8a3e-a7f8d3b0bc5d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '29126e4b-f566-4990-8a3e-a7f8d3b0bc5d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Amarilli vezzosa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29126e4b-f566-4990-8a3e-a7f8d3b0bc5d'
);


-- HWV 83 칸타타 <Aminta e Fillide>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Aminta e Fillide>', 'Cantata <Aminta e Fillide>', 'song', 'HWV 83', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Aminta e Fillide>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '794a392a-d884-4662-adc2-793ff423f77e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '794a392a-d884-4662-adc2-793ff423f77e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Aminta e Fillide>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '794a392a-d884-4662-adc2-793ff423f77e'
);


-- HWV 84 칸타타 <Aure soavi e lieti>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Aure soavi e lieti>', 'Cantata <Aure soavi e lieti>', 'song', 'HWV 84', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Aure soavi e lieti>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18a26e99-469b-4f52-bdce-d8983d956159'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '18a26e99-469b-4f52-bdce-d8983d956159'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Aure soavi e lieti>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18a26e99-469b-4f52-bdce-d8983d956159'
);


-- HWV 86 칸타타 <Bella ma ritrosetta>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Bella ma ritrosetta>', 'Cantata <Bella ma ritrosetta>', 'song', 'HWV 86', NULL, NULL, 1718, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Bella ma ritrosetta>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f3cd416-568b-41ef-8fda-6098546d4dab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0f3cd416-568b-41ef-8fda-6098546d4dab'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Bella ma ritrosetta>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f3cd416-568b-41ef-8fda-6098546d4dab'
);


-- HWV 88 칸타타 <Care selve, aure grate>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Care selve, aure grate>', 'Cantata <Care selve, aure grate>', 'song', 'HWV 88', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Care selve, aure grate>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87f75331-ef0a-433e-8666-6a846e5bd8f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '87f75331-ef0a-433e-8666-6a846e5bd8f8'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Care selve, aure grate>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87f75331-ef0a-433e-8666-6a846e5bd8f8'
);


-- HWV 89 칸타타 <Cecilia, volgi un sguardo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Cecilia, volgi un sguardo>', 'Cantata <Cecilia, volgi un sguardo>', 'song', 'HWV 89', NULL, NULL, 1736, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Cecilia, volgi un sguardo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '602ba8bf-4109-4840-9331-ed804a70862e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '602ba8bf-4109-4840-9331-ed804a70862e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Cecilia, volgi un sguardo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '602ba8bf-4109-4840-9331-ed804a70862e'
);


-- HWV 90 칸타타 <Chi rapì la pace al core>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Chi rapì la pace al core>', 'Cantata <Chi rapì la pace al core>', 'song', 'HWV 90', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Chi rapì la pace al core>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92ad8359-ce05-47a5-a057-c9b6f3c59cbd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '92ad8359-ce05-47a5-a057-c9b6f3c59cbd'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Chi rapì la pace al core>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92ad8359-ce05-47a5-a057-c9b6f3c59cbd'
);


-- HWV 91b 칸타타 <Clori, degli occhi miei>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Clori, degli occhi miei>', 'Cantata <Clori, degli occhi miei>', 'song', 'HWV 91b', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Clori, degli occhi miei>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b4ca4d2-1ea5-49a1-bbbf-725a4237bb1a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3b4ca4d2-1ea5-49a1-bbbf-725a4237bb1a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Clori, degli occhi miei>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b4ca4d2-1ea5-49a1-bbbf-725a4237bb1a'
);


-- HWV 92 칸타타 <Clori, mia bella Clori>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Clori, mia bella Clori>', 'Cantata <Clori, mia bella Clori>', 'song', 'HWV 92', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Clori, mia bella Clori>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8016ff39-fc55-47ca-80d1-ce02fe486b32'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8016ff39-fc55-47ca-80d1-ce02fe486b32'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Clori, mia bella Clori>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8016ff39-fc55-47ca-80d1-ce02fe486b32'
);


-- HWV 93 칸타타 <Clori, ove sei?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Clori, ove sei?>', 'Cantata <Clori, ove sei?>', 'song', 'HWV 93', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Clori, ove sei?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19985b53-2217-4478-b186-90bd06c78ad7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '19985b53-2217-4478-b186-90bd06c78ad7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Clori, ove sei?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19985b53-2217-4478-b186-90bd06c78ad7'
);


-- HWV 94 칸타타 <Clori, si, ch'io t'adoro>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Clori, si, ch''io t''adoro>', 'Cantata <Clori, si, ch''io t''adoro>', 'song', 'HWV 94', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Clori, si, ch''io t''adoro>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b9dd2ff-9af1-4481-813b-3c9b69069ccc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b9dd2ff-9af1-4481-813b-3c9b69069ccc'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Clori, si, ch''io t''adoro>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b9dd2ff-9af1-4481-813b-3c9b69069ccc'
);


-- HWV 95 칸타타 <Clori, vezzosa Clori>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Clori, vezzosa Clori>', 'Cantata <Clori, vezzosa Clori>', 'song', 'HWV 95', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Clori, vezzosa Clori>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '835980db-8fe2-46c3-828c-b5048cadc2ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '835980db-8fe2-46c3-828c-b5048cadc2ec'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Clori, vezzosa Clori>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '835980db-8fe2-46c3-828c-b5048cadc2ec'
);


-- HWV 96 칸타타 <Clori, Tirsi e Fileno>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Clori, Tirsi e Fileno>', 'Cantata <Clori, Tirsi e Fileno>', 'song', 'HWV 96', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Clori, Tirsi e Fileno>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99f5ead4-89a3-4788-b712-f321f0f9788e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '99f5ead4-89a3-4788-b712-f321f0f9788e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Clori, Tirsi e Fileno>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99f5ead4-89a3-4788-b712-f321f0f9788e'
);


-- HWV 97 칸타타 <Crudel tiranno Amor>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Crudel tiranno Amor>', 'Cantata <Crudel tiranno Amor>', 'song', 'HWV 97', NULL, NULL, 1721, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Crudel tiranno Amor>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '870416b7-1dca-49aa-8351-7da6106288bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '870416b7-1dca-49aa-8351-7da6106288bf'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Crudel tiranno Amor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '870416b7-1dca-49aa-8351-7da6106288bf'
);


-- HWV 98 칸타타 <Cuopre tal volta il cielo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Cuopre tal volta il cielo>', 'Cantata <Cuopre tal volta il cielo>', 'song', 'HWV 98', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Cuopre tal volta il cielo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '305e304a-d87b-4928-a90c-ffe8721218d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '305e304a-d87b-4928-a90c-ffe8721218d5'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Cuopre tal volta il cielo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '305e304a-d87b-4928-a90c-ffe8721218d5'
);


-- HWV 99 칸타타 <Il delirio amoroso>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Il delirio amoroso>', 'Cantata <Il delirio amoroso>', 'song', 'HWV 99', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Il delirio amoroso>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e61affd9-4118-4c1e-ab23-f902b0c67650'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e61affd9-4118-4c1e-ab23-f902b0c67650'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Il delirio amoroso>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e61affd9-4118-4c1e-ab23-f902b0c67650'
);


-- HWV 100 칸타타 <Da sete ardente afflitto>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Da sete ardente afflitto>', 'Cantata <Da sete ardente afflitto>', 'song', 'HWV 100', NULL, NULL, 1709, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Da sete ardente afflitto>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '383d4c22-ef7d-4aa3-9159-6e8131c3bead'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '383d4c22-ef7d-4aa3-9159-6e8131c3bead'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Da sete ardente afflitto>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '383d4c22-ef7d-4aa3-9159-6e8131c3bead'
);


-- HWV 102b 칸타타 <Dalla guerra amorosa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Dalla guerra amorosa>', 'Cantata <Dalla guerra amorosa>', 'song', 'HWV 102b', NULL, NULL, 1709, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Dalla guerra amorosa>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41bc0286-81ae-495b-9b38-59375e55f6b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '41bc0286-81ae-495b-9b38-59375e55f6b8'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Dalla guerra amorosa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41bc0286-81ae-495b-9b38-59375e55f6b8'
);


-- HWV 103 칸타타 <Deh! lasciate e vita e volo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Deh! lasciate e vita e volo>', 'Cantata <Deh! lasciate e vita e volo>', 'song', 'HWV 103', NULL, NULL, 1725, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Deh! lasciate e vita e volo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf85eda2-6186-4771-8aef-3e2a589a99f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bf85eda2-6186-4771-8aef-3e2a589a99f9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Deh! lasciate e vita e volo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf85eda2-6186-4771-8aef-3e2a589a99f9'
);


-- HWV 104 칸타타 <Del bell'idolo mio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Del bell''idolo mio>', 'Cantata <Del bell''idolo mio>', 'song', 'HWV 104', NULL, NULL, 1709, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Del bell''idolo mio>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dd30e21-4583-49a7-8b15-98c4fd85c69b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2dd30e21-4583-49a7-8b15-98c4fd85c69b'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Del bell''idolo mio>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dd30e21-4583-49a7-8b15-98c4fd85c69b'
);


-- HWV 105 칸타타 <Armida abbandonata>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Armida abbandonata>', 'Cantata <Armida abbandonata>', 'song', 'HWV 105', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Armida abbandonata>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56cfb3f0-8327-4ba3-9e45-af5594286b53'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56cfb3f0-8327-4ba3-9e45-af5594286b53'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Armida abbandonata>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56cfb3f0-8327-4ba3-9e45-af5594286b53'
);


-- HWV 106 칸타타 <Dimmi, o mio cor>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Dimmi, o mio cor>', 'Cantata <Dimmi, o mio cor>', 'song', 'HWV 106', NULL, NULL, 1709, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Dimmi, o mio cor>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '856e7649-922b-46d6-8a2a-f13d47faf7ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '856e7649-922b-46d6-8a2a-f13d47faf7ba'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Dimmi, o mio cor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '856e7649-922b-46d6-8a2a-f13d47faf7ba'
);


-- HWV 107 칸타타 <Ditemi, o piante>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Ditemi, o piante>', 'Cantata <Ditemi, o piante>', 'song', 'HWV 107', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Ditemi, o piante>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe356820-fc20-4196-83c4-c68524730fc1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fe356820-fc20-4196-83c4-c68524730fc1'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Ditemi, o piante>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe356820-fc20-4196-83c4-c68524730fc1'
);


-- HWV 109b 칸타타 <Dolc'è pur d'amor l'affanno>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Dolc''è pur d''amor l''affanno>', 'Cantata <Dolc''è pur d''amor l''affanno>', 'song', 'HWV 109b', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Dolc''è pur d''amor l''affanno>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '754f2b91-ad6e-4e7e-ba19-11e3eb43e4e2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '754f2b91-ad6e-4e7e-ba19-11e3eb43e4e2'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Dolc''è pur d''amor l''affanno>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '754f2b91-ad6e-4e7e-ba19-11e3eb43e4e2'
);


-- HWV 110 칸타타 <Agrippina condotta a morire>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Agrippina condotta a morire>', 'Cantata <Agrippina condotta a morire>', 'song', 'HWV 110', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Agrippina condotta a morire>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6036def-ff00-427f-be78-3836b3659df6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e6036def-ff00-427f-be78-3836b3659df6'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Agrippina condotta a morire>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6036def-ff00-427f-be78-3836b3659df6'
);


-- HWV 111b 칸타타 <E partirai, mia vita?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <E partirai, mia vita?>', 'Cantata <E partirai, mia vita?>', 'song', 'HWV 111b', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <E partirai, mia vita?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c40d8539-767e-472e-9bee-d055891115ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c40d8539-767e-472e-9bee-d055891115ba'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <E partirai, mia vita?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c40d8539-767e-472e-9bee-d055891115ba'
);


-- HWV 112 칸타타 <Figli del mesto cor>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Figli del mesto cor>', 'Cantata <Figli del mesto cor>', 'song', 'HWV 112', NULL, NULL, 1709, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Figli del mesto cor>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5ea236f-3f57-4e5f-a240-e7718d47e196'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c5ea236f-3f57-4e5f-a240-e7718d47e196'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Figli del mesto cor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5ea236f-3f57-4e5f-a240-e7718d47e196'
);


-- HWV 113 칸타타 <Figlio d'alte speranze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Figlio d''alte speranze>', 'Cantata <Figlio d''alte speranze>', 'song', 'HWV 113', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Figlio d''alte speranze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15f916bb-8b56-40ea-b458-eef466562ba6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '15f916bb-8b56-40ea-b458-eef466562ba6'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Figlio d''alte speranze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15f916bb-8b56-40ea-b458-eef466562ba6'
);


-- HWV 114 칸타타 <Filli adorata e cara>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Filli adorata e cara>', 'Cantata <Filli adorata e cara>', 'song', 'HWV 114', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Filli adorata e cara>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0033e58-0d39-4786-ad26-dabf71fe1dd8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c0033e58-0d39-4786-ad26-dabf71fe1dd8'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Filli adorata e cara>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0033e58-0d39-4786-ad26-dabf71fe1dd8'
);


-- HWV 115 칸타타 <Fra pensieri quel pensiero>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Fra pensieri quel pensiero>', 'Cantata <Fra pensieri quel pensiero>', 'song', 'HWV 115', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Fra pensieri quel pensiero>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c4a0955-c693-4a93-946a-31e6f68861f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c4a0955-c693-4a93-946a-31e6f68861f1'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Fra pensieri quel pensiero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c4a0955-c693-4a93-946a-31e6f68861f1'
);


-- HWV 116 칸타타 <Fra tante pene>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Fra tante pene>', 'Cantata <Fra tante pene>', 'song', 'HWV 116', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Fra tante pene>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff090e91-62f5-4e51-b949-3b649e96975c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ff090e91-62f5-4e51-b949-3b649e96975c'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Fra tante pene>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff090e91-62f5-4e51-b949-3b649e96975c'
);


-- HWV 117 칸타타 <Hendel, non può mia musa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Hendel, non può mia musa>', 'Cantata <Hendel, non può mia musa>', 'song', 'HWV 117', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Hendel, non può mia musa>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec960af1-3d03-4eeb-bec9-56a5a8ca0fc2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec960af1-3d03-4eeb-bec9-56a5a8ca0fc2'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Hendel, non può mia musa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec960af1-3d03-4eeb-bec9-56a5a8ca0fc2'
);


-- HWV 118 칸타타 <Ho fuggito Amore anch'io>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Ho fuggito Amore anch''io>', 'Cantata <Ho fuggito Amore anch''io>', 'song', 'HWV 118', NULL, NULL, 1723, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Ho fuggito Amore anch''io>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3ac35b7-9f23-4b5c-b177-0beffb6b5ae1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e3ac35b7-9f23-4b5c-b177-0beffb6b5ae1'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Ho fuggito Amore anch''io>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3ac35b7-9f23-4b5c-b177-0beffb6b5ae1'
);


-- HWV 120b 칸타타 <Irene, idolo mio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Irene, idolo mio>', 'Cantata <Irene, idolo mio>', 'song', 'HWV 120b', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Irene, idolo mio>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6fb21441-6917-4bb2-8147-589fc8a6175b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6fb21441-6917-4bb2-8147-589fc8a6175b'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Irene, idolo mio>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6fb21441-6917-4bb2-8147-589fc8a6175b'
);


-- HWV 121b 칸타타 <La Solitudine>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <La Solitudine>', 'Cantata <La Solitudine>', 'song', 'HWV 121b', NULL, NULL, 1718, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <La Solitudine>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e07d767-ffca-43f7-97c9-1f4fe98e55ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8e07d767-ffca-43f7-97c9-1f4fe98e55ff'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <La Solitudine>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e07d767-ffca-43f7-97c9-1f4fe98e55ff'
);


-- HWV 122 칸타타 <Apollo e Dafne>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Apollo e Dafne>', 'Cantata <Apollo e Dafne>', 'song', 'HWV 122', NULL, NULL, 1710, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Apollo e Dafne>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c951277-989b-45e2-8754-fa04725e3367'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c951277-989b-45e2-8754-fa04725e3367'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Apollo e Dafne>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c951277-989b-45e2-8754-fa04725e3367'
);


-- HWV 125b 칸타타 <Lungi da me, pensier tiranno>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Lungi da me, pensier tiranno>', 'Cantata <Lungi da me, pensier tiranno>', 'song', 'HWV 125b', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Lungi da me, pensier tiranno>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9d5a7d5-0568-4fd0-8adc-1c2f28a36158'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9d5a7d5-0568-4fd0-8adc-1c2f28a36158'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Lungi da me, pensier tiranno>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9d5a7d5-0568-4fd0-8adc-1c2f28a36158'
);


-- HWV 126c 칸타타 <Lungi da voi, che siete poli>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Lungi da voi, che siete poli>', 'Cantata <Lungi da voi, che siete poli>', 'song', 'HWV 126c', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Lungi da voi, che siete poli>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c52d2417-44e1-4d19-9133-e2d7bdd7a6f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c52d2417-44e1-4d19-9133-e2d7bdd7a6f9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Lungi da voi, che siete poli>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c52d2417-44e1-4d19-9133-e2d7bdd7a6f9'
);


-- HWV 127c 칸타타 <Lungi dal mio bel nume>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Lungi dal mio bel nume>', 'Cantata <Lungi dal mio bel nume>', 'song', 'HWV 127c', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Lungi dal mio bel nume>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7424cd5a-b407-487b-8570-3aa828a73899'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7424cd5a-b407-487b-8570-3aa828a73899'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Lungi dal mio bel nume>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7424cd5a-b407-487b-8570-3aa828a73899'
);


-- HWV 128 칸타타 <Lungi n'andò Fileno>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Lungi n''andò Fileno>', 'Cantata <Lungi n''andò Fileno>', 'song', 'HWV 128', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Lungi n''andò Fileno>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e73898ab-e635-40cf-affc-b4c6fdaefc67'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e73898ab-e635-40cf-affc-b4c6fdaefc67'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Lungi n''andò Fileno>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e73898ab-e635-40cf-affc-b4c6fdaefc67'
);


-- HWV 129 칸타타 <Manca pur quanto sai>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Manca pur quanto sai>', 'Cantata <Manca pur quanto sai>', 'song', 'HWV 129', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Manca pur quanto sai>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62590d0c-11c2-4ea6-b24f-0e1fdebf17e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '62590d0c-11c2-4ea6-b24f-0e1fdebf17e9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Manca pur quanto sai>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62590d0c-11c2-4ea6-b24f-0e1fdebf17e9'
);


-- HWV 130 칸타타 <Mentre il tutto è in furore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Mentre il tutto è in furore>', 'Cantata <Mentre il tutto è in furore>', 'song', 'HWV 130', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Mentre il tutto è in furore>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b053a0fc-0d7e-41dd-99f9-1e140a64c820'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b053a0fc-0d7e-41dd-99f9-1e140a64c820'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Mentre il tutto è in furore>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b053a0fc-0d7e-41dd-99f9-1e140a64c820'
);


-- HWV 131 칸타타 <Menzognere speranze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Menzognere speranze>', 'Cantata <Menzognere speranze>', 'song', 'HWV 131', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Menzognere speranze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34b9e2fc-7cde-4a7d-8929-1f057dd10002'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '34b9e2fc-7cde-4a7d-8929-1f057dd10002'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Menzognere speranze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34b9e2fc-7cde-4a7d-8929-1f057dd10002'
);


-- HWV 132b 칸타타 <Mi palpita il cor>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Mi palpita il cor>', 'Cantata <Mi palpita il cor>', 'song', 'HWV 132b', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Mi palpita il cor>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fd69f97-0fdf-428e-8965-5981a8cd29f2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3fd69f97-0fdf-428e-8965-5981a8cd29f2'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Mi palpita il cor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fd69f97-0fdf-428e-8965-5981a8cd29f2'
);


-- HWV 133 칸타타 <Ne' tuoi lumi, o bella Clori>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Ne'' tuoi lumi, o bella Clori>', 'Cantata <Ne'' tuoi lumi, o bella Clori>', 'song', 'HWV 133', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Ne'' tuoi lumi, o bella Clori>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9cf5738e-e640-402b-b3da-95eab0513d6c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9cf5738e-e640-402b-b3da-95eab0513d6c'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Ne'' tuoi lumi, o bella Clori>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9cf5738e-e640-402b-b3da-95eab0513d6c'
);


-- HWV 134 칸타타 <Pensieri notturni di Filli>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Pensieri notturni di Filli>', 'Cantata <Pensieri notturni di Filli>', 'song', 'HWV 134', NULL, NULL, 1709, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Pensieri notturni di Filli>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fafe8821-3d98-4be8-bb45-800521feaccf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fafe8821-3d98-4be8-bb45-800521feaccf'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Pensieri notturni di Filli>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fafe8821-3d98-4be8-bb45-800521feaccf'
);


-- HWV 135b 칸타타 <Nel dolce tempo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Nel dolce tempo>', 'Cantata <Nel dolce tempo>', 'song', 'HWV 135b', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Nel dolce tempo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a727ce19-6175-4ce3-a22e-35b7c395d3a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a727ce19-6175-4ce3-a22e-35b7c395d3a5'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Nel dolce tempo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a727ce19-6175-4ce3-a22e-35b7c395d3a5'
);


-- HWV 136b 칸타타 <Nell'Africane selve>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Nell''Africane selve>', 'Cantata <Nell''Africane selve>', 'song', 'HWV 136b', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Nell''Africane selve>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e9e3447f-cfe9-4d3a-9d99-bb8764488dc8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e9e3447f-cfe9-4d3a-9d99-bb8764488dc8'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Nell''Africane selve>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e9e3447f-cfe9-4d3a-9d99-bb8764488dc8'
);


-- HWV 137 칸타타 <Nella stagion che di viole e rose>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Nella stagion che di viole e rose>', 'Cantata <Nella stagion che di viole e rose>', 'song', 'HWV 137', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Nella stagion che di viole e rose>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fae90496-3613-4f37-87ff-786786badfb9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fae90496-3613-4f37-87ff-786786badfb9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Nella stagion che di viole e rose>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fae90496-3613-4f37-87ff-786786badfb9'
);


-- HWV 138 칸타타 <Nice, che fa? che pensa?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Nice, che fa? che pensa?>', 'Cantata <Nice, che fa? che pensa?>', 'song', 'HWV 138', NULL, NULL, 1710, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Nice, che fa? che pensa?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ed77467-1c85-46b6-b266-2b7ca223a31c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7ed77467-1c85-46b6-b266-2b7ca223a31c'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Nice, che fa? che pensa?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ed77467-1c85-46b6-b266-2b7ca223a31c'
);


-- HWV 139c 칸타타 <Ninfe e pastori>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Ninfe e pastori>', 'Cantata <Ninfe e pastori>', 'song', 'HWV 139c', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Ninfe e pastori>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c7b3af7-03de-4966-a228-2d99819d95cd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4c7b3af7-03de-4966-a228-2d99819d95cd'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Ninfe e pastori>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c7b3af7-03de-4966-a228-2d99819d95cd'
);


-- HWV 140 칸타타 <Nò se emenderá jamás>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Nò se emenderá jamás>', 'Cantata <Nò se emenderá jamás>', 'song', 'HWV 140', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Nò se emenderá jamás>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fff821db-1fc8-476b-aee3-22a99dca5f08'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fff821db-1fc8-476b-aee3-22a99dca5f08'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Nò se emenderá jamás>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fff821db-1fc8-476b-aee3-22a99dca5f08'
);


-- HWV 141 칸타타 <Non sospirar, non piangere>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Non sospirar, non piangere>', 'Cantata <Non sospirar, non piangere>', 'song', 'HWV 141', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Non sospirar, non piangere>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ed3e93f-f8f2-4bfd-9398-ef089ffe7dd3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8ed3e93f-f8f2-4bfd-9398-ef089ffe7dd3'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Non sospirar, non piangere>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ed3e93f-f8f2-4bfd-9398-ef089ffe7dd3'
);


-- HWV 142 칸타타 <Notte placida e cheta>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Notte placida e cheta>', 'Cantata <Notte placida e cheta>', 'song', 'HWV 142', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Notte placida e cheta>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d2fdf3f-a038-4b30-bd6f-6d879df37486'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5d2fdf3f-a038-4b30-bd6f-6d879df37486'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Notte placida e cheta>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d2fdf3f-a038-4b30-bd6f-6d879df37486'
);


-- HWV 143 칸타타 <Olinto pastore, Tebro fiume, Gloria>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Olinto pastore, Tebro fiume, Gloria>', 'Cantata <Olinto pastore, Tebro fiume, Gloria>', 'song', 'HWV 143', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Olinto pastore, Tebro fiume, Gloria>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '236e4e17-7674-4d9b-8adc-136294f7806c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '236e4e17-7674-4d9b-8adc-136294f7806c'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Olinto pastore, Tebro fiume, Gloria>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '236e4e17-7674-4d9b-8adc-136294f7806c'
);


-- HWV 144 칸타타 <O lucenti, o sereni occhi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <O lucenti, o sereni occhi>', 'Cantata <O lucenti, o sereni occhi>', 'song', 'HWV 144', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <O lucenti, o sereni occhi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f89af62b-23e4-4839-ba5d-4d4a38c63e9e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f89af62b-23e4-4839-ba5d-4d4a38c63e9e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <O lucenti, o sereni occhi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f89af62b-23e4-4839-ba5d-4d4a38c63e9e'
);


-- HWV 145 칸타타 <La Lucrezia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <La Lucrezia>', 'Cantata <La Lucrezia>', 'song', 'HWV 145', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <La Lucrezia>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27b14855-5969-4bae-8f53-a892e0f154a8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '27b14855-5969-4bae-8f53-a892e0f154a8'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <La Lucrezia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27b14855-5969-4bae-8f53-a892e0f154a8'
);


-- HWV 146 칸타타 <Occhi miei che faceste?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Occhi miei che faceste?>', 'Cantata <Occhi miei che faceste?>', 'song', 'HWV 146', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Occhi miei che faceste?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bafb138-d892-44c7-9205-464dc4e98c62'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7bafb138-d892-44c7-9205-464dc4e98c62'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Occhi miei che faceste?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bafb138-d892-44c7-9205-464dc4e98c62'
);


-- HWV 147 칸타타 <Partì, l'idolo mio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Partì, l''idolo mio>', 'Cantata <Partì, l''idolo mio>', 'song', 'HWV 147', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Partì, l''idolo mio>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '385f1ee4-ec08-4fc6-a1e5-40acd2cde1a0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '385f1ee4-ec08-4fc6-a1e5-40acd2cde1a0'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Partì, l''idolo mio>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '385f1ee4-ec08-4fc6-a1e5-40acd2cde1a0'
);


-- HWV 148 칸타타 <Poichè giuraro amore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Poichè giuraro amore>', 'Cantata <Poichè giuraro amore>', 'song', 'HWV 148', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Poichè giuraro amore>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b19d84c2-ae83-462b-bf11-0800e6c99199'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b19d84c2-ae83-462b-bf11-0800e6c99199'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Poichè giuraro amore>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b19d84c2-ae83-462b-bf11-0800e6c99199'
);


-- HWV 149 칸타타 <Qual sento io non conosciuto>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Qual sento io non conosciuto>', 'Cantata <Qual sento io non conosciuto>', 'song', 'HWV 149', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Qual sento io non conosciuto>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9cc0c6a8-b101-4069-a80e-cef958028956'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9cc0c6a8-b101-4069-a80e-cef958028956'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Qual sento io non conosciuto>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9cc0c6a8-b101-4069-a80e-cef958028956'
);


-- HWV 150 칸타타 <Ero e Leandro>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Ero e Leandro>', 'Cantata <Ero e Leandro>', 'song', 'HWV 150', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Ero e Leandro>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a0b4c20-262c-4e29-835e-1200b5637d8a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2a0b4c20-262c-4e29-835e-1200b5637d8a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Ero e Leandro>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a0b4c20-262c-4e29-835e-1200b5637d8a'
);


-- HWV 151 칸타타 <Qualor crudele, sì ma vaga Dori>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Qualor crudele, sì ma vaga Dori>', 'Cantata <Qualor crudele, sì ma vaga Dori>', 'song', 'HWV 151', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Qualor crudele, sì ma vaga Dori>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f152478-8ddb-4378-8515-c1cbd6f2a673'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f152478-8ddb-4378-8515-c1cbd6f2a673'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Qualor crudele, sì ma vaga Dori>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f152478-8ddb-4378-8515-c1cbd6f2a673'
);


-- HWV 152 칸타타 <Qualor l'egre pupille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Qualor l''egre pupille>', 'Cantata <Qualor l''egre pupille>', 'song', 'HWV 152', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Qualor l''egre pupille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14da6bc3-62fc-4865-b2ed-191f4066390f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '14da6bc3-62fc-4865-b2ed-191f4066390f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Qualor l''egre pupille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14da6bc3-62fc-4865-b2ed-191f4066390f'
);


-- HWV 153 칸타타 <Quando sperasti, o core>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Quando sperasti, o core>', 'Cantata <Quando sperasti, o core>', 'song', 'HWV 153', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Quando sperasti, o core>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '95450ae3-c7f5-4377-944a-04d7ec5452c4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '95450ae3-c7f5-4377-944a-04d7ec5452c4'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Quando sperasti, o core>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '95450ae3-c7f5-4377-944a-04d7ec5452c4'
);


-- HWV 154 칸타타 <Quel fior che all'alba ride>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Quel fior che all''alba ride>', 'Cantata <Quel fior che all''alba ride>', 'song', 'HWV 154', NULL, NULL, 1740, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Quel fior che all''alba ride>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3afb292d-e80b-4133-8924-5419b041a14d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3afb292d-e80b-4133-8924-5419b041a14d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Quel fior che all''alba ride>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3afb292d-e80b-4133-8924-5419b041a14d'
);


-- HWV 155 칸타타 <Sans y penser>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Sans y penser>', 'Cantata <Sans y penser>', 'song', 'HWV 155', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Sans y penser>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'afc2fc0e-8aaa-49f1-b12d-5d50df37937c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'afc2fc0e-8aaa-49f1-b12d-5d50df37937c'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Sans y penser>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'afc2fc0e-8aaa-49f1-b12d-5d50df37937c'
);


-- HWV 156 칸타타 <Sarai contenta un di>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Sarai contenta un di>', 'Cantata <Sarai contenta un di>', 'song', 'HWV 156', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Sarai contenta un di>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f61b9f39-042a-44d2-b579-5fdf663a01f3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f61b9f39-042a-44d2-b579-5fdf663a01f3'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Sarai contenta un di>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f61b9f39-042a-44d2-b579-5fdf663a01f3'
);


-- HWV 157 칸타타 <Sarei troppo felice>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Sarei troppo felice>', 'Cantata <Sarei troppo felice>', 'song', 'HWV 157', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Sarei troppo felice>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '681069ef-75e1-4f7e-9388-8ba5cdb38b11'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '681069ef-75e1-4f7e-9388-8ba5cdb38b11'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Sarei troppo felice>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '681069ef-75e1-4f7e-9388-8ba5cdb38b11'
);


-- HWV 158c 칸타타 <Se pari è la tua fè>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Se pari è la tua fè>', 'Cantata <Se pari è la tua fè>', 'song', 'HWV 158c', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Se pari è la tua fè>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be461782-3b73-4f24-9ccf-ee875bbd27d8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be461782-3b73-4f24-9ccf-ee875bbd27d8'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Se pari è la tua fè>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be461782-3b73-4f24-9ccf-ee875bbd27d8'
);


-- HWV 159 칸타타 <Se per fatal destino>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Se per fatal destino>', 'Cantata <Se per fatal destino>', 'song', 'HWV 159', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Se per fatal destino>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8052de05-2f25-4357-a96d-b281fb9d354b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8052de05-2f25-4357-a96d-b281fb9d354b'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Se per fatal destino>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8052de05-2f25-4357-a96d-b281fb9d354b'
);


-- HWV 160c 칸타타 <La bianca rosa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <La bianca rosa>', 'Cantata <La bianca rosa>', 'song', 'HWV 160c', NULL, NULL, 1741, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <La bianca rosa>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a65c9865-5b86-4b15-bcd0-b4a0afd26759'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a65c9865-5b86-4b15-bcd0-b4a0afd26759'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <La bianca rosa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a65c9865-5b86-4b15-bcd0-b4a0afd26759'
);


-- HWV 161c 칸타타 <Sento là che ristretto>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Sento là che ristretto>', 'Cantata <Sento là che ristretto>', 'song', 'HWV 161c', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Sento là che ristretto>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29f3b19f-cf01-42b4-bf84-b4ff9c0c3eb7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '29f3b19f-cf01-42b4-bf84-b4ff9c0c3eb7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Sento là che ristretto>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29f3b19f-cf01-42b4-bf84-b4ff9c0c3eb7'
);


-- HWV 162 칸타타 <Siete rose ruggiadose>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Siete rose ruggiadose>', 'Cantata <Siete rose ruggiadose>', 'song', 'HWV 162', NULL, NULL, 1712, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Siete rose ruggiadose>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c6ed972-a2e7-4397-b18a-cf96e17db7c9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c6ed972-a2e7-4397-b18a-cf96e17db7c9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Siete rose ruggiadose>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c6ed972-a2e7-4397-b18a-cf96e17db7c9'
);


-- HWV 163 칸타타 <Solitudini care, amata libertà>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Solitudini care, amata libertà>', 'Cantata <Solitudini care, amata libertà>', 'song', 'HWV 163', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Solitudini care, amata libertà>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6382e046-e66c-44fb-84dc-0be8351c0817'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6382e046-e66c-44fb-84dc-0be8351c0817'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Solitudini care, amata libertà>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6382e046-e66c-44fb-84dc-0be8351c0817'
);


-- HWV 164a 칸타타 <Il Gelsomino>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Il Gelsomino>', 'Cantata <Il Gelsomino>', 'song', 'HWV 164a', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Il Gelsomino>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8384c82-867c-4139-b6d1-784391503602'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e8384c82-867c-4139-b6d1-784391503602'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Il Gelsomino>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8384c82-867c-4139-b6d1-784391503602'
);


-- HWV 165 칸타타 <Spande ancor a mio dispetto>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Spande ancor a mio dispetto>', 'Cantata <Spande ancor a mio dispetto>', 'song', 'HWV 165', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Spande ancor a mio dispetto>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ef1f7bb-988e-4c17-adb8-19a0f73723d7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ef1f7bb-988e-4c17-adb8-19a0f73723d7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Spande ancor a mio dispetto>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ef1f7bb-988e-4c17-adb8-19a0f73723d7'
);


-- HWV 167b 칸타타 <Stanco di più soffrire>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Stanco di più soffrire>', 'Cantata <Stanco di più soffrire>', 'song', 'HWV 167b', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Stanco di più soffrire>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94f72092-4510-4232-a1ba-dff529e0c414'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '94f72092-4510-4232-a1ba-dff529e0c414'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Stanco di più soffrire>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94f72092-4510-4232-a1ba-dff529e0c414'
);


-- HWV 168 칸타타 <Partenza di G. B.>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Partenza di G. B.>', 'Cantata <Partenza di G. B.>', 'song', 'HWV 168', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Partenza di G. B.>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9c71402-df3a-454b-99bc-0fa267d3bbbd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a9c71402-df3a-454b-99bc-0fa267d3bbbd'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Partenza di G. B.>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9c71402-df3a-454b-99bc-0fa267d3bbbd'
);


-- HWV 169 칸타타 <Torna il core al suo diletto>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Torna il core al suo diletto>', 'Cantata <Torna il core al suo diletto>', 'song', 'HWV 169', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Torna il core al suo diletto>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a59a6707-c27f-40d5-84c6-e83c5eee137c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a59a6707-c27f-40d5-84c6-e83c5eee137c'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Torna il core al suo diletto>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a59a6707-c27f-40d5-84c6-e83c5eee137c'
);


-- HWV 170 칸타타 <Tra le fiamme>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Tra le fiamme>', 'Cantata <Tra le fiamme>', 'song', 'HWV 170', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Tra le fiamme>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c23d8ab9-20d6-4f81-b768-a82926792f4b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c23d8ab9-20d6-4f81-b768-a82926792f4b'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Tra le fiamme>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c23d8ab9-20d6-4f81-b768-a82926792f4b'
);


-- HWV 171 칸타타 <Tu fedel? Tu costante?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Tu fedel? Tu costante?>', 'Cantata <Tu fedel? Tu costante?>', 'song', 'HWV 171', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Tu fedel? Tu costante?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '652069a4-b205-46a8-901d-27703e6f8220'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '652069a4-b205-46a8-901d-27703e6f8220'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Tu fedel? Tu costante?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '652069a4-b205-46a8-901d-27703e6f8220'
);


-- HWV 172 칸타타 <Udite il mio consiglio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Udite il mio consiglio>', 'Cantata <Udite il mio consiglio>', 'song', 'HWV 172', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Udite il mio consiglio>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b3b2c62-3e60-48f1-a6b3-bb302f3f7053'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b3b2c62-3e60-48f1-a6b3-bb302f3f7053'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Udite il mio consiglio>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b3b2c62-3e60-48f1-a6b3-bb302f3f7053'
);


-- HWV 173 칸타타 <Un'alma innamorata>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Un''alma innamorata>', 'Cantata <Un''alma innamorata>', 'song', 'HWV 173', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Un''alma innamorata>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b7ea541-9690-49bf-bf88-869e091e028f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b7ea541-9690-49bf-bf88-869e091e028f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Un''alma innamorata>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b7ea541-9690-49bf-bf88-869e091e028f'
);


-- HWV 174 칸타타 <Un sospir a chi si muore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Un sospir a chi si muore>', 'Cantata <Un sospir a chi si muore>', 'song', 'HWV 174', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Un sospir a chi si muore>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41e57c55-e5b1-45cc-8a9d-019f7f0b09bb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '41e57c55-e5b1-45cc-8a9d-019f7f0b09bb'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Un sospir a chi si muore>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41e57c55-e5b1-45cc-8a9d-019f7f0b09bb'
);


-- HWV 175 칸타타 <Vedendo Amor>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Vedendo Amor>', 'Cantata <Vedendo Amor>', 'song', 'HWV 175', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Vedendo Amor>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a97a011-b815-40b3-bc6c-69dece0d28e0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0a97a011-b815-40b3-bc6c-69dece0d28e0'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Vedendo Amor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a97a011-b815-40b3-bc6c-69dece0d28e0'
);


-- HWV 176 칸타타 <Amore uccellatore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Amore uccellatore>', 'Cantata <Amore uccellatore>', 'song', 'HWV 176', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Amore uccellatore>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '551bab62-bc0b-4038-b9f9-de56f53ff74a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '551bab62-bc0b-4038-b9f9-de56f53ff74a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Amore uccellatore>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '551bab62-bc0b-4038-b9f9-de56f53ff74a'
);


-- HWV 177 칸타타 <Zeffiretto, arresta il volo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Zeffiretto, arresta il volo>', 'Cantata <Zeffiretto, arresta il volo>', 'song', 'HWV 177', NULL, NULL, 1709, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Zeffiretto, arresta il volo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac1bb248-0a08-4e04-a594-0910781282d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac1bb248-0a08-4e04-a594-0910781282d9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '칸타타 <Zeffiretto, arresta il volo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac1bb248-0a08-4e04-a594-0910781282d9'
);


-- HWV 178 2중창 <A mirarvi io son intento>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <A mirarvi io son intento>', 'Duet <A mirarvi io son intento>', 'song', 'HWV 178', NULL, NULL, 1711, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <A mirarvi io son intento>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be79ef4f-1fdf-42a6-8a53-0fbd07c7ab77'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be79ef4f-1fdf-42a6-8a53-0fbd07c7ab77'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <A mirarvi io son intento>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be79ef4f-1fdf-42a6-8a53-0fbd07c7ab77'
);


-- HWV 179 2중창 <Ahi, nelle sorti umane>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Ahi, nelle sorti umane>', 'Duet <Ahi, nelle sorti umane>', 'song', 'HWV 179', NULL, NULL, 1745, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Ahi, nelle sorti umane>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acb188b2-f194-4376-8ca7-e291db052c68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'acb188b2-f194-4376-8ca7-e291db052c68'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Ahi, nelle sorti umane>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acb188b2-f194-4376-8ca7-e291db052c68'
);


-- HWV 180 2중창 <Amor, gioje mi porge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Amor, gioje mi porge>', 'Duet <Amor, gioje mi porge>', 'song', 'HWV 180', NULL, NULL, 1709, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Amor, gioje mi porge>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '894bf6b1-d00f-47b9-a9b4-c95ecc858703'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '894bf6b1-d00f-47b9-a9b4-c95ecc858703'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Amor, gioje mi porge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '894bf6b1-d00f-47b9-a9b4-c95ecc858703'
);


-- HWV 181 2중창 <Beato in ver chi può>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Beato in ver chi può>', 'Duet <Beato in ver chi può>', 'song', 'HWV 181', NULL, NULL, 1742, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Beato in ver chi può>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '442b9d87-45c7-40f5-8659-e5842d1a500e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '442b9d87-45c7-40f5-8659-e5842d1a500e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Beato in ver chi può>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '442b9d87-45c7-40f5-8659-e5842d1a500e'
);


-- HWV 182b 2중창 <Caro autor di mia doglia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Caro autor di mia doglia>', 'Duet <Caro autor di mia doglia>', 'song', 'HWV 182b', NULL, NULL, 1742, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Caro autor di mia doglia>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0ec8827-9069-44dc-9b0a-2a501aee7e36'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0ec8827-9069-44dc-9b0a-2a501aee7e36'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Caro autor di mia doglia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0ec8827-9069-44dc-9b0a-2a501aee7e36'
);


-- HWV 184 2중창 <Che vai pensando, folle pensier>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Che vai pensando, folle pensier>', 'Duet <Che vai pensando, folle pensier>', 'song', 'HWV 184', NULL, NULL, 1709, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Che vai pensando, folle pensier>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ec7e6c5-0e8f-4533-8311-28c96d1986ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8ec7e6c5-0e8f-4533-8311-28c96d1986ea'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Che vai pensando, folle pensier>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ec7e6c5-0e8f-4533-8311-28c96d1986ea'
);


-- HWV 185 2중창 <Conservate, raddoppiate>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Conservate, raddoppiate>', 'Duet <Conservate, raddoppiate>', 'song', 'HWV 185', NULL, NULL, 1711, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Conservate, raddoppiate>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b258507e-e584-4e71-b8ce-db73669be561'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b258507e-e584-4e71-b8ce-db73669be561'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Conservate, raddoppiate>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b258507e-e584-4e71-b8ce-db73669be561'
);


-- HWV 186 2중창 <Fronda leggiera e mobile>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Fronda leggiera e mobile>', 'Duet <Fronda leggiera e mobile>', 'song', 'HWV 186', NULL, NULL, 1745, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Fronda leggiera e mobile>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da7a4ef3-c0ed-48e0-a696-eccf7810a574'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'da7a4ef3-c0ed-48e0-a696-eccf7810a574'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Fronda leggiera e mobile>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da7a4ef3-c0ed-48e0-a696-eccf7810a574'
);


-- HWV 187 2중창 <Giù nei Tartarei regni>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Giù nei Tartarei regni>', 'Duet <Giù nei Tartarei regni>', 'song', 'HWV 187', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Giù nei Tartarei regni>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f62194e4-9a17-422d-8c9d-be8de038d518'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f62194e4-9a17-422d-8c9d-be8de038d518'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Giù nei Tartarei regni>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f62194e4-9a17-422d-8c9d-be8de038d518'
);


-- HWV 188 2중창 <Langue, geme, e sospira>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Langue, geme, e sospira>', 'Duet <Langue, geme, e sospira>', 'song', 'HWV 188', NULL, NULL, 1722, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Langue, geme, e sospira>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2bc72014-075d-4fc9-8fdb-b4d329e37c93'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2bc72014-075d-4fc9-8fdb-b4d329e37c93'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Langue, geme, e sospira>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2bc72014-075d-4fc9-8fdb-b4d329e37c93'
);


-- HWV 189 2중창 <No, di voi non vuo' fidarmi> HWV 189

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <No, di voi non vuo'' fidarmi> HWV 189', 'Duet <No, di voi non vuo'' fidarmi>, HWV 189', 'song', NULL, 'HWV', '189', 1741, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <No, di voi non vuo'' fidarmi> HWV 189'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f1b2bfe-b33e-4378-8a81-a3cda5ba8e18'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f1b2bfe-b33e-4378-8a81-a3cda5ba8e18'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <No, di voi non vuo'' fidarmi> HWV 189' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f1b2bfe-b33e-4378-8a81-a3cda5ba8e18'
);


-- HWV 190 2중창 <No, di voi non vuo' fidarmi> HWV 190

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <No, di voi non vuo'' fidarmi> HWV 190', 'Duet <No, di voi non vuo'' fidarmi>, HWV 190', 'song', NULL, 'HWV', '190', 1742, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <No, di voi non vuo'' fidarmi> HWV 190'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed568eaf-d394-4cf4-8f4c-d086b3364d03'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed568eaf-d394-4cf4-8f4c-d086b3364d03'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <No, di voi non vuo'' fidarmi> HWV 190' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed568eaf-d394-4cf4-8f4c-d086b3364d03'
);


-- HWV 191 2중창 <Quando in calma ride il mare>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Quando in calma ride il mare>', 'Duet <Quando in calma ride il mare>', 'song', 'HWV 191', NULL, NULL, 1711, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Quando in calma ride il mare>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1c8e76d-b52c-4b9a-a1f8-479acf246402'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd1c8e76d-b52c-4b9a-a1f8-479acf246402'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Quando in calma ride il mare>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1c8e76d-b52c-4b9a-a1f8-479acf246402'
);


-- HWV 192 2중창 <Quel fior che all'alba ride>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Quel fior che all''alba ride>', 'Duet <Quel fior che all''alba ride>', 'song', 'HWV 192', NULL, NULL, 1741, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Quel fior che all''alba ride>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e05041ed-a884-4296-a0b0-77a7f97e7a2f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e05041ed-a884-4296-a0b0-77a7f97e7a2f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Quel fior che all''alba ride>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e05041ed-a884-4296-a0b0-77a7f97e7a2f'
);


-- HWV 193 2중창 <Se tu non lasci amore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Se tu non lasci amore>', 'Duet <Se tu non lasci amore>', 'song', 'HWV 193', NULL, NULL, 1722, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Se tu non lasci amore>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8582d478-6610-4cc2-a894-7db5f4159f5d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8582d478-6610-4cc2-a894-7db5f4159f5d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Se tu non lasci amore>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8582d478-6610-4cc2-a894-7db5f4159f5d'
);


-- HWV 194 2중창 <Sono liete, fortunate>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Sono liete, fortunate>', 'Duet <Sono liete, fortunate>', 'song', 'HWV 194', NULL, NULL, 1711, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Sono liete, fortunate>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '23379273-e88f-442e-aa74-fa4077f2aa18'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '23379273-e88f-442e-aa74-fa4077f2aa18'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Sono liete, fortunate>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '23379273-e88f-442e-aa74-fa4077f2aa18'
);


-- HWV 196 2중창 <Tacete, ohimè, tacete>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Tacete, ohimè, tacete>', 'Duet <Tacete, ohimè, tacete>', 'song', 'HWV 196', NULL, NULL, 1709, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Tacete, ohimè, tacete>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7017cfb-7cc9-4af7-8a98-b9329cf8698e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7017cfb-7cc9-4af7-8a98-b9329cf8698e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Tacete, ohimè, tacete>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7017cfb-7cc9-4af7-8a98-b9329cf8698e'
);


-- HWV 197 2중창 <Tanti strali al sen mi scocchi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Tanti strali al sen mi scocchi>', 'Duet <Tanti strali al sen mi scocchi>', 'song', 'HWV 197', NULL, NULL, 1711, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Tanti strali al sen mi scocchi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72b0a6fc-f14a-45f0-bb0d-e5af49bc5d24'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72b0a6fc-f14a-45f0-bb0d-e5af49bc5d24'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Tanti strali al sen mi scocchi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72b0a6fc-f14a-45f0-bb0d-e5af49bc5d24'
);


-- HWV 198 2중창 <Troppo cruda, troppo fiera>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Troppo cruda, troppo fiera>', 'Duet <Troppo cruda, troppo fiera>', 'song', 'HWV 198', NULL, NULL, 1711, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Troppo cruda, troppo fiera>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52fdba95-980e-4570-93de-8fc4cd312b1a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52fdba95-980e-4570-93de-8fc4cd312b1a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Troppo cruda, troppo fiera>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52fdba95-980e-4570-93de-8fc4cd312b1a'
);


-- HWV 199 2중창 <Va, speme infida>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Va, speme infida>', 'Duet <Va, speme infida>', 'song', 'HWV 199', NULL, NULL, 1711, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Va, speme infida>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd8bc385-74ea-4c26-9bbd-916e0c5bdfc8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fd8bc385-74ea-4c26-9bbd-916e0c5bdfc8'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '2중창 <Va, speme infida>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd8bc385-74ea-4c26-9bbd-916e0c5bdfc8'
);


-- HWV 200 3중창 <Quel fior che all'alba ride>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3중창 <Quel fior che all''alba ride>', 'Trio <Quel fior che all''alba ride>', 'song', 'HWV 200', NULL, NULL, 1709, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3중창 <Quel fior che all''alba ride>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc7141c4-ab79-49e7-ae72-65845d4ae34d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc7141c4-ab79-49e7-ae72-65845d4ae34d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '3중창 <Quel fior che all''alba ride>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc7141c4-ab79-49e7-ae72-65845d4ae34d'
);


-- HWV 201b 3중창 <Se tu non lasci amore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3중창 <Se tu non lasci amore>', 'Trio <Se tu non lasci amore>', 'song', 'HWV 201b', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3중창 <Se tu non lasci amore>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6872bde-f42a-4c45-ba91-91eea494add5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a6872bde-f42a-4c45-ba91-91eea494add5'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '3중창 <Se tu non lasci amore>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6872bde-f42a-4c45-ba91-91eea494add5'
);


-- HWV 202–210 9개의 독일 아리아

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '9개의 독일 아리아', '9 German Arias, HWV 202–210', 'album', 'HWV 202–210', NULL, NULL, 1726, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '9개의 독일 아리아'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1cda5747-8f6d-4292-b29f-45dfc64dd140'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1cda5747-8f6d-4292-b29f-45dfc64dd140'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 독일 아리아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1cda5747-8f6d-4292-b29f-45dfc64dd140'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaaace19-8c06-488e-838a-f09a544f8103', 1, NULL, 'Künft''ger Zeiten eitler Kummer', 'Künft''ger Zeiten eitler Kummer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 독일 아리아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaaace19-8c06-488e-838a-f09a544f8103'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60800afb-287f-4ca0-bdd6-5da273e32d9d', 2, NULL, 'Das zitternde Glänzen der spielenden Wellen', 'Das zitternde Glänzen der spielenden Wellen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 독일 아리아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60800afb-287f-4ca0-bdd6-5da273e32d9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b283721-8a74-46a9-aa33-86257541bb21', 3, NULL, 'Süßer Blumen Ambraflocken', 'Süßer Blumen Ambraflocken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 독일 아리아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b283721-8a74-46a9-aa33-86257541bb21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99fd8136-06a8-4774-bd38-657791e5bd7b', 4, NULL, 'Süße Stille, sanfte Quelle', 'Süße Stille, sanfte Quelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 독일 아리아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99fd8136-06a8-4774-bd38-657791e5bd7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3c12193-15f2-4612-b37e-bb947641d01a', 5, NULL, 'Singe, Seele, Gott zum Preise', 'Singe, Seele, Gott zum Preise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 독일 아리아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3c12193-15f2-4612-b37e-bb947641d01a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eeabdaac-0227-4f6d-b6a0-20bcc770dca7', 6, NULL, 'Meine Seele hört im Sehen', 'Meine Seele hört im Sehen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 독일 아리아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeabdaac-0227-4f6d-b6a0-20bcc770dca7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0876215-8b4d-466f-87fb-d50d1e8a9b2c', 7, NULL, 'Die ihr aus dunkeln Grüften', 'Die ihr aus dunkeln Grüften', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 독일 아리아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0876215-8b4d-466f-87fb-d50d1e8a9b2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9258934-b329-41b0-a431-80e2fbabf21a', 8, NULL, 'In den angenehmen Büschen', 'In den angenehmen Büschen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 독일 아리아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9258934-b329-41b0-a431-80e2fbabf21a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb6753ff-dc59-40b6-998e-340b4f268fcd', 9, NULL, 'Flammende Rose, Zierde der Erden', 'Flammende Rose, Zierde der Erden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 독일 아리아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb6753ff-dc59-40b6-998e-340b4f268fcd'
);


-- HWV 284 찬송가 <Sinners obey the Gospel word>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬송가 <Sinners obey the Gospel word>', 'Hymn <Sinners obey the Gospel word> "The Invitation"', 'song', 'HWV 284', NULL, NULL, 1747, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬송가 <Sinners obey the Gospel word>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3871f0e8-5fb1-4696-8650-02fe56e7d045'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3871f0e8-5fb1-4696-8650-02fe56e7d045'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '찬송가 <Sinners obey the Gospel word>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3871f0e8-5fb1-4696-8650-02fe56e7d045'
);


-- HWV 285 찬송가 <O Love divine, how sweet thou art>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬송가 <O Love divine, how sweet thou art>', 'Hymn <O Love divine, how sweet thou art> "Desiring to Love"', 'song', 'HWV 285', NULL, NULL, 1747, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬송가 <O Love divine, how sweet thou art>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '736fa298-07b8-42cf-bc30-8cea41dda163'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '736fa298-07b8-42cf-bc30-8cea41dda163'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '찬송가 <O Love divine, how sweet thou art>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '736fa298-07b8-42cf-bc30-8cea41dda163'
);


-- HWV 286 찬송가 <Rejoice, the Lord is King>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬송가 <Rejoice, the Lord is King>', 'Hymn <Rejoice, the Lord is King> "On the Resurrection"', 'song', 'HWV 286', NULL, NULL, 1747, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬송가 <Rejoice, the Lord is King>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1027b919-23ed-4214-b49a-8a3323822734'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1027b919-23ed-4214-b49a-8a3323822734'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '찬송가 <Rejoice, the Lord is King>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1027b919-23ed-4214-b49a-8a3323822734'
);


-- HWV 211 아리아 <Aure dolci, deh, spirate>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Aure dolci, deh, spirate>', 'Aria <Aure dolci, deh, spirate>', 'song', 'HWV 211', NULL, NULL, 1726, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Aure dolci, deh, spirate>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70ee498f-567a-4e67-8cac-060de452cbfd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '70ee498f-567a-4e67-8cac-060de452cbfd'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <Aure dolci, deh, spirate>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70ee498f-567a-4e67-8cac-060de452cbfd'
);


-- HWV 212 아리아 <Con doppia gloria mia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Con doppia gloria mia>', 'Aria <Con doppia gloria mia>', 'song', 'HWV 212', NULL, NULL, 1726, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Con doppia gloria mia>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6ab1eb8-88c8-47c1-8527-89b1609e72d4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6ab1eb8-88c8-47c1-8527-89b1609e72d4'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <Con doppia gloria mia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6ab1eb8-88c8-47c1-8527-89b1609e72d4'
);


-- HWV 213 아리아 <Con lacrime sì belle>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Con lacrime sì belle>', 'Aria <Con lacrime sì belle>', 'song', 'HWV 213', NULL, NULL, 1718, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Con lacrime sì belle>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4cf8d24-62e3-4c7b-beb5-e549ccab1f83'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4cf8d24-62e3-4c7b-beb5-e549ccab1f83'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <Con lacrime sì belle>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4cf8d24-62e3-4c7b-beb5-e549ccab1f83'
);


-- HWV 214 아리아 <Dell'onda instabile>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Dell''onda instabile>', 'Aria <Dell''onda instabile>', 'song', 'HWV 214', NULL, NULL, 1749, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Dell''onda instabile>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40ff5521-de96-4413-bc27-c75da7e4f95d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '40ff5521-de96-4413-bc27-c75da7e4f95d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <Dell''onda instabile>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40ff5521-de96-4413-bc27-c75da7e4f95d'
);


-- HWV 215 아리아 <Col valor del vostro brando>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Col valor del vostro brando>', 'Aria <Col valor del vostro brando>', 'song', 'HWV 215', NULL, NULL, 1713, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Col valor del vostro brando>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fee4e271-6886-4ff9-890b-ec04822ff8fa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fee4e271-6886-4ff9-890b-ec04822ff8fa'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <Col valor del vostro brando>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fee4e271-6886-4ff9-890b-ec04822ff8fa'
);


-- HWV 216 아리아 <Impari del mio core>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Impari del mio core>', 'Aria <Impari del mio core>', 'song', 'HWV 216', NULL, NULL, 1749, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Impari del mio core>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '603a30ef-31c2-4f79-9f72-dac3826d8554'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '603a30ef-31c2-4f79-9f72-dac3826d8554'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <Impari del mio core>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '603a30ef-31c2-4f79-9f72-dac3826d8554'
);


-- HWV 217 아리아 <L'odio, sì, ma poi ritrovò>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <L''odio, sì, ma poi ritrovò>', 'Aria <L''odio, sì, ma poi ritrovò>', 'song', 'HWV 217', NULL, NULL, 1726, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <L''odio, sì, ma poi ritrovò>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e91ba4ce-4201-4e0a-b699-ea772b16d6e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e91ba4ce-4201-4e0a-b699-ea772b16d6e9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <L''odio, sì, ma poi ritrovò>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e91ba4ce-4201-4e0a-b699-ea772b16d6e9'
);


-- HWV 219 아리아 <Non so se avrai mai bene>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Non so se avrai mai bene>', 'Aria <Non so se avrai mai bene>', 'song', 'HWV 219', NULL, NULL, 1718, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Non so se avrai mai bene>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '106076ba-1e16-4998-816b-d08036eac8a9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '106076ba-1e16-4998-816b-d08036eac8a9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <Non so se avrai mai bene>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '106076ba-1e16-4998-816b-d08036eac8a9'
);


-- HWV 220 아리아 <Per dar pace al mio tormento>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Per dar pace al mio tormento>', 'Aria <Per dar pace al mio tormento>', 'song', 'HWV 220', NULL, NULL, 1749, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Per dar pace al mio tormento>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0f5444a-ae01-44ee-bf3f-7a5d7a4e8d86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd0f5444a-ae01-44ee-bf3f-7a5d7a4e8d86'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <Per dar pace al mio tormento>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0f5444a-ae01-44ee-bf3f-7a5d7a4e8d86'
);


-- HWV 221 아리아 <Quant'invidio tua fortuna>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Quant''invidio tua fortuna>', 'Aria <Quant''invidio tua fortuna>', 'song', 'HWV 221', NULL, NULL, 1749, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Quant''invidio tua fortuna>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca76c73f-d92f-4736-a7f5-ccd4f3cc7af0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca76c73f-d92f-4736-a7f5-ccd4f3cc7af0'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <Quant''invidio tua fortuna>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca76c73f-d92f-4736-a7f5-ccd4f3cc7af0'
);


-- HWV 222 아리아 <Quanto più amara fu sorte crudele>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Quanto più amara fu sorte crudele>', 'Aria <Quanto più amara fu sorte crudele>', 'song', 'HWV 222', NULL, NULL, 1723, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Quanto più amara fu sorte crudele>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efcc087e-3607-4e4e-84ea-9b6a7b1b4a68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'efcc087e-3607-4e4e-84ea-9b6a7b1b4a68'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <Quanto più amara fu sorte crudele>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efcc087e-3607-4e4e-84ea-9b6a7b1b4a68'
);


-- HWV 223 아리아 <S'un dì m'appaga, la mia crudele>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <S''un dì m''appaga, la mia crudele>', 'Aria <S''un dì m''appaga, la mia crudele>', 'song', 'HWV 223', NULL, NULL, 1741, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <S''un dì m''appaga, la mia crudele>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f62c2d2-62fd-4045-9b24-412ae53c8c5a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1f62c2d2-62fd-4045-9b24-412ae53c8c5a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <S''un dì m''appaga, la mia crudele>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f62c2d2-62fd-4045-9b24-412ae53c8c5a'
);


-- HWV 224 아리아 <Sì, crudel, tornerà>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Sì, crudel, tornerà>', 'Aria <Sì, crudel, tornerà>', 'song', 'HWV 224', NULL, NULL, 1741, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Sì, crudel, tornerà>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c086178-6835-4457-ae23-3a1b652d59ad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c086178-6835-4457-ae23-3a1b652d59ad'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <Sì, crudel, tornerà>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c086178-6835-4457-ae23-3a1b652d59ad'
);


-- HWV 225 아리아 <Spera chi sa perchè la sorte>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Spera chi sa perchè la sorte>', 'Aria <Spera chi sa perchè la sorte>', 'song', 'HWV 225', NULL, NULL, 1718, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Spera chi sa perchè la sorte>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8a98ef0-e927-4b99-b9b6-9332132009f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8a98ef0-e927-4b99-b9b6-9332132009f7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <Spera chi sa perchè la sorte>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8a98ef0-e927-4b99-b9b6-9332132009f7'
);


-- HWV 227 아리아 <Vo' cercando tra fiori>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Vo'' cercando tra fiori>', 'Aria <Vo'' cercando tra fiori>', 'song', 'HWV 227', NULL, NULL, 1726, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Vo'' cercando tra fiori>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e8e67d4-cac9-4014-9235-1cf533d30577'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e8e67d4-cac9-4014-9235-1cf533d30577'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 <Vo'' cercando tra fiori>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e8e67d4-cac9-4014-9235-1cf533d30577'
);


-- HWV 226 가곡 <Hunting Song>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Hunting Song>', 'Song <Hunting Song> "The morning is charming"', 'song', 'HWV 226', NULL, NULL, 1743, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Hunting Song>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92dd7268-6ae0-4933-add6-73d500b8d038'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '92dd7268-6ae0-4933-add6-73d500b8d038'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '가곡 <Hunting Song>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92dd7268-6ae0-4933-add6-73d500b8d038'
);


-- HWV 228 24개의 영어 가곡 HWV 228

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '24개의 영어 가곡 HWV 228', '24 English Songs, HWV 228', 'album', NULL, 'HWV', '228', 1746, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '24개의 영어 가곡 HWV 228'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f576a033-b69a-41e0-86c3-cd7879fdcfc1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f576a033-b69a-41e0-86c3-cd7879fdcfc1'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f576a033-b69a-41e0-86c3-cd7879fdcfc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9758a634-7086-4824-8cb9-5a604a7bb490', 1, NULL, 'The unhappy Lovers: As Celia''s fatal arrows flew', 'The unhappy Lovers: As Celia''s fatal arrows flew', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9758a634-7086-4824-8cb9-5a604a7bb490'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:607f5970-d928-486c-982c-8f6e9563facb', 2, NULL, 'Charming Cloris: Ask not the cause', 'Charming Cloris: Ask not the cause', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:607f5970-d928-486c-982c-8f6e9563facb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d98e8f8-3449-44f0-800a-9125dc8bc8c9', 3, NULL, 'As on a Sunshine Summer''s Day', 'As on a Sunshine Summer''s Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d98e8f8-3449-44f0-800a-9125dc8bc8c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51c386ce-1809-4a71-b664-da56adfd62a1', 4, NULL, 'Bacchus Speech in Praise of Wine: Bacchus one day gayly striding', 'Bacchus Speech in Praise of Wine: Bacchus one day gayly striding', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51c386ce-1809-4a71-b664-da56adfd62a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:553651b0-b8a8-488b-9234-9e285e45e2a8', 5, NULL, 'The Polish Minuet', 'The Polish Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:553651b0-b8a8-488b-9234-9e285e45e2a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28f17647-9a59-4df5-98ec-c4993a96065c', 6, NULL, 'The Sailor''s Complaint: Come and listen to my ditty', 'The Sailor''s Complaint: Come and listen to my ditty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28f17647-9a59-4df5-98ec-c4993a96065c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dd5a085-44aa-4694-9f10-6e71d0aa71a0', 7, NULL, 'Di godere ha speranza il mio core', 'Di godere ha speranza il mio core', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dd5a085-44aa-4694-9f10-6e71d0aa71a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e977156e-17e6-43b8-994c-f7f9fe73dc88', 8, NULL, 'The forsaken Maid''s Complaint: Faithless ungrateful', 'The forsaken Maid''s Complaint: Faithless ungrateful', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e977156e-17e6-43b8-994c-f7f9fe73dc88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a9d1625-4755-4d9b-966e-90361d0cad28', 9, NULL, 'From scourging rebellion', 'From scourging rebellion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a9d1625-4755-4d9b-966e-90361d0cad28'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f6f45f7-ad21-4c7b-b2b2-c6980a6074ca', 10, NULL, 'The forsaken Nymph: Guardian Angels now protect me', 'The forsaken Nymph: Guardian Angels now protect me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f6f45f7-ad21-4c7b-b2b2-c6980a6074ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92cc0a39-a446-4afb-a3a6-5a9861f83451', 11, NULL, 'I like the am''rous Youth that''s free', 'I like the am''rous Youth that''s free', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92cc0a39-a446-4afb-a3a6-5a9861f83451'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8f6a455-541e-40e5-bc65-4b54a8c6d718', 12, NULL, 'Phillis: My fair, ye Swains, is gone astray', 'Phillis: My fair, ye Swains, is gone astray', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8f6a455-541e-40e5-bc65-4b54a8c6d718'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66437f42-cb37-4d91-9f07-e4a31f2cf31c', 13, NULL, 'Not, Cloe, that I better am', 'Not, Cloe, that I better am', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66437f42-cb37-4d91-9f07-e4a31f2cf31c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61484468-71f5-483b-9c8b-489d879bbd2c', 14, NULL, 'Strephon''s Complaint of Love: Oh cruel Tyrant Love', 'Strephon''s Complaint of Love: Oh cruel Tyrant Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61484468-71f5-483b-9c8b-489d879bbd2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cd1eb80-f607-42c3-ada2-ffda62757bfd', 15, NULL, 'The Satyr''s Advice to a Stock-Jobber: On the shore of a low ebbing sea', 'The Satyr''s Advice to a Stock-Jobber: On the shore of a low ebbing sea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cd1eb80-f607-42c3-ada2-ffda62757bfd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c0cd536-8929-4735-8e37-62628e57b839', 16, NULL, 'Phillis be kind and hear', 'Phillis be kind and hear', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c0cd536-8929-4735-8e37-62628e57b839'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c4f3b51-e67e-4db8-85f8-4fb9dbecfb45', 17, NULL, 'Phillis advised: Phillis the lovely', 'Phillis advised: Phillis the lovely', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c4f3b51-e67e-4db8-85f8-4fb9dbecfb45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0b73967-5e80-4e24-9d37-bc467e965ccd', 18, NULL, 'Stand round, my brave boys', 'Stand round, my brave boys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0b73967-5e80-4e24-9d37-bc467e965ccd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1b29acf-0fca-4fd0-9227-dace5e413895', 19, NULL, 'The faithful Maid', 'The faithful Maid', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1b29acf-0fca-4fd0-9227-dace5e413895'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc201d5f-5ff7-48d9-bcea-738d6acb8f8e', 20, NULL, 'The Rapture', 'The Rapture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc201d5f-5ff7-48d9-bcea-738d6acb8f8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:762d26dc-fc33-4bf9-a44c-cdf6489cff84', 21, NULL, 'The Death of the Stag: When Phoebus the tops of the Hills does adorn', 'The Death of the Stag: When Phoebus the tops of the Hills does adorn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:762d26dc-fc33-4bf9-a44c-cdf6489cff84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb8eb75d-8127-4938-a6c9-90ea73efe2f3', 22, NULL, 'Who to win a Woman''s favour', 'Who to win a Woman''s favour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb8eb75d-8127-4938-a6c9-90ea73efe2f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:026e08c3-c672-4cce-aefb-c1df0e9c05d6', 23, NULL, 'An Answer to Collin''s Complaint: Ye winds to whome Collin complains', 'An Answer to Collin''s Complaint: Ye winds to whome Collin complains', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:026e08c3-c672-4cce-aefb-c1df0e9c05d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a402b33e-0dc0-422a-bd7b-d0df358b9240', 24, NULL, 'Yes, I''m in love', 'Yes, I''m in love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '24개의 영어 가곡 HWV 228' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a402b33e-0dc0-422a-bd7b-d0df358b9240'
);


-- HWV 230 종교 칸타타 <Ah! che troppo ineguali>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '종교 칸타타 <Ah! che troppo ineguali>', 'Sacred Cantata <Ah! che troppo ineguali>', 'song', 'HWV 230', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '종교 칸타타 <Ah! che troppo ineguali>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ba20d68-bf41-46ff-be80-432950588426'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3ba20d68-bf41-46ff-be80-432950588426'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '종교 칸타타 <Ah! che troppo ineguali>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ba20d68-bf41-46ff-be80-432950588426'
);


-- HWV 233 종교 칸타타 <Donna, che in ciel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '종교 칸타타 <Donna, che in ciel>', 'Sacred Cantata <Donna, che in ciel>', 'song', 'HWV 233', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '종교 칸타타 <Donna, che in ciel>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c426cb87-bd79-443c-9f49-b5e885d76100'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c426cb87-bd79-443c-9f49-b5e885d76100'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '종교 칸타타 <Donna, che in ciel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c426cb87-bd79-443c-9f49-b5e885d76100'
);


-- HWV 231 모테트 <Coelestis dum spirat aura>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Coelestis dum spirat aura>', 'Motet <Coelestis dum spirat aura>', 'song', 'HWV 231', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Coelestis dum spirat aura>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ad1b23f-d9c6-4c5b-9b1a-34c650ef822e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ad1b23f-d9c6-4c5b-9b1a-34c650ef822e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '모테트 <Coelestis dum spirat aura>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ad1b23f-d9c6-4c5b-9b1a-34c650ef822e'
);


-- HWV 232 시편 <Dixit Dominus> G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 <Dixit Dominus> G단조', 'Psalm <Dixit Dominus> in G minor', 'album', 'HWV 232', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 <Dixit Dominus> G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37c35905-2ab0-4385-b970-48842b461dde'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '37c35905-2ab0-4385-b970-48842b461dde'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Dixit Dominus> G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37c35905-2ab0-4385-b970-48842b461dde'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d75374af-d500-38e8-a074-f5f9c855ffc1', 1, 'I', '합창 "Dixit Dominus"', 'I. Chorus "Dixit Dominus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Dixit Dominus> G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d75374af-d500-38e8-a074-f5f9c855ffc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6b0affe-a4ea-344f-9afd-23b0bd4abbb3', 2, 'II', '아리아 "Virgam virtutis tuae"', 'II. Aria "Virgam virtutis tuae"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Dixit Dominus> G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6b0affe-a4ea-344f-9afd-23b0bd4abbb3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6de92f51-dfd0-36f6-b09d-b50581b7dfe1', 3, 'III', '아리아 "Tecum principium"', 'III. Aria "Tecum principium"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Dixit Dominus> G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6de92f51-dfd0-36f6-b09d-b50581b7dfe1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:783100bf-c28c-3893-ab13-a2af38a2fb0f', 4, 'IV', '합창 "Juravit Dominus"', 'IV. Chorus "Juravit Dominus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Dixit Dominus> G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:783100bf-c28c-3893-ab13-a2af38a2fb0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8eea0081-c675-3944-9928-20f9f552192e', 5, 'V', '합창 "Tu es sacerdos in aeternum"', 'V. Chorus "Tu es sacerdos in aeternum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Dixit Dominus> G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8eea0081-c675-3944-9928-20f9f552192e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:298c0e1c-99ca-3eef-99b1-57ba533aca45', 6, 'VI', 'Dominus a dextris tuis', 'VI. Dominus a dextris tuis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Dixit Dominus> G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:298c0e1c-99ca-3eef-99b1-57ba533aca45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feb6be37-2aad-4705-a023-aa17ab46beb8', 7, 'VII', '합창 "Judicabit in nationibus"', 'VII. Chorus "Judicabit in nationibus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Dixit Dominus> G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feb6be37-2aad-4705-a023-aa17ab46beb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a69a14e2-7f07-3c8d-ac6f-a5b6bce848ab', 8, 'VIII', '2중창과 합창 "De torrente in via bibet"', 'VIII. Duet & Chorus "De torrente in via bibet"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Dixit Dominus> G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a69a14e2-7f07-3c8d-ac6f-a5b6bce848ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6809f5af-1e91-3227-a85c-91186a301739', 9, 'IX', '합창 "Gloria Patri, et Filio"', 'IX. Chorus "Gloria Patri, et Filio"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Dixit Dominus> G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6809f5af-1e91-3227-a85c-91186a301739'
);


-- HWV 235 안티폰 <Haec est Regina virginum>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안티폰 <Haec est Regina virginum>', 'Antiphon <Haec est Regina virginum>', 'song', 'HWV 235', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안티폰 <Haec est Regina virginum>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41bd5be0-4e1f-4480-a03f-d1831997f5b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '41bd5be0-4e1f-4480-a03f-d1831997f5b7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '안티폰 <Haec est Regina virginum>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41bd5be0-4e1f-4480-a03f-d1831997f5b7'
);


-- HWV 236 시편 <Laudate pueri Dominum> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 <Laudate pueri Dominum> F장조', 'Psalm <Laudate pueri Dominum> in F major', 'album', 'HWV 236', NULL, NULL, 1706, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 <Laudate pueri Dominum> F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dce94774-3fe9-46fe-ad76-bc13062a90b4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dce94774-3fe9-46fe-ad76-bc13062a90b4'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dce94774-3fe9-46fe-ad76-bc13062a90b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4387e9a8-fab6-4db5-849c-e20d2b42e15b', 1, 'I', 'Laudate pueri Dominum', 'I. Laudate pueri Dominum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4387e9a8-fab6-4db5-849c-e20d2b42e15b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f64a13a-dfa6-4252-b5a2-aec110131c86', 2, 'II', 'Sit nomen Domini benedictum', 'II. Sit nomen Domini benedictum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f64a13a-dfa6-4252-b5a2-aec110131c86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66cd021e-5972-4b0e-a00c-8fc2711661f4', 3, 'III', 'A solis ortu usque ad occasum', 'III. A solis ortu usque ad occasum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66cd021e-5972-4b0e-a00c-8fc2711661f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41c3eb26-6c70-4d69-9c2f-979d4b9f0c53', 4, 'IV', 'Excelsus super omnes gentes Dominus', 'IV. Excelsus super omnes gentes Dominus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41c3eb26-6c70-4d69-9c2f-979d4b9f0c53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:087b7bbd-9c1b-4c05-a3d6-4404e6bfadf6', 5, 'V', 'Quis sicut Dominus', 'V. Quis sicut Dominus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:087b7bbd-9c1b-4c05-a3d6-4404e6bfadf6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6235a134-ce73-4584-884c-472e0835db94', 6, 'VI', 'Ut collocet eum cum principibus', 'VI. Ut collocet eum cum principibus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6235a134-ce73-4584-884c-472e0835db94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:552198a5-00cb-4bcb-a4ab-8a07899e0a8c', 7, 'VII', 'Qui habitare facit', 'VII. Qui habitare facit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:552198a5-00cb-4bcb-a4ab-8a07899e0a8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37f0adc1-d350-4e5f-860a-5228c0c4bdf4', 8, 'VIII', 'Gloria Patri et Filio et Spiritui Sancto', 'VIII. Gloria Patri et Filio et Spiritui Sancto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37f0adc1-d350-4e5f-860a-5228c0c4bdf4'
);


-- HWV 237 시편 <Laudate pueri Dominum> D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 <Laudate pueri Dominum> D장조', 'Psalm <Laudate pueri Dominum> in D major', 'album', 'HWV 237', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 <Laudate pueri Dominum> D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbdd4d0f-8cd5-47a8-a254-f8fba7b58cd3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bbdd4d0f-8cd5-47a8-a254-f8fba7b58cd3'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbdd4d0f-8cd5-47a8-a254-f8fba7b58cd3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81865ce9-a704-3189-bdea-1c7f4952ba37', 1, 'I', 'Laudate pueri Dominum', 'I. Laudate pueri Dominum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81865ce9-a704-3189-bdea-1c7f4952ba37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:914af357-1cf4-4a41-bf9b-5632870bada2', 2, 'II', 'Sit nomen Domini', 'II. Sit nomen Domini', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:914af357-1cf4-4a41-bf9b-5632870bada2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6490e7a9-aefb-4735-aa80-967352489aaa', 3, 'III', 'A solis ortu usque ad occasum', 'III. A solis ortu usque ad occasum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6490e7a9-aefb-4735-aa80-967352489aaa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c36a5f74-cf35-40f6-ba3f-67377c78dd52', 4, 'IV', 'Excelsus super omnes gentes Dominus', 'IV. Excelsus super omnes gentes Dominus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c36a5f74-cf35-40f6-ba3f-67377c78dd52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49bd2e86-ca97-4cc2-9f8e-a29907f9590c', 5, 'V', 'Quis sicut Dominus Deus noster', 'V. Quis sicut Dominus Deus noster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49bd2e86-ca97-4cc2-9f8e-a29907f9590c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3cd0eb9-bcec-45aa-a8b6-323af5e52c7a', 6, 'VI', 'Suscitans a terra inopem', 'VI. Suscitans a terra inopem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3cd0eb9-bcec-45aa-a8b6-323af5e52c7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01119b38-6f9d-4140-94f0-7147e45d32ec', 7, 'VII', 'Qui habitare facit sterilem in domo', 'VII. Qui habitare facit sterilem in domo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01119b38-6f9d-4140-94f0-7147e45d32ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:128d27c0-8128-4c8a-be82-d5e6ce771121', 8, 'VIII', 'Gloria', 'VIII. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Laudate pueri Dominum> D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:128d27c0-8128-4c8a-be82-d5e6ce771121'
);


-- HWV 238 시편 <Nisi Dominus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 <Nisi Dominus>', 'Psalm <Nisi Dominus>', 'album', 'HWV 238', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 <Nisi Dominus>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7b47e3e-6a01-4d79-8d77-f91dbf2fbb81'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f7b47e3e-6a01-4d79-8d77-f91dbf2fbb81'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Nisi Dominus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7b47e3e-6a01-4d79-8d77-f91dbf2fbb81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ab935fa-88d5-4eb4-9620-e719c85debbd', 1, 'I', 'Nisi Dominus', 'I. Nisi Dominus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Nisi Dominus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ab935fa-88d5-4eb4-9620-e719c85debbd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cef1a54d-6620-4e0a-a355-5fed9a657896', 2, 'II', 'Vanum est', 'II. Vanum est', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Nisi Dominus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cef1a54d-6620-4e0a-a355-5fed9a657896'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a88c11c-e1f5-431f-a28f-4ea9751ba65f', 3, 'III', 'Cum dederit dilectis suis somnum', 'III. Cum dederit dilectis suis somnum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Nisi Dominus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a88c11c-e1f5-431f-a28f-4ea9751ba65f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d17d2545-b6bc-452a-8c74-555cb419dc6c', 4, 'IV', 'Sicut sagittae in manu potentis', 'IV. Sicut sagittae in manu potentis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Nisi Dominus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d17d2545-b6bc-452a-8c74-555cb419dc6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31a08aca-2709-446a-84be-b891ef277c3b', 5, 'V', 'Beatus vir', 'V. Beatus vir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Nisi Dominus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31a08aca-2709-446a-84be-b891ef277c3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd1e0077-a8cf-4342-bc58-4198ff50ed14', 6, 'VI', 'Gloria Patri', 'VI. Gloria Patri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '시편 <Nisi Dominus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd1e0077-a8cf-4342-bc58-4198ff50ed14'
);


-- HWV 239 모테트 <O qualis de coelo sonus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <O qualis de coelo sonus>', 'Motet <O qualis de coelo sonus>', 'song', 'HWV 239', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <O qualis de coelo sonus>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce04e4c8-0148-45f6-b524-2a82294a2305'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ce04e4c8-0148-45f6-b524-2a82294a2305'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '모테트 <O qualis de coelo sonus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce04e4c8-0148-45f6-b524-2a82294a2305'
);


-- HWV 240 모테트 <Saeviat tellus inter rigores>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Saeviat tellus inter rigores>', 'Motet <Saeviat tellus inter rigores>', 'song', 'HWV 240', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Saeviat tellus inter rigores>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac5f5558-4829-46f7-a15b-fd1e67a253e2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac5f5558-4829-46f7-a15b-fd1e67a253e2'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '모테트 <Saeviat tellus inter rigores>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac5f5558-4829-46f7-a15b-fd1e67a253e2'
);


-- HWV 241 살베 레지나 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '살베 레지나 G단조', 'Salve Regina in G minor', 'album', 'HWV 241', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '살베 레지나 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8768987-853d-4006-956a-a8019e0f78ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f8768987-853d-4006-956a-a8019e0f78ee'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '살베 레지나 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8768987-853d-4006-956a-a8019e0f78ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:479b6707-b44d-48a0-b644-6866df158103', 1, 'I', 'Largo - Adagio "Salve Regina"', 'I. Largo - Adagio "Salve Regina"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '살베 레지나 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:479b6707-b44d-48a0-b644-6866df158103'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09126d18-532c-43b9-9c5b-1e13d66648a8', 2, 'II', 'Allegro "Eja ergo advocata nostra"', 'II. Allegro "Eja ergo advocata nostra"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '살베 레지나 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09126d18-532c-43b9-9c5b-1e13d66648a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a1936d7-c8ea-4bb2-8381-53bea6d0e3e6', 3, 'III', 'Adagissimo "O clemens, o pia"', 'III. Adagissimo "O clemens, o pia"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '살베 레지나 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a1936d7-c8ea-4bb2-8381-53bea6d0e3e6'
);


-- HWV 242 모테트 <Silete venti>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Silete venti>', 'Motet <Silete venti>', 'album', 'HWV 242', NULL, NULL, 1725, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Silete venti>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ecbadd0-3ed3-4e2b-acce-b00bf0d96a56'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5ecbadd0-3ed3-4e2b-acce-b00bf0d96a56'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '모테트 <Silete venti>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ecbadd0-3ed3-4e2b-acce-b00bf0d96a56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9de5b771-b85d-468e-9868-33317cf8ee25', 1, 'I', 'Symphonia - Silete venti', 'I. Symphonia - Silete venti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '모테트 <Silete venti>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9de5b771-b85d-468e-9868-33317cf8ee25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bf321b0-6c2a-419e-afc7-55e8366b2b0a', 2, 'II', 'Dulcis amor, Jesus care', 'II. Dulcis amor, Jesus care', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '모테트 <Silete venti>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bf321b0-6c2a-419e-afc7-55e8366b2b0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30718a1e-50ce-43ce-9777-3a8834844ec0', 3, 'III', 'O fortunata anima', 'III. O fortunata anima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '모테트 <Silete venti>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30718a1e-50ce-43ce-9777-3a8834844ec0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef81811a-1640-489f-ad72-420602b881b4', 4, 'IV', 'Date serta, date flores', 'IV. Date serta, date flores', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '모테트 <Silete venti>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef81811a-1640-489f-ad72-420602b881b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:180f4ef5-01df-4a17-94f6-31a9a7f804db', 5, 'V', 'Alleluia', 'V. Alleluia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '모테트 <Silete venti>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:180f4ef5-01df-4a17-94f6-31a9a7f804db'
);


-- HWV 243 안티폰 <Te decus virgineum>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안티폰 <Te decus virgineum>', 'Antiphon <Te decus virgineum>', 'song', 'HWV 243', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안티폰 <Te decus virgineum>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7a2d322-0bdf-4c14-b098-65f86cfebc39'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e7a2d322-0bdf-4c14-b098-65f86cfebc39'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '안티폰 <Te decus virgineum>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7a2d322-0bdf-4c14-b098-65f86cfebc39'
);


-- HWV 269–277 9개의 아멘과 알렐루야 HWV 269–277

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '9개의 아멘과 알렐루야 HWV 269–277', '9 Amen and Alleluia Settings, HWV 269–277', 'album', NULL, 'HWV', '269–277', 1747, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '9개의 아멘과 알렐루야 HWV 269–277'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86aead95-af0f-4cbc-a016-27ab776da2a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86aead95-af0f-4cbc-a016-27ab776da2a7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 아멘과 알렐루야 HWV 269–277' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86aead95-af0f-4cbc-a016-27ab776da2a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a7e0462-6f16-46c8-91ed-2ec4909877ab', 1, NULL, '아멘, 알렐루야 D단조', 'Amen, alleluja in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 아멘과 알렐루야 HWV 269–277' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a7e0462-6f16-46c8-91ed-2ec4909877ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69ceba69-86d5-417c-8367-b4d9dc6f6966', 2, NULL, '아멘 F장조', 'Amen in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 아멘과 알렐루야 HWV 269–277' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69ceba69-86d5-417c-8367-b4d9dc6f6966'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18986de6-21f6-416e-9031-43d3e52e7453', 3, NULL, '아멘, 알렐루야 G단조', 'Amen, alleluja in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 아멘과 알렐루야 HWV 269–277' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18986de6-21f6-416e-9031-43d3e52e7453'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:329806d2-daf8-4526-978d-7c22db09e8b2', 4, NULL, '알렐루야, 아멘 D단조', 'Alleluja, amen in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 아멘과 알렐루야 HWV 269–277' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:329806d2-daf8-4526-978d-7c22db09e8b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:150c8ad0-f854-4837-8f40-a219fec24f3c', 5, NULL, '알렐루야, 아멘 G장조', 'Alleluja, amen in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 아멘과 알렐루야 HWV 269–277' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:150c8ad0-f854-4837-8f40-a219fec24f3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a02e0a3a-d926-412e-aa56-a6fda2da12b7', 6, NULL, '알렐루야, 아멘 A단조', 'Alleluja, amen in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 아멘과 알렐루야 HWV 269–277' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a02e0a3a-d926-412e-aa56-a6fda2da12b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fa40b5d-64b9-4aa0-b4db-9f254d200617', 7, NULL, '알렐루야, 아멘', 'Alleluja, amen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 아멘과 알렐루야 HWV 269–277' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fa40b5d-64b9-4aa0-b4db-9f254d200617'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a56aca14-f07c-48e3-b5fb-fd7cc072627c', 8, NULL, '아멘, 할렐루야 F장조', 'Amen, hallelujah in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 아멘과 알렐루야 HWV 269–277' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a56aca14-f07c-48e3-b5fb-fd7cc072627c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e134e90-ec9f-4ba6-9196-6c5610aa86b5', 9, NULL, '할렐루야, 아멘 F장조', 'Hallelujah, amen in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '9개의 아멘과 알렐루야 HWV 269–277' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e134e90-ec9f-4ba6-9196-6c5610aa86b5'
);


-- HWV 246–256 챈도스 찬가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '챈도스 찬가', 'Chandos Anthems', 'album', 'HWV 246–256', NULL, NULL, 1718, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '챈도스 찬가'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f4f01b1-039c-4c35-b4d4-c62f3bdce45e', 1, NULL, 'O be joyful in the Lord', 'O be joyful in the Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f4f01b1-039c-4c35-b4d4-c62f3bdce45e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b14cf4a4-6d59-4143-a814-661a9127ae9c', 1, 'I', '소나타', 'I. Sonata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4f4f01b1-039c-4c35-b4d4-c62f3bdce45e'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b14cf4a4-6d59-4143-a814-661a9127ae9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:426037c7-daaa-40dd-afe1-860e94e72fb8', 2, 'II', '독창과 합창 "O be joyful in the Lord"', 'II. Solo and Chorus "O be joyful in the Lord"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4f4f01b1-039c-4c35-b4d4-c62f3bdce45e'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:426037c7-daaa-40dd-afe1-860e94e72fb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3361dfa6-0d63-4191-9db1-01e3f7e10bef', 3, 'III', '합창 "Serve the Lord with gladness"', 'III. Chorus "Serve the Lord with gladness"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4f4f01b1-039c-4c35-b4d4-c62f3bdce45e'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3361dfa6-0d63-4191-9db1-01e3f7e10bef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:756447cc-5d9f-4b2a-8819-feba39cf518a', 4, 'IV', '2중창 "Be ye sure that the Lord he is God"', 'IV. Duet "Be ye sure that the Lord he is God"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4f4f01b1-039c-4c35-b4d4-c62f3bdce45e'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:756447cc-5d9f-4b2a-8819-feba39cf518a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bac7b405-786f-4a1c-a44d-d3407e3223ea', 5, 'V', '합창 "O go your way into his gates"', 'V. Chorus "O go your way into his gates"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4f4f01b1-039c-4c35-b4d4-c62f3bdce45e'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bac7b405-786f-4a1c-a44d-d3407e3223ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3c1fd3e8-9574-42b6-9296-5190d79e92d9', 6, 'VI', '3중창 "For the Lord is gracious"', 'VI. Trio "For the Lord is gracious"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4f4f01b1-039c-4c35-b4d4-c62f3bdce45e'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c1fd3e8-9574-42b6-9296-5190d79e92d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c0587da6-d874-469f-a9d0-016b08b2eea1', 7, 'VII', '합창 "Glory be to the Father"', 'VII. Chorus "Glory be to the Father"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4f4f01b1-039c-4c35-b4d4-c62f3bdce45e'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0587da6-d874-469f-a9d0-016b08b2eea1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8ac77be-807b-452e-85a0-d25e886b6596', 8, 'VIII', '합창 "As it was in the beginning"', 'VIII. Chorus "As it was in the beginning"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4f4f01b1-039c-4c35-b4d4-c62f3bdce45e'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8ac77be-807b-452e-85a0-d25e886b6596'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbdb2b89-1567-450c-8069-9477395635d3', 2, NULL, 'In the Lord put I my trust', 'In the Lord put I my trust', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbdb2b89-1567-450c-8069-9477395635d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:086f6da6-598b-465b-88d0-8499cb0b0e56', 1, 'I', '소나타', 'I. Sonata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbdb2b89-1567-450c-8069-9477395635d3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:086f6da6-598b-465b-88d0-8499cb0b0e56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00c96a6f-6374-430f-9023-7dc9b39a214b', 2, 'II', '합창 "In the Lord put I my trust!"', 'II. Chorus "In the Lord put I my trust!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbdb2b89-1567-450c-8069-9477395635d3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00c96a6f-6374-430f-9023-7dc9b39a214b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6601f009-a94e-4561-98cb-e4edb3263755', 3, 'III', '독창 "God is a constant sure defence" (테너)', 'III. Solo "God is a constant sure defence" (tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbdb2b89-1567-450c-8069-9477395635d3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6601f009-a94e-4561-98cb-e4edb3263755'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:305cc28e-bdd4-4edb-9822-f5c04ca5b269', 4, 'IV', '합창 "Behold! The wicked bend their bow"', 'IV. Chorus "Behold! The wicked bend their bow"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbdb2b89-1567-450c-8069-9477395635d3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:305cc28e-bdd4-4edb-9822-f5c04ca5b269'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:46676012-57fc-4940-a185-a23ab85ceaa7', 5, 'V', '독창 "But God, who hears the suff''ring pow''r" (테너)', 'V. Solo "But God, who hears the suff''ring pow''r" (tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbdb2b89-1567-450c-8069-9477395635d3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46676012-57fc-4940-a185-a23ab85ceaa7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05c9e684-7326-431c-8d84-2bf8a94a78d9', 6, 'VI', '합창 "Snares, fire and brimstone"', 'VI. Chorus "Snares, fire and brimstone"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbdb2b89-1567-450c-8069-9477395635d3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05c9e684-7326-431c-8d84-2bf8a94a78d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85a21ea7-8cc0-4ea9-b0e4-97352fe209be', 7, 'VII', '독창 "The righteous Lord" (테너)', 'VII. Solo "The righteous Lord" (tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbdb2b89-1567-450c-8069-9477395635d3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85a21ea7-8cc0-4ea9-b0e4-97352fe209be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e3ce27b-8ff4-42bb-8f23-c099f6cf34ee', 8, 'VIII', '합창 "Then shall my song"', 'VIII. Chorus "Then shall my song"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbdb2b89-1567-450c-8069-9477395635d3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e3ce27b-8ff4-42bb-8f23-c099f6cf34ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cd9feb4-f497-4d65-8d93-5328152fcd96', 3, NULL, 'Have mercy upon me', 'Have mercy upon me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cd9feb4-f497-4d65-8d93-5328152fcd96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b2c57ae9-c3e3-42d6-8b36-493615a4e47f', 1, 'I', '소나타', 'I. Sonata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7cd9feb4-f497-4d65-8d93-5328152fcd96'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2c57ae9-c3e3-42d6-8b36-493615a4e47f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1306ec63-3548-4e2c-ae58-5df3c8341e0c', 2, 'II', '합창 "Have mercy upon me, O God"', 'II. Chorus "Have mercy upon me, O God"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7cd9feb4-f497-4d65-8d93-5328152fcd96'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1306ec63-3548-4e2c-ae58-5df3c8341e0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2a63e29-52a6-43f6-86d7-a476e100309f', 3, 'III', '2중창 "Wash me throughly from my wickedness"', 'III. Duet "Wash me throughly from my wickedness"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7cd9feb4-f497-4d65-8d93-5328152fcd96'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2a63e29-52a6-43f6-86d7-a476e100309f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bcc6c045-8e38-4541-b332-fdfec07e52c6', 4, 'IV', '독창 "For I acknowledge my faults"', 'IV. Solo "For I acknowledge my faults"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7cd9feb4-f497-4d65-8d93-5328152fcd96'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcc6c045-8e38-4541-b332-fdfec07e52c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c5c76d7d-741b-40fb-871a-a01627c21ae7', 5, 'V', '독창 "Against thee only have I sinned"', 'V. Solo "Against thee only have I sinned"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7cd9feb4-f497-4d65-8d93-5328152fcd96'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5c76d7d-741b-40fb-871a-a01627c21ae7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f2febac-7c49-44f9-9f83-bec48ef27ba3', 6, 'VI', '합창 "Thou shalt make me hear of joy and gladness"', 'VI. Chorus "Thou shalt make me hear of joy and gladness"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7cd9feb4-f497-4d65-8d93-5328152fcd96'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f2febac-7c49-44f9-9f83-bec48ef27ba3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3df92c98-9434-490e-bc1c-b2bd899b0df0', 7, 'VII', '독창 "Make me a clean heart, O God"', 'VII. Solo "Make me a clean heart, O God"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7cd9feb4-f497-4d65-8d93-5328152fcd96'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3df92c98-9434-490e-bc1c-b2bd899b0df0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f206a30f-f23e-4685-af74-922f7d53ae4a', 8, 'VIII', '합창 "Then shall I teach Thy ways unto the wicked"', 'VIII. Chorus "Then shall I teach Thy ways unto the wicked"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7cd9feb4-f497-4d65-8d93-5328152fcd96'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f206a30f-f23e-4685-af74-922f7d53ae4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1374d52-642c-4b93-af72-5dcbda1e7d92', 4, NULL, 'O sing unto the Lord a new song', 'O sing unto the Lord a new song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1374d52-642c-4b93-af72-5dcbda1e7d92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78d4c78d-4275-4cb4-a4e8-c3246da729d7', 1, 'I', '소나타', 'I. Sonata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1374d52-642c-4b93-af72-5dcbda1e7d92'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78d4c78d-4275-4cb4-a4e8-c3246da729d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:723efee0-2bf6-4183-864b-beeb2ec39b67', 2, 'II', 'O Sing Unto the Lord, and Praise His Name', 'II. O Sing Unto the Lord, and Praise His Name', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1374d52-642c-4b93-af72-5dcbda1e7d92'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:723efee0-2bf6-4183-864b-beeb2ec39b67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7241d0f9-16a4-4b26-a4d2-841555b35e83', 3, 'III', 'Declare His Honour Unto the Heathen', 'III. Declare His Honour Unto the Heathen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1374d52-642c-4b93-af72-5dcbda1e7d92'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7241d0f9-16a4-4b26-a4d2-841555b35e83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22769384-2e27-48ab-aee6-e5e033a9eb6b', 4, 'IV', 'The Waves of the Sea Rage', 'IV. The Waves of the Sea Rage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1374d52-642c-4b93-af72-5dcbda1e7d92'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22769384-2e27-48ab-aee6-e5e033a9eb6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d44153fb-85de-4cd8-8069-4de6c24e7977', 5, 'V', 'O Worship the Lord in the Beauty', 'V. O Worship the Lord in the Beauty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1374d52-642c-4b93-af72-5dcbda1e7d92'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d44153fb-85de-4cd8-8069-4de6c24e7977'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de9dbbde-4b28-49a0-b07e-9b656f564ef2', 6, 'VI', 'Let the Whole Earth Stand in Awe', 'VI. Let the Whole Earth Stand in Awe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1374d52-642c-4b93-af72-5dcbda1e7d92'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de9dbbde-4b28-49a0-b07e-9b656f564ef2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31ea1cfa-27ad-4acf-907d-9b385d61dac5', 7, 'VII', 'Let the Heav''ns Rejoice', 'VII. Let the Heav''ns Rejoice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1374d52-642c-4b93-af72-5dcbda1e7d92'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31ea1cfa-27ad-4acf-907d-9b385d61dac5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f300a3ee-0c08-452a-b85a-0d062f94902d', 8, 'VIII', 'For He Cometh to Judge the Earth', 'VIII. For He Cometh to Judge the Earth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1374d52-642c-4b93-af72-5dcbda1e7d92'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f300a3ee-0c08-452a-b85a-0d062f94902d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2bcecbb-e367-43fb-971a-58a2dc997358', 5, NULL, 'I will magnify thee', 'I will magnify thee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2bcecbb-e367-43fb-971a-58a2dc997358'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6eef669c-12d6-4ea8-b2ba-3a84b5ee7692', 1, 'I', '소나타', 'I. Sonata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2bcecbb-e367-43fb-971a-58a2dc997358'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6eef669c-12d6-4ea8-b2ba-3a84b5ee7692'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff917a33-2694-42dc-8311-c3a2a2b352a1', 2, 'II', 'I Will Magnify Thee, O God (합창)', 'II. I Will Magnify Thee, O God (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2bcecbb-e367-43fb-971a-58a2dc997358'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff917a33-2694-42dc-8311-c3a2a2b352a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d899c7c8-b6a6-4339-a08d-79eb31adb9e2', 3, 'III', 'Ev''ry Day Will I Give Thanks Unto Thee (테너)', 'III. Ev''ry Day Will I Give Thanks Unto Thee (Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2bcecbb-e367-43fb-971a-58a2dc997358'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d899c7c8-b6a6-4339-a08d-79eb31adb9e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2067c302-af5b-409b-bf1d-03598595e96c', 4, 'IV', 'One Generation Shall Praise Thy Works Unto Another (합창)', 'IV. One Generation Shall Praise Thy Works Unto Another (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2bcecbb-e367-43fb-971a-58a2dc997358'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2067c302-af5b-409b-bf1d-03598595e96c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dea83b06-b205-4715-ab1c-f8eb8df02758', 5, 'V', 'The Lord Preserveth All Them That Love Him (테너)', 'V. The Lord Preserveth All Them That Love Him (Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2bcecbb-e367-43fb-971a-58a2dc997358'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dea83b06-b205-4715-ab1c-f8eb8df02758'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:23173d97-d8af-48ba-9264-fcee153d45fe', 6, 'VI', 'The Lord is Righteous in All His Ways (소프라노)', 'VI. The Lord is Righteous in All His Ways (Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2bcecbb-e367-43fb-971a-58a2dc997358'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23173d97-d8af-48ba-9264-fcee153d45fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3a34edab-f410-4dfc-8a12-9df9a0ee4c4d', 7, 'VII', 'Happy Are the People That Are in Such a Case (테너)', 'VII. Happy Are the People That Are in Such a Case (Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2bcecbb-e367-43fb-971a-58a2dc997358'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a34edab-f410-4dfc-8a12-9df9a0ee4c4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:48efcac9-1caa-493f-8acb-11bbb4933103', 8, 'VIII', 'My Mouth Shall Speak the Praise of the Lord (테너, 합창)', 'VIII. My Mouth Shall Speak the Praise of the Lord (Tenor, Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2bcecbb-e367-43fb-971a-58a2dc997358'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48efcac9-1caa-493f-8acb-11bbb4933103'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:930bd799-7a11-4b63-a6f3-1897bf55558f', 6, NULL, 'As pants the hart', 'As pants the hart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:930bd799-7a11-4b63-a6f3-1897bf55558f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:52b11813-138b-3dde-9a6c-4b44aa38081e', 1, 'I', '소나타', 'I. Sonata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:930bd799-7a11-4b63-a6f3-1897bf55558f'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52b11813-138b-3dde-9a6c-4b44aa38081e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7518e3d5-6402-3924-b663-29ad9dae0cf4', 2, 'II', 'As Pants the Hart', 'II. As Pants the Hart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:930bd799-7a11-4b63-a6f3-1897bf55558f'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7518e3d5-6402-3924-b663-29ad9dae0cf4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0a246038-99a5-3c15-9fa8-9bdd90f54436', 3, 'III', 'Tears Are My Daily Food', 'III. Tears Are My Daily Food', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:930bd799-7a11-4b63-a6f3-1897bf55558f'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a246038-99a5-3c15-9fa8-9bdd90f54436'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:74e626bb-55a3-333a-b7b8-33eaa3c41190', 4, 'IV', 'Now When I Think Thereupon', 'IV. Now When I Think Thereupon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:930bd799-7a11-4b63-a6f3-1897bf55558f'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74e626bb-55a3-333a-b7b8-33eaa3c41190'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:517c2b70-0161-343e-b2e7-3a5c5065de25', 5, 'V', 'In the Voice of Praise', 'V. In the Voice of Praise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:930bd799-7a11-4b63-a6f3-1897bf55558f'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:517c2b70-0161-343e-b2e7-3a5c5065de25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c0efceb7-ad94-36dc-99cb-87b16e070a41', 6, 'VI', 'Why So Full of Grief?', 'VI. Why So Full of Grief?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:930bd799-7a11-4b63-a6f3-1897bf55558f'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0efceb7-ad94-36dc-99cb-87b16e070a41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:278a1342-df1f-3bdc-aaaa-d7e64f84f80f', 7, 'VII', 'Put Thy Trust in God', 'VII. Put Thy Trust in God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:930bd799-7a11-4b63-a6f3-1897bf55558f'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:278a1342-df1f-3bdc-aaaa-d7e64f84f80f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7e30150-3c7f-4409-9627-2bf12c49e2f4', 7, NULL, 'My song shall be alway', 'My song shall be alway', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7e30150-3c7f-4409-9627-2bf12c49e2f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da69bd39-ddcc-4a11-b88b-c594a1b16111', 1, 'I', '소나타', 'I. Sonata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7e30150-3c7f-4409-9627-2bf12c49e2f4'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da69bd39-ddcc-4a11-b88b-c594a1b16111'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09ec7501-93e0-4cac-9f0d-4b45c8fb14cc', 2, 'II', 'My Song Shall Be Alway', 'II. My Song Shall Be Alway', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7e30150-3c7f-4409-9627-2bf12c49e2f4'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09ec7501-93e0-4cac-9f0d-4b45c8fb14cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:be7a27a4-d62d-4330-b817-7467b1447a73', 3, 'III', 'For Who Is He Among the Clouds', 'III. For Who Is He Among the Clouds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7e30150-3c7f-4409-9627-2bf12c49e2f4'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be7a27a4-d62d-4330-b817-7467b1447a73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57b53d99-6c21-4bfe-a4e2-38391e233c22', 4, 'IV', 'God Is Very Greatly to Be Feared', 'IV. God Is Very Greatly to Be Feared', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7e30150-3c7f-4409-9627-2bf12c49e2f4'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57b53d99-6c21-4bfe-a4e2-38391e233c22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:76c22955-3572-4d45-b5a5-7823140b2118', 5, 'V', 'The Heav''ns Are Thine', 'V. The Heav''ns Are Thine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7e30150-3c7f-4409-9627-2bf12c49e2f4'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76c22955-3572-4d45-b5a5-7823140b2118'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c11f560-065b-44a7-a645-0bd541f25e28', 6, 'VI', 'Righteousness & Equity', 'VI. Righteousness & Equity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7e30150-3c7f-4409-9627-2bf12c49e2f4'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c11f560-065b-44a7-a645-0bd541f25e28'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35adfbff-9ea7-44e4-a804-47a22d1aa7e6', 7, 'VII', 'Blessed Is the People', 'VII. Blessed Is the People', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7e30150-3c7f-4409-9627-2bf12c49e2f4'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35adfbff-9ea7-44e4-a804-47a22d1aa7e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c81a6d1-5148-4fe1-984a-e630c6272271', 8, 'VIII', 'Thou Art the Glory', 'VIII. Thou Art the Glory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7e30150-3c7f-4409-9627-2bf12c49e2f4'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c81a6d1-5148-4fe1-984a-e630c6272271'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:328ca43b-27f3-4abf-bd5b-7bde0a5b978b', 8, NULL, 'O come, let us sing unto the Lord', 'O come, let us sing unto the Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:328ca43b-27f3-4abf-bd5b-7bde0a5b978b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:953f9ba8-a6a7-4be9-b6da-fb4600c42703', 1, 'I', '소나타', 'I. Sonata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:328ca43b-27f3-4abf-bd5b-7bde0a5b978b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:953f9ba8-a6a7-4be9-b6da-fb4600c42703'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bac2299a-509b-4f14-b498-0082ce88acba', 2, 'II', 'O Come Let Us Sing Unto the Lord (합창)', 'II. O Come Let Us Sing Unto the Lord (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:328ca43b-27f3-4abf-bd5b-7bde0a5b978b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bac2299a-509b-4f14-b498-0082ce88acba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:44f7f913-fd0f-4331-b29a-6888782ab540', 3, 'III', 'O Come Let Us Worship (테너)', 'III. O Come Let Us Worship (Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:328ca43b-27f3-4abf-bd5b-7bde0a5b978b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44f7f913-fd0f-4331-b29a-6888782ab540'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5f756f1b-472d-4750-8fab-0fbe60ceb328', 4, 'IV', 'Glory and Worship Are Before Him (합창)', 'IV. Glory and Worship Are Before Him (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:328ca43b-27f3-4abf-bd5b-7bde0a5b978b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f756f1b-472d-4750-8fab-0fbe60ceb328'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f6ac6128-618d-4187-a809-4626bd36067d', 5, 'V', 'Tell it Out Among the Heathen (테너, 합창)', 'V. Tell it Out Among the Heathen (Tenor, Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:328ca43b-27f3-4abf-bd5b-7bde0a5b978b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6ac6128-618d-4187-a809-4626bd36067d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:345dacf1-7d87-42b0-8e57-dd2af9c0a9d8', 6, 'VI', 'O Magnify the Lord (소프라노)', 'VI. O Magnify the Lord (Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:328ca43b-27f3-4abf-bd5b-7bde0a5b978b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:345dacf1-7d87-42b0-8e57-dd2af9c0a9d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:414635d4-403c-4803-8132-a2483988fcd5', 7, 'VII', 'The Lord Preserveth the Souls (테너)', 'VII. The Lord Preserveth the Souls (Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:328ca43b-27f3-4abf-bd5b-7bde0a5b978b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:414635d4-403c-4803-8132-a2483988fcd5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6483b1e6-8e69-4374-84b9-33f84a1231fe', 8, 'VIII', 'For Look, as High as the Heaven is (테너)', 'VIII. For Look, as High as the Heaven is (Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:328ca43b-27f3-4abf-bd5b-7bde0a5b978b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6483b1e6-8e69-4374-84b9-33f84a1231fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f7310b73-e062-4559-9ce9-0c238d1154f2', 9, 'IX', 'There is Sprung Up a Light for the Righteous (합창)', 'IX. There is Sprung Up a Light for the Righteous (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:328ca43b-27f3-4abf-bd5b-7bde0a5b978b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7310b73-e062-4559-9ce9-0c238d1154f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:497c77e2-685b-44fe-8c73-a0f93186daa3', 9, NULL, 'O praise the Lord with one consent', 'O praise the Lord with one consent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:497c77e2-685b-44fe-8c73-a0f93186daa3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d839ced4-6f61-4c59-a79b-4b0cd8bcb223', 1, 'I', 'O Praise the Lord With One Consent', 'I. O Praise the Lord With One Consent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:497c77e2-685b-44fe-8c73-a0f93186daa3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d839ced4-6f61-4c59-a79b-4b0cd8bcb223'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d521f4ad-5ada-472e-9f46-b1b68a5621ca', 2, 'II', 'Praise Him, All Ye That in His House', 'II. Praise Him, All Ye That in His House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:497c77e2-685b-44fe-8c73-a0f93186daa3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d521f4ad-5ada-472e-9f46-b1b68a5621ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd7efec4-6771-49f3-a42e-978c090e0772', 3, 'III', 'For This Our Truest Int''rest Is', 'III. For This Our Truest Int''rest Is', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:497c77e2-685b-44fe-8c73-a0f93186daa3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd7efec4-6771-49f3-a42e-978c090e0772'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:863e350c-7a16-4ac8-a714-9af00dd7d994', 4, 'IV', 'That God Is Great', 'IV. That God Is Great', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:497c77e2-685b-44fe-8c73-a0f93186daa3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:863e350c-7a16-4ac8-a714-9af00dd7d994'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:065b337b-e7ff-4a72-8b5c-70b1b291478b', 5, 'V', 'With Cheerful Notes', 'V. With Cheerful Notes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:497c77e2-685b-44fe-8c73-a0f93186daa3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:065b337b-e7ff-4a72-8b5c-70b1b291478b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:27b21fd2-bd6c-455d-8629-d2a7c14c4ce2', 6, 'VI', 'God''s Tender Mercy', 'VI. God''s Tender Mercy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:497c77e2-685b-44fe-8c73-a0f93186daa3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27b21fd2-bd6c-455d-8629-d2a7c14c4ce2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a2d2f5e2-af67-40a3-b51d-d059b9ab5ed9', 7, 'VII', 'Ye Boundless Realms of Joy', 'VII. Ye Boundless Realms of Joy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:497c77e2-685b-44fe-8c73-a0f93186daa3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2d2f5e2-af67-40a3-b51d-d059b9ab5ed9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7ff14b45-8d37-4630-91c9-c5ff76e67e76', 8, 'VIII', 'Your Voices Raise', 'VIII. Your Voices Raise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:497c77e2-685b-44fe-8c73-a0f93186daa3'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ff14b45-8d37-4630-91c9-c5ff76e67e76'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a12f750e-6e82-4749-9109-8f3e9cb33e6b', 10, NULL, 'The Lord is my light', 'The Lord is my light', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a12f750e-6e82-4749-9109-8f3e9cb33e6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9eb24632-ead0-346e-8172-c8a1a952d92f', 1, 'I', '서곡', 'I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a12f750e-6e82-4749-9109-8f3e9cb33e6b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eb24632-ead0-346e-8172-c8a1a952d92f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ae01734-da26-339f-9c3f-6aba54e2bd2f', 2, 'II', 'The Lord Is My Light and Salvation', 'II. The Lord Is My Light and Salvation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a12f750e-6e82-4749-9109-8f3e9cb33e6b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ae01734-da26-339f-9c3f-6aba54e2bd2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b5f0d07-38f9-3f56-8c39-a750d68a5f50', 3, 'III', 'Though an Host of Men Were Laid Against Me', 'III. Though an Host of Men Were Laid Against Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a12f750e-6e82-4749-9109-8f3e9cb33e6b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b5f0d07-38f9-3f56-8c39-a750d68a5f50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a186e86-ca2b-31c3-9ca9-0cc2df455de4', 4, 'IV', 'One Thing Have I Desired of the Lord', 'IV. One Thing Have I Desired of the Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a12f750e-6e82-4749-9109-8f3e9cb33e6b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a186e86-ca2b-31c3-9ca9-0cc2df455de4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:20589c1d-3caa-3286-bc4c-9a76e724595a', 5, 'V', 'I Will Offer in His Dwelling an Oblation', 'V. I Will Offer in His Dwelling an Oblation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a12f750e-6e82-4749-9109-8f3e9cb33e6b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20589c1d-3caa-3286-bc4c-9a76e724595a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4dfabfc1-4571-3f6d-915e-7619683efd90', 6, 'VI', 'For Who Is God but the Lord', 'VI. For Who Is God but the Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a12f750e-6e82-4749-9109-8f3e9cb33e6b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dfabfc1-4571-3f6d-915e-7619683efd90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:819bde35-c40d-3941-b9cf-e037e0cf6ef6', 7, 'VII', 'The Lord is My Strength and My Shield', 'VII. The Lord is My Strength and My Shield', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a12f750e-6e82-4749-9109-8f3e9cb33e6b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:819bde35-c40d-3941-b9cf-e037e0cf6ef6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a0af871-23d3-3bb0-9786-48073e5a798a', 8, 'VIII', 'It Is the Lord That Ruleth the Sea', 'VIII. It Is the Lord That Ruleth the Sea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a12f750e-6e82-4749-9109-8f3e9cb33e6b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a0af871-23d3-3bb0-9786-48073e5a798a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cb2aa5c9-0b20-39e9-8391-add767a36d00', 9, 'IX', 'Sing Praises Unto the Lord', 'IX. Sing Praises Unto the Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a12f750e-6e82-4749-9109-8f3e9cb33e6b'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb2aa5c9-0b20-39e9-8391-add767a36d00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be1297a0-f9d9-4c94-aef0-ce1cb338d295', 11, NULL, 'Let God arise', 'Let God arise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be1297a0-f9d9-4c94-aef0-ce1cb338d295'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:63c549e8-6b55-4fd0-b56b-c0985205f7ce', 1, 'I', '소나타', 'I. Sonata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be1297a0-f9d9-4c94-aef0-ce1cb338d295'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63c549e8-6b55-4fd0-b56b-c0985205f7ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd828ede-daf3-45ae-abdd-2bd374fac994', 2, 'II', 'Let God Arise', 'II. Let God Arise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be1297a0-f9d9-4c94-aef0-ce1cb338d295'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd828ede-daf3-45ae-abdd-2bd374fac994'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:422a5fde-91d4-4f55-9273-e80ca4f8c32c', 3, 'III', 'Like as the Smoke Vanisheth', 'III. Like as the Smoke Vanisheth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be1297a0-f9d9-4c94-aef0-ce1cb338d295'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:422a5fde-91d4-4f55-9273-e80ca4f8c32c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c0c6891-29d3-4f26-95be-317590f783b8', 4, 'IV', 'Let the Righteous Be Glad', 'IV. Let the Righteous Be Glad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be1297a0-f9d9-4c94-aef0-ce1cb338d295'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c0c6891-29d3-4f26-95be-317590f783b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:855c09a8-0089-4547-9715-225ae25dcca5', 5, 'V', 'O Sing Unto God', 'V. O Sing Unto God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be1297a0-f9d9-4c94-aef0-ce1cb338d295'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:855c09a8-0089-4547-9715-225ae25dcca5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e56e2188-4831-416c-83ee-cb9b16564451', 6, 'VI', 'Praised Be the Lord!', 'VI. Praised Be the Lord!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be1297a0-f9d9-4c94-aef0-ce1cb338d295'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e56e2188-4831-416c-83ee-cb9b16564451'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:02c63c48-479c-4947-9b61-e18455ebe11a', 7, 'VII', 'At Thy Rebuke, O God', 'VII. At Thy Rebuke, O God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be1297a0-f9d9-4c94-aef0-ce1cb338d295'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02c63c48-479c-4947-9b61-e18455ebe11a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f7fa18a-1744-401d-89ca-4c526325ffcd', 8, 'VIII', 'Blessed Be God', 'VIII. Blessed Be God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be1297a0-f9d9-4c94-aef0-ce1cb338d295'
WHERE p.composer_id = 6 AND p.title = '챈도스 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f7fa18a-1744-401d-89ca-4c526325ffcd'
);


-- HWV 249a 찬가 <O sing unto the Lord a new song>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬가 <O sing unto the Lord a new song>', 'Anthem <O sing unto the Lord a new song>', 'song', 'HWV 249a', NULL, NULL, 1714, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬가 <O sing unto the Lord a new song>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5acea7ba-6b8c-4b6a-9898-79eb53332e84'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5acea7ba-6b8c-4b6a-9898-79eb53332e84'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '찬가 <O sing unto the Lord a new song>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5acea7ba-6b8c-4b6a-9898-79eb53332e84'
);


-- HWV 258–261 대관식 찬가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대관식 찬가', 'Coronation Anthems', 'album', 'HWV 258–261', NULL, NULL, 1727, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대관식 찬가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba627125-7e1b-4ab4-8ec6-a6d77076001d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ba627125-7e1b-4ab4-8ec6-a6d77076001d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba627125-7e1b-4ab4-8ec6-a6d77076001d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 27 AND linked.composer_id = 6), 'musicbrainz:1a9b015f-43e9-3605-ba69-dd84bd642223', 1, NULL, '사제 차독 (Zadok the Priest)', 'Zadok the Priest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a9b015f-43e9-3605-ba69-dd84bd642223'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8afcbb58-bc65-4e38-b9a0-9b0c7868633c', 1, 'I', 'Zadok the Priest', 'I. Zadok the Priest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1a9b015f-43e9-3605-ba69-dd84bd642223'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8afcbb58-bc65-4e38-b9a0-9b0c7868633c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2ccf1bd-13d6-459b-b495-de7b93c6c74c', 2, 'II', 'And All the People Rejoic''d', 'II. And All the People Rejoic''d', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1a9b015f-43e9-3605-ba69-dd84bd642223'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2ccf1bd-13d6-459b-b495-de7b93c6c74c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32d5debf-25b3-4105-b9f2-5ae7715aae48', 3, 'III', 'God Save the King!', 'III. God Save the King!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1a9b015f-43e9-3605-ba69-dd84bd642223'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32d5debf-25b3-4105-b9f2-5ae7715aae48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b1434bc-cb70-46dd-ad17-900f6a6ea208', 2, NULL, 'Let thy hand be strengthened', 'Let thy hand be strengthened', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b1434bc-cb70-46dd-ad17-900f6a6ea208'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e91a193-458f-3ae2-908f-35b100d07983', 1, 'I', 'Let thy hand be strengthened', 'I. Let thy hand be strengthened', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5b1434bc-cb70-46dd-ad17-900f6a6ea208'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e91a193-458f-3ae2-908f-35b100d07983'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:372f2ea5-bd5a-305f-bb59-38a0de3309c3', 2, 'II', 'Let justice and judgement', 'II. Let justice and judgement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5b1434bc-cb70-46dd-ad17-900f6a6ea208'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:372f2ea5-bd5a-305f-bb59-38a0de3309c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:959a7d86-663c-309a-9693-e74a0821c260', 3, 'III', 'Alleluia', 'III. Alleluia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5b1434bc-cb70-46dd-ad17-900f6a6ea208'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:959a7d86-663c-309a-9693-e74a0821c260'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56d2e55f-fa67-4a84-8ee3-79d02dbd2b46', 3, NULL, 'The King shall rejoice', 'The King shall rejoice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56d2e55f-fa67-4a84-8ee3-79d02dbd2b46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:db89209e-b235-3df4-b8d6-3387300daa11', 1, 'I', 'The King shall rejoice', 'I. The King shall rejoice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:56d2e55f-fa67-4a84-8ee3-79d02dbd2b46'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db89209e-b235-3df4-b8d6-3387300daa11'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a3aac48-83f1-32a1-b3d8-77b3e27fcd26', 2, 'II', 'Exceeding glad shall he be', 'II. Exceeding glad shall he be', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:56d2e55f-fa67-4a84-8ee3-79d02dbd2b46'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a3aac48-83f1-32a1-b3d8-77b3e27fcd26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21f719f6-451f-3b40-9c1e-ad71068df945', 3, 'III', 'Glory and great worship – Thou hast prevented him', 'III. Glory and great worship – Thou hast prevented him', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:56d2e55f-fa67-4a84-8ee3-79d02dbd2b46'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21f719f6-451f-3b40-9c1e-ad71068df945'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:71e6b5e7-99f7-352e-ac6c-92797b5ee376', 4, 'IV', 'Alleluia', 'IV. Alleluia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:56d2e55f-fa67-4a84-8ee3-79d02dbd2b46'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71e6b5e7-99f7-352e-ac6c-92797b5ee376'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6939dee-0e5f-4bcc-9a4c-34df519445bd', 4, NULL, 'My heart is inditing', 'My heart is inditing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6939dee-0e5f-4bcc-9a4c-34df519445bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3ce84279-e430-374c-8855-dcd5749d19c6', 1, 'I', 'My heart is inditing', 'I. My heart is inditing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b6939dee-0e5f-4bcc-9a4c-34df519445bd'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ce84279-e430-374c-8855-dcd5749d19c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b6b5268-9a5b-3d4d-90c4-1e98dd234828', 2, 'II', 'Kings'' daughters were among thy honourable women', 'II. Kings'' daughters were among thy honourable women', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b6939dee-0e5f-4bcc-9a4c-34df519445bd'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b6b5268-9a5b-3d4d-90c4-1e98dd234828'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5ee85b72-d3b9-3e45-8d2a-c68c3af38c03', 3, 'III', 'Upon thy right hand did stand the Queen', 'III. Upon thy right hand did stand the Queen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b6939dee-0e5f-4bcc-9a4c-34df519445bd'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ee85b72-d3b9-3e45-8d2a-c68c3af38c03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1f5ad0d3-c88c-3f80-b438-33066ce971ba', 4, 'IV', 'Kings shall be thy nursing fathers', 'IV. Kings shall be thy nursing fathers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b6939dee-0e5f-4bcc-9a4c-34df519445bd'
WHERE p.composer_id = 6 AND p.title = '대관식 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f5ad0d3-c88c-3f80-b438-33066ce971ba'
);


-- HWV 262 결혼 찬가 <This is the day which the Lord hath made>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '결혼 찬가 <This is the day which the Lord hath made>', 'Wedding Anthem <This is the day which the Lord hath made>', 'song', 'HWV 262', NULL, NULL, 1734, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '결혼 찬가 <This is the day which the Lord hath made>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aeec16c0-de8e-44ba-925a-132c501f79aa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aeec16c0-de8e-44ba-925a-132c501f79aa'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '결혼 찬가 <This is the day which the Lord hath made>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aeec16c0-de8e-44ba-925a-132c501f79aa'
);


-- HWV 263 결혼 찬가 <Sing unto God>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '결혼 찬가 <Sing unto God>', 'Wedding Anthem <Sing unto God>', 'album', 'HWV 263', NULL, NULL, 1736, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '결혼 찬가 <Sing unto God>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6d2d780-5e78-457b-8245-b6a5b8b60b99'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6d2d780-5e78-457b-8245-b6a5b8b60b99'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '결혼 찬가 <Sing unto God>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6d2d780-5e78-457b-8245-b6a5b8b60b99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:187b46f4-517b-417b-ac5c-fdb02d9e0d1f', 1, 'I', 'Sing unto God', 'I. Sing unto God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '결혼 찬가 <Sing unto God>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:187b46f4-517b-417b-ac5c-fdb02d9e0d1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eedd730e-f627-43ef-ab9e-8004320d3a36', 2, 'II', 'Blessed are all they that fear the Lord', 'II. Blessed are all they that fear the Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '결혼 찬가 <Sing unto God>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eedd730e-f627-43ef-ab9e-8004320d3a36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bf2a63e-15f0-43e2-8b18-cc543fa59f4f', 3, 'III', 'Thy wife shall be as the fruitful vine', 'III. Thy wife shall be as the fruitful vine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '결혼 찬가 <Sing unto God>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bf2a63e-15f0-43e2-8b18-cc543fa59f4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2012126-1ae9-4280-83e3-1fc584ec5474', 4, 'IV', 'Lo, thus shall the man be blessed', 'IV. Lo, thus shall the man be blessed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '결혼 찬가 <Sing unto God>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2012126-1ae9-4280-83e3-1fc584ec5474'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11e2fa07-dfbc-4d65-9f44-5919a70e2e95', 5, 'V', 'Blessed be the Lord God of Israel', 'V. Blessed be the Lord God of Israel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '결혼 찬가 <Sing unto God>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11e2fa07-dfbc-4d65-9f44-5919a70e2e95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fe1502b-3d9a-4684-abf3-6bde0e285380', 6, 'VI', 'And let all the people say', 'VI. And let all the people say', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '결혼 찬가 <Sing unto God>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fe1502b-3d9a-4684-abf3-6bde0e285380'
);


-- HWV 264 장례 찬가 <The ways of Zion do mourn>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '장례 찬가 <The ways of Zion do mourn>', 'Funeral Anthem for Queen Caroline <The ways of Zion do mourn>', 'album', 'HWV 264', NULL, NULL, 1737, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '장례 찬가 <The ways of Zion do mourn>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e9fc842f-9aac-4d7c-98a1-0be8fd033d59'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e9fc842f-9aac-4d7c-98a1-0be8fd033d59'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e9fc842f-9aac-4d7c-98a1-0be8fd033d59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c64cada-b3aa-4124-9c00-d8e076d1b068', 1, 'I', '신포니아', 'I. Sinfonia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c64cada-b3aa-4124-9c00-d8e076d1b068'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:095fc772-039e-42cb-8a0c-07e06fae190d', 2, 'II', 'The Ways of Zion Do Mourn', 'II. The Ways of Zion Do Mourn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:095fc772-039e-42cb-8a0c-07e06fae190d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0524bb29-7268-4e5b-ba32-489ea54fa87b', 3, 'III', 'How Are the Mighty Fall''n!', 'III. How Are the Mighty Fall''n!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0524bb29-7268-4e5b-ba32-489ea54fa87b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7bfacfb-6253-4fa1-956d-e9c988178a9f', 4, 'IV', '합창 "She put on righteousness"', 'IV. Chorus "She put on righteousness"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7bfacfb-6253-4fa1-956d-e9c988178a9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32c4ca80-22a1-4d7d-9ce0-26fa4a0103cc', 5, 'V', 'When the Ear Heard Her', 'V. When the Ear Heard Her', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32c4ca80-22a1-4d7d-9ce0-26fa4a0103cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89dc9ca9-6dfa-4fb5-8802-1ba40a455ae7', 6, 'VI', 'How Are the Mighty Fall''n!', 'VI. How Are the Mighty Fall''n!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89dc9ca9-6dfa-4fb5-8802-1ba40a455ae7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b149179-a450-4bca-a27d-c215344217f1', 7, 'VII', 'She Deliver''d the Poor That Cried, the Fatherless', 'VII. She Deliver''d the Poor That Cried, the Fatherless', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b149179-a450-4bca-a27d-c215344217f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7502ba5-d1b1-4eab-a737-40118d76ba3d', 8, 'VIII', 'How Are the Mighty Fall''n!', 'VIII. How Are the Mighty Fall''n!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7502ba5-d1b1-4eab-a737-40118d76ba3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b91346e-9bde-4a17-b871-bc0a11aa4019', 9, 'IX', 'The Righteous Shall Be Had', 'IX. The Righteous Shall Be Had', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b91346e-9bde-4a17-b871-bc0a11aa4019'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b614a89-7924-4ea4-91cd-6981e8470528', 10, 'X', 'Their Bodies Are Buried in Peace', 'X. Their Bodies Are Buried in Peace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b614a89-7924-4ea4-91cd-6981e8470528'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7504b510-7eea-49d0-994d-531cc0dd648e', 11, 'XI', 'The People Will Tell of Their Wisdom', 'XI. The People Will Tell of Their Wisdom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7504b510-7eea-49d0-994d-531cc0dd648e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2fc0131-afc8-414c-a8e4-61e333074100', 12, 'XII', 'They Shall Receive a Glorious Kingdom', 'XII. They Shall Receive a Glorious Kingdom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2fc0131-afc8-414c-a8e4-61e333074100'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de038510-1a4c-4e7a-83bf-364d23a04624', 13, 'XIII', 'The Merciful Goodness of the Lord Endureth for Ever', 'XIII. The Merciful Goodness of the Lord Endureth for Ever', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '장례 찬가 <The ways of Zion do mourn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de038510-1a4c-4e7a-83bf-364d23a04624'
);


-- HWV 265 데팅겐 찬가 <The King shall rejoice>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '데팅겐 찬가 <The King shall rejoice>', 'Dettingen Anthem <The King shall rejoice>', 'album', 'HWV 265', NULL, NULL, 1743, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '데팅겐 찬가 <The King shall rejoice>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98a1eb6c-081e-433c-abed-1ea6dcd9b99e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '98a1eb6c-081e-433c-abed-1ea6dcd9b99e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 찬가 <The King shall rejoice>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98a1eb6c-081e-433c-abed-1ea6dcd9b99e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:507da9be-2b84-4bf9-8d8f-1e88bc0847eb', 1, 'I', 'The King Shall Rejoice', 'I. The King Shall Rejoice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 찬가 <The King shall rejoice>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:507da9be-2b84-4bf9-8d8f-1e88bc0847eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f94dc820-9fb9-4f61-a4a4-8de4485378d0', 2, 'II', 'His Honour Is Great', 'II. His Honour Is Great', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 찬가 <The King shall rejoice>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f94dc820-9fb9-4f61-a4a4-8de4485378d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:053d1d11-df12-4270-b10b-fbbb72400c4a', 3, 'III', 'Thou Shalt Give Him Everlasting Felicity', 'III. Thou Shalt Give Him Everlasting Felicity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 찬가 <The King shall rejoice>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:053d1d11-df12-4270-b10b-fbbb72400c4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01cea12f-10f0-43ab-bf95-bf977ec485ad', 4, 'IV', 'And Why? Because the King Putteth His Trust in the Lord', 'IV. And Why? Because the King Putteth His Trust in the Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 찬가 <The King shall rejoice>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01cea12f-10f0-43ab-bf95-bf977ec485ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e2cfb5c-2bb7-4e49-8616-f65a190e1b55', 5, 'V', 'We Shall Rejoice in Thy Salvation', 'V. We Shall Rejoice in Thy Salvation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 찬가 <The King shall rejoice>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e2cfb5c-2bb7-4e49-8616-f65a190e1b55'
);


-- HWV 266 평화 찬가 <How beautiful are the feet of them>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '평화 찬가 <How beautiful are the feet of them>', 'Peace Anthem <How beautiful are the feet of them>', 'song', 'HWV 266', NULL, NULL, 1749, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '평화 찬가 <How beautiful are the feet of them>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e940a204-0d97-4f77-beb1-f7b7d8339276'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e940a204-0d97-4f77-beb1-f7b7d8339276'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '평화 찬가 <How beautiful are the feet of them>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e940a204-0d97-4f77-beb1-f7b7d8339276'
);


-- HWV 268 파운들링 병원 찬가 <Blessed are they that considereth the poor>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파운들링 병원 찬가 <Blessed are they that considereth the poor>', 'Foundling Hospital Anthem <Blessed are they that considereth the poor>', 'album', 'HWV 268', NULL, NULL, 1749, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파운들링 병원 찬가 <Blessed are they that considereth the poor>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9cdf0ae9-bdcf-4908-b716-7a9276b4801a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9cdf0ae9-bdcf-4908-b716-7a9276b4801a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파운들링 병원 찬가 <Blessed are they that considereth the poor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9cdf0ae9-bdcf-4908-b716-7a9276b4801a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e44c7963-7630-4602-b7cc-7eb352318491', 1, 'I', 'Blessed are they that considereth the poor', 'I. Blessed are they that considereth the poor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파운들링 병원 찬가 <Blessed are they that considereth the poor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e44c7963-7630-4602-b7cc-7eb352318491'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3019a81a-822c-47e8-9257-86187ae92e31', 2, 'II', 'Blessed are they... They deliver the poor', 'II. Blessed are they... They deliver the poor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파운들링 병원 찬가 <Blessed are they that considereth the poor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3019a81a-822c-47e8-9257-86187ae92e31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f44375a8-65ee-4ea1-b878-2f3286fdb249', 3, 'III', 'O God who from the suckling''s mouth', 'III. O God who from the suckling''s mouth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파운들링 병원 찬가 <Blessed are they that considereth the poor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f44375a8-65ee-4ea1-b878-2f3286fdb249'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59ee026b-ce79-4900-b714-b3b45c25cd1d', 4, 'IV', 'The charitable shall be had', 'IV. The charitable shall be had', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파운들링 병원 찬가 <Blessed are they that considereth the poor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59ee026b-ce79-4900-b714-b3b45c25cd1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cc63f0d-c25b-4b87-a208-09dd199f4f3e', 5, 'V', 'Comfort them, O Lord', 'V. Comfort them, O Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파운들링 병원 찬가 <Blessed are they that considereth the poor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cc63f0d-c25b-4b87-a208-09dd199f4f3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8643344-9f71-4220-961b-137f468e98bc', 6, 'VI', 'The people will tell of their wisdom', 'VI. The people will tell of their wisdom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파운들링 병원 찬가 <Blessed are they that considereth the poor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8643344-9f71-4220-961b-137f468e98bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62b405af-f268-4e65-99dc-94cddd74ef6c', 7, 'VII', 'Hallelujah!', 'VII. Hallelujah!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파운들링 병원 찬가 <Blessed are they that considereth the poor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62b405af-f268-4e65-99dc-94cddd74ef6c'
);


-- HWV 278 위트레흐트 테 데움

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '위트레흐트 테 데움', 'Utrecht Te Deum', 'album', 'HWV 278', NULL, NULL, 1713, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '위트레흐트 테 데움'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14367eda-67da-4ada-a86d-95956d963626'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '14367eda-67da-4ada-a86d-95956d963626'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14367eda-67da-4ada-a86d-95956d963626'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a66fd517-9fb1-420b-8018-f972ab98cdaf', 1, 'I', 'We Praise Thee, O God', 'I. We Praise Thee, O God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a66fd517-9fb1-420b-8018-f972ab98cdaf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffde8171-321f-462d-a10e-a6fb83176844', 2, 'II', 'To Thee all angels cry aloud', 'II. To Thee all angels cry aloud', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffde8171-321f-462d-a10e-a6fb83176844'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c74c72b-5d68-4023-bb4d-fd1d4ade9593', 3, 'III', 'To Thee Cherubin and Seraphin', 'III. To Thee Cherubin and Seraphin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c74c72b-5d68-4023-bb4d-fd1d4ade9593'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca5c01e7-f819-4a21-acbc-f8ecead7181c', 4, 'IV', 'The glorious company of the apostles / Thou art the King of Glory', 'IV. The glorious company of the apostles / Thou art the King of Glory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca5c01e7-f819-4a21-acbc-f8ecead7181c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:581e081b-e741-4402-b5cd-9ba9c91f7faa', 5, 'V', 'When Thou took''st upon Thee / Thou sittest at the right hand', 'V. When Thou took''st upon Thee / Thou sittest at the right hand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:581e081b-e741-4402-b5cd-9ba9c91f7faa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efced83c-f145-4ac5-8f28-c83a7b919d30', 6, 'VI', 'We believe that Thou shalt come', 'VI. We believe that Thou shalt come', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efced83c-f145-4ac5-8f28-c83a7b919d30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9563c95-c4ce-46ac-883b-d3baa90a97a9', 7, 'VII', 'Day by day we magnify Thee', 'VII. Day by day we magnify Thee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9563c95-c4ce-46ac-883b-d3baa90a97a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c66a32e6-fd17-459b-a1ca-c931d7efb38b', 8, 'VIII', 'And we worship thy name', 'VIII. And we worship thy name', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c66a32e6-fd17-459b-a1ca-c931d7efb38b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4fcdeba-7a69-4edd-90f3-986c7ccbd2b8', 9, 'IX', 'Vouchsafe, O Lord', 'IX. Vouchsafe, O Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4fcdeba-7a69-4edd-90f3-986c7ccbd2b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dd37419-875d-4551-84cc-2900eb44ef60', 10, 'X', 'O Lord, in Thee have I trusted', 'X. O Lord, in Thee have I trusted', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dd37419-875d-4551-84cc-2900eb44ef60'
);


-- HWV 279 위트레흐트 유빌라테

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '위트레흐트 유빌라테', 'Utrecht Jubilate', 'album', 'HWV 279', NULL, NULL, 1713, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '위트레흐트 유빌라테'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5601847-87c3-4b23-a980-be49be5054e7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e5601847-87c3-4b23-a980-be49be5054e7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 유빌라테' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5601847-87c3-4b23-a980-be49be5054e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41b46a90-49a9-49d5-ab6c-931bec517c04', 1, 'I', 'O be joyful in the Lord', 'I. O be joyful in the Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 유빌라테' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41b46a90-49a9-49d5-ab6c-931bec517c04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15969d97-5760-43a9-ad79-d18156b9a73b', 2, 'II', 'Serve the Lord with gladness', 'II. Serve the Lord with gladness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 유빌라테' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15969d97-5760-43a9-ad79-d18156b9a73b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96fae9e6-f8ea-4ac2-a2f5-44e4df076a26', 3, 'III', 'Be ye sure that the Lord he is God', 'III. Be ye sure that the Lord he is God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 유빌라테' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96fae9e6-f8ea-4ac2-a2f5-44e4df076a26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5b0cbb5-67a4-4461-8a7d-1b67b569f20a', 4, 'IV', 'O go your way into his gates', 'IV. O go your way into his gates', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 유빌라테' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5b0cbb5-67a4-4461-8a7d-1b67b569f20a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd86e498-d39f-4501-a7fa-00995b958c42', 5, 'V', 'For the Lord is gracious', 'V. For the Lord is gracious', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 유빌라테' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd86e498-d39f-4501-a7fa-00995b958c42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a345b665-2803-4a49-b7bb-d7a4a63fddb3', 6, 'VI', 'Glory be to the Father', 'VI. Glory be to the Father', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 유빌라테' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a345b665-2803-4a49-b7bb-d7a4a63fddb3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ce88f69-dd1d-4e75-911a-f1de7d10763e', 7, 'VII', 'As it was in the beginning', 'VII. As it was in the beginning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '위트레흐트 유빌라테' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ce88f69-dd1d-4e75-911a-f1de7d10763e'
);


-- HWV 280 테 데움 D장조 "캐롤라인 왕비"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '테 데움 D장조 "캐롤라인 왕비"', 'Te Deum in D major "Queen Caroline"', 'song', 'HWV 280', NULL, NULL, 1714, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '테 데움 D장조 "캐롤라인 왕비"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0d2c98d-a6b4-46f4-950d-3f4601ae48f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a0d2c98d-a6b4-46f4-950d-3f4601ae48f7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '테 데움 D장조 "캐롤라인 왕비"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0d2c98d-a6b4-46f4-950d-3f4601ae48f7'
);


-- HWV 281 테 데움 B♭장조 "챈도스"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '테 데움 B♭장조 "챈도스"', 'Te Deum in B♭ major "Chandos"', 'song', 'HWV 281', NULL, NULL, 1718, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '테 데움 B♭장조 "챈도스"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62853dcc-7c79-4397-a95d-043b88a70b78'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '62853dcc-7c79-4397-a95d-043b88a70b78'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '테 데움 B♭장조 "챈도스"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62853dcc-7c79-4397-a95d-043b88a70b78'
);


-- HWV 282 테 데움 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '테 데움 A장조', 'Te Deum in A major', 'album', 'HWV 282', NULL, NULL, 1726, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '테 데움 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6f6c4af-be35-4746-a236-e1e7b8dd2c1a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a6f6c4af-be35-4746-a236-e1e7b8dd2c1a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '테 데움 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6f6c4af-be35-4746-a236-e1e7b8dd2c1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:465ebff7-8ebf-4ddb-a8f6-6b302c1c974d', 1, 'I', 'We praise Thee, O God', 'I. We praise Thee, O God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '테 데움 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:465ebff7-8ebf-4ddb-a8f6-6b302c1c974d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7583b7b4-73d4-4bc6-ba63-dccf9f668328', 2, 'II', 'To Thee all angels cry aloud', 'II. To Thee all angels cry aloud', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '테 데움 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7583b7b4-73d4-4bc6-ba63-dccf9f668328'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26b6d72b-8c50-4290-9c66-7bb8880a4aa0', 3, 'III', 'To Thee Cherubim and Seraphim', 'III. To Thee Cherubim and Seraphim', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '테 데움 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26b6d72b-8c50-4290-9c66-7bb8880a4aa0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:761e5c82-cde1-4449-8298-269606ad5f9e', 4, 'IV', 'The glorious company of the Apostles', 'IV. The glorious company of the Apostles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '테 데움 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:761e5c82-cde1-4449-8298-269606ad5f9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7b2c850-37e2-4ef2-a8d2-d09c3fa36951', 5, 'V', 'When Thou tookest upon Thee to deliver Man', 'V. When Thou tookest upon Thee to deliver Man', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '테 데움 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7b2c850-37e2-4ef2-a8d2-d09c3fa36951'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4eb7f14c-3056-4a0c-abfc-d9b1cf925ab2', 6, 'VI', 'We believe that Thou shalt come', 'VI. We believe that Thou shalt come', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '테 데움 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4eb7f14c-3056-4a0c-abfc-d9b1cf925ab2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e9015fd-ce8f-46d2-b76d-7b760f41e7dd', 7, 'VII', 'Vouchsafe, O Lord, to keep us this day', 'VII. Vouchsafe, O Lord, to keep us this day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '테 데움 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e9015fd-ce8f-46d2-b76d-7b760f41e7dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9df8d2dc-b738-4671-b6ac-2872d0267b19', 8, 'VIII', 'O Lord, in Thee have I trusted', 'VIII. O Lord, in Thee have I trusted', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '테 데움 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9df8d2dc-b738-4671-b6ac-2872d0267b19'
);


-- HWV 283 데팅겐 테 데움

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '데팅겐 테 데움', 'Dettingen Te Deum', 'album', 'HWV 283', NULL, NULL, 1743, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '데팅겐 테 데움'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c924a185-9346-49af-990c-16e11fd802ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c924a185-9346-49af-990c-16e11fd802ef'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c924a185-9346-49af-990c-16e11fd802ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:894e4086-796d-4d84-b18c-da88f8a967c4', 1, 'I', 'We Praise Thee, o God', 'I. We Praise Thee, o God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:894e4086-796d-4d84-b18c-da88f8a967c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2d1a1c1-368f-4a64-b712-431ec83f417e', 2, 'II', 'All the Earth Does Worship Thee', 'II. All the Earth Does Worship Thee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2d1a1c1-368f-4a64-b712-431ec83f417e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98949df6-1615-440a-944a-4f93a0b20771', 3, 'III', 'To Thee All Angels Cry Aloud', 'III. To Thee All Angels Cry Aloud', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98949df6-1615-440a-944a-4f93a0b20771'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86c4caf3-8064-4481-852e-4ab10efd2bca', 4, 'IV', 'To Thee Cherubin and Seraphim', 'IV. To Thee Cherubin and Seraphim', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86c4caf3-8064-4481-852e-4ab10efd2bca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:544f5db7-ea0b-4f94-a112-914898e73109', 5, 'V', 'To Glorious Company of Th''Apostles', 'V. To Glorious Company of Th''Apostles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:544f5db7-ea0b-4f94-a112-914898e73109'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52f80c9d-1b1f-4940-b6fa-26ebac324fc5', 6, 'VI', 'Thine Honourable, True, and Only Son', 'VI. Thine Honourable, True, and Only Son', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52f80c9d-1b1f-4940-b6fa-26ebac324fc5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:790387b3-8370-40ff-895d-a5d8d2eb0c58', 7, 'VII', 'Thou Art the King of Glory', 'VII. Thou Art the King of Glory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:790387b3-8370-40ff-895d-a5d8d2eb0c58'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81f47cca-e847-484b-803f-4c2e841a57ed', 8, 'VIII', 'When Thou Tookest Upon Thee', 'VIII. When Thou Tookest Upon Thee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81f47cca-e847-484b-803f-4c2e841a57ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bf67508-e394-47f4-befd-911b9e3dff8f', 9, 'IX', 'When Thou Hadst Overcome the Sharpness of Death', 'IX. When Thou Hadst Overcome the Sharpness of Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bf67508-e394-47f4-befd-911b9e3dff8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9a2d1fa-a793-4165-bfed-2d6cfd40a9fe', 10, 'X', 'Thou Didst Open the Kingdom of Heaven', 'X. Thou Didst Open the Kingdom of Heaven', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9a2d1fa-a793-4165-bfed-2d6cfd40a9fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a79eb07f-241b-427d-be8b-d1e792288675', 11, 'XI', 'Thou Sittest at the Right Hand of God', 'XI. Thou Sittest at the Right Hand of God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a79eb07f-241b-427d-be8b-d1e792288675'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0aeb679-e9d2-49c4-9b8b-9abe6e1c2a42', 12, 'XII', 'Adagio', 'XII. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0aeb679-e9d2-49c4-9b8b-9abe6e1c2a42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:284cab5d-4c10-4d06-8785-22becd4f2e8d', 13, 'XIII', 'We Therefore Pray Thee', 'XIII. We Therefore Pray Thee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:284cab5d-4c10-4d06-8785-22becd4f2e8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c87b15e5-43b4-4c51-ae30-0e8a993c2141', 14, 'XIV', 'Make Them to Be Number''d', 'XIV. Make Them to Be Number''d', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c87b15e5-43b4-4c51-ae30-0e8a993c2141'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f07ffec0-bf4f-47c5-971a-016379eb3ea1', 15, 'XV', 'Day by Day We Magnify Thee', 'XV. Day by Day We Magnify Thee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f07ffec0-bf4f-47c5-971a-016379eb3ea1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c6769bf-49b9-4c9e-a2ea-085d703227af', 16, 'XVI', 'And We Worship Thy Name', 'XVI. And We Worship Thy Name', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c6769bf-49b9-4c9e-a2ea-085d703227af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:759b6323-13d3-47cc-a743-a256844454a9', 17, 'XVII', 'Vouchsafe, o Lord', 'XVII. Vouchsafe, o Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:759b6323-13d3-47cc-a743-a256844454a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:892c76cb-49b2-42f1-8e7a-4f1525ee1122', 18, 'XVIII', 'O Lord, in Thee Have I Trusted', 'XVIII. O Lord, in Thee Have I Trusted', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '데팅겐 테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:892c76cb-49b2-42f1-8e7a-4f1525ee1122'
);


-- HWV 287 오보에 협주곡 3번 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 협주곡 3번 G단조', 'Oboe Concerto No. 3 in G minor', 'album', 'HWV 287', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 협주곡 3번 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ccc25f5-a6bf-40e8-ac8b-c2e10bb8a069'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3ccc25f5-a6bf-40e8-ac8b-c2e10bb8a069'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 3번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ccc25f5-a6bf-40e8-ac8b-c2e10bb8a069'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9be046b9-ec32-3cfb-8a63-ad7b359a9b6a', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 3번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9be046b9-ec32-3cfb-8a63-ad7b359a9b6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e417ee2-3bf4-3c03-9127-7393deb22a5e', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 3번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e417ee2-3bf4-3c03-9127-7393deb22a5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:944e68a5-03b2-3e2f-813d-8dd1d991e63c', 3, 'III', '사라방드 (Largo)', 'III. Sarabande (Largo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 3번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:944e68a5-03b2-3e2f-813d-8dd1d991e63c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9e9c1e1-7f3b-325f-909a-c66a9003c93c', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 3번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9e9c1e1-7f3b-325f-909a-c66a9003c93c'
);


-- HWV 288 바이올린 협주곡 B♭장조 "소나타 a 5"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 B♭장조 "소나타 a 5"', 'Violin Concerto in B♭ major "Sonata a 5"', 'album', 'HWV 288', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 B♭장조 "소나타 a 5"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb303c35-34dd-4e03-b818-61ed09d47168'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fb303c35-34dd-4e03-b818-61ed09d47168'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '바이올린 협주곡 B♭장조 "소나타 a 5"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb303c35-34dd-4e03-b818-61ed09d47168'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fa3e89a-f8d8-37e5-b630-d9431ee6b945', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '바이올린 협주곡 B♭장조 "소나타 a 5"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fa3e89a-f8d8-37e5-b630-d9431ee6b945'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aaa1e8b-cee2-3578-995f-e6b0b1d1f355', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '바이올린 협주곡 B♭장조 "소나타 a 5"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aaa1e8b-cee2-3578-995f-e6b0b1d1f355'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e6fa326-b7ac-3264-b29e-2f279115ed71', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '바이올린 협주곡 B♭장조 "소나타 a 5"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e6fa326-b7ac-3264-b29e-2f279115ed71'
);


-- Op. 4 오르간 협주곡 Op. 4

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 협주곡 Op. 4', '6 Organ Concertos, Op. 4', 'album', NULL, 'Op.', '4', 1736, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 협주곡 Op. 4'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb28bccb-c099-475b-8643-7cd6c12bef94'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb28bccb-c099-475b-8643-7cd6c12bef94'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb28bccb-c099-475b-8643-7cd6c12bef94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ae720c4-9b6d-4545-b5db-dd914129c0c0', 1, NULL, '오르간 협주곡 1번 G단조', 'Organ Concerto No. 1 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ae720c4-9b6d-4545-b5db-dd914129c0c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:369c734a-25d8-4cfa-9758-fb1d800e31ea', 1, 'I', 'Larghetto, e staccato', 'I. Larghetto, e staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1ae720c4-9b6d-4545-b5db-dd914129c0c0'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:369c734a-25d8-4cfa-9758-fb1d800e31ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cbbf75fc-9b10-482a-8e2a-ded9d8f0ccd7', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1ae720c4-9b6d-4545-b5db-dd914129c0c0'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbbf75fc-9b10-482a-8e2a-ded9d8f0ccd7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b1d97705-de80-490c-84e2-43b1547ce089', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1ae720c4-9b6d-4545-b5db-dd914129c0c0'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1d97705-de80-490c-84e2-43b1547ce089'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0d1dfb3-63b7-49d7-854f-9b838c8bc3ff', 4, 'IV', 'Andante', 'IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1ae720c4-9b6d-4545-b5db-dd914129c0c0'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0d1dfb3-63b7-49d7-854f-9b838c8bc3ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbacf849-4c32-4453-8766-e40434371435', 2, NULL, '오르간 협주곡 2번 B♭장조', 'Organ Concerto No. 2 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbacf849-4c32-4453-8766-e40434371435'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb584870-ac51-454d-869e-2f41cf1f446d', 1, 'I', 'A tempo ordinario, e staccato', 'I. A tempo ordinario, e staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dbacf849-4c32-4453-8766-e40434371435'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb584870-ac51-454d-869e-2f41cf1f446d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:40dbe7ea-6e6f-4151-9765-eac51b241d03', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dbacf849-4c32-4453-8766-e40434371435'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40dbe7ea-6e6f-4151-9765-eac51b241d03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f75b585-bd5f-43dd-85a7-21b27b6261dd', 3, 'III', 'Adagio, e staccato', 'III. Adagio, e staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dbacf849-4c32-4453-8766-e40434371435'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f75b585-bd5f-43dd-85a7-21b27b6261dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:97008328-2f56-48f9-8711-8bc085650ae2', 4, 'IV', 'Allegro, ma non presto', 'IV. Allegro, ma non presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dbacf849-4c32-4453-8766-e40434371435'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97008328-2f56-48f9-8711-8bc085650ae2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f751d6e8-2890-4ba7-90eb-26e8b8fae366', 3, NULL, '오르간 협주곡 3번 G단조', 'Organ Concerto No. 3 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f751d6e8-2890-4ba7-90eb-26e8b8fae366'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ebfb4f0e-b055-45a0-ba70-bf9255c34cc5', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f751d6e8-2890-4ba7-90eb-26e8b8fae366'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebfb4f0e-b055-45a0-ba70-bf9255c34cc5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc78250f-0ab6-4a65-9078-acf5295cda90', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f751d6e8-2890-4ba7-90eb-26e8b8fae366'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc78250f-0ab6-4a65-9078-acf5295cda90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1278d2b-ed46-425c-9c64-9bbcf7beae96', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f751d6e8-2890-4ba7-90eb-26e8b8fae366'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1278d2b-ed46-425c-9c64-9bbcf7beae96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ffd8e7b-6a8d-4435-a246-d67f55ed8303', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f751d6e8-2890-4ba7-90eb-26e8b8fae366'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ffd8e7b-6a8d-4435-a246-d67f55ed8303'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec22e0c6-5013-4d82-ab86-3d5af3485fa2', 4, NULL, '오르간 협주곡 4번 F장조', 'Organ Concerto No. 4 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec22e0c6-5013-4d82-ab86-3d5af3485fa2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2bb4287-4516-4ee6-9284-211512a3e555', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec22e0c6-5013-4d82-ab86-3d5af3485fa2'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2bb4287-4516-4ee6-9284-211512a3e555'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:056b67c0-52d8-4bfc-b168-b233d2c4d701', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec22e0c6-5013-4d82-ab86-3d5af3485fa2'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:056b67c0-52d8-4bfc-b168-b233d2c4d701'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5c9f6f4f-a682-4d5a-b438-834e62d52158', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec22e0c6-5013-4d82-ab86-3d5af3485fa2'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c9f6f4f-a682-4d5a-b438-834e62d52158'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37724e1a-9f8f-44c2-9a08-c07f3e62091e', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec22e0c6-5013-4d82-ab86-3d5af3485fa2'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37724e1a-9f8f-44c2-9a08-c07f3e62091e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95a76eb0-753b-4295-9361-5e4147d18474', 5, NULL, '오르간 협주곡 5번 F장조', 'Organ Concerto No. 5 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95a76eb0-753b-4295-9361-5e4147d18474'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fb5aeea1-2091-49d7-aa45-afc639c6d9ca', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95a76eb0-753b-4295-9361-5e4147d18474'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb5aeea1-2091-49d7-aa45-afc639c6d9ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ed16d1a1-588f-49dd-8988-c3d43ed81ef8', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95a76eb0-753b-4295-9361-5e4147d18474'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed16d1a1-588f-49dd-8988-c3d43ed81ef8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b125cf8-a090-45d1-b2f9-60c6aeebb8b7', 3, 'III', '시칠리아노', 'III. Alla Siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95a76eb0-753b-4295-9361-5e4147d18474'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b125cf8-a090-45d1-b2f9-60c6aeebb8b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:63eff33f-c918-4e6a-a5da-2b8662d12580', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95a76eb0-753b-4295-9361-5e4147d18474'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63eff33f-c918-4e6a-a5da-2b8662d12580'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:401dce63-3ffe-4efb-93d4-625d52a61d96', 6, NULL, '오르간 협주곡 6번 B♭장조', 'Organ Concerto No. 6 in B♭ major (also for harp)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:401dce63-3ffe-4efb-93d4-625d52a61d96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6438eebe-a4ef-413e-9021-496d3dc38499', 1, 'I', 'Andante - Allegro', 'I. Andante - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:401dce63-3ffe-4efb-93d4-625d52a61d96'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6438eebe-a4ef-413e-9021-496d3dc38499'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3b7ff473-3058-497d-aa0e-9c8e493e1878', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:401dce63-3ffe-4efb-93d4-625d52a61d96'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b7ff473-3058-497d-aa0e-9c8e493e1878'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b6fd7803-cff6-4e23-bc01-0c11074daace', 3, 'III', 'Allegro moderato', 'III. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:401dce63-3ffe-4efb-93d4-625d52a61d96'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6fd7803-cff6-4e23-bc01-0c11074daace'
);


-- HWV 295 오르간 협주곡 13번 F장조 "뻐꾸기와 나이팅게일"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 협주곡 13번 F장조 "뻐꾸기와 나이팅게일"', 'Organ Concerto No. 13 in F major "The Cuckoo and the Nightingale"', 'album', 'HWV 295', NULL, NULL, 1739, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 협주곡 13번 F장조 "뻐꾸기와 나이팅게일"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3868dc22-b134-4c14-9e48-d491c8ca02b2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3868dc22-b134-4c14-9e48-d491c8ca02b2'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 13번 F장조 "뻐꾸기와 나이팅게일"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3868dc22-b134-4c14-9e48-d491c8ca02b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c3f35e6-fb77-4ea4-8b1a-ed01d73a4887', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 13번 F장조 "뻐꾸기와 나이팅게일"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c3f35e6-fb77-4ea4-8b1a-ed01d73a4887'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:937074c3-a893-4852-b7ed-b550b66f906d', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 13번 F장조 "뻐꾸기와 나이팅게일"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:937074c3-a893-4852-b7ed-b550b66f906d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:621afc4c-1566-3f94-9ca3-664ddb15e157', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 13번 F장조 "뻐꾸기와 나이팅게일"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:621afc4c-1566-3f94-9ca3-664ddb15e157'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a923ce2-77ce-4fef-8268-95dce390c6cb', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 13번 F장조 "뻐꾸기와 나이팅게일"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a923ce2-77ce-4fef-8268-95dce390c6cb'
);


-- HWV 296a 오르간 협주곡 14번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 협주곡 14번 A장조', 'Organ Concerto No. 14 in A major', 'album', 'HWV 296a', NULL, NULL, 1739, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 협주곡 14번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f6b21db-fa62-4fb5-af63-1e77ecd8f9a9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f6b21db-fa62-4fb5-af63-1e77ecd8f9a9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 14번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f6b21db-fa62-4fb5-af63-1e77ecd8f9a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34b4b6fe-e483-411c-a3bf-9b76b0888b32', 1, 'I', 'Largo e staccato', 'I. Largo e staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 14번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34b4b6fe-e483-411c-a3bf-9b76b0888b32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecf2009b-82ac-4580-9c6d-84f17b1c84cd', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 14번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecf2009b-82ac-4580-9c6d-84f17b1c84cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcc274c9-dfc9-4b5f-bf57-469d50a9e0cd', 3, 'III', 'Grave', 'III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 14번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcc274c9-dfc9-4b5f-bf57-469d50a9e0cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b8a85b1-9fdd-40bd-97a5-372fbce02cdb', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 14번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b8a85b1-9fdd-40bd-97a5-372fbce02cdb'
);


-- HWV 301 오보에 협주곡 1번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 협주곡 1번 B♭장조', 'Oboe Concerto No. 1 in B♭ major', 'album', 'HWV 301', NULL, NULL, 1740, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 협주곡 1번 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '783891a0-7924-45ee-a20a-22cff5988ad2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '783891a0-7924-45ee-a20a-22cff5988ad2'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '783891a0-7924-45ee-a20a-22cff5988ad2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16cfbaa4-9e41-4803-a500-a2d57327024d', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16cfbaa4-9e41-4803-a500-a2d57327024d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f83a7262-9629-4860-94d1-54c54e5ccbb2', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f83a7262-9629-4860-94d1-54c54e5ccbb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0f66ecc-150e-4b5a-968d-395698826578', 3, 'III', '시칠리아노', 'III. Siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0f66ecc-150e-4b5a-968d-395698826578'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e783fd0-cee3-44e8-add9-1c2a2bec7d8f', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e783fd0-cee3-44e8-add9-1c2a2bec7d8f'
);


-- HWV 302a 오보에 협주곡 2번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 협주곡 2번 B♭장조', 'Oboe Concerto No. 2 in B♭ major', 'album', 'HWV 302a', NULL, NULL, 1740, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 협주곡 2번 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bace1deb-8d60-4a55-ac93-4eca91ab4eed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bace1deb-8d60-4a55-ac93-4eca91ab4eed'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bace1deb-8d60-4a55-ac93-4eca91ab4eed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82265c43-eee0-4ba6-a293-14d65ddde8e9', 1, 'I', 'Vivace', 'I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82265c43-eee0-4ba6-a293-14d65ddde8e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a22be46-8e15-4ab7-82f3-6fbe8f5cb601', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a22be46-8e15-4ab7-82f3-6fbe8f5cb601'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b354ade-1bee-440c-ab2a-f434dbe556f5', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b354ade-1bee-440c-ab2a-f434dbe556f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8121ecf3-f051-4c4c-8b3a-c8f6eba87a54', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8121ecf3-f051-4c4c-8b3a-c8f6eba87a54'
);


-- HWV 304 오르간 협주곡 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 협주곡 D단조', 'Organ Concerto in D minor', 'album', 'HWV 304', NULL, NULL, 1746, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 협주곡 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1afc2b0-f6c0-41b7-995f-ae3fff6183b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b1afc2b0-f6c0-41b7-995f-ae3fff6183b8'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1afc2b0-f6c0-41b7-995f-ae3fff6183b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73e96360-20a0-4c8d-bf72-37411059f94e', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73e96360-20a0-4c8d-bf72-37411059f94e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3d7d869-e367-4064-9db8-b3828dabb5f5', 2, 'II', 'Organo ad libitum', 'II. Organo ad libitum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3d7d869-e367-4064-9db8-b3828dabb5f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4a57bac-fc96-4ac3-bae6-9dbea4600d96', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4a57bac-fc96-4ac3-bae6-9dbea4600d96'
);


-- Op. 7 오르간 협주곡 Op. 7

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 협주곡 Op. 7', '6 Organ Concertos, Op. 7', 'album', NULL, 'Op.', '7', 1751, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 협주곡 Op. 7'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bbe9901-8283-4db9-9b01-e36db54db596'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7bbe9901-8283-4db9-9b01-e36db54db596'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bbe9901-8283-4db9-9b01-e36db54db596'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ba7dac7-cc54-40e6-9db4-440a9311af67', 1, NULL, '오르간 협주곡 7번 B♭장조', 'Organ Concerto No. 7 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ba7dac7-cc54-40e6-9db4-440a9311af67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1155042-3b1e-4df7-9242-af4634e19829', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ba7dac7-cc54-40e6-9db4-440a9311af67'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1155042-3b1e-4df7-9242-af4634e19829'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3203ee7-2987-4c2f-9c81-64ee579c290d', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ba7dac7-cc54-40e6-9db4-440a9311af67'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3203ee7-2987-4c2f-9c81-64ee579c290d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1b578a05-3b18-45a0-9751-090443911574', 3, 'III', 'Largo e piano', 'III. Largo e piano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ba7dac7-cc54-40e6-9db4-440a9311af67'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b578a05-3b18-45a0-9751-090443911574'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c50646a3-aa89-4ed7-85ff-98798034eb78', 4, 'IV', '푸가 (Allegro)', 'IV. Fuga (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ba7dac7-cc54-40e6-9db4-440a9311af67'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c50646a3-aa89-4ed7-85ff-98798034eb78'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb10b3a8-13f6-4d72-b42e-91e883034387', 5, 'V', 'Organ ad libitum', 'V. Organ ad libitum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ba7dac7-cc54-40e6-9db4-440a9311af67'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb10b3a8-13f6-4d72-b42e-91e883034387'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7c809d82-91f7-4c1e-a855-0491e762b56f', 6, 'VI', '부레. Allegro', 'VI. Bourée: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ba7dac7-cc54-40e6-9db4-440a9311af67'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c809d82-91f7-4c1e-a855-0491e762b56f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73e65a80-fb77-45df-b373-494b91582feb', 2, NULL, '오르간 협주곡 8번 A장조', 'Organ Concerto No. 8 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73e65a80-fb77-45df-b373-494b91582feb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1b295cb-d9dc-40a3-a11b-25e2ad05f5ed', 1, 'I', '서곡', 'I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:73e65a80-fb77-45df-b373-494b91582feb'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1b295cb-d9dc-40a3-a11b-25e2ad05f5ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:91158db3-177e-4a72-9251-bd306482b99d', 2, 'II', 'A tempo ordinario', 'II. A tempo ordinario', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:73e65a80-fb77-45df-b373-494b91582feb'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91158db3-177e-4a72-9251-bd306482b99d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:17f63eff-e99b-484a-af4e-4463a9613dc1', 3, 'III', 'Adagio (organo ad libitum)', 'III. Adagio (organo ad libitum)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:73e65a80-fb77-45df-b373-494b91582feb'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17f63eff-e99b-484a-af4e-4463a9613dc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41168e2d-d5df-413a-bc89-663bbf251a11', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:73e65a80-fb77-45df-b373-494b91582feb'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41168e2d-d5df-413a-bc89-663bbf251a11'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba1ccb73-05db-4208-8819-1177cd75364c', 3, NULL, '오르간 협주곡 9번 B♭장조', 'Organ Concerto No. 9 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba1ccb73-05db-4208-8819-1177cd75364c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:093af5a9-751f-4d2d-9947-20a741482c97', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ba1ccb73-05db-4208-8819-1177cd75364c'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:093af5a9-751f-4d2d-9947-20a741482c97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:10a78e2e-681c-46dc-9a9e-bd4ad1bd8041', 2, 'II', 'Organo ad libitum: Adagio - Fuga', 'II. Organo ad libitum: Adagio - Fuga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ba1ccb73-05db-4208-8819-1177cd75364c'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10a78e2e-681c-46dc-9a9e-bd4ad1bd8041'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6822e6b5-b067-431b-af9c-1a005b6749ea', 3, 'III', 'Spiritoso', 'III. Spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ba1ccb73-05db-4208-8819-1177cd75364c'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6822e6b5-b067-431b-af9c-1a005b6749ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84cc9b68-2fb0-425b-b0ce-e5a323672158', 4, 'IV', '미뉴에트', 'IV. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ba1ccb73-05db-4208-8819-1177cd75364c'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84cc9b68-2fb0-425b-b0ce-e5a323672158'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d6374e0-9329-47fb-b41d-a01d242701b8', 4, NULL, '오르간 협주곡 10번 D단조', 'Organ Concerto No. 10 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d6374e0-9329-47fb-b41d-a01d242701b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3c1963c9-6af0-396c-a39a-10ac7556a326', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d6374e0-9329-47fb-b41d-a01d242701b8'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c1963c9-6af0-396c-a39a-10ac7556a326'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a7bef90-4bdf-4f40-88e7-38d2b610ba79', 2, 'II', 'Allegro così così', 'II. Allegro così così', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d6374e0-9329-47fb-b41d-a01d242701b8'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a7bef90-4bdf-4f40-88e7-38d2b610ba79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5005340e-f83d-4d50-918f-fd3beda76f62', 3, 'III', 'Adagio (organo ad libitum)', 'III. Adagio (organo ad libitum)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d6374e0-9329-47fb-b41d-a01d242701b8'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5005340e-f83d-4d50-918f-fd3beda76f62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8ef51714-70a7-3b2c-9f1f-7e72272eaa60', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d6374e0-9329-47fb-b41d-a01d242701b8'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ef51714-70a7-3b2c-9f1f-7e72272eaa60'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:904c4639-0c46-4798-94c1-20eed43d9b1e', 5, NULL, '오르간 협주곡 11번 G단조', 'Organ Concerto No. 11 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:904c4639-0c46-4798-94c1-20eed43d9b1e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8150cc45-27aa-4cd1-805a-a42da774bbc3', 1, 'I', 'Staccato ma non troppo allegro', 'I. Staccato ma non troppo allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:904c4639-0c46-4798-94c1-20eed43d9b1e'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8150cc45-27aa-4cd1-805a-a42da774bbc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c008407-8d3b-4833-a687-de68b55eb62f', 2, 'II', 'Andante larghetto e staccato', 'II. Andante larghetto e staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:904c4639-0c46-4798-94c1-20eed43d9b1e'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c008407-8d3b-4833-a687-de68b55eb62f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f609951-9b7a-4a22-9b6a-a769776b865a', 3, 'III', '미뉴에트', 'III. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:904c4639-0c46-4798-94c1-20eed43d9b1e'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f609951-9b7a-4a22-9b6a-a769776b865a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84dad6a6-bd08-43e6-99d9-bf1db0703d0e', 4, 'IV', '가보트', 'IV. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:904c4639-0c46-4798-94c1-20eed43d9b1e'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84dad6a6-bd08-43e6-99d9-bf1db0703d0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7e3a96b-ee8f-4576-a270-1ddd3dee0332', 6, NULL, '오르간 협주곡 12번 B♭장조', 'Organ Concerto No. 12 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7e3a96b-ee8f-4576-a270-1ddd3dee0332'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bf16ca75-0492-49e3-b8ab-f92826960303', 1, 'I', 'Pomposo', 'I. Pomposo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a7e3a96b-ee8f-4576-a270-1ddd3dee0332'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf16ca75-0492-49e3-b8ab-f92826960303'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5cbd7038-3f49-4757-9e40-35737b2f844f', 2, 'II', 'Organo ad libitum', 'II. Organo ad libitum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a7e3a96b-ee8f-4576-a270-1ddd3dee0332'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cbd7038-3f49-4757-9e40-35737b2f844f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc0da700-7f33-4ba0-ad2e-0c2643960359', 3, 'III', 'A tempo ordinario', 'III. A tempo ordinario', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a7e3a96b-ee8f-4576-a270-1ddd3dee0332'
WHERE p.composer_id = 6 AND p.title = '오르간 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc0da700-7f33-4ba0-ad2e-0c2643960359'
);


-- Op. 3 합주 협주곡 Op. 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합주 협주곡 Op. 3', '6 Concerti Grossi, Op. 3', 'album', NULL, 'Op.', '3', 1734, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합주 협주곡 Op. 3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de342f6e-d506-4cfe-aa76-cd9d94ca031d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'de342f6e-d506-4cfe-aa76-cd9d94ca031d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de342f6e-d506-4cfe-aa76-cd9d94ca031d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23215f58-dcf5-4059-b49e-c7177bf60bab', 1, NULL, '합주 협주곡 B♭장조', 'Concerto Grosso in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23215f58-dcf5-4059-b49e-c7177bf60bab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9ae95fb6-d728-353a-bc6d-a1a8044ed40b', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23215f58-dcf5-4059-b49e-c7177bf60bab'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ae95fb6-d728-353a-bc6d-a1a8044ed40b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d8a7cf3-f9b8-3ba0-a60a-1a6bc3d66477', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23215f58-dcf5-4059-b49e-c7177bf60bab'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d8a7cf3-f9b8-3ba0-a60a-1a6bc3d66477'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85177701-85b3-3f7f-b62c-582c71d2bdda', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:23215f58-dcf5-4059-b49e-c7177bf60bab'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85177701-85b3-3f7f-b62c-582c71d2bdda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:026fdc0a-9260-429e-9d46-01ce993606eb', 2, NULL, '합주 협주곡 B♭장조', 'Concerto Grosso in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:026fdc0a-9260-429e-9d46-01ce993606eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35f00e24-1e5e-34fa-a578-7c7ce35251d4', 1, 'I', 'Vivace', 'I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:026fdc0a-9260-429e-9d46-01ce993606eb'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35f00e24-1e5e-34fa-a578-7c7ce35251d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c2e1ae5a-0473-3b4a-bcdc-915c51782484', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:026fdc0a-9260-429e-9d46-01ce993606eb'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2e1ae5a-0473-3b4a-bcdc-915c51782484'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:095cdfe1-a368-3f51-9f89-a3420e1d0eca', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:026fdc0a-9260-429e-9d46-01ce993606eb'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:095cdfe1-a368-3f51-9f89-a3420e1d0eca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a95516ea-3c53-3f0c-b08d-f9fe46ad1850', 4, 'IV', '미뉴에트', 'IV. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:026fdc0a-9260-429e-9d46-01ce993606eb'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a95516ea-3c53-3f0c-b08d-f9fe46ad1850'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4067c75b-11f0-34c1-baeb-6b8dc0583f5f', 5, 'V', '가보트', 'V. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:026fdc0a-9260-429e-9d46-01ce993606eb'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4067c75b-11f0-34c1-baeb-6b8dc0583f5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb25262c-bc38-47e4-bbdc-81e2fa24ba94', 3, NULL, '합주 협주곡 G장조', 'Concerto Grosso in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb25262c-bc38-47e4-bbdc-81e2fa24ba94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32cc5a86-d6c3-3bdb-9e1d-3f2a28384e9c', 1, 'I', 'Largo e staccato', 'I. Largo e staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb25262c-bc38-47e4-bbdc-81e2fa24ba94'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32cc5a86-d6c3-3bdb-9e1d-3f2a28384e9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f35993f3-d9c8-3c0e-b80a-96be3811383b', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb25262c-bc38-47e4-bbdc-81e2fa24ba94'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f35993f3-d9c8-3c0e-b80a-96be3811383b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:39ebd526-1375-3ee2-bc3a-0d0c5624b324', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb25262c-bc38-47e4-bbdc-81e2fa24ba94'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39ebd526-1375-3ee2-bc3a-0d0c5624b324'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:236954b3-0399-402f-92b6-d1554b19c5d2', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb25262c-bc38-47e4-bbdc-81e2fa24ba94'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:236954b3-0399-402f-92b6-d1554b19c5d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:591caf9f-d83c-4ce4-80b5-a66a115df9b4', 4, NULL, '합주 협주곡 F장조', 'Concerto Grosso in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:591caf9f-d83c-4ce4-80b5-a66a115df9b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:23a2b94c-45e4-3e20-ac51-3f1a106d5094', 1, 'I', '서곡', 'I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:591caf9f-d83c-4ce4-80b5-a66a115df9b4'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23a2b94c-45e4-3e20-ac51-3f1a106d5094'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df9af6cd-6d11-3567-bd16-378befded31c', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:591caf9f-d83c-4ce4-80b5-a66a115df9b4'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df9af6cd-6d11-3567-bd16-378befded31c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:572efaa7-2314-30e6-b845-47163d701134', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:591caf9f-d83c-4ce4-80b5-a66a115df9b4'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:572efaa7-2314-30e6-b845-47163d701134'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e6456c2a-50f7-3b62-8123-24def1b0b5fc', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:591caf9f-d83c-4ce4-80b5-a66a115df9b4'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6456c2a-50f7-3b62-8123-24def1b0b5fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:606d00f1-d801-4156-8ee2-0fea77e3f4c4', 5, NULL, '합주 협주곡 D단조', 'Concerto Grosso in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:606d00f1-d801-4156-8ee2-0fea77e3f4c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cb0e2989-ac85-39f7-b002-c3bd725c1ac5', 1, 'I', '(빠르기말 없음)', 'I. (no tempo marking)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:606d00f1-d801-4156-8ee2-0fea77e3f4c4'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb0e2989-ac85-39f7-b002-c3bd725c1ac5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa2badaa-0351-3085-818b-7ed1b6943c8d', 2, 'II', '푸가. Allegro', 'II. Fuga. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:606d00f1-d801-4156-8ee2-0fea77e3f4c4'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa2badaa-0351-3085-818b-7ed1b6943c8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32a4bc5e-6936-3031-aa0d-8a501f7a2eab', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:606d00f1-d801-4156-8ee2-0fea77e3f4c4'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32a4bc5e-6936-3031-aa0d-8a501f7a2eab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6349b856-e48d-3ac0-b7d7-17106338974b', 4, 'IV', 'Allegro ma non troppo', 'IV. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:606d00f1-d801-4156-8ee2-0fea77e3f4c4'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6349b856-e48d-3ac0-b7d7-17106338974b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:afafbef2-83e3-3066-a5f2-0c9da06d4ff7', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:606d00f1-d801-4156-8ee2-0fea77e3f4c4'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afafbef2-83e3-3066-a5f2-0c9da06d4ff7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3eda3e2d-c150-43c6-b181-b8d3434bbcd0', 6, NULL, '합주 협주곡 D장조', 'Concerto Grosso in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3eda3e2d-c150-43c6-b181-b8d3434bbcd0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47204334-3939-3b4d-b852-8f8edd5578f3', 1, 'I', 'Vivace', 'I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3eda3e2d-c150-43c6-b181-b8d3434bbcd0'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47204334-3939-3b4d-b852-8f8edd5578f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc2cecc1-0b6c-377f-a8b2-153cf8350e8d', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3eda3e2d-c150-43c6-b181-b8d3434bbcd0'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc2cecc1-0b6c-377f-a8b2-153cf8350e8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:11195d4d-acdc-3f22-8397-9758de4dcf53', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3eda3e2d-c150-43c6-b181-b8d3434bbcd0'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11195d4d-acdc-3f22-8397-9758de4dcf53'
);


-- HWV 318 합주 협주곡 C장조 "알렉산더의 향연"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합주 협주곡 C장조 "알렉산더의 향연"', 'Concerto Grosso in C major "Alexander''s Feast"', 'album', 'HWV 318', NULL, NULL, 1736, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합주 협주곡 C장조 "알렉산더의 향연"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d0833a7-b45b-4118-bd2e-eb3183428fc4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4d0833a7-b45b-4118-bd2e-eb3183428fc4'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 C장조 "알렉산더의 향연"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d0833a7-b45b-4118-bd2e-eb3183428fc4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:129b5559-8e66-49f1-8ae7-483145adb642', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 C장조 "알렉산더의 향연"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:129b5559-8e66-49f1-8ae7-483145adb642'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f7b3f48-f76d-4e85-8721-29e9c7d8424d', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 C장조 "알렉산더의 향연"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f7b3f48-f76d-4e85-8721-29e9c7d8424d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:978208cc-c426-493d-918b-38ed0a182768', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 C장조 "알렉산더의 향연"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:978208cc-c426-493d-918b-38ed0a182768'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b173112-51bb-4d86-9fd2-a9745ca72271', 4, 'IV', 'Andante, non presto', 'IV. Andante, non presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 C장조 "알렉산더의 향연"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b173112-51bb-4d86-9fd2-a9745ca72271'
);


-- Op. 6 합주 협주곡 Op. 6

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합주 협주곡 Op. 6', '12 Concerti Grossi, Op. 6', 'album', NULL, 'Op.', '6', 1739, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합주 협주곡 Op. 6'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cea25928-6ad8-48e3-9e77-656cacf996c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cea25928-6ad8-48e3-9e77-656cacf996c7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cea25928-6ad8-48e3-9e77-656cacf996c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:296fed5b-8aa9-4f20-8e8f-48f82f842702', 1, NULL, '합주 협주곡 G장조', 'Concerto Grosso in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:296fed5b-8aa9-4f20-8e8f-48f82f842702'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d9bbe47e-ba2e-3df2-a54a-0f8506c7bdd4', 1, 'I', 'A tempo giusto', 'I. A tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:296fed5b-8aa9-4f20-8e8f-48f82f842702'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9bbe47e-ba2e-3df2-a54a-0f8506c7bdd4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b6b4554-1d63-3c19-b6a9-e1de2d83813a', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:296fed5b-8aa9-4f20-8e8f-48f82f842702'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b6b4554-1d63-3c19-b6a9-e1de2d83813a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e88bcb96-f535-363c-9825-7f26312bca30', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:296fed5b-8aa9-4f20-8e8f-48f82f842702'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e88bcb96-f535-363c-9825-7f26312bca30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c74ed2d-b8c3-325e-9965-3b259c197220', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:296fed5b-8aa9-4f20-8e8f-48f82f842702'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c74ed2d-b8c3-325e-9965-3b259c197220'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9926154c-0fa3-3a19-8a9e-e0f6bb6d9855', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:296fed5b-8aa9-4f20-8e8f-48f82f842702'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9926154c-0fa3-3a19-8a9e-e0f6bb6d9855'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c54164ce-e4a3-4beb-a94f-415beab38bac', 2, NULL, '합주 협주곡 F장조', 'Concerto Grosso in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c54164ce-e4a3-4beb-a94f-415beab38bac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2527fa77-e006-3179-8903-72d4f961516e', 1, 'I', 'Andante larghetto', 'I. Andante larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c54164ce-e4a3-4beb-a94f-415beab38bac'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2527fa77-e006-3179-8903-72d4f961516e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc9c80e5-54e5-3876-bfc6-3d0345d09d32', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c54164ce-e4a3-4beb-a94f-415beab38bac'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc9c80e5-54e5-3876-bfc6-3d0345d09d32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79a81405-f38f-3ae8-8ea3-e944b70992e8', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c54164ce-e4a3-4beb-a94f-415beab38bac'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79a81405-f38f-3ae8-8ea3-e944b70992e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9407645-ba1b-3feb-a74a-a6dc44f16c79', 4, 'IV', 'Allegro ma non troppo', 'IV. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c54164ce-e4a3-4beb-a94f-415beab38bac'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9407645-ba1b-3feb-a74a-a6dc44f16c79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7ea69b1-4a34-456f-bf2f-110adb143ada', 3, NULL, '합주 협주곡 E단조', 'Concerto Grosso in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7ea69b1-4a34-456f-bf2f-110adb143ada'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:29429ca2-3ca1-3e9c-84ae-daf7a7586bd6', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7ea69b1-4a34-456f-bf2f-110adb143ada'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29429ca2-3ca1-3e9c-84ae-daf7a7586bd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3192868a-81e2-3def-83bc-764ad8e4c21e', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7ea69b1-4a34-456f-bf2f-110adb143ada'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3192868a-81e2-3def-83bc-764ad8e4c21e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0e285976-702f-3b13-bc07-fda7847f1cf0', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7ea69b1-4a34-456f-bf2f-110adb143ada'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e285976-702f-3b13-bc07-fda7847f1cf0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4bb6bace-b27f-3dbb-9723-15ba2f3200a8', 4, 'IV', 'Polonaise, andante', 'IV. Polonaise, andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7ea69b1-4a34-456f-bf2f-110adb143ada'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bb6bace-b27f-3dbb-9723-15ba2f3200a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:faa2d193-1aba-3362-b0b3-02bd28f410b1', 5, 'V', 'Allegro ma non troppo', 'V. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7ea69b1-4a34-456f-bf2f-110adb143ada'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faa2d193-1aba-3362-b0b3-02bd28f410b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a163c285-bfba-48e8-8b96-458daacfca6a', 4, NULL, '합주 협주곡 A단조', 'Concerto Grosso in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a163c285-bfba-48e8-8b96-458daacfca6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d75f2a63-64d5-385b-b5b9-07d9c5d286a2', 1, 'I', 'Larghetto affettuoso', 'I. Larghetto affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a163c285-bfba-48e8-8b96-458daacfca6a'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d75f2a63-64d5-385b-b5b9-07d9c5d286a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e9deabc8-544e-3c4c-9115-ff7216a1a3bf', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a163c285-bfba-48e8-8b96-458daacfca6a'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9deabc8-544e-3c4c-9115-ff7216a1a3bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fd8e7408-009a-3274-b756-411659988097', 3, 'III', 'Largo e piano', 'III. Largo e piano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a163c285-bfba-48e8-8b96-458daacfca6a'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd8e7408-009a-3274-b756-411659988097'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ffcd36e1-266c-3b4c-85f3-b90c6dcca4a3', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a163c285-bfba-48e8-8b96-458daacfca6a'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffcd36e1-266c-3b4c-85f3-b90c6dcca4a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2936c7ef-f878-413e-9ed6-eb5f75d18227', 5, NULL, '합주 협주곡 D장조', 'Concerto Grosso in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2936c7ef-f878-413e-9ed6-eb5f75d18227'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4d40ffe-8c1a-3697-bd5b-4f19f6cd434f', 1, 'I', 'Larghetto e staccato', 'I. Larghetto e staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2936c7ef-f878-413e-9ed6-eb5f75d18227'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4d40ffe-8c1a-3697-bd5b-4f19f6cd434f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cbacb2e9-8741-3ff5-b33f-cb15ce8cf671', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2936c7ef-f878-413e-9ed6-eb5f75d18227'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbacb2e9-8741-3ff5-b33f-cb15ce8cf671'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f97f405-e661-36e8-9438-7ecf0a35bae2', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2936c7ef-f878-413e-9ed6-eb5f75d18227'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f97f405-e661-36e8-9438-7ecf0a35bae2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9a57c37-4e6a-3db1-9427-d4163be019ce', 4, 'IV', 'Largo', 'IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2936c7ef-f878-413e-9ed6-eb5f75d18227'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9a57c37-4e6a-3db1-9427-d4163be019ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e8d54b12-52e3-37b6-ba6d-f3f16ee5d1a9', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2936c7ef-f878-413e-9ed6-eb5f75d18227'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8d54b12-52e3-37b6-ba6d-f3f16ee5d1a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:49131873-dd3b-3dfd-a56f-466b4949a88f', 6, 'VI', '미뉴에트, un poco larghetto', 'VI. Menuet, un poco larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2936c7ef-f878-413e-9ed6-eb5f75d18227'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49131873-dd3b-3dfd-a56f-466b4949a88f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad710c19-609b-4916-b72b-972d1542224e', 6, NULL, '합주 협주곡 G단조', 'Concerto Grosso in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad710c19-609b-4916-b72b-972d1542224e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d7fb3c5f-f131-34eb-aaec-7e6398ca9ace', 1, 'I', 'Largo affettuoso', 'I. Largo affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad710c19-609b-4916-b72b-972d1542224e'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7fb3c5f-f131-34eb-aaec-7e6398ca9ace'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:18728251-c60e-37d9-891d-6e16eb46cc1b', 2, 'II', 'A tempo giusto', 'II. A tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad710c19-609b-4916-b72b-972d1542224e'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18728251-c60e-37d9-891d-6e16eb46cc1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc96a6a6-f816-34f1-8255-1e261049970b', 3, 'III', '뮈제트, larghetto', 'III. Musette, larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad710c19-609b-4916-b72b-972d1542224e'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc96a6a6-f816-34f1-8255-1e261049970b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8491566-18c4-3d1b-b356-82d36072cc2f', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad710c19-609b-4916-b72b-972d1542224e'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8491566-18c4-3d1b-b356-82d36072cc2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cfa4806b-18d8-315b-a99a-74e1f12a4392', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad710c19-609b-4916-b72b-972d1542224e'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfa4806b-18d8-315b-a99a-74e1f12a4392'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e51ba690-75a5-424c-9587-410799fda2f6', 7, NULL, '합주 협주곡 B♭장조', 'Concerto Grosso in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e51ba690-75a5-424c-9587-410799fda2f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f880ed2f-79c0-309e-b1b6-35f4009855e7', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e51ba690-75a5-424c-9587-410799fda2f6'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f880ed2f-79c0-309e-b1b6-35f4009855e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0827b90-99e4-3df7-a832-46a5121d16d9', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e51ba690-75a5-424c-9587-410799fda2f6'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0827b90-99e4-3df7-a832-46a5121d16d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:96d925a0-95b7-37db-ba5f-bd7c25166bfd', 3, 'III', 'Largo e piano', 'III. Largo e piano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e51ba690-75a5-424c-9587-410799fda2f6'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96d925a0-95b7-37db-ba5f-bd7c25166bfd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab47e097-f195-3e0a-9b70-42eaafc02ae4', 4, 'IV', 'Andante', 'IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e51ba690-75a5-424c-9587-410799fda2f6'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab47e097-f195-3e0a-9b70-42eaafc02ae4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c85bd56f-9428-30f1-89fa-44b38ac109ff', 5, 'V', '혼파이프', 'V. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e51ba690-75a5-424c-9587-410799fda2f6'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c85bd56f-9428-30f1-89fa-44b38ac109ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aea3405e-32d1-4c9c-807e-e498601654f3', 8, NULL, '합주 협주곡 C단조', 'Concerto Grosso in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aea3405e-32d1-4c9c-807e-e498601654f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8aa3173-8527-322f-90ce-1239a164a21d', 1, 'I', '알르망드, andante', 'I. Allemande, andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aea3405e-32d1-4c9c-807e-e498601654f3'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8aa3173-8527-322f-90ce-1239a164a21d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b81a090-8cdf-3603-8e50-2bf7d1ca810a', 2, 'II', 'Grave', 'II. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aea3405e-32d1-4c9c-807e-e498601654f3'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b81a090-8cdf-3603-8e50-2bf7d1ca810a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37117c86-e20b-362a-ab4d-e7ecc2747326', 3, 'III', 'Andante-allegro', 'III. Andante-allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aea3405e-32d1-4c9c-807e-e498601654f3'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37117c86-e20b-362a-ab4d-e7ecc2747326'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d8be2ef-ce77-3c52-828c-e315aec70945', 4, 'IV', 'Adagio', 'IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aea3405e-32d1-4c9c-807e-e498601654f3'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d8be2ef-ce77-3c52-828c-e315aec70945'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:48112b54-7026-31d3-8c64-3d09fc543deb', 5, 'V', '시칠리아노, andante', 'V. Siciliana, andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aea3405e-32d1-4c9c-807e-e498601654f3'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48112b54-7026-31d3-8c64-3d09fc543deb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3be7d5ea-51cf-3fab-91f3-3a68f73e077c', 6, 'VI', 'Allegro', 'VI. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aea3405e-32d1-4c9c-807e-e498601654f3'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3be7d5ea-51cf-3fab-91f3-3a68f73e077c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96d873e3-4c85-4d53-9f81-a8fe390a1339', 9, NULL, '합주 협주곡 F장조', 'Concerto Grosso in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96d873e3-4c85-4d53-9f81-a8fe390a1339'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3b5632f-6edf-342a-9543-f6d844e8dcfc', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96d873e3-4c85-4d53-9f81-a8fe390a1339'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3b5632f-6edf-342a-9543-f6d844e8dcfc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28ffb4b4-f22e-34b1-a483-2e079e0a5c31', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96d873e3-4c85-4d53-9f81-a8fe390a1339'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28ffb4b4-f22e-34b1-a483-2e079e0a5c31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c195d72b-bd57-3887-ac57-3c2908450e6c', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96d873e3-4c85-4d53-9f81-a8fe390a1339'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c195d72b-bd57-3887-ac57-3c2908450e6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c65f4fad-f98a-39dd-90ef-0a79a137ec1b', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96d873e3-4c85-4d53-9f81-a8fe390a1339'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c65f4fad-f98a-39dd-90ef-0a79a137ec1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:24b679fb-f010-3a2b-b5a2-3b1a90c48afe', 5, 'V', '미뉴에트', 'V. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96d873e3-4c85-4d53-9f81-a8fe390a1339'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24b679fb-f010-3a2b-b5a2-3b1a90c48afe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b2f1120-f232-3a23-b187-9bbf11858da7', 6, 'VI', '지그', 'VI. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96d873e3-4c85-4d53-9f81-a8fe390a1339'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b2f1120-f232-3a23-b187-9bbf11858da7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7205bbd0-46f6-49b0-a288-8fefae021420', 10, NULL, '합주 협주곡 D단조', 'Concerto Grosso in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7205bbd0-46f6-49b0-a288-8fefae021420'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f7ae4929-3ff2-3feb-8fae-957cea427ea4', 1, 'I', '서곡', 'I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7205bbd0-46f6-49b0-a288-8fefae021420'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7ae4929-3ff2-3feb-8fae-957cea427ea4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f83098c-7d58-3a8a-9c30-01d9636c4a29', 2, 'II', 'Allegro-lento', 'II. Allegro-lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7205bbd0-46f6-49b0-a288-8fefae021420'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f83098c-7d58-3a8a-9c30-01d9636c4a29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fba96d90-15b8-3774-815b-2b49c1bddf6d', 3, 'III', '에어, lento', 'III. Air, lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7205bbd0-46f6-49b0-a288-8fefae021420'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fba96d90-15b8-3774-815b-2b49c1bddf6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22d9db0f-1f96-30e2-9ddb-7a589becef50', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7205bbd0-46f6-49b0-a288-8fefae021420'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22d9db0f-1f96-30e2-9ddb-7a589becef50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b6115e9f-d0ac-3235-b28d-e7015b3e3ba1', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7205bbd0-46f6-49b0-a288-8fefae021420'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6115e9f-d0ac-3235-b28d-e7015b3e3ba1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ceed2f41-8201-34de-b280-60cfbbfc09ea', 6, 'VI', 'Allegro moderato', 'VI. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7205bbd0-46f6-49b0-a288-8fefae021420'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceed2f41-8201-34de-b280-60cfbbfc09ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0da9347d-6c07-40b0-ac6c-16e6f08a28f1', 11, NULL, '합주 협주곡 A장조', 'Concerto Grosso in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0da9347d-6c07-40b0-ac6c-16e6f08a28f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c315e75d-ab5c-3a5a-8717-ec261e9dc1d2', 1, 'I', 'Andante larghetto e staccato', 'I. Andante larghetto e staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0da9347d-6c07-40b0-ac6c-16e6f08a28f1'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c315e75d-ab5c-3a5a-8717-ec261e9dc1d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c4c1eb75-c109-3c79-be20-a615131f8e52', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0da9347d-6c07-40b0-ac6c-16e6f08a28f1'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4c1eb75-c109-3c79-be20-a615131f8e52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5fc3192f-c48a-3484-af68-79dce5ca4259', 3, 'III', 'Largo e staccato', 'III. Largo e staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0da9347d-6c07-40b0-ac6c-16e6f08a28f1'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fc3192f-c48a-3484-af68-79dce5ca4259'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:536847eb-4108-3db1-88e7-3f950fa77416', 4, 'IV', 'Andante', 'IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0da9347d-6c07-40b0-ac6c-16e6f08a28f1'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:536847eb-4108-3db1-88e7-3f950fa77416'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12d1afce-b368-3c3f-a126-ea9154c87878', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0da9347d-6c07-40b0-ac6c-16e6f08a28f1'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12d1afce-b368-3c3f-a126-ea9154c87878'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2de9e81a-ecfa-4bf5-92d3-00b74cce102b', 12, NULL, '합주 협주곡 B단조', 'Concerto Grosso in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2de9e81a-ecfa-4bf5-92d3-00b74cce102b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1db7e3a8-e1ce-344a-9b78-397beed31ea6', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2de9e81a-ecfa-4bf5-92d3-00b74cce102b'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1db7e3a8-e1ce-344a-9b78-397beed31ea6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:03bb6559-abab-32f6-b5d9-d679514a4905', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2de9e81a-ecfa-4bf5-92d3-00b74cce102b'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03bb6559-abab-32f6-b5d9-d679514a4905'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bfb9063c-dac9-36e9-a407-da6bcad0579c', 3, 'III', '아리아. larghetto e piano', 'III. Aria: larghetto e piano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2de9e81a-ecfa-4bf5-92d3-00b74cce102b'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfb9063c-dac9-36e9-a407-da6bcad0579c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7f8020b-dfaa-346f-86b1-e0cbfd3a50fe', 4, 'IV', 'Largo', 'IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2de9e81a-ecfa-4bf5-92d3-00b74cce102b'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7f8020b-dfaa-346f-86b1-e0cbfd3a50fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc27ce55-365c-3cb4-8021-6a62feebd7ff', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2de9e81a-ecfa-4bf5-92d3-00b74cce102b'
WHERE p.composer_id = 6 AND p.title = '합주 협주곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc27ce55-365c-3cb4-8021-6a62feebd7ff'
);


-- HWV 331 협주곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '협주곡 F장조', 'Concerto in F major', 'song', 'HWV 331', NULL, NULL, 1723, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '협주곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88348f73-3db5-456b-8d61-124a1ee168be'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '88348f73-3db5-456b-8d61-124a1ee168be'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '협주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88348f73-3db5-456b-8d61-124a1ee168be'
);


-- HWV 332 두 합주단을 위한 협주곡 1번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 합주단을 위한 협주곡 1번 B♭장조', 'Concerto a due cori No. 1 in B♭ major', 'album', 'HWV 332', NULL, NULL, 1748, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 합주단을 위한 협주곡 1번 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66303f3d-1357-4925-bf37-52d3003e03f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '66303f3d-1357-4925-bf37-52d3003e03f9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66303f3d-1357-4925-bf37-52d3003e03f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3cfddd3-24ee-4059-8f3f-19fe692c7b51', 1, 'I', '서곡', 'I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3cfddd3-24ee-4059-8f3f-19fe692c7b51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ede06d94-f22b-40ab-b735-8769691021ba', 2, 'II', 'Allegro ma non troppo', 'II. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ede06d94-f22b-40ab-b735-8769691021ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15017509-1f41-43b1-8049-957215cc81e0', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15017509-1f41-43b1-8049-957215cc81e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d24bc5e2-7117-491b-a216-7b857d229f69', 4, 'IV', 'Largo', 'IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d24bc5e2-7117-491b-a216-7b857d229f69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88203fa5-5ce0-452f-b0e4-7ce66d82e66c', 5, 'V', 'A tempo ordinario', 'V. A tempo ordinario', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88203fa5-5ce0-452f-b0e4-7ce66d82e66c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c487be5-3047-4eba-b481-db0a149fe0d8', 6, 'VI', 'Alla breve moderato', 'VI. Alla breve moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c487be5-3047-4eba-b481-db0a149fe0d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60df1343-6b9b-4628-b91d-a9b3ef7a5db8', 7, 'VII', '미뉴에트', 'VII. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60df1343-6b9b-4628-b91d-a9b3ef7a5db8'
);


-- HWV 333 두 합주단을 위한 협주곡 2번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 합주단을 위한 협주곡 2번 F장조', 'Concerto a due cori No. 2 in F major', 'album', 'HWV 333', NULL, NULL, 1748, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 합주단을 위한 협주곡 2번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9eedd403-022b-4e8a-8979-5545dbba9af0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9eedd403-022b-4e8a-8979-5545dbba9af0'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9eedd403-022b-4e8a-8979-5545dbba9af0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90ceb423-e134-4c8c-9924-04f4910d5ec7', 1, 'I', 'Pomposo', 'I. Pomposo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90ceb423-e134-4c8c-9924-04f4910d5ec7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2422367-bf2c-44cd-875a-1848cce5d5b6', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2422367-bf2c-44cd-875a-1848cce5d5b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9101ef89-6902-4fb1-aa8a-f9b48dc1a67f', 3, 'III', 'A tempo giusto', 'III. A tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9101ef89-6902-4fb1-aa8a-f9b48dc1a67f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a85726b-ef87-4bc2-983d-ee5e87dc8968', 4, 'IV', 'Largo', 'IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a85726b-ef87-4bc2-983d-ee5e87dc8968'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26725656-3896-45a7-a565-47f7c15a9e7e', 5, 'V', 'Allegro ma non troppo', 'V. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26725656-3896-45a7-a565-47f7c15a9e7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42f1a420-7945-483c-acca-aa1dfae80e2c', 6, 'VI', 'A tempo ordinario', 'VI. A tempo ordinario', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42f1a420-7945-483c-acca-aa1dfae80e2c'
);


-- HWV 334 두 합주단을 위한 협주곡 3번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 합주단을 위한 협주곡 3번 F장조', 'Concerto a due cori No. 3 in F major', 'album', 'HWV 334', NULL, NULL, 1748, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 합주단을 위한 협주곡 3번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a2ff4d4-61be-49f0-a29e-66836926b7c5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a2ff4d4-61be-49f0-a29e-66836926b7c5'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 3번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a2ff4d4-61be-49f0-a29e-66836926b7c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c984f02-3ed6-4494-9301-a557abbc455f', 1, 'I', '서곡', 'I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 3번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c984f02-3ed6-4494-9301-a557abbc455f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17a2678c-86c6-4b09-a487-76a7372a6bcc', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 3번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17a2678c-86c6-4b09-a487-76a7372a6bcc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30877f49-7537-4124-9824-22fa60185c53', 3, 'III', 'Allegro ma non troppo', 'III. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 3번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30877f49-7537-4124-9824-22fa60185c53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5ffb3d7-a4f0-47f3-ae75-60634ef43411', 4, 'IV', 'Adagio', 'IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 3번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5ffb3d7-a4f0-47f3-ae75-60634ef43411'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dad8189-cf54-46a4-ac49-9bdbd1573ec9', 5, 'V', 'Andante larghetto', 'V. Andante larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 3번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dad8189-cf54-46a4-ac49-9bdbd1573ec9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee5fd932-ed37-413e-b400-8c584bef4c25', 6, 'VI', 'Allegro', 'VI. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '두 합주단을 위한 협주곡 3번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee5fd932-ed37-413e-b400-8c584bef4c25'
);


-- HWV 302b 라르고 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '라르고 F장조', 'Largo in F major', 'song', 'HWV 302b', NULL, NULL, 1738, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '라르고 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5dd73fb-2916-4f39-9df3-f62a0870981f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5dd73fb-2916-4f39-9df3-f62a0870981f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '라르고 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5dd73fb-2916-4f39-9df3-f62a0870981f'
);


-- HWV 336 서곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 B♭장조', 'Overture in B♭ major', 'song', 'HWV 336', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bffc037f-3f2f-4833-9762-7702d27e3c1e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bffc037f-3f2f-4833-9762-7702d27e3c1e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '서곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bffc037f-3f2f-4833-9762-7702d27e3c1e'
);


-- HWV 337 서곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 D장조', 'Overture in D major', 'album', 'HWV 337', NULL, NULL, 1725, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '564058fc-c606-4775-aa4b-d72cbe7c48b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '564058fc-c606-4775-aa4b-d72cbe7c48b7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '서곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '564058fc-c606-4775-aa4b-d72cbe7c48b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d97d809-6908-32f1-90b8-93b549c7a658', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '서곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d97d809-6908-32f1-90b8-93b549c7a658'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88631d43-868f-3ee4-9a6c-f21982e8e3e3', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '서곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88631d43-868f-3ee4-9a6c-f21982e8e3e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b9cc16b-eb48-3a79-9c30-fc1c409872a8', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '서곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b9cc16b-eb48-3a79-9c30-fc1c409872a8'
);


-- HWV 338 아다지오와 알레그로

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아다지오와 알레그로', 'Adagio in B minor and Allegro in D major', 'song', 'HWV 338', NULL, NULL, 1722, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아다지오와 알레그로'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c161aabb-1c0a-477c-ab7e-ba52565d3462'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c161aabb-1c0a-477c-ab7e-ba52565d3462'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아다지오와 알레그로' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c161aabb-1c0a-477c-ab7e-ba52565d3462'
);


-- HWV 339 신포니아 B♭장조 HWV 339

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 B♭장조 HWV 339', 'Sinfonia in B♭ major, HWV 339', 'song', NULL, 'HWV', '339', 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 B♭장조 HWV 339'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32bc65bf-c1a1-4554-9729-eb80d513d1af'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '32bc65bf-c1a1-4554-9729-eb80d513d1af'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '신포니아 B♭장조 HWV 339' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32bc65bf-c1a1-4554-9729-eb80d513d1af'
);


-- HWV 340 알레그로 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그로 G장조', 'Allegro in G major', 'song', 'HWV 340', NULL, NULL, 1715, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그로 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e65dbb72-8c0a-451a-a966-28dc45001c3f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e65dbb72-8c0a-451a-a966-28dc45001c3f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '알레그로 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e65dbb72-8c0a-451a-a966-28dc45001c3f'
);


-- HWV 342 서곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 F장조', 'Overture in F major', 'song', 'HWV 342', NULL, NULL, 1736, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f5b777d-7658-4024-9f4b-f0d36c410a03'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f5b777d-7658-4024-9f4b-f0d36c410a03'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '서곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f5b777d-7658-4024-9f4b-f0d36c410a03'
);


-- HWV 344 합창과 미뉴에트 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창과 미뉴에트 B♭장조', 'Chorus and Minuet in B♭ major', 'song', 'HWV 344', NULL, NULL, 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창과 미뉴에트 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7245283b-e00c-4deb-aeab-d02e90878733'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7245283b-e00c-4deb-aeab-d02e90878733'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '합창과 미뉴에트 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7245283b-e00c-4deb-aeab-d02e90878733'
);


-- HWV 345 행진곡 D장조 HWV 345

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 D장조 HWV 345', 'March in D major, HWV 345', 'song', NULL, 'HWV', '345', 1738, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 D장조 HWV 345'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f05ed3e-aa74-4552-a35c-c9bd603fc282'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9f05ed3e-aa74-4552-a35c-c9bd603fc282'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '행진곡 D장조 HWV 345' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f05ed3e-aa74-4552-a35c-c9bd603fc282'
);


-- HWV 347 신포니아 B♭장조 HWV 347

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 B♭장조 HWV 347', 'Sinfonia in B♭ major, HWV 347', 'song', NULL, 'HWV', '347', 1747, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 B♭장조 HWV 347'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd55af4af-83dd-479d-b25d-dc2ab3f72488'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd55af4af-83dd-479d-b25d-dc2ab3f72488'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '신포니아 B♭장조 HWV 347' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd55af4af-83dd-479d-b25d-dc2ab3f72488'
);


-- HWV 348–350 수상 음악

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '493b61ba-51bc-423e-987c-480c97431e97'
FROM pieces p
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '493b61ba-51bc-423e-987c-480c97431e97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5778d42-d8b2-4a27-90e6-a72a7183f642', 1, NULL, '모음곡 F장조', 'Suite No. 1 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5778d42-d8b2-4a27-90e6-a72a7183f642'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ad5d5152-2a6d-3daa-bf56-b975acc8ec15', 1, 'I', '서곡. Largo - Allegro', 'I. Overture. Largo - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5778d42-d8b2-4a27-90e6-a72a7183f642'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad5d5152-2a6d-3daa-bf56-b975acc8ec15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9d453dd-548d-3e82-92e4-910786b6e6b8', 2, 'II', 'Adagio e staccato', 'II. Adagio e staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5778d42-d8b2-4a27-90e6-a72a7183f642'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9d453dd-548d-3e82-92e4-910786b6e6b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:521f473b-33f8-4b6a-a4b8-22206f5bbe49', 3, 'III', 'Allegro - Andante - Allegro da capo', 'III. Allegro - Andante - Allegro da capo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5778d42-d8b2-4a27-90e6-a72a7183f642'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:521f473b-33f8-4b6a-a4b8-22206f5bbe49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc81fa8a-8dcb-328b-8e15-29be3419b7a2', 4, 'IV', '미뉴에트', 'IV. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5778d42-d8b2-4a27-90e6-a72a7183f642'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc81fa8a-8dcb-328b-8e15-29be3419b7a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34b9d25b-8d3c-3acd-ab76-ae17ea410f2a', 5, 'V', '에어. Presto', 'V. Air. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5778d42-d8b2-4a27-90e6-a72a7183f642'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34b9d25b-8d3c-3acd-ab76-ae17ea410f2a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a96d5e4f-8dbb-3db3-add1-9ce9c8c41e50', 6, 'VI', '미뉴에트', 'VI. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5778d42-d8b2-4a27-90e6-a72a7183f642'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a96d5e4f-8dbb-3db3-add1-9ce9c8c41e50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ece3d40a-a502-3696-9a02-76b6265f4d71', 7, 'VII', '부레. Presto', 'VII. Bourrée. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5778d42-d8b2-4a27-90e6-a72a7183f642'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ece3d40a-a502-3696-9a02-76b6265f4d71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22f50c17-afcb-35b6-b0c3-bf96e545b9a8', 8, 'VIII', '혼파이프', 'VIII. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5778d42-d8b2-4a27-90e6-a72a7183f642'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22f50c17-afcb-35b6-b0c3-bf96e545b9a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d07b91a9-6440-38f8-a887-8892a4da647a', 9, 'IX', 'Allegro moderato', 'IX. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5778d42-d8b2-4a27-90e6-a72a7183f642'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d07b91a9-6440-38f8-a887-8892a4da647a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42180886-6c45-4b6f-b5e9-0b3b6434710c', 2, NULL, '모음곡 D장조', 'Suite No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42180886-6c45-4b6f-b5e9-0b3b6434710c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e27214b-8b9e-3786-8a0e-0e81ba261c37', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:42180886-6c45-4b6f-b5e9-0b3b6434710c'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e27214b-8b9e-3786-8a0e-0e81ba261c37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1b46a78-f2df-3611-96b9-99286e2cce2a', 2, 'II', '알라 혼파이프', 'II. Alla hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:42180886-6c45-4b6f-b5e9-0b3b6434710c'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1b46a78-f2df-3611-96b9-99286e2cce2a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a9bc53b-3bc3-30c5-a6d7-d52248648f8f', 3, 'III', '미뉴에트', 'III. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:42180886-6c45-4b6f-b5e9-0b3b6434710c'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a9bc53b-3bc3-30c5-a6d7-d52248648f8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f30ea8a-6816-32b1-9056-3096d4bd13a9', 4, 'IV', 'Lentement', 'IV. Lentement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:42180886-6c45-4b6f-b5e9-0b3b6434710c'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f30ea8a-6816-32b1-9056-3096d4bd13a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9617172b-aecc-323d-9fc8-14518799e726', 5, 'V', '부레', 'V. Bourrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:42180886-6c45-4b6f-b5e9-0b3b6434710c'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9617172b-aecc-323d-9fc8-14518799e726'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6956e24-2395-439d-96eb-6a274b6885fa', 3, NULL, '모음곡 G장조', 'Suite No. 3 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6956e24-2395-439d-96eb-6a274b6885fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c7d19d6f-9e28-3180-a558-6cb30d236fa8', 1, 'I', '미뉴에트', 'I. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6956e24-2395-439d-96eb-6a274b6885fa'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7d19d6f-9e28-3180-a558-6cb30d236fa8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d7975163-3a1d-3941-b0cd-056a3e9e696c', 2, 'II', '리고동 I·II', 'II. Rigaudon I–II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6956e24-2395-439d-96eb-6a274b6885fa'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7975163-3a1d-3941-b0cd-056a3e9e696c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7b92fd33-02b2-3514-8b39-f1eb7bbc6b86', 3, 'III', '미뉴에트 I·II', 'III. Minuet I–II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6956e24-2395-439d-96eb-6a274b6885fa'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b92fd33-02b2-3514-8b39-f1eb7bbc6b86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:474a8a32-bc57-348e-a6df-12498234d59c', 4, 'IV', '컨트리 댄스 I·II', 'IV. Country Dance I–II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6956e24-2395-439d-96eb-6a274b6885fa'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:474a8a32-bc57-348e-a6df-12498234d59c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:92ae01bb-e0c3-3e78-a289-89702973af57', 5, 'V', 'Cantabile – Affettuoso – Cantabile', 'V. Cantabile – Affettuoso – Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6956e24-2395-439d-96eb-6a274b6885fa'
WHERE p.id = 22 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92ae01bb-e0c3-3e78-a289-89702973af57'
);


-- HWV 351 왕궁의 불꽃놀이

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '925c3677-75be-4736-a5dd-3d49f92e0834'
FROM pieces p
WHERE p.id = 23 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '925c3677-75be-4736-a5dd-3d49f92e0834'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:641f5cf3-415e-384d-b16e-617e4c3a7f80', 1, 'I', '서곡', 'I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:641f5cf3-415e-384d-b16e-617e4c3a7f80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26f51885-6c5d-3692-9730-e33bae1ae766', 2, 'II', '부레', 'II. Bourrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26f51885-6c5d-3692-9730-e33bae1ae766'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ca41ed0-2e69-32c3-a89b-45a4b5659c14', 3, 'III', 'La Paix: Largo alla siciliana', 'III. La Paix: Largo alla siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ca41ed0-2e69-32c3-a89b-45a4b5659c14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca869598-9290-3178-8ea0-3eadedcc3898', 4, 'IV', 'La Réjouissance', 'IV. La Réjouissance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca869598-9290-3178-8ea0-3eadedcc3898'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7a8bd9e-0b30-368c-98a5-1fd02e8f53da', 5, 'V', '미뉴에트 I·II', 'V. Menuet I and II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23 AND p.composer_id = 6
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7a8bd9e-0b30-368c-98a5-1fd02e8f53da'
);


-- HWV 352 모음곡 B♭장조 HWV 352

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 B♭장조 HWV 352', 'Suite in B♭ major, HWV 352', 'song', NULL, 'HWV', '352', 1706, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 B♭장조 HWV 352'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28f5b246-00be-4616-8c3c-9b08fe04ce9b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '28f5b246-00be-4616-8c3c-9b08fe04ce9b'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '모음곡 B♭장조 HWV 352' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28f5b246-00be-4616-8c3c-9b08fe04ce9b'
);


-- HWV 353 모음곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 G장조', 'Suite in G major', 'song', 'HWV 353', NULL, NULL, 1706, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f4d2e5e2-1709-4fdb-b6a6-e84b1be43919'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f4d2e5e2-1709-4fdb-b6a6-e84b1be43919'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '모음곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f4d2e5e2-1709-4fdb-b6a6-e84b1be43919'
);


-- HWV 354 모음곡 B♭장조 HWV 354

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 B♭장조 HWV 354', 'Suite in B♭ major, HWV 354', 'song', NULL, 'HWV', '354', 1708, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 B♭장조 HWV 354'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9eb9aac-794c-4185-814c-164b748a7829'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b9eb9aac-794c-4185-814c-164b748a7829'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '모음곡 B♭장조 HWV 354' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9eb9aac-794c-4185-814c-164b748a7829'
);


-- HWV 355 혼파이프 아리아 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '혼파이프 아리아 C단조', 'Hornpipe Aria in C minor', 'song', 'HWV 355', NULL, NULL, 1715, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '혼파이프 아리아 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07c51360-b289-4537-9313-f68ea45b4a02'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07c51360-b289-4537-9313-f68ea45b4a02'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '혼파이프 아리아 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07c51360-b289-4537-9313-f68ea45b4a02'
);


-- HWV 356 혼파이프 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '혼파이프 D장조', 'Hornpipe in D major', 'song', 'HWV 356', NULL, NULL, 1740, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '혼파이프 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7a5eae1-39d1-4771-a44a-912bc857f50c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f7a5eae1-39d1-4771-a44a-912bc857f50c'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '혼파이프 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7a5eae1-39d1-4771-a44a-912bc857f50c'
);


-- HWV 413 지그 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '지그 B♭장조', 'Gigue in B♭ major', 'song', 'HWV 413', NULL, NULL, 1736, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '지그 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a53996f7-2899-4bd4-80eb-9a676c0fb0ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a53996f7-2899-4bd4-80eb-9a676c0fb0ea'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '지그 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a53996f7-2899-4bd4-80eb-9a676c0fb0ea'
);


-- HWV 357 오보에 소나타 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 소나타 B♭장조', 'Oboe Sonata in B♭ major', 'album', 'HWV 357', NULL, NULL, 1710, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 소나타 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '059ce398-0ed5-4ae4-8bbc-c453a0a42303'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '059ce398-0ed5-4ae4-8bbc-c453a0a42303'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '059ce398-0ed5-4ae4-8bbc-c453a0a42303'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1475b21-fe98-4362-b34e-ec27779fb0ae', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1475b21-fe98-4362-b34e-ec27779fb0ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4a73bf6-e85d-47ec-9cb9-09b38cb4a1cd', 2, 'II', 'Grave', 'II. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4a73bf6-e85d-47ec-9cb9-09b38cb4a1cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d26c431-ec3e-4829-bdf5-50b797b77423', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '오보에 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d26c431-ec3e-4829-bdf5-50b797b77423'
);


-- HWV 358 소나타 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나타 G장조', 'Sonata in G major (recorder or violin)', 'album', 'HWV 358', NULL, NULL, 1710, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나타 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed25f803-21a3-466f-97a8-94881796c36b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed25f803-21a3-466f-97a8-94881796c36b'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed25f803-21a3-466f-97a8-94881796c36b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bb6b612-0da7-4fcc-a63c-2e7c5b92c3ee', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bb6b612-0da7-4fcc-a63c-2e7c5b92c3ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00cb45c3-3802-4c1d-b92f-ea14c6136d9b', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00cb45c3-3802-4c1d-b92f-ea14c6136d9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eed1193f-be23-4ba0-b4ae-8f36bbd97e4b', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eed1193f-be23-4ba0-b4ae-8f36bbd97e4b'
);


-- Op. 1 독주 소나타 Op. 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '독주 소나타 Op. 1', '12 Solo Sonatas, Op. 1', 'album', NULL, 'Op.', '1', 1732, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '독주 소나타 Op. 1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa7ac24f-7fb9-4275-aa58-9bdce0dbd25a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aa7ac24f-7fb9-4275-aa58-9bdce0dbd25a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa7ac24f-7fb9-4275-aa58-9bdce0dbd25a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e2fc449-2f4f-4a6e-a72f-0a9aff38eea9', 1, NULL, '플루트 소나타 E단조', 'Flute Sonata in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e2fc449-2f4f-4a6e-a72f-0a9aff38eea9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd0395f6-dcfd-4eee-a54d-fa42bb5b87bc', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e2fc449-2f4f-4a6e-a72f-0a9aff38eea9'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd0395f6-dcfd-4eee-a54d-fa42bb5b87bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa353047-9318-4fa8-a610-dd367e1a08ba', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e2fc449-2f4f-4a6e-a72f-0a9aff38eea9'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa353047-9318-4fa8-a610-dd367e1a08ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3ad6acdd-52fc-422f-aea4-c6ad5472a4b9', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e2fc449-2f4f-4a6e-a72f-0a9aff38eea9'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ad6acdd-52fc-422f-aea4-c6ad5472a4b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:873b55f1-cd20-4b74-96b9-880e2a8d55e0', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e2fc449-2f4f-4a6e-a72f-0a9aff38eea9'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:873b55f1-cd20-4b74-96b9-880e2a8d55e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6619b8e6-4b9e-4ec9-8c7f-6ad7f7bd5f2b', 2, NULL, '리코더 소나타 G단조', 'Recorder Sonata in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6619b8e6-4b9e-4ec9-8c7f-6ad7f7bd5f2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:50aff23f-0d47-4c2d-b90a-de81a62709cf', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6619b8e6-4b9e-4ec9-8c7f-6ad7f7bd5f2b'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50aff23f-0d47-4c2d-b90a-de81a62709cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d7361d1a-57b4-4716-8667-0c70e834dc60', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6619b8e6-4b9e-4ec9-8c7f-6ad7f7bd5f2b'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7361d1a-57b4-4716-8667-0c70e834dc60'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:898cd551-7b75-4e45-bb43-618a5efe11df', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6619b8e6-4b9e-4ec9-8c7f-6ad7f7bd5f2b'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:898cd551-7b75-4e45-bb43-618a5efe11df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e01965b3-fc65-470d-b85b-b7599cfe6b6d', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6619b8e6-4b9e-4ec9-8c7f-6ad7f7bd5f2b'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e01965b3-fc65-470d-b85b-b7599cfe6b6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09e52885-6407-44b7-98f6-751b188a77ab', 3, NULL, '바이올린 소나타 A장조', 'Violin Sonata in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09e52885-6407-44b7-98f6-751b188a77ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fdb9b740-2dd0-426e-9a4d-aa58ef2177fe', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09e52885-6407-44b7-98f6-751b188a77ab'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdb9b740-2dd0-426e-9a4d-aa58ef2177fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f21e722f-faf3-41f1-b604-fb2d70d86554', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09e52885-6407-44b7-98f6-751b188a77ab'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f21e722f-faf3-41f1-b604-fb2d70d86554'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:81d90f0c-8ba6-4a4d-b230-5b55ab1b4d7c', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09e52885-6407-44b7-98f6-751b188a77ab'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81d90f0c-8ba6-4a4d-b230-5b55ab1b4d7c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:43a32a58-36e5-4aea-abaf-569d9d6020fe', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09e52885-6407-44b7-98f6-751b188a77ab'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43a32a58-36e5-4aea-abaf-569d9d6020fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d99973fe-7469-3fb0-a74e-f6390d17e79f', 4, NULL, '리코더 소나타 A단조', 'Recorder Sonata in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d99973fe-7469-3fb0-a74e-f6390d17e79f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8d782da-c93b-4eb2-9ddf-09cbae76f01a', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d99973fe-7469-3fb0-a74e-f6390d17e79f'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d782da-c93b-4eb2-9ddf-09cbae76f01a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0fef6c2c-6467-4735-ab95-000bcf838503', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d99973fe-7469-3fb0-a74e-f6390d17e79f'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fef6c2c-6467-4735-ab95-000bcf838503'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1af5122-a8f3-44e9-b445-f881be3de8d1', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d99973fe-7469-3fb0-a74e-f6390d17e79f'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1af5122-a8f3-44e9-b445-f881be3de8d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a3a5060-2ec9-4104-ac70-1611701c3264', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d99973fe-7469-3fb0-a74e-f6390d17e79f'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a3a5060-2ec9-4104-ac70-1611701c3264'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:791b9722-6d42-4538-9abc-9093fd0765e1', 5, NULL, '플루트 소나타 G장조', 'Flute Sonata in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:791b9722-6d42-4538-9abc-9093fd0765e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5d4dc06f-0725-4748-b2a3-dc2f720b2956', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:791b9722-6d42-4538-9abc-9093fd0765e1'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d4dc06f-0725-4748-b2a3-dc2f720b2956'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:50968ce8-5a00-4026-93dc-0744d6b4fdf8', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:791b9722-6d42-4538-9abc-9093fd0765e1'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50968ce8-5a00-4026-93dc-0744d6b4fdf8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5ad52994-261a-4bec-bce2-922de13e35d7', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:791b9722-6d42-4538-9abc-9093fd0765e1'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ad52994-261a-4bec-bce2-922de13e35d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b7443686-db1e-4040-b4c7-e3a7230b7971', 4, 'IV', '부레', 'IV. Bourrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:791b9722-6d42-4538-9abc-9093fd0765e1'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7443686-db1e-4040-b4c7-e3a7230b7971'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c075e3e-f051-479f-a222-2e6e079c9a3b', 5, 'V', '미뉴에트', 'V. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:791b9722-6d42-4538-9abc-9093fd0765e1'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c075e3e-f051-479f-a222-2e6e079c9a3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e6dd554-7af0-437a-863e-2cd42772da33', 6, NULL, '바이올린 소나타 G단조', 'Violin Sonata in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e6dd554-7af0-437a-863e-2cd42772da33'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d34c6086-3294-4594-8454-5b54dbb530b7', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5e6dd554-7af0-437a-863e-2cd42772da33'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d34c6086-3294-4594-8454-5b54dbb530b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:944232b5-e747-48de-a21d-6dbdd9137f5f', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5e6dd554-7af0-437a-863e-2cd42772da33'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:944232b5-e747-48de-a21d-6dbdd9137f5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6db2782f-3981-4411-bea1-3362e8be74cd', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5e6dd554-7af0-437a-863e-2cd42772da33'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6db2782f-3981-4411-bea1-3362e8be74cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ad038878-9d0a-4e45-9860-ca4fa12ca9e9', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5e6dd554-7af0-437a-863e-2cd42772da33'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad038878-9d0a-4e45-9860-ca4fa12ca9e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e098f04-0483-48f6-a935-58ddda5489e5', 7, NULL, '리코더 소나타 C장조', 'Recorder Sonata in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e098f04-0483-48f6-a935-58ddda5489e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7ed48ae4-5ef7-4255-b1b0-1ac7980553e4', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e098f04-0483-48f6-a935-58ddda5489e5'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ed48ae4-5ef7-4255-b1b0-1ac7980553e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8b7605a-6094-4ce7-9c82-ffa9156261d8', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e098f04-0483-48f6-a935-58ddda5489e5'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8b7605a-6094-4ce7-9c82-ffa9156261d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:94880925-d4e2-4dc8-86e2-d3048db824b1', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e098f04-0483-48f6-a935-58ddda5489e5'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94880925-d4e2-4dc8-86e2-d3048db824b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21e579a2-139c-401f-b2e5-c66471e78c16', 4, 'IV', 'A tempo di gavotta', 'IV. A tempo di gavotta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e098f04-0483-48f6-a935-58ddda5489e5'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21e579a2-139c-401f-b2e5-c66471e78c16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d95a66d2-f873-4710-9027-7b846c4e27f8', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e098f04-0483-48f6-a935-58ddda5489e5'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d95a66d2-f873-4710-9027-7b846c4e27f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:210c863d-17cc-4cae-904a-d0a7260619ce', 8, NULL, '오보에 소나타 C단조', 'Oboe Sonata in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:210c863d-17cc-4cae-904a-d0a7260619ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:87bd3ff4-f3bd-4116-84d5-99189889ea4a', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:210c863d-17cc-4cae-904a-d0a7260619ce'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87bd3ff4-f3bd-4116-84d5-99189889ea4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e9d2b44-c492-487d-9c60-d389bb0c819d', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:210c863d-17cc-4cae-904a-d0a7260619ce'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e9d2b44-c492-487d-9c60-d389bb0c819d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8a14cdfc-f411-469a-bba9-6429bfdf862e', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:210c863d-17cc-4cae-904a-d0a7260619ce'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a14cdfc-f411-469a-bba9-6429bfdf862e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ebe182b0-261f-4995-b7f0-df9dfa81fa75', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:210c863d-17cc-4cae-904a-d0a7260619ce'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebe182b0-261f-4995-b7f0-df9dfa81fa75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f38d5e8-eecd-40c9-bc1c-2c6b72b1fa04', 9, NULL, '플루트 소나타 B단조', 'Flute Sonata in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f38d5e8-eecd-40c9-bc1c-2c6b72b1fa04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aab87a1a-e0f6-4163-92eb-3712b0923441', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f38d5e8-eecd-40c9-bc1c-2c6b72b1fa04'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aab87a1a-e0f6-4163-92eb-3712b0923441'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:597b09b2-9f50-46d4-b319-06373abfd0c1', 2, 'II', 'Vivace', 'II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f38d5e8-eecd-40c9-bc1c-2c6b72b1fa04'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:597b09b2-9f50-46d4-b319-06373abfd0c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:81687784-30a4-4d8e-adfc-6200d03bb5d7', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f38d5e8-eecd-40c9-bc1c-2c6b72b1fa04'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81687784-30a4-4d8e-adfc-6200d03bb5d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c0bfeeaf-3860-454d-8101-c53390fdb18a', 4, 'IV', 'Adagio', 'IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f38d5e8-eecd-40c9-bc1c-2c6b72b1fa04'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0bfeeaf-3860-454d-8101-c53390fdb18a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7f6cf2a8-fedb-4a67-afdb-83187f57efeb', 5, 'V', 'Alla breve', 'V. Alla breve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f38d5e8-eecd-40c9-bc1c-2c6b72b1fa04'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f6cf2a8-fedb-4a67-afdb-83187f57efeb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2d9127fe-9810-4dc7-be92-0a439565a315', 6, 'VI', 'Andante', 'VI. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f38d5e8-eecd-40c9-bc1c-2c6b72b1fa04'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d9127fe-9810-4dc7-be92-0a439565a315'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b1904127-c598-47bf-850a-d7978f5f3adb', 7, 'VII', 'A tempo di minuet', 'VII. A tempo di minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f38d5e8-eecd-40c9-bc1c-2c6b72b1fa04'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1904127-c598-47bf-850a-d7978f5f3adb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a31cd25d-aeff-448c-b08a-b74bacf7de8b', 10, NULL, '바이올린 소나타 G단조', 'Violin Sonata in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a31cd25d-aeff-448c-b08a-b74bacf7de8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1bcad1b6-ee13-40ef-8a21-30a4238a6738', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a31cd25d-aeff-448c-b08a-b74bacf7de8b'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bcad1b6-ee13-40ef-8a21-30a4238a6738'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7ffc6f96-9251-4882-98cb-2131ae37316d', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a31cd25d-aeff-448c-b08a-b74bacf7de8b'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ffc6f96-9251-4882-98cb-2131ae37316d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0dc20432-8317-40ea-9421-63402a945c1e', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a31cd25d-aeff-448c-b08a-b74bacf7de8b'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dc20432-8317-40ea-9421-63402a945c1e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67b7e286-7951-449d-8a43-3b8bcb83ac2d', 4, 'IV', '지그', 'IV. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a31cd25d-aeff-448c-b08a-b74bacf7de8b'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67b7e286-7951-449d-8a43-3b8bcb83ac2d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:213c2d4a-1fc3-4e75-99f6-0dc6d6cfc330', 11, NULL, '리코더 소나타 F장조', 'Recorder Sonata in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:213c2d4a-1fc3-4e75-99f6-0dc6d6cfc330'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f4f799db-ed6f-4f0d-8e2f-c1da2cd77207', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:213c2d4a-1fc3-4e75-99f6-0dc6d6cfc330'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4f799db-ed6f-4f0d-8e2f-c1da2cd77207'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6537e1b1-de34-4ea4-bd4d-a38f8ba8f157', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:213c2d4a-1fc3-4e75-99f6-0dc6d6cfc330'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6537e1b1-de34-4ea4-bd4d-a38f8ba8f157'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e6e53c72-8237-4810-84f5-771eb4cde04a', 3, 'III', '시칠리아노', 'III. Siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:213c2d4a-1fc3-4e75-99f6-0dc6d6cfc330'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6e53c72-8237-4810-84f5-771eb4cde04a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:45e4cc7d-b040-4721-aa86-f11d9b5d7c19', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:213c2d4a-1fc3-4e75-99f6-0dc6d6cfc330'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45e4cc7d-b040-4721-aa86-f11d9b5d7c19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e3b62d3-faf1-49ce-bf14-2fd02583bdad', 12, NULL, '바이올린 소나타 F장조', 'Violin Sonata in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e3b62d3-faf1-49ce-bf14-2fd02583bdad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b53b126c-0760-4fdf-87b1-9668a071bc82', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8e3b62d3-faf1-49ce-bf14-2fd02583bdad'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b53b126c-0760-4fdf-87b1-9668a071bc82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b370a38-12d6-42ac-b29f-79d6e3d8e81d', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8e3b62d3-faf1-49ce-bf14-2fd02583bdad'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b370a38-12d6-42ac-b29f-79d6e3d8e81d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5ba24f2d-d2a2-4dd8-b68e-b2a700bec721', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8e3b62d3-faf1-49ce-bf14-2fd02583bdad'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ba24f2d-d2a2-4dd8-b68e-b2a700bec721'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a8618651-bb96-42d4-9618-86edb7a5e6fd', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8e3b62d3-faf1-49ce-bf14-2fd02583bdad'
WHERE p.composer_id = 6 AND p.title = '독주 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8618651-bb96-42d4-9618-86edb7a5e6fd'
);


-- HWV 371 바이올린 소나타 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 D장조', 'Violin Sonata in D major', 'album', 'HWV 371', NULL, NULL, 1750, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7a6bdc0-a198-4496-a633-ec3d406b16fe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a7a6bdc0-a198-4496-a633-ec3d406b16fe'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '바이올린 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7a6bdc0-a198-4496-a633-ec3d406b16fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:033c4e4a-735c-3ca2-881e-589910892d3d', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '바이올린 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:033c4e4a-735c-3ca2-881e-589910892d3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d7c75f0-bb14-3726-9315-88c4e1b994f7', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '바이올린 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d7c75f0-bb14-3726-9315-88c4e1b994f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bef1f673-3ba2-34bc-99de-c50012670035', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '바이올린 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bef1f673-3ba2-34bc-99de-c50012670035'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3f20fff-3f80-3d7c-9ee1-aa182e128674', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '바이올린 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3f20fff-3f80-3d7c-9ee1-aa182e128674'
);


-- HWV 377 리코더 소나타 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '리코더 소나타 B♭장조', 'Recorder Sonata in B♭ major', 'album', 'HWV 377', NULL, NULL, 1712, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '리코더 소나타 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02369fd3-7493-4701-be1a-554871acdd93'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '02369fd3-7493-4701-be1a-554871acdd93'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '리코더 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02369fd3-7493-4701-be1a-554871acdd93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd450ef7-a2d3-4ef6-8de5-7454c1be7d29', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '리코더 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd450ef7-a2d3-4ef6-8de5-7454c1be7d29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cec5ecb-1f2d-490a-877e-e71484053fd9', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '리코더 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cec5ecb-1f2d-490a-877e-e71484053fd9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:411867cd-6a91-4025-b537-60bab2c72492', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '리코더 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:411867cd-6a91-4025-b537-60bab2c72492'
);


-- HWV 378 플루트 소나타 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 소나타 D장조', 'Flute Sonata in D major', 'album', 'HWV 378', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 소나타 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd29e7639-5fe5-4176-b442-48b8aa261e48'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd29e7639-5fe5-4176-b442-48b8aa261e48'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '플루트 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd29e7639-5fe5-4176-b442-48b8aa261e48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de66e6e6-6781-4b3e-bcb6-3e4613e5cc70', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '플루트 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de66e6e6-6781-4b3e-bcb6-3e4613e5cc70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56fe7877-9458-4d93-9eac-c64024b1d14a', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '플루트 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56fe7877-9458-4d93-9eac-c64024b1d14a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bfe610f-cbc7-4e3e-af2e-308428580657', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '플루트 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bfe610f-cbc7-4e3e-af2e-308428580657'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cccb5a9-9826-441e-948a-06f8f928d8ea', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '플루트 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cccb5a9-9826-441e-948a-06f8f928d8ea'
);


-- HWV 379 플루트 소나타 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 소나타 E단조', 'Flute Sonata in E minor', 'album', 'HWV 379', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 소나타 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e422088-a6ee-4ed1-923c-ab3ec048d4cd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1e422088-a6ee-4ed1-923c-ab3ec048d4cd'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '플루트 소나타 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e422088-a6ee-4ed1-923c-ab3ec048d4cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d80243b-2a4c-404c-b042-61129f6767e0', 1, 'I', 'Larghetto - Adagio', 'I. Larghetto - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '플루트 소나타 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d80243b-2a4c-404c-b042-61129f6767e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f611c53-c683-49c9-82d1-e0e06c97ac75', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '플루트 소나타 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f611c53-c683-49c9-82d1-e0e06c97ac75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02fe927f-e018-4133-82e8-82ae215f368a', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '플루트 소나타 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02fe927f-e018-4133-82e8-82ae215f368a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:994c103c-72de-4fa3-9471-bb18a51b4b92', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '플루트 소나타 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:994c103c-72de-4fa3-9471-bb18a51b4b92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:502a3747-65b5-47da-ac88-f9564a15f081', 5, 'V', 'Presto', 'V. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '플루트 소나타 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:502a3747-65b5-47da-ac88-f9564a15f081'
);


-- HWV 406 바이올린을 위한 아다지오와 알레그로 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린을 위한 아다지오와 알레그로 A장조', 'Adagio and Allegro in A major for Violin', 'song', 'HWV 406', NULL, NULL, 1751, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린을 위한 아다지오와 알레그로 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4747ef0-754e-4f89-8cbb-666d4905ea64'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4747ef0-754e-4f89-8cbb-666d4905ea64'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '바이올린을 위한 아다지오와 알레그로 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4747ef0-754e-4f89-8cbb-666d4905ea64'
);


-- HWV 407 바이올린을 위한 알레그로 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린을 위한 알레그로 G장조', 'Allegro in G major for Violin', 'song', 'HWV 407', NULL, NULL, 1738, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린을 위한 알레그로 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51d27855-28bd-4a22-a4da-46d9e47accb6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51d27855-28bd-4a22-a4da-46d9e47accb6'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '바이올린을 위한 알레그로 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51d27855-28bd-4a22-a4da-46d9e47accb6'
);


-- HWV 412 바이올린을 위한 안단테 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린을 위한 안단테 A단조', 'Andante in A minor for Violin', 'song', 'HWV 412', NULL, NULL, 1726, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린을 위한 안단테 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7e8edfd-6755-455c-89d4-a7ca67517a9e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e7e8edfd-6755-455c-89d4-a7ca67517a9e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '바이올린을 위한 안단테 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7e8edfd-6755-455c-89d4-a7ca67517a9e'
);


-- HWV 419 6개의 행진곡 HWV 419

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 행진곡 HWV 419', '6 Marches, HWV 419', 'album', NULL, 'HWV', '419', 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 행진곡 HWV 419'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0681260f-ff2c-4ec0-a623-c99fa9ad969d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0681260f-ff2c-4ec0-a623-c99fa9ad969d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 행진곡 HWV 419' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0681260f-ff2c-4ec0-a623-c99fa9ad969d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:handel:handel-hwv419:1', 1, NULL, 'G장조', 'No. 1 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 행진곡 HWV 419' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:handel:handel-hwv419:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:handel:handel-hwv419:2', 2, NULL, 'G장조', 'No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 행진곡 HWV 419' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:handel:handel-hwv419:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:handel:handel-hwv419:3', 3, NULL, 'G장조', 'No. 3 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 행진곡 HWV 419' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:handel:handel-hwv419:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:handel:handel-hwv419:4', 4, NULL, 'F장조', 'No. 4 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 행진곡 HWV 419' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:handel:handel-hwv419:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:handel:handel-hwv419:5', 5, NULL, 'C장조', 'No. 5 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 행진곡 HWV 419' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:handel:handel-hwv419:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:handel:handel-hwv419:6', 6, NULL, 'C장조', 'No. 6 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 행진곡 HWV 419' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:handel:handel-hwv419:6'
);


-- HWV 420 미뉴에트 D장조 HWV 420

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 D장조 HWV 420', 'Minuet in D major, HWV 420', 'song', NULL, 'HWV', '420', 1744, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 D장조 HWV 420'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c699706-935d-4b5b-a510-4c4d3b0cf890'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c699706-935d-4b5b-a510-4c4d3b0cf890'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '미뉴에트 D장조 HWV 420' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c699706-935d-4b5b-a510-4c4d3b0cf890'
);


-- HWV 421 미뉴에트 D장조 HWV 421

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 D장조 HWV 421', 'Minuet in D major, HWV 421', 'song', NULL, 'HWV', '421', 1744, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 D장조 HWV 421'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '281cc0e6-6581-4fff-a840-c5a58643fc89'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '281cc0e6-6581-4fff-a840-c5a58643fc89'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '미뉴에트 D장조 HWV 421' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '281cc0e6-6581-4fff-a840-c5a58643fc89'
);


-- Op. 2 트리오 소나타 Op. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리오 소나타 Op. 2', '6 Trio Sonatas, Op. 2', 'album', NULL, 'Op.', '2', 1727, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리오 소나타 Op. 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2096a4fc-857a-44d8-9a5d-d95591fd1dbb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2096a4fc-857a-44d8-9a5d-d95591fd1dbb'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2096a4fc-857a-44d8-9a5d-d95591fd1dbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec4f6ad6-d337-4208-ac03-3367d0cdd24c', 1, NULL, '트리오 소나타 B단조', 'Trio Sonata in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec4f6ad6-d337-4208-ac03-3367d0cdd24c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22aa6563-7b71-4ce2-bbee-b284f3523554', 1, 'I', 'Andante - Adagio', 'I. Andante - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec4f6ad6-d337-4208-ac03-3367d0cdd24c'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22aa6563-7b71-4ce2-bbee-b284f3523554'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f6d3f857-090f-4c5c-8cd2-06f2d1f78b4f', 2, 'II', 'Allegro ma non troppo', 'II. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec4f6ad6-d337-4208-ac03-3367d0cdd24c'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6d3f857-090f-4c5c-8cd2-06f2d1f78b4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3b7a1843-923f-47a2-bcd4-f3e9ca95afd9', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec4f6ad6-d337-4208-ac03-3367d0cdd24c'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b7a1843-923f-47a2-bcd4-f3e9ca95afd9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:56a36352-4f5d-4294-96cd-c149f17d5176', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec4f6ad6-d337-4208-ac03-3367d0cdd24c'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56a36352-4f5d-4294-96cd-c149f17d5176'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a3fc16e-7d02-47ab-9d2d-63ee72b1d041', 2, NULL, '트리오 소나타 G단조', 'Trio Sonata in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a3fc16e-7d02-47ab-9d2d-63ee72b1d041'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4745d8e1-af4e-4528-906d-ded2a7b31bf4', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a3fc16e-7d02-47ab-9d2d-63ee72b1d041'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4745d8e1-af4e-4528-906d-ded2a7b31bf4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:edf3ba95-4bf7-4f45-af44-dabb4a9a9ddd', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a3fc16e-7d02-47ab-9d2d-63ee72b1d041'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edf3ba95-4bf7-4f45-af44-dabb4a9a9ddd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5034517e-06ca-4159-a1f8-bc3d83563287', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a3fc16e-7d02-47ab-9d2d-63ee72b1d041'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5034517e-06ca-4159-a1f8-bc3d83563287'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:843a0797-13a5-4eef-a455-2d2c3f0f51f9', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a3fc16e-7d02-47ab-9d2d-63ee72b1d041'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:843a0797-13a5-4eef-a455-2d2c3f0f51f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47594784-d54a-41fe-b4b4-1a551416f0ad', 3, NULL, '트리오 소나타 B♭장조', 'Trio Sonata in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47594784-d54a-41fe-b4b4-1a551416f0ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b57ca248-80b1-4f97-9640-daee29aa1f60', 1, 'I', 'Andante - Adagio', 'I. Andante - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:47594784-d54a-41fe-b4b4-1a551416f0ad'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b57ca248-80b1-4f97-9640-daee29aa1f60'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:68c76ac6-1ef5-4de1-a342-a0f53db40ad7', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:47594784-d54a-41fe-b4b4-1a551416f0ad'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68c76ac6-1ef5-4de1-a342-a0f53db40ad7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:44d77ca3-3e68-4b1c-b79d-85c10a9f7606', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:47594784-d54a-41fe-b4b4-1a551416f0ad'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44d77ca3-3e68-4b1c-b79d-85c10a9f7606'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3240579-bd93-4b91-a3c1-9664cfd5d196', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:47594784-d54a-41fe-b4b4-1a551416f0ad'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3240579-bd93-4b91-a3c1-9664cfd5d196'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6decd42-f6d8-4887-a1b0-9fa1fb911d4f', 4, NULL, '트리오 소나타 F장조', 'Trio Sonata in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6decd42-f6d8-4887-a1b0-9fa1fb911d4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85ceb984-c5a9-474d-979c-38c4e8782b27', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6decd42-f6d8-4887-a1b0-9fa1fb911d4f'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85ceb984-c5a9-474d-979c-38c4e8782b27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:276a76bf-6304-48c4-b85b-4aa3ead15e7e', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6decd42-f6d8-4887-a1b0-9fa1fb911d4f'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:276a76bf-6304-48c4-b85b-4aa3ead15e7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae762363-cefc-4eaf-ac8f-41466a3f3b1c', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6decd42-f6d8-4887-a1b0-9fa1fb911d4f'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae762363-cefc-4eaf-ac8f-41466a3f3b1c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:23317869-6c98-413d-9fd2-d7d0427d30f4', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6decd42-f6d8-4887-a1b0-9fa1fb911d4f'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23317869-6c98-413d-9fd2-d7d0427d30f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e34d9165-3ef4-430a-b116-b4e1c40a7645', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6decd42-f6d8-4887-a1b0-9fa1fb911d4f'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e34d9165-3ef4-430a-b116-b4e1c40a7645'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:433876b1-a8df-4b5e-83ee-2a260ca270fc', 5, NULL, '트리오 소나타 G단조', 'Trio Sonata in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:433876b1-a8df-4b5e-83ee-2a260ca270fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:282cac0f-c17d-445a-b3a5-4e5ce64c415d', 1, 'I', 'Larghetto - Adagio', 'I. Larghetto - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:433876b1-a8df-4b5e-83ee-2a260ca270fc'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:282cac0f-c17d-445a-b3a5-4e5ce64c415d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:abcf20be-2268-4d7e-8b0c-f2be6ce8bb91', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:433876b1-a8df-4b5e-83ee-2a260ca270fc'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abcf20be-2268-4d7e-8b0c-f2be6ce8bb91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d4950151-0c08-47df-a27f-53265ae41cc3', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:433876b1-a8df-4b5e-83ee-2a260ca270fc'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4950151-0c08-47df-a27f-53265ae41cc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2d362422-a90c-4593-af13-2676e7920492', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:433876b1-a8df-4b5e-83ee-2a260ca270fc'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d362422-a90c-4593-af13-2676e7920492'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bb14384-20de-43d7-8ea4-fa008c323d61', 6, NULL, '트리오 소나타 G단조', 'Trio Sonata in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bb14384-20de-43d7-8ea4-fa008c323d61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:941e55d9-8bfb-45bf-a738-846283ca5289', 1, 'I', 'Andante - Allegro', 'I. Andante - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb14384-20de-43d7-8ea4-fa008c323d61'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:941e55d9-8bfb-45bf-a738-846283ca5289'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1fdcd1b2-22ac-4203-8ca1-55b9a8420019', 2, 'II', '아리오소', 'II. Arioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb14384-20de-43d7-8ea4-fa008c323d61'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fdcd1b2-22ac-4203-8ca1-55b9a8420019'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:897cbb4a-0068-4af5-88d7-8afd43234641', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb14384-20de-43d7-8ea4-fa008c323d61'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:897cbb4a-0068-4af5-88d7-8afd43234641'
);


-- HWV 392 트리오 소나타 F장조 HWV 392

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리오 소나타 F장조 HWV 392', 'Trio Sonata in F major, HWV 392', 'album', NULL, 'HWV', '392', 1707, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리오 소나타 F장조 HWV 392'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e6367c9-b915-4476-94b6-eb16957023f3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4e6367c9-b915-4476-94b6-eb16957023f3'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 F장조 HWV 392' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e6367c9-b915-4476-94b6-eb16957023f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10b5e9bc-8409-4505-a9bb-4da52f59c2aa', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 F장조 HWV 392' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10b5e9bc-8409-4505-a9bb-4da52f59c2aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87ee6b61-ba6d-41c1-b1af-4053459d36d4', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 F장조 HWV 392' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87ee6b61-ba6d-41c1-b1af-4053459d36d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:481f6c84-e7bf-485f-9f6a-4cf54bca104e', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 F장조 HWV 392' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:481f6c84-e7bf-485f-9f6a-4cf54bca104e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50bfd977-9719-4b71-8e54-f1f683a701f6', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 F장조 HWV 392' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50bfd977-9719-4b71-8e54-f1f683a701f6'
);


-- Op. 5 트리오 소나타 Op. 5

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리오 소나타 Op. 5', '7 Trio Sonatas, Op. 5', 'album', NULL, 'Op.', '5', 1739, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리오 소나타 Op. 5'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fda008c-bcd8-453a-861b-1f3abb30f51f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3fda008c-bcd8-453a-861b-1f3abb30f51f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fda008c-bcd8-453a-861b-1f3abb30f51f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03439df6-d752-4156-b0ca-65c17f112bf2', 1, NULL, '트리오 소나타 A장조', 'Trio Sonata in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03439df6-d752-4156-b0ca-65c17f112bf2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59333247-f328-4820-9c6f-87a4c271c96c', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03439df6-d752-4156-b0ca-65c17f112bf2'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59333247-f328-4820-9c6f-87a4c271c96c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e96b5b58-933c-4935-86cb-d8c01c1b9340', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03439df6-d752-4156-b0ca-65c17f112bf2'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e96b5b58-933c-4935-86cb-d8c01c1b9340'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:787528b3-8111-40fa-a75b-f93e5fd4b21d', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03439df6-d752-4156-b0ca-65c17f112bf2'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:787528b3-8111-40fa-a75b-f93e5fd4b21d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a08c55d2-b0ce-4395-97f9-16eea27f33d9', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03439df6-d752-4156-b0ca-65c17f112bf2'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a08c55d2-b0ce-4395-97f9-16eea27f33d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0083482-5478-45f1-821f-9e4b8c2e568c', 5, 'V', '가보트', 'V. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03439df6-d752-4156-b0ca-65c17f112bf2'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0083482-5478-45f1-821f-9e4b8c2e568c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb8b5cd4-a4cf-494b-b63c-4f213718d114', 2, NULL, '트리오 소나타 D장조', 'Trio Sonata in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb8b5cd4-a4cf-494b-b63c-4f213718d114'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2afc5199-88bd-4e60-bd18-79709d7f7175', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb8b5cd4-a4cf-494b-b63c-4f213718d114'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2afc5199-88bd-4e60-bd18-79709d7f7175'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:24340718-5327-42cf-b1c8-502fea54c6ee', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb8b5cd4-a4cf-494b-b63c-4f213718d114'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24340718-5327-42cf-b1c8-502fea54c6ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:468f9975-9246-4312-b872-a40c391b5143', 3, 'III', '뮈제트. Andante – Allegro – Andante', 'III. Musette. Andante – Allegro – Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb8b5cd4-a4cf-494b-b63c-4f213718d114'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:468f9975-9246-4312-b872-a40c391b5143'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04520cba-8e4e-4489-917a-1c49ece0a04d', 4, 'IV', '행진곡', 'IV. Marche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb8b5cd4-a4cf-494b-b63c-4f213718d114'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04520cba-8e4e-4489-917a-1c49ece0a04d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70c6a632-e910-4581-9b98-e7e7d43ea417', 5, 'V', '가보트. Allegro', 'V. Gavotte. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb8b5cd4-a4cf-494b-b63c-4f213718d114'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70c6a632-e910-4581-9b98-e7e7d43ea417'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b75f7dc1-44c8-489f-8cf6-dd6622f24f42', 3, NULL, '트리오 소나타 E단조', 'Trio Sonata in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b75f7dc1-44c8-489f-8cf6-dd6622f24f42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:781e19e9-00df-47fd-a9cd-990eb75011c5', 1, 'I', 'Andante larghetto', 'I. Andante larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b75f7dc1-44c8-489f-8cf6-dd6622f24f42'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:781e19e9-00df-47fd-a9cd-990eb75011c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1c5e714-4049-4ee0-9a95-54b8c0ed0892', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b75f7dc1-44c8-489f-8cf6-dd6622f24f42'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1c5e714-4049-4ee0-9a95-54b8c0ed0892'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0a869fec-e59a-4b46-8b92-831a10081e79', 3, 'III', '사라방드', 'III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b75f7dc1-44c8-489f-8cf6-dd6622f24f42'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a869fec-e59a-4b46-8b92-831a10081e79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eff724f0-179b-4d5f-9d23-45dc9442194c', 4, 'IV', '알르망드', 'IV. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b75f7dc1-44c8-489f-8cf6-dd6622f24f42'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eff724f0-179b-4d5f-9d23-45dc9442194c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:08a26bfa-a87d-429f-8af5-7970cd7d01f3', 5, 'V', 'Rondeau', 'V. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b75f7dc1-44c8-489f-8cf6-dd6622f24f42'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08a26bfa-a87d-429f-8af5-7970cd7d01f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:817a79d8-3cf4-4406-9ee1-e8961108d6ec', 6, 'VI', '가보트', 'VI. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b75f7dc1-44c8-489f-8cf6-dd6622f24f42'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:817a79d8-3cf4-4406-9ee1-e8961108d6ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f1e99f6-4d47-428f-89c8-6b97c476aa00', 4, NULL, '트리오 소나타 G장조', 'Trio Sonata in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f1e99f6-4d47-428f-89c8-6b97c476aa00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff08a8ca-ea7d-4f45-bb57-0db98507a807', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f1e99f6-4d47-428f-89c8-6b97c476aa00'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff08a8ca-ea7d-4f45-bb57-0db98507a807'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5210cc0d-6c24-4bde-be4d-2bc75fc496d8', 2, 'II', 'A tempo ordinario', 'II. A tempo ordinario', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f1e99f6-4d47-428f-89c8-6b97c476aa00'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5210cc0d-6c24-4bde-be4d-2bc75fc496d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:248eec39-ac41-420c-a6d3-c38a32e3c682', 3, 'III', 'Allegro, non presto', 'III. Allegro, non presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f1e99f6-4d47-428f-89c8-6b97c476aa00'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:248eec39-ac41-420c-a6d3-c38a32e3c682'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:390c813d-38b1-455e-9828-46620d771571', 4, 'IV', '파사칼리아', 'IV. Passacaile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f1e99f6-4d47-428f-89c8-6b97c476aa00'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:390c813d-38b1-455e-9828-46620d771571'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:400b06fc-c291-4bdb-800a-e9dbc6a64705', 5, 'V', '지그. Presto', 'V. Gigue: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f1e99f6-4d47-428f-89c8-6b97c476aa00'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:400b06fc-c291-4bdb-800a-e9dbc6a64705'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:018b9a01-b22d-4845-b00a-4f03b824aedf', 6, 'VI', '미뉴에트. Allegro moderato', 'VI. Menuet: Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f1e99f6-4d47-428f-89c8-6b97c476aa00'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:018b9a01-b22d-4845-b00a-4f03b824aedf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ba9c957-7e12-4c97-821c-2ebb5b2e998e', 5, NULL, '트리오 소나타 G단조', 'Trio Sonata in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ba9c957-7e12-4c97-821c-2ebb5b2e998e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a020aeb-2f19-4fc4-9c39-6a510c7e4fbb', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ba9c957-7e12-4c97-821c-2ebb5b2e998e'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a020aeb-2f19-4fc4-9c39-6a510c7e4fbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d19fabec-2f1c-4697-b2b9-7b6d40bef30a', 2, 'II', 'Alla Breve', 'II. Alla Breve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ba9c957-7e12-4c97-821c-2ebb5b2e998e'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d19fabec-2f1c-4697-b2b9-7b6d40bef30a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:562a198e-5573-4f41-b88a-1da09a8abf2f', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ba9c957-7e12-4c97-821c-2ebb5b2e998e'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:562a198e-5573-4f41-b88a-1da09a8abf2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1eeeef3-d9ac-4921-b070-f0188c277860', 4, 'IV', 'Tempo giusto', 'IV. Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ba9c957-7e12-4c97-821c-2ebb5b2e998e'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1eeeef3-d9ac-4921-b070-f0188c277860'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ed9a648f-e6ab-40d1-a299-2988dc52a84b', 5, 'V', '에어', 'V. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ba9c957-7e12-4c97-821c-2ebb5b2e998e'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed9a648f-e6ab-40d1-a299-2988dc52a84b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e64f747-e0e4-48d7-9401-2693142c4338', 6, 'VI', '부레', 'VI. Bourree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ba9c957-7e12-4c97-821c-2ebb5b2e998e'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e64f747-e0e4-48d7-9401-2693142c4338'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3f39992-f2ef-42d8-8c13-1fc0d46ed769', 6, NULL, '트리오 소나타 F장조', 'Trio Sonata in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3f39992-f2ef-42d8-8c13-1fc0d46ed769'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bbf60222-ca94-4e29-943c-1c2ad4eee535', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3f39992-f2ef-42d8-8c13-1fc0d46ed769'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbf60222-ca94-4e29-943c-1c2ad4eee535'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84871af7-a421-421b-af7f-10d4699e341f', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3f39992-f2ef-42d8-8c13-1fc0d46ed769'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84871af7-a421-421b-af7f-10d4699e341f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a9b757fd-7fba-4622-9246-2dd54a60443a', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3f39992-f2ef-42d8-8c13-1fc0d46ed769'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9b757fd-7fba-4622-9246-2dd54a60443a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f0728b7-f1c0-44d0-be08-e828d38e8b3e', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3f39992-f2ef-42d8-8c13-1fc0d46ed769'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f0728b7-f1c0-44d0-be08-e828d38e8b3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ed52d7dc-2fea-4cc0-907b-f022c0c419e6', 5, 'V', '미뉴에트', 'V. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d3f39992-f2ef-42d8-8c13-1fc0d46ed769'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed52d7dc-2fea-4cc0-907b-f022c0c419e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9619d8a5-ac3d-4f18-9f3a-26f790424945', 7, NULL, '트리오 소나타 B♭장조', 'Trio Sonata in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9619d8a5-ac3d-4f18-9f3a-26f790424945'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:604587ba-220d-468e-a59b-116690f7ffd8', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9619d8a5-ac3d-4f18-9f3a-26f790424945'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:604587ba-220d-468e-a59b-116690f7ffd8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cf85cb3b-2d5f-4e38-b276-af216f9fa28e', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9619d8a5-ac3d-4f18-9f3a-26f790424945'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf85cb3b-2d5f-4e38-b276-af216f9fa28e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:680bb7ad-48d8-4075-b9fa-4171ca1320ac', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9619d8a5-ac3d-4f18-9f3a-26f790424945'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:680bb7ad-48d8-4075-b9fa-4171ca1320ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa930edb-d1fb-408e-84ec-c635c842bffd', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9619d8a5-ac3d-4f18-9f3a-26f790424945'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa930edb-d1fb-408e-84ec-c635c842bffd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1baabfaf-fe06-4131-a903-cbb1f858b33f', 5, 'V', '가보트', 'V. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9619d8a5-ac3d-4f18-9f3a-26f790424945'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1baabfaf-fe06-4131-a903-cbb1f858b33f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7754215e-6c27-42d2-825d-6db77c85f0f8', 6, 'VI', '미뉴에트', 'VI. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9619d8a5-ac3d-4f18-9f3a-26f790424945'
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7754215e-6c27-42d2-825d-6db77c85f0f8'
);


-- HWV 403 트리오 소나타 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리오 소나타 C장조', 'Trio Sonata in C major', 'song', 'HWV 403', NULL, NULL, 1738, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리오 소나타 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20154270-5a13-411d-95ef-88cebfb59875'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '20154270-5a13-411d-95ef-88cebfb59875'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20154270-5a13-411d-95ef-88cebfb59875'
);


-- HWV 404 트리오 소나타 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리오 소나타 G단조', 'Trio Sonata in G minor', 'album', 'HWV 404', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리오 소나타 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f95247a4-df68-415e-8fce-8f3848ecb8d1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f95247a4-df68-415e-8fce-8f3848ecb8d1'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f95247a4-df68-415e-8fce-8f3848ecb8d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:869c2a90-76be-4412-ab8c-f7e51a83be2f', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:869c2a90-76be-4412-ab8c-f7e51a83be2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f06ed551-2171-423a-9968-ca0a57eef275', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f06ed551-2171-423a-9968-ca0a57eef275'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8842b7bb-f94d-4dc0-b978-f810a28a2deb', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8842b7bb-f94d-4dc0-b978-f810a28a2deb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01650e1f-e236-461c-ad5a-1d2d8e3829d5', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01650e1f-e236-461c-ad5a-1d2d8e3829d5'
);


-- HWV 405 트리오 소나타 F장조 HWV 405

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리오 소나타 F장조 HWV 405', 'Trio Sonata in F major, HWV 405', 'album', NULL, 'HWV', '405', 1710, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리오 소나타 F장조 HWV 405'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'edfba498-e151-4639-bb05-716ada3ded8f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'edfba498-e151-4639-bb05-716ada3ded8f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 F장조 HWV 405' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'edfba498-e151-4639-bb05-716ada3ded8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76083e69-839b-4a25-b569-f4e2ed433af4', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 F장조 HWV 405' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76083e69-839b-4a25-b569-f4e2ed433af4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e02a33b-3c5e-4d2b-8bdc-71e48bfa4d4b', 2, 'II', 'Grave', 'II. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 F장조 HWV 405' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e02a33b-3c5e-4d2b-8bdc-71e48bfa4d4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfbe940e-b4ea-45d8-94ab-700e199c7bae', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '트리오 소나타 F장조 HWV 405' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfbe940e-b4ea-45d8-94ab-700e199c7bae'
);


-- HWV 346 행진곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 F장조', 'March in F major', 'song', 'HWV 346', NULL, NULL, 1729, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fa8be03-21ec-48e4-94b7-728b9e3f3eac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2fa8be03-21ec-48e4-94b7-728b9e3f3eac'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '행진곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fa8be03-21ec-48e4-94b7-728b9e3f3eac'
);


-- HWV 410 아리아 F장조 HWV 410

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 F장조 HWV 410', 'Aria in F major, HWV 410', 'song', NULL, 'HWV', '410', 1725, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 F장조 HWV 410'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'deaadd24-c926-4b2f-8e6a-b836393dd5b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'deaadd24-c926-4b2f-8e6a-b836393dd5b3'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 F장조 HWV 410' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'deaadd24-c926-4b2f-8e6a-b836393dd5b3'
);


-- HWV 411 아리아 F장조 HWV 411

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 F장조 HWV 411', 'Aria in F major, HWV 411', 'song', NULL, 'HWV', '411', 1725, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 F장조 HWV 411'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec3367d7-bfb2-48e2-9f77-e447ab93a3db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec3367d7-bfb2-48e2-9f77-e447ab93a3db'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '아리아 F장조 HWV 411' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec3367d7-bfb2-48e2-9f77-e447ab93a3db'
);


-- HWV 414 파이프를 위한 행진곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파이프를 위한 행진곡 C장조', 'March for Fife in C major', 'song', 'HWV 414', NULL, NULL, 1747, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파이프를 위한 행진곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8d2de50-9d8c-44a2-bd7e-72cfdbbe643b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e8d2de50-9d8c-44a2-bd7e-72cfdbbe643b'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파이프를 위한 행진곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8d2de50-9d8c-44a2-bd7e-72cfdbbe643b'
);


-- HWV 415 파이프를 위한 행진곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파이프를 위한 행진곡 D장조', 'March for Fife in D major', 'song', 'HWV 415', NULL, NULL, 1747, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파이프를 위한 행진곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '33807dde-2a7d-478b-bd65-7be79d4436af'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '33807dde-2a7d-478b-bd65-7be79d4436af'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파이프를 위한 행진곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '33807dde-2a7d-478b-bd65-7be79d4436af'
);


-- HWV 416 행진곡 D장조 HWV 416

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 D장조 HWV 416', 'March in D major, HWV 416', 'song', NULL, 'HWV', '416', 1734, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 D장조 HWV 416'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68e4a7f6-6da9-49fc-88de-1e6e34b96345'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '68e4a7f6-6da9-49fc-88de-1e6e34b96345'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '행진곡 D장조 HWV 416' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68e4a7f6-6da9-49fc-88de-1e6e34b96345'
);


-- HWV 417 행진곡 D장조 HWV 417

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 D장조 HWV 417', 'March in D major, HWV 417', 'song', NULL, 'HWV', '417', 1747, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 D장조 HWV 417'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bf10c5e-1fc0-4062-9bfa-3219e08f4fe9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7bf10c5e-1fc0-4062-9bfa-3219e08f4fe9'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '행진곡 D장조 HWV 417' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bf10c5e-1fc0-4062-9bfa-3219e08f4fe9'
);


-- HWV 418 행진곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 G장조', 'March in G major', 'song', 'HWV 418', NULL, NULL, 1741, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34997ded-3d6a-4507-8677-97c47c62242e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '34997ded-3d6a-4507-8677-97c47c62242e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '행진곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34997ded-3d6a-4507-8677-97c47c62242e'
);


-- HWV 422 미뉴에트 G장조 HWV 422

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 G장조 HWV 422', 'Minuet in G major, HWV 422', 'song', NULL, 'HWV', '422', 1747, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 G장조 HWV 422'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '77bdb078-4b33-468e-bc18-762b7f0b1d48'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '77bdb078-4b33-468e-bc18-762b7f0b1d48'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '미뉴에트 G장조 HWV 422' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '77bdb078-4b33-468e-bc18-762b7f0b1d48'
);


-- HWV 423 미뉴에트 G장조 HWV 423

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 G장조 HWV 423', 'Minuet in G major, HWV 423', 'song', NULL, 'HWV', '423', 1747, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 G장조 HWV 423'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4bfa74bc-8d68-4c95-9529-ae89074e5d03'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4bfa74bc-8d68-4c95-9529-ae89074e5d03'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '미뉴에트 G장조 HWV 423' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4bfa74bc-8d68-4c95-9529-ae89074e5d03'
);


-- HWV 424 서곡 D장조 "피츠윌리엄"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 D장조 "피츠윌리엄"', 'Overture in D major "Fitzwilliam"', 'song', 'HWV 424', NULL, NULL, 1741, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 D장조 "피츠윌리엄"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f4b391a-5836-4135-a508-08f74c48c9eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f4b391a-5836-4135-a508-08f74c48c9eb'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '서곡 D장조 "피츠윌리엄"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f4b391a-5836-4135-a508-08f74c48c9eb'
);


-- HWV 425 에어(사라방드) E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에어(사라방드) E장조', 'Air (Saraband) in E major', 'song', 'HWV 425', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에어(사라방드) E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c76f16c-e279-46a3-bcbe-776b9c7e8de4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9c76f16c-e279-46a3-bcbe-776b9c7e8de4'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '에어(사라방드) E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c76f16c-e279-46a3-bcbe-776b9c7e8de4'
);


-- HWV 426–433 하프시코드 모음곡 HWV 426–433

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드 모음곡 HWV 426–433', 'Suites de pièces pour le clavecin, Vol. 1, HWV 426–433', 'album', NULL, 'HWV', '426–433', 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드 모음곡 HWV 426–433'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aeba89c4-4a28-49c1-b187-755e63b47896'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aeba89c4-4a28-49c1-b187-755e63b47896'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aeba89c4-4a28-49c1-b187-755e63b47896'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8cdd1aa-63ab-4909-b9a0-cfb25fd0af42', 1, NULL, '모음곡 A장조', 'Suite No. 1 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8cdd1aa-63ab-4909-b9a0-cfb25fd0af42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab7db588-357a-33c5-bb61-587186314bd9', 1, 'I', '전주곡', 'I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a8cdd1aa-63ab-4909-b9a0-cfb25fd0af42'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab7db588-357a-33c5-bb61-587186314bd9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1fce382-985d-380a-ba40-5a753f106715', 2, 'II', '알르망드. Andantino', 'II. Allemande. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a8cdd1aa-63ab-4909-b9a0-cfb25fd0af42'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1fce382-985d-380a-ba40-5a753f106715'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9666195b-045b-32af-a195-30ecf7a7a218', 3, 'III', '쿠랑트. Allegro moderato', 'III. Courante. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a8cdd1aa-63ab-4909-b9a0-cfb25fd0af42'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9666195b-045b-32af-a195-30ecf7a7a218'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca82777c-d33f-394a-9357-87dc247b3676', 4, 'IV', '지그. Presto', 'IV. Gigue. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a8cdd1aa-63ab-4909-b9a0-cfb25fd0af42'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca82777c-d33f-394a-9357-87dc247b3676'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95e3a8aa-32e5-4b30-8c3b-52a9c0865a74', 2, NULL, '모음곡 F장조', 'Suite No. 2 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95e3a8aa-32e5-4b30-8c3b-52a9c0865a74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9f7f2423-e2c6-39d5-835e-b06be807c9b6', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95e3a8aa-32e5-4b30-8c3b-52a9c0865a74'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f7f2423-e2c6-39d5-835e-b06be807c9b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8ed12dc6-ccdc-35f8-87eb-29c513e40163', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95e3a8aa-32e5-4b30-8c3b-52a9c0865a74'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ed12dc6-ccdc-35f8-87eb-29c513e40163'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:18b9cf86-6c43-3d1b-8542-4f1e6fbe74a6', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95e3a8aa-32e5-4b30-8c3b-52a9c0865a74'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18b9cf86-6c43-3d1b-8542-4f1e6fbe74a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a106f50-7d74-301e-bab8-2319826fe4a1', 4, 'IV', '푸가. Allegro', 'IV. Fuga. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95e3a8aa-32e5-4b30-8c3b-52a9c0865a74'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a106f50-7d74-301e-bab8-2319826fe4a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd13ef00-cf0a-42e2-8412-591ab749ab25', 3, NULL, '모음곡 D단조', 'Suite No. 3 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd13ef00-cf0a-42e2-8412-591ab749ab25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b52a6e1f-b897-3a70-8d31-f93f25567fd5', 1, 'I', '전주곡', 'I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd13ef00-cf0a-42e2-8412-591ab749ab25'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b52a6e1f-b897-3a70-8d31-f93f25567fd5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1250153-3233-3f97-8b51-781d8eac9fa3', 2, 'II', '푸가. Allegro', 'II. Fuga. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd13ef00-cf0a-42e2-8412-591ab749ab25'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1250153-3233-3f97-8b51-781d8eac9fa3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d13d45b0-3c80-3322-ae5a-5d1c67edd1ca', 3, 'III', '알르망드. Andantino quasi Allegretto', 'III. Allemande. Andantino quasi Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd13ef00-cf0a-42e2-8412-591ab749ab25'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d13d45b0-3c80-3322-ae5a-5d1c67edd1ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9cc501a8-7eed-331a-89db-2ebaaa737c96', 4, 'IV', '쿠랑트. Allegretto', 'IV. Courante. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd13ef00-cf0a-42e2-8412-591ab749ab25'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cc501a8-7eed-331a-89db-2ebaaa737c96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5806778f-ad5c-39db-a5c1-8d8f105f56bf', 5, 'V', '에어와 변주', 'V. Air con Variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd13ef00-cf0a-42e2-8412-591ab749ab25'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5806778f-ad5c-39db-a5c1-8d8f105f56bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:30bf579d-ff1a-3e30-a1cc-34800687b259', 6, 'VI', 'Presto', 'VI. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd13ef00-cf0a-42e2-8412-591ab749ab25'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30bf579d-ff1a-3e30-a1cc-34800687b259'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e4e765d-24ca-46a2-a719-4b75ccd9252f', 4, NULL, '모음곡 E단조', 'Suite No. 4 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e4e765d-24ca-46a2-a719-4b75ccd9252f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:50ee7e6e-d741-3f58-b0f4-7ff6cf524e77', 1, 'I', '푸가. Allegro', 'I. Fuga. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1e4e765d-24ca-46a2-a719-4b75ccd9252f'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50ee7e6e-d741-3f58-b0f4-7ff6cf524e77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5ff71015-6799-3d04-8b6b-58331c0cef3b', 2, 'II', '알르망드. Allegro moderato', 'II. Allemande. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1e4e765d-24ca-46a2-a719-4b75ccd9252f'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ff71015-6799-3d04-8b6b-58331c0cef3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:af359da6-14d9-3f04-845d-dac3e58f7288', 3, 'III', '쿠랑트. Allegretto tranquillo', 'III. Courante. Allegretto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1e4e765d-24ca-46a2-a719-4b75ccd9252f'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af359da6-14d9-3f04-845d-dac3e58f7288'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e75058dd-4fa4-35ae-a4d3-5c5040eead1d', 4, 'IV', '사라방드. Allegretto con moto', 'IV. Sarabande. Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1e4e765d-24ca-46a2-a719-4b75ccd9252f'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e75058dd-4fa4-35ae-a4d3-5c5040eead1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d992350-4d3c-3c51-859c-a0e007ef541a', 5, 'V', '지그. Vivace', 'V. Gigue. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1e4e765d-24ca-46a2-a719-4b75ccd9252f'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d992350-4d3c-3c51-859c-a0e007ef541a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a2589bd-d43d-45e1-9bf5-4acc6e88b5f2', 5, NULL, '모음곡 E장조', 'Suite No. 5 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a2589bd-d43d-45e1-9bf5-4acc6e88b5f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:abdaf518-8f98-4629-9474-73391b31a3ce', 1, 'I', '전주곡', 'I. Praeludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a2589bd-d43d-45e1-9bf5-4acc6e88b5f2'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abdaf518-8f98-4629-9474-73391b31a3ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:184d315d-7086-4d2e-ba78-c1184b1ece2e', 2, 'II', '알르망드', 'II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a2589bd-d43d-45e1-9bf5-4acc6e88b5f2'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:184d315d-7086-4d2e-ba78-c1184b1ece2e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d486f751-9f86-42c5-a252-f842a503cd7e', 3, 'III', '쿠랑트', 'III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a2589bd-d43d-45e1-9bf5-4acc6e88b5f2'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d486f751-9f86-42c5-a252-f842a503cd7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cec89ad4-e6e3-4596-ab82-4dd21496f6d9', 4, 'IV', '에어와 변주', 'IV. Air con Variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a2589bd-d43d-45e1-9bf5-4acc6e88b5f2'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cec89ad4-e6e3-4596-ab82-4dd21496f6d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d628ba69-fe15-405a-9580-76ccc389e6c5', 6, NULL, '모음곡 F#단조', 'Suite No. 6 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d628ba69-fe15-405a-9580-76ccc389e6c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8b3c66e-7850-3470-9aae-59d06cfced28', 1, 'I', '전주곡. Allegro moderato', 'I. Prélude. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d628ba69-fe15-405a-9580-76ccc389e6c5'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8b3c66e-7850-3470-9aae-59d06cfced28'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:29ecbbfb-6826-3f4f-87b5-4407744f5e2f', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d628ba69-fe15-405a-9580-76ccc389e6c5'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29ecbbfb-6826-3f4f-87b5-4407744f5e2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b1a2041b-44fc-375a-b097-d06242c595fb', 3, 'III', '푸가. Allegro', 'III. Fuga. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d628ba69-fe15-405a-9580-76ccc389e6c5'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1a2041b-44fc-375a-b097-d06242c595fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5e91dae8-2a85-3ff8-a442-3a3b310e069d', 4, 'IV', '지그. Presto', 'IV. Gigue. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d628ba69-fe15-405a-9580-76ccc389e6c5'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e91dae8-2a85-3ff8-a442-3a3b310e069d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66d42d18-ef58-4884-a32f-22f93350cf04', 7, NULL, '모음곡 G단조', 'Suite No. 7 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66d42d18-ef58-4884-a32f-22f93350cf04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6dfe0601-a2b0-3e78-aa51-ad70f77adb34', 1, 'I', '서곡. Adagio – Presto – Adagio', 'I. Ouverture. Adagio – Presto – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66d42d18-ef58-4884-a32f-22f93350cf04'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dfe0601-a2b0-3e78-aa51-ad70f77adb34'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9f3dbfe4-a69f-3b28-a1a0-61214ec2c3a0', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66d42d18-ef58-4884-a32f-22f93350cf04'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f3dbfe4-a69f-3b28-a1a0-61214ec2c3a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:499c9f4f-c767-3f9c-8c31-7566eed926d5', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66d42d18-ef58-4884-a32f-22f93350cf04'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:499c9f4f-c767-3f9c-8c31-7566eed926d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:252c799b-b41f-3d8c-b2cd-ae9073e91db6', 4, 'IV', '사라방드. Andante con moto', 'IV. Sarabande. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66d42d18-ef58-4884-a32f-22f93350cf04'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:252c799b-b41f-3d8c-b2cd-ae9073e91db6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:990a6563-b6be-33a2-9bc8-3a290964faa8', 5, 'V', '지그. Vivo', 'V. Gigue. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66d42d18-ef58-4884-a32f-22f93350cf04'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:990a6563-b6be-33a2-9bc8-3a290964faa8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ac15bf65-9859-36f8-8d6f-748d5e1a9d8a', 6, 'VI', '파사칼리아. Allegro commodo', 'VI. Passacaglia. Allegro commodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66d42d18-ef58-4884-a32f-22f93350cf04'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac15bf65-9859-36f8-8d6f-748d5e1a9d8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95203ac8-4f05-4a04-949e-f358ffc96ada', 8, NULL, '모음곡 F단조', 'Suite No. 8 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95203ac8-4f05-4a04-949e-f358ffc96ada'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73828ad8-4f0d-3d30-875f-0a40da7d7274', 1, 'I', '전주곡. Adagio', 'I. Prélude. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95203ac8-4f05-4a04-949e-f358ffc96ada'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73828ad8-4f0d-3d30-875f-0a40da7d7274'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1235d6f8-b541-308f-9dce-9a807ace1685', 2, 'II', '푸가. Allegro', 'II. Fuga. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95203ac8-4f05-4a04-949e-f358ffc96ada'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1235d6f8-b541-308f-9dce-9a807ace1685'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b7ffdb5-d5f9-332b-99ca-d9f2858e4a25', 3, 'III', '알르망드. Allegro moderato', 'III. Allemande. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95203ac8-4f05-4a04-949e-f358ffc96ada'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b7ffdb5-d5f9-332b-99ca-d9f2858e4a25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22dceeb1-d2b8-3702-ba3c-365cb84d5336', 4, 'IV', '쿠랑트. Allegro', 'IV. Courante. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95203ac8-4f05-4a04-949e-f358ffc96ada'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22dceeb1-d2b8-3702-ba3c-365cb84d5336'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:18706081-e021-3e50-aa21-ea8ee895e962', 5, 'V', '지그. Presto', 'V. Gigue. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95203ac8-4f05-4a04-949e-f358ffc96ada'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 426–433' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18706081-e021-3e50-aa21-ea8ee895e962'
);


-- HWV 434–442 하프시코드 모음곡 HWV 434–442

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드 모음곡 HWV 434–442', 'Suites de pièces pour le clavecin, Vol. 2, HWV 434–442', 'album', NULL, 'HWV', '434–442', 1726, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드 모음곡 HWV 434–442'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '228ee218-df23-4782-9239-a3a389f24a8e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '228ee218-df23-4782-9239-a3a389f24a8e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '228ee218-df23-4782-9239-a3a389f24a8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a31290f-5b9c-4b23-bfde-730718882293', 1, NULL, '모음곡 B♭장조', 'Suite No. 1 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a31290f-5b9c-4b23-bfde-730718882293'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:909b2263-3ec5-32e0-a3ec-b62267e96cab', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a31290f-5b9c-4b23-bfde-730718882293'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:909b2263-3ec5-32e0-a3ec-b62267e96cab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:45635a55-8037-3c0d-b4a5-fc076f62077d', 2, 'II', '소나타. Allegro', 'II. Sonata. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a31290f-5b9c-4b23-bfde-730718882293'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45635a55-8037-3c0d-b4a5-fc076f62077d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e44ee63b-5129-3d4d-92f1-267359e5b9b5', 3, 'III', '아리아와 변주', 'III. Aria con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a31290f-5b9c-4b23-bfde-730718882293'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e44ee63b-5129-3d4d-92f1-267359e5b9b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:375a5dac-b11f-4ea4-9334-99c08f5144ba', 4, 'IV', '미뉴에트', 'IV. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a31290f-5b9c-4b23-bfde-730718882293'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:375a5dac-b11f-4ea4-9334-99c08f5144ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccc71955-fc14-3f87-b3b3-7051200fd606', 2, NULL, '샤콘 G장조', 'Chaconne in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccc71955-fc14-3f87-b3b3-7051200fd606'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fffb5356-5a68-476b-abf7-fb409c9b0a93', 3, NULL, '모음곡 D단조', 'Suite No. 3 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fffb5356-5a68-476b-abf7-fb409c9b0a93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bf5e90e4-b5b4-3ec9-b5e4-e7f18b95261a', 1, 'I', '알르망드', 'I. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fffb5356-5a68-476b-abf7-fb409c9b0a93'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf5e90e4-b5b4-3ec9-b5e4-e7f18b95261a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3dc0a063-5bcf-333b-9c46-88452cb65789', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fffb5356-5a68-476b-abf7-fb409c9b0a93'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dc0a063-5bcf-333b-9c46-88452cb65789'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c1dabf8-26c3-3f5a-9295-854f741dbf05', 3, 'III', '에어. Lentement', 'III. Air. Lentement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fffb5356-5a68-476b-abf7-fb409c9b0a93'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c1dabf8-26c3-3f5a-9295-854f741dbf05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d7be03f4-844d-312d-b6af-83fca242f74e', 4, 'IV', '지그', 'IV. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fffb5356-5a68-476b-abf7-fb409c9b0a93'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7be03f4-844d-312d-b6af-83fca242f74e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0acc5165-6bb5-3b46-b8f4-f421fc4622e2', 5, 'V', '미뉴에트', 'V. Menuett', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fffb5356-5a68-476b-abf7-fb409c9b0a93'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0acc5165-6bb5-3b46-b8f4-f421fc4622e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae049061-2f11-45f1-8797-440927c15f3b', 4, NULL, '모음곡 D단조', 'Suite No. 4 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae049061-2f11-45f1-8797-440927c15f3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a185909-5235-3328-84ed-3cdc695838b3', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae049061-2f11-45f1-8797-440927c15f3b'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a185909-5235-3328-84ed-3cdc695838b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:03537c5f-a4ff-3efe-87eb-0cec05ffbabf', 2, 'II', '알르망드', 'II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae049061-2f11-45f1-8797-440927c15f3b'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03537c5f-a4ff-3efe-87eb-0cec05ffbabf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e3b3c4dc-0e34-3f71-8f2a-e43908506e19', 3, 'III', '쿠랑트', 'III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae049061-2f11-45f1-8797-440927c15f3b'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3b3c4dc-0e34-3f71-8f2a-e43908506e19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1e90f973-74a7-3493-a4a7-86e22a3658ea', 4, 'IV', '사라방드', 'IV. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae049061-2f11-45f1-8797-440927c15f3b'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e90f973-74a7-3493-a4a7-86e22a3658ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:40c2ff15-7ce2-3890-ba06-a42a587b7c16', 5, 'V', '지그', 'V. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae049061-2f11-45f1-8797-440927c15f3b'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40c2ff15-7ce2-3890-ba06-a42a587b7c16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cd5edb0-5328-4423-bf15-6cf943dcaae7', 5, NULL, '모음곡 E단조', 'Suite No. 5 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cd5edb0-5328-4423-bf15-6cf943dcaae7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34f72d07-e8ab-329a-b059-489cb4e01ef1', 1, 'I', '알르망드', 'I. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8cd5edb0-5328-4423-bf15-6cf943dcaae7'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34f72d07-e8ab-329a-b059-489cb4e01ef1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f7413094-d75b-3def-ac68-47ec75ac08bd', 2, 'II', '사라방드', 'II. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8cd5edb0-5328-4423-bf15-6cf943dcaae7'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7413094-d75b-3def-ac68-47ec75ac08bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c6fb8ee1-1128-3e72-91a8-4422a1fc3499', 3, 'III', '지그', 'III. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8cd5edb0-5328-4423-bf15-6cf943dcaae7'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6fb8ee1-1128-3e72-91a8-4422a1fc3499'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28ac7eda-3b42-4c30-accf-6b41df71718b', 6, NULL, '모음곡 G단조', 'Suite No. 6 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28ac7eda-3b42-4c30-accf-6b41df71718b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2d78f72-33eb-3331-8142-8defdc3fbd03', 1, 'I', '알르망드', 'I. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:28ac7eda-3b42-4c30-accf-6b41df71718b'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2d78f72-33eb-3331-8142-8defdc3fbd03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b6a4bdb-ce07-3545-8e19-7f852f568fc6', 2, 'II', '쿠랑트', 'II. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:28ac7eda-3b42-4c30-accf-6b41df71718b'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b6a4bdb-ce07-3545-8e19-7f852f568fc6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:871aab23-f4f5-34cc-b46c-658891a04f29', 3, 'III', '지그', 'III. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:28ac7eda-3b42-4c30-accf-6b41df71718b'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:871aab23-f4f5-34cc-b46c-658891a04f29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee99fd5a-b6a1-4cfb-a257-d7b459faf3fb', 7, NULL, '모음곡 B♭장조', 'Suite No. 7 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee99fd5a-b6a1-4cfb-a257-d7b459faf3fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4bf1b5f7-5c63-32fa-9fad-e0c7f8c94367', 1, 'I', '알르망드', 'I. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ee99fd5a-b6a1-4cfb-a257-d7b459faf3fb'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bf1b5f7-5c63-32fa-9fad-e0c7f8c94367'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8288bd0-a4df-3660-a0ed-c7bc889767da', 2, 'II', '쿠랑트', 'II. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ee99fd5a-b6a1-4cfb-a257-d7b459faf3fb'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8288bd0-a4df-3660-a0ed-c7bc889767da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88c60289-6cba-3eb4-8ece-5e60241be2f5', 3, 'III', '사라방드', 'III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ee99fd5a-b6a1-4cfb-a257-d7b459faf3fb'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88c60289-6cba-3eb4-8ece-5e60241be2f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b828075-f77c-3134-b37b-c6b3815f9bf1', 4, 'IV', '지그', 'IV. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ee99fd5a-b6a1-4cfb-a257-d7b459faf3fb'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b828075-f77c-3134-b37b-c6b3815f9bf1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bc5bba4-93c1-4f70-ac4c-8266223828c8', 8, NULL, '모음곡 G장조', 'Suite No. 8 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bc5bba4-93c1-4f70-ac4c-8266223828c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:daea49e5-96bf-3741-8f64-0878bcfecd28', 1, 'I', '알르망드', 'I. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4bc5bba4-93c1-4f70-ac4c-8266223828c8'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daea49e5-96bf-3741-8f64-0878bcfecd28'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e36530b1-49c8-3e7c-b5fa-8a275af61705', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4bc5bba4-93c1-4f70-ac4c-8266223828c8'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e36530b1-49c8-3e7c-b5fa-8a275af61705'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d10ab55-1781-3811-ba61-14036e56f47c', 3, 'III', '쿠랑트', 'III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4bc5bba4-93c1-4f70-ac4c-8266223828c8'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d10ab55-1781-3811-ba61-14036e56f47c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:90c1e383-ee01-3415-aef6-b53bd090871f', 4, 'IV', '아리아. Presto', 'IV. Aria. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4bc5bba4-93c1-4f70-ac4c-8266223828c8'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90c1e383-ee01-3415-aef6-b53bd090871f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47376042-2fb1-3485-9530-fd625a492153', 5, 'V', '미뉴에트', 'V. Menuett', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4bc5bba4-93c1-4f70-ac4c-8266223828c8'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47376042-2fb1-3485-9530-fd625a492153'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6df216ac-beb1-367f-9455-876acd3c6969', 6, 'VI', '가보트 - Double', 'VI. Gavotte - Double', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4bc5bba4-93c1-4f70-ac4c-8266223828c8'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6df216ac-beb1-367f-9455-876acd3c6969'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5756ec7a-b381-383d-8277-e7fc9e30d0ff', 7, 'VII', '지그', 'VII. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4bc5bba4-93c1-4f70-ac4c-8266223828c8'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5756ec7a-b381-383d-8277-e7fc9e30d0ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae166b51-79c3-4933-b186-41fb1455b17d', 9, NULL, '전주곡과 샤콘 G장조', 'Prelude and Chaconne in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae166b51-79c3-4933-b186-41fb1455b17d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ba0751a9-15f5-4566-8f47-a4a825390b5d', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae166b51-79c3-4933-b186-41fb1455b17d'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba0751a9-15f5-4566-8f47-a4a825390b5d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1dccabd-164e-40a3-83a8-61db3905ce31', 2, 'II', '샤콘', 'II. Chaconne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae166b51-79c3-4933-b186-41fb1455b17d'
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 HWV 434–442' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1dccabd-164e-40a3-83a8-61db3905ce31'
);


-- HWV 443 하프시코드 모음곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드 모음곡 C장조', 'Keyboard Suite in C major', 'album', 'HWV 443', NULL, NULL, 1703, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드 모음곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e6bbd4c-3153-4339-8874-f1dd32d53d7e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1e6bbd4c-3153-4339-8874-f1dd32d53d7e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e6bbd4c-3153-4339-8874-f1dd32d53d7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1768c77-dbd5-42d1-b8f0-37deec59f89d', 1, 'I', '전주곡', 'I. Praeludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1768c77-dbd5-42d1-b8f0-37deec59f89d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a02f907a-7b81-4229-91a2-1a01aed071e1', 2, 'II', '알르망드', 'II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a02f907a-7b81-4229-91a2-1a01aed071e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd908fe9-dd28-41e4-8dbd-06062b577ba2', 3, 'III', '쿠랑트', 'III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd908fe9-dd28-41e4-8dbd-06062b577ba2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f41d762b-9162-43ec-be16-ab19fb26dff0', 4, 'IV', '사라방드와 두블', 'IV. Sarabande & Double', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f41d762b-9162-43ec-be16-ab19fb26dff0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90997550-9281-40c8-b015-9565f39d2018', 5, 'V', '지그', 'V. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90997550-9281-40c8-b015-9565f39d2018'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dce1e231-3db0-4741-8033-c8c924a620c2', 6, 'VI', '샤콘', 'VI. Chaconne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dce1e231-3db0-4741-8033-c8c924a620c2'
);


-- HWV 444 파르티타 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파르티타 C단조', 'Partita in C minor', 'album', 'HWV 444', NULL, NULL, 1706, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파르티타 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd061e92e-19f2-41e6-a58e-ee5a7f45b881'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd061e92e-19f2-41e6-a58e-ee5a7f45b881'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd061e92e-19f2-41e6-a58e-ee5a7f45b881'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d394e501-1971-4d3e-b0fd-b0e8d57e6104', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d394e501-1971-4d3e-b0fd-b0e8d57e6104'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73f9adaf-c644-4bc1-b967-3781537263d1', 2, 'II', '알르망드', 'II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73f9adaf-c644-4bc1-b967-3781537263d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60b0a269-7857-45dc-bb77-b123046d8acc', 3, 'III', '쿠랑트', 'III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60b0a269-7857-45dc-bb77-b123046d8acc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fa402c5-b864-4ade-95fe-c93e03448879', 4, 'IV', '가보트', 'IV. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fa402c5-b864-4ade-95fe-c93e03448879'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c586f16-4931-43f3-a58a-9f7f538c1469', 5, 'V', '미뉴에트', 'V. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c586f16-4931-43f3-a58a-9f7f538c1469'
);


-- HWV 445 하프시코드 모음곡 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드 모음곡 C단조', 'Keyboard Suite in C minor', 'album', 'HWV 445', NULL, NULL, 1706, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드 모음곡 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d651acc-2d80-4f4c-b06d-490cdd83c797'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6d651acc-2d80-4f4c-b06d-490cdd83c797'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d651acc-2d80-4f4c-b06d-490cdd83c797'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf014c83-fd67-4185-ac8b-3c317e753d2f', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf014c83-fd67-4185-ac8b-3c317e753d2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf79d1de-33d5-4f0c-a333-dc266cfeb425', 2, 'II', '알르망드', 'II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf79d1de-33d5-4f0c-a333-dc266cfeb425'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e77856a-e36c-4f86-9843-e3297a7fdc1a', 3, 'III', '쿠랑트', 'III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e77856a-e36c-4f86-9843-e3297a7fdc1a'
);


-- HWV 447 하프시코드 모음곡 D단조 HWV 447

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드 모음곡 D단조 HWV 447', 'Keyboard Suite in D minor, HWV 447', 'album', NULL, 'HWV', '447', 1739, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드 모음곡 D단조 HWV 447'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a97490ce-4302-4524-9164-3df0709d0318'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a97490ce-4302-4524-9164-3df0709d0318'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 447' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a97490ce-4302-4524-9164-3df0709d0318'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ab0e7cd-6856-4f00-9477-457c031b9937', 1, 'I', '알르망드', 'I. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 447' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ab0e7cd-6856-4f00-9477-457c031b9937'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43577af5-8df4-4c34-a2b6-af8948a1b00f', 2, 'II', '쿠랑트', 'II. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 447' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43577af5-8df4-4c34-a2b6-af8948a1b00f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f164a21f-e9cc-48e5-913f-b7cd2d338780', 3, 'III', '사라방드', 'III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 447' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f164a21f-e9cc-48e5-913f-b7cd2d338780'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e40bf4c-a1d7-4265-bf3c-a9ad52600ff3', 4, 'IV', '지그', 'IV. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 447' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e40bf4c-a1d7-4265-bf3c-a9ad52600ff3'
);


-- HWV 448 하프시코드 모음곡 D단조 HWV 448

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드 모음곡 D단조 HWV 448', 'Keyboard Suite in D minor, HWV 448', 'album', NULL, 'HWV', '448', 1706, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드 모음곡 D단조 HWV 448'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9c9ef03-a1f2-4a65-a3a9-e72f349bdc6e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd9c9ef03-a1f2-4a65-a3a9-e72f349bdc6e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 448' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9c9ef03-a1f2-4a65-a3a9-e72f349bdc6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ec0509a-5cb7-407d-b6ff-3fea5337aab2', 1, 'I', '서곡', 'I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 448' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ec0509a-5cb7-407d-b6ff-3fea5337aab2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61f2f50b-4036-4985-a7cf-20c739677824', 2, 'II', '알르망드', 'II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 448' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61f2f50b-4036-4985-a7cf-20c739677824'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:938c9d3d-b2c1-4be7-8613-810accd79de8', 3, 'III', '쿠랑트', 'III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 448' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:938c9d3d-b2c1-4be7-8613-810accd79de8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e794dd4-7572-4484-9ab3-98ae8dfd3826', 4, 'IV', '사라방드 I', 'IV. Sarabande I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 448' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e794dd4-7572-4484-9ab3-98ae8dfd3826'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54e2f671-a7bb-44a2-9061-c51b66eaa9f0', 5, 'V', '사라방드 II', 'V. Sarabande II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 448' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54e2f671-a7bb-44a2-9061-c51b66eaa9f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd79a9ea-7e54-44f6-b9a4-9f600ded21fd', 6, 'VI', '샤콘', 'VI. Chaconne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 448' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd79a9ea-7e54-44f6-b9a4-9f600ded21fd'
);


-- HWV 449 하프시코드 모음곡 D단조 HWV 449

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드 모음곡 D단조 HWV 449', 'Keyboard Suite in D minor, HWV 449', 'album', NULL, 'HWV', '449', 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드 모음곡 D단조 HWV 449'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f0a185d-c867-4eb0-8167-f674cf6c7ea0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7f0a185d-c867-4eb0-8167-f674cf6c7ea0'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 449' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f0a185d-c867-4eb0-8167-f674cf6c7ea0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8d340a8-b4d3-4dc4-9b4e-8043f22ec35b', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 449' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8d340a8-b4d3-4dc4-9b4e-8043f22ec35b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c8dd193-e1b0-4acb-8757-a7ce34b80beb', 2, 'II', '알르망드', 'II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 449' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c8dd193-e1b0-4acb-8757-a7ce34b80beb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61366378-5f1a-474a-9df5-f3034b0d3e36', 3, 'III', '쿠랑트', 'III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 449' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61366378-5f1a-474a-9df5-f3034b0d3e36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33edf41b-60b6-4641-9ca2-e00a1d387e05', 4, 'IV', '사라방드', 'IV. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 449' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33edf41b-60b6-4641-9ca2-e00a1d387e05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6a84a73-cb1c-4bdd-96e0-2d7da4e6fc1b', 5, 'V', '아리아', 'V. Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 449' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6a84a73-cb1c-4bdd-96e0-2d7da4e6fc1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e5be736-0a54-41b3-b4f0-e7fd33db3bfe', 6, 'VI', '지그', 'VI. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 449' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e5be736-0a54-41b3-b4f0-e7fd33db3bfe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f30536fa-f08f-47c3-86c3-80bed9b2a9e2', 7, 'VII', '미뉴에트', 'VII. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 D단조 HWV 449' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f30536fa-f08f-47c3-86c3-80bed9b2a9e2'
);


-- HWV 450 파르티타 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파르티타 G장조', 'Partita in G major', 'album', 'HWV 450', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파르티타 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35e5a924-315f-46f2-8253-95bfde942771'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '35e5a924-315f-46f2-8253-95bfde942771'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35e5a924-315f-46f2-8253-95bfde942771'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eef14d66-472d-4420-ad00-1ff9a55a8125', 1, 'I', '전주곡', 'I. Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eef14d66-472d-4420-ad00-1ff9a55a8125'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:504c6e71-583d-413d-99ef-71999161a46d', 2, 'II', '알르망드', 'II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:504c6e71-583d-413d-99ef-71999161a46d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b973a13-ff68-460b-854c-14ee31f1866f', 3, 'III', '쿠랑트', 'III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b973a13-ff68-460b-854c-14ee31f1866f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a533f930-6763-41db-9747-9d9c7ff460f6', 4, 'IV', '사라방드', 'IV. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a533f930-6763-41db-9747-9d9c7ff460f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f38b3d75-15f1-410f-8fed-d31e42f6f0f4', 5, 'V', '지그', 'V. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f38b3d75-15f1-410f-8fed-d31e42f6f0f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f6c3374-56a6-4f07-9665-f76e53af7c9d', 6, 'VI', '미뉴에트', 'VI. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f6c3374-56a6-4f07-9665-f76e53af7c9d'
);


-- HWV 451 하프시코드 모음곡 G단조 HWV 451

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드 모음곡 G단조 HWV 451', 'Keyboard Suite in G minor, HWV 451', 'album', NULL, 'HWV', '451', 1706, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드 모음곡 G단조 HWV 451'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5d1f0a8-161d-4ebc-922f-80a399920b8c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b5d1f0a8-161d-4ebc-922f-80a399920b8c'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 451' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5d1f0a8-161d-4ebc-922f-80a399920b8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04e7c9ad-7059-4541-9f7e-5a675c974372', 1, 'I', '알르망드', 'I. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 451' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04e7c9ad-7059-4541-9f7e-5a675c974372'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:887ca463-3d67-4c06-8462-9461290975b7', 2, 'II', '쿠랑트', 'II. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 451' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:887ca463-3d67-4c06-8462-9461290975b7'
);


-- HWV 452 하프시코드 모음곡 G단조 HWV 452

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드 모음곡 G단조 HWV 452', 'Keyboard Suite in G minor, HWV 452', 'album', NULL, 'HWV', '452', 1739, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드 모음곡 G단조 HWV 452'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd714a7f0-9f26-4c28-8980-fbbf59cdee3f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd714a7f0-9f26-4c28-8980-fbbf59cdee3f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 452' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd714a7f0-9f26-4c28-8980-fbbf59cdee3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b92d78ca-2596-3db1-bd3d-904d0198c020', 1, 'I', '알르망드', 'I. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 452' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b92d78ca-2596-3db1-bd3d-904d0198c020'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71fe6eb1-6da6-3b31-9b22-02c1d18edf8d', 2, 'II', '쿠랑트', 'II. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 452' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71fe6eb1-6da6-3b31-9b22-02c1d18edf8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f11b9f85-5862-38a1-bdd9-bb873f13d02b', 3, 'III', '사라방드', 'III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 452' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f11b9f85-5862-38a1-bdd9-bb873f13d02b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cab8257-1914-32d2-a78c-d53a8f2edea4', 4, 'IV', '지그', 'IV. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 452' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cab8257-1914-32d2-a78c-d53a8f2edea4'
);


-- HWV 453 하프시코드 모음곡 G단조 HWV 453

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드 모음곡 G단조 HWV 453', 'Keyboard Suite in G minor, HWV 453', 'album', NULL, 'HWV', '453', 1706, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드 모음곡 G단조 HWV 453'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea8241cb-a126-456e-93c0-9874f88f4b3d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ea8241cb-a126-456e-93c0-9874f88f4b3d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 453' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea8241cb-a126-456e-93c0-9874f88f4b3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7e07ef-476e-4ece-bb9f-f68f8d2e9e44', 1, 'I', '서곡', 'I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 453' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7e07ef-476e-4ece-bb9f-f68f8d2e9e44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9aecdf5c-79b7-4e96-833a-730c287f0457', 2, 'II', 'Entrée', 'II. Entrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 453' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9aecdf5c-79b7-4e96-833a-730c287f0457'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8d89196-b2d3-4d2c-b57a-58a0d9105d7d', 3, 'III', '미뉴에트 I', 'III. Menuet I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 453' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d89196-b2d3-4d2c-b57a-58a0d9105d7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7c4792d-c6c8-4451-9895-22d0bd54297e', 4, 'IV', '미뉴에트 II', 'IV. Menuet II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 453' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7c4792d-c6c8-4451-9895-22d0bd54297e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee6746d9-b7fe-4b1e-a44d-00643f06a0fd', 5, 'V', '샤콘', 'V. Chaconne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '하프시코드 모음곡 G단조 HWV 453' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee6746d9-b7fe-4b1e-a44d-00643f06a0fd'
);


-- HWV 454 파르티타 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파르티타 A장조', 'Partita in A major', 'album', 'HWV 454', NULL, NULL, 1706, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파르티타 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab310353-15bc-4fc5-a371-b2dfafa76c19'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ab310353-15bc-4fc5-a371-b2dfafa76c19'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab310353-15bc-4fc5-a371-b2dfafa76c19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b76c414b-d08d-4bb7-9b0e-834e156cee94', 1, 'I', '알르망드', 'I. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b76c414b-d08d-4bb7-9b0e-834e156cee94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a140f11b-9a5e-4f12-8408-849032492ca8', 2, 'II', '쿠랑트', 'II. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a140f11b-9a5e-4f12-8408-849032492ca8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:759a4e50-ef27-4b51-99ff-233eb5edc52e', 3, 'III', '사라방드', 'III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:759a4e50-ef27-4b51-99ff-233eb5edc52e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b713f88-1ae8-4626-9efc-6762177b1dc8', 4, 'IV', '지그', 'IV. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파르티타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b713f88-1ae8-4626-9efc-6762177b1dc8'
);


-- HWV 457 에어 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에어 C장조', 'Air in C major', 'song', 'HWV 457', NULL, NULL, 1721, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에어 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8dcbf05-fc55-4fd4-9ce9-fb1ff00ef96c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e8dcbf05-fc55-4fd4-9ce9-fb1ff00ef96c'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '에어 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8dcbf05-fc55-4fd4-9ce9-fb1ff00ef96c'
);


-- HWV 460 에어(행진곡) D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에어(행진곡) D장조', 'Air (March) in D major', 'song', 'HWV 460', NULL, NULL, 1721, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에어(행진곡) D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e2e71b1f-8954-4b67-bb52-c1901058a94c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e2e71b1f-8954-4b67-bb52-c1901058a94c'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '에어(행진곡) D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e2e71b1f-8954-4b67-bb52-c1901058a94c'
);


-- HWV 461 에어(혼파이프) D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에어(혼파이프) D단조', 'Air (Hornpipe) in D minor', 'song', 'HWV 461', NULL, NULL, 1718, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에어(혼파이프) D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a821a0e-eeba-4a0a-8a1d-aa435ed82bab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a821a0e-eeba-4a0a-8a1d-aa435ed82bab'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '에어(혼파이프) D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a821a0e-eeba-4a0a-8a1d-aa435ed82bab'
);


-- HWV 462 에어와 미뉴에트 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에어와 미뉴에트 D단조', 'Air and Minuet in D minor', 'song', 'HWV 462', NULL, NULL, 1726, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에어와 미뉴에트 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e2d69321-c5b5-4966-b71e-0e33b125772b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e2d69321-c5b5-4966-b71e-0e33b125772b'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '에어와 미뉴에트 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e2d69321-c5b5-4966-b71e-0e33b125772b'
);


-- HWV 463 에어 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에어 F장조', 'Air in F major', 'song', 'HWV 463', NULL, NULL, 1709, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에어 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6738383-93b9-4f80-8c07-dd85cd304859'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6738383-93b9-4f80-8c07-dd85cd304859'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '에어 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6738383-93b9-4f80-8c07-dd85cd304859'
);


-- HWV 465 에어와 두 개의 두블 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에어와 두 개의 두블 F장조', 'Air and Two Doubles in F major', 'song', 'HWV 465', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에어와 두 개의 두블 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b1019d7-0378-4ee1-bdc4-69cf7ef2ac4f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b1019d7-0378-4ee1-bdc4-69cf7ef2ac4f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '에어와 두 개의 두블 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b1019d7-0378-4ee1-bdc4-69cf7ef2ac4f'
);


-- HWV 466 에어 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에어 G단조', 'Air in G minor', 'song', 'HWV 466', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에어 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0e2870d-9f8f-49cf-8b75-a6a2a727ae8b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c0e2870d-9f8f-49cf-8b75-a6a2a727ae8b'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '에어 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0e2870d-9f8f-49cf-8b75-a6a2a727ae8b'
);


-- HWV 467 에어 G단조 "Lentement"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에어 G단조 "Lentement"', 'Air in G minor "Lentement"', 'song', 'HWV 467', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에어 G단조 "Lentement"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5057c5d4-4a57-4ee9-8d58-be48317ee61a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5057c5d4-4a57-4ee9-8d58-be48317ee61a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '에어 G단조 "Lentement"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5057c5d4-4a57-4ee9-8d58-be48317ee61a'
);


-- HWV 468 에어 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에어 A장조', 'Air in A major', 'song', 'HWV 468', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에어 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81f61ca8-9877-4f57-8e99-99f8b47a5aba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '81f61ca8-9877-4f57-8e99-99f8b47a5aba'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '에어 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81f61ca8-9877-4f57-8e99-99f8b47a5aba'
);


-- HWV 469 에어 B♭장조 HWV 469

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에어 B♭장조 HWV 469', 'Air in B♭ major, HWV 469', 'song', NULL, 'HWV', '469', 1739, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에어 B♭장조 HWV 469'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4e5c800-93a2-4eea-9167-e0becbfb3b2f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4e5c800-93a2-4eea-9167-e0becbfb3b2f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '에어 B♭장조 HWV 469' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4e5c800-93a2-4eea-9167-e0becbfb3b2f'
);


-- HWV 470 에어 B♭장조 HWV 470

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에어 B♭장조 HWV 470', 'Air in B♭ major, HWV 470', 'song', NULL, 'HWV', '470', 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에어 B♭장조 HWV 470'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '820a0bf0-c4bf-4d05-a02d-545674bb388d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '820a0bf0-c4bf-4d05-a02d-545674bb388d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '에어 B♭장조 HWV 470' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '820a0bf0-c4bf-4d05-a02d-545674bb388d'
);


-- HWV 471 에어 B♭장조 HWV 471

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에어 B♭장조 HWV 471', 'Air in B♭ major, HWV 471', 'song', NULL, 'HWV', '471', 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에어 B♭장조 HWV 471'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '95638e77-228c-4100-945b-c9944a210426'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '95638e77-228c-4100-945b-c9944a210426'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '에어 B♭장조 HWV 471' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '95638e77-228c-4100-945b-c9944a210426'
);


-- HWV 472 알레그로 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그로 C장조', 'Allegro in C major', 'song', 'HWV 472', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그로 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e0e4090-2861-47b5-9ec1-6da3b29129ad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e0e4090-2861-47b5-9ec1-6da3b29129ad'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '알레그로 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e0e4090-2861-47b5-9ec1-6da3b29129ad'
);


-- HWV 475 알레그로 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그로 D단조', 'Allegro in D minor', 'song', 'HWV 475', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그로 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86d37894-797a-4354-8e04-f6734036475a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86d37894-797a-4354-8e04-f6734036475a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '알레그로 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86d37894-797a-4354-8e04-f6734036475a'
);


-- HWV 476 알르망드 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알르망드 F장조', 'Allemande in F major', 'song', 'HWV 476', NULL, NULL, 1735, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알르망드 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '731c3b04-7f9a-4e04-a263-1fbe070be7c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '731c3b04-7f9a-4e04-a263-1fbe070be7c7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '알르망드 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '731c3b04-7f9a-4e04-a263-1fbe070be7c7'
);


-- HWV 477 알르망드 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알르망드 A장조', 'Allemande in A major', 'song', 'HWV 477', NULL, NULL, 1726, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알르망드 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5da9b47b-3b86-4b3e-8838-9b11e4c3765d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5da9b47b-3b86-4b3e-8838-9b11e4c3765d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '알르망드 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5da9b47b-3b86-4b3e-8838-9b11e4c3765d'
);


-- HWV 478 알르망드 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알르망드 A단조', 'Allemande in A minor', 'song', 'HWV 478', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알르망드 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '799a14f7-3bc8-4b1f-92f3-6d2fd43420e3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '799a14f7-3bc8-4b1f-92f3-6d2fd43420e3'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '알르망드 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '799a14f7-3bc8-4b1f-92f3-6d2fd43420e3'
);


-- HWV 479 알르망드 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알르망드 B단조', 'Allemande in B minor', 'song', 'HWV 479', NULL, NULL, 1722, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알르망드 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ddf5d17-0d35-4337-a76e-6ae982356672'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3ddf5d17-0d35-4337-a76e-6ae982356672'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '알르망드 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ddf5d17-0d35-4337-a76e-6ae982356672'
);


-- HWV 480 코랄 G단조 "Jesu, meine Freude"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '코랄 G단조 "Jesu, meine Freude"', 'Chorale in G minor "Jesu, meine Freude"', 'song', 'HWV 480', NULL, NULL, 1740, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '코랄 G단조 "Jesu, meine Freude"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ec5c7c5-028b-4403-bd11-bf1bcc559636'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5ec5c7c5-028b-4403-bd11-bf1bcc559636'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '코랄 G단조 "Jesu, meine Freude"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ec5c7c5-028b-4403-bd11-bf1bcc559636'
);


-- HWV 481 카프리치오 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카프리치오 F장조', 'Capriccio in F major', 'song', 'HWV 481', NULL, NULL, 1706, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카프리치오 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c099ed81-c0ff-406f-a45f-11aa82222b6f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c099ed81-c0ff-406f-a45f-11aa82222b6f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '카프리치오 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c099ed81-c0ff-406f-a45f-11aa82222b6f'
);


-- HWV 483 카프리치오 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카프리치오 G단조', 'Capriccio in G minor', 'song', 'HWV 483', NULL, NULL, 1721, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카프리치오 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ecba8d1-d4af-4359-a010-545f36bdfc70'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3ecba8d1-d4af-4359-a010-545f36bdfc70'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '카프리치오 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ecba8d1-d4af-4359-a010-545f36bdfc70'
);


-- HWV 485 샤콘 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '샤콘 F장조', 'Chaconne in F major', 'song', 'HWV 485', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '샤콘 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5ab056d-2c7e-453d-add1-1c79fd874edc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5ab056d-2c7e-453d-add1-1c79fd874edc'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '샤콘 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5ab056d-2c7e-453d-add1-1c79fd874edc'
);


-- HWV 486 샤콘 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '샤콘 G단조', 'Chaconne in G minor', 'song', 'HWV 486', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '샤콘 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2560b15-14f5-4562-891c-f7faab6c7fd1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b2560b15-14f5-4562-891c-f7faab6c7fd1'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '샤콘 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2560b15-14f5-4562-891c-f7faab6c7fd1'
);


-- HWV 487 건반 협주곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 협주곡 G장조', 'Concerto in G major for Keyboard', 'album', 'HWV 487', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 협주곡 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8931832-8939-4e99-ad7a-f044d1060b15'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b8931832-8939-4e99-ad7a-f044d1060b15'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '건반 협주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8931832-8939-4e99-ad7a-f044d1060b15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a982c953-afc8-4457-b1b3-4d91fc753f2e', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '건반 협주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a982c953-afc8-4457-b1b3-4d91fc753f2e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:335495f5-822b-48ed-9e0c-f360cb6c0f3a', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '건반 협주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:335495f5-822b-48ed-9e0c-f360cb6c0f3a'
);


-- HWV 489 쿠랑트 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '쿠랑트 B단조', 'Courante in B minor', 'song', 'HWV 489', NULL, NULL, 1722, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '쿠랑트 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '273fb4d6-308a-4a6f-93fc-9f12ce28f42a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '273fb4d6-308a-4a6f-93fc-9f12ce28f42a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '쿠랑트 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '273fb4d6-308a-4a6f-93fc-9f12ce28f42a'
);


-- HWV 490 환상곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상곡 C장조', 'Fantasia in C major', 'song', 'HWV 490', NULL, NULL, 1706, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '946fef2a-83f7-4049-8578-abcdb6421138'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '946fef2a-83f7-4049-8578-abcdb6421138'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '환상곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '946fef2a-83f7-4049-8578-abcdb6421138'
);


-- HWV 491 가보트 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가보트 G장조', 'Gavotte in G major', 'song', 'HWV 491', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가보트 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9206f310-849b-4bdb-b7db-8c5ec229db4b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9206f310-849b-4bdb-b7db-8c5ec229db4b'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '가보트 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9206f310-849b-4bdb-b7db-8c5ec229db4b'
);


-- HWV 492 지그 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '지그 F장조', 'Gigue in F major', 'song', 'HWV 492', NULL, NULL, 1727, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '지그 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e17dc206-80c5-44f8-a2ec-4d07bf70e4ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e17dc206-80c5-44f8-a2ec-4d07bf70e4ed'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '지그 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e17dc206-80c5-44f8-a2ec-4d07bf70e4ed'
);


-- HWV 493 지그 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '지그 G단조', 'Gigue in G minor', 'song', 'HWV 493', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '지그 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c77ea8fa-cfcd-491b-aac2-3d6460073c0f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c77ea8fa-cfcd-491b-aac2-3d6460073c0f'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '지그 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c77ea8fa-cfcd-491b-aac2-3d6460073c0f'
);


-- HWV 494 부레 G단조 "Impertinence"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부레 G단조 "Impertinence"', 'Bourrée in G minor "Impertinence"', 'song', 'HWV 494', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부레 G단조 "Impertinence"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e51e9cf1-d15f-4cc7-9583-44c71b742a7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e51e9cf1-d15f-4cc7-9583-44c71b742a7d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '부레 G단조 "Impertinence"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e51e9cf1-d15f-4cc7-9583-44c71b742a7d'
);


-- HWV 496 레슨 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '레슨 A단조', 'Lesson in A minor', 'song', 'HWV 496', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '레슨 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2b49e5e-d28c-4865-b7f0-c4be54ac3614'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd2b49e5e-d28c-4865-b7f0-c4be54ac3614'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '레슨 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2b49e5e-d28c-4865-b7f0-c4be54ac3614'
);


-- HWV 559 파스피에 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파스피에 C장조', 'Passepied in C major', 'song', 'HWV 559', NULL, NULL, 1722, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파스피에 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '693c0f10-9b67-44b6-bdf0-505818920ba7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '693c0f10-9b67-44b6-bdf0-505818920ba7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파스피에 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '693c0f10-9b67-44b6-bdf0-505818920ba7'
);


-- HWV 560 파스피에 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파스피에 A장조', 'Passepied in A major', 'song', 'HWV 560', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파스피에 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68400ba3-aa0d-4d9a-b4d8-93425b86def2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '68400ba3-aa0d-4d9a-b4d8-93425b86def2'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '파스피에 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68400ba3-aa0d-4d9a-b4d8-93425b86def2'
);


-- HWV 562 전주곡 D단조 "Harpeggio"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 D단조 "Harpeggio"', 'Prelude in D minor "Harpeggio"', 'song', 'HWV 562', NULL, NULL, 1712, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 D단조 "Harpeggio"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '050c044f-10a1-4a05-8c68-fa390356c953'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '050c044f-10a1-4a05-8c68-fa390356c953'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡 D단조 "Harpeggio"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '050c044f-10a1-4a05-8c68-fa390356c953'
);


-- HWV 563 전주곡 D단조 HWV 563

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 D단조 HWV 563', 'Prelude in D minor, HWV 563', 'song', NULL, 'HWV', '563', 1703, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 D단조 HWV 563'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e7c0dac-c7fd-4eb9-aecd-5db1200d692a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6e7c0dac-c7fd-4eb9-aecd-5db1200d692a'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡 D단조 HWV 563' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e7c0dac-c7fd-4eb9-aecd-5db1200d692a'
);


-- HWV 564 전주곡 D단조 HWV 564

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 D단조 HWV 564', 'Prelude in D minor, HWV 564', 'song', NULL, 'HWV', '564', 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 D단조 HWV 564'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3ec3914-1756-4541-9c3b-9d8128b48b9d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f3ec3914-1756-4541-9c3b-9d8128b48b9d'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡 D단조 HWV 564' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3ec3914-1756-4541-9c3b-9d8128b48b9d'
);


-- HWV 566 전주곡 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 E장조', 'Prelude in E major', 'song', 'HWV 566', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06ddd7b6-2160-49f7-9858-82decd8d9327'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06ddd7b6-2160-49f7-9858-82decd8d9327'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06ddd7b6-2160-49f7-9858-82decd8d9327'
);


-- HWV 567 전주곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 F장조', 'Prelude in F major', 'song', 'HWV 567', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02116c5c-8a14-47fe-b51a-87d8bdcfc716'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '02116c5c-8a14-47fe-b51a-87d8bdcfc716'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02116c5c-8a14-47fe-b51a-87d8bdcfc716'
);


-- HWV 568 전주곡 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 F단조', 'Prelude in F minor', 'song', 'HWV 568', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eacc508d-b1c7-4214-a042-51ce32477d73'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eacc508d-b1c7-4214-a042-51ce32477d73'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eacc508d-b1c7-4214-a042-51ce32477d73'
);


-- HWV 570 전주곡 F#단조 "Harpeggio"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 F#단조 "Harpeggio"', 'Prelude in F# minor "Harpeggio"', 'song', 'HWV 570', NULL, NULL, 1718, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 F#단조 "Harpeggio"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d3175c1-2f39-4de3-8c20-2fbf29f07eef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2d3175c1-2f39-4de3-8c20-2fbf29f07eef'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡 F#단조 "Harpeggio"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d3175c1-2f39-4de3-8c20-2fbf29f07eef'
);


-- HWV 571 전주곡과 카프리치오 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡과 카프리치오 G장조', 'Prelude and Capriccio in G major', 'album', 'HWV 571', NULL, NULL, 1706, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡과 카프리치오 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1686ec1c-89f1-4910-9c75-14a52cad5e9e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1686ec1c-89f1-4910-9c75-14a52cad5e9e'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡과 카프리치오 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1686ec1c-89f1-4910-9c75-14a52cad5e9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:040e5773-0e5e-401f-b3a3-435314fb1fb8', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡과 카프리치오 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:040e5773-0e5e-401f-b3a3-435314fb1fb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f88d382-e5aa-45da-839b-ae6027834ef7', 2, 'II', '카프리치오', 'II. Capriccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡과 카프리치오 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f88d382-e5aa-45da-839b-ae6027834ef7'
);


-- HWV 572 전주곡 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 G단조', 'Prelude in G minor', 'song', 'HWV 572', NULL, NULL, 1717, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da1e5bbe-205b-4f76-b33c-3e554b9f0c23'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'da1e5bbe-205b-4f76-b33c-3e554b9f0c23'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da1e5bbe-205b-4f76-b33c-3e554b9f0c23'
);


-- HWV 573 전주곡 G단조 "Harpeggio"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 G단조 "Harpeggio"', 'Prelude in G minor "Harpeggio"', 'song', 'HWV 573', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 G단조 "Harpeggio"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9610df2d-ac83-4a67-a34a-af9840478ea6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9610df2d-ac83-4a67-a34a-af9840478ea6'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡 G단조 "Harpeggio"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9610df2d-ac83-4a67-a34a-af9840478ea6'
);


-- HWV 574 전주곡과 알레그로 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡과 알레그로 G단조', 'Prelude and Allegro in G minor', 'song', 'HWV 574', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡과 알레그로 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae95e071-0a3c-4a4f-8c3b-478549c4a9e7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae95e071-0a3c-4a4f-8c3b-478549c4a9e7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡과 알레그로 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae95e071-0a3c-4a4f-8c3b-478549c4a9e7'
);


-- HWV 575 전주곡 A단조 "Harpeggio"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 A단조 "Harpeggio"', 'Prelude in A minor "Harpeggio"', 'song', 'HWV 575', NULL, NULL, 1718, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 A단조 "Harpeggio"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b77481ef-0bc8-453e-ad79-a96a7509b092'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b77481ef-0bc8-453e-ad79-a96a7509b092'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡 A단조 "Harpeggio"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b77481ef-0bc8-453e-ad79-a96a7509b092'
);


-- HWV 576 전주곡과 알레그로 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡과 알레그로 A단조', 'Prelude and Allegro in A minor', 'album', 'HWV 576', NULL, NULL, 1706, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡과 알레그로 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac8b68f7-d7ac-42a0-9aa9-40b0b77dd476'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac8b68f7-d7ac-42a0-9aa9-40b0b77dd476'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡과 알레그로 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac8b68f7-d7ac-42a0-9aa9-40b0b77dd476'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9829d44c-7de4-4ca7-a4c9-e43e26576a8b', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡과 알레그로 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9829d44c-7de4-4ca7-a4c9-e43e26576a8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f132981-956c-4e36-ac2f-53ab429df4ea', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '전주곡과 알레그로 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f132981-956c-4e36-ac2f-53ab429df4ea'
);


-- HWV 577 소나타(환상곡) C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나타(환상곡) C장조', 'Sonata (Fantasia) in C major', 'song', 'HWV 577', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나타(환상곡) C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '299ef3d9-b4fd-488d-9fd7-db2160cfc3e2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '299ef3d9-b4fd-488d-9fd7-db2160cfc3e2'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '소나타(환상곡) C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '299ef3d9-b4fd-488d-9fd7-db2160cfc3e2'
);


-- HWV 579 소나타(환상곡) G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나타(환상곡) G장조', 'Sonata (Fantasia) in G major', 'song', 'HWV 579', NULL, NULL, 1710, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나타(환상곡) G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b7f1217-e733-4393-83cb-98842f726a82'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3b7f1217-e733-4393-83cb-98842f726a82'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '소나타(환상곡) G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b7f1217-e733-4393-83cb-98842f726a82'
);


-- HWV 580 소나타(라르게토) G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나타(라르게토) G단조', 'Sonata (Larghetto) in G minor', 'song', 'HWV 580', NULL, NULL, 1710, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나타(라르게토) G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79597343-445b-49cc-b5fa-0d6f36f651d1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '79597343-445b-49cc-b5fa-0d6f36f651d1'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '소나타(라르게토) G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79597343-445b-49cc-b5fa-0d6f36f651d1'
);


-- HWV 581 소나티나 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나티나 D단조', 'Sonatina in D minor', 'song', 'HWV 581', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나티나 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3beefebf-97ce-4502-b25a-eee395f9c622'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3beefebf-97ce-4502-b25a-eee395f9c622'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '소나티나 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3beefebf-97ce-4502-b25a-eee395f9c622'
);


-- HWV 582 소나티나 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나티나 G장조', 'Sonatina in G major', 'song', 'HWV 582', NULL, NULL, 1722, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나티나 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a416578-dda0-4889-a06c-c6bdaa84cbf7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3a416578-dda0-4889-a06c-c6bdaa84cbf7'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '소나티나 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a416578-dda0-4889-a06c-c6bdaa84cbf7'
);


-- HWV 583 소나티나 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나티나 G단조', 'Sonatina in G minor', 'song', 'HWV 583', NULL, NULL, 1722, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나티나 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d109224-dc27-4e41-99dc-2f9640eeaacd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d109224-dc27-4e41-99dc-2f9640eeaacd'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '소나티나 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d109224-dc27-4e41-99dc-2f9640eeaacd'
);


-- HWV 585 소나티나 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나티나 B♭장조', 'Sonatina in B♭ major', 'song', 'HWV 585', NULL, NULL, 1722, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나티나 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4ef961b-5832-4f14-8050-3d0103434335'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4ef961b-5832-4f14-8050-3d0103434335'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '소나티나 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4ef961b-5832-4f14-8050-3d0103434335'
);


-- HWV 586 토카타 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카타 G단조', 'Toccata in G minor', 'song', 'HWV 586', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카타 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be93320d-c4ea-4f6a-9f05-4ef724699006'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be93320d-c4ea-4f6a-9f05-4ef724699006'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '토카타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be93320d-c4ea-4f6a-9f05-4ef724699006'
);


-- HWV 605–610 6개의 푸가 HWV 605–610

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 푸가 HWV 605–610', '6 Fugues or Voluntaries, HWV 605–610', 'album', NULL, 'HWV', '605–610', 1718, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 푸가 HWV 605–610'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83464b53-6d1f-4f0a-809e-2a1566fc55fd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '83464b53-6d1f-4f0a-809e-2a1566fc55fd'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 푸가 HWV 605–610' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83464b53-6d1f-4f0a-809e-2a1566fc55fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e592b37e-2d4c-46cc-bc1e-55dd4b4285ff', 1, NULL, 'G단조', 'No. 1 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 푸가 HWV 605–610' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e592b37e-2d4c-46cc-bc1e-55dd4b4285ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4869bdf1-d70e-4807-8bf4-23585e8122a7', 2, NULL, 'G장조', 'No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 푸가 HWV 605–610' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4869bdf1-d70e-4807-8bf4-23585e8122a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:496901fb-d8b3-48bc-b415-d3e27eac5cc8', 3, NULL, 'B♭장조', 'No. 3 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 푸가 HWV 605–610' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:496901fb-d8b3-48bc-b415-d3e27eac5cc8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26654718-c80d-4860-92cd-fcb67464feed', 4, NULL, 'B단조', 'No. 4 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 푸가 HWV 605–610' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26654718-c80d-4860-92cd-fcb67464feed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12bbff69-742d-4f5d-adee-3e1580a1a328', 5, NULL, 'A단조', 'No. 5 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 푸가 HWV 605–610' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12bbff69-742d-4f5d-adee-3e1580a1a328'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cdc4c80-abc5-47ff-9a8c-824ff434deb7', 6, NULL, 'C단조', 'No. 6 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '6개의 푸가 HWV 605–610' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cdc4c80-abc5-47ff-9a8c-824ff434deb7'
);


-- HWV 611 푸가 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가 F장조', 'Fugue in F major', 'song', 'HWV 611', NULL, NULL, 1705, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64cddaf1-8e00-434b-8f11-74801486d6a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64cddaf1-8e00-434b-8f11-74801486d6a4'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '푸가 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64cddaf1-8e00-434b-8f11-74801486d6a4'
);


-- HWV 612 푸가 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가 E장조', 'Fugue in E major', 'song', 'HWV 612', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0baff678-7950-4424-b850-aa6033bd5adc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0baff678-7950-4424-b850-aa6033bd5adc'
FROM pieces p
WHERE p.composer_id = 6 AND p.title = '푸가 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0baff678-7950-4424-b850-aa6033bd5adc'
);

