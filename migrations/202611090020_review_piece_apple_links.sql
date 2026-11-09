-- 애매한 작품 Apple Music 링크를 근거를 보고 바로잡는다. 자료와 근거는
-- seed_pipeline/curation/piece-link-audit-2026-11-09/
-- (review-decisions.jsonl, apply_review.py).
-- 바꿈 20곳, 지움 30곳.
-- 지금 값이 판정 때 본 값과 같을 때만 바꾸고, 그 작품의 곡 링크는 비운다
-- (새 앨범에서 다시 채움).

CREATE TEMPORARY TABLE tmp_review_piece_apple (
    piece_id INT NOT NULL PRIMARY KEY,
    old_url VARCHAR(500) NOT NULL,
    new_url VARCHAR(500) NULL
);
INSERT INTO tmp_review_piece_apple (piece_id, old_url, new_url) VALUES
(391, 'https://music.apple.com/us/album/arnold-beckus-the-dandipratt-dances-sinfonietta-no-1/1460056397', NULL),
(408, 'https://music.apple.com/us/album/stockhausen-klavierst%C3%BCcke-beethoven-sonaten/990479962', 'https://music.apple.com/us/album/stockhausen-stimmung/586057651'),
(1637, 'https://music.apple.com/us/album/lutos%C5%82awski-concerto-for-orchestra-jan%C3%A1%C4%8Dek-sinfonietta/1463603543', 'https://music.apple.com/us/album/lutoslawski-piano-concerto/1452526988'),
(1696, 'https://music.apple.com/us/album/piazzolla-suite-for-oboe-and-string-orchestra-las/314272277', NULL),
(1857, 'https://music.apple.com/us/album/rachmaninoff-4-pieces-tn-ii-12-no-1-romance-single/1736158365', NULL),
(2481, 'https://music.apple.com/us/album/britten-variations-on-a-theme-by-frank-bridge/696673016', 'https://music.apple.com/us/album/britten-chamber-instrumental-works/725948330'),
(2520, 'https://music.apple.com/us/album/khachaturian-ballet-music/194421758', 'https://music.apple.com/us/album/khachaturian-a-i-spartacus-suite-no-4-masquerade-circus/363085747'),
(2711, 'https://music.apple.com/us/album/beton-studie-ep/1313407025', NULL),
(2751, 'https://music.apple.com/us/album/vaughan-williams-fantasia-on-a-theme-by-thomas/1593007673', NULL),
(2907, 'https://music.apple.com/us/album/bach-partitas-sonata-bernstein-serenade-beethoven-stravinsky/534049139', NULL),
(7809, 'https://music.apple.com/us/album/nightmare-single/1673944125', NULL),
(8174, 'https://music.apple.com/us/album/ravel-five-oclock-foxtrot-bol%C3%A9ro-pavane-for-a-dead/307063314', 'https://music.apple.com/us/album/ravel-l-enfant-et-les-sortileges-ma-mere-l-oye/1452154922'),
(8368, 'https://music.apple.com/us/album/alb%C3%A9niz-serenata/544667811', NULL),
(9180, 'https://music.apple.com/us/album/vaughan-williams-fantasia-on-a-theme-by-thomas/1106003785', NULL),
(10057, 'https://music.apple.com/us/album/i-knew/69819274', NULL),
(10321, 'https://music.apple.com/us/album/philip-glass-violin-concerto-company-prelude-from-akhnaten/407772704', 'https://music.apple.com/us/album/circles-piano-concertos-by-bach-glass/1356328954'),
(10405, 'https://music.apple.com/us/album/mahler-g-symphony-no-3-in-d-minor-schubert-rosamunde/342853606', 'https://music.apple.com/us/album/kremerata-musica-mahler-schonberg-berg-webern/1452144191'),
(10679, 'https://music.apple.com/us/album/frederic-belli-plays-works-by-berio-rabe-martin-delerue/416113879', NULL),
(11558, 'https://music.apple.com/us/album/gustav-mahler-lieder/1456709604', NULL),
(12974, 'https://music.apple.com/us/album/c-p-e-bach-double-concertos/326475999', NULL),
(13508, 'https://music.apple.com/us/album/william-kapell-edition-vol-3-rachmaninoff-concerto/380153269', 'https://music.apple.com/us/album/shostakovich-solo-piano-works/1452513200'),
(14034, 'https://music.apple.com/us/album/grieg-piano-transcriptions-of-songs-op-41-no-3-jeg/1792219172', NULL),
(15787, 'https://music.apple.com/us/album/enescu-romanian-rhapsody-no-1-hindemith-philharmonisches/918267708', 'https://music.apple.com/us/album/japanese-orchestral-favourites/466154484'),
(15898, 'https://music.apple.com/us/album/etudes-for-string-orchestra-concerto-for-violin-and/55172908', NULL),
(16254, 'https://music.apple.com/us/album/hakim-plays-hakim-the-van-den-heuvel-organ-of/418697338', 'https://music.apple.com/us/album/rhapsody/1642948701'),
(16423, 'https://music.apple.com/us/album/you-cant-do-that-on-stage-anymore-vol-1-live/1443109235', 'https://music.apple.com/us/album/waka-wazoo/1648828930'),
(16728, 'https://music.apple.com/us/album/vivaldi-concertos-for-2-violins/1402984835', NULL),
(16955, 'https://music.apple.com/us/album/van-de-vate-music-for-viola-percussion-and-piano/493686814', NULL),
(17168, 'https://music.apple.com/us/album/roberto-milano-sinfonietta-no-1-childhood-memories/1612653948', NULL),
(17241, 'https://music.apple.com/us/album/have-i-offended-someone/1444079989', 'https://music.apple.com/us/album/sheik-yerbouti/1440930094'),
(17450, 'https://music.apple.com/us/album/tansman-a-triptyque-laks-s-sinfonietta-fitelberg-j/360963403', NULL),
(17710, 'https://music.apple.com/us/album/folk-songs-obras-de-leo-brouwer/1094234875', 'https://music.apple.com/us/album/bach-brouwer-canciones/1586966394'),
(17908, 'https://music.apple.com/us/album/malipiero-concerto-no-6-for-piano-and-orchestra/695149486', NULL),
(17957, 'https://music.apple.com/us/album/michael-nyman-the-piano-concerto-where-the-bee-dances/3052508', 'https://music.apple.com/us/album/the-kiss-and-other-movements/714416799'),
(18210, 'https://music.apple.com/us/album/still-symphony-no-2-dawson-negro-folk-symphony-ellington/1761658810', 'https://music.apple.com/us/album/vintage-america/166021338'),
(18864, 'https://music.apple.com/us/album/forever-single/1576814266', NULL),
(18988, 'https://music.apple.com/us/album/kevin-volans-hunting-gathering-string-quartet-no-2-single/79658644', NULL),
(19324, 'https://music.apple.com/us/album/over-nite-sensation-50th-anniversary/1699704883', 'https://music.apple.com/us/album/joe-s-garage-acts-i-ii-iii/1443266937'),
(19583, 'https://music.apple.com/us/album/borsotti-twelve-bizarre-studies-for-guitar-tribute/921502913', 'https://music.apple.com/us/album/meat-light-the-uncle-meat-project-object/1443011528'),
(23064, 'https://music.apple.com/us/album/aho-clarinet-quintet-trio-for-clarinet-viola-and/1727225679', 'https://music.apple.com/us/album/kalevi-aho-piano-works/1225717198'),
(23666, 'https://music.apple.com/us/album/aho-concerto-for-soprano-saxophone-chamber-orchestra/1725555239', NULL),
(23953, 'https://music.apple.com/us/album/aho-concerto-for-soprano-saxophone-chamber-orchestra/1725555239', NULL),
(24482, 'https://music.apple.com/us/album/harrison-for-strings/1401579913', 'https://music.apple.com/us/album/lou-harrison-suite-from-the-marriage-at-the-eiffel-tower/286186199'),
(24941, 'https://music.apple.com/us/album/caprica-main-theme-for-solo-piano-bear-mccreary-single/543016023', NULL),
(24960, 'https://music.apple.com/us/album/aho-moonlight-concerto-alto-flute-concerto/1823960782', NULL),
(25461, 'https://music.apple.com/us/album/aho-concerto-for-soprano-saxophone-chamber-orchestra/1725555239', NULL),
(25768, 'https://music.apple.com/us/album/aho-concerto-for-soprano-saxophone-chamber-orchestra/1725555239', NULL),
(26010, 'https://music.apple.com/us/album/aho-concerto-for-soprano-saxophone-chamber-orchestra/1725555239', NULL),
(28738, 'https://music.apple.com/us/album/tomaso-albinoni-sonate-a-tre-op-1-nos-4-5-6-7-antonio-vivaldi-violin-sonatas-rv-12-rv-26-rv-17a/1622557693', 'https://music.apple.com/us/album/vivaldi-trio-sonatas-op-1/969394731'),
(29440, 'https://music.apple.com/us/album/bach-beethoven-medtner/1141976829', NULL);

UPDATE piece_parts part
JOIN tmp_review_piece_apple fix ON fix.piece_id = part.piece_id
JOIN pieces piece ON piece.id = fix.piece_id
SET part.apple_music_url = NULL
WHERE piece.apple_music_url = fix.old_url;

UPDATE pieces piece
JOIN tmp_review_piece_apple fix ON fix.piece_id = piece.id
SET piece.apple_music_url = fix.new_url
WHERE piece.apple_music_url = fix.old_url;

DROP TEMPORARY TABLE tmp_review_piece_apple;
