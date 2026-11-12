-- 0601·0602 를 하다 새로 본 틀린 작품 링크를 바꾸고, 새 앨범에서 그 작품의 빈 안 곡 링크를 채운다.
-- 몬테베르디 「저녁 기도」(18) Spotify(한 곡짜리 앨범), 텔레만 리코더 모음곡(54) Spotify(다섯 곡짜리 모음 EP),
-- 텔레만 「돈키호테 풍자극」(55) Apple(이 작품이 없는 음반)·Spotify(다른 모음곡 한 악장).
-- 바꾸는 것은 지금 값이 그때 본 값과 같을 때만, 채우는 것은 비어 있을 때만. 안 곡은 작품을 다 담은 앨범에서만 붙였다.
-- 자료·까닭: seed_pipeline/curation/old-link-fixes-2026-11-12/(README, fixes-0603.tsv, decisions-0603.jsonl). 두 번 돌려도 같다.
-- part apple fill 6, part spotify fill 20, piece apple replace 1, piece spotify replace 3

-- 18 Vespro della Beata Vergine (spotify replace: Monteverdi: Vespro della Beata Vergine, SV 206)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/5IfcZx8SGaON3hSnnE7uZg' WHERE id = 18 AND composer_id = 5 AND spotify_url = 'https://open.spotify.com/album/2vDo3uvmYcIqRd4sNC2mN1';
-- 54 Suite in A minor for Recorder and Strings (spotify replace: Telemann, G.P.: Overtures (Suites) - Twv 55: A2, Es2, F14)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4uDoWn0SqQh9hdJdS2tv9k' WHERE id = 54 AND composer_id = 11 AND spotify_url = 'https://open.spotify.com/album/4UDKEL4W75R2yvXMaclric';
-- 55 Burlesque de Quixotte (apple replace: Telemann: Don Quixote and Other Suites & Concertos)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-don-quixote-and-other-suites-concertos/1126477482' WHERE id = 55 AND composer_id = 11 AND apple_music_url = 'https://music.apple.com/us/album/telemann-recorder-suite-in-a-minor-viola-concerto/516997994';
-- 55 Burlesque de Quixotte (spotify replace: Telemann: Don Quixote and Other Suites & Concertos)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/51Do5nXsTvTJ6PJJOXGtyt' WHERE id = 55 AND composer_id = 11 AND spotify_url = 'https://open.spotify.com/album/1iTmIWpP79rZclqBs5XzEw';

UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/7dE8l7hR5WdxmlKH8BJd0R' WHERE id = 62277 AND piece_id = 18 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/5XIRrvaq6hROi3TSduF7UX' WHERE id = 62278 AND piece_id = 18 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/55vkoIGKbO5fvkRe9uvICj' WHERE id = 62279 AND piece_id = 18 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/3W1QzjysiieZKW94PiGMYy' WHERE id = 62280 AND piece_id = 18 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/3e6d09CSGyHBl8IwDpvhml' WHERE id = 62282 AND piece_id = 18 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/3ygSqt8L0uVhVUWDg5aaUs' WHERE id = 62283 AND piece_id = 18 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/1KmePHlIvdvy9g7SgJY68o' WHERE id = 62287 AND piece_id = 18 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/7JU1EjdTCLWdcwuwmU4kml' WHERE id = 61123 AND piece_id = 54 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/2kXoJzBS7vzSKB4uE5zUq8' WHERE id = 61124 AND piece_id = 54 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/4DQzX550Ug3IfwKw43rvfZ' WHERE id = 61125 AND piece_id = 54 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/3b2sjH7cjE3gDB9eWe5HqI' WHERE id = 61126 AND piece_id = 54 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/7nguhhXp0wdkHM3irozWO7' WHERE id = 61127 AND piece_id = 54 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/3voqdleCya0QSsidr0AA6g' WHERE id = 61128 AND piece_id = 54 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/2tayQOODNbOHzIwD5UQtT7' WHERE id = 61129 AND piece_id = 54 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET apple_music_url = 'https://music.apple.com/us/album/ouverture-suite-twv-55-g10-burlesque-de-quixotte-i/1126477482?i=1126477999' WHERE id = 61130 AND piece_id = 55 AND (apple_music_url IS NULL OR apple_music_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/6EgZydzkyiF8OshwPKhwRU' WHERE id = 61130 AND piece_id = 55 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET apple_music_url = 'https://music.apple.com/us/album/ouverture-suite-twv-55-g10-burlesque-de-quixotte-ii/1126477482?i=1126478003' WHERE id = 61131 AND piece_id = 55 AND (apple_music_url IS NULL OR apple_music_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/4gbsDCwB934UAGL1xSlXYO' WHERE id = 61131 AND piece_id = 55 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET apple_music_url = 'https://music.apple.com/us/album/ouverture-suite-twv-55-g10-burlesque-de-quixotte-iv/1126477482?i=1126478015' WHERE id = 61133 AND piece_id = 55 AND (apple_music_url IS NULL OR apple_music_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/1UGUaYL42qzHs9569GuzNf' WHERE id = 61133 AND piece_id = 55 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET apple_music_url = 'https://music.apple.com/us/album/ouverture-suite-twv-55-g10-burlesque-de-quixotte-v/1126477482?i=1126478086' WHERE id = 61134 AND piece_id = 55 AND (apple_music_url IS NULL OR apple_music_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/7HnbABSvPHirMnNTZFDJwN' WHERE id = 61134 AND piece_id = 55 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET apple_music_url = 'https://music.apple.com/us/album/ouverture-suite-twv-55-g10-burlesque-de-quixotte-vi/1126477482?i=1126478253' WHERE id = 61135 AND piece_id = 55 AND (apple_music_url IS NULL OR apple_music_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/70MSUars1qTU4qAjT1zgdR' WHERE id = 61135 AND piece_id = 55 AND (spotify_url IS NULL OR spotify_url = '');
UPDATE piece_parts SET apple_music_url = 'https://music.apple.com/us/album/ouverture-suite-twv-55-g10-burlesque-de-quixotte-vii/1126477482?i=1126478270' WHERE id = 61136 AND piece_id = 55 AND (apple_music_url IS NULL OR apple_music_url = '');
UPDATE piece_parts SET spotify_url = 'https://open.spotify.com/track/3stXJpXQhVbVm6wU9IwFnW' WHERE id = 61136 AND piece_id = 55 AND (spotify_url IS NULL OR spotify_url = '');
