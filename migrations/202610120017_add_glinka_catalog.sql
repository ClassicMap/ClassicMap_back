-- 글린카 작품을 출판 단위로 채운다(카탈로그: 없음). 작품 149개(묶음 4, 다악장 6, 낱곡 139),
-- 새 작품 148개, 기존 작품 1개, part 42개, 그 아래 0개, 기존 낱곡 연결 1개.
--
-- 정한 것
--   175 가곡 <종달새>는 <페테르부르크와의 이별> 10번 part 로 잇는다. 173 <루슬란과 류드밀라> 서곡은 그대로 둔다.
--   남의 오페라 주제에 의한 변주곡·론도 등은 창작으로 넣고, 성악 연습곡·교본은 뺀다.
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

-- None 오페라 <황제를 위한 삶>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5514eb9-2f4f-4690-9fe6-5d7257671193'
FROM pieces p
WHERE p.id = 174 AND p.composer_id = 38
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5514eb9-2f4f-4690-9fe6-5d7257671193'
);


-- None <몰다비아 처녀와 집시 처녀> 를 위한 합창 딸린 아리아

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<몰다비아 처녀와 집시 처녀> 를 위한 합창 딸린 아리아', 'Aria with Chorus for Bakhturin''s Play "The Moldavian Girl and the Gypsy Girl"', 'song', NULL, NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<몰다비아 처녀와 집시 처녀> 를 위한 합창 딸린 아리아'
);


-- None 오페라 <루슬란과 류드밀라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <루슬란과 류드밀라>', 'Ruslan and Lyudmila', 'song', NULL, NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <루슬란과 류드밀라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1b335d1-fda6-4ede-87f0-3756432827a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd1b335d1-fda6-4ede-87f0-3756432827a7'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '오페라 <루슬란과 류드밀라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1b335d1-fda6-4ede-87f0-3756432827a7'
);


-- None 부수음악 <홀름스키 공작>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <홀름스키 공작>', 'Prince Kholmsky, incidental music', 'song', NULL, NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <홀름스키 공작>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29171b5f-e7f2-4ed6-9d74-89e24e0a2638'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '29171b5f-e7f2-4ed6-9d74-89e24e0a2638'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '부수음악 <홀름스키 공작>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29171b5f-e7f2-4ed6-9d74-89e24e0a2638'
);


-- None 낭송·합창·관현악을 위한 타란텔라

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '낭송·합창·관현악을 위한 타란텔라', 'Tarantella for narrator, chorus and orchestra', 'song', NULL, NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '낭송·합창·관현악을 위한 타란텔라'
);


-- None 서곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 D장조', 'Overture in D major', 'song', NULL, NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc258dc8-e2b2-4007-ada6-5d93d30720bd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc258dc8-e2b2-4007-ada6-5d93d30720bd'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '서곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc258dc8-e2b2-4007-ada6-5d93d30720bd'
);


-- None 서곡 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 G단조', 'Overture in G minor', 'song', NULL, NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81f9fe98-a8e8-41ca-8528-6e4fb393a0ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '81f9fe98-a8e8-41ca-8528-6e4fb393a0ff'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '서곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81f9fe98-a8e8-41ca-8528-6e4fb393a0ff'
);


-- None 안단테 칸타빌레와 론도 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 칸타빌레와 론도 D단조', 'Andante cantabile and Rondo in D minor', 'song', NULL, NULL, NULL, 1823, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 칸타빌레와 론도 D단조'
);


-- None 환상 왈츠 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상 왈츠 B단조', 'Valse-fantaisie in B minor', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상 왈츠 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35c02b7e-038c-4f74-880c-5f7252c9edab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '35c02b7e-038c-4f74-880c-5f7252c9edab'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '환상 왈츠 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35c02b7e-038c-4f74-880c-5f7252c9edab'
);


-- None 스페인 서곡 1번 "아라곤의 호타에 의한 화려한 카프리치오"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스페인 서곡 1번 "아라곤의 호타에 의한 화려한 카프리치오"', 'Spanish Overture No. 1 "Capriccio brillante on the Jota aragonesa"', 'song', NULL, NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스페인 서곡 1번 "아라곤의 호타에 의한 화려한 카프리치오"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45f59c53-b3e9-4cbe-8c3f-a7250ae0404e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '45f59c53-b3e9-4cbe-8c3f-a7250ae0404e'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '스페인 서곡 1번 "아라곤의 호타에 의한 화려한 카프리치오"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45f59c53-b3e9-4cbe-8c3f-a7250ae0404e'
);


-- None 관현악 환상곡 <카마린스카야>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 환상곡 <카마린스카야>', 'Kamarinskaya, Fantasia on Two Russian Themes', 'song', NULL, NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 환상곡 <카마린스카야>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3589565-212a-4faf-af4b-755fac021ddd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e3589565-212a-4faf-af4b-755fac021ddd'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '관현악 환상곡 <카마린스카야>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3589565-212a-4faf-af4b-755fac021ddd'
);


-- None 스페인 서곡 2번 "마드리드의 여름밤 추억"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스페인 서곡 2번 "마드리드의 여름밤 추억"', 'Spanish Overture No. 2 "Souvenir d''une nuit d''été à Madrid"', 'song', NULL, NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스페인 서곡 2번 "마드리드의 여름밤 추억"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dadfaaaf-f60b-422a-bf02-e10b87aa9ea7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dadfaaaf-f60b-422a-bf02-e10b87aa9ea7'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '스페인 서곡 2번 "마드리드의 여름밤 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dadfaaaf-f60b-422a-bf02-e10b87aa9ea7'
);


-- None 스페인 볼레로 주제에 의한 폴로네즈 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스페인 볼레로 주제에 의한 폴로네즈 F장조', 'Polonaise on a Spanish Bolero Theme in F major', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스페인 볼레로 주제에 의한 폴로네즈 F장조'
);


-- None 7중주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '7중주 E♭장조', 'Septet in E♭ major', 'album', NULL, NULL, NULL, 1823, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '7중주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42467301-096e-4355-9519-69da292bebcd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '42467301-096e-4355-9519-69da292bebcd'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '7중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42467301-096e-4355-9519-69da292bebcd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef5e2f50-9420-43e7-9d9d-0d87e3eeddb3', 1, 'I', 'Adagio maestoso – Allegro moderato', 'I. Adagio maestoso – Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '7중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef5e2f50-9420-43e7-9d9d-0d87e3eeddb3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8f81415-0065-4616-8678-1685547b4e65', 2, 'II', 'Adagio non tanto', 'II. Adagio non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '7중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8f81415-0065-4616-8678-1685547b4e65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7d1a807-3cdc-4db2-b17b-d7c9497d9f7c', 3, 'III', '미뉴에트', 'III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '7중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7d1a807-3cdc-4db2-b17b-d7c9497d9f7c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d797425e-bdba-4b54-b036-500ab1f5d354', 4, 'IV', '론도. Allegro', 'IV. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '7중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d797425e-bdba-4b54-b036-500ab1f5d354'
);


