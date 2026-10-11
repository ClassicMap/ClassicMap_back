-- 시벨리우스 작품을 출판 단위로 채운다(카탈로그: Op.·JS). 작품 300개(묶음 63, 다악장 40, 낱곡 197),
-- 새 작품 297개, 기존 작품 3개, part 451개, 그 아래 34개, 기존 낱곡 연결 1개.
--
-- 정한 것
--   작품번호 작품과 JS 번호 완성 작품. 279 「슬픈 왈츠」는 Op. 44 묶음의 1번 part 로 잇는다.
--   운영 작품에 MBID 가 없어 카탈로그 번호로 맞추고 MB work 를 식별자로 더한다.
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

-- Op. 1 5개의 크리스마스 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 크리스마스 노래', '5 Christmas Songs, Op. 1', 'album', 'Op. 1', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 크리스마스 노래'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c360815-352b-4b55-bb92-52373afea4ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0c360815-352b-4b55-bb92-52373afea4ba'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 크리스마스 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c360815-352b-4b55-bb92-52373afea4ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09a74ad4-a616-4d85-9de7-7712b53f5072', 1, NULL, 'Nu står jul vid snöig port', 'Nu står jul vid snöig port', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 크리스마스 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09a74ad4-a616-4d85-9de7-7712b53f5072'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17982df6-6d9b-4a45-9836-e806354e660f', 2, NULL, 'Nu så kommer julen', 'Nu så kommer julen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 크리스마스 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17982df6-6d9b-4a45-9836-e806354e660f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86d6a2f2-9ca8-4d80-b912-aca62b1f29cf', 3, NULL, 'Det mörknar ute', 'Det mörknar ute', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 크리스마스 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86d6a2f2-9ca8-4d80-b912-aca62b1f29cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b15c145e-ecad-4bc2-8ef9-f90440fb6fbf', 4, NULL, 'Giv mig ej glans, ej guld, ej prakt', 'Giv mig ej glans, ej guld, ej prakt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 크리스마스 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b15c145e-ecad-4bc2-8ef9-f90440fb6fbf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf187807-9309-4809-8724-7b47f8c786b9', 5, NULL, 'On hanget korkeat, nietokset', 'On hanget korkeat, nietokset', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 크리스마스 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf187807-9309-4809-8724-7b47f8c786b9'
);


-- Op. 2 바이올린과 피아노를 위한 2개의 소품 Op. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 2개의 소품 Op. 2', '2 Pieces for Violin and Piano, Op. 2', 'album', NULL, 'Op.', '2', 1911, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 2개의 소품 Op. 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c27fecd1-d075-468e-b05a-bbf98457677a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c27fecd1-d075-468e-b05a-bbf98457677a'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 2개의 소품 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c27fecd1-d075-468e-b05a-bbf98457677a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5e1f15f-8db6-432f-9241-0cc560c20afe', 1, NULL, '로망스 B단조', 'Romance in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 2개의 소품 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5e1f15f-8db6-432f-9241-0cc560c20afe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cd6a155-7d77-4841-99a3-07838074291f', 2, NULL, '에필로그', 'Epilog', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 2개의 소품 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cd6a155-7d77-4841-99a3-07838074291f'
);


-- Op. 3 가곡 <Arioso>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Arioso>', 'Arioso', 'song', 'Op. 3', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Arioso>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ba23eb8-8fbd-4b69-8565-ea2ba18a7731'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9ba23eb8-8fbd-4b69-8565-ea2ba18a7731'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <Arioso>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ba23eb8-8fbd-4b69-8565-ea2ba18a7731'
);


-- Op. 4 현악 4중주 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 B♭장조', 'String Quartet in B♭ major', 'album', 'Op. 4', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a739e824-8c0d-4b51-a8d3-32a64da34432'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a739e824-8c0d-4b51-a8d3-32a64da34432'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a739e824-8c0d-4b51-a8d3-32a64da34432'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:773e5612-84b1-43da-9831-f58675869055', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:773e5612-84b1-43da-9831-f58675869055'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffbce33b-0c22-4f6f-8964-206ab879ac14', 2, 'II', 'Andante sostenuto', 'II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffbce33b-0c22-4f6f-8964-206ab879ac14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbd8d3d2-b679-4962-a186-edf91a587418', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbd8d3d2-b679-4962-a186-edf91a587418'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:656c9088-bea0-4fb1-89ad-05775becc178', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:656c9088-bea0-4fb1-89ad-05775becc178'
);


-- Op. 5 6개의 즉흥곡 Op. 5

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 즉흥곡 Op. 5', '6 Impromptus, Op. 5', 'album', NULL, 'Op.', '5', 1893, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 즉흥곡 Op. 5'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed1a6ce5-885a-3350-91f9-c32b8771352d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed1a6ce5-885a-3350-91f9-c32b8771352d'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 즉흥곡 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed1a6ce5-885a-3350-91f9-c32b8771352d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f1f219e-948a-47ad-af57-b211e075b8c4', 1, NULL, 'G단조', 'No. 1 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 즉흥곡 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f1f219e-948a-47ad-af57-b211e075b8c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5860c332-7413-44f1-b744-d556779d880f', 2, NULL, 'G단조', 'No. 2 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 즉흥곡 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5860c332-7413-44f1-b744-d556779d880f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ae3f00a-7a3f-47a4-92b3-d33017a1427e', 3, NULL, 'A단조', 'No. 3 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 즉흥곡 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ae3f00a-7a3f-47a4-92b3-d33017a1427e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:250b5175-5190-4e92-8de5-30dc259df08c', 4, NULL, 'E단조', 'No. 4 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 즉흥곡 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:250b5175-5190-4e92-8de5-30dc259df08c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e9c6f61-30e8-4e3e-abe6-1cfcb7dbc549', 5, NULL, 'B단조', 'No. 5 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 즉흥곡 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e9c6f61-30e8-4e3e-abe6-1cfcb7dbc549'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81773dfa-8cd0-4473-bcff-719711970dbc', 6, NULL, 'E장조', 'No. 6 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 즉흥곡 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81773dfa-8cd0-4473-bcff-719711970dbc'
);


-- Op. 6 카사치오네

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카사치오네', 'Cassazione', 'song', 'Op. 6', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카사치오네'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f170650d-93fe-45a2-92c0-8d153149fa67'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f170650d-93fe-45a2-92c0-8d153149fa67'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '카사치오네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f170650d-93fe-45a2-92c0-8d153149fa67'
);


-- Op. 7 교향곡 <쿨레르보>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 <쿨레르보>', 'Kullervo', 'album', 'Op. 7', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 <쿨레르보>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3291f749-e40c-4975-886d-f4ac7378452c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3291f749-e40c-4975-886d-f4ac7378452c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 <쿨레르보>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3291f749-e40c-4975-886d-f4ac7378452c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00e3925a-276f-37d3-a071-9d403dc45e3f', 1, 'I', '도입부 (Johdanto). Allegro moderato', 'I. Introduction (Johdanto). Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 <쿨레르보>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00e3925a-276f-37d3-a071-9d403dc45e3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d45e873c-b672-3dd9-9e60-bcdebc36a69d', 2, 'II', '쿨레르보의 젊은 시절 (Kullervon nuoruus). Grave', 'II. Kullervo''s Youth (Kullervon nuoruus). Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 <쿨레르보>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d45e873c-b672-3dd9-9e60-bcdebc36a69d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed7add19-a669-3ac4-9b72-d6907f6304f9', 3, 'III', '쿨레르보와 누이 (Kullervo ja hänen sisarensa). Allegro vivace', 'III. Kullervo and His Sister (Kullervo ja hänen sisarensa). Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 <쿨레르보>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed7add19-a669-3ac4-9b72-d6907f6304f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95aa62ef-70a5-384e-8b98-24320e151d11', 4, 'IV', '쿨레르보 싸움터로 가다 (Kullervon sotaanlähtö). Alla marcia', 'IV. Kullervo Goes to War (Kullervon sotaanlähtö). Alla marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 <쿨레르보>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95aa62ef-70a5-384e-8b98-24320e151d11'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63fa7229-b55f-3763-a276-4af39376c032', 5, 'V', '쿨레르보의 죽음 (Kullervon kuolema). Andante', 'V. Kullervo''s Death (Kullervon kuolema). Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 <쿨레르보>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63fa7229-b55f-3763-a276-4af39376c032'
);


-- Op. 8 부수음악 <도마뱀>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <도마뱀>', 'Ödlan (The Lizard), Incidental Music', 'song', 'Op. 8', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <도마뱀>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93dea010-6055-41f1-8793-b3b2a7b85c9f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '93dea010-6055-41f1-8793-b3b2a7b85c9f'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '부수음악 <도마뱀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93dea010-6055-41f1-8793-b3b2a7b85c9f'
);


-- Op. 9 교향시 <엔 사가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <엔 사가>', 'En saga', 'song', 'Op. 9', NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <엔 사가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d1c78fe-4986-3705-9dc2-b2e27e55fd9d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6d1c78fe-4986-3705-9dc2-b2e27e55fd9d'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향시 <엔 사가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d1c78fe-4986-3705-9dc2-b2e27e55fd9d'
);


-- Op. 10 <카렐리아> 서곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<카렐리아> 서곡', 'Karelia Overture', 'song', 'Op. 10', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<카렐리아> 서곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51ec073f-6468-4ca2-ba5f-4d9be58e7a92'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51ec073f-6468-4ca2-ba5f-4d9be58e7a92'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<카렐리아> 서곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51ec073f-6468-4ca2-ba5f-4d9be58e7a92'
);


-- Op. 11 <카렐리아> 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<카렐리아> 모음곡', 'Karelia Suite', 'album', 'Op. 11', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<카렐리아> 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '479561d4-43aa-46e0-b80c-1c2f907c63f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '479561d4-43aa-46e0-b80c-1c2f907c63f8'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<카렐리아> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '479561d4-43aa-46e0-b80c-1c2f907c63f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b15a9e7c-c9d0-39aa-a8a3-86e2bbb52d22', 1, 'I', '간주곡', 'I. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<카렐리아> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b15a9e7c-c9d0-39aa-a8a3-86e2bbb52d22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:339b4e79-6d4b-37c0-9dab-beb60ef948ec', 2, 'II', '발라드', 'II. Ballade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<카렐리아> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:339b4e79-6d4b-37c0-9dab-beb60ef948ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00f13466-ebbd-3665-8343-a635e90079d4', 3, 'III', 'Alla marcia', 'III. Alla marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<카렐리아> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00f13466-ebbd-3665-8343-a635e90079d4'
);


-- Op. 12 피아노 소나타 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 F장조', 'Piano Sonata in F major', 'album', 'Op. 12', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9550d004-9d54-49eb-9a04-de3f4d99f341'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9550d004-9d54-49eb-9a04-de3f4d99f341'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9550d004-9d54-49eb-9a04-de3f4d99f341'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebfcab78-9838-47ae-afd6-dca8262bdda3', 1, 'I', 'Allegro molto', 'I. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebfcab78-9838-47ae-afd6-dca8262bdda3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fdc529e-7c6d-4311-bca6-31f07754fd64', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fdc529e-7c6d-4311-bca6-31f07754fd64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9c15a31-dc32-4fed-86f8-02b26d1b56f2', 3, 'III', 'Vivacissimo', 'III. Vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9c15a31-dc32-4fed-86f8-02b26d1b56f2'
);


-- Op. 13 루네베리 시에 의한 7개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '루네베리 시에 의한 7개의 가곡', '7 Runeberg Songs, Op. 13', 'album', 'Op. 13', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '루네베리 시에 의한 7개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a136333-22ed-42c2-9efb-13c142cb8fc5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8a136333-22ed-42c2-9efb-13c142cb8fc5'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 7개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a136333-22ed-42c2-9efb-13c142cb8fc5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fde93c73-cfc2-47ec-b5b7-07ff7c5c1d1c', 1, NULL, 'Under strandens granar', 'Under strandens granar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 7개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fde93c73-cfc2-47ec-b5b7-07ff7c5c1d1c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9f5163d-14e5-4abe-b19f-14d27f1b20a1', 2, NULL, 'Kyssens hopp', 'Kyssens hopp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 7개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9f5163d-14e5-4abe-b19f-14d27f1b20a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e83a5aa-5349-4b3f-b272-88ff72d8911f', 3, NULL, 'Hjärtats morgon', 'Hjärtats morgon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 7개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e83a5aa-5349-4b3f-b272-88ff72d8911f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:381c13b2-d5de-3f42-b1f5-0d140754bb83', 4, NULL, 'Våren flyktar hastigt', 'Våren flyktar hastigt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 7개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:381c13b2-d5de-3f42-b1f5-0d140754bb83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3da036c-5066-4616-8573-9144fbc17c55', 5, NULL, 'Drömmen', 'Drömmen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 7개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3da036c-5066-4616-8573-9144fbc17c55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c516f507-a3da-4f07-b87e-9c421a6427cd', 6, NULL, 'Till Frigga', 'Till Frigga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 7개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c516f507-a3da-4f07-b87e-9c421a6427cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d0f3623-f232-4d02-8da1-082f4d04efe6', 7, NULL, 'Jägargossen', 'Jägargossen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 7개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d0f3623-f232-4d02-8da1-082f4d04efe6'
);


-- Op. 14 현악 모음곡 <라카스타바>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 모음곡 <라카스타바>', 'Rakastava (The Lover), Suite for Strings', 'album', 'Op. 14', NULL, NULL, 1912, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 모음곡 <라카스타바>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '825a31e3-d5db-4dc8-bb88-c4057ac44e1c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '825a31e3-d5db-4dc8-bb88-c4057ac44e1c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 모음곡 <라카스타바>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '825a31e3-d5db-4dc8-bb88-c4057ac44e1c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7449f9e-77cd-3ca1-8dd2-9f7449249600', 1, 'I', '연인 (Rakastava)', 'I. The Lover (Rakastava)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 모음곡 <라카스타바>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7449f9e-77cd-3ca1-8dd2-9f7449249600'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebf1fbf7-3b4c-3be1-a0ff-19fb669fcd4f', 2, 'II', '연인의 길 (Rakastetun tie)', 'II. The Path of the Beloved (Rakastetun tie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 모음곡 <라카스타바>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebf1fbf7-3b4c-3be1-a0ff-19fb669fcd4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34d51b15-0103-3585-a281-d343358b310a', 3, 'III', '잘 자요… 안녕히 (Hyvää iltaa ... Jää hyvästi)', 'III. Good Evening ... Farewell! (Hyvää iltaa ... Jää hyvästi)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 모음곡 <라카스타바>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34d51b15-0103-3585-a281-d343358b310a'
);


-- Op. 15 교향시 <숲의 요정>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <숲의 요정>', 'The Wood Nymph (Skogsrået)', 'song', 'Op. 15', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <숲의 요정>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28016b8b-b40a-414e-ad32-bd0379305caa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '28016b8b-b40a-414e-ad32-bd0379305caa'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향시 <숲의 요정>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28016b8b-b40a-414e-ad32-bd0379305caa'
);


-- Op. 16 교향시 <봄의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <봄의 노래>', 'Spring Song (Vårsång)', 'song', 'Op. 16', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <봄의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6357892-dbf6-4988-b3df-e042c8c66b15'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6357892-dbf6-4988-b3df-e042c8c66b15'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향시 <봄의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6357892-dbf6-4988-b3df-e042c8c66b15'
);


-- Op. 17 7개의 가곡 Op. 17

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '7개의 가곡 Op. 17', '7 Songs, Op. 17', 'album', NULL, 'Op.', '17', 1904, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '7개의 가곡 Op. 17'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae4defd3-41db-4024-89f6-99a47baaac47'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae4defd3-41db-4024-89f6-99a47baaac47'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '7개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae4defd3-41db-4024-89f6-99a47baaac47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5547659c-7bca-38e7-b9a4-547c1191dbc0', 1, NULL, 'Se''n har jag ej frågat mera', 'Se''n har jag ej frågat mera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '7개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5547659c-7bca-38e7-b9a4-547c1191dbc0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bb428ea-6bc6-4fe1-bd36-07fc8d192d2d', 2, NULL, 'Sov in!', 'Sov in!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '7개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bb428ea-6bc6-4fe1-bd36-07fc8d192d2d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:520e4663-41fb-44a4-88ca-aedfd5860489', 3, NULL, 'Fågellek', 'Fågellek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '7개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:520e4663-41fb-44a4-88ca-aedfd5860489'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c2ca4a0-c908-465d-abfa-e12411f9456e', 4, NULL, 'Vilse', 'Vilse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '7개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c2ca4a0-c908-465d-abfa-e12411f9456e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83e96ac0-0258-45b0-9ec6-22733f58520f', 5, NULL, 'En slända', 'En slända', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '7개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83e96ac0-0258-45b0-9ec6-22733f58520f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22aabebe-a4d6-3a0a-ba92-e33b927a51ae', 6, NULL, 'Illalle', 'Illalle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '7개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22aabebe-a4d6-3a0a-ba92-e33b927a51ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e59c248f-656e-4272-94b3-a87231ef19d3', 7, NULL, 'Lastu lainehilla', 'Lastu lainehilla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '7개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e59c248f-656e-4272-94b3-a87231ef19d3'
);


-- Op. 18 남성 합창곡 Op. 18

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 Op. 18', '6 Part-Songs for Male Chorus, Op. 18', 'album', NULL, 'Op.', '18', 1901, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 Op. 18'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6fe05bdf-ceab-424d-b832-46d187ac617b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6fe05bdf-ceab-424d-b832-46d187ac617b'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6fe05bdf-ceab-424d-b832-46d187ac617b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e3ec2a6-e4a8-4da1-81d5-898ab36a803f', 1, NULL, 'Sortunut ääni', 'Sortunut ääni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e3ec2a6-e4a8-4da1-81d5-898ab36a803f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2abda62-e283-4169-a6fe-89dd715a7e2a', 2, NULL, 'Terve, kuu', 'Terve, kuu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2abda62-e283-4169-a6fe-89dd715a7e2a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a78b5a6-7dd7-4b63-8350-13712bf4ba15', 3, NULL, 'Venematka', 'Venematka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a78b5a6-7dd7-4b63-8350-13712bf4ba15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e807d3c0-d462-4075-9fe6-7e58bfad9eae', 4, NULL, 'Saarella palaa', 'Saarella palaa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e807d3c0-d462-4075-9fe6-7e58bfad9eae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bd829b3-6385-4659-94ee-0ba30bf0851f', 5, NULL, 'Metsämiehen laulu', 'Metsämiehen laulu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bd829b3-6385-4659-94ee-0ba30bf0851f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2151d27-3edf-442c-8749-58d9ccde3504', 6, NULL, 'Sydämeni laulu', 'Sydämeni laulu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2151d27-3edf-442c-8749-58d9ccde3504'
);


-- Op. 19 여성 합창과 관현악을 위한 <즉흥곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '여성 합창과 관현악을 위한 <즉흥곡>', 'Impromptu for Female Chorus and Orchestra', 'song', 'Op. 19', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '여성 합창과 관현악을 위한 <즉흥곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '021d0e19-f1cf-4fb9-a59e-973a81953acf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '021d0e19-f1cf-4fb9-a59e-973a81953acf'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '여성 합창과 관현악을 위한 <즉흥곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '021d0e19-f1cf-4fb9-a59e-973a81953acf'
);


-- Op. 20 첼로와 피아노를 위한 <말린코니아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로와 피아노를 위한 <말린코니아>', 'Malinconia for Cello and Piano', 'song', 'Op. 20', NULL, NULL, 1900, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로와 피아노를 위한 <말린코니아>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6cc1bd3-4360-4350-a717-baa7ff5bf90b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6cc1bd3-4360-4350-a717-baa7ff5bf90b'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '첼로와 피아노를 위한 <말린코니아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6cc1bd3-4360-4350-a717-baa7ff5bf90b'
);


-- Op. 21 남성 합창곡 <찬가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <찬가>', 'Hymn (Natus in curas)', 'song', 'Op. 21', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <찬가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f9d66d1-dfc8-4da6-b84f-dd21ff63a9f2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f9d66d1-dfc8-4da6-b84f-dd21ff63a9f2'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 <찬가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f9d66d1-dfc8-4da6-b84f-dd21ff63a9f2'
);


-- Op. 22 <레민카이넨 모음곡> (네 개의 전설)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<레민카이넨 모음곡> (네 개의 전설)', 'Lemminkäinen Suite (Four Legends from the Kalevala)', 'album', 'Op. 22', NULL, NULL, 1939, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<레민카이넨 모음곡> (네 개의 전설)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '71d975cb-db64-488b-a4ce-87e2b355f194'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '71d975cb-db64-488b-a4ce-87e2b355f194'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<레민카이넨 모음곡> (네 개의 전설)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '71d975cb-db64-488b-a4ce-87e2b355f194'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fa2b8ce-353d-3941-b1a1-bcf04f8488b6', 1, 'I', '레민카이넨과 섬의 처녀들 (Lemminkäinen ja saaren neidot)', 'I. Lemminkäinen and the Maidens of the Island', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<레민카이넨 모음곡> (네 개의 전설)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fa2b8ce-353d-3941-b1a1-bcf04f8488b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51fb0145-4d77-3c37-a97c-5bf58689be59', 2, 'II', '투오넬라의 백조 (Tuonelan joutsen)', 'II. The Swan of Tuonela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<레민카이넨 모음곡> (네 개의 전설)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51fb0145-4d77-3c37-a97c-5bf58689be59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eaad7d04-8656-3259-a800-dca7897d3bbd', 3, 'III', '투오넬라의 레민카이넨 (Lemminkäinen Tuonelassa)', 'III. Lemminkäinen in Tuonela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<레민카이넨 모음곡> (네 개의 전설)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaad7d04-8656-3259-a800-dca7897d3bbd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:565b75ed-1256-392e-807e-002818631915', 4, 'IV', '레민카이넨의 귀향 (Lemminkäinen palaa kotitienoille)', 'IV. Lemminkäinen''s Return', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<레민카이넨 모음곡> (네 개의 전설)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:565b75ed-1256-392e-807e-002818631915'
);


-- Op. 23 1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23', 'Songs for Mixed Chorus from the 1897 Promotional Cantata, Op. 23', 'album', NULL, 'Op.', '23', 1898, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '473fdb2d-f9ce-4223-951e-2178d3a7f09d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '473fdb2d-f9ce-4223-951e-2178d3a7f09d'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '473fdb2d-f9ce-4223-951e-2178d3a7f09d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57d16f90-0ddf-49d6-961d-be1438847954', 1, NULL, 'Me nuoriso Suomen', 'Me nuoriso Suomen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57d16f90-0ddf-49d6-961d-be1438847954'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72b4fe16-a509-4feb-a2a1-010ae9e8f225', 2, NULL, 'Tuuli tuudittele', 'Tuuli tuudittele', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72b4fe16-a509-4feb-a2a1-010ae9e8f225'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3477b7a8-d6fe-4379-848e-59a211c24e39', 3, NULL, 'Oi toivo, toivo, sä lietomieli', 'Oi toivo, toivo, sä lietomieli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3477b7a8-d6fe-4379-848e-59a211c24e39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bba2b4b3-3058-44f8-a5f5-9e8b3a9aad05', 4, NULL, 'Montapa elon merellä', 'Montapa elon merellä', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bba2b4b3-3058-44f8-a5f5-9e8b3a9aad05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef168567-f2a1-44f0-99be-2b310fe40f75', 5, NULL, 'Sammuva sainio maan', 'Sammuva sainio maan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef168567-f2a1-44f0-99be-2b310fe40f75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:sibelius:sibelius-op23:6', 6, NULL, 'Soi kiitokseksi Luojan / Tuule, tuuli, leppeämmin', 'No. 6 (a) Soi kiitokseksi Luojan (b) Tuule, tuuli, leppeämmin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:sibelius:sibelius-op23:6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3a3248f0-f8e5-400a-80eb-b70aaa95a0c6', 1, NULL, 'Soi kiitokseksi Luojan', '6a. Soi kiitokseksi Luojan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:sibelius:sibelius-op23:6'
WHERE p.composer_id = 68 AND p.title = '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a3248f0-f8e5-400a-80eb-b70aaa95a0c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8178c782-405a-4af8-9b8d-e565e828e4f2', 2, NULL, 'Tuule, tuuli, leppeämmin', '6b. Tuule, tuuli, leppeämmin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:sibelius:sibelius-op23:6'
WHERE p.composer_id = 68 AND p.title = '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8178c782-405a-4af8-9b8d-e565e828e4f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4186251-546e-432c-aad7-0619478f5781', 7, NULL, 'Oi Lempi, sun valtas ääretön on', 'Oi Lempi, sun valtas ääretön on', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4186251-546e-432c-aad7-0619478f5781'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c891c3f4-b2b8-445b-ac5d-c6dc67fe9c1d', 8, NULL, 'Kun virta vuolas', 'Kun virta vuolas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c891c3f4-b2b8-445b-ac5d-c6dc67fe9c1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be3ce8a4-75fd-4de0-b643-f8e1b732bbc4', 9, NULL, 'Oi kallis Suomi, äiti verraton', 'Oi kallis Suomi, äiti verraton', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '1897년 학위 수여식 칸타타에 의한 혼성 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be3ce8a4-75fd-4de0-b643-f8e1b732bbc4'
);


-- Op. 24 10개의 피아노 소품 Op. 24

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '10개의 피아노 소품 Op. 24', '10 Pieces for Piano, Op. 24', 'album', NULL, 'Op.', '24', 1904, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '10개의 피아노 소품 Op. 24'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a31244c0-15b3-4a58-a60f-b067bd572b12'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a31244c0-15b3-4a58-a60f-b067bd572b12'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a31244c0-15b3-4a58-a60f-b067bd572b12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aad87c84-4dc1-411b-b71e-555993b0c1b1', 1, NULL, '즉흥곡 G단조', 'No. 1 Impromptu in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aad87c84-4dc1-411b-b71e-555993b0c1b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fc3e11a-5d74-4171-bf38-dbd0459408e9', 2, NULL, '로망스 A장조', 'No. 2 Romance in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fc3e11a-5d74-4171-bf38-dbd0459408e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62049cec-a7d6-4708-b193-a484bd6d191c', 3, NULL, '카프리스 E단조', 'No. 3 Caprice in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62049cec-a7d6-4708-b193-a484bd6d191c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b69ed635-0411-44bd-877a-10d44716347a', 4, NULL, '로망스 D단조', 'No. 4 Romance in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b69ed635-0411-44bd-877a-10d44716347a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f7795b9-43ed-4548-b4ed-c6d8f763a37a', 5, NULL, '왈츠 E장조', 'No. 5 Waltz in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f7795b9-43ed-4548-b4ed-c6d8f763a37a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd73b53b-136d-4ba0-94e6-3d20b1535e9d', 6, NULL, '목가 F장조', 'No. 6 Idyll in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd73b53b-136d-4ba0-94e6-3d20b1535e9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e495224-7abe-41e4-9b6d-dfe7d0ad5fb1', 7, NULL, '안단티노 F장조', 'No. 7 Andantino in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e495224-7abe-41e4-9b6d-dfe7d0ad5fb1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae67f7b6-2b51-4de8-9318-e1d2224488f3', 8, NULL, '녹턴', 'No. 8 Nocturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae67f7b6-2b51-4de8-9318-e1d2224488f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c598606f-6667-4ef1-b119-4e51955685d4', 9, NULL, '로망스 D♭장조', 'No. 9 Romance in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c598606f-6667-4ef1-b119-4e51955685d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57118379-5348-41d1-98e5-9b8a130134c5', 10, NULL, '뱃노래 G단조', 'No. 10 Barcarola in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57118379-5348-41d1-98e5-9b8a130134c5'
);


-- Op. 25 <역사적 장면> 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<역사적 장면> 1번', 'Scènes historiques I', 'album', 'Op. 25', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<역사적 장면> 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd112b268-2f0f-4dc7-977d-1720e58ea4a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd112b268-2f0f-4dc7-977d-1720e58ea4a4'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<역사적 장면> 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd112b268-2f0f-4dc7-977d-1720e58ea4a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f4ed341-32d6-4f8f-a892-e594ac09d834', 1, 'I', '서곡풍으로 (All''Overtura)', 'I. All''Overtura', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<역사적 장면> 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f4ed341-32d6-4f8f-a892-e594ac09d834'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32f5c59c-53fd-49d3-86c4-4621ab249f62', 2, 'II', '장면 (Scena)', 'II. Scena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<역사적 장면> 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32f5c59c-53fd-49d3-86c4-4621ab249f62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94a099d1-1eee-3a8f-8b71-3aec1790905b', 3, 'III', '축제 (Festivo)', 'III. Festivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<역사적 장면> 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94a099d1-1eee-3a8f-8b71-3aec1790905b'
);


-- Op. 26 교향시 <핀란디아>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '809aadce-6229-3164-96ed-478ca72a06c6'
FROM pieces p
WHERE p.id = 277 AND p.composer_id = 68
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '809aadce-6229-3164-96ed-478ca72a06c6'
);


-- Op. 27 부수음악 <크리스티안 2세>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <크리스티안 2세>', 'King Christian II, Incidental Music', 'song', 'Op. 27', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <크리스티안 2세>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b114481a-96fc-496d-a3ca-2b46f1f2c825'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b114481a-96fc-496d-a3ca-2b46f1f2c825'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '부수음악 <크리스티안 2세>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b114481a-96fc-496d-a3ca-2b46f1f2c825'
);


-- Op. 27 <크리스티안 2세> 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<크리스티안 2세> 모음곡', 'King Christian II Suite', 'album', 'Op. 27', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<크리스티안 2세> 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd679c86c-26a8-476e-b287-10a66117b017'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd679c86c-26a8-476e-b287-10a66117b017'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<크리스티안 2세> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd679c86c-26a8-476e-b287-10a66117b017'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a56c301a-2ecc-4484-97f7-c02e74fd5dba', 1, 'I', '녹턴. Molto moderato', 'I. Nocturne. Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<크리스티안 2세> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a56c301a-2ecc-4484-97f7-c02e74fd5dba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adc2e0aa-4e48-49ee-af1e-f697cbba9854', 2, 'II', '엘레지. Andante sostenuto', 'II. Elegie. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<크리스티안 2세> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adc2e0aa-4e48-49ee-af1e-f697cbba9854'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4007198-0a46-45ef-85d7-8780afd903b1', 3, 'III', '뮈제트. Allegretto', 'III. Musette. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<크리스티안 2세> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4007198-0a46-45ef-85d7-8780afd903b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d30b874-93d6-46c8-90f4-c007a65f3d21', 4, 'IV', '세레나데. Moderato assai (Quasi menuetto)', 'IV. Serenade. Moderato assai (Quasi menuetto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<크리스티안 2세> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d30b874-93d6-46c8-90f4-c007a65f3d21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6d336a3-b6b6-42e5-a8fb-586879ee15ff', 5, 'V', '발라드. Allegro molto – Vivace', 'V. Ballade. Allegro molto – Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<크리스티안 2세> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6d336a3-b6b6-42e5-a8fb-586879ee15ff'
);


