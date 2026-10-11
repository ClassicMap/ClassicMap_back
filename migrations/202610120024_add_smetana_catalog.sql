-- 스메타나 작품을 출판 단위로 채운다(카탈로그: JB). 작품 122개(묶음 24, 다악장 5, 낱곡 93),
-- 새 작품 122개, 기존 작품 0개, part 122개, 그 아래 0개, 기존 낱곡 연결 1개.
--
-- 정한 것
--   JB 1(완성작)·JB 3(습작)을 넣고 JB 2(미완성)·JB 4(카덴차)는 뺀다.
--   247 「<나의 조국> 중 "몰다우"」는 연작 교향시 <나의 조국> 2번 part 로 잇는다. 248 <팔려간 신부> 서곡은 그대로.
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

-- JB 1:87 오페라 <보헤미아의 브란덴부르크인>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <보헤미아의 브란덴부르크인>', 'The Brandenburgers in Bohemia', 'song', 'JB 1:87', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <보헤미아의 브란덴부르크인>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f54c625b-537f-4480-af9c-d28a3e2de6cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f54c625b-537f-4480-af9c-d28a3e2de6cb'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '오페라 <보헤미아의 브란덴부르크인>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f54c625b-537f-4480-af9c-d28a3e2de6cb'
);


-- JB 1:100 오페라 <팔려간 신부>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <팔려간 신부>', 'The Bartered Bride', 'song', 'JB 1:100', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <팔려간 신부>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a156517b-0346-433f-b069-edd3dd1593e0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a156517b-0346-433f-b069-edd3dd1593e0'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '오페라 <팔려간 신부>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a156517b-0346-433f-b069-edd3dd1593e0'
);


-- JB 1:101 오페라 <달리보르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <달리보르>', 'Dalibor', 'song', 'JB 1:101', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <달리보르>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '478ee603-ddc3-460f-8844-0abf98fb3aea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '478ee603-ddc3-460f-8844-0abf98fb3aea'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '오페라 <달리보르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '478ee603-ddc3-460f-8844-0abf98fb3aea'
);


-- JB 1:102 오페라 <리부셰>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <리부셰>', 'Libuše', 'song', 'JB 1:102', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <리부셰>'
);


-- JB 1:108 오페라 <두 과부>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <두 과부>', 'The Two Widows', 'song', 'JB 1:108', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <두 과부>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df635ef5-76f7-47c0-a175-4ca55cae1252'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df635ef5-76f7-47c0-a175-4ca55cae1252'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '오페라 <두 과부>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df635ef5-76f7-47c0-a175-4ca55cae1252'
);


-- JB 1:104 오페라 <입맞춤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <입맞춤>', 'The Kiss', 'song', 'JB 1:104', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <입맞춤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a836ffba-ec86-4ae3-95c5-637b382a21dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a836ffba-ec86-4ae3-95c5-637b382a21dc'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '오페라 <입맞춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a836ffba-ec86-4ae3-95c5-637b382a21dc'
);


-- JB 1:110 오페라 <비밀>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <비밀>', 'The Secret', 'song', 'JB 1:110', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <비밀>'
);


-- JB 1:122 오페라 <악마의 벽>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <악마의 벽>', 'The Devil''s Wall', 'song', 'JB 1:122', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <악마의 벽>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f35bb721-8e98-450b-9447-850d04e50bd5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f35bb721-8e98-450b-9447-850d04e50bd5'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '오페라 <악마의 벽>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f35bb721-8e98-450b-9447-850d04e50bd5'
);


-- JB 1:10 미뉴에트 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 B♭장조', 'Minuet in B♭ major', 'song', 'JB 1:10', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 B♭장조'
);


-- JB 1:11 바야데르 갤럽 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바야데르 갤럽 C장조', 'Bayadere Galop in C major', 'song', 'JB 1:11', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바야데르 갤럽 C장조'
);


-- JB 1:39 축전 서곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '축전 서곡 D장조', 'Festive Overture in D major', 'song', 'JB 1:39', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '축전 서곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbf682f2-05b9-4b23-a5d7-8308d75d4209'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dbf682f2-05b9-4b23-a5d7-8308d75d4209'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '축전 서곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbf682f2-05b9-4b23-a5d7-8308d75d4209'
);


-- JB 1:59 축전 교향곡 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '축전 교향곡 E장조', 'Festive Symphony in E major', 'album', 'JB 1:59', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '축전 교향곡 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b21d512d-88e2-46a0-93cb-39f1e871a393'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b21d512d-88e2-46a0-93cb-39f1e871a393'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '축전 교향곡 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b21d512d-88e2-46a0-93cb-39f1e871a393'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:397363d1-619c-47ca-80ef-96057afb5709', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '축전 교향곡 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:397363d1-619c-47ca-80ef-96057afb5709'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03dc34fa-98a5-47e2-88f2-1df7fd4670b8', 2, 'II', 'Largo maestoso', 'II. Largo maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '축전 교향곡 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03dc34fa-98a5-47e2-88f2-1df7fd4670b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:443e8d69-0b09-4b7b-8641-52e6ba28386b', 3, 'III', '스케르초. Allegro vivo', 'III. Scherzo. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '축전 교향곡 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:443e8d69-0b09-4b7b-8641-52e6ba28386b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6106970a-4d23-486d-8094-fbf1964d66ce', 4, 'IV', '피날레. Allegro non troppo ma energico', 'IV. Finale. Allegro non troppo ma energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '축전 교향곡 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6106970a-4d23-486d-8094-fbf1964d66ce'
);


-- JB 1:70 교향시 <리처드 3세>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <리처드 3세>', 'Richard III', 'song', 'JB 1:70', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <리처드 3세>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55c9127d-9dba-48a4-ab5c-9271a3bf6914'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '55c9127d-9dba-48a4-ab5c-9271a3bf6914'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '교향시 <리처드 3세>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55c9127d-9dba-48a4-ab5c-9271a3bf6914'
);


-- JB 1:72 교향시 <발렌슈타인의 진영>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <발렌슈타인의 진영>', 'Wallenstein''s Camp', 'song', 'JB 1:72', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <발렌슈타인의 진영>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5ae962d-b79c-4923-9d70-e69b0fb8eed8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c5ae962d-b79c-4923-9d70-e69b0fb8eed8'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '교향시 <발렌슈타인의 진영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5ae962d-b79c-4923-9d70-e69b0fb8eed8'
);


-- JB 1:79 교향시 <하콘 야를>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <하콘 야를>', 'Hakon Jarl', 'song', 'JB 1:79', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <하콘 야를>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8199fc02-0bd8-4eed-8e61-51db06292ce2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8199fc02-0bd8-4eed-8e61-51db06292ce2'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '교향시 <하콘 야를>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8199fc02-0bd8-4eed-8e61-51db06292ce2'
);


-- JB 1:85 인형극 <파우스트 박사> 서곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '인형극 <파우스트 박사> 서곡', 'Doctor Faust, Prelude to a Puppet Play', 'song', 'JB 1:85', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '인형극 <파우스트 박사> 서곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a58e9901-41c1-4502-9f54-82825b96c13c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a58e9901-41c1-4502-9f54-82825b96c13c'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '인형극 <파우스트 박사> 서곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a58e9901-41c1-4502-9f54-82825b96c13c'
);


-- JB 1:86 폴카 D장조 "우리 아가씨들에게"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 D장조 "우리 아가씨들에게"', 'Polka in D major "To Our Girls"', 'song', 'JB 1:86', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 D장조 "우리 아가씨들에게"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b75b61b-aba9-47b0-80c9-b9709c8ca9ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4b75b61b-aba9-47b0-80c9-b9709c8ca9ef'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '폴카 D장조 "우리 아가씨들에게"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b75b61b-aba9-47b0-80c9-b9709c8ca9ef'
);


-- JB 1:88 인형극 <올드르지흐와 보제나> 서곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '인형극 <올드르지흐와 보제나> 서곡', 'Oldřich and Božena, Prelude to a Puppet Play', 'song', 'JB 1:88', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '인형극 <올드르지흐와 보제나> 서곡'
);


-- JB 1:90 셰익스피어 축제를 위한 장엄 행진곡 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '셰익스피어 축제를 위한 장엄 행진곡 E장조', 'Solemn March for the Shakespeare Celebrations in E major', 'song', 'JB 1:90', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '셰익스피어 축제를 위한 장엄 행진곡 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1b0ce83-198c-4aeb-9bce-3ca550f763dd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e1b0ce83-198c-4aeb-9bce-3ca550f763dd'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '셰익스피어 축제를 위한 장엄 행진곡 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1b0ce83-198c-4aeb-9bce-3ca550f763dd'
);


