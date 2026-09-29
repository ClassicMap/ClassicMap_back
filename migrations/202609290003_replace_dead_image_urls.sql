-- 열리지 않는 사진 주소 셋을 고친다.
--
-- 나무위키(i.namu.wiki)는 외부에서 불러오면 403, DuckDuckGo 이미지 프록시 주소는 400 이라
-- 화면에서는 늘 이니셜로 떨어졌다. 백엔드 image-proxy 도 위키미디어만 받는다.
--
--   아티스트 367 블라디미르 호로비츠  → Wikidata Q192506 P18 (위키미디어 500px 썸네일)
--   아티스트 340 뮌헨 필하모닉       → Wikidata Q693453 P18
--   작곡가  103 김동진              → Wikidata Q4991776 에 P18 이 없어 비운다
--
-- 사진·커버를 같은 주소로 쓰던 행이라 둘 다 바꾼다. 지금 값이 죽은 주소일 때만 바꾸고,
-- 누가 이미 고쳤으면 건드리지 않는다.

UPDATE artists
SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Vladimir_Horowitz_C37292-1_%28cropped%29.jpg/500px-Vladimir_Horowitz_C37292-1_%28cropped%29.jpg'
WHERE id = 367
  AND english_name LIKE 'Vladimir%Horowitz'
  AND image_url LIKE 'https://i.namu.wiki/%';

UPDATE artists
SET cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Vladimir_Horowitz_C37292-1_%28cropped%29.jpg/500px-Vladimir_Horowitz_C37292-1_%28cropped%29.jpg'
WHERE id = 367
  AND english_name LIKE 'Vladimir%Horowitz'
  AND cover_image_url LIKE 'https://i.namu.wiki/%';

UPDATE artists
SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/M%C3%BCnchner_Philharmoniker_im_Gasteig.jpg/500px-M%C3%BCnchner_Philharmoniker_im_Gasteig.jpg'
WHERE id = 340
  AND english_name = 'Munich Philharmonic'
  AND image_url LIKE 'https://external-content.duckduckgo.com/%';

UPDATE artists
SET cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/M%C3%BCnchner_Philharmoniker_im_Gasteig.jpg/500px-M%C3%BCnchner_Philharmoniker_im_Gasteig.jpg'
WHERE id = 340
  AND english_name = 'Munich Philharmonic'
  AND cover_image_url LIKE 'https://external-content.duckduckgo.com/%';

UPDATE composers
SET avatar_url = NULL
WHERE id = 103
  AND english_name = 'Kim Dong-jin'
  AND avatar_url LIKE 'https://i.namu.wiki/%';

UPDATE composers
SET cover_image_url = NULL
WHERE id = 103
  AND english_name = 'Kim Dong-jin'
  AND cover_image_url LIKE 'https://i.namu.wiki/%';
