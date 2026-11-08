-- 세트 안 곡(piece_parts)마다 Apple Music 트랙 링크를 둔다. 작품(pieces.apple_music_url)과 같은 꼴이다.
-- 따로 작품 행으로 이어진 곡은 그 작품의 링크를 쓰고, 이 칸은 이어진 작품이 없는 곡에 쓴다.
ALTER TABLE piece_parts
    ADD COLUMN apple_music_url VARCHAR(500) NULL AFTER name_en;
