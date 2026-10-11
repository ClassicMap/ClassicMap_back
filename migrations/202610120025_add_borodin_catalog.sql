-- 보로딘 작품을 출판 단위로 채운다(카탈로그: 없음). 작품 34개(묶음 0, 다악장 10, 낱곡 24),
-- 새 작품 32개, 기존 작품 2개, part 38개, 그 아래 0개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   남이 완성한 <이고르 공>·교향곡 3번·현악 5중주는 넣고, 합작 기고곡은 뺀다. 249 「폴로베츠인의 춤」은 그대로.
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

-- None 오페라 <이고르 공>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <이고르 공>', 'Prince Igor', 'song', NULL, NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <이고르 공>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b585d9b-1518-4951-a1ab-4b68306c6cd3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b585d9b-1518-4951-a1ab-4b68306c6cd3'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '오페라 <이고르 공>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b585d9b-1518-4951-a1ab-4b68306c6cd3'
);


-- None 교향곡 1번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번 E♭장조', 'Symphony No. 1 in E♭ major', 'album', NULL, NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5e7c393-e7c3-4268-89d5-ee8c7351be6d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5e7c393-e7c3-4268-89d5-ee8c7351be6d'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '교향곡 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5e7c393-e7c3-4268-89d5-ee8c7351be6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5a61ace-7c40-3cab-97e9-bd2529384380', 1, 'I', 'Adagio – Allegro – Andantino', 'I. Adagio – Allegro – Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '교향곡 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5a61ace-7c40-3cab-97e9-bd2529384380'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c56094e3-fa98-341a-9b05-79d090a2cc19', 2, 'II', '스케르초. Prestissimo – 트리오. Allegro', 'II. Scherzo. Prestissimo – Trio. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '교향곡 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c56094e3-fa98-341a-9b05-79d090a2cc19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b582fb80-2633-33fa-9517-874462aac639', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '교향곡 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b582fb80-2633-33fa-9517-874462aac639'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce6b2c53-a722-360c-9db3-b804e3c2332e', 4, 'IV', 'Allegro molto vivo', 'IV. Allegro molto vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '교향곡 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce6b2c53-a722-360c-9db3-b804e3c2332e'
);


-- None 교향곡 2번 B단조

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae9e6363-39a8-4ff9-b899-5a8eabbdd229'
FROM pieces p
WHERE p.id = 251 AND p.composer_id = 59
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae9e6363-39a8-4ff9-b899-5a8eabbdd229'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89390cbb-33b8-35a2-a828-e46b66acffb8', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 251 AND p.composer_id = 59
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89390cbb-33b8-35a2-a828-e46b66acffb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:add7114c-02a8-3f22-8971-0b6ca858d558', 2, 'II', '스케르초. Prestissimo – Allegretto', 'II. Scherzo. Prestissimo – Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 251 AND p.composer_id = 59
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:add7114c-02a8-3f22-8971-0b6ca858d558'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e272c758-89c9-3cfb-b981-d3abb0d507b4', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 251 AND p.composer_id = 59
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e272c758-89c9-3cfb-b981-d3abb0d507b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:404aabfc-d39c-3c85-a349-a09779295f6a', 4, 'IV', '피날레. Allegro', 'IV. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 251 AND p.composer_id = 59
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:404aabfc-d39c-3c85-a349-a09779295f6a'
);


-- None 교향시 <중앙아시아의 초원에서>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be546cd2-2e99-3253-95dc-646fc904e3b9'
FROM pieces p
WHERE p.id = 250 AND p.composer_id = 59
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be546cd2-2e99-3253-95dc-646fc904e3b9'
);


-- None 교향곡 3번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 3번 A단조', 'Symphony No. 3 in A minor', 'album', NULL, NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 3번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecc884ac-02e1-4998-9def-452ea8f05917'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ecc884ac-02e1-4998-9def-452ea8f05917'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '교향곡 3번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecc884ac-02e1-4998-9def-452ea8f05917'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2441ac5c-f728-32d2-9db6-62af2a19b0a8', 1, 'I', 'Moderato assai', 'I. Moderato assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '교향곡 3번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2441ac5c-f728-32d2-9db6-62af2a19b0a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3c28298-f94d-30eb-bdc6-a08d7a9e60e2', 2, 'II', '스케르초. Vivo – 트리오. Moderato', 'II. Scherzo. Vivo – Trio. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '교향곡 3번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3c28298-f94d-30eb-bdc6-a08d7a9e60e2'
);