-- None 현악 4중주 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 D장조', 'String Quartet in D major', 'album', NULL, NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '759488dd-b8ff-42ed-8da0-38bcedfdf5f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '759488dd-b8ff-42ed-8da0-38bcedfdf5f1'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '759488dd-b8ff-42ed-8da0-38bcedfdf5f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca521ee8-c45e-4e14-838d-11ead21d22f3', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca521ee8-c45e-4e14-838d-11ead21d22f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44c385e6-059a-47a0-b90d-f67986a0970d', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44c385e6-059a-47a0-b90d-f67986a0970d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db488929-aa3a-49d2-bbc4-5c3a3f5970de', 3, 'III', 'Moderato', 'III. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db488929-aa3a-49d2-bbc4-5c3a3f5970de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ae3be2d-6d74-4b3f-a742-4b33a3669592', 4, 'IV', '론도', 'IV. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ae3be2d-6d74-4b3f-a742-4b33a3669592'
);


-- None 비올라 소나타 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비올라 소나타 D단조', 'Viola Sonata in D minor', 'album', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비올라 소나타 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2236491-92b9-4d71-819b-72c2e3c12d56'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd2236491-92b9-4d71-819b-72c2e3c12d56'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '비올라 소나타 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2236491-92b9-4d71-819b-72c2e3c12d56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f67a953-763b-317b-8936-0a542e928036', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '비올라 소나타 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f67a953-763b-317b-8936-0a542e928036'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00fdf449-a609-3568-bdfc-397f603c8771', 2, 'II', 'Larghetto ma non troppo', 'II. Larghetto ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '비올라 소나타 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00fdf449-a609-3568-bdfc-397f603c8771'
);


-- None 현악 4중주 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 F장조', 'String Quartet in F major', 'album', NULL, NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f522c81a-2f4d-467d-ab20-69162c0fe342'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f522c81a-2f4d-467d-ab20-69162c0fe342'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f522c81a-2f4d-467d-ab20-69162c0fe342'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77ff94bb-9f45-42fb-9807-d1450e7ec0a8', 1, 'I', 'Allegro spiritoso', 'I. Allegro spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77ff94bb-9f45-42fb-9807-d1450e7ec0a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fba9da47-dbad-43d5-acba-b761c85d5dd3', 2, 'II', 'Andante con moto', 'II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fba9da47-dbad-43d5-acba-b761c85d5dd3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5000a9f-674d-4d84-976c-a5a400eb90d9', 3, 'III', '미뉴에트', 'III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5000a9f-674d-4d84-976c-a5a400eb90d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:403a9b35-c707-4898-9923-b1a205b07148', 4, 'IV', '론도', 'IV. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:403a9b35-c707-4898-9923-b1a205b07148'
);


-- None 벨리니 <몽유병의 여인> 주제에 의한 화려한 디베르티멘토 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '벨리니 <몽유병의 여인> 주제에 의한 화려한 디베르티멘토 A♭장조', 'Divertimento brillante on Themes from Bellini''s "La sonnambula" in A♭ major', 'song', NULL, NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '벨리니 <몽유병의 여인> 주제에 의한 화려한 디베르티멘토 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39c0d87d-1cc7-4c63-9f59-f8bfcf26b335'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '39c0d87d-1cc7-4c63-9f59-f8bfcf26b335'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '벨리니 <몽유병의 여인> 주제에 의한 화려한 디베르티멘토 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39c0d87d-1cc7-4c63-9f59-f8bfcf26b335'
);


-- None 대 6중주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대 6중주 E♭장조', 'Gran sestetto originale in E♭ major', 'album', NULL, NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대 6중주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b3f4e64-0c16-41cf-9bb5-95df89d6ac17'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b3f4e64-0c16-41cf-9bb5-95df89d6ac17'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '대 6중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b3f4e64-0c16-41cf-9bb5-95df89d6ac17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e902318-415e-423e-9cfb-eb911179c04e', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '대 6중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e902318-415e-423e-9cfb-eb911179c04e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fa99ffa-17cc-4ff7-90a8-38e579aa0734', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '대 6중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fa99ffa-17cc-4ff7-90a8-38e579aa0734'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3aec2bd5-3431-4491-ac69-7b81b4b7bcda', 3, 'III', '피날레. Allegro con spirito', 'III. Finale. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '대 6중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aec2bd5-3431-4491-ac69-7b81b4b7bcda'
);


-- None 도니체티 <안나 볼레나> 주제에 의한 세레나데 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '도니체티 <안나 볼레나> 주제에 의한 세레나데 E♭장조', 'Serenade on Themes from Donizetti''s "Anna Bolena" in E♭ major', 'song', NULL, NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '도니체티 <안나 볼레나> 주제에 의한 세레나데 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6bc91a57-0167-46ec-bedd-59aa5b9bb511'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6bc91a57-0167-46ec-bedd-59aa5b9bb511'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '도니체티 <안나 볼레나> 주제에 의한 세레나데 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6bc91a57-0167-46ec-bedd-59aa5b9bb511'
);


-- None 비창 3중주 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비창 3중주 D단조', 'Trio pathétique in D minor', 'album', NULL, NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비창 3중주 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7ee187a-be4d-4f88-87ca-d7313e8e4562'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7ee187a-be4d-4f88-87ca-d7313e8e4562'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '비창 3중주 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7ee187a-be4d-4f88-87ca-d7313e8e4562'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83b8f192-16d2-4435-9525-2939472bbf96', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '비창 3중주 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83b8f192-16d2-4435-9525-2939472bbf96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa892bae-49e4-401e-9872-c39e9b81ec63', 2, 'II', '스케르초. Vivacissimo', 'II. Scherzo. Vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '비창 3중주 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa892bae-49e4-401e-9872-c39e9b81ec63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:840bb3fb-230a-4022-af79-2fbebbc6804d', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '비창 3중주 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:840bb3fb-230a-4022-af79-2fbebbc6804d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00d69975-ae0c-46b6-8fdb-3832e9c7579a', 4, 'IV', 'Allegro con spirito', 'IV. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '비창 3중주 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00d69975-ae0c-46b6-8fdb-3832e9c7579a'
);


-- None 모차르트 <마술피리> 주제에 의한 변주곡 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모차르트 <마술피리> 주제에 의한 변주곡 E♭장조', 'Variations on a Theme from Mozart''s "Die Zauberflöte" in E♭ major', 'song', NULL, NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모차르트 <마술피리> 주제에 의한 변주곡 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65777827-d9e3-4fe2-9e70-7b49ca83b4a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '65777827-d9e3-4fe2-9e70-7b49ca83b4a5'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '모차르트 <마술피리> 주제에 의한 변주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65777827-d9e3-4fe2-9e70-7b49ca83b4a5'
);


