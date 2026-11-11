-- 도메니코 스카를라티(composer_id 9) 작품 목록. 지금은 작곡가 화면에 건반 소나타 7곡뿐이다.
-- 작품 71개(새 64 + 기존 7), 다악장 작품 안 곡 12개, 장르·형식.
--
-- 소나타 555곡을 다 넣지 않고 널리 연주·녹음되는 59곡을 K. 번호 낱곡(「건반 소나타 A단조 K. 3」)으로 골랐다.
-- 1738 「Essercizi」 묶음은 만들지 않았다(기존 K. 1·9·27 이 묶음 안으로 들어가 최상위에서 빠지므로).
-- 성악은 스타바트 마테르·살베 레지나 A장조·미사 2·테 데움. 자료와 생성기:
--   seed_pipeline/curation/baroque-catalog-2026-11-12/(build.py, scarlatti/works.tsv) → catalog-wave4 gen_catalog.py
-- 기존 7곡은 제목(「소나타 D단조」 꼴)·설명·링크를 두고 MBID 만 잇는다.
-- 장르·형식은 비어 있을 때만 채운다. 두 번 돌려도 같다.

-- Kk. 1 (L. 366) 소나타 D단조

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4dad1f72-5f8d-3a63-ae31-799131026480'
FROM pieces p
WHERE p.id = 45 AND p.composer_id = 9
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dad1f72-5f8d-3a63-ae31-799131026480'
);


-- Kk. 9 (L. 413) 소나타 D단조 파스토랄레

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '442d428d-de03-3f45-afd5-fff61685177e'
FROM pieces p
WHERE p.id = 44 AND p.composer_id = 9
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '442d428d-de03-3f45-afd5-fff61685177e'
);


-- Kk. 27 (L. 449) 소나타 B단조

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1de803cd-2b67-38f3-9aae-18f616be4d80'
FROM pieces p
WHERE p.id = 41 AND p.composer_id = 9
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1de803cd-2b67-38f3-9aae-18f616be4d80'
);


-- Kk. 141 (L. 422) 소나타 D단조

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '08d2472b-57c6-3fab-beba-8f6a13073fbd'
FROM pieces p
WHERE p.id = 42 AND p.composer_id = 9
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08d2472b-57c6-3fab-beba-8f6a13073fbd'
);


-- Kk. 159 (L. 104) 소나타 C장조 사냥

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52b0d1a1-6799-3acb-a2a0-13c6201cdecd'
FROM pieces p
WHERE p.id = 40 AND p.composer_id = 9
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52b0d1a1-6799-3acb-a2a0-13c6201cdecd'
);


-- Kk. 380 (L. 23) 소나타 E장조 행렬

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ee7e99f-b0d3-3434-84cb-de98161bffb1'
FROM pieces p
WHERE p.id = 39 AND p.composer_id = 9
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ee7e99f-b0d3-3434-84cb-de98161bffb1'
);


-- Kk. 466 (L. 118) 소나타 F단조

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'afc3fc5f-b245-312e-8a5f-5f38d51a6c59'
FROM pieces p
WHERE p.id = 43 AND p.composer_id = 9
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'afc3fc5f-b245-312e-8a5f-5f38d51a6c59'
);


-- K. 3 건반 소나타 A단조 K. 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 A단조 K. 3', 'Sonata in A minor, K 3, L 378: Presto', 'song', NULL, 'K.', '3', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 A단조 K. 3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8066208-1574-4d83-b0ad-3526cb8a09a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c8066208-1574-4d83-b0ad-3526cb8a09a7'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 A단조 K. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8066208-1574-4d83-b0ad-3526cb8a09a7'
);


-- K. 8 건반 소나타 G단조 K. 8

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 G단조 K. 8', 'Sonata in G minor, K 8, L 488: Allegro', 'song', NULL, 'K.', '8', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 G단조 K. 8'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3758ba8-8c0e-4c9b-a98a-313aa2bb9601'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e3758ba8-8c0e-4c9b-a98a-313aa2bb9601'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 G단조 K. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3758ba8-8c0e-4c9b-a98a-313aa2bb9601'
);


-- K. 11 건반 소나타 C단조 K. 11

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 C단조 K. 11', 'Sonata in C minor, K 11, L 352: Allegro', 'song', NULL, 'K.', '11', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 C단조 K. 11'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd777698-f344-3de2-bfa3-fad34d01ecf8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bd777698-f344-3de2-bfa3-fad34d01ecf8'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 C단조 K. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd777698-f344-3de2-bfa3-fad34d01ecf8'
);


