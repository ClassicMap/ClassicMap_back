-- 말러 작품을 출판 단위로 다시 짠다(카탈로그: 없음). 작품 20개(묶음 6, 다악장 11, 낱곡 3),
-- 새 작품 5개, 기존 작품 15개(seed 제목 고침 21개), part 82개, 그 아래 0개,
-- 기존 part 고쳐 씀 38개, 기존 작품 연결 13개. 카탈로그에 대응이 없는 seed 45개는 목록에서 숨긴다.
--
-- 정한 것
--   교향곡 10번은 5악장 작품(미완성 원본 MBID), 휠러 등 남의 완성판 seed 는 숨긴다.
--   교향곡 8번은 manual 218 의 part 를 두 부와 그 아래 대목으로 다시 짠다.
--
-- 공통: 자료는 seed_pipeline/curation/catalog-wave3-2026-10-12/<작곡가>/catalog.json·seed_map.json 이고,
-- 본문은 그 폴더의 gen_catalog.py 가 만든다. 위키백과 작품 목록을 기준으로 MusicBrainz work 와 맞췄다.
--   3차는 국제 시드가 원어 제목으로 넣어 둔 작품이 많은 작곡가다. seed_map.json 으로 seed 작품마다
--     work(카탈로그 작품 자리) / part(묶음·다악장 안 곡) / unmatched(남의 편곡·대중음악·번안·중복·범위 밖 등)를 정했다.
--   손대지 않은 seed(origin='seed', editor_locked=0)는 제목·갈래·번호를 카탈로그대로 고치고 잠근다.
--     part 로 이은 seed 는 「<작품> 중 "<곡>"」 꼴이 된다. 편집자가 잠근 seed 와 manual 은 제목을 바꾸지 않는다.
--   unmatched seed 는 hidden_reason='catalog_unmatched' 로 목록에서 숨긴다(지우지 않음, 상세는 열림).
--     비교 구간이 있거나 part 가 가리키는 작품, 단독으로 널리 연주되는 대목은 숨기지 않는다.
--   기존 seed part 중 카탈로그와 MBID 가 같은 것은 이름·순서·상위 part 를 고쳐 EDITOR_REVIEWED 로 올린다.
--     맞는 게 없는 seed part 는 확인 안 된 상태로 둔다(화면에 안 보임).
--   단위: 함께 출판된 곡은 묶음(작품 하나 + part), 악장은 part, 묶음 안 곡의 악장은 그 아래 part.
--     무대·대형 성악 작품은 seed 가 안의 대목을 가리킬 때만 part 를 둔다.
--   이름: 묶음 제목은 구별이 필요하면 끝에 카탈로그를 넣고 opus_number 를 비운 채 catalogue_system·number 를
--     채운다. 낱곡·다악장은 opus_number 에 카탈로그를 둔다. part 이름에는 "1번"·"1악장" 을 넣지 않는다.
--   빼는 것: 위작, 소실, 단편·스케치, 남의 작품 편곡, 민요 편곡(작곡가별 예외는 위에 적음), 같은 곡의 옛 판.
--   기존 작품: MBID 로 먼저, 없으면 카탈로그 번호로 맞춘다. manual 의 제목·설명·링크는 바꾸지 않고 비어 있는
--     작품번호·연도만 채운다. 기존 작품에 없는 원곡 MBID 는 식별자로 더한다.
--   두 번 돌려도 같다.

-- None 교향곡 1번 D장조 "거인"

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Langsam. Schleppend', part.name_en = 'I. Langsam. Schleppend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 217 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:f969bc33-3297-335b-9dcb-1840bfea4781' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Kräftig bewegt, doch nicht zu schnell', part.name_en = 'II. Kräftig bewegt, doch nicht zu schnell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 217 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:64cc1ef0-3471-352f-b84f-1e5f6b710339' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Feierlich und gemessen, ohne zu schleppen', part.name_en = 'III. Feierlich und gemessen, ohne zu schleppen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 217 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:b8810dc0-1b98-3623-b292-95ac2cd0d227' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Stürmisch bewegt', part.name_en = 'IV. Stürmisch bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 217 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:0d4b5498-40c4-32a7-8a25-d2c2e29c9301' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));


-- None 교향곡 2번 C단조 "부활"

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro maestoso', part.name_en = 'I. Allegro maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 215 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:e2332b37-71fa-34e9-b7d8-a4cc5d7327c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante moderato', part.name_en = 'II. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 215 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:896860b7-5bd5-3f1c-bb52-04017c312e7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'In ruhig fließender Bewegung', part.name_en = 'III. In ruhig fließender Bewegung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 215 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:590f829d-79b1-393e-9836-665ae8b4712d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Urlicht. Sehr feierlich, aber schlicht', part.name_en = 'IV. Urlicht. Sehr feierlich, aber schlicht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 215 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:79ec4415-159a-3be9-b244-693e3e7df617' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Im Tempo des Scherzos. Wild herausfahrend', part.name_en = 'V. Im Tempo des Scherzos. Wild herausfahrend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 215 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:58d48f47-eb56-3154-abb3-ceb54f2ba407' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));


