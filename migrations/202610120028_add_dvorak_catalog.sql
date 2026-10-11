-- 드보르자크 작품을 출판 단위로 채운다(카탈로그: Op.·B.). 작품 173개(묶음 36, 다악장 53, 낱곡 84),
-- 새 작품 170개, 기존 작품 3개, part 463개, 그 아래 0개, 기존 낱곡 연결 1개.
--
-- 정한 것
--   작품번호가 있으면 Op., 없으면 B. 번호. 출판사가 겹쳐 붙인 번호는 B. 로만 둔다. 피아노판·관현악판은 한 작품(관현악판 MBID).
--   201 「유모레스크 7번」은 Op. 101 의 7번 part. 199 「슬라브 무곡 (1권, 2권)」은 두 권 합본이라 그대로 두고 Op. 46·72 는 새 묶음.
--   197 의 기존 MBID 는 피아노 편곡 work 라 원곡 work 를 식별자로 더한다.
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

-- B. 1 물망초 폴카 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '물망초 폴카 C장조', 'Forget-me-not Polka in C major', 'song', 'B. 1', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '물망초 폴카 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72f641e0-2492-4894-8e19-632f86106157'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72f641e0-2492-4894-8e19-632f86106157'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '물망초 폴카 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72f641e0-2492-4894-8e19-632f86106157'
);


-- B. 2bis 페르 페데스 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '페르 페데스 폴카', 'Per Pedes Polka', 'song', 'B. 2bis', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '페르 페데스 폴카'
);


-- B. 3 폴카 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 E장조', 'Polka in E major', 'song', 'B. 3', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8e0648a-41f7-4749-9c1b-d736f064fd0f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c8e0648a-41f7-4749-9c1b-d736f064fd0f'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '폴카 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8e0648a-41f7-4749-9c1b-d736f064fd0f'
);


-- Op. 1 현악 5중주 1번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 5중주 1번 A단조', 'String Quintet No. 1 in A minor', 'album', 'Op. 1', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 5중주 1번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ea2bc7a-a74d-4273-afc6-641c8c2b385e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7ea2bc7a-a74d-4273-afc6-641c8c2b385e'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 1번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ea2bc7a-a74d-4273-afc6-641c8c2b385e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcb69b3e-dda6-4692-8248-2e1abd3a1802', 1, 'I', 'Adagio. Allegro ma non troppo', 'I. Adagio. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 1번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcb69b3e-dda6-4692-8248-2e1abd3a1802'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfb66763-4425-4e16-bb98-17a5807f8511', 2, 'II', 'Lento', 'II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 1번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfb66763-4425-4e16-bb98-17a5807f8511'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10306121-58cd-452d-907c-b0adde353a10', 3, 'III', '피날레. Allegro con brio', 'III. Finale. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 1번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10306121-58cd-452d-907c-b0adde353a10'
);


-- Op. 2 현악 4중주 1번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 1번 A장조', 'String Quartet No. 1 in A major', 'album', 'Op. 2', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 1번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f46d4da-c88e-41b2-9287-4f04ae03080b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f46d4da-c88e-41b2-9287-4f04ae03080b'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f46d4da-c88e-41b2-9287-4f04ae03080b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaa6bb2d-e6e2-3305-8182-345cbcf886a2', 1, 'I', 'Andante – Allegro', 'I. Andante – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaa6bb2d-e6e2-3305-8182-345cbcf886a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:491ced25-aa57-34d6-8bed-93f260885c62', 2, 'II', 'Adagio affettuoso ed appassionato', 'II. Adagio affettuoso ed appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:491ced25-aa57-34d6-8bed-93f260885c62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64a25e31-72ac-37e5-bc2d-5685da8728d2', 3, 'III', 'Allegro scherzando – 트리오', 'III. Allegro scherzando – Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64a25e31-72ac-37e5-bc2d-5685da8728d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c745fd14-70bc-3a13-897b-e506021cf41b', 4, 'IV', '피날레. Allegro animato', 'IV. Finale. Allegro animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c745fd14-70bc-3a13-897b-e506021cf41b'
);


-- B. 9 교향곡 1번 C단조 "즐로니체의 종"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번 C단조 "즐로니체의 종"', 'Symphony No. 1 in C minor "The Bells of Zlonice"', 'album', 'B. 9', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번 C단조 "즐로니체의 종"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4fb9bc92-f2d1-40a1-a97a-331fbb594d49'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4fb9bc92-f2d1-40a1-a97a-331fbb594d49'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 1번 C단조 "즐로니체의 종"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4fb9bc92-f2d1-40a1-a97a-331fbb594d49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc84fd49-cc78-3ce3-a67b-c731a9f94ddf', 1, 'I', 'Maestoso – Allegro', 'I. Maestoso – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 1번 C단조 "즐로니체의 종"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc84fd49-cc78-3ce3-a67b-c731a9f94ddf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c98d0ff-3409-30c1-9cd1-62125c6ff976', 2, 'II', 'Adagio molto', 'II. Adagio molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 1번 C단조 "즐로니체의 종"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c98d0ff-3409-30c1-9cd1-62125c6ff976'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55cff963-9f26-3536-8ea3-919f55f7698d', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 1번 C단조 "즐로니체의 종"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55cff963-9f26-3536-8ea3-919f55f7698d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87cfd86f-b037-3323-bc5e-f59aa5f5f46d', 4, 'IV', '피날레. Allegro animato', 'IV. Finale. Allegro animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 1번 C단조 "즐로니체의 종"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87cfd86f-b037-3323-bc5e-f59aa5f5f46d'
);


-- B. 10 첼로 협주곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 협주곡 A장조', 'Cello Concerto in A major', 'album', 'B. 10', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 협주곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b32c9660-dde2-4943-a407-1b6f427bdc53'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b32c9660-dde2-4943-a407-1b6f427bdc53'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '첼로 협주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b32c9660-dde2-4943-a407-1b6f427bdc53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52f87660-a105-4728-bbfa-23ea09409e7d', 1, 'I', 'Andante, allegro non troppo', 'I. Andante, allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '첼로 협주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52f87660-a105-4728-bbfa-23ea09409e7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51fca320-777a-4724-9fbe-c836cb35976e', 2, 'II', 'Andante cantabile', 'II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '첼로 협주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51fca320-777a-4724-9fbe-c836cb35976e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dff61ee-934f-425e-8c20-636a74c627f9', 3, 'III', 'Allegro risoluto', 'III. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '첼로 협주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dff61ee-934f-425e-8c20-636a74c627f9'
);


-- B. 11 가곡집 <사이프러스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <사이프러스>', 'Cypresses', 'album', 'B. 11', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <사이프러스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29d8c2ed-5c12-416d-86a9-cde93da81a5d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '29d8c2ed-5c12-416d-86a9-cde93da81a5d'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29d8c2ed-5c12-416d-86a9-cde93da81a5d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b20d2083-b18b-4515-aa77-8f2ca02aa6fc', 1, NULL, 'Vy vroucí písně spějte', 'Vy vroucí písně spějte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b20d2083-b18b-4515-aa77-8f2ca02aa6fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86c96385-28b4-4c5a-99f6-a9b2ad0c6eb6', 2, NULL, 'V té sladké moci očí tvých', 'V té sladké moci očí tvých', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86c96385-28b4-4c5a-99f6-a9b2ad0c6eb6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c927724-0818-4b62-9db5-8c7088939e92', 3, NULL, 'V tak mnohém srdci mrtvo jest', 'V tak mnohém srdci mrtvo jest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c927724-0818-4b62-9db5-8c7088939e92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:663920b4-e858-478f-96ce-7be6318b5b91', 4, NULL, 'Ó duše drahá jedinká', 'Ó duše drahá jedinká', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:663920b4-e858-478f-96ce-7be6318b5b91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbb81ab2-e19d-462e-8ccc-af9b55f575d7', 5, NULL, 'Ó byl to krásný zlatý sen', 'Ó byl to krásný zlatý sen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbb81ab2-e19d-462e-8ccc-af9b55f575d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d909c73-816a-4272-b878-afc523153c8b', 6, NULL, 'Já vím, že v sladké naději', 'Já vím, že v sladké naději', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d909c73-816a-4272-b878-afc523153c8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbf156cd-b54b-4f67-ac28-23c6163b97f5', 7, NULL, 'Ó zlatá růže spanilá', 'Ó zlatá růže spanilá', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbf156cd-b54b-4f67-ac28-23c6163b97f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:963c034a-d2b6-45be-a8ca-04188038deac', 8, NULL, 'Ó naší lásce nekvete', 'Ó naší lásce nekvete', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:963c034a-d2b6-45be-a8ca-04188038deac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ded4fd57-26da-4bc0-bec7-d1bdda7cb156', 9, NULL, 'Kol domu se teď potácím', 'Kol domu se teď potácím', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ded4fd57-26da-4bc0-bec7-d1bdda7cb156'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f9e4c89-24c4-433a-b629-e58a83b56d09', 10, NULL, 'Mne často týrá pochyba', 'Mne často týrá pochyba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f9e4c89-24c4-433a-b629-e58a83b56d09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5d75ea4-0487-43fc-a62f-03d7a88a3d29', 11, NULL, 'Mé srdce často v bolesti', 'Mé srdce často v bolesti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5d75ea4-0487-43fc-a62f-03d7a88a3d29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6be2a6f6-469d-47ba-8c01-9837b0cb925f', 12, NULL, 'Zde hledím na ten drahý list', 'Zde hledím na ten drahý list', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6be2a6f6-469d-47ba-8c01-9837b0cb925f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa2703e1-9ed2-4fb3-adf8-dba87c6aa4e7', 13, NULL, 'Na horách ticho', 'Na horách ticho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa2703e1-9ed2-4fb3-adf8-dba87c6aa4e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ac2f396-e712-4370-adb7-89b6d9f5c26c', 14, NULL, 'Zde v lese u potoka', 'Zde v lese u potoka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ac2f396-e712-4370-adb7-89b6d9f5c26c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98952ce4-bb92-4dfa-b63c-00fe1be42230', 15, NULL, 'Mou celou duší zádumně', 'Mou celou duší zádumně', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98952ce4-bb92-4dfa-b63c-00fe1be42230'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf845f5d-2182-42af-b2c0-c8a49bbbb0e5', 16, NULL, 'Tam stojí stará skála', 'Tam stojí stará skála', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf845f5d-2182-42af-b2c0-c8a49bbbb0e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de12ad0d-dc5a-4553-92e4-2b6303596c1b', 17, NULL, 'Nad krajem vévodí lehký spánek', 'Nad krajem vévodí lehký spánek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de12ad0d-dc5a-4553-92e4-2b6303596c1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e483339d-9649-46b8-be73-5c0536bd1d9e', 18, NULL, 'Ty se ptáš, proč moje zpěvy bouří', 'Ty se ptáš, proč moje zpěvy bouří', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e483339d-9649-46b8-be73-5c0536bd1d9e'
);


-- Op. 4 교향곡 2번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번 B♭장조', 'Symphony No. 2 in B♭ major', 'album', 'Op. 4', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18dd95fa-2580-4fcd-8c3f-dbdf569074ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '18dd95fa-2580-4fcd-8c3f-dbdf569074ee'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18dd95fa-2580-4fcd-8c3f-dbdf569074ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9106c713-a04f-3ea6-ba3c-83b49b95fd25', 1, 'I', 'Allegro con moto', 'I. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9106c713-a04f-3ea6-ba3c-83b49b95fd25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33533614-5216-33b3-921e-6ae7cf9b1048', 2, 'II', 'Poco adagio', 'II. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33533614-5216-33b3-921e-6ae7cf9b1048'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40d24f86-4f98-3f91-a2b5-5f4c1849b05e', 3, 'III', '스케르초. Allegro con brio', 'III. Scherzo. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40d24f86-4f98-3f91-a2b5-5f4c1849b05e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca7d1add-1606-447f-af89-89f678b0dcc6', 4, 'IV', '피날레. Allegro con fuoco', 'IV. Finale. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca7d1add-1606-447f-af89-89f678b0dcc6'
);


-- B. 13 바리톤을 위한 2개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바리톤을 위한 2개의 가곡', '2 Songs for Baritone', 'song', 'B. 13', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바리톤을 위한 2개의 가곡'
);


-- B. 15 7개의 간주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '7개의 간주곡', '7 Interludes', 'album', 'B. 15', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '7개의 간주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c973370-35d1-4405-9136-f6d6b2343542'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5c973370-35d1-4405-9136-f6d6b2343542'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '7개의 간주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c973370-35d1-4405-9136-f6d6b2343542'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d8d0dc9-c372-4603-b980-8cb48bd70a7b', 1, NULL, '카프리치오. Allegro risoluto', 'No. 1: Capriccio. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '7개의 간주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d8d0dc9-c372-4603-b980-8cb48bd70a7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a24f39c-ef84-4632-bdeb-94f4ff9772c9', 2, NULL, 'Andante sostenuto', 'No. 2: Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '7개의 간주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a24f39c-ef84-4632-bdeb-94f4ff9772c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe4ec6f6-1e08-4365-9347-69e0afade99b', 3, NULL, 'Con molta espressione', 'No. 3: Con molta espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '7개의 간주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe4ec6f6-1e08-4365-9347-69e0afade99b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae430827-d834-4bfd-9c8a-2c40b74ee09f', 4, NULL, 'Allegro con brio', 'No. 4: Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '7개의 간주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae430827-d834-4bfd-9c8a-2c40b74ee09f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc6839a0-d284-4f82-a873-e9307b43b720', 5, NULL, 'Allegro assai', 'No. 5: Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '7개의 간주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc6839a0-d284-4f82-a873-e9307b43b720'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e926122-5d8e-48ac-a595-ba7bef8f8843', 6, NULL, '세레나타. Andantino con moto', 'No. 6: Serenata. Andantino con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '7개의 간주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e926122-5d8e-48ac-a595-ba7bef8f8843'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3513ec90-c0d1-401d-ae0f-a23ec019306f', 7, NULL, 'Allegro animato', 'No. 7: Allegro animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '7개의 간주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3513ec90-c0d1-401d-ae0f-a23ec019306f'
);


-- B. 15bis 플루트, 바이올린, 비올라와 트라이앵글을 위한 세레나데

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트, 바이올린, 비올라와 트라이앵글을 위한 세레나데', 'Serenade for Flute, Violin, Viola and Triangle', 'song', 'B. 15bis', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트, 바이올린, 비올라와 트라이앵글을 위한 세레나데'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4c1092f-a06b-4152-9b58-c83dfdd6ff9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c4c1092f-a06b-4152-9b58-c83dfdd6ff9c'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '플루트, 바이올린, 비올라와 트라이앵글을 위한 세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4c1092f-a06b-4152-9b58-c83dfdd6ff9c'
);


-- B. 16 오페라 <알프레드>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <알프레드>', 'Alfred', 'song', 'B. 16', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <알프레드>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24823f9c-b700-493e-9645-05a22df9aadf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '24823f9c-b700-493e-9645-05a22df9aadf'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '오페라 <알프레드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24823f9c-b700-493e-9645-05a22df9aadf'
);


-- B. 16a 비극적 서곡 B♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비극적 서곡 B♭단조', 'Tragic Overture in B♭ minor', 'song', 'B. 16a', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비극적 서곡 B♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '086ba24c-b151-403e-81b2-5e31b5f08f19'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '086ba24c-b151-403e-81b2-5e31b5f08f19'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '비극적 서곡 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '086ba24c-b151-403e-81b2-5e31b5f08f19'
);


-- B. 17 현악 4중주 2번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 2번 B♭장조', 'String Quartet No. 2 in B♭ major', 'album', 'B. 17', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 2번 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c428fc7-a533-4292-80c5-73c2565180d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c428fc7-a533-4292-80c5-73c2565180d5'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c428fc7-a533-4292-80c5-73c2565180d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9966a387-2e40-3c01-9ce5-91446891211c', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9966a387-2e40-3c01-9ce5-91446891211c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bce1b477-d21e-3b54-8d8f-835069ef3a0e', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bce1b477-d21e-3b54-8d8f-835069ef3a0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27ec36bf-2df2-307b-b87a-80559a22cb38', 3, 'III', 'Allegro con brio', 'III. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27ec36bf-2df2-307b-b87a-80559a22cb38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:275d7383-9107-3663-99ad-6d7e15230a5c', 4, 'IV', '피날레. Andante – Allegro giusto – Allegro con fuoco', 'IV. Finale. Andante – Allegro giusto – Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:275d7383-9107-3663-99ad-6d7e15230a5c'
);


-- B. 18 현악 4중주 3번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 3번 D장조', 'String Quartet No. 3 in D major', 'album', 'B. 18', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 3번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f47ad6e3-72f2-4fdc-84cd-a4edaf16d7eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f47ad6e3-72f2-4fdc-84cd-a4edaf16d7eb'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 3번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f47ad6e3-72f2-4fdc-84cd-a4edaf16d7eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f3573c9-edf8-3b40-9863-bc8b22cba281', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 3번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f3573c9-edf8-3b40-9863-bc8b22cba281'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20c585b5-f2d2-3424-b7b6-c45f7a8eaa7a', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 3번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20c585b5-f2d2-3424-b7b6-c45f7a8eaa7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2ec401a-51b0-337b-8880-935bbdec1b3d', 3, 'III', 'Allegro energico – 트리오', 'III. Allegro energico – Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 3번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2ec401a-51b0-337b-8880-935bbdec1b3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a94235a6-8f6b-3d7e-a16d-c0aaef802abd', 4, 'IV', '피날레. Allegretto', 'IV. Finale. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 3번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a94235a6-8f6b-3d7e-a16d-c0aaef802abd'
);


-- B. 19 현악 4중주 4번 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 4번 E단조', 'String Quartet No. 4 in E minor', 'album', 'B. 19', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 4번 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'baf2276f-d7c9-4448-9915-728d79675b8f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'baf2276f-d7c9-4448-9915-728d79675b8f'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 4번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'baf2276f-d7c9-4448-9915-728d79675b8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18edd581-2cc7-32ed-9d48-25ac2b8f9d31', 1, 'I', 'Velmi pohyblivě a rázně', 'I. Velmi pohyblivě a rázně (Assai con moto ed energico)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 4번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18edd581-2cc7-32ed-9d48-25ac2b8f9d31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7e79dc6-acf1-3ed7-9628-af82da751b25', 2, 'II', 'Andante religioso', 'II. Andante religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 4번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7e79dc6-acf1-3ed7-9628-af82da751b25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:389619d4-0199-3c44-aa71-24005cfcc63d', 3, 'III', 'Allegro con brio', 'III. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 4번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:389619d4-0199-3c44-aa71-24005cfcc63d'
);


-- B. 21 오페라 <왕과 숯장이> (1871)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <왕과 숯장이> (1871)', 'King and Charcoal Burner (first setting, 1871)', 'song', 'B. 21', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <왕과 숯장이> (1871)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82169094-2974-4128-bbc2-5fafa1419166'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82169094-2974-4128-bbc2-5fafa1419166'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '오페라 <왕과 숯장이> (1871)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82169094-2974-4128-bbc2-5fafa1419166'
);


-- B. 21a 연주회용 서곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연주회용 서곡 F장조', 'Concert Overture in F major', 'song', 'B. 21a', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연주회용 서곡 F장조'
);


-- B. 23 엘리슈카 크라스노호르스카의 시에 의한 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '엘리슈카 크라스노호르스카의 시에 의한 가곡', 'Songs on Words by Eliška Krásnohorská', 'song', 'B. 23', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '엘리슈카 크라스노호르스카의 시에 의한 가곡'
);


-- B. 24 가곡 <Sirotek>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Sirotek>', 'Sirotek (The Orphan)', 'song', 'B. 24', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Sirotek>'
);


-- B. 24bis 가곡 <Rozmarýna>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Rozmarýna>', 'Rozmarýna (Rosmarine)', 'song', 'B. 24bis', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Rozmarýna>'
);


-- Op. 30 찬가 <백산의 후예들>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬가 <백산의 후예들>', 'Hymnus: The Heirs of the White Mountain', 'song', 'Op. 30', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬가 <백산의 후예들>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9994728f-36f1-4520-8221-956e6fbabfa9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9994728f-36f1-4520-8221-956e6fbabfa9'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '찬가 <백산의 후예들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9994728f-36f1-4520-8221-956e6fbabfa9'
);


