-- 요한 슈타미츠(composer_id 24) 작품 목록. 지금은 클라리넷·트럼펫 협주곡과 신포니아 D장조 Op. 3, No. 2 세 곡뿐이다.
-- 새 작품 21개(관현악 3중주 Op. 1·Op. 4·Op. 5, 교향곡 Op. 3·Op. 4·Op. 11·「만하임」 2·3번, 플루트·비올라·바이올린 협주곡,
-- 바이올린 소나타 Op. 6, 무반주 바이올린 디베르티멘토), 묶음 안 곡·악장 127개, 장르·형식.
--
-- 작품은 손으로 고르고 곡은 MusicBrainz parts 순서대로 붙였다. 자료와 생성기:
--   seed_pipeline/curation/composer-catalog-2026-11-12/(build.py, stamitz/works.tsv) → catalog-wave4 gen_catalog.py
-- MusicBrainz 에서 아들 카를 슈타미츠 곡으로 보이는 것(클라리넷·바순 협주곡, 오보에 4중주, 비올라 소나타, 오르간 협주곡)과
-- 마오 작으로 보는 「만하임 1번」은 넣지 않았다. 기존 세 곡은 제목·설명·링크를 두고 MBID 와 악장만 잇는다.
-- 장르·형식은 비어 있을 때만 채운다. 두 번 돌려도 같다.

-- KaiS 55 클라리넷 협주곡 B♭장조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 110 AND p.composer_id = 24 AND part.part_key = 'musicbrainz:6505102a-017b-4f45-a16d-b80c6d2c492f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6505102a-017b-4f45-a16d-b80c6d2c492f', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 110 AND p.composer_id = 24
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6505102a-017b-4f45-a16d-b80c6d2c492f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 110 AND p.composer_id = 24 AND part.part_key = 'musicbrainz:fcf87b58-db8f-4f0f-8769-fefd0daff7dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcf87b58-db8f-4f0f-8769-fefd0daff7dd', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 110 AND p.composer_id = 24
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcf87b58-db8f-4f0f-8769-fefd0daff7dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Poco presto', part.name_en = 'III. Poco presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 110 AND p.composer_id = 24 AND part.part_key = 'musicbrainz:9bf13e44-bfad-4dd1-9616-efec47c44463' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bf13e44-bfad-4dd1-9616-efec47c44463', 3, 'III', 'Poco presto', 'III. Poco presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 110 AND p.composer_id = 24
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bf13e44-bfad-4dd1-9616-efec47c44463'
);


-- Op. 3, No. 2 신포니아 D장조 "만하임"

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d31184a-9ed8-41e7-902c-33ddad3b8fd2'
FROM pieces p
WHERE p.id = 111 AND p.composer_id = 24
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d31184a-9ed8-41e7-902c-33ddad3b8fd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Presto', part.name_en = 'I. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 111 AND p.composer_id = 24 AND part.part_key = 'musicbrainz:c24d5e01-cacf-4fe5-a659-3a9f4bc19a56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c24d5e01-cacf-4fe5-a659-3a9f4bc19a56', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 111 AND p.composer_id = 24
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c24d5e01-cacf-4fe5-a659-3a9f4bc19a56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino', part.name_en = 'II. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 111 AND p.composer_id = 24 AND part.part_key = 'musicbrainz:5d75f346-f582-42ff-a1fa-e7652057e71d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d75f346-f582-42ff-a1fa-e7652057e71d', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 111 AND p.composer_id = 24
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d75f346-f582-42ff-a1fa-e7652057e71d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '미뉴에트', part.name_en = 'III. Menuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 111 AND p.composer_id = 24 AND part.part_key = 'musicbrainz:89e2922d-bbb3-48bb-bbd0-fae55eb5413b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89e2922d-bbb3-48bb-bbd0-fae55eb5413b', 3, 'III', '미뉴에트', 'III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 111 AND p.composer_id = 24
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89e2922d-bbb3-48bb-bbd0-fae55eb5413b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Prestissimo', part.name_en = 'IV. Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 111 AND p.composer_id = 24 AND part.part_key = 'musicbrainz:1d94d656-80e7-4616-8de5-9e04fca40f83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d94d656-80e7-4616-8de5-9e04fca40f83', 4, 'IV', 'Prestissimo', 'IV. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 111 AND p.composer_id = 24
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d94d656-80e7-4616-8de5-9e04fca40f83'
);


-- KaiS 49 트럼펫 협주곡 D장조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo presto', part.name_en = 'I. Allegro non troppo presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 112 AND p.composer_id = 24 AND part.part_key = 'musicbrainz:7976fb35-dd0d-3ba9-9c74-1c14dd2898d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7976fb35-dd0d-3ba9-9c74-1c14dd2898d9', 1, 'I', 'Allegro non troppo presto', 'I. Allegro non troppo presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 112 AND p.composer_id = 24
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7976fb35-dd0d-3ba9-9c74-1c14dd2898d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 112 AND p.composer_id = 24 AND part.part_key = 'musicbrainz:c8352732-6ce3-3659-a115-d954cd53843a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8352732-6ce3-3659-a115-d954cd53843a', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 112 AND p.composer_id = 24
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8352732-6ce3-3659-a115-d954cd53843a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto', part.name_en = 'III. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 112 AND p.composer_id = 24 AND part.part_key = 'musicbrainz:212cc1d9-1b4f-30bf-a0e0-d4f92377e87b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:212cc1d9-1b4f-30bf-a0e0-d4f92377e87b', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 112 AND p.composer_id = 24
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:212cc1d9-1b4f-30bf-a0e0-d4f92377e87b'
);