-- Op. 28 남성 합창과 관현악을 위한 <산델스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창과 관현악을 위한 <산델스>', 'Sandels', 'song', 'Op. 28', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창과 관현악을 위한 <산델스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0085242b-a25e-42b9-8848-9d422113c18f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0085242b-a25e-42b9-8848-9d422113c18f'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창과 관현악을 위한 <산델스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0085242b-a25e-42b9-8848-9d422113c18f'
);


-- Op. 29 멜로드라마 <스뇌프리드>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <스뇌프리드>', 'Snöfrid', 'song', 'Op. 29', NULL, NULL, 1900, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <스뇌프리드>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7165583e-2786-4765-98c7-fa9511fc69e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7165583e-2786-4765-98c7-fa9511fc69e9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '멜로드라마 <스뇌프리드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7165583e-2786-4765-98c7-fa9511fc69e9'
);


-- Op. 30 멜로드라마 <울루강의 얼음 깨짐>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <울루강의 얼음 깨짐>', 'The Breaking of the Ice on the Oulu River (Islossningen i Uleå älv)', 'song', 'Op. 30', NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <울루강의 얼음 깨짐>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0a8060d-1fae-4b14-80dd-972a460ee9e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0a8060d-1fae-4b14-80dd-972a460ee9e9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '멜로드라마 <울루강의 얼음 깨짐>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0a8060d-1fae-4b14-80dd-972a460ee9e9'
);


-- Op. 31 남성 합창과 관현악을 위한 3개의 노래 Op. 31

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창과 관현악을 위한 3개의 노래 Op. 31', '3 Songs for Male Chorus and Orchestra, Op. 31', 'album', NULL, 'Op.', '31', 1914, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창과 관현악을 위한 3개의 노래 Op. 31'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7114ceac-9b4b-4694-aa39-34b637167b91'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7114ceac-9b4b-4694-aa39-34b637167b91'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창과 관현악을 위한 3개의 노래 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7114ceac-9b4b-4694-aa39-34b637167b91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9b7212f-6d8d-4c49-9115-237edfb437c2', 1, NULL, '레민카이넨을 위한 노래 (Laulu Lemminkäiselle)', 'No. 1 A Song for Lemminkäinen (Laulu Lemminkäiselle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창과 관현악을 위한 3개의 노래 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9b7212f-6d8d-4c49-9115-237edfb437c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1ecf6cc-e171-4b5a-9270-817c9acd4171', 2, NULL, 'Har du mod?', 'No. 2 Har du mod?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창과 관현악을 위한 3개의 노래 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1ecf6cc-e171-4b5a-9270-817c9acd4171'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92e3f639-0ffc-48c8-a580-b96d6a780ac3', 3, NULL, '아테네인의 노래 (Athenarnes sång)', 'No. 3 Song of the Athenians (Athenarnes sång)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창과 관현악을 위한 3개의 노래 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92e3f639-0ffc-48c8-a580-b96d6a780ac3'
);


-- Op. 32 칸타타 <불의 기원>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <불의 기원>', 'The Origin of Fire (Tulen synty)', 'song', 'Op. 32', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <불의 기원>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3968810c-8000-4b81-9534-888a048f84a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3968810c-8000-4b81-9534-888a048f84a6'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '칸타타 <불의 기원>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3968810c-8000-4b81-9534-888a048f84a6'
);


-- Op. 33 관현악 가곡 <Koskenlaskijan morsiamet>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 가곡 <Koskenlaskijan morsiamet>', 'The Rapids-Rider''s Brides (Koskenlaskijan morsiamet)', 'song', 'Op. 33', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 가곡 <Koskenlaskijan morsiamet>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6210970d-f3b5-4d56-9e28-95c009c8fa18'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6210970d-f3b5-4d56-9e28-95c009c8fa18'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '관현악 가곡 <Koskenlaskijan morsiamet>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6210970d-f3b5-4d56-9e28-95c009c8fa18'
);


-- Op. 34 10개의 바가텔 Op. 34

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '10개의 바가텔 Op. 34', '10 Bagatelles, Op. 34', 'album', NULL, 'Op.', '34', 1916, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '10개의 바가텔 Op. 34'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17c82a03-3652-4851-b903-1c4fd81562ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17c82a03-3652-4851-b903-1c4fd81562ec'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 바가텔 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17c82a03-3652-4851-b903-1c4fd81562ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d440045-a7cb-46cd-a493-166b4f8d459b', 1, NULL, '왈츠 D♭장조', 'No. 1 Valse in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 바가텔 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d440045-a7cb-46cd-a493-166b4f8d459b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59b99ce9-9ad3-48ce-80c0-d6fbdac07a69', 2, NULL, '춤의 아리아 (Air de danse) E장조', 'No. 2 Air de danse in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 바가텔 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59b99ce9-9ad3-48ce-80c0-d6fbdac07a69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abd64a5f-7f00-4b13-b7bd-23aea843f2df', 3, NULL, '마주르카 A장조', 'No. 3 Mazurka in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 바가텔 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abd64a5f-7f00-4b13-b7bd-23aea843f2df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2812ff1-8a74-414a-984b-61b08c86e383', 4, NULL, '쿠플레 D장조', 'No. 4 Couplet in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 바가텔 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2812ff1-8a74-414a-984b-61b08c86e383'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f01c2c0-4055-49d3-a98e-dadd99a606da', 5, NULL, '부타드 A♭장조', 'No. 5 Boutade in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 바가텔 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f01c2c0-4055-49d3-a98e-dadd99a606da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd9ebf1a-e8fe-43e5-9c9d-561fbc69ee00', 6, NULL, '몽상 (Rêverie) E단조', 'No. 6 Rêverie in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 바가텔 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd9ebf1a-e8fe-43e5-9c9d-561fbc69ee00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02d0e790-6d45-4a41-9941-4bedfe0e0737', 7, NULL, '전원 무곡 (Danse pastorale) A장조', 'No. 7 Danse pastorale in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 바가텔 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02d0e790-6d45-4a41-9941-4bedfe0e0737'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:372de5a7-12ad-4c8f-8f6a-de75b74c51bf', 8, NULL, '하프 타는 사람 (Joueur de harpe) B♭단조', 'No. 8 Joueur de harpe in B♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 바가텔 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:372de5a7-12ad-4c8f-8f6a-de75b74c51bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae50e96d-f650-4ca8-ad16-42dfab28be39', 9, NULL, '감사 (Reconnaissance) D장조', 'No. 9 Reconnaissance in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 바가텔 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae50e96d-f650-4ca8-ad16-42dfab28be39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d684c44-daad-4ceb-8eda-5bdbf649c710', 10, NULL, '추억 (Souvenir) A단조', 'No. 10 Souvenir in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 바가텔 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d684c44-daad-4ceb-8eda-5bdbf649c710'
);


-- Op. 35 2개의 가곡 Op. 35

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 가곡 Op. 35', '2 Songs, Op. 35', 'album', NULL, 'Op.', '35', 1908, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 가곡 Op. 35'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4bf9ab2-bf6a-4412-a6e0-5f76f9cd7ddc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4bf9ab2-bf6a-4412-a6e0-5f76f9cd7ddc'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 가곡 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4bf9ab2-bf6a-4412-a6e0-5f76f9cd7ddc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a17f09d7-843b-4c8f-b63f-44a106bd0d85', 1, NULL, 'Jubal', 'Jubal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 가곡 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a17f09d7-843b-4c8f-b63f-44a106bd0d85'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4222c2f-c24d-481d-8f27-f00605946c7d', 2, NULL, 'Teodora', 'Teodora', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 가곡 Op. 35' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4222c2f-c24d-481d-8f27-f00605946c7d'
);


-- Op. 36 6개의 가곡 Op. 36

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 가곡 Op. 36', '6 Songs, Op. 36', 'album', NULL, 'Op.', '36', 1900, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 가곡 Op. 36'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '674c40f2-84a3-4efb-aace-c6550895b329'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '674c40f2-84a3-4efb-aace-c6550895b329'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '674c40f2-84a3-4efb-aace-c6550895b329'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e35082f-1a7d-3356-8c50-5d6433f5212c', 1, NULL, '검은 장미 (Svarta rosor)', 'Svarta rosor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e35082f-1a7d-3356-8c50-5d6433f5212c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:175b761e-52f6-3b35-9359-fe11da3c917e', 2, NULL, 'Men min fågel märks dock icke', 'Men min fågel märks dock icke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:175b761e-52f6-3b35-9359-fe11da3c917e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28108659-c21e-421e-ae79-55ac2987d92c', 3, NULL, 'Bollspelet vid Trianon', 'Bollspelet vid Trianon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28108659-c21e-421e-ae79-55ac2987d92c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e00f42c6-51a7-3343-8f2f-7167aa6e8658', 4, NULL, 'Säv, säv, susa', 'Säv, säv, susa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e00f42c6-51a7-3343-8f2f-7167aa6e8658'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58f184ef-7b2c-4ead-98a1-de36ded574e3', 5, NULL, 'Marssnön', 'Marssnön', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58f184ef-7b2c-4ead-98a1-de36ded574e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21128882-6b2c-3b3b-9de9-7a5b8e280998', 6, NULL, 'Demanten på marssnön', 'Demanten på marssnön', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21128882-6b2c-3b3b-9de9-7a5b8e280998'
);


-- Op. 37 5개의 가곡 Op. 37

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 가곡 Op. 37', '5 Songs, Op. 37', 'album', NULL, 'Op.', '37', 1902, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 가곡 Op. 37'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2433c70c-3a26-4821-a474-555231c91bae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2433c70c-3a26-4821-a474-555231c91bae'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 가곡 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2433c70c-3a26-4821-a474-555231c91bae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06b3832c-b4dd-37e1-b2bf-1c812a80c581', 1, NULL, '첫 키스 (Den första kyssen)', 'Den första kyssen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 가곡 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06b3832c-b4dd-37e1-b2bf-1c812a80c581'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d979980-6d50-4dd7-8f5a-257ca0cdffd4', 2, NULL, 'Lasse liten', 'Lasse liten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 가곡 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d979980-6d50-4dd7-8f5a-257ca0cdffd4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b313b39f-7bd5-4d50-ad8d-f94e5e8053be', 3, NULL, 'Soluppgång', 'Soluppgång', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 가곡 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b313b39f-7bd5-4d50-ad8d-f94e5e8053be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8329fdda-7e6e-33bd-b356-88adb5d93a0e', 4, NULL, '그것은 꿈이었나 (Var det en dröm?)', 'Var det en dröm?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 가곡 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8329fdda-7e6e-33bd-b356-88adb5d93a0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:513724c2-7d1f-324c-8674-ba0ed17bf2fb', 5, NULL, '밀회에서 돌아온 소녀 (Flickan kom ifrån sin älsklings möte)', 'Flickan kom ifrån sin älsklings möte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 가곡 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:513724c2-7d1f-324c-8674-ba0ed17bf2fb'
);


-- Op. 38 5개의 가곡 Op. 38

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 가곡 Op. 38', '5 Songs, Op. 38', 'album', NULL, 'Op.', '38', 1904, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 가곡 Op. 38'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f4cba92-30c0-49ee-81b8-1a1d9e0aac7b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7f4cba92-30c0-49ee-81b8-1a1d9e0aac7b'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 가곡 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f4cba92-30c0-49ee-81b8-1a1d9e0aac7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb57544e-37e3-3a5c-8ed8-5bb3747a9797', 1, NULL, 'Höstkväll', 'Höstkväll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 가곡 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb57544e-37e3-3a5c-8ed8-5bb3747a9797'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4054a747-9985-3f24-961c-55b30f8a3561', 2, NULL, 'På verandan vid havet', 'På verandan vid havet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 가곡 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4054a747-9985-3f24-961c-55b30f8a3561'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c3c31a2-ce1a-43d8-b7b9-1ee5ac8e9461', 3, NULL, 'I natten', 'I natten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 가곡 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c3c31a2-ce1a-43d8-b7b9-1ee5ac8e9461'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38653b3d-04b9-4bcb-a34d-755ad9d43c9d', 4, NULL, 'Harpolekaren och hans son', 'Harpolekaren och hans son', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 가곡 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38653b3d-04b9-4bcb-a34d-755ad9d43c9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66a6b2a7-3d00-424a-8ad1-2dc7d322ac35', 5, NULL, 'Jag ville, jag vore i Indialand', 'Jag ville, jag vore i Indialand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 가곡 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66a6b2a7-3d00-424a-8ad1-2dc7d322ac35'
);


-- Op. 39 교향곡 1번 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번 E단조', 'Symphony No. 1 in E minor', 'album', 'Op. 39', NULL, NULL, 1900, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80b9c3cb-ac2f-4bb1-bf0c-dc13195c8c31'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '80b9c3cb-ac2f-4bb1-bf0c-dc13195c8c31'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80b9c3cb-ac2f-4bb1-bf0c-dc13195c8c31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c37d6e8a-d635-35f2-b778-b5c2cf4ed1f1', 1, 'I', 'Andante, ma non troppo – Allegro energico', 'I. Andante, ma non troppo – Allegro energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c37d6e8a-d635-35f2-b778-b5c2cf4ed1f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dab1f12f-b1db-37c4-90f8-33b0624d03dd', 2, 'II', 'Andante (ma non troppo lento)', 'II. Andante (ma non troppo lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dab1f12f-b1db-37c4-90f8-33b0624d03dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8e3ad5e-36c3-3ace-a632-421a2c30f7d5', 3, 'III', '스케르초. Allegro', 'III. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8e3ad5e-36c3-3ace-a632-421a2c30f7d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90d51ce9-673a-3fad-b9be-c507312ad53d', 4, 'IV', '피날레 (Quasi una fantasia). Andante – Allegro molto', 'IV. Finale (Quasi una fantasia). Andante – Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90d51ce9-673a-3fad-b9be-c507312ad53d'
);


-- Op. 40 10개의 서정적 상념 Op. 40

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '10개의 서정적 상념 Op. 40', '10 Pensées lyriques, Op. 40', 'album', NULL, 'Op.', '40', 1916, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '10개의 서정적 상념 Op. 40'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c95a72a-6464-46aa-8f49-549e1942b8b9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0c95a72a-6464-46aa-8f49-549e1942b8b9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 서정적 상념 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c95a72a-6464-46aa-8f49-549e1942b8b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a5e92f3-6f31-474c-99ac-c8bfb5d39320', 1, NULL, '작은 왈츠 (Valsette) E단조', 'No. 1 Valsette in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 서정적 상념 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a5e92f3-6f31-474c-99ac-c8bfb5d39320'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aacd99f9-d8c7-4bf1-9617-edefaf4fddfa', 2, NULL, '무언가 (Chant sans paroles) E단조', 'No. 2 Chant sans paroles in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 서정적 상념 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aacd99f9-d8c7-4bf1-9617-edefaf4fddfa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a083003-aa8a-44ee-9024-861613117f1b', 3, NULL, '유머레스크 C장조', 'No. 3 Humoresque in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 서정적 상념 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a083003-aa8a-44ee-9024-861613117f1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:093e1213-69c2-4e26-81e0-1dc4e699293f', 4, NULL, '미뉴에트 C장조', 'No. 4 Menuetto in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 서정적 상념 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:093e1213-69c2-4e26-81e0-1dc4e699293f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:203c50ba-f619-4b17-bcb7-df9f620a40b1', 5, NULL, '자장가 D장조', 'No. 5 Berceuse in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 서정적 상념 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:203c50ba-f619-4b17-bcb7-df9f620a40b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e279abf8-9cc0-455e-ab29-d9a43bafbd36', 6, NULL, '선율적 상념 (Pensée mélodique) C장조', 'No. 6 Pensée mélodique in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 서정적 상념 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e279abf8-9cc0-455e-ab29-d9a43bafbd36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4575eee1-e823-4820-821d-5b8318ec57b9', 7, NULL, '론돌레토 A♭장조', 'No. 7 Rondoletto in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 서정적 상념 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4575eee1-e823-4820-821d-5b8318ec57b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:114a348d-ca9e-49b0-a065-198802aa12ba', 8, NULL, '스케르찬도 A♭장조', 'No. 8 Scherzando in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 서정적 상념 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:114a348d-ca9e-49b0-a065-198802aa12ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5ba9d72-a3c0-4991-96f0-5eeb9bd00251', 9, NULL, '작은 세레나데 (Petite sérénade) B♭장조', 'No. 9 Petite sérénade in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 서정적 상념 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5ba9d72-a3c0-4991-96f0-5eeb9bd00251'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c210e02b-2483-4c0d-96ba-22639672f6a7', 10, NULL, '폴로네이즈 C장조', 'No. 10 Polonaise in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 서정적 상념 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c210e02b-2483-4c0d-96ba-22639672f6a7'
);


-- Op. 41 피아노 모음곡 <퀼리키>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <퀼리키>', 'Kyllikki', 'album', 'Op. 41', NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <퀼리키>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38487cd6-8321-430e-a746-71ffceb9a5f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38487cd6-8321-430e-a746-71ffceb9a5f9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <퀼리키>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38487cd6-8321-430e-a746-71ffceb9a5f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8835dc12-de62-350b-9ae9-8f5a966e9a1d', 1, 'I', 'Largamente – Allegro', 'I. Largamente – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <퀼리키>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8835dc12-de62-350b-9ae9-8f5a966e9a1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cea8a05e-7651-357e-81c1-7d51cc06d8f7', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <퀼리키>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cea8a05e-7651-357e-81c1-7d51cc06d8f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3101e8b3-7ffc-3589-9619-073bc61624bc', 3, 'III', 'Comodo', 'III. Comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <퀼리키>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3101e8b3-7ffc-3589-9619-073bc61624bc'
);


-- Op. 42 현악 합주를 위한 로망스 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 합주를 위한 로망스 C장조', 'Romance in C major for Strings', 'song', 'Op. 42', NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 합주를 위한 로망스 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e0a4f7d5-df6a-3f13-87ed-2fbef2259c9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e0a4f7d5-df6a-3f13-87ed-2fbef2259c9c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 합주를 위한 로망스 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e0a4f7d5-df6a-3f13-87ed-2fbef2259c9c'
);


-- Op. 43 교향곡 2번 D장조

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '74d08c2f-7b35-48d5-ac6f-3bc2a4c116d3'
FROM pieces p
WHERE p.id = 280 AND p.composer_id = 68
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74d08c2f-7b35-48d5-ac6f-3bc2a4c116d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3b2e32d-ba88-3cb1-a4d4-3df1b0df08dc', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 280 AND p.composer_id = 68
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3b2e32d-ba88-3cb1-a4d4-3df1b0df08dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26820388-1310-3847-bc07-b1b98a5c99cf', 2, 'II', 'Tempo andante, ma rubato', 'II. Tempo andante, ma rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 280 AND p.composer_id = 68
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26820388-1310-3847-bc07-b1b98a5c99cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90ba59b4-c6b0-3bf5-a317-fd9e39739ceb', 3, 'III', 'Vivacissimo', 'III. Vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 280 AND p.composer_id = 68
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90ba59b4-c6b0-3bf5-a317-fd9e39739ceb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:101f9ecd-7a55-33c8-b89a-7d62d996b5d5', 4, 'IV', '피날레. Allegro moderato', 'IV. Finale. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 280 AND p.composer_id = 68
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:101f9ecd-7a55-33c8-b89a-7d62d996b5d5'
);


-- Op. 44 <쿠올레마>에서 뽑은 2개의 소품 Op. 44

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<쿠올레마>에서 뽑은 2개의 소품 Op. 44', '2 Pieces from Kuolema, Op. 44', 'album', NULL, 'Op.', '44', 1906, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<쿠올레마>에서 뽑은 2개의 소품 Op. 44'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8224c547-e30b-4490-b8b4-5a0d2b413b94'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8224c547-e30b-4490-b8b4-5a0d2b413b94'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<쿠올레마>에서 뽑은 2개의 소품 Op. 44' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8224c547-e30b-4490-b8b4-5a0d2b413b94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 279 AND linked.composer_id = 68), 'musicbrainz:176827c6-c37d-3e24-81e8-8b1a4ba09b61', 1, NULL, '슬픈 왈츠 (Valse triste)', 'No. 1 Valse triste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<쿠올레마>에서 뽑은 2개의 소품 Op. 44' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:176827c6-c37d-3e24-81e8-8b1a4ba09b61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:543daf9a-a394-4a0c-9ba7-7c482a890930', 2, NULL, '학이 있는 정경 (Kurkikohtaus)', 'No. 2 Scene with Cranes (Kurkikohtaus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<쿠올레마>에서 뽑은 2개의 소품 Op. 44' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:543daf9a-a394-4a0c-9ba7-7c482a890930'
);


-- Op. 45 관현악을 위한 2개의 소품 Op. 45

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 2개의 소품 Op. 45', '2 Pieces for Orchestra, Op. 45', 'album', NULL, 'Op.', '45', 1910, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 2개의 소품 Op. 45'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20c672ac-e287-46fe-9839-dfe547ef19ae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '20c672ac-e287-46fe-9839-dfe547ef19ae'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '관현악을 위한 2개의 소품 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20c672ac-e287-46fe-9839-dfe547ef19ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e250456-0f06-4e6c-a009-bc39a41ea634', 1, NULL, '드리아드 (Dryadi)', 'No. 1 The Dryad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '관현악을 위한 2개의 소품 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e250456-0f06-4e6c-a009-bc39a41ea634'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f2ec909-d709-4e3a-9360-e0bb569c82b3', 2, NULL, '무도 간주곡 (Tanssi-Intermezzo)', 'No. 2 Dance Intermezzo (Tanssi-Intermezzo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '관현악을 위한 2개의 소품 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f2ec909-d709-4e3a-9360-e0bb569c82b3'
);


-- Op. 46 <펠레아스와 멜리장드> 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<펠레아스와 멜리장드> 모음곡', 'Pelléas et Mélisande Suite', 'album', 'Op. 46', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<펠레아스와 멜리장드> 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85082d0b-bc70-4c7d-af19-c4d116a4bdcd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '85082d0b-bc70-4c7d-af19-c4d116a4bdcd'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<펠레아스와 멜리장드> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85082d0b-bc70-4c7d-af19-c4d116a4bdcd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7864df15-2917-3a46-97c1-d991ea1e660c', 1, 'I', '성문에서 (Vid slottsporten)', 'I. At the Castle Gate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<펠레아스와 멜리장드> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7864df15-2917-3a46-97c1-d991ea1e660c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47bad149-6673-3723-9da9-d8f40df87f57', 2, 'II', '멜리장드 (Mélisande)', 'II. Mélisande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<펠레아스와 멜리장드> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47bad149-6673-3723-9da9-d8f40df87f57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a69f19a-d7c3-3f16-abf7-5d96bc274521', 3, 'III', '바닷가에서 (På stranden vid havet)', 'III. At the Seashore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<펠레아스와 멜리장드> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a69f19a-d7c3-3f16-abf7-5d96bc274521'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b989c22b-d0c8-31dd-aaf8-d1dfd6d2cd53', 4, 'IV', '공원의 샘 (En källa i parken)', 'IV. By a Spring in the Park', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<펠레아스와 멜리장드> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b989c22b-d0c8-31dd-aaf8-d1dfd6d2cd53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a633be91-2fb6-3a66-a06c-2cfa6468603f', 5, 'V', '세 눈먼 자매 (De trenne blinda systrar)', 'V. The Three Blind Sisters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<펠레아스와 멜리장드> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a633be91-2fb6-3a66-a06c-2cfa6468603f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f352069-d5b3-337f-8756-95a934560a84', 6, 'VI', '파스토랄', 'VI. Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<펠레아스와 멜리장드> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f352069-d5b3-337f-8756-95a934560a84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7241298b-2fe5-3347-ae16-9cbab6b10260', 7, 'VII', '물레 앞의 멜리장드 (Mélisande vid sländan)', 'VII. Mélisande at the Spinning Wheel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<펠레아스와 멜리장드> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7241298b-2fe5-3347-ae16-9cbab6b10260'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c08193d4-3fa3-395b-8cf0-e403c514ff6f', 8, 'VIII', '간주곡 (Mellanaktsmusik)', 'VIII. Entr''acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<펠레아스와 멜리장드> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c08193d4-3fa3-395b-8cf0-e403c514ff6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efd39efb-a9b9-3d78-8b47-0e7003ad799b', 9, 'IX', '멜리장드의 죽음 (Mélisandes död)', 'IX. The Death of Mélisande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<펠레아스와 멜리장드> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efd39efb-a9b9-3d78-8b47-0e7003ad799b'
);


-- Op. 47 바이올린 협주곡 D단조

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '67843334-ebe7-46b8-8154-199b37a40e4f'
FROM pieces p
WHERE p.id = 278 AND p.composer_id = 68
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67843334-ebe7-46b8-8154-199b37a40e4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9159906a-0a5c-30fc-84e9-950f69b5170c', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 278 AND p.composer_id = 68
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9159906a-0a5c-30fc-84e9-950f69b5170c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fadd25b-ca18-376c-b0a5-e90832601ace', 2, 'II', 'Adagio di molto', 'II. Adagio di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 278 AND p.composer_id = 68
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fadd25b-ca18-376c-b0a5-e90832601ace'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba481af9-9f35-31c4-813e-4fc73a1f52ea', 3, 'III', 'Allegro (ma non tanto)', 'III. Allegro (ma non tanto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 278 AND p.composer_id = 68
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba481af9-9f35-31c4-813e-4fc73a1f52ea'
);


-- Op. 48 칸타타 <해방된 여왕>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <해방된 여왕>', 'The Captive Queen (Vapautettu kuningatar)', 'song', 'Op. 48', NULL, NULL, 1906, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <해방된 여왕>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb0a21da-ec02-48cf-86de-3b9ac8bdaf0e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fb0a21da-ec02-48cf-86de-3b9ac8bdaf0e'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '칸타타 <해방된 여왕>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb0a21da-ec02-48cf-86de-3b9ac8bdaf0e'
);


-- Op. 49 교향시 <포욜라의 딸>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <포욜라의 딸>', 'Pohjola''s Daughter (Pohjolan tytär)', 'song', 'Op. 49', NULL, NULL, 1906, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <포욜라의 딸>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9252560d-0c5b-3eb4-a838-9d25784e7ac3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9252560d-0c5b-3eb4-a838-9d25784e7ac3'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향시 <포욜라의 딸>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9252560d-0c5b-3eb4-a838-9d25784e7ac3'
);


-- Op. 50 6개의 가곡 Op. 50

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 가곡 Op. 50', '6 Songs, Op. 50', 'album', NULL, 'Op.', '50', 1906, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 가곡 Op. 50'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '593a8f0e-0f31-4f7d-8a99-925d7ec38e22'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '593a8f0e-0f31-4f7d-8a99-925d7ec38e22'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '593a8f0e-0f31-4f7d-8a99-925d7ec38e22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04aa26d9-c95c-4968-bcf3-93456e14262c', 1, NULL, 'Lenzgesang', 'Lenzgesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04aa26d9-c95c-4968-bcf3-93456e14262c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a004d95-fd40-45dc-ac9c-54ed0da0dd59', 2, NULL, 'Sehnsucht', 'Sehnsucht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a004d95-fd40-45dc-ac9c-54ed0da0dd59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ade63a1a-180b-389a-90bc-975f731b2be0', 3, NULL, 'Im Feld ein Mädchen singt', 'Im Feld ein Mädchen singt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ade63a1a-180b-389a-90bc-975f731b2be0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54ff02e4-f72d-31c7-8362-861fa95788d9', 4, NULL, 'Aus banger Brust', 'Aus banger Brust', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54ff02e4-f72d-31c7-8362-861fa95788d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d037cf2-6f69-390b-a04b-fdf76c9a0b33', 5, NULL, 'Die stille Stadt', 'Die stille Stadt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d037cf2-6f69-390b-a04b-fdf76c9a0b33'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63df5369-2cae-4062-981d-95ede8e8b239', 6, NULL, 'Rosenlied', 'Rosenlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63df5369-2cae-4062-981d-95ede8e8b239'
);


-- Op. 51 <벨사살의 향연> 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<벨사살의 향연> 모음곡', 'Belshazzar''s Feast Suite', 'album', 'Op. 51', NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<벨사살의 향연> 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '23658583-bdfb-438b-a296-70b61107e10b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '23658583-bdfb-438b-a296-70b61107e10b'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<벨사살의 향연> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '23658583-bdfb-438b-a296-70b61107e10b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:801af0b4-0b44-429f-97bd-2da84c87edad', 1, 'I', '동방의 행렬 (Orientalisk marsch)', 'I. Oriental Procession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<벨사살의 향연> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:801af0b4-0b44-429f-97bd-2da84c87edad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6e9a2b2-2683-4490-874a-3a06a0303f9c', 2, 'II', '고독 (Solitude)', 'II. Solitude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<벨사살의 향연> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6e9a2b2-2683-4490-874a-3a06a0303f9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:125ade98-ba74-4bc9-8d7d-3115541b74db', 3, 'III', '녹턴', 'III. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<벨사살의 향연> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:125ade98-ba74-4bc9-8d7d-3115541b74db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feec4517-b696-4066-8f89-4ca0cd868514', 4, 'IV', '카드라의 춤 (Khadras dans)', 'IV. Khadra''s Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<벨사살의 향연> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feec4517-b696-4066-8f89-4ca0cd868514'
);


-- Op. 52 교향곡 3번 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 3번 C장조', 'Symphony No. 3 in C major', 'album', 'Op. 52', NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 3번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '440c6550-3b70-4538-aaf7-cfe02da15dd0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '440c6550-3b70-4538-aaf7-cfe02da15dd0'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 3번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '440c6550-3b70-4538-aaf7-cfe02da15dd0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da18dec7-9f7a-3dab-a8ea-ec7908d93e0d', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 3번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da18dec7-9f7a-3dab-a8ea-ec7908d93e0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb94f889-48b0-3b67-870b-78c994615ea9', 2, 'II', 'Andantino con moto, quasi allegretto', 'II. Andantino con moto, quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 3번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb94f889-48b0-3b67-870b-78c994615ea9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a17a55c5-3a98-3b93-bef4-7d5f503cb726', 3, 'III', 'Moderato – Allegro (ma non tanto)', 'III. Moderato – Allegro (ma non tanto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 3번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a17a55c5-3a98-3b93-bef4-7d5f503cb726'
);


