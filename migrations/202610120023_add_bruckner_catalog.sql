-- 브루크너 작품을 출판 단위로 채운다(카탈로그: WAB). 작품 126개(묶음 8, 다악장 23, 낱곡 95),
-- 새 작품 122개, 기존 작품 4개, part 132개, 그 아래 0개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   번호 하나 = 작품 하나(글자 붙은 판은 합친다). 교향곡은 판이 여럿이어도 작품 하나이고 00번·0번도 넣는다. WAB 밖(deest) 곡은 뺀다.
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

-- WAB 1 모테트 <Afferentur regi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Afferentur regi>', 'Offertory "Afferentur regi" in F major', 'song', 'WAB 1', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Afferentur regi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccc0b185-b30e-41ec-be58-1c597233bcf9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ccc0b185-b30e-41ec-be58-1c597233bcf9'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Afferentur regi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccc0b185-b30e-41ec-be58-1c597233bcf9'
);


-- WAB 2 합창곡 <Am Grabe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Am Grabe>', '"Am Grabe" in F minor', 'song', 'WAB 2', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Am Grabe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6e8248a-ff45-4bb3-9b7a-280695223d05'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a6e8248a-ff45-4bb3-9b7a-280695223d05'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '합창곡 <Am Grabe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6e8248a-ff45-4bb3-9b7a-280695223d05'
);


-- WAB 3 모테트 <Asperges me> 2곡 WAB 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Asperges me> 2곡 WAB 3', '2 Asperges me, WAB 3', 'album', NULL, 'WAB', '3', 1845, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Asperges me> 2곡 WAB 3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bruckner:bruckner-wab3:1', 1, NULL, '에올리아 선법', 'No. 1 (Aeolian mode)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Asperges me> 2곡 WAB 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bruckner:bruckner-wab3:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bruckner:bruckner-wab3:2', 2, NULL, 'F장조', 'No. 2 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Asperges me> 2곡 WAB 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bruckner:bruckner-wab3:2'
);


-- WAB 4 모테트 <Asperges me> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Asperges me> F장조', 'Antiphon "Asperges me" in F major', 'song', 'WAB 4', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Asperges me> F장조'
);


-- WAB 5 모테트 <Ave Maria> (1856)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Ave Maria> (1856)', '"Ave Maria" in F major (1856)', 'song', 'WAB 5', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Ave Maria> (1856)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a44bd8a-6b29-4ef5-8393-6d76bfa19818'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4a44bd8a-6b29-4ef5-8393-6d76bfa19818'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Ave Maria> (1856)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a44bd8a-6b29-4ef5-8393-6d76bfa19818'
);


-- WAB 6 모테트 <Ave Maria> (1861)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Ave Maria> (1861)', '"Ave Maria" in F major (1861)', 'song', 'WAB 6', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Ave Maria> (1861)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7135e602-95df-4f04-a0c9-904c01568f93'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7135e602-95df-4f04-a0c9-904c01568f93'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Ave Maria> (1861)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7135e602-95df-4f04-a0c9-904c01568f93'
);


-- WAB 7 가곡 <Ave Maria> (1882)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ave Maria> (1882)', '"Ave Maria" in F major for alto and keyboard (1882)', 'song', 'WAB 7', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ave Maria> (1882)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '976b1e3f-fe20-4a49-80f8-06a38bbc988a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '976b1e3f-fe20-4a49-80f8-06a38bbc988a'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '가곡 <Ave Maria> (1882)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '976b1e3f-fe20-4a49-80f8-06a38bbc988a'
);


-- WAB 8 모테트 <Ave Regina caelorum>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Ave Regina caelorum>', 'Antiphon "Ave Regina caelorum"', 'song', 'WAB 8', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Ave Regina caelorum>'
);


-- WAB 9 성목요일 미사 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성목요일 미사 F장조', 'Messe für den Gründonnerstag in F major', 'song', 'WAB 9', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성목요일 미사 F장조'
);


-- WAB 10 모테트 <Christus factus est> (1873)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Christus factus est> (1873)', 'Gradual "Christus factus est" in D minor (1873)', 'song', 'WAB 10', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Christus factus est> (1873)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1d05d30d-044f-4e4c-b4a5-d03fce0387f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1d05d30d-044f-4e4c-b4a5-d03fce0387f5'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Christus factus est> (1873)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1d05d30d-044f-4e4c-b4a5-d03fce0387f5'
);


-- WAB 11 모테트 <Christus factus est> (1884)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Christus factus est> (1884)', 'Gradual "Christus factus est" in D minor (1884)', 'song', 'WAB 11', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Christus factus est> (1884)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4132bec9-59ab-38a8-9d9a-9aaa80d9d67a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4132bec9-59ab-38a8-9d9a-9aaa80d9d67a'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Christus factus est> (1884)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4132bec9-59ab-38a8-9d9a-9aaa80d9d67a'
);


-- WAB 12 코랄 <Dir, Herr, dir will ich mich ergeben>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '코랄 <Dir, Herr, dir will ich mich ergeben>', 'Chorale "Dir, Herr, dir will ich mich ergeben" in A major', 'song', 'WAB 12', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '코랄 <Dir, Herr, dir will ich mich ergeben>'
);


-- WAB 13 모테트 <Ecce sacerdos magnus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Ecce sacerdos magnus>', 'Antiphon "Ecce sacerdos magnus" in A minor', 'song', 'WAB 13', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Ecce sacerdos magnus>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68ad5dd7-8e85-4e17-a980-9930a22d6ecb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '68ad5dd7-8e85-4e17-a980-9930a22d6ecb'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Ecce sacerdos magnus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68ad5dd7-8e85-4e17-a980-9930a22d6ecb'
);


-- WAB 14 칸타타 <Entsagen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Entsagen>', 'Cantata "Entsagen" in B♭ major', 'song', 'WAB 14', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Entsagen>'
);


-- WAB 15 축전가 <St. Jodok spross aus edlem Stamm>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '축전가 <St. Jodok spross aus edlem Stamm>', 'Festgesang "St. Jodok spross aus edlem Stamm" in C major', 'song', 'WAB 15', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '축전가 <St. Jodok spross aus edlem Stamm>'
);


-- WAB 16 축전 칸타타 <Preiset den Herrn>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '축전 칸타타 <Preiset den Herrn>', 'Festive Cantata "Preiset den Herrn" in D major', 'song', 'WAB 16', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '축전 칸타타 <Preiset den Herrn>'
);


-- WAB 17 코랄 <In jener letzten der Nächte>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '코랄 <In jener letzten der Nächte>', 'Chorale "In jener letzten der Nächte" in F minor', 'song', 'WAB 17', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '코랄 <In jener letzten der Nächte>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f0b3f6c-d76b-4759-83be-fc14206952c4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f0b3f6c-d76b-4759-83be-fc14206952c4'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '코랄 <In jener letzten der Nächte>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f0b3f6c-d76b-4759-83be-fc14206952c4'
);


-- WAB 18 모테트 <Iam lucis orto sidere>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Iam lucis orto sidere>', 'Hymn "Iam lucis orto sidere"', 'song', 'WAB 18', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Iam lucis orto sidere>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d03ace7-d571-4d8c-a89b-3979ec893b13'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5d03ace7-d571-4d8c-a89b-3979ec893b13'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Iam lucis orto sidere>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d03ace7-d571-4d8c-a89b-3979ec893b13'
);


-- WAB 19 모테트 <Inveni David>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Inveni David>', 'Offertory "Inveni David" in F minor', 'song', 'WAB 19', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Inveni David>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a447eaba-64d0-4760-8fd0-146364440fad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a447eaba-64d0-4760-8fd0-146364440fad'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Inveni David>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a447eaba-64d0-4760-8fd0-146364440fad'
);


-- WAB 21 모테트 <Libera me> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Libera me> F장조', '"Libera me" in F major', 'song', 'WAB 21', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Libera me> F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06b3bfe2-89db-44e1-ad8c-2f0596ef9abe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06b3bfe2-89db-44e1-ad8c-2f0596ef9abe'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Libera me> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06b3bfe2-89db-44e1-ad8c-2f0596ef9abe'
);


-- WAB 22 모테트 <Libera me> F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Libera me> F단조', '"Libera me" in F minor', 'song', 'WAB 22', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Libera me> F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1deb5cf-9cd6-4553-a285-df17f21c1dc7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd1deb5cf-9cd6-4553-a285-df17f21c1dc7'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Libera me> F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1deb5cf-9cd6-4553-a285-df17f21c1dc7'
);


-- WAB 24 마니피캇 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마니피캇 B♭장조', 'Magnificat in B♭ major', 'song', 'WAB 24', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마니피캇 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c487f22-ec3d-4c97-9b2b-375b397803d7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c487f22-ec3d-4c97-9b2b-375b397803d7'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '마니피캇 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c487f22-ec3d-4c97-9b2b-375b397803d7'
);