-- None 창작 주제에 의한 변주곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '창작 주제에 의한 변주곡 F장조', 'Variations on an Original Theme in F major', 'song', NULL, NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '창작 주제에 의한 변주곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e736bb0-39b0-4144-a1ce-19305d8bcf07'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7e736bb0-39b0-4144-a1ce-19305d8bcf07'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '창작 주제에 의한 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e736bb0-39b0-4144-a1ce-19305d8bcf07'
);


-- None 러시아 노래 "평평한 골짜기 가운데" 주제에 의한 변주곡 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '러시아 노래 "평평한 골짜기 가운데" 주제에 의한 변주곡 A단조', 'Variations on the Russian Song "Sredi doliny rovnyya" in A minor', 'song', NULL, NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '러시아 노래 "평평한 골짜기 가운데" 주제에 의한 변주곡 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a63a2eb4-781f-4f07-bc85-8316b9450910'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a63a2eb4-781f-4f07-bc85-8316b9450910'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '러시아 노래 "평평한 골짜기 가운데" 주제에 의한 변주곡 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a63a2eb4-781f-4f07-bc85-8316b9450910'
);


-- None 로망스 "Benedetta sia la madre" 주제에 의한 변주곡 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 "Benedetta sia la madre" 주제에 의한 변주곡 E장조', 'Variations on the Romance "Benedetta sia la madre" in E major', 'song', NULL, NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 "Benedetta sia la madre" 주제에 의한 변주곡 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa399491-1958-4de2-8232-ef868ae5e8ae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fa399491-1958-4de2-8232-ef868ae5e8ae'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '로망스 "Benedetta sia la madre" 주제에 의한 변주곡 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa399491-1958-4de2-8232-ef868ae5e8ae'
);


-- None 케루비니 <파니스카> 주제에 의한 변주곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '케루비니 <파니스카> 주제에 의한 변주곡 B♭장조', 'Variations on a Theme from Cherubini''s "Faniska" in B♭ major', 'song', NULL, NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '케루비니 <파니스카> 주제에 의한 변주곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3324053e-5c8f-4e3d-861a-a73451e58e08'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3324053e-5c8f-4e3d-861a-a73451e58e08'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '케루비니 <파니스카> 주제에 의한 변주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3324053e-5c8f-4e3d-861a-a73451e58e08'
);


-- None 5개의 새 프랑스 콩트르당스

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 새 프랑스 콩트르당스', '5 Nouvelles quadrilles françaises', 'song', NULL, NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 새 프랑스 콩트르당스'
);


-- None 4개의 새 콩트르당스

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 새 콩트르당스', '4 New Contredanses', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 새 콩트르당스'
);


-- None 코티용 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '코티용 B♭장조', 'Cotillon in B♭ major', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '코티용 B♭장조'
);


-- None 마주르카 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 G장조', 'Mazurka in G major', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 G장조'
);


-- None 녹턴 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 E♭장조', 'Nocturne in E♭ major', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '800ec32f-88a0-3b40-8c85-baa2e419608b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '800ec32f-88a0-3b40-8c85-baa2e419608b'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '녹턴 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '800ec32f-88a0-3b40-8c85-baa2e419608b'
);


-- None 핀란드 노래 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '핀란드 노래 D장조', 'Finnish Song in D major', 'song', NULL, NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '핀란드 노래 D장조'
);


-- None 네 손을 위한 기병의 속보 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 기병의 속보 C장조', 'Trot de cavalerie in C major for piano four hands', 'song', NULL, NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 기병의 속보 C장조'
);


-- None 네 손을 위한 기병의 속보 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 기병의 속보 G장조', 'Trot de cavalerie in G major for piano four hands', 'song', NULL, NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 기병의 속보 G장조'
);


-- None 이별의 왈츠 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '이별의 왈츠 G장조', 'Valse d''adieux in G major', 'song', NULL, NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '이별의 왈츠 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd432a779-8bfe-47cb-ba87-a14e47400ae9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd432a779-8bfe-47cb-ba87-a14e47400ae9'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '이별의 왈츠 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd432a779-8bfe-47cb-ba87-a14e47400ae9'
);


-- None 벨리니 <카풀레티가와 몬테키가> 주제에 의한 화려한 론도 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '벨리니 <카풀레티가와 몬테키가> 주제에 의한 화려한 론도 B♭장조', 'Rondo brillante on Themes from Bellini''s "I Capuleti e i Montecchi" in B♭ major', 'song', NULL, NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '벨리니 <카풀레티가와 몬테키가> 주제에 의한 화려한 론도 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '130c60c9-29f2-41fd-9c6e-2a0eee98f344'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '130c60c9-29f2-41fd-9c6e-2a0eee98f344'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '벨리니 <카풀레티가와 몬테키가> 주제에 의한 화려한 론도 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '130c60c9-29f2-41fd-9c6e-2a0eee98f344'
);


-- None 도니체티 <안나 볼레나> 주제에 의한 화려한 변주곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '도니체티 <안나 볼레나> 주제에 의한 화려한 변주곡 A장조', 'Variations brillantes on a Theme from Donizetti''s "Anna Bolena" in A major', 'song', NULL, NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '도니체티 <안나 볼레나> 주제에 의한 화려한 변주곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24ef376b-2f8d-4611-b443-c91d0ea572d2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '24ef376b-2f8d-4611-b443-c91d0ea572d2'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '도니체티 <안나 볼레나> 주제에 의한 화려한 변주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24ef376b-2f8d-4611-b443-c91d0ea572d2'
);


-- None 발레 <차오캉> 의 두 주제에 의한 변주곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <차오캉> 의 두 주제에 의한 변주곡 D장조', 'Variations on Two Themes from the Ballet "Chao-Kang" in D major', 'song', NULL, NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <차오캉> 의 두 주제에 의한 변주곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af6eee07-1002-4bb1-a4de-8f6ed4917fd1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'af6eee07-1002-4bb1-a4de-8f6ed4917fd1'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '발레 <차오캉> 의 두 주제에 의한 변주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af6eee07-1002-4bb1-a4de-8f6ed4917fd1'
);


-- None 도니체티 <사랑의 묘약> 주제에 의한 갤럽풍 즉흥곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '도니체티 <사랑의 묘약> 주제에 의한 갤럽풍 즉흥곡 B♭장조', 'Impromptu en galop on a Theme from Donizetti''s "L''elisir d''amore" in B♭ major', 'song', NULL, NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '도니체티 <사랑의 묘약> 주제에 의한 갤럽풍 즉흥곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d4b772e-7c49-4e6a-8686-c43018a3413b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6d4b772e-7c49-4e6a-8686-c43018a3413b'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '도니체티 <사랑의 묘약> 주제에 의한 갤럽풍 즉흥곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d4b772e-7c49-4e6a-8686-c43018a3413b'
);