-- None 현악 3중주 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 3중주 G단조', 'String Trio in G minor', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 3중주 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '097abad3-36bc-4065-b3f0-8572da123d8c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '097abad3-36bc-4065-b3f0-8572da123d8c'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 3중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '097abad3-36bc-4065-b3f0-8572da123d8c'
);


-- None 현악 5중주 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 5중주 F단조', 'String Quintet in F minor', 'album', NULL, NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 5중주 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b07d8e6-f36e-4b3f-b9b1-d6781b8690f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b07d8e6-f36e-4b3f-b9b1-d6781b8690f6'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 5중주 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b07d8e6-f36e-4b3f-b9b1-d6781b8690f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea7267bc-51b4-4bde-9de8-35585f8c8458', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 5중주 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea7267bc-51b4-4bde-9de8-35585f8c8458'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5702f3d2-2648-49a0-b023-13004e95abae', 2, 'II', 'Andante ma non troppo', 'II. Andante ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 5중주 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5702f3d2-2648-49a0-b023-13004e95abae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3418e8ed-cb68-4b78-a59e-e9519119615a', 3, 'III', '미뉴에트', 'III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 5중주 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3418e8ed-cb68-4b78-a59e-e9519119615a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b52e34c-aa54-47aa-9cf1-cec02763c0c3', 4, 'IV', '피날레. Prestissimo – Adagio – Prestissimo', 'IV. Finale. Prestissimo – Adagio – Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 5중주 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b52e34c-aa54-47aa-9cf1-cec02763c0c3'
);


-- None 첼로 소나타 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 소나타 B단조', 'Cello Sonata in B minor', 'album', NULL, NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 소나타 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cf877f5-8f3b-4569-8be7-e2e7593f729f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4cf877f5-8f3b-4569-8be7-e2e7593f729f'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '첼로 소나타 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cf877f5-8f3b-4569-8be7-e2e7593f729f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb874190-97e4-3cc3-9ffb-e19b0ff1a32d', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '첼로 소나타 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb874190-97e4-3cc3-9ffb-e19b0ff1a32d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:272fb452-2d78-3701-b2d8-1e7f4609710f', 2, 'II', '파스토랄레. Andante dolce', 'II. Pastorale. Andante dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '첼로 소나타 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:272fb452-2d78-3701-b2d8-1e7f4609710f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6522ec45-5c4c-3311-b1f6-2ef1adc1a4cd', 3, 'III', 'Maestoso – Presto', 'III. Maestoso – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '첼로 소나타 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6522ec45-5c4c-3311-b1f6-2ef1adc1a4cd'
);


-- None 피아노 3중주 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 D장조', 'Piano Trio in D major', 'album', NULL, NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cddf291f-95d0-4fb9-869d-ef06fbeb7456'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cddf291f-95d0-4fb9-869d-ef06fbeb7456'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '피아노 3중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cddf291f-95d0-4fb9-869d-ef06fbeb7456'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:943ec63f-ec47-4d86-bb9a-8051ef24d12a', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '피아노 3중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:943ec63f-ec47-4d86-bb9a-8051ef24d12a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83bf5cd3-f752-43ef-bfb1-404117d75c5d', 2, 'II', '로망스. Andante', 'II. Romance. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '피아노 3중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83bf5cd3-f752-43ef-bfb1-404117d75c5d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33472457-6fa1-4b92-8c2f-cb71cb2d2eaa', 3, 'III', '인테르메초. Tempo di minuetto', 'III. Intermezzo. Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '피아노 3중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33472457-6fa1-4b92-8c2f-cb71cb2d2eaa'
);


-- None 피아노 5중주 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 5중주 C단조', 'Piano Quintet in C minor', 'album', NULL, NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 5중주 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85251f52-126b-4804-af82-ca7f745e508a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '85251f52-126b-4804-af82-ca7f745e508a'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '피아노 5중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85251f52-126b-4804-af82-ca7f745e508a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61612aee-5046-4bf9-af24-4edc437679e7', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '피아노 5중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61612aee-5046-4bf9-af24-4edc437679e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4868117e-393c-4d47-8b3d-09c2f01ff0f9', 2, 'II', 'Allegro non troppo', 'II. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '피아노 5중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4868117e-393c-4d47-8b3d-09c2f01ff0f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:236973b1-3088-4227-b8b3-9f0cdac6f64f', 3, 'III', '피날레. Allegro moderato', 'III. Finale. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '피아노 5중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:236973b1-3088-4227-b8b3-9f0cdac6f64f'
);