-- K. 13 건반 소나타 G장조 K. 13

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 G장조 K. 13', 'Sonata in G major, K 13, L 486: Presto', 'song', NULL, 'K.', '13', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 G장조 K. 13'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d2ae68d-833a-3458-b820-fea3e7a85301'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7d2ae68d-833a-3458-b820-fea3e7a85301'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 G장조 K. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d2ae68d-833a-3458-b820-fea3e7a85301'
);


-- K. 20 건반 소나타 E장조 K. 20

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 E장조 K. 20', 'Sonata in E major "Capriccio", K 20, L 375: Presto', 'song', NULL, 'K.', '20', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 E장조 K. 20'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '830a4b99-2cd5-40c3-a090-a389736633fc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '830a4b99-2cd5-40c3-a090-a389736633fc'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 E장조 K. 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '830a4b99-2cd5-40c3-a090-a389736633fc'
);


-- K. 24 건반 소나타 A장조 K. 24

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 A장조 K. 24', 'Sonata in A major, K 24, L 495: Presto', 'song', NULL, 'K.', '24', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 A장조 K. 24'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bac641c4-ddbf-4a6d-ae49-5b6ee25d239c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bac641c4-ddbf-4a6d-ae49-5b6ee25d239c'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 A장조 K. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bac641c4-ddbf-4a6d-ae49-5b6ee25d239c'
);


-- K. 25 건반 소나타 F#단조 K. 25

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 F#단조 K. 25', 'Sonata in F-sharp minor, K 25, L 481: Allegro', 'song', NULL, 'K.', '25', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 F#단조 K. 25'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '214bc87e-ea6f-3267-92c7-0901ff554d54'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '214bc87e-ea6f-3267-92c7-0901ff554d54'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 F#단조 K. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '214bc87e-ea6f-3267-92c7-0901ff554d54'
);


-- K. 29 건반 소나타 D장조 K. 29

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 D장조 K. 29', 'Sonata in D major, K 29, L 461: Presto', 'song', NULL, 'K.', '29', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 D장조 K. 29'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '71358543-b104-4f07-a766-8ea311344dbd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '71358543-b104-4f07-a766-8ea311344dbd'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 D장조 K. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '71358543-b104-4f07-a766-8ea311344dbd'
);


-- K. 30 건반 소나타 G단조 "고양이 푸가" K. 30

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 G단조 "고양이 푸가" K. 30', 'Sonata in G minor "The Cat''s Fugue", K 30, L 499: Moderato', 'song', NULL, 'K.', '30', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 G단조 "고양이 푸가" K. 30'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f06e4b4-7ecf-4e65-9fc2-dc00c0d31d69'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f06e4b4-7ecf-4e65-9fc2-dc00c0d31d69'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 G단조 "고양이 푸가" K. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f06e4b4-7ecf-4e65-9fc2-dc00c0d31d69'
);


-- K. 32 건반 소나타 D단조 K. 32

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 D단조 K. 32', 'Sonata in D minor, K 32, L 423: Aria', 'song', NULL, 'K.', '32', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 D단조 K. 32'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c466c92f-d82b-4deb-a24a-5c0b33cc78f4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c466c92f-d82b-4deb-a24a-5c0b33cc78f4'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 D단조 K. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c466c92f-d82b-4deb-a24a-5c0b33cc78f4'
);


-- K. 46 건반 소나타 E장조 K. 46

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 E장조 K. 46', 'Sonata in E major, K 46, L 25: Presto', 'song', NULL, 'K.', '46', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 E장조 K. 46'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4b7a0b1-5ce8-412b-a2f9-5074b9948e7e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4b7a0b1-5ce8-412b-a2f9-5074b9948e7e'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 E장조 K. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4b7a0b1-5ce8-412b-a2f9-5074b9948e7e'
);


-- K. 54 건반 소나타 A단조 K. 54

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 A단조 K. 54', 'Sonata in A minor, K 54, L 241: Allegro', 'song', NULL, 'K.', '54', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 A단조 K. 54'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df067c04-27d2-328e-8812-57ead46c0ca6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df067c04-27d2-328e-8812-57ead46c0ca6'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 A단조 K. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df067c04-27d2-328e-8812-57ead46c0ca6'
);


-- K. 69 건반 소나타 F단조 K. 69

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 F단조 K. 69', 'Sonata in F minor, K 69, L 382', 'song', NULL, 'K.', '69', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 F단조 K. 69'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '636d58d8-617d-3cc4-99c6-499060750ab4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '636d58d8-617d-3cc4-99c6-499060750ab4'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 F단조 K. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '636d58d8-617d-3cc4-99c6-499060750ab4'
);