-- WAB 25 빈트하그 미사 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '빈트하그 미사 C장조', 'Windhaager Messe in C major', 'album', 'WAB 25', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '빈트하그 미사 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd790c0bc-3b2d-4acc-a0d2-bad80df371f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd790c0bc-3b2d-4acc-a0d2-bad80df371f7'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '빈트하그 미사 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd790c0bc-3b2d-4acc-a0d2-bad80df371f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6637eafe-59bd-4df9-8a7a-41f37946bfb7', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '빈트하그 미사 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6637eafe-59bd-4df9-8a7a-41f37946bfb7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:808f8834-13fe-4309-875e-73fb2a856261', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '빈트하그 미사 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:808f8834-13fe-4309-875e-73fb2a856261'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4508d9b1-446c-4bf5-959f-41671ef25228', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '빈트하그 미사 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4508d9b1-446c-4bf5-959f-41671ef25228'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a21aa40a-7962-40bb-bad2-4949f88f68be', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '빈트하그 미사 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a21aa40a-7962-40bb-bad2-4949f88f68be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d55f8a1-381e-44f0-b7cc-63c933ff9752', 5, 'V', '베네딕투스', 'V. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '빈트하그 미사 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d55f8a1-381e-44f0-b7cc-63c933ff9752'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32ecfac3-40d2-4274-80ed-e50f02b5b43d', 6, 'VI', '아뉴스 데이', 'VI. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '빈트하그 미사 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32ecfac3-40d2-4274-80ed-e50f02b5b43d'
);


-- WAB 26 미사 1번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미사 1번 D단조', 'Mass No. 1 in D minor', 'album', 'WAB 26', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미사 1번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a8fcf52-43c7-495a-b203-b259a0f24ac9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a8fcf52-43c7-495a-b203-b259a0f24ac9'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a8fcf52-43c7-495a-b203-b259a0f24ac9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f62fc7bd-c996-46fd-b4dd-8fbd532ac9ac', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f62fc7bd-c996-46fd-b4dd-8fbd532ac9ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1c51783-1636-40c4-b38f-15ee91041ccc', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1c51783-1636-40c4-b38f-15ee91041ccc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c87ba9d0-7987-47f6-9ee5-002e23b36fe8', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c87ba9d0-7987-47f6-9ee5-002e23b36fe8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4f362f0-9bae-4b15-9325-9119e1c434b7', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4f362f0-9bae-4b15-9325-9119e1c434b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b736a4d3-df9f-4349-bc55-26a6aeafb034', 5, 'V', '베네딕투스', 'V. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b736a4d3-df9f-4349-bc55-26a6aeafb034'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68877d13-5411-45da-9570-3c17f8a7c607', 6, 'VI', '아뉴스 데이', 'VI. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68877d13-5411-45da-9570-3c17f8a7c607'
);


-- WAB 27 미사 2번 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미사 2번 E단조', 'Mass No. 2 in E minor', 'album', 'WAB 27', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미사 2번 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97e7efd3-24f5-411f-b784-1ad3e3a5f573'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '97e7efd3-24f5-411f-b784-1ad3e3a5f573'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 2번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97e7efd3-24f5-411f-b784-1ad3e3a5f573'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b430da44-869f-3a22-8544-b1bdde685c70', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 2번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b430da44-869f-3a22-8544-b1bdde685c70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3218cdf0-1a84-3806-9623-fdd2df010304', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 2번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3218cdf0-1a84-3806-9623-fdd2df010304'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffbd8f89-27b3-370a-b15e-249f334b025a', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 2번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffbd8f89-27b3-370a-b15e-249f334b025a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54e9cf32-89ca-3dbd-ba10-ef44bc8a6b5e', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 2번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54e9cf32-89ca-3dbd-ba10-ef44bc8a6b5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0964c00e-188c-3023-aa02-83d05bf31590', 5, 'V', '베네딕투스', 'V. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 2번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0964c00e-188c-3023-aa02-83d05bf31590'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6df4f78-ba47-3da6-9729-9c49479ddf2e', 6, 'VI', '아뉴스 데이', 'VI. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 2번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6df4f78-ba47-3da6-9729-9c49479ddf2e'
);


-- WAB 28 미사 3번 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미사 3번 F단조', 'Mass No. 3 in F minor', 'album', 'WAB 28', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미사 3번 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6fc6e5b-3ec4-4e52-8607-ca1e5b568a42'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6fc6e5b-3ec4-4e52-8607-ca1e5b568a42'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 3번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6fc6e5b-3ec4-4e52-8607-ca1e5b568a42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21755eeb-bbd2-3ac5-a8bb-0b7ad166456a', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 3번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21755eeb-bbd2-3ac5-a8bb-0b7ad166456a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48849b25-ee9d-3642-b988-909de05ca735', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 3번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48849b25-ee9d-3642-b988-909de05ca735'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ba6337d-0533-3e57-ac0e-2164a6a690f1', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 3번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ba6337d-0533-3e57-ac0e-2164a6a690f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76466305-dccc-353e-8d99-fb1f810f0948', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 3번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76466305-dccc-353e-8d99-fb1f810f0948'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11bf9efc-9eda-36c1-bb5e-c915b963c9fc', 5, 'V', '베네딕투스', 'V. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 3번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11bf9efc-9eda-36c1-bb5e-c915b963c9fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72b37fd5-80ac-30db-8492-856569f52150', 6, 'VI', '아뉴스 데이', 'VI. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '미사 3번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72b37fd5-80ac-30db-8492-856569f52150'
);


-- WAB 29 장엄 미사 B♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '장엄 미사 B♭단조', 'Missa solemnis in B♭ minor', 'album', 'WAB 29', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '장엄 미사 B♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b706ebba-4e1a-4f22-98b5-9df529eef9ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b706ebba-4e1a-4f22-98b5-9df529eef9ed'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '장엄 미사 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b706ebba-4e1a-4f22-98b5-9df529eef9ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:472bdb56-fbc8-4c8d-a1f1-667020282d3e', 1, 'I', '키리에. Andante', 'I. Kyrie. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '장엄 미사 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:472bdb56-fbc8-4c8d-a1f1-667020282d3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a2677ba-3908-4e9f-afa4-1e43cfa6412e', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '장엄 미사 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a2677ba-3908-4e9f-afa4-1e43cfa6412e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f6bb7f2-55b4-4a02-a2e8-72acd12fe0e4', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '장엄 미사 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f6bb7f2-55b4-4a02-a2e8-72acd12fe0e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:697dbd00-ac48-4dc9-9570-e997d4787388', 4, 'IV', '상투스 / Hosanna. Moderato', 'IV. Sanctus / Hosanna. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '장엄 미사 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:697dbd00-ac48-4dc9-9570-e997d4787388'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7652ce3-3fe1-4e68-a7aa-7e9030d7fae7', 5, 'V', '베네딕투스 / Hosanna. Moderato', 'V. Benedictus / Hosanna. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '장엄 미사 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7652ce3-3fe1-4e68-a7aa-7e9030d7fae7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed4e3bb8-d3ad-4e89-a797-f164b2cb2759', 6, 'VI', '아뉴스 데이', 'VI. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '장엄 미사 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed4e3bb8-d3ad-4e89-a797-f164b2cb2759'
);


-- WAB 30 모테트 <Os justi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Os justi>', 'Gradual "Os justi" (Lydian mode)', 'song', 'WAB 30', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Os justi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef0e474e-b5dd-37e6-b270-023752c9d544'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ef0e474e-b5dd-37e6-b270-023752c9d544'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Os justi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef0e474e-b5dd-37e6-b270-023752c9d544'
);


-- WAB 31 모테트 <Pange lingua> C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Pange lingua> C장조', '"Pange lingua" in C major', 'song', 'WAB 31', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Pange lingua> C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d3c5320-e524-4dc0-95c8-2c4e21b0477a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2d3c5320-e524-4dc0-95c8-2c4e21b0477a'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Pange lingua> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d3c5320-e524-4dc0-95c8-2c4e21b0477a'
);


-- WAB 32 모테트 <Tantum ergo> D장조 (1845)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Tantum ergo> D장조 (1845)', '"Tantum ergo" in D major (c. 1845)', 'song', 'WAB 32', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Tantum ergo> D장조 (1845)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97ff36d4-f3e7-43d1-b44e-c99d1426a530'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '97ff36d4-f3e7-43d1-b44e-c99d1426a530'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Tantum ergo> D장조 (1845)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97ff36d4-f3e7-43d1-b44e-c99d1426a530'
);


-- WAB 33 모테트 <Pange lingua> (프리지아 선법)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Pange lingua> (프리지아 선법)', '"Pange lingua" (Phrygian mode)', 'song', 'WAB 33', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Pange lingua> (프리지아 선법)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f6fc71e-d12e-4718-92a0-27af8f51774f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f6fc71e-d12e-4718-92a0-27af8f51774f'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Pange lingua> (프리지아 선법)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f6fc71e-d12e-4718-92a0-27af8f51774f'
);


-- WAB 34 시편 22편

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 22편', 'Psalm 22 in E♭ major', 'song', 'WAB 34', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 22편'
);


-- WAB 35 시편 112편

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 112편', 'Psalm 112 in B♭ major', 'song', 'WAB 35', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 112편'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87d11a68-6b6b-4adc-86da-3ca8cd120080'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '87d11a68-6b6b-4adc-86da-3ca8cd120080'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '시편 112편' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87d11a68-6b6b-4adc-86da-3ca8cd120080'
);