-- Op. 53 관현악을 위한 <판과 에코>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <판과 에코>', 'Pan and Echo (Pan och Echo)', 'song', 'Op. 53', NULL, NULL, 1906, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <판과 에코>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ef5b4b9-de0a-4cb3-9b8f-d4c8b8121905'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ef5b4b9-de0a-4cb3-9b8f-d4c8b8121905'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '관현악을 위한 <판과 에코>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ef5b4b9-de0a-4cb3-9b8f-d4c8b8121905'
);


-- Op. 54 <백조 공주> 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<백조 공주> 모음곡', 'Swanwhite Suite (Svanevit)', 'album', 'Op. 54', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<백조 공주> 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '491b9736-d165-4232-be86-73e4f8bdf7db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '491b9736-d165-4232-be86-73e4f8bdf7db'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<백조 공주> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '491b9736-d165-4232-be86-73e4f8bdf7db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ce1e545-40a8-4898-8ab3-b0a7b269a4a8', 1, 'I', '공작 (Påfågeln)', 'I. The Peacock', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<백조 공주> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ce1e545-40a8-4898-8ab3-b0a7b269a4a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5696b01b-e3c0-471c-b0dc-2ae7f0793f1e', 2, 'II', '하프 (Harpan)', 'II. The Harp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<백조 공주> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5696b01b-e3c0-471c-b0dc-2ae7f0793f1e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:491c2973-a4ed-415e-866c-3c2dc1857c8e', 3, 'III', '장미를 든 처녀들 (Tärnorna med rosor)', 'III. The Maiden with the Roses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<백조 공주> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:491c2973-a4ed-415e-866c-3c2dc1857c8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bee7e1b-b425-46ce-8fd8-646f04af1a1f', 4, 'IV', '들어 봐, 울새가 노래한다 (Hör rödhaken slå)', 'IV. Listen! The Robin Sings', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<백조 공주> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bee7e1b-b425-46ce-8fd8-646f04af1a1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d271f3a-c27c-44a0-b406-8460cc3d697a', 5, 'V', '홀로 있는 왕자 (Prinsen allena)', 'V. The Prince Alone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<백조 공주> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d271f3a-c27c-44a0-b406-8460cc3d697a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:010bbad0-7936-46a0-9418-706a7d221bfb', 6, 'VI', '백조 공주와 왕자 (Svanevit och prinsen)', 'VI. Swanwhite and the Prince', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<백조 공주> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:010bbad0-7936-46a0-9418-706a7d221bfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8fc42f7-6abe-4a9c-bc6f-29704c1abc7d', 7, 'VII', '찬가 (Lovsång)', 'VII. Song of Praise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<백조 공주> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8fc42f7-6abe-4a9c-bc6f-29704c1abc7d'
);


-- Op. 55 교향시 <밤의 질주와 해돋이>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <밤의 질주와 해돋이>', 'Nightride and Sunrise', 'song', 'Op. 55', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <밤의 질주와 해돋이>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '367f1887-de5a-3864-9fbf-1251b1dbe15f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '367f1887-de5a-3864-9fbf-1251b1dbe15f'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향시 <밤의 질주와 해돋이>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '367f1887-de5a-3864-9fbf-1251b1dbe15f'
);


-- Op. 56 현악 4중주 D단조 "친밀한 목소리"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 D단조 "친밀한 목소리"', 'String Quartet in D minor "Voces intimae"', 'album', 'Op. 56', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 D단조 "친밀한 목소리"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8c7787c-7120-4180-8ef2-0f544fdfb6a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f8c7787c-7120-4180-8ef2-0f544fdfb6a4'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 D단조 "친밀한 목소리"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8c7787c-7120-4180-8ef2-0f544fdfb6a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0c9794b-8740-322b-abc2-7cf731e805b8', 1, 'I', 'Andante – Allegro molto moderato', 'I. Andante – Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 D단조 "친밀한 목소리"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0c9794b-8740-322b-abc2-7cf731e805b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:407470d6-ecae-3344-8da6-046b29e3b61e', 2, 'II', 'Vivace', 'II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 D단조 "친밀한 목소리"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:407470d6-ecae-3344-8da6-046b29e3b61e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86d166d2-c8be-3693-95c6-47d6df9abd90', 3, 'III', 'Adagio di molto', 'III. Adagio di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 D단조 "친밀한 목소리"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86d166d2-c8be-3693-95c6-47d6df9abd90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:413e3375-baea-3f0e-a211-5791dee34c4c', 4, 'IV', 'Allegretto (ma pesante)', 'IV. Allegretto (ma pesante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 D단조 "친밀한 목소리"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:413e3375-baea-3f0e-a211-5791dee34c4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35297c1f-8fb2-3573-bbd1-b35a70b0b449', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 D단조 "친밀한 목소리"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35297c1f-8fb2-3573-bbd1-b35a70b0b449'
);


-- Op. 57 요셉손 시에 의한 8개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '요셉손 시에 의한 8개의 가곡', '8 Songs on Poems by Josephson, Op. 57', 'album', 'Op. 57', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '요셉손 시에 의한 8개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d2a34f4-d658-4323-9e20-1f3be3538546'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6d2a34f4-d658-4323-9e20-1f3be3538546'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '요셉손 시에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d2a34f4-d658-4323-9e20-1f3be3538546'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c1af594-3f6b-4ffa-a71c-6d51e522f8a6', 1, NULL, 'Älven och snigeln', 'Älven och snigeln', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '요셉손 시에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c1af594-3f6b-4ffa-a71c-6d51e522f8a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d4d42fd-9ad8-4fae-b86d-2fc0eeca73c9', 2, NULL, 'En blomma stod vid vägen', 'En blomma stod vid vägen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '요셉손 시에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d4d42fd-9ad8-4fae-b86d-2fc0eeca73c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c1b0ec0-007b-4a73-92ed-a0c0256cf68d', 3, NULL, 'Kvarnhjulet', 'Kvarnhjulet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '요셉손 시에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c1b0ec0-007b-4a73-92ed-a0c0256cf68d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72057e3e-a1e0-4e43-afa8-10f54c38b397', 4, NULL, 'Maj', 'Maj', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '요셉손 시에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72057e3e-a1e0-4e43-afa8-10f54c38b397'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffff7586-f8e3-3c8f-9a84-f6f8d1bf9dab', 5, NULL, 'Jag är ett träd', 'Jag är ett träd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '요셉손 시에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffff7586-f8e3-3c8f-9a84-f6f8d1bf9dab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ae9cf64-b233-4cb6-9e19-5e6dfe81798e', 6, NULL, 'Hertig Magnus', 'Hertig Magnus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '요셉손 시에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ae9cf64-b233-4cb6-9e19-5e6dfe81798e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07f54c78-3b0b-42a8-8f53-5dab10322dd6', 7, NULL, 'Vänskapens blomma', 'Vänskapens blomma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '요셉손 시에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07f54c78-3b0b-42a8-8f53-5dab10322dd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a387b0a8-7760-49f3-9cab-cbe4e26dcb7f', 8, NULL, 'Näcken', 'Näcken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '요셉손 시에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a387b0a8-7760-49f3-9cab-cbe4e26dcb7f'
);


-- Op. 58 10개의 피아노 소품 Op. 58

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '10개의 피아노 소품 Op. 58', '10 Pieces for Piano, Op. 58', 'album', NULL, 'Op.', '58', 1909, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '10개의 피아노 소품 Op. 58'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ceae2158-500d-4121-a16d-5aa4ae24ca29'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ceae2158-500d-4121-a16d-5aa4ae24ca29'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ceae2158-500d-4121-a16d-5aa4ae24ca29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc53b732-1168-4d2e-9291-3c83bbfa8e59', 1, NULL, '몽상 (Rêverie)', 'No. 1 Rêverie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc53b732-1168-4d2e-9291-3c83bbfa8e59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59f0e87d-26fb-44c2-910f-fb0aae6f3f98', 2, NULL, '스케르치노', 'No. 2 Scherzino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59f0e87d-26fb-44c2-910f-fb0aae6f3f98'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f07c62cb-3c52-4f24-b36d-a766a04578a2', 3, NULL, '변주가 붙은 아리아 (Air varié)', 'No. 3 Air varié', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f07c62cb-3c52-4f24-b36d-a766a04578a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc1a3a9b-41d3-4394-84b3-4531d7bec138', 4, NULL, '목동 (Der Hirt)', 'No. 4 Der Hirt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc1a3a9b-41d3-4394-84b3-4531d7bec138'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e56a74d-65f1-4b2e-8b36-4cc3c99dca78', 5, NULL, '저녁에 (Des Abends)', 'No. 5 Des Abends', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e56a74d-65f1-4b2e-8b36-4cc3c99dca78'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e749afaf-0084-4ddc-b05e-40f64a27725d', 6, NULL, '대화 (Dialogue)', 'No. 6 Dialogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e749afaf-0084-4ddc-b05e-40f64a27725d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e04d6e77-c114-446f-806c-90f7972d3b86', 7, NULL, 'Tempo di minuetto', 'No. 7 Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e04d6e77-c114-446f-806c-90f7972d3b86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b2e6864-d9f3-4254-bc30-eb927a847790', 8, NULL, '어부의 노래 (Fischerlied)', 'No. 8 Fischerlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b2e6864-d9f3-4254-bc30-eb927a847790'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19e96c90-b96e-41f7-beb0-a8e3f5b56f63', 9, NULL, '세레나데 (Ständchen)', 'No. 9 Ständchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19e96c90-b96e-41f7-beb0-a8e3f5b56f63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b1f5d23-9f4e-46ef-97c4-bba570278bb3', 10, NULL, '여름 노래 (Sommerlied)', 'No. 10 Sommerlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '10개의 피아노 소품 Op. 58' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b1f5d23-9f4e-46ef-97c4-bba570278bb3'
);


-- Op. 59 관현악을 위한 장송 행진곡 <인 메모리암>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 장송 행진곡 <인 메모리암>', 'In memoriam, Funeral March for Orchestra', 'song', 'Op. 59', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 장송 행진곡 <인 메모리암>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f72dc80a-f2bc-42a6-bc8f-6da9a820bf58'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f72dc80a-f2bc-42a6-bc8f-6da9a820bf58'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '관현악을 위한 장송 행진곡 <인 메모리암>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f72dc80a-f2bc-42a6-bc8f-6da9a820bf58'
);


-- Op. 60 <십이야>에 의한 2개의 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<십이야>에 의한 2개의 노래', '2 Songs from Twelfth Night, Op. 60', 'album', 'Op. 60', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<십이야>에 의한 2개의 노래'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db63dba4-d368-4ade-831e-13016b2486ac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'db63dba4-d368-4ade-831e-13016b2486ac'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<십이야>에 의한 2개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db63dba4-d368-4ade-831e-13016b2486ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50fc7d43-468d-4f21-9b34-13641dd737a4', 1, NULL, 'Kom nu hit, död', 'Kom nu hit, död', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<십이야>에 의한 2개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50fc7d43-468d-4f21-9b34-13641dd737a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb2a3581-5f63-4d07-990c-6c8b3743c39d', 2, NULL, 'Hållilå, uti storm och i regn', 'Hållilå, uti storm och i regn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<십이야>에 의한 2개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb2a3581-5f63-4d07-990c-6c8b3743c39d'
);


-- Op. 61 8개의 가곡 Op. 61

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '8개의 가곡 Op. 61', '8 Songs, Op. 61', 'album', NULL, 'Op.', '61', 1910, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '8개의 가곡 Op. 61'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27ac514d-bda0-4c80-b793-6adbf560fad0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '27ac514d-bda0-4c80-b793-6adbf560fad0'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 가곡 Op. 61' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27ac514d-bda0-4c80-b793-6adbf560fad0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0a0bad8-cb85-414d-9386-b72ca0dc0c6e', 1, NULL, 'Långsamt som kvällskyn', 'Långsamt som kvällskyn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 가곡 Op. 61' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0a0bad8-cb85-414d-9386-b72ca0dc0c6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73e960ea-8d7e-4974-9109-cc87e5b9583e', 2, NULL, 'Vattenplask', 'Vattenplask', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 가곡 Op. 61' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73e960ea-8d7e-4974-9109-cc87e5b9583e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0587450-72d8-488c-a398-e18c3ce89d8c', 3, NULL, 'När jag drömmer', 'När jag drömmer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 가곡 Op. 61' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0587450-72d8-488c-a398-e18c3ce89d8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3fc2f64-c651-4cc7-8e20-bc5a100e8491', 4, NULL, 'Romeo', 'Romeo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 가곡 Op. 61' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3fc2f64-c651-4cc7-8e20-bc5a100e8491'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18e4c883-0261-4661-8f7f-142599235af0', 5, NULL, 'Romans', 'Romans', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 가곡 Op. 61' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18e4c883-0261-4661-8f7f-142599235af0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33018e23-9cab-499c-be1d-4061ff0678c1', 6, NULL, 'Dolce far niente', 'Dolce far niente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 가곡 Op. 61' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33018e23-9cab-499c-be1d-4061ff0678c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:496f4464-49bb-4483-9329-a7428c5b0485', 7, NULL, 'Fåfäng önskan', 'Fåfäng önskan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 가곡 Op. 61' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:496f4464-49bb-4483-9329-a7428c5b0485'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8c286a0-c045-42bd-8260-0d0363fc99ba', 8, NULL, 'Vårtagen', 'Vårtagen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 가곡 Op. 61' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8c286a0-c045-42bd-8260-0d0363fc99ba'
);


-- Op. 62 <쿠올레마>를 위한 2개의 소품 Op. 62

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<쿠올레마>를 위한 2개의 소품 Op. 62', '2 Pieces for Kuolema, Op. 62', 'album', NULL, 'Op.', '62', 1911, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<쿠올레마>를 위한 2개의 소품 Op. 62'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a38ab28-e2fd-435d-8c96-52835a7b8e92'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9a38ab28-e2fd-435d-8c96-52835a7b8e92'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<쿠올레마>를 위한 2개의 소품 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a38ab28-e2fd-435d-8c96-52835a7b8e92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92f05846-c5f2-4042-9b6c-cbb250fb4c68', 1, NULL, '칸초네타', 'No. 1 Canzonetta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<쿠올레마>를 위한 2개의 소품 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92f05846-c5f2-4042-9b6c-cbb250fb4c68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d625781-c31a-476d-b8fe-47a715edafa2', 2, NULL, '낭만적 왈츠 (Valse romantique)', 'No. 2 Valse romantique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<쿠올레마>를 위한 2개의 소품 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d625781-c31a-476d-b8fe-47a715edafa2'
);


-- Op. 63 교향곡 4번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 4번 A단조', 'Symphony No. 4 in A minor', 'album', 'Op. 63', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 4번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c4b9157-7406-41e6-a448-37afa949670c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9c4b9157-7406-41e6-a448-37afa949670c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 4번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c4b9157-7406-41e6-a448-37afa949670c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:018b096d-9e9b-39c3-8380-d82541fa9eeb', 1, 'I', 'Tempo molto moderato, quasi adagio', 'I. Tempo molto moderato, quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 4번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:018b096d-9e9b-39c3-8380-d82541fa9eeb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9020ce7c-df42-35bc-b07d-28308e77bff4', 2, 'II', 'Allegro molto vivace', 'II. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 4번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9020ce7c-df42-35bc-b07d-28308e77bff4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b4894b2-6125-3960-816a-c62541651fa2', 3, 'III', 'Il tempo largo', 'III. Il tempo largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 4번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b4894b2-6125-3960-816a-c62541651fa2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bad7a5da-b20d-351d-939e-923b750fb9fc', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 4번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bad7a5da-b20d-351d-939e-923b750fb9fc'
);


-- Op. 64 교향시 <음유시인>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <음유시인>', 'The Bard (Barden)', 'song', 'Op. 64', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <음유시인>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51f3e07c-b51b-34e0-bf33-2e2e8039ee5f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51f3e07c-b51b-34e0-bf33-2e2e8039ee5f'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향시 <음유시인>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51f3e07c-b51b-34e0-bf33-2e2e8039ee5f'
);


-- Op. 65 혼성 합창곡 Op. 65

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '혼성 합창곡 Op. 65', '2 Part-Songs for Mixed Chorus, Op. 65', 'album', NULL, 'Op.', '65', 1912, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '혼성 합창곡 Op. 65'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9799799-4d7a-489c-8ae4-98f5620b74c1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a9799799-4d7a-489c-8ae4-98f5620b74c1'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '혼성 합창곡 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9799799-4d7a-489c-8ae4-98f5620b74c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:259d4fe2-4692-4888-a262-b97aa1515e0d', 1, NULL, 'Män från slätten och havet', 'Män från slätten och havet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '혼성 합창곡 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:259d4fe2-4692-4888-a262-b97aa1515e0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:521aa920-4814-4d74-97d1-a07d52e43f8b', 2, NULL, 'Kallion kirkon kellosävel', 'Kallion kirkon kellosävel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '혼성 합창곡 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:521aa920-4814-4d74-97d1-a07d52e43f8b'
);


-- Op. 66 <역사적 장면> 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<역사적 장면> 2번', 'Scènes historiques II', 'album', 'Op. 66', NULL, NULL, 1912, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<역사적 장면> 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '665c121a-fc1b-4b04-a21f-a944d0f9bbe8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '665c121a-fc1b-4b04-a21f-a944d0f9bbe8'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<역사적 장면> 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '665c121a-fc1b-4b04-a21f-a944d0f9bbe8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b80b04a8-e05c-4eaf-8e49-c290d395ea7f', 1, 'I', '사냥 (Metsästys)', 'I. The Hunt (Metsästys)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<역사적 장면> 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b80b04a8-e05c-4eaf-8e49-c290d395ea7f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2492e693-f8bd-450a-9de3-fd18c7308e3c', 2, 'II', '사랑의 노래 (Minnelaulu)', 'II. Love Song (Minnelaulu)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<역사적 장면> 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2492e693-f8bd-450a-9de3-fd18c7308e3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f681b4c-934b-4a9f-93a9-add181de596a', 3, 'III', '도개교에서 (Nostosillalla)', 'III. At the Draw-Bridge (Nostosillalla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<역사적 장면> 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f681b4c-934b-4a9f-93a9-add181de596a'
);


-- Op. 67 3개의 소나티나 Op. 67

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 소나티나 Op. 67', '3 Sonatinas, Op. 67', 'album', NULL, 'Op.', '67', 1912, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 소나티나 Op. 67'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52e9b2d4-46db-4bf5-9ba7-07a57f32589c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52e9b2d4-46db-4bf5-9ba7-07a57f32589c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3개의 소나티나 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52e9b2d4-46db-4bf5-9ba7-07a57f32589c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:368bed89-e018-490d-9e68-54cbf19db6db', 1, NULL, '소나티나 1번 F#단조', 'No. 1 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3개의 소나티나 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:368bed89-e018-490d-9e68-54cbf19db6db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f375aaa-727a-3337-b050-7d4fa70184c9', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:368bed89-e018-490d-9e68-54cbf19db6db'
WHERE p.composer_id = 68 AND p.title = '3개의 소나티나 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f375aaa-727a-3337-b050-7d4fa70184c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84c57424-70e3-31db-b951-245fbfdcf901', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:368bed89-e018-490d-9e68-54cbf19db6db'
WHERE p.composer_id = 68 AND p.title = '3개의 소나티나 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84c57424-70e3-31db-b951-245fbfdcf901'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca8dbc64-9c71-3ad8-8d3a-8eef45d82eff', 3, 'III', 'Allegro moderato', 'III. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:368bed89-e018-490d-9e68-54cbf19db6db'
WHERE p.composer_id = 68 AND p.title = '3개의 소나티나 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca8dbc64-9c71-3ad8-8d3a-8eef45d82eff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4e790e1-b36b-4a8a-90b7-985b06da0641', 2, NULL, '소나티나 2번 E장조', 'No. 2 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3개의 소나티나 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4e790e1-b36b-4a8a-90b7-985b06da0641'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13e96860-6c90-3363-8b05-20e0dd0dd781', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4e790e1-b36b-4a8a-90b7-985b06da0641'
WHERE p.composer_id = 68 AND p.title = '3개의 소나티나 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13e96860-6c90-3363-8b05-20e0dd0dd781'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc6dc895-567d-3254-b696-7ff27cb6276d', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4e790e1-b36b-4a8a-90b7-985b06da0641'
WHERE p.composer_id = 68 AND p.title = '3개의 소나티나 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc6dc895-567d-3254-b696-7ff27cb6276d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ecbc2b27-7acf-4085-9b86-5c3ffbbd5005', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4e790e1-b36b-4a8a-90b7-985b06da0641'
WHERE p.composer_id = 68 AND p.title = '3개의 소나티나 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecbc2b27-7acf-4085-9b86-5c3ffbbd5005'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97af00b2-b997-4cae-bc57-106056f33da8', 3, NULL, '소나티나 3번 B♭단조', 'No. 3 in B♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3개의 소나티나 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97af00b2-b997-4cae-bc57-106056f33da8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9ffe99a5-040d-3992-b1a9-cfa379787294', 1, 'I', 'Andante – Allegro moderato', 'I. Andante – Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97af00b2-b997-4cae-bc57-106056f33da8'
WHERE p.composer_id = 68 AND p.title = '3개의 소나티나 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ffe99a5-040d-3992-b1a9-cfa379787294'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2fa87d7b-2bf4-3006-a992-aa9f98bf4f76', 2, 'II', 'Andante – Allegretto', 'II. Andante – Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97af00b2-b997-4cae-bc57-106056f33da8'
WHERE p.composer_id = 68 AND p.title = '3개의 소나티나 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fa87d7b-2bf4-3006-a992-aa9f98bf4f76'
);


-- Op. 68 2개의 론디노 Op. 68

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 론디노 Op. 68', '2 Rondinos, Op. 68', 'album', NULL, 'Op.', '68', 1912, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 론디노 Op. 68'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '860a03ba-d6fd-4006-8367-52d3d1a32c67'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '860a03ba-d6fd-4006-8367-52d3d1a32c67'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 론디노 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '860a03ba-d6fd-4006-8367-52d3d1a32c67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b919f34-b565-4663-a0fa-d5f29ba59169', 1, NULL, 'G#단조', 'No. 1 in G# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 론디노 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b919f34-b565-4663-a0fa-d5f29ba59169'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8421054b-7667-48a3-b5ce-fd60d6c8362e', 2, NULL, 'C#단조', 'No. 2 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 론디노 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8421054b-7667-48a3-b5ce-fd60d6c8362e'
);


-- Op. 69 바이올린과 관현악을 위한 2개의 세레나데 Op. 69

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 관현악을 위한 2개의 세레나데 Op. 69', '2 Serenades for Violin and Orchestra, Op. 69', 'album', NULL, 'Op.', '69', 1913, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 관현악을 위한 2개의 세레나데 Op. 69'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49b90052-9476-465d-bf17-e96e09897a5f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '49b90052-9476-465d-bf17-e96e09897a5f'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 관현악을 위한 2개의 세레나데 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49b90052-9476-465d-bf17-e96e09897a5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:934b8c25-32fb-435a-a76b-20ce0832f786', 1, NULL, '세레나데 1번 D장조', 'No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 관현악을 위한 2개의 세레나데 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:934b8c25-32fb-435a-a76b-20ce0832f786'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83b15009-7a7f-45fb-9ed6-18cb0045521a', 2, NULL, '세레나데 2번 G단조', 'No. 2 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 관현악을 위한 2개의 세레나데 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83b15009-7a7f-45fb-9ed6-18cb0045521a'
);


-- Op. 70 소프라노와 관현악을 위한 교향시 <루온노타르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소프라노와 관현악을 위한 교향시 <루온노타르>', 'Luonnotar', 'song', 'Op. 70', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소프라노와 관현악을 위한 교향시 <루온노타르>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c365fd0-a4b4-4d9f-b17b-5e172f8d48d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c365fd0-a4b4-4d9f-b17b-5e172f8d48d9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '소프라노와 관현악을 위한 교향시 <루온노타르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c365fd0-a4b4-4d9f-b17b-5e172f8d48d9'
);


-- Op. 71 발레 판토마임 <스카라무슈>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 판토마임 <스카라무슈>', 'Scaramouche', 'song', 'Op. 71', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 판토마임 <스카라무슈>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c74cd70-8cf0-48f8-9ed3-560edfcc23da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c74cd70-8cf0-48f8-9ed3-560edfcc23da'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '발레 판토마임 <스카라무슈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c74cd70-8cf0-48f8-9ed3-560edfcc23da'
);


-- Op. 72 6개의 가곡 Op. 72

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 가곡 Op. 72', '6 Songs, Op. 72', 'album', NULL, 'Op.', '72', 1915, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 가곡 Op. 72'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e5ba8d2-29a6-4793-8a79-814e4718c1e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e5ba8d2-29a6-4793-8a79-814e4718c1e8'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e5ba8d2-29a6-4793-8a79-814e4718c1e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3609142-e95b-4151-a1bf-e81aee229a13', 1, NULL, 'Kyssen', 'No. 3 Kyssen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3609142-e95b-4151-a1bf-e81aee229a13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:665c5bb9-b8c3-35e1-96cb-63b9483e0066', 2, NULL, 'Kaiutar', 'No. 4 Kaiutar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:665c5bb9-b8c3-35e1-96cb-63b9483e0066'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c848420-7a76-4ee3-b838-b5c7fe008e9a', 3, NULL, 'Der Wanderer und der Bach', 'No. 5 Der Wanderer und der Bach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c848420-7a76-4ee3-b838-b5c7fe008e9a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d73feff4-8962-4e6f-8297-d18a6db763b0', 4, NULL, 'Hundra vägar', 'No. 6 Hundra vägar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d73feff4-8962-4e6f-8297-d18a6db763b0'
);


-- Op. 73 교향시 <대양의 요정>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <대양의 요정>', 'The Oceanides (Aallottaret)', 'song', 'Op. 73', NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <대양의 요정>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '301319e9-312a-4af2-8b77-c78a0c5d9be5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '301319e9-312a-4af2-8b77-c78a0c5d9be5'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향시 <대양의 요정>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '301319e9-312a-4af2-8b77-c78a0c5d9be5'
);


-- Op. 74 4개의 서정적 소품 Op. 74

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 서정적 소품 Op. 74', '4 Lyric Pieces, Op. 74', 'album', NULL, 'Op.', '74', 1914, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 서정적 소품 Op. 74'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '979f4245-f7aa-4a66-a1d5-72aab53f37d8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '979f4245-f7aa-4a66-a1d5-72aab53f37d8'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '4개의 서정적 소품 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '979f4245-f7aa-4a66-a1d5-72aab53f37d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d0f8c71-d2b4-4f8e-aaf7-7230250a9bd8', 1, NULL, '목가 (Ekloge)', 'No. 1 Ekloge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '4개의 서정적 소품 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d0f8c71-d2b4-4f8e-aaf7-7230250a9bd8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99fe5d07-4953-41f9-9984-f4c3e0f1cd85', 2, NULL, '부드러운 서풍 (Sanfter Westwind)', 'No. 2 Sanfter Westwind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '4개의 서정적 소품 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99fe5d07-4953-41f9-9984-f4c3e0f1cd85'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:763fca83-004b-485e-a8c6-ec849db319bd', 3, NULL, '무도회에서 (Auf dem Tanzvergnügen)', 'No. 3 Auf dem Tanzvergnügen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '4개의 서정적 소품 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:763fca83-004b-485e-a8c6-ec849db319bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07e81402-5363-4a16-a864-67c8b7fb8999', 4, NULL, '옛집에서 (Im alten Heim)', 'No. 4 Im alten Heim', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '4개의 서정적 소품 Op. 74' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07e81402-5363-4a16-a864-67c8b7fb8999'
);


-- Op. 75 피아노 모음곡 <나무>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <나무>', '5 Pieces "The Trees", Op. 75', 'album', 'Op. 75', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <나무>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '635e4065-c8ea-4a32-97bc-80c007c42828'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '635e4065-c8ea-4a32-97bc-80c007c42828'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <나무>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '635e4065-c8ea-4a32-97bc-80c007c42828'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77b94c2e-fc03-4b3e-b13d-0bf36936ed9a', 1, NULL, '마가목이 꽃필 때 (När rönnan blommar)', 'No. 1 När rönnan blommar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <나무>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77b94c2e-fc03-4b3e-b13d-0bf36936ed9a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f1d4194-1283-485e-9d8f-d0b7a9f641bc', 2, NULL, '외로운 소나무 (Den ensamma furan)', 'No. 2 Den ensamma furan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <나무>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f1d4194-1283-485e-9d8f-d0b7a9f641bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41031513-a338-4bea-b008-75dbb289dfe9', 3, NULL, '사시나무 (Aspen)', 'No. 3 Aspen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <나무>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41031513-a338-4bea-b008-75dbb289dfe9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4112c3e-f50a-4610-b631-a3db4c548077', 4, NULL, '자작나무 (Björken)', 'No. 4 Björken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <나무>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4112c3e-f50a-4610-b631-a3db4c548077'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25709a95-d1f0-49aa-b1a6-fd2496cc6d54', 5, NULL, '가문비나무 (Granen)', 'No. 5 Granen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <나무>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25709a95-d1f0-49aa-b1a6-fd2496cc6d54'
);


