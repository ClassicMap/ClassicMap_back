-- 202610020001 에서 넣은 위키미디어 사진 84장의 주소가 thumb.wikimedia.org 였다(Commons imageinfo 가 준 그대로).
-- 이미지 프록시는 upload.wikimedia.org 만 받아서 이 사진들이 화면에서 이니셜로 보였다.
-- 같은 경로를 upload.wikimedia.org 로 바꾸고 utm 꼬리를 뗀다. 바꾼 주소가 열리는 것을 확인했다.
-- 사진 출처(entity_images.file_url)도 같은 값으로 바꿔 사진과 출처가 계속 맞게 한다. 다시 돌려도 같다.

UPDATE artists
SET image_url = REPLACE(SUBSTRING_INDEX(image_url, '?utm_source=', 1),
                        'https://thumb.wikimedia.org/', 'https://upload.wikimedia.org/')
WHERE image_url LIKE 'https://thumb.wikimedia.org/%';

UPDATE entity_images
SET file_url = REPLACE(SUBSTRING_INDEX(file_url, '?utm_source=', 1),
                       'https://thumb.wikimedia.org/', 'https://upload.wikimedia.org/')
WHERE file_url LIKE 'https://thumb.wikimedia.org/%';