-- WAB 36 시편 114편

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 114편', 'Psalm 114 in G major', 'song', 'WAB 36', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 114편'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94a4a3cf-48e6-34dd-8488-c2a43bb428ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '94a4a3cf-48e6-34dd-8488-c2a43bb428ee'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '시편 114편' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94a4a3cf-48e6-34dd-8488-c2a43bb428ee'
);


-- WAB 37 시편 146편

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 146편', 'Psalm 146 in A major', 'album', 'WAB 37', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 146편'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2c7b69f-e5a7-42f1-a661-392d747ff27f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a2c7b69f-e5a7-42f1-a661-392d747ff27f'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '시편 146편' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2c7b69f-e5a7-42f1-a661-392d747ff27f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30ab86db-c4d2-4a74-90c2-9410bc4944ac', 1, 'I', 'Solo und Chor “Alleluja! Lobet den Herrn”. Langsam', 'I. Solo und Chor “Alleluja! Lobet den Herrn”. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '시편 146편' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30ab86db-c4d2-4a74-90c2-9410bc4944ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaca1196-fcce-45e1-9abe-85ca793ad409', 2, 'II', 'Recitativ “Der Herr bauet Jerusalem”', 'II. Recitativ “Der Herr bauet Jerusalem”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '시편 146편' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaca1196-fcce-45e1-9abe-85ca793ad409'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2ebc17a-b0cb-440e-b039-eaba7120a074', 3, 'III', 'Chor “Groß ist unser Herr”. Schnell', 'III. Chor “Groß ist unser Herr”. Schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '시편 146편' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2ebc17a-b0cb-440e-b039-eaba7120a074'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:606abe1d-4d7e-4afe-993a-acf5f6186199', 4, 'IV', 'Arioso mit Chor “Der Herr nimmt auf die Sanften”. Nicht zu langsam – Etwas bewegter', 'IV. Arioso mit Chor “Der Herr nimmt auf die Sanften”. Nicht zu langsam – Etwas bewegter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '시편 146편' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:606abe1d-4d7e-4afe-993a-acf5f6186199'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f63b8b64-e168-45b7-abbb-22932c3e01f6', 5, 'V', 'Arioso “Der Herr hat Wohlgefallen”. Nicht schnell', 'V. Arioso “Der Herr hat Wohlgefallen”. Nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '시편 146편' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f63b8b64-e168-45b7-abbb-22932c3e01f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32531065-147a-4925-b482-850525d0eb49', 6, 'VI', 'Schlußchor mit Fuge “Alleluja! Lobet den Herrn”. Etwas schnell – Nicht schnell', 'VI. Schlußchor mit Fuge “Alleluja! Lobet den Herrn”. Etwas schnell – Nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '시편 146편' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32531065-147a-4925-b482-850525d0eb49'
);


-- WAB 38 시편 150편

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 150편', 'Psalm 150 in C major', 'song', 'WAB 38', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 150편'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f8f8c9f-9c19-41e4-9736-e75ab211edb0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f8f8c9f-9c19-41e4-9736-e75ab211edb0'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '시편 150편' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f8f8c9f-9c19-41e4-9736-e75ab211edb0'
);


-- WAB 39 레퀴엠 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '레퀴엠 D단조', 'Requiem in D minor', 'album', 'WAB 39', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '레퀴엠 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfc97704-1682-41bd-aba7-ec3d36638e3f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cfc97704-1682-41bd-aba7-ec3d36638e3f'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '레퀴엠 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfc97704-1682-41bd-aba7-ec3d36638e3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2c8f676-83f7-4de9-af69-68d2ded0ae49', 1, 'I', 'Requiem aeternam dona eis, Domine', 'I. Requiem aeternam dona eis, Domine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '레퀴엠 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2c8f676-83f7-4de9-af69-68d2ded0ae49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c5cf7a8-eef8-4ddd-8f4e-13e97f1034f0', 2, 'II', 'Dies irae', 'II. Dies irae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '레퀴엠 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c5cf7a8-eef8-4ddd-8f4e-13e97f1034f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b4b7ce1-4d90-42a1-ab24-527e051fc91f', 3, 'III', 'Domine Jesu Christe', 'III. Domine Jesu Christe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '레퀴엠 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b4b7ce1-4d90-42a1-ab24-527e051fc91f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdaaea79-f49c-47d4-b444-fe725bce61ef', 4, 'IV', 'Hostias et preces tibi Domine offerimus', 'IV. Hostias et preces tibi Domine offerimus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '레퀴엠 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdaaea79-f49c-47d4-b444-fe725bce61ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53c958ac-774c-4348-9a96-d89c37033991', 5, 'V', 'Quam olim Abrahae promisisti', 'V. Quam olim Abrahae promisisti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '레퀴엠 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53c958ac-774c-4348-9a96-d89c37033991'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7df6fb6-ef41-4d44-be80-758f96626d8b', 6, 'VI', '상투스', 'VI. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '레퀴엠 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7df6fb6-ef41-4d44-be80-758f96626d8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5122a50c-f816-4aed-bfe8-02827173dd97', 7, 'VII', '베네딕투스', 'VII. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '레퀴엠 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5122a50c-f816-4aed-bfe8-02827173dd97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:105829e8-4393-4f99-ba44-d9ed52a94ed5', 8, 'VIII', '아뉴스 데이', 'VIII. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '레퀴엠 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:105829e8-4393-4f99-ba44-d9ed52a94ed5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a699bbb-6668-4246-a9c8-73c74f4df380', 9, 'IX', 'Requiem aeternam dona eis, Domine', 'IX. Requiem aeternam dona eis, Domine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '레퀴엠 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a699bbb-6668-4246-a9c8-73c74f4df380'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9b729e6-6e77-4ec6-8d8d-eafeeb5b4e6d', 10, 'X', 'Cum sanctis tuis', 'X. Cum sanctis tuis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '레퀴엠 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9b729e6-6e77-4ec6-8d8d-eafeeb5b4e6d'
);


-- WAB 40 모테트 <Salvum fac populum tuum>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Salvum fac populum tuum>', 'Offertory "Salvum fac populum tuum" in F major', 'song', 'WAB 40', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Salvum fac populum tuum>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f6aac10-17f8-4474-bec1-9faca948c37c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6f6aac10-17f8-4474-bec1-9faca948c37c'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Salvum fac populum tuum>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f6aac10-17f8-4474-bec1-9faca948c37c'
);


-- WAB 41 모테트 <Tantum ergo> 4곡 WAB 41

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Tantum ergo> 4곡 WAB 41', '4 Tantum ergo, WAB 41', 'album', NULL, 'WAB', '41', 1846, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Tantum ergo> 4곡 WAB 41'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6798a009-6f43-4d85-b591-2d24b70cacd4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6798a009-6f43-4d85-b591-2d24b70cacd4'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Tantum ergo> 4곡 WAB 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6798a009-6f43-4d85-b591-2d24b70cacd4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17f23b38-a014-4a42-a094-e2bb3174e070', 1, NULL, 'B♭장조', 'Tantum ergo in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Tantum ergo> 4곡 WAB 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17f23b38-a014-4a42-a094-e2bb3174e070'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac250477-1cf7-42d9-9021-575c2c583d56', 2, NULL, 'A♭장조', 'Tantum ergo in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Tantum ergo> 4곡 WAB 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac250477-1cf7-42d9-9021-575c2c583d56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43392850-505d-405d-a99e-f8d8a27b6779', 3, NULL, 'E♭장조', 'Tantum ergo in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Tantum ergo> 4곡 WAB 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43392850-505d-405d-a99e-f8d8a27b6779'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e0aa37c-2289-4064-b452-9a524db5aa9c', 4, NULL, 'C장조', 'Tantum ergo in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Tantum ergo> 4곡 WAB 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e0aa37c-2289-4064-b452-9a524db5aa9c'
);


-- WAB 42 모테트 <Tantum ergo> D장조 (1846)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Tantum ergo> D장조 (1846)', '"Tantum ergo" in D major (1846)', 'song', 'WAB 42', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Tantum ergo> D장조 (1846)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b42bf21c-687b-4f3f-acf4-2f22ebd2443e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b42bf21c-687b-4f3f-acf4-2f22ebd2443e'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Tantum ergo> D장조 (1846)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b42bf21c-687b-4f3f-acf4-2f22ebd2443e'
);


-- WAB 43 모테트 <Tantum ergo> A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Tantum ergo> A장조', '"Tantum ergo" in A major', 'song', 'WAB 43', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Tantum ergo> A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66397945-c9fe-44b1-a225-45bf382ad1b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '66397945-c9fe-44b1-a225-45bf382ad1b8'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Tantum ergo> A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66397945-c9fe-44b1-a225-45bf382ad1b8'
);


-- WAB 44 모테트 <Tantum ergo> B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Tantum ergo> B♭장조', '"Tantum ergo" in B♭ major', 'song', 'WAB 44', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Tantum ergo> B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e47e8042-0163-4521-afc1-f8109494082e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e47e8042-0163-4521-afc1-f8109494082e'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Tantum ergo> B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e47e8042-0163-4521-afc1-f8109494082e'
);


