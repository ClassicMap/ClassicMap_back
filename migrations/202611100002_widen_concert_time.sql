-- KOPIS 공연 시간 안내(dtguidance)가 100자를 넘는 공연(장기 뮤지컬 등)은 저장하다 1406 "Data too long" 으로 빠졌다.
-- 칸을 넓힌다(줄이지 않는다). 상세 원문은 performance_schedule(text)에도 있다.
ALTER TABLE concerts
    MODIFY COLUMN concert_time VARCHAR(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공연 시간 (예: 목요일(19:30))';