-- K. 87 건반 소나타 B단조 K. 87

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 B단조 K. 87', 'Sonata in B minor, K 87, L 33', 'song', NULL, 'K.', '87', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 B단조 K. 87'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d39f190-c744-3565-8718-dd507afd779a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7d39f190-c744-3565-8718-dd507afd779a'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 B단조 K. 87' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d39f190-c744-3565-8718-dd507afd779a'
);


-- K. 96 건반 소나타 D장조 K. 96

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 D장조 K. 96', 'Sonata in D major, K 96, L 465: Allegrissimo', 'song', NULL, 'K.', '96', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 D장조 K. 96'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be495691-1719-39ea-9dbb-8cd793f07f0d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be495691-1719-39ea-9dbb-8cd793f07f0d'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 D장조 K. 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be495691-1719-39ea-9dbb-8cd793f07f0d'
);


-- K. 113 건반 소나타 A장조 K. 113

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 A장조 K. 113', 'Sonata in A major, K 113, L 345: Allegro', 'song', NULL, 'K.', '113', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 A장조 K. 113'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25ef15dd-5d49-4047-b166-ba91f1f9cfea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '25ef15dd-5d49-4047-b166-ba91f1f9cfea'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 A장조 K. 113' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25ef15dd-5d49-4047-b166-ba91f1f9cfea'
);


-- K. 119 건반 소나타 D장조 K. 119

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 D장조 K. 119', 'Sonata in D major, K 119, L 415', 'song', NULL, 'K.', '119', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 D장조 K. 119'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b56beea7-54f2-45cc-91be-e70e40e1234b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b56beea7-54f2-45cc-91be-e70e40e1234b'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 D장조 K. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b56beea7-54f2-45cc-91be-e70e40e1234b'
);


-- K. 125 건반 소나타 G장조 K. 125

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 G장조 K. 125', 'Sonata in G major, K 125, L 487: Vivo', 'song', NULL, 'K.', '125', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 G장조 K. 125'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7885df19-ce29-30e6-8662-f1e4337513cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7885df19-ce29-30e6-8662-f1e4337513cb'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 G장조 K. 125' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7885df19-ce29-30e6-8662-f1e4337513cb'
);


-- K. 132 건반 소나타 C장조 K. 132

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 C장조 K. 132', 'Sonata in C major, K 132, L 457: Cantabile', 'song', NULL, 'K.', '132', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 C장조 K. 132'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efdb22d2-3b2d-3958-b693-a18faa3261f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'efdb22d2-3b2d-3958-b693-a18faa3261f1'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 C장조 K. 132' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efdb22d2-3b2d-3958-b693-a18faa3261f1'
);


-- K. 135 건반 소나타 E장조 K. 135

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 E장조 K. 135', 'Sonata in E major, K 135, L 224: Allegro', 'song', NULL, 'K.', '135', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 E장조 K. 135'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e591a886-2bb3-3c7e-b450-d9eb8f7af754'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e591a886-2bb3-3c7e-b450-d9eb8f7af754'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 E장조 K. 135' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e591a886-2bb3-3c7e-b450-d9eb8f7af754'
);


-- K. 146 건반 소나타 G장조 K. 146

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 G장조 K. 146', 'Sonata in G major, K 146, L 349', 'song', NULL, 'K.', '146', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 G장조 K. 146'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a37be9ed-6aa0-3b99-8409-7b60d3366d86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a37be9ed-6aa0-3b99-8409-7b60d3366d86'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 G장조 K. 146' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a37be9ed-6aa0-3b99-8409-7b60d3366d86'
);


-- K. 162 건반 소나타 E장조 K. 162

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 E장조 K. 162', 'Sonata in E major, K 162, L 21: Andante - Allegro', 'song', NULL, 'K.', '162', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 E장조 K. 162'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35af2202-7b5e-3055-8606-3fdcdd98609a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '35af2202-7b5e-3055-8606-3fdcdd98609a'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 E장조 K. 162' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35af2202-7b5e-3055-8606-3fdcdd98609a'
);


-- K. 175 건반 소나타 A단조 K. 175

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 A단조 K. 175', 'Sonata in A minor, K 175, L 429: Allegro', 'song', NULL, 'K.', '175', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 A단조 K. 175'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '603b5b8d-2cfe-3726-8d8a-55fa3c57a30a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '603b5b8d-2cfe-3726-8d8a-55fa3c57a30a'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 A단조 K. 175' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '603b5b8d-2cfe-3726-8d8a-55fa3c57a30a'
);