-- Op. 5 피아노 5중주 1번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 5중주 1번 A장조', 'Piano Quintet No. 1 in A major', 'album', 'Op. 5', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 5중주 1번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c57b631a-2d9f-4cca-8a85-0ca11d8fd66b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c57b631a-2d9f-4cca-8a85-0ca11d8fd66b'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 5중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c57b631a-2d9f-4cca-8a85-0ca11d8fd66b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8a6541b-f4fb-4217-b132-112d63fe993e', 1, 'I', 'Allegro, ma non troppo', 'I. Allegro, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 5중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8a6541b-f4fb-4217-b132-112d63fe993e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8dab64d-1113-4fe2-bd55-12e043f046ca', 2, 'II', 'Andante sostenuto', 'II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 5중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8dab64d-1113-4fe2-bd55-12e043f046ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d5b2fc3-f8ce-40c1-8df4-cd64270df900', 3, 'III', '피날레. Allegro con brio', 'III. Finale. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 5중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d5b2fc3-f8ce-40c1-8df4-cd64270df900'
);


-- Op. 6 세르비아 민요시에 의한 4개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세르비아 민요시에 의한 4개의 가곡', '4 Songs on Serbian Folk Poems', 'song', 'Op. 6', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세르비아 민요시에 의한 4개의 가곡'
);


-- Op. 7 가곡집 <드부르 크랄로베 필사본의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <드부르 크랄로베 필사본의 노래>', 'Songs from the "Dvůr Králové" Manuscript', 'album', 'Op. 7', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <드부르 크랄로베 필사본의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a1cbf7f-42fc-4e78-9b35-1db5c5a056dd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8a1cbf7f-42fc-4e78-9b35-1db5c5a056dd'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <드부르 크랄로베 필사본의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a1cbf7f-42fc-4e78-9b35-1db5c5a056dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66afe776-8f49-4517-80a3-01bb70d7be26', 1, NULL, 'Kytice', 'The Flowery Message', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <드부르 크랄로베 필사본의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66afe776-8f49-4517-80a3-01bb70d7be26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0238679-1702-4e51-bccf-75864d32f87d', 2, NULL, 'Róže', 'Rosebud', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <드부르 크랄로베 필사본의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0238679-1702-4e51-bccf-75864d32f87d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6436d2af-d40f-4632-b807-a0733fc92c38', 3, NULL, 'Zezhulice', 'The Cuckoo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <드부르 크랄로베 필사본의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6436d2af-d40f-4632-b807-a0733fc92c38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ec67b79-701b-446c-a243-7798d5ca75a0', 4, NULL, 'Skřivánek', 'The Lark', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <드부르 크랄로베 필사본의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ec67b79-701b-446c-a243-7798d5ca75a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59deb90b-013a-46d6-b5a3-b19c7d6bc031', 5, NULL, 'Opuštěná', 'The Forsaken Maiden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <드부르 크랄로베 필사본의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59deb90b-013a-46d6-b5a3-b19c7d6bc031'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea508654-ed2a-40ad-b1c9-55cd96e9d5ef', 6, NULL, 'Jahody', 'Strawberries', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <드부르 크랄로베 필사본의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea508654-ed2a-40ad-b1c9-55cd96e9d5ef'
);


-- B. 31 녹턴 <5월의 밤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 <5월의 밤>', 'Nocturne "May Night"', 'song', 'B. 31', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 <5월의 밤>'
);


-- Op. 10 교향곡 3번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 3번 E♭장조', 'Symphony No. 3 in E♭ major', 'album', 'Op. 10', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 3번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1646c720-3287-4aa1-8dad-a80b840eacdf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1646c720-3287-4aa1-8dad-a80b840eacdf'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 3번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1646c720-3287-4aa1-8dad-a80b840eacdf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6454401d-ac89-48c0-8cec-f900594613bd', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 3번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6454401d-ac89-48c0-8cec-f900594613bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08a061cc-ae59-44ea-8bf1-bbe18d8ae16a', 2, 'II', 'Adagio molto, tempo di marcia', 'II. Adagio molto, tempo di marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 3번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08a061cc-ae59-44ea-8bf1-bbe18d8ae16a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7fa0d39-86e0-4c0c-90bd-9bc859865fb6', 3, 'III', '피날레. Allegro vivace', 'III. Finale. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 3번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7fa0d39-86e0-4c0c-90bd-9bc859865fb6'
);


-- Op. 9 현악 4중주 5번 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 5번 F단조', 'String Quartet No. 5 in F minor', 'album', 'Op. 9', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 5번 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9942ce7a-6f7a-4aee-8bcc-fe0dc081629b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9942ce7a-6f7a-4aee-8bcc-fe0dc081629b'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 5번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9942ce7a-6f7a-4aee-8bcc-fe0dc081629b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29ebc308-54c7-3883-b61d-767e1e4faba7', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 5번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29ebc308-54c7-3883-b61d-767e1e4faba7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9448c4aa-1e22-324f-a42d-4c51ffd36b54', 2, 'II', 'Andante con moto quasi allegretto', 'II. Andante con moto quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 5번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9448c4aa-1e22-324f-a42d-4c51ffd36b54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b76444a-39a1-3d82-80ea-d93a13b682ca', 3, 'III', 'Tempo di valse', 'III. Tempo di valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 5번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b76444a-39a1-3d82-80ea-d93a13b682ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59166e7a-3966-364f-9e00-34bd4f3240e4', 4, 'IV', '피날레. Allegro molto', 'IV. Finale. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 5번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59166e7a-3966-364f-9e00-34bd4f3240e4'
);


-- Op. 11 로망스 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 F단조', 'Romance in F minor', 'song', 'Op. 11', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54b5e409-6521-311d-a28c-7bb764e4aa4e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '54b5e409-6521-311d-a28c-7bb764e4aa4e'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '로망스 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54b5e409-6521-311d-a28c-7bb764e4aa4e'
);


-- Op. 12 현악 4중주 6번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 6번 A단조', 'String Quartet No. 6 in A minor', 'album', 'Op. 12', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 6번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc887ac4-7cab-49ca-8435-989ea6e92529'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc887ac4-7cab-49ca-8435-989ea6e92529'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 6번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc887ac4-7cab-49ca-8435-989ea6e92529'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ee16a29-5291-3c03-9816-9f00685204b0', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 6번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ee16a29-5291-3c03-9816-9f00685204b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9235f7c-9a2c-322b-ab8d-03239a9771e5', 2, 'II', 'Poco allegro', 'II. Poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 6번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9235f7c-9a2c-322b-ab8d-03239a9771e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55d599f6-c719-3a39-86a7-5263f65e793a', 3, 'III', 'Poco adagio', 'III. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 6번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55d599f6-c719-3a39-86a7-5263f65e793a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e1de001-1fa9-3a32-8ff7-ef542bc8b3de', 4, 'IV', '피날레. Allegro molto', 'IV. Finale. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 6번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e1de001-1fa9-3a32-8ff7-ef542bc8b3de'
);


-- B. 40a 안단테 아파시오나토 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 아파시오나토 F장조', 'Andante appassionato in F major', 'song', 'B. 40a', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 아파시오나토 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '503f27fe-6e56-415e-b7be-f7bb2b351373'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '503f27fe-6e56-415e-b7be-f7bb2b351373'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '안단테 아파시오나토 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '503f27fe-6e56-415e-b7be-f7bb2b351373'
);


-- Op. 13 교향곡 4번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 4번 D단조', 'Symphony No. 4 in D minor', 'album', 'Op. 13', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 4번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2c9ff21-f234-43af-9f1a-9ded1b808098'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f2c9ff21-f234-43af-9f1a-9ded1b808098'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2c9ff21-f234-43af-9f1a-9ded1b808098'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88d4d150-99bd-47af-9a55-0bf510ba9aaf', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88d4d150-99bd-47af-9a55-0bf510ba9aaf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b55ae68-42ad-4d66-82f0-eade4b29644a', 2, 'II', 'Andante sostenuto e molto cantabile', 'II. Andante sostenuto e molto cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b55ae68-42ad-4d66-82f0-eade4b29644a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bda52fa-c9e0-4c6c-ad4c-2c5828e0297d', 3, 'III', '스케르초 (Allegro feroce)', 'III. Scherzo (Allegro feroce)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bda52fa-c9e0-4c6c-ad4c-2c5828e0297d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43551681-9e94-4dc5-add0-5ee9063b1b49', 4, 'IV', '피날레. Allegro con brio', 'IV. Finale. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43551681-9e94-4dc5-add0-5ee9063b1b49'
);


-- Op. 14 오페라 <왕과 숯장이>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <왕과 숯장이>', 'King and Charcoal Burner', 'song', 'Op. 14', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <왕과 숯장이>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9010422-cda4-4e55-a12a-987e2b50b06f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd9010422-cda4-4e55-a12a-987e2b50b06f'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '오페라 <왕과 숯장이>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9010422-cda4-4e55-a12a-987e2b50b06f'
);


-- B. 44 광시곡 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '광시곡 A단조', 'Symphonic Poem (Rhapsody) in A minor', 'song', 'B. 44', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '광시곡 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a45d8ba-0662-4ca9-b8d8-d473c574441c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6a45d8ba-0662-4ca9-b8d8-d473c574441c'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '광시곡 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a45d8ba-0662-4ca9-b8d8-d473c574441c'
);


-- Op. 16 현악 4중주 7번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 7번 A단조', 'String Quartet No. 7 in A minor', 'album', 'Op. 16', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 7번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85045d13-8c85-49c0-85a4-079cbffaf85f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '85045d13-8c85-49c0-85a4-079cbffaf85f'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 7번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85045d13-8c85-49c0-85a4-079cbffaf85f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0be09aa-ef15-3e4a-b11d-a9d3f0fe7486', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 7번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0be09aa-ef15-3e4a-b11d-a9d3f0fe7486'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f750a95-7233-3b61-99e8-1991a6cd5e66', 2, 'II', 'Andante cantabile', 'II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 7번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f750a95-7233-3b61-99e8-1991a6cd5e66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0934f30c-557e-3656-b112-7fb127961b4c', 3, 'III', 'Allegro scherzando – 트리오', 'III. Allegro scherzando – Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 7번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0934f30c-557e-3656-b112-7fb127961b4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f84f94d-4e47-3cce-b56a-8966487ce44e', 4, 'IV', 'Allegro ma non troppo', 'IV. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 7번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f84f94d-4e47-3cce-b56a-8966487ce44e'
);


-- Op. 17 오페라 <고집쟁이 연인들>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <고집쟁이 연인들>', 'The Stubborn Lovers', 'song', 'Op. 17', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <고집쟁이 연인들>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5e2fe04-aba7-499d-8728-61de3fdcccbd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5e2fe04-aba7-499d-8728-61de3fdcccbd'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '오페라 <고집쟁이 연인들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5e2fe04-aba7-499d-8728-61de3fdcccbd'
);


-- Op. 40 녹턴 B장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 B장조', 'Nocturne in B major', 'song', 'Op. 40', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 B장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11cb043f-4bcf-4287-9e17-1c2e36033d17'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '11cb043f-4bcf-4287-9e17-1c2e36033d17'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '녹턴 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11cb043f-4bcf-4287-9e17-1c2e36033d17'
);


-- Op. 77 현악 5중주 2번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 5중주 2번 G장조', 'String Quintet No. 2 in G major', 'album', 'Op. 77', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 5중주 2번 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'def7fe0c-1a28-4e55-8866-2b12a74ccaaa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'def7fe0c-1a28-4e55-8866-2b12a74ccaaa'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'def7fe0c-1a28-4e55-8866-2b12a74ccaaa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e893e5ac-e22a-4a60-a28c-51ec901b81af', 1, 'I', 'Allegro con fuoco', 'I. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e893e5ac-e22a-4a60-a28c-51ec901b81af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f778c12-0efc-4447-b165-0753316d0566', 2, 'II', '스케르초', 'II. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f778c12-0efc-4447-b165-0753316d0566'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b09333b6-85ea-489d-9b9c-e85a7128a40e', 3, 'III', 'Poco andante', 'III. Poco andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b09333b6-85ea-489d-9b9c-e85a7128a40e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97278946-7440-4170-a1e0-8af1e7f38b7e', 4, 'IV', 'Allegro assai', 'IV. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97278946-7440-4170-a1e0-8af1e7f38b7e'
);


-- Op. 20 모라비아 2중창 Op. 20

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모라비아 2중창 Op. 20', 'Moravian Duets, Op. 20', 'album', NULL, 'Op.', '20', 1875, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모라비아 2중창 Op. 20'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed61d235-993d-4247-a469-da8a98b3a8e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed61d235-993d-4247-a469-da8a98b3a8e8'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed61d235-993d-4247-a469-da8a98b3a8e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8f127a8-952a-43b1-8242-7fcc48c327d6', 1, NULL, 'Proměny', 'Proměny (Darmo sa ty trápíš)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8f127a8-952a-43b1-8242-7fcc48c327d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:dvorak:dvorak-op20:2', 2, NULL, 'Zatoč se mně, galanečko', 'Zatoč se mně, galanečko', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:dvorak:dvorak-op20:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73f6c16e-471f-464a-ac44-2087f7721f72', 3, NULL, 'Chudoba', 'Chudoba (Ach, co je to za slavíček)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73f6c16e-471f-464a-ac44-2087f7721f72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:550515a0-771d-4955-93f3-86b492fc95c8', 4, NULL, 'Vuře šohaj, vuře', 'Vuře šohaj, vuře', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:550515a0-771d-4955-93f3-86b492fc95c8'
);


-- Op. 21 피아노 3중주 1번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 1번 B♭장조', 'Piano Trio No. 1 in B♭ major', 'album', 'Op. 21', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 1번 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56460ca4-5ba9-4bea-a1f7-d7211368d7fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56460ca4-5ba9-4bea-a1f7-d7211368d7fb'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56460ca4-5ba9-4bea-a1f7-d7211368d7fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f4a5872-ef71-48d7-8c87-a7d838ccdf3e', 1, 'I', 'Allegro molto', 'I. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f4a5872-ef71-48d7-8c87-a7d838ccdf3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06a84d21-048c-4dab-9501-46b5b7cb2b69', 2, 'II', 'Adagio molto e mesto', 'II. Adagio molto e mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06a84d21-048c-4dab-9501-46b5b7cb2b69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27a9c233-091d-4f3a-93b6-e9351b36792b', 3, 'III', 'Allegretto scherzando', 'III. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27a9c233-091d-4f3a-93b6-e9351b36792b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6702e8d3-a166-46f2-b145-e609d90a538d', 4, 'IV', 'Allegro vivace', 'IV. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 1번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6702e8d3-a166-46f2-b145-e609d90a538d'
);


-- Op. 22 현악 세레나데 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 세레나데 E장조', 'Serenade for Strings in E major', 'album', 'Op. 22', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 세레나데 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d5dc9a2-633a-3b03-ad47-5bef2ebfa561'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9d5dc9a2-633a-3b03-ad47-5bef2ebfa561'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 세레나데 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d5dc9a2-633a-3b03-ad47-5bef2ebfa561'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fff788d-a789-3771-9ee9-5b84b24d4172', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 세레나데 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fff788d-a789-3771-9ee9-5b84b24d4172'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcceef17-1dd6-3b66-8207-719e734b666a', 2, 'II', 'Tempo di valse', 'II. Tempo di valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 세레나데 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcceef17-1dd6-3b66-8207-719e734b666a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df43ae54-07fd-3058-b259-e541de0ae244', 3, 'III', '스케르초. Vivace', 'III. Scherzo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 세레나데 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df43ae54-07fd-3058-b259-e541de0ae244'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e8c486b-1127-3c09-af68-2db30dbacc08', 4, 'IV', 'Larghetto', 'IV. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 세레나데 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e8c486b-1127-3c09-af68-2db30dbacc08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:653c55ef-bfef-3908-a962-b23b6e0cb89b', 5, 'V', '피날레. Allegro vivace', 'V. Finale. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 세레나데 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:653c55ef-bfef-3908-a962-b23b6e0cb89b'
);


-- Op. 23 피아노 4중주 1번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 4중주 1번 D장조', 'Piano Quartet No. 1 in D major', 'album', 'Op. 23', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 4중주 1번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a80e1f46-4548-467c-bab5-da81d2a0c758'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a80e1f46-4548-467c-bab5-da81d2a0c758'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 4중주 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a80e1f46-4548-467c-bab5-da81d2a0c758'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7e865df-5c27-4494-82e7-e57597d1492f', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 4중주 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7e865df-5c27-4494-82e7-e57597d1492f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdbdaada-5e9e-4dea-88f8-585a770389d5', 2, 'II', '주제와 변주. Andantino', 'II. Theme (Andantino) and Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 4중주 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdbdaada-5e9e-4dea-88f8-585a770389d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e15b338-ee95-4404-889b-347fdaa7ace1', 3, 'III', '피날레. Allegretto scherzando', 'III. Finale. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 4중주 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e15b338-ee95-4404-889b-347fdaa7ace1'
);


-- Op. 76 교향곡 5번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 5번 F장조', 'Symphony No. 5 in F major', 'album', 'Op. 76', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 5번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b26ec6f1-c573-4f76-b53e-03c5a2d222b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b26ec6f1-c573-4f76-b53e-03c5a2d222b7'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 5번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b26ec6f1-c573-4f76-b53e-03c5a2d222b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5e79871-2a1e-39be-ab5a-18c85cef186b', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 5번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5e79871-2a1e-39be-ab5a-18c85cef186b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27c359c2-2c52-3e73-8725-33fd436d05c3', 2, 'II', 'Andante con moto', 'II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 5번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27c359c2-2c52-3e73-8725-33fd436d05c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b71ce6d5-5cd4-3994-b343-0df9624aaabc', 3, 'III', 'Andante con moto, quasi l''istesso tempo – Allegro scherzando', 'III. Andante con moto, quasi l''istesso tempo – Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 5번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b71ce6d5-5cd4-3994-b343-0df9624aaabc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c749f03-e02c-37e1-9275-be0fe1a1475b', 4, 'IV', '피날레. Allegro molto', 'IV. Finale. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 5번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c749f03-e02c-37e1-9275-be0fe1a1475b'
);


-- Op. 25 오페라 <반다>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <반다>', 'Vanda', 'song', 'Op. 25', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <반다>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a6d298c-f77b-4dec-a0f4-b8f1b4e3feff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a6d298c-f77b-4dec-a0f4-b8f1b4e3feff'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '오페라 <반다>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a6d298c-f77b-4dec-a0f4-b8f1b4e3feff'
);


-- Op. 26 피아노 3중주 2번 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 2번 G단조', 'Piano Trio No. 2 in G minor', 'album', 'Op. 26', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 2번 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a25d45f-c3ee-4eab-bd04-7752ed47ccf6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7a25d45f-c3ee-4eab-bd04-7752ed47ccf6'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a25d45f-c3ee-4eab-bd04-7752ed47ccf6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91347292-2f1c-4394-861a-08bf3beccb6b', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91347292-2f1c-4394-861a-08bf3beccb6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaeae47d-7060-41da-8f57-f9dbb4bad17a', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaeae47d-7060-41da-8f57-f9dbb4bad17a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b7643ef-6e73-4e74-bce8-c3fb67b28cf9', 3, 'III', '스케르초. Presto – 트리오. Poco meno mosso – Presto da capo', 'III. Scherzo. Presto – Trio. Poco meno mosso – Presto da capo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b7643ef-6e73-4e74-bce8-c3fb67b28cf9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4845de12-5690-41a8-ab79-7525ae7c5dfe', 4, 'IV', 'Allegro non tanto', 'IV. Allegro non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4845de12-5690-41a8-ab79-7525ae7c5dfe'
);


-- Op. 80 현악 4중주 8번 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 8번 E장조', 'String Quartet No. 8 in E major', 'album', 'Op. 80', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 8번 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c255949d-bea7-47ae-8da4-fc251a74f99c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c255949d-bea7-47ae-8da4-fc251a74f99c'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 8번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c255949d-bea7-47ae-8da4-fc251a74f99c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fbaf565-7d6f-46d5-b957-85054c79f9fd', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 8번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fbaf565-7d6f-46d5-b957-85054c79f9fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8588ff0-dfd2-4d13-a3ad-0d00b069aa2c', 2, 'II', 'Andante con moto', 'II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 8번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8588ff0-dfd2-4d13-a3ad-0d00b069aa2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66e4122a-34f1-4d5e-a85e-7ed7c7d080e7', 3, 'III', 'Allegro scherzando', 'III. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 8번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66e4122a-34f1-4d5e-a85e-7ed7c7d080e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efbb7235-bd4b-42df-9b8b-c81b7bc167c8', 4, 'IV', '피날레. Allegro con brio', 'IV. Finale. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 8번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efbb7235-bd4b-42df-9b8b-c81b7bc167c8'
);