-- None 현악 4중주 1번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 1번 A장조', 'String Quartet No. 1 in A major', 'album', NULL, NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 1번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16679f4a-e7bd-4a87-92f5-3f1bf2b639f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '16679f4a-e7bd-4a87-92f5-3f1bf2b639f9'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 4중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16679f4a-e7bd-4a87-92f5-3f1bf2b639f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4169db0-b724-401f-a8f3-f3e8ef8be1f2', 1, 'I', 'Moderato – Allegro', 'I. Moderato – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 4중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4169db0-b724-401f-a8f3-f3e8ef8be1f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6e1ac05-29c6-47d7-986c-e35fc74fe09d', 2, 'II', 'Andante con moto', 'II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 4중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6e1ac05-29c6-47d7-986c-e35fc74fe09d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2649475-79ff-4b6b-b079-519925822899', 3, 'III', '스케르초. Prestissimo', 'III. Scherzo. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 4중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2649475-79ff-4b6b-b079-519925822899'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67fd7d1f-4dc9-4b58-a089-0f968c0e7094', 4, 'IV', 'Andante – Allegro risoluto', 'IV. Andante – Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 4중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67fd7d1f-4dc9-4b58-a089-0f968c0e7094'
);


-- None 현악 4중주 2번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 2번 D장조', 'String Quartet No. 2 in D major', 'album', NULL, NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 2번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc571a2e-77d1-44fa-a9bf-aa74231225cc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc571a2e-77d1-44fa-a9bf-aa74231225cc'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 4중주 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc571a2e-77d1-44fa-a9bf-aa74231225cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bbd2a8f-97cd-31de-a934-924e25830d2c', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 4중주 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bbd2a8f-97cd-31de-a934-924e25830d2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed240ba0-02ca-38ee-80c0-2df0c8f6fe6e', 2, 'II', '스케르초. Allegro', 'II. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 4중주 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed240ba0-02ca-38ee-80c0-2df0c8f6fe6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28cb54bc-905f-33fa-9a38-2a1d9820aed5', 3, 'III', '녹턴. Andante', 'III. Notturno. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 4중주 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28cb54bc-905f-33fa-9a38-2a1d9820aed5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4834b576-994a-3870-8a1a-276468c67435', 4, 'IV', '피날레. Andante – Vivace', 'IV. Finale. Andante – Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '현악 4중주 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4834b576-994a-3870-8a1a-276468c67435'
);


-- None 작은 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '작은 모음곡', 'Petite Suite', 'album', NULL, NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '작은 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '907ed240-6b14-4626-ae0b-1846133b4af6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '907ed240-6b14-4626-ae0b-1846133b4af6'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '907ed240-6b14-4626-ae0b-1846133b4af6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:deb6cee0-dd17-47c4-b435-f3c83fc4430e', 1, 'I', '수도원에서. Andante religioso', 'I. Au couvent. Andante religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:deb6cee0-dd17-47c4-b435-f3c83fc4430e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfca229c-b27d-4a09-b296-92a865a9c11b', 2, 'II', '인테르메초. Tempo di minuetto', 'II. Intermezzo. Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfca229c-b27d-4a09-b296-92a865a9c11b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:089c79dd-5ddf-431c-bde2-38065aa347ae', 3, 'III', '마주르카 I. Allegro', 'III. Mazurka I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:089c79dd-5ddf-431c-bde2-38065aa347ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20f5286a-0ffb-471f-84fe-5d6813e2dcf6', 4, 'IV', '마주르카 II. Allegretto', 'IV. Mazurka II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20f5286a-0ffb-471f-84fe-5d6813e2dcf6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:037ab509-948b-4835-b835-a6051cbd3ad0', 5, 'V', '몽상. Andante', 'V. Rêverie. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:037ab509-948b-4835-b835-a6051cbd3ad0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:612b809b-193b-42fd-8889-b1eb623a8d17', 6, 'VI', '세레나데. Allegretto', 'VI. Sérénade. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:612b809b-193b-42fd-8889-b1eb623a8d17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2f0e5fe-913f-477b-b1ca-5f85207ca652', 7, 'VII', '녹턴. Andantino', 'VII. Nocturne. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '작은 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2f0e5fe-913f-477b-b1ca-5f85207ca652'
);