-- K. 180 건반 소나타 G장조 K. 180

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 G장조 K. 180', 'Sonata in G major, K 180, L 272: Allegro vivo', 'song', NULL, 'K.', '180', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 G장조 K. 180'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c46a74f1-3215-4105-a8f5-085749a83ef3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c46a74f1-3215-4105-a8f5-085749a83ef3'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 G장조 K. 180' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c46a74f1-3215-4105-a8f5-085749a83ef3'
);


-- K. 197 건반 소나타 B단조 K. 197

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 B단조 K. 197', 'Sonata in B minor, K 197, L 147: Andante', 'song', NULL, 'K.', '197', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 B단조 K. 197'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cdd5482b-2126-3755-a612-625d7da08de9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cdd5482b-2126-3755-a612-625d7da08de9'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 B단조 K. 197' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cdd5482b-2126-3755-a612-625d7da08de9'
);


-- K. 198 건반 소나타 E단조 K. 198

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 E단조 K. 198', 'Sonata in E minor, K 198, L 22: Allegro', 'song', NULL, 'K.', '198', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 E단조 K. 198'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '879cea08-5a71-3890-9174-40ea279466f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '879cea08-5a71-3890-9174-40ea279466f5'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 E단조 K. 198' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '879cea08-5a71-3890-9174-40ea279466f5'
);


-- K. 201 건반 소나타 G장조 K. 201

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 G장조 K. 201', 'Sonata in G major, K 201, L 129: Vivo', 'song', NULL, 'K.', '201', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 G장조 K. 201'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8055b9d4-3920-305d-aee4-c7c34c08871f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8055b9d4-3920-305d-aee4-c7c34c08871f'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 G장조 K. 201' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8055b9d4-3920-305d-aee4-c7c34c08871f'
);


-- K. 208 건반 소나타 A장조 K. 208

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 A장조 K. 208', 'Sonata in A major, K 208, L 238: Adagio e cantabile', 'song', NULL, 'K.', '208', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 A장조 K. 208'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '232644a4-48a9-3c57-aa46-377e2645dba0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '232644a4-48a9-3c57-aa46-377e2645dba0'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 A장조 K. 208' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '232644a4-48a9-3c57-aa46-377e2645dba0'
);


-- K. 209 건반 소나타 A장조 K. 209

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 A장조 K. 209', 'Sonata in A major, K 209, L 428: Allegro', 'song', NULL, 'K.', '209', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 A장조 K. 209'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '488ba0e7-f012-34d0-b30d-d9d11ad38fae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '488ba0e7-f012-34d0-b30d-d9d11ad38fae'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 A장조 K. 209' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '488ba0e7-f012-34d0-b30d-d9d11ad38fae'
);


-- K. 213 건반 소나타 D단조 K. 213

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 D단조 K. 213', 'Sonata in D minor, K 213, L 108: Andante', 'song', NULL, 'K.', '213', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 D단조 K. 213'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3b17217-3129-3ebe-81ef-5e96e3dfbd43'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f3b17217-3129-3ebe-81ef-5e96e3dfbd43'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 D단조 K. 213' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3b17217-3129-3ebe-81ef-5e96e3dfbd43'
);


-- K. 216 건반 소나타 E장조 K. 216

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 E장조 K. 216', 'Sonata in E major, K 216, L 273: Allegro', 'song', NULL, 'K.', '216', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 E장조 K. 216'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6e108b2-7542-47d2-9ed3-926e237f761b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e6e108b2-7542-47d2-9ed3-926e237f761b'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 E장조 K. 216' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6e108b2-7542-47d2-9ed3-926e237f761b'
);


-- K. 239 건반 소나타 F단조 K. 239

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 F단조 K. 239', 'Sonata in F minor, K 239, L 281: Allegro', 'song', NULL, 'K.', '239', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 F단조 K. 239'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02c0ef25-3822-4982-82b3-d1c1bb94dfb4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '02c0ef25-3822-4982-82b3-d1c1bb94dfb4'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 F단조 K. 239' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02c0ef25-3822-4982-82b3-d1c1bb94dfb4'
);


-- K. 260 건반 소나타 G장조 K. 260

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 G장조 K. 260', 'Sonata in G major, K. 260, L 124: Allegro', 'song', NULL, 'K.', '260', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 G장조 K. 260'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79c51268-066b-42f9-a417-2df481e5a478'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '79c51268-066b-42f9-a417-2df481e5a478'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 G장조 K. 260' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79c51268-066b-42f9-a417-2df481e5a478'
);


-- K. 263 건반 소나타 E단조 K. 263

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 E단조 K. 263', 'Sonata in E minor, K 263, L 321: Andante', 'song', NULL, 'K.', '263', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 E단조 K. 263'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9418902-dcaf-4a93-8b51-964cb5f8fbdd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9418902-dcaf-4a93-8b51-964cb5f8fbdd'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 E단조 K. 263' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9418902-dcaf-4a93-8b51-964cb5f8fbdd'
);