-- Op. 28 미뉴에트 Op. 28

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 Op. 28', '2 Minuets, Op. 28', 'album', NULL, 'Op.', '28', 1876, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 Op. 28'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f54dd85-6d0f-4a84-98bc-043f7347611d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f54dd85-6d0f-4a84-98bc-043f7347611d'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미뉴에트 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f54dd85-6d0f-4a84-98bc-043f7347611d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a53a59f6-2662-4c7b-b0ac-d022fff564ef', 1, NULL, 'A♭장조', 'No. 1 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미뉴에트 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a53a59f6-2662-4c7b-b0ac-d022fff564ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95924137-466e-447a-a17e-87f034403fde', 2, NULL, 'F장조', 'No. 2 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미뉴에트 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95924137-466e-447a-a17e-87f034403fde'
);


-- Op. 29 혼성 합창곡 Op. 29

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '혼성 합창곡 Op. 29', '4 Choruses for Mixed Voices, Op. 29', 'album', NULL, 'Op.', '29', 1876, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '혼성 합창곡 Op. 29'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59323216-9a57-4ce3-b0a0-0eeb683b135e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '59323216-9a57-4ce3-b0a0-0eeb683b135e'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '혼성 합창곡 Op. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59323216-9a57-4ce3-b0a0-0eeb683b135e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e87525a-02cf-44a4-9114-95bcfdbfbe39', 1, NULL, 'Místo klekání', 'Místo klekání', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '혼성 합창곡 Op. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e87525a-02cf-44a4-9114-95bcfdbfbe39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:385d7218-8184-49ec-8965-fbd4650b2741', 2, NULL, 'Ukolébavka', 'Ukolébavka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '혼성 합창곡 Op. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:385d7218-8184-49ec-8965-fbd4650b2741'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abe14cd6-a499-40d7-85e0-adfc2d9f8183', 3, NULL, 'Nepovím', 'Nepovím', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '혼성 합창곡 Op. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abe14cd6-a499-40d7-85e0-adfc2d9f8183'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8badaa5e-1808-4107-af68-e4ec631b4641', 4, NULL, 'Opuštěný', 'Opuštěný', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '혼성 합창곡 Op. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8badaa5e-1808-4107-af68-e4ec631b4641'
);


-- Op. 32 모라비아 2중창 Op. 32

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모라비아 2중창 Op. 32', 'Moravian Duets, Op. 32', 'album', NULL, 'Op.', '32', 1876, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모라비아 2중창 Op. 32'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ab6710d-77f3-48dd-9bea-de0ffe86a0ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ab6710d-77f3-48dd-9bea-de0ffe86a0ea'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ab6710d-77f3-48dd-9bea-de0ffe86a0ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7b35cfb-7837-4493-85a7-413befab3200', 1, NULL, 'A já ti uplynu', 'A já ti uplynu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7b35cfb-7837-4493-85a7-413befab3200'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00f823d1-ba2c-4fcf-a5b7-8aba31ff28bf', 2, NULL, 'Veleť, vtáčku', 'Veleť, vtáčku', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00f823d1-ba2c-4fcf-a5b7-8aba31ff28bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0282bde-3fc7-48e7-973a-dd2abb50c59a', 3, NULL, 'Dyby byla kosa nabróšená', 'Dyby byla kosa nabróšená', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0282bde-3fc7-48e7-973a-dd2abb50c59a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5fb2efe-b10e-4382-9d9e-28701501ab39', 4, NULL, 'V dobrým sme se sešli', 'V dobrým sme se sešli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5fb2efe-b10e-4382-9d9e-28701501ab39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa0520f4-03a2-4651-a68d-1e0955ac7d62', 5, NULL, 'Slavíkovský polečko malý', 'Slavíkovský polečko malý', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa0520f4-03a2-4651-a68d-1e0955ac7d62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5857a31b-cfdd-4092-ab91-994ed582bad0', 6, NULL, 'Holub na javoře', 'Holub na javoře', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5857a31b-cfdd-4092-ab91-994ed582bad0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:919b8e99-662c-41df-8cad-032150190bc8', 7, NULL, 'Voda a pláč', 'Voda a pláč', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:919b8e99-662c-41df-8cad-032150190bc8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d06f7fc-8bbe-436e-8584-43394dade310', 8, NULL, 'Skromná', 'Skromná', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d06f7fc-8bbe-436e-8584-43394dade310'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e106682-79b2-43c4-a23c-c0b6e320b774', 9, NULL, 'Prsten', 'Prsten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e106682-79b2-43c4-a23c-c0b6e320b774'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bee616ce-f02d-4f31-b4ec-a69dd6dfe0bb', 10, NULL, 'Zelenaj se, zelenaj', 'Zelenaj se, zelenaj', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bee616ce-f02d-4f31-b4ec-a69dd6dfe0bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:443bf7a4-c7e8-47f5-92cc-42ea97be484e', 11, NULL, 'Zajatá', 'Zajatá', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:443bf7a4-c7e8-47f5-92cc-42ea97be484e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8210161d-afa4-4380-a54d-8ea79ac77996', 12, NULL, 'Neveta', 'Neveta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8210161d-afa4-4380-a54d-8ea79ac77996'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a79ab8ae-e490-46c2-88ed-d4659cb15c9f', 13, NULL, 'Šípek', 'Šípek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a79ab8ae-e490-46c2-88ed-d4659cb15c9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a2f99ab-d41f-41d6-a2b0-ccec27c57e12', 14, NULL, 'Život vojenský', 'Život vojenský', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a2f99ab-d41f-41d6-a2b0-ccec27c57e12'
);


-- B. 61 가곡집 <저녁 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <저녁 노래>', 'Evening Songs', 'album', 'B. 61', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <저녁 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f6d9d1e-d62f-472f-8a0f-3c071389862a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f6d9d1e-d62f-472f-8a0f-3c071389862a'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f6d9d1e-d62f-472f-8a0f-3c071389862a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:117245b3-f431-423d-8687-0c80a356aa60', 1, NULL, 'Ty hvězdičky tam na nebi', 'Ty hvězdičky tam na nebi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:117245b3-f431-423d-8687-0c80a356aa60'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbd0d8f7-52d6-4cea-ab72-5dbf4d2fab51', 2, NULL, 'Mně zdálo se, žes umřela', 'Mně zdálo se, žes umřela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbd0d8f7-52d6-4cea-ab72-5dbf4d2fab51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:440946aa-73dc-48cf-aca6-f8ccb691633e', 3, NULL, 'Já jsem ten rytíř z pohádky', 'Já jsem ten rytíř z pohádky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:440946aa-73dc-48cf-aca6-f8ccb691633e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2422353-7621-43dd-adaf-e7edceac66a4', 4, NULL, 'Když bůh byl nejvíc rozkochán', 'Když bůh byl nejvíc rozkochán', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2422353-7621-43dd-adaf-e7edceac66a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6b00134-6e48-4aad-a516-08f1c334cf02', 5, NULL, 'Umlklo stromů šumění', 'Umlklo stromů šumění', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6b00134-6e48-4aad-a516-08f1c334cf02'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ed34f6b-f306-4ffa-8805-0642db322d18', 6, NULL, 'Přilítlo jaro zdaleka', 'Přilítlo jaro zdaleka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ed34f6b-f306-4ffa-8805-0642db322d18'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb8a7134-b9f6-470c-bbb2-2c0bbc8580a2', 7, NULL, 'Když jsem se díval do nebe', 'Když jsem se díval do nebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb8a7134-b9f6-470c-bbb2-2c0bbc8580a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:558e6816-17c9-4ec8-86fb-05423a13b1f6', 8, NULL, 'Vy malí, drobní ptáčkové', 'Vy malí, drobní ptáčkové', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:558e6816-17c9-4ec8-86fb-05423a13b1f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e443c008-2a17-4b5f-9112-dd812973abeb', 9, NULL, 'Jsem jako lípa košatá', 'Jsem jako lípa košatá', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e443c008-2a17-4b5f-9112-dd812973abeb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e734012-e113-4285-8a68-464f7c299804', 10, NULL, 'Vy všichni, kdo jste stísněni', 'Vy všichni, kdo jste stísněni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e734012-e113-4285-8a68-464f7c299804'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecdbf987-63af-44ce-b07e-7e96d9b58818', 11, NULL, 'Ten ptáček', 'Ten ptáček', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecdbf987-63af-44ce-b07e-7e96d9b58818'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8706b80-1a6f-41a5-91e2-5658f1096139', 12, NULL, 'Tak jak ten měsíc', 'Tak jak ten měsíc', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8706b80-1a6f-41a5-91e2-5658f1096139'
);


-- Op. 33 피아노 협주곡 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 G단조', 'Piano Concerto in G minor', 'album', 'Op. 33', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fd0b2ff-4f8b-4d98-bc41-5c1bfb3ac428'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3fd0b2ff-4f8b-4d98-bc41-5c1bfb3ac428'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 협주곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fd0b2ff-4f8b-4d98-bc41-5c1bfb3ac428'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:655f0b42-05b3-3c23-a1a0-7635aa241f40', 1, 'I', 'Allegro agitato', 'I. Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 협주곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:655f0b42-05b3-3c23-a1a0-7635aa241f40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9df6d1c8-df76-3ce6-b6ca-e640b5eab766', 2, 'II', 'Andante sostenuto', 'II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 협주곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9df6d1c8-df76-3ce6-b6ca-e640b5eab766'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e158b2d-3898-3933-90f9-20694165e7c1', 3, 'III', '피날레. Allegro con fuoco', 'III. Finale. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 협주곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e158b2d-3898-3933-90f9-20694165e7c1'
);


-- Op. 35 둠카 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '둠카 D단조', 'Dumka in D minor', 'song', 'Op. 35', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '둠카 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a43b61b-8af4-4e41-800f-447ac759ea71'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a43b61b-8af4-4e41-800f-447ac759ea71'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '둠카 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a43b61b-8af4-4e41-800f-447ac759ea71'
);


-- Op. 36 주제와 변주 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '주제와 변주 A♭장조', 'Theme and Variations in A♭ major', 'song', 'Op. 36', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '주제와 변주 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b875948f-0f3d-4ee2-be2f-ff980c4c8e9a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b875948f-0f3d-4ee2-be2f-ff980c4c8e9a'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '주제와 변주 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b875948f-0f3d-4ee2-be2f-ff980c4c8e9a'
);


-- B. 66 남성 합창곡 B. 66

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 B. 66', '3 Choral Songs for Male Voices, B. 66', 'album', NULL, 'B.', '66', 1877, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 B. 66'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43a8626b-3865-4b8f-aeb2-8fb24c4253d1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '43a8626b-3865-4b8f-aeb2-8fb24c4253d1'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡 B. 66' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43a8626b-3865-4b8f-aeb2-8fb24c4253d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c819c320-acb9-45ce-a12a-dbd78a12e39f', 1, NULL, 'Převozníček', 'Převozníček', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡 B. 66' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c819c320-acb9-45ce-a12a-dbd78a12e39f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e366615c-e48d-4bbb-8c90-a4d2c756cf8c', 2, NULL, 'Milenka travička', 'Milenka travička', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡 B. 66' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e366615c-e48d-4bbb-8c90-a4d2c756cf8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39919396-d293-40dc-99d2-af85c279954a', 3, NULL, 'Huslař', 'Huslař', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡 B. 66' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39919396-d293-40dc-99d2-af85c279954a'
);


-- Op. 37 오페라 <교활한 농부>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <교활한 농부>', 'The Cunning Peasant', 'song', 'Op. 37', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <교활한 농부>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9b2e256-cd22-4f1b-b3bc-5f1f4cd2762d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9b2e256-cd22-4f1b-b3bc-5f1f4cd2762d'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '오페라 <교활한 농부>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9b2e256-cd22-4f1b-b3bc-5f1f4cd2762d'
);


-- Op. 19b, No. 1 아베 마리아

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아베 마리아', 'Ave Maria', 'song', 'Op. 19b, No. 1', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아베 마리아'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1004c1b-5929-415b-a80b-2bb208c25e0b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a1004c1b-5929-415b-a80b-2bb208c25e0b'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '아베 마리아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1004c1b-5929-415b-a80b-2bb208c25e0b'
);


-- Op. 38 모라비아 2중창 Op. 38

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모라비아 2중창 Op. 38', 'Moravian Duets, Op. 38', 'album', NULL, 'Op.', '38', 1877, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모라비아 2중창 Op. 38'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6094360e-0b36-4913-9dd8-9874841eb65b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6094360e-0b36-4913-9dd8-9874841eb65b'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6094360e-0b36-4913-9dd8-9874841eb65b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c974280-fdaa-4cfa-8b88-e2bd560a8c0d', 1, NULL, 'Možnost', 'Možnost', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c974280-fdaa-4cfa-8b88-e2bd560a8c0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3191e2ee-9bab-4f4f-9d59-246776dafe3c', 2, NULL, 'Jablko', 'Jablko', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3191e2ee-9bab-4f4f-9d59-246776dafe3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46a070a3-32e6-4a98-ba4c-219c50960161', 3, NULL, 'Věneček', 'Věneček', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46a070a3-32e6-4a98-ba4c-219c50960161'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ad49f73-a651-4967-94d6-ca2ef77248f3', 4, NULL, 'Hoře', 'Hoře', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모라비아 2중창 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ad49f73-a651-4967-94d6-ca2ef77248f3'
);


-- Op. 78 교향적 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 변주곡', 'Symphonic Variations', 'song', 'Op. 78', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c56f156-f38e-371e-86fc-ef2321ed2fae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5c56f156-f38e-371e-86fc-ef2321ed2fae'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향적 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c56f156-f38e-371e-86fc-ef2321ed2fae'
);


-- Op. 58 스타바트 마테르

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스타바트 마테르', 'Stabat Mater', 'album', 'Op. 58', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스타바트 마테르'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '517734a4-e630-4e65-8075-920b8c96f7e3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '517734a4-e630-4e65-8075-920b8c96f7e3'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '517734a4-e630-4e65-8075-920b8c96f7e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38298ac6-ab2f-36e0-8353-6ad18f482ce8', 1, 'I', 'Stabat Mater dolorosa', 'I. Andante con moto: Stabat Mater dolorosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38298ac6-ab2f-36e0-8353-6ad18f482ce8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed89f690-925a-4dac-aed1-074293230c26', 2, 'II', 'Quis est homo, qui non fleret', 'II. Andante sostenuto: Quis est homo, qui non fleret', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed89f690-925a-4dac-aed1-074293230c26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6e241b3-ad92-498f-b8f3-f7f971bd9f56', 3, 'III', 'Eja, Mater, fons amoris', 'III. Andante con moto: Eja, Mater, fons amoris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6e241b3-ad92-498f-b8f3-f7f971bd9f56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a6d87ee-9e1a-46bb-8577-7fe4beb8991b', 4, 'IV', 'Fac, ut ardeat cor meum', 'IV. Largo: Fac, ut ardeat cor meum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a6d87ee-9e1a-46bb-8577-7fe4beb8991b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88718acc-0ef2-4dd6-b7f5-97fa32238215', 5, 'V', 'Tui nati vulnerati', 'V. Andante con moto, quasi allegretto: Tui nati vulnerati', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88718acc-0ef2-4dd6-b7f5-97fa32238215'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c6500bf-11f6-4f34-be25-606a6d1b6629', 6, 'VI', 'Fac me vere tecum flere', 'VI. Andante con moto: Fac me vere tecum flere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c6500bf-11f6-4f34-be25-606a6d1b6629'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af0e1bc6-563e-40b5-afa4-7ed66c32f6ca', 7, 'VII', 'Virgo virginum praeclara', 'VII. Largo: Virgo virginum praeclara', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af0e1bc6-563e-40b5-afa4-7ed66c32f6ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd677147-4c33-422f-ae26-7660a28a22ae', 8, 'VIII', 'Fac, ut portem Christi mortem', 'VIII. Larghetto: Fac, ut portem Christi mortem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd677147-4c33-422f-ae26-7660a28a22ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06b8a2ea-a9a2-46f0-ab71-2a4876a4bd1a', 9, 'IX', 'Inflammatus et accensus', 'IX. Andante maestoso: Inflammatus et accensus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06b8a2ea-a9a2-46f0-ab71-2a4876a4bd1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a48e4226-8d9b-33e3-b625-f97907a2b94e', 10, 'X', 'Quando corpus morietur', 'X. Andante con moto: Quando corpus morietur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a48e4226-8d9b-33e3-b625-f97907a2b94e'
);


-- B. 72 남성 합창곡집 <체코 민요 꽃다발>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡집 <체코 민요 꽃다발>', 'Bouquet of Czech Folksongs', 'song', 'B. 72', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡집 <체코 민요 꽃다발>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dc6a34c-942e-494b-a137-8174b8ed4519'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4dc6a34c-942e-494b-a137-8174b8ed4519'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡집 <체코 민요 꽃다발>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dc6a34c-942e-494b-a137-8174b8ed4519'
);


-- B. 73 남성 합창곡 <Píseň Čecha>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <Píseň Čecha>', 'Píseň Čecha (Song of a Czech)', 'song', 'B. 73', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <Píseň Čecha>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35d64045-e92c-40b4-a813-c4242905195e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '35d64045-e92c-40b4-a813-c4242905195e'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡 <Píseň Čecha>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35d64045-e92c-40b4-a813-c4242905195e'
);


-- Op. 41 스코틀랜드 무곡 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스코틀랜드 무곡 D단조', 'Scottish Dances in D minor', 'song', 'Op. 41', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스코틀랜드 무곡 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '145b6265-1f2c-49bb-91a8-7a748ed239b2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '145b6265-1f2c-49bb-91a8-7a748ed239b2'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '스코틀랜드 무곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '145b6265-1f2c-49bb-91a8-7a748ed239b2'
);


-- Op. 34 현악 4중주 9번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 9번 D단조', 'String Quartet No. 9 in D minor', 'album', 'Op. 34', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 9번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d9f6545-dea3-499a-becd-ec3f0ae91844'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4d9f6545-dea3-499a-becd-ec3f0ae91844'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 9번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d9f6545-dea3-499a-becd-ec3f0ae91844'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49a08ee1-17a8-4058-a395-408808b3e0d8', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 9번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49a08ee1-17a8-4058-a395-408808b3e0d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40f02bc0-4cbf-4026-8fca-a5ea736e23e1', 2, 'II', 'Alla polka. Allegretto scherzando', 'II. Alla polka. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 9번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40f02bc0-4cbf-4026-8fca-a5ea736e23e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5a5590e-792c-4cd1-ab52-55d2ebbc0d71', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 9번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5a5590e-792c-4cd1-ab52-55d2ebbc0d71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b86d793e-1816-4cb5-be58-8c2b473985c9', 4, 'IV', 'Poco Allegro', 'IV. Poco Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 9번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b86d793e-1816-4cb5-be58-8c2b473985c9'
);


-- Op. 43 남성 합창곡집 <슬라브 민요 꽃다발에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡집 <슬라브 민요 꽃다발에서>', 'From a Bouquet of Slavonic Folksongs', 'album', 'Op. 43', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡집 <슬라브 민요 꽃다발에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7176c34-c6d8-4569-b7d5-561fe88d7173'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e7176c34-c6d8-4569-b7d5-561fe88d7173'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡집 <슬라브 민요 꽃다발에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7176c34-c6d8-4569-b7d5-561fe88d7173'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78b82d68-074c-414f-ade0-5f093cab5349', 1, NULL, 'Žal', 'Žal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡집 <슬라브 민요 꽃다발에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78b82d68-074c-414f-ade0-5f093cab5349'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10d0a83b-5036-42b7-963d-201ee1bf464c', 2, NULL, 'Divná voda', 'Divná voda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡집 <슬라브 민요 꽃다발에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10d0a83b-5036-42b7-963d-201ee1bf464c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f83fb8b6-2344-4f57-bddb-a7b7b4a73d84', 3, NULL, 'Děvče v háji', 'Děvče v háji', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡집 <슬라브 민요 꽃다발에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f83fb8b6-2344-4f57-bddb-a7b7b4a73d84'
);