-- Op. 76 13개의 피아노 소품 Op. 76

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '13개의 피아노 소품 Op. 76', '13 Pieces for Piano, Op. 76', 'album', NULL, 'Op.', '76', 1919, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '13개의 피아노 소품 Op. 76'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfbafcb5-2ae5-414c-8188-4f6ca862a601'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cfbafcb5-2ae5-414c-8188-4f6ca862a601'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfbafcb5-2ae5-414c-8188-4f6ca862a601'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55afa3dc-e676-4218-93e0-6fe89d1039f4', 1, NULL, '스케치 (Esquisse)', 'No. 1 Esquisse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55afa3dc-e676-4218-93e0-6fe89d1039f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ca7c074-7bba-4642-86b7-0b5f989e9b26', 2, NULL, '연습곡 A단조', 'No. 2 Étude in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ca7c074-7bba-4642-86b7-0b5f989e9b26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45b89ac3-7b61-40c0-a3b2-2505ebab5d73', 3, NULL, '카리용', 'No. 3 Carillon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45b89ac3-7b61-40c0-a3b2-2505ebab5d73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fdd73d5-e383-4ada-b739-129ac6406c4f', 4, NULL, '유머레스크 C#단조', 'No. 4 Humoresque in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fdd73d5-e383-4ada-b739-129ac6406c4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5c83260-fab6-4301-bc8c-e2ffa56aa589', 5, NULL, '위안 (Consolation) C#단조', 'No. 5 Consolation in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5c83260-fab6-4301-bc8c-e2ffa56aa589'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20d8c016-4947-4ef7-8c2a-0defbc7f74a5', 6, NULL, '로만체타', 'No. 6 Romanzetta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20d8c016-4947-4ef7-8c2a-0defbc7f74a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3534327-139e-4ab2-af0c-4865c7c04c00', 7, NULL, 'Affettuoso', 'No. 7 Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3534327-139e-4ab2-af0c-4865c7c04c00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78ae737e-b717-4db4-aa99-f6808cc6af00', 8, NULL, '어린이 소품 (Pièce enfantine)', 'No. 8 Pièce enfantine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78ae737e-b717-4db4-aa99-f6808cc6af00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7620b22c-2666-487c-97ce-a2d5ed57ac3c', 9, NULL, '아라베스크 D♭장조', 'No. 9 Arabesque in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7620b22c-2666-487c-97ce-a2d5ed57ac3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b153970-7bed-4aa6-8234-1bf131abcbc5', 10, NULL, 'Elegiaco C#단조', 'No. 10 Elegiaco in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b153970-7bed-4aa6-8234-1bf131abcbc5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93dd3b8c-1bba-47ba-b630-c307b28a7ddb', 11, NULL, '린네풀 (Linnaea)', 'No. 11 Linnaea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93dd3b8c-1bba-47ba-b630-c307b28a7ddb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b58d65d9-0ce2-46bc-b6aa-b2bf0395efc6', 12, NULL, '카프리치에토', 'No. 12 Capriccietto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b58d65d9-0ce2-46bc-b6aa-b2bf0395efc6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55e66f74-8efc-4a3d-845f-1c339325afca', 13, NULL, '할리퀸 춤 (Harlequinade)', 'No. 13 Harlequinade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '13개의 피아노 소품 Op. 76' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55e66f74-8efc-4a3d-845f-1c339325afca'
);


-- Op. 77 2개의 장엄한 선율 Op. 77

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 장엄한 선율 Op. 77', '2 Serious Melodies, Op. 77', 'album', NULL, 'Op.', '77', 1915, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 장엄한 선율 Op. 77'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6531c631-ce91-4cab-86b1-47c61ff9f843'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6531c631-ce91-4cab-86b1-47c61ff9f843'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 장엄한 선율 Op. 77' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6531c631-ce91-4cab-86b1-47c61ff9f843'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4144c665-114e-49c3-8fcd-416cd1e0c003', 1, NULL, '칸티크 (Laetare anima mea)', 'No. 1 Cantique (Laetare anima mea)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 장엄한 선율 Op. 77' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4144c665-114e-49c3-8fcd-416cd1e0c003'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:465cd414-98e6-457b-a996-ea165c50f3cc', 2, NULL, '헌신 (Ab imo pectore)', 'No. 2 Devotion (Ab imo pectore)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 장엄한 선율 Op. 77' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:465cd414-98e6-457b-a996-ea165c50f3cc'
);


-- Op. 78 바이올린(또는 첼로)과 피아노를 위한 4개의 소품 Op. 78

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린(또는 첼로)과 피아노를 위한 4개의 소품 Op. 78', '4 Pieces for Violin (or Cello) and Piano, Op. 78', 'album', NULL, 'Op.', '78', 1917, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린(또는 첼로)과 피아노를 위한 4개의 소품 Op. 78'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a36a8349-fdbe-4db3-957a-571a6c452e7a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a36a8349-fdbe-4db3-957a-571a6c452e7a'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린(또는 첼로)과 피아노를 위한 4개의 소품 Op. 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a36a8349-fdbe-4db3-957a-571a6c452e7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1803d3c-0d86-4177-bf8a-0b09b08d5dfa', 1, NULL, '즉흥곡 A단조', 'No. 1 Impromptu in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린(또는 첼로)과 피아노를 위한 4개의 소품 Op. 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1803d3c-0d86-4177-bf8a-0b09b08d5dfa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a919a05-525a-48c2-bd3d-30b1df3e6a59', 2, NULL, '로망스 F장조', 'No. 2 Romance in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린(또는 첼로)과 피아노를 위한 4개의 소품 Op. 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a919a05-525a-48c2-bd3d-30b1df3e6a59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2724ed5d-d7ec-4893-b575-fe0fd668539c', 3, NULL, 'Religioso G단조', 'No. 3 Religioso in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린(또는 첼로)과 피아노를 위한 4개의 소품 Op. 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2724ed5d-d7ec-4893-b575-fe0fd668539c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0db81af5-0f34-42b7-9b8d-b9e2d66afd3d', 4, NULL, '리고동 D장조', 'No. 4 Rigaudon in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린(또는 첼로)과 피아노를 위한 4개의 소품 Op. 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0db81af5-0f34-42b7-9b8d-b9e2d66afd3d'
);


-- Op. 79 바이올린과 피아노를 위한 6개의 소품 Op. 79

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 6개의 소품 Op. 79', '6 Pieces for Violin and Piano, Op. 79', 'album', NULL, 'Op.', '79', 1917, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 6개의 소품 Op. 79'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af8ad5df-9f6b-4e58-a69c-f5be4c60478e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'af8ad5df-9f6b-4e58-a69c-f5be4c60478e'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 6개의 소품 Op. 79' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af8ad5df-9f6b-4e58-a69c-f5be4c60478e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:948cf02c-e614-44b2-8e6c-fcc3d8a5ba42', 1, NULL, '추억 (Souvenir) D장조', 'No. 1 Souvenir in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 6개의 소품 Op. 79' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:948cf02c-e614-44b2-8e6c-fcc3d8a5ba42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4431f676-22a0-4742-ab7f-5500136a36e7', 2, NULL, 'Tempo di minuetto', 'No. 2 Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 6개의 소품 Op. 79' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4431f676-22a0-4742-ab7f-5500136a36e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da22396a-1471-400e-82b0-eda0e666bda7', 3, NULL, '성격적 무곡 (Danse caractéristique)', 'No. 3 Danse caractéristique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 6개의 소품 Op. 79' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da22396a-1471-400e-82b0-eda0e666bda7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba5af7c6-db46-4312-a657-a040c18fe3d5', 4, NULL, '세레나데 D장조', 'No. 4 Sérénade in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 6개의 소품 Op. 79' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba5af7c6-db46-4312-a657-a040c18fe3d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f27c3af-3856-4425-abdd-bd2e74bade8b', 5, NULL, '무도 목가 (Tanz-Idylle) E단조', 'No. 5 Tanz-Idylle in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 6개의 소품 Op. 79' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f27c3af-3856-4425-abdd-bd2e74bade8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b08c3a8-7d7b-4132-b2d3-bcaaaa9d9ad0', 6, NULL, '자장가 C#단조', 'No. 6 Berceuse in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 6개의 소품 Op. 79' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b08c3a8-7d7b-4132-b2d3-bcaaaa9d9ad0'
);


-- Op. 80 바이올린 소나티나 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나티나 E장조', 'Violin Sonatina in E major', 'album', 'Op. 80', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나티나 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48460ead-ceb3-45a8-b076-565df29e256d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '48460ead-ceb3-45a8-b076-565df29e256d'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린 소나티나 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48460ead-ceb3-45a8-b076-565df29e256d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9f69d54-2253-4df6-b528-0da6931d6986', 1, 'I', 'Lento – Allegro', 'I. Lento – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린 소나티나 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9f69d54-2253-4df6-b528-0da6931d6986'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5aa8c39a-d143-48f0-aad4-94f7a90bb414', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린 소나티나 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5aa8c39a-d143-48f0-aad4-94f7a90bb414'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:074fb275-9ffa-41f5-aae7-121d05ae4f7b', 3, 'III', 'Lento – Allegretto', 'III. Lento – Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린 소나티나 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:074fb275-9ffa-41f5-aae7-121d05ae4f7b'
);


-- Op. 81 바이올린과 피아노를 위한 5개의 소품 Op. 81

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 5개의 소품 Op. 81', '5 Pieces for Violin and Piano, Op. 81', 'album', NULL, 'Op.', '81', 1918, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 5개의 소품 Op. 81'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d575c4e-36cc-4335-bad2-ede7a9eb07f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3d575c4e-36cc-4335-bad2-ede7a9eb07f6'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 5개의 소품 Op. 81' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d575c4e-36cc-4335-bad2-ede7a9eb07f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4d4d828-fc20-490b-8990-e22722e1fcee', 1, NULL, '마주르카 D단조', 'No. 1 Mazurka in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 5개의 소품 Op. 81' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4d4d828-fc20-490b-8990-e22722e1fcee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a625513-162d-48fa-bda4-c2aba15db84f', 2, NULL, '론디노 D장조', 'No. 2 Rondino in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 5개의 소품 Op. 81' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a625513-162d-48fa-bda4-c2aba15db84f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26120173-7feb-423e-9037-da8879a20c28', 3, NULL, '왈츠 D장조', 'No. 3 Valse in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 5개의 소품 Op. 81' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26120173-7feb-423e-9037-da8879a20c28'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea6a3035-6ba6-47cb-95a2-8f39f0bd491d', 4, NULL, '아침의 노래 (Aubade) D장조', 'No. 4 Aubade in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 5개의 소품 Op. 81' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea6a3035-6ba6-47cb-95a2-8f39f0bd491d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b785ca1-4516-40dd-b188-861961e3e33c', 5, NULL, '미뉴에트 D단조', 'No. 5 Menuetto in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 5개의 소품 Op. 81' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b785ca1-4516-40dd-b188-861961e3e33c'
);


-- Op. 82 교향곡 5번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 5번 E♭장조', 'Symphony No. 5 in E♭ major', 'album', 'Op. 82', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 5번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e9918ea-a7c4-46d6-912b-eff2f380cc20'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0e9918ea-a7c4-46d6-912b-eff2f380cc20'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 5번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e9918ea-a7c4-46d6-912b-eff2f380cc20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:675dbbe1-b260-3523-af06-b6d8455cff88', 1, 'I', 'Tempo molto moderato – Allegro moderato', 'I. Tempo molto moderato – Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 5번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:675dbbe1-b260-3523-af06-b6d8455cff88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:158f45a6-df55-3c54-960e-5e76ada7f4cb', 2, 'II', 'Andante mosso, quasi allegretto', 'II. Andante mosso, quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 5번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:158f45a6-df55-3c54-960e-5e76ada7f4cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b9c0f1f-05ba-371e-a495-b911b3d8b89f', 3, 'III', 'Allegro molto – Largamente assai', 'III. Allegro molto – Largamente assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 5번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b9c0f1f-05ba-371e-a495-b911b3d8b89f'
);


-- Op. 83 부수음악 <예더만>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <예더만>', 'Everyman (Jokamies), Incidental Music', 'song', 'Op. 83', NULL, NULL, 1916, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <예더만>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28df3965-af20-4b0b-a5ad-cb99bd693e8b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '28df3965-af20-4b0b-a5ad-cb99bd693e8b'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '부수음악 <예더만>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28df3965-af20-4b0b-a5ad-cb99bd693e8b'
);


-- Op. 84 남성 합창곡 Op. 84

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 Op. 84', '5 Part-Songs for Male Chorus, Op. 84', 'album', NULL, 'Op.', '84', 1917, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 Op. 84'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a1069bc-3d8e-41c0-9d7e-702ccf67a931'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a1069bc-3d8e-41c0-9d7e-702ccf67a931'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a1069bc-3d8e-41c0-9d7e-702ccf67a931'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25c8c70c-d9bf-4b52-bd3d-76097603ff9d', 1, NULL, 'Herr Lager och Skön fager', 'Herr Lager och Skön fager', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25c8c70c-d9bf-4b52-bd3d-76097603ff9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3a0d05e-6e15-40db-b544-6706e5426d08', 2, NULL, 'På berget', 'På berget', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3a0d05e-6e15-40db-b544-6706e5426d08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff2dd66f-3fe1-432a-9da6-d1113accc38f', 3, NULL, 'Ett drömackord', 'Ett drömackord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff2dd66f-3fe1-432a-9da6-d1113accc38f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a50549fe-94b5-4871-bece-b1729681dfdc', 4, NULL, 'Evige Eros', 'Evige Eros', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a50549fe-94b5-4871-bece-b1729681dfdc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:284b9070-f431-4b6c-b0d8-1d76d2070186', 5, NULL, 'Till havs', 'Till havs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:284b9070-f431-4b6c-b0d8-1d76d2070186'
);


-- Op. 85 피아노 모음곡 <꽃>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <꽃>', '5 Pieces "The Flowers", Op. 85', 'album', 'Op. 85', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <꽃>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d673ad2-aa3d-4cb2-a742-c78c94e242f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d673ad2-aa3d-4cb2-a742-c78c94e242f6'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d673ad2-aa3d-4cb2-a742-c78c94e242f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:406439f2-a620-4724-9faa-56b92f0dfce3', 1, NULL, '데이지 (Bellis)', 'No. 1 Bellis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:406439f2-a620-4724-9faa-56b92f0dfce3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f70118a-f77a-4b12-9a04-240bb1ccf3d9', 2, NULL, '카네이션 (Oeillet)', 'No. 2 Oeillet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f70118a-f77a-4b12-9a04-240bb1ccf3d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a212f05-460a-47a7-8e1e-643fd62d8894', 3, NULL, '붓꽃 (Iris)', 'No. 3 Iris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a212f05-460a-47a7-8e1e-643fd62d8894'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f186de3d-9a2a-4ea2-952b-b79940f83b73', 4, NULL, '매발톱꽃 (Aquileja)', 'No. 4 Aquileja', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f186de3d-9a2a-4ea2-952b-b79940f83b73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c038ce7-5c6f-4666-b36b-1abc9883817e', 5, NULL, '초롱꽃 (Campanula)', 'No. 5 Campanula', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <꽃>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c038ce7-5c6f-4666-b36b-1abc9883817e'
);


-- Op. 86 6개의 가곡 Op. 86

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 가곡 Op. 86', '6 Songs, Op. 86', 'album', NULL, 'Op.', '86', 1917, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 가곡 Op. 86'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aff2e480-bc5c-492a-85f8-d2e9a834075c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aff2e480-bc5c-492a-85f8-d2e9a834075c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 86' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aff2e480-bc5c-492a-85f8-d2e9a834075c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97403ca5-c557-49d2-a2ee-0b3361df0e74', 1, NULL, 'Vårförnimmelser', 'Vårförnimmelser', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 86' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97403ca5-c557-49d2-a2ee-0b3361df0e74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ecb92fc-c4de-3820-8b03-84fc5002fb05', 2, NULL, 'Längtan heter min arvedel', 'Längtan heter min arvedel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 86' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ecb92fc-c4de-3820-8b03-84fc5002fb05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fda585c8-2824-4b8b-9bc2-8c745bd7ab9b', 3, NULL, 'Dold förening', 'Dold förening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 86' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fda585c8-2824-4b8b-9bc2-8c745bd7ab9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ec9e683-fc43-4628-a3fa-5a544b537fd4', 4, NULL, 'Och finns det en tanke?', 'Och finns det en tanke?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 86' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ec9e683-fc43-4628-a3fa-5a544b537fd4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f899e75b-39b2-4227-a403-600a8f81fc4a', 5, NULL, 'Sångarlön', 'Sångarlön', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 86' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f899e75b-39b2-4227-a403-600a8f81fc4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2729a68-6d50-35fe-9f52-4564be6acaba', 6, NULL, 'I systrar, I bröder, I älskande par', 'I systrar, I bröder, I älskande par', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 가곡 Op. 86' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2729a68-6d50-35fe-9f52-4564be6acaba'
);


-- Op. 87 바이올린과 관현악을 위한 2개의 유머레스크 Op. 87

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 관현악을 위한 2개의 유머레스크 Op. 87', '2 Humoresques for Violin and Orchestra, Op. 87', 'album', NULL, 'Op.', '87', 1940, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 관현악을 위한 2개의 유머레스크 Op. 87'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4ab180b-0aef-4641-9748-2d2f8159b034'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4ab180b-0aef-4641-9748-2d2f8159b034'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 관현악을 위한 2개의 유머레스크 Op. 87' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4ab180b-0aef-4641-9748-2d2f8159b034'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe597be0-b933-3918-aac0-9ce6eb387620', 1, NULL, '유머레스크 1번 D단조', 'No. 1 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 관현악을 위한 2개의 유머레스크 Op. 87' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe597be0-b933-3918-aac0-9ce6eb387620'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84b07590-f68b-3f5c-82e5-c0be8464d27c', 2, NULL, '유머레스크 2번 D장조', 'No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 관현악을 위한 2개의 유머레스크 Op. 87' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84b07590-f68b-3f5c-82e5-c0be8464d27c'
);


-- Op. 88 6개의 꽃의 노래 Op. 88

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 꽃의 노래 Op. 88', '6 Flower Songs, Op. 88', 'album', NULL, 'Op.', '88', 1917, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 꽃의 노래 Op. 88'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aad3a391-dbd8-454d-828c-88fad9ac8e93'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aad3a391-dbd8-454d-828c-88fad9ac8e93'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 꽃의 노래 Op. 88' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aad3a391-dbd8-454d-828c-88fad9ac8e93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a993b94-1d3f-4f12-984c-1cd8e1ef060e', 1, NULL, 'Blåsippan', 'Blåsippan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 꽃의 노래 Op. 88' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a993b94-1d3f-4f12-984c-1cd8e1ef060e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:056a8887-f573-4566-8b28-b65b1348463c', 2, NULL, 'De bägge rosorna', 'De bägge rosorna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 꽃의 노래 Op. 88' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:056a8887-f573-4566-8b28-b65b1348463c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6559bb4-38ac-4855-8538-a7beca8feb5b', 3, NULL, 'Vitsippan', 'Vitsippan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 꽃의 노래 Op. 88' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6559bb4-38ac-4855-8538-a7beca8feb5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76892ae9-764b-45d5-b191-ed415287cbc0', 4, NULL, 'Sippan', 'Sippan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 꽃의 노래 Op. 88' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76892ae9-764b-45d5-b191-ed415287cbc0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6999a4a-e604-4146-ba09-9b15fd4ddc1b', 5, NULL, 'Törnet', 'Törnet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 꽃의 노래 Op. 88' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6999a4a-e604-4146-ba09-9b15fd4ddc1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d53bc199-7313-40e4-8cbc-a1949ff95361', 6, NULL, 'Blommans öde', 'Blommans öde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 꽃의 노래 Op. 88' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d53bc199-7313-40e4-8cbc-a1949ff95361'
);


-- Op. 89 바이올린과 관현악을 위한 4개의 유머레스크 Op. 89

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 관현악을 위한 4개의 유머레스크 Op. 89', '4 Humoresques for Violin and Orchestra, Op. 89', 'album', NULL, 'Op.', '89', 1918, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 관현악을 위한 4개의 유머레스크 Op. 89'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1bb44ca5-76f0-4832-a27b-2011319d7c81'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1bb44ca5-76f0-4832-a27b-2011319d7c81'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 관현악을 위한 4개의 유머레스크 Op. 89' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1bb44ca5-76f0-4832-a27b-2011319d7c81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d31fc79c-835d-4dbd-b789-530cf7a0b2c5', 1, NULL, '유머레스크 3번 G단조', 'No. 3 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 관현악을 위한 4개의 유머레스크 Op. 89' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d31fc79c-835d-4dbd-b789-530cf7a0b2c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a954aa56-56d8-40da-ab30-2e66a5b59524', 2, NULL, '유머레스크 4번 G단조', 'No. 4 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 관현악을 위한 4개의 유머레스크 Op. 89' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a954aa56-56d8-40da-ab30-2e66a5b59524'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1d4ba3b-e97a-47e9-a533-97ea315f207c', 3, NULL, '유머레스크 5번 E♭장조', 'No. 5 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 관현악을 위한 4개의 유머레스크 Op. 89' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1d4ba3b-e97a-47e9-a533-97ea315f207c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:124147d3-809d-4748-9cb0-c57e33c9aca8', 4, NULL, '유머레스크 6번 G단조', 'No. 6 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 관현악을 위한 4개의 유머레스크 Op. 89' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:124147d3-809d-4748-9cb0-c57e33c9aca8'
);


-- Op. 90 루네베리 시에 의한 6개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '루네베리 시에 의한 6개의 가곡', '6 Runeberg Songs, Op. 90', 'album', 'Op. 90', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '루네베리 시에 의한 6개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e02f7d4-31e5-491c-bc51-2c41da3beb0d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6e02f7d4-31e5-491c-bc51-2c41da3beb0d'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e02f7d4-31e5-491c-bc51-2c41da3beb0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38e1f49b-9174-376d-941d-c7c79a1d24a3', 1, NULL, 'Norden', 'Norden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38e1f49b-9174-376d-941d-c7c79a1d24a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59627093-a3f4-476f-a3e9-9fcc4db4f330', 2, NULL, 'Hennes budskap', 'Hennes budskap', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59627093-a3f4-476f-a3e9-9fcc4db4f330'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea9d12e7-7ada-4012-b559-7e1f2357f2b3', 3, NULL, 'Morgonen', 'Morgonen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea9d12e7-7ada-4012-b559-7e1f2357f2b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d0f78ed-5942-4e23-b3e9-a15380a49dc0', 4, NULL, 'Fågelfängaren', 'Fågelfängaren', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d0f78ed-5942-4e23-b3e9-a15380a49dc0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14c26f51-d856-40dd-af8e-a6c591426b92', 5, NULL, 'Sommarnatten', 'Sommarnatten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14c26f51-d856-40dd-af8e-a6c591426b92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01eb83ae-1515-48b7-acf8-814724fdcf5d', 6, NULL, 'Vem styrde hit din väg?', 'Vem styrde hit din väg?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '루네베리 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01eb83ae-1515-48b7-acf8-814724fdcf5d'
);


-- Op. 91 2개의 행진곡 Op. 91

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 행진곡 Op. 91', '2 Marches, Op. 91', 'album', NULL, 'Op.', '91', 1918, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 행진곡 Op. 91'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5abc21eb-773b-4251-9b82-7b98c62442a1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5abc21eb-773b-4251-9b82-7b98c62442a1'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 행진곡 Op. 91' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5abc21eb-773b-4251-9b82-7b98c62442a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f60b7fd-a87f-48b5-ab92-5ceeeb127d55', 1, NULL, '예거 행진곡 (Jääkärien marssi)', 'Op. 91a Jäger March (Jääkärien marssi)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 행진곡 Op. 91' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f60b7fd-a87f-48b5-ab92-5ceeeb127d55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a2bce74-20fd-4f73-aa8c-05fd5e37e083', 2, NULL, '보이스카우트 행진곡 (Partiolaisten marssi)', 'Op. 91b Scout March (Partiolaisten marssi)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 행진곡 Op. 91' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a2bce74-20fd-4f73-aa8c-05fd5e37e083'
);


-- Op. 92 칸타타 <나의 조국>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <나의 조국>', 'My Own Land (Oma maa)', 'song', 'Op. 92', NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <나의 조국>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a70ba0f-ae02-47c0-bad1-c8dea332ceea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3a70ba0f-ae02-47c0-bad1-c8dea332ceea'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '칸타타 <나의 조국>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a70ba0f-ae02-47c0-bad1-c8dea332ceea'
);


-- Op. 93 칸타타 <대지의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <대지의 노래>', 'Song of the Earth (Jordens sång)', 'song', 'Op. 93', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <대지의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec0ade73-fd2c-4654-8564-36418bdf3f9b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec0ade73-fd2c-4654-8564-36418bdf3f9b'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '칸타타 <대지의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec0ade73-fd2c-4654-8564-36418bdf3f9b'
);


-- Op. 94 6개의 피아노 소품 Op. 94

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 피아노 소품 Op. 94', '6 Pieces for Piano, Op. 94', 'album', NULL, 'Op.', '94', 1919, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 피아노 소품 Op. 94'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be0c6b8a-1ede-412d-a2bf-2fa2820eb19c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be0c6b8a-1ede-412d-a2bf-2fa2820eb19c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 피아노 소품 Op. 94' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be0c6b8a-1ede-412d-a2bf-2fa2820eb19c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c13d2f05-0057-4494-99ba-b306b77b0980', 1, NULL, '춤곡 C장조', 'No. 1 Danse in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 피아노 소품 Op. 94' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c13d2f05-0057-4494-99ba-b306b77b0980'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a689962f-fb93-408c-84ed-cba7e7d6f2b4', 2, NULL, '노벨레테 F장조', 'No. 2 Nouvellette in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 피아노 소품 Op. 94' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a689962f-fb93-408c-84ed-cba7e7d6f2b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dea276ae-a249-43ee-b462-5828af74be9d', 3, NULL, '소네트 B♭장조', 'No. 3 Sonnet in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 피아노 소품 Op. 94' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dea276ae-a249-43ee-b462-5828af74be9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94a4a187-1fbe-4d72-860a-517f2e136482', 4, NULL, '목동과 목동 아가씨 (Berger et bergerette)', 'No. 4 Berger et bergerette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 피아노 소품 Op. 94' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94a4a187-1fbe-4d72-860a-517f2e136482'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0c8a149-954a-4804-a0d4-0005d4d13feb', 5, NULL, '선율 (Mélodie) B장조', 'No. 5 Mélodie in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 피아노 소품 Op. 94' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0c8a149-954a-4804-a0d4-0005d4d13feb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97cf3a7b-0504-475e-8e66-13596580c84e', 6, NULL, '가보트 C장조', 'No. 6 Gavotte in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 피아노 소품 Op. 94' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97cf3a7b-0504-475e-8e66-13596580c84e'
);


-- Op. 95 칸타타 <대지의 찬가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <대지의 찬가>', 'Hymn of the Earth (Maan virsi)', 'song', 'Op. 95', NULL, NULL, 1920, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <대지의 찬가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da010fc6-0e1e-4feb-862b-1da6613325cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'da010fc6-0e1e-4feb-862b-1da6613325cf'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '칸타타 <대지의 찬가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da010fc6-0e1e-4feb-862b-1da6613325cf'
);


-- Op. 96 3개의 소품 Op. 96

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 소품 Op. 96', '3 Pieces, Op. 96', 'album', NULL, 'Op.', '96', 1922, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 소품 Op. 96'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4854ef46-a817-4b4d-913d-e2bb6f7a2bd6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4854ef46-a817-4b4d-913d-e2bb6f7a2bd6'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3개의 소품 Op. 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4854ef46-a817-4b4d-913d-e2bb6f7a2bd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1f3e686-4b02-4f3d-acea-309147671837', 1, NULL, '서정적 왈츠 (Valse lyrique)', 'Op. 96a Valse lyrique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3개의 소품 Op. 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1f3e686-4b02-4f3d-acea-309147671837'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebacac22-f5d9-410d-a42a-ee7601bc3eb9', 2, NULL, '옛날에 (Autrefois)', 'Op. 96b Autrefois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3개의 소품 Op. 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebacac22-f5d9-410d-a42a-ee7601bc3eb9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b03dbf2-baa3-4c7e-bd06-07803f67bd91', 3, NULL, '기사의 왈츠 (Valse chevaleresque)', 'Op. 96c Valse chevaleresque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3개의 소품 Op. 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b03dbf2-baa3-4c7e-bd06-07803f67bd91'
);


-- Op. 97 6개의 바가텔 Op. 97

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 바가텔 Op. 97', '6 Bagatelles, Op. 97', 'album', NULL, 'Op.', '97', 1920, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 바가텔 Op. 97'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0255e159-a7cf-4324-8371-f25ef02450fe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0255e159-a7cf-4324-8371-f25ef02450fe'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 바가텔 Op. 97' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0255e159-a7cf-4324-8371-f25ef02450fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b7617a4-c580-46c7-bfd8-a40f69c77ee9', 1, NULL, '유머레스크 1', 'No. 1 Humoreske I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 바가텔 Op. 97' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b7617a4-c580-46c7-bfd8-a40f69c77ee9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4758fc8-5fd4-4e8e-9ca1-4c668bfccf1a', 2, NULL, '노래 (Lied)', 'No. 2 Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 바가텔 Op. 97' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4758fc8-5fd4-4e8e-9ca1-4c668bfccf1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78a24355-ce8e-4be0-9d41-66dbc0c9b83f', 3, NULL, '작은 왈츠 (Kleiner Walzer)', 'No. 3 Kleiner Walzer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 바가텔 Op. 97' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78a24355-ce8e-4be0-9d41-66dbc0c9b83f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02e5f5c7-b6d1-4400-aa08-f8048d3c3ed6', 4, NULL, '익살스러운 행진곡 (Humoristischer Marsch)', 'No. 4 Humoristischer Marsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 바가텔 Op. 97' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02e5f5c7-b6d1-4400-aa08-f8048d3c3ed6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:892828bd-b343-4084-b740-6586757c5a18', 5, NULL, '즉흥곡', 'No. 5 Impromptu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 바가텔 Op. 97' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:892828bd-b343-4084-b740-6586757c5a18'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5969a757-12ed-4a55-a208-94c75ab6c825', 6, NULL, '유머레스크 2', 'No. 6 Humoreske II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '6개의 바가텔 Op. 97' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5969a757-12ed-4a55-a208-94c75ab6c825'
);