-- WAB 45 테 데움 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '테 데움 C장조', 'Te Deum in C major', 'album', 'WAB 45', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '테 데움 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e02f2621-647b-408b-81dc-2fa8719a5cc0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e02f2621-647b-408b-81dc-2fa8719a5cc0'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '테 데움 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e02f2621-647b-408b-81dc-2fa8719a5cc0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:953a26be-f6ff-3b06-9d35-a7677f3e6910', 1, 'I', 'Te Deum. Allegro moderato', 'I. Te Deum. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '테 데움 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:953a26be-f6ff-3b06-9d35-a7677f3e6910'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b1c8af1-2d80-3a04-a8d8-1cc93895dde2', 2, 'II', 'Te ergo. Moderato', 'II. Te ergo. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '테 데움 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b1c8af1-2d80-3a04-a8d8-1cc93895dde2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e246bcf7-3b62-3e29-b3a3-d126176ac89c', 3, 'III', 'Aeterna fac. Allegro – Moderato – Feierlich, mit Kraft', 'III. Aeterna fac. Allegro – Moderato – Feierlich, mit Kraft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '테 데움 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e246bcf7-3b62-3e29-b3a3-d126176ac89c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0994fa9f-05eb-323a-9325-91a38a436ce7', 4, 'IV', 'Salvum fac populum tuum', 'IV. Salvum fac populum tuum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '테 데움 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0994fa9f-05eb-323a-9325-91a38a436ce7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5da04663-7687-3654-bd65-8a8f2cf169ae', 5, 'V', 'In te Domine speravi', 'V. In te Domine speravi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '테 데움 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5da04663-7687-3654-bd65-8a8f2cf169ae'
);


-- WAB 46 모테트 <Tota pulchra es>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Tota pulchra es>', 'Antiphon "Tota pulchra es" (Phrygian mode)', 'song', 'WAB 46', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Tota pulchra es>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '969b35dd-9a4b-46c1-8da9-e9ceb72dcf9e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '969b35dd-9a4b-46c1-8da9-e9ceb72dcf9e'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Tota pulchra es>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '969b35dd-9a4b-46c1-8da9-e9ceb72dcf9e'
);


-- WAB 47 모테트 <Totenlied> 1번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Totenlied> 1번 E♭장조', 'Totenlied No. 1 in E♭ major', 'song', 'WAB 47', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Totenlied> 1번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7d494b8-4e20-424c-afb3-13cf0ff10c96'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a7d494b8-4e20-424c-afb3-13cf0ff10c96'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Totenlied> 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7d494b8-4e20-424c-afb3-13cf0ff10c96'
);


-- WAB 48 모테트 <Totenlied> 2번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Totenlied> 2번 F장조', 'Totenlied No. 2 in F major', 'song', 'WAB 48', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Totenlied> 2번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '319572f5-da50-41f1-8dcf-576f3225725d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '319572f5-da50-41f1-8dcf-576f3225725d'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Totenlied> 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '319572f5-da50-41f1-8dcf-576f3225725d'
);


-- WAB 49 합창곡 <Trauungschor>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Trauungschor>', '"Trauungschor" in F major', 'song', 'WAB 49', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Trauungschor>'
);


-- WAB 50 모테트 <Veni Creator Spiritus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Veni Creator Spiritus>', '"Veni Creator Spiritus"', 'song', 'WAB 50', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Veni Creator Spiritus>'
);


-- WAB 51 모테트 <Vexilla regis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Vexilla regis>', 'Hymn "Vexilla regis" (Phrygian mode)', 'song', 'WAB 51', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Vexilla regis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35af2442-6627-40ec-ac35-4d705421814c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '35af2442-6627-40ec-ac35-4d705421814c'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Vexilla regis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35af2442-6627-40ec-ac35-4d705421814c'
);


-- WAB 52 모테트 <Virga Jesse>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Virga Jesse>', 'Gradual "Virga Jesse" in E minor', 'song', 'WAB 52', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Virga Jesse>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0993fa90-183c-3010-ae93-8aa40464d5cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0993fa90-183c-3010-ae93-8aa40464d5cf'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '모테트 <Virga Jesse>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0993fa90-183c-3010-ae93-8aa40464d5cf'
);


-- WAB 53 합창곡 <Vor Arneths Grab>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Vor Arneths Grab>', '"Vor Arneths Grab" in F minor', 'song', 'WAB 53', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Vor Arneths Grab>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56aae3ac-2770-4770-b92e-868c19b16c4a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56aae3ac-2770-4770-b92e-868c19b16c4a'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '합창곡 <Vor Arneths Grab>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56aae3ac-2770-4770-b92e-868c19b16c4a'
);


-- WAB 54 합창곡 <Zur Vermählungsfeier>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Zur Vermählungsfeier>', '"Zur Vermählungsfeier" in D major', 'song', 'WAB 54', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Zur Vermählungsfeier>'
);


-- WAB 55 합창곡 <Der Abendhimmel> A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Der Abendhimmel> A♭장조', '"Der Abendhimmel" in A♭ major (1862)', 'song', 'WAB 55', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Der Abendhimmel> A♭장조'
);


-- WAB 56 합창곡 <Der Abendhimmel> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Der Abendhimmel> F장조', '"Der Abendhimmel" in F major (1866)', 'song', 'WAB 56', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Der Abendhimmel> F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a6a563e-e497-4822-bc39-ea34e7b223f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3a6a563e-e497-4822-bc39-ea34e7b223f7'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '합창곡 <Der Abendhimmel> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a6a563e-e497-4822-bc39-ea34e7b223f7'
);


-- WAB 57 합창곡 <Abendzauber>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Abendzauber>', '"Abendzauber" in G♭ major', 'song', 'WAB 57', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Abendzauber>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f6aad2ce-1f12-4439-b712-305748a9747a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f6aad2ce-1f12-4439-b712-305748a9747a'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '합창곡 <Abendzauber>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f6aad2ce-1f12-4439-b712-305748a9747a'
);


-- WAB 58 가곡 <Wie bist du, Frühling, gut und treu>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Wie bist du, Frühling, gut und treu>', '"Wie bist du, Frühling, gut und treu" in G major', 'song', 'WAB 58', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Wie bist du, Frühling, gut und treu>'
);


-- WAB 59 합창곡 <An dem Feste>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <An dem Feste>', '"An dem Feste" in D♭ major', 'song', 'WAB 59', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <An dem Feste>'
);


-- WAB 60 마이어 칸타타 <Auf Brüder! auf, und die Saiten zur Hand!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마이어 칸타타 <Auf Brüder! auf, und die Saiten zur Hand!>', 'Mayer Cantata "Auf Brüder! auf, und die Saiten zur Hand!" in D major', 'song', 'WAB 60', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마이어 칸타타 <Auf Brüder! auf, und die Saiten zur Hand!>'
);


-- WAB 61 아르네트 칸타타 <Heil, Vater! Dir zum hohen Feste!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아르네트 칸타타 <Heil, Vater! Dir zum hohen Feste!>', 'Arneth Cantata "Heil, Vater! Dir zum hohen Feste!" in D major', 'song', 'WAB 61', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아르네트 칸타타 <Heil, Vater! Dir zum hohen Feste!>'
);


-- WAB 62 합창곡 <Des Dankes Wort sei mir vergönnt>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Des Dankes Wort sei mir vergönnt>', '"Des Dankes Wort sei mir vergönnt" in F major', 'song', 'WAB 62', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Des Dankes Wort sei mir vergönnt>'
);


-- WAB 63 합창곡 <Der deutsche Gesang>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Der deutsche Gesang>', '"Der deutsche Gesang" in D minor', 'song', 'WAB 63', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Der deutsche Gesang>'
);


-- WAB 64 합창곡 <Du bist wie eine Blume>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Du bist wie eine Blume>', '"Du bist wie eine Blume" in F major', 'song', 'WAB 64', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Du bist wie eine Blume>'
);


-- WAB 65 합창곡 <Das edle Herz> (남성 합창)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Das edle Herz> (남성 합창)', '"Das edle Herz" in A major for male choir', 'song', 'WAB 65', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Das edle Herz> (남성 합창)'
);


-- WAB 66 합창곡 <Das edle Herz> (혼성 합창)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Das edle Herz> (혼성 합창)', '"Das edle Herz" in A major for mixed choir', 'song', 'WAB 66', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Das edle Herz> (혼성 합창)'
);


-- WAB 68 가곡 <Frühlingslied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Frühlingslied>', '"Frühlingslied" in A major', 'song', 'WAB 68', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Frühlingslied>'
);


-- WAB 69 합창곡 <Die Geburt>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Die Geburt>', '"Die Geburt" in D♭ major', 'song', 'WAB 69', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Die Geburt>'
);


-- WAB 70 칸타타 <Germanenzug>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Germanenzug>', 'Cantata "Germanenzug" in D minor', 'song', 'WAB 70', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Germanenzug>'
);


-- WAB 71 칸타타 <헬골란트>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <헬골란트>', 'Cantata "Helgoland" in G minor', 'song', 'WAB 71', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <헬골란트>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c40b207-605a-4c16-b7b9-432777baa482'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4c40b207-605a-4c16-b7b9-432777baa482'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '칸타타 <헬골란트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c40b207-605a-4c16-b7b9-432777baa482'
);


