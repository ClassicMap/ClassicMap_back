-- 글루크 작품을 출판 단위로 채운다(카탈로그: Wq.). 작품 47개(묶음 2, 다악장 0, 낱곡 45),
-- 새 작품 44개, 기존 작품 3개, part 16개, 그 아래 0개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   오페라는 part 없이 둔다. 파리 판 <오르페와 외리디스>(Wq. 41)·<알세스트>(Wq. 44)는 번호·언어·대본이 달라 따로 둔다.
--   대목 작품 62·63 은 그대로 둔다. 아리아 몇 곡만 전하는 오페라는 뺀다.
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

-- Wq. 7 오페라 <Ipermestra>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Ipermestra>', 'Ipermestra', 'song', 'Wq. 7', NULL, NULL, 1744, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Ipermestra>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9709d6ed-6ff5-42cf-85e2-2949c38b61dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9709d6ed-6ff5-42cf-85e2-2949c38b61dc'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <Ipermestra>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9709d6ed-6ff5-42cf-85e2-2949c38b61dc'
);


-- Wq. 12 오페라 <Le nozze d'Ercole e d'Ebe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Le nozze d''Ercole e d''Ebe>', 'Le nozze d''Ercole e d''Ebe', 'song', 'Wq. 12', NULL, NULL, 1747, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Le nozze d''Ercole e d''Ebe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7c63092-fdad-4614-a968-c382f0b55513'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a7c63092-fdad-4614-a968-c382f0b55513'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <Le nozze d''Ercole e d''Ebe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7c63092-fdad-4614-a968-c382f0b55513'
);


-- Wq. 13 오페라 <La Semiramide riconosciuta>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <La Semiramide riconosciuta>', 'La Semiramide riconosciuta', 'song', 'Wq. 13', NULL, NULL, 1748, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <La Semiramide riconosciuta>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75c2b803-c095-4721-a076-bfa43827eacc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '75c2b803-c095-4721-a076-bfa43827eacc'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <La Semiramide riconosciuta>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75c2b803-c095-4721-a076-bfa43827eacc'
);


-- Wq. 14 오페라 <La contesa de' numi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <La contesa de'' numi>', 'La contesa de'' numi', 'song', 'Wq. 14', NULL, NULL, 1749, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <La contesa de'' numi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e617d955-e565-4092-ba43-82d2123d1f04'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e617d955-e565-4092-ba43-82d2123d1f04'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <La contesa de'' numi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e617d955-e565-4092-ba43-82d2123d1f04'
);


-- Wq. 15 오페라 <Ezio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Ezio>', 'Ezio', 'song', 'Wq. 15', NULL, NULL, 1750, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Ezio>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08d47948-3856-40e5-9355-e58cdebd795e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '08d47948-3856-40e5-9355-e58cdebd795e'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <Ezio>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08d47948-3856-40e5-9355-e58cdebd795e'
);


-- Wq. 16 오페라 <La clemenza di Tito>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <La clemenza di Tito>', 'La clemenza di Tito', 'song', 'Wq. 16', NULL, NULL, 1752, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <La clemenza di Tito>'
);


-- Wq. 18 오페라 <Le cinesi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Le cinesi>', 'Le cinesi', 'song', 'Wq. 18', NULL, NULL, 1754, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Le cinesi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5ccefa0-b914-41f6-a649-f2760628e88c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5ccefa0-b914-41f6-a649-f2760628e88c'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <Le cinesi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5ccefa0-b914-41f6-a649-f2760628e88c'
);


-- Wq. 19 오페라 <La danza>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <La danza>', 'La danza', 'song', 'Wq. 19', NULL, NULL, 1755, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <La danza>'
);


-- Wq. 20 오페라 <L'innocenza giustificata>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <L''innocenza giustificata>', 'L''innocenza giustificata', 'song', 'Wq. 20', NULL, NULL, 1755, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <L''innocenza giustificata>'
);


-- Wq. 21 오페라 <Antigono>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Antigono>', 'Antigono', 'song', 'Wq. 21', NULL, NULL, 1756, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Antigono>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3e5096a-ad03-49ed-b285-bc54bbe0bb94'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3e5096a-ad03-49ed-b285-bc54bbe0bb94'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <Antigono>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3e5096a-ad03-49ed-b285-bc54bbe0bb94'
);


-- Wq. 22 오페라 <Il re pastore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Il re pastore>', 'Il re pastore', 'song', 'Wq. 22', NULL, NULL, 1756, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Il re pastore>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '715a8225-94d2-4555-8d85-8eb70bca1368'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '715a8225-94d2-4555-8d85-8eb70bca1368'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <Il re pastore>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '715a8225-94d2-4555-8d85-8eb70bca1368'
);


