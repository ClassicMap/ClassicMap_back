-- 윤이상·홍난파·김동진 기존 작품의 사실 오류 5곳(작품 목록을 채우다 걸린 곳). 근거는
-- seed_pipeline/curation/korean-composers-catalog-2026-11-12/README.md 「기존 작품 사실 고침」 표.
-- 지금 값이 확인할 때 본 값일 때만 바꾼다(사람이 먼저 고쳤으면 건드리지 않는다). 카드는 자동 초안 줄(source auto)만.
-- 두 번 돌려도 같다.

-- 1) 김동진 460 <신아리랑>: 1930년 창작 가곡이 아니라 만주 신경교향악단 시절(1942) 대한 방송용 민요 편곡.
--    들을 지점을 쓸 사실이 없어 카드는 내린다.
UPDATE pieces SET composition_year = 1942
WHERE id = 460 AND composer_id = 103 AND title = '신아리랑' AND composition_year = 1930;

UPDATE pieces SET genre = 'vocal', form_key = 'folk'
WHERE id = 460 AND composer_id = 103 AND title = '신아리랑' AND genre IS NULL AND form_key IS NULL;

UPDATE pieces
SET description = '김동진이 만주 신경교향악단에서 일하던 1942년, 한국을 향한 방송 프로그램을 위해 편곡한 민요다.',
    description_en = 'A folk-song arrangement Kim Dong-jin made in 1942, while with the Hsinking Symphony Orchestra in Manchuria, for radio programs broadcast to Korea.'
WHERE id = 460 AND composer_id = 103
  AND description = '한국의 대표 민요 아리랑을 현대적인 가곡 형식으로 재해석한 곡이다. 피아노 반주와 어우러진 한국적인 정서와 웅장함이 특징이다.';

UPDATE composer_highlights SET status = 'DRAFT'
WHERE id = 461 AND composer_id = 103 AND piece_id = 460 AND source = 'auto' AND status = 'PUBLISHED'
  AND reason = '민요 아리랑을 무대용 가곡으로 다시 쓴 곡이에요. 아리랑 선율에 피아노 반주를 입혔어요';

-- 2) 김동진 391 <신포니에타 (교향곡 1번)>: 작품 목록·약력·백과 어디에도 없다. 목록에서 숨기고(지우지 않음) 카드를 내린다.
--    비교 구간이나 다른 작품의 곡이 가리키면 숨기지 않는다.
UPDATE pieces piece SET piece.hidden_reason = 'unverified'
WHERE piece.id = 391 AND piece.composer_id = 103 AND piece.title = '신포니에타 (교향곡 1번)'
  AND piece.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

UPDATE composer_highlights SET status = 'DRAFT'
WHERE id = 460 AND composer_id = 103 AND piece_id = 391 AND source = 'auto' AND status = 'PUBLISHED'
  AND reason = '1968년에 쓴 김동진의 첫 교향곡이에요. 한국 민요풍 선율을 관현악으로 펼쳐요';

-- 3) 윤이상 348: 1974년 <Etüden> 은 피아노가 아니라 플루트(들) 독주곡. 제목·장르·설명·카드를 고치고 MBID·다섯 곡을 잇는다.
UPDATE pieces
SET title = '플루트를 위한 5개의 연습곡', title_en = 'Etudes for Flute(s) Solo'
WHERE id = 348 AND composer_id = 90 AND title = '5개의 피아노를 위한 연습곡';

UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 348 AND composer_id = 90 AND title = '플루트를 위한 5개의 연습곡' AND genre = 'piano' AND form_key = 'etude';

UPDATE pieces
SET description = '연주자 한 명이 플루트·알토 플루트·피콜로·베이스 플루트를 바꿔 가며 부는 다섯 곡의 연습곡. 1974년 교토에서 김창국이 초연했다.',
    description_en = 'Five etudes for a single player who switches among flute, alto flute, piccolo and bass flute. Chang-Kook Kim gave the premiere in Kyoto in 1974.'
WHERE id = 348 AND composer_id = 90
  AND description = '12음 기법과 국악의 시김새, 꾸밈음 등을 결합하여 독창적인 음향을 만들어낸 피아노 연습곡이다.';

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9ab1aaef-127f-4a21-be0c-3611f3d435ae'
FROM pieces p
WHERE p.id = 348 AND p.composer_id = 90
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ab1aaef-127f-4a21-be0c-3611f3d435ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, CONCAT('musicbrainz:', etude.mbid), etude.seq, etude.movement, etude.name_ko, etude.name_en, 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN (
    SELECT 1 AS seq, 'I' AS movement, 'Moderato (플루트)' AS name_ko, 'Moderato (flute)' AS name_en, '3ffd509e-c018-48e0-a64e-401ffc9cb5c8' AS mbid
    UNION ALL SELECT 2, 'II', 'Adagio (알토 플루트)', 'Adagio (alto flute)', '0116f320-9085-479a-9d88-8ec27401ac74'
    UNION ALL SELECT 3, 'III', 'Allegro (피콜로)', 'Allegro (piccolo)', 'c74a4ad1-94ad-4924-999a-70516af7f3a0'
    UNION ALL SELECT 4, 'IV', 'Andante (베이스 플루트)', 'Andante (bass flute)', '6f37fb42-f9c9-4f9e-9ffd-077507225554'
    UNION ALL SELECT 5, 'V', 'Allegretto (플루트)', 'Allegretto (flute)', 'e3a56116-3471-4b35-922e-275fac43449c'
) etude
WHERE p.id = 348 AND p.composer_id = 90
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = CONCAT('musicbrainz:', etude.mbid)
);