-- JB 1:92 <리처드 3세>를 위한 팡파르

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<리처드 3세>를 위한 팡파르', 'Fanfares for Shakespeare''s Richard III', 'song', 'JB 1:92', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<리처드 3세>를 위한 팡파르'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '946c9df1-409a-4275-881a-0cee124e2aab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '946c9df1-409a-4275-881a-0cee124e2aab'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '<리처드 3세>를 위한 팡파르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '946c9df1-409a-4275-881a-0cee124e2aab'
);


-- JB 1:95 국민극장 정초식을 위한 장엄 전주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '국민극장 정초식을 위한 장엄 전주곡 C장조', 'Solemn Prelude for the Laying of the Foundation Stone of the National Theatre in C major', 'song', 'JB 1:95', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '국민극장 정초식을 위한 장엄 전주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4789473-4dc5-4253-b1bd-87a82ca0acb4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4789473-4dc5-4253-b1bd-87a82ca0acb4'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '국민극장 정초식을 위한 장엄 전주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4789473-4dc5-4253-b1bd-87a82ca0acb4'
);


-- JB 1:97 활인화 음악 <어부> E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '활인화 음악 <어부> E♭장조', 'The Fisherman in E♭ major', 'song', 'JB 1:97', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '활인화 음악 <어부> E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4abb9111-471a-4a4f-beba-156402c869ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4abb9111-471a-4a4f-beba-156402c869ee'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '활인화 음악 <어부> E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4abb9111-471a-4a4f-beba-156402c869ee'
);


-- JB 1:98 활인화 음악 <리부셰의 심판>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '활인화 음악 <리부셰의 심판>', 'Libuše''s Judgement', 'song', 'JB 1:98', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '활인화 음악 <리부셰의 심판>'
);


-- JB 1:112 연작 교향시 <나의 조국>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연작 교향시 <나의 조국>', 'Má vlast (My Country)', 'album', 'JB 1:112', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연작 교향시 <나의 조국>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be255a2d-85b1-4258-b78c-280e8739df95'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be255a2d-85b1-4258-b78c-280e8739df95'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '연작 교향시 <나의 조국>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be255a2d-85b1-4258-b78c-280e8739df95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:013b1dc2-6f9d-32a3-a6de-943f76cfba60', 1, NULL, '비셰흐라드 (Vyšehrad)', 'Vyšehrad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '연작 교향시 <나의 조국>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:013b1dc2-6f9d-32a3-a6de-943f76cfba60'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 247 AND linked.composer_id = 58), 'musicbrainz:009b2276-f259-3f13-9112-7f1df8e6962a', 2, NULL, '블타바 (Vltava)', 'Vltava (The Moldau)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '연작 교향시 <나의 조국>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:009b2276-f259-3f13-9112-7f1df8e6962a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d54882d-fa67-3c2b-9a77-0008408a30ad', 3, NULL, '샤르카 (Šárka)', 'Šárka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '연작 교향시 <나의 조국>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d54882d-fa67-3c2b-9a77-0008408a30ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8136e383-c7f9-350f-8fce-8043450b4e5b', 4, NULL, '보헤미아의 숲과 들에서 (Z českých luhů a hájů)', 'From Bohemia''s Woods and Fields', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '연작 교향시 <나의 조국>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8136e383-c7f9-350f-8fce-8043450b4e5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ded037f8-7c60-3224-8817-0d72d36032c3', 5, NULL, '타보르 (Tábor)', 'Tábor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '연작 교향시 <나의 조국>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ded037f8-7c60-3224-8817-0d72d36032c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bf2dbd1-d985-38bc-b51a-8fa64ae47f26', 6, NULL, '블라니크 (Blaník)', 'Blaník', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '연작 교향시 <나의 조국>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bf2dbd1-d985-38bc-b51a-8fa64ae47f26'
);


-- JB 1:115 폴카 G장조 "시골 여인"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 G장조 "시골 여인"', 'Polka in G major "The Country Woman"', 'song', 'JB 1:115', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 G장조 "시골 여인"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34fb7d80-5924-4dfa-aa2f-c683e84aca21'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '34fb7d80-5924-4dfa-aa2f-c683e84aca21'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '폴카 G장조 "시골 여인"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34fb7d80-5924-4dfa-aa2f-c683e84aca21'
);


-- JB 1:126 <프라하 카니발> 서주와 폴로네즈

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<프라하 카니발> 서주와 폴로네즈', 'The Prague Carnival, Introduction and Polonaise', 'song', 'JB 1:126', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<프라하 카니발> 서주와 폴로네즈'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c1e6c60-a7cb-4562-b0b8-03681ea97572'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8c1e6c60-a7cb-4562-b0b8-03681ea97572'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '<프라하 카니발> 서주와 폴로네즈' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c1e6c60-a7cb-4562-b0b8-03681ea97572'
);


-- JB 1:12 보헤미아 민요에 의한 환상곡 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '보헤미아 민요에 의한 환상곡 G단조', 'Fantasy on a Bohemian Song "Sil jsem proso" in G minor', 'song', 'JB 1:12', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '보헤미아 민요에 의한 환상곡 G단조'
);


-- JB 1:64 피아노 3중주 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 G단조', 'Piano Trio in G minor', 'album', 'JB 1:64', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc2ab3f4-2f2f-4f3a-9093-5cab27c81ea5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cc2ab3f4-2f2f-4f3a-9093-5cab27c81ea5'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노 3중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc2ab3f4-2f2f-4f3a-9093-5cab27c81ea5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88980cc1-e337-4d32-af6f-6064737b9d7b', 1, 'I', 'Moderato assai', 'I. Moderato assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노 3중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88980cc1-e337-4d32-af6f-6064737b9d7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72752704-510d-4ea7-ab08-1ada0fad94ee', 2, 'II', 'Allegro, ma non agitato', 'II. Allegro, ma non agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노 3중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72752704-510d-4ea7-ab08-1ada0fad94ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c29626d-838a-4efe-b583-af56077492ed', 3, 'III', '피날레. Presto', 'III. Finale. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노 3중주 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c29626d-838a-4efe-b583-af56077492ed'
);


-- JB 1:105 현악 4중주 1번 E단조 "나의 생애에서"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 1번 E단조 "나의 생애에서"', 'String Quartet No. 1 in E minor "From My Life"', 'album', 'JB 1:105', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 1번 E단조 "나의 생애에서"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16f98641-799b-42b4-8d5a-4195a59baf34'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '16f98641-799b-42b4-8d5a-4195a59baf34'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '현악 4중주 1번 E단조 "나의 생애에서"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16f98641-799b-42b4-8d5a-4195a59baf34'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fd4c9e9-8dd6-3eed-905c-9ea1c4f1bef6', 1, 'I', 'Allegro vivo appassionato', 'I. Allegro vivo appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '현악 4중주 1번 E단조 "나의 생애에서"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fd4c9e9-8dd6-3eed-905c-9ea1c4f1bef6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a58e90c-f973-3e94-85d6-3e2ae393c699', 2, 'II', 'Allegro moderato alla polka', 'II. Allegro moderato alla polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '현악 4중주 1번 E단조 "나의 생애에서"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a58e90c-f973-3e94-85d6-3e2ae393c699'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fffd7fc-a642-3278-a0e0-87ec3b89c14a', 3, 'III', 'Largo sostenuto', 'III. Largo sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '현악 4중주 1번 E단조 "나의 생애에서"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fffd7fc-a642-3278-a0e0-87ec3b89c14a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17c64e9f-1e15-34bf-b2b5-fb016c6b0b9a', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '현악 4중주 1번 E단조 "나의 생애에서"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17c64e9f-1e15-34bf-b2b5-fb016c6b0b9a'
);


