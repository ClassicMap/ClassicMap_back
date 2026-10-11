-- 요한 슈트라우스 2세 작품을 출판 단위로 채운다(카탈로그: Op.). 작품 495개(묶음 0, 다악장 0, 낱곡 495),
-- 새 작품 492개, 기존 작품 3개, part 0개, 그 아래 0개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   작품번호가 곡 단위라 낱곡이다(오페레타 15·오페라 1·발레 1 포함). 남의 오페라 선율 카드리유와 포푸리는 뺀다.
--   관례 우리말 제목(황제 왈츠·폭발 폴카 등)이 없으면 앞에 우리말 갈래를 두고 원제를 꺾쇠 안에 둔다. 186 <박쥐> 서곡은 대목이라 그대로.
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

-- Op. 1 왈츠 <Sinngedichte>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Sinngedichte>', 'Waltz <Sinngedichte>', 'song', 'Op. 1', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Sinngedichte>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66ca7dbe-cfaa-4693-b371-dd4717b55cf3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '66ca7dbe-cfaa-4693-b371-dd4717b55cf3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Sinngedichte>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66ca7dbe-cfaa-4693-b371-dd4717b55cf3'
);


-- Op. 2 카드리유 <Debut-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Debut-Quadrille>', 'Quadrille <Debut-Quadrille>', 'song', 'Op. 2', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Debut-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '335874d0-2f22-4b7b-b2e4-a23402484dff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '335874d0-2f22-4b7b-b2e4-a23402484dff'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Debut-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '335874d0-2f22-4b7b-b2e4-a23402484dff'
);


-- Op. 3 폴카 <Herzenslust>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Herzenslust>', 'Polka <Herzenslust>', 'song', 'Op. 3', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Herzenslust>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd06b679d-209b-49da-b1ac-c69750b075cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd06b679d-209b-49da-b1ac-c69750b075cb'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Herzenslust>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd06b679d-209b-49da-b1ac-c69750b075cb'
);


-- Op. 4 왈츠 <Gunstwerber>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Gunstwerber>', 'Waltz <Gunstwerber>', 'song', 'Op. 4', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Gunstwerber>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90c47293-828b-4824-a2bc-2aac8389f6c3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '90c47293-828b-4824-a2bc-2aac8389f6c3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Gunstwerber>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90c47293-828b-4824-a2bc-2aac8389f6c3'
);


-- Op. 5 왈츠 <Serail-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Serail-Tänze>', 'Waltz <Serail-Tänze>', 'song', 'Op. 5', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Serail-Tänze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c076b832-cb90-4f39-a074-072c26e225ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c076b832-cb90-4f39-a074-072c26e225ee'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Serail-Tänze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c076b832-cb90-4f39-a074-072c26e225ee'
);


-- Op. 6 카드리유 <Cytheren-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Cytheren-Quadrille>', 'Quadrille <Cytheren-Quadrille>', 'song', 'Op. 6', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Cytheren-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6549d210-d267-42c4-94eb-8573858b4a7c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6549d210-d267-42c4-94eb-8573858b4a7c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Cytheren-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6549d210-d267-42c4-94eb-8573858b4a7c'
);


-- Op. 7 왈츠 <Die jungen Wiener>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die jungen Wiener>', 'Waltz <Die jungen Wiener>', 'song', 'Op. 7', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die jungen Wiener>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '887ee9b2-fbcd-4f03-92e5-59056bb86a0f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '887ee9b2-fbcd-4f03-92e5-59056bb86a0f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Die jungen Wiener>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '887ee9b2-fbcd-4f03-92e5-59056bb86a0f'
);


-- Op. 8 행진곡 <Patrioten-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Patrioten-Marsch>', 'March <Patrioten-Marsch>', 'song', 'Op. 8', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Patrioten-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2147bb4-917a-4d27-85eb-b7c8f38b3dfd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a2147bb4-917a-4d27-85eb-b7c8f38b3dfd'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Patrioten-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2147bb4-917a-4d27-85eb-b7c8f38b3dfd'
);


-- Op. 9 폴카 <Amazonen-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Amazonen-Polka>', 'Polka <Amazonen-Polka>', 'song', 'Op. 9', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Amazonen-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76df65a1-099b-43ca-a80d-5c5492328e8a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '76df65a1-099b-43ca-a80d-5c5492328e8a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Amazonen-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76df65a1-099b-43ca-a80d-5c5492328e8a'
);


-- Op. 11 왈츠 <Faschings-Lieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Faschings-Lieder>', 'Waltz <Faschings-Lieder>', 'song', 'Op. 11', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Faschings-Lieder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eab05c76-a634-40cf-95a6-26547d74c0d1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eab05c76-a634-40cf-95a6-26547d74c0d1'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Faschings-Lieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eab05c76-a634-40cf-95a6-26547d74c0d1'
);


-- Op. 12 왈츠 <Jugend-Träume>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Jugend-Träume>', 'Waltz <Jugend-Träume>', 'song', 'Op. 12', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Jugend-Träume>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ef10564-0ced-4946-b6f7-1eb2e983a5f2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7ef10564-0ced-4946-b6f7-1eb2e983a5f2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Jugend-Träume>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ef10564-0ced-4946-b6f7-1eb2e983a5f2'
);


-- Op. 13 폴카 <Czechen-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Czechen-Polka>', 'Polka <Czechen-Polka>', 'song', 'Op. 13', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Czechen-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a19eb6d2-d38a-486a-9052-89a6578342a2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a19eb6d2-d38a-486a-9052-89a6578342a2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Czechen-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a19eb6d2-d38a-486a-9052-89a6578342a2'
);


-- Op. 14 카드리유 <Serben-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Serben-Quadrille>', 'Quadrille <Serben-Quadrille>', 'song', 'Op. 14', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Serben-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '566347b0-88b6-4f74-a057-055467a3d5ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '566347b0-88b6-4f74-a057-055467a3d5ef'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Serben-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '566347b0-88b6-4f74-a057-055467a3d5ef'
);


-- Op. 15 왈츠 <Sträusschen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Sträusschen>', 'Waltz <Sträusschen>', 'song', 'Op. 15', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Sträusschen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7096fdd1-b84e-47f8-b352-530774fc63ae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7096fdd1-b84e-47f8-b352-530774fc63ae'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Sträusschen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7096fdd1-b84e-47f8-b352-530774fc63ae'
);


-- Op. 16 카드리유 <Elfen-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Elfen-Quadrille>', 'Quadrille <Elfen-Quadrille>', 'song', 'Op. 16', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Elfen-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'edbf793e-c962-449e-8d73-2b5a5e65dde0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'edbf793e-c962-449e-8d73-2b5a5e65dde0'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Elfen-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'edbf793e-c962-449e-8d73-2b5a5e65dde0'
);


-- Op. 17 폴카 <Jux-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Jux-Polka>', 'Polka <Jux-Polka>', 'song', 'Op. 17', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Jux-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b591f51b-fe6f-443a-9572-08d0a9503c77'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b591f51b-fe6f-443a-9572-08d0a9503c77'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Jux-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b591f51b-fe6f-443a-9572-08d0a9503c77'
);


-- Op. 18 왈츠 <Berglieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Berglieder>', 'Waltz <Berglieder>', 'song', 'Op. 18', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Berglieder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '33b234e9-e464-42d8-943a-9e9382468706'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '33b234e9-e464-42d8-943a-9e9382468706'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Berglieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '33b234e9-e464-42d8-943a-9e9382468706'
);


-- Op. 19 카드리유 <Dämonen-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Dämonen-Quadrille>', 'Quadrille <Dämonen-Quadrille>', 'song', 'Op. 19', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Dämonen-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b1c6878-02fb-4760-a33e-6d0c60683f21'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b1c6878-02fb-4760-a33e-6d0c60683f21'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Dämonen-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b1c6878-02fb-4760-a33e-6d0c60683f21'
);


-- Op. 20 행진곡 <Austria-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Austria-Marsch>', 'March <Austria-Marsch>', 'song', 'Op. 20', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Austria-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '286d1c23-ebac-430c-a09d-a38df0012449'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '286d1c23-ebac-430c-a09d-a38df0012449'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Austria-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '286d1c23-ebac-430c-a09d-a38df0012449'
);


-- Op. 21 왈츠 <Lind-Gesänge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Lind-Gesänge>', 'Waltz <Lind-Gesänge>', 'song', 'Op. 21', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Lind-Gesänge>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1fd21b0a-2612-4e44-91b5-1144b73ed4c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1fd21b0a-2612-4e44-91b5-1144b73ed4c8'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Lind-Gesänge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1fd21b0a-2612-4e44-91b5-1144b73ed4c8'
);


-- Op. 22 왈츠 <Die Oesterreicher>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Oesterreicher>', 'Waltz <Die Oesterreicher>', 'song', 'Op. 22', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Oesterreicher>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ec64620-fb25-4dbd-bee7-b91cddff135b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ec64620-fb25-4dbd-bee7-b91cddff135b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Die Oesterreicher>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ec64620-fb25-4dbd-bee7-b91cddff135b'
);


-- Op. 23 차르다시 <Pesther Czárdás>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '차르다시 <Pesther Czárdás>', 'Csárdás <Pesther Czárdás>', 'song', 'Op. 23', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '차르다시 <Pesther Czárdás>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e09c029d-948a-4cff-b0bf-8ccd1240bc65'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e09c029d-948a-4cff-b0bf-8ccd1240bc65'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '차르다시 <Pesther Czárdás>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e09c029d-948a-4cff-b0bf-8ccd1240bc65'
);


-- Op. 25 왈츠 <Zeitgeister>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Zeitgeister>', 'Waltz <Zeitgeister>', 'song', 'Op. 25', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Zeitgeister>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9d3e9a2-d847-42c7-93ca-a3bb1c98d395'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9d3e9a2-d847-42c7-93ca-a3bb1c98d395'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Zeitgeister>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9d3e9a2-d847-42c7-93ca-a3bb1c98d395'
);


-- Op. 26 폴카 <Fidelen-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Fidelen-Polka>', 'Polka <Fidelen-Polka>', 'song', 'Op. 26', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Fidelen-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed8a68b8-8054-4d8f-99d6-07a15db5c97c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed8a68b8-8054-4d8f-99d6-07a15db5c97c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Fidelen-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed8a68b8-8054-4d8f-99d6-07a15db5c97c'
);


-- Op. 27 왈츠 <Die Sanguiniker>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Sanguiniker>', 'Waltz <Die Sanguiniker>', 'song', 'Op. 27', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Sanguiniker>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b56c4d27-227f-4d25-896d-387f36921b22'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b56c4d27-227f-4d25-896d-387f36921b22'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Die Sanguiniker>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b56c4d27-227f-4d25-896d-387f36921b22'
);


-- Op. 28 폴카 <Hopser-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Hopser-Polka>', 'Polka <Hopser-Polka>', 'song', 'Op. 28', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Hopser-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0db7ff9b-cb4c-4d93-b06a-8268e5497dc9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0db7ff9b-cb4c-4d93-b06a-8268e5497dc9'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Hopser-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0db7ff9b-cb4c-4d93-b06a-8268e5497dc9'
);


-- Op. 29 카드리유 <Odeon-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Odeon-Quadrille>', 'Quadrille <Odeon-Quadrille>', 'song', 'Op. 29', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Odeon-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b17049d3-5b29-49ed-958a-b38d65b1e06a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b17049d3-5b29-49ed-958a-b38d65b1e06a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Odeon-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b17049d3-5b29-49ed-958a-b38d65b1e06a'
);


-- Op. 30 왈츠 <Die Zillerthaler>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Zillerthaler>', 'Waltz <Die Zillerthaler>', 'song', 'Op. 30', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Zillerthaler>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3466c4b5-e8a0-41f3-b786-1c85bebb9e41'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3466c4b5-e8a0-41f3-b786-1c85bebb9e41'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Die Zillerthaler>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3466c4b5-e8a0-41f3-b786-1c85bebb9e41'
);


-- Op. 32 왈츠 <Irenen-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Irenen-Walzer>', 'Waltz <Irenen-Walzer>', 'song', 'Op. 32', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Irenen-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8bb61da-bf89-48e6-84fa-56faac7c6a73'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8bb61da-bf89-48e6-84fa-56faac7c6a73'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Irenen-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8bb61da-bf89-48e6-84fa-56faac7c6a73'
);


-- Op. 33 카드리유 <Alexander-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Alexander-Quadrille>', 'Quadrille <Alexander-Quadrille>', 'song', 'Op. 33', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Alexander-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c40caf6-ae54-427b-bc96-70834d35c435'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c40caf6-ae54-427b-bc96-70834d35c435'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Alexander-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c40caf6-ae54-427b-bc96-70834d35c435'
);


-- Op. 34 왈츠 <Die Jovialen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Jovialen>', 'Waltz <Die Jovialen>', 'song', 'Op. 34', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Jovialen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8cd95d6a-5c3c-4ca5-a86a-155373adb3bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8cd95d6a-5c3c-4ca5-a86a-155373adb3bf'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Die Jovialen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8cd95d6a-5c3c-4ca5-a86a-155373adb3bf'
);


-- Op. 35 카드리유 <Industrie-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Industrie-Quadrille>', 'Quadrille <Industrie-Quadrille>', 'song', 'Op. 35', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Industrie-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fc8e2ff-f504-4f41-8c5a-d322fd5875ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7fc8e2ff-f504-4f41-8c5a-d322fd5875ea'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Industrie-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fc8e2ff-f504-4f41-8c5a-d322fd5875ea'
);


-- Op. 36 왈츠 <Architecten-Ball-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Architecten-Ball-Tänze>', 'Waltz <Architecten-Ball-Tänze>', 'song', 'Op. 36', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Architecten-Ball-Tänze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97e979cf-3c8a-4cc9-9f5b-30bdef49fec2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '97e979cf-3c8a-4cc9-9f5b-30bdef49fec2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Architecten-Ball-Tänze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97e979cf-3c8a-4cc9-9f5b-30bdef49fec2'
);


-- Op. 37 카드리유 <Wilhelminen-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Wilhelminen-Quadrille>', 'Quadrille <Wilhelminen-Quadrille>', 'song', 'Op. 37', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Wilhelminen-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1d56754-5883-4b1a-8a23-666c35f6708a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd1d56754-5883-4b1a-8a23-666c35f6708a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Wilhelminen-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1d56754-5883-4b1a-8a23-666c35f6708a'
);


-- Op. 38 폴카 <Bachus-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Bachus-Polka>', 'Polka <Bachus-Polka>', 'song', 'Op. 38', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Bachus-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6265d90-f697-430f-b1c6-de326f6ca69d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b6265d90-f697-430f-b1c6-de326f6ca69d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Bachus-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6265d90-f697-430f-b1c6-de326f6ca69d'
);


-- Op. 39 포푸리 <Slaven-Potpourri>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '포푸리 <Slaven-Potpourri>', 'Potpourri <Slaven-Potpourri>', 'song', 'Op. 39', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '포푸리 <Slaven-Potpourri>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0d7bd6b-29bf-493a-92ea-2378411b56ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0d7bd6b-29bf-493a-92ea-2378411b56ba'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '포푸리 <Slaven-Potpourri>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0d7bd6b-29bf-493a-92ea-2378411b56ba'
);


-- Op. 41 왈츠 <Sängerfahrten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Sängerfahrten>', 'Waltz <Sängerfahrten>', 'song', 'Op. 41', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Sängerfahrten>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d91dbd5-42dd-47ad-b280-6a9150908b9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5d91dbd5-42dd-47ad-b280-6a9150908b9c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Sängerfahrten>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d91dbd5-42dd-47ad-b280-6a9150908b9c'
);


-- Op. 42 왈츠 <Wilde Rosen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Wilde Rosen>', 'Waltz <Wilde Rosen>', 'song', 'Op. 42', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Wilde Rosen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90733f93-4116-4340-b05a-9fd564a6641b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '90733f93-4116-4340-b05a-9fd564a6641b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Wilde Rosen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90733f93-4116-4340-b05a-9fd564a6641b'
);


-- Op. 43 폭발 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폭발 폴카', 'Explosions-Polka', 'song', 'Op. 43', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폭발 폴카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2333eef5-1422-3c7f-8213-a5897c3fdfe1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2333eef5-1422-3c7f-8213-a5897c3fdfe1'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폭발 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2333eef5-1422-3c7f-8213-a5897c3fdfe1'
);


-- Op. 44 카드리유 <Fest-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Fest-Quadrille>', 'Quadrille <Fest-Quadrille>', 'song', 'Op. 44', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Fest-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73e0724d-39e1-4676-9600-fb26b7c94a99'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '73e0724d-39e1-4676-9600-fb26b7c94a99'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Fest-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73e0724d-39e1-4676-9600-fb26b7c94a99'
);


-- Op. 45 왈츠 <Ernte-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Ernte-Tänze>', 'Waltz <Ernte-Tänze>', 'song', 'Op. 45', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Ernte-Tänze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '180f939c-c64a-48be-8383-ba3b6f023323'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '180f939c-c64a-48be-8383-ba3b6f023323'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Ernte-Tänze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '180f939c-c64a-48be-8383-ba3b6f023323'
);


-- Op. 47 왈츠 <Dorfgeschichten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Dorfgeschichten>', 'Waltz <Dorfgeschichten>', 'song', 'Op. 47', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Dorfgeschichten>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ed80d9f-b3a1-47cf-a395-bccf622cfc1e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9ed80d9f-b3a1-47cf-a395-bccf622cfc1e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Dorfgeschichten>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ed80d9f-b3a1-47cf-a395-bccf622cfc1e'
);


-- Op. 48 카드리유 <Seladon-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Seladon-Quadrille>', 'Quadrille <Seladon-Quadrille>', 'song', 'Op. 48', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Seladon-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd80900fd-60bc-4c20-b576-e238c1321555'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd80900fd-60bc-4c20-b576-e238c1321555'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Seladon-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd80900fd-60bc-4c20-b576-e238c1321555'
);


-- Op. 49 행진곡 <Fest-Marsch> Op. 49

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Fest-Marsch> Op. 49', 'March <Fest-Marsch>, Op. 49', 'song', NULL, 'Op.', '49', 1847, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Fest-Marsch> Op. 49'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a753915-fc2d-46ec-92f8-b5bc31847018'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3a753915-fc2d-46ec-92f8-b5bc31847018'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Fest-Marsch> Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a753915-fc2d-46ec-92f8-b5bc31847018'
);


-- Op. 50 왈츠 <Klänge aus der Walachei>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Klänge aus der Walachei>', 'Waltz <Klänge aus der Walachei>', 'song', 'Op. 50', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Klänge aus der Walachei>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '641adbbf-3318-485b-a5be-df4e7806fbe5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '641adbbf-3318-485b-a5be-df4e7806fbe5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Klänge aus der Walachei>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '641adbbf-3318-485b-a5be-df4e7806fbe5'
);


-- Op. 51 카드리유 <Marien-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Marien-Quadrille>', 'Quadrille <Marien-Quadrille>', 'song', 'Op. 51', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Marien-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '564db42b-0a5c-41ce-8a0b-6d2b11966302'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '564db42b-0a5c-41ce-8a0b-6d2b11966302'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Marien-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '564db42b-0a5c-41ce-8a0b-6d2b11966302'
);


-- Op. 52 왈츠 <Freiheits-Lieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Freiheits-Lieder>', 'Waltz <Freiheits-Lieder>', 'song', 'Op. 52', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Freiheits-Lieder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37a2e8be-747f-4b03-a232-7c8a60e484f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '37a2e8be-747f-4b03-a232-7c8a60e484f5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Freiheits-Lieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37a2e8be-747f-4b03-a232-7c8a60e484f5'
);


-- Op. 53 카드리유 <Annika-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Annika-Quadrille>', 'Quadrille <Annika-Quadrille>', 'song', 'Op. 53', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Annika-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3ec1296-fc9a-4875-8bf3-d85a91dd3f74'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f3ec1296-fc9a-4875-8bf3-d85a91dd3f74'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Annika-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3ec1296-fc9a-4875-8bf3-d85a91dd3f74'
);


-- Op. 54 행진곡 <Revolutions-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Revolutions-Marsch>', 'March <Revolutions-Marsch>', 'song', 'Op. 54', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Revolutions-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff7da47a-ca68-4193-859f-fbe785b56668'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ff7da47a-ca68-4193-859f-fbe785b56668'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Revolutions-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff7da47a-ca68-4193-859f-fbe785b56668'
);


-- Op. 55 왈츠 <Burschen-Lieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Burschen-Lieder>', 'Waltz <Burschen-Lieder>', 'song', 'Op. 55', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Burschen-Lieder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '975bbd16-4034-45e7-a305-f37c5fa571ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '975bbd16-4034-45e7-a305-f37c5fa571ff'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Burschen-Lieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '975bbd16-4034-45e7-a305-f37c5fa571ff'
);


-- Op. 56 행진곡 <Studenten-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Studenten-Marsch>', 'March <Studenten-Marsch>', 'song', 'Op. 56', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Studenten-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70e9d628-de1e-4a8d-b999-feb4fa237378'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '70e9d628-de1e-4a8d-b999-feb4fa237378'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Studenten-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70e9d628-de1e-4a8d-b999-feb4fa237378'
);


-- Op. 57 폴카 <Liguorianer-Seufzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Liguorianer-Seufzer>', 'Polka <Liguorianer-Seufzer>', 'song', 'Op. 57', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Liguorianer-Seufzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '367b875e-fd0e-4d2a-9645-d8e180abcc15'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '367b875e-fd0e-4d2a-9645-d8e180abcc15'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Liguorianer-Seufzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '367b875e-fd0e-4d2a-9645-d8e180abcc15'
);


-- Op. 58 행진곡 <Brünner-Nationalgarde-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Brünner-Nationalgarde-Marsch>', 'March <Brünner-Nationalgarde-Marsch>', 'song', 'Op. 58', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Brünner-Nationalgarde-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '204b5992-b726-4056-ac66-e0346b9842d3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '204b5992-b726-4056-ac66-e0346b9842d3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Brünner-Nationalgarde-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '204b5992-b726-4056-ac66-e0346b9842d3'
);


-- Op. 60 폴카 <Geisselhiebe-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Geisselhiebe-Polka>', 'Polka <Geisselhiebe-Polka>', 'song', 'Op. 60', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Geisselhiebe-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '153fa1d1-af55-4151-86cc-4a28ac8b1e9f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '153fa1d1-af55-4151-86cc-4a28ac8b1e9f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Geisselhiebe-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '153fa1d1-af55-4151-86cc-4a28ac8b1e9f'
);


-- Op. 61 왈츠 <Neue Steierische Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Neue Steierische Tänze>', 'Waltz <Neue Steierische Tänze>', 'song', 'Op. 61', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Neue Steierische Tänze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e9df290-97cd-414e-92ce-146b70ed2c1a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8e9df290-97cd-414e-92ce-146b70ed2c1a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Neue Steierische Tänze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e9df290-97cd-414e-92ce-146b70ed2c1a'
);


-- Op. 62 왈츠 <Einheits-Klänge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Einheits-Klänge>', 'Waltz <Einheits-Klänge>', 'song', 'Op. 62', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Einheits-Klänge>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b57ba70f-2d04-465a-be50-7da5e0a27b6b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b57ba70f-2d04-465a-be50-7da5e0a27b6b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Einheits-Klänge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b57ba70f-2d04-465a-be50-7da5e0a27b6b'
);


-- Op. 63 카드리유 <Sanssouci-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Sanssouci-Quadrille>', 'Quadrille <Sanssouci-Quadrille>', 'song', 'Op. 63', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Sanssouci-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22b083db-5c76-463b-8f6d-f475ed337fbc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '22b083db-5c76-463b-8f6d-f475ed337fbc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Sanssouci-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22b083db-5c76-463b-8f6d-f475ed337fbc'
);


-- Op. 64 왈츠 <Fantasiebilder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Fantasiebilder>', 'Waltz <Fantasiebilder>', 'song', 'Op. 64', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Fantasiebilder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25886b88-17fd-408f-8d42-82a5159bf941'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '25886b88-17fd-408f-8d42-82a5159bf941'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Fantasiebilder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25886b88-17fd-408f-8d42-82a5159bf941'
);


-- Op. 65 카드리유 <Nikolai-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Nikolai-Quadrille>', 'Quadrille <Nikolai-Quadrille>', 'song', 'Op. 65', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Nikolai-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ce0de3d-4bd8-4dbd-9a38-b64ee512d4b6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9ce0de3d-4bd8-4dbd-9a38-b64ee512d4b6'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Nikolai-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ce0de3d-4bd8-4dbd-9a38-b64ee512d4b6'
);


-- Op. 66 왈츠 <D'Woaldbuama>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <D''Woaldbuama>', 'Waltz <D''Woaldbuama>', 'song', 'Op. 66', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <D''Woaldbuama>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec159728-d6c2-462a-8af3-1e1fc7077716'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec159728-d6c2-462a-8af3-1e1fc7077716'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <D''Woaldbuama>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec159728-d6c2-462a-8af3-1e1fc7077716'
);