-- None 교향곡 3번 D단조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kräftig. Entschieden', part.name_en = 'I. Kräftig. Entschieden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11933 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:ad5d1ca5-ea0c-3bd9-8420-d36f8f45159d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad5d1ca5-ea0c-3bd9-8420-d36f8f45159d', 1, 'I', 'Kräftig. Entschieden', 'I. Kräftig. Entschieden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11933 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad5d1ca5-ea0c-3bd9-8420-d36f8f45159d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tempo di Menuetto. Sehr mäßig', part.name_en = 'II. Tempo di Menuetto. Sehr mäßig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11933 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:272693bb-ac54-3bbf-a66e-2a96de02da1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:272693bb-ac54-3bbf-a66e-2a96de02da1f', 2, 'II', 'Tempo di Menuetto. Sehr mäßig', 'II. Tempo di Menuetto. Sehr mäßig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11933 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:272693bb-ac54-3bbf-a66e-2a96de02da1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Comodo. Scherzando. Ohne Hast', part.name_en = 'III. Comodo. Scherzando. Ohne Hast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11933 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:2a83aea9-ab2a-3d91-a6bf-797c1e39fee0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a83aea9-ab2a-3d91-a6bf-797c1e39fee0', 3, 'III', 'Comodo. Scherzando. Ohne Hast', 'III. Comodo. Scherzando. Ohne Hast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11933 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a83aea9-ab2a-3d91-a6bf-797c1e39fee0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sehr langsam. Misterioso (O Mensch! Gib acht!)', part.name_en = 'IV. Sehr langsam. Misterioso (O Mensch! Gib acht!)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11933 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:513e3c93-8bc2-3580-8b3a-5337c95766ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:513e3c93-8bc2-3580-8b3a-5337c95766ba', 4, 'IV', 'Sehr langsam. Misterioso (O Mensch! Gib acht!)', 'IV. Sehr langsam. Misterioso (O Mensch! Gib acht!)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11933 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:513e3c93-8bc2-3580-8b3a-5337c95766ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Lustig im Tempo und keck im Ausdruck (Es sungen drei Engel)', part.name_en = 'V. Lustig im Tempo und keck im Ausdruck (Es sungen drei Engel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11933 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:73ca1dd6-9eaa-32ff-9d08-eadbf223ed47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73ca1dd6-9eaa-32ff-9d08-eadbf223ed47', 5, 'V', 'Lustig im Tempo und keck im Ausdruck (Es sungen drei Engel)', 'V. Lustig im Tempo und keck im Ausdruck (Es sungen drei Engel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11933 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73ca1dd6-9eaa-32ff-9d08-eadbf223ed47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Langsam. Ruhevoll. Empfunden', part.name_en = 'VI. Langsam. Ruhevoll. Empfunden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11933 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:d7cc7c86-5a33-36f9-8e0b-3e3231ac0973' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7cc7c86-5a33-36f9-8e0b-3e3231ac0973', 6, 'VI', 'Langsam. Ruhevoll. Empfunden', 'VI. Langsam. Ruhevoll. Empfunden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11933 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7cc7c86-5a33-36f9-8e0b-3e3231ac0973'
);


-- None 교향곡 4번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 4번 G장조', 'Symphony No. 4 in G major', 'album', NULL, NULL, NULL, 1900, 'manual', 1
FROM composers c
WHERE c.id = 49
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 4번 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b99a498c-2a7d-4e1d-85e5-9e60808b16f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b99a498c-2a7d-4e1d-85e5-9e60808b16f1'
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '교향곡 4번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b99a498c-2a7d-4e1d-85e5-9e60808b16f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4129ef42-6441-30e6-a91e-7de840011cc7', 1, 'I', 'Bedächtig. Nicht eilen – Recht gemächlich', 'I. Bedächtig. Nicht eilen – Recht gemächlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '교향곡 4번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4129ef42-6441-30e6-a91e-7de840011cc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8186d96c-4bad-3539-82b0-b864cdd65900', 2, 'II', 'In gemächlicher Bewegung. Ohne Hast', 'II. In gemächlicher Bewegung. Ohne Hast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '교향곡 4번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8186d96c-4bad-3539-82b0-b864cdd65900'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f45c78d2-4857-3256-9ee7-3e04c5fe6e1f', 3, 'III', 'Ruhevoll. Poco adagio', 'III. Ruhevoll. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '교향곡 4번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f45c78d2-4857-3256-9ee7-3e04c5fe6e1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11723 AND linked.composer_id = 49), 'musicbrainz:fcfa102f-0093-3f1d-a1fa-1d38e4ce5a02', 4, 'IV', 'Sehr behaglich (Das himmlische Leben)', 'IV. Sehr behaglich (Das himmlische Leben)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '교향곡 4번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcfa102f-0093-3f1d-a1fa-1d38e4ce5a02'
);

UPDATE pieces piece
SET piece.title = '교향곡 4번 G장조 중 "Sehr behaglich (Das himmlische Leben)"', piece.title_en = 'Symphony No. 4 in G major: IV. Sehr behaglich (Das himmlische Leben)', piece.editor_locked = 1
WHERE piece.id = 11723 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 5번 C#단조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '장송 행진곡. In gemessenem Schritt. Streng. Wie ein Kondukt', part.name_en = 'I. Trauermarsch. In gemessenem Schritt. Streng. Wie ein Kondukt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 216 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:fa02dc03-f548-3815-b7be-0df54e364dc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa02dc03-f548-3815-b7be-0df54e364dc9', 1, 'I', '장송 행진곡. In gemessenem Schritt. Streng. Wie ein Kondukt', 'I. Trauermarsch. In gemessenem Schritt. Streng. Wie ein Kondukt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 216 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa02dc03-f548-3815-b7be-0df54e364dc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Stürmisch bewegt. Mit größter Vehemenz', part.name_en = 'II. Stürmisch bewegt. Mit größter Vehemenz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 216 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:08354077-7053-36d0-b59f-ce4017e9c642' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08354077-7053-36d0-b59f-ce4017e9c642', 2, 'II', 'Stürmisch bewegt. Mit größter Vehemenz', 'II. Stürmisch bewegt. Mit größter Vehemenz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 216 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08354077-7053-36d0-b59f-ce4017e9c642'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Kräftig, nicht zu schnell', part.name_en = 'III. Scherzo. Kräftig, nicht zu schnell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 216 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:1cc08a7b-f89c-30ea-8a49-2ed2b0ecfb8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cc08a7b-f89c-30ea-8a49-2ed2b0ecfb8b', 3, 'III', '스케르초. Kräftig, nicht zu schnell', 'III. Scherzo. Kräftig, nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 216 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cc08a7b-f89c-30ea-8a49-2ed2b0ecfb8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagietto. Sehr langsam', part.name_en = 'IV. Adagietto. Sehr langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 216 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:acf009a9-1d24-3c0f-badd-3fa722316d26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acf009a9-1d24-3c0f-badd-3fa722316d26', 4, 'IV', 'Adagietto. Sehr langsam', 'IV. Adagietto. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 216 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acf009a9-1d24-3c0f-badd-3fa722316d26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '론도-피날레. Allegro – Allegro giocoso. Frisch', part.name_en = 'V. Rondo-Finale. Allegro – Allegro giocoso. Frisch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 216 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:450e8aaa-2cca-3ecc-aedc-e5ab00910fee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:450e8aaa-2cca-3ecc-aedc-e5ab00910fee', 5, 'V', '론도-피날레. Allegro – Allegro giocoso. Frisch', 'V. Rondo-Finale. Allegro – Allegro giocoso. Frisch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 216 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:450e8aaa-2cca-3ecc-aedc-e5ab00910fee'
);


-- None 교향곡 6번 A단조 "비극적"