-- JB 1:118 바이올린과 피아노를 위한 <고향에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 <고향에서>', 'From My Homeland', 'album', 'JB 1:118', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 <고향에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3278ab5f-5588-4915-bc6c-9a0d7e700fee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3278ab5f-5588-4915-bc6c-9a0d7e700fee'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '바이올린과 피아노를 위한 <고향에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3278ab5f-5588-4915-bc6c-9a0d7e700fee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:152a641b-8f8d-3229-a939-88a00bbccd3b', 1, NULL, 'A장조', 'No. 1 in A major (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '바이올린과 피아노를 위한 <고향에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:152a641b-8f8d-3229-a939-88a00bbccd3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a62b089-5fd6-3af6-bceb-a28abd41fcf3', 2, NULL, 'G단조', 'No. 2 in G minor (Andantino – Allegro vivo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '바이올린과 피아노를 위한 <고향에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a62b089-5fd6-3af6-bceb-a28abd41fcf3'
);


-- JB 1:124 현악 4중주 2번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 2번 D단조', 'String Quartet No. 2 in D minor', 'album', 'JB 1:124', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 2번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0fc14db-6c70-458b-8e9e-ecf92b933383'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0fc14db-6c70-458b-8e9e-ecf92b933383'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '현악 4중주 2번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0fc14db-6c70-458b-8e9e-ecf92b933383'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e78fde57-78a7-370b-8edd-2fd0fd76be03', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '현악 4중주 2번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e78fde57-78a7-370b-8edd-2fd0fd76be03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2972782a-6949-3cbc-891f-489f9543fafc', 2, 'II', 'Allegro moderato', 'II. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '현악 4중주 2번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2972782a-6949-3cbc-891f-489f9543fafc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:274a9b4f-7798-3ab9-9fbb-f59c950dce74', 3, 'III', 'Allegro non più moderato, ma agitato e con fuoco', 'III. Allegro non più moderato, ma agitato e con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '현악 4중주 2번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:274a9b4f-7798-3ab9-9fbb-f59c950dce74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a27e8192-daa3-3053-85df-2f0d63bada13', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '현악 4중주 2번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a27e8192-daa3-3053-85df-2f0d63bada13'
);


-- JB 1:30 6개의 오르간 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 오르간 전주곡', '6 Preludes for Organ', 'album', 'JB 1:30', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 오르간 전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e98b78e8-42dd-43f7-862e-f9e1d88a2524'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e98b78e8-42dd-43f7-862e-f9e1d88a2524'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 오르간 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e98b78e8-42dd-43f7-862e-f9e1d88a2524'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcf2494e-bc0b-4e41-9b93-87802878a96d', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 오르간 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcf2494e-bc0b-4e41-9b93-87802878a96d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7ff4257-bcab-4f85-8a6f-50454e5e2b24', 2, NULL, 'C단조', 'No. 2 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 오르간 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7ff4257-bcab-4f85-8a6f-50454e5e2b24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70e5d965-ce1b-4256-881e-df501bc57cfe', 3, NULL, 'G장조', 'No. 3 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 오르간 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70e5d965-ce1b-4256-881e-df501bc57cfe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9235bfb7-a2ef-4dd6-9cb4-2ef33a0c2c38', 4, NULL, 'G단조', 'No. 4 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 오르간 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9235bfb7-a2ef-4dd6-9cb4-2ef33a0c2c38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37da2819-b70f-40c6-8fd9-0c5a0e4f63ec', 5, NULL, 'D장조', 'No. 5 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 오르간 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37da2819-b70f-40c6-8fd9-0c5a0e4f63ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:763d02cf-6a35-465b-b8ca-f3556d36221d', 6, NULL, 'F장조', 'No. 6 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 오르간 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:763d02cf-6a35-465b-b8ca-f3556d36221d'
);


-- JB 1:1 루이자 폴카 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '루이자 폴카 D장조', 'Louisina Polka in D major', 'song', 'JB 1:1', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '루이자 폴카 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7de9dfc-a0d1-4806-aabd-37adcc1d94ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7de9dfc-a0d1-4806-aabd-37adcc1d94ab'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '루이자 폴카 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7de9dfc-a0d1-4806-aabd-37adcc1d94ab'
);


-- JB 1:2 달리아 폴카 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '달리아 폴카 D장조', 'Jiřinková Polka (Dahlia Polka) in D major', 'song', 'JB 1:2', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '달리아 폴카 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2be7a51-4339-46be-8278-5c5b962296e0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f2be7a51-4339-46be-8278-5c5b962296e0'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '달리아 폴카 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2be7a51-4339-46be-8278-5c5b962296e0'
);


-- JB 1:3 갤럽 디 브라부라 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 디 브라부라 B♭장조', 'Galopp di bravoura in B♭ major', 'song', 'JB 1:3', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 디 브라부라 B♭장조'
);


-- JB 1:4 즉흥곡 E♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '즉흥곡 E♭단조', 'Impromptu in E♭ minor', 'song', 'JB 1:4', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '즉흥곡 E♭단조'
);


-- JB 1:5 즉흥곡 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '즉흥곡 B단조', 'Impromptu in B minor', 'song', 'JB 1:5', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '즉흥곡 B단조'
);


-- JB 1:6 즉흥곡 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '즉흥곡 A♭장조', 'Impromptu in A♭ major', 'song', 'JB 1:6', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '즉흥곡 A♭장조'
);


-- JB 1:7 피아노 4손을 위한 서곡 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 4손을 위한 서곡 C단조', 'Overture in C minor for Piano Four Hands', 'song', 'JB 1:7', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 4손을 위한 서곡 C단조'
);


-- JB 1:8 피아노 4손을 위한 서곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 4손을 위한 서곡 A장조', 'Overture in A major for Piano Four Hands', 'song', 'JB 1:8', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 4손을 위한 서곡 A장조'
);


-- JB 1:9 폴카 C장조 "학창 시절에서"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 C장조 "학창 시절에서"', 'Polka in C major "From Student Life"', 'song', 'JB 1:9', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 C장조 "학창 시절에서"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0e6550f-54f1-492e-aff9-4dd57cf9f52a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0e6550f-54f1-492e-aff9-4dd57cf9f52a'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '폴카 C장조 "학창 시절에서"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0e6550f-54f1-492e-aff9-4dd57cf9f52a'
);


-- JB 1:13 무언의 2중주 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무언의 2중주 E장조', 'Duo without Words in E major', 'song', 'JB 1:13', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무언의 2중주 E장조'
);


-- JB 1:14 카드리유 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 B♭장조', 'Quadrille in B♭ major', 'song', 'JB 1:14', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 B♭장조'
);


-- JB 1:16 카드리유 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 F장조', 'Quadrille in F major', 'song', 'JB 1:16', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 F장조'
);


-- JB 1:15 마주르카 카프리치오 C#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 카프리치오 C#단조', 'Mazurka-Capriccio in C# minor', 'song', 'JB 1:15', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 카프리치오 C#단조'
);


-- JB 1:17 폴카 E♭장조 "플젠의 추억"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 E♭장조 "플젠의 추억"', 'Polka in E♭ major "Souvenir of Pilsen"', 'song', 'JB 1:17', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 E♭장조 "플젠의 추억"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4feb89c-3601-49f0-b0ee-77ddff836132'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4feb89c-3601-49f0-b0ee-77ddff836132'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '폴카 E♭장조 "플젠의 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4feb89c-3601-49f0-b0ee-77ddff836132'
);


-- JB 1:19 피아노곡집 <바가텔과 즉흥곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡집 <바가텔과 즉흥곡>', 'Bagatelles et impromptus', 'album', 'JB 1:19', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡집 <바가텔과 즉흥곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'feaa00b2-4773-4687-b7d2-345b4b1131a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'feaa00b2-4773-4687-b7d2-345b4b1131a7'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <바가텔과 즉흥곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'feaa00b2-4773-4687-b7d2-345b4b1131a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42178806-3417-41f0-a4b1-2d61a9733f71', 1, NULL, 'L''innocence', 'No. 1 L''innocence (Innocence)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <바가텔과 즉흥곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42178806-3417-41f0-a4b1-2d61a9733f71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74b091bb-cf0a-46d6-8b8d-4925378bed05', 2, NULL, 'L''abattement', 'No. 2 L''abattement (Dejection)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <바가텔과 즉흥곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74b091bb-cf0a-46d6-8b8d-4925378bed05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a714302b-7e3c-4899-bf21-8ae8e616b1e7', 3, NULL, 'L''idylle', 'No. 3 L''idylle (Idyll)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <바가텔과 즉흥곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a714302b-7e3c-4899-bf21-8ae8e616b1e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5d294cc-1d52-4f20-9543-d70e3a59cc49', 4, NULL, 'Le désir', 'No. 4 Le désir (Longing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <바가텔과 즉흥곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5d294cc-1d52-4f20-9543-d70e3a59cc49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9faff60b-d479-443d-af7f-cd76ff8d39a9', 5, NULL, 'La joie', 'No. 5 La joie (Happiness)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <바가텔과 즉흥곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9faff60b-d479-443d-af7f-cd76ff8d39a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02270c1f-dfa9-498c-9b25-5123d6a6b623', 6, NULL, 'Le conte', 'No. 6 Le conte (Fairy Tale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <바가텔과 즉흥곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02270c1f-dfa9-498c-9b25-5123d6a6b623'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22b5417b-0cd2-4660-a787-8da8c6346f6a', 7, NULL, 'L''amour', 'No. 7 L''amour (Love)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <바가텔과 즉흥곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22b5417b-0cd2-4660-a787-8da8c6346f6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:862d0184-7634-441a-a7d1-28b8b27264dc', 8, NULL, 'La discorde', 'No. 8 La discorde (Quarrel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <바가텔과 즉흥곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:862d0184-7634-441a-a7d1-28b8b27264dc'
);