-- Op. 67 행진곡 <Kaiser-Franz-Joseph-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Kaiser-Franz-Joseph-Marsch>', 'March <Kaiser-Franz-Joseph-Marsch>', 'song', 'Op. 67', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Kaiser-Franz-Joseph-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38216a7e-d226-4426-8b99-92e81ba6b45f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38216a7e-d226-4426-8b99-92e81ba6b45f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Kaiser-Franz-Joseph-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38216a7e-d226-4426-8b99-92e81ba6b45f'
);


-- Op. 68 왈츠 <Aeols-Töne>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Aeols-Töne>', 'Waltz <Aeols-Töne>', 'song', 'Op. 68', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Aeols-Töne>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b3decdc-58df-4675-99e2-1421d6847f9b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6b3decdc-58df-4675-99e2-1421d6847f9b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Aeols-Töne>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b3decdc-58df-4675-99e2-1421d6847f9b'
);


-- Op. 69 행진곡 <Triumph-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Triumph-Marsch>', 'March <Triumph-Marsch>', 'song', 'Op. 69', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Triumph-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd9b15b6-d0cb-4f05-ac4e-2ed62bee730d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd9b15b6-d0cb-4f05-ac4e-2ed62bee730d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Triumph-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd9b15b6-d0cb-4f05-ac4e-2ed62bee730d'
);


-- Op. 70 왈츠 <Die Gemüthlichen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Gemüthlichen>', 'Waltz <Die Gemüthlichen>', 'song', 'Op. 70', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Gemüthlichen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20ba7a9e-2a65-4367-bd81-282fe7b27282'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '20ba7a9e-2a65-4367-bd81-282fe7b27282'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Die Gemüthlichen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20ba7a9e-2a65-4367-bd81-282fe7b27282'
);


-- Op. 71 카드리유 <Künstler-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Künstler-Quadrille>', 'Quadrille <Künstler-Quadrille>', 'song', 'Op. 71', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Künstler-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '240b2013-c46c-4c6d-a09d-08e5b004ccf5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '240b2013-c46c-4c6d-a09d-08e5b004ccf5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Künstler-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '240b2013-c46c-4c6d-a09d-08e5b004ccf5'
);


-- Op. 72 폴카 <Scherz-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Scherz-Polka>', 'Polka <Scherz-Polka>', 'song', 'Op. 72', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Scherz-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d9b68df-c74a-4963-bf49-ae7cff7cd52f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4d9b68df-c74a-4963-bf49-ae7cff7cd52f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Scherz-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d9b68df-c74a-4963-bf49-ae7cff7cd52f'
);


-- Op. 73 왈츠 <Frohsinns-Spenden>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Frohsinns-Spenden>', 'Waltz <Frohsinns-Spenden>', 'song', 'Op. 73', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Frohsinns-Spenden>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0cab223a-9066-4523-a23a-b0f74fa2f127'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0cab223a-9066-4523-a23a-b0f74fa2f127'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Frohsinns-Spenden>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0cab223a-9066-4523-a23a-b0f74fa2f127'
);


-- Op. 74 왈츠 <Lava-Ströme>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Lava-Ströme>', 'Waltz <Lava-Ströme>', 'song', 'Op. 74', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Lava-Ströme>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '476fd04c-f7ab-44a9-8304-db4276c1b5cc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '476fd04c-f7ab-44a9-8304-db4276c1b5cc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Lava-Ströme>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '476fd04c-f7ab-44a9-8304-db4276c1b5cc'
);


-- Op. 75 카드리유 <Sofien-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Sofien-Quadrille>', 'Quadrille <Sofien-Quadrille>', 'song', 'Op. 75', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Sofien-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6929367-e27f-426c-b35a-6a4afcd4d8b5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c6929367-e27f-426c-b35a-6a4afcd4d8b5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Sofien-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6929367-e27f-426c-b35a-6a4afcd4d8b5'
);


-- Op. 76 카드리유 <Attaque-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Attaque-Quadrille>', 'Quadrille <Attaque-Quadrille>', 'song', 'Op. 76', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Attaque-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f56e1ee5-5f50-490f-903e-856099c86228'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f56e1ee5-5f50-490f-903e-856099c86228'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Attaque-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f56e1ee5-5f50-490f-903e-856099c86228'
);


-- Op. 77 행진곡 <Wiener-Garnison-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Wiener-Garnison-Marsch>', 'March <Wiener-Garnison-Marsch>', 'song', 'Op. 77', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Wiener-Garnison-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74c649a6-ce5f-427b-bcec-7c1a1586b140'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '74c649a6-ce5f-427b-bcec-7c1a1586b140'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Wiener-Garnison-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74c649a6-ce5f-427b-bcec-7c1a1586b140'
);


-- Op. 78 폴카 <Heiligenstädter Rendez-vous-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Heiligenstädter Rendez-vous-Polka>', 'Polka <Heiligenstädter Rendez-vous-Polka>', 'song', 'Op. 78', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Heiligenstädter Rendez-vous-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f893dc25-7ebe-48d3-919b-5759bea2ce24'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f893dc25-7ebe-48d3-919b-5759bea2ce24'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Heiligenstädter Rendez-vous-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f893dc25-7ebe-48d3-919b-5759bea2ce24'
);


-- Op. 79 왈츠 <Maxing-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Maxing-Tänze>', 'Waltz <Maxing-Tänze>', 'song', 'Op. 79', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Maxing-Tänze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a800e02-74b8-4287-a474-a5890292316b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4a800e02-74b8-4287-a474-a5890292316b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Maxing-Tänze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a800e02-74b8-4287-a474-a5890292316b'
);


-- Op. 80 폴카 <Heski-Holki-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Heski-Holki-Polka>', 'Polka <Heski-Holki-Polka>', 'song', 'Op. 80', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Heski-Holki-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7d937e4-e2c4-4b9b-a375-01b327632ef8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b7d937e4-e2c4-4b9b-a375-01b327632ef8'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Heski-Holki-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7d937e4-e2c4-4b9b-a375-01b327632ef8'
);


-- Op. 81 왈츠 <Luisen Sympathie Klänge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Luisen Sympathie Klänge>', 'Waltz <Luisen Sympathie Klänge>', 'song', 'Op. 81', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Luisen Sympathie Klänge>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c36f080e-33d1-4768-a7b2-4eadfe3d4632'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c36f080e-33d1-4768-a7b2-4eadfe3d4632'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Luisen Sympathie Klänge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c36f080e-33d1-4768-a7b2-4eadfe3d4632'
);


-- Op. 82 왈츠 <Johannis-Käferln>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Johannis-Käferln>', 'Waltz <Johannis-Käferln>', 'song', 'Op. 82', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Johannis-Käferln>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72b056b8-06d0-4606-9e5b-1c67f3f181fe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72b056b8-06d0-4606-9e5b-1c67f3f181fe'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Johannis-Käferln>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72b056b8-06d0-4606-9e5b-1c67f3f181fe'
);


-- Op. 83 행진곡 <Ottinger-Reiter-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Ottinger-Reiter-Marsch>', 'March <Ottinger-Reiter-Marsch>', 'song', 'Op. 83', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Ottinger-Reiter-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98434d42-a511-4f9d-bc40-d18877e19582'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '98434d42-a511-4f9d-bc40-d18877e19582'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Ottinger-Reiter-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98434d42-a511-4f9d-bc40-d18877e19582'
);


-- Op. 84 폴카 <Warschauer Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Warschauer Polka>', 'Polka <Warschauer Polka>', 'song', 'Op. 84', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Warschauer Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6774771-a8cc-4654-a478-61a8406305e5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a6774771-a8cc-4654-a478-61a8406305e5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Warschauer Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6774771-a8cc-4654-a478-61a8406305e5'
);


-- Op. 85 왈츠 <Heimaths-Kinder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Heimaths-Kinder>', 'Waltz <Heimaths-Kinder>', 'song', 'Op. 85', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Heimaths-Kinder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6d3f018-5397-4cb5-ba85-489ba0c5efc2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a6d3f018-5397-4cb5-ba85-489ba0c5efc2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Heimaths-Kinder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6d3f018-5397-4cb5-ba85-489ba0c5efc2'
);


-- Op. 86 카드리유 <Bonvivant-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Bonvivant-Quadrille>', 'Quadrille <Bonvivant-Quadrille>', 'song', 'Op. 86', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Bonvivant-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78509bcd-cbfc-4afc-9da3-ba941cdeb5ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '78509bcd-cbfc-4afc-9da3-ba941cdeb5ec'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Bonvivant-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78509bcd-cbfc-4afc-9da3-ba941cdeb5ec'
);


-- Op. 87 왈츠 <Aurora-Ball-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Aurora-Ball-Tänze>', 'Waltz <Aurora-Ball-Tänze>', 'song', 'Op. 87', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Aurora-Ball-Tänze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dac82a3-a8c0-4709-a2a5-ec5956e150e4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2dac82a3-a8c0-4709-a2a5-ec5956e150e4'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Aurora-Ball-Tänze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dac82a3-a8c0-4709-a2a5-ec5956e150e4'
);


-- Op. 88 카드리유 <Slaven-Ball-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Slaven-Ball-Quadrille>', 'Quadrille <Slaven-Ball-Quadrille>', 'song', 'Op. 88', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Slaven-Ball-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '563b6e8a-011d-4d34-aafd-bfda5c8ac3e3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '563b6e8a-011d-4d34-aafd-bfda5c8ac3e3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Slaven-Ball-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '563b6e8a-011d-4d34-aafd-bfda5c8ac3e3'
);


-- Op. 89 왈츠 <Hirten-Spiele>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Hirten-Spiele>', 'Waltz <Hirten-Spiele>', 'song', 'Op. 89', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Hirten-Spiele>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ca92d48-6f9e-47bc-81b4-bfbc5203bc70'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3ca92d48-6f9e-47bc-81b4-bfbc5203bc70'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Hirten-Spiele>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ca92d48-6f9e-47bc-81b4-bfbc5203bc70'
);


-- Op. 90 왈츠 <Orakel-Sprüche>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Orakel-Sprüche>', 'Waltz <Orakel-Sprüche>', 'song', 'Op. 90', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Orakel-Sprüche>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbeb2b83-1ada-4c32-919f-50615dea7500'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dbeb2b83-1ada-4c32-919f-50615dea7500'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Orakel-Sprüche>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbeb2b83-1ada-4c32-919f-50615dea7500'
);


-- Op. 91 폴카 <Herrmann-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Herrmann-Polka>', 'Polka <Herrmann-Polka>', 'song', 'Op. 91', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Herrmann-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b53a3bca-5cce-4812-811b-d1884740d29b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b53a3bca-5cce-4812-811b-d1884740d29b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Herrmann-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b53a3bca-5cce-4812-811b-d1884740d29b'
);


-- Op. 92 카드리유 <Maskenfest-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Maskenfest-Quadrille>', 'Quadrille <Maskenfest-Quadrille>', 'song', 'Op. 92', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Maskenfest-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42de8f53-a862-4a82-9e0c-8f64c0136d3f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '42de8f53-a862-4a82-9e0c-8f64c0136d3f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Maskenfest-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42de8f53-a862-4a82-9e0c-8f64c0136d3f'
);


-- Op. 93 행진곡 <Kaiser-Jäger-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Kaiser-Jäger-Marsch>', 'March <Kaiser-Jäger-Marsch>', 'song', 'Op. 93', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Kaiser-Jäger-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8ab2988-f5b8-4a7a-9df7-a0cd5daa9dac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b8ab2988-f5b8-4a7a-9df7-a0cd5daa9dac'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Kaiser-Jäger-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8ab2988-f5b8-4a7a-9df7-a0cd5daa9dac'
);


-- Op. 94 왈츠 <Rhadamantus-Klänge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Rhadamantus-Klänge>', 'Waltz <Rhadamantus-Klänge>', 'song', 'Op. 94', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Rhadamantus-Klänge>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8353bfe-8c53-451c-b59e-078ec76f2fbc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b8353bfe-8c53-451c-b59e-078ec76f2fbc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Rhadamantus-Klänge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8353bfe-8c53-451c-b59e-078ec76f2fbc'
);


-- Op. 95 왈츠 <Idyllen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Idyllen>', 'Waltz <Idyllen>', 'song', 'Op. 95', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Idyllen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9a557f2-d09d-45b3-be10-90747b1db0aa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f9a557f2-d09d-45b3-be10-90747b1db0aa'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Idyllen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9a557f2-d09d-45b3-be10-90747b1db0aa'
);


-- Op. 96 행진곡 <Viribus unitis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Viribus unitis>', 'March <Viribus unitis>', 'song', 'Op. 96', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Viribus unitis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f3476f4-f89c-4260-a053-2f82daddb22b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7f3476f4-f89c-4260-a053-2f82daddb22b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Viribus unitis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f3476f4-f89c-4260-a053-2f82daddb22b'
);


-- Op. 97 왈츠 <Gambrinus-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Gambrinus-Tänze>', 'Waltz <Gambrinus-Tänze>', 'song', 'Op. 97', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Gambrinus-Tänze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a0996dd-7703-4fd8-97c8-62fb9db0cc18'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a0996dd-7703-4fd8-97c8-62fb9db0cc18'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Gambrinus-Tänze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a0996dd-7703-4fd8-97c8-62fb9db0cc18'
);


-- Op. 98 카드리유 <Promenade-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Promenade-Quadrille>', 'Quadrille <Promenade-Quadrille>', 'song', 'Op. 98', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Promenade-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07f2f95d-d752-4ea4-93f6-efc149378b80'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07f2f95d-d752-4ea4-93f6-efc149378b80'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Promenade-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07f2f95d-d752-4ea4-93f6-efc149378b80'
);


-- Op. 99 왈츠 <Frauenkäferln>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Frauenkäferln>', 'Waltz <Frauenkäferln>', 'song', 'Op. 99', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Frauenkäferln>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62158d09-2bea-40ee-af3d-12c0ace178a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '62158d09-2bea-40ee-af3d-12c0ace178a4'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Frauenkäferln>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62158d09-2bea-40ee-af3d-12c0ace178a4'
);


-- Op. 100 폴카 <Vöslauer Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Vöslauer Polka>', 'Polka <Vöslauer Polka>', 'song', 'Op. 100', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Vöslauer Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c00189e0-a7a3-4923-8353-fdabe9f84572'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c00189e0-a7a3-4923-8353-fdabe9f84572'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Vöslauer Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c00189e0-a7a3-4923-8353-fdabe9f84572'
);


-- Op. 101 왈츠 <Mephisto's Höllenrufe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Mephisto''s Höllenrufe>', 'Waltz <Mephisto''s Höllenrufe>', 'song', 'Op. 101', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Mephisto''s Höllenrufe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '935567f7-ffba-4c32-9d6c-0f4449232089'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '935567f7-ffba-4c32-9d6c-0f4449232089'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Mephisto''s Höllenrufe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '935567f7-ffba-4c32-9d6c-0f4449232089'
);


-- Op. 102 폴카 <Albion-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Albion-Polka>', 'Polka <Albion-Polka>', 'song', 'Op. 102', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Albion-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '320b3927-2780-414d-9e84-042c9238bbc3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '320b3927-2780-414d-9e84-042c9238bbc3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Albion-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '320b3927-2780-414d-9e84-042c9238bbc3'
);


-- Op. 103 카드리유 <Vivat!-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Vivat!-Quadrille>', 'Quadrille <Vivat!-Quadrille>', 'song', 'Op. 103', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Vivat!-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc98b68e-63c6-47ae-983c-b90f6cb486d7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc98b68e-63c6-47ae-983c-b90f6cb486d7'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Vivat!-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc98b68e-63c6-47ae-983c-b90f6cb486d7'
);


-- Op. 104 왈츠 <Windsor-Klänge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Windsor-Klänge>', 'Waltz <Windsor-Klänge>', 'song', 'Op. 104', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Windsor-Klänge>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '269d4877-86ac-483d-900e-7211815f4760'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '269d4877-86ac-483d-900e-7211815f4760'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Windsor-Klänge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '269d4877-86ac-483d-900e-7211815f4760'
);


-- Op. 105 왈츠 <Fünf Paragraphe aus dem Walzer-Codex>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Fünf Paragraphe aus dem Walzer-Codex>', 'Waltz <Fünf Paragraphe aus dem Walzer-Codex>', 'song', 'Op. 105', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Fünf Paragraphe aus dem Walzer-Codex>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10f819b9-3260-43db-9604-ec588d89ecaf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '10f819b9-3260-43db-9604-ec588d89ecaf'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Fünf Paragraphe aus dem Walzer-Codex>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10f819b9-3260-43db-9604-ec588d89ecaf'
);


-- Op. 106 폴카 <Harmonie-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Harmonie-Polka>', 'Polka française <Harmonie-Polka>', 'song', 'Op. 106', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Harmonie-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0a69efc-bbc4-4f78-a574-79ec480eddc0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0a69efc-bbc4-4f78-a574-79ec480eddc0'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Harmonie-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0a69efc-bbc4-4f78-a574-79ec480eddc0'
);


-- Op. 107 행진곡 <Großfürsten-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Großfürsten-Marsch>', 'March <Großfürsten-Marsch>', 'song', 'Op. 107', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Großfürsten-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9766d3c3-59ba-4232-8313-f5566bfe201a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9766d3c3-59ba-4232-8313-f5566bfe201a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Großfürsten-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9766d3c3-59ba-4232-8313-f5566bfe201a'
);


-- Op. 108 왈츠 <Die Unzertrennlichen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Unzertrennlichen>', 'Waltz <Die Unzertrennlichen>', 'song', 'Op. 108', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Unzertrennlichen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9013897-ca63-43a3-bb11-dee71926ee1e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f9013897-ca63-43a3-bb11-dee71926ee1e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Die Unzertrennlichen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9013897-ca63-43a3-bb11-dee71926ee1e'
);


-- Op. 109 카드리유 <Tête-à-Tête-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Tête-à-Tête-Quadrille>', 'Quadrille <Tête-à-Tête-Quadrille>', 'song', 'Op. 109', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Tête-à-Tête-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21c30dcf-f436-4775-b23b-672a1507e28e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '21c30dcf-f436-4775-b23b-672a1507e28e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Tête-à-Tête-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21c30dcf-f436-4775-b23b-672a1507e28e'
);


-- Op. 110 폴카 <Electro-magnetische-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Electro-magnetische-Polka>', 'Polka <Electro-magnetische-Polka>', 'song', 'Op. 110', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Electro-magnetische-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b390a72f-ee1d-36bd-a58f-61112dff6b84'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b390a72f-ee1d-36bd-a58f-61112dff6b84'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Electro-magnetische-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b390a72f-ee1d-36bd-a58f-61112dff6b84'
);


-- Op. 111 폴카 <Blumenfest-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Blumenfest-Polka>', 'Polka française <Blumenfest-Polka>', 'song', 'Op. 111', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Blumenfest-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6141b80-e17c-4fda-978a-4aa46ed787ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6141b80-e17c-4fda-978a-4aa46ed787ab'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Blumenfest-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6141b80-e17c-4fda-978a-4aa46ed787ab'
);


-- Op. 113 행진곡 <Sachsen-Kürassier-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Sachsen-Kürassier-Marsch>', 'March <Sachsen-Kürassier-Marsch>', 'song', 'Op. 113', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Sachsen-Kürassier-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '848473bf-29f1-44ad-b4e7-b6caf503a619'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '848473bf-29f1-44ad-b4e7-b6caf503a619'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Sachsen-Kürassier-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '848473bf-29f1-44ad-b4e7-b6caf503a619'
);


-- Op. 114 왈츠 <Liebeslieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Liebeslieder>', 'Waltz <Liebeslieder>', 'song', 'Op. 114', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Liebeslieder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8be951cd-753a-302b-80a7-268420ac2c13'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8be951cd-753a-302b-80a7-268420ac2c13'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Liebeslieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8be951cd-753a-302b-80a7-268420ac2c13'
);


-- Op. 115 행진곡 <Wiener Jubel-Gruß-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Wiener Jubel-Gruß-Marsch>', 'March <Wiener Jubel-Gruß-Marsch>', 'song', 'Op. 115', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Wiener Jubel-Gruß-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9600bf0f-9d2d-4de8-b915-5461b407b95d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9600bf0f-9d2d-4de8-b915-5461b407b95d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Wiener Jubel-Gruß-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9600bf0f-9d2d-4de8-b915-5461b407b95d'
);


-- Op. 116 카드리유 <Hofball-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Hofball-Quadrille>', 'Quadrille <Hofball-Quadrille>', 'song', 'Op. 116', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Hofball-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3771a965-f6ed-4f0d-9e3e-78c7f2b57612'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3771a965-f6ed-4f0d-9e3e-78c7f2b57612'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Hofball-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3771a965-f6ed-4f0d-9e3e-78c7f2b57612'
);


-- Op. 117 안넨 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안넨 폴카', 'Annen-Polka', 'song', 'Op. 117', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안넨 폴카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62308818-2d79-39eb-9794-551ba9722370'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '62308818-2d79-39eb-9794-551ba9722370'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '안넨 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62308818-2d79-39eb-9794-551ba9722370'
);


-- Op. 118 왈츠 <Lockvögel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Lockvögel>', 'Waltz <Lockvögel>', 'song', 'Op. 118', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Lockvögel>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f7fe278-c360-4ee8-a477-84f2fc1fe451'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f7fe278-c360-4ee8-a477-84f2fc1fe451'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Lockvögel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f7fe278-c360-4ee8-a477-84f2fc1fe451'
);


-- Op. 119 왈츠 <Volkssänger>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Volkssänger>', 'Waltz <Volkssänger>', 'song', 'Op. 119', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Volkssänger>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c293029-3cc8-44c5-bcf7-7893016981fc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7c293029-3cc8-44c5-bcf7-7893016981fc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Volkssänger>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c293029-3cc8-44c5-bcf7-7893016981fc'
);


-- Op. 120 카드리유 <Nocturne-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Nocturne-Quadrille>', 'Quadrille <Nocturne-Quadrille>', 'song', 'Op. 120', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Nocturne-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '419e3c47-7795-497b-a0e2-9c6c37e5c3f4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '419e3c47-7795-497b-a0e2-9c6c37e5c3f4'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Nocturne-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '419e3c47-7795-497b-a0e2-9c6c37e5c3f4'
);


-- Op. 121 폴카 <Zehner-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Zehner-Polka>', 'Polka <Zehner-Polka>', 'song', 'Op. 121', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Zehner-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab414fbd-ff83-4e13-a035-7c11527e83a1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ab414fbd-ff83-4e13-a035-7c11527e83a1'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Zehner-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab414fbd-ff83-4e13-a035-7c11527e83a1'
);


-- Op. 123 카드리유 <Satanella-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Satanella-Quadrille>', 'Quadrille <Satanella-Quadrille>', 'song', 'Op. 123', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Satanella-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd90475e-332b-4d26-8ffd-cce8911c942a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fd90475e-332b-4d26-8ffd-cce8911c942a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Satanella-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd90475e-332b-4d26-8ffd-cce8911c942a'
);


-- Op. 124 폴카 <Satanella-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Satanella-Polka>', 'Polka <Satanella-Polka>', 'song', 'Op. 124', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Satanella-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c420d858-56da-4efb-b3e3-261b5bf32e4c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c420d858-56da-4efb-b3e3-261b5bf32e4c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Satanella-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c420d858-56da-4efb-b3e3-261b5bf32e4c'
);


-- Op. 125 왈츠 <Phönix-Schwingen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Phönix-Schwingen>', 'Waltz <Phönix-Schwingen>', 'song', 'Op. 125', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Phönix-Schwingen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b167de05-ea78-489e-84f4-c718bcc1299c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b167de05-ea78-489e-84f4-c718bcc1299c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Phönix-Schwingen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b167de05-ea78-489e-84f4-c718bcc1299c'
);


-- Op. 126 행진곡 <Kaiser-Franz-Joseph-I.-Rettungs-Jubel-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Kaiser-Franz-Joseph-I.-Rettungs-Jubel-Marsch>', 'March <Kaiser-Franz-Joseph-I.-Rettungs-Jubel-Marsch>', 'song', 'Op. 126', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Kaiser-Franz-Joseph-I.-Rettungs-Jubel-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '759af77c-1e26-49a7-be41-58de83d0a60c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '759af77c-1e26-49a7-be41-58de83d0a60c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Kaiser-Franz-Joseph-I.-Rettungs-Jubel-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '759af77c-1e26-49a7-be41-58de83d0a60c'
);


-- Op. 127 폴카 <Freuden-Gruß-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Freuden-Gruß-Polka>', 'Polka <Freuden-Gruß-Polka>', 'song', 'Op. 127', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Freuden-Gruß-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '531ac38a-8526-420f-9c21-ab005e94cc45'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '531ac38a-8526-420f-9c21-ab005e94cc45'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Freuden-Gruß-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '531ac38a-8526-420f-9c21-ab005e94cc45'
);