-- None 벨리니 <카풀레티가와 몬테키가> 주제에 의한 변주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '벨리니 <카풀레티가와 몬테키가> 주제에 의한 변주곡 C장조', 'Variations on a Theme from Bellini''s "I Capuleti e i Montecchi" in C major', 'song', NULL, NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '벨리니 <카풀레티가와 몬테키가> 주제에 의한 변주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5de8734a-bfbc-445e-8e9b-0817854cd394'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5de8734a-bfbc-445e-8e9b-0817854cd394'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '벨리니 <카풀레티가와 몬테키가> 주제에 의한 변주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5de8734a-bfbc-445e-8e9b-0817854cd394'
);


-- None 알랴비예프 가곡 <나이팅게일> 주제에 의한 변주곡 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알랴비예프 가곡 <나이팅게일> 주제에 의한 변주곡 E단조', 'Variations on Alyabyev''s Song "The Nightingale" in E minor', 'song', NULL, NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알랴비예프 가곡 <나이팅게일> 주제에 의한 변주곡 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf83ff89-7792-4066-a9d0-ce15ab117a4c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cf83ff89-7792-4066-a9d0-ce15ab117a4c'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '알랴비예프 가곡 <나이팅게일> 주제에 의한 변주곡 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf83ff89-7792-4066-a9d0-ce15ab117a4c'
);


-- None 3개의 푸가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 푸가', '3 Fugues', 'album', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 푸가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc8c3bc4-b695-4a41-9fc6-e1dd1c69a115'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc8c3bc4-b695-4a41-9fc6-e1dd1c69a115'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '3개의 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc8c3bc4-b695-4a41-9fc6-e1dd1c69a115'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82bd7f97-048f-41c8-b926-da2096753778', 1, NULL, '3성 푸가 E♭장조', '3-Part Fugue in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '3개의 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82bd7f97-048f-41c8-b926-da2096753778'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fea8055d-5b3f-4f5e-ae57-58258d6d1bbf', 2, NULL, '3성 푸가 A단조', '3-Part Fugue in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '3개의 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fea8055d-5b3f-4f5e-ae57-58258d6d1bbf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2edc61a6-4017-417c-b340-4bfeb3053b21', 3, NULL, '4성 푸가 D장조', '4-Part Fugue in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '3개의 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2edc61a6-4017-417c-b340-4bfeb3053b21'
);


-- None 마주르카 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 A♭장조', 'Mazurka in A♭ major', 'song', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 A♭장조'
);


-- None 마주르카 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 F장조', 'Mazurka in F major', 'song', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 F장조'
);


-- None 네 손을 위한 러시아 주제에 의한 카프리치오 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 러시아 주제에 의한 카프리치오 A장조', 'Capriccio on Russian Themes in A major for piano four hands', 'song', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 러시아 주제에 의한 카프리치오 A장조'
);


-- None <애국의 노래> C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<애국의 노래> C장조', 'Patriotic Song (Motif de chant national) in C major', 'song', NULL, NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<애국의 노래> C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcba345c-cb25-455a-8523-89ba72f7f52d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dcba345c-cb25-455a-8523-89ba72f7f52d'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '<애국의 노래> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcba345c-cb25-455a-8523-89ba72f7f52d'
);


-- None 마주르카 F장조 "아내에게 바침"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 F장조 "아내에게 바침"', 'Mazurka in F major "Dédiée à sa femme"', 'song', NULL, NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 F장조 "아내에게 바침"'
);


-- None 5개의 콩트르당스

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 콩트르당스', '5 Contredanses', 'song', NULL, NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 콩트르당스'
);


-- None 왈츠 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 B♭장조', 'Waltz in B♭ major', 'song', NULL, NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 B♭장조'
);


-- None 선율적 왈츠 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '선율적 왈츠 E♭장조', 'Melodic Waltz in E♭ major', 'song', NULL, NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '선율적 왈츠 E♭장조'
);


-- None 갈로파드 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갈로파드 E♭장조', 'Galopade in E♭ major', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갈로파드 E♭장조'
);


-- None <수녀원 기숙생> 5개의 새 콩트르당스

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<수녀원 기숙생> 5개의 새 콩트르당스', 'La Conventine, 5 New Contredanses', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<수녀원 기숙생> 5개의 새 콩트르당스'
);


-- None 녹턴 F단조 "이별"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 F단조 "이별"', 'Nocturne in F minor "La Séparation"', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 F단조 "이별"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b71b464d-a4eb-32c4-8b22-5c8ac02a5791'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b71b464d-a4eb-32c4-8b22-5c8ac02a5791'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '녹턴 F단조 "이별"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b71b464d-a4eb-32c4-8b22-5c8ac02a5791'
);


-- None 대 왈츠 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대 왈츠 G장조', 'Grande valse in G major', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대 왈츠 G장조'
);


-- None 폴로네즈 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 E장조', 'Polonaise in E major', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 E장조'
);


-- None 볼레로 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '볼레로 D단조', 'Bolero in D minor', 'song', NULL, NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '볼레로 D단조'
);


-- None 러시아 민요 주제에 의한 타란텔라 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '러시아 민요 주제에 의한 타란텔라 A단조', 'Tarantella on a Russian Folk Song in A minor', 'song', NULL, NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '러시아 민요 주제에 의한 타란텔라 A단조'
);


-- None 마주르카 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 C단조', 'Mazurka in C minor', 'song', NULL, NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9394853b-96b3-4568-97c8-dcd12c8814e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9394853b-96b3-4568-97c8-dcd12c8814e9'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '마주르카 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9394853b-96b3-4568-97c8-dcd12c8814e9'
);


-- None 피아노 모음곡 <조국에 보내는 인사>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <조국에 보내는 인사>', 'A Greeting to My Native Land', 'album', NULL, NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <조국에 보내는 인사>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b46e912b-a222-4803-a3ec-2eb6cc8e4bd9', 1, NULL, '마주르카의 추억 B♭장조', 'Souvenir d''une mazurka in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '피아노 모음곡 <조국에 보내는 인사>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b46e912b-a222-4803-a3ec-2eb6cc8e4bd9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:glinka:glinka-greeting-native-land:2', 2, NULL, '뱃노래 G장조', 'Barcarolle in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '피아노 모음곡 <조국에 보내는 인사>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:glinka:glinka-greeting-native-land:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:glinka:glinka-greeting-native-land:3', 3, NULL, '기도 A장조', 'Prière in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '피아노 모음곡 <조국에 보내는 인사>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:glinka:glinka-greeting-native-land:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:glinka:glinka-greeting-native-land:4', 4, NULL, '스코틀랜드 주제에 의한 변주곡', 'Variations on a Scottish Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '피아노 모음곡 <조국에 보내는 인사>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:glinka:glinka-greeting-native-land:4'
);


-- None 폴카 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 D단조', 'Polka in D minor', 'song', NULL, NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32940d75-d69f-4428-a3ba-9f2eda22afc5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '32940d75-d69f-4428-a3ba-9f2eda22afc5'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '폴카 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32940d75-d69f-4428-a3ba-9f2eda22afc5'
);