UPDATE pieces piece
SET piece.title = '교향곡 6번 A단조 "비극적"', piece.title_en = 'Symphony No. 6 in A minor "Tragic"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1904, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11368 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1904
WHERE piece.id = 11368 AND piece.composer_id = 49 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro energico, ma non troppo. Heftig, aber markig', part.name_en = 'I. Allegro energico, ma non troppo. Heftig, aber markig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11368 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:7ae4f7eb-2981-3919-a426-bf6d330694e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ae4f7eb-2981-3919-a426-bf6d330694e2', 1, 'I', 'Allegro energico, ma non troppo. Heftig, aber markig', 'I. Allegro energico, ma non troppo. Heftig, aber markig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11368 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ae4f7eb-2981-3919-a426-bf6d330694e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante moderato', part.name_en = 'II. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11368 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:c6c4f4ad-6ee8-374d-bbfe-86c918bae80c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6c4f4ad-6ee8-374d-bbfe-86c918bae80c', 2, 'II', 'Andante moderato', 'II. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11368 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6c4f4ad-6ee8-374d-bbfe-86c918bae80c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Wuchtig', part.name_en = 'III. Scherzo. Wuchtig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11368 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:00dca803-085d-3afd-9269-c3583bd29eae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00dca803-085d-3afd-9269-c3583bd29eae', 3, 'III', '스케르초. Wuchtig', 'III. Scherzo. Wuchtig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11368 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00dca803-085d-3afd-9269-c3583bd29eae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Sostenuto – Allegro moderato – Allegro energico', part.name_en = 'IV. Finale. Sostenuto – Allegro moderato – Allegro energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11368 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:3fb85d59-c7be-3095-9dcb-ff2a1d52fa36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fb85d59-c7be-3095-9dcb-ff2a1d52fa36', 4, 'IV', '피날레. Sostenuto – Allegro moderato – Allegro energico', 'IV. Finale. Sostenuto – Allegro moderato – Allegro energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11368 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fb85d59-c7be-3095-9dcb-ff2a1d52fa36'
);


-- None 교향곡 7번 E단조 "밤의 노래"

UPDATE pieces piece
SET piece.title = '교향곡 7번 E단조 "밤의 노래"', piece.title_en = 'Symphony No. 7 in E minor "Song of the Night"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2163 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 2163 AND piece.composer_id = 49 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Langsam – Allegro risoluto, ma non troppo', part.name_en = 'I. Langsam – Allegro risoluto, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2163 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:05afa1c5-d31c-36eb-bd97-9de0b279382b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05afa1c5-d31c-36eb-bd97-9de0b279382b', 1, 'I', 'Langsam – Allegro risoluto, ma non troppo', 'I. Langsam – Allegro risoluto, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2163 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05afa1c5-d31c-36eb-bd97-9de0b279382b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '밤의 음악 I. Allegro moderato', part.name_en = 'II. Nachtmusik I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2163 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:dc83ae84-22ae-352d-9bae-d6c869408f93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc83ae84-22ae-352d-9bae-d6c869408f93', 2, 'II', '밤의 음악 I. Allegro moderato', 'II. Nachtmusik I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2163 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc83ae84-22ae-352d-9bae-d6c869408f93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Schattenhaft', part.name_en = 'III. Scherzo. Schattenhaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2163 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:62ce5272-adfb-3891-9baf-32bbd1cc430b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62ce5272-adfb-3891-9baf-32bbd1cc430b', 3, 'III', '스케르초. Schattenhaft', 'III. Scherzo. Schattenhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2163 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62ce5272-adfb-3891-9baf-32bbd1cc430b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '밤의 음악 II. Andante amoroso', part.name_en = 'IV. Nachtmusik II. Andante amoroso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2163 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:6cba7ea1-f729-37e5-9c38-c113dfc0dcff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cba7ea1-f729-37e5-9c38-c113dfc0dcff', 4, 'IV', '밤의 음악 II. Andante amoroso', 'IV. Nachtmusik II. Andante amoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2163 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cba7ea1-f729-37e5-9c38-c113dfc0dcff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '론도-피날레. Tempo I (Allegro ordinario)', part.name_en = 'V. Rondo-Finale. Tempo I (Allegro ordinario)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2163 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:d1c3a25b-4654-3b8f-836c-eed4d24074e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1c3a25b-4654-3b8f-836c-eed4d24074e3', 5, 'V', '론도-피날레. Tempo I (Allegro ordinario)', 'V. Rondo-Finale. Tempo I (Allegro ordinario)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2163 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1c3a25b-4654-3b8f-836c-eed4d24074e3'
);