-- Op. 98 2개의 모음곡 Op. 98

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 모음곡 Op. 98', '2 Suites, Op. 98', 'album', NULL, 'Op.', '98', 1922, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 모음곡 Op. 98'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aed692bb-1a6a-4da0-9b19-1a373ac14ae9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aed692bb-1a6a-4da0-9b19-1a373ac14ae9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 모음곡 Op. 98' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aed692bb-1a6a-4da0-9b19-1a373ac14ae9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0238fb93-df54-44a4-b512-441f1654470a', 1, NULL, '작은 모음곡 (Suite mignonne)', 'Op. 98a Suite mignonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 모음곡 Op. 98' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0238fb93-df54-44a4-b512-441f1654470a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a54b20a7-818c-4975-933c-ea530ed23dc5', 1, 'I', '작은 장면 (Petite scène)', 'I. Petite scène', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0238fb93-df54-44a4-b512-441f1654470a'
WHERE p.composer_id = 68 AND p.title = '2개의 모음곡 Op. 98' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a54b20a7-818c-4975-933c-ea530ed23dc5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:98c78ec0-6433-43fe-be7b-6b479f210138', 2, 'II', '폴카', 'II. Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0238fb93-df54-44a4-b512-441f1654470a'
WHERE p.composer_id = 68 AND p.title = '2개의 모음곡 Op. 98' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98c78ec0-6433-43fe-be7b-6b479f210138'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:90c99257-3197-4c01-ab4b-7c0c23097ab1', 3, 'III', '에필로그', 'III. Épilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0238fb93-df54-44a4-b512-441f1654470a'
WHERE p.composer_id = 68 AND p.title = '2개의 모음곡 Op. 98' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90c99257-3197-4c01-ab4b-7c0c23097ab1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8ab65be-19bb-4c07-b64a-4419cc9a25d0', 2, NULL, '전원 모음곡 (Suite champêtre)', 'Op. 98b Suite champêtre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2개의 모음곡 Op. 98' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8ab65be-19bb-4c07-b64a-4419cc9a25d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:185186d9-89c3-4098-b4d2-26265eb40838', 1, 'I', '성격적 소품 (Pièce caractéristique)', 'I. Pièce caractéristique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a8ab65be-19bb-4c07-b64a-4419cc9a25d0'
WHERE p.composer_id = 68 AND p.title = '2개의 모음곡 Op. 98' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:185186d9-89c3-4098-b4d2-26265eb40838'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc08d982-f85d-4915-8908-788f548935c3', 2, 'II', '엘레지풍 선율 (Mélodie élégiaque)', 'II. Mélodie élégiaque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a8ab65be-19bb-4c07-b64a-4419cc9a25d0'
WHERE p.composer_id = 68 AND p.title = '2개의 모음곡 Op. 98' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc08d982-f85d-4915-8908-788f548935c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0250ef22-6527-4725-9b58-225eb4de1a0f', 3, 'III', '춤곡', 'III. Danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a8ab65be-19bb-4c07-b64a-4419cc9a25d0'
WHERE p.composer_id = 68 AND p.title = '2개의 모음곡 Op. 98' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0250ef22-6527-4725-9b58-225eb4de1a0f'
);


-- Op. 99 8개의 작은 소품 Op. 99

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '8개의 작은 소품 Op. 99', '8 Petits morceaux, Op. 99', 'album', NULL, 'Op.', '99', 1922, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '8개의 작은 소품 Op. 99'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40476abc-a04f-4663-8602-1aa47b5deb9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '40476abc-a04f-4663-8602-1aa47b5deb9c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 작은 소품 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40476abc-a04f-4663-8602-1aa47b5deb9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c49d4297-750f-41be-a078-ca7ad066d2f6', 1, NULL, '익살스러운 소품 (Pièce humoristique)', 'No. 1 Pièce humoristique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 작은 소품 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c49d4297-750f-41be-a078-ca7ad066d2f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3191c7a-1932-43d1-8a15-937bbcf09b00', 2, NULL, '스케치 (Esquisse)', 'No. 2 Esquisse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 작은 소품 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3191c7a-1932-43d1-8a15-937bbcf09b00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7df600b5-447a-437a-89a7-71b7d96380c6', 3, NULL, '추억 (Souvenir)', 'No. 3 Souvenir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 작은 소품 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7df600b5-447a-437a-89a7-71b7d96380c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2df8aab0-252e-4ebc-8879-35a21f06b3cd', 4, NULL, '즉흥곡', 'No. 4 Impromptu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 작은 소품 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2df8aab0-252e-4ebc-8879-35a21f06b3cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dfb30fa-83e4-4cb7-b801-15ccf9aa53a7', 5, NULL, '쿠플레', 'No. 5 Couplet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 작은 소품 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dfb30fa-83e4-4cb7-b801-15ccf9aa53a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:689a7235-5477-4c6a-817f-27ab58b82185', 6, NULL, 'Animoso', 'No. 6 Animoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 작은 소품 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:689a7235-5477-4c6a-817f-27ab58b82185'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b799c16-3a2b-40bc-a54c-bdf013f5b870', 7, NULL, '왈츠의 순간 (Moment de valse)', 'No. 7 Moment de valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 작은 소품 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b799c16-3a2b-40bc-a54c-bdf013f5b870'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ed34d77-dd68-4e47-a542-b1d4dc9e8a23', 8, NULL, '작은 행진곡 (Petite marche)', 'No. 8 Petite marche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '8개의 작은 소품 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ed34d77-dd68-4e47-a542-b1d4dc9e8a23'
);


-- Op. 100 현악과 하프를 위한 <성격적 모음곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악과 하프를 위한 <성격적 모음곡>', 'Suite caractéristique', 'album', 'Op. 100', NULL, NULL, 1922, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악과 하프를 위한 <성격적 모음곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b1bc442-c493-41e0-ab2e-a5ef301fdfeb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1b1bc442-c493-41e0-ab2e-a5ef301fdfeb'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악과 하프를 위한 <성격적 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b1bc442-c493-41e0-ab2e-a5ef301fdfeb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60518e0d-b749-4553-8641-ecc96b6eee56', 1, 'I', 'Vivo', 'I. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악과 하프를 위한 <성격적 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60518e0d-b749-4553-8641-ecc96b6eee56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0ef6fc9-717b-4883-afb7-e248b9ac922e', 2, 'II', 'Lento', 'II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악과 하프를 위한 <성격적 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0ef6fc9-717b-4883-afb7-e248b9ac922e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a3846c2-bacb-49d9-afba-d2350f66834c', 3, 'III', 'Comodo', 'III. Comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악과 하프를 위한 <성격적 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a3846c2-bacb-49d9-afba-d2350f66834c'
);


-- Op. 101 5개의 낭만적 소품 Op. 101

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 낭만적 소품 Op. 101', '5 Morceaux romantiques, Op. 101', 'album', NULL, 'Op.', '101', 1924, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 낭만적 소품 Op. 101'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '695e47df-25a9-4963-82c9-67bb58a979a9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '695e47df-25a9-4963-82c9-67bb58a979a9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 낭만적 소품 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '695e47df-25a9-4963-82c9-67bb58a979a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ebcf897-5e2f-4ea0-bbfe-dea5ba0949cc', 1, NULL, '로망스', 'No. 1 Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 낭만적 소품 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ebcf897-5e2f-4ea0-bbfe-dea5ba0949cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3980f0bf-29e2-4dfc-80dd-658e2fb9dcdf', 2, NULL, '저녁 노래 (Chant du soir)', 'No. 2 Chant du soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 낭만적 소품 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3980f0bf-29e2-4dfc-80dd-658e2fb9dcdf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19e99f04-0c6f-4a48-bff5-460d62751b4f', 3, NULL, '서정적 장면 (Scène lyrique)', 'No. 3 Scène lyrique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 낭만적 소품 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19e99f04-0c6f-4a48-bff5-460d62751b4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92fecabf-698f-433e-9ada-b01a3e2a9bdf', 4, NULL, '유머레스크', 'No. 4 Humoresque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 낭만적 소품 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92fecabf-698f-433e-9ada-b01a3e2a9bdf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dcb94e8-f344-4344-8b2d-c8f878b56e1d', 5, NULL, '낭만적 장면 (Scène romantique)', 'No. 5 Scène romantique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 낭만적 소품 Op. 101' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dcb94e8-f344-4344-8b2d-c8f878b56e1d'
);


-- Op. 102 바이올린과 피아노를 위한 노벨레테

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 노벨레테', 'Novellette for Violin and Piano', 'song', 'Op. 102', NULL, NULL, 1922, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 노벨레테'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba7c48ec-4f21-4c53-aee6-04ddbbad1c3f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ba7c48ec-4f21-4c53-aee6-04ddbbad1c3f'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 노벨레테' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba7c48ec-4f21-4c53-aee6-04ddbbad1c3f'
);


-- Op. 103 5개의 성격적 인상 Op. 103

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 성격적 인상 Op. 103', '5 Characteristic Impressions, Op. 103', 'album', NULL, 'Op.', '103', 1924, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 성격적 인상 Op. 103'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dae11b8a-a5a3-46f4-acd6-5a616bb1f090'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dae11b8a-a5a3-46f4-acd6-5a616bb1f090'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 성격적 인상 Op. 103' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dae11b8a-a5a3-46f4-acd6-5a616bb1f090'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6daa423b-9f41-40d0-829f-f1474388f86d', 1, NULL, '마을 교회 (The Village Church)', 'No. 1 The Village Church', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 성격적 인상 Op. 103' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6daa423b-9f41-40d0-829f-f1474388f86d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:271a156a-6f10-4b65-b812-dda2f5fe4c45', 2, NULL, '바이올린 타는 사람 (The Fiddler)', 'No. 2 The Fiddler', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 성격적 인상 Op. 103' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:271a156a-6f10-4b65-b812-dda2f5fe4c45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8eeb3577-59a3-48e8-9d6e-b761e33d2ba1', 3, NULL, '노 젓는 사람 (The Oarsman)', 'No. 3 The Oarsman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 성격적 인상 Op. 103' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8eeb3577-59a3-48e8-9d6e-b761e33d2ba1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a27379ce-cb91-4eb1-8e5f-ab8e0e2a9a77', 4, NULL, '폭풍 (The Storm)', 'No. 4 The Storm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 성격적 인상 Op. 103' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a27379ce-cb91-4eb1-8e5f-ab8e0e2a9a77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08310fbe-0d4c-4bae-a18d-3bede768acfa', 5, NULL, '슬픈 기분으로 (In Mournful Mood)', 'No. 5 In Mournful Mood', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '5개의 성격적 인상 Op. 103' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08310fbe-0d4c-4bae-a18d-3bede768acfa'
);


-- Op. 104 교향곡 6번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 6번 D단조', 'Symphony No. 6 in D minor', 'album', 'Op. 104', NULL, NULL, 1923, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 6번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1746cc77-92fc-4ce7-a37d-77bd21e5c7cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1746cc77-92fc-4ce7-a37d-77bd21e5c7cb'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 6번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1746cc77-92fc-4ce7-a37d-77bd21e5c7cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a24dbb7-f7c3-36cb-a1cd-d6c55b739fe7', 1, 'I', 'Allegro molto moderato', 'I. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 6번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a24dbb7-f7c3-36cb-a1cd-d6c55b739fe7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74ae5df4-94d8-3102-a012-c2b09634ec65', 2, 'II', 'Allegretto moderato', 'II. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 6번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74ae5df4-94d8-3102-a012-c2b09634ec65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81ee7c69-a65a-39e6-b9c7-66974e15cf5f', 3, 'III', 'Poco vivace', 'III. Poco vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 6번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81ee7c69-a65a-39e6-b9c7-66974e15cf5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02db98bf-f132-33eb-a390-7a00feb28402', 4, 'IV', 'Allegro molto', 'IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 6번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02db98bf-f132-33eb-a390-7a00feb28402'
);


-- Op. 105 교향곡 7번 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 7번 C장조', 'Symphony No. 7 in C major', 'song', 'Op. 105', NULL, NULL, 1924, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 7번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9d35627-5442-4bff-8a29-b1b67a3ab021'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd9d35627-5442-4bff-8a29-b1b67a3ab021'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향곡 7번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9d35627-5442-4bff-8a29-b1b67a3ab021'
);


-- Op. 106 바이올린과 피아노를 위한 5개의 전원 무곡 Op. 106

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 5개의 전원 무곡 Op. 106', '5 Danses champêtres for Violin and Piano, Op. 106', 'album', NULL, 'Op.', '106', 1925, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 5개의 전원 무곡 Op. 106'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '166cfb71-22e5-4f6b-a2b6-a0ba7da11bbe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '166cfb71-22e5-4f6b-a2b6-a0ba7da11bbe'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 5개의 전원 무곡 Op. 106' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '166cfb71-22e5-4f6b-a2b6-a0ba7da11bbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13a2f6aa-7322-4d76-83c3-af4fed914b0f', 1, NULL, '전원 무곡 1번', 'No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 5개의 전원 무곡 Op. 106' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13a2f6aa-7322-4d76-83c3-af4fed914b0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52006ae4-d95d-4947-939c-0f7b2a23a9cf', 2, NULL, '전원 무곡 2번', 'No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 5개의 전원 무곡 Op. 106' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52006ae4-d95d-4947-939c-0f7b2a23a9cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b379375-c8f9-4369-a511-1984708efd75', 3, NULL, '전원 무곡 3번', 'No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 5개의 전원 무곡 Op. 106' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b379375-c8f9-4369-a511-1984708efd75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b5ac3e7-caae-4e8a-84f0-5419c77350dd', 4, NULL, '전원 무곡 4번', 'No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 5개의 전원 무곡 Op. 106' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b5ac3e7-caae-4e8a-84f0-5419c77350dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9b8eb55-cf3d-4a4b-bedb-0445f8b80beb', 5, NULL, '전원 무곡 5번', 'No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 5개의 전원 무곡 Op. 106' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9b8eb55-cf3d-4a4b-bedb-0445f8b80beb'
);


-- Op. 108 남성 합창곡 Op. 108

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 Op. 108', '2 Part-Songs for Male Chorus, Op. 108', 'album', NULL, 'Op.', '108', 1925, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 Op. 108'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79e6599f-f2be-48bc-9b97-5d0182a82350'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '79e6599f-f2be-48bc-9b97-5d0182a82350'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 108' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79e6599f-f2be-48bc-9b97-5d0182a82350'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d707d4e-3252-43d6-a01f-e4c3fbfb0489', 1, NULL, 'Humoreski', 'Humoreski', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 108' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d707d4e-3252-43d6-a01f-e4c3fbfb0489'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a6a756c-6bac-4b74-9d90-62ddcd7c6810', 2, NULL, 'Ne pitkän matkan kulkijat', 'Ne pitkän matkan kulkijat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 Op. 108' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a6a756c-6bac-4b74-9d90-62ddcd7c6810'
);


-- Op. 109 <템페스트> 전주곡과 모음곡 Op. 109

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<템페스트> 전주곡과 모음곡 Op. 109', 'The Tempest: Prelude and Suites, Op. 109', 'album', NULL, 'Op.', '109', 1929, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<템페스트> 전주곡과 모음곡 Op. 109'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08ecc2ed-79b8-432d-9d20-f6c2078ba052', 1, NULL, '전주곡', 'No. 1 Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08ecc2ed-79b8-432d-9d20-f6c2078ba052'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbee5b3a-84f9-49a6-a1c6-b0530f792f96', 2, NULL, '모음곡 1번', 'No. 2 Suite No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbee5b3a-84f9-49a6-a1c6-b0530f792f96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:db68ca1c-e6e7-46ff-959c-f1e99d0fe8ac', 1, 'I', '떡갈나무 (Der Eichbaum)', 'I. The Oak Tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbee5b3a-84f9-49a6-a1c6-b0530f792f96'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db68ca1c-e6e7-46ff-959c-f1e99d0fe8ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8390bf27-46dc-423b-bc35-3f5620fd331b', 2, 'II', '유머레스크', 'II. Humoreske', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbee5b3a-84f9-49a6-a1c6-b0530f792f96'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8390bf27-46dc-423b-bc35-3f5620fd331b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c4f4dcca-4a74-4261-8a33-6ba614d6438b', 3, 'III', '칼리반의 노래 (Calibans Lied)', 'III. Caliban''s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbee5b3a-84f9-49a6-a1c6-b0530f792f96'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4f4dcca-4a74-4261-8a33-6ba614d6438b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca5c2471-d68f-4584-8534-db81be8d87ca', 4, 'IV', '추수하는 사람들 (Die Herbstmänner)', 'IV. The Harvesters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbee5b3a-84f9-49a6-a1c6-b0530f792f96'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca5c2471-d68f-4584-8534-db81be8d87ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6bdb4ea4-461e-4b2a-a4f7-2c2149325169', 5, 'V', '카논', 'V. Canon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbee5b3a-84f9-49a6-a1c6-b0530f792f96'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bdb4ea4-461e-4b2a-a4f7-2c2149325169'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c3816a0f-4b06-4e5c-9587-c2ca4c21d78c', 6, 'VI', '장면 (Scène)', 'VI. Scène', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbee5b3a-84f9-49a6-a1c6-b0530f792f96'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3816a0f-4b06-4e5c-9587-c2ca4c21d78c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9d506fa4-d16d-4164-b705-9a126c89f80f', 7, 'VII', '인트라다 – 자장가', 'VII. Intrada – Berceuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbee5b3a-84f9-49a6-a1c6-b0530f792f96'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d506fa4-d16d-4164-b705-9a126c89f80f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a256826e-319a-4942-9481-6d2d8157c281', 8, 'VIII', '간주곡 – 아리엘의 노래 (Zwischenspiel – Ariels Lied)', 'VIII. Entr''acte – Ariel''s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbee5b3a-84f9-49a6-a1c6-b0530f792f96'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a256826e-319a-4942-9481-6d2d8157c281'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:081dfa48-fcea-4494-9781-f3e1af55c769', 9, 'IX', '폭풍 (Der Sturm)', 'IX. The Storm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbee5b3a-84f9-49a6-a1c6-b0530f792f96'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:081dfa48-fcea-4494-9781-f3e1af55c769'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb8d2fae-85a8-4960-8d6c-035f47670e07', 3, NULL, '모음곡 2번', 'No. 3 Suite No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb8d2fae-85a8-4960-8d6c-035f47670e07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d74552d5-1cf9-48ff-a462-b328dd762f10', 1, 'I', '바람의 합창 (Chor der Winde)', 'I. Chorus of the Winds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb8d2fae-85a8-4960-8d6c-035f47670e07'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d74552d5-1cf9-48ff-a462-b328dd762f10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0c94334-48e2-4796-80fb-97af5f19b98e', 2, 'II', '간주곡', 'II. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb8d2fae-85a8-4960-8d6c-035f47670e07'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0c94334-48e2-4796-80fb-97af5f19b98e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d10112a-6ee8-490f-8add-99ee90a3fb5c', 3, 'III', '님프의 춤 (Tanz der Nymphen)', 'III. Dance of the Nymphs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb8d2fae-85a8-4960-8d6c-035f47670e07'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d10112a-6ee8-490f-8add-99ee90a3fb5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff449ece-8288-4849-8858-f74d8de2c7df', 4, 'IV', '프로스페로', 'IV. Prospero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb8d2fae-85a8-4960-8d6c-035f47670e07'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff449ece-8288-4849-8858-f74d8de2c7df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'classicmap:sibelius:sibelius-op109:3-5', 5, 'V', '노래 1 (Lied I)', 'V. Song I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb8d2fae-85a8-4960-8d6c-035f47670e07'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:sibelius:sibelius-op109:3-5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'classicmap:sibelius:sibelius-op109:3-6', 6, 'VI', '노래 2 (Lied II)', 'VI. Song II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb8d2fae-85a8-4960-8d6c-035f47670e07'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:sibelius:sibelius-op109:3-6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:81224b89-170f-4cbb-80ff-e6fde1e64ad8', 7, 'VII', '미란다', 'VII. Miranda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb8d2fae-85a8-4960-8d6c-035f47670e07'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81224b89-170f-4cbb-80ff-e6fde1e64ad8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:726aad4f-231e-4dff-9e2c-76368b09c3a0', 8, 'VIII', '물의 요정들 (Die Najaden)', 'VIII. The Naiads', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb8d2fae-85a8-4960-8d6c-035f47670e07'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:726aad4f-231e-4dff-9e2c-76368b09c3a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:01aca752-6e5c-4394-8690-9e04c84e90db', 9, 'IX', '춤의 에피소드 (Tanz-Episode)', 'IX. Dance Episode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb8d2fae-85a8-4960-8d6c-035f47670e07'
WHERE p.composer_id = 68 AND p.title = '<템페스트> 전주곡과 모음곡 Op. 109' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01aca752-6e5c-4394-8690-9e04c84e90db'
);


-- Op. 110 칸타타 <바이내뫼이넨의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <바이내뫼이넨의 노래>', 'Väinämöinen''s Song (Väinön virsi)', 'song', 'Op. 110', NULL, NULL, 1926, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <바이내뫼이넨의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb9638d2-88d6-407a-8b54-431d44ccb196'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb9638d2-88d6-407a-8b54-431d44ccb196'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '칸타타 <바이내뫼이넨의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb9638d2-88d6-407a-8b54-431d44ccb196'
);


-- Op. 111 오르간을 위한 2개의 소품 Op. 111

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간을 위한 2개의 소품 Op. 111', '2 Pieces for Organ, Op. 111', 'album', NULL, 'Op.', '111', 1931, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간을 위한 2개의 소품 Op. 111'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a3a97bf-3305-4fcd-8e80-c3f5f0471c8a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4a3a97bf-3305-4fcd-8e80-c3f5f0471c8a'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '오르간을 위한 2개의 소품 Op. 111' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a3a97bf-3305-4fcd-8e80-c3f5f0471c8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c9e66d5-f2a8-4625-9594-482ed57f18e2', 1, NULL, '인트라다', 'Op. 111a Intrada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '오르간을 위한 2개의 소품 Op. 111' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c9e66d5-f2a8-4625-9594-482ed57f18e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12249f77-4d82-4118-9da6-b6405a004a25', 2, NULL, '장송 음악 (Surusoitto)', 'Op. 111b Surusoitto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '오르간을 위한 2개의 소품 Op. 111' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12249f77-4d82-4118-9da6-b6405a004a25'
);


-- Op. 112 교향시 <타피올라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <타피올라>', 'Tapiola', 'song', 'Op. 112', NULL, NULL, 1926, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <타피올라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '303afc21-ef96-3578-a238-52e3dd6e417a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '303afc21-ef96-3578-a238-52e3dd6e417a'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '교향시 <타피올라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '303afc21-ef96-3578-a238-52e3dd6e417a'
);


-- Op. 113 <프리메이슨 의식 음악>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<프리메이슨 의식 음악>', 'Masonic Ritual Music (Musique religieuse)', 'song', 'Op. 113', NULL, NULL, 1948, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<프리메이슨 의식 음악>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de255210-06ac-47c8-968b-0ffc301cf7fd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'de255210-06ac-47c8-968b-0ffc301cf7fd'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<프리메이슨 의식 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de255210-06ac-47c8-968b-0ffc301cf7fd'
);


-- Op. 114 <5개의 스케치> Op. 114

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<5개의 스케치> Op. 114', '5 Sketches, Op. 114', 'album', NULL, 'Op.', '114', 1929, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<5개의 스케치> Op. 114'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27217d3d-4dce-4d34-8b0d-b52fbee48e1d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '27217d3d-4dce-4d34-8b0d-b52fbee48e1d'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<5개의 스케치> Op. 114' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27217d3d-4dce-4d34-8b0d-b52fbee48e1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f19047fa-7978-4034-a7c9-170851dfdf04', 1, NULL, '풍경 (Maisema)', 'No. 1 Maisema', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<5개의 스케치> Op. 114' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f19047fa-7978-4034-a7c9-170851dfdf04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0de7f878-35fa-472e-a3df-9e8ea7921795', 2, NULL, '겨울 풍경 (Talvikuva)', 'No. 2 Talvikuva', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<5개의 스케치> Op. 114' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0de7f878-35fa-472e-a3df-9e8ea7921795'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c135742-2c50-423a-a064-9d615cbadb64', 3, NULL, '숲속 호수 (Metsälampi)', 'No. 3 Metsälampi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<5개의 스케치> Op. 114' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c135742-2c50-423a-a064-9d615cbadb64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5141477d-f41d-40ff-b0d8-2d93886fc4a7', 4, NULL, '숲의 노래 (Metsälaulu)', 'No. 4 Metsälaulu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<5개의 스케치> Op. 114' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5141477d-f41d-40ff-b0d8-2d93886fc4a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5cc5383-1ad2-465d-917f-c19550bc62af', 5, NULL, '봄의 환영 (Kevätnäky)', 'No. 5 Kevätnäky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<5개의 스케치> Op. 114' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5cc5383-1ad2-465d-917f-c19550bc62af'
);


-- Op. 115 바이올린과 피아노를 위한 4개의 소품 Op. 115

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 4개의 소품 Op. 115', '4 Pieces for Violin and Piano, Op. 115', 'album', NULL, 'Op.', '115', 1929, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 4개의 소품 Op. 115'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '36c97042-1071-42eb-9308-40a64fd12cc0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '36c97042-1071-42eb-9308-40a64fd12cc0'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 4개의 소품 Op. 115' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '36c97042-1071-42eb-9308-40a64fd12cc0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16d404aa-8c1e-4acc-9ecd-d4d276acb7a2', 1, NULL, '황야에서 (Auf der Heide)', 'No. 1 Auf der Heide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 4개의 소품 Op. 115' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16d404aa-8c1e-4acc-9ecd-d4d276acb7a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9caefa0f-df39-4a4f-8431-959ad2509774', 2, NULL, '발라드', 'No. 2 Ballade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 4개의 소품 Op. 115' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9caefa0f-df39-4a4f-8431-959ad2509774'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de79b953-0bcd-4f6a-aa72-d0284796d758', 3, NULL, '유머레스크', 'No. 3 Humoresque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 4개의 소품 Op. 115' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de79b953-0bcd-4f6a-aa72-d0284796d758'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c962017-df67-4a88-82e8-1b9f143ffc06', 4, NULL, '종 (Die Glocken)', 'No. 4 Die Glocken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 4개의 소품 Op. 115' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c962017-df67-4a88-82e8-1b9f143ffc06'
);


-- Op. 116 바이올린과 피아노를 위한 3개의 소품 Op. 116

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 3개의 소품 Op. 116', '3 Pieces for Violin and Piano, Op. 116', 'album', NULL, 'Op.', '116', 1929, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 3개의 소품 Op. 116'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9a065e8-3b38-45ed-965b-1ba17a21c6b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a9a065e8-3b38-45ed-965b-1ba17a21c6b7'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 3개의 소품 Op. 116' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9a065e8-3b38-45ed-965b-1ba17a21c6b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62098543-3e47-4ed0-84bb-cefafcc4b51a', 1, NULL, '무도 장면 (Scène de danse)', 'No. 1 Scène de danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 3개의 소품 Op. 116' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62098543-3e47-4ed0-84bb-cefafcc4b51a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15da1dc4-afc7-446b-93cf-08fb820fa241', 2, NULL, '성격적 무곡 (Danse caractéristique)', 'No. 2 Danse caractéristique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 3개의 소품 Op. 116' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15da1dc4-afc7-446b-93cf-08fb820fa241'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3804af4f-3ae2-4168-829f-c36ae6575be8', 3, NULL, '낭만적 론도 (Rondeau romantique)', 'No. 3 Rondeau romantique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 피아노를 위한 3개의 소품 Op. 116' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3804af4f-3ae2-4168-829f-c36ae6575be8'
);


-- JS 1 왈츠 A♭장조 "베치 레르셰에게"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 A♭장조 "베치 레르셰에게"', 'Valse in A♭ major "À Betzy Lerche"', 'song', 'JS 1', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 A♭장조 "베치 레르셰에게"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce8ede73-e600-4132-bc57-404c8e76f395'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ce8ede73-e600-4132-bc57-404c8e76f395'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '왈츠 A♭장조 "베치 레르셰에게"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce8ede73-e600-4132-bc57-404c8e76f395'
);


-- JS 2 템포 디 발스 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '템포 디 발스 A장조', '[Tempo di valse] in A major', 'song', 'JS 2', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '템포 디 발스 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '289feac3-a651-4fc7-a645-c539d6af94f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '289feac3-a651-4fc7-a645-c539d6af94f9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '템포 디 발스 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '289feac3-a651-4fc7-a645-c539d6af94f9'
);


-- JS 3 아침의 노래 A장조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아침의 노래 A장조 (바이올린과 피아노)', '[Aubade] in A major for violin and piano', 'song', 'JS 3', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아침의 노래 A장조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d2eaba0-848c-48ab-bf41-a1907aa46bd6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7d2eaba0-848c-48ab-bf41-a1907aa46bd6'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '아침의 노래 A장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d2eaba0-848c-48ab-bf41-a1907aa46bd6'
);


-- JS 4 마주르카 A장조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 A장조 (바이올린과 피아노)', '[Mazurka] in A major for violin and piano', 'song', 'JS 4', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 A장조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64672e81-027d-494d-8f3e-689f08c965c3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64672e81-027d-494d-8f3e-689f08c965c3'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '마주르카 A장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64672e81-027d-494d-8f3e-689f08c965c3'
);


-- JS 5 미뉴에트 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 A단조', '[Menuetto] in A minor', 'song', 'JS 5', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7aaf301-4712-4e40-a125-016802c904de'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7aaf301-4712-4e40-a125-016802c904de'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '미뉴에트 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7aaf301-4712-4e40-a125-016802c904de'
);


-- JS 6 프레스토 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '프레스토 A단조', '[Presto] in A minor', 'song', 'JS 6', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '프레스토 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc35ba30-2c8c-4a47-9486-6ee073c8b031'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc35ba30-2c8c-4a47-9486-6ee073c8b031'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '프레스토 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc35ba30-2c8c-4a47-9486-6ee073c8b031'
);


-- JS 7 모데라토 – 프레스토 A단조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모데라토 – 프레스토 A단조 (바이올린과 피아노)', '[Moderato] – Presto – Tempo I in A minor for violin and piano', 'song', 'JS 7', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모데라토 – 프레스토 A단조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fb034b2-e359-471e-b8b6-95511a6d9cad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3fb034b2-e359-471e-b8b6-95511a6d9cad'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모데라토 – 프레스토 A단조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fb034b2-e359-471e-b8b6-95511a6d9cad'
);


-- JS 8 안단티노 A단조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 A단조 (바이올린과 피아노)', '[Andantino] in A minor for violin and piano', 'song', 'JS 8', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 A단조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7c1220b-316e-4d14-967d-b055d1649e9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f7c1220b-316e-4d14-967d-b055d1649e9c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단티노 A단조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7c1220b-316e-4d14-967d-b055d1649e9c'
);


-- JS 9a 합창곡 <Aamusumussa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Aamusumussa>', 'Aamusumussa (In the Morning Mist)', 'song', 'JS 9a', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Aamusumussa>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5071c396-0ec4-4b77-af2c-0289c78cf012'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5071c396-0ec4-4b77-af2c-0289c78cf012'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Aamusumussa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5071c396-0ec4-4b77-af2c-0289c78cf012'
);


-- JS 11 아다지오 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아다지오 D장조', 'Adagio in D major', 'song', 'JS 11', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아다지오 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01929788-d9cf-43a0-b7a2-8912ade835ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '01929788-d9cf-43a0-b7a2-8912ade835ea'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '아다지오 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01929788-d9cf-43a0-b7a2-8912ade835ea'
);