-- Op. 1 관현악 3중주 Op. 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 3중주 Op. 1', '6 Orchestral Trios, op. 1', 'album', NULL, 'Op.', '1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 3중주 Op. 1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8bd550c8-5597-4fc2-994e-b46d0be340b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8bd550c8-5597-4fc2-994e-b46d0be340b3'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8bd550c8-5597-4fc2-994e-b46d0be340b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a458a7f0-34fa-45e7-9c16-6f204eeff308', 1, NULL, '관현악 3중주 1번 C장조', 'Orchestral Trio in C major, op. 1 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a458a7f0-34fa-45e7-9c16-6f204eeff308'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b3c4fa08-30a6-41da-822f-87bf69c1cac6', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a458a7f0-34fa-45e7-9c16-6f204eeff308'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3c4fa08-30a6-41da-822f-87bf69c1cac6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa6edab6-3016-4d2e-a8c0-1f8d5fb033c7', 2, 'II', 'Andante ma non adagio', 'II. Andante ma non adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a458a7f0-34fa-45e7-9c16-6f204eeff308'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa6edab6-3016-4d2e-a8c0-1f8d5fb033c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fba73189-e754-4b85-a71a-93be1a3aa501', 3, 'III', '미뉴에트', 'III. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a458a7f0-34fa-45e7-9c16-6f204eeff308'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fba73189-e754-4b85-a71a-93be1a3aa501'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:476222ca-d2d3-4ab9-9f12-b762fac4476d', 4, 'IV', 'Prestissimo', 'IV. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a458a7f0-34fa-45e7-9c16-6f204eeff308'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:476222ca-d2d3-4ab9-9f12-b762fac4476d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9bffca8-5319-4c66-95d0-7b54f529ca02', 2, NULL, '관현악 3중주 2번 A장조', 'Orchestral Trio in A major, op. 1 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9bffca8-5319-4c66-95d0-7b54f529ca02'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b7c8cd4-704f-4f1d-9dfc-36da808eec0c', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9bffca8-5319-4c66-95d0-7b54f529ca02'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b7c8cd4-704f-4f1d-9dfc-36da808eec0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:561166f5-f032-4706-ab80-3f6ed4dbe189', 2, 'II', 'Andante poco adagio', 'II. Andante poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9bffca8-5319-4c66-95d0-7b54f529ca02'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:561166f5-f032-4706-ab80-3f6ed4dbe189'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1363258-90ca-4455-b1e6-796331a3af73', 3, 'III', '미뉴에트', 'III. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9bffca8-5319-4c66-95d0-7b54f529ca02'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1363258-90ca-4455-b1e6-796331a3af73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67a9460f-bfdf-4d81-9f4f-036f1ed7901c', 4, 'IV', 'Prestissimo', 'IV. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9bffca8-5319-4c66-95d0-7b54f529ca02'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67a9460f-bfdf-4d81-9f4f-036f1ed7901c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0daa895a-72b0-4d6c-8e9f-7ea999838090', 3, NULL, '관현악 3중주 3번 F장조', 'Orchestral Trio in F major, op. 1 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0daa895a-72b0-4d6c-8e9f-7ea999838090'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c0ff39d-d8e7-4922-886b-f9026ef43f58', 1, 'I', 'Allegro molto', 'I. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0daa895a-72b0-4d6c-8e9f-7ea999838090'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c0ff39d-d8e7-4922-886b-f9026ef43f58'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5b801d77-40a0-458f-95db-299c60a6713b', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0daa895a-72b0-4d6c-8e9f-7ea999838090'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b801d77-40a0-458f-95db-299c60a6713b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fd651f22-fc94-4286-8abb-43c0c0a9c384', 3, 'III', '미뉴에트', 'III. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0daa895a-72b0-4d6c-8e9f-7ea999838090'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd651f22-fc94-4286-8abb-43c0c0a9c384'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f4a3561-e896-4ce3-89ab-0b59510eadb3', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0daa895a-72b0-4d6c-8e9f-7ea999838090'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f4a3561-e896-4ce3-89ab-0b59510eadb3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:915aaa28-20f8-4fd5-a36d-0a1f2bd5b901', 4, NULL, '관현악 3중주 4번 D장조', 'Orchestral Trio in D major, op. 1 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:915aaa28-20f8-4fd5-a36d-0a1f2bd5b901'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84f2af70-eeef-483f-926d-01c6ed53cc89', 1, 'I', 'Presto assai', 'I. Presto assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:915aaa28-20f8-4fd5-a36d-0a1f2bd5b901'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84f2af70-eeef-483f-926d-01c6ed53cc89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:60aace64-981d-44fd-9ae6-7c0c067107a2', 2, 'II', 'Andante ma non adagio', 'II. Andante ma non adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:915aaa28-20f8-4fd5-a36d-0a1f2bd5b901'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60aace64-981d-44fd-9ae6-7c0c067107a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7ff5a296-9d1c-4bfd-a02c-f6048b94f1aa', 3, 'III', '미뉴에트', 'III. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:915aaa28-20f8-4fd5-a36d-0a1f2bd5b901'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ff5a296-9d1c-4bfd-a02c-f6048b94f1aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:45268940-d238-41e1-90f0-171e02c1538c', 4, 'IV', 'Allegro spirito', 'IV. Allegro spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:915aaa28-20f8-4fd5-a36d-0a1f2bd5b901'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45268940-d238-41e1-90f0-171e02c1538c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dc0c9cc-8bd0-4f70-abe3-fbf24fa4a567', 5, NULL, '관현악 3중주 5번 B♭장조', 'Orchestral Trio in B-flat major, op. 1 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dc0c9cc-8bd0-4f70-abe3-fbf24fa4a567'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c4480a3-cb5a-40b7-a72f-e34944547bee', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3dc0c9cc-8bd0-4f70-abe3-fbf24fa4a567'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c4480a3-cb5a-40b7-a72f-e34944547bee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b433ec9b-a671-4072-b650-e2a124acbe9d', 2, 'II', 'Lento', 'II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3dc0c9cc-8bd0-4f70-abe3-fbf24fa4a567'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b433ec9b-a671-4072-b650-e2a124acbe9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3489caa2-13a1-4389-9447-536362f0113b', 3, 'III', '미뉴에트', 'III. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3dc0c9cc-8bd0-4f70-abe3-fbf24fa4a567'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3489caa2-13a1-4389-9447-536362f0113b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e370703b-ed3b-4485-8b67-195cb479db14', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3dc0c9cc-8bd0-4f70-abe3-fbf24fa4a567'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e370703b-ed3b-4485-8b67-195cb479db14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd997f1f-5828-4a58-853d-1766c1033ca7', 6, NULL, '관현악 3중주 6번 F장조', 'Orchestral Trio in F major, op. 1 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd997f1f-5828-4a58-853d-1766c1033ca7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73c04be5-db4c-4f5e-9e5b-1ee088b3e836', 1, 'I', 'Allegro di molto', 'I. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd997f1f-5828-4a58-853d-1766c1033ca7'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73c04be5-db4c-4f5e-9e5b-1ee088b3e836'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78aa4839-c351-49eb-9430-2db748d67cad', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd997f1f-5828-4a58-853d-1766c1033ca7'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78aa4839-c351-49eb-9430-2db748d67cad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e8cc9a7f-9438-4d74-ab61-59c765a02777', 3, 'III', '미뉴에트', 'III. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd997f1f-5828-4a58-853d-1766c1033ca7'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8cc9a7f-9438-4d74-ab61-59c765a02777'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff4095c8-c809-40de-8a8e-3ca7fff6fab6', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd997f1f-5828-4a58-853d-1766c1033ca7'
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff4095c8-c809-40de-8a8e-3ca7fff6fab6'
);