UPDATE composer_highlights
SET reason = '한 사람이 플루트 네 가지를 바꿔 부는 다섯 곡의 연습곡이에요. 3번은 피콜로, 4번은 베이스 플루트라 음역이 끝과 끝이에요',
    reason_en = 'Five etudes in which one player switches among four flutes. No. 3 is for piccolo and No. 4 for bass flute, the two ends of the range'
WHERE id = 394 AND composer_id = 90 AND piece_id = 348 AND source = 'auto'
  AND reason = '국악의 꾸밈음과 시김새를 피아노로 옮긴 연습곡이에요. 다섯 곡이 저마다 다른 기법을 다뤄요';

-- 4) 홍난파 344: 「애수의 곡」(1921)이 아니라 1920년 『처녀혼』 첫머리에 실린 기악곡 「애수」. 뒤에 가사를 붙여 <봉선화>가 됐다.
UPDATE pieces
SET title = '바이올린 소품 <애수>', title_en = 'Violin Piece <Sorrow (Aesu)>'
WHERE id = 344 AND composer_id = 89 AND title = '바이올린 소품 <애수의 곡>';

UPDATE pieces SET composition_year = 1920
WHERE id = 344 AND composer_id = 89 AND title = '바이올린 소품 <애수>' AND composition_year = 1921;

UPDATE pieces
SET description = '1920년 홍난파가 자신의 단편소설집 『처녀혼』 첫머리에 「애수」라는 제목으로 발표한 기악곡. 뒤에 김형준이 가사를 붙여 가곡 <봉선화>가 되었다.',
    description_en = 'An instrumental piece Hong Nan-pa published in 1920 under the title Aesu (Sorrow) at the front of his short-story collection Cheonyeohon. Kim Hyeong-jun later set words to it, and it became the art song Bongseonhwa.'
WHERE id = 344 AND composer_id = 89
  AND description = '1921년 작곡된, 현존하는 한국 최초의 바이올린 창작곡. 홍난파 자신의 비극적 사랑 이야기를 담았다는 일화가 있다.';

UPDATE composers
SET style = REPLACE(style, '바이올린 소품 <애수의 곡>', '바이올린 소품 <애수>'),
    style_en = REPLACE(style_en, 'the violin piece Melody of Sorrow', 'the violin piece Aesu (Sorrow)')
WHERE id = 89 AND style LIKE '%바이올린 소품 <애수의 곡>%';

-- 5) 김동진 390: 노래 제목은 <내 마음>(김동명의 시 제목이 <내 마음은>). 옛 제목으로도 찾히게 별칭을 남긴다.
UPDATE pieces
SET title = '가곡 <내 마음>', title_en = 'Gagok <My Heart (Nae Maeum)>'
WHERE id = 390 AND composer_id = 103 AND title = '가곡 <내 마음은>';

UPDATE pieces
SET description = REPLACE(description, '김동명의 시에 곡을 붙인 가곡.', '김동명의 시 <내 마음은>에 곡을 붙인 가곡.'),
    description_en = REPLACE(description_en, 'A gagok set to a poem by Kim Dong-myeong.', 'A gagok set to Kim Dong-myeong''s poem Nae maeumeun (My Heart Is).')
WHERE id = 390 AND composer_id = 103 AND description LIKE '김동명의 시에 곡을 붙인 가곡.%';

INSERT INTO piece_aliases (piece_id, locale, alias_kind, alias_value, normalized_value, is_preferred, origin, editor_locked)
SELECT p.id, 'ko', 'alias', '내 마음은', '내 마음은', 0, 'manual', 1
FROM pieces p
WHERE p.id = 390 AND p.composer_id = 103 AND p.title = '가곡 <내 마음>'
AND NOT EXISTS (
    SELECT 1 FROM piece_aliases alias
    WHERE alias.piece_id = p.id AND alias.locale = 'ko' AND alias.alias_kind = 'alias' AND alias.normalized_value = '내 마음은'
);

UPDATE composers
SET bio = REPLACE(bio, '<내 마음은>', '<내 마음>'),
    style = REPLACE(style, '<내 마음은>', '<내 마음>'),
    bio_en = REPLACE(bio_en, 'Nae maeumeun (My Heart)', 'Nae maeum (My Heart)'),
    style_en = REPLACE(style_en, 'Nae maeumeun', 'Nae maeum')
WHERE id = 103 AND (bio LIKE '%<내 마음은>%' OR style LIKE '%<내 마음은>%');