-- None 마주르카 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 C장조', 'Mazurka in C major', 'song', NULL, NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '266b8e5c-463e-42f8-a1b1-8810080f671a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '266b8e5c-463e-42f8-a1b1-8810080f671a'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '마주르카 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '266b8e5c-463e-42f8-a1b1-8810080f671a'
);


-- None 네 손을 위한 첫 폴카 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 첫 폴카 B♭장조', 'Première polka in B♭ major for piano four hands', 'song', NULL, NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 첫 폴카 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb52ba66-60a2-4cb7-bb82-277e048c080c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb52ba66-60a2-4cb7-bb82-277e048c080c'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '네 손을 위한 첫 폴카 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb52ba66-60a2-4cb7-bb82-277e048c080c'
);


-- None 어린이 폴카 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '어린이 폴카 B♭장조', 'Polka enfantine in B♭ major', 'song', NULL, NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '어린이 폴카 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '599ba9fe-2435-4c4b-b3aa-a8ad62411227'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '599ba9fe-2435-4c4b-b3aa-a8ad62411227'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '어린이 폴카 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '599ba9fe-2435-4c4b-b3aa-a8ad62411227'
);


-- None 안달루시아 춤 <라스 모야레스> G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안달루시아 춤 <라스 모야레스> G장조', 'Las Mollares, Andalusian Dance in G major', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안달루시아 춤 <라스 모야레스> G장조'
);


-- None 레지에라멘테 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '레지에라멘테 E장조', 'Leggieramente in E major', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '레지에라멘테 E장조'
);


-- None 마주르카 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 A단조', 'Mazurka in A minor', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 A단조'
);


-- None 칸타타 <알렉산드르 1세의 죽음과 니콜라이 1세의 즉위에 부치는 프롤로그>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <알렉산드르 1세의 죽음과 니콜라이 1세의 즉위에 부치는 프롤로그>', 'Prologue on the Death of Emperor Alexander I and the Accession of Nicholas I', 'song', NULL, NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <알렉산드르 1세의 죽음과 니콜라이 1세의 즉위에 부치는 프롤로그>'
);


-- None 합창곡 <Russkaya pesnya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Russkaya pesnya>', 'Russkaya pesnya (Russian Song)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Russkaya pesnya>'
);


-- None 합창곡 <Kheruvimskaya> C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Kheruvimskaya> C장조', 'Kheruvimskaya (Cherubic Hymn) in C major', 'song', NULL, NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Kheruvimskaya> C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '887d59d9-3460-4ea6-b37a-91a098289c48'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '887d59d9-3460-4ea6-b37a-91a098289c48'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '합창곡 <Kheruvimskaya> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '887d59d9-3460-4ea6-b37a-91a098289c48'
);


-- None 합창곡 <Velik nash bog>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Velik nash bog>', 'Velik nash bog (Our God Is Great)', 'song', NULL, NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Velik nash bog>'
);


-- None 합창곡 <Gimn khozyainu>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Gimn khozyainu>', 'Gimn khozyainu (Hymn to the Master)', 'song', NULL, NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Gimn khozyainu>'
);


-- None 합창곡 <Zazdravnaya pesnya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Zazdravnaya pesnya>', 'Zazdravnaya pesnya (Toasting Song)', 'song', NULL, NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Zazdravnaya pesnya>'
);


-- None 귀족 여학교 학생들을 위한 이별의 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '귀족 여학교 학생들을 위한 이별의 노래', 'Farewell Song for the Pupils of the Society of Genteel Maidens', 'song', NULL, NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '귀족 여학교 학생들을 위한 이별의 노래'
);


-- None 합창곡 <Kosa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Kosa>', 'Kosa (The Scythe)', 'song', NULL, NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Kosa>'
);


-- None 합창곡 <Molitva>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Molitva>', 'Molitva (Prayer)', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Molitva>'
);


-- None 합창곡 <Yekteniya pervaya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Yekteniya pervaya>', 'Yekteniya pervaya (First Litany)', 'song', NULL, NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Yekteniya pervaya>'
);


-- None 가곡 <Moya arfa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Moya arfa>', 'Moya arfa (My Harp)', 'song', NULL, NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Moya arfa>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a0e80ab-222a-4314-844a-e333f99d34fe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2a0e80ab-222a-4314-844a-e333f99d34fe'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Moya arfa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a0e80ab-222a-4314-844a-e333f99d34fe'
);


-- None 가곡 <Ne iskushay menya bez nuzhdy>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ne iskushay menya bez nuzhdy>', 'Ne iskushay menya bez nuzhdy (Do Not Tempt Me Needlessly)', 'song', NULL, NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ne iskushay menya bez nuzhdy>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4b74cd2-0b57-4ddf-bf46-0a528dad8559'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd4b74cd2-0b57-4ddf-bf46-0a528dad8559'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Ne iskushay menya bez nuzhdy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4b74cd2-0b57-4ddf-bf46-0a528dad8559'
);


-- None 가곡 <Akh ty, dushechka, krasna devitsa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Akh ty, dushechka, krasna devitsa>', 'Akh ty, dushechka, krasna devitsa (Ah, My Sweet, Thou Art a Beautiful Maiden)', 'song', NULL, NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Akh ty, dushechka, krasna devitsa>'
);


-- None 가곡 <Uteshenie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Uteshenie>', 'Uteshenie (Consolation)', 'song', NULL, NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Uteshenie>'
);


-- None 가곡 <Bednyy pevets>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Bednyy pevets>', 'Bednyy pevets (The Poor Singer)', 'song', NULL, NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Bednyy pevets>'
);


-- None 가곡 <Gor'ko, gor'ko mne, krasnoy devitse>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Gor''ko, gor''ko mne, krasnoy devitse>', 'Gor''ko, gor''ko mne, krasnoy devitse (Bitter, Bitter It Is for Me)', 'song', NULL, NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Gor''ko, gor''ko mne, krasnoy devitse>'
);


-- None 가곡 <Pamyat' serdtsa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pamyat'' serdtsa>', 'Pamyat'' serdtsa (Heart''s Memory)', 'song', NULL, NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pamyat'' serdtsa>'
);


-- None 가곡 <Ya lyublyu, ty mne tverdila>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ya lyublyu, ty mne tverdila>', 'Ya lyublyu, ty mne tverdila ("I Love" Was Your Assurance)', 'song', NULL, NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ya lyublyu, ty mne tverdila>'
);


-- None 가곡 <Chto, krasotka molodaya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Chto, krasotka molodaya>', 'Chto, krasotka molodaya (Why Do You Cry, Young Beauty)', 'song', NULL, NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Chto, krasotka molodaya>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e2cf1cd0-5a47-416f-9404-e73d6fe3ab70'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e2cf1cd0-5a47-416f-9404-e73d6fe3ab70'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Chto, krasotka molodaya>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e2cf1cd0-5a47-416f-9404-e73d6fe3ab70'
);


-- None 가곡 <Mio ben ricordati>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mio ben ricordati>', 'Mio ben ricordati', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mio ben ricordati>'
);