-- None 교향곡 8번 E♭장조 "천인 교향곡"

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '제1부: 찬가 "Veni, creator spiritus"', part.name_en = 'I. Hymnus "Veni, creator spiritus"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:0c95618f-ff44-3ec3-979f-44b578905062' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c95618f-ff44-3ec3-979f-44b578905062'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Veni, creator spiritus', part.name_en = 'a. Veni, creator spiritus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:9293a139-8b77-3673-80dc-a40db6c7345c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c95618f-ff44-3ec3-979f-44b578905062'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Imple superna gratia', part.name_en = 'b. Imple superna gratia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:612904bf-21c2-371d-b9e3-9fe78a36cc08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c95618f-ff44-3ec3-979f-44b578905062'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Infirma nostri corporis', part.name_en = 'c. Infirma nostri corporis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:56f706dc-f4f5-3684-935f-741c59b7b159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c95618f-ff44-3ec3-979f-44b578905062'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tempo I. Allegro, etwas hastig', part.name_en = 'd. Tempo I. Allegro, etwas hastig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:a05a16da-8d4f-3f51-9b52-1509836775a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c95618f-ff44-3ec3-979f-44b578905062'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Infirma nostri corporis (독창진)', part.name_en = 'e. Infirma nostri corporis (soloists)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:7cb55b01-d466-30df-9d9a-3d2dbf7e1eb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c95618f-ff44-3ec3-979f-44b578905062'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Accende lumen sensibus', part.name_en = 'f. Accende lumen sensibus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:c3ae5b3f-20c6-472d-a2ae-971bfc5ffa50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c95618f-ff44-3ec3-979f-44b578905062'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Tu septiformis munere', part.name_en = 'g. Tu septiformis munere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:fe65091e-0def-3df7-a3a8-76575eb6b43d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c95618f-ff44-3ec3-979f-44b578905062'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Veni, creator spiritus (재현)', part.name_en = 'g. Veni, creator spiritus (reprise)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:4d68aa67-d4df-4a2f-bf40-83f4c9f158d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c95618f-ff44-3ec3-979f-44b578905062'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Gloria sit Patri Domino', part.name_en = 'h. Gloria sit Patri Domino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:7b75b61f-2fcb-464c-9fd0-409a458f582b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '제2부: 괴테 <파우스트>의 마지막 장면', part.name_en = 'II. Schlussszene aus Goethes "Faust"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Poco adagio', part.name_en = 'a. Poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:9770b2b0-7ff0-3a67-aff2-01db2c818acf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Più mosso. Allegro moderato', part.name_en = 'b. Più mosso. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:731134e9-c083-35ce-89b6-3ed4c26ae1fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Waldung, sie schwankt heran', part.name_en = 'c. Waldung, sie schwankt heran (Chorus and Echo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:ea293fa4-c8e8-32ea-9e7a-192973b1045f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ewiger Wonnebrand', part.name_en = 'd. Ewiger Wonnebrand (Pater Ecstaticus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:4054237f-fff9-3ceb-b777-a96453adf323' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Wie Felsenabgrund mir zu Füßen', part.name_en = 'e. Wie Felsenabgrund mir zu Füßen (Pater Profundus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:7f6dc019-f5e9-354b-a2be-dadca7c59a50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Gerettet ist das edle Glied', part.name_en = 'f. Gerettet ist das edle Glied (Angels)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:a6cb9549-9aa7-3ab3-8349-66dbd5e555f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Jene Rosen, aus den Händen', part.name_en = 'g1. Jene Rosen, aus den Händen (Angels)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:3d1e97e8-1462-33d2-a7ee-bb9e23273c4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Uns bleibt ein Erdenrest', part.name_en = 'g2. Uns bleibt ein Erdenrest (Angels)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:8c053d91-3400-371b-9a76-5fc2864392c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Ich spür'' soeben', part.name_en = 'h1. Ich spür'' soeben (Younger Angels)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:1e26744b-f4cf-31f2-a310-f30bf2f9c046' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Hier ist die Aussicht frei', part.name_en = 'h2. Hier ist die Aussicht frei (Doctor Marianus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:1caf5bc6-9451-3243-a736-2a70f0609b7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Höchste Herrscherin der Welt', part.name_en = 'i. Höchste Herrscherin der Welt (Doctor Marianus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:d6c31783-9e42-3147-b32d-8ecb21c1f13b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Dir, der Unberührbaren', part.name_en = 'j. Dir, der Unberührbaren (Chorus, Una Poenitentium)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:a24d9b34-b7f0-3e21-adba-c4794119b1f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Bei der Liebe, die den Füßen', part.name_en = 'k. Bei der Liebe, die den Füßen (Magna Peccatrix, Mulier Samaritana, Maria Aegyptiaca)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:03e92368-8ba8-31a0-aa80-68516a782125' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Neige, neige, du Ohnegleiche', part.name_en = 'l. Neige, neige, du Ohnegleiche (Una Poenitentium)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:bfa4e616-0353-37dc-b023-53048d83328d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Er überwächst uns schon', part.name_en = 'm. Er überwächst uns schon (Boys'' Chorus, Una Poenitentium)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:42186602-b5b0-3173-90da-568e1128f212' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11929 AND linked.composer_id = 49),
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Komm! Hebe dich zu höhern Sphären!', part.name_en = 'n. Komm! Hebe dich zu höhern Sphären! (Mater Gloriosa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:609f9630-4e69-3f3e-a802-4b951db438d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE pieces piece
SET piece.title = '교향곡 8번 E♭장조 "천인 교향곡" 제2부: 괴테 <파우스트>의 마지막 장면 중 "Komm! Hebe dich zu höhern Sphären!"', piece.title_en = 'Symphony No. 8 in E♭ major "Symphony of a Thousand", II. Schlussszene aus Goethes "Faust": n. Komm! Hebe dich zu höhern Sphären! (Mater Gloriosa)', piece.editor_locked = 1
WHERE piece.id = 11929 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Blicket auf zum Retterblick', part.name_en = 'o. Blicket auf zum Retterblick (Doctor Marianus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:65e65c2e-22fb-381e-8158-9d8959e39e81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a472ec39-13d9-3549-8f17-67dd7907edd3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11867 AND linked.composer_id = 49),
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Alles Vergängliche', part.name_en = 'p. Alles Vergängliche (Chorus mysticus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 218 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:299b72e0-dc92-351d-a0d4-59f7be8e917b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE pieces piece
SET piece.title = '교향곡 8번 E♭장조 "천인 교향곡" 제2부: 괴테 <파우스트>의 마지막 장면 중 "Alles Vergängliche"', piece.title_en = 'Symphony No. 8 in E♭ major "Symphony of a Thousand", II. Schlussszene aus Goethes "Faust": p. Alles Vergängliche (Chorus mysticus)', piece.editor_locked = 1
WHERE piece.id = 11867 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 대지의 노래

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Das Trinklied vom Jammer der Erde', part.name_en = 'I. Das Trinklied vom Jammer der Erde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 219 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:ff15c2ab-0775-3757-975a-331357299635' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff15c2ab-0775-3757-975a-331357299635', 1, 'I', 'Das Trinklied vom Jammer der Erde', 'I. Das Trinklied vom Jammer der Erde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 219 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff15c2ab-0775-3757-975a-331357299635'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Der Einsame im Herbst', part.name_en = 'II. Der Einsame im Herbst',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 219 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:dbd032de-ebe3-3201-b0aa-04196651003b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbd032de-ebe3-3201-b0aa-04196651003b', 2, 'II', 'Der Einsame im Herbst', 'II. Der Einsame im Herbst', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 219 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbd032de-ebe3-3201-b0aa-04196651003b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Von der Jugend', part.name_en = 'III. Von der Jugend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 219 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:d17ba9db-beeb-30d7-aab4-5574de50d1ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d17ba9db-beeb-30d7-aab4-5574de50d1ff', 3, 'III', 'Von der Jugend', 'III. Von der Jugend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 219 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d17ba9db-beeb-30d7-aab4-5574de50d1ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Von der Schönheit', part.name_en = 'IV. Von der Schönheit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 219 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:743d20f7-b7f5-375b-b262-e5666fcefb8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:743d20f7-b7f5-375b-b262-e5666fcefb8f', 4, 'IV', 'Von der Schönheit', 'IV. Von der Schönheit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 219 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:743d20f7-b7f5-375b-b262-e5666fcefb8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Der Trunkene im Frühling', part.name_en = 'V. Der Trunkene im Frühling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 219 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:4818ba28-bade-309d-9efa-8e2a3cfc425b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4818ba28-bade-309d-9efa-8e2a3cfc425b', 5, 'V', 'Der Trunkene im Frühling', 'V. Der Trunkene im Frühling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 219 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4818ba28-bade-309d-9efa-8e2a3cfc425b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Der Abschied', part.name_en = 'VI. Der Abschied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 219 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:7b696cdf-7241-3157-87b3-7c5a6f0bb558' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b696cdf-7241-3157-87b3-7c5a6f0bb558', 6, 'VI', 'Der Abschied', 'VI. Der Abschied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 219 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b696cdf-7241-3157-87b3-7c5a6f0bb558'
);


-- None 교향곡 9번 D장조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante comodo', part.name_en = 'I. Andante comodo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11293 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:22cc1e5f-0796-3bbf-9cb4-61aea8825917' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22cc1e5f-0796-3bbf-9cb4-61aea8825917', 1, 'I', 'Andante comodo', 'I. Andante comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11293 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22cc1e5f-0796-3bbf-9cb4-61aea8825917'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Im Tempo eines gemächlichen Ländlers. Etwas täppisch und sehr derb', part.name_en = 'II. Im Tempo eines gemächlichen Ländlers. Etwas täppisch und sehr derb',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11293 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:1b592ca5-fdd6-33e7-8a12-c8244f6bbd31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b592ca5-fdd6-33e7-8a12-c8244f6bbd31', 2, 'II', 'Im Tempo eines gemächlichen Ländlers. Etwas täppisch und sehr derb', 'II. Im Tempo eines gemächlichen Ländlers. Etwas täppisch und sehr derb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11293 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b592ca5-fdd6-33e7-8a12-c8244f6bbd31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '론도-부를레스케. Allegro assai. Sehr trotzig', part.name_en = 'III. Rondo-Burleske. Allegro assai. Sehr trotzig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11293 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:a4a289b5-fdbb-32b7-a461-de1df6005a98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4a289b5-fdbb-32b7-a461-de1df6005a98', 3, 'III', '론도-부를레스케. Allegro assai. Sehr trotzig', 'III. Rondo-Burleske. Allegro assai. Sehr trotzig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11293 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4a289b5-fdbb-32b7-a461-de1df6005a98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio. Sehr langsam und noch zurückhaltend', part.name_en = 'IV. Adagio. Sehr langsam und noch zurückhaltend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11293 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:625ebe22-7673-35da-8f5e-bd96c69a5089' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:625ebe22-7673-35da-8f5e-bd96c69a5089', 4, 'IV', 'Adagio. Sehr langsam und noch zurückhaltend', 'IV. Adagio. Sehr langsam und noch zurückhaltend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11293 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:625ebe22-7673-35da-8f5e-bd96c69a5089'
);


-- None 교향곡 10번 F#장조

UPDATE pieces piece
SET piece.title = '교향곡 10번 F#장조', piece.title_en = 'Symphony No. 10 in F# major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1910, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2575 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1910
WHERE piece.id = 2575 AND piece.composer_id = 49 AND piece.composition_year IS NULL;
INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eff9bd21-8ba3-4a16-832b-d241c280ed8a'
FROM pieces p
WHERE p.id = 2575 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eff9bd21-8ba3-4a16-832b-d241c280ed8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante – Adagio', part.name_en = 'I. Andante – Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2575 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:06181625-4a4a-3957-8cc1-a513febb4d5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06181625-4a4a-3957-8cc1-a513febb4d5d', 1, 'I', 'Andante – Adagio', 'I. Andante – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2575 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06181625-4a4a-3957-8cc1-a513febb4d5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초. Schnelle Vierteln', part.name_en = 'II. Scherzo. Schnelle Vierteln',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2575 AND p.composer_id = 49 AND part.part_key = 'classicmap:mahler:mahler-symphony-10:2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:mahler:mahler-symphony-10:2', 2, 'II', '스케르초. Schnelle Vierteln', 'II. Scherzo. Schnelle Vierteln', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2575 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:mahler:mahler-symphony-10:2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Purgatorio. Allegretto moderato', part.name_en = 'III. Purgatorio. Allegretto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2575 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:663a7c2b-eebe-3501-8838-8818538eb5d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:663a7c2b-eebe-3501-8838-8818538eb5d4', 3, 'III', 'Purgatorio. Allegretto moderato', 'III. Purgatorio. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2575 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:663a7c2b-eebe-3501-8838-8818538eb5d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '스케르초. Allegro pesante. Nicht zu schnell', part.name_en = 'IV. [Scherzo]. Allegro pesante. Nicht zu schnell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2575 AND p.composer_id = 49 AND part.part_key = 'classicmap:mahler:mahler-symphony-10:4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:mahler:mahler-symphony-10:4', 4, 'IV', '스케르초. Allegro pesante. Nicht zu schnell', 'IV. [Scherzo]. Allegro pesante. Nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2575 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:mahler:mahler-symphony-10:4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '피날레. Langsam, schwer', part.name_en = 'V. Finale. Langsam, schwer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2575 AND p.composer_id = 49 AND part.part_key = 'classicmap:mahler:mahler-symphony-10:5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:mahler:mahler-symphony-10:5', 5, 'V', '피날레. Langsam, schwer', 'V. Finale. Langsam, schwer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2575 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:mahler:mahler-symphony-10:5'
);


-- None 교향적 악장 <블루미네>

UPDATE pieces piece
SET piece.title = '교향적 악장 <블루미네>', piece.title_en = 'Blumine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1888, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11322 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1888
WHERE piece.id = 11322 AND piece.composer_id = 49 AND piece.composition_year IS NULL;


-- None 피아노 4중주 악장 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 4중주 악장 A단조', 'Piano Quartet Movement in A minor', 'song', NULL, NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 49
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 4중주 악장 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd287a61f-bbc3-484b-a7f2-1bc3d7a2c4e4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd287a61f-bbc3-484b-a7f2-1bc3d7a2c4e4'
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '피아노 4중주 악장 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd287a61f-bbc3-484b-a7f2-1bc3d7a2c4e4'
);


-- None 칸타타 <탄식의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <탄식의 노래>', 'Das klagende Lied', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 49
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <탄식의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15911087-9545-46d5-90d7-18274ff283e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '15911087-9545-46d5-90d7-18274ff283e8'
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '칸타타 <탄식의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15911087-9545-46d5-90d7-18274ff283e8'
);


