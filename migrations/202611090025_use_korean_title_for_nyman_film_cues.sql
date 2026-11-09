-- 영화 「Le Mari de la coiffeuse」(1990)의 한국 제목은 「사랑한다면 이들처럼」이다
-- (왓챠피디아: 원제 Le Mari de la coiffeuse, 1990, 프랑스). 202611090024 에서 원제로 둔
-- 나이먼 사운드트랙 큐 6곡의 한국어 제목을 한국 제목으로 바꾼다. 영어 제목은 그대로 둔다.
-- 지금 값이 0024 가 넣은 값과 같을 때만 바꾼다.

UPDATE pieces
SET title = REPLACE(title, '영화 <Le Mari de la coiffeuse> 사운드트랙: ', '영화 <사랑한다면 이들처럼> 사운드트랙: ')
WHERE id IN (18046, 17114, 18743, 19299, 16126, 18947)
    AND title LIKE '영화 <Le Mari de la coiffeuse> 사운드트랙: Michael Nyman _';