-- K. 278 건반 소나타 D장조 K. 278

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 D장조 K. 278', 'Sonata in D major, K 278, L S15: Con velocità', 'song', NULL, 'K.', '278', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 D장조 K. 278'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0755342-30da-3eed-93d6-d5b6b4c96702'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a0755342-30da-3eed-93d6-d5b6b4c96702'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 D장조 K. 278' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0755342-30da-3eed-93d6-d5b6b4c96702'
);


-- K. 322 건반 소나타 A장조 K. 322

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 A장조 K. 322', 'Sonata in A major, K 322, L 483: Allegro', 'song', NULL, 'K.', '322', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 A장조 K. 322'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1caf85da-0d65-3e59-9f75-3b26f1eee862'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1caf85da-0d65-3e59-9f75-3b26f1eee862'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 A장조 K. 322' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1caf85da-0d65-3e59-9f75-3b26f1eee862'
);


-- K. 323 건반 소나타 A장조 K. 323

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 A장조 K. 323', 'Sonata in A major, K 323, L 95: Allegro', 'song', NULL, 'K.', '323', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 A장조 K. 323'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cb15c70-d5ba-4ef9-bb43-5cf2833b1bff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4cb15c70-d5ba-4ef9-bb43-5cf2833b1bff'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 A장조 K. 323' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cb15c70-d5ba-4ef9-bb43-5cf2833b1bff'
);


-- K. 386 건반 소나타 F단조 K. 386

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 F단조 K. 386', 'Sonata in F minor, K 386, L 171: Presto', 'song', NULL, 'K.', '386', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 F단조 K. 386'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5e4977c-bb28-3df4-b2a3-1ce25d17fa76'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b5e4977c-bb28-3df4-b2a3-1ce25d17fa76'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 F단조 K. 386' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5e4977c-bb28-3df4-b2a3-1ce25d17fa76'
);


-- K. 394 건반 소나타 E단조 K. 394

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 E단조 K. 394', 'Sonata in E minor, K 394, L 275: Allegro', 'song', NULL, 'K.', '394', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 E단조 K. 394'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c85d457e-0093-321b-a7b4-be73d6b6ffd6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c85d457e-0093-321b-a7b4-be73d6b6ffd6'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 E단조 K. 394' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c85d457e-0093-321b-a7b4-be73d6b6ffd6'
);


-- K. 420 건반 소나타 C장조 K. 420

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 C장조 K. 420', 'Sonata in C major, K 420, L S2: Allegro', 'song', NULL, 'K.', '420', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 C장조 K. 420'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20cab382-b9d0-3529-8e05-0aa1e92ab462'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '20cab382-b9d0-3529-8e05-0aa1e92ab462'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 C장조 K. 420' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20cab382-b9d0-3529-8e05-0aa1e92ab462'
);


-- K. 425 건반 소나타 G장조 K. 425

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 G장조 K. 425', 'Sonata in G major, K 425, L 333: Allegro molto', 'song', NULL, 'K.', '425', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 G장조 K. 425'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9f01eb8-7a27-4e31-8e98-3d5cf2754706'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9f01eb8-7a27-4e31-8e98-3d5cf2754706'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 G장조 K. 425' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9f01eb8-7a27-4e31-8e98-3d5cf2754706'
);


-- K. 427 건반 소나타 G장조 K. 427

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 G장조 K. 427', 'Sonata in G major, K 427, L 286: Presto, quanto sia possibile', 'song', NULL, 'K.', '427', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 G장조 K. 427'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ceea9c73-1d2a-34ba-83a4-604e3a5afee6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ceea9c73-1d2a-34ba-83a4-604e3a5afee6'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 G장조 K. 427' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ceea9c73-1d2a-34ba-83a4-604e3a5afee6'
);


-- K. 430 건반 소나타 D장조 K. 430

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 D장조 K. 430', 'Sonata in D major, K. 430, L 463: Non presto ma a tempo di ballo', 'song', NULL, 'K.', '430', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 D장조 K. 430'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e150bc7c-8622-3f99-9af7-447fe788b328'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e150bc7c-8622-3f99-9af7-447fe788b328'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 D장조 K. 430' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e150bc7c-8622-3f99-9af7-447fe788b328'
);


-- K. 435 건반 소나타 D장조 K. 435

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 D장조 K. 435', 'Sonata in D major, K 435, L 361', 'song', NULL, 'K.', '435', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 D장조 K. 435'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00f702e2-cf7d-4341-80ee-a4ef1bf334f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '00f702e2-cf7d-4341-80ee-a4ef1bf334f8'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 D장조 K. 435' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00f702e2-cf7d-4341-80ee-a4ef1bf334f8'
);


