-- 작품 설명 사실 오류 4곳(「처음 듣는다면」 초안을 만들다 걸린 곳). 근거는 seed_pipeline/curation/fact-fixes-2026-11-11/README.md.
-- 지금 값이 확인할 때 본 값일 때만 바꾼다(사람이 먼저 고쳤으면 건드리지 않는다).

-- 김동진 <목련화>: 시는 조영출이 아니라 경희대 설립자 조영식, 작곡은 1974년(1949 아님)
UPDATE pieces
SET description = REPLACE(description, '조영출의 시에', '조영식의 시에'),
    description_en = REPLACE(description_en, 'a poem by Jo Yeong-chul', 'a poem by Choue Young-seek')
WHERE id = 389 AND title = '가곡 <목련화>' AND description LIKE '조영출의 시에%';

UPDATE pieces SET composition_year = 1974
WHERE id = 389 AND title = '가곡 <목련화>' AND composition_year = 1949;

-- 김동진 <내 마음은>: 시는 김동환이 아니라 김동명, 발표는 1944년(1948 아님)
UPDATE pieces
SET description = REPLACE(description, '김동환의 시에', '김동명의 시에'),
    description_en = REPLACE(description_en, 'a poem by Kim Dong-hwan', 'a poem by Kim Dong-myeong')
WHERE id = 390 AND title = '가곡 <내 마음은>' AND description LIKE '김동환의 시에%';

UPDATE pieces SET composition_year = 1944
WHERE id = 390 AND title = '가곡 <내 마음은>' AND composition_year = 1948;

-- 아이브스 <뉴잉글랜드의 세 장소>: 1곡의 기념비는 독립전쟁이 아니라 남북전쟁(보스턴 쇼 기념비)
UPDATE pieces
SET description = REPLACE(description, '(독립전쟁 기념비,', '(보스턴의 남북전쟁 기념비,'),
    description_en = REPLACE(description_en, '(a Revolutionary War monument,', '(a Civil War memorial in Boston,')
WHERE id = 373 AND description LIKE '%(독립전쟁 기념비,%';

-- 베르디 <아이다>: 수에즈 운하 개통(1869) 기념곡이 아니다. 카이로 오페라 극장의 의뢰로 써서 1871년 그곳에서 초연
UPDATE pieces
SET description = REPLACE(description, '수에즈 운하 개통을 기념하여 작곡된 스펙터클 오페라.', '카이로 오페라 극장의 의뢰로 써서 1871년 그곳에서 초연한 스펙터클 오페라.'),
    description_en = REPLACE(description_en, 'A spectacular opera composed to commemorate the opening of the Suez Canal.', 'A spectacular opera commissioned by the Cairo opera house and first performed there in 1871.')
WHERE id = 150 AND description LIKE '수에즈 운하 개통을 기념하여 작곡된 스펙터클 오페라.%';
