-- 브람스 「2개의 가보트」 WoO 3 의 1·2번 조성이 뒤바뀌어 있었다. 1번이 A단조, 2번이 A장조다
-- (IMSLP「2 Gavottes, WoO 3」, Piano Library「Two Gavottes, WoO 3: 1. A minor 2. A major」,
-- 앨범 트랙도 같다). 곡 이름을 고친다.
-- 조성이 어긋나 곡 링크 매칭이 막혀 있었으므로, 고친 이름으로 작품 앨범에서 번호로 찾은
-- 트랙 링크를 채운다(seed_pipeline/curation/piece-link-audit-2026-11-09/README.md 「데이터 바로잡기」).
-- 지금 값이 예전 값과 같을 때만 바꾸고, 링크는 빈칸일 때만 채운다.

UPDATE piece_parts
SET name_en = 'No. 1 in A minor', name_ko = 'A단조'
WHERE id = 18334 AND piece_id = 11515 AND sequence_number = 1
    AND name_en = 'No. 1 in A major' AND name_ko = 'A장조';

UPDATE piece_parts
SET name_en = 'No. 2 in A major', name_ko = 'A장조'
WHERE id = 18199 AND piece_id = 11515 AND sequence_number = 2
    AND name_en = 'No. 2 in A minor' AND name_ko = 'A단조';

UPDATE piece_parts
SET apple_music_url = 'https://music.apple.com/us/album/2-gavottes-woo-3-no-1-in-a-minor/975584268?i=975584479'
WHERE id = 18334 AND piece_id = 11515 AND apple_music_url IS NULL;

UPDATE piece_parts
SET apple_music_url = 'https://music.apple.com/us/album/2-gavottes-woo-3-no-2-in-a-major/975584268?i=975584480'
WHERE id = 18199 AND piece_id = 11515 AND apple_music_url IS NULL;

UPDATE piece_parts
SET spotify_url = 'https://open.spotify.com/track/3BoOlQFwG5jLbQglhzY8Fc'
WHERE id = 18334 AND piece_id = 11515 AND spotify_url IS NULL;

UPDATE piece_parts
SET spotify_url = 'https://open.spotify.com/track/2A7RX1RU70Kz5NZOBak5Ey'
WHERE id = 18199 AND piece_id = 11515 AND spotify_url IS NULL;