-- JS 12 아다지오 D단조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아다지오 D단조 (현악 4중주)', 'Adagio in D minor for string quartet', 'song', 'JS 12', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아다지오 D단조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61ec77a1-eadb-4659-9398-795970216f11'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '61ec77a1-eadb-4659-9398-795970216f11'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '아다지오 D단조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61ec77a1-eadb-4659-9398-795970216f11'
);


-- JS 13 아다지오 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아다지오 E장조', 'Adagio in E major', 'song', 'JS 13', NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아다지오 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d7d6b97-c890-4758-a64b-11e79f8da136'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9d7d6b97-c890-4758-a64b-11e79f8da136'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '아다지오 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d7d6b97-c890-4758-a64b-11e79f8da136'
);


-- JS 14 아다지오 F단조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아다지오 F단조 (현악 4중주)', 'Adagio in F minor for string quartet', 'song', 'JS 14', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아다지오 F단조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '721420a1-2fc7-4e21-a17e-0d04b13f5825'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '721420a1-2fc7-4e21-a17e-0d04b13f5825'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '아다지오 F단조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '721420a1-2fc7-4e21-a17e-0d04b13f5825'
);


-- JS 15 아다지오 F#단조 (첼로와 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아다지오 F#단조 (첼로와 피아노)', 'Adagio in F# minor for cello and piano', 'song', 'JS 15', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아다지오 F#단조 (첼로와 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f85b0f91-95df-4b1f-9856-24f9fc06e348'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f85b0f91-95df-4b1f-9856-24f9fc06e348'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '아다지오 F#단조 (첼로와 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f85b0f91-95df-4b1f-9856-24f9fc06e348'
);


-- JS 16 알라 마르치아 E단조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알라 마르치아 E단조 (현악 4중주)', 'Alla marcia in E minor for string quartet', 'song', 'JS 16', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알라 마르치아 E단조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d659244-671a-439d-9c41-d6e1b668239f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6d659244-671a-439d-9c41-d6e1b668239f'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알라 마르치아 E단조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d659244-671a-439d-9c41-d6e1b668239f'
);


-- JS 17 알레그레토 A장조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 A장조 (현악 4중주)', 'Allegretto in A major for string quartet', 'song', 'JS 17', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 A장조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b638303-ff9e-4456-b254-55f18e00e3f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9b638303-ff9e-4456-b254-55f18e00e3f1'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알레그레토 A장조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b638303-ff9e-4456-b254-55f18e00e3f1'
);


-- JS 18 알레그레토 B♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 B♭단조', 'Allegretto in B♭ minor', 'song', 'JS 18', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 B♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c0e3846-65c6-4d5b-9231-a1fee9e6768e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c0e3846-65c6-4d5b-9231-a1fee9e6768e'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알레그레토 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c0e3846-65c6-4d5b-9231-a1fee9e6768e'
);


-- JS 19 알레그레토 C장조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 C장조 (바이올린과 피아노)', 'Allegretto in C major for violin and piano', 'song', 'JS 19', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 C장조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aba138e7-63cd-48de-914e-8646fe817c04'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aba138e7-63cd-48de-914e-8646fe817c04'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알레그레토 C장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aba138e7-63cd-48de-914e-8646fe817c04'
);


-- JS 20 알레그레토 D장조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 D장조 (현악 4중주)', 'Allegretto in D major for string quartet', 'song', 'JS 20', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 D장조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40cc16c1-c2b7-4113-a63e-178949a19ee9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '40cc16c1-c2b7-4113-a63e-178949a19ee9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알레그레토 D장조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40cc16c1-c2b7-4113-a63e-178949a19ee9'
);


-- JS 21 알레그레토 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 E장조', 'Allegretto in E major', 'song', 'JS 21', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b9ab883-d6ca-41aa-a4fb-2fe1ae122186'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b9ab883-d6ca-41aa-a4fb-2fe1ae122186'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알레그레토 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b9ab883-d6ca-41aa-a4fb-2fe1ae122186'
);


-- JS 22 알레그레토 E♭장조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 E♭장조 (바이올린과 피아노)', 'Allegretto in E♭ major for violin and piano', 'song', 'JS 22', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 E♭장조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99e527c2-e4ae-4577-8189-4638b94ee59d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '99e527c2-e4ae-4577-8189-4638b94ee59d'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알레그레토 E♭장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99e527c2-e4ae-4577-8189-4638b94ee59d'
);


-- JS 23 알레그레토 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 F장조', 'Allegretto in F major', 'song', 'JS 23', NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f865b5a-8245-46db-adc5-673135782ddc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f865b5a-8245-46db-adc5-673135782ddc'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알레그레토 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f865b5a-8245-46db-adc5-673135782ddc'
);


-- JS 24 알레그레토 G단조 (1888)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 G단조 (1888)', 'Allegretto in G minor (1888)', 'song', 'JS 24', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 G단조 (1888)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df979a5e-7999-4da2-95a3-c8d90fd15f4f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df979a5e-7999-4da2-95a3-c8d90fd15f4f'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알레그레토 G단조 (1888)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df979a5e-7999-4da2-95a3-c8d90fd15f4f'
);


-- JS 25 알레그로 G단조 (금관 7중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그로 G단조 (금관 7중주)', 'Allegro in G minor for brass septet', 'song', 'JS 25', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그로 G단조 (금관 7중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '874db609-139c-4fb6-804b-e8e5d4392bda'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '874db609-139c-4fb6-804b-e8e5d4392bda'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알레그로 G단조 (금관 7중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '874db609-139c-4fb6-804b-e8e5d4392bda'
);


-- JS 27 알레그로 D장조 (피아노 3중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그로 D장조 (피아노 3중주)', 'Allegro in D major for piano trio', 'song', 'JS 27', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그로 D장조 (피아노 3중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e28fe15-b16c-47d9-8299-b3082de647ca'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e28fe15-b16c-47d9-8299-b3082de647ca'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알레그로 D장조 (피아노 3중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e28fe15-b16c-47d9-8299-b3082de647ca'
);


-- JS 28 알레그로 E단조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그로 E단조 (현악 4중주)', 'Allegro in E minor for string quartet', 'song', 'JS 28', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그로 E단조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2125f8a1-d800-41e4-a364-929c7819a7da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2125f8a1-d800-41e4-a364-929c7819a7da'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알레그로 E단조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2125f8a1-d800-41e4-a364-929c7819a7da'
);


-- JS 30a 안단테 E♭장조 (1887)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 E♭장조 (1887)', 'Andante in E♭ major (1887)', 'song', 'JS 30a', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 E♭장조 (1887)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34bc3f7c-93cc-48be-a53d-971f8b8ddbf1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '34bc3f7c-93cc-48be-a53d-971f8b8ddbf1'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단테 E♭장조 (1887)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34bc3f7c-93cc-48be-a53d-971f8b8ddbf1'
);


-- JS 31 안단테 – 알레그로 (피아노 5중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 – 알레그로 (피아노 5중주)', 'Andante – Allegro for piano quintet', 'song', 'JS 31', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 – 알레그로 (피아노 5중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd6f1381-6ba8-4c42-af92-e01974b98538'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fd6f1381-6ba8-4c42-af92-e01974b98538'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단테 – 알레그로 (피아노 5중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd6f1381-6ba8-4c42-af92-e01974b98538'
);


-- JS 32 안단테 – 알레그로 몰토 D장조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 – 알레그로 몰토 D장조 (현악 4중주)', 'Andante – Allegro molto in D major for string quartet', 'song', 'JS 32', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 – 알레그로 몰토 D장조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '542265cc-ddb7-4590-b691-049838326f09'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '542265cc-ddb7-4590-b691-049838326f09'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단테 – 알레그로 몰토 D장조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '542265cc-ddb7-4590-b691-049838326f09'
);


-- JS 33 안단테 칸타빌레 G장조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 칸타빌레 G장조 (바이올린과 피아노)', 'Andante cantabile in G major for violin and piano', 'song', 'JS 33', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 칸타빌레 G장조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85cb820b-9700-4a5f-96a3-013363dcf938'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '85cb820b-9700-4a5f-96a3-013363dcf938'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단테 칸타빌레 G장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85cb820b-9700-4a5f-96a3-013363dcf938'
);


-- JS 34b 안단테 페스티보

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 페스티보', 'Andante festivo', 'song', 'JS 34b', NULL, NULL, 1938, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 페스티보'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f86be6c1-2eab-3aab-a228-1fa7b4c0d436'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f86be6c1-2eab-3aab-a228-1fa7b4c0d436'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단테 페스티보' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f86be6c1-2eab-3aab-a228-1fa7b4c0d436'
);


-- JS 35 안단테 그라치오소 D장조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 그라치오소 D장조 (바이올린과 피아노)', 'Andante grazioso in D major for violin and piano', 'song', 'JS 35', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 그라치오소 D장조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8998eaf-7869-48ab-a066-7ee280973b69'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8998eaf-7869-48ab-a066-7ee280973b69'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단테 그라치오소 D장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8998eaf-7869-48ab-a066-7ee280973b69'
);


-- JS 36 안단테 몰토 F단조 (첼로와 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 몰토 F단조 (첼로와 피아노)', 'Andante molto in F minor for cello and piano', 'song', 'JS 36', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 몰토 F단조 (첼로와 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c87be0fc-44ea-4f77-8836-12e0630bfbc4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c87be0fc-44ea-4f77-8836-12e0630bfbc4'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단테 몰토 F단조 (첼로와 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c87be0fc-44ea-4f77-8836-12e0630bfbc4'
);


-- JS 38 안단티노 A장조 (피아노 3중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 A장조 (피아노 3중주)', 'Andantino in A major for piano trio', 'song', 'JS 38', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 A장조 (피아노 3중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe09726b-2c79-45b7-9052-31db2fb8c0ce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fe09726b-2c79-45b7-9052-31db2fb8c0ce'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단티노 A장조 (피아노 3중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe09726b-2c79-45b7-9052-31db2fb8c0ce'
);


-- JS 39 안단티노 C장조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 C장조 (현악 4중주)', 'Andantino in C major for string quartet', 'song', 'JS 39', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 C장조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b61a7735-1d1d-4d4d-84d1-650156cba0ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b61a7735-1d1d-4d4d-84d1-650156cba0ed'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단티노 C장조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b61a7735-1d1d-4d4d-84d1-650156cba0ed'
);


-- JS 40 안단티노 C장조 (첼로와 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 C장조 (첼로와 피아노)', 'Andantino in C major for cello and piano', 'song', 'JS 40', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 C장조 (첼로와 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8ae5927-10ab-4e0c-8f8a-ebcc6ef9362b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e8ae5927-10ab-4e0c-8f8a-ebcc6ef9362b'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단티노 C장조 (첼로와 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8ae5927-10ab-4e0c-8f8a-ebcc6ef9362b'
);


-- JS 41 안단티노 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 E장조', 'Andantino in E major', 'song', 'JS 41', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac1ad1dd-8e6a-4e7a-a8f4-117e7eaf0a12'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac1ad1dd-8e6a-4e7a-a8f4-117e7eaf0a12'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단티노 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac1ad1dd-8e6a-4e7a-a8f4-117e7eaf0a12'
);


-- JS 43 안단티노 G단조 (피아노 3중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 G단조 (피아노 3중주)', 'Andantino in G minor for piano trio', 'song', 'JS 43', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 G단조 (피아노 3중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c692595-bbff-4c4a-92fa-c0b3da809a33'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c692595-bbff-4c4a-92fa-c0b3da809a33'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단티노 G단조 (피아노 3중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c692595-bbff-4c4a-92fa-c0b3da809a33'
);


-- JS 44 안단티노 B장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 B장조', 'Andantino in B major', 'song', 'JS 44', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 B장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '716555eb-51eb-4a8a-9c83-11b8f50f3001'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '716555eb-51eb-4a8a-9c83-11b8f50f3001'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단티노 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '716555eb-51eb-4a8a-9c83-11b8f50f3001'
);


-- JS 45 금관 7중주를 위한 안단티노와 미뉴에트

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '금관 7중주를 위한 안단티노와 미뉴에트', 'Andantino and Menuetto for brass septet', 'album', 'JS 45', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '금관 7중주를 위한 안단티노와 미뉴에트'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7c40269-37f9-4e56-ab3b-4471d2988926'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a7c40269-37f9-4e56-ab3b-4471d2988926'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '금관 7중주를 위한 안단티노와 미뉴에트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7c40269-37f9-4e56-ab3b-4471d2988926'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:790076b1-67b3-47c8-8cc0-cc9f060c6224', 1, NULL, '안단티노', 'Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '금관 7중주를 위한 안단티노와 미뉴에트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:790076b1-67b3-47c8-8cc0-cc9f060c6224'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c762fc27-d89f-4218-8bf6-f943f2e7cce7', 2, NULL, '미뉴에트', 'Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '금관 7중주를 위한 안단티노와 미뉴에트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c762fc27-d89f-4218-8bf6-f943f2e7cce7'
);


-- JS 46 아침의 노래 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아침의 노래 A♭장조', '[Aubade] in A♭ major', 'song', 'JS 46', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아침의 노래 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '202b1326-9d3d-4e8d-a6ab-2bd7bc095592'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '202b1326-9d3d-4e8d-a6ab-2bd7bc095592'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '아침의 노래 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '202b1326-9d3d-4e8d-a6ab-2bd7bc095592'
);


-- JS 47 황혼에 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '황혼에 F#단조', 'Au crépuscule in F# minor', 'song', 'JS 47', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '황혼에 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0746c8b-764b-408a-8f10-f531780dc056'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f0746c8b-764b-408a-8f10-f531780dc056'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '황혼에 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0746c8b-764b-408a-8f10-f531780dc056'
);


-- JS 48 부수음악 <벨사살의 향연>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <벨사살의 향연>', 'Belshazzar''s Feast (Belsazars gästabud), Incidental Music', 'song', 'JS 48', NULL, NULL, 1906, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <벨사살의 향연>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da859979-873a-4959-a8d0-e5bd11b0e46a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'da859979-873a-4959-a8d0-e5bd11b0e46a'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '부수음악 <벨사살의 향연>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da859979-873a-4959-a8d0-e5bd11b0e46a'
);


-- JS 49 안단테 몰토 C장조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 몰토 C장조 (바이올린과 피아노)', '[Andante molto] in C major for violin and piano', 'song', 'JS 49', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 몰토 C장조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5477b6de-a0ad-40ed-a761-4b84ea2a8c82'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5477b6de-a0ad-40ed-a761-4b84ea2a8c82'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단테 몰토 C장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5477b6de-a0ad-40ed-a761-4b84ea2a8c82'
);


-- JS 50 카논 G단조 (바이올린과 첼로)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 G단조 (바이올린과 첼로)', 'Canon in G minor for violin and cello', 'song', 'JS 50', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 G단조 (바이올린과 첼로)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c6a220b-5738-409c-b420-ffc216d98da7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4c6a220b-5738-409c-b420-ffc216d98da7'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '카논 G단조 (바이올린과 첼로)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c6a220b-5738-409c-b420-ffc216d98da7'
);


-- JS 52 콘 모토, 셈프레 우나 코르다 D♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '콘 모토, 셈프레 우나 코르다 D♭장조', 'Con moto, sempre una corda in D♭ major', 'song', 'JS 52', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '콘 모토, 셈프레 우나 코르다 D♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea0f6eb8-8e6a-483d-8cf9-6f63d1f7d56f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ea0f6eb8-8e6a-483d-8cf9-6f63d1f7d56f'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '콘 모토, 셈프레 우나 코르다 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea0f6eb8-8e6a-483d-8cf9-6f63d1f7d56f'
);


-- JS 53 콘 파시오네

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '콘 파시오네', 'Con passione', 'song', 'JS 53', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '콘 파시오네'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f18257e4-bffc-46bb-b014-d8dcde5b7760'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f18257e4-bffc-46bb-b014-d8dcde5b7760'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '콘 파시오네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f18257e4-bffc-46bb-b014-d8dcde5b7760'
);


-- JS 54 관현악을 위한 <행렬>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <행렬>', 'Cortège', 'song', 'JS 54', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <행렬>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25914720-acbf-4a56-8d61-90933eda90ca'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '25914720-acbf-4a56-8d61-90933eda90ca'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '관현악을 위한 <행렬>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25914720-acbf-4a56-8d61-90933eda90ca'
);


-- JS 55 연습곡 D장조 (바이올린 독주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연습곡 D장조 (바이올린 독주)', '[Étude] in D major for solo violin', 'song', 'JS 55', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연습곡 D장조 (바이올린 독주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d1dc1e0-e28d-4870-a1c1-972bd8d461f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9d1dc1e0-e28d-4870-a1c1-972bd8d461f6'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '연습곡 D장조 (바이올린 독주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d1dc1e0-e28d-4870-a1c1-972bd8d461f6'
);


-- JS 58a 합창곡 <Den höga himlen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Den höga himlen>', 'Den höga himlen (The Lofty Heaven)', 'song', 'JS 58a', NULL, NULL, 1927, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Den höga himlen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df55f549-a566-4506-94cd-9e2e55cf7342'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df55f549-a566-4506-94cd-9e2e55cf7342'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Den höga himlen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df55f549-a566-4506-94cd-9e2e55cf7342'
);


-- JS 60 합창곡 <Den 25 oktober 1902. Till Thérèse Hahl> (첫 작곡)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Den 25 oktober 1902. Till Thérèse Hahl> (첫 작곡)', 'Den 25 oktober 1902. Till Thérèse Hahl [Version I]', 'song', 'JS 60', NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Den 25 oktober 1902. Till Thérèse Hahl> (첫 작곡)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4144e42-3575-4bc4-9ed1-637a386fa87b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4144e42-3575-4bc4-9ed1-637a386fa87b'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Den 25 oktober 1902. Till Thérèse Hahl> (첫 작곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4144e42-3575-4bc4-9ed1-637a386fa87b'
);


-- JS 61 합창곡 <Den 25 oktober 1902. Till Thérèse Hahl> (두 번째 작곡)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Den 25 oktober 1902. Till Thérèse Hahl> (두 번째 작곡)', 'Den 25 oktober 1902. Till Thérèse Hahl [Version II]', 'song', 'JS 61', NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Den 25 oktober 1902. Till Thérèse Hahl> (두 번째 작곡)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b3e251e-4a7d-42d2-9ed5-1e59450ba347'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1b3e251e-4a7d-42d2-9ed5-1e59450ba347'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Den 25 oktober 1902. Till Thérèse Hahl> (두 번째 작곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b3e251e-4a7d-42d2-9ed5-1e59450ba347'
);


-- JS 62 부수음악 <새들의 언어> 중 결혼 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <새들의 언어> 중 결혼 행진곡', 'The Language of the Birds (Die Sprache der Vögel): Wedding March', 'song', 'JS 62', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <새들의 언어> 중 결혼 행진곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50b73326-d6f3-497c-8a44-4fdae25865fa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '50b73326-d6f3-497c-8a44-4fdae25865fa'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '부수음악 <새들의 언어> 중 결혼 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50b73326-d6f3-497c-8a44-4fdae25865fa'
);


-- JS 63 돌치시모 (칸텔레)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '돌치시모 (칸텔레)', 'Dolcissimo for kantele', 'song', 'JS 63', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '돌치시모 (칸텔레)'
);


-- JS 64 합창곡 <Drömmarna>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Drömmarna>', 'Drömmarna (The Dreams)', 'song', 'JS 64', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Drömmarna>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b5d58d8-765e-4ca1-926e-e823e1be1a83'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b5d58d8-765e-4ca1-926e-e823e1be1a83'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Drömmarna>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b5d58d8-765e-4ca1-926e-e823e1be1a83'
);


-- JS 65 <공중누각> (바이올린 2대)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<공중누각> (바이올린 2대)', 'Luftslott (Castles in the Air) for two violins', 'song', 'JS 65', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<공중누각> (바이올린 2대)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72e94420-9d8f-4b9a-8e9e-33d65a78e03f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72e94420-9d8f-4b9a-8e9e-33d65a78e03f'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<공중누각> (바이올린 2대)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72e94420-9d8f-4b9a-8e9e-33d65a78e03f'
);


-- JS 66 2중주 C장조 (바이올린과 비올라)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중주 C장조 (바이올린과 비올라)', 'Duo in C major for violin and viola', 'song', 'JS 66', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중주 C장조 (바이올린과 비올라)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5c7192a-7e39-4768-b7d1-f6b0a486362d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e5c7192a-7e39-4768-b7d1-f6b0a486362d'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2중주 C장조 (바이올린과 비올라)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5c7192a-7e39-4768-b7d1-f6b0a486362d'
);


-- JS 67 미뉴에트 E단조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 E단조 (바이올린과 피아노)', '[Menuetto] in E minor for violin and piano', 'song', 'JS 67', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 E단조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbc773dd-3c3e-4685-929f-163498567edc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bbc773dd-3c3e-4685-929f-163498567edc'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '미뉴에트 E단조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbc773dd-3c3e-4685-929f-163498567edc'
);


-- JS 68 2중주 E단조 (바이올린과 첼로)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중주 E단조 (바이올린과 첼로)', '[Duo] in E minor for violin and cello', 'song', 'JS 68', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중주 E단조 (바이올린과 첼로)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4f7dba5-5520-44da-9669-a9f406bf615a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4f7dba5-5520-44da-9669-a9f406bf615a'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2중주 E단조 (바이올린과 첼로)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4f7dba5-5520-44da-9669-a9f406bf615a'
);


-- JS 69 합창곡 <Ej med klagan>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Ej med klagan>', 'Ej med klagan (Not with Lamentation)', 'song', 'JS 69', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Ej med klagan>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '883000c5-20dd-4a67-87c9-1ec8e859b06e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '883000c5-20dd-4a67-87c9-1ec8e859b06e'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Ej med klagan>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '883000c5-20dd-4a67-87c9-1ec8e859b06e'
);


-- JS 70 <즐거운 악사> (바이올린 독주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<즐거운 악사> (바이올린 독주)', 'En glad musikant (A Happy Musician) for solo violin', 'song', 'JS 70', NULL, NULL, 1926, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<즐거운 악사> (바이올린 독주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6176df6b-927e-4ac2-b6d9-4d50cfb6503c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6176df6b-927e-4ac2-b6d9-4d50cfb6503c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<즐거운 악사> (바이올린 독주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6176df6b-927e-4ac2-b6d9-4d50cfb6503c'
);


-- JS 71 가곡 <En visa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <En visa>', 'En visa (A Song)', 'song', 'JS 71', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <En visa>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f1ed373-4015-440f-9ba6-1f174efcf717'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7f1ed373-4015-440f-9ba6-1f174efcf717'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <En visa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f1ed373-4015-440f-9ba6-1f174efcf717'
);


-- JS 72 합창곡 <Ensam i dunkla skogarnas famn>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Ensam i dunkla skogarnas famn>', 'Ensam i dunkla skogarnas famn', 'song', 'JS 72', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Ensam i dunkla skogarnas famn>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb938436-b937-474f-adc9-29806f07ffff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb938436-b937-474f-adc9-29806f07ffff'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Ensam i dunkla skogarnas famn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb938436-b937-474f-adc9-29806f07ffff'
);


-- JS 73 가곡 <Erloschen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Erloschen>', 'Erloschen (Extinguished)', 'song', 'JS 73', NULL, NULL, 1906, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Erloschen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ad23622-22a8-4610-a887-88a0a76f25b6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3ad23622-22a8-4610-a887-88a0a76f25b6'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <Erloschen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ad23622-22a8-4610-a887-88a0a76f25b6'
);


-- JS 74 안단테 E♭장조 (1885)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 E♭장조 (1885)', '[Andante] in E♭ major (1885)', 'song', 'JS 74', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 E♭장조 (1885)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fcc063cf-8428-4883-ba74-029dc821280d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fcc063cf-8428-4883-ba74-029dc821280d'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단테 E♭장조 (1885)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fcc063cf-8428-4883-ba74-029dc821280d'
);


-- JS 75 폴카 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 E♭장조', '[Polka] in E♭ major', 'song', 'JS 75', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f9d5b2e-9c1b-472a-a8ec-987bb8fab0ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0f9d5b2e-9c1b-472a-a8ec-987bb8fab0ed'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '폴카 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f9d5b2e-9c1b-472a-a8ec-987bb8fab0ed'
);


-- JS 76 렌토 E♭단조 (바이올린(또는 첼로)과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '렌토 E♭단조 (바이올린(또는 첼로)과 피아노)', '[Lento] in E♭ minor for violin (or cello) and piano', 'song', 'JS 76', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '렌토 E♭단조 (바이올린(또는 첼로)과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be2ade55-7e56-40b4-9e70-0509ac6fd13f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be2ade55-7e56-40b4-9e70-0509ac6fd13f'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '렌토 E♭단조 (바이올린(또는 첼로)과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be2ade55-7e56-40b4-9e70-0509ac6fd13f'
);


-- JS 77a 멜로드라마 <외로운 스키 자국>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <외로운 스키 자국>', 'Ett ensamt skidspår (A Lonely Ski-Trail)', 'song', 'JS 77a', NULL, NULL, 1925, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <외로운 스키 자국>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f1fd2df-de97-4c7e-92c2-e0e51e89723a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f1fd2df-de97-4c7e-92c2-e0e51e89723a'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '멜로드라마 <외로운 스키 자국>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f1fd2df-de97-4c7e-92c2-e0e51e89723a'
);


-- JS 78 스케르치노 F장조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르치노 F장조 (바이올린과 피아노)', '[Scherzino] in F major for violin and piano', 'song', 'JS 78', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르치노 F장조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1dacd047-fb2b-4dcc-8d54-a7188ff4da02'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1dacd047-fb2b-4dcc-8d54-a7188ff4da02'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '스케르치노 F장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1dacd047-fb2b-4dcc-8d54-a7188ff4da02'
);


-- JS 82 피아노 모음곡 <플로레스탄>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <플로레스탄>', 'Florestan', 'album', 'JS 82', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <플로레스탄>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'faab0dc0-b6d9-4ca2-956e-699ec4e178ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'faab0dc0-b6d9-4ca2-956e-699ec4e178ff'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <플로레스탄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'faab0dc0-b6d9-4ca2-956e-699ec4e178ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11709974-b3fa-4ae7-a2b9-d0184a7907b3', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <플로레스탄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11709974-b3fa-4ae7-a2b9-d0184a7907b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce7cfd01-6e9a-459c-a594-07b4fc4caf8f', 2, 'II', 'Molto moderato', 'II. Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <플로레스탄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce7cfd01-6e9a-459c-a594-07b4fc4caf8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:545099ca-b75b-4d8c-9475-a318df391b67', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <플로레스탄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:545099ca-b75b-4d8c-9475-a318df391b67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94a3abe8-888e-4d74-80ac-470c9b6c384f', 4, 'IV', 'Tempo I', 'IV. Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 모음곡 <플로레스탄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94a3abe8-888e-4d74-80ac-470c9b6c384f'
);


-- JS 83 전주곡 (금관 7중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 (금관 7중주)', 'Preludium (Förspel) for brass septet', 'song', 'JS 83', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 (금관 7중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19416862-9379-43cc-9010-e9031681cea5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '19416862-9379-43cc-9010-e9031681cea5'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '전주곡 (금관 7중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19416862-9379-43cc-9010-e9031681cea5'
);


-- JS 84 합창곡 <Fridolins dårskap>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Fridolins dårskap>', 'Fridolins dårskap (Fridolin''s Folly)', 'song', 'JS 84', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Fridolins dårskap>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b29c9a4c-7a8d-44d8-8d56-04c76fffc262'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b29c9a4c-7a8d-44d8-8d56-04c76fffc262'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Fridolins dårskap>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b29c9a4c-7a8d-44d8-8d56-04c76fffc262'
);


-- JS 85 마르틴 W.를 위한 푸가 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마르틴 W.를 위한 푸가 (현악 4중주)', 'Fuga för Martin W. for string quartet', 'song', 'JS 85', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마르틴 W.를 위한 푸가 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c581b36a-2ce4-40b2-b27a-8139a17da758'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c581b36a-2ce4-40b2-b27a-8139a17da758'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '마르틴 W.를 위한 푸가 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c581b36a-2ce4-40b2-b27a-8139a17da758'
);


-- JS 86 알레그레토 G장조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 G장조 (바이올린과 피아노)', '[Allegretto] in G major for violin and piano', 'song', 'JS 86', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 G장조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0514f239-d4e0-4738-ae6d-f2ace934cbde'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0514f239-d4e0-4738-ae6d-f2ace934cbde'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알레그레토 G장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0514f239-d4e0-4738-ae6d-f2ace934cbde'
);


-- JS 88 멜로드라마 <백작 부인의 초상>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <백작 부인의 초상>', 'Grevinnans konterfej (The Countess''s Portrait)', 'song', 'JS 88', NULL, NULL, 1906, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <백작 부인의 초상>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55d1b59f-6a91-4d93-a75d-8e8616ad7ceb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '55d1b59f-6a91-4d93-a75d-8e8616ad7ceb'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '멜로드라마 <백작 부인의 초상>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55d1b59f-6a91-4d93-a75d-8e8616ad7ceb'
);


-- JS 93 합창곡 <Har du mod?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Har du mod?>', 'Har du mod? (Have You Courage?)', 'song', 'JS 93', NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Har du mod?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54466e19-cb67-4ea4-b41e-30806dd50de2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '54466e19-cb67-4ea4-b41e-30806dd50de2'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Har du mod?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54466e19-cb67-4ea4-b41e-30806dd50de2'
);


-- JS 95 가곡 <Herran siunaus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Herran siunaus>', 'Herran siunaus (The Lord''s Blessing)', 'song', 'JS 95', NULL, NULL, 1925, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Herran siunaus>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ed0a35e-d9e1-4e14-aa65-3eb557b5fd5c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9ed0a35e-d9e1-4e14-aa65-3eb557b5fd5c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <Herran siunaus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ed0a35e-d9e1-4e14-aa65-3eb557b5fd5c'
);


-- JS 96 합창곡 <Hur blekt är allt>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Hur blekt är allt>', 'Hur blekt är allt', 'song', 'JS 96', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Hur blekt är allt>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0fcd339-86d0-4c08-bba4-6a42b6d85c41'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0fcd339-86d0-4c08-bba4-6a42b6d85c41'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Hur blekt är allt>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0fcd339-86d0-4c08-bba4-6a42b6d85c41'
);


-- JS 97 가곡 <잊을 수 없는 타이스 찬가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <잊을 수 없는 타이스 찬가>', 'Hymn to Thaïs, the Unforgettable', 'song', 'JS 97', NULL, NULL, 1948, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <잊을 수 없는 타이스 찬가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6e5989d-f93c-4a56-aad9-b0ce8cce3296'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b6e5989d-f93c-4a56-aad9-b0ce8cce3296'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <잊을 수 없는 타이스 찬가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6e5989d-f93c-4a56-aad9-b0ce8cce3296'
);


