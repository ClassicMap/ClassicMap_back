-- 나이먼 「Michael Nyman 1」~「Michael Nyman 6」은 영화 「Le Mari de la coiffeuse」(파트리스 르콩트, 1990)
-- 사운드트랙의 큐 트랙 이름이다. 작품마다 MusicBrainz 작품 → 녹음 → 음반이
-- 「Le mari de la coiffeuse」(1992·1998 발매)다. 제목에 영화를 밝히고(다른 영화 음악과 같은 꼴),
-- 작곡 연도를 넣는다. 한국 개봉 제목은 확인하지 못해 원제를 쓴다.
-- Apple Music 링크는 현악 사중주 음반 등 다른 작품을 가리켜 지운다. 사운드트랙은
-- Apple Music·Spotify 에서 찾지 못했다.
-- 지금 값이 예전 값과 같을 때만 바꾼다.

CREATE TEMPORARY TABLE tmp_nyman_cue (
    piece_id INT NOT NULL PRIMARY KEY,
    old_title VARCHAR(255) NOT NULL,
    old_apple VARCHAR(500) NOT NULL
);
INSERT INTO tmp_nyman_cue (piece_id, old_title, old_apple) VALUES
(18046, 'Michael Nyman 1', 'https://music.apple.com/us/album/nyman-string-quartets-nos-1-3/1452331921'),
(17114, 'Michael Nyman 2', 'https://music.apple.com/us/album/nyman-string-quartets-nos-1-3/1452331921'),
(18743, 'Michael Nyman 3', 'https://music.apple.com/us/album/nyman-string-quartets-nos-1-3/1452331921'),
(19299, 'Michael Nyman 4', 'https://music.apple.com/us/album/michael-nyman-string-quartet-no-5-ep/1825897741'),
(16126, 'Michael Nyman 5', 'https://music.apple.com/us/album/michael-nyman-string-quartet-no-5-ep/1825897741'),
(18947, 'Michael Nyman 6', 'https://music.apple.com/us/album/michael-nyman/1074794623');

UPDATE pieces piece
JOIN tmp_nyman_cue cue ON cue.piece_id = piece.id
SET piece.apple_music_url = NULL
WHERE piece.apple_music_url = cue.old_apple;

UPDATE pieces piece
JOIN tmp_nyman_cue cue ON cue.piece_id = piece.id
SET piece.title = CONCAT('영화 <Le Mari de la coiffeuse> 사운드트랙: ', cue.old_title),
    piece.title_en = CONCAT('Le Mari de la coiffeuse: ', cue.old_title),
    piece.composition_year = COALESCE(piece.composition_year, 1990)
WHERE piece.title = cue.old_title AND piece.title_en = cue.old_title;

DROP TEMPORARY TABLE tmp_nyman_cue;
