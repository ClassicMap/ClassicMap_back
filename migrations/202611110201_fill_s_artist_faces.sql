-- 얼굴 그림(image_url)이 없던 S 연주자 2명. 빈칸일 때만 넣고, 출처는 entity_images profile 행에 남긴다.
-- 바이로이트 축제 관현악단(660)은 애플 뮤직·디저 그림이 음반 표지뿐이라 비워 둔다(배너는 있음).

-- artist 646 Heinrich Schiff (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/c2/87/46/c287463b-139b-faa9-6b3d-891767ac8c92/619fa94d-5732-4859-a866-eba88940ff59.png/600x600bb.jpg'
WHERE id = 646 AND english_name = 'Heinrich Schiff' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/746918', 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/c2/87/46/c287463b-139b-faa9-6b3d-891767ac8c92/619fa94d-5732-4859-a866-eba88940ff59.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 646 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/c2/87/46/c287463b-139b-faa9-6b3d-891767ac8c92/619fa94d-5732-4859-a866-eba88940ff59.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/c2/87/46/c287463b-139b-faa9-6b3d-891767ac8c92/619fa94d-5732-4859-a866-eba88940ff59.png/600x600bb.jpg');

-- artist 685 Margaret Price (Deezer artist 146252)
UPDATE artists SET image_url = 'https://cdn-images.dzcdn.net/images/artist/a9f6f5eec79a014eb20b54aae39e05d4/1000x1000-000000-80-0-0.jpg'
WHERE id = 685 AND english_name = 'Margaret Price' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.deezer.com/artist/146252', 'https://cdn-images.dzcdn.net/images/artist/a9f6f5eec79a014eb20b54aae39e05d4/1000x1000-000000-80-0-0.jpg', NULL, NULL, NULL, 'Deezer', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 685 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://cdn-images.dzcdn.net/images/artist/a9f6f5eec79a014eb20b54aae39e05d4/1000x1000-000000-80-0-0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://cdn-images.dzcdn.net/images/artist/a9f6f5eec79a014eb20b54aae39e05d4/1000x1000-000000-80-0-0.jpg');