-- Op. 44 관악 세레나데 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악 세레나데 D단조', 'Serenade for Wind Instruments in D minor', 'album', 'Op. 44', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악 세레나데 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f347b545-dd80-4d28-b634-e326649d0abc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f347b545-dd80-4d28-b634-e326649d0abc'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관악 세레나데 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f347b545-dd80-4d28-b634-e326649d0abc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57d930b2-3681-3d92-8862-bb663abb69d8', 1, 'I', 'Moderato quasi marcia', 'I. Moderato quasi marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관악 세레나데 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57d930b2-3681-3d92-8862-bb663abb69d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2eaad24b-0b32-3ee6-a9c5-bf4d950cf852', 2, 'II', '미뉴에트와 트리오', 'II. Menuetto e Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관악 세레나데 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2eaad24b-0b32-3ee6-a9c5-bf4d950cf852'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56081182-ac0a-31d6-adb9-08988cfbcd29', 3, 'III', 'Andante con moto', 'III. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관악 세레나데 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56081182-ac0a-31d6-adb9-08988cfbcd29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d89dc371-e0e3-37cf-8a38-b601ee542553', 4, 'IV', '피날레. Allegro molto', 'IV. Finale. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관악 세레나데 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d89dc371-e0e3-37cf-8a38-b601ee542553'
);


-- Op. 46 슬라브 무곡 Op. 46

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '슬라브 무곡 Op. 46', 'Slavonic Dances, Op. 46', 'album', NULL, 'Op.', '46', 1878, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '슬라브 무곡 Op. 46'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8e4b15d-f051-4cfa-a8e5-2929bd877ac8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8e4b15d-f051-4cfa-a8e5-2929bd877ac8'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8e4b15d-f051-4cfa-a8e5-2929bd877ac8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:782fc932-3c6b-4dea-b47d-93494bb3c680', 1, NULL, '푸리안트 C장조', 'No. 1 in C major (Furiant)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:782fc932-3c6b-4dea-b47d-93494bb3c680'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b417d1e-c295-49d7-b184-b88422aea50f', 2, NULL, '둠카 E단조', 'No. 2 in E minor (Dumka)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b417d1e-c295-49d7-b184-b88422aea50f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6070154d-2c7a-459d-b775-3709f3af7b84', 3, NULL, '폴카 A♭장조', 'No. 3 in A♭ major (Polka)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6070154d-2c7a-459d-b775-3709f3af7b84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de94e20c-acab-4ef2-b0fc-0f4d8be9102d', 4, NULL, '소우세드스카 F장조', 'No. 4 in F major (Sousedská)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de94e20c-acab-4ef2-b0fc-0f4d8be9102d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:843ec94d-d690-4344-9c92-bd05d3d79d91', 5, NULL, '스코치나 A장조', 'No. 5 in A major (Skočná)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:843ec94d-d690-4344-9c92-bd05d3d79d91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f1e0757-562c-481f-b446-ecf1996e3326', 6, NULL, '소우세드스카 D장조', 'No. 6 in D major (Sousedská)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f1e0757-562c-481f-b446-ecf1996e3326'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61368eaa-9fbf-46df-b90c-c0a968f51881', 7, NULL, '스코치나 C단조', 'No. 7 in C minor (Skočná)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61368eaa-9fbf-46df-b90c-c0a968f51881'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:507c4de9-596c-4554-87a9-1263ce89a030', 8, NULL, '푸리안트 G단조', 'No. 8 in G minor (Furiant)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:507c4de9-596c-4554-87a9-1263ce89a030'
);


-- Op. 47 바가텔

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔', 'Bagatelles', 'album', 'Op. 47', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa411049-cd99-4bb5-85c5-1a8b30fa73ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aa411049-cd99-4bb5-85c5-1a8b30fa73ea'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa411049-cd99-4bb5-85c5-1a8b30fa73ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d19ad9dd-cf6c-4136-a905-956cf1990123', 1, 'I', 'Allegretto scherzando', 'I. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d19ad9dd-cf6c-4136-a905-956cf1990123'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6452fcc6-3beb-49e6-a63b-01f35634eec0', 2, 'II', 'Tempo di menuetto (Grazioso)', 'II. Tempo di menuetto (Grazioso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6452fcc6-3beb-49e6-a63b-01f35634eec0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89cdbe19-e8b3-48c5-9570-2c55fa22688d', 3, 'III', 'Allegretto scherzando', 'III. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89cdbe19-e8b3-48c5-9570-2c55fa22688d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e748ce41-fe86-4e68-9391-682e8595926a', 4, 'IV', '카논. Andante con moto', 'IV. Canon. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e748ce41-fe86-4e68-9391-682e8595926a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5074550-5629-4782-993f-16c8d00119dd', 5, 'V', 'Poco allegro', 'V. Poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5074550-5629-4782-993f-16c8d00119dd'
);


-- Op. 48 현악 6중주 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 6중주 A장조', 'String Sextet in A major', 'album', 'Op. 48', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 6중주 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24690e12-cda0-4687-98ce-199c881d3ce7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '24690e12-cda0-4687-98ce-199c881d3ce7'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 6중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24690e12-cda0-4687-98ce-199c881d3ce7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c24a8fb-f75e-46fe-9714-d73f8b6dd787', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 6중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c24a8fb-f75e-46fe-9714-d73f8b6dd787'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33ea8a1e-532c-46c5-967b-d7095a0cc090', 2, 'II', '둠카 (엘레지). Poco allegretto', 'II. Dumka (Elegie). Poco allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 6중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33ea8a1e-532c-46c5-967b-d7095a0cc090'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61915cb5-6b1d-4822-8a83-1628f0f2d12f', 3, 'III', '푸리안트. Presto', 'III. Furiant. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 6중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61915cb5-6b1d-4822-8a83-1628f0f2d12f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09e50a8c-f708-406e-8320-514697af4752', 4, 'IV', '피날레. 주제와 변주. Allegretto grazioso, quasi andantino', 'IV. Finale. Tema con variazioni. Allegretto grazioso, quasi andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 6중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09e50a8c-f708-406e-8320-514697af4752'
);


-- Op. 24 카프리치오 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카프리치오 C장조', 'Capriccio in C major', 'song', 'Op. 24', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카프리치오 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd70f2a66-bf42-42e0-96c0-d184e910147b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd70f2a66-bf42-42e0-96c0-d184e910147b'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '카프리치오 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd70f2a66-bf42-42e0-96c0-d184e910147b'
);


-- Op. 19b, No. 2 삼위일체 축일 찬가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '삼위일체 축일 찬가', 'Hymnus ad laudes in festo Sanctae Trinitatis', 'song', 'Op. 19b, No. 2', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '삼위일체 축일 찬가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5f076e6-19eb-467c-8d2e-92de2572ee11'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c5f076e6-19eb-467c-8d2e-92de2572ee11'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '삼위일체 축일 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5f076e6-19eb-467c-8d2e-92de2572ee11'
);


-- Op. 50 현대 그리스 시에 의한 3개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현대 그리스 시에 의한 3개의 가곡', '3 Modern Greek Songs', 'song', 'Op. 50', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현대 그리스 시에 의한 3개의 가곡'
);


-- Op. 42 푸리안트 Op. 42

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸리안트 Op. 42', '2 Furiants, Op. 42', 'album', NULL, 'Op.', '42', 1878, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸리안트 Op. 42'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9722a98-ee4f-49bc-a4bf-77a2e9a336a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b9722a98-ee4f-49bc-a4bf-77a2e9a336a5'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '푸리안트 Op. 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9722a98-ee4f-49bc-a4bf-77a2e9a336a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b869015-7edc-4f29-b40d-6ff3540c5f43', 1, NULL, 'D장조', 'No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '푸리안트 Op. 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b869015-7edc-4f29-b40d-6ff3540c5f43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a826be34-0b8d-4184-8d31-978882054396', 2, NULL, 'F장조', 'No. 2 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '푸리안트 Op. 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a826be34-0b8d-4184-8d31-978882054396'
);


-- Op. 45 슬라브 광시곡 Op. 45

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '슬라브 광시곡 Op. 45', '3 Slavonic Rhapsodies, Op. 45', 'album', NULL, 'Op.', '45', 1878, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '슬라브 광시곡 Op. 45'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b4c6bc7-d80e-4523-a3de-dcf65d6189e7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1b4c6bc7-d80e-4523-a3de-dcf65d6189e7'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 광시곡 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b4c6bc7-d80e-4523-a3de-dcf65d6189e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:807fb598-f451-4438-bc65-639f3a01fd0d', 1, NULL, 'D장조', 'No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 광시곡 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:807fb598-f451-4438-bc65-639f3a01fd0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84f71cb5-a7dd-4bf1-b689-065ac32e3d3e', 2, NULL, 'G단조', 'No. 2 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 광시곡 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84f71cb5-a7dd-4bf1-b689-065ac32e3d3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98d8c73d-931e-4f71-af55-896603db508b', 3, NULL, 'A♭장조', 'No. 3 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 광시곡 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98d8c73d-931e-4f71-af55-896603db508b'
);


-- Op. 27 남성 합창곡 Op. 27

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 Op. 27', '5 Choruses for Male Voices, Op. 27', 'album', NULL, 'Op.', '27', 1878, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 Op. 27'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4223ab54-4a03-4d0c-81ab-7e3c74245110'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4223ab54-4a03-4d0c-81ab-7e3c74245110'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4223ab54-4a03-4d0c-81ab-7e3c74245110'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ba13cb1-5716-46c8-9489-5e5685bd75e0', 1, NULL, 'Pomluva', 'Pomluva', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ba13cb1-5716-46c8-9489-5e5685bd75e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b68392d-99db-42c3-8350-d14355206164', 2, NULL, 'Pomořané', 'Pomořané', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b68392d-99db-42c3-8350-d14355206164'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:139a5386-90f6-401b-bc8c-fef911051781', 3, NULL, 'Přípověď lásky', 'Přípověď lásky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:139a5386-90f6-401b-bc8c-fef911051781'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:816b6fc3-3719-4a28-80b8-902411cdf882', 4, NULL, 'Ztracená ovečka', 'Ztracená ovečka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:816b6fc3-3719-4a28-80b8-902411cdf882'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10551288-f8d7-4646-9dc1-e5887faea80c', 5, NULL, 'Hostina', 'Hostina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '남성 합창곡 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10551288-f8d7-4646-9dc1-e5887faea80c'
);


-- B. 88 축전 행진곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '축전 행진곡 C장조', 'Festival March in C major', 'song', 'B. 88', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '축전 행진곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c7fbf39-6a84-4a40-8b86-8f9453da93db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c7fbf39-6a84-4a40-8b86-8f9453da93db'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '축전 행진곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c7fbf39-6a84-4a40-8b86-8f9453da93db'
);


-- Op. 49 마주레크 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주레크 E단조', 'Mazurek in E minor', 'song', 'Op. 49', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주레크 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ff5d6b9-3308-4625-96b9-2ba20de344ce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7ff5d6b9-3308-4625-96b9-2ba20de344ce'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '마주레크 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ff5d6b9-3308-4625-96b9-2ba20de344ce'
);


-- Op. 79 시편 149편

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 149편', 'Psalm 149', 'song', 'Op. 79', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 149편'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df398c98-8dcb-4e81-a273-10bc96856fad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df398c98-8dcb-4e81-a273-10bc96856fad'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '시편 149편' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df398c98-8dcb-4e81-a273-10bc96856fad'
);


-- Op. 51 현악 4중주 10번 E♭장조 "슬라브"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 10번 E♭장조 "슬라브"', 'String Quartet No. 10 in E♭ major "Slavonic"', 'album', 'Op. 51', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 10번 E♭장조 "슬라브"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ba65cab-6cc7-486b-909a-06143a2837bc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3ba65cab-6cc7-486b-909a-06143a2837bc'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 10번 E♭장조 "슬라브"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ba65cab-6cc7-486b-909a-06143a2837bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33ff5d24-a6d4-373f-ab49-6a140db757d1', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 10번 E♭장조 "슬라브"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33ff5d24-a6d4-373f-ab49-6a140db757d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24edb11e-9dbb-337c-975e-b08bab25f437', 2, 'II', '둠카 (엘레지). Andante con moto – Vivace', 'II. Dumka (Elegia). Andante con moto – Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 10번 E♭장조 "슬라브"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24edb11e-9dbb-337c-975e-b08bab25f437'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abacd235-6a13-366b-9e10-d560658513f0', 3, 'III', '로망스. Andante con moto', 'III. Romanza. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 10번 E♭장조 "슬라브"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abacd235-6a13-366b-9e10-d560658513f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6e6786a-c4e8-3101-9f42-0e0a95f82eb9', 4, 'IV', '피날레. Allegro assai', 'IV. Finale. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 10번 E♭장조 "슬라브"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6e6786a-c4e8-3101-9f42-0e0a95f82eb9'
);


-- Op. 39 체코 모음곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '체코 모음곡 D장조', 'Czech Suite in D major', 'album', 'Op. 39', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '체코 모음곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76a5f1d1-8a1f-4fa2-8303-9effe4bca06f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '76a5f1d1-8a1f-4fa2-8303-9effe4bca06f'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '체코 모음곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76a5f1d1-8a1f-4fa2-8303-9effe4bca06f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f373e78-fb4d-354d-b27e-396680e6b8a6', 1, 'I', '전주곡 (파스토랄레). Allegro moderato', 'I. Preludium (Pastorale). Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '체코 모음곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f373e78-fb4d-354d-b27e-396680e6b8a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed3a0803-d33a-3447-91a4-91b73988553b', 2, 'II', '폴카. Allegretto grazioso', 'II. Polka. Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '체코 모음곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed3a0803-d33a-3447-91a4-91b73988553b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fd9cd83-aeac-321b-9195-19ee24e546b1', 3, 'III', '미뉴에트. 소우세드스카. Allegro giusto', 'III. Minuetto. Sousedská. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '체코 모음곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fd9cd83-aeac-321b-9195-19ee24e546b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dbb8f9d-36bf-3d36-8cb6-73855fdcfbbe', 4, 'IV', '로망스. Andante con moto', 'IV. Romanze. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '체코 모음곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dbb8f9d-36bf-3d36-8cb6-73855fdcfbbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a53dd55-2355-321c-8833-ba45cd1cc721', 5, 'V', '피날레 (푸리안트). Presto', 'V. Finale (Furiant). Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '체코 모음곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a53dd55-2355-321c-8833-ba45cd1cc721'
);


-- B. 94 폴로네즈 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 A장조', 'Polonaise in A major', 'song', 'B. 94', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61fe1ce6-22eb-48e1-b790-8e185ce3ff49'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '61fe1ce6-22eb-48e1-b790-8e185ce3ff49'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '폴로네즈 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61fe1ce6-22eb-48e1-b790-8e185ce3ff49'
);


-- Op. 19b, No. 3 아베 마리스 스텔라

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아베 마리스 스텔라', 'Ave maris stella', 'song', 'Op. 19b, No. 3', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아베 마리스 스텔라'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ebf8ccb-fa6c-409d-816f-f411e129d93d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ebf8ccb-fa6c-409d-816f-f411e129d93d'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '아베 마리스 스텔라' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ebf8ccb-fa6c-409d-816f-f411e129d93d'
);


-- Op. 19a 2중창 <O sanctissima dulcis virgo Maria>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <O sanctissima dulcis virgo Maria>', 'O sanctissima dulcis virgo Maria', 'song', 'Op. 19a', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <O sanctissima dulcis virgo Maria>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1c386fa-1807-45f2-a295-f3432bbc391d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f1c386fa-1807-45f2-a295-f3432bbc391d'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '2중창 <O sanctissima dulcis virgo Maria>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1c386fa-1807-45f2-a295-f3432bbc391d'
);


-- Op. 53 바이올린 협주곡 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 A단조', 'Violin Concerto in A minor', 'album', 'Op. 53', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56dd29ec-4826-48c2-b01f-3c963883dbb3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56dd29ec-4826-48c2-b01f-3c963883dbb3'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바이올린 협주곡 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56dd29ec-4826-48c2-b01f-3c963883dbb3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b61d5a4d-29ab-3834-b715-71da420d2ca2', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바이올린 협주곡 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b61d5a4d-29ab-3834-b715-71da420d2ca2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa8f0b3d-70c7-3158-858a-36cfefa68681', 2, 'II', 'Adagio ma non troppo', 'II. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바이올린 협주곡 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa8f0b3d-70c7-3158-858a-36cfefa68681'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:052b320c-2d21-3ace-ac09-8b2a9e58daef', 3, 'III', '피날레. Allegro giocoso ma non troppo', 'III. Finale. Allegro giocoso ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바이올린 협주곡 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:052b320c-2d21-3ace-ac09-8b2a9e58daef'
);


-- B. 97 연주회용 서곡 <반다> G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연주회용 서곡 <반다> G단조', 'Vanda, Concert Overture in G minor', 'song', 'B. 97', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연주회용 서곡 <반다> G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a38ee87-a186-4c8a-9f48-0950a20a0609'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9a38ee87-a186-4c8a-9f48-0950a20a0609'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '연주회용 서곡 <반다> G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a38ee87-a186-4c8a-9f48-0950a20a0609'
);


-- Op. 8 피아노곡집 <실루엣>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡집 <실루엣>', 'Silhouettes', 'album', 'Op. 8', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡집 <실루엣>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f54cddf1-aee4-40ec-8d78-9e80b8a5db80'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f54cddf1-aee4-40ec-8d78-9e80b8a5db80'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <실루엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f54cddf1-aee4-40ec-8d78-9e80b8a5db80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80bb714e-a36a-4259-b993-6efa5f2f95d6', 1, NULL, 'C#단조', 'No. 1 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <실루엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80bb714e-a36a-4259-b993-6efa5f2f95d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:367afd55-c501-478c-b068-0d8f868e022e', 2, NULL, 'D♭장조', 'No. 2 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <실루엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:367afd55-c501-478c-b068-0d8f868e022e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d81bb13f-ba60-4748-8a31-10ff8f45b1dc', 3, NULL, 'D♭장조', 'No. 3 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <실루엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d81bb13f-ba60-4748-8a31-10ff8f45b1dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b58b8047-986d-4bae-af1a-6280eac88a26', 4, NULL, 'F#단조', 'No. 4 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <실루엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b58b8047-986d-4bae-af1a-6280eac88a26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dde1943a-4331-49f4-9400-ce35a40d635e', 5, NULL, 'F#단조', 'No. 5 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <실루엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dde1943a-4331-49f4-9400-ce35a40d635e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b483649-5da3-4492-a9e3-e28970136b89', 6, NULL, 'B♭장조', 'No. 6 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <실루엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b483649-5da3-4492-a9e3-e28970136b89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e00b53c3-c7f3-4d85-b344-494b8a217cd1', 7, NULL, 'D장조', 'No. 7 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <실루엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e00b53c3-c7f3-4d85-b344-494b8a217cd1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdf8779b-eb4a-41ba-87a3-ab4899bc38e9', 8, NULL, 'B단조', 'No. 8 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <실루엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdf8779b-eb4a-41ba-87a3-ab4899bc38e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dcd73e1-e27b-47b8-982c-c815ecbb8637', 9, NULL, 'B장조', 'No. 9 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <실루엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dcd73e1-e27b-47b8-982c-c815ecbb8637'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:277fc597-9c0b-44d0-86c5-d5cdb4aa01fa', 10, NULL, 'G장조', 'No. 10 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <실루엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:277fc597-9c0b-44d0-86c5-d5cdb4aa01fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dab8a7c-6041-46c1-b9fd-2ac66a5d015f', 11, NULL, 'A장조', 'No. 11 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <실루엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dab8a7c-6041-46c1-b9fd-2ac66a5d015f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9d5e5d8-a9b4-4e55-ab32-1bb9452f4ad5', 12, NULL, 'C#단조', 'No. 12 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <실루엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9d5e5d8-a9b4-4e55-ab32-1bb9452f4ad5'
);


-- B. 99 프라하 왈츠 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '프라하 왈츠 D장조', 'Prague Waltzes in D major', 'song', 'B. 99', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '프라하 왈츠 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a30cf27-b2d9-45ee-b21c-a8f345b7fb28'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6a30cf27-b2d9-45ee-b21c-a8f345b7fb28'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '프라하 왈츠 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a30cf27-b2d9-45ee-b21c-a8f345b7fb28'
);


-- B. 100 폴로네즈 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 E♭장조', 'Polonaise in E♭ major', 'song', 'B. 100', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '280f1f67-3ed8-4313-85c2-a162cd2c21e4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '280f1f67-3ed8-4313-85c2-a162cd2c21e4'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '폴로네즈 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '280f1f67-3ed8-4313-85c2-a162cd2c21e4'
);


