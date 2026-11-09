-- 곡 안 곡(악장 등)과 그 곡을 가진 곡에 Spotify 트랙 링크를 채운다. 자료와 규칙은
-- seed_pipeline/curation/piece-link-audit-2026-11-09/(match.py, spotify-review-nested-matches.jsonl).
-- 앨범 링크가 있는 세트의 곡 379곡 중 29곡.
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
(47304, 60, 1, NULL, 'https://open.spotify.com/track/006ciP9PbZGOUjR0LOBxbW'),
(47305, 60, 1, 47304, 'https://open.spotify.com/track/006ciP9PbZGOUjR0LOBxbW'),
(47306, 60, 2, 47304, 'https://open.spotify.com/track/51enT8mkBkN2PncgBlo9DZ'),
(47307, 60, 3, 47304, 'https://open.spotify.com/track/6BMqsUro3ncbLSwNPWeU3s'),
(47308, 60, 4, 47304, 'https://open.spotify.com/track/14v4jiLD4jrFRP78IqitzY'),
(47314, 60, 3, NULL, 'https://open.spotify.com/track/6r5aQHpQtILbnolJn7Q1kk'),
(47315, 60, 1, 47314, 'https://open.spotify.com/track/6r5aQHpQtILbnolJn7Q1kk'),
(47316, 60, 2, 47314, 'https://open.spotify.com/track/5C0yiYz1a6t4nOqVa7dFvQ'),
(47317, 60, 3, 47314, 'https://open.spotify.com/track/6hLuon3NUYGVi2zXROG8SX'),
(47318, 60, 4, 47314, 'https://open.spotify.com/track/3Ybmob9yur3G2H3yYRoRlH'),
(35222, 23539, 4, NULL, 'https://open.spotify.com/track/65I08ECaDglx99zJGjywAy'),
(35223, 23539, 1, 35222, 'https://open.spotify.com/track/65I08ECaDglx99zJGjywAy'),
(35593, 23539, 1, NULL, 'https://open.spotify.com/track/6l7FuUH0Tf3l5j7kZuANV0'),
(35594, 23539, 4, 35593, 'https://open.spotify.com/track/6ZlFXYDf8hxCz0UlXe4nqy'),
(36021, 23539, 2, NULL, 'https://open.spotify.com/track/0P1iSO883skCBwi5q2h3hq'),
(36022, 23539, 2, 36021, 'https://open.spotify.com/track/1FtUp247dS7aqNY7RyaMAx'),
(36197, 23539, 1, 36021, 'https://open.spotify.com/track/0P1iSO883skCBwi5q2h3hq'),
(36282, 23539, 3, 35593, 'https://open.spotify.com/track/15WrLN1AEo9jPH0UwJr4Nt'),
(36515, 23539, 3, 35222, 'https://open.spotify.com/track/4jkAN1rfwHMGUkhl3606Z8'),
(36559, 23539, 3, NULL, 'https://open.spotify.com/track/2vi9XoZdmrPjBVgKU6M7Kw'),
(36560, 23539, 1, 36559, 'https://open.spotify.com/track/2vi9XoZdmrPjBVgKU6M7Kw'),
(36562, 23539, 1, 35593, 'https://open.spotify.com/track/6l7FuUH0Tf3l5j7kZuANV0'),
(36952, 23539, 2, 36559, 'https://open.spotify.com/track/5oQogNTJwZtPeYJKQx9LO7'),
(36955, 23539, 2, 35222, 'https://open.spotify.com/track/1PCLWIkOXK3HGk1ph6WJv3'),
(36962, 23539, 3, 36559, 'https://open.spotify.com/track/1eGClLxvZqdDRCLXR1ziTz'),
(37119, 23539, 4, 36021, 'https://open.spotify.com/track/0pOU355kU82Rf6gkhFEXCm'),
(37608, 23539, 3, 36021, 'https://open.spotify.com/track/5ioQ8Zfs7N7lplkN2OFuvJ'),
(37740, 23539, 2, 35593, 'https://open.spotify.com/track/0dLDp7rHWdqKDr03lAb8uF'),
(38195, 23539, 4, 35222, 'https://open.spotify.com/track/1uswOXdDhQ8vBqqKSiMqZA');

UPDATE piece_parts part
JOIN tmp_part_spotify link
    ON link.part_id = part.id
    AND link.piece_id = part.piece_id
    AND link.sequence_number = part.sequence_number
    AND part.parent_part_id <=> link.parent_part_id
SET part.spotify_url = link.url
WHERE part.spotify_url IS NULL;

DROP TEMPORARY TABLE tmp_part_spotify;