-- WAB 72 가곡 <Herbstkummer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Herbstkummer>', '"Herbstkummer" in E minor', 'song', 'WAB 72', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Herbstkummer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e5b01f8-5d9a-43cb-9239-0577c3fa3f3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1e5b01f8-5d9a-43cb-9239-0577c3fa3f3e'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '가곡 <Herbstkummer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e5b01f8-5d9a-43cb-9239-0577c3fa3f3e'
);


-- WAB 73 합창곡 <Herbstlied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Herbstlied>', '"Herbstlied" in F# minor', 'song', 'WAB 73', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Herbstlied>'
);


-- WAB 74 합창곡 <Das hohe Lied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Das hohe Lied>', '"Das hohe Lied" in A♭ major', 'song', 'WAB 74', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Das hohe Lied>'
);


-- WAB 75 가곡 <Im April>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Im April>', '"Im April" in A♭ major', 'song', 'WAB 75', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Im April>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4782118-9517-470f-9680-d37be481b4c0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c4782118-9517-470f-9680-d37be481b4c0'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '가곡 <Im April>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4782118-9517-470f-9680-d37be481b4c0'
);


-- WAB 76 합창곡 <Laßt Jubeltöne laut erklingen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Laßt Jubeltöne laut erklingen>', '"Laßt Jubeltöne laut erklingen" in E♭ major', 'song', 'WAB 76', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Laßt Jubeltöne laut erklingen>'
);


-- WAB 77 합창곡 <Der Lehrerstand>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Der Lehrerstand>', '"Der Lehrerstand" in E♭ major', 'song', 'WAB 77', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Der Lehrerstand>'
);


-- WAB 78 합창곡 <Das Lied vom deutschen Vaterland>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Das Lied vom deutschen Vaterland>', '"Das Lied vom deutschen Vaterland" in D♭ major', 'song', 'WAB 78', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Das Lied vom deutschen Vaterland>'
);


-- WAB 79 가곡 <Mein Herz und deine Stimme>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mein Herz und deine Stimme>', '"Mein Herz und deine Stimme" in A major', 'song', 'WAB 79', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mein Herz und deine Stimme>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a762ad58-db7e-463b-81e9-15c242b472ca'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a762ad58-db7e-463b-81e9-15c242b472ca'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '가곡 <Mein Herz und deine Stimme>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a762ad58-db7e-463b-81e9-15c242b472ca'
);


-- WAB 80 합창곡 <Mitternacht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Mitternacht>', '"Mitternacht" in A♭ major', 'song', 'WAB 80', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Mitternacht>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a83f768a-a0a1-4ed7-8fc9-48ac255ab9c0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a83f768a-a0a1-4ed7-8fc9-48ac255ab9c0'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '합창곡 <Mitternacht>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a83f768a-a0a1-4ed7-8fc9-48ac255ab9c0'
);


-- WAB 81 합창곡 <Nachruf>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Nachruf>', '"Nachruf" in C minor', 'song', 'WAB 81', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Nachruf>'
);


-- WAB 82 합창곡 <Sängerbund>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Sängerbund>', '"Sängerbund" in C major', 'song', 'WAB 82', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Sängerbund>'
);


-- WAB 83 합창 모토 WAB 83

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창 모토 WAB 83', '2 Mottos for the Liedertafel Eferding, WAB 83', 'album', NULL, 'WAB', '83', 1851, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창 모토 WAB 83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bruckner:bruckner-wab83:1', 1, NULL, 'Ein jubelnd Hoch in Leid und Lust', '"Ein jubelnd Hoch in Leid und Lust" in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '합창 모토 WAB 83' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bruckner:bruckner-wab83:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bruckner:bruckner-wab83:2', 2, NULL, 'Lebt wohl, ihr Sangesbrüder', '"Lebt wohl, ihr Sangesbrüder" in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '합창 모토 WAB 83' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bruckner:bruckner-wab83:2'
);


-- WAB 84.2 합창곡 <Ständchen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Ständchen>', '"Ständchen" in G major', 'song', 'WAB 84.2', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Ständchen>'
);


-- WAB 85 합창곡 <Sternschnuppen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Sternschnuppen>', '"Sternschnuppen" in F major', 'song', 'WAB 85', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Sternschnuppen>'
);


-- WAB 87 합창곡 <Träumen und Wachen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Träumen und Wachen>', '"Träumen und Wachen" in A♭ major', 'song', 'WAB 87', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Träumen und Wachen>'
);


-- WAB 89 합창곡 <Um Mitternacht> (1864)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Um Mitternacht> (1864)', '"Um Mitternacht" in F minor (1864)', 'song', 'WAB 89', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Um Mitternacht> (1864)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b6a9a03-2a76-47b9-8c1b-ec746f166320'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b6a9a03-2a76-47b9-8c1b-ec746f166320'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '합창곡 <Um Mitternacht> (1864)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b6a9a03-2a76-47b9-8c1b-ec746f166320'
);


-- WAB 90 합창곡 <Um Mitternacht> (1886)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Um Mitternacht> (1886)', '"Um Mitternacht" in F minor (1886)', 'song', 'WAB 90', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Um Mitternacht> (1886)'
);


-- WAB 91 합창곡 <Vaterländisch Weinlied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Vaterländisch Weinlied>', '"Vaterländisch Weinlied" in C major', 'song', 'WAB 91', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Vaterländisch Weinlied>'
);


-- WAB 92 합창곡 <O könnt ich dich beglücken>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <O könnt ich dich beglücken>', '"O könnt ich dich beglücken" (Vaterlandslied) in A♭ major', 'song', 'WAB 92', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <O könnt ich dich beglücken>'
);


-- WAB 93 칸타타 <Musikalischer Versuch nach dem Kammer-Styl>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Musikalischer Versuch nach dem Kammer-Styl>', 'Cantata "Musikalischer Versuch nach dem Kammer-Styl" in D major', 'song', 'WAB 93', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Musikalischer Versuch nach dem Kammer-Styl>'
);


-- WAB 94 합창곡 <Volkslied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Volkslied>', '"Volkslied" in C major', 'song', 'WAB 94', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Volkslied>'
);


-- WAB 95 합창 모토 WAB 95

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창 모토 WAB 95', '2 Mottos, WAB 95', 'album', NULL, 'WAB', '95', 1868, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창 모토 WAB 95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bruckner:bruckner-wab95:1', 1, NULL, 'Das Frauenherz, die Mannesbrust', '"Das Frauenherz, die Mannesbrust" in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '합창 모토 WAB 95' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bruckner:bruckner-wab95:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bruckner:bruckner-wab95:2', 2, NULL, 'Des Höchsten Preis, des Vaterlandes Ruhm', '"Des Höchsten Preis, des Vaterlandes Ruhm" in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '합창 모토 WAB 95' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bruckner:bruckner-wab95:2'
);


-- WAB 96 행진곡 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 D단조', 'March in D minor', 'song', 'WAB 96', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5f8a2b9-e9de-4517-aa8b-63c30a2ba609'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b5f8a2b9-e9de-4517-aa8b-63c30a2ba609'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '행진곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5f8a2b9-e9de-4517-aa8b-63c30a2ba609'
);


-- WAB 97 관현악 소품 WAB 97

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 소품 WAB 97', '3 Orchestral Pieces, WAB 97', 'album', NULL, 'WAB', '97', 1862, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 소품 WAB 97'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09ac73e9-29a6-4536-bfb9-5bdb56dbdd62'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09ac73e9-29a6-4536-bfb9-5bdb56dbdd62'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '관현악 소품 WAB 97' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09ac73e9-29a6-4536-bfb9-5bdb56dbdd62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e4fcc48-b28a-4090-a23b-208928bb9033', 1, NULL, 'E♭장조', 'No. 1 Moderato in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '관현악 소품 WAB 97' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e4fcc48-b28a-4090-a23b-208928bb9033'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:863b853e-624e-46cb-bb04-7cb3fa9028c3', 2, NULL, 'E단조', 'No. 2 Andante in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '관현악 소품 WAB 97' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:863b853e-624e-46cb-bb04-7cb3fa9028c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca6a3185-0555-4ae3-a1d0-9d48de5558a8', 3, NULL, 'F장조', 'No. 3 Andante con moto in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '관현악 소품 WAB 97' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca6a3185-0555-4ae3-a1d0-9d48de5558a8'
);


-- WAB 98 서곡 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 G단조', 'Overture in G minor', 'song', 'WAB 98', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c499ae8f-26ad-329b-b4eb-777504c6993d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c499ae8f-26ad-329b-b4eb-777504c6993d'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '서곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c499ae8f-26ad-329b-b4eb-777504c6993d'
);