-- Op. 54 왈츠 Op. 54

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 Op. 54', '8 Waltzes, Op. 54', 'album', NULL, 'Op.', '54', 1880, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 Op. 54'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9d7f285-47e0-4c3c-be24-efb179cd67bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd9d7f285-47e0-4c3c-be24-efb179cd67bf'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '왈츠 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9d7f285-47e0-4c3c-be24-efb179cd67bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:614758e3-6e48-4a16-b626-cf839e380ebd', 1, NULL, 'A장조', 'No. 1 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '왈츠 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:614758e3-6e48-4a16-b626-cf839e380ebd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52303a87-3184-4426-bdc2-5ce45f306d94', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '왈츠 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52303a87-3184-4426-bdc2-5ce45f306d94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:959ce273-f97b-4310-88cd-586649e78580', 3, NULL, 'E장조', 'No. 3 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '왈츠 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:959ce273-f97b-4310-88cd-586649e78580'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b97f488-644d-43e4-a4ce-ffdd344c638e', 4, NULL, 'D♭장조', 'No. 4 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '왈츠 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b97f488-644d-43e4-a4ce-ffdd344c638e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ed8bd73-5424-44e5-8942-d7200132fee9', 5, NULL, 'B♭장조', 'No. 5 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '왈츠 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ed8bd73-5424-44e5-8942-d7200132fee9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22b604ac-8d35-45c8-a6c7-7e74a19d2b36', 6, NULL, 'F장조', 'No. 6 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '왈츠 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22b604ac-8d35-45c8-a6c7-7e74a19d2b36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aec5193d-734e-47c5-8b05-1fbb849aca12', 7, NULL, 'D단조', 'No. 7 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '왈츠 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aec5193d-734e-47c5-8b05-1fbb849aca12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d383e86-c4c5-4443-a2d7-67d0ac8b41d3', 8, NULL, 'E♭장조', 'No. 8 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '왈츠 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d383e86-c4c5-4443-a2d7-67d0ac8b41d3'
);


-- B. 103 에클로그 B. 103

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에클로그 B. 103', '4 Eclogues, B. 103', 'album', NULL, 'B.', '103', 1880, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에클로그 B. 103'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44ea8b8d-f70d-46cc-a331-325f3a003873'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '44ea8b8d-f70d-46cc-a331-325f3a003873'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '에클로그 B. 103' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44ea8b8d-f70d-46cc-a331-325f3a003873'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e9f4f4d-2814-4a24-848a-6ead63e50e54', 1, NULL, 'F장조', 'No. 1 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '에클로그 B. 103' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e9f4f4d-2814-4a24-848a-6ead63e50e54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5984eab-56d0-40cd-8b25-feeb1aa2dc19', 2, NULL, 'D장조', 'No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '에클로그 B. 103' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5984eab-56d0-40cd-8b25-feeb1aa2dc19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d59f7582-cec3-49de-94ce-42f6f648d186', 3, NULL, 'G장조', 'No. 3 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '에클로그 B. 103' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d59f7582-cec3-49de-94ce-42f6f648d186'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80524206-c9fa-43cc-9265-52cbba3cbab7', 4, NULL, 'E장조', 'No. 4 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '에클로그 B. 103' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80524206-c9fa-43cc-9265-52cbba3cbab7'
);


-- Op. 55 가곡집 <집시의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <집시의 노래>', 'Gypsy Songs', 'album', 'Op. 55', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <집시의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94939028-eae9-4785-9006-7b39b6ebb565'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '94939028-eae9-4785-9006-7b39b6ebb565'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94939028-eae9-4785-9006-7b39b6ebb565'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93934012-24cc-3a8f-abe1-ac2a525496bc', 1, NULL, 'Má píseň zas mi láskou zní', 'Má píseň zas mi láskou zní', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93934012-24cc-3a8f-abe1-ac2a525496bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90345c93-f597-361c-9197-66968b478951', 2, NULL, 'Aj! Kterak trojhranec můj', 'Aj! Kterak trojhranec můj', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90345c93-f597-361c-9197-66968b478951'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92a58a21-e590-3170-8dad-2f55a3b8dac0', 3, NULL, 'A les je tichý kolem kol', 'A les je tichý kolem kol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92a58a21-e590-3170-8dad-2f55a3b8dac0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6e1ac44-2777-3f09-b01d-ee183444c00b', 4, NULL, '어머니가 가르쳐 주신 노래 (Když mne stará matka)', 'Když mne stará matka (Songs My Mother Taught Me)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6e1ac44-2777-3f09-b01d-ee183444c00b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7181fd65-4830-3d41-8271-e63b3ebd8e53', 5, NULL, 'Struna naladěna', 'Struna naladěna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7181fd65-4830-3d41-8271-e63b3ebd8e53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:745f533d-17b2-3e4e-8e9e-791c3e99bc40', 6, NULL, 'Široké rukávy', 'Široké rukávy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:745f533d-17b2-3e4e-8e9e-791c3e99bc40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f5903c4-94ff-331f-9568-95b18c874bc5', 7, NULL, 'Dejte klec jestřábu', 'Dejte klec jestřábu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f5903c4-94ff-331f-9568-95b18c874bc5'
);


-- Op. 57 바이올린 소나타 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 F장조', 'Violin Sonata in F major', 'album', 'Op. 57', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7a5e88d-cf4e-4df7-af80-4ef188590ea7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7a5e88d-cf4e-4df7-af80-4ef188590ea7'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바이올린 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7a5e88d-cf4e-4df7-af80-4ef188590ea7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4eabd21b-e0ed-49c8-9387-f13e72cb8a65', 1, 'I', 'Allegro, ma non troppo', 'I. Allegro, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바이올린 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4eabd21b-e0ed-49c8-9387-f13e72cb8a65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2dc8456d-7083-4e1d-882a-4ebb0b285cfa', 2, 'II', 'Poco sostenuto', 'II. Poco sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바이올린 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dc8456d-7083-4e1d-882a-4ebb0b285cfa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea528faf-865f-476d-a08f-ef50226aa5a1', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바이올린 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea528faf-865f-476d-a08f-ef50226aa5a1'
);


-- B. 109 앨범의 한 장 B. 109

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 B. 109', '4 Album Leaves, B. 109', 'album', NULL, 'B.', '109', 1880, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 B. 109'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c9bc114-0b76-4551-b8fb-e225d54baec0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4c9bc114-0b76-4551-b8fb-e225d54baec0'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '앨범의 한 장 B. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c9bc114-0b76-4551-b8fb-e225d54baec0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94499d34-569a-4907-9dc2-d9169c66d8df', 1, NULL, 'G장조', 'No. 1 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '앨범의 한 장 B. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94499d34-569a-4907-9dc2-d9169c66d8df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4188721b-4903-4415-87ce-ce426560607a', 2, NULL, 'F#단조', 'No. 2 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '앨범의 한 장 B. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4188721b-4903-4415-87ce-ce426560607a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c26b412e-9dd4-4a2e-8be7-1777eab1c22d', 3, NULL, 'F장조', 'No. 3 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '앨범의 한 장 B. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c26b412e-9dd4-4a2e-8be7-1777eab1c22d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62230771-3d3e-4f8e-b6e6-b77ab0a323d4', 4, NULL, 'G장조', 'No. 4 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '앨범의 한 장 B. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62230771-3d3e-4f8e-b6e6-b77ab0a323d4'
);


-- Op. 52 피아노 소품 Op. 52

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소품 Op. 52', '6 Piano Pieces, Op. 52', 'album', NULL, 'Op.', '52', 1880, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소품 Op. 52'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '016453ce-9cdd-4923-a5be-bcb910944a49'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '016453ce-9cdd-4923-a5be-bcb910944a49'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 소품 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '016453ce-9cdd-4923-a5be-bcb910944a49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e096d98e-262d-4007-92eb-f435db79a993', 1, NULL, '즉흥곡 G단조', 'No. 1 Impromptu in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 소품 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e096d98e-262d-4007-92eb-f435db79a993'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2783c235-e989-446b-9def-79bd027fdc58', 2, NULL, '인터메초 E♭장조', 'No. 2 Intermezzo in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 소품 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2783c235-e989-446b-9def-79bd027fdc58'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26e1da0b-0dd4-4131-8ad1-7c6aa8a88680', 3, NULL, '지그 B♭장조', 'No. 3 Gigue in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 소품 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26e1da0b-0dd4-4131-8ad1-7c6aa8a88680'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:044a835e-5407-4c13-82dc-5999d4614e55', 4, NULL, '에클로그 G단조', 'No. 4 Eclogue in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 소품 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:044a835e-5407-4c13-82dc-5999d4614e55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f09318b-e225-4164-a12b-bcd91a07ba07', 5, NULL, 'G단조', 'No. 5 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 소품 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f09318b-e225-4164-a12b-bcd91a07ba07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2d2a342-4313-4c7f-9064-03a54556eb81', 6, NULL, '행진곡 E♭장조', 'No. 6 Tempo di marcia in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 소품 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2d2a342-4313-4c7f-9064-03a54556eb81'
);


-- Op. 56 마주르카 Op. 56

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 Op. 56', '6 Mazurkas, Op. 56', 'album', NULL, 'Op.', '56', 1880, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 Op. 56'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6c9e783-8416-4ae8-8c52-aabb026b764f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c6c9e783-8416-4ae8-8c52-aabb026b764f'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '마주르카 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6c9e783-8416-4ae8-8c52-aabb026b764f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38efb611-f106-44b2-bac4-ab2c8c0d997f', 1, NULL, 'Allegro non tanto', 'No. 1: Allegro non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '마주르카 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38efb611-f106-44b2-bac4-ab2c8c0d997f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0be6891d-3233-42ce-b47c-0ffa5e0f1ea5', 2, NULL, 'Vivo e risoluto', 'No. 2: Vivo e risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '마주르카 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0be6891d-3233-42ce-b47c-0ffa5e0f1ea5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63867037-f4ee-40a3-a339-fccd3daa5140', 3, NULL, 'Allegro', 'No. 3: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '마주르카 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63867037-f4ee-40a3-a339-fccd3daa5140'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2c393e6-1f99-49e6-b664-f9d252e2a13e', 4, NULL, 'Lento, ma non troppo', 'No. 4: Lento, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '마주르카 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2c393e6-1f99-49e6-b664-f9d252e2a13e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7db3e19-3fa0-4788-a6cd-1a0e66264e10', 5, NULL, 'Allegro non troppo', 'No. 5: Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '마주르카 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7db3e19-3fa0-4788-a6cd-1a0e66264e10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15e37df2-5779-44f0-ae02-62b2ecc7c691', 6, NULL, 'Allegro', 'No. 6: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '마주르카 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15e37df2-5779-44f0-ae02-62b2ecc7c691'
);


-- Op. 60 교향곡 6번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 6번 D장조', 'Symphony No. 6 in D major', 'album', 'Op. 60', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 6번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43bad451-e042-4d1e-a30c-62bca320c7dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '43bad451-e042-4d1e-a30c-62bca320c7dc'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 6번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43bad451-e042-4d1e-a30c-62bca320c7dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67f3d800-d689-32e0-abf7-103181cc28e5', 1, 'I', 'Allegro non tanto', 'I. Allegro non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 6번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67f3d800-d689-32e0-abf7-103181cc28e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:952a4e69-3c5b-32a6-80a8-2017487f6ce0', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 6번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:952a4e69-3c5b-32a6-80a8-2017487f6ce0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2ae53fe-2bf3-31d4-bd2b-8c22bcf1c23c', 3, 'III', '스케르초 (푸리안트). Presto', 'III. Scherzo (Furiant). Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 6번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2ae53fe-2bf3-31d4-bd2b-8c22bcf1c23c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e97f33e3-355e-38c0-8076-49fa20bd1a6a', 4, 'IV', '피날레. Allegro con spirito', 'IV. Finale. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 6번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e97f33e3-355e-38c0-8076-49fa20bd1a6a'
);


-- B. 113 2성 가곡 <Dětská píseň>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2성 가곡 <Dětská píseň>', 'Dětská píseň (Children''s Song)', 'song', 'B. 113', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2성 가곡 <Dětská píseň>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee81f63d-3a45-4e39-8b4e-374e38c5e0a8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ee81f63d-3a45-4e39-8b4e-374e38c5e0a8'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '2성 가곡 <Dětská píseň>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee81f63d-3a45-4e39-8b4e-374e38c5e0a8'
);


-- B. 114 폴카 B♭장조 "프라하 학생들에게"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 B♭장조 "프라하 학생들에게"', 'Polka in B♭ major "For Prague Students"', 'song', 'B. 114', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 B♭장조 "프라하 학생들에게"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1da7aea7-fb1c-43dc-a437-3dd67123215e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1da7aea7-fb1c-43dc-a437-3dd67123215e'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '폴카 B♭장조 "프라하 학생들에게"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1da7aea7-fb1c-43dc-a437-3dd67123215e'
);


-- B. 116 모데라토 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모데라토 A장조', 'Moderato in A major', 'song', 'B. 116', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모데라토 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0d054fc1-2183-457e-83bb-e68c8b8e3bf8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0d054fc1-2183-457e-83bb-e68c8b8e3bf8'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모데라토 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0d054fc1-2183-457e-83bb-e68c8b8e3bf8'
);


-- Op. 59 관현악곡집 <전설>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악곡집 <전설>', 'Legends', 'album', 'Op. 59', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악곡집 <전설>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd25fb54a-6ace-47b7-a31d-9f6701152228'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd25fb54a-6ace-47b7-a31d-9f6701152228'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관현악곡집 <전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd25fb54a-6ace-47b7-a31d-9f6701152228'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d8fd7be-3608-48be-b9da-d1954459527d', 1, NULL, 'D단조', 'No. 1 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관현악곡집 <전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d8fd7be-3608-48be-b9da-d1954459527d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdb24f69-a91b-40d4-8f1c-8bfe7c9752cc', 2, NULL, 'G장조', 'No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관현악곡집 <전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdb24f69-a91b-40d4-8f1c-8bfe7c9752cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4c0b2f4-cecc-41dc-a2ce-cee3bd8b6105', 3, NULL, 'G단조', 'No. 3 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관현악곡집 <전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4c0b2f4-cecc-41dc-a2ce-cee3bd8b6105'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceb885aa-b5b3-4a9b-9f6a-f945fe19c7c0', 4, NULL, 'C장조', 'No. 4 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관현악곡집 <전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceb885aa-b5b3-4a9b-9f6a-f945fe19c7c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:802092fc-739b-41a5-8cf9-fefec9dd0968', 5, NULL, 'A♭장조', 'No. 5 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관현악곡집 <전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:802092fc-739b-41a5-8cf9-fefec9dd0968'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:703d60d0-93de-4ce6-9803-a75c957e07a1', 6, NULL, 'C#단조', 'No. 6 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관현악곡집 <전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:703d60d0-93de-4ce6-9803-a75c957e07a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cda5b039-379e-4c93-90af-6a176408b0ea', 7, NULL, 'A장조', 'No. 7 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관현악곡집 <전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cda5b039-379e-4c93-90af-6a176408b0ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0492a14-27b4-40a6-a243-2163af8881a1', 8, NULL, 'F장조', 'No. 8 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관현악곡집 <전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0492a14-27b4-40a6-a243-2163af8881a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dfe9777-49b7-4303-b504-e548a0c47aba', 9, NULL, 'D장조', 'No. 9 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관현악곡집 <전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dfe9777-49b7-4303-b504-e548a0c47aba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efffeb12-54af-4576-b6b1-3a83d50ee186', 10, NULL, 'B♭단조', 'No. 10 in B♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '관현악곡집 <전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efffeb12-54af-4576-b6b1-3a83d50ee186'
);


-- B. 118 2중창 <Na tej našej střeše>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Na tej našej střeše>', 'Na tej našej střeše (There on Our Roof)', 'song', 'B. 118', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Na tej našej střeše>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49f3a020-7666-4a2f-a1eb-fd20f09bc335'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '49f3a020-7666-4a2f-a1eb-fd20f09bc335'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '2중창 <Na tej našej střeše>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49f3a020-7666-4a2f-a1eb-fd20f09bc335'
);


-- B. 119 갤럽 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 E장조', 'Gallop in E major', 'song', 'B. 119', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 E장조'
);


-- B. 120 현악 4중주 악장 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 악장 F장조', 'Quartet Movement in F major', 'song', 'B. 120', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 악장 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52aca1bf-6eaf-39f0-9ca8-08d09b459330'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52aca1bf-6eaf-39f0-9ca8-08d09b459330'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 악장 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52aca1bf-6eaf-39f0-9ca8-08d09b459330'
);


-- Op. 61 현악 4중주 11번 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 11번 C장조', 'String Quartet No. 11 in C major', 'album', 'Op. 61', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 11번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3300b90-6248-42be-8588-bd9db4588850'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3300b90-6248-42be-8588-bd9db4588850'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 11번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3300b90-6248-42be-8588-bd9db4588850'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e16ea203-5048-3c54-b67a-4e3c2a9fbf9f', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 11번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e16ea203-5048-3c54-b67a-4e3c2a9fbf9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5b77f57-b15b-3bef-b81c-815365ff6602', 2, 'II', 'Poco adagio e molto cantabile', 'II. Poco adagio e molto cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 11번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5b77f57-b15b-3bef-b81c-815365ff6602'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6aca67e1-2f2a-3e93-b92b-9ff9b3207c4d', 3, 'III', '스케르초. Allegro vivo – 트리오. L''istesso tempo', 'III. Scherzo. Allegro vivo – Trio. L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 11번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6aca67e1-2f2a-3e93-b92b-9ff9b3207c4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a2e56c2-62b8-312b-9888-dcecfaaded8c', 4, 'IV', '피날레. Vivace', 'IV. Finale. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 11번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a2e56c2-62b8-312b-9888-dcecfaaded8c'
);


-- B. 124 4개의 가곡 B. 124

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 가곡 B. 124', '4 Songs on Poems by Gustav Pfleger Moravský, B. 124', 'album', NULL, 'B.', '124', 1882, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 가곡 B. 124'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0e952f5-5733-449b-8b19-c59d4b0fa82f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd0e952f5-5733-449b-8b19-c59d4b0fa82f'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '4개의 가곡 B. 124' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0e952f5-5733-449b-8b19-c59d4b0fa82f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e885aad-9b61-35df-9f0a-bb6c07d02f18', 1, NULL, 'Vy vroucí písně', 'Vy vroucí písně', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '4개의 가곡 B. 124' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e885aad-9b61-35df-9f0a-bb6c07d02f18'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d05c3905-19ec-3c06-9e3a-1c16596fb42f', 2, NULL, 'Ó byl to krásný zlatý sen', 'Ó byl to krásný zlatý sen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '4개의 가곡 B. 124' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d05c3905-19ec-3c06-9e3a-1c16596fb42f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4140cd3b-e796-335d-a915-50c09328759d', 3, NULL, 'Mé srdce často', 'Mé srdce často', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '4개의 가곡 B. 124' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4140cd3b-e796-335d-a915-50c09328759d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08e03733-1bef-31fe-b6d0-bd23a692bd6c', 4, NULL, 'Na horách ticho', 'Na horách ticho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '4개의 가곡 B. 124' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08e03733-1bef-31fe-b6d0-bd23a692bd6c'
);


-- Op. 62 부수음악 <요세프 카예탄 틸>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <요세프 카예탄 틸>', 'Josef Kajetán Tyl', 'song', 'Op. 62', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <요세프 카예탄 틸>'
);


-- B. 125a 서곡 <나의 집> C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <나의 집> C장조', 'My Home, Overture in C major', 'song', 'B. 125a', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <나의 집> C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8b14928-1d49-36a6-ac65-e48b46cf77a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8b14928-1d49-36a6-ac65-e48b46cf77a6'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '서곡 <나의 집> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8b14928-1d49-36a6-ac65-e48b46cf77a6'
);


-- Op. 63 혼성 합창곡집 <자연 속에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '혼성 합창곡집 <자연 속에서>', 'In Nature''s Realm (5 Choruses)', 'album', 'Op. 63', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '혼성 합창곡집 <자연 속에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '278f1458-044b-42a7-a48b-7b8ca753b071'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '278f1458-044b-42a7-a48b-7b8ca753b071'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '혼성 합창곡집 <자연 속에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '278f1458-044b-42a7-a48b-7b8ca753b071'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f7f01e7-d2a2-443a-aa29-e1f23832f8a2', 1, NULL, 'Napadly písně v duši mou', 'Napadly písně v duši mou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '혼성 합창곡집 <자연 속에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f7f01e7-d2a2-443a-aa29-e1f23832f8a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adf31083-2163-46e1-bbec-9432a93ca0d9', 2, NULL, 'Večerní les rozvázal zvonky', 'Večerní les rozvázal zvonky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '혼성 합창곡집 <자연 속에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adf31083-2163-46e1-bbec-9432a93ca0d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd034ee7-0104-4bc1-bba2-ce71c96bc327', 3, NULL, 'Žitné pole', 'Žitné pole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '혼성 합창곡집 <자연 속에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd034ee7-0104-4bc1-bba2-ce71c96bc327'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5892fa8b-968f-4cbd-848d-c1ed73f90673', 4, NULL, 'Vyběhla bříza běličká', 'Vyběhla bříza běličká', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '혼성 합창곡집 <자연 속에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5892fa8b-968f-4cbd-848d-c1ed73f90673'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36d3aaef-d43d-416e-aa7c-cee1eed38e11', 5, NULL, 'Dnes do skoku a do písničky', 'Dnes do skoku a do písničky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '혼성 합창곡집 <자연 속에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36d3aaef-d43d-416e-aa7c-cee1eed38e11'
);