-- JB 1:18 5개의 왈츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 왈츠', '5 Waltzes', 'album', 'JB 1:18', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 왈츠'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-18:1', 1, NULL, 'C단조', 'No. 1 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '5개의 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-18:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-18:2', 2, NULL, 'A♭장조', 'No. 2 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '5개의 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-18:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-18:3', 3, NULL, 'E♭장조', 'No. 3 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '5개의 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-18:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-18:4', 4, NULL, 'C단조', 'No. 4 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '5개의 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-18:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-18:5', 5, NULL, 'A♭장조', 'No. 5 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '5개의 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-18:5'
);


-- JB 1:20 앨범의 한 장 B장조 "Kateřině Kolářové"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 B장조 "Kateřině Kolářové"', 'Album Leaf in B major "To Kateřina Kolářová"', 'song', 'JB 1:20', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 B장조 "Kateřině Kolářové"'
);


-- JB 1:25 앨범의 한 장 E장조 "Alžbětě Felicii Thunové"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 E장조 "Alžbětě Felicii Thunové"', 'Album Leaf in E major "To Elizabeth Felicia Thun"', 'song', 'JB 1:25', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 E장조 "Alžbětě Felicii Thunové"'
);


-- JB 1:21 앨범의 한 장 C단조 "Josephini Finkové"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 C단조 "Josephini Finkové"', 'Album Leaf in C minor "To Josephina Fink"', 'song', 'JB 1:21', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 C단조 "Josephini Finkové"'
);


-- JB 1:22 앨범의 한 장 E♭단조 "Janu Kunzovi"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 E♭단조 "Janu Kunzovi"', 'Album Leaf in E♭ minor "To Jean Kunz"', 'song', 'JB 1:22', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 E♭단조 "Janu Kunzovi"'
);


-- JB 1:23 앨범의 한 장 A♭장조 "Václavi Ulwerovi"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 A♭장조 "Václavi Ulwerovi"', 'Album Leaf in A♭ major "To Wenzel Ulwer"', 'song', 'JB 1:23', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 A♭장조 "Václavi Ulwerovi"'
);


-- JB 1:81 앨범의 한 장 C장조 "Marii Prokschové"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 C장조 "Marii Prokschové"', 'Album Leaf in C major "To Marie Proksch"', 'song', 'JB 1:81', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 C장조 "Marii Prokschové"'
);


-- JB 1:24 Pensée fugitive D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Pensée fugitive D단조', 'Pensée fugitive in D minor', 'song', 'JB 1:24', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Pensée fugitive D단조'
);


-- JB 1:26 2대의 피아노 8손을 위한 소품 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2대의 피아노 8손을 위한 소품 G단조', 'Untitled Piece in G minor for Two Pianos Eight Hands', 'song', 'JB 1:26', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2대의 피아노 8손을 위한 소품 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a60dd75-71e8-4be1-a2bb-d796c1a0f1f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a60dd75-71e8-4be1-a2bb-d796c1a0f1f6'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '2대의 피아노 8손을 위한 소품 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a60dd75-71e8-4be1-a2bb-d796c1a0f1f6'
);


-- JB 3:24 피아노 소나타 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 G단조', 'Piano Sonata in G minor', 'album', 'JB 3:24', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '485d2d8c-90e5-4ca2-af90-198a153056d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '485d2d8c-90e5-4ca2-af90-198a153056d5'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '485d2d8c-90e5-4ca2-af90-198a153056d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb159e67-bf73-41da-8323-f53ae7ad75a7', 1, 'I', 'Sostenuto – Allegro', 'I. Sostenuto – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb159e67-bf73-41da-8323-f53ae7ad75a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22ac2aac-535b-4991-8666-2b72c6348727', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22ac2aac-535b-4991-8666-2b72c6348727'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a84c241-8291-4b72-a76b-8754e0225ecc', 3, 'III', '스케르초. Vivace', 'III. Scherzo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a84c241-8291-4b72-a76b-8754e0225ecc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9005d4d9-5b93-4925-97d2-7310734200d8', 4, 'IV', '피날레. Molto vivace', 'IV. Finale. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9005d4d9-5b93-4925-97d2-7310734200d8'
);


-- JB 1:28 폴카 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 E♭장조', 'Polka in E♭ major', 'song', 'JB 1:28', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80308eb4-3777-4a89-b036-e19c612787ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '80308eb4-3777-4a89-b036-e19c612787ee'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '폴카 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80308eb4-3777-4a89-b036-e19c612787ee'
);


-- JB 3:18 2개의 연습곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 연습곡', '2 Études', 'album', 'JB 3:18', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 연습곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97d40527-6767-4168-a80a-fc565689ed83', 1, NULL, 'C장조 "전주곡 형식"', 'No. 1 in C major (Étude in Prelude Form)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '2개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97d40527-6767-4168-a80a-fc565689ed83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f8821a2-87d8-4a52-b485-b6b893e9a0a2', 2, NULL, 'A단조 "가곡 형식"', 'No. 2 in A minor (Étude in Song Form)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '2개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f8821a2-87d8-4a52-b485-b6b893e9a0a2'
);


-- JB 1:31 녹턴 F단조 "숲의 느낌과 인상"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 F단조 "숲의 느낌과 인상"', 'Nocturne in F minor "Forest Impressions and Emotions"', 'song', 'JB 1:31', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 F단조 "숲의 느낌과 인상"'
);


-- JB 1:32 알레그로 카프리치오소 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그로 카프리치오소 B단조', 'Allegro capriccioso in B minor', 'song', 'JB 1:32', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그로 카프리치오소 B단조'
);


-- JB 1:33 로망스 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 B♭장조', 'Romance in B♭ major', 'song', 'JB 1:33', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 B♭장조'
);


-- JB 1:34 성격 소품 C♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성격 소품 C♭장조', 'Character Piece in C♭ major', 'song', 'JB 1:34', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성격 소품 C♭장조'
);


-- JB 1:35 6개의 성격 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 성격 소품', '6 Character Pieces, Op. 1', 'album', 'JB 1:35', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 성격 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb2b4e43-32fd-45dd-b471-9283f2c4de25'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb2b4e43-32fd-45dd-b471-9283f2c4de25'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 성격 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb2b4e43-32fd-45dd-b471-9283f2c4de25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57f79b78-3c0b-44bb-ad48-7ff1509ebe22', 1, NULL, 'Im Walde', 'No. 1 Im Walde (In the Forest)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 성격 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57f79b78-3c0b-44bb-ad48-7ff1509ebe22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:200ef2b1-0706-41dc-be5b-ba2a7c7b17a0', 2, NULL, 'Erwachende Leidenschaft', 'No. 2 Erwachende Leidenschaft (Rising Passion)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 성격 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:200ef2b1-0706-41dc-be5b-ba2a7c7b17a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bf2dc47-3491-4760-9e98-f45f4d922d6d', 3, NULL, 'Das Schäfermädchen', 'No. 3 Das Schäfermädchen (The Shepherdess)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 성격 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bf2dc47-3491-4760-9e98-f45f4d922d6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ad18b35-be54-4fe1-9047-f85d57f11c11', 4, NULL, 'Die Sehnsucht', 'No. 4 Die Sehnsucht (Desire)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 성격 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ad18b35-be54-4fe1-9047-f85d57f11c11'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5078efc-727e-4e2e-82d9-59ee290ec63e', 5, NULL, 'Der Krieger', 'No. 5 Der Krieger (The Warrior)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 성격 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5078efc-727e-4e2e-82d9-59ee290ec63e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0fa1fba-6c4c-4241-8e99-cc197e7508fb', 6, NULL, 'Die Verzweiflung', 'No. 6 Die Verzweiflung (Desperation)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '6개의 성격 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0fa1fba-6c4c-4241-8e99-cc197e7508fb'
);


