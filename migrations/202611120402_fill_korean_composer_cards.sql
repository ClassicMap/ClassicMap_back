-- 한국 작곡가(윤이상·홍난파·김동진) 작품 목록을 채운 뒤 「처음 듣는다면」 카드와 남은 사실 고침.
-- 자료·근거: seed_pipeline/curation/korean-cards-2026-11-12/(cards.json, build.py, README). 두 번 돌려도 같다.

-- 카드 작품 링크(트랙 목록으로 확인한 앨범). 비어 있을 때만.
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/isang-yun-my-land-my-people-exemplum-in-memoriam-kwangju/394685864'
WHERE composer_id = 90 AND title = '교향시 <광주여 영원히>' AND apple_music_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/korean-lyric-song-vol-1/1592912336'
WHERE composer_id = 89 AND title = '가곡 <성불사의 밤>' AND apple_music_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/korean-lyric-song-vol-1/1592912336'
WHERE composer_id = 89 AND title = '가곡 <옛 동산에 올라>' AND apple_music_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EA%B9%80%EB%8F%99%EC%A7%84-%EC%98%88%EC%88%A0%EA%B0%80%EA%B3%A1%EC%A7%91-%EA%B0%80%EA%B3%A0%ED%8C%8C-%EB%AA%A9%EB%A0%A8%ED%99%94/1746922365'
WHERE composer_id = 103 AND title = '가곡 <봄이 오면>' AND apple_music_url IS NULL;
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/%EA%B9%80%EB%8F%99%EC%A7%84-%EC%98%88%EC%88%A0%EA%B0%80%EA%B3%A1%EC%A7%91-%EA%B0%80%EA%B3%A0%ED%8C%8C-%EB%AA%A9%EB%A0%A8%ED%99%94/1746922365'
WHERE composer_id = 103 AND title = '가곡 <수선화>' AND apple_music_url IS NULL;

-- 사실 고침(지금 값일 때만)
-- 홍난파 344: 대백과(E0023929)는 「애수」를 『처녀혼』 서두의 「기악곡」이라고만 한다(바이올린 곡이라는 근거 없음).
UPDATE pieces SET title = '기악곡 <애수>' WHERE id = 344 AND composer_id = 89 AND title = '바이올린 소품 <애수>';
UPDATE pieces SET title_en = 'Instrumental Piece <Sorrow (Aesu)>' WHERE id = 344 AND composer_id = 89 AND title_en = 'Violin Piece <Sorrow (Aesu)>';
UPDATE composers SET style = REPLACE(style, '바이올린 소품 <애수>', '기악곡 <애수>'), style_en = REPLACE(style_en, 'the violin piece Aesu (Sorrow)', 'the instrumental piece Aesu (Sorrow)') WHERE id = 89 AND (style LIKE '%바이올린 소품 <애수>%' OR style_en LIKE '%the violin piece Aesu (Sorrow)%');
-- 홍난파 342 <봉선화>: 기악곡 「애수」(1920)에 1926년 김형준이 가사를 붙여 가곡이 됐다(대백과 E0023929).
UPDATE pieces SET composition_year = 1926 WHERE id = 342 AND composer_id = 89 AND title = '가곡 <봉선화>' AND composition_year = 1920;
-- 홍난파 343 <고향의 봄>: 1926 은 이원수의 시가 실린 해이고 작곡 연도 근거는 없다.
UPDATE pieces SET composition_year = NULL WHERE id = 343 AND composer_id = 89 AND title = '동요 <고향의 봄>' AND composition_year = 1926;
-- 윤이상 347: 새로 넣은 작품과 같은 관례(「관현악을 위한」)로.
UPDATE pieces SET title = '관현악을 위한 <예악>' WHERE id = 347 AND composer_id = 90 AND title = '오케스트라를 위한 <예악>';
UPDATE composer_highlights SET reason = '1920년 소설집 『처녀혼』 첫머리에 실렸다가 가사가 붙어 <봉선화>가 된 기악곡이에요. <봉선화> 선율이 가사 없이 흘러요', reason_en = 'An instrumental piece printed in 1920 at the front of his story collection; words added later made it Bongseonhwa. The same tune, without words'
WHERE composer_id = 89 AND piece_id = 344 AND source = 'auto' AND reason = '한국 서양음악 초창기의 바이올린 소품이에요. 바이올리니스트였던 홍난파의 짧은 곡이에요';

-- 카드
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '1980년 광주 민중항쟁을 기리며 이듬해 쓴 관현악곡이에요. 첫머리 G음 총주를 윤이상은 젊은이들의 결기라고 했어요', 'Written in 1981 in memory of the 1980 Gwangju uprising. Yun called the opening tutti strokes on G a symbol of young people''s resolve', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '교향시 <광주여 영원히>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 4, '미국 유학 중이던 1932년 무렵 이은상의 시조에 곡을 붙인 가곡이에요. 가단조 3박자의 기복 적은 선율이 두 절을 이어요', 'Set to a sijo by Yi Eun-sang around 1932, while Hong studied in the US. A calm A-minor tune in triple time carries two verses', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 89 AND p.title = '가곡 <성불사의 밤>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 5, '<성불사의 밤>과 함께 1933년 곡집에 실린 이은상 시조 가곡이에요. 이끈음을 빼 한국적 느낌을 낸 라단조 3박자 선율이에요', 'Published with Night at Seongbulsa in his 1933 collection, also to a sijo by Yi Eun-sang. The D-minor tune omits the leading tone for a Korean colour', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 89 AND p.title = '가곡 <옛 동산에 올라>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 2, '김동진이 이 곡을 계기로 작곡가의 길에 들어선 1931년 가곡이에요. 조금 느린 3박자로 세 절을 같은 선율에 불러요', 'The 1931 song that set Kim Dong-jin on the path to composing. Three verses share one tune in an unhurried triple time', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 103 AND p.title = '가곡 <봄이 오면>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)
SELECT p.composer_id, p.id, NULL, 3, '만주에서 바이올리니스트로 일하던 1941년 피아노를 치며 앞부분을 단숨에 썼다는 노래예요. 2박자에서 3박자로 박자가 바뀌어요', 'Written in 1941 while he played violin in Manchuria; he is said to have dashed off its opening at the piano. The metre shifts from two to three', 'editor', 'PUBLISHED'
FROM pieces p
WHERE p.composer_id = 103 AND p.title = '가곡 <수선화>' AND p.hidden_reason IS NULL
AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);