-- Op. 4, No. 3 관현악 3중주 C단조 Op. 4, No. 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 3중주 C단조 Op. 4, No. 3', 'Orchestral Trio in C minor, op. 4 no. 3', 'album', NULL, 'Op.', '4, No. 3', NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 3중주 C단조 Op. 4, No. 3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1f33766-38f3-4280-9ae3-ffabf1991e95'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b1f33766-38f3-4280-9ae3-ffabf1991e95'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 C단조 Op. 4, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1f33766-38f3-4280-9ae3-ffabf1991e95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:775c95bc-fb7d-4c0d-a496-195e47a3182e', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 C단조 Op. 4, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:775c95bc-fb7d-4c0d-a496-195e47a3182e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:984831c8-cef7-4218-b2e6-aa3723adf157', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 C단조 Op. 4, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:984831c8-cef7-4218-b2e6-aa3723adf157'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c80fd5d9-5654-4f79-a0eb-41b024239a20', 3, 'III', '미뉴에트', 'III. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 C단조 Op. 4, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c80fd5d9-5654-4f79-a0eb-41b024239a20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:759b3a65-e226-4388-a31a-241b7c9828b8', 4, 'IV', 'Prestissimo', 'IV. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 C단조 Op. 4, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:759b3a65-e226-4388-a31a-241b7c9828b8'
);


-- Op. 5, No. 3 관현악 3중주 E장조 Op. 5, No. 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 3중주 E장조 Op. 5, No. 3', 'Orchestral Trio in E major, op. 5 no. 3', 'album', NULL, 'Op.', '5, No. 3', NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 3중주 E장조 Op. 5, No. 3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2213bd5-2205-4e67-aecf-e1046f895b4b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b2213bd5-2205-4e67-aecf-e1046f895b4b'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 E장조 Op. 5, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2213bd5-2205-4e67-aecf-e1046f895b4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:320d0586-b686-4171-9200-cb724950a451', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 E장조 Op. 5, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:320d0586-b686-4171-9200-cb724950a451'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fa497eb-f6e5-4380-b8b0-7c30dc3a3f84', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 E장조 Op. 5, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fa497eb-f6e5-4380-b8b0-7c30dc3a3f84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0154e4fc-9e4e-4081-9b92-e8a4c2bfee24', 3, 'III', '미뉴에트', 'III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 E장조 Op. 5, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0154e4fc-9e4e-4081-9b92-e8a4c2bfee24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1042586-8077-4dab-aa3a-d28348bbfbeb', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 E장조 Op. 5, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1042586-8077-4dab-aa3a-d28348bbfbeb'
);


