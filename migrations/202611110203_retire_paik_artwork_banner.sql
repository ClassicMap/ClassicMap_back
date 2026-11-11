-- 백남준(102)은 11/8 에 본인 사진이 없어 작품 「다다익선」 사진을 머리 배너로 넣었다(202611082002).
-- 지금은 본인 초상(avatar)이 있어서, 김동진(202611110202)과 같이 배너를 내리고 초상을 오른쪽에 세운다.
UPDATE entity_images image
JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id
SET image.editorial_status = 'RETIRED'
WHERE entity.id = 102
  AND image.image_kind = 'banner'
  AND image.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/60/The_More%2C_the_Better_%28%EB%8B%A4%EB%8B%A4%EC%9D%B5%EC%84%A0%28%E5%A4%9A%E5%A4%9A%E7%9B%8A%E5%96%84%29%29_%EB%B0%B1%EB%82%A8%EC%A4%80_PAIK_Namjune%281932~2006%29.jpg'
  AND image.editorial_status = 'PUBLISHED';
