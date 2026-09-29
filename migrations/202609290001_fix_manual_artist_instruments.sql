-- 손으로 넣은 한국 연주자 셋과 라쉬코프스키의 악기 분류를 바로잡는다.
--
-- 리디자인 연주자 둘러보기에서 분류 칩을 붙이며 드러났다. 넷 다 한 가지 악기로만
-- 활동하는 연주자라 겸업(피아니스트 겸 지휘자 등) 판단이 끼지 않는다.
--
--   192 양인모             pianist → violinist  (2015 파가니니 콩쿠르 우승)
--   195 대니구             pianist → violinist
--   244 이지윤             pianist → violinist  (베를린 슈타츠카펠레 악장)
--   221 일리야 라쉬코프스키  violinist → pianist (2012 하마마쓰 콩쿠르 우승)
--
-- id 와 영문명, 현재 분류가 모두 예상과 같을 때만 바꾼다. 이미 누가 고쳤으면
-- 아무것도 하지 않는다. 자동 시드가 다시 덮지 못하게 editor_locked 를 올린다.

UPDATE artists
SET category = 'violinist',
    editor_locked = 1
WHERE id = 192
  AND english_name = 'Inmo Yang'
  AND category IN ('pianist', '피아노', '피아니스트');

UPDATE artists
SET category = 'violinist',
    editor_locked = 1
WHERE id = 195
  AND english_name = 'Danny Koo'
  AND category IN ('pianist', '피아노', '피아니스트');

UPDATE artists
SET category = 'violinist',
    editor_locked = 1
WHERE id = 244
  AND english_name = 'Ji-Yoon Lee'
  AND category IN ('pianist', '피아노', '피아니스트');

UPDATE artists
SET category = 'pianist',
    editor_locked = 1
WHERE id = 221
  AND english_name = 'Ilya Rashkovskiy'
  AND category IN ('violinist', '바이올린');