-- Op. 128 왈츠 <Solon-Sprüche>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Solon-Sprüche>', 'Waltz <Solon-Sprüche>', 'song', 'Op. 128', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Solon-Sprüche>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd952c277-370c-4f17-9b84-07e12a1c800f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd952c277-370c-4f17-9b84-07e12a1c800f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Solon-Sprüche>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd952c277-370c-4f17-9b84-07e12a1c800f'
);


-- Op. 129 카드리유 <Motor-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Motor-Quadrille>', 'Quadrille <Motor-Quadrille>', 'song', 'Op. 129', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Motor-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98bc0825-4b49-3805-a7c7-d4ddf49b6774'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '98bc0825-4b49-3805-a7c7-d4ddf49b6774'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Motor-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98bc0825-4b49-3805-a7c7-d4ddf49b6774'
);


-- Op. 130 폴카 <Aesculap-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Aesculap-Polka>', 'Polka <Aesculap-Polka>', 'song', 'Op. 130', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Aesculap-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1517e8be-c3ba-47b5-a4cc-2f96c57c5806'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1517e8be-c3ba-47b5-a4cc-2f96c57c5806'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Aesculap-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1517e8be-c3ba-47b5-a4cc-2f96c57c5806'
);


-- Op. 131 왈츠 <Wiener Punch-Lieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Wiener Punch-Lieder>', 'Waltz <Wiener Punch-Lieder>', 'song', 'Op. 131', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Wiener Punch-Lieder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ac8fbff-0b12-4c90-8cc4-d63518722666'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ac8fbff-0b12-4c90-8cc4-d63518722666'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Wiener Punch-Lieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ac8fbff-0b12-4c90-8cc4-d63518722666'
);


-- Op. 132 폴카 <Veilchen-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Veilchen-Polka>', 'Polka <Veilchen-Polka>', 'song', 'Op. 132', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Veilchen-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef961e63-9404-41ef-a9bb-bdc5a37647b4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ef961e63-9404-41ef-a9bb-bdc5a37647b4'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Veilchen-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef961e63-9404-41ef-a9bb-bdc5a37647b4'
);


-- Op. 133 행진곡 <Caroussel-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Caroussel-Marsch>', 'March <Caroussel-Marsch>', 'song', 'Op. 133', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Caroussel-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9162b55a-6779-4ac9-acd5-3f2b6d202d74'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9162b55a-6779-4ac9-acd5-3f2b6d202d74'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Caroussel-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9162b55a-6779-4ac9-acd5-3f2b6d202d74'
);


-- Op. 134 폴카 <Tanzi-Bäri-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Tanzi-Bäri-Polka>', 'Polka <Tanzi-Bäri-Polka>', 'song', 'Op. 134', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Tanzi-Bäri-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1dca2a96-0727-42f3-97c5-3211e12a64e4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1dca2a96-0727-42f3-97c5-3211e12a64e4'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Tanzi-Bäri-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1dca2a96-0727-42f3-97c5-3211e12a64e4'
);


-- Op. 135 카드리유 <Bouquet-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Bouquet-Quadrille>', 'Quadrille <Bouquet-Quadrille>', 'song', 'Op. 135', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Bouquet-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b56d33b-0e0c-49b7-ab17-bbfd2b15ac65'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b56d33b-0e0c-49b7-ab17-bbfd2b15ac65'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Bouquet-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b56d33b-0e0c-49b7-ab17-bbfd2b15ac65'
);


-- Op. 136 왈츠 <Vermählungs-Toaste>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Vermählungs-Toaste>', 'Waltz <Vermählungs-Toaste>', 'song', 'Op. 136', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Vermählungs-Toaste>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3891bc0b-ff59-422f-ac32-5d6047adb477'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3891bc0b-ff59-422f-ac32-5d6047adb477'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Vermählungs-Toaste>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3891bc0b-ff59-422f-ac32-5d6047adb477'
);


-- Op. 137 폴카 <Neuhauser-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Neuhauser-Polka>', 'Polka <Neuhauser-Polka>', 'song', 'Op. 137', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Neuhauser-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '412f1eb1-b9f0-4c3f-8333-33e4bdb1f1f2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '412f1eb1-b9f0-4c3f-8333-33e4bdb1f1f2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Neuhauser-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '412f1eb1-b9f0-4c3f-8333-33e4bdb1f1f2'
);


-- Op. 138 폴카 <Pepita-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Pepita-Polka>', 'Polka <Pepita-Polka>', 'song', 'Op. 138', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Pepita-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '568f3ee7-bc67-4ab2-8bb0-d4b9b56e231b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '568f3ee7-bc67-4ab2-8bb0-d4b9b56e231b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Pepita-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '568f3ee7-bc67-4ab2-8bb0-d4b9b56e231b'
);


-- Op. 139 행진곡 <Kron-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Kron-Marsch>', 'March <Kron-Marsch>', 'song', 'Op. 139', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Kron-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '347083e3-1d2b-4e90-93eb-f7449062be14'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '347083e3-1d2b-4e90-93eb-f7449062be14'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Kron-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '347083e3-1d2b-4e90-93eb-f7449062be14'
);


-- Op. 140 왈츠 <Knallkügerln>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Knallkügerln>', 'Waltz <Knallkügerln>', 'song', 'Op. 140', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Knallkügerln>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28211641-8903-485d-9e17-8001b36e2cf8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '28211641-8903-485d-9e17-8001b36e2cf8'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Knallkügerln>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28211641-8903-485d-9e17-8001b36e2cf8'
);


-- Op. 141 왈츠 <Wellen und Wogen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Wellen und Wogen>', 'Waltz <Wellen und Wogen>', 'song', 'Op. 141', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Wellen und Wogen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '218efa2a-ca36-4b17-9f40-fc9ae95bf370'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '218efa2a-ca36-4b17-9f40-fc9ae95bf370'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Wellen und Wogen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '218efa2a-ca36-4b17-9f40-fc9ae95bf370'
);


-- Op. 142 폴카 <Wiedersehen-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Wiedersehen-Polka>', 'Polka <Wiedersehen-Polka>', 'song', 'Op. 142', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Wiedersehen-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04c8e9a5-a6db-43c8-8d0a-8b0b12df4473'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '04c8e9a5-a6db-43c8-8d0a-8b0b12df4473'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Wiedersehen-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04c8e9a5-a6db-43c8-8d0a-8b0b12df4473'
);


-- Op. 143 왈츠 <Schnee-Glöckchen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Schnee-Glöckchen>', 'Waltz <Schnee-Glöckchen>', 'song', 'Op. 143', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Schnee-Glöckchen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f5dc8b2-9c6f-423f-adfa-4f18ab2504ad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9f5dc8b2-9c6f-423f-adfa-4f18ab2504ad'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Schnee-Glöckchen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f5dc8b2-9c6f-423f-adfa-4f18ab2504ad'
);


-- Op. 144 폴카 마주르카 <La Viennoise>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <La Viennoise>', 'Polka-Mazurka <La Viennoise>', 'song', 'Op. 144', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <La Viennoise>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c898478-713a-40ab-9c35-9921f26dc302'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5c898478-713a-40ab-9c35-9921f26dc302'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <La Viennoise>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c898478-713a-40ab-9c35-9921f26dc302'
);


-- Op. 145 폴카 <Bürgerball-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Bürgerball-Polka>', 'Polka <Bürgerball-Polka>', 'song', 'Op. 145', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Bürgerball-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '993983c2-1026-4d4f-bec6-f2394a2aceb9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '993983c2-1026-4d4f-bec6-f2394a2aceb9'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Bürgerball-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '993983c2-1026-4d4f-bec6-f2394a2aceb9'
);


-- Op. 146 왈츠 <Novellen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Novellen>', 'Waltz <Novellen>', 'song', 'Op. 146', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Novellen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7066931f-91df-4f16-9b40-d81a6195804b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7066931f-91df-4f16-9b40-d81a6195804b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Novellen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7066931f-91df-4f16-9b40-d81a6195804b'
);


-- Op. 147 폴카 <Musen-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Musen-Polka>', 'Polka <Musen-Polka>', 'song', 'Op. 147', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Musen-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a952dce4-11b1-45a7-a112-bd1e455415cd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a952dce4-11b1-45a7-a112-bd1e455415cd'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Musen-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a952dce4-11b1-45a7-a112-bd1e455415cd'
);


-- Op. 148 왈츠 <Schallwellen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Schallwellen>', 'Waltz <Schallwellen>', 'song', 'Op. 148', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Schallwellen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa5e0adc-8d18-36b7-95f4-d2ff2dc797f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aa5e0adc-8d18-36b7-95f4-d2ff2dc797f8'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Schallwellen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa5e0adc-8d18-36b7-95f4-d2ff2dc797f8'
);


-- Op. 149 행진곡 <Erzherzog-Wilhelm-Genesungs-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Erzherzog-Wilhelm-Genesungs-Marsch>', 'March <Erzherzog-Wilhelm-Genesungs-Marsch>', 'song', 'Op. 149', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Erzherzog-Wilhelm-Genesungs-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c54eaf7-6eac-4f83-94ba-ea8cb30a9f53'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c54eaf7-6eac-4f83-94ba-ea8cb30a9f53'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Erzherzog-Wilhelm-Genesungs-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c54eaf7-6eac-4f83-94ba-ea8cb30a9f53'
);


-- Op. 150 왈츠 <Ballg'schichten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Ballg''schichten>', 'Waltz <Ballg''schichten>', 'song', 'Op. 150', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Ballg''schichten>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64e90e48-db52-489c-9b49-dc828d94f65c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64e90e48-db52-489c-9b49-dc828d94f65c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Ballg''schichten>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64e90e48-db52-489c-9b49-dc828d94f65c'
);


-- Op. 151 폴카 <Elisen-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Elisen-Polka>', 'Polka française <Elisen-Polka>', 'song', 'Op. 151', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Elisen-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82fce77f-3995-338c-92c6-a8f43782c92e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82fce77f-3995-338c-92c6-a8f43782c92e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Elisen-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82fce77f-3995-338c-92c6-a8f43782c92e'
);


-- Op. 152 카드리유 <Carnevals-Spectakel-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Carnevals-Spectakel-Quadrille>', 'Quadrille <Carnevals-Spectakel-Quadrille>', 'song', 'Op. 152', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Carnevals-Spectakel-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd88213ed-4be0-4365-a7f7-ac2b7d5ca7bb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd88213ed-4be0-4365-a7f7-ac2b7d5ca7bb'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Carnevals-Spectakel-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd88213ed-4be0-4365-a7f7-ac2b7d5ca7bb'
);


-- Op. 154 왈츠 <Myrthen-Kränze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Myrthen-Kränze>', 'Waltz <Myrthen-Kränze>', 'song', 'Op. 154', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Myrthen-Kränze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d5ae79e-fbde-4f34-b0d2-4d766464a823'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3d5ae79e-fbde-4f34-b0d2-4d766464a823'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Myrthen-Kränze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d5ae79e-fbde-4f34-b0d2-4d766464a823'
);


-- Op. 155 폴카 <Haute volée-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Haute volée-Polka>', 'Polka française <Haute volée-Polka>', 'song', 'Op. 155', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Haute volée-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc2fa933-cb99-4e2c-8f79-0bd7c8530aab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc2fa933-cb99-4e2c-8f79-0bd7c8530aab'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Haute volée-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc2fa933-cb99-4e2c-8f79-0bd7c8530aab'
);


-- Op. 156 행진곡 <Napoleon-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Napoleon-Marsch>', 'March <Napoleon-Marsch>', 'song', 'Op. 156', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Napoleon-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '309ab8e2-58ba-3374-9580-9b64b1cf92ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '309ab8e2-58ba-3374-9580-9b64b1cf92ff'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Napoleon-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '309ab8e2-58ba-3374-9580-9b64b1cf92ff'
);


-- Op. 157 왈츠 <Nachtfalter>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Nachtfalter>', 'Waltz <Nachtfalter>', 'song', 'Op. 157', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Nachtfalter>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd385bafa-3f55-4475-b21f-1da09a87a133'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd385bafa-3f55-4475-b21f-1da09a87a133'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Nachtfalter>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd385bafa-3f55-4475-b21f-1da09a87a133'
);


-- Op. 158 행진곡 <Alliance-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Alliance-Marsch>', 'March <Alliance-Marsch>', 'song', 'Op. 158', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Alliance-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4235985c-d378-4b03-96ff-ec6339658b2b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4235985c-d378-4b03-96ff-ec6339658b2b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Alliance-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4235985c-d378-4b03-96ff-ec6339658b2b'
);


-- Op. 159 폴카 <Schnellpost-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Schnellpost-Polka>', 'Polka schnell <Schnellpost-Polka>', 'song', 'Op. 159', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Schnellpost-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fae19938-9c20-4fb5-b819-18c147b61717'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fae19938-9c20-4fb5-b819-18c147b61717'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Schnellpost-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fae19938-9c20-4fb5-b819-18c147b61717'
);


-- Op. 160 폴카 <Ella-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Ella-Polka>', 'Polka <Ella-Polka>', 'song', 'Op. 160', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Ella-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58d2d9ef-b554-442f-95fd-b44df3505688'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58d2d9ef-b554-442f-95fd-b44df3505688'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Ella-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58d2d9ef-b554-442f-95fd-b44df3505688'
);


-- Op. 161 왈츠 <Panacea-Klänge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Panacea-Klänge>', 'Waltz <Panacea-Klänge>', 'song', 'Op. 161', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Panacea-Klänge>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25deb989-0ed1-46e8-a9de-0e7e5eddcc0b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '25deb989-0ed1-46e8-a9de-0e7e5eddcc0b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Panacea-Klänge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25deb989-0ed1-46e8-a9de-0e7e5eddcc0b'
);


-- Op. 162 폴카 <Souvenir-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Souvenir-Polka>', 'Polka <Souvenir-Polka>', 'song', 'Op. 162', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Souvenir-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dac453a8-0e73-4f41-aea9-2b8328beabb7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dac453a8-0e73-4f41-aea9-2b8328beabb7'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Souvenir-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dac453a8-0e73-4f41-aea9-2b8328beabb7'
);


-- Op. 163 왈츠 <Glossen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Glossen>', 'Waltz <Glossen>', 'song', 'Op. 163', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Glossen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17962682-8205-422c-85bf-4a32288c5b84'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17962682-8205-422c-85bf-4a32288c5b84'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Glossen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17962682-8205-422c-85bf-4a32288c5b84'
);


-- Op. 164 왈츠 <Sirenen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Sirenen>', 'Waltz <Sirenen>', 'song', 'Op. 164', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Sirenen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b2ad2e0-8d24-4778-9d70-9e50b6b9e3d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3b2ad2e0-8d24-4778-9d70-9e50b6b9e3d5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Sirenen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b2ad2e0-8d24-4778-9d70-9e50b6b9e3d5'
);


-- Op. 165 폴카 <Aurora-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Aurora-Polka>', 'Polka <Aurora-Polka>', 'song', 'Op. 165', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Aurora-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb9af361-9aff-4652-a5fc-52ce413de7bc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cb9af361-9aff-4652-a5fc-52ce413de7bc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Aurora-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb9af361-9aff-4652-a5fc-52ce413de7bc'
);


-- Op. 166 카드리유 <Handels-Elite-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Handels-Elite-Quadrille>', 'Quadrille <Handels-Elite-Quadrille>', 'song', 'Op. 166', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Handels-Elite-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd76b633-b5ac-409b-9f15-13996cb2d8b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bd76b633-b5ac-409b-9f15-13996cb2d8b3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Handels-Elite-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd76b633-b5ac-409b-9f15-13996cb2d8b3'
);


-- Op. 167 왈츠 <Man lebt nur einmal>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Man lebt nur einmal>', 'Waltz <Man lebt nur einmal>', 'song', 'Op. 167', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Man lebt nur einmal>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd659be60-5eea-4f7c-92a2-7f40e4bc47cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd659be60-5eea-4f7c-92a2-7f40e4bc47cb'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Man lebt nur einmal>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd659be60-5eea-4f7c-92a2-7f40e4bc47cb'
);


-- Op. 168 폴카 <Leopoldstädter Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Leopoldstädter Polka>', 'Polka <Leopoldstädter Polka>', 'song', 'Op. 168', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Leopoldstädter Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31b0f524-ca77-4f83-a5da-fb79deeb0044'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '31b0f524-ca77-4f83-a5da-fb79deeb0044'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Leopoldstädter Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31b0f524-ca77-4f83-a5da-fb79deeb0044'
);


-- Op. 169 카드리유 <Bijouterie-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Bijouterie-Quadrille>', 'Quadrille <Bijouterie-Quadrille>', 'song', 'Op. 169', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Bijouterie-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b3ed2b6a-5a9b-4fdb-9d64-4e8aa7bf5109'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b3ed2b6a-5a9b-4fdb-9d64-4e8aa7bf5109'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Bijouterie-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b3ed2b6a-5a9b-4fdb-9d64-4e8aa7bf5109'
);


-- Op. 170 폴카 마주르카 <Nachtveilchen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Nachtveilchen>', 'Polka-Mazurka <Nachtveilchen>', 'song', 'Op. 170', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Nachtveilchen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f8d62aa-52e2-4e34-98be-b2eed438a0cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f8d62aa-52e2-4e34-98be-b2eed438a0cf'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Nachtveilchen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f8d62aa-52e2-4e34-98be-b2eed438a0cf'
);


-- Op. 171 왈츠 <Freuden-Salven>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Freuden-Salven>', 'Waltz <Freuden-Salven>', 'song', 'Op. 171', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Freuden-Salven>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '076dd470-d4e8-4afd-b80f-d4fab3d88903'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '076dd470-d4e8-4afd-b80f-d4fab3d88903'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Freuden-Salven>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '076dd470-d4e8-4afd-b80f-d4fab3d88903'
);


-- Op. 172 왈츠 <Gedanken auf den Alpen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Gedanken auf den Alpen>', 'Waltz <Gedanken auf den Alpen>', 'song', 'Op. 172', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Gedanken auf den Alpen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8a6ff7e-6d52-4d07-9e02-cca8b271295b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8a6ff7e-6d52-4d07-9e02-cca8b271295b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Gedanken auf den Alpen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8a6ff7e-6d52-4d07-9e02-cca8b271295b'
);


-- Op. 173 폴카 <Marie Taglioni-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Marie Taglioni-Polka>', 'Polka <Marie Taglioni-Polka>', 'song', 'Op. 173', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Marie Taglioni-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb49eab7-e57e-4547-81d7-92bd1425a093'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb49eab7-e57e-4547-81d7-92bd1425a093'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Marie Taglioni-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb49eab7-e57e-4547-81d7-92bd1425a093'
);


-- Op. 174 폴카 마주르카 <Le Papillon>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Le Papillon>', 'Polka-Mazurka <Le Papillon>', 'song', 'Op. 174', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Le Papillon>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30ebfa2a-bc7c-4c08-8baf-91e85f247767'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '30ebfa2a-bc7c-4c08-8baf-91e85f247767'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Le Papillon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30ebfa2a-bc7c-4c08-8baf-91e85f247767'
);


-- Op. 175 왈츠 <Erhöhte Pulse>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Erhöhte Pulse>', 'Waltz <Erhöhte Pulse>', 'song', 'Op. 175', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Erhöhte Pulse>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b9d14a9-d49c-4123-be98-9c159dee1661'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b9d14a9-d49c-4123-be98-9c159dee1661'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Erhöhte Pulse>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b9d14a9-d49c-4123-be98-9c159dee1661'
);


-- Op. 176 폴카 <Armen-Ball-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Armen-Ball-Polka>', 'Polka <Armen-Ball-Polka>', 'song', 'Op. 176', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Armen-Ball-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd6490e8-9144-4351-ae49-7473bd0a1ce2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fd6490e8-9144-4351-ae49-7473bd0a1ce2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Armen-Ball-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd6490e8-9144-4351-ae49-7473bd0a1ce2'
);


-- Op. 177 왈츠 <Juristenball-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Juristenball-Tänze>', 'Waltz <Juristenball-Tänze>', 'song', 'Op. 177', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Juristenball-Tänze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d59918b-14d7-4e78-9726-21c0a3bb4227'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d59918b-14d7-4e78-9726-21c0a3bb4227'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Juristenball-Tänze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d59918b-14d7-4e78-9726-21c0a3bb4227'
);


-- Op. 178 폴카 <Sans-souci-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Sans-souci-Polka>', 'Polka <Sans-souci-Polka>', 'song', 'Op. 178', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Sans-souci-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76547f85-b442-4f28-930d-18a05bbb4970'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '76547f85-b442-4f28-930d-18a05bbb4970'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Sans-souci-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76547f85-b442-4f28-930d-18a05bbb4970'
);


-- Op. 179 왈츠 <Abschieds-Rufe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Abschieds-Rufe>', 'Waltz <Abschieds-Rufe>', 'song', 'Op. 179', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Abschieds-Rufe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e772f269-4b0c-4d56-9412-d5e035310cea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e772f269-4b0c-4d56-9412-d5e035310cea'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Abschieds-Rufe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e772f269-4b0c-4d56-9412-d5e035310cea'
);


-- Op. 180 왈츠 <Libellen-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Libellen-Walzer>', 'Waltz <Libellen-Walzer>', 'song', 'Op. 180', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Libellen-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b87badd1-df2a-4752-bc0f-6756abe9426a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b87badd1-df2a-4752-bc0f-6756abe9426a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Libellen-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b87badd1-df2a-4752-bc0f-6756abe9426a'
);


-- Op. 181 왈츠 <Großfürstin Alexandra>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Großfürstin Alexandra>', 'Waltz <Großfürstin Alexandra>', 'song', 'Op. 181', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Großfürstin Alexandra>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3c63d5b-3ecb-4c78-af61-f30186495695'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd3c63d5b-3ecb-4c78-af61-f30186495695'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Großfürstin Alexandra>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3c63d5b-3ecb-4c78-af61-f30186495695'
);


-- Op. 182 폴카 <L'Inconnue>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <L''Inconnue>', 'Polka française <L''Inconnue>', 'song', 'Op. 182', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <L''Inconnue>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c714961-f3e5-4b55-bf82-4e40492358d6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0c714961-f3e5-4b55-bf82-4e40492358d6'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <L''Inconnue>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c714961-f3e5-4b55-bf82-4e40492358d6'
);


-- Op. 183 행진곡 <Krönungs-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Krönungs-Marsch>', 'March <Krönungs-Marsch>', 'song', 'Op. 183', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Krönungs-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5c0f5e6-561f-49bb-890e-630f862509fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b5c0f5e6-561f-49bb-890e-630f862509fb'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Krönungs-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5c0f5e6-561f-49bb-890e-630f862509fb'
);


-- Op. 184 왈츠 <Krönungslieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Krönungslieder>', 'Waltz <Krönungslieder>', 'song', 'Op. 184', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Krönungslieder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08bba3b0-5fa1-4757-a68e-96f71f7d604e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '08bba3b0-5fa1-4757-a68e-96f71f7d604e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Krönungslieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08bba3b0-5fa1-4757-a68e-96f71f7d604e'
);


-- Op. 185 카드리유 <Strelna-Terrassen-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Strelna-Terrassen-Quadrille>', 'Quadrille <Strelna-Terrassen-Quadrille>', 'song', 'Op. 185', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Strelna-Terrassen-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3cc02896-3e69-466a-a39a-248ea55121bc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3cc02896-3e69-466a-a39a-248ea55121bc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Strelna-Terrassen-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3cc02896-3e69-466a-a39a-248ea55121bc'
);


-- Op. 186 폴카 <Demi-Fortune-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Demi-Fortune-Polka>', 'Polka française <Demi-Fortune-Polka>', 'song', 'Op. 186', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Demi-Fortune-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fffae551-e4ff-4339-ae0d-efedfd748f3a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fffae551-e4ff-4339-ae0d-efedfd748f3a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Demi-Fortune-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fffae551-e4ff-4339-ae0d-efedfd748f3a'
);


-- Op. 187 폴카 마주르카 <Une Bagatelle>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Une Bagatelle>', 'Polka-Mazurka <Une Bagatelle>', 'song', 'Op. 187', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Une Bagatelle>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '372bae92-83e7-4101-a25c-7eb5ae0d1a9b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '372bae92-83e7-4101-a25c-7eb5ae0d1a9b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Une Bagatelle>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '372bae92-83e7-4101-a25c-7eb5ae0d1a9b'
);


-- Op. 188 폴카 <Herzel-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Herzel-Polka>', 'Polka <Herzel-Polka>', 'song', 'Op. 188', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Herzel-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86b12d5d-6735-4c5f-b9c9-4c71144606db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86b12d5d-6735-4c5f-b9c9-4c71144606db'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Herzel-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86b12d5d-6735-4c5f-b9c9-4c71144606db'
);