-- Wq. 23 오페라 <L'île de Merlin>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <L''île de Merlin>', 'L''île de Merlin, ou Le monde renversé', 'song', 'Wq. 23', NULL, NULL, 1758, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <L''île de Merlin>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55f87d18-1088-40b4-9bbd-aa49f7bef8cd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '55f87d18-1088-40b4-9bbd-aa49f7bef8cd'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <L''île de Merlin>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55f87d18-1088-40b4-9bbd-aa49f7bef8cd'
);


-- Wq. 24 오페라 <La fausse esclave>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <La fausse esclave>', 'La fausse esclave', 'song', 'Wq. 24', NULL, NULL, 1758, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <La fausse esclave>'
);


-- None 오페라 <Le diable à quatre>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Le diable à quatre>', 'Le diable à quatre, ou La double métamorphose', 'song', NULL, NULL, NULL, 1759, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Le diable à quatre>'
);


-- Wq. 27 오페라 <Tetide>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Tetide>', 'Tetide', 'song', 'Wq. 27', NULL, NULL, 1760, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Tetide>'
);


-- Wq. 28 오페라 <L'ivrogne corrigé>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <L''ivrogne corrigé>', 'L''ivrogne corrigé', 'song', 'Wq. 28', NULL, NULL, 1760, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <L''ivrogne corrigé>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '210b38e9-1edc-4470-b6d9-9b21e30e3b0d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '210b38e9-1edc-4470-b6d9-9b21e30e3b0d'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <L''ivrogne corrigé>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '210b38e9-1edc-4470-b6d9-9b21e30e3b0d'
);


-- Wq. 29 오페라 <Le cadi dupé>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Le cadi dupé>', 'Le cadi dupé', 'song', 'Wq. 29', NULL, NULL, 1761, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Le cadi dupé>'
);


-- Wq. 30 오페라 <오르페오와 에우리디체>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '89d3eaa1-c9b9-4352-97ff-7eac83239623'
FROM pieces p
WHERE p.id = 61 AND p.composer_id = 21
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '89d3eaa1-c9b9-4352-97ff-7eac83239623'
);


-- Wq. 31 오페라 <Il trionfo di Clelia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Il trionfo di Clelia>', 'Il trionfo di Clelia', 'song', 'Wq. 31', NULL, NULL, 1763, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Il trionfo di Clelia>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0cb7b40-d835-4094-b75b-67999bc249cc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0cb7b40-d835-4094-b75b-67999bc249cc'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <Il trionfo di Clelia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0cb7b40-d835-4094-b75b-67999bc249cc'
);


-- Wq. 32 오페라 <La rencontre imprévue>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <La rencontre imprévue>', 'La rencontre imprévue', 'song', 'Wq. 32', NULL, NULL, 1764, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <La rencontre imprévue>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '103da7b4-c017-4573-a17c-d8a521662859'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '103da7b4-c017-4573-a17c-d8a521662859'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <La rencontre imprévue>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '103da7b4-c017-4573-a17c-d8a521662859'
);


-- Wq. 33 오페라 <Il Parnaso confuso>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Il Parnaso confuso>', 'Il Parnaso confuso', 'song', 'Wq. 33', NULL, NULL, 1765, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Il Parnaso confuso>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee36bc38-afb2-470d-afc3-e2e2119d4c03'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ee36bc38-afb2-470d-afc3-e2e2119d4c03'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <Il Parnaso confuso>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee36bc38-afb2-470d-afc3-e2e2119d4c03'
);


-- Wq. 34 오페라 <Telemaco>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Telemaco>', 'Telemaco, ossia L''isola di Circe', 'song', 'Wq. 34', NULL, NULL, 1765, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Telemaco>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ebd6604c-4cea-436d-a502-34ac521ebc55'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ebd6604c-4cea-436d-a502-34ac521ebc55'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <Telemaco>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ebd6604c-4cea-436d-a502-34ac521ebc55'
);


-- Wq. 35 오페라 <La corona>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <La corona>', 'La corona', 'song', 'Wq. 35', NULL, NULL, 1765, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <La corona>'
);


-- Wq. 36 오페라 프롤로그 <Il prologo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 프롤로그 <Il prologo>', 'Il prologo', 'song', 'Wq. 36', NULL, NULL, 1767, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 프롤로그 <Il prologo>'
);


-- Wq. 37 오페라 <알체스테>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f51bdd6a-27d4-492c-ae4d-a76dd47471c1'
FROM pieces p
WHERE p.id = 64 AND p.composer_id = 21
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f51bdd6a-27d4-492c-ae4d-a76dd47471c1'
);