-- Op. 3, No. 1 교향곡 G장조 Op. 3, No. 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 G장조 Op. 3, No. 1', 'Symphony in G major, op. 3 no. 1, WolS G2', 'album', NULL, 'Op.', '3, No. 1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 G장조 Op. 3, No. 1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59f013aa-bdcc-41e1-9c5a-ddd9da94b1ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '59f013aa-bdcc-41e1-9c5a-ddd9da94b1ef'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 G장조 Op. 3, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59f013aa-bdcc-41e1-9c5a-ddd9da94b1ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:154d70cc-15e8-4f78-b521-faf87662a5df', 1, 'I', 'Presto assai', 'I. Presto assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 G장조 Op. 3, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:154d70cc-15e8-4f78-b521-faf87662a5df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0fed31d-c081-4abf-91ca-36272b9eacfb', 2, 'II', 'Andante non adagio', 'II. Andante non adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 G장조 Op. 3, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0fed31d-c081-4abf-91ca-36272b9eacfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85141dc4-11fd-4425-b977-a7edfa2b35ac', 3, 'III', '미뉴에트', 'III. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 G장조 Op. 3, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85141dc4-11fd-4425-b977-a7edfa2b35ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e544c6ce-0153-4090-abc2-fc8dfdc69fee', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 G장조 Op. 3, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e544c6ce-0153-4090-abc2-fc8dfdc69fee'
);


-- Op. 3, No. 3 교향곡 G장조 Op. 3, No. 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 G장조 Op. 3, No. 3', 'Symphony in G major, op. 3 no. 3, WolS G3', 'album', NULL, 'Op.', '3, No. 3', NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 G장조 Op. 3, No. 3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bf793a7-d4ab-4b96-bc65-8d7e3055f73d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5bf793a7-d4ab-4b96-bc65-8d7e3055f73d'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 G장조 Op. 3, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bf793a7-d4ab-4b96-bc65-8d7e3055f73d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89d14018-9908-40ea-a11d-30f864027bbf', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 G장조 Op. 3, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89d14018-9908-40ea-a11d-30f864027bbf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:813186f2-feec-4e12-89b0-68a55e95ba23', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 G장조 Op. 3, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:813186f2-feec-4e12-89b0-68a55e95ba23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8095571a-c1f1-4fac-85af-7444ffaf48c1', 3, 'III', '미뉴에트', 'III. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 G장조 Op. 3, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8095571a-c1f1-4fac-85af-7444ffaf48c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7537d416-2e7c-46ac-8d58-00d6647d2247', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 G장조 Op. 3, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7537d416-2e7c-46ac-8d58-00d6647d2247'
);


-- Op. 3, No. 4 교향곡 E♭장조 Op. 3, No. 4

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 E♭장조 Op. 3, No. 4', 'Symphony in E-flat major, op. 3 no. 4, WolS Eb3', 'album', NULL, 'Op.', '3, No. 4', NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 E♭장조 Op. 3, No. 4'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e061f85a-7014-4e23-b796-a4a87603ec2c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e061f85a-7014-4e23-b796-a4a87603ec2c'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 3, No. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e061f85a-7014-4e23-b796-a4a87603ec2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b46d623-911e-488a-8543-3d9d8ac3066c', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 3, No. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b46d623-911e-488a-8543-3d9d8ac3066c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93bad765-a7ca-4693-a914-ba150bce9ff3', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 3, No. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93bad765-a7ca-4693-a914-ba150bce9ff3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:708fd833-9d80-476a-8740-a055ada34e74', 3, 'III', 'Prestissimo', 'III. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 3, No. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:708fd833-9d80-476a-8740-a055ada34e74'
);


-- Op. 3, No. 6 교향곡 F장조 Op. 3, No. 6

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 F장조 Op. 3, No. 6', 'Symphony in F major, op. 3 no. 6, WolS F2', 'album', NULL, 'Op.', '3, No. 6', NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 F장조 Op. 3, No. 6'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59a4d8a1-e70b-48c0-8012-a40a6cc2f456'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '59a4d8a1-e70b-48c0-8012-a40a6cc2f456'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 F장조 Op. 3, No. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59a4d8a1-e70b-48c0-8012-a40a6cc2f456'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2056364f-ccf3-4414-9e06-a34e6600ba32', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 F장조 Op. 3, No. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2056364f-ccf3-4414-9e06-a34e6600ba32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef0a38eb-97dd-42b2-9f3a-e52f49e6381a', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 F장조 Op. 3, No. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef0a38eb-97dd-42b2-9f3a-e52f49e6381a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31e6f37f-acab-4f94-bd7f-6ec2cc8af375', 3, 'III', 'Presto assai', 'III. Presto assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 F장조 Op. 3, No. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31e6f37f-acab-4f94-bd7f-6ec2cc8af375'
);