-- None 테너를 위한 3개의 가곡

UPDATE pieces piece
SET piece.title = '테너를 위한 3개의 가곡', piece.title_en = '3 Songs for Tenor and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11558 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 11558 AND piece.composer_id = 49 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Im Lenz', part.name_en = 'Im Lenz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11558 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:2ba277c4-2c86-358f-9fe4-90a57e44c7e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ba277c4-2c86-358f-9fe4-90a57e44c7e3', 1, NULL, 'Im Lenz', 'Im Lenz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11558 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ba277c4-2c86-358f-9fe4-90a57e44c7e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Winterlied', part.name_en = 'Winterlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11558 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:874d58c4-62be-3d84-8199-83dcccd0b2be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:874d58c4-62be-3d84-8199-83dcccd0b2be', 2, NULL, 'Winterlied', 'Winterlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11558 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:874d58c4-62be-3d84-8199-83dcccd0b2be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Maitanz im Grünen', part.name_en = 'Maitanz im Grünen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11558 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:702527d8-010f-3b2c-95d4-f428224b444a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:702527d8-010f-3b2c-95d4-f428224b444a', 3, NULL, 'Maitanz im Grünen', 'Maitanz im Grünen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11558 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:702527d8-010f-3b2c-95d4-f428224b444a'
);


-- None 가곡집 <젊은 날의 노래>

