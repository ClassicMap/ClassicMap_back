-- 공식 원본과 명백히 어긋난 출생연도를 고친다.
--
-- Wikidata authority 연결 과정에서 드러난 것들이다. 1~2 년 차이는
-- 율리우스력·그레고리력 환산 차이일 수 있어 건드리지 않고,
-- 근거가 분명한 두 건만 고친다.
--
--   양인모        1986 → 1995  https://www.wikidata.org/wiki/Q23829586
--   소리타 교헤이   1990 → 1994  https://www.wikidata.org/wiki/Q17160446
--
-- 현재 값이 예상과 다르면 아무것도 바꾸지 않는다.

UPDATE artists SET birth_year = '1995'
WHERE english_name = 'Inmo Yang' AND birth_year = '1986';

UPDATE artists SET birth_year = '1994'
WHERE english_name = 'Kyohei Sorita' AND birth_year = '1990';