-- Op. 4, No. 1 교향곡 F장조 Op. 4, No. 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 F장조 Op. 4, No. 1', 'Symphony in F major, op. 4 no. 1 (Wolf F3)', 'album', NULL, 'Op.', '4, No. 1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 F장조 Op. 4, No. 1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1fa62bcd-9dfa-4d6b-9c4a-5b3d40ef58c0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1fa62bcd-9dfa-4d6b-9c4a-5b3d40ef58c0'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 F장조 Op. 4, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1fa62bcd-9dfa-4d6b-9c4a-5b3d40ef58c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceb23a5d-25b0-4248-b565-4999dda2637b', 1, 'I', 'Allegro molto', 'I. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 F장조 Op. 4, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceb23a5d-25b0-4248-b565-4999dda2637b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afd223f3-b3e1-480d-8bac-ee27069217b9', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 F장조 Op. 4, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afd223f3-b3e1-480d-8bac-ee27069217b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:037bafa5-5298-41f4-a01a-e22dee2a4f16', 3, 'III', '미뉴에트와 트리오', 'III. Minuetto - Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 F장조 Op. 4, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:037bafa5-5298-41f4-a01a-e22dee2a4f16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f0d2d40-a399-46f2-b18f-c328ed6bcb2f', 4, 'IV', 'Presto assai', 'IV. Presto assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 F장조 Op. 4, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f0d2d40-a399-46f2-b18f-c328ed6bcb2f'
);


-- Op. 4, No. 2 신포니아 파스토랄레 D장조 Op. 4, No. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 파스토랄레 D장조 Op. 4, No. 2', 'Sinfonia Pastorale in D major, op. 4 no. 2 (Wolf D4)', 'album', NULL, 'Op.', '4, No. 2', NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 파스토랄레 D장조 Op. 4, No. 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9b2970e-f744-4172-872b-17487e7ba205'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f9b2970e-f744-4172-872b-17487e7ba205'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '신포니아 파스토랄레 D장조 Op. 4, No. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9b2970e-f744-4172-872b-17487e7ba205'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73b4ea67-ae4a-4886-86b7-ef61eea192e2', 1, 'I', 'Pastorale: Presto', 'I. Pastorale: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '신포니아 파스토랄레 D장조 Op. 4, No. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73b4ea67-ae4a-4886-86b7-ef61eea192e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55e8013b-f8c5-46ea-8e1e-1a2fc4191c68', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '신포니아 파스토랄레 D장조 Op. 4, No. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55e8013b-f8c5-46ea-8e1e-1a2fc4191c68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d59e3fc-8cf0-44a3-8c02-a92095a4d071', 3, 'III', '미뉴에트와 트리오', 'III. Minuetto - Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '신포니아 파스토랄레 D장조 Op. 4, No. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d59e3fc-8cf0-44a3-8c02-a92095a4d071'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cde0c170-98e4-4e32-b2ca-b77f916f4817', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '신포니아 파스토랄레 D장조 Op. 4, No. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cde0c170-98e4-4e32-b2ca-b77f916f4817'
);


-- Op. 4, No. 4 교향곡 E♭장조 Op. 4, No. 4

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 E♭장조 Op. 4, No. 4', 'Symphony in E-flat major, op. 4 no. 4 (Wolf Eb4)', 'album', NULL, 'Op.', '4, No. 4', NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 E♭장조 Op. 4, No. 4'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c7b484f-20a3-4d39-8d54-56cd886c3b03'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9c7b484f-20a3-4d39-8d54-56cd886c3b03'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 4, No. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c7b484f-20a3-4d39-8d54-56cd886c3b03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be942324-54d7-46fd-afa7-45d8301d9844', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 4, No. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be942324-54d7-46fd-afa7-45d8301d9844'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd508b4f-0d1b-4029-b948-645ac742c47b', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 4, No. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd508b4f-0d1b-4029-b948-645ac742c47b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:577d9212-16c7-47b3-a730-3abdbc9c0053', 3, 'III', 'Minuetto I - Minuetto II', 'III. Minuetto I - Minuetto II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 4, No. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:577d9212-16c7-47b3-a730-3abdbc9c0053'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:691887aa-70ab-4c75-b3e6-edd782bb630d', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 4, No. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:691887aa-70ab-4c75-b3e6-edd782bb630d'
);


-- Op. 4, No. 6 교향곡 E♭장조 Op. 4, No. 6

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 E♭장조 Op. 4, No. 6', 'Symphony in E-flat major, op. 4 no. 6 (Wolf Eb5)', 'album', NULL, 'Op.', '4, No. 6', NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 E♭장조 Op. 4, No. 6'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0223b299-c8aa-4c88-ae85-9f500728ddb0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0223b299-c8aa-4c88-ae85-9f500728ddb0'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 4, No. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0223b299-c8aa-4c88-ae85-9f500728ddb0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bfed0d1-0ea3-4236-a1d1-4f3fdcaa6bda', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 4, No. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bfed0d1-0ea3-4236-a1d1-4f3fdcaa6bda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2feb3c7e-b426-44e7-9c8c-aeec0fbe6c6d', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 4, No. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2feb3c7e-b426-44e7-9c8c-aeec0fbe6c6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e686b544-ebf3-4d2d-bf39-67ae48e0658c', 3, 'III', '미뉴에트와 트리오', 'III. Minuetto - Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 4, No. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e686b544-ebf3-4d2d-bf39-67ae48e0658c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3139a2e7-5fb0-4d76-80a2-6c8a89137e71', 4, 'IV', 'Prestissimo', 'IV. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 4, No. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3139a2e7-5fb0-4d76-80a2-6c8a89137e71'
);