UPDATE pieces piece
SET piece.title = '가곡집 <젊은 날의 노래>', piece.title_en = 'Lieder und Gesänge',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11298 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 11298 AND piece.composer_id = 49 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Frühlingsmorgen', part.name_en = 'Frühlingsmorgen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:db8a6ed4-5998-35ee-81fc-73d95560f1e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db8a6ed4-5998-35ee-81fc-73d95560f1e3', 1, NULL, 'Frühlingsmorgen', 'Frühlingsmorgen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db8a6ed4-5998-35ee-81fc-73d95560f1e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Erinnerung', part.name_en = 'Erinnerung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:a0f80dc8-9a9c-3368-bbda-f08e053a1868' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0f80dc8-9a9c-3368-bbda-f08e053a1868', 2, NULL, 'Erinnerung', 'Erinnerung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0f80dc8-9a9c-3368-bbda-f08e053a1868'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Hans und Grete', part.name_en = 'Hans und Grete',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:7b6bc23e-6c1c-3478-82b2-a80b41ac0058' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b6bc23e-6c1c-3478-82b2-a80b41ac0058', 3, NULL, 'Hans und Grete', 'Hans und Grete', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b6bc23e-6c1c-3478-82b2-a80b41ac0058'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Serenade aus Don Juan', part.name_en = 'Serenade aus Don Juan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:3ef7058a-7220-3955-b8e5-0894248340b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ef7058a-7220-3955-b8e5-0894248340b5', 4, NULL, 'Serenade aus Don Juan', 'Serenade aus Don Juan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ef7058a-7220-3955-b8e5-0894248340b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Phantasie aus Don Juan', part.name_en = 'Phantasie aus Don Juan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:641bfd3e-8e64-3fe6-b23b-b540b1cd66b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:641bfd3e-8e64-3fe6-b23b-b540b1cd66b0', 5, NULL, 'Phantasie aus Don Juan', 'Phantasie aus Don Juan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:641bfd3e-8e64-3fe6-b23b-b540b1cd66b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Um schlimme Kinder artig zu machen', part.name_en = 'Um schlimme Kinder artig zu machen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:14a4bf18-49f4-3c3d-9ba6-f596cc30cc5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14a4bf18-49f4-3c3d-9ba6-f596cc30cc5f', 6, NULL, 'Um schlimme Kinder artig zu machen', 'Um schlimme Kinder artig zu machen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14a4bf18-49f4-3c3d-9ba6-f596cc30cc5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ich ging mit Lust durch einen grünen Wald', part.name_en = 'Ich ging mit Lust durch einen grünen Wald',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:a867b146-2266-3949-9c76-c2ef588784bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a867b146-2266-3949-9c76-c2ef588784bb', 7, NULL, 'Ich ging mit Lust durch einen grünen Wald', 'Ich ging mit Lust durch einen grünen Wald', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a867b146-2266-3949-9c76-c2ef588784bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Aus! Aus!', part.name_en = 'Aus! Aus!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:d32a591a-8fed-344c-9d18-6498ebcc0712' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d32a591a-8fed-344c-9d18-6498ebcc0712', 8, NULL, 'Aus! Aus!', 'Aus! Aus!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d32a591a-8fed-344c-9d18-6498ebcc0712'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Starke Einbildungskraft', part.name_en = 'Starke Einbildungskraft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:7a2270db-76e0-3e2c-b8c8-0da847319003' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a2270db-76e0-3e2c-b8c8-0da847319003', 9, NULL, 'Starke Einbildungskraft', 'Starke Einbildungskraft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a2270db-76e0-3e2c-b8c8-0da847319003'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Zu Straßburg auf der Schanz''', part.name_en = 'Zu Straßburg auf der Schanz''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:59846f5f-9d4c-317a-bb46-6f950d7fa4d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59846f5f-9d4c-317a-bb46-6f950d7fa4d5', 10, NULL, 'Zu Straßburg auf der Schanz''', 'Zu Straßburg auf der Schanz''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59846f5f-9d4c-317a-bb46-6f950d7fa4d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Ablösung im Sommer', part.name_en = 'Ablösung im Sommer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:99557cb0-be6c-3600-9024-d38a77a3c0af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99557cb0-be6c-3600-9024-d38a77a3c0af', 11, NULL, 'Ablösung im Sommer', 'Ablösung im Sommer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99557cb0-be6c-3600-9024-d38a77a3c0af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Scheiden und Meiden', part.name_en = 'Scheiden und Meiden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:083355d6-72d2-3727-8c61-56c06c562a98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:083355d6-72d2-3727-8c61-56c06c562a98', 12, NULL, 'Scheiden und Meiden', 'Scheiden und Meiden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:083355d6-72d2-3727-8c61-56c06c562a98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Nicht wiedersehen!', part.name_en = 'Nicht wiedersehen!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:5df26b42-f7d7-39d9-b86e-75922c66bc6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5df26b42-f7d7-39d9-b86e-75922c66bc6e', 13, NULL, 'Nicht wiedersehen!', 'Nicht wiedersehen!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5df26b42-f7d7-39d9-b86e-75922c66bc6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Selbstgefühl', part.name_en = 'Selbstgefühl',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11298 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:1e4c6e75-d004-3c39-9dce-9950ce6aa9ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e4c6e75-d004-3c39-9dce-9950ce6aa9ac', 14, NULL, 'Selbstgefühl', 'Selbstgefühl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11298 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e4c6e75-d004-3c39-9dce-9950ce6aa9ac'
);


-- None 연가곡집 <방랑하는 젊은이의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <방랑하는 젊은이의 노래>', 'Lieder eines fahrenden Gesellen', 'album', NULL, NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 49
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <방랑하는 젊은이의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81c59ea4-0f41-45fd-a731-320b5fc00f7b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '81c59ea4-0f41-45fd-a731-320b5fc00f7b'
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '연가곡집 <방랑하는 젊은이의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81c59ea4-0f41-45fd-a731-320b5fc00f7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0071ccf9-a75a-3412-90a9-687a6b4eb5d4', 1, NULL, 'Wenn mein Schatz Hochzeit macht', 'Wenn mein Schatz Hochzeit macht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '연가곡집 <방랑하는 젊은이의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0071ccf9-a75a-3412-90a9-687a6b4eb5d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05cf27b7-4e55-3637-b98d-4c02c33ef158', 2, NULL, 'Ging heut'' Morgen übers Feld', 'Ging heut'' Morgen übers Feld', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '연가곡집 <방랑하는 젊은이의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05cf27b7-4e55-3637-b98d-4c02c33ef158'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:290b3609-ab9b-33fd-926a-bac06994e1be', 3, NULL, 'Ich hab'' ein glühend Messer', 'Ich hab'' ein glühend Messer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '연가곡집 <방랑하는 젊은이의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:290b3609-ab9b-33fd-926a-bac06994e1be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecb909b7-eca8-32ec-a545-fd24d17700e9', 4, NULL, 'Die zwei blauen Augen von meinem Schatz', 'Die zwei blauen Augen von meinem Schatz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '연가곡집 <방랑하는 젊은이의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecb909b7-eca8-32ec-a545-fd24d17700e9'
);


-- None 가곡집 <어린이의 이상한 뿔피리>

UPDATE pieces piece
SET piece.title = '가곡집 <어린이의 이상한 뿔피리>', piece.title_en = 'Lieder aus "Des Knaben Wunderhorn"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1901, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11439 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1901
WHERE piece.id = 11439 AND piece.composer_id = 49 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11589 AND linked.composer_id = 49),
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Der Schildwache Nachtlied', part.name_en = 'Der Schildwache Nachtlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11439 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:dc081a44-ec13-3955-b555-88ac52b57d02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11589 AND linked.composer_id = 49), 'musicbrainz:dc081a44-ec13-3955-b555-88ac52b57d02', 1, NULL, 'Der Schildwache Nachtlied', 'Der Schildwache Nachtlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11439 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc081a44-ec13-3955-b555-88ac52b57d02'
);