-- None 3중창 <Bozhe sil, vo dni smyaten'ya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3중창 <Bozhe sil, vo dni smyaten''ya>', 'Bozhe sil, vo dni smyaten''ya (O God, Preserve Our Strength in the Days of Confusion)', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3중창 <Bozhe sil, vo dni smyaten''ya>'
);


-- None 가곡 <Odin lish' mig>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Odin lish'' mig>', 'Odin lish'' mig (Pour un moment)', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Odin lish'' mig>'
);


-- None 가곡 <Skazhi, zachem>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Skazhi, zachem>', 'Skazhi, zachem (Tell Me Why)', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Skazhi, zachem>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4fe8f9d3-c959-4287-9120-3b41b47cd9a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4fe8f9d3-c959-4287-9120-3b41b47cd9a7'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Skazhi, zachem>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4fe8f9d3-c959-4287-9120-3b41b47cd9a7'
);


-- None 가곡 <Razocharovanie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Razocharovanie>', 'Razocharovanie (Disenchantment)', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Razocharovanie>'
);


-- None 가곡 <Dovunque il guardo giro>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Dovunque il guardo giro>', 'Dovunque il guardo giro', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Dovunque il guardo giro>'
);


-- None 2개의 이탈리아 칸초네타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 이탈리아 칸초네타', 'Due canzonette italiane', 'album', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 이탈리아 칸초네타'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:glinka:glinka-due-canzonette:1', 1, NULL, 'Ah, rammenta, o bella Irene', 'Ah, rammenta, o bella Irene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '2개의 이탈리아 칸초네타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:glinka:glinka-due-canzonette:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c8a3c26-45c5-4abf-a2c3-73ea1767347c', 2, NULL, 'Alla cetra', 'Alla cetra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '2개의 이탈리아 칸초네타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c8a3c26-45c5-4abf-a2c3-73ea1767347c'
);


-- None 가곡 <Ho perduto il mio tesoro>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ho perduto il mio tesoro>', 'Ho perduto il mio tesoro', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ho perduto il mio tesoro>'
);


-- None 가곡 <Dedushka! – devitsy raz mne govorili>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Dedushka! – devitsy raz mne govorili>', 'Dedushka! – devitsy raz mne govorili (The Maids Once Told Me, Grandfather)', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Dedushka! – devitsy raz mne govorili>'
);


-- None 가곡 <Mi sento il cor trafiggere>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mi sento il cor trafiggere>', 'Mi sento il cor trafiggere', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mi sento il cor trafiggere>'
);


-- None 가곡 <O Dafni, che di quest'anima>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <O Dafni, che di quest''anima>', 'O Dafni, che di quest''anima', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <O Dafni, che di quest''anima>'
);


-- None 가곡 <Akh ty, noch' li, nochen'ka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Akh ty, noch'' li, nochen''ka>', 'Akh ty, noch'' li, nochen''ka (O Thou Black Night)', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Akh ty, noch'' li, nochen''ka>'
);


-- None 가곡 <Pensa che questo istante>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pensa che questo istante>', 'Pensa che questo istante', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pensa che questo istante>'
);


-- None 가곡 <Piangendo ancora rinascer suole>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Piangendo ancora rinascer suole>', 'Piangendo ancora rinascer suole', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Piangendo ancora rinascer suole>'
);


-- None 4중창 <Molitva> B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4중창 <Molitva> B♭장조', 'Molitva (Prayer) in B♭ major', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4중창 <Molitva> B♭장조'
);


-- None 가곡 <Pur nel sonno>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pur nel sonno>', 'Pur nel sonno', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pur nel sonno>'
);


-- None 가곡 <Zabudu l' ya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Zabudu l'' ya>', 'Zabudu l'' ya (Shall I Forget...)', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Zabudu l'' ya>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3aca2cb0-6514-46bf-849b-d0adba2a527d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3aca2cb0-6514-46bf-849b-d0adba2a527d'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Zabudu l'' ya>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3aca2cb0-6514-46bf-849b-d0adba2a527d'
);


-- None 가곡 <Ne poy, krasavitsa, pri mne>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ne poy, krasavitsa, pri mne>', 'Ne poy, krasavitsa, pri mne (Sing Not, Thou Beauty, in My Presence)', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ne poy, krasavitsa, pri mne>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c28b7191-8d6d-4c3e-beb7-acbf7ef69468'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c28b7191-8d6d-4c3e-beb7-acbf7ef69468'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Ne poy, krasavitsa, pri mne>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c28b7191-8d6d-4c3e-beb7-acbf7ef69468'
);


-- None 4중창 <Sogna chi crede d'esser felice>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4중창 <Sogna chi crede d''esser felice>', 'Sogna chi crede d''esser felice', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4중창 <Sogna chi crede d''esser felice>'
);


-- None 가곡 <Tu sei figlia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Tu sei figlia>', 'Tu sei figlia', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Tu sei figlia>'
);


-- None 4중창 <Come di gloria al nome>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4중창 <Come di gloria al nome>', 'Come di gloria al nome', 'song', NULL, NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4중창 <Come di gloria al nome>'
);


-- None 가곡 <Golos s togo sveta>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Golos s togo sveta>', 'Golos s togo sveta (A Voice from the Other World)', 'song', NULL, NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Golos s togo sveta>'
);


-- None 가곡 <Noch' osennyaya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Noch'' osennyaya>', 'Noch'' osennyaya (O Gentle Autumn Night)', 'song', NULL, NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Noch'' osennyaya>'
);


-- None 가곡 <Pobeditel'>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pobeditel''>', 'Pobeditel'' (The Conqueror)', 'song', NULL, NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pobeditel''>'
);


-- None 가곡 <Il desiderio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Il desiderio>', 'Il desiderio', 'song', NULL, NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Il desiderio>'
);


-- None 가곡 <L'iniquo voto>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <L''iniquo voto>', 'L''iniquo voto', 'song', NULL, NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <L''iniquo voto>'
);


-- None 가곡 <Venetsianskaya noch'>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Venetsianskaya noch''>', 'Venetsianskaya noch'' (Venetian Night)', 'song', NULL, NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Venetsianskaya noch''>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49170d51-ddca-447d-a3b9-ad49fb828bf1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '49170d51-ddca-447d-a3b9-ad49fb828bf1'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Venetsianskaya noch''>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49170d51-ddca-447d-a3b9-ad49fb828bf1'
);


-- None 가곡 <Dubrava shumit>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Dubrava shumit>', 'Dubrava shumit (The Leafy Grove Howls)', 'song', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Dubrava shumit>'
);


-- None 가곡 <Ne govori: lyubov' proydet>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ne govori: lyubov'' proydet>', 'Ne govori: lyubov'' proydet (Say Not That Love Will Pass)', 'song', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ne govori: lyubov'' proydet>'
);