-- JB 1:36 프라하 학생 군단 행진곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '프라하 학생 군단 행진곡 F장조', 'March of the Prague Student Legion in F major', 'song', 'JB 1:36', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '프라하 학생 군단 행진곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce9f9aa0-f1a1-4bd3-b76a-576c30361f83'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ce9f9aa0-f1a1-4bd3-b76a-576c30361f83'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '프라하 학생 군단 행진곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce9f9aa0-f1a1-4bd3-b76a-576c30361f83'
);


-- JB 1:37 국민군 행진곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '국민군 행진곡 D장조', 'National Guard March in D major', 'song', 'JB 1:37', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '국민군 행진곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6571d180-752c-4f89-b77e-372b23d83d39'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6571d180-752c-4f89-b77e-372b23d83d39'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '국민군 행진곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6571d180-752c-4f89-b77e-372b23d83d39'
);


-- JB 1:42 앨범의 한 장 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 G단조', 'Album Leaf in G minor', 'song', 'JB 1:42', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 G단조'
);


-- JB 1:60 3개의 살롱 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 살롱 폴카', '3 Salon Polkas, Op. 7', 'album', 'JB 1:60', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 살롱 폴카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1927ee3-8546-44f0-b353-d7aa64646517'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b1927ee3-8546-44f0-b353-d7aa64646517'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '3개의 살롱 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1927ee3-8546-44f0-b353-d7aa64646517'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dc539b9-ba89-4df6-a1ce-e912edc95ec5', 1, NULL, 'F#장조', 'No. 1 in F# major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '3개의 살롱 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dc539b9-ba89-4df6-a1ce-e912edc95ec5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a32236f-b776-428b-ac99-15422d9795a1', 2, NULL, 'F단조', 'No. 2 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '3개의 살롱 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a32236f-b776-428b-ac99-15422d9795a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70dc3c1b-0e92-468f-9674-aa491ffe6ce0', 3, NULL, 'E장조', 'No. 3 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '3개의 살롱 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70dc3c1b-0e92-468f-9674-aa491ffe6ce0'
);


-- JB 1:66 스케치 1권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케치 1권', 'Sketches I, Op. 4', 'album', 'JB 1:66', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케치 1권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a0a519b-d6a7-43c1-92f1-6905b02a0acd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9a0a519b-d6a7-43c1-92f1-6905b02a0acd'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '스케치 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a0a519b-d6a7-43c1-92f1-6905b02a0acd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccf776de-6cfd-4a78-9655-29d935c329fc', 1, NULL, 'Preludium', 'No. 1 Preludium (Prelude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '스케치 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccf776de-6cfd-4a78-9655-29d935c329fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfbea079-6d87-4006-b92c-735c31c3c24c', 2, NULL, 'Idyla', 'No. 2 Idyla (Idyll)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '스케치 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfbea079-6d87-4006-b92c-735c31c3c24c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da189691-a5d2-494c-b263-0266c7aed764', 3, NULL, 'Vzpomínka', 'No. 3 Vzpomínka (A Memory)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '스케치 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da189691-a5d2-494c-b263-0266c7aed764'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7a56d1f-4758-4a34-a747-dcc34852dae5', 4, NULL, 'Vytrvalá snaha', 'No. 4 Vytrvalá snaha (Perseverance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '스케치 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7a56d1f-4758-4a34-a747-dcc34852dae5'
);


-- JB 1:67 스케치 2권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케치 2권', 'Sketches II, Op. 5', 'album', 'JB 1:67', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케치 2권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f1454b4-d18d-439d-bc6a-167cef777bc1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1f1454b4-d18d-439d-bc6a-167cef777bc1'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '스케치 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f1454b4-d18d-439d-bc6a-167cef777bc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ebaabe2-88c6-4d94-942a-6791ff4b664e', 1, NULL, 'Scherzo-polka', 'No. 1 Scherzo-polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '스케치 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ebaabe2-88c6-4d94-942a-6791ff4b664e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51f4925d-ba58-4c6d-8ba9-fbfef70e1fb3', 2, NULL, 'Zádumčivost', 'No. 2 Zádumčivost (Melancholy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '스케치 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51f4925d-ba58-4c6d-8ba9-fbfef70e1fb3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14a07c51-37dc-4924-bfae-becbe58df6c9', 3, NULL, 'Přívětivá krajina', 'No. 3 Přívětivá krajina (The Pleasant Countryside)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '스케치 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14a07c51-37dc-4924-bfae-becbe58df6c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a16b01a-b650-4f9d-b77f-5d9a4577d5cc', 4, NULL, 'Rhapsodie', 'No. 4 Rhapsodie (Rhapsody)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '스케치 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a16b01a-b650-4f9d-b77f-5d9a4577d5cc'
);


-- JB 1:44 피아노곡집 <결혼식 장면>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡집 <결혼식 장면>', 'Wedding Scenes', 'album', 'JB 1:44', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡집 <결혼식 장면>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff5070ac-212c-4c9d-8767-fea9ab5cb5cc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ff5070ac-212c-4c9d-8767-fea9ab5cb5cc'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <결혼식 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff5070ac-212c-4c9d-8767-fea9ab5cb5cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76234e7e-04e7-42bb-8e43-6e147953adc6', 1, NULL, 'Svatební průvod', 'No. 1 Svatební průvod (Wedding March)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <결혼식 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76234e7e-04e7-42bb-8e43-6e147953adc6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bd16ccb-05a1-442d-baaa-f8b7988f0bd4', 2, NULL, 'Ženich a nevěsta', 'No. 2 Ženich a nevěsta (The Bride and Groom)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <결혼식 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bd16ccb-05a1-442d-baaa-f8b7988f0bd4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fd8bf6f-db02-4385-91d8-aa0b25a22ec3', 3, NULL, 'Svatební veselí', 'No. 3 Svatební veselí (Wedding Merriment: Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <결혼식 장면>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fd8bf6f-db02-4385-91d8-aa0b25a22ec3'
);


-- JB 1:45 앨범의 한 장 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 A장조', 'Album Leaf in A major', 'song', 'JB 1:45', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 A장조'
);


-- JB 1:46 앨범의 한 장 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 B♭장조', 'Album Leaf in B♭ major', 'song', 'JB 1:46', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 B♭장조'
);


-- JB 1:47 2대의 피아노 8손을 위한 소나타 악장 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2대의 피아노 8손을 위한 소나타 악장 E단조', 'Sonata Movement in E minor for Two Pianos Eight Hands', 'song', 'JB 1:47', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2대의 피아노 8손을 위한 소나타 악장 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd3e5a81-9b93-420d-9a31-83ef31bb5546'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd3e5a81-9b93-420d-9a31-83ef31bb5546'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '2대의 피아노 8손을 위한 소나타 악장 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd3e5a81-9b93-420d-9a31-83ef31bb5546'
);


-- JB 1:48 피아노곡집 <선율의 보물> 1권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡집 <선율의 보물> 1권', 'A Treasure of Melodies I', 'album', 'JB 1:48', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡집 <선율의 보물> 1권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '216c78bc-e0f5-4017-a048-e362e0cc5d06'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '216c78bc-e0f5-4017-a048-e362e0cc5d06'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <선율의 보물> 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '216c78bc-e0f5-4017-a048-e362e0cc5d06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4007910a-52b1-417c-ae40-b428e91b5ba3', 1, NULL, '전주곡 C장조', 'No. 1 Preludium in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <선율의 보물> 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4007910a-52b1-417c-ae40-b428e91b5ba3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b917ef72-de36-4ce1-8429-3829357a6737', 2, NULL, '카프리치오 A단조', 'No. 2 Capriccio in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <선율의 보물> 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b917ef72-de36-4ce1-8429-3829357a6737'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbb5f5ef-75df-4cf4-adc5-e3428c32e591', 3, NULL, 'G장조', 'No. 3 in G major (Allegro vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <선율의 보물> 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbb5f5ef-75df-4cf4-adc5-e3428c32e591'
);