-- Op. 189 왈츠 <Paroxysmen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Paroxysmen>', 'Waltz <Paroxysmen>', 'song', 'Op. 189', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Paroxysmen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32e00a2a-7836-4a4f-b41b-7759504816b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '32e00a2a-7836-4a4f-b41b-7759504816b7'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Paroxysmen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32e00a2a-7836-4a4f-b41b-7759504816b7'
);


-- Op. 190 폴카 <Etwas Kleines>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Etwas Kleines>', 'Polka française <Etwas Kleines>', 'song', 'Op. 190', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Etwas Kleines>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '778139d9-36d5-4cfc-a3cc-dc300235b1ad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '778139d9-36d5-4cfc-a3cc-dc300235b1ad'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Etwas Kleines>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '778139d9-36d5-4cfc-a3cc-dc300235b1ad'
);


-- Op. 191 왈츠 <Controversen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Controversen>', 'Waltz <Controversen>', 'song', 'Op. 191', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Controversen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c9c1083-b4ae-4c25-a401-ddc718b06ea8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c9c1083-b4ae-4c25-a401-ddc718b06ea8'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Controversen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c9c1083-b4ae-4c25-a401-ddc718b06ea8'
);


-- Op. 192 왈츠 <Wien, mein Sinn!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Wien, mein Sinn!>', 'Waltz <Wien, mein Sinn!>', 'song', 'Op. 192', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Wien, mein Sinn!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5eac2e3-9e36-4a03-b796-ba743fe860c9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c5eac2e3-9e36-4a03-b796-ba743fe860c9'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Wien, mein Sinn!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5eac2e3-9e36-4a03-b796-ba743fe860c9'
);


-- Op. 193 왈츠 <Phänomene>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Phänomene>', 'Waltz <Phänomene>', 'song', 'Op. 193', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Phänomene>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5159a2af-6683-4d2c-b590-04c989143eed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5159a2af-6683-4d2c-b590-04c989143eed'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Phänomene>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5159a2af-6683-4d2c-b590-04c989143eed'
);


-- Op. 194 카드리유 <La Berceuse>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <La Berceuse>', 'Quadrille <La Berceuse>', 'song', 'Op. 194', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <La Berceuse>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61668f1e-1e52-4fed-980c-93c288e514ac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '61668f1e-1e52-4fed-980c-93c288e514ac'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <La Berceuse>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61668f1e-1e52-4fed-980c-93c288e514ac'
);


-- Op. 195 왈츠 <Telegrafische Depeschen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Telegrafische Depeschen>', 'Waltz <Telegrafische Depeschen>', 'song', 'Op. 195', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Telegrafische Depeschen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c09f142-1ebc-4b18-ac1f-e39bdbdda183'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7c09f142-1ebc-4b18-ac1f-e39bdbdda183'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Telegrafische Depeschen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c09f142-1ebc-4b18-ac1f-e39bdbdda183'
);


-- Op. 196 폴카 <Olga-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Olga-Polka>', 'Polka française <Olga-Polka>', 'song', 'Op. 196', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Olga-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '732ef373-8134-4208-b4ae-c01e49109055'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '732ef373-8134-4208-b4ae-c01e49109055'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Olga-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '732ef373-8134-4208-b4ae-c01e49109055'
);


-- Op. 197 폴카 마주르카 <Spleen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Spleen>', 'Polka-Mazurka <Spleen>', 'song', 'Op. 197', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Spleen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15fdd1f2-73dd-4bef-97b0-e3b8298213f2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '15fdd1f2-73dd-4bef-97b0-e3b8298213f2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Spleen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15fdd1f2-73dd-4bef-97b0-e3b8298213f2'
);


-- Op. 198 폴카 <Alexandrine-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Alexandrine-Polka>', 'Polka <Alexandrine-Polka>', 'song', 'Op. 198', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Alexandrine-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13e9b7cb-9a7f-476c-bf7b-8a96944586c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13e9b7cb-9a7f-476c-bf7b-8a96944586c8'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Alexandrine-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13e9b7cb-9a7f-476c-bf7b-8a96944586c8'
);


-- Op. 199 카드리유 <Le beau monde>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Le beau monde>', 'Quadrille <Le beau monde>', 'song', 'Op. 199', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Le beau monde>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37d7613b-f431-410a-8d39-8be8ae95ab00'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '37d7613b-f431-410a-8d39-8be8ae95ab00'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Le beau monde>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37d7613b-f431-410a-8d39-8be8ae95ab00'
);


-- Op. 200 왈츠 <Souvenir de Nizza>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Souvenir de Nizza>', 'Waltz <Souvenir de Nizza>', 'song', 'Op. 200', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Souvenir de Nizza>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5f482ba-e85e-4777-abeb-f84253284a8b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e5f482ba-e85e-4777-abeb-f84253284a8b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Souvenir de Nizza>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5f482ba-e85e-4777-abeb-f84253284a8b'
);


-- Op. 202 폴카 <L'Enfantillage-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <L''Enfantillage-Polka>', 'Polka <L''Enfantillage-Polka>', 'song', 'Op. 202', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <L''Enfantillage-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab90b3d4-6ff4-41a3-9b66-f59670421253'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ab90b3d4-6ff4-41a3-9b66-f59670421253'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <L''Enfantillage-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab90b3d4-6ff4-41a3-9b66-f59670421253'
);


-- Op. 203 폴카 <Hellenen-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Hellenen-Polka>', 'Polka schnell <Hellenen-Polka>', 'song', 'Op. 203', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Hellenen-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1247fbed-a0cc-4cf4-9100-39da31a585cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1247fbed-a0cc-4cf4-9100-39da31a585cf'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Hellenen-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1247fbed-a0cc-4cf4-9100-39da31a585cf'
);


-- Op. 204 왈츠 <Vibrationen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Vibrationen>', 'Waltz <Vibrationen>', 'song', 'Op. 204', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Vibrationen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '36808419-a419-4d86-863e-fc36dcec2fe3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '36808419-a419-4d86-863e-fc36dcec2fe3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Vibrationen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '36808419-a419-4d86-863e-fc36dcec2fe3'
);


-- Op. 205 왈츠 <Die Extravaganten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Extravaganten>', 'Waltz <Die Extravaganten>', 'song', 'Op. 205', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Extravaganten>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cba0e7f1-f8d8-4af7-9dbb-74fcbade783d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cba0e7f1-f8d8-4af7-9dbb-74fcbade783d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Die Extravaganten>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cba0e7f1-f8d8-4af7-9dbb-74fcbade783d'
);


-- Op. 206 폴카 마주르카 <Concordia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Concordia>', 'Polka-Mazurka <Concordia>', 'song', 'Op. 206', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Concordia>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a9ebd5d-32f2-477c-a461-a8d097ae4356'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6a9ebd5d-32f2-477c-a461-a8d097ae4356'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Concordia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a9ebd5d-32f2-477c-a461-a8d097ae4356'
);


-- Op. 207 왈츠 <Cycloiden>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Cycloiden>', 'Waltz <Cycloiden>', 'song', 'Op. 207', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Cycloiden>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e442e2b2-fd85-4f37-8a2a-9f3cd2c5b30f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e442e2b2-fd85-4f37-8a2a-9f3cd2c5b30f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Cycloiden>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e442e2b2-fd85-4f37-8a2a-9f3cd2c5b30f'
);


-- Op. 208 왈츠 <Jux-Brüder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Jux-Brüder>', 'Waltz <Jux-Brüder>', 'song', 'Op. 208', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Jux-Brüder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a0e15e3-36ee-48dd-8c34-cbc4eff60fdb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6a0e15e3-36ee-48dd-8c34-cbc4eff60fdb'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Jux-Brüder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a0e15e3-36ee-48dd-8c34-cbc4eff60fdb'
);


-- Op. 209 왈츠 <Spiralen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Spiralen>', 'Waltz <Spiralen>', 'song', 'Op. 209', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Spiralen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e3ead87-25cb-3c48-b2f9-872da9c1f7ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6e3ead87-25cb-3c48-b2f9-872da9c1f7ed'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Spiralen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e3ead87-25cb-3c48-b2f9-872da9c1f7ed'
);


-- Op. 210 왈츠 <Abschied von St. Petersburg>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Abschied von St. Petersburg>', 'Waltz <Abschied von St. Petersburg>', 'song', 'Op. 210', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Abschied von St. Petersburg>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f088dea6-10b1-4196-b432-d09c804d670b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f088dea6-10b1-4196-b432-d09c804d670b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Abschied von St. Petersburg>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f088dea6-10b1-4196-b432-d09c804d670b'
);


-- Op. 211 샴페인 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '샴페인 폴카', 'Champagne Polka', 'song', 'Op. 211', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '샴페인 폴카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a385dbd-5314-4f56-97bd-53a2ca46d930'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8a385dbd-5314-4f56-97bd-53a2ca46d930'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '샴페인 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a385dbd-5314-4f56-97bd-53a2ca46d930'
);


-- Op. 212 행진곡 <Fürst-Bariatinsky-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Fürst-Bariatinsky-Marsch>', 'March <Fürst-Bariatinsky-Marsch>', 'song', 'Op. 212', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Fürst-Bariatinsky-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e244eb7b-c720-420d-a9fb-fb8b52390846'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e244eb7b-c720-420d-a9fb-fb8b52390846'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Fürst-Bariatinsky-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e244eb7b-c720-420d-a9fb-fb8b52390846'
);


-- Op. 213 폴카 <Bonbon-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Bonbon-Polka>', 'Polka française <Bonbon-Polka>', 'song', 'Op. 213', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Bonbon-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5eb8de61-5134-47d3-83a0-216a67bbe6c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5eb8de61-5134-47d3-83a0-216a67bbe6c7'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Bonbon-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5eb8de61-5134-47d3-83a0-216a67bbe6c7'
);


-- Op. 214 트리치 트라치 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리치 트라치 폴카', 'Tritsch-Tratsch-Polka', 'song', 'Op. 214', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리치 트라치 폴카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38ed9e44-839d-3088-b66a-45c6e2399ec6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38ed9e44-839d-3088-b66a-45c6e2399ec6'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '트리치 트라치 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38ed9e44-839d-3088-b66a-45c6e2399ec6'
);


-- Op. 215 왈츠 <Gedankenflug>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Gedankenflug>', 'Waltz <Gedankenflug>', 'song', 'Op. 215', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Gedankenflug>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90300f3a-b9e4-49de-a9d4-9d0533b159ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '90300f3a-b9e4-49de-a9d4-9d0533b159ec'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Gedankenflug>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90300f3a-b9e4-49de-a9d4-9d0533b159ec'
);


-- Op. 216 왈츠 <Hell und voll>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Hell und voll>', 'Waltz <Hell und voll>', 'song', 'Op. 216', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Hell und voll>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e77d7751-10b4-47ef-9604-8056e8c8d985'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e77d7751-10b4-47ef-9604-8056e8c8d985'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Hell und voll>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e77d7751-10b4-47ef-9604-8056e8c8d985'
);


-- Op. 217 폴카 <La Favorite-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <La Favorite-Polka>', 'Polka française <La Favorite-Polka>', 'song', 'Op. 217', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <La Favorite-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bca1bed0-6b49-49e7-a6f9-13c38591b455'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bca1bed0-6b49-49e7-a6f9-13c38591b455'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <La Favorite-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bca1bed0-6b49-49e7-a6f9-13c38591b455'
);


-- Op. 218 왈츠 <Irrlichter>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Irrlichter>', 'Waltz <Irrlichter>', 'song', 'Op. 218', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Irrlichter>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd388f4c6-d813-497d-9a5c-dd6ec00eb450'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd388f4c6-d813-497d-9a5c-dd6ec00eb450'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Irrlichter>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd388f4c6-d813-497d-9a5c-dd6ec00eb450'
);


-- Op. 219 폴카 <Auroraball-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Auroraball-Polka>', 'Polka française <Auroraball-Polka>', 'song', 'Op. 219', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Auroraball-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee822db5-8145-40e9-b831-7a05685e504d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ee822db5-8145-40e9-b831-7a05685e504d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Auroraball-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee822db5-8145-40e9-b831-7a05685e504d'
);


-- Op. 220 왈츠 <Deutsche>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Deutsche>', 'Waltz <Deutsche>', 'song', 'Op. 220', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Deutsche>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7ea738d-9a5a-4058-b581-4cb222722589'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e7ea738d-9a5a-4058-b581-4cb222722589'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Deutsche>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7ea738d-9a5a-4058-b581-4cb222722589'
);


-- Op. 221 왈츠 <Promotionen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Promotionen>', 'Waltz <Promotionen>', 'song', 'Op. 221', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Promotionen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f59ded3-b777-4e73-a373-81679beef1cc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6f59ded3-b777-4e73-a373-81679beef1cc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Promotionen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f59ded3-b777-4e73-a373-81679beef1cc'
);


-- Op. 222 폴카 <Nachtigall-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Nachtigall-Polka>', 'Polka <Nachtigall-Polka>', 'song', 'Op. 222', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Nachtigall-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e0dd0f6-ef0d-4c23-adb9-102ea0331d14'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1e0dd0f6-ef0d-4c23-adb9-102ea0331d14'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Nachtigall-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e0dd0f6-ef0d-4c23-adb9-102ea0331d14'
);


-- Op. 223 왈츠 <Schwungräder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Schwungräder>', 'Waltz <Schwungräder>', 'song', 'Op. 223', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Schwungräder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5e67044-7b3f-3335-af96-b78789ca9db6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e5e67044-7b3f-3335-af96-b78789ca9db6'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Schwungräder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5e67044-7b3f-3335-af96-b78789ca9db6'
);


-- Op. 225 폴카 <Gruß an Wien>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Gruß an Wien>', 'Polka française <Gruß an Wien>', 'song', 'Op. 225', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Gruß an Wien>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56130251-76fe-43ea-9179-d7d83927c81d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56130251-76fe-43ea-9179-d7d83927c81d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Gruß an Wien>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56130251-76fe-43ea-9179-d7d83927c81d'
);


-- Op. 226 폴카 마주르카 <Der Kobold>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Der Kobold>', 'Polka-Mazurka <Der Kobold>', 'song', 'Op. 226', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Der Kobold>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09b8bc08-03de-41d2-b06d-cb7cd8c6a1c2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09b8bc08-03de-41d2-b06d-cb7cd8c6a1c2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Der Kobold>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09b8bc08-03de-41d2-b06d-cb7cd8c6a1c2'
);


-- Op. 227 왈츠 <Reiseabenteuer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Reiseabenteuer>', 'Waltz <Reiseabenteuer>', 'song', 'Op. 227', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Reiseabenteuer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10564c53-2a33-447e-8a13-21cffce8c57f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '10564c53-2a33-447e-8a13-21cffce8c57f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Reiseabenteuer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10564c53-2a33-447e-8a13-21cffce8c57f'
);


-- Op. 228 폴카 <Niko-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Niko-Polka>', 'Polka <Niko-Polka>', 'song', 'Op. 228', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Niko-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd4c5c1d-ab4c-4467-9c5b-f72edffb3dd8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bd4c5c1d-ab4c-4467-9c5b-f72edffb3dd8'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Niko-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd4c5c1d-ab4c-4467-9c5b-f72edffb3dd8'
);


-- Op. 229 폴카 <Jäger-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Jäger-Polka>', 'Polka française <Jäger-Polka>', 'song', 'Op. 229', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Jäger-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a92299f4-a226-4bf6-9fe3-036abca4a18e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a92299f4-a226-4bf6-9fe3-036abca4a18e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Jäger-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a92299f4-a226-4bf6-9fe3-036abca4a18e'
);


-- Op. 230 폴카 <Kammerball-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Kammerball-Polka>', 'Polka française <Kammerball-Polka>', 'song', 'Op. 230', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Kammerball-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6c33f7a-9949-490e-8535-90bc9781c4a2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e6c33f7a-9949-490e-8535-90bc9781c4a2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Kammerball-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6c33f7a-9949-490e-8535-90bc9781c4a2'
);


-- Op. 231 폴카 <Drollerie-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Drollerie-Polka>', 'Polka française <Drollerie-Polka>', 'song', 'Op. 231', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Drollerie-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7600c91c-dfa1-4802-9a45-a939f7a01742'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7600c91c-dfa1-4802-9a45-a939f7a01742'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Drollerie-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7600c91c-dfa1-4802-9a45-a939f7a01742'
);


-- Op. 232 왈츠 <Lebenswecker>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Lebenswecker>', 'Waltz <Lebenswecker>', 'song', 'Op. 232', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Lebenswecker>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30e25569-9bac-4d25-ac1c-5d4730812cd9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '30e25569-9bac-4d25-ac1c-5d4730812cd9'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Lebenswecker>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30e25569-9bac-4d25-ac1c-5d4730812cd9'
);


-- Op. 233 왈츠 <Sentenzen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Sentenzen>', 'Waltz <Sentenzen>', 'song', 'Op. 233', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Sentenzen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '728767bd-1a7b-4af0-a826-a9c0367711c5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '728767bd-1a7b-4af0-a826-a9c0367711c5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Sentenzen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '728767bd-1a7b-4af0-a826-a9c0367711c5'
);


-- Op. 234 왈츠 <가속도>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <가속도>', 'Waltz <Accelerations>', 'song', 'Op. 234', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <가속도>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be482645-9064-3ea1-8fb1-45407f8ce722'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be482645-9064-3ea1-8fb1-45407f8ce722'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <가속도>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be482645-9064-3ea1-8fb1-45407f8ce722'
);


-- Op. 235 왈츠 <Immer heiterer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Immer heiterer>', 'Waltz <Immer heiterer>', 'song', 'Op. 235', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Immer heiterer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0d5e8115-3d2f-4a0e-a384-589dd6cbbaf2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0d5e8115-3d2f-4a0e-a384-589dd6cbbaf2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Immer heiterer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0d5e8115-3d2f-4a0e-a384-589dd6cbbaf2'
);


-- Op. 237 폴카 <Taubenpost>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Taubenpost>', 'Polka française <Taubenpost>', 'song', 'Op. 237', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Taubenpost>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa79d353-bffc-404e-b788-3c899fd06d69'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fa79d353-bffc-404e-b788-3c899fd06d69'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Taubenpost>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa79d353-bffc-404e-b788-3c899fd06d69'
);


-- Op. 238 폴카 <Die Pariserin>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Die Pariserin>', 'Polka française <Die Pariserin>', 'song', 'Op. 238', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Die Pariserin>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '298d4e4f-e3ef-4e4d-a7ff-1782e1bd125f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '298d4e4f-e3ef-4e4d-a7ff-1782e1bd125f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Die Pariserin>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '298d4e4f-e3ef-4e4d-a7ff-1782e1bd125f'
);


-- Op. 239 폴카 마주르카 <Polka-Mazurka champêtre>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Polka-Mazurka champêtre>', 'Polka-Mazurka <Polka-Mazurka champêtre>', 'song', 'Op. 239', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Polka-Mazurka champêtre>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b587498-d4d7-4ec5-a7b3-3edc5ceb23cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b587498-d4d7-4ec5-a7b3-3edc5ceb23cf'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Polka-Mazurka champêtre>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b587498-d4d7-4ec5-a7b3-3edc5ceb23cf'
);


-- Op. 240 폴카 <Maskenzug-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Maskenzug-Polka>', 'Polka française <Maskenzug-Polka>', 'song', 'Op. 240', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Maskenzug-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9b9a0c7-aa54-444c-ada0-921598f188a2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b9b9a0c7-aa54-444c-ada0-921598f188a2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Maskenzug-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9b9a0c7-aa54-444c-ada0-921598f188a2'
);


-- Op. 241 폴카 마주르카 <Fantasieblümchen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Fantasieblümchen>', 'Polka-Mazurka <Fantasieblümchen>', 'song', 'Op. 241', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Fantasieblümchen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '581b1011-7384-4d70-99fc-f04ff96712df'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '581b1011-7384-4d70-99fc-f04ff96712df'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Fantasieblümchen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '581b1011-7384-4d70-99fc-f04ff96712df'
);


-- Op. 242 폴카 <Bijoux-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Bijoux-Polka>', 'Polka française <Bijoux-Polka>', 'song', 'Op. 242', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Bijoux-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f64a5375-0b42-4803-8723-8c66b5abfe95'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f64a5375-0b42-4803-8723-8c66b5abfe95'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Bijoux-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f64a5375-0b42-4803-8723-8c66b5abfe95'
);


-- Op. 243 로망스 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 1번', 'Romanze No. 1', 'song', 'Op. 243', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c66ac416-78b8-49b5-9e28-e2c5334c1f94'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c66ac416-78b8-49b5-9e28-e2c5334c1f94'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '로망스 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c66ac416-78b8-49b5-9e28-e2c5334c1f94'
);


-- Op. 244 폴카 <Diabolin-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Diabolin-Polka>', 'Polka française <Diabolin-Polka>', 'song', 'Op. 244', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Diabolin-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea612263-72a5-48f0-a65f-cfdb534520ad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ea612263-72a5-48f0-a65f-cfdb534520ad'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Diabolin-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea612263-72a5-48f0-a65f-cfdb534520ad'
);


-- Op. 245 왈츠 <Thermen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Thermen>', 'Waltz <Thermen>', 'song', 'Op. 245', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Thermen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '345e80d2-711e-48b3-8e96-26870fe3e63d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '345e80d2-711e-48b3-8e96-26870fe3e63d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Thermen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '345e80d2-711e-48b3-8e96-26870fe3e63d'
);


-- Op. 246 폴카 <Rokonhangok>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Rokonhangok>', 'Polka française <Rokonhangok>', 'song', 'Op. 246', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Rokonhangok>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0433b56-e7e3-4761-af63-5018f539ddda'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd0433b56-e7e3-4761-af63-5018f539ddda'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Rokonhangok>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0433b56-e7e3-4761-af63-5018f539ddda'
);


-- Op. 247 왈츠 <Grillenbanner>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Grillenbanner>', 'Waltz <Grillenbanner>', 'song', 'Op. 247', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Grillenbanner>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0aa22c0f-c8c7-4d1a-b1ac-01222e186ee2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0aa22c0f-c8c7-4d1a-b1ac-01222e186ee2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Grillenbanner>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0aa22c0f-c8c7-4d1a-b1ac-01222e186ee2'
);


-- Op. 248 폴카 <Camelien-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Camelien-Polka>', 'Polka schnell <Camelien-Polka>', 'song', 'Op. 248', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Camelien-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fb6bc64-7833-4e63-ba72-7b29ad28d5fc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7fb6bc64-7833-4e63-ba72-7b29ad28d5fc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Camelien-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fb6bc64-7833-4e63-ba72-7b29ad28d5fc'
);


-- Op. 249 폴카 <Hesperus-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Hesperus-Polka>', 'Polka <Hesperus-Polka>', 'song', 'Op. 249', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Hesperus-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7d9c07e-748c-4c63-b2db-cb4a3dff2107'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b7d9c07e-748c-4c63-b2db-cb4a3dff2107'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Hesperus-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7d9c07e-748c-4c63-b2db-cb4a3dff2107'
);


-- Op. 250 왈츠 <Wahlstimmen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Wahlstimmen>', 'Waltz <Wahlstimmen>', 'song', 'Op. 250', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Wahlstimmen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c725b7e6-7f87-467a-a894-490941c14b13'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c725b7e6-7f87-467a-a894-490941c14b13'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Wahlstimmen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c725b7e6-7f87-467a-a894-490941c14b13'
);


-- Op. 251 왈츠 <Klangfiguren>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Klangfiguren>', 'Waltz <Klangfiguren>', 'song', 'Op. 251', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Klangfiguren>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c78c848b-feb2-4047-a73f-1598172067e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c78c848b-feb2-4047-a73f-1598172067e8'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Klangfiguren>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c78c848b-feb2-4047-a73f-1598172067e8'
);


-- Op. 252 왈츠 <Dividenden>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Dividenden>', 'Waltz <Dividenden>', 'song', 'Op. 252', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Dividenden>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa0fd019-e124-484d-a9c8-840e25cbaf1b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aa0fd019-e124-484d-a9c8-840e25cbaf1b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Dividenden>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa0fd019-e124-484d-a9c8-840e25cbaf1b'
);


-- Op. 253 왈츠 <Schwärmereien>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Schwärmereien>', 'Waltz <Schwärmereien>', 'song', 'Op. 253', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Schwärmereien>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7eb77e1-75eb-4d1e-bd1b-664aafeeac0e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7eb77e1-75eb-4d1e-bd1b-664aafeeac0e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Schwärmereien>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7eb77e1-75eb-4d1e-bd1b-664aafeeac0e'
);


-- Op. 255 카드리유 <St. Petersburg>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <St. Petersburg>', 'Quadrille <St. Petersburg>', 'song', 'Op. 255', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <St. Petersburg>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f6ea6be-309d-4f40-ac00-14d26529b47a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0f6ea6be-309d-4f40-ac00-14d26529b47a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <St. Petersburg>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f6ea6be-309d-4f40-ac00-14d26529b47a'
);