-- None 가곡 <Ne nazyvay yee nebesnoy>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ne nazyvay yee nebesnoy>', 'Ne nazyvay yee nebesnoy (Call Her Not Heavenly)', 'song', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ne nazyvay yee nebesnoy>'
);


-- None 가곡 <Ya zdes', Inezil'ya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ya zdes'', Inezil''ya>', 'Ya zdes'', Inezil''ya (I Am Here, Inezilla)', 'song', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ya zdes'', Inezil''ya>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81be74e9-a2f4-4211-bbdd-69df45690c5f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '81be74e9-a2f4-4211-bbdd-69df45690c5f'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Ya zdes'', Inezil''ya>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81be74e9-a2f4-4211-bbdd-69df45690c5f'
);


-- None 가곡 <Tol'ko uznal ya tebya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Tol''ko uznal ya tebya>', 'Tol''ko uznal ya tebya (I Had But Recognized You)', 'song', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Tol''ko uznal ya tebya>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7181db2a-770c-4101-b2fa-ebc2d169eee8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7181db2a-770c-4101-b2fa-ebc2d169eee8'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Tol''ko uznal ya tebya>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7181db2a-770c-4101-b2fa-ebc2d169eee8'
);


-- None 가곡 <Nochnoy smotr>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Nochnoy smotr>', 'Nochnoy smotr (The Night Review)', 'song', NULL, NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Nochnoy smotr>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8bc651f3-d698-4c02-a87a-75ed34423603'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8bc651f3-d698-4c02-a87a-75ed34423603'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Nochnoy smotr>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8bc651f3-d698-4c02-a87a-75ed34423603'
);


-- None 가곡 <Gde nasha roza>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Gde nasha roza>', 'Gde nasha roza (Where Is Our Rose?)', 'song', NULL, NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Gde nasha roza>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a6e5660-fea0-4863-b80f-913d92f6b7a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0a6e5660-fea0-4863-b80f-913d92f6b7a4'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Gde nasha roza>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a6e5660-fea0-4863-b80f-913d92f6b7a4'
);


-- None 가곡 <Stantsy. Vot mesto taynogo svidan'ya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Stantsy. Vot mesto taynogo svidan''ya>', 'Stantsy. Vot mesto taynogo svidan''ya (Stanzas: This Secret Meeting Place)', 'song', NULL, NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Stantsy. Vot mesto taynogo svidan''ya>'
);


-- None 2중창 <Vy ne pridete vnov'>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Vy ne pridete vnov''>', 'Vy ne pridete vnov'' (Will You Not Return)', 'song', NULL, NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Vy ne pridete vnov''>'
);


-- None 가곡 <Somnenie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Somnenie>', 'Somnenie (Doubt)', 'song', NULL, NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Somnenie>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a845a9a-04ad-4bdf-a950-8f63a2ef1b82'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a845a9a-04ad-4bdf-a950-8f63a2ef1b82'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Somnenie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a845a9a-04ad-4bdf-a950-8f63a2ef1b82'
);


-- None 가곡 <V krovi gorit ogon' zhelan'ya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <V krovi gorit ogon'' zhelan''ya>', 'V krovi gorit ogon'' zhelan''ya (The Fire of Longing Burns in My Heart)', 'song', NULL, NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <V krovi gorit ogon'' zhelan''ya>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '154a4547-1d93-423e-be0a-87447ff1ab34'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '154a4547-1d93-423e-be0a-87447ff1ab34'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <V krovi gorit ogon'' zhelan''ya>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '154a4547-1d93-423e-be0a-87447ff1ab34'
);


-- None 가곡 <Nochnoy zefir>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Nochnoy zefir>', 'Nochnoy zefir (The Night Zephir)', 'song', NULL, NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Nochnoy zefir>'
);


-- None 가곡 <Ne shchebechi, soloveyku>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ne shchebechi, soloveyku>', 'Ne shchebechi, soloveyku (Sing Not, O Nightingale)', 'song', NULL, NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ne shchebechi, soloveyku>'
);


-- None 가곡 <Gude viter vel'mi v poli...>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Gude viter vel''mi v poli...>', 'Gude viter vel''mi v poli... (The Wind Blows)', 'song', NULL, NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Gude viter vel''mi v poli...>'
);


-- None 가곡 <Zatsvetyot cheryomukha>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Zatsvetyot cheryomukha>', 'Zatsvetyot cheryomukha (The Cherry Tree Is Blooming)', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Zatsvetyot cheryomukha>'
);


-- None 가곡 <Priznanie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Priznanie>', 'Priznanie (Declaration)', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Priznanie>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5cab604-254d-4285-b36b-5395b6071b6c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5cab604-254d-4285-b36b-5395b6071b6c'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Priznanie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5cab604-254d-4285-b36b-5395b6071b6c'
);


-- None 가곡 <Yesli vstrechus' s toboy>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Yesli vstrechus'' s toboy>', 'Yesli vstrechus'' s toboy (If I Shall Meet You)', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Yesli vstrechus'' s toboy>'
);


-- None 가곡 <Svadebnaya pesnya "Divnyy terem stoit">

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Svadebnaya pesnya "Divnyy terem stoit">', 'Svadebnaya pesnya "Divnyy terem stoit" (Wedding Song)', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Svadebnaya pesnya "Divnyy terem stoit">'
);


-- None 예카테리나 여학교 졸업생의 이별 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '예카테리나 여학교 졸업생의 이별 노래', 'Farewell Song of the Pupils of the Yekaterinsky Institute', 'song', NULL, NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '예카테리나 여학교 졸업생의 이별 노래'
);