-- JB 1:49 피아노곡집 <선율의 보물> 2권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡집 <선율의 보물> 2권', 'A Treasure of Melodies II', 'album', 'JB 1:49', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡집 <선율의 보물> 2권'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-49:1', 1, NULL, 'C장조', 'No. 1 in C major (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <선율의 보물> 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-49:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-49:2', 2, NULL, 'G장조', 'No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <선율의 보물> 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-49:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-49:3', 3, NULL, '토카타 D장조', 'No. 3 Toccata in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <선율의 보물> 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-49:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-49:4', 4, NULL, 'A장조', 'No. 4 in A major (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <선율의 보물> 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-49:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-49:5', 5, NULL, '행진곡 E장조', 'No. 5 in E major (Tempo di marcia)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <선율의 보물> 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-49:5'
);


-- JB 1:50 2대의 피아노 8손을 위한 젊은이를 위한 론도 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2대의 피아노 8손을 위한 젊은이를 위한 론도 C장조', 'Rondo for the Young in C major for Two Pianos Eight Hands', 'song', 'JB 1:50', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2대의 피아노 8손을 위한 젊은이를 위한 론도 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9484dc6c-0402-42ae-a31c-b64fc19995a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9484dc6c-0402-42ae-a31c-b64fc19995a6'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '2대의 피아노 8손을 위한 젊은이를 위한 론도 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9484dc6c-0402-42ae-a31c-b64fc19995a6'
);


-- JB 1:51 앨범의 한 장 Op. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 Op. 2', '6 Album Leaves, Op. 2', 'album', 'JB 1:51', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 Op. 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98fadb23-a412-43cd-8531-a6362c62ab99'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '98fadb23-a412-43cd-8531-a6362c62ab99'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '앨범의 한 장 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98fadb23-a412-43cd-8531-a6362c62ab99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-51:1', 1, NULL, 'C장조 "전주곡"', 'No. 1 in C major (Allegro – Prélude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '앨범의 한 장 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-51:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-51:2', 2, NULL, 'A단조 "샹송"', 'No. 2 in A minor (Moderato – Chanson)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '앨범의 한 장 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-51:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dbd9646-2311-429b-92d8-65008bd70fce', 3, NULL, 'G장조', 'No. 3 in G major (Vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '앨범의 한 장 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dbd9646-2311-429b-92d8-65008bd70fce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-51:4', 4, NULL, 'E단조', 'No. 4 in E minor (Allegro comodo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '앨범의 한 장 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-51:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-51:5', 5, NULL, 'D장조', 'No. 5 in D major (Moderato con anima)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '앨범의 한 장 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-51:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb1-51:6', 6, NULL, 'B단조', 'No. 6 in B minor (Andante ma non troppo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '앨범의 한 장 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb1-51:6'
);


-- JB 1:65 앨범의 한 장 Op. 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 Op. 3', '3 Album Leaves, Op. 3', 'album', 'JB 1:65', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 Op. 3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46acb003-dcfc-432d-a50c-d7b526d3b507'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '46acb003-dcfc-432d-a50c-d7b526d3b507'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '앨범의 한 장 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46acb003-dcfc-432d-a50c-d7b526d3b507'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b614d12c-8775-4b81-a1d6-3e32792976a6', 1, NULL, 'An Robert Schumann', 'No. 1 in E major "An Robert Schumann"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '앨범의 한 장 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b614d12c-8775-4b81-a1d6-3e32792976a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1647af8c-ecae-4c8b-af95-be0231bcc8eb', 2, NULL, 'Wanderlied', 'No. 2 in A major "Wanderlied"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '앨범의 한 장 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1647af8c-ecae-4c8b-af95-be0231bcc8eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24d645f6-32a0-4e5b-b83a-1f5e4a46addf', 3, NULL, 'Es siedet und braust', 'No. 3 in F# minor "Es siedet und braust"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '앨범의 한 장 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24d645f6-32a0-4e5b-b83a-1f5e4a46addf'
);


-- JB 1:53 앨범의 한 장 B단조 JB 1:53

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 B단조 JB 1:53', 'Album Leaf in B minor JB 1:53', 'song', NULL, 'JB', '1:53', 1850, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 B단조 JB 1:53'
);


-- JB 1:41 토카티나 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카티나 B♭장조', 'Toccatina in B♭ major', 'song', 'JB 1:41', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카티나 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'daff8ddd-3099-45fb-9d48-9832ce937e24'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'daff8ddd-3099-45fb-9d48-9832ce937e24'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '토카티나 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'daff8ddd-3099-45fb-9d48-9832ce937e24'
);


-- JB 1:43 앨범의 한 장 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 G장조', 'Album Leaf in G major', 'song', 'JB 1:43', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 G장조'
);


-- JB 1:54 앨범의 한 장 B단조 JB 1:54

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 B단조 JB 1:54', 'Album Leaf in B minor JB 1:54', 'song', NULL, 'JB', '1:54', 1850, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 B단조 JB 1:54'
);


-- JB 1:52 앨범의 한 장 E♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 장 E♭단조', 'Album Leaf in E♭ minor', 'song', 'JB 1:52', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 장 E♭단조'
);


-- JB 1:57 폴카 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 E장조', 'Polka in E major', 'song', 'JB 1:57', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9dc8f994-4b95-4b1c-8494-33ea1be29dfb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9dc8f994-4b95-4b1c-8494-33ea1be29dfb'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '폴카 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9dc8f994-4b95-4b1c-8494-33ea1be29dfb'
);


-- JB 1:55 폴카 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 G단조', 'Polka in G minor', 'song', 'JB 1:55', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '976eec94-626b-4d20-8698-5fed828a5e97'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '976eec94-626b-4d20-8698-5fed828a5e97'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '폴카 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '976eec94-626b-4d20-8698-5fed828a5e97'
);


-- JB 1:56 폴카 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 A장조', 'Polka in A major', 'song', 'JB 1:56', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '268ac987-4d72-4c46-89ea-747860522a5f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '268ac987-4d72-4c46-89ea-747860522a5f'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '폴카 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '268ac987-4d72-4c46-89ea-747860522a5f'
);


-- JB 1:63 폴카 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 F단조', 'Polka in F minor', 'song', 'JB 1:63', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcd7b939-46ac-4b2f-b591-bd1702058adc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dcd7b939-46ac-4b2f-b591-bd1702058adc'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '폴카 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcd7b939-46ac-4b2f-b591-bd1702058adc'
);


-- JB 1:61 3개의 시적인 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 시적인 폴카', '3 Poetic Polkas, Op. 8', 'album', 'JB 1:61', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 시적인 폴카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '776a948b-59f1-4fe0-b9e1-48144267d9dd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '776a948b-59f1-4fe0-b9e1-48144267d9dd'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '3개의 시적인 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '776a948b-59f1-4fe0-b9e1-48144267d9dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc7708ba-6a3a-4e2c-916d-7dca3402ee36', 1, NULL, 'E♭장조', 'No. 1 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '3개의 시적인 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc7708ba-6a3a-4e2c-916d-7dca3402ee36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a2c0703-481a-4878-8c35-b7de97156864', 2, NULL, 'G단조', 'No. 2 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '3개의 시적인 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a2c0703-481a-4878-8c35-b7de97156864'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d47e6e43-0ede-436b-9733-f3e8838a755d', 3, NULL, 'A♭장조', 'No. 3 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '3개의 시적인 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d47e6e43-0ede-436b-9733-f3e8838a755d'
);


-- JB 1:62 안단테 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 E♭장조', 'Andante in E♭ major', 'song', 'JB 1:62', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 E♭장조'
);


-- JB 1:71 폴카-랩소디 <무도회의 환상> A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카-랩소디 <무도회의 환상> A단조', 'Ball-Vision (Polka-Rhapsody) in A minor', 'song', 'JB 1:71', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카-랩소디 <무도회의 환상> A단조'
);


-- JB 1:73 연주회용 연습곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연주회용 연습곡 C장조', 'Concert Étude in C major', 'song', 'JB 1:73', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연주회용 연습곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb743c0b-0be5-4ad3-aee8-3eb51037aaa4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb743c0b-0be5-4ad3-aee8-3eb51037aaa4'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '연주회용 연습곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb743c0b-0be5-4ad3-aee8-3eb51037aaa4'
);