-- Op. 11, No. 3 교향곡 E♭장조 Op. 11, No. 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 E♭장조 Op. 11, No. 3', 'Symphony in E-flat major, op. 11 no. 3', 'album', NULL, 'Op.', '11, No. 3', NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 E♭장조 Op. 11, No. 3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d7c67e8-9a7b-470d-bb62-eba46d205153'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7d7c67e8-9a7b-470d-bb62-eba46d205153'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 11, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d7c67e8-9a7b-470d-bb62-eba46d205153'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:482d7db0-8034-4777-9a0a-df0a0e85f90e', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 11, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:482d7db0-8034-4777-9a0a-df0a0e85f90e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0ba1089-3589-4038-8f17-0c8eeab35a7f', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 11, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0ba1089-3589-4038-8f17-0c8eeab35a7f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6925668d-53c0-44a7-9a8a-1ba5b7290f4b', 3, 'III', '미뉴에트', 'III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 11, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6925668d-53c0-44a7-9a8a-1ba5b7290f4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dc4086c-b57d-48d3-9a1c-a7fbad68c04a', 4, 'IV', 'Prestissimo', 'IV. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 E♭장조 Op. 11, No. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dc4086c-b57d-48d3-9a1c-a7fbad68c04a'
);


-- None 교향곡 A장조 "만하임 2번"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 A장조 "만하임 2번"', 'Symphony in A major "Mannheim no. 2"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 A장조 "만하임 2번"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee64050d-2eb3-490b-b9e9-08bbcacbebfe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ee64050d-2eb3-490b-b9e9-08bbcacbebfe'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 A장조 "만하임 2번"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee64050d-2eb3-490b-b9e9-08bbcacbebfe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27d55257-b77d-406a-8481-17caf3261708', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 A장조 "만하임 2번"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27d55257-b77d-406a-8481-17caf3261708'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd401a96-770b-4ba0-819c-6f1311c912ab', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 A장조 "만하임 2번"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd401a96-770b-4ba0-819c-6f1311c912ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b0f1a47-ea08-476e-93c7-f77efab1f6d1', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 A장조 "만하임 2번"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b0f1a47-ea08-476e-93c7-f77efab1f6d1'
);


-- None 교향곡 B♭장조 "만하임 3번"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 B♭장조 "만하임 3번"', 'Symphony in B-flat major "Mannheim no. 3"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 B♭장조 "만하임 3번"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7162152-892a-4797-b153-4594f3cf1130'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f7162152-892a-4797-b153-4594f3cf1130'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 B♭장조 "만하임 3번"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7162152-892a-4797-b153-4594f3cf1130'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2aaa88b2-9b14-440c-9a05-49b15fbdde5b', 1, 'I', 'Alla breve', 'I. Alla breve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 B♭장조 "만하임 3번"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2aaa88b2-9b14-440c-9a05-49b15fbdde5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88362a2a-4a32-4340-9799-72262817d59d', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 B♭장조 "만하임 3번"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88362a2a-4a32-4340-9799-72262817d59d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ee05a3b-4986-4caa-a73f-7872f1cb423a', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '교향곡 B♭장조 "만하임 3번"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ee05a3b-4986-4caa-a73f-7872f1cb423a'
);


-- None 4성부 신포니아 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4성부 신포니아 D장조', 'Sinfonia A 4 in D major', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4성부 신포니아 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81af196a-c580-4125-9aed-3871337b1e4e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '81af196a-c580-4125-9aed-3871337b1e4e'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '4성부 신포니아 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81af196a-c580-4125-9aed-3871337b1e4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5b16f63-8acf-423f-9bbc-d88a48fa42d1', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '4성부 신포니아 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5b16f63-8acf-423f-9bbc-d88a48fa42d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75361473-3da0-495e-9df0-d35f66674051', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '4성부 신포니아 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75361473-3da0-495e-9df0-d35f66674051'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f57aae8-1e8b-4447-b82b-735746e3fd7f', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '4성부 신포니아 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f57aae8-1e8b-4447-b82b-735746e3fd7f'
);


-- None 플루트 협주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 협주곡 C장조', 'Flute Concerto in C major', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 협주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '082c8660-8b63-4c51-93b0-1a73128e0df6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '082c8660-8b63-4c51-93b0-1a73128e0df6'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '플루트 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '082c8660-8b63-4c51-93b0-1a73128e0df6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:484fb073-24ea-4f23-804c-33d3cef2a59d', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '플루트 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:484fb073-24ea-4f23-804c-33d3cef2a59d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e062d61b-6510-423e-b5d6-58a8ce4a5c86', 2, 'II', 'Andante poco adagio', 'II. Andante poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '플루트 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e062d61b-6510-423e-b5d6-58a8ce4a5c86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b442d66-a725-48c3-95ad-7791ec835bae', 3, 'III', 'Prestissimo', 'III. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '플루트 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b442d66-a725-48c3-95ad-7791ec835bae'
);


