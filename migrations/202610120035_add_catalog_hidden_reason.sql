-- 작곡가·작품을 지우지 않고 목록에서 숨긴다.
-- 국제 시드가 넣은 대중음악 작곡가(록·팝·재즈)와 잡음 작품(악장 하나짜리, 팝 편곡 등)을 목록·검색·개수에서 뺀다.
-- NULL 이면 보이고, 값이 있으면 숨긴 까닭이다(예: 'non_classical', 'performer', 'catalog_unmatched').
-- 상세 화면은 숨겨도 열린다. 계약은 docs/catalog-hidden.md 에 둔다.
--
-- 작곡가 작품 목록과 작품 수는 (composer_id, hidden_reason) 로 찾는다.
-- 작곡가 표는 작고 숨기는 행이 적어 hidden_reason 만의 인덱스는 두지 않는다.

ALTER TABLE composers
    ADD COLUMN hidden_reason VARCHAR(32) NULL,
    ADD CONSTRAINT chk_composers_hidden_reason CHECK (hidden_reason IS NULL OR hidden_reason <> '');

ALTER TABLE pieces
    ADD COLUMN hidden_reason VARCHAR(32) NULL,
    ADD CONSTRAINT chk_pieces_hidden_reason CHECK (hidden_reason IS NULL OR hidden_reason <> ''),
    ADD INDEX idx_pieces_composer_hidden (composer_id, hidden_reason);