-- None 스케르초 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 A♭장조', 'Scherzo in A♭ major', 'song', NULL, NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5bd15e2-c94e-4a68-9e19-64d955ebf29b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c5bd15e2-c94e-4a68-9e19-64d955ebf29b'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '스케르초 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5bd15e2-c94e-4a68-9e19-64d955ebf29b'
);


-- None 엘렌 폴카 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '엘렌 폴카 D단조', 'Hélène-Polka in D minor', 'song', NULL, NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '엘렌 폴카 D단조'
);


-- None 네 손을 위한 스케르초 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 스케르초 E장조', 'Scherzo in E major for piano four hands', 'song', NULL, NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 스케르초 E장조'
);


-- None 네 손을 위한 타란텔라 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 타란텔라 D장조', 'Tarantella in D major for piano four hands', 'song', NULL, NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 타란텔라 D장조'
);


-- None 가곡 <Chto ty rano, zoren'ka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Chto ty rano, zoren''ka>', 'Chto ty rano, zoren''ka (Why Did You Grow Pale Early)', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Chto ty rano, zoren''ka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aabbc9da-ad70-4a74-8454-2f9c333c03af'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aabbc9da-ad70-4a74-8454-2f9c333c03af'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Chto ty rano, zoren''ka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aabbc9da-ad70-4a74-8454-2f9c333c03af'
);


-- None 가곡 <Razlyubila krasna devitsa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Razlyubila krasna devitsa>', 'Razlyubila krasna devitsa (The Beautiful Girl Does Not Love Me)', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Razlyubila krasna devitsa>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a52f7c9-289f-4c4f-8d75-1a4103a8ab26'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a52f7c9-289f-4c4f-8d75-1a4103a8ab26'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Razlyubila krasna devitsa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a52f7c9-289f-4c4f-8d75-1a4103a8ab26'
);


-- None 가곡 <Slushayte, podruzhen'ki, pesenku moyu>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Slushayte, podruzhen''ki, pesenku moyu>', 'Slushayte, podruzhen''ki, pesenku moyu (Listen to My Song, My Friends)', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Slushayte, podruzhen''ki, pesenku moyu>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc055b0a-8732-4670-9ba6-f0f9a5b202da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc055b0a-8732-4670-9ba6-f0f9a5b202da'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Slushayte, podruzhen''ki, pesenku moyu>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc055b0a-8732-4670-9ba6-f0f9a5b202da'
);


-- None 가곡 <Krasavitsa rybachka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Krasavitsa rybachka>', 'Krasavitsa rybachka (Thou Lovely Fisher-Girl)', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Krasavitsa rybachka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16770ff5-3555-41ad-b9f4-47bdddfc2c5b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '16770ff5-3555-41ad-b9f4-47bdddfc2c5b'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Krasavitsa rybachka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16770ff5-3555-41ad-b9f4-47bdddfc2c5b'
);


-- None 가곡 <Spyashchaya knyazhna>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Spyashchaya knyazhna>', 'Spyashchaya knyazhna (The Sleeping Princess)', 'song', NULL, NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Spyashchaya knyazhna>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15f0ae69-ed5b-440a-b2f0-8253d9e9f219'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '15f0ae69-ed5b-440a-b2f0-8253d9e9f219'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Spyashchaya knyazhna>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15f0ae69-ed5b-440a-b2f0-8253d9e9f219'
);


-- None 가곡 <Otravoy polny moi pesni>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Otravoy polny moi pesni>', 'Otravoy polny moi pesni (My Songs Are Full of Poison)', 'song', NULL, NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Otravoy polny moi pesni>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e385fdb-5dc8-4d1f-b801-7b3d52f5f76e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6e385fdb-5dc8-4d1f-b801-7b3d52f5f76e'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Otravoy polny moi pesni>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e385fdb-5dc8-4d1f-b801-7b3d52f5f76e'
);


-- None 가곡 <Morskaya tsarevna>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Morskaya tsarevna>', 'Morskaya tsarevna (The Sea Princess)', 'song', NULL, NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Morskaya tsarevna>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e90ceb0-74f7-440f-abd6-0446a7ef7555'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6e90ceb0-74f7-440f-abd6-0446a7ef7555'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Morskaya tsarevna>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e90ceb0-74f7-440f-abd6-0446a7ef7555'
);