-- WAB 99 교향곡 00번 F단조 "습작"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 00번 F단조 "습작"', 'Symphony No. 00 in F minor "Study Symphony"', 'album', 'WAB 99', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 00번 F단조 "습작"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c20db8c0-f24a-420f-b778-b58e455c3e3a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c20db8c0-f24a-420f-b778-b58e455c3e3a'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 00번 F단조 "습작"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c20db8c0-f24a-420f-b778-b58e455c3e3a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eacbf99b-86db-4ce6-8a3d-ab785819019b', 1, 'I', 'Allegro molto vivace', 'I. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 00번 F단조 "습작"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eacbf99b-86db-4ce6-8a3d-ab785819019b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23f52621-b383-4320-9b00-2a7ec567b4a4', 2, 'II', 'Andante molto', 'II. Andante molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 00번 F단조 "습작"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23f52621-b383-4320-9b00-2a7ec567b4a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ed452da-db69-4c4d-9d5f-b9ee6b95ff15', 3, 'III', '스케르초. Schnell', 'III. Scherzo. Schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 00번 F단조 "습작"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ed452da-db69-4c4d-9d5f-b9ee6b95ff15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afff8930-8108-4dfe-97c5-aa45dccfc7cb', 4, 'IV', '피날레. Allegro', 'IV. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 00번 F단조 "습작"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afff8930-8108-4dfe-97c5-aa45dccfc7cb'
);


-- WAB 100 교향곡 0번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 0번 D단조', 'Symphony No. 0 in D minor "Die Nullte"', 'album', 'WAB 100', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 0번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b7c68e0-50de-4f32-bfbc-d7b1a3efc121'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4b7c68e0-50de-4f32-bfbc-d7b1a3efc121'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 0번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b7c68e0-50de-4f32-bfbc-d7b1a3efc121'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a53154e0-1979-3493-8f36-c927d99d23bc', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 0번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a53154e0-1979-3493-8f36-c927d99d23bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a65aa7ca-1a7f-3b0b-af30-18af2ea6315e', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 0번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a65aa7ca-1a7f-3b0b-af30-18af2ea6315e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c03a3afa-2a9a-32fb-bbfb-677b751664db', 3, 'III', '스케르초. Presto', 'III. Scherzo. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 0번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c03a3afa-2a9a-32fb-bbfb-677b751664db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0108899e-40a0-34f8-a807-b3d1cb6af83d', 4, 'IV', '피날레. Moderato', 'IV. Finale. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 0번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0108899e-40a0-34f8-a807-b3d1cb6af83d'
);


-- WAB 101 교향곡 1번 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번 C단조', 'Symphony No. 1 in C minor', 'album', 'WAB 101', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a5af240-86cd-4043-9156-d2ef3134fdfa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9a5af240-86cd-4043-9156-d2ef3134fdfa'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 1번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a5af240-86cd-4043-9156-d2ef3134fdfa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f39c7c6c-b554-3adc-97e6-480536bae118', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 1번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f39c7c6c-b554-3adc-97e6-480536bae118'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75a6200c-499d-35e3-95a2-379f5185ba30', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 1번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75a6200c-499d-35e3-95a2-379f5185ba30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9253dff0-a649-3302-8c5a-1217f020a6cd', 3, 'III', '스케르초', 'III. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 1번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9253dff0-a649-3302-8c5a-1217f020a6cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c97c5b31-3349-3298-996b-cdb94eabe327', 4, 'IV', '피날레. Animato', 'IV. Finale. Animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 1번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c97c5b31-3349-3298-996b-cdb94eabe327'
);


-- WAB 102 교향곡 2번 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번 C단조', 'Symphony No. 2 in C minor', 'album', 'WAB 102', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eadb4b24-1569-42c0-80ec-ac2bb628f6f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eadb4b24-1569-42c0-80ec-ac2bb628f6f8'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 2번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eadb4b24-1569-42c0-80ec-ac2bb628f6f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f40ec9e4-360b-45db-a866-2b6ae7f89e1f', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 2번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f40ec9e4-360b-45db-a866-2b6ae7f89e1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d13b3fac-5057-4b6f-92d1-5b159e6b8005', 2, 'II', 'Andante. Feierlich, etwas bewegt', 'II. Andante. Feierlich, etwas bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 2번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d13b3fac-5057-4b6f-92d1-5b159e6b8005'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9481f090-4d81-4e4e-9fca-4da2e8a28cf2', 3, 'III', '스케르초. Mäßig schnell – 트리오. Gleiches Tempo', 'III. Scherzo. Mäßig schnell – Trio. Gleiches Tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 2번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9481f090-4d81-4e4e-9fca-4da2e8a28cf2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:870df42f-c7ae-43a0-bea8-499c68817935', 4, 'IV', '피날레. Ziemlich schnell', 'IV. Finale. Ziemlich schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 2번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:870df42f-c7ae-43a0-bea8-499c68817935'
);


-- WAB 103 교향곡 3번 D단조 "바그너"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 3번 D단조 "바그너"', 'Symphony No. 3 in D minor "Wagner Symphony"', 'album', 'WAB 103', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 3번 D단조 "바그너"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d96cf40-86a3-41fa-a63c-e00466e91007'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7d96cf40-86a3-41fa-a63c-e00466e91007'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 3번 D단조 "바그너"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d96cf40-86a3-41fa-a63c-e00466e91007'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:279cc8bf-6779-46c5-8b0f-b2422200a82c', 1, 'I', 'Gemäßigt, misterioso', 'I. Gemäßigt, misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 3번 D단조 "바그너"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:279cc8bf-6779-46c5-8b0f-b2422200a82c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7a2c4f8-9381-4542-943c-8e4e02c9ad63', 2, 'II', 'Adagio. Feierlich', 'II. Adagio. Feierlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 3번 D단조 "바그너"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7a2c4f8-9381-4542-943c-8e4e02c9ad63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7f714bc-84d0-46b9-9f7a-f993370c7de7', 3, 'III', '스케르초. Ziemlich schnell', 'III. Scherzo. Ziemlich schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 3번 D단조 "바그너"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7f714bc-84d0-46b9-9f7a-f993370c7de7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9049329-397f-4c1b-986b-d0564c4e1ea6', 4, 'IV', '피날레. Allegro', 'IV. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 3번 D단조 "바그너"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9049329-397f-4c1b-986b-d0564c4e1ea6'
);


-- WAB 104 교향곡 4번 E♭장조 "낭만적"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d71e54c-1694-449c-9e12-716345ad2b10', 1, 'I', 'Bewegt, nicht zu schnell', 'I. Bewegt, nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 182 AND p.composer_id = 41
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d71e54c-1694-449c-9e12-716345ad2b10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:192ae3ea-34ba-4819-aad1-f6bf0ed6fc4f', 2, 'II', 'Andante, quasi allegretto', 'II. Andante, quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 182 AND p.composer_id = 41
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:192ae3ea-34ba-4819-aad1-f6bf0ed6fc4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59727151-7eb8-47e3-80aa-a67ad7557799', 3, 'III', '스케르초 (Bewegt) – 트리오 (Nicht zu schnell, Keinesfalls schleppend)', 'III. Scherzo (Bewegt) – Trio (Nicht zu schnell, Keinesfalls schleppend)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 182 AND p.composer_id = 41
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59727151-7eb8-47e3-80aa-a67ad7557799'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e0424ea-5b4e-4974-a55e-5fe0c3d164ed', 4, 'IV', '피날레. Bewegt, doch nicht zu schnell', 'IV. Finale. Bewegt, doch nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 182 AND p.composer_id = 41
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e0424ea-5b4e-4974-a55e-5fe0c3d164ed'
);


-- WAB 105 교향곡 5번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 5번 B♭장조', 'Symphony No. 5 in B♭ major', 'album', 'WAB 105', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 5번 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa420e9f-1851-4fca-b51b-e6ef71d97ad6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fa420e9f-1851-4fca-b51b-e6ef71d97ad6'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 5번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa420e9f-1851-4fca-b51b-e6ef71d97ad6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:805a587b-a42e-4b21-a47c-57074ec9c9a5', 1, 'I', '서주 (Adagio) – Allegro', 'I. Introduction (Adagio) – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 5번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:805a587b-a42e-4b21-a47c-57074ec9c9a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b97730e7-0ed8-416b-b8d6-f26b4ad11cbb', 2, 'II', 'Adagio. Sehr langsam', 'II. Adagio. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 5번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b97730e7-0ed8-416b-b8d6-f26b4ad11cbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:083d083a-c7f9-4ffc-9378-436fd7ce469c', 3, 'III', '스케르초. Molto vivace', 'III. Scherzo. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 5번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:083d083a-c7f9-4ffc-9378-436fd7ce469c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19d9dbdd-88cc-4f4a-9917-6f5fd384ab4c', 4, 'IV', '피날레. Adagio – Allegro moderato', 'IV. Finale. Adagio – Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 5번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19d9dbdd-88cc-4f4a-9917-6f5fd384ab4c'
);


