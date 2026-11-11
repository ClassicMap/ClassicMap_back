-- 「처음 듣는다면」 카드가 2장 이하였던 작곡가를 채운다(백남준 1→3, R. 슈트라우스 1→6, J.C. 바흐 2→5).
-- 안익태(2장)는 근거와 음원이 있는 작품이 더 없어 그대로 둔다.
-- 자료: seed_pipeline/curation/thin-composer-highlights-2026-11-11/(cards.json, build.py, README 의 근거).
-- 슈트라우스 작품은 202611110701 이 넣는다. 두 번 돌려도 같다.

-- 백남준: 실제 작품으로 고친다(지금 제목일 때만).
UPDATE pieces SET title = '존 케이지에게 바치는 경의', title_en = 'Hommage à John Cage: Music for Tapes and Piano',
    composition_year = 1959,
    description = '1959년 11월 뒤셀도르프 갤러리 22에서 선보인 백남준의 데뷔 공연. 녹음테이프 콜라주와 피아노 연주에 피아노를 넘어뜨리는 행위를 더했다.',
    description_en = 'Paik''s debut performance, given at Galerie 22 in Düsseldorf in November 1959. It combines a tape collage and piano playing with the act of toppling a piano.'
WHERE id = 385 AND composer_id = 102 AND title = '존 케이지를 위한 교향곡';
UPDATE pieces SET title = '피아노포르테를 위한 연습곡', title_en = 'Étude for Pianoforte',
    composition_year = 1960,
    description = '1960년 10월 쾰른 마리 바우어마이스터의 작업실에서 선보인 행위 음악. 피아노를 치던 백남준이 객석의 존 케이지와 데이비드 튜더에게 다가가 옷을 자르고 머리에 샴푸를 부었다.',
    description_en = 'Action music first performed in October 1960 at Mary Bauermeister''s studio in Cologne. Paik left the piano, cut the clothes of John Cage and David Tudor in the audience and poured shampoo over their heads.',
    spotify_url = COALESCE(spotify_url, 'https://open.spotify.com/album/28DeGPXSSRdjhx9hba3aKm')
WHERE id = 387 AND composer_id = 102 AND title = '조작된 피아노를 위한 연습곡';

-- 슈트라우스 카드 작품 Apple Music 앨범(트랙 목록에 작품 전곡이 있는 음반). 비어 있을 때만.
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-four-last-songs/1452223225'
WHERE composer_id = 498 AND title = '연가곡집 <네 개의 마지막 노래>' AND apple_music_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-tone-poems/1452343256'
WHERE composer_id = 498 AND title = '교향시 <돈 후안>' AND apple_music_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-tone-poems/1452343256'
WHERE composer_id = 498 AND title = '교향시 <틸 오일렌슈피겔의 유쾌한 장난>' AND apple_music_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/richard-strauss-der-rosenkavalier/1293724292'
WHERE composer_id = 498 AND title = '오페라 <장미의 기사>' AND apple_music_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/strauss-salome/1452375364'
WHERE composer_id = 498 AND title = '오페라 <살로메>' AND apple_music_url IS NULL;

-- 카드
UPDATE composer_highlights SET reason = '1959년 뒤셀도르프에서 백남준이 처음 무대에 올린 작품이에요. 테이프 소리와 피아노 연주 끝에 피아노를 넘어뜨려요', reason_en = 'The piece Paik first staged, in Düsseldorf in 1959. After taped sounds and piano playing, the piano is toppled over',
    sort_order = 1, status = 'PUBLISHED'
WHERE composer_id = 102 AND piece_id = 385 AND source = 'auto';
UPDATE composer_highlights SET reason = '1960년 쾰른의 작업실에서 선보인 행위 음악이에요. 피아노를 치다 객석의 존 케이지에게 가서 옷을 자르고 샴푸를 부어요', reason_en = 'Action music first shown in a Cologne studio in 1960. Paik leaves the piano for John Cage in the audience, cuts his clothes and pours shampoo',
    sort_order = 2, status = 'PUBLISHED'
WHERE composer_id = 102 AND piece_id = 387 AND source = 'auto';
UPDATE composer_highlights SET reason = '1962년 뒤셀도르프 <음악 속의 네오다다>에서 처음 선보였어요. 바이올린을 천천히 들어 올렸다가 탁자에 내리쳐 부숴요', reason_en = 'First shown at the 1962 Neo-Dada in der Musik event in Düsseldorf. The violin is slowly raised, then smashed on a table',
    sort_order = 3, status = 'PUBLISHED'
WHERE composer_id = 102 AND piece_id = 386 AND source = 'auto';
UPDATE composer_highlights SET reason = '모차르트가 2·3·4번을 협주곡 K. 107로 고쳐 쓴 소나타집이에요. 하프시코드나 피아노용으로 나와 음반마다 악기가 달라요', reason_en = 'Mozart turned Nos. 2–4 into his concertos K. 107. Printed for harpsichord or piano, so recordings use either',
    sort_order = 3, status = 'PUBLISHED'
WHERE composer_id = 23 AND piece_id = 29433 AND source = 'auto';
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 4, '4번 끝 악장에 스코틀랜드 민요 ''노란 머리 소년''을 넣은 건반 협주곡집이에요. 1777년 초판 표지부터 그 민요를 앞세웠어요', 'No. 4 ends on the Scottish tune ''The Yellow-Haired Laddie''. The 1777 first edition advertised the tune on its title page', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.id = 29442 AND p.composer_id = 23 AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '만하임 오페라 두 편을 의뢰받고 선제후 카를 테오도르에게 바친 5중주곡집이에요. 플루트·오보에·바이올린·비올라·첼로가 함께해요', 'Dedicated to Elector Karl Theodor after two Mannheim opera commissions. Flute, oboe, violin, viola and cello share the lines', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.id = 29441 AND p.composer_id = 23 AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 2, '여든네 살에 쓰고 세상을 떠난 뒤 1950년 런던에서 초연됐어요. 마지막 곡 끝에서 60년 전 교향시 <죽음과 변용>이 들려요', 'Written at 84 and premiered in London in 1950, after his death. The last song ends quoting his tone poem Death and Transfiguration', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <네 개의 마지막 노래>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 3, '스물네 살에 쓰고 이듬해 바이마르에서 직접 지휘해 이름을 알린 교향시예요. 첫 소절부터 관현악이 단숨에 박차고 나가요', 'Written at 24 and conducted by Strauss in Weimar the next year, it made his name. The orchestra bursts out from the first bar', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <돈 후안>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 4, '장난꾼 틸이 끝내 교수형을 당하는 이야기를 그린 교향시예요. 호른이 틸의 주제를 열고, 끝에서 D 클라리넷이 비명을 질러요', 'A tone poem about the prankster Till, who ends on the gallows. A horn opens his theme; at the end the D clarinet screams', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <틸 오일렌슈피겔의 유쾌한 장난>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '1911년 드레스덴 초연 표가 곧바로 매진된 오페라예요. 이야기는 18세기인데 그 뒤에야 빈에서 유행한 왈츠가 흘러요', 'Tickets for the 1911 Dresden premiere sold out at once. The story is set in the 1740s, yet waltzes from a later Vienna run through it', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <장미의 기사>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 6, '1907년 뉴욕 메트가 한 번 올리고 27년 동안 다시 안 올린 오페라예요. <일곱 베일의 춤>은 동방풍 관현악으로 그려요', 'The Met staged it once in 1907, then not again for 27 years. The Dance of the Seven Veils is scored in an oriental style', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <살로메>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