-- Wq. 38 오페라 <Le feste d'Apollo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Le feste d''Apollo>', 'Le feste d''Apollo', 'song', 'Wq. 38', NULL, NULL, 1769, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Le feste d''Apollo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd99d2db-a377-4eb9-a6ca-3c1cd2fe2a7a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cd99d2db-a377-4eb9-a6ca-3c1cd2fe2a7a'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <Le feste d''Apollo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd99d2db-a377-4eb9-a6ca-3c1cd2fe2a7a'
);


-- Wq. 39 오페라 <파리데와 엘레나>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <파리데와 엘레나>', 'Paride ed Elena', 'song', 'Wq. 39', NULL, NULL, 1770, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <파리데와 엘레나>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b43cbc0e-fb45-42cc-ad62-ddd5ab74e3aa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b43cbc0e-fb45-42cc-ad62-ddd5ab74e3aa'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <파리데와 엘레나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b43cbc0e-fb45-42cc-ad62-ddd5ab74e3aa'
);


-- Wq. 40 오페라 <아울리데의 이피제니>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아울리데의 이피제니>', 'Iphigénie en Aulide', 'song', 'Wq. 40', NULL, NULL, 1774, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아울리데의 이피제니>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84f98703-3115-415a-a1f5-f87a831e0836'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '84f98703-3115-415a-a1f5-f87a831e0836'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <아울리데의 이피제니>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84f98703-3115-415a-a1f5-f87a831e0836'
);


-- Wq. 41 오페라 <오르페와 외리디스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <오르페와 외리디스>', 'Orphée et Eurydice', 'song', 'Wq. 41', NULL, NULL, 1774, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <오르페와 외리디스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7234d26e-981d-493f-83d6-1c515ced842a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7234d26e-981d-493f-83d6-1c515ced842a'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <오르페와 외리디스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7234d26e-981d-493f-83d6-1c515ced842a'
);


-- Wq. 42 오페라 <L'arbre enchanté>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <L''arbre enchanté>', 'L''arbre enchanté, ou Le tuteur dupé', 'song', 'Wq. 42', NULL, NULL, 1775, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <L''arbre enchanté>'
);


-- Wq. 43 오페라-발레 <La Cythère assiégée>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라-발레 <La Cythère assiégée>', 'La Cythère assiégée', 'song', 'Wq. 43', NULL, NULL, 1775, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라-발레 <La Cythère assiégée>'
);


-- Wq. 44 오페라 <알세스트>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <알세스트>', 'Alceste', 'song', 'Wq. 44', NULL, NULL, 1776, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <알세스트>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b6812b1-9c04-41e9-a13a-bbcc285e5d0e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6b6812b1-9c04-41e9-a13a-bbcc285e5d0e'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <알세스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b6812b1-9c04-41e9-a13a-bbcc285e5d0e'
);


-- Wq. 45 오페라 <아르미드>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아르미드>', 'Armide', 'song', 'Wq. 45', NULL, NULL, 1777, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아르미드>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91f13fe4-5389-4c4a-986b-80f68ad5830f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '91f13fe4-5389-4c4a-986b-80f68ad5830f'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <아르미드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91f13fe4-5389-4c4a-986b-80f68ad5830f'
);


-- Wq. 46 오페라 <타우리데의 이피제니>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c4c4b5c-0f9b-4ed8-989e-ace86e1a6d42'
FROM pieces p
WHERE p.id = 65 AND p.composer_id = 21
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c4c4b5c-0f9b-4ed8-989e-ace86e1a6d42'
);


-- Wq. 47 오페라 <에코와 나르시스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <에코와 나르시스>', 'Echo et Narcisse', 'song', 'Wq. 47', NULL, NULL, 1779, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <에코와 나르시스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb97d629-336a-4225-a64f-bb43c0c97cd7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb97d629-336a-4225-a64f-bb43c0c97cd7'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <에코와 나르시스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb97d629-336a-4225-a64f-bb43c0c97cd7'
);


-- Wq. 52 발레 <돈 후안>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <돈 후안>', 'Don Juan, ou Le festin de pierre', 'song', 'Wq. 52', NULL, NULL, 1761, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <돈 후안>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11818640-17dc-4760-b10b-6eae149beaaf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '11818640-17dc-4760-b10b-6eae149beaaf'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '발레 <돈 후안>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11818640-17dc-4760-b10b-6eae149beaaf'
);


-- None 발레 <Alessandro>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <Alessandro>', 'Alessandro (Les amours d''Alexandre et de Roxane)', 'song', NULL, NULL, NULL, 1755, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <Alessandro>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '161ff4df-fd6a-48f3-8610-3415fd2d40f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '161ff4df-fd6a-48f3-8610-3415fd2d40f8'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '발레 <Alessandro>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '161ff4df-fd6a-48f3-8610-3415fd2d40f8'
);