-- Op. 64 오페라 <디미트리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <디미트리>', 'Dimitrij', 'song', 'Op. 64', NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <디미트리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e557e1d-ee8f-43b4-bb82-7c3a54059af7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3e557e1d-ee8f-43b4-bb82-7c3a54059af7'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '오페라 <디미트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e557e1d-ee8f-43b4-bb82-7c3a54059af7'
);


-- B. 128bis 질문 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '질문 G단조', 'Question in G minor', 'song', 'B. 128bis', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '질문 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58d11400-425d-4d55-b328-b8b47c7f7ab9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58d11400-425d-4d55-b328-b8b47c7f7ab9'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '질문 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58d11400-425d-4d55-b328-b8b47c7f7ab9'
);


-- B. 129 즉흥곡 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '즉흥곡 D단조', 'Impromptu in D minor', 'song', 'B. 129', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '즉흥곡 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16e2436b-51ae-4a19-bf28-66a92b0b233d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '16e2436b-51ae-4a19-bf28-66a92b0b233d'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '즉흥곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16e2436b-51ae-4a19-bf28-66a92b0b233d'
);


-- Op. 65 피아노 3중주 3번 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 3번 F단조', 'Piano Trio No. 3 in F minor', 'album', 'Op. 65', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 3번 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f02eb19-5fde-4528-ae67-5efacc10642e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f02eb19-5fde-4528-ae67-5efacc10642e'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 3번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f02eb19-5fde-4528-ae67-5efacc10642e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98184186-e2a1-3456-9f3f-f430b313e105', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 3번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98184186-e2a1-3456-9f3f-f430b313e105'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbd9204c-25f6-3d42-8637-b48dd6d75b39', 2, 'II', 'Allegretto grazioso – Meno mosso', 'II. Allegretto grazioso – Meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 3번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbd9204c-25f6-3d42-8637-b48dd6d75b39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f45bc42-125e-3697-aa0e-ee51301cf19f', 3, 'III', 'Poco adagio', 'III. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 3번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f45bc42-125e-3697-aa0e-ee51301cf19f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ad2b46a-bd96-31f6-bb0f-cd5f08b82289', 4, 'IV', '피날레. Allegro con brio', 'IV. Finale. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 3번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ad2b46a-bd96-31f6-bb0f-cd5f08b82289'
);


-- Op. 66 스케르초 카프리치오소

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 카프리치오소', 'Scherzo capriccioso', 'song', 'Op. 66', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 카프리치오소'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ecaad04-87f6-3e97-926e-5230c4b47972'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ecaad04-87f6-3e97-926e-5230c4b47972'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '스케르초 카프리치오소' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ecaad04-87f6-3e97-926e-5230c4b47972'
);


-- Op. 67 서곡 <후스 교도>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <후스 교도>', 'Hussite Overture', 'song', 'Op. 67', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <후스 교도>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dfda8d48-a9e5-4af1-8b84-e16820fd0c7b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dfda8d48-a9e5-4af1-8b84-e16820fd0c7b'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '서곡 <후스 교도>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dfda8d48-a9e5-4af1-8b84-e16820fd0c7b'
);


-- Op. 68 피아노 연탄곡집 <보헤미아의 숲에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 연탄곡집 <보헤미아의 숲에서>', 'From the Bohemian Forest', 'album', 'Op. 68', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 연탄곡집 <보헤미아의 숲에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25f18da4-a90f-46fb-a61f-d3229c63cccd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '25f18da4-a90f-46fb-a61f-d3229c63cccd'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 연탄곡집 <보헤미아의 숲에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25f18da4-a90f-46fb-a61f-d3229c63cccd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:deff730c-7d19-40f6-b3ea-2f5357ce1c22', 1, NULL, 'Na přástkách', 'Na přástkách (In the Spinning Room)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 연탄곡집 <보헤미아의 숲에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:deff730c-7d19-40f6-b3ea-2f5357ce1c22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fb64083-1b84-470f-8828-12860caa4146', 2, NULL, 'U Černého jezera', 'U Černého jezera (By the Black Lake)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 연탄곡집 <보헤미아의 숲에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fb64083-1b84-470f-8828-12860caa4146'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48afde17-bb92-4e65-a531-ca1ad6fb4220', 3, NULL, 'Noc filipojakubská', 'Noc filipojakubská (Witches'' Sabbath)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 연탄곡집 <보헤미아의 숲에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48afde17-bb92-4e65-a531-ca1ad6fb4220'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92d2d1cf-b326-45fe-9202-fc0590af2182', 4, NULL, 'Na čekání', 'Na čekání (On the Watch)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 연탄곡집 <보헤미아의 숲에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92d2d1cf-b326-45fe-9202-fc0590af2182'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47cb21e6-d320-4cc1-a8e9-bd54055cc9ae', 5, NULL, '고요한 숲 (Klid)', 'Klid (Silent Woods)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 연탄곡집 <보헤미아의 숲에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47cb21e6-d320-4cc1-a8e9-bd54055cc9ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b9c4983-1855-474c-b2ac-476dbdc71307', 6, NULL, 'Z bouřlivých dob', 'Z bouřlivých dob (From Stormy Times)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 연탄곡집 <보헤미아의 숲에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b9c4983-1855-474c-b2ac-476dbdc71307'
);


-- Op. 69 칸타타 <유령의 신부>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <유령의 신부>', 'The Spectre''s Bride', 'song', 'Op. 69', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <유령의 신부>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc316bd7-65d8-4974-9541-8fed5568509e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc316bd7-65d8-4974-9541-8fed5568509e'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '칸타타 <유령의 신부>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc316bd7-65d8-4974-9541-8fed5568509e'
);


-- B. 136 둠카 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '둠카 C단조', 'Dumka in C minor', 'song', 'B. 136', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '둠카 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7fcd097-a757-44ff-9624-722ce31fa20a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a7fcd097-a757-44ff-9624-722ce31fa20a'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '둠카 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7fcd097-a757-44ff-9624-722ce31fa20a'
);


-- B. 137 푸리안트 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸리안트 G단조', 'Furiant in G minor', 'song', 'B. 137', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸리안트 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0be4bd3-f018-4357-bbac-d8c9fc8b9168'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a0be4bd3-f018-4357-bbac-d8c9fc8b9168'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '푸리안트 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0be4bd3-f018-4357-bbac-d8c9fc8b9168'
);


-- B. 138 유모레스크 F#장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '유모레스크 F#장조', 'Humoresque in F# major', 'song', 'B. 138', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '유모레스크 F#장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d703e56-2b85-4377-9847-fcc02e5204dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3d703e56-2b85-4377-9847-fcc02e5204dc'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '유모레스크 F#장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d703e56-2b85-4377-9847-fcc02e5204dc'
);


-- Op. 15 발라드 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 D단조', 'Ballade in D minor', 'song', 'Op. 15', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04918f92-bd3d-4266-823e-af25ee3a6502'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '04918f92-bd3d-4266-823e-af25ee3a6502'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '발라드 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04918f92-bd3d-4266-823e-af25ee3a6502'
);


-- Op. 70 교향곡 7번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 7번 D단조', 'Symphony No. 7 in D minor', 'album', 'Op. 70', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 7번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc7764f9-1d1a-409c-b261-7fa41ff6da81'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc7764f9-1d1a-409c-b261-7fa41ff6da81'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 7번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc7764f9-1d1a-409c-b261-7fa41ff6da81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2ced375-cafe-3c6d-9b90-043a6f3fd731', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 7번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2ced375-cafe-3c6d-9b90-043a6f3fd731'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba587e7f-4d66-307a-8b6a-25c5c7a9d449', 2, 'II', 'Poco adagio', 'II. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 7번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba587e7f-4d66-307a-8b6a-25c5c7a9d449'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f326c46-2a84-3a8f-92a1-a2d016d80dd2', 3, 'III', '스케르초. Vivace – Poco meno mosso', 'III. Scherzo. Vivace – Poco meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 7번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f326c46-2a84-3a8f-92a1-a2d016d80dd2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dbfc50a-53d0-3eb5-ae82-616fdfa1edfe', 4, 'IV', '피날레. Allegro', 'IV. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 7번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dbfc50a-53d0-3eb5-ae82-616fdfa1edfe'
);


-- B. 142 체코 민요시에 의한 2개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '체코 민요시에 의한 2개의 가곡', '2 Czech Folk Poems', 'song', 'B. 142', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '체코 민요시에 의한 2개의 가곡'
);


-- B. 143 칸타타 <체코 농민의 찬가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <체코 농민의 찬가>', 'Hymn of the Czech Peasants', 'song', 'B. 143', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <체코 농민의 찬가>'
);


-- Op. 71 오라토리오 <성 루드밀라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <성 루드밀라>', 'Saint Ludmila', 'song', 'Op. 71', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <성 루드밀라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e64cb224-3749-4b34-b3e9-6aae1d637ff4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e64cb224-3749-4b34-b3e9-6aae1d637ff4'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '오라토리오 <성 루드밀라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e64cb224-3749-4b34-b3e9-6aae1d637ff4'
);


-- Op. 72 슬라브 무곡 Op. 72

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '슬라브 무곡 Op. 72', 'Slavonic Dances, Op. 72', 'album', NULL, 'Op.', '72', 1887, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '슬라브 무곡 Op. 72'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09835fb8-af7e-43a0-9347-075104e5a1c9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09835fb8-af7e-43a0-9347-075104e5a1c9'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09835fb8-af7e-43a0-9347-075104e5a1c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e6c1083-6dbc-3246-b995-3ad8862a04d8', 1, NULL, '오드제메크 B장조', 'No. 1 in B major (Odzemek)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e6c1083-6dbc-3246-b995-3ad8862a04d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1f8f2bb-acad-33a9-9a5c-8c393638ae00', 2, NULL, '스타로다브니 E단조', 'No. 2 in E minor (Starodávný)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1f8f2bb-acad-33a9-9a5c-8c393638ae00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4580eb21-50d0-3d13-872f-664b0af40267', 3, NULL, '스코치나 F장조', 'No. 3 in F major (Skočná)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4580eb21-50d0-3d13-872f-664b0af40267'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d028a9a8-331c-3cc2-ad87-60f5bceb8f47', 4, NULL, '둠카 D♭장조', 'No. 4 in D♭ major (Dumka)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d028a9a8-331c-3cc2-ad87-60f5bceb8f47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07011a0c-73b8-367f-a062-c9c0cf7588ad', 5, NULL, '슈파치르카 B♭단조', 'No. 5 in B♭ minor (Špacírka)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07011a0c-73b8-367f-a062-c9c0cf7588ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cee755c9-a19f-3641-85ff-1b0bb5bd8619', 6, NULL, '스타로다브니 B♭장조', 'No. 6 in B♭ major (Starodávný)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cee755c9-a19f-3641-85ff-1b0bb5bd8619'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9f24b21-2d45-3c8a-b9cc-ad8482512248', 7, NULL, '콜로 C장조', 'No. 7 in C major (Kolo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9f24b21-2d45-3c8a-b9cc-ad8482512248'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fd81fe1-344d-35f2-894a-cbe10c3eeebb', 8, NULL, '소우세드스카 A♭장조', 'No. 8 in A♭ major (Sousedská)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '슬라브 무곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fd81fe1-344d-35f2-894a-cbe10c3eeebb'
);


-- Op. 73 가곡집 <민요풍으로>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <민요풍으로>', 'In Folk Tone', 'album', 'Op. 73', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <민요풍으로>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7463e0a2-8977-4e25-ad83-fa04969304c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7463e0a2-8977-4e25-ad83-fa04969304c6'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <민요풍으로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7463e0a2-8977-4e25-ad83-fa04969304c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b78d614d-648c-40fd-b3e5-5a012bc6c4d3', 1, NULL, 'Dobrú noc, má milá', 'Dobrú noc, má milá', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <민요풍으로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b78d614d-648c-40fd-b3e5-5a012bc6c4d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7acb1f69-7d51-47b4-bfdc-928acf2a1439', 2, NULL, 'Žalo dievča', 'Žalo dievča', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <민요풍으로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7acb1f69-7d51-47b4-bfdc-928acf2a1439'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96b28a55-50f8-4afd-aace-f8803e782add', 3, NULL, 'Ach není, není tu', 'Ach není, není tu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <민요풍으로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96b28a55-50f8-4afd-aace-f8803e782add'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:959d6703-cbaf-4b83-b057-f6ee31449954', 4, NULL, 'Ej, mám já koňa faku', 'Ej, mám já koňa faku', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <민요풍으로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:959d6703-cbaf-4b83-b057-f6ee31449954'
);


-- Op. 74 테르체토 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '테르체토 C장조', 'Terzetto in C major', 'album', 'Op. 74', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '테르체토 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '231f9bf8-2f83-4ae5-ab2f-51aaa43539b9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '231f9bf8-2f83-4ae5-ab2f-51aaa43539b9'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '테르체토 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '231f9bf8-2f83-4ae5-ab2f-51aaa43539b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:458d1602-3c0b-4465-94f2-a68b6af979b5', 1, 'I', '서주. Allegro ma non troppo', 'I. Introduzione. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '테르체토 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:458d1602-3c0b-4465-94f2-a68b6af979b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:609120ab-0660-4fe0-ace7-990533ba293d', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '테르체토 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:609120ab-0660-4fe0-ace7-990533ba293d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a04dd59e-b115-48ad-9d55-65a6df50f5fa', 3, 'III', '스케르초. Vivace', 'III. Scherzo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '테르체토 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a04dd59e-b115-48ad-9d55-65a6df50f5fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b458e5f6-1406-42b8-b116-975580344061', 4, 'IV', '주제와 변주. Poco adagio – Molto allegro', 'IV. Tema con variazioni. Poco adagio – Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '테르체토 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b458e5f6-1406-42b8-b116-975580344061'
);


-- Op. 75a 미니어처

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미니어처', 'Miniatures (Drobnosti)', 'album', 'Op. 75a', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미니어처'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b78a6152-9def-4f96-89e7-bcd96110f756'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b78a6152-9def-4f96-89e7-bcd96110f756'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b78a6152-9def-4f96-89e7-bcd96110f756'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9319cb1-592a-41a9-a70a-9481b5bee5a3', 1, 'I', '카바티나. Moderato', 'I. Cavatina. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9319cb1-592a-41a9-a70a-9481b5bee5a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afff2c08-fed4-4e21-bd8c-373e4bb0d771', 2, 'II', '카프리치오. Poco allegro', 'II. Capriccio. Poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afff2c08-fed4-4e21-bd8c-373e4bb0d771'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7859f43-dc0d-429c-bbbc-9b0a24c08fdf', 3, 'III', '로망스. Allegro', 'III. Romanza. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7859f43-dc0d-429c-bbbc-9b0a24c08fdf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43bf2e26-5c05-4cda-aee1-48b2b264f017', 4, 'IV', '엘레지. Larghetto', 'IV. Elegia. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43bf2e26-5c05-4cda-aee1-48b2b264f017'
);


-- Op. 75 낭만적 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '낭만적 소품', 'Romantic Pieces', 'album', 'Op. 75', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '낭만적 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6599a4b4-311d-4a80-b262-86bc29f3da05'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6599a4b4-311d-4a80-b262-86bc29f3da05'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '낭만적 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6599a4b4-311d-4a80-b262-86bc29f3da05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d935c82f-6022-320d-95c9-7a9e22301729', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '낭만적 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d935c82f-6022-320d-95c9-7a9e22301729'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:683c6307-19f7-370d-b943-4ad32d6f666a', 2, 'II', 'Allegro maestoso', 'II. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '낭만적 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:683c6307-19f7-370d-b943-4ad32d6f666a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6b53908-95bc-3d91-8d7e-c2dbb866a1c0', 3, 'III', 'Allegro appassionato', 'III. Allegro appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '낭만적 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6b53908-95bc-3d91-8d7e-c2dbb866a1c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:090ae1d8-1c22-387a-acf7-65eee90cee60', 4, 'IV', 'Larghetto', 'IV. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '낭만적 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:090ae1d8-1c22-387a-acf7-65eee90cee60'
);


-- B. 152 현악 4중주를 위한 <사이프러스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주를 위한 <사이프러스>', 'Cypresses for String Quartet', 'album', 'B. 152', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주를 위한 <사이프러스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4bab564-b0d3-4095-8367-6ba29d3708bb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4bab564-b0d3-4095-8367-6ba29d3708bb'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주를 위한 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4bab564-b0d3-4095-8367-6ba29d3708bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80e604a2-abe9-39ae-910d-3aca3dd3198c', 1, NULL, 'Moderato', 'No. 1: Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주를 위한 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80e604a2-abe9-39ae-910d-3aca3dd3198c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c97a579-85cc-3de9-baa2-cf079800578c', 2, NULL, 'Allegro ma non troppo', 'No. 2: Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주를 위한 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c97a579-85cc-3de9-baa2-cf079800578c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce986d02-91df-351d-8224-90981b079175', 3, NULL, 'Andante con moto', 'No. 3: Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주를 위한 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce986d02-91df-351d-8224-90981b079175'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07e16420-e7b8-3df9-a29c-8d00ce51cbf1', 4, NULL, 'Poco adagio', 'No. 4: Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주를 위한 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07e16420-e7b8-3df9-a29c-8d00ce51cbf1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a73ff18e-2298-3976-9fee-da516b83ac62', 5, NULL, 'Andante', 'No. 5: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주를 위한 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a73ff18e-2298-3976-9fee-da516b83ac62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a14f4727-7d8a-3518-836b-8bd42db395d8', 6, NULL, 'Andante moderato', 'No. 6: Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주를 위한 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a14f4727-7d8a-3518-836b-8bd42db395d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42c76171-09d5-330f-acc3-fcceca9249a7', 7, NULL, 'Andante con moto', 'No. 7: Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주를 위한 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42c76171-09d5-330f-acc3-fcceca9249a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bdc9cc5-d007-32da-badb-9b6bde786765', 8, NULL, 'Lento', 'No. 8: Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주를 위한 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bdc9cc5-d007-32da-badb-9b6bde786765'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79624738-4d97-3f87-ab6d-1aedb2a859c1', 9, NULL, 'Moderato', 'No. 9: Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주를 위한 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79624738-4d97-3f87-ab6d-1aedb2a859c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:444003f6-9783-3055-a3d3-0ed5fa64fb4f', 10, NULL, 'Andante maestoso', 'No. 10: Andante maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주를 위한 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:444003f6-9783-3055-a3d3-0ed5fa64fb4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68052b3b-d941-3848-90d1-f0e449ea8f69', 11, NULL, 'Allegro scherzando', 'No. 11: Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주를 위한 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68052b3b-d941-3848-90d1-f0e449ea8f69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d893d74c-8ebd-365d-8a87-fc4298e3bd55', 12, NULL, 'Allegro animato', 'No. 12: Allegro animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주를 위한 <사이프러스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d893d74c-8ebd-365d-8a87-fc4298e3bd55'
);


-- Op. 86 미사 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미사 D장조', 'Mass in D major', 'album', 'Op. 86', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미사 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '26391f04-f198-4977-ab23-ab6cef770d7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '26391f04-f198-4977-ab23-ab6cef770d7d'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미사 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '26391f04-f198-4977-ab23-ab6cef770d7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acf1ba2a-a01c-4aa0-ad8e-5a974ee0e2fb', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미사 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acf1ba2a-a01c-4aa0-ad8e-5a974ee0e2fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3f7f5d1-dfba-4523-9728-a14b5ed13ecc', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미사 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3f7f5d1-dfba-4523-9728-a14b5ed13ecc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72cdefa4-9cd2-4c20-8cac-324afdd62628', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미사 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72cdefa4-9cd2-4c20-8cac-324afdd62628'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4ee03b1-b615-4562-bdc3-41a08c3e1fcd', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미사 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4ee03b1-b615-4562-bdc3-41a08c3e1fcd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dcfa082-a323-4371-98d7-49093d118247', 5, 'V', '베네딕투스', 'V. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미사 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dcfa082-a323-4371-98d7-49093d118247'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:660d4660-d5ed-490b-a770-565ca5d4f18b', 6, 'VI', '아뉴스 데이', 'VI. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '미사 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:660d4660-d5ed-490b-a770-565ca5d4f18b'
);