-- K. 450 건반 소나타 G단조 K. 450

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 G단조 K. 450', 'Sonata in G minor, K 450, L 338: Allegrissimo', 'song', NULL, 'K.', '450', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 G단조 K. 450'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bacbd4f7-14b0-3df8-b27d-3459c27c6dfd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bacbd4f7-14b0-3df8-b27d-3459c27c6dfd'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 G단조 K. 450' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bacbd4f7-14b0-3df8-b27d-3459c27c6dfd'
);


-- K. 455 건반 소나타 G장조 K. 455

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 G장조 K. 455', 'Sonata in G major, K 455, L 209: Allegro', 'song', NULL, 'K.', '455', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 G장조 K. 455'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3deaf9d-8d14-37a9-8dd1-96c8c1dfa27d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a3deaf9d-8d14-37a9-8dd1-96c8c1dfa27d'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 G장조 K. 455' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3deaf9d-8d14-37a9-8dd1-96c8c1dfa27d'
);


-- K. 462 건반 소나타 F단조 K. 462

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 F단조 K. 462', 'Sonata in F minor, K 462, L 438: Andante', 'song', NULL, 'K.', '462', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 F단조 K. 462'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9267f71b-bfed-4874-9222-acc073fc3244'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9267f71b-bfed-4874-9222-acc073fc3244'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 F단조 K. 462' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9267f71b-bfed-4874-9222-acc073fc3244'
);


-- K. 474 건반 소나타 E♭장조 K. 474

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 E♭장조 K. 474', 'Sonata in E-flat major, K 474, L 203: Andante cantabile', 'song', NULL, 'K.', '474', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 E♭장조 K. 474'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5825b2c-b81d-3f11-a5e1-0946a6fba20c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5825b2c-b81d-3f11-a5e1-0946a6fba20c'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 E♭장조 K. 474' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5825b2c-b81d-3f11-a5e1-0946a6fba20c'
);


-- K. 481 건반 소나타 F단조 K. 481

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 F단조 K. 481', 'Sonata in F minor, K 481, L 187: Andante cantabile', 'song', NULL, 'K.', '481', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 F단조 K. 481'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55e85420-c993-33fa-9ae3-f42ba5be5af4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '55e85420-c993-33fa-9ae3-f42ba5be5af4'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 F단조 K. 481' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55e85420-c993-33fa-9ae3-f42ba5be5af4'
);


-- K. 490 건반 소나타 D장조 K. 490

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 D장조 K. 490', 'Sonata in D major, K 490, L 206', 'song', NULL, 'K.', '490', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 D장조 K. 490'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '169aa056-809c-424b-a8c2-a344d3f76c60'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '169aa056-809c-424b-a8c2-a344d3f76c60'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 D장조 K. 490' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '169aa056-809c-424b-a8c2-a344d3f76c60'
);


-- K. 491 건반 소나타 D장조 K. 491

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 D장조 K. 491', 'Sonata in D major, K 491, L 164: Allegro', 'song', NULL, 'K.', '491', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 D장조 K. 491'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '733a2e83-3f51-33b4-9bbc-e61360ba59e5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '733a2e83-3f51-33b4-9bbc-e61360ba59e5'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 D장조 K. 491' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '733a2e83-3f51-33b4-9bbc-e61360ba59e5'
);


-- K. 492 건반 소나타 D장조 K. 492

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 D장조 K. 492', 'Sonata in D major, K 492, L 14: Presto', 'song', NULL, 'K.', '492', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 D장조 K. 492'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6873c268-2026-3d87-94c4-170f7a291336'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6873c268-2026-3d87-94c4-170f7a291336'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 D장조 K. 492' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6873c268-2026-3d87-94c4-170f7a291336'
);


-- K. 513 건반 소나타 C장조 K. 513

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 C장조 K. 513', 'Sonata in C major, K 513, L S3: Moderato e Molto allegro - Presto', 'song', NULL, 'K.', '513', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 C장조 K. 513'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7381a00-7007-4fd7-8488-80e5ce7aa1d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7381a00-7007-4fd7-8488-80e5ce7aa1d5'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 C장조 K. 513' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7381a00-7007-4fd7-8488-80e5ce7aa1d5'
);