-- JS 98 합창곡 <Isänmaalle>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Isänmaalle>', 'Isänmaalle (To the Fatherland)', 'song', 'JS 98', NULL, NULL, 1900, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Isänmaalle>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4942d8d-af77-48f3-9d2d-c70e88edf8d0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4942d8d-af77-48f3-9d2d-c70e88edf8d0'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Isänmaalle>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4942d8d-af77-48f3-9d2d-c70e88edf8d0'
);


-- JS 100 합창곡 <Jone havsfärd>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Jone havsfärd>', 'Jone havsfärd (Jonah''s Voyage)', 'song', 'JS 100', NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Jone havsfärd>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '439c2f31-939a-4714-bb21-3d07fb94b250'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '439c2f31-939a-4714-bb21-3d07fb94b250'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Jone havsfärd>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '439c2f31-939a-4714-bb21-3d07fb94b250'
);


-- JS 101 오페라 <탑 속의 처녀>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <탑 속의 처녀>', 'The Maiden in the Tower (Jungfrun i tornet)', 'song', 'JS 101', NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <탑 속의 처녀>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '431e3ede-e6c1-4ec9-9e86-d5e27ec2117c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '431e3ede-e6c1-4ec9-9e86-d5e27ec2117c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '오페라 <탑 속의 처녀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '431e3ede-e6c1-4ec9-9e86-d5e27ec2117c'
);


-- JS 102 카리용을 위한 <칼리오 교회의 종>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카리용을 위한 <칼리오 교회의 종>', 'Kallion kirkon kellosävel (The Bells of Kallio Church)', 'song', 'JS 102', NULL, NULL, 1912, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카리용을 위한 <칼리오 교회의 종>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a47ca6a-069e-41ac-a12c-c69f7252d7d3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8a47ca6a-069e-41ac-a12c-c69f7252d7d3'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '카리용을 위한 <칼리오 교회의 종>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a47ca6a-069e-41ac-a12c-c69f7252d7d3'
);


-- JS 103 합창곡 <Kansakoululaisten marssi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Kansakoululaisten marssi>', 'Kansakoululaisten marssi', 'song', 'JS 103', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Kansakoululaisten marssi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5deae6ab-2b51-4238-ac72-c02adc41c51e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5deae6ab-2b51-4238-ac72-c02adc41c51e'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Kansakoululaisten marssi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5deae6ab-2b51-4238-ac72-c02adc41c51e'
);


-- JS 104 니콜라이 2세 대관 칸타타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '니콜라이 2세 대관 칸타타', 'Cantata for the Coronation of Nicholas II', 'song', 'JS 104', NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '니콜라이 2세 대관 칸타타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c67140d3-5663-4b9a-aa84-3a1436f5f174'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c67140d3-5663-4b9a-aa84-3a1436f5f174'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '니콜라이 2세 대관 칸타타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c67140d3-5663-4b9a-aa84-3a1436f5f174'
);


-- JS 107 여성 합창을 위한 칸타타 (1911)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '여성 합창을 위한 칸타타 (1911)', 'Kantat (Cantata) for female chorus', 'song', 'JS 107', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '여성 합창을 위한 칸타타 (1911)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01c62bea-2a02-4e4b-8730-658a73aea38b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '01c62bea-2a02-4e4b-8730-658a73aea38b'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '여성 합창을 위한 칸타타 (1911)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01c62bea-2a02-4e4b-8730-658a73aea38b'
);


-- JS 108 합창곡 <Karjalan osa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Karjalan osa>', 'Karjalan osa (Karelia''s Fate)', 'song', 'JS 108', NULL, NULL, 1930, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Karjalan osa>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5824bbc4-bf06-4250-8d5e-d75e6e807a22'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5824bbc4-bf06-4250-8d5e-d75e6e807a22'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Karjalan osa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5824bbc4-bf06-4250-8d5e-d75e6e807a22'
);


-- JS 109 피아노곡 <기사>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡 <기사>', 'Kavaljeren (The Cavalier)', 'song', 'JS 109', NULL, NULL, 1900, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡 <기사>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b6414d5-6a73-46a4-872b-5eb459f0c2e3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b6414d5-6a73-46a4-872b-5eb459f0c2e3'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노곡 <기사>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b6414d5-6a73-46a4-872b-5eb459f0c2e3'
);


-- JS 110 3개의 입당 교창 JS 110

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 입당 교창 JS 110', '3 Introductory Antiphons, JS 110', 'album', NULL, 'JS', '110', 1925, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 입당 교창 JS 110'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8c4b6a8-4a23-4de6-900c-1d054307d850'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c8c4b6a8-4a23-4de6-900c-1d054307d850'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3개의 입당 교창 JS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8c4b6a8-4a23-4de6-900c-1d054307d850'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5570223-cc39-4695-a78c-d9132307f173', 1, NULL, 'Palmusunnuntaina', 'No. 1 Palmusunnuntaina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3개의 입당 교창 JS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5570223-cc39-4695-a78c-d9132307f173'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ca409d5-2604-49b0-a4b9-a60b860058ca', 2, NULL, 'Pyhäinpäivänä tai hautajaisjumalanpalveluksissa', 'No. 2 Pyhäinpäivänä tai hautajaisjumalanpalveluksissa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3개의 입당 교창 JS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ca409d5-2604-49b0-a4b9-a60b860058ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62f93be3-0e26-43a1-94c9-f5c93d2d625b', 3, NULL, 'Kristillisissä nuorisojuhlissa', 'No. 3 Kristillisissä nuorisojuhlissa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3개의 입당 교창 JS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62f93be3-0e26-43a1-94c9-f5c93d2d625b'
);


-- JS 111 여성 3중창 <Kotikaipaus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '여성 3중창 <Kotikaipaus>', 'Kotikaipaus (Homesickness)', 'song', 'JS 111', NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '여성 3중창 <Kotikaipaus>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc3844c3-c39a-4579-9ee3-033e26750fdd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc3844c3-c39a-4579-9ee3-033e26750fdd'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '여성 3중창 <Kotikaipaus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc3844c3-c39a-4579-9ee3-033e26750fdd'
);


-- JS 112 합창곡 <Koulutie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Koulutie>', 'Koulutie (The Way to School)', 'song', 'JS 112', NULL, NULL, 1924, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Koulutie>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ed9c3dc-a45c-454a-a1bf-dbd45f21227c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ed9c3dc-a45c-454a-a1bf-dbd45f21227c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Koulutie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ed9c3dc-a45c-454a-a1bf-dbd45f21227c'
);


-- JS 113 부수음악 <쿠올레마>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <쿠올레마>', 'Kuolema (Death), Incidental Music', 'song', 'JS 113', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <쿠올레마>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09d7127b-fc04-41b6-a0e8-df1fde657235'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09d7127b-fc04-41b6-a0e8-df1fde657235'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '부수음악 <쿠올레마>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09d7127b-fc04-41b6-a0e8-df1fde657235'
);


-- JS 114 합창곡 <Kuutamolla>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Kuutamolla>', 'Kuutamolla (In the Moonlight)', 'song', 'JS 114', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Kuutamolla>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9a2443a-7ff1-40cd-8356-e46b8b8b0d1e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9a2443a-7ff1-40cd-8356-e46b8b8b0d1e'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Kuutamolla>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9a2443a-7ff1-40cd-8356-e46b8b8b0d1e'
);


-- JS 116 <아시스의 장엄한 행진곡> (피아노 3중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<아시스의 장엄한 행진곡> (피아노 3중주)', 'La pompeuse Marche d''Asis for piano trio', 'song', 'JS 116', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<아시스의 장엄한 행진곡> (피아노 3중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a85644d4-414c-303d-a11a-8ec723e85a26'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a85644d4-414c-303d-a11a-8ec723e85a26'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<아시스의 장엄한 행진곡> (피아노 3중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a85644d4-414c-303d-a11a-8ec723e85a26'
);


-- JS 117 라르고 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '라르고 A장조', 'Largo in A major', 'song', 'JS 117', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '라르고 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0cdb90a-41af-4779-ad42-3769cd773c4e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f0cdb90a-41af-4779-ad42-3769cd773c4e'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '라르고 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0cdb90a-41af-4779-ad42-3769cd773c4e'
);


-- JS 119 렌토 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '렌토 E장조', 'Lento in E major', 'song', 'JS 119', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '렌토 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2f8871e-e05a-4d64-b757-a1ce5843f6d1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd2f8871e-e05a-4d64-b757-a1ce5843f6d1'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '렌토 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2f8871e-e05a-4d64-b757-a1ce5843f6d1'
);


-- JS 120 가곡 <Likhet>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Likhet>', 'Likhet (Alikeness)', 'song', 'JS 120', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Likhet>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70145e76-ec91-4464-8b79-80d8ea8b6d03'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '70145e76-ec91-4464-8b79-80d8ea8b6d03'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <Likhet>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70145e76-ec91-4464-8b79-80d8ea8b6d03'
);


-- JS 121 합창곡 <Likhet>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Likhet>', 'Likhet (Resemblance)', 'song', 'JS 121', NULL, NULL, 1922, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Likhet>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6f21ab7-882a-43fc-9507-e0eca5db5fd6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6f21ab7-882a-43fc-9507-e0eca5db5fd6'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Likhet>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6f21ab7-882a-43fc-9507-e0eca5db5fd6'
);


-- JS 123 만돌리나토

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '만돌리나토', 'Mandolinato', 'song', 'JS 123', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '만돌리나토'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00b1d6e8-a130-45a8-8336-1921ab554736'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '00b1d6e8-a130-45a8-8336-1921ab554736'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '만돌리나토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00b1d6e8-a130-45a8-8336-1921ab554736'
);


-- JS 124 슬픈 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '슬픈 행진곡', 'Marche triste', 'song', 'JS 124', NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '슬픈 행진곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44ff53be-f7c5-492f-b251-a2094671b180'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '44ff53be-f7c5-492f-b251-a2094671b180'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '슬픈 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44ff53be-f7c5-492f-b251-a2094671b180'
);


-- JS 125 멜로드라마 <질투의 밤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <질투의 밤>', 'Svartsjukans nätter (Nights of Jealousy)', 'song', 'JS 125', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <질투의 밤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b897198c-c49a-46dc-8fc7-e0006d6053cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b897198c-c49a-46dc-8fc7-e0006d6053cf'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '멜로드라마 <질투의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b897198c-c49a-46dc-8fc7-e0006d6053cf'
);


-- JS 126 미뉴에트 F장조 (피아노와 바이올린 2대)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 F장조 (피아노와 바이올린 2대)', 'Menuetto in F major for two violins and piano', 'song', 'JS 126', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 F장조 (피아노와 바이올린 2대)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b538d00e-d57c-48a7-96b5-63cc097608bd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b538d00e-d57c-48a7-96b5-63cc097608bd'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '미뉴에트 F장조 (피아노와 바이올린 2대)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b538d00e-d57c-48a7-96b5-63cc097608bd'
);


-- JS 127 관현악을 위한 미뉴에트

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 미뉴에트', 'Menuetto for orchestra', 'song', 'JS 127', NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 미뉴에트'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e94f1749-d851-4813-81c8-7fb97af21425'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e94f1749-d851-4813-81c8-7fb97af21425'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '관현악을 위한 미뉴에트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e94f1749-d851-4813-81c8-7fb97af21425'
);


-- JS 128 미뉴에트와 알레그로 (바이올린 2대와 첼로)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트와 알레그로 (바이올린 2대와 첼로)', 'Menuetto and Allegro for two violins and cello', 'album', 'JS 128', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트와 알레그로 (바이올린 2대와 첼로)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a3d489d-fddc-491a-873a-edeb8d4a4663'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2a3d489d-fddc-491a-873a-edeb8d4a4663'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '미뉴에트와 알레그로 (바이올린 2대와 첼로)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a3d489d-fddc-491a-873a-edeb8d4a4663'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e145003c-274f-4186-8ae3-0e5add3238b9', 1, 'I', '미뉴에트 – Adagio molto – Coda. Più lento', 'I. Menuetto – Adagio molto – Coda. Più lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '미뉴에트와 알레그로 (바이올린 2대와 첼로)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e145003c-274f-4186-8ae3-0e5add3238b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ee5deb3-891d-4cdb-bdff-2456608676f3', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '미뉴에트와 알레그로 (바이올린 2대와 첼로)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ee5deb3-891d-4cdb-bdff-2456608676f3'
);


-- JS 129 합창곡 <Min rastas raataa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Min rastas raataa>', 'Min rastas raataa (Busy as a Thrush)', 'song', 'JS 129', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Min rastas raataa>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98fb8dff-1b8d-48c5-a841-ecdc6a29e7cc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '98fb8dff-1b8d-48c5-a841-ecdc6a29e7cc'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Min rastas raataa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98fb8dff-1b8d-48c5-a841-ecdc6a29e7cc'
);


-- JS 130 모데라토 (칸텔레)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모데라토 (칸텔레)', 'Moderato for kantele', 'song', 'JS 130', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모데라토 (칸텔레)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66647aad-2f40-485f-802d-7da0b2c1d7a1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '66647aad-2f40-485f-802d-7da0b2c1d7a1'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모데라토 (칸텔레)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66647aad-2f40-485f-802d-7da0b2c1d7a1'
);


-- JS 131 모데라토 – 알레그로 아파시오나토 C#단조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모데라토 – 알레그로 아파시오나토 C#단조 (현악 4중주)', 'Moderato – Allegro appassionato in C# minor for string quartet', 'song', 'JS 131', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모데라토 – 알레그로 아파시오나토 C#단조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ec5631a-224c-3c0c-8a9b-ea393ff08d06'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ec5631a-224c-3c0c-8a9b-ea393ff08d06'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모데라토 – 알레그로 아파시오나토 C#단조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ec5631a-224c-3c0c-8a9b-ea393ff08d06'
);


-- JS 132 모데라토 – 마에스토소 E♭장조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모데라토 – 마에스토소 E♭장조 (바이올린과 피아노)', 'Moderato – Maestoso in E♭ major for violin and piano', 'song', 'JS 132', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모데라토 – 마에스토소 E♭장조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '007a3505-8dfb-4c7d-9c4b-b0855b090295'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '007a3505-8dfb-4c7d-9c4b-b0855b090295'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모데라토 – 마에스토소 E♭장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '007a3505-8dfb-4c7d-9c4b-b0855b090295'
);


-- JS 133 모데라토 – 프레스토 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모데라토 – 프레스토 D단조', 'Moderato – Presto in D minor', 'song', 'JS 133', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모데라토 – 프레스토 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdc171b0-c7f4-485a-bd66-47eff7254e7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bdc171b0-c7f4-485a-bd66-47eff7254e7d'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모데라토 – 프레스토 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdc171b0-c7f4-485a-bd66-47eff7254e7d'
);


-- JS 134 몰토 모데라토 – 스케르초 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '몰토 모데라토 – 스케르초 (현악 4중주)', 'Molto moderato – Scherzo for string quartet', 'song', 'JS 134', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '몰토 모데라토 – 스케르초 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '630ad1e1-d319-42f8-adbd-1cadf6d3199c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '630ad1e1-d319-42f8-adbd-1cadf6d3199c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '몰토 모데라토 – 스케르초 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '630ad1e1-d319-42f8-adbd-1cadf6d3199c'
);


-- JS 135a 관현악을 위한 <낭만적 소품>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <낭만적 소품>', 'Morceau romantique sur un motif de M. Jacob de Julin', 'song', 'JS 135a', NULL, NULL, 1925, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <낭만적 소품>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ebba11f-6de3-4f46-9e8c-92d74f3051da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ebba11f-6de3-4f46-9e8c-92d74f3051da'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '관현악을 위한 <낭만적 소품>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ebba11f-6de3-4f46-9e8c-92d74f3051da'
);


-- JS 136 가곡 <Mummon syntymäpäivänä>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mummon syntymäpäivänä>', 'Mummon syntymäpäivänä (Birthday Song to Grandmother)', 'song', 'JS 136', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mummon syntymäpäivänä>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64b5b78e-a15b-4535-8caf-77e458bfaf8e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64b5b78e-a15b-4535-8caf-77e458bfaf8e'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <Mummon syntymäpäivänä>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64b5b78e-a15b-4535-8caf-77e458bfaf8e'
);


-- JS 137 <신문의 날 축제 음악>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<신문의 날 축제 음악>', 'Press Celebrations Music (Sanomalehdistön päivien musiikki)', 'song', 'JS 137', NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<신문의 날 축제 음악>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd996dbe0-8c85-45ee-8f1c-6d5b6aa25403'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd996dbe0-8c85-45ee-8f1c-6d5b6aa25403'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<신문의 날 축제 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd996dbe0-8c85-45ee-8f1c-6d5b6aa25403'
);


-- JS 138 멜로드라마 <물의 요정> A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <물의 요정> A♭장조', 'Näcken (The Watersprite) in A♭ major', 'song', 'JS 138', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <물의 요정> A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f4e9001-11d0-3521-be7a-8de7249c9263'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8f4e9001-11d0-3521-be7a-8de7249c9263'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '멜로드라마 <물의 요정> A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f4e9001-11d0-3521-be7a-8de7249c9263'
);


-- JS 139 합창곡 <När sig våren åter föder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <När sig våren åter föder>', 'När sig våren åter föder', 'song', 'JS 139', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <När sig våren åter föder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6915c748-698c-4635-9956-618c2f181aab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6915c748-698c-4635-9956-618c2f181aab'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <När sig våren åter föder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6915c748-698c-4635-9956-618c2f181aab'
);


-- JS 140 가곡 <Narciss>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Narciss>', 'Narciss (Narcissus)', 'song', 'JS 140', NULL, NULL, 1925, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Narciss>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd1e480f-3ca0-48f1-872f-519c53230a5b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bd1e480f-3ca0-48f1-872f-519c53230a5b'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <Narciss>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd1e480f-3ca0-48f1-872f-519c53230a5b'
);


-- JS 141 멜로드라마 <O, om du sett>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <O, om du sett>', 'O, om du sett (Oh, If You Had Seen)', 'song', 'JS 141', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <O, om du sett>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1423810f-459b-44b6-8625-f6c901bd0635'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1423810f-459b-44b6-8625-f6c901bd0635'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '멜로드라마 <O, om du sett>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1423810f-459b-44b6-8625-f6c901bd0635'
);


-- JS 142 합창곡 <On lapsonen syntynyt meille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <On lapsonen syntynyt meille>', 'On lapsonen syntynyt meille (A Child is Born to Us)', 'song', 'JS 142', NULL, NULL, 1929, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <On lapsonen syntynyt meille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b05a6678-a79d-44e4-b983-a405cc56b3ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b05a6678-a79d-44e4-b983-a405cc56b3ab'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <On lapsonen syntynyt meille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b05a6678-a79d-44e4-b983-a405cc56b3ab'
);


-- JS 143 가곡 <Orgier>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Orgier>', 'Orgier (Orgies)', 'song', 'JS 143', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Orgier>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2d9c9ff-85a4-400d-b49a-11e689f0a4a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c2d9c9ff-85a4-400d-b49a-11e689f0a4a4'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <Orgier>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2d9c9ff-85a4-400d-b49a-11e689f0a4a4'
);


-- JS 144 서곡 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 A단조', 'Overture in A minor', 'song', 'JS 144', NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acf98e5f-5d42-4a46-a7ae-b1408535e4ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'acf98e5f-5d42-4a46-a7ae-b1408535e4ec'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '서곡 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acf98e5f-5d42-4a46-a7ae-b1408535e4ec'
);


-- JS 145 서곡 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 E장조', 'Overture in E major', 'song', 'JS 145', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da19e34b-ce8b-4c50-8b7f-2dd81b04b7fc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'da19e34b-ce8b-4c50-8b7f-2dd81b04b7fc'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '서곡 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da19e34b-ce8b-4c50-8b7f-2dd81b04b7fc'
);


-- JS 146 서곡 F단조 (금관 7중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 F단조 (금관 7중주)', 'Overture in F minor for brass septet', 'song', 'JS 146', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 F단조 (금관 7중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f10f6db0-ad04-4474-a201-50e153cfb7f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f10f6db0-ad04-4474-a201-50e153cfb7f7'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '서곡 F단조 (금관 7중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f10f6db0-ad04-4474-a201-50e153cfb7f7'
);


-- JS 147 부수음악 <펠레아스와 멜리장드>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <펠레아스와 멜리장드>', 'Pelléas et Mélisande, Incidental Music', 'song', 'JS 147', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <펠레아스와 멜리장드>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e44350e5-3597-4876-a4af-46e7bc6da870'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e44350e5-3597-4876-a4af-46e7bc6da870'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '부수음악 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e44350e5-3597-4876-a4af-46e7bc6da870'
);


-- JS 149 피우 렌토 F장조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피우 렌토 F장조 (현악 4중주)', 'Più lento in F major for string quartet', 'song', 'JS 149', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피우 렌토 F장조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5068bc8-1bea-4c71-825c-22fbb71d3f90'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e5068bc8-1bea-4c71-825c-22fbb71d3f90'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피우 렌토 F장조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5068bc8-1bea-4c71-825c-22fbb71d3f90'
);


-- JS 150 피우 렌토 – 템포 디 발스 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피우 렌토 – 템포 디 발스 E♭장조', 'Più lento – Tempo di valse in E♭ major', 'song', 'JS 150', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피우 렌토 – 템포 디 발스 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a501835-e97e-40d7-a0a8-e98e216ea7eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0a501835-e97e-40d7-a0a8-e98e216ea7eb'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피우 렌토 – 템포 디 발스 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a501835-e97e-40d7-a0a8-e98e216ea7eb'
);


-- JS 153 오르간을 위한 2개의 소품 JS 153

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간을 위한 2개의 소품 JS 153', '2 Pieces for Organ, JS 153', 'album', NULL, 'JS', '153', 1926, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간을 위한 2개의 소품 JS 153'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d78a17df-aa17-4594-b959-766aa4a0d953', 1, NULL, '전주곡 (Preludium)', 'No. 1 Preludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '오르간을 위한 2개의 소품 JS 153' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d78a17df-aa17-4594-b959-766aa4a0d953'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32b99020-4f0b-4926-9088-b008529cf0de', 2, NULL, '후주곡 (Postludium)', 'No. 2 Postludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '오르간을 위한 2개의 소품 JS 153' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32b99020-4f0b-4926-9088-b008529cf0de'
);


-- JS 154 프레스토 F장조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '프레스토 F장조 (현악 4중주)', 'Presto in F major for string quartet', 'song', 'JS 154', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '프레스토 F장조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c28655e6-7153-4d9a-96d9-c23ea97be3d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c28655e6-7153-4d9a-96d9-c23ea97be3d9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '프레스토 F장조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c28655e6-7153-4d9a-96d9-c23ea97be3d9'
);


-- JS 155 학위 수여식 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '학위 수여식 행진곡', 'Academic March (Promootiomarssi)', 'song', 'JS 155', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '학위 수여식 행진곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91cf13cd-b217-4c5c-9cac-d6263182b7ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '91cf13cd-b217-4c5c-9cac-d6263182b7ba'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '학위 수여식 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91cf13cd-b217-4c5c-9cac-d6263182b7ba'
);


-- JS 157 피아노 4중주 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 4중주 D단조', 'Piano Quartet in D minor', 'album', 'JS 157', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 4중주 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22f43483-8286-45ed-8ec0-c1482ecaed74'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '22f43483-8286-45ed-8ec0-c1482ecaed74'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 4중주 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22f43483-8286-45ed-8ec0-c1482ecaed74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:497b708e-8ada-4ada-9e37-ce1a11cae14d', 1, 'I', 'Andante molto – Allegro moderato', 'I. Andante molto – Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 4중주 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:497b708e-8ada-4ada-9e37-ce1a11cae14d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18b1c284-3b5d-4af0-b348-5c7211c5697e', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 4중주 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18b1c284-3b5d-4af0-b348-5c7211c5697e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ba153d2-e0ba-480e-8640-df4fe1ada4e2', 3, 'III', '미뉴에트', 'III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 4중주 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ba153d2-e0ba-480e-8640-df4fe1ada4e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed3a1f55-524c-4a1a-b8ac-ea2935b7ba5c', 4, 'IV', 'Grave – 론도. Vivacissimo', 'IV. Grave – Rondo. Vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 4중주 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed3a1f55-524c-4a1a-b8ac-ea2935b7ba5c'
);


-- JS 158 하모늄 4중주 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하모늄 4중주 G단조', 'Harmonium Quartet in G minor', 'song', 'JS 158', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하모늄 4중주 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fae68661-def7-4c50-97ca-23293e4958a9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fae68661-def7-4c50-97ca-23293e4958a9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '하모늄 4중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fae68661-def7-4c50-97ca-23293e4958a9'
);


-- JS 159 피아노 5중주 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 5중주 G단조', 'Piano Quintet in G minor', 'album', 'JS 159', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 5중주 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c417a666-37ba-47fa-ab5e-169757348624'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c417a666-37ba-47fa-ab5e-169757348624'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 5중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c417a666-37ba-47fa-ab5e-169757348624'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54563d09-4049-333b-9079-c47f8f0b9d0c', 1, 'I', 'Grave – Allegro', 'I. Grave – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 5중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54563d09-4049-333b-9079-c47f8f0b9d0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d52df88a-0305-3d03-81d6-adc4ecec2648', 2, 'II', '간주곡. Moderato', 'II. Intermezzo. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 5중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d52df88a-0305-3d03-81d6-adc4ecec2648'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fadf30d2-3999-321f-a97b-2bfe550c691e', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 5중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fadf30d2-3999-321f-a97b-2bfe550c691e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd62020a-f350-3f8f-b0f9-e12f2727bd68', 4, 'IV', '스케르초. Vivacissimo', 'IV. Scherzo. Vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 5중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd62020a-f350-3f8f-b0f9-e12f2727bd68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c26a8743-0d5b-34f1-8dac-f2ee23deeb2b', 5, 'V', 'Moderato – Vivace', 'V. Moderato – Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 5중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c26a8743-0d5b-34f1-8dac-f2ee23deeb2b'
);


-- JS 160a 남성 합창곡 <라카스타바>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <라카스타바>', 'Rakastava (The Lover) for male chorus', 'album', 'JS 160a', NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <라카스타바>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ba0ef88-4150-4533-ba83-1ac4474e4b35'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ba0ef88-4150-4533-ba83-1ac4474e4b35'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 <라카스타바>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ba0ef88-4150-4533-ba83-1ac4474e4b35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:sibelius:sibelius-js-160:1', 1, NULL, 'Rakastava', 'No. 1 Rakastava', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 <라카스타바>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:sibelius:sibelius-js-160:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:sibelius:sibelius-js-160:2', 2, NULL, 'Rakastetun tie', 'No. 2 Rakastetun tie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 <라카스타바>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:sibelius:sibelius-js-160:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:sibelius:sibelius-js-160:3', 3, NULL, 'Hyvää iltaa ... Jää hyvästi', 'No. 3 Hyvää iltaa ... Jää hyvästi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '남성 합창곡 <라카스타바>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:sibelius:sibelius-js-160:3'
);


-- JS 161 <사랑하는 아이노에게> (피아노 연탄)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<사랑하는 아이노에게> (피아노 연탄)', 'Rakkaalle Ainolle (To My Beloved Aino) for piano four hands', 'song', 'JS 161', NULL, NULL, 1931, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<사랑하는 아이노에게> (피아노 연탄)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd40c8eb8-079d-42c0-bcdb-160061d5b14b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd40c8eb8-079d-42c0-bcdb-160061d5b14b'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<사랑하는 아이노에게> (피아노 연탄)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd40c8eb8-079d-42c0-bcdb-160061d5b14b'
);


-- JS 162 론도 D단조 (비올라와 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '론도 D단조 (비올라와 피아노)', 'Rondo in D minor for viola and piano', 'song', 'JS 162', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '론도 D단조 (비올라와 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80ec423a-a42d-4778-aa74-67135f6736c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '80ec423a-a42d-4778-aa74-67135f6736c7'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '론도 D단조 (비올라와 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80ec423a-a42d-4778-aa74-67135f6736c7'
);


-- JS 163 관현악을 위한 <발레 장면>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <발레 장면>', 'Scène de ballet', 'song', 'JS 163', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <발레 장면>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4bda8b4f-fa69-4c04-9092-90ad65aecd59'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4bda8b4f-fa69-4c04-9092-90ad65aecd59'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '관현악을 위한 <발레 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4bda8b4f-fa69-4c04-9092-90ad65aecd59'
);


-- JS 164 스케르초 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 F#단조', 'Scherzo in F# minor', 'song', 'JS 164', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62b54cfa-a179-4248-9ca1-3c9f7b7bffd2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '62b54cfa-a179-4248-9ca1-3c9f7b7bffd2'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '스케르초 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62b54cfa-a179-4248-9ca1-3c9f7b7bffd2'
);


-- JS 166 가곡 <Segelfahrt>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Segelfahrt>', 'Segelfahrt (Sailing)', 'song', 'JS 166', NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Segelfahrt>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '964693ca-9953-49bb-a471-a17eb0e6bafe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '964693ca-9953-49bb-a471-a17eb0e6bafe'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <Segelfahrt>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '964693ca-9953-49bb-a471-a17eb0e6bafe'
);


-- JS 167 가곡 <Serenad>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Serenad>', 'Serenad (Serenade)', 'song', 'JS 167', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Serenad>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0627ac08-2a0f-4337-a444-92bbc94159e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0627ac08-2a0f-4337-a444-92bbc94159e9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <Serenad>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0627ac08-2a0f-4337-a444-92bbc94159e9'
);


-- JS 168 바리톤과 관현악을 위한 <Serenad>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바리톤과 관현악을 위한 <Serenad>', 'Serenad (Serenade) for baritone and orchestra', 'song', 'JS 168', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바리톤과 관현악을 위한 <Serenad>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd906a001-3320-428f-a728-22903f05b3a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd906a001-3320-428f-a728-22903f05b3a4'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바리톤과 관현악을 위한 <Serenad>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd906a001-3320-428f-a728-22903f05b3a4'
);


-- JS 169 세레나타 D단조 (바이올린 2대와 첼로)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나타 D단조 (바이올린 2대와 첼로)', 'Serenata in D minor for two violins and cello', 'song', 'JS 169', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나타 D단조 (바이올린 2대와 첼로)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3d2198c-c912-4985-9ff3-4226813cfa96'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f3d2198c-c912-4985-9ff3-4226813cfa96'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '세레나타 D단조 (바이올린 2대와 첼로)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3d2198c-c912-4985-9ff3-4226813cfa96'
);