-- Op. 255 로망스 2번 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 2번 G단조', 'Romanze No. 2 in G minor', 'song', 'Op. 255', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 2번 G단조'
);


-- Op. 256 마주르카 <Veilchen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카 <Veilchen>', 'Mazurka <Veilchen>', 'song', 'Op. 256', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카 <Veilchen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5305f20-3964-4f6a-817f-8f0700d3c772'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5305f20-3964-4f6a-817f-8f0700d3c772'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '마주르카 <Veilchen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5305f20-3964-4f6a-817f-8f0700d3c772'
);


-- Op. 257 무궁동

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무궁동', 'Perpetuum mobile', 'song', 'Op. 257', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무궁동'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a26cbcf8-fade-3e3b-8135-469bc7e48162'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a26cbcf8-fade-3e3b-8135-469bc7e48162'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '무궁동' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a26cbcf8-fade-3e3b-8135-469bc7e48162'
);


-- Op. 258 폴카 <Secunden-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Secunden-Polka>', 'Polka française <Secunden-Polka>', 'song', 'Op. 258', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Secunden-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e2b5f694-850d-499c-a83f-0fa2825d3310'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e2b5f694-850d-499c-a83f-0fa2825d3310'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Secunden-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e2b5f694-850d-499c-a83f-0fa2825d3310'
);


-- Op. 259 카드리유 <Chansonette-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Chansonette-Quadrille>', 'Quadrille <Chansonette-Quadrille>', 'song', 'Op. 259', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Chansonette-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f35324c7-f182-47ce-bb62-178f540626e3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f35324c7-f182-47ce-bb62-178f540626e3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Chansonette-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f35324c7-f182-47ce-bb62-178f540626e3'
);


-- Op. 260 폴카 <Furioso-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Furioso-Polka>', 'Polka <Furioso-Polka>', 'song', 'Op. 260', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Furioso-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fecef5e1-ac4f-4153-a6a0-67720768d447'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fecef5e1-ac4f-4153-a6a0-67720768d447'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Furioso-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fecef5e1-ac4f-4153-a6a0-67720768d447'
);


-- Op. 261 왈츠 <Die ersten Curen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die ersten Curen>', 'Waltz <Die ersten Curen>', 'song', 'Op. 261', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die ersten Curen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc1e3d0a-e047-4842-9da2-de1a4e53711c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc1e3d0a-e047-4842-9da2-de1a4e53711c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Die ersten Curen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc1e3d0a-e047-4842-9da2-de1a4e53711c'
);


-- Op. 262 왈츠 <Colonnen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Colonnen>', 'Waltz <Colonnen>', 'song', 'Op. 262', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Colonnen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b8f9802-9c7b-469f-9035-47fd6fe4a414'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9b8f9802-9c7b-469f-9035-47fd6fe4a414'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Colonnen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b8f9802-9c7b-469f-9035-47fd6fe4a414'
);


-- Op. 263 폴카 <Studenten-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Studenten-Polka>', 'Polka française <Studenten-Polka>', 'song', 'Op. 263', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Studenten-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1016d7d3-6582-4270-8c60-fab3c7a6103e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1016d7d3-6582-4270-8c60-fab3c7a6103e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Studenten-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1016d7d3-6582-4270-8c60-fab3c7a6103e'
);


-- Op. 264 왈츠 <Patronessen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Patronessen>', 'Waltz <Patronessen>', 'song', 'Op. 264', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Patronessen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce6df12d-a253-4a33-941b-52b1e2b8d428'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ce6df12d-a253-4a33-941b-52b1e2b8d428'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Patronessen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce6df12d-a253-4a33-941b-52b1e2b8d428'
);


-- Op. 265 왈츠 <Motoren>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Motoren>', 'Waltz <Motoren>', 'song', 'Op. 265', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Motoren>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17cc64b6-7db4-3d6b-a405-9ab75c8f93a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17cc64b6-7db4-3d6b-a405-9ab75c8f93a5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Motoren>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17cc64b6-7db4-3d6b-a405-9ab75c8f93a5'
);


-- Op. 266 폴카 <Lucifer-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Lucifer-Polka>', 'Polka schnell <Lucifer-Polka>', 'song', 'Op. 266', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Lucifer-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa391fc1-f6d2-4e5a-864c-b1112d65f905'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aa391fc1-f6d2-4e5a-864c-b1112d65f905'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Lucifer-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa391fc1-f6d2-4e5a-864c-b1112d65f905'
);


-- Op. 267 왈츠 <Concurrenzen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Concurrenzen>', 'Waltz <Concurrenzen>', 'song', 'Op. 267', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Concurrenzen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd18c3fb-d8c3-4023-ac46-c16d739026a3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd18c3fb-d8c3-4023-ac46-c16d739026a3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Concurrenzen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd18c3fb-d8c3-4023-ac46-c16d739026a3'
);


-- Op. 268 왈츠 <Wiener Chronik>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Wiener Chronik>', 'Waltz <Wiener Chronik>', 'song', 'Op. 268', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Wiener Chronik>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18f21836-566e-4776-bb02-9931d188eb19'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '18f21836-566e-4776-bb02-9931d188eb19'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Wiener Chronik>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18f21836-566e-4776-bb02-9931d188eb19'
);


-- Op. 269 폴카 <Demolirer-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Demolirer-Polka>', 'Polka française <Demolirer-Polka>', 'song', 'Op. 269', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Demolirer-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83948c2d-aed5-4cc5-9f42-f82112086f85'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '83948c2d-aed5-4cc5-9f42-f82112086f85'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Demolirer-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83948c2d-aed5-4cc5-9f42-f82112086f85'
);


-- Op. 270 왈츠 <Carnevals-Botschafter>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Carnevals-Botschafter>', 'Waltz <Carnevals-Botschafter>', 'song', 'Op. 270', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Carnevals-Botschafter>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad8d5692-c624-4d69-8a7a-69e2cef3d3cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ad8d5692-c624-4d69-8a7a-69e2cef3d3cf'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Carnevals-Botschafter>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad8d5692-c624-4d69-8a7a-69e2cef3d3cf'
);


-- Op. 271 폴카 <Bluette>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Bluette>', 'Polka française <Bluette>', 'song', 'Op. 271', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Bluette>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f121ac91-bf28-4fcb-806c-26eba93e6770'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f121ac91-bf28-4fcb-806c-26eba93e6770'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Bluette>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f121ac91-bf28-4fcb-806c-26eba93e6770'
);


-- Op. 273 왈츠 <Leitartikel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Leitartikel>', 'Waltz <Leitartikel>', 'song', 'Op. 273', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Leitartikel>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca22330a-4b3b-44a9-a28d-638462764b2b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca22330a-4b3b-44a9-a28d-638462764b2b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Leitartikel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca22330a-4b3b-44a9-a28d-638462764b2b'
);


-- Op. 274 폴카 <Patrioten-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Patrioten-Polka>', 'Polka <Patrioten-Polka>', 'song', 'Op. 274', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Patrioten-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da13ff79-ba59-4e61-b110-692bba946f17'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'da13ff79-ba59-4e61-b110-692bba946f17'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Patrioten-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da13ff79-ba59-4e61-b110-692bba946f17'
);


-- Op. 275 카드리유 <Lieder-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Lieder-Quadrille>', 'Quadrille <Lieder-Quadrille>', 'song', 'Op. 275', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Lieder-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '262baa74-fee9-4e4b-be51-8f8d0ce80ddc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '262baa74-fee9-4e4b-be51-8f8d0ce80ddc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Lieder-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '262baa74-fee9-4e4b-be51-8f8d0ce80ddc'
);


-- Op. 276 폴카 <Bauern-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Bauern-Polka>', 'Polka française <Bauern-Polka>', 'song', 'Op. 276', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Bauern-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94e7fedb-0ba3-4c76-9a56-fd9eb362627e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '94e7fedb-0ba3-4c76-9a56-fd9eb362627e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Bauern-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94e7fedb-0ba3-4c76-9a56-fd9eb362627e'
);


-- Op. 277 폴카 마주르카 <Invitation à la Polka-Mazur>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Invitation à la Polka-Mazur>', 'Polka-Mazurka <Invitation à la Polka-Mazur>', 'song', 'Op. 277', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Invitation à la Polka-Mazur>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f95058c6-7556-4b7d-9637-2206c2ba1f8b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f95058c6-7556-4b7d-9637-2206c2ba1f8b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Invitation à la Polka-Mazur>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f95058c6-7556-4b7d-9637-2206c2ba1f8b'
);


-- Op. 278 폴카 <Neues Leben>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Neues Leben>', 'Polka française <Neues Leben>', 'song', 'Op. 278', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Neues Leben>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7187474e-7a9b-4636-82de-1567e94ea1b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7187474e-7a9b-4636-82de-1567e94ea1b7'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Neues Leben>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7187474e-7a9b-4636-82de-1567e94ea1b7'
);


-- Op. 279 왈츠 <아침 신문>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <아침 신문>', 'Waltz <Morning Papers>', 'song', 'Op. 279', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <아침 신문>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '577ff828-99dd-3753-b046-e33feac220c5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '577ff828-99dd-3753-b046-e33feac220c5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <아침 신문>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '577ff828-99dd-3753-b046-e33feac220c5'
);


-- Op. 280 폴카 <Juristenball-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Juristenball-Polka>', 'Polka schnell <Juristenball-Polka>', 'song', 'Op. 280', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Juristenball-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '411d816b-49f5-45eb-ad18-dfbec5c483d3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '411d816b-49f5-45eb-ad18-dfbec5c483d3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Juristenball-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '411d816b-49f5-45eb-ad18-dfbec5c483d3'
);


-- Op. 281 폴카 <관광열차>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <관광열차>', 'Polka <Pleasure Train>', 'song', 'Op. 281', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <관광열차>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd995231-b239-325a-b606-1d34408e9dd0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd995231-b239-325a-b606-1d34408e9dd0'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <관광열차>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd995231-b239-325a-b606-1d34408e9dd0'
);


-- Op. 282 폴카 <Gut bürgerlich>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Gut bürgerlich>', 'Polka française <Gut bürgerlich>', 'song', 'Op. 282', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Gut bürgerlich>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f230caa2-f820-48b4-80ce-7dd7382196c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f230caa2-f820-48b4-80ce-7dd7382196c7'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Gut bürgerlich>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f230caa2-f820-48b4-80ce-7dd7382196c7'
);


-- Op. 284 행진곡 <Deutscher Krieger-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Deutscher Krieger-Marsch>', 'March <Deutscher Krieger-Marsch>', 'song', 'Op. 284', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Deutscher Krieger-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47837fa8-246d-4d77-bb29-157eb44c7a1c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47837fa8-246d-4d77-bb29-157eb44c7a1c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Deutscher Krieger-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47837fa8-246d-4d77-bb29-157eb44c7a1c'
);


-- Op. 285 왈츠 <Studentenlust>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Studentenlust>', 'Waltz <Studentenlust>', 'song', 'Op. 285', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Studentenlust>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5565f442-3e14-4ff5-9e22-3073f36a21bc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5565f442-3e14-4ff5-9e22-3073f36a21bc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Studentenlust>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5565f442-3e14-4ff5-9e22-3073f36a21bc'
);


-- Op. 286 폴카 <Patronessen-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Patronessen-Polka>', 'Polka française <Patronessen-Polka>', 'song', 'Op. 286', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Patronessen-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ab4763f-d3b4-4ffc-95c4-a972df0bcff5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ab4763f-d3b4-4ffc-95c4-a972df0bcff5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Patronessen-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ab4763f-d3b4-4ffc-95c4-a972df0bcff5'
);


-- Op. 287 행진곡 <Verbrüderungs-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Verbrüderungs-Marsch>', 'March <Verbrüderungs-Marsch>', 'song', 'Op. 287', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Verbrüderungs-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e637e97-7f3f-469b-8456-fe8b642946d8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0e637e97-7f3f-469b-8456-fe8b642946d8'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Verbrüderungs-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e637e97-7f3f-469b-8456-fe8b642946d8'
);


-- Op. 288 폴카 <Newa-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Newa-Polka>', 'Polka française <Newa-Polka>', 'song', 'Op. 288', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Newa-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9631b2b7-31c1-4c30-a208-cfc283ae71a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9631b2b7-31c1-4c30-a208-cfc283ae71a4'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Newa-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9631b2b7-31c1-4c30-a208-cfc283ae71a4'
);


-- Op. 289 페르시아 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '페르시아 행진곡', 'Persian March', 'song', 'Op. 289', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '페르시아 행진곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df2755aa-c0ce-399e-bdbc-9b5257f3e23d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df2755aa-c0ce-399e-bdbc-9b5257f3e23d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '페르시아 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df2755aa-c0ce-399e-bdbc-9b5257f3e23d'
);


-- Op. 290 카드리유 <Quadrille sur des airs français>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Quadrille sur des airs français>', 'Quadrille <Quadrille sur des airs français>', 'song', 'Op. 290', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Quadrille sur des airs français>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cbcd90e-d024-4551-b386-9face6fd1287'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4cbcd90e-d024-4551-b386-9face6fd1287'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Quadrille sur des airs français>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cbcd90e-d024-4551-b386-9face6fd1287'
);


-- Op. 291 폴카 <'s gibt nur a Kaiserstadt, 's gibt nur a Wien>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <''s gibt nur a Kaiserstadt, ''s gibt nur a Wien>', 'Polka schnell <''s gibt nur a Kaiserstadt, ''s gibt nur a Wien>', 'song', 'Op. 291', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <''s gibt nur a Kaiserstadt, ''s gibt nur a Wien>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7adcffcd-5879-4440-8b8f-b5bbdf7aaaf6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7adcffcd-5879-4440-8b8f-b5bbdf7aaaf6'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <''s gibt nur a Kaiserstadt, ''s gibt nur a Wien>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7adcffcd-5879-4440-8b8f-b5bbdf7aaaf6'
);


-- Op. 292 왈츠 <Aus den Bergen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Aus den Bergen>', 'Waltz <Aus den Bergen>', 'song', 'Op. 292', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Aus den Bergen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '95aa61a7-755a-401d-b72e-6523ca4944b5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '95aa61a7-755a-401d-b72e-6523ca4944b5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Aus den Bergen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '95aa61a7-755a-401d-b72e-6523ca4944b5'
);


-- Op. 293 왈츠 <Feuilleton>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Feuilleton>', 'Waltz <Feuilleton>', 'song', 'Op. 293', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Feuilleton>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '756a834e-fa42-4516-b3fc-3199e6f97c3b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '756a834e-fa42-4516-b3fc-3199e6f97c3b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Feuilleton>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '756a834e-fa42-4516-b3fc-3199e6f97c3b'
);


-- Op. 294 폴카 <Proceß-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Proceß-Polka>', 'Polka schnell <Proceß-Polka>', 'song', 'Op. 294', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Proceß-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0cab3bd-5c91-4364-8d06-dde4e5ae95fc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0cab3bd-5c91-4364-8d06-dde4e5ae95fc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Proceß-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0cab3bd-5c91-4364-8d06-dde4e5ae95fc'
);


-- Op. 295 왈츠 <Bürgersinn>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Bürgersinn>', 'Waltz <Bürgersinn>', 'song', 'Op. 295', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Bürgersinn>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac850110-37b4-4b29-8add-65da45407166'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac850110-37b4-4b29-8add-65da45407166'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Bürgersinn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac850110-37b4-4b29-8add-65da45407166'
);


-- Op. 296 폴카 <Episode-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Episode-Polka>', 'Polka française <Episode-Polka>', 'song', 'Op. 296', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Episode-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '500d488a-2f05-459e-a9b8-75919a388899'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '500d488a-2f05-459e-a9b8-75919a388899'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Episode-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '500d488a-2f05-459e-a9b8-75919a388899'
);


-- Op. 297 폴카 <Electrofor-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Electrofor-Polka>', 'Polka schnell <Electrofor-Polka>', 'song', 'Op. 297', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Electrofor-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7299ef65-2481-3452-9252-5ad78db57d7b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7299ef65-2481-3452-9252-5ad78db57d7b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Electrofor-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7299ef65-2481-3452-9252-5ad78db57d7b'
);


-- Op. 298 왈츠 <Hofball-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Hofball-Tänze>', 'Waltz <Hofball-Tänze>', 'song', 'Op. 298', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Hofball-Tänze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11f34645-659a-48b4-927f-c2b1a366318f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '11f34645-659a-48b4-927f-c2b1a366318f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Hofball-Tänze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11f34645-659a-48b4-927f-c2b1a366318f'
);


-- Op. 300 왈츠 <Flugschriften>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Flugschriften>', 'Waltz <Flugschriften>', 'song', 'Op. 300', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Flugschriften>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '135961f9-7c08-4d7f-b60c-d943d7a21d26'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '135961f9-7c08-4d7f-b60c-d943d7a21d26'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Flugschriften>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '135961f9-7c08-4d7f-b60c-d943d7a21d26'
);


-- Op. 301 폴카 <Kreuzfidel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Kreuzfidel>', 'Polka française <Kreuzfidel>', 'song', 'Op. 301', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Kreuzfidel>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b1359d1-e0ab-38e0-9389-b835e8530bfc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b1359d1-e0ab-38e0-9389-b835e8530bfc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Kreuzfidel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b1359d1-e0ab-38e0-9389-b835e8530bfc'
);


-- Op. 302 폴카 <Die Zeitlose>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Die Zeitlose>', 'Polka française <Die Zeitlose>', 'song', 'Op. 302', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Die Zeitlose>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2f4b968-b937-459e-bf43-579931b1760d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd2f4b968-b937-459e-bf43-579931b1760d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Die Zeitlose>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2f4b968-b937-459e-bf43-579931b1760d'
);


-- Op. 303 카드리유 <Bal champêtre>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Bal champêtre>', 'Quadrille <Bal champêtre>', 'song', 'Op. 303', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Bal champêtre>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c128ab2-8cc9-47a2-a8a4-09fd826c79ce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7c128ab2-8cc9-47a2-a8a4-09fd826c79ce'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Bal champêtre>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c128ab2-8cc9-47a2-a8a4-09fd826c79ce'
);


-- Op. 304 폴카 <Kinderspiele>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Kinderspiele>', 'Polka française <Kinderspiele>', 'song', 'Op. 304', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Kinderspiele>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ad73146-403d-4e36-970f-98220438d3c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5ad73146-403d-4e36-970f-98220438d3c7'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Kinderspiele>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ad73146-403d-4e36-970f-98220438d3c7'
);


-- Op. 305 폴카 <Damenspende>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Damenspende>', 'Polka française <Damenspende>', 'song', 'Op. 305', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Damenspende>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3e15d05-35a9-4935-a9bf-4cbf8b3e2884'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3e15d05-35a9-4935-a9bf-4cbf8b3e2884'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Damenspende>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3e15d05-35a9-4935-a9bf-4cbf8b3e2884'
);


-- Op. 306 왈츠 <Bürgerweisen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Bürgerweisen>', 'Waltz <Bürgerweisen>', 'song', 'Op. 306', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Bürgerweisen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff8ccc81-7270-48ac-a91b-9137a7aeccae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ff8ccc81-7270-48ac-a91b-9137a7aeccae'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Bürgerweisen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff8ccc81-7270-48ac-a91b-9137a7aeccae'
);


-- Op. 307 왈츠 <빈의 봉봉>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <빈의 봉봉>', 'Waltz <Viennese Bonbons>', 'song', 'Op. 307', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <빈의 봉봉>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed538401-17dd-3d0b-a891-cc0258a4a06c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed538401-17dd-3d0b-a891-cc0258a4a06c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <빈의 봉봉>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed538401-17dd-3d0b-a891-cc0258a4a06c'
);


-- Op. 308 폴카 <Par force!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Par force!>', 'Polka schnell <Par force!>', 'song', 'Op. 308', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Par force!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccca2c97-303a-4da2-b859-9454f5529232'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ccca2c97-303a-4da2-b859-9454f5529232'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Par force!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccca2c97-303a-4da2-b859-9454f5529232'
);


-- Op. 309 폴카 <Sylphen-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Sylphen-Polka>', 'Polka <Sylphen-Polka>', 'song', 'Op. 309', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Sylphen-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92bebe54-2e05-41cb-974d-10b066ee9d6a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '92bebe54-2e05-41cb-974d-10b066ee9d6a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Sylphen-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92bebe54-2e05-41cb-974d-10b066ee9d6a'
);


-- Op. 310 폴카 마주르카 <Tändelei>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Tändelei>', 'Polka-Mazurka <Tändelei>', 'song', 'Op. 310', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Tändelei>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '089b8290-90fe-4408-b1d9-20a460de7f28'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '089b8290-90fe-4408-b1d9-20a460de7f28'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Tändelei>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '089b8290-90fe-4408-b1d9-20a460de7f28'
);


-- Op. 311 폴카 <Express-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Express-Polka>', 'Polka schnell <Express-Polka>', 'song', 'Op. 311', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Express-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0e49412-70b7-458d-8756-9724d86da55a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c0e49412-70b7-458d-8756-9724d86da55a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Express-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0e49412-70b7-458d-8756-9724d86da55a'
);


-- Op. 312 왈츠 <Feenmärchen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Feenmärchen>', 'Waltz <Feenmärchen>', 'song', 'Op. 312', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Feenmärchen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da9704ac-3f68-44bb-a2ce-48debd532aca'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'da9704ac-3f68-44bb-a2ce-48debd532aca'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Feenmärchen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da9704ac-3f68-44bb-a2ce-48debd532aca'
);


-- Op. 313 폴카 <Wildfeuer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Wildfeuer>', 'Polka française <Wildfeuer>', 'song', 'Op. 313', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Wildfeuer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb736b7d-b044-408b-b003-7a6c4041ee62'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb736b7d-b044-408b-b003-7a6c4041ee62'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Wildfeuer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb736b7d-b044-408b-b003-7a6c4041ee62'
);


-- Op. 315 폴카 마주르카 <Lob der Frauen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Lob der Frauen>', 'Polka-Mazurka <Lob der Frauen>', 'song', 'Op. 315', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Lob der Frauen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ce29f05-716c-4474-a622-0fc36681d1b2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ce29f05-716c-4474-a622-0fc36681d1b2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Lob der Frauen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ce29f05-716c-4474-a622-0fc36681d1b2'
);


-- Op. 316 왈츠 <예술가의 생애>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <예술가의 생애>', 'Waltz <Artist''s Life>', 'song', 'Op. 316', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <예술가의 생애>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '71f4fb64-ef2c-3c00-8fdf-8c75db36efa5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '71f4fb64-ef2c-3c00-8fdf-8c75db36efa5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <예술가의 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '71f4fb64-ef2c-3c00-8fdf-8c75db36efa5'
);


-- Op. 317 폴카 <Postillon d'amour>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Postillon d''amour>', 'Polka française <Postillon d''amour>', 'song', 'Op. 317', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Postillon d''amour>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fae9b36-48f1-4dc5-8e3c-4ca7c36a56f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2fae9b36-48f1-4dc5-8e3c-4ca7c36a56f5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Postillon d''amour>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fae9b36-48f1-4dc5-8e3c-4ca7c36a56f5'
);


-- Op. 318 왈츠 <Telegramme>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Telegramme>', 'Waltz <Telegramme>', 'song', 'Op. 318', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Telegramme>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a16013c7-cded-4f24-b26a-45f762117a4b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a16013c7-cded-4f24-b26a-45f762117a4b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Telegramme>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a16013c7-cded-4f24-b26a-45f762117a4b'
);


-- Op. 319 폴카 <Leichtes Blut>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Leichtes Blut>', 'Polka schnell <Leichtes Blut>', 'song', 'Op. 319', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Leichtes Blut>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64bf568b-822f-3683-9bc2-3b66fc9f98a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64bf568b-822f-3683-9bc2-3b66fc9f98a6'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Leichtes Blut>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64bf568b-822f-3683-9bc2-3b66fc9f98a6'
);


-- Op. 320 폴카 <Figaro-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Figaro-Polka>', 'Polka française <Figaro-Polka>', 'song', 'Op. 320', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Figaro-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fb2c97e-fd62-4ef9-92dc-cefa2c2726e0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7fb2c97e-fd62-4ef9-92dc-cefa2c2726e0'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Figaro-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fb2c97e-fd62-4ef9-92dc-cefa2c2726e0'
);


-- Op. 321 왈츠 <Die Publicisten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Publicisten>', 'Waltz <Die Publicisten>', 'song', 'Op. 321', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Publicisten>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b258868f-24bc-4290-ba88-96a382cb673e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b258868f-24bc-4290-ba88-96a382cb673e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Die Publicisten>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b258868f-24bc-4290-ba88-96a382cb673e'
);


-- Op. 322 폴카 마주르카 <Stadt und Land>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Stadt und Land>', 'Polka-Mazurka <Stadt und Land>', 'song', 'Op. 322', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Stadt und Land>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32a3f2b4-1e33-40e4-9085-6371ab13c9e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '32a3f2b4-1e33-40e4-9085-6371ab13c9e9'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Stadt und Land>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32a3f2b4-1e33-40e4-9085-6371ab13c9e9'
);


