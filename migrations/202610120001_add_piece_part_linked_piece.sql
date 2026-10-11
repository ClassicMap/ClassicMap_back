-- 묶음 작품의 part 가 따로 있는 작품 행을 가리킬 수 있게 한다.
-- 쇼팽 「연습곡 Op. 10」의 12번 part 가 이미 비교 구간을 가진 작품 「혁명」(pieces 행)을 가리키는 식이다.
-- 가리켜진 작품은 작곡가 작품 목록 최상위에서 빠지고 묶음 안에서 보인다.
-- 가리키던 작품이 지워지면 part 는 남고 연결만 끊긴다.

ALTER TABLE piece_parts
    ADD COLUMN linked_piece_id INT NULL AFTER parent_part_id,
    ADD CONSTRAINT fk_piece_parts_linked_piece
        FOREIGN KEY (linked_piece_id) REFERENCES pieces(id) ON DELETE SET NULL,
    ADD INDEX idx_piece_parts_linked_piece (linked_piece_id);
