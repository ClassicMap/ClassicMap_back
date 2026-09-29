-- 공연 편성(피아노·현악·관악·성악·합창·오케스트라·실내악·오페라·크로스오버)을 담는다.
--
-- 값은 쉼표로 이은 코드다 (예: 'piano,chamber'). NULL 은 아직 분류하지 않은 공연,
-- 빈 문자열은 분류했지만 해당하는 편성이 없는 공연이다. 서버가 시작할 때 NULL 인
-- 공연을 제목과 출연 아티스트 분류로 채우고, KOPIS 동기화가 공연을 갱신할 때마다 다시 매긴다.

ALTER TABLE concerts
    ADD COLUMN instrumentation VARCHAR(120) NULL COMMENT '편성 코드 (쉼표 구분)' AFTER is_festival;