-- None 플루트 협주곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 협주곡 G장조', 'Flute Concerto in G major', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 협주곡 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3f660c4-96b8-43fe-bd7c-dcdd88414378'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3f660c4-96b8-43fe-bd7c-dcdd88414378'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '플루트 협주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3f660c4-96b8-43fe-bd7c-dcdd88414378'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e576d89-f586-400c-8baa-91499f01381a', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '플루트 협주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e576d89-f586-400c-8baa-91499f01381a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a010226a-e19f-4f27-a955-3ed621bf3fbe', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '플루트 협주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a010226a-e19f-4f27-a955-3ed621bf3fbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7bf44eb-65b8-44eb-ab15-173df2bc787d', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '플루트 협주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7bf44eb-65b8-44eb-ab15-173df2bc787d'
);


-- None 비올라 협주곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비올라 협주곡 G장조', 'Concerto for Viola and Orchestra in G major', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비올라 협주곡 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6800232d-1cf1-45f1-98b4-27e11e569dc9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6800232d-1cf1-45f1-98b4-27e11e569dc9'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '비올라 협주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6800232d-1cf1-45f1-98b4-27e11e569dc9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:869bd397-f759-4f70-997c-fbf4dad4bb20', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '비올라 협주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:869bd397-f759-4f70-997c-fbf4dad4bb20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d5dc23e-a1b3-49ec-993a-bb45b4c8dd41', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '비올라 협주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d5dc23e-a1b3-49ec-993a-bb45b4c8dd41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68191bb3-7e64-4dae-9476-e54373c13cae', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '비올라 협주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68191bb3-7e64-4dae-9476-e54373c13cae'
);


-- None 바이올린 협주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 C장조', 'Konzert für Violine und Streichorchester C-Dur', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '195c9c95-bf1f-4e0c-bca5-01586597eef0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '195c9c95-bf1f-4e0c-bca5-01586597eef0'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '바이올린 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '195c9c95-bf1f-4e0c-bca5-01586597eef0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a978b5b-bc41-423a-bf96-01cf4403a655', 1, 'I', 'Allegro non molto', 'I. Allegro non molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '바이올린 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a978b5b-bc41-423a-bf96-01cf4403a655'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ec8f918-06db-4150-a9b6-6b0cc2961e2b', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '바이올린 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ec8f918-06db-4150-a9b6-6b0cc2961e2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee37339f-26cb-4025-a843-83609bc7c858', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '바이올린 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee37339f-26cb-4025-a843-83609bc7c858'
);


-- Op. 6 바이올린 소나타 Op. 6

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 Op. 6', '6 Violin Sonatas, op. 6', 'album', NULL, 'Op.', '6', NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 Op. 6'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e24127c6-f9aa-4bdb-a0c0-eefad4007eef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e24127c6-f9aa-4bdb-a0c0-eefad4007eef'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e24127c6-f9aa-4bdb-a0c0-eefad4007eef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d9fd17a-58f0-4a36-997d-2867802a32ff', 1, NULL, '바이올린 소나타 1번 G장조', 'Violin Sonata in G major, op. 6 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d9fd17a-58f0-4a36-997d-2867802a32ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b337e650-aae9-47fa-b8b2-29bf503448ec', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d9fd17a-58f0-4a36-997d-2867802a32ff'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b337e650-aae9-47fa-b8b2-29bf503448ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69c8bd3f-20ed-4453-a1ea-6f49f9934b2c', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d9fd17a-58f0-4a36-997d-2867802a32ff'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69c8bd3f-20ed-4453-a1ea-6f49f9934b2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:703714f7-ac01-4fbd-92f7-2ce868c5ce55', 3, 'III', '미뉴에트', 'III. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d9fd17a-58f0-4a36-997d-2867802a32ff'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:703714f7-ac01-4fbd-92f7-2ce868c5ce55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45d77207-aa0c-4bdf-aa0d-7cbb04177954', 2, NULL, '바이올린 소나타 2번 C장조', 'Violin Sonata in C major, op. 6 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45d77207-aa0c-4bdf-aa0d-7cbb04177954'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7fff5cad-3dc5-43b4-90a9-e77de4347461', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:45d77207-aa0c-4bdf-aa0d-7cbb04177954'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fff5cad-3dc5-43b4-90a9-e77de4347461'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88d7911d-d0d6-43c7-bd8b-6245662206a6', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:45d77207-aa0c-4bdf-aa0d-7cbb04177954'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88d7911d-d0d6-43c7-bd8b-6245662206a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:40e1bc78-f79e-4a84-986f-26db870e73cb', 3, 'III', '미뉴에트', 'III. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:45d77207-aa0c-4bdf-aa0d-7cbb04177954'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40e1bc78-f79e-4a84-986f-26db870e73cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb94e9ae-7a42-4ea8-9a04-148e26da0f66', 3, NULL, '바이올린 소나타 3번 E♭장조', 'Violin Sonata in E-flat major, op. 6 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb94e9ae-7a42-4ea8-9a04-148e26da0f66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e563b43e-ff19-4d50-ab60-18fdc17903f6', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eb94e9ae-7a42-4ea8-9a04-148e26da0f66'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e563b43e-ff19-4d50-ab60-18fdc17903f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b885905e-1988-4735-baa6-aa201fbe0e92', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eb94e9ae-7a42-4ea8-9a04-148e26da0f66'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b885905e-1988-4735-baa6-aa201fbe0e92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59a58758-15b8-4260-bf10-9f9745bba404', 3, 'III', '미뉴에트', 'III. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eb94e9ae-7a42-4ea8-9a04-148e26da0f66'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59a58758-15b8-4260-bf10-9f9745bba404'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36f27944-c11b-4d6e-90d9-e332ffdbf63a', 4, NULL, '바이올린 소나타 4번 A장조', 'Violin Sonata in A major, op. 6 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36f27944-c11b-4d6e-90d9-e332ffdbf63a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d09344a0-9a8c-4004-b432-d802e4139663', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36f27944-c11b-4d6e-90d9-e332ffdbf63a'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d09344a0-9a8c-4004-b432-d802e4139663'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8e79abef-f078-4cee-82a5-24dd2c8868e1', 2, 'II', 'Allegro ma non troppo', 'II. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36f27944-c11b-4d6e-90d9-e332ffdbf63a'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e79abef-f078-4cee-82a5-24dd2c8868e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41de4ce7-69f5-44a6-b855-ed07e96dffb0', 3, 'III', '미뉴에트', 'III. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36f27944-c11b-4d6e-90d9-e332ffdbf63a'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41de4ce7-69f5-44a6-b855-ed07e96dffb0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84591090-13dd-4398-85f5-47f7d87d55f4', 5, NULL, '바이올린 소나타 5번 D장조', 'Violin Sonata in D major, op. 6 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84591090-13dd-4398-85f5-47f7d87d55f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41a954cc-fbaa-404f-bc1f-d8b97d123e73', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84591090-13dd-4398-85f5-47f7d87d55f4'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41a954cc-fbaa-404f-bc1f-d8b97d123e73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e1d5fefb-2a89-4072-9a76-557189a7b129', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84591090-13dd-4398-85f5-47f7d87d55f4'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1d5fefb-2a89-4072-9a76-557189a7b129'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e1f9cef5-4fa6-4829-8c46-63119ced4fb3', 3, 'III', '미뉴에트', 'III. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84591090-13dd-4398-85f5-47f7d87d55f4'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1f9cef5-4fa6-4829-8c46-63119ced4fb3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbf5fca7-3033-4144-b015-d318bdfc8160', 6, NULL, '바이올린 소나타 6번 B♭장조', 'Violin Sonata in B-flat major, op. 6 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbf5fca7-3033-4144-b015-d318bdfc8160'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04c6939f-0854-46c1-a669-01751e5761db', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dbf5fca7-3033-4144-b015-d318bdfc8160'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04c6939f-0854-46c1-a669-01751e5761db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:51b38647-22a2-49d7-b2b4-bed0be1089e4', 2, 'II', 'Allegro cantabile', 'II. Allegro cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dbf5fca7-3033-4144-b015-d318bdfc8160'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51b38647-22a2-49d7-b2b4-bed0be1089e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee71256a-1c52-4e7c-b372-f0e4bbd08138', 3, 'III', 'Tempo di Minuetto', 'III. Tempo di Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dbf5fca7-3033-4144-b015-d318bdfc8160'
WHERE p.composer_id = 24 AND p.title = '바이올린 소나타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee71256a-1c52-4e7c-b372-f0e4bbd08138'
);


