-- 작곡가 화면 「처음 듣는다면」: 작곡가마다 고른 작품 5~10곡과 한 줄 이유.
-- 작품 목록 한 줄(최상위 작품)을 가리키고, 세트면 대표 곡(part_id, 그 작품의 최상위 part)을 단다.
-- 이유는 곡의 자리나 대표 곡 같은 사실 한 줄이다(비유·권유 없이, 근거가 없으면 비운다).
-- source 는 자동 초안(auto)인지 사람이 고른 것(editor)인지, status 는 화면에 내놓는지(PUBLISHED)다.
-- 화면에는 PUBLISHED 만 나가고, 자동 초안은 DRAFT 로 넣은 뒤 사람이 확인하고 올린다.
CREATE TABLE composer_highlights (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    composer_id INT NOT NULL,
    piece_id INT NOT NULL,
    part_id BIGINT UNSIGNED NULL,
    sort_order SMALLINT UNSIGNED NOT NULL,
    reason VARCHAR(255) NULL,
    reason_en VARCHAR(255) NULL,
    source VARCHAR(16) NOT NULL DEFAULT 'auto',
    status VARCHAR(16) NOT NULL DEFAULT 'DRAFT',
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    UNIQUE KEY uq_composer_highlights_piece (composer_id, piece_id),
    KEY idx_composer_highlights_order (composer_id, status, sort_order),
    KEY idx_composer_highlights_piece (piece_id),
    KEY idx_composer_highlights_part (part_id),
    CONSTRAINT fk_composer_highlights_composer FOREIGN KEY (composer_id)
        REFERENCES composers (id) ON DELETE CASCADE,
    CONSTRAINT fk_composer_highlights_piece FOREIGN KEY (piece_id)
        REFERENCES pieces (id) ON DELETE CASCADE,
    CONSTRAINT fk_composer_highlights_part FOREIGN KEY (part_id)
        REFERENCES piece_parts (id) ON DELETE SET NULL,
    CONSTRAINT chk_composer_highlights_source CHECK (source IN ('auto', 'editor')),
    CONSTRAINT chk_composer_highlights_status CHECK (status IN ('DRAFT', 'PUBLISHED'))
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