-- WAB 106 교향곡 6번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 6번 A장조', 'Symphony No. 6 in A major', 'album', 'WAB 106', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 6번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3360eb76-4937-4e05-b4c5-1a8c999d14d6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3360eb76-4937-4e05-b4c5-1a8c999d14d6'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 6번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3360eb76-4937-4e05-b4c5-1a8c999d14d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b16bb76b-4058-3ba9-bd93-7d26fb6b2707', 1, 'I', 'Majestoso', 'I. Majestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 6번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b16bb76b-4058-3ba9-bd93-7d26fb6b2707'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:617f7d36-8a2a-31c6-aa2c-44284bfc115e', 2, 'II', 'Adagio. Sehr feierlich', 'II. Adagio. Sehr feierlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 6번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:617f7d36-8a2a-31c6-aa2c-44284bfc115e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d93ca50d-b56a-3b84-a346-f5d4f1c293e0', 3, 'III', '스케르초. Nicht schnell – 트리오. Langsam', 'III. Scherzo. Nicht schnell – Trio. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 6번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d93ca50d-b56a-3b84-a346-f5d4f1c293e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a87148a1-2bb6-395e-bac5-7d877add1dab', 4, 'IV', '피날레. Bewegt, doch nicht zu schnell', 'IV. Finale. Bewegt, doch nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 6번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a87148a1-2bb6-395e-bac5-7d877add1dab'
);


-- WAB 107 교향곡 7번 E장조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de28e84c-edcd-4882-9b6d-398af016a5a9', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 183 AND p.composer_id = 41
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de28e84c-edcd-4882-9b6d-398af016a5a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b3affe2-0da8-493d-9017-5d6c24221430', 2, 'II', 'Adagio. Sehr feierlich und sehr langsam', 'II. Adagio. Sehr feierlich und sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 183 AND p.composer_id = 41
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b3affe2-0da8-493d-9017-5d6c24221430'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:deee87bb-8673-4122-8fcd-b54927914ac4', 3, 'III', '스케르초. Sehr schnell', 'III. Scherzo. Sehr schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 183 AND p.composer_id = 41
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:deee87bb-8673-4122-8fcd-b54927914ac4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dff2e98f-2289-4f97-b3e9-07ad21e23fd1', 4, 'IV', '피날레. Bewegt, doch nicht schnell', 'IV. Finale. Bewegt, doch nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 183 AND p.composer_id = 41
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dff2e98f-2289-4f97-b3e9-07ad21e23fd1'
);


-- WAB 108 교향곡 8번 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 8번 C단조', 'Symphony No. 8 in C minor', 'album', 'WAB 108', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 8번 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c84bb04b-dbc2-493d-a3e0-ba19eab6fc1d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c84bb04b-dbc2-493d-a3e0-ba19eab6fc1d'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 8번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c84bb04b-dbc2-493d-a3e0-ba19eab6fc1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:275050b4-9589-4101-875c-ac1aa65f71da', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 8번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:275050b4-9589-4101-875c-ac1aa65f71da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcad339e-2d27-4ae9-84e2-d0e032436b15', 2, 'II', '스케르초. Allegro moderato – 트리오. Langsam', 'II. Scherzo. Allegro moderato – Trio. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 8번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcad339e-2d27-4ae9-84e2-d0e032436b15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac7d186f-b69b-491f-a5cd-7eacc60c695e', 3, 'III', 'Adagio. Feierlich langsam, doch nicht schleppend', 'III. Adagio. Feierlich langsam, doch nicht schleppend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 8번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac7d186f-b69b-491f-a5cd-7eacc60c695e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e995164-c338-4777-9e8f-753fdc1a64e6', 4, 'IV', '피날레. Feierlich, nicht schnell', 'IV. Finale. Feierlich, nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '교향곡 8번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e995164-c338-4777-9e8f-753fdc1a64e6'
);


-- WAB 109 교향곡 9번 D단조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aebfbf85-a666-45ba-8a94-da46d93c79c2', 1, 'I', 'Feierlich, misterioso', 'I. Feierlich, misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26056 AND p.composer_id = 41
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aebfbf85-a666-45ba-8a94-da46d93c79c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4652f241-875a-4685-ad5b-6f57806c79f5', 2, 'II', '스케르초. Bewegt, lebhaft – 트리오. Schnell', 'II. Scherzo. Bewegt, lebhaft – Trio. Schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26056 AND p.composer_id = 41
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4652f241-875a-4685-ad5b-6f57806c79f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:192c2755-9b86-4c7e-99d3-806a2df43e04', 3, 'III', 'Adagio. Langsam, feierlich', 'III. Adagio. Langsam, feierlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26056 AND p.composer_id = 41
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:192c2755-9b86-4c7e-99d3-806a2df43e04'
);


-- WAB 110 바이올린과 피아노를 위한 <Abendklänge> E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 <Abendklänge> E단조', '"Abendklänge" in E minor for violin and piano', 'song', 'WAB 110', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 <Abendklänge> E단조'
);


-- WAB 111 현악 4중주 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 C단조', 'String Quartet in C minor', 'album', 'WAB 111', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7d456a0-c5fc-4a5e-bf5e-1e68d4882c67'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7d456a0-c5fc-4a5e-bf5e-1e68d4882c67'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '현악 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7d456a0-c5fc-4a5e-bf5e-1e68d4882c67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc698e33-b507-450c-bbba-da7c760d3554', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '현악 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc698e33-b507-450c-bbba-da7c760d3554'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:535b6b92-d075-455a-be23-198a9084f0bd', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '현악 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:535b6b92-d075-455a-be23-198a9084f0bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87470e1c-0a33-4d3c-b644-c8a29aa7da47', 3, 'III', '스케르초. Presto – 트리오', 'III. Scherzo. Presto – Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '현악 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87470e1c-0a33-4d3c-b644-c8a29aa7da47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91bb55bc-4756-4aca-98ba-757b201e25b9', 4, 'IV', '론도. Schnell', 'IV. Rondo. Schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '현악 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91bb55bc-4756-4aca-98ba-757b201e25b9'
);


-- WAB 112 현악 5중주 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 5중주 F장조', 'String Quintet in F major', 'album', 'WAB 112', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 5중주 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd854c6d4-f518-4c32-aeda-f5c0a83717f2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd854c6d4-f518-4c32-aeda-f5c0a83717f2'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '현악 5중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd854c6d4-f518-4c32-aeda-f5c0a83717f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:477f865e-290e-3ead-a629-9cb8bfd2f104', 1, 'I', 'Gemäßigt', 'I. Gemäßigt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '현악 5중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:477f865e-290e-3ead-a629-9cb8bfd2f104'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b32ed8c9-9c0f-3a02-a2b5-42054b3c9962', 2, 'II', '스케르초. Schnell – 트리오. Langsamer', 'II. Scherzo. Schnell – Trio. Langsamer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '현악 5중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b32ed8c9-9c0f-3a02-a2b5-42054b3c9962'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec6c3346-e71f-3b2b-ad5a-136e64405987', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '현악 5중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec6c3346-e71f-3b2b-ad5a-136e64405987'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef4d6adf-1ccf-3e83-857d-f14ad2d6b4ea', 4, 'IV', '피날레. Lebhaft bewegt', 'IV. Finale. Lebhaft bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '현악 5중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef4d6adf-1ccf-3e83-857d-f14ad2d6b4ea'
);


-- WAB 113 현악 5중주를 위한 간주곡 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 5중주를 위한 간주곡 D단조', 'Intermezzo in D minor for string quintet', 'song', 'WAB 113', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 5중주를 위한 간주곡 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f187cfe7-e83a-3a42-9733-1925871d1502'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f187cfe7-e83a-3a42-9733-1925871d1502'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '현악 5중주를 위한 간주곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f187cfe7-e83a-3a42-9733-1925871d1502'
);


-- WAB 114 세 대의 트롬본을 위한 에콸레 1번 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세 대의 트롬본을 위한 에콸레 1번 C단조', 'Aequale No. 1 in C minor for three trombones', 'song', 'WAB 114', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세 대의 트롬본을 위한 에콸레 1번 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e80ea85-3734-44a1-b157-a26f1aa990d4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6e80ea85-3734-44a1-b157-a26f1aa990d4'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '세 대의 트롬본을 위한 에콸레 1번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e80ea85-3734-44a1-b157-a26f1aa990d4'
);


-- WAB 116 군악 행진곡 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '군악 행진곡 E♭장조', 'Military March in E♭ major', 'song', 'WAB 116', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '군악 행진곡 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76f7db1e-3aa7-42b6-817a-2f7bedc19912'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '76f7db1e-3aa7-42b6-817a-2f7bedc19912'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '군악 행진곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76f7db1e-3aa7-42b6-817a-2f7bedc19912'
);


-- WAB 117 피아노곡 <Erinnerung> A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡 <Erinnerung> A♭장조', '"Erinnerung" in A♭ major', 'song', 'WAB 117', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡 <Erinnerung> A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '695be5a5-1b54-47ed-b964-53d114ece295'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '695be5a5-1b54-47ed-b964-53d114ece295'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '피아노곡 <Erinnerung> A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '695be5a5-1b54-47ed-b964-53d114ece295'
);


-- WAB 118 환상곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상곡 G장조', 'Fantasie in G major', 'song', 'WAB 118', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상곡 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4e509da-31af-4c15-abc6-651210ecd4b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4e509da-31af-4c15-abc6-651210ecd4b3'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '환상곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4e509da-31af-4c15-abc6-651210ecd4b3'
);


-- WAB 119 피아노 소품 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소품 E♭장조', 'Klavierstück in E♭ major', 'song', 'WAB 119', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소품 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '23d3763c-fe9f-4129-b9b6-d20d5e9bcc9a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '23d3763c-fe9f-4129-b9b6-d20d5e9bcc9a'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '피아노 소품 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '23d3763c-fe9f-4129-b9b6-d20d5e9bcc9a'
);