-- JB 1:75 피아노곡 <맥베스와 마녀들> G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡 <맥베스와 마녀들> G단조', 'Macbeth and the Witches in G minor', 'song', 'JB 1:75', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡 <맥베스와 마녀들> G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03f8f211-f1a7-43ed-9444-abc9ac29ec3c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '03f8f211-f1a7-43ed-9444-abc9ac29ec3c'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡 <맥베스와 마녀들> G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03f8f211-f1a7-43ed-9444-abc9ac29ec3c'
);


-- JB 1:74 베티나 폴카 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '베티나 폴카 C장조', 'Bettina Polka in C major', 'song', 'JB 1:74', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '베티나 폴카 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22ca8c88-3dd1-46f0-8efa-20d0cd8f8b97'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '22ca8c88-3dd1-46f0-8efa-20d0cd8f8b97'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '베티나 폴카 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22ca8c88-3dd1-46f0-8efa-20d0cd8f8b97'
);


-- JB 1:76 보헤미아의 추억 Op. 12

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '보헤미아의 추억 Op. 12', 'Souvenir de Bohême en forme de polkas, Op. 12', 'album', 'JB 1:76', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '보헤미아의 추억 Op. 12'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97780a03-fb82-463f-b69b-fc300edb8091'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '97780a03-fb82-463f-b69b-fc300edb8091'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '보헤미아의 추억 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97780a03-fb82-463f-b69b-fc300edb8091'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3903fc90-81d9-429a-8808-095a6f3c40c1', 1, NULL, 'A단조', 'No. 1 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '보헤미아의 추억 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3903fc90-81d9-429a-8808-095a6f3c40c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84285112-adea-47f5-be35-6660eb05d8c0', 2, NULL, 'E단조', 'No. 2 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '보헤미아의 추억 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84285112-adea-47f5-be35-6660eb05d8c0'
);


-- JB 1:77 보헤미아의 추억 Op. 13

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '보헤미아의 추억 Op. 13', 'Souvenir de Bohême en forme de polkas, Op. 13', 'album', 'JB 1:77', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '보헤미아의 추억 Op. 13'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '805d9ee8-b23c-40f0-84dd-b8d7e8bcd1a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '805d9ee8-b23c-40f0-84dd-b8d7e8bcd1a6'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '보헤미아의 추억 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '805d9ee8-b23c-40f0-84dd-b8d7e8bcd1a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c77db8ab-fcad-41be-89ce-25fad65f9b83', 1, NULL, 'E단조', 'No. 1 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '보헤미아의 추억 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c77db8ab-fcad-41be-89ce-25fad65f9b83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0232da4c-84c8-4728-918d-7d3418970b1a', 2, NULL, 'E♭장조', 'No. 2 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '보헤미아의 추억 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0232da4c-84c8-4728-918d-7d3418970b1a'
);


-- JB 1:80 연주회용 연습곡 G#단조 "바닷가에서"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연주회용 연습곡 G#단조 "바닷가에서"', 'Concert Étude in G# minor "On the Seashore"', 'song', 'JB 1:80', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연주회용 연습곡 G#단조 "바닷가에서"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47db5403-7c80-4d8c-8c03-cf252c4a0ea0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47db5403-7c80-4d8c-8c03-cf252c4a0ea0'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '연주회용 연습곡 G#단조 "바닷가에서"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47db5403-7c80-4d8c-8c03-cf252c4a0ea0'
);


-- JB 1:83 체코 민요에 의한 연주회용 환상곡 B장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '체코 민요에 의한 연주회용 환상곡 B장조', 'Concert Fantasy on Czech Folksongs in B major', 'song', 'JB 1:83', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '체코 민요에 의한 연주회용 환상곡 B장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6dee8573-8ac0-4bba-8446-d9028eb4c185'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6dee8573-8ac0-4bba-8446-d9028eb4c185'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 민요에 의한 연주회용 환상곡 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6dee8573-8ac0-4bba-8446-d9028eb4c185'
);


-- JB 1:103 피아노곡집 <꿈>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡집 <꿈>', 'Rêves (Dreams)', 'album', 'JB 1:103', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡집 <꿈>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2acdbe29-0be3-4ee1-84d4-41445c9519bb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2acdbe29-0be3-4ee1-84d4-41445c9519bb'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <꿈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2acdbe29-0be3-4ee1-84d4-41445c9519bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46b62eb2-c355-465d-adba-7bcb4b3947b7', 1, NULL, 'Le bonheur éteint', 'No. 1 Le bonheur éteint (Bygone Happiness)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <꿈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46b62eb2-c355-465d-adba-7bcb4b3947b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88f1baad-3da6-47da-955c-7ec2f13451dc', 2, NULL, 'La consolation', 'No. 2 La consolation (Consolation)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <꿈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88f1baad-3da6-47da-955c-7ec2f13451dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86771376-c564-4090-96bb-a21b14dd8a5f', 3, NULL, 'En Bohême', 'No. 3 En Bohême (In Bohemia)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <꿈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86771376-c564-4090-96bb-a21b14dd8a5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f5c40fa-6b1f-4a70-9ca4-9ee1193a98b6', 4, NULL, 'Au salon', 'No. 4 Au salon (In the Salon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <꿈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f5c40fa-6b1f-4a70-9ca4-9ee1193a98b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65d2a51e-478e-47cb-a898-e09fffd1cb63', 5, NULL, 'Près du château', 'No. 5 Près du château (Before the Castle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <꿈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65d2a51e-478e-47cb-a898-e09fffd1cb63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78140e44-56d4-4a6e-a8b6-91dc7636cb71', 6, NULL, 'La fête des paysans bohémiens', 'No. 6 La fête des paysans bohémiens (Czech Peasants'' Festival)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '피아노곡집 <꿈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78140e44-56d4-4a6e-a8b6-91dc7636cb71'
);


-- JB 1:107 체코 무곡 1권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '체코 무곡 1권', 'Czech Dances I', 'album', 'JB 1:107', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '체코 무곡 1권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b15342d-b862-4262-96e9-9c69c52b1203'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b15342d-b862-4262-96e9-9c69c52b1203'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b15342d-b862-4262-96e9-9c69c52b1203'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:558a341b-63bd-4ab8-b95f-0f4ddafa32a7', 1, NULL, '폴카 F#단조', 'No. 1 Polka in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:558a341b-63bd-4ab8-b95f-0f4ddafa32a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f45d7fc3-fbed-45a0-845e-4c671ce2fec2', 2, NULL, '폴카 A단조', 'No. 2 Polka in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f45d7fc3-fbed-45a0-845e-4c671ce2fec2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dc7ca1c-1f6c-4c47-9938-0b99feef31be', 3, NULL, '폴카 F장조', 'No. 3 Polka in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dc7ca1c-1f6c-4c47-9938-0b99feef31be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccb8fb25-8c4b-4f7c-b353-ab932c0efd47', 4, NULL, '폴카 B♭장조', 'No. 4 Polka in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccb8fb25-8c4b-4f7c-b353-ab932c0efd47'
);


-- JB 1:114 체코 무곡 2권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '체코 무곡 2권', 'Czech Dances II', 'album', 'JB 1:114', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '체코 무곡 2권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82a88154-17de-4864-8688-f68509dcc34c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82a88154-17de-4864-8688-f68509dcc34c'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82a88154-17de-4864-8688-f68509dcc34c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7085c1cc-4f15-4940-85c0-0e23ca217fbd', 1, NULL, '푸리안트 A단조', 'No. 1 Furiant in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7085c1cc-4f15-4940-85c0-0e23ca217fbd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16e2bcc6-7b31-49dc-80d9-b65461bcdff7', 2, NULL, '슬레피치카 B♭장조', 'No. 2 Slepička (The Little Hen) in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16e2bcc6-7b31-49dc-80d9-b65461bcdff7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1c9fabb-cc1f-4d77-839e-0184717fff6f', 3, NULL, '오베스 A♭장조', 'No. 3 Oves (Oats) in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1c9fabb-cc1f-4d77-839e-0184717fff6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39b9d8e8-eb40-419e-a1e2-8e1e0a19ce6b', 4, NULL, '메드베드 C장조', 'No. 4 Medvěd (The Bear) in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39b9d8e8-eb40-419e-a1e2-8e1e0a19ce6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4749deab-9210-4661-8665-3a1904a2d708', 5, NULL, '치불리치카 G장조', 'No. 5 Cibulička (The Little Onion) in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4749deab-9210-4661-8665-3a1904a2d708'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f580e693-1fc1-4df3-8e2d-77681b1c6f7c', 6, NULL, '두파크 D장조', 'No. 6 Dupák (Stamping Dance) in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f580e693-1fc1-4df3-8e2d-77681b1c6f7c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ad9a092-de9b-4cef-b1ac-7506a60abe8e', 7, NULL, '훌란 A장조', 'No. 7 Hulán (The Lancer) in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ad9a092-de9b-4cef-b1ac-7506a60abe8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a0ba445-2242-4f86-bbff-1f3904575b8c', 8, NULL, '오브크로차크 E♭장조', 'No. 8 Obkročák (Step Dance) in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a0ba445-2242-4f86-bbff-1f3904575b8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc1998ff-9955-4e3e-a00b-1b17c6a341d5', 9, NULL, '소우세드스카 B장조', 'No. 9 Sousedská (Neighbour''s Dance) in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc1998ff-9955-4e3e-a00b-1b17c6a341d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a98b6e9d-1e73-474e-a082-6151bc29ba6f', 10, NULL, '스코치나 F장조', 'No. 10 Skočná (Leaping Dance) in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '체코 무곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a98b6e9d-1e73-474e-a082-6151bc29ba6f'
);


