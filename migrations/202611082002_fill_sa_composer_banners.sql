-- 어느 음원 서비스에도 머리 그림이 없던 S·A 작곡가 6명의 화면 머리 배너(위키미디어 공용).
-- 원본: seed_pipeline/curation/entity-banners-more-2026-11-08/ (gen_sql.py 로 만든다).
-- 출처 페이지를 함께 밝히고, 권리자가 요청하면 그 줄을 RETIRED 로 내린다.
-- composer 88 안익태 (wikimedia)
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 88 AND image.image_kind = 'banner' AND image.file_url <> 'https://upload.wikimedia.org/wikipedia/commons/6/67/AhnEakTai1962.png';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:AhnEakTai1962.png', 'https://upload.wikimedia.org/wikipedia/commons/6/67/AhnEakTai1962.png', NULL, 'Bureau of Public Information (공보처 홍보국 사진담당관)', 'Public domain', NULL, '100% 22%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 88 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/67/AhnEakTai1962.png');
-- composer 38 글린카 (wikimedia)
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 38 AND image.image_kind = 'banner' AND image.file_url <> 'https://upload.wikimedia.org/wikipedia/commons/7/72/Mikhail_Glinka_by_Ilya_Repin.jpg';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Mikhail_Glinka_by_Ilya_Repin.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/72/Mikhail_Glinka_by_Ilya_Repin.jpg', NULL, 'Ilya Repin', 'Public domain', NULL, '0% 33%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 38 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/72/Mikhail_Glinka_by_Ilya_Repin.jpg');
-- composer 25 무치오 클레멘티 (wikimedia)
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 25 AND image.image_kind = 'banner' AND image.file_url <> 'https://upload.wikimedia.org/wikipedia/commons/1/12/Clementi_by_Scriven.png';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Clementi_by_Scriven.png', 'https://upload.wikimedia.org/wikipedia/commons/1/12/Clementi_by_Scriven.png', NULL, 'Edward Scriven', 'Public domain', NULL, '50% 39%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 25 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/12/Clementi_by_Scriven.png');
-- composer 24 요한 슈타미츠 (wikimedia)
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 24 AND image.image_kind = 'banner' AND image.file_url <> 'https://upload.wikimedia.org/wikipedia/commons/c/c5/Johann_Stamitz.jpg';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Johann_Stamitz.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/c5/Johann_Stamitz.jpg', 'Wikimedia Commons', NULL, 'Public domain', NULL, '50% 55%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 24 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c5/Johann_Stamitz.jpg');
-- composer 102 백남준 (wikimedia)
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 102 AND image.image_kind = 'banner' AND image.file_url <> 'https://upload.wikimedia.org/wikipedia/commons/6/60/The_More%2C_the_Better_%28%EB%8B%A4%EB%8B%A4%EC%9D%B5%EC%84%A0%28%E5%A4%9A%E5%A4%9A%E7%9B%8A%E5%96%84%29%29_%EB%B0%B1%EB%82%A8%EC%A4%80_PAIK_Namjune%281932~2006%29.jpg';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:The_More,_the_Better_(%EB%8B%A4%EB%8B%A4%EC%9D%B5%EC%84%A0(%E5%A4%9A%E5%A4%9A%E7%9B%8A%E5%96%84))_%EB%B0%B1%EB%82%A8%EC%A4%80_PAIK_Namjune(1932~2006).jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/60/The_More%2C_the_Better_%28%EB%8B%A4%EB%8B%A4%EC%9D%B5%EC%84%A0%28%E5%A4%9A%E5%A4%9A%E7%9B%8A%E5%96%84%29%29_%EB%B0%B1%EB%82%A8%EC%A4%80_PAIK_Namjune%281932~2006%29.jpg', NULL, 'Republic of Korea', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '29% 44%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 102 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/60/The_More%2C_the_Better_%28%EB%8B%A4%EB%8B%A4%EC%9D%B5%EC%84%A0%28%E5%A4%9A%E5%A4%9A%E7%9B%8A%E5%96%84%29%29_%EB%B0%B1%EB%82%A8%EC%A4%80_PAIK_Namjune%281932~2006%29.jpg');
-- composer 103 김동진 (wikimedia)
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 103 AND image.image_kind = 'banner' AND image.file_url <> 'https://upload.wikimedia.org/wikipedia/commons/d/d6/Masan_bay_taken_from_Sinpo-dong.jpg';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Masan_bay_taken_from_Sinpo-dong.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d6/Masan_bay_taken_from_Sinpo-dong.jpg', NULL, 'Choi2451', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '24% 78%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 103 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d6/Masan_bay_taken_from_Sinpo-dong.jpg');
