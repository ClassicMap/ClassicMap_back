-- 세트 안 곡(최상위 part)에 Apple Music 트랙 링크를 채운다. 자료와 규칙은
-- seed_pipeline/curation/piece-link-audit-2026-11-09/(match.py, apple-review-part-matches.jsonl).
-- 앨범 링크가 있는 세트의 곡 87곡 중 43곡.
-- 이미 링크가 있는 곡은 그대로 두고, id 와 함께 작품·순서가 같은 최상위 곡에만 넣는다.
-- 두 번 넣어도 같다.

CREATE TEMPORARY TABLE tmp_part_apple (
    part_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    piece_id INT NOT NULL,
    sequence_number INT NOT NULL,
    url VARCHAR(500) NOT NULL
);
INSERT INTO tmp_part_apple (part_id, piece_id, sequence_number, url) VALUES
(12901, 10321, 1, 'https://music.apple.com/us/album/piano-concerto-no-3-movement-i/1356328954?i=1356328958'),
(15280, 10321, 3, 'https://music.apple.com/us/album/piano-concerto-no-3-movement-iii-for-arvo-p-rt/1356328954?i=1356328960'),
(19456, 11511, 1, 'https://music.apple.com/us/album/2-cadenzas-in-g-major-woo-12-for-beethoven-s-piano-concerto-in-g-major-op-58-no-1-first-movement-cadenza/1313054380?i=1313057285'),
(20230, 11511, 2, 'https://music.apple.com/us/album/2-cadenzas-in-g-major-woo-12-for-beethoven-s-piano-concerto-in-g-major-op-58-no-2-third-movement-cadenza/1313054380?i=1313057286'),
(22994, 13508, 1, 'https://music.apple.com/us/album/five-preludes-i-allegro-moderato-e-scherzando/1452513200?i=1452514570'),
(27928, 16254, 1, 'https://music.apple.com/us/album/expressions-excerpts-no-2-calm-and-deeply-expressive/1642948701?i=1642948720'),
(28397, 16254, 2, 'https://music.apple.com/us/album/expressions-excerpts-no-12-rather-slow/1642948701?i=1642948795'),
(31034, 16254, 4, 'https://music.apple.com/us/album/expressions-excerpts-no-10-very-lively/1642948701?i=1642948725'),
(27596, 17710, 1, 'https://music.apple.com/us/album/english-folk-songs-o-waly-waly/1586966394?i=1586966828'),
(30981, 17710, 2, 'https://music.apple.com/us/album/english-folk-songs-i-am-a-poor-wayfaring-stranger-arr-leo-brouwer/1586966394?i=1586966657'),
(31708, 17710, 3, 'https://music.apple.com/us/album/english-folk-songs-down-by-the-salley-gardens-arr-leo-brouwer/1586966394?i=1586966667'),
(27745, 17957, 4, 'https://music.apple.com/us/album/water-dances-gliding/714416799?i=714418320'),
(28308, 17957, 2, 'https://music.apple.com/us/album/water-dances-stroking/714416799?i=714418307'),
(28717, 17957, 5, 'https://music.apple.com/us/album/water-dances-synchronising/714416799?i=714418430'),
(39867, 26449, 1, 'https://music.apple.com/us/album/two-minuets-k-604-no-1-in-b-flat-major/1453069508?i=1453089204'),
(39868, 26449, 2, 'https://music.apple.com/us/album/two-minuets-k-604-no-2-in-e-flat-major/1453069508?i=1453083043'),
(41636, 27162, 1, 'https://music.apple.com/us/album/string-quartet-no-45-in-a-major-op-55-no-1-hob-iii-60-i-allegro/295538611?i=295539377'),
(41641, 27162, 2, 'https://music.apple.com/us/album/string-quartet-no-46-in-f-minor-op-55-no-2-hob-iii-61-the-razor-i-andante-o-piu-tosto-allegretto/295538611?i=295539325'),
(41646, 27162, 3, 'https://music.apple.com/us/album/string-quartet-no-47-in-b-flat-major-op-55-no-3-hob-iii-62-i-vivace-assai/295538611?i=295539386'),
(42937, 27596, 1, 'https://music.apple.com/us/album/sechs-gedichte-von-nikolaus-lenau-und-requiem-op-90-1-lied-eines-schmiedes/1581392784?i=1581394339'),
(42938, 27596, 2, 'https://music.apple.com/us/album/sechs-gedichte-von-nikolaus-lenau-und-requiem-op-90-2-meine-rose/1581392784?i=1581394340'),
(42939, 27596, 3, 'https://music.apple.com/us/album/sechs-gedichte-von-nikolaus-lenau-und-requiem-op-90-3-kommen-und-scheiden/1581392784?i=1581394341'),
(42940, 27596, 4, 'https://music.apple.com/us/album/sechs-gedichte-von-nikolaus-lenau-und-requiem-op-90-4-die-sennin/1581392784?i=1581394342'),
(42941, 27596, 5, 'https://music.apple.com/us/album/sechs-gedichte-von-nikolaus-lenau-und-requiem-op-90-5-einsamkeit/1581392784?i=1581394343'),
(42942, 27596, 6, 'https://music.apple.com/us/album/sechs-gedichte-von-nikolaus-lenau-und-requiem-op-90-6-der-schwere-abend/1581392784?i=1581394344'),
(42943, 27596, 7, 'https://music.apple.com/us/album/sechs-gedichte-von-nikolaus-lenau-und-requiem-op-90-requiem/1581392784?i=1581394345'),
(42955, 27601, 1, 'https://music.apple.com/us/album/drei-ges-nge-aus-lord-byrons-hebr-ischen-ges-ngen-op-95-1-die-tochter-jephta-s/1581392784?i=1581393666'),
(42956, 27601, 2, 'https://music.apple.com/us/album/drei-ges-nge-aus-lord-byrons-hebr-ischen-ges-ngen-op-95-2-an-den-mond/1581392784?i=1581393668'),
(42957, 27601, 3, 'https://music.apple.com/us/album/drei-ges-nge-aus-lord-byrons-hebr-ischen-ges-ngen-op-95-3-dem-helden/1581392784?i=1581393673'),
(43044, 27620, 1, 'https://music.apple.com/us/album/drei-lieder-op-114-1-n-nie/1581392784?i=1581394216'),
(43045, 27620, 2, 'https://music.apple.com/us/album/drei-lieder-op-114-2-triolett/1581392784?i=1581394217'),
(43046, 27620, 3, 'https://music.apple.com/us/album/drei-lieder-op-114-3-spruch/1581392784?i=1581394218'),
(43099, 27631, 1, 'https://music.apple.com/us/album/f-nf-heitere-ges-nge-op-125-3-die-meerfee/1581392784?i=1581393972'),
(43100, 27631, 2, 'https://music.apple.com/us/album/f-nf-heitere-ges-nge-op-125-5-husarenabzug/1581392784?i=1581393974'),
(43101, 27631, 3, 'https://music.apple.com/us/album/f-nf-heitere-ges-nge-op-125-4-jung-volkers-lied/1581392784?i=1581393973'),
(43102, 27631, 4, 'https://music.apple.com/us/album/f-nf-heitere-ges-nge-op-125-1-fr-hlingslied/1581392784?i=1581393970'),
(43103, 27631, 5, 'https://music.apple.com/us/album/f-nf-heitere-ges-nge-op-125-2-fr-hlingslust-aus-dem-jungbrunnen/1581392784?i=1581393971'),
(50371, 31965, 1, 'https://music.apple.com/us/album/ten-easy-pieces-sz-39-bb-51-aj-nl-s-dedication/1452428753?i=1452430835'),
(50372, 31965, 2, 'https://music.apple.com/us/album/ten-easy-pieces-sz-39-bb-51-i-parazsti-n-ta-peasant-song/1452428753?i=1452430839'),
(50377, 31965, 7, 'https://music.apple.com/us/album/ten-easy-pieces-sz-39-bb-51-vi-g-d-llei-piact-re-leesett-a-h-hungarian-folksong/1452428753?i=1452430634'),
(50379, 31965, 9, 'https://music.apple.com/us/album/ten-easy-pieces-sz-39-bb-51-viii-azt-mondj-k-nem-adnak-slovakian-folksong/1452428753?i=1452430826'),
(50380, 31965, 10, 'https://music.apple.com/us/album/ten-easy-pieces-sz-39-bb-51-ix-ujjgyakorlat-five-finger-exercise/1452428753?i=1452430832'),
(50381, 31965, 11, 'https://music.apple.com/us/album/ten-easy-pieces-sz-39-bb-51-x-medvet-nc-bear-dance/1452428753?i=1452430636');

UPDATE piece_parts part
JOIN tmp_part_apple link
    ON link.part_id = part.id
    AND link.piece_id = part.piece_id
    AND link.sequence_number = part.sequence_number
SET part.apple_music_url = link.url
WHERE part.apple_music_url IS NULL
    AND part.parent_part_id IS NULL;

DROP TEMPORARY TABLE tmp_part_apple;