-- JS 170a 합창곡 <Siltavahti>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Siltavahti>', 'Siltavahti (The Guardian of the Bridge)', 'song', 'JS 170a', NULL, NULL, 1928, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Siltavahti>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e614028-59a4-4574-bf36-2cd3fa17e13d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3e614028-59a4-4574-bf36-2cd3fa17e13d'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Siltavahti>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e614028-59a4-4574-bf36-2cd3fa17e13d'
);


-- JS 171 가곡 <Skogsrået>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Skogsrået>', 'Skogsrået (The Wood-Nymph)', 'song', 'JS 171', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Skogsrået>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df3e6241-a736-45fe-8cd8-904dfbd76004'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df3e6241-a736-45fe-8cd8-904dfbd76004'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <Skogsrået>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df3e6241-a736-45fe-8cd8-904dfbd76004'
);


-- JS 172 합창곡 <Skolsång>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Skolsång>', 'Skolsång (School Song)', 'song', 'JS 172', NULL, NULL, 1925, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Skolsång>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c0b8aa9-e47a-4ad7-a435-7746a5b266b9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c0b8aa9-e47a-4ad7-a435-7746a5b266b9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Skolsång>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c0b8aa9-e47a-4ad7-a435-7746a5b266b9'
);


-- JS 173 합창곡 <Skyddskårsmarsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Skyddskårsmarsch>', 'Skyddskårsmarsch', 'song', 'JS 173', NULL, NULL, 1925, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Skyddskårsmarsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b54c12f3-887b-4237-8480-626e7a536da5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b54c12f3-887b-4237-8480-626e7a536da5'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Skyddskårsmarsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b54c12f3-887b-4237-8480-626e7a536da5'
);


-- JS 174 가곡 <Små flickorna>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Små flickorna>', 'Små flickorna (Young Girls)', 'song', 'JS 174', NULL, NULL, 1920, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Små flickorna>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13408d37-97a6-4ef2-979f-c05606b8ddb7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13408d37-97a6-4ef2-979f-c05606b8ddb7'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <Små flickorna>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13408d37-97a6-4ef2-979f-c05606b8ddb7'
);


-- JS 176 합창곡 <Soitapas sorea neito>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Soitapas sorea neito>', 'Soitapas sorea neito (Play, Pretty Maiden)', 'song', 'JS 176', NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Soitapas sorea neito>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61a24a04-69bd-410c-8b5a-faf4ec724a86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '61a24a04-69bd-410c-8b5a-faf4ec724a86'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Soitapas sorea neito>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61a24a04-69bd-410c-8b5a-faf4ec724a86'
);


-- JS 177 바이올린 소나타 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 A단조', 'Violin Sonata in A minor', 'album', 'JS 177', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d4a6803-d8b4-4f68-ac57-90f0335d6393'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2d4a6803-d8b4-4f68-ac57-90f0335d6393'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린 소나타 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d4a6803-d8b4-4f68-ac57-90f0335d6393'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50f3b016-955f-45e2-9f27-d06b5863a8ca', 1, 'I', 'Un poco lento – Più mosso quasi presto', 'I. Un poco lento – Più mosso quasi presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린 소나타 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50f3b016-955f-45e2-9f27-d06b5863a8ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c456c4ec-f998-4e45-8ac4-1ce984fabe2c', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린 소나타 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c456c4ec-f998-4e45-8ac4-1ce984fabe2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:915ef97c-c54c-4903-9221-106534ad841f', 3, 'III', 'Tempo di menuetto', 'III. Tempo di menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린 소나타 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:915ef97c-c54c-4903-9221-106534ad841f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9299d9a2-7a63-4078-964c-e71fc8286e57', 4, 'IV', '론도. Presto', 'IV. Rondo. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린 소나타 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9299d9a2-7a63-4078-964c-e71fc8286e57'
);


-- JS 178 바이올린 소나타 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 F장조', 'Violin Sonata in F major', 'album', 'JS 178', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56f615f5-1564-48ab-a862-a4b3c0fa8bf8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56f615f5-1564-48ab-a862-a4b3c0fa8bf8'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56f615f5-1564-48ab-a862-a4b3c0fa8bf8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abc93f58-8805-4f4d-bbfd-a0064028cf0c', 1, 'I', 'Allegro', 'I. [Allegro]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abc93f58-8805-4f4d-bbfd-a0064028cf0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c94d8951-1c49-4f57-a0b1-98d2b5756ff7', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c94d8951-1c49-4f57-a0b1-98d2b5756ff7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bb495d2-8eb6-4a49-ad1a-59ad475339a7', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bb495d2-8eb6-4a49-ad1a-59ad475339a7'
);


-- JS 180 가곡 <Souda, souda, sinisorsa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Souda, souda, sinisorsa>', 'Souda, souda, sinisorsa (Swim, Duck, Swim)', 'song', 'JS 180', NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Souda, souda, sinisorsa>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0593342a-0ad4-317c-8cc5-26585b84f28c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0593342a-0ad4-317c-8cc5-26585b84f28c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '가곡 <Souda, souda, sinisorsa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0593342a-0ad4-317c-8cc5-26585b84f28c'
);


-- JS 181 스파뇰로

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스파뇰로', 'Spagnuolo', 'song', 'JS 181', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스파뇰로'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf226e7c-d7ae-43a9-9e4b-240f90badab5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cf226e7c-d7ae-43a9-9e4b-240f90badab5'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '스파뇰로' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf226e7c-d7ae-43a9-9e4b-240f90badab5'
);


-- JS 182 부수음악 <템페스트>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <템페스트>', 'The Tempest (Stormen), Incidental Music', 'song', 'JS 182', NULL, NULL, 1927, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <템페스트>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7116829c-3d30-4de7-93e8-9a0f9d6e4ad2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7116829c-3d30-4de7-93e8-9a0f9d6e4ad2'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '부수음악 <템페스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7116829c-3d30-4de7-93e8-9a0f9d6e4ad2'
);


-- JS 183 현악 4중주 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 A단조', 'String Quartet in A minor', 'album', 'JS 183', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c87ba913-58b5-413e-af80-39f8e422d907'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c87ba913-58b5-413e-af80-39f8e422d907'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c87ba913-58b5-413e-af80-39f8e422d907'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c16c818-659a-3b53-847e-a291465200c4', 1, 'I', 'Andante – Allegro', 'I. Andante – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c16c818-659a-3b53-847e-a291465200c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abb6d9aa-59b4-39f3-b145-3ea9d5dcf3e9', 2, 'II', 'Adagio ma non tanto', 'II. Adagio ma non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abb6d9aa-59b4-39f3-b145-3ea9d5dcf3e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec24a025-9ee7-356c-a523-2347638d265f', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec24a025-9ee7-356c-a523-2347638d265f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8651f9b5-1c3a-3192-907b-ce60357a6eac', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8651f9b5-1c3a-3192-907b-ce60357a6eac'
);


-- JS 184 현악 4중주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 E♭장조', 'String Quartet in E♭ major', 'album', 'JS 184', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75e29bb4-10de-44fd-ae3b-9f92c625075b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '75e29bb4-10de-44fd-ae3b-9f92c625075b'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75e29bb4-10de-44fd-ae3b-9f92c625075b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67c15783-3cdb-4984-adca-a995b8380396', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67c15783-3cdb-4984-adca-a995b8380396'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fc42c1a-bee3-455c-ad16-39566dda3ce3', 2, 'II', 'Andante molto', 'II. Andante molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fc42c1a-bee3-455c-ad16-39566dda3ce3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51e9839f-1921-4695-b5db-663e44f9748e', 3, 'III', '스케르초. Allegretto', 'III. Scherzo. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51e9839f-1921-4695-b5db-663e44f9748e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17b2a362-c9af-4082-a9db-5df161c4e381', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '현악 4중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17b2a362-c9af-4082-a9db-5df161c4e381'
);


-- JS 185 바이올린과 현악 합주를 위한 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 현악 합주를 위한 모음곡', 'Suite for Violin and String Orchestra', 'album', 'JS 185', NULL, NULL, 1929, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 현악 합주를 위한 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27bca9c5-495c-4148-ab7e-a89a71d298ad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '27bca9c5-495c-4148-ab7e-a89a71d298ad'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 현악 합주를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27bca9c5-495c-4148-ab7e-a89a71d298ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b311eb0-71f7-44f0-8b49-1431576531c2', 1, 'I', '전원 풍경 (Country Scenery)', 'I. Country Scenery', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 현악 합주를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b311eb0-71f7-44f0-8b49-1431576531c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:402c8b4d-a9be-4c33-9d45-c9ff8b04c870', 2, 'II', '세레나데: 봄 저녁 (Serenade: Evening in Spring)', 'II. Serenade: Evening in Spring', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 현악 합주를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:402c8b4d-a9be-4c33-9d45-c9ff8b04c870'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4152bad-1c25-4f69-b859-3a3dce87580c', 3, 'III', '여름에 (In the Summer)', 'III. In the Summer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '바이올린과 현악 합주를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4152bad-1c25-4f69-b859-3a3dce87580c'
);


-- JS 187 모음곡 D단조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 D단조 (바이올린과 피아노)', 'Suite in D minor for violin and piano', 'album', 'JS 187', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 D단조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c039d2a4-83fe-4d45-aa45-7c96d6059beb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c039d2a4-83fe-4d45-aa45-7c96d6059beb'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모음곡 D단조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c039d2a4-83fe-4d45-aa45-7c96d6059beb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72eb7a7b-eb7c-4e3f-a0de-58d52ca38dea', 1, 'I', 'Un poco adagio – Andante', 'I. Un poco adagio – Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모음곡 D단조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72eb7a7b-eb7c-4e3f-a0de-58d52ca38dea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc2b9d1e-70d5-49dd-aac8-8d12ab50ab86', 2, 'II', 'Vivace', 'II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모음곡 D단조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc2b9d1e-70d5-49dd-aac8-8d12ab50ab86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18224271-5b01-45f2-8097-2a2fe41afeb5', 3, 'III', 'Andantino', 'III. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모음곡 D단조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18224271-5b01-45f2-8097-2a2fe41afeb5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:901a6a59-a4d7-4612-837a-666a0408925d', 4, 'IV', 'Vivacissimo', 'IV. Vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모음곡 D단조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:901a6a59-a4d7-4612-837a-666a0408925d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32b80f5c-9d96-4fea-b6d7-13faa0b2295e', 5, 'V', 'Moderato', 'V. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모음곡 D단조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32b80f5c-9d96-4fea-b6d7-13faa0b2295e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fbffae7-a3b6-4c4b-89ff-e7793043080b', 6, 'VI', 'Quasi presto', 'VI. Quasi presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모음곡 D단조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fbffae7-a3b6-4c4b-89ff-e7793043080b'
);


-- JS 188 모음곡 E장조 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 E장조 (바이올린과 피아노)', 'Suite in E major for violin and piano', 'album', 'JS 188', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 E장조 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2969045a-0bb9-4fae-8145-fd75d140bc92'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2969045a-0bb9-4fae-8145-fd75d140bc92'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모음곡 E장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2969045a-0bb9-4fae-8145-fd75d140bc92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f3c92ac-80d1-4cc8-8686-59c5318fd617', 1, 'I', 'Allegro molto moderato – Quasi adagio', 'I. Allegro molto moderato – Quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모음곡 E장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f3c92ac-80d1-4cc8-8686-59c5318fd617'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ba8f134-5274-4d7f-a293-fa246ecf7cc7', 2, 'II', 'Allegro molto', 'II. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모음곡 E장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ba8f134-5274-4d7f-a293-fa246ecf7cc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2f2ba17-1856-4868-8cfa-bbbca1a9be80', 3, 'III', 'Più lento quasi andantino', 'III. Più lento quasi andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모음곡 E장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2f2ba17-1856-4868-8cfa-bbbca1a9be80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:899a848f-57c6-4f8b-849a-f034b36a941a', 4, 'IV', 'Allegro brillante', 'IV. Allegro brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '모음곡 E장조 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:899a848f-57c6-4f8b-849a-f034b36a941a'
);


-- JS 189 부수음악 <백조 공주>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <백조 공주>', 'Svanevit (Swanwhite), Incidental Music', 'song', 'JS 189', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <백조 공주>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82189e96-acca-4af3-b4ab-45dc2f31ddf0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82189e96-acca-4af3-b4ab-45dc2f31ddf0'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '부수음악 <백조 공주>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82189e96-acca-4af3-b4ab-45dc2f31ddf0'
);


-- JS 191 합창곡 <Tanke, se hur fågeln svingar>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Tanke, se hur fågeln svingar>', 'Tanke, se hur fågeln svingar', 'song', 'JS 191', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Tanke, se hur fågeln svingar>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f4516a55-eb16-4dbc-a437-aec0bcbaccfd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f4516a55-eb16-4dbc-a437-aec0bcbaccfd'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Tanke, se hur fågeln svingar>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f4516a55-eb16-4dbc-a437-aec0bcbaccfd'
);


-- JS 192 2중창 <Tanken>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Tanken>', 'Tanken (The Thought)', 'song', 'JS 192', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Tanken>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52b00c98-f079-30d0-8de2-f1f771739005'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52b00c98-f079-30d0-8de2-f1f771739005'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '2중창 <Tanken>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52b00c98-f079-30d0-8de2-f1f771739005'
);


-- JS 194 템포 디 발스 F#단조 "룰루 왈츠" (첼로와 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '템포 디 발스 F#단조 "룰루 왈츠" (첼로와 피아노)', 'Tempo di valse in F# minor "Lulu Waltz" for cello and piano', 'song', 'JS 194', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '템포 디 발스 F#단조 "룰루 왈츠" (첼로와 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38043812-b123-4ee7-924e-3bb6d7dc2f06'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38043812-b123-4ee7-924e-3bb6d7dc2f06'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '템포 디 발스 F#단조 "룰루 왈츠" (첼로와 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38043812-b123-4ee7-924e-3bb6d7dc2f06'
);


-- JS 196 주제와 변주 D단조 (첼로 독주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '주제와 변주 D단조 (첼로 독주)', '[Theme and Variations] in D minor for solo cello', 'song', 'JS 196', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '주제와 변주 D단조 (첼로 독주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dbb8369-33a4-45cf-b156-17d5b4becff4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2dbb8369-33a4-45cf-b156-17d5b4becff4'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '주제와 변주 D단조 (첼로 독주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dbb8369-33a4-45cf-b156-17d5b4becff4'
);


-- JS 197 주제와 변주 G단조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '주제와 변주 G단조 (현악 4중주)', 'Theme and Variations in G minor for string quartet', 'song', 'JS 197', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '주제와 변주 G단조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd28beec-3818-4b5d-9b93-746500f95cdc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bd28beec-3818-4b5d-9b93-746500f95cdc'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '주제와 변주 G단조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd28beec-3818-4b5d-9b93-746500f95cdc'
);


-- JS 199 미국 학교를 위한 3개의 노래 JS 199

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미국 학교를 위한 3개의 노래 JS 199', '3 Songs for American Schools, JS 199', 'album', NULL, 'JS', '199', 1913, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미국 학교를 위한 3개의 노래 JS 199'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:129c5fcc-8018-4449-b796-1b20947ba030', 1, NULL, 'Autumn Song', 'No. 1 Autumn Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '미국 학교를 위한 3개의 노래 JS 199' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:129c5fcc-8018-4449-b796-1b20947ba030'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbe9110d-b505-45d8-a55b-11477d93e981', 2, NULL, 'The Sun upon the Lake is Low', 'No. 2 The Sun upon the Lake is Low', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '미국 학교를 위한 3개의 노래 JS 199' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbe9110d-b505-45d8-a55b-11477d93e981'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cc2a2aa-9047-4f22-a70b-71baa2122031', 3, NULL, 'A Cavalry Catch', 'No. 3 A Cavalry Catch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '미국 학교를 위한 3개의 노래 JS 199' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cc2a2aa-9047-4f22-a70b-71baa2122031'
);


-- JS 200 <티에라> (금관 7중주와 타악기)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<티에라> (금관 7중주와 타악기)', 'Tiera for brass septet and percussion', 'song', 'JS 200', NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<티에라> (금관 7중주와 타악기)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd762570-beb3-4ce4-9cfa-91cc1e02603b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd762570-beb3-4ce4-9cfa-91cc1e02603b'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<티에라> (금관 7중주와 타악기)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd762570-beb3-4ce4-9cfa-91cc1e02603b'
);


-- JS 201 안단티노 "O. 파르비아이넨에게"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 "O. 파르비아이넨에게"', 'Andantino "Till O. Parviainen"', 'song', 'JS 201', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 "O. 파르비아이넨에게"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e510b05-3b22-4503-bcd3-5b435fbb4c36'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e510b05-3b22-4503-bcd3-5b435fbb4c36'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '안단티노 "O. 파르비아이넨에게"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e510b05-3b22-4503-bcd3-5b435fbb4c36'
);


-- JS 202 피아노곡 <Till trånaden>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡 <Till trånaden>', 'Till trånaden (To Longing)', 'song', 'JS 202', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡 <Till trånaden>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52ec5be8-51f8-43b4-a2e3-d479efb2e468'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52ec5be8-51f8-43b4-a2e3-d479efb2e468'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노곡 <Till trånaden>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52ec5be8-51f8-43b4-a2e3-d479efb2e468'
);


-- JS 203 멜로드라마 <Trånaden>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <Trånaden>', 'Trånaden (To Longing)', 'album', 'JS 203', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <Trånaden>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dffdb1db-ae8d-4097-aee3-e9e7afe8a640'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dffdb1db-ae8d-4097-aee3-e9e7afe8a640'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '멜로드라마 <Trånaden>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dffdb1db-ae8d-4097-aee3-e9e7afe8a640'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:sibelius:sibelius-js-203:1', 1, 'I', 'Tvenne lagar styra menniskolifvet ...', 'I. Tvenne lagar styra menniskolifvet ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '멜로드라마 <Trånaden>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:sibelius:sibelius-js-203:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:sibelius:sibelius-js-203:2', 2, 'II', 'Ser du hafvet?', 'II. Ser du hafvet?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '멜로드라마 <Trånaden>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:sibelius:sibelius-js-203:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:sibelius:sibelius-js-203:3', 3, 'III', 'Hör du vinden?', 'III. Hör du vinden?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '멜로드라마 <Trånaden>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:sibelius:sibelius-js-203:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:sibelius:sibelius-js-203:4', 4, 'IV', 'Hvad är vären?', 'IV. Hvad är vären?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '멜로드라마 <Trånaden>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:sibelius:sibelius-js-203:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:sibelius:sibelius-js-203:5', 5, 'V', 'Menska, vill du lifvets vishet lära ...', 'V. Menska, vill du lifvets vishet lära ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '멜로드라마 <Trånaden>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:sibelius:sibelius-js-203:5'
);


-- JS 205 3중주 G장조 (피아노와 바이올린 2대)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3중주 G장조 (피아노와 바이올린 2대)', 'Trio in G major for two violins and piano', 'album', 'JS 205', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3중주 G장조 (피아노와 바이올린 2대)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5df40ca-9aa1-4849-a944-1b998a83de36'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5df40ca-9aa1-4849-a944-1b998a83de36'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3중주 G장조 (피아노와 바이올린 2대)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5df40ca-9aa1-4849-a944-1b998a83de36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e74e4d7-5889-40a5-838f-80199bea7bd1', 1, 'I', 'Andante – Allegro', 'I. Andante – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3중주 G장조 (피아노와 바이올린 2대)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e74e4d7-5889-40a5-838f-80199bea7bd1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:899b1f2b-7e7c-401a-a2d5-ccb1a0ce231e', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3중주 G장조 (피아노와 바이올린 2대)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:899b1f2b-7e7c-401a-a2d5-ccb1a0ce231e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0f71837-4607-4d4e-ad05-3c44d308113c', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '3중주 G장조 (피아노와 바이올린 2대)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0f71837-4607-4d4e-ad05-3c44d308113c'
);


-- JS 206 피아노 3중주 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 A단조', 'Piano Trio in A minor', 'album', 'JS 206', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb54ed30-57fa-4af0-a0b0-aab2be521348'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb54ed30-57fa-4af0-a0b0-aab2be521348'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb54ed30-57fa-4af0-a0b0-aab2be521348'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8eb0dd51-0796-449e-9fe8-c1b307384c96', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8eb0dd51-0796-449e-9fe8-c1b307384c96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93f780d6-0b9c-4f60-a444-2f56f1814cbd', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93f780d6-0b9c-4f60-a444-2f56f1814cbd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df47085a-c4b7-47d1-8bae-a59298c64b3f', 3, 'III', '미뉴에트', 'III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df47085a-c4b7-47d1-8bae-a59298c64b3f'
);


-- JS 207 피아노 3중주 A단조 "하프트레스크"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 A단조 "하프트레스크"', 'Piano Trio in A minor "Hafträsk"', 'album', 'JS 207', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 A단조 "하프트레스크"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45e06432-deaa-4f04-b58c-5006d821058c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '45e06432-deaa-4f04-b58c-5006d821058c'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 A단조 "하프트레스크"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45e06432-deaa-4f04-b58c-5006d821058c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19f7b9ee-201f-4111-ae09-c222b349a2a5', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 A단조 "하프트레스크"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19f7b9ee-201f-4111-ae09-c222b349a2a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2aaff74-613c-4e69-aa8b-c318ac055e3d', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 A단조 "하프트레스크"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2aaff74-613c-4e69-aa8b-c318ac055e3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46637589-dc0d-434f-8593-ebd38f6b1c89', 3, 'III', '스케르초. Vivace', 'III. Scherzo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 A단조 "하프트레스크"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46637589-dc0d-434f-8593-ebd38f6b1c89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1e5a02e-d288-4ac5-b7aa-e046330e3918', 4, 'IV', '론도', 'IV. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 A단조 "하프트레스크"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1e5a02e-d288-4ac5-b7aa-e046330e3918'
);


-- JS 208 피아노 3중주 C장조 "로비사"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 C장조 "로비사"', 'Piano Trio in C major "Lovisa"', 'album', 'JS 208', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 C장조 "로비사"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1811fe03-f084-48f8-9c7d-f2f7ea5ba7b5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1811fe03-f084-48f8-9c7d-f2f7ea5ba7b5'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 C장조 "로비사"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1811fe03-f084-48f8-9c7d-f2f7ea5ba7b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38898f54-7a58-4a1e-b07e-c417d5cfb0b7', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 C장조 "로비사"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38898f54-7a58-4a1e-b07e-c417d5cfb0b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6e5ebb2-7439-4b49-9147-6d8106b52f54', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 C장조 "로비사"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6e5ebb2-7439-4b49-9147-6d8106b52f54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5644098-caef-4766-a480-9adbdeaa4fcf', 3, 'III', 'Lento – Allegro con brio', 'III. Lento – Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 C장조 "로비사"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5644098-caef-4766-a480-9adbdeaa4fcf'
);


-- JS 209 피아노 3중주 D장조 "코르포"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 D장조 "코르포"', 'Piano Trio in D major "Korpo"', 'album', 'JS 209', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 D장조 "코르포"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ea3a128-4436-4f2e-8a2d-64002a3910f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9ea3a128-4436-4f2e-8a2d-64002a3910f9'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 D장조 "코르포"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ea3a128-4436-4f2e-8a2d-64002a3910f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4acf789-31a0-3133-878e-ec0962f5ff58', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 D장조 "코르포"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4acf789-31a0-3133-878e-ec0962f5ff58'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1582874-cb3c-3a92-beea-61fa7ae332d0', 2, 'II', '환상곡. Andante – Andantino', 'II. Fantasia. Andante – Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 D장조 "코르포"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1582874-cb3c-3a92-beea-61fa7ae332d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9451c058-0737-328a-b527-b29161899585', 3, 'III', '피날레. Vivace', 'III. Finale. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '피아노 3중주 D장조 "코르포"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9451c058-0737-328a-b527-b29161899585'
);


-- JS 212 합창곡 <Työkansan marssi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Työkansan marssi>', 'Työkansan marssi (Workers'' March)', 'song', 'JS 212', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Työkansan marssi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54aeecbf-b132-4e08-a9da-0d2c516fcd96'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '54aeecbf-b132-4e08-a9da-0d2c516fcd96'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Työkansan marssi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54aeecbf-b132-4e08-a9da-0d2c516fcd96'
);


-- JS 213 합창곡 <Upp genom luften>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Upp genom luften>', 'Upp genom luften', 'song', 'JS 213', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Upp genom luften>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '074d090f-7907-4f86-814e-cc3a89a7c8ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '074d090f-7907-4f86-814e-cc3a89a7c8ea'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Upp genom luften>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '074d090f-7907-4f86-814e-cc3a89a7c8ea'
);


-- JS 214a 합창곡 <Uusmaalaisten laulu>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Uusmaalaisten laulu>', 'Uusmaalaisten laulu (Song of the People of Uusimaa)', 'song', 'JS 214a', NULL, NULL, 1912, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Uusmaalaisten laulu>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf692610-9d48-4714-8096-623446562dc7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bf692610-9d48-4714-8096-623446562dc7'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Uusmaalaisten laulu>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf692610-9d48-4714-8096-623446562dc7'
);


-- JS 216 <물방울> (바이올린과 첼로)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<물방울> (바이올린과 첼로)', 'Vattendroppar (Water Droplets) for violin and cello', 'song', 'JS 216', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<물방울> (바이올린과 첼로)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35ec605f-53e8-4301-a125-774b48880b61'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '35ec605f-53e8-4301-a125-774b48880b61'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '<물방울> (바이올린과 첼로)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35ec605f-53e8-4301-a125-774b48880b61'
);


-- JS 217 합창곡 <Veljeni vierailla mailla>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Veljeni vierailla mailla>', 'Veljeni vierailla mailla (My Brothers Abroad)', 'song', 'JS 217', NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Veljeni vierailla mailla>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a86ada8c-e893-4afb-ab27-b4a8406e1d7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a86ada8c-e893-4afb-ab27-b4a8406e1d7d'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Veljeni vierailla mailla>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a86ada8c-e893-4afb-ab27-b4a8406e1d7d'
);


-- JS 218 합창곡 <Vi kysser du fader min fästmö här?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Vi kysser du fader min fästmö här?>', 'Vi kysser du fader min fästmö här?', 'song', 'JS 218', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Vi kysser du fader min fästmö här?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '204a175a-4a3a-4bf2-9e7c-0b2df7289f68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '204a175a-4a3a-4bf2-9e7c-0b2df7289f68'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Vi kysser du fader min fästmö här?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '204a175a-4a3a-4bf2-9e7c-0b2df7289f68'
);


-- JS 219 합창곡 <Viipurin Laulu-Veikkojen kunniamarssi> (1920)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Viipurin Laulu-Veikkojen kunniamarssi> (1920)', 'Viipurin Laulu-Veikkojen kunniamarssi [Version I]', 'song', 'JS 219', NULL, NULL, 1920, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Viipurin Laulu-Veikkojen kunniamarssi> (1920)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e12fe99a-058f-452d-90b3-5ff347057f57'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e12fe99a-058f-452d-90b3-5ff347057f57'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Viipurin Laulu-Veikkojen kunniamarssi> (1920)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e12fe99a-058f-452d-90b3-5ff347057f57'
);


-- JS 220 합창곡 <Viipurin Laulu-Veikkojen kunniamarssi> (1929)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Viipurin Laulu-Veikkojen kunniamarssi> (1929)', 'Viipurin Laulu-Veikkojen kunniamarssi [Version II]', 'song', 'JS 220', NULL, NULL, 1929, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Viipurin Laulu-Veikkojen kunniamarssi> (1929)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc33588f-6ea3-43f1-938d-bbf5f605353f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc33588f-6ea3-43f1-938d-bbf5f605353f'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '합창곡 <Viipurin Laulu-Veikkojen kunniamarssi> (1929)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc33588f-6ea3-43f1-938d-bbf5f605353f'
);


-- JS 221 비바체 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비바체 D단조', 'Vivace in D minor', 'song', 'JS 221', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비바체 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22f80c5d-4aaa-44fd-aa48-d6bf247fc356'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '22f80c5d-4aaa-44fd-aa48-d6bf247fc356'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '비바체 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22f80c5d-4aaa-44fd-aa48-d6bf247fc356'
);


-- JS 222 자장가 (칸텔레와 바이올린)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '자장가 (칸텔레와 바이올린)', 'Kehtolaulu (Lullaby) for violin and kantele', 'song', 'JS 222', NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '자장가 (칸텔레와 바이올린)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1d4ae522-98bc-4b3e-bc7c-1a26936e3057'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1d4ae522-98bc-4b3e-bc7c-1a26936e3057'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '자장가 (칸텔레와 바이올린)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1d4ae522-98bc-4b3e-bc7c-1a26936e3057'
);


-- JS 224 쉬베리손 시에 의한 2개의 남성 합창곡 JS 224

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '쉬베리손 시에 의한 2개의 남성 합창곡 JS 224', '2 Schybergson Songs for Male Chorus, JS 224', 'album', NULL, 'JS', '224', 1918, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '쉬베리손 시에 의한 2개의 남성 합창곡 JS 224'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af1987f8-05fb-462c-8db5-e84817dfa9cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'af1987f8-05fb-462c-8db5-e84817dfa9cb'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '쉬베리손 시에 의한 2개의 남성 합창곡 JS 224' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af1987f8-05fb-462c-8db5-e84817dfa9cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88854a03-4a81-45b7-aa5f-53172e531835', 1, NULL, 'Ute hörs stormen', 'No. 1 Ute hörs stormen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '쉬베리손 시에 의한 2개의 남성 합창곡 JS 224' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88854a03-4a81-45b7-aa5f-53172e531835'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5324c030-eb37-4907-bf86-e842d24d5655', 2, NULL, 'Brusande rusar en våg', 'No. 2 Brusande rusar en våg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '쉬베리손 시에 의한 2개의 남성 합창곡 JS 224' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5324c030-eb37-4907-bf86-e842d24d5655'
);


-- JS 225 알레그레토 G단조 (1897)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 G단조 (1897)', 'Allegretto in G minor (1897)', 'song', 'JS 225', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 68
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 G단조 (1897)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52774636-265b-473f-ad79-08d6d33f7d8e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52774636-265b-473f-ad79-08d6d33f7d8e'
FROM pieces p
WHERE p.composer_id = 68 AND p.title = '알레그레토 G단조 (1897)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52774636-265b-473f-ad79-08d6d33f7d8e'
);