-- K. 519 건반 소나타 F단조 K. 519

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 F단조 K. 519', 'Sonata in F minor, K 519, L 475: Allegro assai', 'song', NULL, 'K.', '519', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 F단조 K. 519'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c50be5ef-c4f5-33a4-a5bc-362b33c4f39e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c50be5ef-c4f5-33a4-a5bc-362b33c4f39e'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 F단조 K. 519' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c50be5ef-c4f5-33a4-a5bc-362b33c4f39e'
);


-- K. 525 건반 소나타 F장조 K. 525

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 F장조 K. 525', 'Sonata in F major, K 525, L 188: Allegro', 'song', NULL, 'K.', '525', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 F장조 K. 525'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'afb4f9ec-ea3e-3b7d-9204-04a297392a0d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'afb4f9ec-ea3e-3b7d-9204-04a297392a0d'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 F장조 K. 525' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'afb4f9ec-ea3e-3b7d-9204-04a297392a0d'
);


-- K. 531 건반 소나타 E장조 K. 531

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 E장조 K. 531', 'Sonata in E major, K 531, L 430: Allegro', 'song', NULL, 'K.', '531', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 E장조 K. 531'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3311130a-b523-3003-bb8e-d055fd00a932'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3311130a-b523-3003-bb8e-d055fd00a932'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 E장조 K. 531' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3311130a-b523-3003-bb8e-d055fd00a932'
);


-- K. 532 건반 소나타 A단조 K. 532

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 A단조 K. 532', 'Sonata in A minor, K 532, L 223: Allegro', 'song', NULL, 'K.', '532', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 A단조 K. 532'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0b8c4c1-0048-341d-8bdb-d816ecf901ce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a0b8c4c1-0048-341d-8bdb-d816ecf901ce'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 A단조 K. 532' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0b8c4c1-0048-341d-8bdb-d816ecf901ce'
);


-- K. 533 건반 소나타 A장조 K. 533

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 A장조 K. 533', 'Sonata in A major, K 533, L 395: Allegro assai', 'song', NULL, 'K.', '533', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 A장조 K. 533'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e92798fd-f376-33c6-808c-c0510e949048'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e92798fd-f376-33c6-808c-c0510e949048'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 A장조 K. 533' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e92798fd-f376-33c6-808c-c0510e949048'
);


-- K. 544 건반 소나타 B♭장조 K. 544

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 B♭장조 K. 544', 'Sonata in B-flat major, K 544, L 497: Cantabile', 'song', NULL, 'K.', '544', NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 B♭장조 K. 544'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da0919ed-6ad1-3679-88c9-602659c432f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'da0919ed-6ad1-3679-88c9-602659c432f1'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '건반 소나타 B♭장조 K. 544' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da0919ed-6ad1-3679-88c9-602659c432f1'
);


-- None 스타바트 마테르

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스타바트 마테르', 'Stabat Mater', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스타바트 마테르'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '289cc29b-c58f-4948-ac60-d18f2cb15c31'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '289cc29b-c58f-4948-ac60-d18f2cb15c31'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '289cc29b-c58f-4948-ac60-d18f2cb15c31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4991e63b-6eb0-4e96-829e-b4e9b5c887ce', 1, 'I', 'Stabat Mater dolorosa', 'Stabat Mater: I. Stabat Mater dolorosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4991e63b-6eb0-4e96-829e-b4e9b5c887ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:194907e1-57be-473b-868e-a5bc2820ffd4', 2, 'II', 'Cuius animam gementem', 'Stabat Mater: II. Cuius animam gementem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:194907e1-57be-473b-868e-a5bc2820ffd4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7c925ec-0895-4174-9cbe-a4da2f0900ce', 3, 'III', 'Quis non posset contristari', 'Stabat Mater: III. Quis non posset contristari', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7c925ec-0895-4174-9cbe-a4da2f0900ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da06878a-e9a5-496c-9cee-83edaf18c868', 4, 'IV', 'Eia, Mater, fons amoris', 'Stabat Mater: IV. Eia, Mater, fons amoris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da06878a-e9a5-496c-9cee-83edaf18c868'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:422e1a70-d72d-4777-af69-b6b89073c102', 5, 'V', 'Sancta Mater, istud agas', 'Stabat Mater: V. Sancta Mater, istud agas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:422e1a70-d72d-4777-af69-b6b89073c102'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07e1fffe-452a-4665-b9a8-45325f98bbb3', 6, 'VI', 'Fac me vere tecum flere', 'Stabat Mater: VI. Fac me vere tecum flere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07e1fffe-452a-4665-b9a8-45325f98bbb3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9aeb359f-8fb9-411d-972f-900e2da08de8', 7, 'VII', 'Juxta crucem tecum stare', 'Stabat Mater: VII. Juxta crucem tecum stare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9aeb359f-8fb9-411d-972f-900e2da08de8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:050e5837-6fd8-4ee9-b4a7-6c27f777e59a', 8, 'VIII', 'Inflammatus et accensus', 'Stabat Mater: VIII. Inflammatus et accensus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:050e5837-6fd8-4ee9-b4a7-6c27f777e59a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91f3351a-2b46-4d27-9726-0cea8cef89ae', 9, 'IX', 'Fac ut animae donetur', 'Stabat Mater: IX. Fac ut animae donetur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91f3351a-2b46-4d27-9726-0cea8cef89ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6c93779-f2db-4ed5-bc4b-32a894fb59b1', 10, 'X', 'Amen', 'Stabat Mater: X. Amen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6c93779-f2db-4ed5-bc4b-32a894fb59b1'
);