-- Op. 323 폴카 마주르카 <Ein Herz, ein Sinn>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Ein Herz, ein Sinn>', 'Polka-Mazurka <Ein Herz, ein Sinn>', 'song', 'Op. 323', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Ein Herz, ein Sinn>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76a155a2-d166-4cfa-b60e-4484e91c3e6d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '76a155a2-d166-4cfa-b60e-4484e91c3e6d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Ein Herz, ein Sinn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76a155a2-d166-4cfa-b60e-4484e91c3e6d'
);


-- Op. 326 폴카 <Freikugeln>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Freikugeln>', 'Polka schnell <Freikugeln>', 'song', 'Op. 326', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Freikugeln>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7e621d2-7f64-428d-932f-03ab063eb7db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7e621d2-7f64-428d-932f-03ab063eb7db'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Freikugeln>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7e621d2-7f64-428d-932f-03ab063eb7db'
);


-- Op. 328 폴카 <Sängerslust-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Sängerslust-Polka>', 'Polka française <Sängerslust-Polka>', 'song', 'Op. 328', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Sängerslust-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01cbd69a-6413-4808-a4a4-99861e1cdc34'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '01cbd69a-6413-4808-a4a4-99861e1cdc34'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Sängerslust-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01cbd69a-6413-4808-a4a4-99861e1cdc34'
);


-- Op. 329 왈츠 <Erinnerung an Covent-Garden>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Erinnerung an Covent-Garden>', 'Waltz <Erinnerung an Covent-Garden>', 'song', 'Op. 329', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Erinnerung an Covent-Garden>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b35f8e18-dbd8-4a29-9f57-47657f32c144'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b35f8e18-dbd8-4a29-9f57-47657f32c144'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Erinnerung an Covent-Garden>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b35f8e18-dbd8-4a29-9f57-47657f32c144'
);


-- Op. 330 폴카 마주르카 <Fata Morgana>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Fata Morgana>', 'Polka-Mazurka <Fata Morgana>', 'song', 'Op. 330', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Fata Morgana>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc630461-c15b-4b23-9cf1-962070bbfad3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc630461-c15b-4b23-9cf1-962070bbfad3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Fata Morgana>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc630461-c15b-4b23-9cf1-962070bbfad3'
);


-- Op. 331 왈츠 <Illustrationen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Illustrationen>', 'Waltz <Illustrationen>', 'song', 'Op. 331', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Illustrationen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df3a8a2a-73d6-4a4c-90af-4f35ea7e26a3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df3a8a2a-73d6-4a4c-90af-4f35ea7e26a3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Illustrationen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df3a8a2a-73d6-4a4c-90af-4f35ea7e26a3'
);


-- Op. 332 폴카 <헝가리 만세>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <헝가리 만세>', 'Polka <Éljen a Magyar!>', 'song', 'Op. 332', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <헝가리 만세>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49adc2c3-68c6-30ee-933c-8c45778e38c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '49adc2c3-68c6-30ee-933c-8c45778e38c7'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <헝가리 만세>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49adc2c3-68c6-30ee-933c-8c45778e38c7'
);


-- Op. 333 왈츠 <술, 여자, 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <술, 여자, 노래>', 'Waltz <Wine, Women and Song>', 'song', 'Op. 333', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <술, 여자, 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6237af8b-2092-3206-a581-3af3e6c5bcf4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6237af8b-2092-3206-a581-3af3e6c5bcf4'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <술, 여자, 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6237af8b-2092-3206-a581-3af3e6c5bcf4'
);


-- Op. 334 왈츠 <Königslieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Königslieder>', 'Waltz <Königslieder>', 'song', 'Op. 334', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Königslieder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06067dc5-88f6-4ff6-9bfd-d2ed231c4c4e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06067dc5-88f6-4ff6-9bfd-d2ed231c4c4e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Königslieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06067dc5-88f6-4ff6-9bfd-d2ed231c4c4e'
);


-- Op. 335 이집트 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '이집트 행진곡', 'Egyptian March', 'song', 'Op. 335', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '이집트 행진곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '927ad721-5630-35d1-8a7f-2dc403727fbd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '927ad721-5630-35d1-8a7f-2dc403727fbd'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '이집트 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '927ad721-5630-35d1-8a7f-2dc403727fbd'
);


-- Op. 336 폴카 <크라펜의 숲에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <크라펜의 숲에서>', 'Polka <In the Krapfen Woods>', 'song', 'Op. 336', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <크라펜의 숲에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fff00e1-0847-4716-9253-981bbf1483c1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3fff00e1-0847-4716-9253-981bbf1483c1'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <크라펜의 숲에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fff00e1-0847-4716-9253-981bbf1483c1'
);


-- Op. 337 폴카 <Von der Börse>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Von der Börse>', 'Polka française <Von der Börse>', 'song', 'Op. 337', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Von der Börse>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce056062-df5b-48c9-8cbc-823ef9504dba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ce056062-df5b-48c9-8cbc-823ef9504dba'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Von der Börse>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce056062-df5b-48c9-8cbc-823ef9504dba'
);


-- Op. 338 카드리유 <Slovianka-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Slovianka-Quadrille>', 'Quadrille <Slovianka-Quadrille>', 'song', 'Op. 338', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Slovianka-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a4de5a8-cb57-49bb-9999-9a49ffecd830'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a4de5a8-cb57-49bb-9999-9a49ffecd830'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Slovianka-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a4de5a8-cb57-49bb-9999-9a49ffecd830'
);


-- Op. 339 폴카 <Louischen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Louischen>', 'Polka française <Louischen>', 'song', 'Op. 339', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Louischen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ab80a13-cc9d-4f2f-962f-a165ee0a3cf4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ab80a13-cc9d-4f2f-962f-a165ee0a3cf4'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Louischen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ab80a13-cc9d-4f2f-962f-a165ee0a3cf4'
);


-- Op. 340 왈츠 <Freuet euch des Lebens>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Freuet euch des Lebens>', 'Waltz <Freuet euch des Lebens>', 'song', 'Op. 340', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Freuet euch des Lebens>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '771a67dc-07b3-42a1-b570-c6a4f5603c17'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '771a67dc-07b3-42a1-b570-c6a4f5603c17'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Freuet euch des Lebens>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '771a67dc-07b3-42a1-b570-c6a4f5603c17'
);


-- Op. 341 카드리유 <Festival-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Festival-Quadrille>', 'Quadrille <Festival-Quadrille>', 'song', 'Op. 341', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Festival-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb1fe50b-27f9-459c-8a74-0c1db0813246'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cb1fe50b-27f9-459c-8a74-0c1db0813246'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Festival-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb1fe50b-27f9-459c-8a74-0c1db0813246'
);


-- Op. 342 왈츠 <Neu-Wien>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Neu-Wien>', 'Waltz <Neu-Wien>', 'song', 'Op. 342', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Neu-Wien>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '174bbff0-e7d1-4b85-a3ad-f7446dfea0ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '174bbff0-e7d1-4b85-a3ad-f7446dfea0ff'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Neu-Wien>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '174bbff0-e7d1-4b85-a3ad-f7446dfea0ff'
);


-- Op. 343 폴카 <Shawl-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Shawl-Polka>', 'Polka française <Shawl-Polka>', 'song', 'Op. 343', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Shawl-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b537e23-3011-4f48-88a5-a59428a8b031'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1b537e23-3011-4f48-88a5-a59428a8b031'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Shawl-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b537e23-3011-4f48-88a5-a59428a8b031'
);


-- Op. 344 카드리유 <Indigo-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Indigo-Quadrille>', 'Quadrille <Indigo-Quadrille>', 'song', 'Op. 344', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Indigo-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b17e6fb-3aca-487b-affe-5523f9651bfb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b17e6fb-3aca-487b-affe-5523f9651bfb'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Indigo-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b17e6fb-3aca-487b-affe-5523f9651bfb'
);


-- Op. 345 폴카 <Auf freiem Fuße>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Auf freiem Fuße>', 'Polka française <Auf freiem Fuße>', 'song', 'Op. 345', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Auf freiem Fuße>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f6882f7-dad5-494d-aecf-24f66c1a6519'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f6882f7-dad5-494d-aecf-24f66c1a6519'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Auf freiem Fuße>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f6882f7-dad5-494d-aecf-24f66c1a6519'
);


-- Op. 346 왈츠 <천일야화>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <천일야화>', 'Waltz <A Thousand and One Nights>', 'song', 'Op. 346', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <천일야화>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0facf44-fd56-3947-bb02-c2df5984b6f0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0facf44-fd56-3947-bb02-c2df5984b6f0'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <천일야화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0facf44-fd56-3947-bb02-c2df5984b6f0'
);


-- Op. 347 폴카 마주르카 <Aus der Heimath>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Aus der Heimath>', 'Polka-Mazurka <Aus der Heimath>', 'song', 'Op. 347', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Aus der Heimath>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c8bc2b7-aa78-4e52-8b95-98d52b33f732'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c8bc2b7-aa78-4e52-8b95-98d52b33f732'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Aus der Heimath>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c8bc2b7-aa78-4e52-8b95-98d52b33f732'
);


-- Op. 348 폴카 <Im Sturmschritt>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Im Sturmschritt>', 'Polka schnell <Im Sturmschritt>', 'song', 'Op. 348', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Im Sturmschritt>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27ced74e-4650-4e2e-ad87-3b9c97d9609d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '27ced74e-4650-4e2e-ad87-3b9c97d9609d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Im Sturmschritt>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27ced74e-4650-4e2e-ad87-3b9c97d9609d'
);


-- Op. 349 행진곡 <Indigo-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Indigo-Marsch>', 'March <Indigo-Marsch>', 'song', 'Op. 349', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Indigo-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b981b664-abf9-422f-acd8-42bbe90f00c5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b981b664-abf9-422f-acd8-42bbe90f00c5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Indigo-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b981b664-abf9-422f-acd8-42bbe90f00c5'
);


-- Op. 350 폴카 <Lust'ger Rath>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Lust''ger Rath>', 'Polka française <Lust''ger Rath>', 'song', 'Op. 350', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Lust''ger Rath>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec05a2b8-b2b5-4503-ba34-9ce5e3a57832'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec05a2b8-b2b5-4503-ba34-9ce5e3a57832'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Lust''ger Rath>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec05a2b8-b2b5-4503-ba34-9ce5e3a57832'
);


-- Op. 351 폴카 <Die Bajadere>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Die Bajadere>', 'Polka schnell <Die Bajadere>', 'song', 'Op. 351', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Die Bajadere>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65c78abb-3520-455b-a4a9-fa71d7ffa42e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '65c78abb-3520-455b-a4a9-fa71d7ffa42e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Die Bajadere>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65c78abb-3520-455b-a4a9-fa71d7ffa42e'
);


-- Op. 352 폴로네즈 <Fest-Polonaise>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 <Fest-Polonaise>', 'Polonaise <Fest-Polonaise>', 'song', 'Op. 352', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 <Fest-Polonaise>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90d0ad38-a2af-4883-8efb-29b580407f88'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '90d0ad38-a2af-4883-8efb-29b580407f88'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴로네즈 <Fest-Polonaise>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90d0ad38-a2af-4883-8efb-29b580407f88'
);


-- Op. 353 행진곡 <Russische Marsch-Fantasie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Russische Marsch-Fantasie>', 'March <Russische Marsch-Fantasie>', 'song', 'Op. 353', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Russische Marsch-Fantasie>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d200e55-9362-4210-aa53-c5800d5dccf4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d200e55-9362-4210-aa53-c5800d5dccf4'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Russische Marsch-Fantasie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d200e55-9362-4210-aa53-c5800d5dccf4'
);


-- Op. 354 왈츠 <빈 기질>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <빈 기질>', 'Waltz <Wiener Blut>', 'song', 'Op. 354', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <빈 기질>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54fe325f-e04a-3849-bc0d-867b110724cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '54fe325f-e04a-3849-bc0d-867b110724cf'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <빈 기질>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54fe325f-e04a-3849-bc0d-867b110724cf'
);


-- Op. 355 환상곡 <Im russischen Dorfe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상곡 <Im russischen Dorfe>', 'Fantasy <Im russischen Dorfe>', 'song', 'Op. 355', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상곡 <Im russischen Dorfe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1854f5a9-44e7-4433-b727-3f1f13b18f51'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1854f5a9-44e7-4433-b727-3f1f13b18f51'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '환상곡 <Im russischen Dorfe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1854f5a9-44e7-4433-b727-3f1f13b18f51'
);


-- Op. 356 폴카 <Vom Donaustrande>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Vom Donaustrande>', 'Polka schnell <Vom Donaustrande>', 'song', 'Op. 356', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Vom Donaustrande>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df3c2b4e-1e35-4080-a7d5-738591d35b35'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df3c2b4e-1e35-4080-a7d5-738591d35b35'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Vom Donaustrande>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df3c2b4e-1e35-4080-a7d5-738591d35b35'
);


-- Op. 357 왈츠 <Carnevalsbilder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Carnevalsbilder>', 'Waltz <Carnevalsbilder>', 'song', 'Op. 357', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Carnevalsbilder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ed5e455-7fe6-46af-b16f-86661abce51a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8ed5e455-7fe6-46af-b16f-86661abce51a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Carnevalsbilder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ed5e455-7fe6-46af-b16f-86661abce51a'
);


-- Op. 358 폴카 <Nimm sie hin>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Nimm sie hin>', 'Polka française <Nimm sie hin>', 'song', 'Op. 358', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Nimm sie hin>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cd32164-562b-4346-8c6f-aee1f98af631'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4cd32164-562b-4346-8c6f-aee1f98af631'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Nimm sie hin>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cd32164-562b-4346-8c6f-aee1f98af631'
);


-- Op. 359 폴카 마주르카 <Gruß aus Österreich>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Gruß aus Österreich>', 'Polka-Mazurka <Gruß aus Österreich>', 'song', 'Op. 359', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Gruß aus Österreich>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78a6b223-0dae-4257-84ac-62ee74dd95b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '78a6b223-0dae-4257-84ac-62ee74dd95b8'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Gruß aus Österreich>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78a6b223-0dae-4257-84ac-62ee74dd95b8'
);


-- Op. 360 카드리유 <Rotunde-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Rotunde-Quadrille>', 'Quadrille <Rotunde-Quadrille>', 'song', 'Op. 360', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Rotunde-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '967e7af8-7e5f-4a12-b49e-34e1f05b2b6f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '967e7af8-7e5f-4a12-b49e-34e1f05b2b6f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Rotunde-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '967e7af8-7e5f-4a12-b49e-34e1f05b2b6f'
);


-- Op. 361 왈츠 <Bei uns z'Haus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Bei uns z''Haus>', 'Waltz <Bei uns z''Haus>', 'song', 'Op. 361', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Bei uns z''Haus>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55795294-4b18-41a2-9fd4-b8898fd5073c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '55795294-4b18-41a2-9fd4-b8898fd5073c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Bei uns z''Haus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55795294-4b18-41a2-9fd4-b8898fd5073c'
);


-- Op. 362 폴카 <Fledermaus-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Fledermaus-Polka>', 'Polka <Fledermaus-Polka>', 'song', 'Op. 362', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Fledermaus-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7599622-4be0-451f-8b83-21d05a4bc65d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7599622-4be0-451f-8b83-21d05a4bc65d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Fledermaus-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7599622-4be0-451f-8b83-21d05a4bc65d'
);


-- Op. 363 카드리유 <Fledermaus-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Fledermaus-Quadrille>', 'Quadrille <Fledermaus-Quadrille>', 'song', 'Op. 363', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Fledermaus-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03a26dc8-b06b-3a52-949d-53c21ed61ace'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '03a26dc8-b06b-3a52-949d-53c21ed61ace'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Fledermaus-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03a26dc8-b06b-3a52-949d-53c21ed61ace'
);


-- Op. 364 왈츠 <레몬꽃 피는 곳>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <레몬꽃 피는 곳>', 'Waltz <Where the Lemons Blossom>', 'song', 'Op. 364', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <레몬꽃 피는 곳>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16e024c8-fc0d-3cf0-b75c-78368dfc247f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '16e024c8-fc0d-3cf0-b75c-78368dfc247f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <레몬꽃 피는 곳>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16e024c8-fc0d-3cf0-b75c-78368dfc247f'
);


-- Op. 365 폴카 <Tik-Tak-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Tik-Tak-Polka>', 'Polka schnell <Tik-Tak-Polka>', 'song', 'Op. 365', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Tik-Tak-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be0b1b11-d065-3ca9-bc6a-ee39d62683ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be0b1b11-d065-3ca9-bc6a-ee39d62683ee'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Tik-Tak-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be0b1b11-d065-3ca9-bc6a-ee39d62683ee'
);


-- Op. 366 폴카 <An der Moldau>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <An der Moldau>', 'Polka française <An der Moldau>', 'song', 'Op. 366', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <An der Moldau>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0a61045-0b2c-4217-8739-61f55aae4808'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f0a61045-0b2c-4217-8739-61f55aae4808'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <An der Moldau>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0a61045-0b2c-4217-8739-61f55aae4808'
);


-- Op. 367 왈츠 <Du und Du>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Du und Du>', 'Waltz <Du und Du>', 'song', 'Op. 367', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Du und Du>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0d9e25d6-cdc5-4201-9099-82dd6f0be680'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0d9e25d6-cdc5-4201-9099-82dd6f0be680'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Du und Du>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0d9e25d6-cdc5-4201-9099-82dd6f0be680'
);


-- Op. 368 폴카 마주르카 <Glücklich ist, wer vergißt!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Glücklich ist, wer vergißt!>', 'Polka-Mazurka <Glücklich ist, wer vergißt!>', 'song', 'Op. 368', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Glücklich ist, wer vergißt!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9c3e822-336a-4d9d-baeb-1f2d128b7e5d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd9c3e822-336a-4d9d-baeb-1f2d128b7e5d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Glücklich ist, wer vergißt!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9c3e822-336a-4d9d-baeb-1f2d128b7e5d'
);


-- Op. 369 카드리유 <Cagliostro-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Cagliostro-Quadrille>', 'Quadrille <Cagliostro-Quadrille>', 'song', 'Op. 369', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Cagliostro-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56ef541c-a635-4fae-acee-95489a1785bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56ef541c-a635-4fae-acee-95489a1785bf'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Cagliostro-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56ef541c-a635-4fae-acee-95489a1785bf'
);


-- Op. 370 왈츠 <Cagliostro-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Cagliostro-Walzer>', 'Waltz <Cagliostro-Walzer>', 'song', 'Op. 370', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Cagliostro-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9cd0fb28-1f1e-4b9d-abf5-324947f6b8c5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9cd0fb28-1f1e-4b9d-abf5-324947f6b8c5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Cagliostro-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9cd0fb28-1f1e-4b9d-abf5-324947f6b8c5'
);


-- Op. 371 행진곡 <Hoch Österreich!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Hoch Österreich!>', 'March <Hoch Österreich!>', 'song', 'Op. 371', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Hoch Österreich!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '53892326-8ad2-41e0-ba47-f38e0e718382'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '53892326-8ad2-41e0-ba47-f38e0e718382'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Hoch Österreich!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '53892326-8ad2-41e0-ba47-f38e0e718382'
);


-- Op. 372 폴카 <Bitte schön>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Bitte schön>', 'Polka française <Bitte schön>', 'song', 'Op. 372', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Bitte schön>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '388b3c13-80be-4f11-94fa-a8910cfbc1f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '388b3c13-80be-4f11-94fa-a8910cfbc1f1'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Bitte schön>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '388b3c13-80be-4f11-94fa-a8910cfbc1f1'
);


-- Op. 373 폴카 <사냥>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <사냥>', 'Polka <On the Hunt>', 'song', 'Op. 373', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <사냥>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8d124e2-4480-3582-8a8c-74e55a5a676f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f8d124e2-4480-3582-8a8c-74e55a5a676f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <사냥>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8d124e2-4480-3582-8a8c-74e55a5a676f'
);


-- Op. 374 폴카 마주르카 <Licht und Schatten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Licht und Schatten>', 'Polka-Mazurka <Licht und Schatten>', 'song', 'Op. 374', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Licht und Schatten>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b818f296-e987-4ea0-82b7-86e3a51eeaa6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b818f296-e987-4ea0-82b7-86e3a51eeaa6'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Licht und Schatten>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b818f296-e987-4ea0-82b7-86e3a51eeaa6'
);


-- Op. 375 왈츠 <O schöner Mai!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <O schöner Mai!>', 'Waltz <O schöner Mai!>', 'song', 'Op. 375', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <O schöner Mai!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82e8441d-74e6-40b3-ad7f-f6c2e8142c1c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82e8441d-74e6-40b3-ad7f-f6c2e8142c1c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <O schöner Mai!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82e8441d-74e6-40b3-ad7f-f6c2e8142c1c'
);


-- Op. 376 카드리유 <Methusalem-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Methusalem-Quadrille>', 'Quadrille <Methusalem-Quadrille>', 'song', 'Op. 376', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Methusalem-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d09baa6-6918-4d0b-adcb-241dee6fcadd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7d09baa6-6918-4d0b-adcb-241dee6fcadd'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Methusalem-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d09baa6-6918-4d0b-adcb-241dee6fcadd'
);


-- Op. 377 폴카 <I-Tipferl-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <I-Tipferl-Polka>', 'Polka française <I-Tipferl-Polka>', 'song', 'Op. 377', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <I-Tipferl-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f75225bb-2d0d-4f98-827e-47d49a7071ce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f75225bb-2d0d-4f98-827e-47d49a7071ce'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <I-Tipferl-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f75225bb-2d0d-4f98-827e-47d49a7071ce'
);


-- Op. 378 갤럽 <Banditen-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Banditen-Galopp>', 'Galop <Banditen-Galopp>', 'song', 'Op. 378', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Banditen-Galopp>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3e5ad84-7d5e-4096-907c-6e5372cea69a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f3e5ad84-7d5e-4096-907c-6e5372cea69a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '갤럽 <Banditen-Galopp>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3e5ad84-7d5e-4096-907c-6e5372cea69a'
);


-- Op. 379 폴카 마주르카 <Kriegers Liebchen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Kriegers Liebchen>', 'Polka-Mazurka <Kriegers Liebchen>', 'song', 'Op. 379', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Kriegers Liebchen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8666372c-bcdf-4aa3-8fff-cb497b9416d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8666372c-bcdf-4aa3-8fff-cb497b9416d5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Kriegers Liebchen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8666372c-bcdf-4aa3-8fff-cb497b9416d5'
);


-- Op. 380 폴카 <Ballsträusschen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Ballsträusschen>', 'Polka schnell <Ballsträusschen>', 'song', 'Op. 380', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Ballsträusschen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ccbdeea-8052-455e-9a7c-d8d4b6ad660e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3ccbdeea-8052-455e-9a7c-d8d4b6ad660e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Ballsträusschen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ccbdeea-8052-455e-9a7c-d8d4b6ad660e'
);


-- Op. 381 왈츠 <Kennst du mich?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Kennst du mich?>', 'Waltz <Kennst du mich?>', 'song', 'Op. 381', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Kennst du mich?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d127ec5-5826-45d9-b57f-90c0b3095863'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4d127ec5-5826-45d9-b57f-90c0b3095863'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Kennst du mich?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d127ec5-5826-45d9-b57f-90c0b3095863'
);


-- Op. 382 폴카 <Pariser-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Pariser-Polka>', 'Polka française <Pariser-Polka>', 'song', 'Op. 382', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Pariser-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02121648-2785-4736-bda1-183af10d76d1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '02121648-2785-4736-bda1-183af10d76d1'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Pariser-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02121648-2785-4736-bda1-183af10d76d1'
);


-- Op. 383 폴카 <Nur fort>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Nur fort>', 'Polka schnell <Nur fort>', 'song', 'Op. 383', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Nur fort>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be5cce52-43ce-4898-b9a3-0ea12e03f143'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be5cce52-43ce-4898-b9a3-0ea12e03f143'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Nur fort>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be5cce52-43ce-4898-b9a3-0ea12e03f143'
);


-- Op. 384 카드리유 <Opern-Maskenball-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Opern-Maskenball-Quadrille>', 'Quadrille <Opern-Maskenball-Quadrille>', 'song', 'Op. 384', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Opern-Maskenball-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2952ae2f-993b-4992-99a7-5d2c0447f76e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2952ae2f-993b-4992-99a7-5d2c0447f76e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Opern-Maskenball-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2952ae2f-993b-4992-99a7-5d2c0447f76e'
);


-- Op. 385 폴카 마주르카 <Waldine>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Waldine>', 'Polka-Mazurka <Waldine>', 'song', 'Op. 385', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Waldine>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a450878-ccec-42c3-a9dd-7da930379277'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8a450878-ccec-42c3-a9dd-7da930379277'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Waldine>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a450878-ccec-42c3-a9dd-7da930379277'
);