-- Wq. 56 발레 <Sémiramis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <Sémiramis>', 'Sémiramis', 'song', 'Wq. 56', NULL, NULL, 1765, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <Sémiramis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ee8373a-72a8-4096-992a-a9086ba002e5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5ee8373a-72a8-4096-992a-a9086ba002e5'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '발레 <Sémiramis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ee8373a-72a8-4096-992a-a9086ba002e5'
);


-- Wq. 50 시편 <De profundis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 <De profundis>', 'De profundis', 'song', 'Wq. 50', NULL, NULL, 1782, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 <De profundis>'
);


-- Wq. 48 성악곡 Wq. 48

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성악곡 Wq. 48', 'Morceaux de chant détachés, Wq. 48', 'album', NULL, 'Wq.', '48', NULL, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성악곡 Wq. 48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq48:1', 1, NULL, 'Oh Dei che dolce incanto', 'Oh Dei che dolce incanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '성악곡 Wq. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq48:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq48:2', 2, NULL, 'Per tutto il timore', 'Per tutto il timore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '성악곡 Wq. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq48:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq48:3', 3, NULL, 'Benché copra al sole il volto', 'Benché copra al sole il volto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '성악곡 Wq. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq48:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq48:4', 4, NULL, 'Và, ti sarò fedele', 'Và, ti sarò fedele', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '성악곡 Wq. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq48:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq48:5', 5, NULL, 'Pace, Amor, torniamo in pace', 'Pace, Amor, torniamo in pace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '성악곡 Wq. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq48:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq48:6', 6, NULL, 'Che legge spietata', 'Che legge spietata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '성악곡 Wq. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq48:6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq48:7', 7, NULL, 'Berenice, ove sei – Ombre che pallida', 'Berenice, ove sei – Ombre che pallida', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '성악곡 Wq. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq48:7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq48:8', 8, NULL, 'Ah pietà se di me senti', 'Ah pietà se di me senti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '성악곡 Wq. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq48:8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq48:9', 9, NULL, 'Nò, che non ha la sorte – Si, vedrò quell''alma ingrata', 'Nò, che non ha la sorte – Si, vedrò quell''alma ingrata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '성악곡 Wq. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq48:9'
);


-- Wq. 49 가곡집 <클롭슈토크의 송가와 가곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <클롭슈토크의 송가와 가곡>', 'Klopstocks Oden und Lieder', 'album', 'Wq. 49', NULL, NULL, 1786, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <클롭슈토크의 송가와 가곡>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq49:1', 1, NULL, 'Vaterlandslied', 'Vaterlandslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '가곡집 <클롭슈토크의 송가와 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq49:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq49:2', 2, NULL, 'Wir und Sie', 'Wir und Sie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '가곡집 <클롭슈토크의 송가와 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq49:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq49:3', 3, NULL, 'Schlachtgesang', 'Schlachtgesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '가곡집 <클롭슈토크의 송가와 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq49:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq49:4', 4, NULL, 'Der Jüngling', 'Der Jüngling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '가곡집 <클롭슈토크의 송가와 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq49:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq49:5', 5, NULL, 'Die Sommernacht', 'Die Sommernacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '가곡집 <클롭슈토크의 송가와 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq49:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq49:6', 6, NULL, 'Die frühen Gräber', 'Die frühen Gräber', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '가곡집 <클롭슈토크의 송가와 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq49:6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:gluck:gluck-wq49:7', 7, NULL, 'Die Neigung', 'Die Neigung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '가곡집 <클롭슈토크의 송가와 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:gluck:gluck-wq49:7'
);


-- Wq. 58 가곡 <Ode an den Tod>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ode an den Tod>', 'Ode an den Tod', 'song', 'Wq. 58', NULL, NULL, 1783, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ode an den Tod>'
);


-- Wq. 60 가곡 <Amour en ces lieux>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Amour en ces lieux>', 'Amour en ces lieux', 'song', 'Wq. 60', NULL, NULL, 1780, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Amour en ces lieux>'
);


-- Wq. 61 가곡 <Quand la beauté lance>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Quand la beauté lance>', 'Quand la beauté lance', 'song', 'Wq. 61', NULL, NULL, 1780, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Quand la beauté lance>'
);


-- Wq. 62 가곡 <Die Sommernacht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Die Sommernacht>', 'Die Sommernacht (2nd version)', 'song', 'Wq. 62', NULL, NULL, 1785, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Die Sommernacht>'
);


-- Wq. 63 2중창 <Minona lieblich und hold>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Minona lieblich und hold>', 'Minona lieblich und hold haucht reine Liebe', 'song', 'Wq. 63', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Minona lieblich und hold>'
);


-- GluckWV 5.2.1 트리오 소나타 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리오 소나타 F장조', 'Trio Sonata in F major', 'song', 'GluckWV 5.2.1', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 21
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리오 소나타 F장조'
);

