-- 애매한 작품 Spotify 링크를 근거를 보고 바로잡는다. 자료와 근거는
-- seed_pipeline/curation/piece-link-audit-2026-11-09/
-- (review-decisions.jsonl, apply_review.py).
-- 바꿈 4곳, 지움 8곳.
-- 지금 값이 판정 때 본 값과 같을 때만 바꾸고, 그 작품의 곡 링크는 비운다
-- (새 앨범에서 다시 채움).

CREATE TEMPORARY TABLE tmp_review_piece_spotify (
    piece_id INT NOT NULL PRIMARY KEY,
    old_url VARCHAR(500) NOT NULL,
    new_url VARCHAR(500) NULL
);
INSERT INTO tmp_review_piece_spotify (piece_id, old_url, new_url) VALUES
(60, 'https://open.spotify.com/album/0GWErIX4yaChZ3LV8ekzCp', 'https://open.spotify.com/album/3t9xw0quv5JXWYqyIgbpal'),
(109, 'https://open.spotify.com/album/55wLtZCsd5gVKrmzLDeSH6', 'https://open.spotify.com/album/5Ky55ZP45ifbhHJwpEJVml'),
(307, 'https://open.spotify.com/album/3r85Aw3DIDErCQEiYHk0lu', 'https://open.spotify.com/album/5KBx5t83Sv9EkdDsxMkmA0'),
(345, 'https://open.spotify.com/album/3jwobJu2gfscIyepVtguSX', NULL),
(347, 'https://open.spotify.com/album/3jwobJu2gfscIyepVtguSX', 'https://open.spotify.com/album/3FofCd55LJzxh1zGVsJl3i'),
(348, 'https://open.spotify.com/album/65tTkPhfEt17nOy0nxSc3S', NULL),
(391, 'https://open.spotify.com/album/2I4Npa3S0lc14yerFPlLOj', NULL),
(8283, 'https://open.spotify.com/album/58RBfEa1TqH0xjz7BMGgqo', NULL),
(8860, 'https://open.spotify.com/album/58RBfEa1TqH0xjz7BMGgqo', NULL),
(9217, 'https://open.spotify.com/album/7Ft31B48bSW26vKItagrc4', NULL),
(10135, 'https://open.spotify.com/album/58RBfEa1TqH0xjz7BMGgqo', NULL),
(11212, 'https://open.spotify.com/album/1VPfdbdL5MzDBwGPKe6Zbi', NULL);

UPDATE piece_parts part
JOIN tmp_review_piece_spotify fix ON fix.piece_id = part.piece_id
JOIN pieces piece ON piece.id = fix.piece_id
SET part.spotify_url = NULL
WHERE piece.spotify_url = fix.old_url;

UPDATE pieces piece
JOIN tmp_review_piece_spotify fix ON fix.piece_id = piece.id
SET piece.spotify_url = fix.new_url
WHERE piece.spotify_url = fix.old_url;

DROP TEMPORARY TABLE tmp_review_piece_spotify;