UPDATE pieces piece
SET piece.title = '가곡집 <어린이의 이상한 뿔피리> 중 "Der Schildwache Nachtlied"', piece.title_en = 'Lieder aus "Des Knaben Wunderhorn": Der Schildwache Nachtlied', piece.editor_locked = 1
WHERE piece.id = 11589 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Verlor''ne Müh', part.name_en = 'Verlor''ne Müh',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11439 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:46400950-717c-3558-8670-90063dd739b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46400950-717c-3558-8670-90063dd739b6', 2, NULL, 'Verlor''ne Müh', 'Verlor''ne Müh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11439 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46400950-717c-3558-8670-90063dd739b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Trost im Unglück', part.name_en = 'Trost im Unglück',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11439 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:993223bc-83bc-39ef-9bea-3c8911c54461' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:993223bc-83bc-39ef-9bea-3c8911c54461', 3, NULL, 'Trost im Unglück', 'Trost im Unglück', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11439 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:993223bc-83bc-39ef-9bea-3c8911c54461'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11408 AND linked.composer_id = 49),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Wer hat dies Liedlein erdacht?', part.name_en = 'Wer hat dies Liedlein erdacht?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11439 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:48c4b34a-ebd5-3d3c-8931-4d9b63d71315' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11408 AND linked.composer_id = 49), 'musicbrainz:48c4b34a-ebd5-3d3c-8931-4d9b63d71315', 4, NULL, 'Wer hat dies Liedlein erdacht?', 'Wer hat dies Liedlein erdacht?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11439 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48c4b34a-ebd5-3d3c-8931-4d9b63d71315'
);

UPDATE pieces piece
SET piece.title = '가곡집 <어린이의 이상한 뿔피리> 중 "Wer hat dies Liedlein erdacht?"', piece.title_en = 'Lieder aus "Des Knaben Wunderhorn": Wer hat dies Liedlein erdacht?', piece.editor_locked = 1
WHERE piece.id = 11408 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11573 AND linked.composer_id = 49),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Das irdische Leben', part.name_en = 'Das irdische Leben',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11439 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:9fc33034-4946-3dde-9050-8d93ddc387e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11573 AND linked.composer_id = 49), 'musicbrainz:9fc33034-4946-3dde-9050-8d93ddc387e3', 5, NULL, 'Das irdische Leben', 'Das irdische Leben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11439 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fc33034-4946-3dde-9050-8d93ddc387e3'
);

UPDATE pieces piece
SET piece.title = '가곡집 <어린이의 이상한 뿔피리> 중 "Das irdische Leben"', piece.title_en = 'Lieder aus "Des Knaben Wunderhorn": Das irdische Leben', piece.editor_locked = 1
WHERE piece.id = 11573 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11684 AND linked.composer_id = 49),
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Des Antonius von Padua Fischpredigt', part.name_en = 'Des Antonius von Padua Fischpredigt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11439 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:fe81bf4f-a609-389e-a966-2102193bc11a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11684 AND linked.composer_id = 49), 'musicbrainz:fe81bf4f-a609-389e-a966-2102193bc11a', 6, NULL, 'Des Antonius von Padua Fischpredigt', 'Des Antonius von Padua Fischpredigt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11439 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe81bf4f-a609-389e-a966-2102193bc11a'
);

UPDATE pieces piece
SET piece.title = '가곡집 <어린이의 이상한 뿔피리> 중 "Des Antonius von Padua Fischpredigt"', piece.title_en = 'Lieder aus "Des Knaben Wunderhorn": Des Antonius von Padua Fischpredigt', piece.editor_locked = 1
WHERE piece.id = 11684 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11968 AND linked.composer_id = 49),
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Rheinlegendchen', part.name_en = 'Rheinlegendchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11439 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:3d010498-cdc9-30cc-b61a-51408d02476d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11968 AND linked.composer_id = 49), 'musicbrainz:3d010498-cdc9-30cc-b61a-51408d02476d', 7, NULL, 'Rheinlegendchen', 'Rheinlegendchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11439 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d010498-cdc9-30cc-b61a-51408d02476d'
);

UPDATE pieces piece
SET piece.title = '가곡집 <어린이의 이상한 뿔피리> 중 "Rheinlegendchen"', piece.title_en = 'Lieder aus "Des Knaben Wunderhorn": Rheinlegendchen', piece.editor_locked = 1
WHERE piece.id = 11968 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Lied des Verfolgten im Turm', part.name_en = 'Lied des Verfolgten im Turm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11439 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:4d265bfd-6d84-3fcb-992e-07a997858595' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d265bfd-6d84-3fcb-992e-07a997858595', 8, NULL, 'Lied des Verfolgten im Turm', 'Lied des Verfolgten im Turm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11439 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d265bfd-6d84-3fcb-992e-07a997858595'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11854 AND linked.composer_id = 49),
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Wo die schönen Trompeten blasen', part.name_en = 'Wo die schönen Trompeten blasen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11439 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:fe408c3e-08c9-3e22-ad1d-b947349680fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11854 AND linked.composer_id = 49), 'musicbrainz:fe408c3e-08c9-3e22-ad1d-b947349680fd', 9, NULL, 'Wo die schönen Trompeten blasen', 'Wo die schönen Trompeten blasen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11439 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe408c3e-08c9-3e22-ad1d-b947349680fd'
);

UPDATE pieces piece
SET piece.title = '가곡집 <어린이의 이상한 뿔피리> 중 "Wo die schönen Trompeten blasen"', piece.title_en = 'Lieder aus "Des Knaben Wunderhorn": Wo die schönen Trompeten blasen', piece.editor_locked = 1
WHERE piece.id = 11854 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11419 AND linked.composer_id = 49),
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Lob des hohen Verstandes', part.name_en = 'Lob des hohen Verstandes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11439 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:31bc8a21-662e-3398-b96e-8afd69f930c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11419 AND linked.composer_id = 49), 'musicbrainz:31bc8a21-662e-3398-b96e-8afd69f930c9', 10, NULL, 'Lob des hohen Verstandes', 'Lob des hohen Verstandes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11439 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31bc8a21-662e-3398-b96e-8afd69f930c9'
);