-- Op. 386 폴카 <Frisch heran>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Frisch heran>', 'Polka schnell <Frisch heran>', 'song', 'Op. 386', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Frisch heran>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccfa720b-c872-47d3-bb7e-27cbe7ea250b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ccfa720b-c872-47d3-bb7e-27cbe7ea250b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Frisch heran>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccfa720b-c872-47d3-bb7e-27cbe7ea250b'
);


-- Op. 387 왈츠 <Ins Centrum>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Ins Centrum>', 'Waltz <Ins Centrum>', 'song', 'Op. 387', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Ins Centrum>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '649e89d4-59fb-4b42-a15e-c7f81ce3b4d3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '649e89d4-59fb-4b42-a15e-c7f81ce3b4d3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Ins Centrum>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '649e89d4-59fb-4b42-a15e-c7f81ce3b4d3'
);


-- Op. 388 왈츠 <남국의 장미>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <남국의 장미>', 'Waltz <Roses from the South>', 'song', 'Op. 388', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <남국의 장미>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2eb55386-e1b9-37d0-97fc-769b50fd2066'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2eb55386-e1b9-37d0-97fc-769b50fd2066'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <남국의 장미>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2eb55386-e1b9-37d0-97fc-769b50fd2066'
);


-- Op. 389 폴카 <Burschenwanderung>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Burschenwanderung>', 'Polka française <Burschenwanderung>', 'song', 'Op. 389', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Burschenwanderung>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aced9451-b8db-4295-bfb9-e5a59e1b185e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aced9451-b8db-4295-bfb9-e5a59e1b185e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Burschenwanderung>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aced9451-b8db-4295-bfb9-e5a59e1b185e'
);


-- Op. 390 왈츠 <Nordseebilder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Nordseebilder>', 'Waltz <Nordseebilder>', 'song', 'Op. 390', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Nordseebilder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2a6c78a-77a5-403d-9633-46f2db6830bd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b2a6c78a-77a5-403d-9633-46f2db6830bd'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Nordseebilder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2a6c78a-77a5-403d-9633-46f2db6830bd'
);


-- Op. 391 가보트 <Gavotte der Königin>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가보트 <Gavotte der Königin>', 'Gavotte <Gavotte der Königin>', 'song', 'Op. 391', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가보트 <Gavotte der Königin>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38a950fb-3239-482a-9239-f2f6ceb1e60b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38a950fb-3239-482a-9239-f2f6ceb1e60b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '가보트 <Gavotte der Königin>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38a950fb-3239-482a-9239-f2f6ceb1e60b'
);


-- Op. 392 카드리유 <Spitzentuch-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Spitzentuch-Quadrille>', 'Quadrille <Spitzentuch-Quadrille>', 'song', 'Op. 392', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Spitzentuch-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7e2b5ea-ac75-49ba-82df-f52cb34e8cfc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e7e2b5ea-ac75-49ba-82df-f52cb34e8cfc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Spitzentuch-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7e2b5ea-ac75-49ba-82df-f52cb34e8cfc'
);


-- Op. 393 폴카 <Stürmisch in Lieb' und Tanz>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Stürmisch in Lieb'' und Tanz>', 'Polka schnell <Stürmisch in Lieb'' und Tanz>', 'song', 'Op. 393', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Stürmisch in Lieb'' und Tanz>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ba1c27a-559e-4c39-b06c-b4c43e178fb9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5ba1c27a-559e-4c39-b06c-b4c43e178fb9'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Stürmisch in Lieb'' und Tanz>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ba1c27a-559e-4c39-b06c-b4c43e178fb9'
);


-- Op. 394 폴카 마주르카 <Liebchen schwing Dich>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Liebchen schwing Dich>', 'Polka-Mazurka <Liebchen schwing Dich>', 'song', 'Op. 394', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Liebchen schwing Dich>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f968772-0306-42c5-b0eb-15eae552eeff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6f968772-0306-42c5-b0eb-15eae552eeff'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Liebchen schwing Dich>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f968772-0306-42c5-b0eb-15eae552eeff'
);


-- Op. 395 왈츠 <Myrthenblüthen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Myrthenblüthen>', 'Waltz <Myrthenblüthen>', 'song', 'Op. 395', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Myrthenblüthen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f82d3f18-b904-4902-914a-8779798eb037'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f82d3f18-b904-4902-914a-8779798eb037'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Myrthenblüthen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f82d3f18-b904-4902-914a-8779798eb037'
);


-- Op. 396 행진곡 <Jubelfest-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Jubelfest-Marsch>', 'March <Jubelfest-Marsch>', 'song', 'Op. 396', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Jubelfest-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e285462-c2ed-4afa-adec-1b53c9f014b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e285462-c2ed-4afa-adec-1b53c9f014b3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Jubelfest-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e285462-c2ed-4afa-adec-1b53c9f014b3'
);


-- Op. 397 행진곡 <Der lustige Krieg>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Der lustige Krieg>', 'March <Der lustige Krieg>', 'song', 'Op. 397', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Der lustige Krieg>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5bea512-bece-46e3-91fd-3087ab88da45'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a5bea512-bece-46e3-91fd-3087ab88da45'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Der lustige Krieg>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5bea512-bece-46e3-91fd-3087ab88da45'
);


-- Op. 398 행진곡 <Frisch ins Feld>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Frisch ins Feld>', 'March <Frisch ins Feld>', 'song', 'Op. 398', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Frisch ins Feld>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b47b3b99-31e4-4e46-9f32-a3c360127c05'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b47b3b99-31e4-4e46-9f32-a3c360127c05'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Frisch ins Feld>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b47b3b99-31e4-4e46-9f32-a3c360127c05'
);


-- Op. 399 폴카 <Was sich liebt, neckt sich>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Was sich liebt, neckt sich>', 'Polka française <Was sich liebt, neckt sich>', 'song', 'Op. 399', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Was sich liebt, neckt sich>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '896d633a-619e-460a-9cf7-35e1be94c6e0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '896d633a-619e-460a-9cf7-35e1be94c6e0'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Was sich liebt, neckt sich>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '896d633a-619e-460a-9cf7-35e1be94c6e0'
);


-- Op. 400 왈츠 <Kuß-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Kuß-Walzer>', 'Waltz <Kuß-Walzer>', 'song', 'Op. 400', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Kuß-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5fe886d9-e47c-4924-bcf7-a4aacfc16d56'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5fe886d9-e47c-4924-bcf7-a4aacfc16d56'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Kuß-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5fe886d9-e47c-4924-bcf7-a4aacfc16d56'
);


-- Op. 401 폴카 마주르카 <Der Klügere gibt nach>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Der Klügere gibt nach>', 'Polka-Mazurka <Der Klügere gibt nach>', 'song', 'Op. 401', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Der Klügere gibt nach>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef2d86ca-5aa9-4180-b72a-3c110ae8d5f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ef2d86ca-5aa9-4180-b72a-3c110ae8d5f1'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Der Klügere gibt nach>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef2d86ca-5aa9-4180-b72a-3c110ae8d5f1'
);


-- Op. 402 카드리유 <Der lustige Krieg>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Der lustige Krieg>', 'Quadrille <Der lustige Krieg>', 'song', 'Op. 402', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Der lustige Krieg>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3283f151-594a-4a3e-b9bb-b00f1d8efec0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3283f151-594a-4a3e-b9bb-b00f1d8efec0'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Der lustige Krieg>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3283f151-594a-4a3e-b9bb-b00f1d8efec0'
);


-- Op. 403 폴카 <Entweder – oder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Entweder – oder>', 'Polka schnell <Entweder – oder>', 'song', 'Op. 403', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Entweder – oder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa7165e0-a8eb-41f7-a60c-6e082638159b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fa7165e0-a8eb-41f7-a60c-6e082638159b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Entweder – oder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa7165e0-a8eb-41f7-a60c-6e082638159b'
);


-- Op. 404 폴카 <Violetta>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Violetta>', 'Polka française <Violetta>', 'song', 'Op. 404', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Violetta>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a879dfc4-6867-43cc-91f8-2342e5bb7146'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a879dfc4-6867-43cc-91f8-2342e5bb7146'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Violetta>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a879dfc4-6867-43cc-91f8-2342e5bb7146'
);


-- Op. 405 폴카 마주르카 <Nord und Süd>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Nord und Süd>', 'Polka-Mazurka <Nord und Süd>', 'song', 'Op. 405', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Nord und Süd>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '916057fe-19ca-4cfa-bed3-3dd98002115b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '916057fe-19ca-4cfa-bed3-3dd98002115b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Nord und Süd>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '916057fe-19ca-4cfa-bed3-3dd98002115b'
);


-- Op. 406 행진곡 <Matador-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Matador-Marsch>', 'March <Matador-Marsch>', 'song', 'Op. 406', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Matador-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73e15315-0e0c-4bbc-83a6-83295d44dd62'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '73e15315-0e0c-4bbc-83a6-83295d44dd62'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Matador-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73e15315-0e0c-4bbc-83a6-83295d44dd62'
);


-- Op. 407 왈츠 <Italienischer Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Italienischer Walzer>', 'Waltz <Italienischer Walzer>', 'song', 'Op. 407', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Italienischer Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc040104-6edd-4937-bce2-c85eb446e00b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cc040104-6edd-4937-bce2-c85eb446e00b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Italienischer Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc040104-6edd-4937-bce2-c85eb446e00b'
);


-- Op. 408 행진곡 <Habsburg hoch!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Habsburg hoch!>', 'March <Habsburg hoch!>', 'song', 'Op. 408', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Habsburg hoch!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '038ffa41-6f8c-4a19-aff2-f328728fbee8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '038ffa41-6f8c-4a19-aff2-f328728fbee8'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Habsburg hoch!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '038ffa41-6f8c-4a19-aff2-f328728fbee8'
);


-- Op. 409 폴카 <Rasch in der That>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Rasch in der That>', 'Polka schnell <Rasch in der That>', 'song', 'Op. 409', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Rasch in der That>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b250d4e6-97c8-46b6-b706-dad28234a157'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b250d4e6-97c8-46b6-b706-dad28234a157'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Rasch in der That>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b250d4e6-97c8-46b6-b706-dad28234a157'
);


-- Op. 410 왈츠 <봄의 소리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <봄의 소리>', 'Waltz <Voices of Spring>', 'song', 'Op. 410', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <봄의 소리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b42a2d27-bbb3-3e5f-9ae7-9e4201331351'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b42a2d27-bbb3-3e5f-9ae7-9e4201331351'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <봄의 소리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b42a2d27-bbb3-3e5f-9ae7-9e4201331351'
);


-- Op. 411 왈츠 <Lagunen-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Lagunen-Walzer>', 'Waltz <Lagunen-Walzer>', 'song', 'Op. 411', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Lagunen-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ddd082b1-083e-43d3-889b-136acb97bb93'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ddd082b1-083e-43d3-889b-136acb97bb93'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Lagunen-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ddd082b1-083e-43d3-889b-136acb97bb93'
);


-- Op. 412 폴카 <Pappacoda-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Pappacoda-Polka>', 'Polka française <Pappacoda-Polka>', 'song', 'Op. 412', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Pappacoda-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9be1c1ad-1ef5-4c9c-9ea2-179fc5d8858e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9be1c1ad-1ef5-4c9c-9ea2-179fc5d8858e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Pappacoda-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9be1c1ad-1ef5-4c9c-9ea2-179fc5d8858e'
);


-- Op. 413 폴카 <So ängstlich sind wir nicht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <So ängstlich sind wir nicht>', 'Polka schnell <So ängstlich sind wir nicht>', 'song', 'Op. 413', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <So ängstlich sind wir nicht>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '780ffd4e-d418-4a29-a2e7-5b4bb2e64e0a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '780ffd4e-d418-4a29-a2e7-5b4bb2e64e0a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <So ängstlich sind wir nicht>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '780ffd4e-d418-4a29-a2e7-5b4bb2e64e0a'
);


-- Op. 414 폴카 <Die Tauben von San Marco>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Die Tauben von San Marco>', 'Polka française <Die Tauben von San Marco>', 'song', 'Op. 414', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Die Tauben von San Marco>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47b8ae27-0dd1-48d1-9346-84867d8f16bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47b8ae27-0dd1-48d1-9346-84867d8f16bf'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Die Tauben von San Marco>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47b8ae27-0dd1-48d1-9346-84867d8f16bf'
);


-- Op. 415 폴카 마주르카 <Annina>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Annina>', 'Polka-Mazurka <Annina>', 'song', 'Op. 415', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Annina>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09853913-58de-4435-90f1-d0c5da6b6fe7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09853913-58de-4435-90f1-d0c5da6b6fe7'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Annina>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09853913-58de-4435-90f1-d0c5da6b6fe7'
);


-- Op. 416 카드리유 <베네치아의 하룻밤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <베네치아의 하룻밤>', 'Quadrille <Eine Nacht in Venedig>', 'song', 'Op. 416', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <베네치아의 하룻밤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c351c59d-69aa-4409-9a66-3402536ce3c1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c351c59d-69aa-4409-9a66-3402536ce3c1'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <베네치아의 하룻밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c351c59d-69aa-4409-9a66-3402536ce3c1'
);


-- Op. 417 폴카 <Brautschau-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Brautschau-Polka>', 'Polka française <Brautschau-Polka>', 'song', 'Op. 417', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Brautschau-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '021eb43a-6b06-4fd8-847b-23201210973d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '021eb43a-6b06-4fd8-847b-23201210973d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Brautschau-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '021eb43a-6b06-4fd8-847b-23201210973d'
);


-- Op. 418 보물 왈츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '보물 왈츠', 'Treasure Waltz', 'song', 'Op. 418', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '보물 왈츠'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a498219-a200-3402-93ca-1ea4b9d83a60'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a498219-a200-3402-93ca-1ea4b9d83a60'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '보물 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a498219-a200-3402-93ca-1ea4b9d83a60'
);


-- Op. 419 폴카 <Kriegsabenteuer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Kriegsabenteuer>', 'Polka schnell <Kriegsabenteuer>', 'song', 'Op. 419', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Kriegsabenteuer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62a5de29-33b2-41c9-a3c7-8e2b9dfb14d0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '62a5de29-33b2-41c9-a3c7-8e2b9dfb14d0'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Kriegsabenteuer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62a5de29-33b2-41c9-a3c7-8e2b9dfb14d0'
);


-- Op. 420 폴카 마주르카 <Die Wahrsagerin>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Die Wahrsagerin>', 'Polka-Mazurka <Die Wahrsagerin>', 'song', 'Op. 420', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Die Wahrsagerin>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '973f333a-3b0d-4097-adaf-8aa1c7343192'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '973f333a-3b0d-4097-adaf-8aa1c7343192'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Die Wahrsagerin>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '973f333a-3b0d-4097-adaf-8aa1c7343192'
);


-- Op. 421 폴카 <Husaren-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Husaren-Polka>', 'Polka <Husaren-Polka>', 'song', 'Op. 421', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Husaren-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c661dc4f-1f3e-4254-a003-781c510e75dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c661dc4f-1f3e-4254-a003-781c510e75dc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Husaren-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c661dc4f-1f3e-4254-a003-781c510e75dc'
);


-- Op. 422 카드리유 <Zigeunerbaron-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Zigeunerbaron-Quadrille>', 'Quadrille <Zigeunerbaron-Quadrille>', 'song', 'Op. 422', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Zigeunerbaron-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b47fbab-d544-4df8-9aba-0607f41c4224'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1b47fbab-d544-4df8-9aba-0607f41c4224'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Zigeunerbaron-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b47fbab-d544-4df8-9aba-0607f41c4224'
);


-- Op. 423 왈츠 <Wiener Frauen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Wiener Frauen>', 'Waltz <Wiener Frauen>', 'song', 'Op. 423', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Wiener Frauen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f021f94-e67e-49a7-a9f5-e50666ca8182'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8f021f94-e67e-49a7-a9f5-e50666ca8182'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Wiener Frauen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f021f94-e67e-49a7-a9f5-e50666ca8182'
);


-- Op. 424 왈츠 <Adelen-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Adelen-Walzer>', 'Waltz <Adelen-Walzer>', 'song', 'Op. 424', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Adelen-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83495aea-3825-41a1-8635-9d43d87cd96d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '83495aea-3825-41a1-8635-9d43d87cd96d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Adelen-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83495aea-3825-41a1-8635-9d43d87cd96d'
);


-- Op. 425 폴카 마주르카 <An der Wolga>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <An der Wolga>', 'Polka-Mazurka <An der Wolga>', 'song', 'Op. 425', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <An der Wolga>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9bb2ff2-aa91-4775-a342-e48e1540b131'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9bb2ff2-aa91-4775-a342-e48e1540b131'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <An der Wolga>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9bb2ff2-aa91-4775-a342-e48e1540b131'
);


-- Op. 426 행진곡 <Russischer Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Russischer Marsch>', 'March <Russischer Marsch>', 'song', 'Op. 426', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Russischer Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe28fb30-1a48-487c-8dfc-bdff750cc6f2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fe28fb30-1a48-487c-8dfc-bdff750cc6f2'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Russischer Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe28fb30-1a48-487c-8dfc-bdff750cc6f2'
);


-- Op. 427 왈츠 <Donauweibchen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Donauweibchen>', 'Waltz <Donauweibchen>', 'song', 'Op. 427', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Donauweibchen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ea5f433-c381-4766-8707-f0c6692da3ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5ea5f433-c381-4766-8707-f0c6692da3ee'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Donauweibchen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ea5f433-c381-4766-8707-f0c6692da3ee'
);


-- Op. 428 행진곡 <Reitermarsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Reitermarsch>', 'March <Reitermarsch>', 'song', 'Op. 428', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Reitermarsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0abadd7c-c1f7-49f5-8a75-63f0af3b95f0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0abadd7c-c1f7-49f5-8a75-63f0af3b95f0'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Reitermarsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0abadd7c-c1f7-49f5-8a75-63f0af3b95f0'
);


-- Op. 429 카드리유 <Simplicius-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Simplicius-Quadrille>', 'Quadrille <Simplicius-Quadrille>', 'song', 'Op. 429', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Simplicius-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2df98b7-35f5-4cc0-b633-401f94bc6cb4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c2df98b7-35f5-4cc0-b633-401f94bc6cb4'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Simplicius-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2df98b7-35f5-4cc0-b633-401f94bc6cb4'
);


-- Op. 430 폴카 <Soldatenspiel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Soldatenspiel>', 'Polka française <Soldatenspiel>', 'song', 'Op. 430', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Soldatenspiel>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e38e1846-8b57-4def-9343-6fbc3a46b13f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e38e1846-8b57-4def-9343-6fbc3a46b13f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Soldatenspiel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e38e1846-8b57-4def-9343-6fbc3a46b13f'
);


-- Op. 431 폴카 마주르카 <Lagerlust>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Lagerlust>', 'Polka-Mazurka <Lagerlust>', 'song', 'Op. 431', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Lagerlust>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '817a9e78-bde3-4e55-9d08-d62e1c3216e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '817a9e78-bde3-4e55-9d08-d62e1c3216e1'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Lagerlust>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '817a9e78-bde3-4e55-9d08-d62e1c3216e1'
);


-- Op. 432 폴카 <Muthig Voran>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Muthig Voran>', 'Polka schnell <Muthig Voran>', 'song', 'Op. 432', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Muthig Voran>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd43e8c24-f76d-47fa-b96a-ca73db96064e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd43e8c24-f76d-47fa-b96a-ca73db96064e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Muthig Voran>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd43e8c24-f76d-47fa-b96a-ca73db96064e'
);


-- Op. 433 행진곡 <Spanischer Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Spanischer Marsch>', 'March <Spanischer Marsch>', 'song', 'Op. 433', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Spanischer Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92cc7fab-bad3-451c-b509-bd4e1af2caf0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '92cc7fab-bad3-451c-b509-bd4e1af2caf0'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Spanischer Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92cc7fab-bad3-451c-b509-bd4e1af2caf0'
);


-- Op. 434 왈츠 <Kaiser-Jubiläum>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Kaiser-Jubiläum>', 'Waltz <Kaiser-Jubiläum>', 'song', 'Op. 434', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Kaiser-Jubiläum>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1beb9b03-aaf2-48af-bccf-0287787c2317'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1beb9b03-aaf2-48af-bccf-0287787c2317'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Kaiser-Jubiläum>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1beb9b03-aaf2-48af-bccf-0287787c2317'
);


-- Op. 435 왈츠 <Sinnen und Minnen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Sinnen und Minnen>', 'Waltz <Sinnen und Minnen>', 'song', 'Op. 435', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Sinnen und Minnen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6134caa7-b06b-45d1-87e8-60b89ec1ce2b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6134caa7-b06b-45d1-87e8-60b89ec1ce2b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Sinnen und Minnen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6134caa7-b06b-45d1-87e8-60b89ec1ce2b'
);


-- Op. 436 폴카 <Auf zum Tanze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Auf zum Tanze>', 'Polka schnell <Auf zum Tanze>', 'song', 'Op. 436', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Auf zum Tanze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3a27678-271d-4f72-b31f-34b071ff3897'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e3a27678-271d-4f72-b31f-34b071ff3897'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Auf zum Tanze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3a27678-271d-4f72-b31f-34b071ff3897'
);


-- Op. 437 황제 왈츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '황제 왈츠', 'Emperor Waltz', 'song', 'Op. 437', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '황제 왈츠'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17c5bf4e-cf3a-3c9a-b127-5b62662a991e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17c5bf4e-cf3a-3c9a-b127-5b62662a991e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '황제 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17c5bf4e-cf3a-3c9a-b127-5b62662a991e'
);


-- Op. 438 왈츠 <Rathausball-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Rathausball-Tänze>', 'Waltz <Rathausball-Tänze>', 'song', 'Op. 438', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Rathausball-Tänze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb7d848c-1d79-4a30-a90c-93d41a879981'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fb7d848c-1d79-4a30-a90c-93d41a879981'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Rathausball-Tänze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb7d848c-1d79-4a30-a90c-93d41a879981'
);


-- Op. 439 폴카 <Durchs Telephon>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Durchs Telephon>', 'Polka <Durchs Telephon>', 'song', 'Op. 439', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Durchs Telephon>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a59573c-748c-34e6-b919-873b41b6d3a0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6a59573c-748c-34e6-b919-873b41b6d3a0'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Durchs Telephon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a59573c-748c-34e6-b919-873b41b6d3a0'
);


-- Op. 440 왈츠 <Groß-Wien>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Groß-Wien>', 'Waltz <Groß-Wien>', 'song', 'Op. 440', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Groß-Wien>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11e33a85-64db-4f59-8fc5-6ee215f2e7fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '11e33a85-64db-4f59-8fc5-6ee215f2e7fb'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Groß-Wien>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11e33a85-64db-4f59-8fc5-6ee215f2e7fb'
);


-- Op. 442 폴카 마주르카 <Unparteiische Kritiken>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Unparteiische Kritiken>', 'Polka-Mazurka <Unparteiische Kritiken>', 'song', 'Op. 442', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Unparteiische Kritiken>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a3efe6d-bc38-4829-825c-405ee000d092'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0a3efe6d-bc38-4829-825c-405ee000d092'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Unparteiische Kritiken>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a3efe6d-bc38-4829-825c-405ee000d092'
);


-- Op. 443 왈츠 <Seid umschlungen, Millionen!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Seid umschlungen, Millionen!>', 'Waltz <Seid umschlungen, Millionen!>', 'song', 'Op. 443', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Seid umschlungen, Millionen!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'deb11247-951d-3155-a660-cd8a39dbbf12'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'deb11247-951d-3155-a660-cd8a39dbbf12'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Seid umschlungen, Millionen!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'deb11247-951d-3155-a660-cd8a39dbbf12'
);


-- Op. 444 왈츠 <Märchen aus dem Orient>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Märchen aus dem Orient>', 'Waltz <Märchen aus dem Orient>', 'song', 'Op. 444', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Märchen aus dem Orient>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a969c539-fd63-447a-8f93-710cc794b7da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a969c539-fd63-447a-8f93-710cc794b7da'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Märchen aus dem Orient>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a969c539-fd63-447a-8f93-710cc794b7da'
);


-- Op. 445 폴카 <Herzenskönigin>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Herzenskönigin>', 'Polka française <Herzenskönigin>', 'song', 'Op. 445', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Herzenskönigin>'
);


-- Op. 445 왈츠 <Ninetta-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Ninetta-Walzer>', 'Waltz <Ninetta-Walzer>', 'song', 'Op. 445', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Ninetta-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '507e7342-5da6-4d99-9d5b-d78ed403b929'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '507e7342-5da6-4d99-9d5b-d78ed403b929'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Ninetta-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '507e7342-5da6-4d99-9d5b-d78ed403b929'
);


-- Op. 446 카드리유 <Ninetta-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Ninetta-Quadrille>', 'Quadrille <Ninetta-Quadrille>', 'song', 'Op. 446', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Ninetta-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7b177f8-c5be-4ccf-9758-d9ec00287d34'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b7b177f8-c5be-4ccf-9758-d9ec00287d34'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Ninetta-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7b177f8-c5be-4ccf-9758-d9ec00287d34'
);