-- WAB 121 네 손을 위한 카드리유 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 카드리유 D장조', 'Quadrille in D major for piano four hands', 'album', 'WAB 121', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 카드리유 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0aaeb79d-7a42-4045-9ce8-056e937c5b41'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0aaeb79d-7a42-4045-9ce8-056e937c5b41'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '네 손을 위한 카드리유 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0aaeb79d-7a42-4045-9ce8-056e937c5b41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c469dd22-5d6d-4982-a547-c8ca2d919f71', 1, 'I', 'Pantalon. Andante con moto', 'I. Pantalon. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '네 손을 위한 카드리유 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c469dd22-5d6d-4982-a547-c8ca2d919f71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1f146bb-5706-4069-b920-8e50c1cca64b', 2, 'II', 'Été. Allegretto', 'II. Été. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '네 손을 위한 카드리유 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1f146bb-5706-4069-b920-8e50c1cca64b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b4051a9-859e-4688-8fc2-b482d9ed1ef8', 3, 'III', 'Poule. Amabile', 'III. Poule. Amabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '네 손을 위한 카드리유 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b4051a9-859e-4688-8fc2-b482d9ed1ef8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd947510-798d-4b23-a849-69f8ccaf34ab', 4, 'IV', 'Trénis. Pathetico', 'IV. Trénis. Pathetico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '네 손을 위한 카드리유 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd947510-798d-4b23-a849-69f8ccaf34ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2687caf0-b18e-4930-9b6a-3f7b23785013', 5, 'V', 'Pastourelle. Grazioso', 'V. Pastourelle. Grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '네 손을 위한 카드리유 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2687caf0-b18e-4930-9b6a-3f7b23785013'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f40c4d0-289b-4288-a600-6e9bb242a668', 6, 'VI', '피날레. Poco animato', 'VI. Finale. Poco animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '네 손을 위한 카드리유 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f40c4d0-289b-4288-a600-6e9bb242a668'
);


-- WAB 122 피아노곡 <Steiermärker> G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡 <Steiermärker> G장조', '"Steiermärker" in G major', 'song', 'WAB 122', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡 <Steiermärker> G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d7267ba-4068-4108-921c-d35a95816e85'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d7267ba-4068-4108-921c-d35a95816e85'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '피아노곡 <Steiermärker> G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d7267ba-4068-4108-921c-d35a95816e85'
);


-- WAB 123 피아노곡 <Stille Betrachtung an einem Herbstabend> F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡 <Stille Betrachtung an einem Herbstabend> F#단조', '"Stille Betrachtung an einem Herbstabend" in F# minor', 'song', 'WAB 123', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡 <Stille Betrachtung an einem Herbstabend> F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad20d836-a7e5-4255-bae5-9321d688fc27'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ad20d836-a7e5-4255-bae5-9321d688fc27'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '피아노곡 <Stille Betrachtung an einem Herbstabend> F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad20d836-a7e5-4255-bae5-9321d688fc27'
);


-- WAB 124 네 손을 위한 소품 WAB 124

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 소품 WAB 124', '3 Little Pieces for Piano Four Hands, WAB 124', 'album', NULL, 'WAB', '124', 1855, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 소품 WAB 124'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c90558fe-8e40-4917-b785-e541db771afe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c90558fe-8e40-4917-b785-e541db771afe'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '네 손을 위한 소품 WAB 124' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c90558fe-8e40-4917-b785-e541db771afe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e4dd2c2-06e7-4baf-8ad8-4af826ecf555', 1, NULL, 'G장조 (Langsam)', 'No. 1 in G major. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '네 손을 위한 소품 WAB 124' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e4dd2c2-06e7-4baf-8ad8-4af826ecf555'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b1beea8-634c-4b7a-a10d-36205805783a', 2, NULL, 'G장조 (Allegro moderato)', 'No. 2 in G major. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '네 손을 위한 소품 WAB 124' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b1beea8-634c-4b7a-a10d-36205805783a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95f89d18-fce5-411d-9e2c-f84a1493d347', 3, NULL, 'F장조 (Langsam, feierlich)', 'No. 3 in F major. Langsam, feierlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '네 손을 위한 소품 WAB 124' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95f89d18-fce5-411d-9e2c-f84a1493d347'
);


-- WAB 125 오르간 푸가 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 푸가 D단조', 'Fugue in D minor for organ', 'song', 'WAB 125', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 푸가 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aaa26bcc-b75d-4391-97de-cf52217ebb9e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aaa26bcc-b75d-4391-97de-cf52217ebb9e'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '오르간 푸가 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aaa26bcc-b75d-4391-97de-cf52217ebb9e'
);


-- WAB 126 오르간 소품 WAB 126

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 소품 WAB 126', '2 Organ Pieces in D minor, WAB 126', 'album', NULL, 'WAB', '126', 1846, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 소품 WAB 126'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:effbfada-af38-4e6b-84df-e9ffa6fafe48', 1, NULL, '후주곡 D단조', 'Postlude in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '오르간 소품 WAB 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:effbfada-af38-4e6b-84df-e9ffa6fafe48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b54013df-e9b4-4285-955b-6905d794042e', 2, NULL, '안단테 D단조', 'Andante (Prelude) in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '오르간 소품 WAB 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b54013df-e9b4-4285-955b-6905d794042e'
);


-- WAB 129 오르간 전주곡 C장조 "페르크 전주곡"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 전주곡 C장조 "페르크 전주곡"', 'Prelude in C major "Perger Präludium"', 'song', 'WAB 129', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 전주곡 C장조 "페르크 전주곡"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '514a00a0-b919-45fe-b025-f3929cd57cd0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '514a00a0-b919-45fe-b025-f3929cd57cd0'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '오르간 전주곡 C장조 "페르크 전주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '514a00a0-b919-45fe-b025-f3929cd57cd0'
);


-- WAB 131 오르간 전주곡과 푸가 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 전주곡과 푸가 C단조', 'Prelude and Fugue in C minor for organ', 'song', 'WAB 131', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 전주곡과 푸가 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8680e0cb-5b4f-490f-bfad-1d47b40f3ec9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8680e0cb-5b4f-490f-bfad-1d47b40f3ec9'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '오르간 전주곡과 푸가 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8680e0cb-5b4f-490f-bfad-1d47b40f3ec9'
);


-- WAB 146 크론슈토르프 미사 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '크론슈토르프 미사 D단조', 'Kronstorfer Messe in D minor', 'album', 'WAB 146', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '크론슈토르프 미사 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6e3a2b3-06e7-4074-909c-6af1ca7a5326'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6e3a2b3-06e7-4074-909c-6af1ca7a5326'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '크론슈토르프 미사 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6e3a2b3-06e7-4074-909c-6af1ca7a5326'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2834f4d-fc9d-4aad-a198-517e90f800c9', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '크론슈토르프 미사 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2834f4d-fc9d-4aad-a198-517e90f800c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1be07cea-f01f-40f8-a9c8-ff9c14a8e6c8', 2, 'II', '상투스', 'II. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '크론슈토르프 미사 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1be07cea-f01f-40f8-a9c8-ff9c14a8e6c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28f23423-c966-4f5b-9374-44a43902cad9', 3, 'III', '베네딕투스', 'III. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '크론슈토르프 미사 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28f23423-c966-4f5b-9374-44a43902cad9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee35c9f6-2ebc-4fdb-b1ac-7a35c6796065', 4, 'IV', '아뉴스 데이', 'IV. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '크론슈토르프 미사 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee35c9f6-2ebc-4fdb-b1ac-7a35c6796065'
);


-- WAB 147 합창곡 <Freier Sinn und froher Mut>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Freier Sinn und froher Mut>', '"Freier Sinn und froher Mut" in D major', 'song', 'WAB 147', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Freier Sinn und froher Mut>'
);


-- WAB 148 합창 모토 WAB 148

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창 모토 WAB 148', '2 Mottos, WAB 148', 'album', NULL, 'WAB', '148', 1869, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창 모토 WAB 148'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bruckner:bruckner-wab148:1', 1, NULL, 'Im Wort und Liede wahr und frei', '"Im Wort und Liede wahr und frei" in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '합창 모토 WAB 148' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bruckner:bruckner-wab148:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:bruckner:bruckner-wab148:2', 2, NULL, 'Wir alle jung und alt', '"Wir alle jung und alt" in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '합창 모토 WAB 148' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:bruckner:bruckner-wab148:2'
);


-- WAB 149 세 대의 트롬본을 위한 에콸레 2번 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세 대의 트롬본을 위한 에콸레 2번 C단조', 'Aequale No. 2 in C minor for three trombones', 'song', 'WAB 149', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세 대의 트롬본을 위한 에콸레 2번 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8b88ebe-413e-493d-b77f-f6cb157628f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8b88ebe-413e-493d-b77f-f6cb157628f6'
FROM pieces p
WHERE p.composer_id = 41 AND p.title = '세 대의 트롬본을 위한 에콸레 2번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8b88ebe-413e-493d-b77f-f6cb157628f6'
);