-- None 가곡 <Pesnya tyomnogo lesa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pesnya tyomnogo lesa>', 'Pesnya tyomnogo lesa (Song of the Dark Woods)', 'song', NULL, NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pesnya tyomnogo lesa>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9afdcfa7-ecb0-4ec3-a2ce-f17e40a6d729'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9afdcfa7-ecb0-4ec3-a2ce-f17e40a6d729'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Pesnya tyomnogo lesa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9afdcfa7-ecb0-4ec3-a2ce-f17e40a6d729'
);


-- None 가곡 <Fal'shivaya nota>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Fal''shivaya nota>', 'Fal''shivaya nota (The False Note)', 'song', NULL, NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Fal''shivaya nota>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd75ed05-20b5-4a92-93e6-1bb83ddc55f4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cd75ed05-20b5-4a92-93e6-1bb83ddc55f4'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Fal''shivaya nota>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd75ed05-20b5-4a92-93e6-1bb83ddc55f4'
);


-- None 가곡 <More>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <More>', 'More (The Sea)', 'song', NULL, NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <More>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73490b98-4d87-448d-8d4b-39d2832dcb1f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '73490b98-4d87-448d-8d4b-39d2832dcb1f'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <More>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73490b98-4d87-448d-8d4b-39d2832dcb1f'
);


-- None 가곡 <Iz slyoz moikh>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Iz slyoz moikh>', 'Iz slyoz moikh (From My Tears)', 'song', NULL, NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Iz slyoz moikh>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '460fd46c-caa3-49c7-b28c-956c3df42602'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '460fd46c-caa3-49c7-b28c-956c3df42602'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Iz slyoz moikh>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '460fd46c-caa3-49c7-b28c-956c3df42602'
);


-- None 가곡 <Dlya beregov otchizny dal'noy>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Dlya beregov otchizny dal''noy>', 'Dlya beregov otchizny dal''noy (For the Shores of Your Far Homeland)', 'song', NULL, NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Dlya beregov otchizny dal''noy>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9fd4b90-7987-37d8-afe9-39206ea91fcc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a9fd4b90-7987-37d8-afe9-39206ea91fcc'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Dlya beregov otchizny dal''noy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9fd4b90-7987-37d8-afe9-39206ea91fcc'
);


-- None 가곡 <U lyudey-to v domu>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <U lyudey-to v domu>', 'U lyudey-to v domu (To the People at Home)', 'song', NULL, NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <U lyudey-to v domu>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '809d7890-045a-4de4-9127-86c801880721'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '809d7890-045a-4de4-9127-86c801880721'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <U lyudey-to v domu>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '809d7890-045a-4de4-9127-86c801880721'
);


-- None 가곡 <Arabskaya melodiya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Arabskaya melodiya>', 'Arabskaya melodiya (Arabian Melody)', 'song', NULL, NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Arabskaya melodiya>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecb39eb4-f90a-43de-a5f8-d21ddf51b421'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ecb39eb4-f90a-43de-a5f8-d21ddf51b421'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Arabskaya melodiya>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecb39eb4-f90a-43de-a5f8-d21ddf51b421'
);


-- None 가곡 <Spes'>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Spes''>', 'Spes'' (Pride)', 'song', NULL, NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Spes''>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91d33643-af11-445f-b89b-68a6a4ac4089'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '91d33643-af11-445f-b89b-68a6a4ac4089'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Spes''>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91d33643-af11-445f-b89b-68a6a4ac4089'
);


-- None 가곡 <Chudnyy sad>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Chudnyy sad>', 'Chudnyy sad (The Magic Garden)', 'song', NULL, NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Chudnyy sad>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aafa5a1c-c479-4db7-a6e4-6d4552bdb926'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aafa5a1c-c479-4db7-a6e4-6d4552bdb926'
FROM pieces p
WHERE p.composer_id = 59 AND p.title = '가곡 <Chudnyy sad>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aafa5a1c-c479-4db7-a6e4-6d4552bdb926'
);


-- None 네 기사가 한 숙녀에게 바치는 세레나데

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 기사가 한 숙녀에게 바치는 세레나데', 'Serenade of Four Knights for One Lady', 'song', NULL, NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 59
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 기사가 한 숙녀에게 바치는 세레나데'
);