-- JB 1:117 안단테 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 F단조', 'Andante in F minor', 'song', 'JB 1:117', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 F단조'
);


-- JB 1:121 로망스 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 G단조', 'Romance in G minor', 'song', 'JB 1:121', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e84b7abd-3633-413e-8afb-132e22ee46a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e84b7abd-3633-413e-8afb-132e22ee46a5'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '로망스 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e84b7abd-3633-413e-8afb-132e22ee46a5'
);


-- JB 1:38 남성 합창곡 <Píseň svobody>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <Píseň svobody>', 'Píseň svobody (Song of Liberty)', 'song', 'JB 1:38', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <Píseň svobody>'
);


-- JB 1:78 합창곡 <Píseň česká>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Píseň česká>', 'Píseň česká (Czech Song)', 'song', 'JB 1:78', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Píseň česká>'
);


-- JB 1:84 남성 합창곡 <Tři jezdci>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <Tři jezdci>', 'Tři jezdci (The Three Riders)', 'song', 'JB 1:84', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <Tři jezdci>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7098ea62-33f0-4bf8-aafd-6bf9f95dba84'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7098ea62-33f0-4bf8-aafd-6bf9f95dba84'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '남성 합창곡 <Tři jezdci>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7098ea62-33f0-4bf8-aafd-6bf9f95dba84'
);


-- JB 1:89 남성 합창곡 <Odrodilec>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <Odrodilec>', 'Odrodilec (The Renegade)', 'song', 'JB 1:89', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <Odrodilec>'
);


-- JB 1:94 남성 합창곡 <Rolnická>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <Rolnická>', 'Rolnická (The Peasant)', 'song', 'JB 1:94', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <Rolnická>'
);


-- JB 1:96 합창곡 <Česká píseň>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Česká píseň>', 'Česká píseň (Czech Song)', 'song', 'JB 1:96', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Česká píseň>'
);


-- JB 1:99 남성 합창곡 <Slavnostní sbor>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <Slavnostní sbor>', 'Slavnostní sbor (Festive Chorus)', 'song', 'JB 1:99', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <Slavnostní sbor>'
);


-- JB 1:106 남성 합창곡 <Píseň na moři>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <Píseň na moři>', 'Píseň na moři (The Song of the Sea)', 'song', 'JB 1:106', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <Píseň na moři>'
);


-- JB 1:109 3개의 여성 합창곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 여성 합창곡', '3 Female Choruses', 'album', 'JB 1:109', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 여성 합창곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '574bfff9-b654-4b84-adba-ebb5ad9bb8dd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '574bfff9-b654-4b84-adba-ebb5ad9bb8dd'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '3개의 여성 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '574bfff9-b654-4b84-adba-ebb5ad9bb8dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bca9e6d2-df4e-4dba-a715-f7196682d30a', 1, NULL, 'Má hvězda', 'Má hvězda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '3개의 여성 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bca9e6d2-df4e-4dba-a715-f7196682d30a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a5b7a07-4994-4e8c-95af-e0b7332e0657', 2, NULL, 'Přiletěly vlaštovičky', 'Přiletěly vlaštovičky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '3개의 여성 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a5b7a07-4994-4e8c-95af-e0b7332e0657'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91e49848-e624-4722-ab31-1a9e64533d42', 3, NULL, 'Za hory slunce zapadá', 'Za hory slunce zapadá', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '3개의 여성 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91e49848-e624-4722-ab31-1a9e64533d42'
);


-- JB 1:119 남성 합창곡 <Věno>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <Věno>', 'Věno (The Dower)', 'song', 'JB 1:119', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <Věno>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd79257e5-674c-4f55-ac73-ac08d4f50de3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd79257e5-674c-4f55-ac73-ac08d4f50de3'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '남성 합창곡 <Věno>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd79257e5-674c-4f55-ac73-ac08d4f50de3'
);


-- JB 1:120 남성 합창곡 <Modlitba>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <Modlitba>', 'Modlitba (Prayer)', 'song', 'JB 1:120', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <Modlitba>'
);


-- JB 1:123 남성 합창곡 <Dvě hesla>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <Dvě hesla>', 'Dvě hesla (Two Mottos)', 'song', 'JB 1:123', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <Dvě hesla>'
);


-- JB 1:125 남성 합창곡 <Naše píseň>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <Naše píseň>', 'Naše píseň (Our Song)', 'song', 'JB 1:125', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <Naše píseň>'
);


-- JB 3:25 2개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 가곡', '2 Songs', 'album', 'JB 3:25', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 가곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb3-25:1', 1, NULL, 'Liebchens Blick', 'Liebchens Blick (Pohled mé dívky)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '2개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb3-25:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:smetana:smetana-jb3-25:2', 2, NULL, 'Lebewohl', 'Lebewohl! (Sbohem!)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '2개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:smetana:smetana-jb3-25:2'
);


-- JB 1:27 가곡 <Schmerz der Trennung>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Schmerz der Trennung>', 'Schmerz der Trennung (Bolest odloučení)', 'song', 'JB 1:27', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Schmerz der Trennung>'
);


-- JB 1:29 가곡 <Einladung>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Einladung>', 'Einladung (Vyzvání)', 'song', 'JB 1:29', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Einladung>'
);


-- JB 1:53 가곡 <Liebesfrühling>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Liebesfrühling>', 'Liebesfrühling (Jaro lásky)', 'song', 'JB 1:53', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Liebesfrühling>'
);


-- JB 1:93 가곡 <O Gustave, můj králi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <O Gustave, můj králi>', 'O Gustave, můj králi', 'song', 'JB 1:93', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <O Gustave, můj králi>'
);


-- JB 1:116 가곡집 <저녁 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <저녁 노래>', 'Evening Songs', 'album', 'JB 1:116', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 58
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <저녁 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '109fa1cd-181b-4948-83b6-59fbe01ff960'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '109fa1cd-181b-4948-83b6-59fbe01ff960'
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '109fa1cd-181b-4948-83b6-59fbe01ff960'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f46cdde-ff4a-401f-b287-e3435e4036f4', 1, NULL, 'Kdo v zlaté struny zahrát zná', 'Kdo v zlaté struny zahrát zná', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f46cdde-ff4a-401f-b287-e3435e4036f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49754d25-cafd-4a6c-b8c2-3e9b828a4520', 2, NULL, 'Nekamenujte proroky', 'Nekamenujte proroky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49754d25-cafd-4a6c-b8c2-3e9b828a4520'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c361678d-f779-435a-9cbf-e916cbdc211e', 3, NULL, 'Mně zdálo se', 'Mně zdálo se', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c361678d-f779-435a-9cbf-e916cbdc211e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f28b74bd-1bdd-4aaf-814d-90644674f5ad', 4, NULL, 'Hej, jaká radost v kole', 'Hej, jaká radost v kole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f28b74bd-1bdd-4aaf-814d-90644674f5ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fd3c753-9413-47d2-8c86-e1749627cc9b', 5, NULL, 'Z svých písní trůn Ti udělám', 'Z svých písní trůn Ti udělám', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 58 AND p.title = '가곡집 <저녁 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fd3c753-9413-47d2-8c86-e1749627cc9b'
);

