-- 국제 작곡가 시드가 중세와 르네상스 작곡가를 레거시 API에도 안전하게 투영할 수 있도록 한다.
ALTER TABLE composers
    MODIFY COLUMN period ENUM(
        '중세',
        '르네상스',
        '바로크',
        '고전주의',
        '낭만주의',
        '근현대'
    ) NOT NULL COMMENT '시대';
