-- 곡 안 곡(악장 등)과 그 곡을 가진 곡에 Spotify 트랙 링크를 채운다. 자료와 규칙은
-- seed_pipeline/curation/piece-link-audit-2026-11-09/(match.py, spotify-nested-matches.jsonl).
-- 앨범 링크가 있는 세트의 곡 247곡 중 26곡.
-- 이미 링크가 있는 곡은 그대로 두고, id 와 함께 작품·부모 곡·순서가 같은 곡에만 넣는다.
-- 두 번 넣어도 같다.

CREATE TEMPORARY TABLE tmp_part_spotify (
    part_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    piece_id INT NOT NULL,
    sequence_number INT NOT NULL,
    parent_part_id BIGINT UNSIGNED NULL,
    url VARCHAR(500) NOT NULL
);
INSERT INTO tmp_part_spotify (part_id, piece_id, sequence_number, parent_part_id, url) VALUES
(14915, 9702, 3, NULL, 'https://open.spotify.com/track/30YRbY3umz04npgYy59YFi'),
(15913, 9702, 1, 14915, 'https://open.spotify.com/track/30YRbY3umz04npgYy59YFi'),
(16994, 9702, 3, 14915, 'https://open.spotify.com/track/1OiOKy7WMHQ6kwMkBFXxa7'),
(41621, 27161, 1, NULL, 'https://open.spotify.com/track/5ETBDE2fJlRHs2sm7r7sQb'),
(41622, 27161, 1, 41621, 'https://open.spotify.com/track/5ETBDE2fJlRHs2sm7r7sQb'),
(41623, 27161, 2, 41621, 'https://open.spotify.com/track/4DcOYlVPB8wR5cSJowqBFz'),
(41624, 27161, 3, 41621, 'https://open.spotify.com/track/459VnxJx6TwpDscoOqPNoz'),
(41625, 27161, 4, 41621, 'https://open.spotify.com/track/28N6RlSqoE9NGjL8tcFddU'),
(41626, 27161, 2, NULL, 'https://open.spotify.com/track/3BBFMrENXolzc8DREJ43rD'),
(41631, 27161, 3, NULL, 'https://open.spotify.com/track/1t4XABiBb0bLyW0GnLigMV'),
(41632, 27161, 1, 41631, 'https://open.spotify.com/track/1t4XABiBb0bLyW0GnLigMV'),
(41633, 27161, 2, 41631, 'https://open.spotify.com/track/307nobqdwcpfvKUbMIFOfy'),
(41634, 27161, 3, 41631, 'https://open.spotify.com/track/4Mht6z7ldYKsz2hcyUhLc3'),
(41635, 27161, 4, 41631, 'https://open.spotify.com/track/2qNUkhoM92Odg1V8irSYhm'),
(51462, 32105, 2, NULL, 'https://open.spotify.com/track/79DN32767lv3poO7jLdY8s'),
(51468, 32105, 5, NULL, 'https://open.spotify.com/track/41UF1DWuwTKtbFLgeZCKM6'),
(51469, 32105, 1, 51468, 'https://open.spotify.com/track/41UF1DWuwTKtbFLgeZCKM6'),
(51470, 32105, 2, 51468, 'https://open.spotify.com/track/5gUFoYa2NYMXoA3hUJwijW'),
(54160, 32755, 1, NULL, 'https://open.spotify.com/track/42pBkIBAzEgLfZVOGVM7Bf'),
(54161, 32755, 1, 54160, 'https://open.spotify.com/track/42pBkIBAzEgLfZVOGVM7Bf'),
(54162, 32755, 2, 54160, 'https://open.spotify.com/track/4LED54LRAu431fFGLx11AH'),
(54163, 32755, 2, NULL, 'https://open.spotify.com/track/6Vv3tAetf93vsP8gGu52e9'),
(54164, 32755, 1, 54163, 'https://open.spotify.com/track/6Vv3tAetf93vsP8gGu52e9'),
(54165, 32755, 2, 54163, 'https://open.spotify.com/track/2VgfwfTe4OnM0Pa94QTY1e'),
(54166, 32755, 3, 54163, 'https://open.spotify.com/track/282iyy3zPOUSbNLkk8WZzE'),
(54167, 32755, 4, 54163, 'https://open.spotify.com/track/7v33CdvRBiIAQUpZM0nPYq');

UPDATE piece_parts part
JOIN tmp_part_spotify link
    ON link.part_id = part.id
    AND link.piece_id = part.piece_id
    AND link.sequence_number = part.sequence_number
    AND part.parent_part_id <=> link.parent_part_id
SET part.spotify_url = link.url
WHERE part.spotify_url IS NULL;

DROP TEMPORARY TABLE tmp_part_spotify;
