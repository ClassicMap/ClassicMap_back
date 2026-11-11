-- 작품 장르에 사운드트랙(screen)을 더한다: 영화·드라마·게임·애니메이션 음악.
-- 영화·게임 작곡가 작품이 장르 7종 어디에도 맞지 않아 작곡가 화면에서 모두 '기타'로 보였다.
-- 형식은 하나(soundtrack)다. 데이터는 다음 마이그레이션(202611110902)이 채운다.
-- 옛 앱(1.3.2 이하)은 모르는 장르를 '기타'로 보이고 'other' 로 묻는다. 서버는 'other' 에 사운드트랙을 함께 준다.
ALTER TABLE pieces DROP CHECK chk_pieces_genre;
ALTER TABLE pieces
    ADD CONSTRAINT chk_pieces_genre CHECK (genre IS NULL OR genre IN (
        'symphony', 'concerto', 'piano', 'chamber', 'orchestral', 'stage', 'vocal', 'screen'
    ));

ALTER TABLE piece_forms DROP CHECK chk_piece_forms_genre;
ALTER TABLE piece_forms
    ADD CONSTRAINT chk_piece_forms_genre CHECK (genre IN (
        'symphony', 'concerto', 'piano', 'chamber', 'orchestral', 'stage', 'vocal', 'screen'
    ));

INSERT IGNORE INTO piece_forms (form_key, genre, name_ko, sort_order) VALUES
    ('soundtrack', 'screen', '사운드트랙', 10);