-- None 무반주 바이올린을 위한 2개의 디베르티멘토

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무반주 바이올린을 위한 2개의 디베르티멘토', '2 Divertimenti for Solo Violin', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 24
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무반주 바이올린을 위한 2개의 디베르티멘토'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '153404bc-dc47-48d6-af1f-3066b73c0ade'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '153404bc-dc47-48d6-af1f-3066b73c0ade'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '무반주 바이올린을 위한 2개의 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '153404bc-dc47-48d6-af1f-3066b73c0ade'
);


-- 장르·형식(works.tsv). 비어 있을 때만 채운다.
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 24 AND title = '관현악 3중주 Op. 1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 24 AND title = '관현악 3중주 C단조 Op. 4, No. 3' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 24 AND title = '관현악 3중주 E장조 Op. 5, No. 3' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 24 AND title = '교향곡 G장조 Op. 3, No. 1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 24 AND title = '교향곡 G장조 Op. 3, No. 3' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 24 AND title = '교향곡 E♭장조 Op. 3, No. 4' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 24 AND title = '교향곡 F장조 Op. 3, No. 6' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 24 AND title = '교향곡 F장조 Op. 4, No. 1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 24 AND title = '신포니아 파스토랄레 D장조 Op. 4, No. 2' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 24 AND title = '교향곡 E♭장조 Op. 4, No. 4' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 24 AND title = '교향곡 E♭장조 Op. 4, No. 6' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 24 AND title = '교향곡 E♭장조 Op. 11, No. 3' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 24 AND title = '교향곡 A장조 "만하임 2번"' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 24 AND title = '교향곡 B♭장조 "만하임 3번"' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'sinfonia'
WHERE composer_id = 24 AND title = '4성부 신포니아 D장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 24 AND title = '플루트 협주곡 C장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 24 AND title = '플루트 협주곡 G장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 24 AND title = '비올라 협주곡 G장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'violin_concerto'
WHERE composer_id = 24 AND title = '바이올린 협주곡 C장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'duo_sonata'
WHERE composer_id = 24 AND title = '바이올린 소나타 Op. 6' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 24 AND title = '무반주 바이올린을 위한 2개의 디베르티멘토' AND genre IS NULL AND form_key IS NULL;
