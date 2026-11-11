-- 작품 목록을 채운 S·A 작곡가(2026-11-12) 중 「처음 듣는다면」 카드가 5장이 안 되던 작곡가의 카드와 그 작품 링크.
-- 자료·근거: seed_pipeline/curation/thin-cards-2026-11-12/(cards.json, build.py, README). 두 번 돌려도 같다.

-- 카드 작품 링크(트랙 목록으로 확인한 앨범). 비어 있을 때만.
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/vladimir-horowitz-live-at-carnegie-hall-recital-march/1102597360'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 24' AND apple_music_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-symphonies-nos-3-4/696107810'
WHERE composer_id = 25 AND title = '교향곡 3번 G장조 "그레이트 내셔널"' AND apple_music_url IS NULL;
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1GDQqQqHjMtBAY6TkeUsOO'
WHERE composer_id = 25 AND title = '교향곡 3번 G장조 "그레이트 내셔널"' AND spotify_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/johann-stamitz-orchestra-trios-volume-1/19554160'
WHERE composer_id = 24 AND title = '관현악 3중주 Op. 1' AND apple_music_url IS NULL;
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4R0Y6njtTZKZsQfRaNG5Fu'
WHERE composer_id = 24 AND title = '관현악 3중주 Op. 1' AND spotify_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/schoenberg-gurre-lieder/1698149575'
WHERE composer_id = 82 AND title = '<구레의 노래>' AND apple_music_url IS NULL;
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/1LFFqwIMAAcHihoybtPxSf'
WHERE composer_id = 82 AND title = '<구레의 노래>' AND spotify_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-%C3%A9tudes-m%C3%BAsica-ricercata/263084597'
WHERE composer_id = 499 AND title = '무지카 리체르카타' AND apple_music_url IS NULL;
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2N0KhIJJ0EaiDXJmxEj05T'
WHERE composer_id = 499 AND title = '무지카 리체르카타' AND spotify_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ligeti-%C3%A9tudes-for-piano/1817587131'
WHERE composer_id = 499 AND title = '피아노 연습곡 1권' AND apple_music_url IS NULL;
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/2N0KhIJJ0EaiDXJmxEj05T'
WHERE composer_id = 499 AND title = '피아노 연습곡 1권' AND spotify_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-edition-vol-1-dido-aeneas-king-arthur-the/337891588'
WHERE composer_id = 8 AND title = '세미 오페라 <아서 왕>' AND apple_music_url IS NULL;
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/07NkGhomfyF1SCxrJvZQxb'
WHERE composer_id = 8 AND title = '세미 오페라 <아서 왕>' AND spotify_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/monteverdi-l-ottavo-libro-de-madrigali-1638/696628286'
WHERE composer_id = 5 AND title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND apple_music_url IS NULL;

-- 카드
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 4, '1781년 빈 황제 앞 모차르트와의 대결에서 친 소나타가 든 곡집이에요. 2번 첫머리 동기가 훗날 <마술피리> 서곡에 나와요', 'Includes the sonata Clementi played in his 1781 Vienna contest with Mozart. The opening motif of No. 2 later appears in the Magic Flute overture', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 24' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '런던에 살던 클레멘티가 영국 국가 ''God Save the King''을 넣은 교향곡이에요. 느린 악장에서 국가 선율이 들려요', 'Clementi, long settled in London, built ''God Save the King'' into this symphony. The anthem tune surfaces in the slow movement', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 3번 G장조 "그레이트 내셔널"' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 4, '파리에서 성공한 뒤 낸 슈타미츠의 첫 출판 곡집이에요. 현악 합주로도, 파트마다 한 명씩 실내악으로도 연주해요', 'Stamitz''s first published set, issued after his Paris success. It can be played by a string orchestra or one player to a part', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 24 AND p.title = '관현악 3중주 Op. 1' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '1913년 빈 초연에서 환호받았지만 쇤베르크는 청중을 등지고 인사했어요. 끝에서 성악진 200명가량이 ''해를 보라!''를 불러요', 'Cheered at its 1913 Vienna premiere, though Schoenberg bowed with his back to the crowd. Some 200 singers end on ''See the sun!''', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '<구레의 노래>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 4, '곡마다 쓰는 음이 하나씩 늘어나는 11곡짜리 피아노 곡집이에요. 첫 곡은 거의 A음 하나로 가다가 마지막에야 D음이 나와요', 'Eleven piano pieces, each using one more pitch than the last. The first stays almost entirely on A until a final D', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무지카 리체르카타' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '18곡 피아노 연습곡의 첫 권(1985)이에요. 1번 ''무질서''는 오른손이 흰건반만, 왼손이 검은건반만 쳐요', 'The first book (1985) of his 18 piano études. In No. 1, ''Désordre'', the right hand plays only white keys, the left only black', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 1권' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '드라이든 대본으로 1691년 런던에서 올린 세미 오페라예요. 3막 서리 장면에서 추위의 정령이 떨리는 현악기 위로 노래해요', 'A semi-opera to Dryden''s text, staged in London in 1691. In the Act 3 Frost Scene the Cold Genius sings over shivering strings', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '세미 오페라 <아서 왕>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, (SELECT part.id FROM piece_parts part WHERE part.piece_id = p.id AND part.part_key = 'musicbrainz:1f66471e-05a5-4185-ba7b-f6a157bffbb6'), 5, '안에 든 <탕크레디와 클로린다의 결투>가 처음 피치카토를 악보에 적은 곡집이에요. 결투에서 현이 같은 음을 빠르게 두드려요', 'Its Combattimento di Tancredi e Clorinda has the first written-out pizzicato. In the duel the strings hammer repeated notes', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 4, '3번 알르망드의 연속 5도가 이론 논쟁을 부른 1685년 곡집이에요. 그 첫 네 마디에서 바이올린과 베이스가 5도로 내려가요', 'Published in 1685, its third sonata''s allemanda sparked a quarrel over parallel fifths. Violin and bass descend in fifths in its first bars', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
