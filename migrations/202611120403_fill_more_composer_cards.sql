-- S·A 작곡가 중 「처음 듣는다면」 카드가 5장 미만이던 작곡가(목록은 있음)의 카드와 그 작품 링크.
-- 자료·근거: seed_pipeline/curation/more-cards-2026-11-12/(cards.json, build.py, README). 두 번 돌려도 같다.

-- 카드 작품 링크(트랙 목록으로 확인한 앨범). 비어 있을 때만.
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/gluck-paride-et-elena/1452180286'
WHERE composer_id = 21 AND title = '오페라 <파리데와 엘레나>' AND apple_music_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/david-oistrakh-concertos-and-encores/1452201536'
WHERE composer_id = 35 AND title = '<모세> 환상곡' AND apple_music_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/glinka-orchestral-works/1761677764'
WHERE composer_id = 38 AND title = '관현악 환상곡 <카마린스카야>' AND apple_music_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clara-schumann-piano-music-vol-1/1784717778'
WHERE composer_id = 39 AND title = '로베르트 슈만 주제에 의한 변주곡 F#단조' AND apple_music_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/ives-central-park-in-the-dark/1452679965'
WHERE composer_id = 98 AND title = 'Central Park in the Dark' AND apple_music_url IS NULL;

-- 카드
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '<오르페오>·<알체스테>에 이어 칼차비지와 만든 세 번째 개혁 오페라예요. 1막에서 파리스가 단조 아리아로 사랑을 고백해요', 'Gluck''s third Vienna reform opera with Calzabigi, after Orfeo and Alceste. In Act 1 Paris declares his love in a minor-key aria', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 21 AND p.title = '오페라 <파리데와 엘레나>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 4, '바이올린 맨 아래 G현 하나로만 연주하는 변주곡이에요. 로시니 오페라 <이집트의 모세>의 선율이 낮은 현에서 노래해요', 'Variations played entirely on the violin''s lowest string, the G. A tune from Rossini''s Moses in Egypt sings on that single string', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<모세> 환상곡' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '차이콥스키가 ''도토리 속 참나무처럼 러시아 교향악이 다 들었다''고 한 곡이에요. 민요 두 곡이 되풀이되며 반주만 바뀌어요', 'Tchaikovsky said Russian symphonic music lay in it like an oak in an acorn. Two folk tunes repeat while the accompaniment keeps changing', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 38 AND p.title = '관현악 환상곡 <카마린스카야>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '로베르트의 마흔세 번째 생일 선물로 쓴 변주곡이에요. 이듬해 브람스가 같은 주제로 변주곡을 써 클라라에게 바쳤어요', 'Written as a gift for Robert''s 43rd birthday. The next year Brahms wrote variations on the same theme and dedicated them to Clara', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '로베르트 슈만 주제에 의한 변주곡 F#단조' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '피아노 연탄 12곡 가운데 다섯 곡을 비제가 관현악 <작은 모음곡>으로 옮겼어요. ''팽이''는 빙글빙글 도는 팽이를 그려요', 'Bizet orchestrated five of these twelve piano-duet miniatures as his Petite Suite. ''La toupie'' pictures a spinning top', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = '모음곡 <어린이의 놀이>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 3, '독일 할버슈타트 교회에서 2001년 시작한 오르간 연주가 2640년까지 이어지는 곡이에요. 몇 해에 한 번씩 화음이 바뀌어요', 'An organ performance of it in Halberstadt, Germany, began in 2001 and is set to end in 2640. The chord changes only every few years', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'ASLSP' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 4, '<주역>으로 점을 쳐 음·길이·셈여림을 정한 1951년 피아노곡이에요. 데이비드 튜더를 위해 네 권으로 썼어요', 'A 1951 piano work whose pitches, durations and dynamics were chosen by consulting the I Ching. Written in four books for David Tudor', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Music of Changes' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '더 많은 사람에게 들려주려고 1981년 음반사 의뢰로 쓴 소품 모음이에요. 첫 곡 ''Opening''은 피아노 독주로 시작해요', 'Short pieces written in 1981 at his label''s request to reach a wider audience. The first, ''Opening'', is for solo piano', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Glassworks' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '<대답 없는 질문>과 짝을 이루는 1906년 곡이에요. 밤을 그리는 조용한 현 위로 래그타임 피아노와 거리 악대가 끼어들어요', 'A 1906 companion piece to The Unanswered Question. Quiet strings paint the night while ragtime pianos and a street band break in', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 98 AND p.title = 'Central Park in the Dark' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '하차투리안을 처음 서방에 알린 1936년 협주곡이에요. 2악장에는 악보에 ''플렉사톤''으로 적힌 뮤지컬 소가 나와요', 'The 1936 concerto that first made Khachaturian known in the West. Its slow movement calls for a ''flexatone'', usually a musical saw', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 101 AND p.title = '피아노 협주곡 D♭장조' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