-- None 연가곡집 <페테르부르크와의 이별>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <페테르부르크와의 이별>', 'A Farewell to Saint Petersburg', 'album', NULL, NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <페테르부르크와의 이별>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9159b362-2c07-4e9b-938c-47e05aee67e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9159b362-2c07-4e9b-938c-47e05aee67e9'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '연가곡집 <페테르부르크와의 이별>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9159b362-2c07-4e9b-938c-47e05aee67e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceaa20e7-eecc-4330-8375-7104b400eee7', 1, NULL, '로망스', 'Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '연가곡집 <페테르부르크와의 이별>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceaa20e7-eecc-4330-8375-7104b400eee7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79e185b5-20ab-4dff-9deb-920e6769a0d0', 2, NULL, '유대인의 노래', 'Hebrew Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '연가곡집 <페테르부르크와의 이별>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79e185b5-20ab-4dff-9deb-920e6769a0d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9a9e508-084f-463e-afd0-86bf0b4391e4', 3, NULL, '볼레로', 'Bolero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '연가곡집 <페테르부르크와의 이별>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9a9e508-084f-463e-afd0-86bf0b4391e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4db6ca9f-a3a0-43c6-8f9c-11d733a6f683', 4, NULL, '카바티나', 'Cavatina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '연가곡집 <페테르부르크와의 이별>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4db6ca9f-a3a0-43c6-8f9c-11d733a6f683'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e01668ce-4dc2-4dd2-aebd-6a3daf7c731a', 5, NULL, '자장가', 'Cradle Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '연가곡집 <페테르부르크와의 이별>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e01668ce-4dc2-4dd2-aebd-6a3daf7c731a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad01a3b4-e958-4ad8-b0b0-de692d1915b8', 6, NULL, '여행의 노래', 'Travelling Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '연가곡집 <페테르부르크와의 이별>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad01a3b4-e958-4ad8-b0b0-de692d1915b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e80956f-2c91-48e5-9820-305639ddc276', 7, NULL, '환상곡', 'Fantasia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '연가곡집 <페테르부르크와의 이별>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e80956f-2c91-48e5-9820-305639ddc276'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1645d218-5858-4a20-83c2-d047a4bc8aa8', 8, NULL, '뱃노래', 'Barcarolle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '연가곡집 <페테르부르크와의 이별>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1645d218-5858-4a20-83c2-d047a4bc8aa8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dea4c85-5a72-413e-8a40-156e134117dc', 9, NULL, 'Virtus antiqua (기사 로망스)', 'Virtus antiqua', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '연가곡집 <페테르부르크와의 이별>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dea4c85-5a72-413e-8a40-156e134117dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 175 AND linked.composer_id = 38), 'musicbrainz:d705f4e5-9292-4ad5-81c7-c4796454d649', 10, NULL, '종달새', 'The Lark', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '연가곡집 <페테르부르크와의 이별>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d705f4e5-9292-4ad5-81c7-c4796454d649'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28780060-2645-4ffa-b5e2-f883ddd372c3', 11, NULL, '몰리에게', 'To Molly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '연가곡집 <페테르부르크와의 이별>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28780060-2645-4ffa-b5e2-f883ddd372c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5212973-b4f1-48a8-86ce-1f6d02261a9d', 12, NULL, '이별의 노래', 'Song of Farewell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '연가곡집 <페테르부르크와의 이별>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5212973-b4f1-48a8-86ce-1f6d02261a9d'
);


-- None 가곡 <Kak sladko s toboyu mne byt'>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Kak sladko s toboyu mne byt''>', 'Kak sladko s toboyu mne byt'' (How Sweet It Is to Be with You)', 'song', NULL, NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Kak sladko s toboyu mne byt''>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b44d07af-96e8-4b2c-a92e-489d7f43113c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b44d07af-96e8-4b2c-a92e-489d7f43113c'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Kak sladko s toboyu mne byt''>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b44d07af-96e8-4b2c-a92e-489d7f43113c'
);


-- None 가곡 <Ya pomnyu chudnoe mgnoven'e>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ya pomnyu chudnoe mgnoven''e>', 'Ya pomnyu chudnoe mgnoven''e (I Recall a Wonderful Moment)', 'song', NULL, NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ya pomnyu chudnoe mgnoven''e>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '198e6475-114c-446e-8457-d2faf7b7a3ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '198e6475-114c-446e-8457-d2faf7b7a3ff'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Ya pomnyu chudnoe mgnoven''e>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '198e6475-114c-446e-8457-d2faf7b7a3ff'
);


-- None 가곡 <Lyublyu tebya, milaya roza>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Lyublyu tebya, milaya roza>', 'Lyublyu tebya, milaya roza (I Love You, Dear Rose)', 'song', NULL, NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Lyublyu tebya, milaya roza>'
);


-- None 가곡 <K ney>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <K ney>', 'K ney (To Her)', 'song', NULL, NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <K ney>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f6d6518a-4e20-4c65-8b50-6e30212eabae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f6d6518a-4e20-4c65-8b50-6e30212eabae'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <K ney>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f6d6518a-4e20-4c65-8b50-6e30212eabae'
);


-- None 가곡 <Milochka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Milochka>', 'Milochka (Darling)', 'song', NULL, NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Milochka>'
);


-- None 가곡 <Ty skoro menya pozabudesh'>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ty skoro menya pozabudesh''>', 'Ty skoro menya pozabudesh'' (Soon You Will Forget Me)', 'song', NULL, NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ty skoro menya pozabudesh''>'
);


-- None 가곡 <Pesn' Margarity>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pesn'' Margarity>', 'Pesn'' Margarity (Meine Ruh'' ist hin)', 'song', NULL, NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pesn'' Margarity>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ec2e527-7148-43ab-b8bf-bb590210516e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ec2e527-7148-43ab-b8bf-bb590210516e'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Pesn'' Margarity>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ec2e527-7148-43ab-b8bf-bb590210516e'
);


-- None 가곡 <Zazdravnyy kubok>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Zazdravnyy kubok>', 'Zazdravnyy kubok (The Toasting Cup)', 'song', NULL, NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Zazdravnyy kubok>'
);


-- None 가곡 <Slyshu li golos tvoy>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Slyshu li golos tvoy>', 'Slyshu li golos tvoy (When I Hear Your Voice)', 'song', NULL, NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Slyshu li golos tvoy>'
);


-- None 가곡 <Adel'>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Adel''>', 'Adel'' (Adèle)', 'song', NULL, NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Adel''>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0fe4e962-7450-4639-9e50-4351787a708b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0fe4e962-7450-4639-9e50-4351787a708b'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Adel''>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0fe4e962-7450-4639-9e50-4351787a708b'
);


-- None 가곡 <Rozmowa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Rozmowa>', 'Rozmowa (Conversation)', 'song', NULL, NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Rozmowa>'
);


-- None 가곡 <Meri>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Meri>', 'Meri (Mary)', 'song', NULL, NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Meri>'
);


-- None 가곡 <Finskiy zaliv>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Finskiy zaliv>', 'Finskiy zaliv (The Gulf of Finland)', 'song', NULL, NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Finskiy zaliv>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '333f638b-abb0-441f-803e-f57267200c62'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '333f638b-abb0-441f-803e-f57267200c62'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '가곡 <Finskiy zaliv>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '333f638b-abb0-441f-803e-f57267200c62'
);


-- None 가곡 <Akh, kogda b ya prezhde znala...>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Akh, kogda b ya prezhde znala...>', 'Akh, kogda b ya prezhde znala... (Oh, If I Had Known...)', 'song', NULL, NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Akh, kogda b ya prezhde znala...>'
);


-- None 가곡 <Ne govori, chto serdtsu bol'no>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ne govori, chto serdtsu bol''no>', 'Ne govori, chto serdtsu bol''no (Say Not That It Grieves the Heart)', 'song', NULL, NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ne govori, chto serdtsu bol''no>'
);


-- None 3중창 <Da ispravitsya molitva moya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3중창 <Da ispravitsya molitva moya>', 'Da ispravitsya molitva moya (Let My Prayer Be Fulfilled)', 'song', NULL, NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3중창 <Da ispravitsya molitva moya>'
);


-- None 3중창 <Gimn voskreseniya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3중창 <Gimn voskreseniya>', 'Gimn voskreseniya (Resurrection Hymn)', 'song', NULL, NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 38
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3중창 <Gimn voskreseniya>'
);