-- Op. 81 피아노 5중주 2번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 5중주 2번 A장조', 'Piano Quintet No. 2 in A major', 'album', 'Op. 81', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 5중주 2번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5adbc202-905f-4184-bddc-d46b9bc452e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5adbc202-905f-4184-bddc-d46b9bc452e8'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 5중주 2번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5adbc202-905f-4184-bddc-d46b9bc452e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eebc144f-469b-3f4a-a052-ac6d413bc7c7', 1, 'I', 'Allegro ma non tanto', 'I. Allegro ma non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 5중주 2번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eebc144f-469b-3f4a-a052-ac6d413bc7c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ab08390-6b01-3dee-b194-0528f07395a8', 2, 'II', '둠카. Andante con moto', 'II. Dumka. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 5중주 2번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ab08390-6b01-3dee-b194-0528f07395a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2e973b6-2978-3652-b07c-8e5db3f63bbe', 3, 'III', '스케르초 – 푸리안트. Molto vivace', 'III. Scherzo – Furiant. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 5중주 2번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2e973b6-2978-3652-b07c-8e5db3f63bbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55318fe7-130a-30a8-96b9-626fca8402cd', 4, 'IV', '피날레. Allegro', 'IV. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 5중주 2번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55318fe7-130a-30a8-96b9-626fca8402cd'
);


-- B. 156 2개의 작은 진주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 작은 진주', '2 Little Pearls', 'album', 'B. 156', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 작은 진주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4abfc37c-1114-452d-9ada-f042aa473170'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4abfc37c-1114-452d-9ada-f042aa473170'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '2개의 작은 진주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4abfc37c-1114-452d-9ada-f042aa473170'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7561d10b-0b16-4408-af42-8575d87e1233', 1, NULL, 'F장조', 'No. 1 in F major "In a Ring!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '2개의 작은 진주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7561d10b-0b16-4408-af42-8575d87e1233'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3b5d4e9-42df-4109-8917-f1c0d3a42fbb', 2, NULL, 'G단조', 'No. 2 in G minor "Grandpa Dances with Grandma"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '2개의 작은 진주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3b5d4e9-42df-4109-8917-f1c0d3a42fbb'
);


-- Op. 82 4개의 가곡 Op. 82

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 가곡 Op. 82', '4 Songs, Op. 82', 'album', NULL, 'Op.', '82', 1888, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 가곡 Op. 82'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '835c7983-6e26-4c3a-aa9f-e890a088be3b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '835c7983-6e26-4c3a-aa9f-e890a088be3b'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '4개의 가곡 Op. 82' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '835c7983-6e26-4c3a-aa9f-e890a088be3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ce97355-018d-4865-8fdf-0a0f59cf0de1', 1, NULL, 'Kéž duch můj sám', 'Kéž duch můj sám (Leave Me Alone)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '4개의 가곡 Op. 82' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ce97355-018d-4865-8fdf-0a0f59cf0de1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a98a001-3ca5-402f-bef6-351f753f937a', 2, NULL, 'Při vyšívání', 'Při vyšívání (The Embroideress)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '4개의 가곡 Op. 82' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a98a001-3ca5-402f-bef6-351f753f937a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b2d7b6e-e535-4a27-97fa-564cdf4044fd', 3, NULL, 'Jaro', 'Jaro (Springtime)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '4개의 가곡 Op. 82' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b2d7b6e-e535-4a27-97fa-564cdf4044fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7108b962-d539-4507-8c22-96a9adba493b', 4, NULL, 'U potoka', 'U potoka (At the Brook)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '4개의 가곡 Op. 82' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7108b962-d539-4507-8c22-96a9adba493b'
);


-- B. 158 앨범의 한 장 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 E♭장조', 'Album Leaf in E♭ major', 'song', 'B. 158', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c11d8ff-d984-48d2-bfc8-c7d67ac038ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0c11d8ff-d984-48d2-bfc8-c7d67ac038ed'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '앨범의 한 장 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c11d8ff-d984-48d2-bfc8-c7d67ac038ed'
);


-- Op. 84 오페라 <자코뱅>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <자코뱅>', 'The Jacobin', 'song', 'Op. 84', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <자코뱅>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3acd6e81-bd82-432f-b0a1-751f05a9e2eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3acd6e81-bd82-432f-b0a1-751f05a9e2eb'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '오페라 <자코뱅>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3acd6e81-bd82-432f-b0a1-751f05a9e2eb'
);


-- Op. 83 가곡집 <사랑의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <사랑의 노래>', 'Love Songs', 'album', 'Op. 83', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <사랑의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '039e42bd-b6cd-496d-ab68-487c1ee970cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '039e42bd-b6cd-496d-ab68-487c1ee970cf'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '039e42bd-b6cd-496d-ab68-487c1ee970cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c75e916a-064b-3d27-985d-af4e99598be4', 1, NULL, 'Ó, naší lásce nekvete', 'Ó, naší lásce nekvete', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c75e916a-064b-3d27-985d-af4e99598be4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b8abc5e-5233-389f-ad8d-0efc027f875d', 2, NULL, 'V tak mnohém srdci mrtvo jest', 'V tak mnohém srdci mrtvo jest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b8abc5e-5233-389f-ad8d-0efc027f875d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20a0588b-d1e0-3cbc-8ea5-bde526688602', 3, NULL, 'Kol domu se teď potácím', 'Kol domu se teď potácím', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20a0588b-d1e0-3cbc-8ea5-bde526688602'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59da5ff4-e8d2-3715-a71f-1dbb625a9a4b', 4, NULL, 'Já vím, že v sladké naději', 'Já vím, že v sladké naději', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59da5ff4-e8d2-3715-a71f-1dbb625a9a4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1e93f84-a1eb-3b67-839a-a99b910f486f', 5, NULL, 'Nad krajem vévodí lehký spánek', 'Nad krajem vévodí lehký spánek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1e93f84-a1eb-3b67-839a-a99b910f486f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f9e5765-f7db-3225-b163-e3c89297b096', 6, NULL, 'Zde v lese u potoka', 'Zde v lese u potoka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f9e5765-f7db-3225-b163-e3c89297b096'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e97c341-ce32-3daa-997f-c5d11c84e5d0', 7, NULL, 'V té sladké moci očí tvých', 'V té sladké moci očí tvých', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e97c341-ce32-3daa-997f-c5d11c84e5d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f7db07a-8405-35ad-a527-a7b961ba9aa0', 8, NULL, 'Ó, duše drahá, jedinká', 'Ó, duše drahá, jedinká', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <사랑의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f7db07a-8405-35ad-a527-a7b961ba9aa0'
);


-- Op. 85 피아노곡집 <시적인 음화>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡집 <시적인 음화>', 'Poetic Tone Pictures', 'album', 'Op. 85', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡집 <시적인 음화>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f658271-983b-429f-8ee2-f1a59ecfc4d7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7f658271-983b-429f-8ee2-f1a59ecfc4d7'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f658271-983b-429f-8ee2-f1a59ecfc4d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7a7399c-c3c4-4dfb-91d1-b0a82f712c69', 1, NULL, 'Noční cesta', 'Noční cesta (Twilight Way)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7a7399c-c3c4-4dfb-91d1-b0a82f712c69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18f678a6-1ba5-4a3c-b4e0-7a65f57f0e3f', 2, NULL, 'Žertem', 'Žertem (Toying)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18f678a6-1ba5-4a3c-b4e0-7a65f57f0e3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf0ca6e3-223b-4255-9686-9673ae766e62', 3, NULL, 'Na starém hradě', 'Na starém hradě (In the Old Castle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf0ca6e3-223b-4255-9686-9673ae766e62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c62f4fc-2436-42bd-b80c-24fd155b8a52', 4, NULL, 'Jarní', 'Jarní (Spring Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c62f4fc-2436-42bd-b80c-24fd155b8a52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1aae23c-93d2-412a-9f85-0b0cbb6d2c95', 5, NULL, 'Selská balada', 'Selská balada (Peasant Ballad)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1aae23c-93d2-412a-9f85-0b0cbb6d2c95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9887fb82-4875-4b24-a022-c5143ce8596f', 6, NULL, 'Vzpomínání', 'Vzpomínání (Reverie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9887fb82-4875-4b24-a022-c5143ce8596f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a448801d-2141-4f29-945e-403b642ffa0a', 7, NULL, 'Furiant', 'Furiant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a448801d-2141-4f29-945e-403b642ffa0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afd5c26b-7fef-474a-a943-8d0da2a1bb49', 8, NULL, 'Rej skřítků', 'Rej skřítků (Goblins'' Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afd5c26b-7fef-474a-a943-8d0da2a1bb49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0f8603e-d157-47a5-acf7-5bb33d81396d', 9, NULL, 'Serenáda', 'Serenáda (Serenade)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0f8603e-d157-47a5-acf7-5bb33d81396d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3ed8e2e-07a9-401f-b822-e2e95b4b5c59', 10, NULL, 'Bakchanale', 'Bakchanale (Bacchanalia)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3ed8e2e-07a9-401f-b822-e2e95b4b5c59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8282758-c4f5-4618-a058-be072cf26572', 11, NULL, 'Na táčkách', 'Na táčkách (Tittle-Tattle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8282758-c4f5-4618-a058-be072cf26572'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c258650-6dfe-4bb5-a3fb-ab34f1aec6ee', 12, NULL, 'U mohyly', 'U mohyly (At a Hero''s Grave)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c258650-6dfe-4bb5-a3fb-ab34f1aec6ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb44e6bd-604f-4e34-a4f0-727fb7de4845', 13, NULL, 'Na svaté hoře', 'Na svaté hoře (On the Holy Mountain)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노곡집 <시적인 음화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb44e6bd-604f-4e34-a4f0-727fb7de4845'
);


-- Op. 87 피아노 4중주 2번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 4중주 2번 E♭장조', 'Piano Quartet No. 2 in E♭ major', 'album', 'Op. 87', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 4중주 2번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1caf2d2-2a77-4780-8386-c8bd588bdd2a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a1caf2d2-2a77-4780-8386-c8bd588bdd2a'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 4중주 2번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1caf2d2-2a77-4780-8386-c8bd588bdd2a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce9b86b7-d7fb-4eee-a791-ec585a79693c', 1, 'I', 'Allegro con fuoco', 'I. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 4중주 2번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce9b86b7-d7fb-4eee-a791-ec585a79693c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28614c2f-eb5f-4a3a-af2f-9af71676ace0', 2, 'II', 'Lento', 'II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 4중주 2번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28614c2f-eb5f-4a3a-af2f-9af71676ace0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bd3a147-e71e-4629-90f6-bc494ad35b61', 3, 'III', 'Allegro moderato, grazioso', 'III. Allegro moderato, grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 4중주 2번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bd3a147-e71e-4629-90f6-bc494ad35b61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcc3a976-0c63-4b8e-88c4-4ba36dc2f5f1', 4, 'IV', '피날레. Allegro ma non troppo', 'IV. Finale. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 4중주 2번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcc3a976-0c63-4b8e-88c4-4ba36dc2f5f1'
);


-- Op. 88 교향곡 8번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 8번 G장조', 'Symphony No. 8 in G major', 'album', 'Op. 88', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 8번 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c16a148-c217-4f00-a239-0df8d816aa4a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0c16a148-c217-4f00-a239-0df8d816aa4a'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 8번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c16a148-c217-4f00-a239-0df8d816aa4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f4a2abe-ec7d-3d6f-950e-7445f51d80b4', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 8번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f4a2abe-ec7d-3d6f-950e-7445f51d80b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc510e44-684a-3984-af37-e98f9bb66d1a', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 8번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc510e44-684a-3984-af37-e98f9bb66d1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17410093-8de4-36a9-b011-832db3c5cf7b', 3, 'III', 'Allegretto grazioso – Molto vivace', 'III. Allegretto grazioso – Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 8번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17410093-8de4-36a9-b011-832db3c5cf7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d9fef71-2a71-3d23-842f-1b25450a8714', 4, 'IV', 'Allegro ma non troppo', 'IV. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향곡 8번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d9fef71-2a71-3d23-842f-1b25450a8714'
);


-- B. 164 3대의 바이올린을 위한 가보트 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3대의 바이올린을 위한 가보트 G단조', 'Gavotte in G minor for Three Violins', 'song', 'B. 164', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3대의 바이올린을 위한 가보트 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a14103ad-ffc6-4948-9908-6f0fca580639'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a14103ad-ffc6-4948-9908-6f0fca580639'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '3대의 바이올린을 위한 가보트 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a14103ad-ffc6-4948-9908-6f0fca580639'
);


-- Op. 89 레퀴엠 B♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '레퀴엠 B♭단조', 'Requiem in B♭ minor', 'album', 'Op. 89', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '레퀴엠 B♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13a54c2c-4075-47a4-aba8-ed399e1c2578'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13a54c2c-4075-47a4-aba8-ed399e1c2578'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13a54c2c-4075-47a4-aba8-ed399e1c2578'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31b00f45-214b-45c7-9729-f16dc60cf793', 1, 'I', '입당송: Requiem aeternam', 'I. Introitus: Requiem aeternam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31b00f45-214b-45c7-9729-f16dc60cf793'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf09e35d-7b10-4513-93f2-fdae25ef6d91', 2, 'II', '층계송: Requiem aeternam', 'II. Graduale: Requiem aeternam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf09e35d-7b10-4513-93f2-fdae25ef6d91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f968256-4399-49ca-a18f-d74d734fb69f', 3, 'III', 'Dies irae', 'III. Sequentia: Dies irae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f968256-4399-49ca-a18f-d74d734fb69f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f9e0b09-3cbf-4fd0-bfad-e5744cd5a052', 4, 'IV', 'Tuba mirum', 'IV. Tuba mirum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f9e0b09-3cbf-4fd0-bfad-e5744cd5a052'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df0392ee-9a02-4f4b-ab4f-5a9e69e55aa4', 5, 'V', 'Quid sum miser', 'V. Quid sum miser', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df0392ee-9a02-4f4b-ab4f-5a9e69e55aa4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f23a4a4-2c2e-4305-953e-63a8fb9c359c', 6, 'VI', 'Recordare, Jesu pie', 'VI. Recordare, Jesu pie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f23a4a4-2c2e-4305-953e-63a8fb9c359c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8597a94b-df64-4b0c-9df7-e52efa6db32e', 7, 'VII', 'Confutatis maledictis', 'VII. Confutatis maledictis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8597a94b-df64-4b0c-9df7-e52efa6db32e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5bcaab0-73d8-4be7-b23b-4039e4f13673', 8, 'VIII', 'Lacrimosa', 'VIII. Lacrimosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5bcaab0-73d8-4be7-b23b-4039e4f13673'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31343cbc-0b15-4629-b5d6-6a1de25c414e', 9, 'IX', '봉헌송: Domine Jesu Christe', 'IX. Offertorium: Domine Jesu Christe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31343cbc-0b15-4629-b5d6-6a1de25c414e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53ef5072-57c1-4b3f-93fa-9782f2207b5e', 10, 'X', 'Hostias', 'X. Hostias', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53ef5072-57c1-4b3f-93fa-9782f2207b5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:105b43b2-4ea5-485f-8450-7c382e3380af', 11, 'XI', '상투스', 'XI. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:105b43b2-4ea5-485f-8450-7c382e3380af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba4e2306-579b-4ebc-a6ce-3dcbc2d618cd', 12, 'XII', 'Pie Jesu', 'XII. Pie Jesu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba4e2306-579b-4ebc-a6ce-3dcbc2d618cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bee21c6c-ac8b-4300-aa68-824c24c588b7', 13, 'XIII', '아뉴스 데이', 'XIII. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '레퀴엠 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bee21c6c-ac8b-4300-aa68-824c24c588b7'
);


-- Op. 90 피아노 3중주 4번 E단조 "둠키"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 4번 E단조 "둠키"', 'Piano Trio No. 4 in E minor "Dumky"', 'album', 'Op. 90', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 4번 E단조 "둠키"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46d66fb8-cd1a-400c-baba-cc8866b40732'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '46d66fb8-cd1a-400c-baba-cc8866b40732'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 4번 E단조 "둠키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46d66fb8-cd1a-400c-baba-cc8866b40732'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0694b17-7bee-34cb-8bf7-f1562acae914', 1, 'I', 'Lento maestoso', 'I. Lento maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 4번 E단조 "둠키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0694b17-7bee-34cb-8bf7-f1562acae914'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b262a82d-120a-3b6f-9c93-a29dd9f7ec03', 2, 'II', 'Poco adagio', 'II. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 4번 E단조 "둠키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b262a82d-120a-3b6f-9c93-a29dd9f7ec03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9acd6e7a-8797-3a2e-b68e-e1a0cb213ce1', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 4번 E단조 "둠키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9acd6e7a-8797-3a2e-b68e-e1a0cb213ce1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8770791-b493-3cc4-9d29-7870f1de0f34', 4, 'IV', 'Andante moderato', 'IV. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 4번 E단조 "둠키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8770791-b493-3cc4-9d29-7870f1de0f34'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4b28ef0-157f-38f7-8bf5-2d8036e30e00', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 4번 E단조 "둠키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4b28ef0-157f-38f7-8bf5-2d8036e30e00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffc75c53-d3e5-3d87-b59f-d317e8516888', 6, 'VI', 'Lento maestoso', 'VI. Lento maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 3중주 4번 E단조 "둠키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffc75c53-d3e5-3d87-b59f-d317e8516888'
);


-- B. 167 팡파르 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '팡파르 C장조', 'Fanfares in C major', 'song', 'B. 167', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '팡파르 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '834c8dcd-dd0d-4524-b331-789efbf5d2f2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '834c8dcd-dd0d-4524-b331-789efbf5d2f2'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '팡파르 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '834c8dcd-dd0d-4524-b331-789efbf5d2f2'
);


-- Op. 91 서곡 <자연 속에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <자연 속에서>', 'In Nature''s Realm, Overture', 'song', 'Op. 91', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <자연 속에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '242e1428-78b7-3ca4-b928-970832a6c70e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '242e1428-78b7-3ca4-b928-970832a6c70e'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '서곡 <자연 속에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '242e1428-78b7-3ca4-b928-970832a6c70e'
);


-- Op. 92 서곡 <사육제>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <사육제>', 'Carnival Overture', 'song', 'Op. 92', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <사육제>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6fd403fe-6720-3c7f-8aae-e51216c06b51'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6fd403fe-6720-3c7f-8aae-e51216c06b51'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '서곡 <사육제>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6fd403fe-6720-3c7f-8aae-e51216c06b51'
);


-- Op. 94 론도 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '론도 G단조', 'Rondo in G minor', 'song', 'Op. 94', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '론도 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cbd10ad8-8665-3e9e-b6f6-afb1f2d46d48'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cbd10ad8-8665-3e9e-b6f6-afb1f2d46d48'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '론도 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cbd10ad8-8665-3e9e-b6f6-afb1f2d46d48'
);


-- B. 182 첼로와 관현악을 위한 <고요한 숲>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로와 관현악을 위한 <고요한 숲>', 'Silent Woods', 'song', 'B. 182', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로와 관현악을 위한 <고요한 숲>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0b17a20-b162-3bbe-8d34-4d57fe14e6a1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd0b17a20-b162-3bbe-8d34-4d57fe14e6a1'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '첼로와 관현악을 위한 <고요한 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0b17a20-b162-3bbe-8d34-4d57fe14e6a1'
);


-- Op. 93 서곡 <오셀로>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <오셀로>', 'Othello, Overture', 'song', 'Op. 93', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <오셀로>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14b9e4c2-3fdc-326e-8c64-0e1488709edc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '14b9e4c2-3fdc-326e-8c64-0e1488709edc'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '서곡 <오셀로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14b9e4c2-3fdc-326e-8c64-0e1488709edc'
);


-- Op. 103 테 데움

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '테 데움', 'Te Deum', 'album', 'Op. 103', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '테 데움'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a555e2a0-16ce-4429-9db0-9e8473b805d2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a555e2a0-16ce-4429-9db0-9e8473b805d2'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a555e2a0-16ce-4429-9db0-9e8473b805d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6d91671-5a6a-328b-aca0-e6adfd13fb1f', 1, 'I', 'Allegro moderato, maestoso', 'I. Allegro moderato, maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6d91671-5a6a-328b-aca0-e6adfd13fb1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b78c950-4a86-3e93-95dd-0147e34105ec', 2, 'II', 'Lento maestoso', 'II. Lento maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b78c950-4a86-3e93-95dd-0147e34105ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bde2885-2995-3aef-9714-ddb289b748ec', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bde2885-2995-3aef-9714-ddb289b748ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d827267f-8a1b-3aaa-b04c-ea3c3ac09d3d', 4, 'IV', 'Lento', 'IV. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d827267f-8a1b-3aaa-b04c-ea3c3ac09d3d'
);