UPDATE pieces piece
SET piece.title = '가곡집 <어린이의 이상한 뿔피리> 중 "Lob des hohen Verstandes"', piece.title_en = 'Lieder aus "Des Knaben Wunderhorn": Lob des hohen Verstandes', piece.editor_locked = 1
WHERE piece.id = 11419 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Revelge', part.name_en = 'Revelge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11439 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:8c5202a5-9d74-38b5-9d5c-a29c91a3ed6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c5202a5-9d74-38b5-9d5c-a29c91a3ed6f', 11, NULL, 'Revelge', 'Revelge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11439 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c5202a5-9d74-38b5-9d5c-a29c91a3ed6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Der Tamboursg''sell', part.name_en = 'Der Tamboursg''sell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11439 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:7ae37316-4c6c-32a6-9cfe-2dd6bd206054' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ae37316-4c6c-32a6-9cfe-2dd6bd206054', 12, NULL, 'Der Tamboursg''sell', 'Der Tamboursg''sell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11439 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ae37316-4c6c-32a6-9cfe-2dd6bd206054'
);


-- None 가곡집 <뤼케르트 가곡>

UPDATE pieces piece
SET piece.title = '가곡집 <뤼케르트 가곡>', piece.title_en = 'Rückert-Lieder',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1902, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11339 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1902
WHERE piece.id = 11339 AND piece.composer_id = 49 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Blicke mir nicht in die Lieder!', part.name_en = 'Blicke mir nicht in die Lieder!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11339 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:da3b3f93-f7be-3c82-bf2a-7f72f0782180' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da3b3f93-f7be-3c82-bf2a-7f72f0782180', 1, NULL, 'Blicke mir nicht in die Lieder!', 'Blicke mir nicht in die Lieder!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11339 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da3b3f93-f7be-3c82-bf2a-7f72f0782180'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11896 AND linked.composer_id = 49),
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ich atmet'' einen linden Duft', part.name_en = 'Ich atmet'' einen linden Duft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11339 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:bdfc63a3-23bc-3e1a-b875-a6430a5f5e42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11896 AND linked.composer_id = 49), 'musicbrainz:bdfc63a3-23bc-3e1a-b875-a6430a5f5e42', 2, NULL, 'Ich atmet'' einen linden Duft', 'Ich atmet'' einen linden Duft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11339 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdfc63a3-23bc-3e1a-b875-a6430a5f5e42'
);

UPDATE pieces piece
SET piece.title = '가곡집 <뤼케르트 가곡> 중 "Ich atmet'' einen linden Duft"', piece.title_en = 'Rückert-Lieder: Ich atmet'' einen linden Duft', piece.editor_locked = 1
WHERE piece.id = 11896 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 12006 AND linked.composer_id = 49),
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '나는 세상에서 잊혀지고 (Ich bin der Welt abhanden gekommen)', part.name_en = 'Ich bin der Welt abhanden gekommen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11339 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:f0769b09-d35d-30e0-9a12-5f6584f7fedd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 12006 AND linked.composer_id = 49), 'musicbrainz:f0769b09-d35d-30e0-9a12-5f6584f7fedd', 3, NULL, '나는 세상에서 잊혀지고 (Ich bin der Welt abhanden gekommen)', 'Ich bin der Welt abhanden gekommen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11339 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0769b09-d35d-30e0-9a12-5f6584f7fedd'
);

UPDATE pieces piece
SET piece.title = '가곡집 <뤼케르트 가곡> 중 "나는 세상에서 잊혀지고 (Ich bin der Welt abhanden gekommen)"', piece.title_en = 'Rückert-Lieder: Ich bin der Welt abhanden gekommen', piece.editor_locked = 1
WHERE piece.id = 12006 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Um Mitternacht', part.name_en = 'Um Mitternacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11339 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:51420712-b3bb-3628-a7de-7999792ae30c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51420712-b3bb-3628-a7de-7999792ae30c', 4, NULL, 'Um Mitternacht', 'Um Mitternacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11339 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51420712-b3bb-3628-a7de-7999792ae30c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11888 AND linked.composer_id = 49),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Liebst du um Schönheit', part.name_en = 'Liebst du um Schönheit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11339 AND p.composer_id = 49 AND part.part_key = 'musicbrainz:b5c22a24-35c3-3197-9e80-8060e4581368' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11888 AND linked.composer_id = 49), 'musicbrainz:b5c22a24-35c3-3197-9e80-8060e4581368', 5, NULL, 'Liebst du um Schönheit', 'Liebst du um Schönheit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11339 AND p.composer_id = 49
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5c22a24-35c3-3197-9e80-8060e4581368'
);

UPDATE pieces piece
SET piece.title = '가곡집 <뤼케르트 가곡> 중 "Liebst du um Schönheit"', piece.title_en = 'Rückert-Lieder: Liebst du um Schönheit', piece.editor_locked = 1
WHERE piece.id = 11888 AND piece.composer_id = 49
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <죽은 아이를 그리는 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <죽은 아이를 그리는 노래>', 'Kindertotenlieder', 'album', NULL, NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 49
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <죽은 아이를 그리는 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1dee3abf-d027-458c-9cbb-3f650182ffd9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1dee3abf-d027-458c-9cbb-3f650182ffd9'
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '연가곡집 <죽은 아이를 그리는 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1dee3abf-d027-458c-9cbb-3f650182ffd9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57153896-db88-33d6-946f-5c96427b28bf', 1, NULL, 'Nun will die Sonn'' so hell aufgeh''n', 'Nun will die Sonn'' so hell aufgeh''n', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '연가곡집 <죽은 아이를 그리는 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57153896-db88-33d6-946f-5c96427b28bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ad25002-5ae4-30d2-9896-d3d8894e0f36', 2, NULL, 'Nun seh'' ich wohl, warum so dunkle Flammen', 'Nun seh'' ich wohl, warum so dunkle Flammen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '연가곡집 <죽은 아이를 그리는 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ad25002-5ae4-30d2-9896-d3d8894e0f36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7eb5f71b-1910-3018-9e8a-45aab950d200', 3, NULL, 'Wenn dein Mütterlein', 'Wenn dein Mütterlein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '연가곡집 <죽은 아이를 그리는 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7eb5f71b-1910-3018-9e8a-45aab950d200'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2050abcb-abb0-35af-aa9b-9ee327db3355', 4, NULL, 'Oft denk'' ich, sie sind nur ausgegangen', 'Oft denk'' ich, sie sind nur ausgegangen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '연가곡집 <죽은 아이를 그리는 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2050abcb-abb0-35af-aa9b-9ee327db3355'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc00e04d-eb29-3f40-b9df-04706a5579a2', 5, NULL, 'In diesem Wetter, in diesem Braus', 'In diesem Wetter, in diesem Braus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 49 AND p.title = '연가곡집 <죽은 아이를 그리는 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc00e04d-eb29-3f40-b9df-04706a5579a2'
);

-- 카탈로그에 대응이 없는 seed 작품 45개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 49 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    543, 614, 1056, 7996, 8549, 8672, 9114, 9153, 9383, 9719, 9866, 10678, 11150, 11217, 11352, 11358, 11369, 11379, 11383, 11438,
    11450, 11530, 11532, 11534, 11548, 11549, 11550, 11591, 11601, 11707, 11730, 11741, 11815, 11837, 11908, 11931, 11934, 11954, 11963, 11976,
    11979, 11981, 11989, 14073, 15066
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
