-- 곡 안 곡(악장 등)과 그 곡을 가진 곡에 Apple Music 트랙 링크를 채운다. 자료와 규칙은
-- seed_pipeline/curation/piece-link-audit-2026-11-09/(match.py, apple-nested-matches.jsonl).
-- 앨범 링크가 있는 세트의 곡 331곡 중 54곡.
-- 이미 링크가 있는 곡은 그대로 두고, id 와 함께 작품·부모 곡·순서가 같은 곡에만 넣는다.
-- 두 번 넣어도 같다.

CREATE TEMPORARY TABLE tmp_part_apple (
    part_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    piece_id INT NOT NULL,
    sequence_number INT NOT NULL,
    parent_part_id BIGINT UNSIGNED NULL,
    url VARCHAR(500) NOT NULL
);
INSERT INTO tmp_part_apple (part_id, piece_id, sequence_number, parent_part_id, url) VALUES
(52793, 14, 2, NULL, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-2-in-f-major-bwv-1047-i-allegro/695459070?i=695459132'),
(52794, 14, 1, 52793, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-2-in-f-major-bwv-1047-i-allegro/695459070?i=695459132'),
(52795, 14, 2, 52793, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-2-in-f-major-bwv-1047-ii-andante/695459070?i=695459150'),
(52796, 14, 3, 52793, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-2-in-f-major-bwv-1047-iii-allegro-assai/695459070?i=695459171'),
(52797, 14, 3, NULL, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-3-in-g-major-bwv-1048-i-allegro/695459070?i=695459173'),
(52798, 14, 1, 52797, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-3-in-g-major-bwv-1048-i-allegro/695459070?i=695459173'),
(52801, 14, 4, NULL, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-4-in-g-major-bwv-1049-i-allegro/695459070?i=695459192'),
(52802, 14, 1, 52801, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-4-in-g-major-bwv-1049-i-allegro/695459070?i=695459192'),
(52803, 14, 2, 52801, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-4-in-g-major-bwv-1049-ii-andante/695459070?i=695459205'),
(52804, 14, 3, 52801, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-4-in-g-major-bwv-1049-iii-presto/695459070?i=695459207'),
(52805, 14, 5, NULL, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-5-in-d-major-bwv-1050-i-allegro/695459070?i=695459222'),
(52806, 14, 1, 52805, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-5-in-d-major-bwv-1050-i-allegro/695459070?i=695459222'),
(52807, 14, 2, 52805, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-5-in-d-major-bwv-1050-ii-affetuoso/695459070?i=695459224'),
(52808, 14, 3, 52805, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-5-in-d-major-bwv-1050-iii-allegro/695459070?i=695459226'),
(52809, 14, 6, NULL, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-6-in-b-flat-major-bwv-1051-i-allegro/695459070?i=695459409'),
(52810, 14, 1, 52809, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-6-in-b-flat-major-bwv-1051-i-allegro/695459070?i=695459409'),
(52811, 14, 2, 52809, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-6-in-b-flat-major-bwv-1051-ii-adagio-ma-non-tanto/695459070?i=695459414'),
(52812, 14, 3, 52809, 'https://music.apple.com/us/album/brandenburg-concertos-bwv-1046-1051-brandenburg-concerto-no-6-in-b-flat-major-bwv-1051-iii-allegro/695459070?i=695459417'),
(13, 794, 2, NULL, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-1-scene-1-the-journey/1616664867?i=1616664870'),
(14, 794, 2, 13, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-1-scene-2-the-welcome/1616664867?i=1616664872'),
(26, 794, 3, NULL, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-2-scene-1-colloquy-and-soliloquy/1616664867?i=1616665006'),
(27, 794, 6, 26, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-2-scene-6-the-piano/1616664867?i=1616665016'),
(176, 794, 2, 26, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-2-scene-2-the-bells/1616664867?i=1616665008'),
(244, 794, 3, 13, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-1-scene-3-the-letter/1616664867?i=1616664874'),
(453, 794, 8, 26, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-2-scene-8-miles/1616664867?i=1616665021'),
(724, 794, 4, 26, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-2-scene-4-the-bedroom/1616664867?i=1616665012'),
(1226, 794, 1, 26, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-2-scene-1-colloquy-and-soliloquy/1616664867?i=1616665006'),
(2914, 794, 5, 26, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-2-scene-5-quint/1616664867?i=1616665014'),
(3199, 794, 1, 13, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-1-scene-1-the-journey/1616664867?i=1616664870'),
(3263, 794, 3, 26, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-2-scene-3-miss-jessel/1616664867?i=1616665010'),
(3587, 794, 4, 13, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-1-scene-4-the-tower/1616664867?i=1616664996'),
(3928, 794, 5, 13, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-1-scene-5-the-window/1616664867?i=1616664998'),
(4062, 794, 6, 13, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-1-scene-6-the-lesson/1616664867?i=1616665000'),
(4168, 794, 8, 13, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-1-scene-8-at-night/1616664867?i=1616665004'),
(4589, 794, 7, 26, 'https://music.apple.com/us/album/the-turn-of-the-screw-op-54-act-2-scene-7-flora/1616664867?i=1616665019'),
(14060, 11223, 4, NULL, 'https://music.apple.com/us/album/string-quintet-in-d-minor-op-20-op-13-no-4-g-280-i-allegro-moderato/6771989503?i=6771989778'),
(14061, 11223, 2, 14060, 'https://music.apple.com/us/album/string-quintet-in-d-minor-op-20-op-13-no-4-g-280-ii-andante-sostenuto/6771989503?i=6771989779'),
(14115, 11223, 3, 14060, 'https://music.apple.com/us/album/string-quintet-in-d-minor-op-20-op-13-no-4-g-280-iii-fuga-allegro-giusto/6771989503?i=6771989780'),
(14726, 11223, 1, 14060, 'https://music.apple.com/us/album/string-quintet-in-d-minor-op-20-op-13-no-4-g-280-i-allegro-moderato/6771989503?i=6771989778'),
(35087, 23637, 4, NULL, 'https://music.apple.com/us/album/les-go-ts-r-nis-concert-no-8-in-g-dans-le-go-t-th-tral-i-ouverture/1452703713?i=1452703725'),
(35187, 23637, 3, NULL, 'https://music.apple.com/us/album/les-go-ts-r-nis-concert-no-5-in-f-major-i-pr-lude-gracieusement/1452703713?i=1452704186'),
(35188, 23637, 1, 35187, 'https://music.apple.com/us/album/les-go-ts-r-nis-concert-no-5-in-f-major-i-pr-lude-gracieusement/1452703713?i=1452704186'),
(35516, 23637, 5, 35515, 'https://music.apple.com/us/album/les-go-ts-r-nis-concert-no-9-in-e-ritratto-dell-amore-v-la-vivacit/1452703713?i=1452704203'),
(35621, 23637, 8, 35087, 'https://music.apple.com/us/album/les-go-ts-r-nis-concert-no-8-in-g-dans-le-go-t-th-tral-xi-air-de-bacchantes-tr-s-anim/1452703713?i=1452703729'),
(35912, 23637, 2, 35911, 'https://music.apple.com/us/album/les-go-ts-r-nis-concert-no-12-in-a-ii-badinage/1452703713?i=1452704025'),
(36359, 23637, 1, 35087, 'https://music.apple.com/us/album/les-go-ts-r-nis-concert-no-8-in-g-dans-le-go-t-th-tral-i-ouverture/1452703713?i=1452703725'),
(36893, 23637, 3, 35087, 'https://music.apple.com/us/album/les-go-ts-r-nis-concert-no-8-in-g-dans-le-go-t-th-tral-iii-air-noblement/1452703713?i=1452704007'),
(37506, 23637, 4, 36544, 'https://music.apple.com/us/album/les-go-ts-r-nis-concert-no-13-in-g-deux-instruments-l-unisson-iv-chaconne-l-g-re/1452703713?i=1452704578'),
(37946, 23637, 2, 35159, 'https://music.apple.com/us/album/les-go-ts-r-nis-concert-no-10-in-a-minor-iii-plainte-pour-les-violes/1452703713?i=1452704326'),
(40351, 26698, 1, NULL, 'https://music.apple.com/us/album/piano-sonata-no-13-in-e-flat-major-op-27-no-1-sonata-quasi-una-fantasia-i-andante/1195145821?i=1195146166'),
(40352, 26698, 1, 40351, 'https://music.apple.com/us/album/piano-sonata-no-13-in-e-flat-major-op-27-no-1-sonata-quasi-una-fantasia-i-andante/1195145821?i=1195146166'),
(40353, 26698, 2, 40351, 'https://music.apple.com/us/album/piano-sonata-no-13-in-e-flat-major-op-27-no-1-sonata-quasi-una-fantasia-ii-allegro-molto-e-vivace/1195145821?i=1195146316'),
(40354, 26698, 3, 40351, 'https://music.apple.com/us/album/piano-sonata-no-13-in-e-flat-major-op-27-no-1-sonata-quasi-una-fantasia-iii-adagio-con-espressione/1195145821?i=1195146323'),
(40355, 26698, 4, 40351, 'https://music.apple.com/us/album/piano-sonata-no-13-in-e-flat-major-op-27-no-1-sonata-quasi-una-fantasia-iv-allegro-vivace/1195145821?i=1195146327');

UPDATE piece_parts part
JOIN tmp_part_apple link
    ON link.part_id = part.id
    AND link.piece_id = part.piece_id
    AND link.sequence_number = part.sequence_number
    AND part.parent_part_id <=> link.parent_part_id
SET part.apple_music_url = link.url
WHERE part.apple_music_url IS NULL;

DROP TEMPORARY TABLE tmp_part_apple;