-- Op. 102 칸타타 <미국 국기>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <미국 국기>', 'The American Flag', 'song', 'Op. 102', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <미국 국기>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '60f8d6e9-60f3-46f2-8ce7-5db6a2d037d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '60f8d6e9-60f3-46f2-8ce7-5db6a2d037d5'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '칸타타 <미국 국기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '60f8d6e9-60f3-46f2-8ce7-5db6a2d037d5'
);


-- Op. 95 교향곡 9번 E단조 "신세계로부터"

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aacb1ab0-c740-436a-a782-ed60026cf82b'
FROM pieces p
WHERE p.id = 197 AND p.composer_id = 45
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aacb1ab0-c740-436a-a782-ed60026cf82b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aec2489b-051c-4892-8df5-6c601877e5f6', 1, 'I', 'Adagio – Allegro molto', 'I. Adagio – Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 197 AND p.composer_id = 45
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aec2489b-051c-4892-8df5-6c601877e5f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8596e5aa-85e1-4f76-907f-ea02aee39ea3', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 197 AND p.composer_id = 45
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8596e5aa-85e1-4f76-907f-ea02aee39ea3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3acb9f1c-9a4a-4421-bcce-2ebdfbf23b00', 3, 'III', '스케르초. Molto vivace – Poco sostenuto', 'III. Scherzo. Molto vivace – Poco sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 197 AND p.composer_id = 45
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3acb9f1c-9a4a-4421-bcce-2ebdfbf23b00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ac97fc0-6b66-413f-8cba-7ea5803697b3', 4, 'IV', 'Allegro con fuoco', 'IV. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 197 AND p.composer_id = 45
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ac97fc0-6b66-413f-8cba-7ea5803697b3'
);


-- Op. 96 현악 4중주 12번 F장조 "아메리카"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:059e44e5-5677-3666-8038-874f9ef2a5a4', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 200 AND p.composer_id = 45
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:059e44e5-5677-3666-8038-874f9ef2a5a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54cb5a03-5676-39f6-8434-8efe2f16c6a0', 2, 'II', 'Lento', 'II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 200 AND p.composer_id = 45
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54cb5a03-5676-39f6-8434-8efe2f16c6a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69f9a0ab-de22-3eb5-a6c1-e463b8a48efb', 3, 'III', 'Molto vivace', 'III. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 200 AND p.composer_id = 45
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69f9a0ab-de22-3eb5-a6c1-e463b8a48efb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7a7c37b-62ac-3a9c-8d0c-60e3d4655764', 4, 'IV', '피날레. Vivace ma non troppo', 'IV. Finale. Vivace ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 200 AND p.composer_id = 45
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7a7c37b-62ac-3a9c-8d0c-60e3d4655764'
);


-- Op. 97 현악 5중주 3번 E♭장조 "아메리카"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 5중주 3번 E♭장조 "아메리카"', 'String Quintet No. 3 in E♭ major "American"', 'album', 'Op. 97', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 5중주 3번 E♭장조 "아메리카"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22c73c3f-b7ec-4a37-840c-741974d936f2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '22c73c3f-b7ec-4a37-840c-741974d936f2'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 3번 E♭장조 "아메리카"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22c73c3f-b7ec-4a37-840c-741974d936f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfd4da0c-29ce-37b8-8691-1582328a1e8b', 1, 'I', 'Allegro non tanto', 'I. Allegro non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 3번 E♭장조 "아메리카"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfd4da0c-29ce-37b8-8691-1582328a1e8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47a2a1f3-61f9-330d-9444-c145a7969185', 2, 'II', 'Allegro vivo – Un poco meno mosso', 'II. Allegro vivo – Un poco meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 3번 E♭장조 "아메리카"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47a2a1f3-61f9-330d-9444-c145a7969185'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:925dd6bb-d6a3-3b3d-9c40-ae83101a1996', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 3번 E♭장조 "아메리카"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:925dd6bb-d6a3-3b3d-9c40-ae83101a1996'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df817536-3bac-30b8-8157-6d7b9def3932', 4, 'IV', '피날레. Allegro giusto', 'IV. Finale. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 5중주 3번 E♭장조 "아메리카"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df817536-3bac-30b8-8157-6d7b9def3932'
);


-- Op. 100 바이올린 소나티나 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나티나 G장조', 'Violin Sonatina in G major', 'album', 'Op. 100', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나티나 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6486d09-dbf5-4fce-bfdb-03050ccc3829'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6486d09-dbf5-4fce-bfdb-03050ccc3829'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바이올린 소나티나 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6486d09-dbf5-4fce-bfdb-03050ccc3829'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:905199be-2475-3fea-a16a-e10135fee739', 1, 'I', 'Allegro risoluto', 'I. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바이올린 소나티나 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:905199be-2475-3fea-a16a-e10135fee739'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f95ca0d6-5223-361b-b68f-c42aa06dd30d', 2, 'II', 'Larghetto – Poco più mosso – Meno mosso, tempo I', 'II. Larghetto – Poco più mosso – Meno mosso, tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바이올린 소나티나 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f95ca0d6-5223-361b-b68f-c42aa06dd30d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8171090-b294-3d0c-84dc-4ebf9550e1c0', 3, 'III', '스케르초. Molto vivace – 트리오', 'III. Scherzo. Molto vivace – Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바이올린 소나티나 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8171090-b294-3d0c-84dc-4ebf9550e1c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad4de811-5467-3f3c-bf3b-a2d83d5a8cd6', 4, 'IV', '피날레. Allegro – Molto tranquillo, tempo I', 'IV. Finale. Allegro – Molto tranquillo, tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '바이올린 소나티나 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad4de811-5467-3f3c-bf3b-a2d83d5a8cd6'
);


-- Op. 98 모음곡 A장조 "아메리카"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 A장조 "아메리카"', 'Suite in A major "American"', 'album', 'Op. 98', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 A장조 "아메리카"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd982e6d8-489b-4743-aaec-a4aca16efc47'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd982e6d8-489b-4743-aaec-a4aca16efc47'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모음곡 A장조 "아메리카"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd982e6d8-489b-4743-aaec-a4aca16efc47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:059859fa-4e7d-4bad-b021-a9c79c0801fe', 1, 'I', 'Andante con moto', 'I. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모음곡 A장조 "아메리카"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:059859fa-4e7d-4bad-b021-a9c79c0801fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3abeeead-7341-463d-9966-b3993813e03e', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모음곡 A장조 "아메리카"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3abeeead-7341-463d-9966-b3993813e03e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdb978b0-aee3-420e-b93c-7720ecb6ad2a', 3, 'III', 'Moderato', 'III. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모음곡 A장조 "아메리카"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdb978b0-aee3-420e-b93c-7720ecb6ad2a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:560f3f0a-7e3b-4fc4-8435-ca08129aad97', 4, 'IV', 'Andante', 'IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모음곡 A장조 "아메리카"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:560f3f0a-7e3b-4fc4-8435-ca08129aad97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e87faa0-8cb9-4bad-925a-bc7b9a8a40fb', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '모음곡 A장조 "아메리카"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e87faa0-8cb9-4bad-925a-bc7b9a8a40fb'
);


-- Op. 99 가곡집 <성서의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <성서의 노래>', 'Biblical Songs', 'album', 'Op. 99', NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <성서의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5d3ff70-76d8-496f-967e-99033b3991ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5d3ff70-76d8-496f-967e-99033b3991ff'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <성서의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5d3ff70-76d8-496f-967e-99033b3991ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ccbf209-0471-4a7a-af8c-4a1d35f48152', 1, NULL, 'Oblak a mrákota jest vůkol Něho', 'Oblak a mrákota jest vůkol Něho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <성서의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ccbf209-0471-4a7a-af8c-4a1d35f48152'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac659e2e-0516-4e08-ab54-986593597783', 2, NULL, 'Skrýše má a paveza má Ty jsí', 'Skrýše má a paveza má Ty jsí', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <성서의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac659e2e-0516-4e08-ab54-986593597783'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b19930fb-bd1b-4409-b979-0624a25e0d5d', 3, NULL, 'Slyš, ó Bože, slyš modlitbu mou', 'Slyš, ó Bože, slyš modlitbu mou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <성서의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b19930fb-bd1b-4409-b979-0624a25e0d5d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2dc37182-ef15-4d5c-a16a-465277b9d4be', 4, NULL, 'Hospodin jest můj pastýř', 'Hospodin jest můj pastýř', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <성서의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dc37182-ef15-4d5c-a16a-465277b9d4be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1a1af34-7080-464b-a24d-4e36a093e381', 5, NULL, 'Bože! Bože! Píseň novou', 'Bože! Bože! Píseň novou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <성서의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1a1af34-7080-464b-a24d-4e36a093e381'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ee72860-12a7-42d9-8634-dccbdf6ba355', 6, NULL, 'Slyš, ó Bože, volání mé', 'Slyš, ó Bože, volání mé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <성서의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ee72860-12a7-42d9-8634-dccbdf6ba355'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13284147-942d-4086-ae9e-c730b034273a', 7, NULL, 'Při řekách babylonských', 'Při řekách babylonských', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <성서의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13284147-942d-4086-ae9e-c730b034273a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9607b174-142d-4f85-83df-d0454e6739ca', 8, NULL, 'Popatřiž na mne a smiluj se nade mnou', 'Popatřiž na mne a smiluj se nade mnou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <성서의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9607b174-142d-4f85-83df-d0454e6739ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:526e05be-b836-403d-a016-885e2ef80a08', 9, NULL, 'Pozdvihuji očí svých k horám', 'Pozdvihuji očí svých k horám', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <성서의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:526e05be-b836-403d-a016-885e2ef80a08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:516a818b-8d2e-4d5d-ba8b-ee101245196f', 10, NULL, 'Zpívejte Hospodinu píseň novou', 'Zpívejte Hospodinu píseň novou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '가곡집 <성서의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:516a818b-8d2e-4d5d-ba8b-ee101245196f'
);


-- Op. 101 유모레스크 Op. 101

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '유모레스크 Op. 101', '8 Humoresques, Op. 101', 'album', NULL, 'Op.', '101', 1894, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '유모레스크 Op. 101'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '077beb4e-3072-4002-8c0d-16514c2b0b84'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '077beb4e-3072-4002-8c0d-16514c2b0b84'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '유모레스크 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '077beb4e-3072-4002-8c0d-16514c2b0b84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dab889b1-37fa-4cfe-99de-f7659ebb7b9d', 1, NULL, 'E♭단조', 'No. 1 in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '유모레스크 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dab889b1-37fa-4cfe-99de-f7659ebb7b9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc5aa8a1-2562-4438-b830-7bc6666a7ea1', 2, NULL, 'B장조', 'No. 2 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '유모레스크 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc5aa8a1-2562-4438-b830-7bc6666a7ea1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02e155f2-f554-45c9-85d7-c9f3ccc2eca3', 3, NULL, 'A♭장조', 'No. 3 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '유모레스크 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02e155f2-f554-45c9-85d7-c9f3ccc2eca3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c811505b-7085-4aab-a4fb-2243132cab20', 4, NULL, 'F장조', 'No. 4 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '유모레스크 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c811505b-7085-4aab-a4fb-2243132cab20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5e0eb22-5abc-4373-9e4f-6d9db8f145d1', 5, NULL, 'A단조', 'No. 5 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '유모레스크 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5e0eb22-5abc-4373-9e4f-6d9db8f145d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d248747-0c36-4a0a-8927-fb7809c2917b', 6, NULL, 'B장조', 'No. 6 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '유모레스크 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d248747-0c36-4a0a-8927-fb7809c2917b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 201 AND linked.composer_id = 45), 'musicbrainz:134f4e53-e0d5-3ec7-aa86-5d3456379c4b', 7, NULL, 'G♭장조', 'No. 7 in G♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '유모레스크 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:134f4e53-e0d5-3ec7-aa86-5d3456379c4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67df5a87-3ef6-3db0-a870-c7dfd0a70d5c', 8, NULL, 'B♭단조', 'No. 8 in B♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '유모레스크 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67df5a87-3ef6-3db0-a870-c7dfd0a70d5c'
);


-- B. 188 피아노 소품 B. 188

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소품 B. 188', '2 Piano Pieces, B. 188', 'album', NULL, 'B.', '188', 1894, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소품 B. 188'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fa95461-b158-4c2d-b19a-1deed199d66f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2fa95461-b158-4c2d-b19a-1deed199d66f'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 소품 B. 188' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fa95461-b158-4c2d-b19a-1deed199d66f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a16e0e2-ea18-45bd-86a5-a94444cc04b9', 1, NULL, '자장가 G장조', 'No. 1 Lullaby in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 소품 B. 188' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a16e0e2-ea18-45bd-86a5-a94444cc04b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5497c33-6332-4970-b9a7-2dad6354a051', 2, NULL, '카프리치오 G단조', 'No. 2 Capriccio in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '피아노 소품 B. 188' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5497c33-6332-4970-b9a7-2dad6354a051'
);


-- Op. 104 첼로 협주곡 B단조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:710830c6-79d6-30ee-956d-f7079681ddf5', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 198 AND p.composer_id = 45
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:710830c6-79d6-30ee-956d-f7079681ddf5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ac7bb10-188c-3a75-af56-629263fda0c1', 2, 'II', 'Adagio ma non troppo', 'II. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 198 AND p.composer_id = 45
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ac7bb10-188c-3a75-af56-629263fda0c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a49f8cc-1b48-3b84-b2a8-f8a8fec80b06', 3, 'III', '피날레. Allegro moderato – Andante – Allegro vivo', 'III. Finale. Allegro moderato – Andante – Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 198 AND p.composer_id = 45
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a49f8cc-1b48-3b84-b2a8-f8a8fec80b06'
);


-- Op. 106 현악 4중주 13번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 13번 G장조', 'String Quartet No. 13 in G major', 'album', 'Op. 106', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 13번 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8b8fd8a-b631-4233-8ac5-4bba1125017d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e8b8fd8a-b631-4233-8ac5-4bba1125017d'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 13번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8b8fd8a-b631-4233-8ac5-4bba1125017d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4c02c5b-8fc3-39e5-a67c-d8cab7c70c86', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 13번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4c02c5b-8fc3-39e5-a67c-d8cab7c70c86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dd0513f-b409-3bd7-8e96-c30f5a580971', 2, 'II', 'Adagio ma non troppo', 'II. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 13번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dd0513f-b409-3bd7-8e96-c30f5a580971'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:486ac32e-854f-313c-ba65-33e290773cab', 3, 'III', 'Molto vivace', 'III. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 13번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:486ac32e-854f-313c-ba65-33e290773cab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94e91ad0-ae9a-3b54-9546-6227dbe43018', 4, 'IV', '피날레. Andante sostenuto – Allegro con fuoco', 'IV. Finale. Andante sostenuto – Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 13번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94e91ad0-ae9a-3b54-9546-6227dbe43018'
);


-- Op. 105 현악 4중주 14번 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 14번 A♭장조', 'String Quartet No. 14 in A♭ major', 'album', 'Op. 105', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 14번 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ad61f99-1bb3-4dc3-b19d-21da1377907f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7ad61f99-1bb3-4dc3-b19d-21da1377907f'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 14번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ad61f99-1bb3-4dc3-b19d-21da1377907f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13a71f5f-4fe4-3d88-95fb-656992560347', 1, 'I', 'Adagio ma non troppo – Allegro appassionato', 'I. Adagio ma non troppo – Allegro appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 14번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13a71f5f-4fe4-3d88-95fb-656992560347'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf12d614-bf85-3fc7-9bf5-8d35d63fa16e', 2, 'II', 'Molto vivace', 'II. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 14번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf12d614-bf85-3fc7-9bf5-8d35d63fa16e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77832a6f-975c-3099-b09a-98597b4b5f1b', 3, 'III', 'Lento e molto cantabile', 'III. Lento e molto cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 14번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77832a6f-975c-3099-b09a-98597b4b5f1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3153fa0-2073-3c17-80e9-224d6b6571a4', 4, 'IV', 'Allegro non tanto', 'IV. Allegro non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '현악 4중주 14번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3153fa0-2073-3c17-80e9-224d6b6571a4'
);


-- B. 194 가곡 <Ukolébavka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ukolébavka>', 'Ukolébavka (Lullaby)', 'song', 'B. 194', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ukolébavka>'
);


-- Op. 107 교향시 <물의 요정>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <물의 요정>', 'The Water Goblin', 'song', 'Op. 107', NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <물의 요정>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74f6cbcf-553f-31a4-80c0-8edc0173b41f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '74f6cbcf-553f-31a4-80c0-8edc0173b41f'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향시 <물의 요정>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74f6cbcf-553f-31a4-80c0-8edc0173b41f'
);


-- Op. 108 교향시 <한낮의 마녀>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <한낮의 마녀>', 'The Noon Witch', 'song', 'Op. 108', NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <한낮의 마녀>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99752323-f0f9-4ada-ab16-0860b9456cd3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '99752323-f0f9-4ada-ab16-0860b9456cd3'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향시 <한낮의 마녀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99752323-f0f9-4ada-ab16-0860b9456cd3'
);


-- Op. 109 교향시 <황금 물레>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <황금 물레>', 'The Golden Spinning Wheel', 'song', 'Op. 109', NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <황금 물레>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2198af4-b8e3-41e1-98e9-1038acece212'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c2198af4-b8e3-41e1-98e9-1038acece212'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향시 <황금 물레>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2198af4-b8e3-41e1-98e9-1038acece212'
);


-- Op. 110 교향시 <들비둘기>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <들비둘기>', 'The Wild Dove', 'song', 'Op. 110', NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <들비둘기>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c06e9a53-1368-3709-bab9-5e7911597a07'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c06e9a53-1368-3709-bab9-5e7911597a07'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향시 <들비둘기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c06e9a53-1368-3709-bab9-5e7911597a07'
);


-- Op. 111 교향시 <영웅의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <영웅의 노래>', 'A Hero''s Song', 'song', 'Op. 111', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <영웅의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2659b54c-86a6-4f22-a80a-839d0350472f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2659b54c-86a6-4f22-a80a-839d0350472f'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '교향시 <영웅의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2659b54c-86a6-4f22-a80a-839d0350472f'
);


-- Op. 112 오페라 <악마와 카차>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <악마와 카차>', 'The Devil and Kate', 'song', 'Op. 112', NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <악마와 카차>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c1a0f14a-c59e-4748-a71b-7783403a39eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c1a0f14a-c59e-4748-a71b-7783403a39eb'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '오페라 <악마와 카차>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c1a0f14a-c59e-4748-a71b-7783403a39eb'
);


-- Op. 113 칸타타 <축전의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <축전의 노래>', 'Festival Song', 'song', 'Op. 113', NULL, NULL, 1900, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <축전의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0624e671-9e3c-42fc-bc81-e1f97f9efe36'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0624e671-9e3c-42fc-bc81-e1f97f9efe36'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '칸타타 <축전의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0624e671-9e3c-42fc-bc81-e1f97f9efe36'
);


-- Op. 114 오페라 <루살카>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <루살카>', 'Rusalka', 'song', 'Op. 114', NULL, NULL, 1900, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <루살카>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07b2663f-0836-4654-9254-583158d05c36'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07b2663f-0836-4654-9254-583158d05c36'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '오페라 <루살카>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07b2663f-0836-4654-9254-583158d05c36'
);


-- Op. 115 오페라 <아르미다>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아르미다>', 'Armida', 'song', 'Op. 115', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아르미다>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '811b14fd-cc94-4433-8c74-1c522f7f5e3d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '811b14fd-cc94-4433-8c74-1c522f7f5e3d'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '오페라 <아르미다>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '811b14fd-cc94-4433-8c74-1c522f7f5e3d'
);


-- B. 302 오르간을 위한 전주곡과 푸가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간을 위한 전주곡과 푸가', 'Preludes and Fugues for Organ', 'song', 'B. 302', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 45
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간을 위한 전주곡과 푸가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5361792c-09d3-4e22-8655-1e7c3ecb3639'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5361792c-09d3-4e22-8655-1e7c3ecb3639'
FROM pieces p
WHERE p.composer_id = 45 AND p.title = '오르간을 위한 전주곡과 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5361792c-09d3-4e22-8655-1e7c3ecb3639'
);