-- None 살베 레지나 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '살베 레지나 A장조', 'Salve Regina in A major', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '살베 레지나 A장조'
);


-- None 미사 브레비스 "라 스텔라"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미사 브레비스 "라 스텔라"', 'Missa breve, "La stella"', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미사 브레비스 "라 스텔라"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0df08cf-e577-43a8-bbc2-b0bd1b01f960'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f0df08cf-e577-43a8-bbc2-b0bd1b01f960'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '미사 브레비스 "라 스텔라"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0df08cf-e577-43a8-bbc2-b0bd1b01f960'
);


-- None 4성부 미사 "마드리드"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4성부 미사 "마드리드"', 'Missa Quatuor vocum "de Madrid"', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4성부 미사 "마드리드"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8727503-4758-47e3-b29c-c271335404e4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8727503-4758-47e3-b29c-c271335404e4'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '4성부 미사 "마드리드"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8727503-4758-47e3-b29c-c271335404e4'
);


-- None 테 데움

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '테 데움', 'Te Deum', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 9
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '테 데움'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b346590c-d776-44f2-a232-203fadb27255'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b346590c-d776-44f2-a232-203fadb27255'
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b346590c-d776-44f2-a232-203fadb27255'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd92bcc3-eaf1-496f-aa54-8625538074f2', 1, 'I', 'Te Deum laudamus', 'Te Deum: Te Deum laudamus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd92bcc3-eaf1-496f-aa54-8625538074f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3f9b59d-bdf2-4695-9676-cf038607e79b', 2, 'II', 'Te ergo quaesumus', 'Te Deum: Te ergo quaesumus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 9 AND p.title = '테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3f9b59d-bdf2-4695-9676-cf038607e79b'
);

-- 장르·형식(works.tsv). 비어 있을 때만 채운다.
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 A단조 K. 3' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 G단조 K. 8' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 C단조 K. 11' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 G장조 K. 13' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 E장조 K. 20' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 A장조 K. 24' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 F#단조 K. 25' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 D장조 K. 29' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 G단조 "고양이 푸가" K. 30' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 D단조 K. 32' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 E장조 K. 46' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 A단조 K. 54' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 F단조 K. 69' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 B단조 K. 87' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 D장조 K. 96' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 A장조 K. 113' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 D장조 K. 119' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 G장조 K. 125' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 C장조 K. 132' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 E장조 K. 135' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 G장조 K. 146' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 E장조 K. 162' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 A단조 K. 175' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 G장조 K. 180' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 B단조 K. 197' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 E단조 K. 198' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 G장조 K. 201' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 A장조 K. 208' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 A장조 K. 209' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 D단조 K. 213' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 E장조 K. 216' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 F단조 K. 239' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 G장조 K. 260' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 E단조 K. 263' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 D장조 K. 278' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 A장조 K. 322' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 A장조 K. 323' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 F단조 K. 386' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 E단조 K. 394' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 C장조 K. 420' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 G장조 K. 425' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 G장조 K. 427' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 D장조 K. 430' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 D장조 K. 435' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 G단조 K. 450' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 G장조 K. 455' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 F단조 K. 462' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 E♭장조 K. 474' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 F단조 K. 481' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 D장조 K. 490' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 D장조 K. 491' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 D장조 K. 492' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 C장조 K. 513' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 F단조 K. 519' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 F장조 K. 525' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 E장조 K. 531' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 A단조 K. 532' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 A장조 K. 533' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 9 AND title = '건반 소나타 B♭장조 K. 544' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 9 AND title = '스타바트 마테르' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 9 AND title = '살베 레지나 A장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'mass_requiem'
WHERE composer_id = 9 AND title = '미사 브레비스 "라 스텔라"' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'mass_requiem'
WHERE composer_id = 9 AND title = '4성부 미사 "마드리드"' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 9 AND title = '테 데움' AND genre IS NULL AND form_key IS NULL;