-- Op. 447 행진곡 <Ninetta-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Ninetta-Marsch>', 'March <Ninetta-Marsch>', 'song', 'Op. 447', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Ninetta-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4670857d-e195-4970-b8b0-bfdc46581a23'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4670857d-e195-4970-b8b0-bfdc46581a23'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Ninetta-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4670857d-e195-4970-b8b0-bfdc46581a23'
);


-- Op. 448 폴카 <Diplomaten-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Diplomaten-Polka>', 'Polka <Diplomaten-Polka>', 'song', 'Op. 448', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Diplomaten-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1ec97b1-257c-4622-b2f2-295837cc1efc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e1ec97b1-257c-4622-b2f2-295837cc1efc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Diplomaten-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1ec97b1-257c-4622-b2f2-295837cc1efc'
);


-- Op. 449 새 피치카토 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '새 피치카토 폴카', 'Neue Pizzicato-Polka', 'song', 'Op. 449', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '새 피치카토 폴카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f45f0f23-c54b-413d-ab2a-e1e922dc2602'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f45f0f23-c54b-413d-ab2a-e1e922dc2602'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '새 피치카토 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f45f0f23-c54b-413d-ab2a-e1e922dc2602'
);


-- Op. 450 갤럽 <Ninetta-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Ninetta-Galopp>', 'Galop <Ninetta-Galopp>', 'song', 'Op. 450', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Ninetta-Galopp>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad8d2b9a-c2f9-4a93-bfa7-706413f87c8a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ad8d2b9a-c2f9-4a93-bfa7-706413f87c8a'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '갤럽 <Ninetta-Galopp>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad8d2b9a-c2f9-4a93-bfa7-706413f87c8a'
);


-- Op. 452 행진곡 <Fest-Marsch> Op. 452

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Fest-Marsch> Op. 452', 'March <Fest-Marsch>, Op. 452', 'song', NULL, 'Op.', '452', 1893, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Fest-Marsch> Op. 452'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '12b132ec-79a3-4369-8deb-4d121a9f54e0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '12b132ec-79a3-4369-8deb-4d121a9f54e0'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Fest-Marsch> Op. 452' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '12b132ec-79a3-4369-8deb-4d121a9f54e0'
);


-- Op. 453 왈츠 <Hochzeitsreigen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Hochzeitsreigen>', 'Waltz <Hochzeitsreigen>', 'song', 'Op. 453', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Hochzeitsreigen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed8a57ad-6e6f-42e7-84fc-f84b50a24c05'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed8a57ad-6e6f-42e7-84fc-f84b50a24c05'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Hochzeitsreigen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed8a57ad-6e6f-42e7-84fc-f84b50a24c05'
);


-- Op. 454 관현악곡 <Auf dem Tanzboden>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악곡 <Auf dem Tanzboden>', 'Orchestral piece <Auf dem Tanzboden>', 'song', 'Op. 454', NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악곡 <Auf dem Tanzboden>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e20e3e8-00d6-4331-80cd-3eed5d5c3ce5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0e20e3e8-00d6-4331-80cd-3eed5d5c3ce5'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '관현악곡 <Auf dem Tanzboden>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e20e3e8-00d6-4331-80cd-3eed5d5c3ce5'
);


-- Op. 455 왈츠 <Ich bin dir gut!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Ich bin dir gut!>', 'Waltz <Ich bin dir gut!>', 'song', 'Op. 455', NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Ich bin dir gut!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a602b31b-ec3c-4f51-8928-1e78503c47b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a602b31b-ec3c-4f51-8928-1e78503c47b3'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Ich bin dir gut!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a602b31b-ec3c-4f51-8928-1e78503c47b3'
);


-- Op. 456 행진곡 <Živio!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Živio!>', 'March <Živio!>', 'song', 'Op. 456', NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Živio!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1cd4c7b3-5889-4b61-b157-43ebac4c9042'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1cd4c7b3-5889-4b61-b157-43ebac4c9042'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Živio!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1cd4c7b3-5889-4b61-b157-43ebac4c9042'
);


-- Op. 457 폴카 <Das Comitat geht in die Höh!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Das Comitat geht in die Höh!>', 'Polka schnell <Das Comitat geht in die Höh!>', 'song', 'Op. 457', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Das Comitat geht in die Höh!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '760732c0-0a3b-42a5-ad41-f1a08ef31edc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '760732c0-0a3b-42a5-ad41-f1a08ef31edc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Das Comitat geht in die Höh!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '760732c0-0a3b-42a5-ad41-f1a08ef31edc'
);


-- Op. 458 폴카 <Tanze mit dem Besenstiel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Tanze mit dem Besenstiel>', 'Polka française <Tanze mit dem Besenstiel>', 'song', 'Op. 458', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Tanze mit dem Besenstiel>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e5e1bed-7b7f-42e3-beed-7de894b16a73'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6e5e1bed-7b7f-42e3-beed-7de894b16a73'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Tanze mit dem Besenstiel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e5e1bed-7b7f-42e3-beed-7de894b16a73'
);


-- Op. 459 폴카 마주르카 <Sonnenblume>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Sonnenblume>', 'Polka-Mazurka <Sonnenblume>', 'song', 'Op. 459', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Sonnenblume>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1584035c-7019-45d2-8f6f-8542914ac80c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1584035c-7019-45d2-8f6f-8542914ac80c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Sonnenblume>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1584035c-7019-45d2-8f6f-8542914ac80c'
);


-- Op. 460 카드리유 <Jabuka-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Jabuka-Quadrille>', 'Quadrille <Jabuka-Quadrille>', 'song', 'Op. 460', NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Jabuka-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '26b65465-37c6-4cb9-a9d3-c32fb37c6151'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '26b65465-37c6-4cb9-a9d3-c32fb37c6151'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Jabuka-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '26b65465-37c6-4cb9-a9d3-c32fb37c6151'
);


-- Op. 461 왈츠 <Gartenlaube-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Gartenlaube-Walzer>', 'Waltz <Gartenlaube-Walzer>', 'song', 'Op. 461', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Gartenlaube-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3cb61c39-024d-4b0b-b586-76acd96bba14'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3cb61c39-024d-4b0b-b586-76acd96bba14'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Gartenlaube-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3cb61c39-024d-4b0b-b586-76acd96bba14'
);


-- Op. 462 왈츠 <Klug Gretelein>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Klug Gretelein>', 'Waltz <Klug Gretelein>', 'song', 'Op. 462', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Klug Gretelein>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09edd652-9c75-4b2e-a480-5eb4d7b5a222'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09edd652-9c75-4b2e-a480-5eb4d7b5a222'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Klug Gretelein>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09edd652-9c75-4b2e-a480-5eb4d7b5a222'
);


-- Op. 463 왈츠 <Trau, schau, wem!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Trau, schau, wem!>', 'Waltz <Trau, schau, wem!>', 'song', 'Op. 463', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Trau, schau, wem!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d40d4fc-fe6b-4031-86b7-b695887397cd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3d40d4fc-fe6b-4031-86b7-b695887397cd'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Trau, schau, wem!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d40d4fc-fe6b-4031-86b7-b695887397cd'
);


-- Op. 464 폴카 <Herrjemineh>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Herrjemineh>', 'Polka française <Herrjemineh>', 'song', 'Op. 464', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Herrjemineh>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2dd0bd5-e596-4c99-b852-7bf2a02218fa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c2dd0bd5-e596-4c99-b852-7bf2a02218fa'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Herrjemineh>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2dd0bd5-e596-4c99-b852-7bf2a02218fa'
);


-- Op. 465 폴카 마주르카 <Liebe und Ehe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Liebe und Ehe>', 'Polka-Mazurka <Liebe und Ehe>', 'song', 'Op. 465', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Liebe und Ehe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '965a3489-8562-4061-854d-f478e82719fa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '965a3489-8562-4061-854d-f478e82719fa'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Liebe und Ehe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '965a3489-8562-4061-854d-f478e82719fa'
);


-- Op. 466 갤럽 <Klipp-Klapp-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Klipp-Klapp-Galopp>', 'Galop <Klipp-Klapp-Galopp>', 'song', 'Op. 466', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Klipp-Klapp-Galopp>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46a77717-f0ae-4032-818c-e92bc77092f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '46a77717-f0ae-4032-818c-e92bc77092f6'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '갤럽 <Klipp-Klapp-Galopp>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46a77717-f0ae-4032-818c-e92bc77092f6'
);


-- Op. 467 행진곡 <Es war so wunderschön>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Es war so wunderschön>', 'March <Es war so wunderschön>', 'song', 'Op. 467', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Es war so wunderschön>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd371d355-7d4d-4324-b6e8-adf3506f5e62'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd371d355-7d4d-4324-b6e8-adf3506f5e62'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Es war so wunderschön>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd371d355-7d4d-4324-b6e8-adf3506f5e62'
);


-- Op. 468 카드리유 <Waldmeister-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Waldmeister-Quadrille>', 'Quadrille <Waldmeister-Quadrille>', 'song', 'Op. 468', NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Waldmeister-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c422519c-b2db-4268-9194-15e8b2551380'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c422519c-b2db-4268-9194-15e8b2551380'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Waldmeister-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c422519c-b2db-4268-9194-15e8b2551380'
);


-- Op. 469 전주곡 <Hochzeits-Präludium>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 <Hochzeits-Präludium>', 'Prelude <Hochzeits-Präludium>', 'song', 'Op. 469', NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 <Hochzeits-Präludium>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4714f291-cf92-488b-81d1-4d42cd09d757'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4714f291-cf92-488b-81d1-4d42cd09d757'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '전주곡 <Hochzeits-Präludium>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4714f291-cf92-488b-81d1-4d42cd09d757'
);


-- Op. 470 행진곡 <Deutschmeister-Jubiläums-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Deutschmeister-Jubiläums-Marsch>', 'March <Deutschmeister-Jubiläums-Marsch>', 'song', 'Op. 470', NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Deutschmeister-Jubiläums-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54843c32-f541-4ba8-8b4b-cb4df92781ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '54843c32-f541-4ba8-8b4b-cb4df92781ee'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Deutschmeister-Jubiläums-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54843c32-f541-4ba8-8b4b-cb4df92781ee'
);


-- Op. 471 왈츠 <Heut' ist heut'>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Heut'' ist heut''>', 'Waltz <Heut'' ist heut''>', 'song', 'Op. 471', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Heut'' ist heut''>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe4429fe-899f-4050-afb7-e8a93ac9c8d7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fe4429fe-899f-4050-afb7-e8a93ac9c8d7'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <Heut'' ist heut''>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe4429fe-899f-4050-afb7-e8a93ac9c8d7'
);


-- Op. 472 폴카 <Nur nicht mucken>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Nur nicht mucken>', 'Polka française <Nur nicht mucken>', 'song', 'Op. 472', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Nur nicht mucken>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '426f7498-327f-4269-9b24-e398b39b9c59'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '426f7498-327f-4269-9b24-e398b39b9c59'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 <Nur nicht mucken>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '426f7498-327f-4269-9b24-e398b39b9c59'
);


-- Op. 473 행진곡 <Wo uns're Fahne weht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Wo uns''re Fahne weht>', 'March <Wo uns''re Fahne weht>', 'song', 'Op. 473', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Wo uns''re Fahne weht>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e061b22-5e6e-4c34-a1e6-eb836eb2cc1c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0e061b22-5e6e-4c34-a1e6-eb836eb2cc1c'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Wo uns''re Fahne weht>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e061b22-5e6e-4c34-a1e6-eb836eb2cc1c'
);


-- Op. 474 폴카 마주르카 <Da nicken die Giebel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 마주르카 <Da nicken die Giebel>', 'Polka-Mazurka <Da nicken die Giebel>', 'song', 'Op. 474', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 마주르카 <Da nicken die Giebel>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2649269-befa-4641-884d-38aca38bb547'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f2649269-befa-4641-884d-38aca38bb547'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '폴카 마주르카 <Da nicken die Giebel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2649269-befa-4641-884d-38aca38bb547'
);


-- Op. 475 갤럽 <Frisch gewagt>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Frisch gewagt>', 'Galop <Frisch gewagt>', 'song', 'Op. 475', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Frisch gewagt>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dca432b-ece2-42d0-be6d-5dc1e4908ead'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4dca432b-ece2-42d0-be6d-5dc1e4908ead'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '갤럽 <Frisch gewagt>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dca432b-ece2-42d0-be6d-5dc1e4908ead'
);


-- Op. 476 카드리유 <Die Göttin der Vernunft>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Die Göttin der Vernunft>', 'Quadrille <Die Göttin der Vernunft>', 'song', 'Op. 476', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Die Göttin der Vernunft>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cd11d75-c7fb-499d-9c44-282916071695'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4cd11d75-c7fb-499d-9c44-282916071695'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Die Göttin der Vernunft>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cd11d75-c7fb-499d-9c44-282916071695'
);


-- Op. 477 왈츠 <An der Elbe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <An der Elbe>', 'Waltz <An der Elbe>', 'song', 'Op. 477', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <An der Elbe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17786e8c-a9e5-42b8-b3c1-8319a71b3b26'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17786e8c-a9e5-42b8-b3c1-8319a71b3b26'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '왈츠 <An der Elbe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17786e8c-a9e5-42b8-b3c1-8319a71b3b26'
);


-- Op. 478 행진곡 <Auf's Korn>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Auf''s Korn>', 'March <Auf''s Korn>', 'song', 'Op. 478', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Auf''s Korn>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4091ead-f8e4-4f27-890d-7e6d3ee138bc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4091ead-f8e4-4f27-890d-7e6d3ee138bc'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Auf''s Korn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4091ead-f8e4-4f27-890d-7e6d3ee138bc'
);


-- None 오페레타 <Indigo und die vierzig Räuber>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Indigo und die vierzig Räuber>', 'Operetta <Indigo und die vierzig Räuber>', 'song', NULL, NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Indigo und die vierzig Räuber>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bfe7141-1526-4585-b3b0-dbc1c3324e8e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7bfe7141-1526-4585-b3b0-dbc1c3324e8e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페레타 <Indigo und die vierzig Räuber>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bfe7141-1526-4585-b3b0-dbc1c3324e8e'
);


-- None 오페레타 <Der Karneval in Rom>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Der Karneval in Rom>', 'Operetta <Der Karneval in Rom>', 'song', NULL, NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Der Karneval in Rom>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '856070a8-251b-42a6-83ac-a5079fcb17b6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '856070a8-251b-42a6-83ac-a5079fcb17b6'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페레타 <Der Karneval in Rom>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '856070a8-251b-42a6-83ac-a5079fcb17b6'
);


-- None 오페레타 <박쥐>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <박쥐>', 'Operetta <Die Fledermaus>', 'song', NULL, NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <박쥐>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88504b20-f1e2-4316-ad45-347730af6b5f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '88504b20-f1e2-4316-ad45-347730af6b5f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페레타 <박쥐>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88504b20-f1e2-4316-ad45-347730af6b5f'
);


-- None 오페레타 <Cagliostro in Wien>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Cagliostro in Wien>', 'Operetta <Cagliostro in Wien>', 'song', NULL, NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Cagliostro in Wien>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec2e5c9a-3ca2-4bec-a5c9-ec36e90d51f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec2e5c9a-3ca2-4bec-a5c9-ec36e90d51f1'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페레타 <Cagliostro in Wien>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec2e5c9a-3ca2-4bec-a5c9-ec36e90d51f1'
);


-- None 오페레타 <Prinz Methusalem>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Prinz Methusalem>', 'Operetta <Prinz Methusalem>', 'song', NULL, NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Prinz Methusalem>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1533b202-a60e-49f6-86f1-4414abe5559f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1533b202-a60e-49f6-86f1-4414abe5559f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페레타 <Prinz Methusalem>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1533b202-a60e-49f6-86f1-4414abe5559f'
);


-- None 오페레타 <Blindekuh>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Blindekuh>', 'Operetta <Blindekuh>', 'song', NULL, NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Blindekuh>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cbd22a6d-c4fb-4fb4-8b50-8eaf5a3f08bd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cbd22a6d-c4fb-4fb4-8b50-8eaf5a3f08bd'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페레타 <Blindekuh>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cbd22a6d-c4fb-4fb4-8b50-8eaf5a3f08bd'
);


-- None 오페레타 <Das Spitzentuch der Königin>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Das Spitzentuch der Königin>', 'Operetta <Das Spitzentuch der Königin>', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Das Spitzentuch der Königin>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c4627e4-6a2d-431e-9a5d-db58fa5442a1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0c4627e4-6a2d-431e-9a5d-db58fa5442a1'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페레타 <Das Spitzentuch der Königin>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c4627e4-6a2d-431e-9a5d-db58fa5442a1'
);


-- None 오페레타 <Der lustige Krieg>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Der lustige Krieg>', 'Operetta <Der lustige Krieg>', 'song', NULL, NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Der lustige Krieg>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d05b9cb-580b-4100-b50e-9fc4b2c17706'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d05b9cb-580b-4100-b50e-9fc4b2c17706'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페레타 <Der lustige Krieg>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d05b9cb-580b-4100-b50e-9fc4b2c17706'
);


-- None 오페레타 <베네치아의 하룻밤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <베네치아의 하룻밤>', 'Operetta <Eine Nacht in Venedig>', 'song', NULL, NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <베네치아의 하룻밤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cda880ae-461c-46f2-8970-64bba40a78e4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cda880ae-461c-46f2-8970-64bba40a78e4'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페레타 <베네치아의 하룻밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cda880ae-461c-46f2-8970-64bba40a78e4'
);


-- None 오페레타 <집시 남작>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <집시 남작>', 'Operetta <Der Zigeunerbaron>', 'song', NULL, NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <집시 남작>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2d0754e-af96-48e8-959f-6684714ce3bb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f2d0754e-af96-48e8-959f-6684714ce3bb'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페레타 <집시 남작>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2d0754e-af96-48e8-959f-6684714ce3bb'
);


-- None 오페레타 <Simplicius>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Simplicius>', 'Operetta <Simplicius>', 'song', NULL, NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Simplicius>'
);


-- Op. 441 오페라 <Ritter Pázmán>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Ritter Pázmán>', 'Opera <Ritter Pázmán>', 'song', 'Op. 441', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Ritter Pázmán>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '142c729e-d8a3-4be7-abcc-78f09d713361'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '142c729e-d8a3-4be7-abcc-78f09d713361'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페라 <Ritter Pázmán>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '142c729e-d8a3-4be7-abcc-78f09d713361'
);


-- None 오페레타 <Fürstin Ninetta>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Fürstin Ninetta>', 'Operetta <Fürstin Ninetta>', 'song', NULL, NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Fürstin Ninetta>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b411a0dd-3dec-445e-b620-1fd87eb8a38b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b411a0dd-3dec-445e-b620-1fd87eb8a38b'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페레타 <Fürstin Ninetta>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b411a0dd-3dec-445e-b620-1fd87eb8a38b'
);


-- None 오페레타 <Jabuka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Jabuka>', 'Operetta <Jabuka>', 'song', NULL, NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Jabuka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9dd8503-0caa-447e-8db0-b33385168a87'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b9dd8503-0caa-447e-8db0-b33385168a87'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페레타 <Jabuka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9dd8503-0caa-447e-8db0-b33385168a87'
);


-- None 오페레타 <Waldmeister>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Waldmeister>', 'Operetta <Waldmeister>', 'song', NULL, NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Waldmeister>'
);


-- None 오페레타 <Die Göttin der Vernunft>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Die Göttin der Vernunft>', 'Operetta <Die Göttin der Vernunft>', 'song', NULL, NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Die Göttin der Vernunft>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ce35f24-6442-4d77-8dce-839fa03d9366'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7ce35f24-6442-4d77-8dce-839fa03d9366'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '오페레타 <Die Göttin der Vernunft>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ce35f24-6442-4d77-8dce-839fa03d9366'
);


-- None 발레 <Aschenbrödel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <Aschenbrödel>', 'Ballet <Aschenbrödel>', 'song', NULL, NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <Aschenbrödel>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '590271e0-8701-4d12-a315-2ef6c3f32a00'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '590271e0-8701-4d12-a315-2ef6c3f32a00'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '발레 <Aschenbrödel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '590271e0-8701-4d12-a315-2ef6c3f32a00'
);


-- None 왈츠 <Erster Gedanke>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Erster Gedanke>', 'Waltz <Erster Gedanke>', 'song', NULL, NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Erster Gedanke>'
);


-- None 층계송 <Tu qui regis totum orbem>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '층계송 <Tu qui regis totum orbem>', 'Graduale <Tu qui regis totum orbem>', 'song', NULL, NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '층계송 <Tu qui regis totum orbem>'
);


-- None 카드리유 <Hinter den Coulissen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Hinter den Coulissen>', 'Quadrille <Hinter den Coulissen>', 'song', NULL, NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Hinter den Coulissen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f051a23-f793-4108-ac8d-6224d35a03d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f051a23-f793-4108-ac8d-6224d35a03d9'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Hinter den Coulissen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f051a23-f793-4108-ac8d-6224d35a03d9'
);


-- None 행진곡 <Vaterländischer Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Vaterländischer Marsch>', 'March <Vaterländischer Marsch>', 'song', NULL, NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Vaterländischer Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e6daefa-c3e7-4e11-bad0-802bf97ff9a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6e6daefa-c3e7-4e11-bad0-802bf97ff9a6'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Vaterländischer Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e6daefa-c3e7-4e11-bad0-802bf97ff9a6'
);


-- None 로망스 <Sehnsucht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 <Sehnsucht>', 'Romanze <Sehnsucht>', 'song', NULL, NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 <Sehnsucht>'
);


-- None 카드리유 <Monstre-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Monstre-Quadrille>', 'Quadrille <Monstre-Quadrille>', 'song', NULL, NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Monstre-Quadrille>'
);


-- None 포푸리 <Hommage au public russe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '포푸리 <Hommage au public russe>', 'Potpourri <Hommage au public russe>', 'song', NULL, NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '포푸리 <Hommage au public russe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ebfe24f-7a53-4c4d-ad78-9f614f4efc3d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ebfe24f-7a53-4c4d-ad78-9f614f4efc3d'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '포푸리 <Hommage au public russe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ebfe24f-7a53-4c4d-ad78-9f614f4efc3d'
);


-- None 왈츠 <Trifolien>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Trifolien>', 'Waltz <Trifolien>', 'song', NULL, NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Trifolien>'
);


-- None 카드리유 <Schützen-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Schützen-Quadrille>', 'Quadrille <Schützen-Quadrille>', 'song', NULL, NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Schützen-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed2de024-b5c1-41ff-854c-833d456567b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed2de024-b5c1-41ff-854c-833d456567b7'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '카드리유 <Schützen-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed2de024-b5c1-41ff-854c-833d456567b7'
);


-- None 피치카토 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피치카토 폴카', 'Pizzicato Polka', 'song', NULL, NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피치카토 폴카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '270024e8-a12c-379e-8af4-d950d2b72c0e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '270024e8-a12c-379e-8af4-d950d2b72c0e'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '피치카토 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '270024e8-a12c-379e-8af4-d950d2b72c0e'
);


-- None 가곡 <Wenn du ein herzig Liebchen hast>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Wenn du ein herzig Liebchen hast>', 'Song <Wenn du ein herzig Liebchen hast>', 'song', NULL, NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Wenn du ein herzig Liebchen hast>'
);


-- None 행진곡 <Freiwillige vor!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Freiwillige vor!>', 'March <Freiwillige vor!>', 'song', NULL, NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Freiwillige vor!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6510eebd-ab67-4957-af7b-52816b06440f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6510eebd-ab67-4957-af7b-52816b06440f'
FROM pieces p
WHERE p.composer_id = 42 AND p.title = '행진곡 <Freiwillige vor!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6510eebd-ab67-4957-af7b-52816b06440f'
);


-- None 목가 <Auf der Alm>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '목가 <Auf der Alm>', 'Idyll <Auf der Alm>', 'song', NULL, NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '목가 <Auf der Alm>'
);


-- None 행진곡 <Kaiser-Franz-Joseph-Jubiläums-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Kaiser-Franz-Joseph-Jubiläums-Marsch>', 'March <Kaiser-Franz-Joseph-Jubiläums-Marsch>', 'song', NULL, NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Kaiser-Franz-Joseph-Jubiläums-Marsch>'
);


-- None 교향시 <Traumbild I>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <Traumbild I>', 'Symphonic poem <Traumbild I>', 'song', NULL, NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <Traumbild I>'
);


-- None 교향시 <Traumbild II>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <Traumbild II>', 'Symphonic poem <Traumbild II>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <Traumbild II>'
);


-- None 서곡 <Ouverture comique>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <Ouverture comique>', 'Overture <Ouverture comique>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 42
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <Ouverture comique>'
);

