-- 스카를라티·몬테베르디 기존 작품 제목을 0103·0104 로 넣은 새 작품과 같은 꼴로 맞춘다(지금 제목일 때만 바꾼다).
-- 스카를라티 「소나타 D단조」 두 곡(K. 1·K. 141)이 같은 제목이었고, 별명은 따옴표 없이 붙어 있었다.
-- 0103 의 K. 30 은 별명이 번호 앞이라 다른 곡과 같은 「건반 소나타 G단조 K. 30 "고양이 푸가"」 꼴로 맞춘다.
-- 영어 제목·설명·링크·작품번호 칸은 그대로 둔다. 두 번 돌려도 같다.

-- 스카를라티(9)
UPDATE pieces SET title = '건반 소나타 D단조 K. 1'
WHERE id = 45 AND composer_id = 9 AND title = '소나타 D단조';
UPDATE pieces SET title = '건반 소나타 D단조 K. 9 "파스토랄레"'
WHERE id = 44 AND composer_id = 9 AND title = '소나타 D단조 파스토랄레';
UPDATE pieces SET title = '건반 소나타 B단조 K. 27'
WHERE id = 41 AND composer_id = 9 AND title = '소나타 B단조';
UPDATE pieces SET title = '건반 소나타 D단조 K. 141'
WHERE id = 42 AND composer_id = 9 AND title = '소나타 D단조';
UPDATE pieces SET title = '건반 소나타 C장조 K. 159 "사냥"'
WHERE id = 40 AND composer_id = 9 AND title = '소나타 C장조 사냥';
UPDATE pieces SET title = '건반 소나타 E장조 K. 380 "행렬"'
WHERE id = 39 AND composer_id = 9 AND title = '소나타 E장조 행렬';
UPDATE pieces SET title = '건반 소나타 F단조 K. 466'
WHERE id = 43 AND composer_id = 9 AND title = '소나타 F단조';
UPDATE pieces SET title = '건반 소나타 G단조 K. 30 "고양이 푸가"'
WHERE composer_id = 9 AND title = '건반 소나타 G단조 "고양이 푸가" K. 30';

-- 몬테베르디(5)
UPDATE pieces SET title = '오페라 <오르페오>'
WHERE id = 17 AND composer_id = 5 AND title = '오르페오';
UPDATE pieces SET title = '<성모 마리아의 저녁 기도>'
WHERE id = 18 AND composer_id = 5 AND title = '성모 마리아의 저녁기도';
UPDATE pieces SET title = '오페라 <포페아의 대관>'
WHERE id = 20 AND composer_id = 5 AND title = '포페아의 대관';
