-- 김동진(103)은 11/8 에 본인 사진이 없어 「가고파」의 마산만 사진을 머리 배너로 넣었다(202611082002).
-- 202611110101 로 얼굴 그림(조선일보 일러스트)이 생겨, 배너를 내리고 화면이 초상을 오른쪽에 세우게 한다.
UPDATE entity_images image
JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id
SET image.editorial_status = 'RETIRED'
WHERE entity.id = 103
  AND image.image_kind = 'banner'
  AND image.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d6/Masan_bay_taken_from_Sinpo-dong.jpg'
  AND image.editorial_status = 'PUBLISHED';
