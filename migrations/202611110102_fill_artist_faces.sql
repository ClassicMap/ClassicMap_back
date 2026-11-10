-- 얼굴 그림이 없던 A·B 연주자의 얼굴 그림(애플 뮤직·스포티파이·위키미디어·공식 사이트 등).
-- 원본: seed_pipeline/curation/entity-images-2-2026-11-11/ (gen_sql.py 로 만든다).
-- image_url 이 비었을 때만 채우고, 출처는 entity_images 'profile' 에 남긴다.
-- artist 374 Bulbul (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/75/B%C3%BClb%C3%BCl_M%C9%99mm%C9%99dov.jpg'
WHERE id = 374 AND english_name = 'Bulbul' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:B%C3%BClb%C3%BCl_M%C9%99mm%C9%99dov.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/75/B%C3%BClb%C3%BCl_M%C9%99mm%C9%99dov.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 374 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/75/B%C3%BClb%C3%BCl_M%C9%99mm%C9%99dov.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/75/B%C3%BClb%C3%BCl_M%C9%99mm%C9%99dov.jpg');
-- artist 376 레나타 테발디 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/93/Photo_Portrait_of_the_soprano_Renata_Tebaldi_1956_-_Touring_Club_Italiano_11_5563.jpg'
WHERE id = 376 AND english_name = 'Renata Tebaldi' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Photo_Portrait_of_the_soprano_Renata_Tebaldi_1956_-_Touring_Club_Italiano_11_5563.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/93/Photo_Portrait_of_the_soprano_Renata_Tebaldi_1956_-_Touring_Club_Italiano_11_5563.jpg', NULL, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 376 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/93/Photo_Portrait_of_the_soprano_Renata_Tebaldi_1956_-_Touring_Club_Italiano_11_5563.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/93/Photo_Portrait_of_the_soprano_Renata_Tebaldi_1956_-_Touring_Club_Italiano_11_5563.jpg');
-- artist 377 제리 해들리 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/6590c0098c3711a3bc89df41c6dc5b9915e4b410'
WHERE id = 377 AND english_name = 'Jerry Hadley' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/6tPOzB5O2YiSkKNXpZrTCp', 'https://i.scdn.co/image/6590c0098c3711a3bc89df41c6dc5b9915e4b410', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 377 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/6590c0098c3711a3bc89df41c6dc5b9915e4b410'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/6590c0098c3711a3bc89df41c6dc5b9915e4b410');
-- artist 378 Peter Donohoe (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/6c/80/2b/6c802bfc-7303-0a7c-2b6f-7f395f5f2972/402f443d-bf51-4b90-95de-5e4b213aadbb.png/600x600bb.jpg'
WHERE id = 378 AND english_name = 'Peter Donohoe' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/707720', 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/6c/80/2b/6c802bfc-7303-0a7c-2b6f-7f395f5f2972/402f443d-bf51-4b90-95de-5e4b213aadbb.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 378 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/6c/80/2b/6c802bfc-7303-0a7c-2b6f-7f395f5f2972/402f443d-bf51-4b90-95de-5e4b213aadbb.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/6c/80/2b/6c802bfc-7303-0a7c-2b6f-7f395f5f2972/402f443d-bf51-4b90-95de-5e4b213aadbb.png/600x600bb.jpg');
-- artist 380 Oliver Schnyder (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a4/Oliver_Schnyder.jpg'
WHERE id = 380 AND english_name = 'Oliver Schnyder' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Oliver_Schnyder.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a4/Oliver_Schnyder.jpg', 'Kurt Schnyder', 'CC BY-SA 3.0', 'http://creativecommons.org/licenses/by-sa/3.0/', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 380 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a4/Oliver_Schnyder.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a4/Oliver_Schnyder.jpg');
-- artist 384 Sakari Oramo (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/42/b4/6a/42b46a92-f00d-f67c-01d3-e159368b0d7f/mzl.luxnufgj.jpg/600x600bb.jpg'
WHERE id = 384 AND english_name = 'Sakari Oramo' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/40618232', 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/42/b4/6a/42b46a92-f00d-f67c-01d3-e159368b0d7f/mzl.luxnufgj.jpg/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 384 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/42/b4/6a/42b46a92-f00d-f67c-01d3-e159368b0d7f/mzl.luxnufgj.jpg/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/42/b4/6a/42b46a92-f00d-f67c-01d3-e159368b0d7f/mzl.luxnufgj.jpg/600x600bb.jpg');
-- artist 386 Rolando Panerai (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Rolando_Panerai%2C_Torino%2C_1948_-_collezione_Tino_Barindelli_%28ritaglio%29.tif/lossy-page1-960px-Rolando_Panerai%2C_Torino%2C_1948_-_collezione_Tino_Barindelli_%28ritaglio%29.tif.jpg'
WHERE id = 386 AND english_name = 'Rolando Panerai' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Rolando_Panerai,_Torino,_1948_-_collezione_Tino_Barindelli_(ritaglio).tif', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Rolando_Panerai%2C_Torino%2C_1948_-_collezione_Tino_Barindelli_%28ritaglio%29.tif/lossy-page1-960px-Rolando_Panerai%2C_Torino%2C_1948_-_collezione_Tino_Barindelli_%28ritaglio%29.tif.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 386 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Rolando_Panerai%2C_Torino%2C_1948_-_collezione_Tino_Barindelli_%28ritaglio%29.tif/lossy-page1-960px-Rolando_Panerai%2C_Torino%2C_1948_-_collezione_Tino_Barindelli_%28ritaglio%29.tif.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Rolando_Panerai%2C_Torino%2C_1948_-_collezione_Tino_Barindelli_%28ritaglio%29.tif/lossy-page1-960px-Rolando_Panerai%2C_Torino%2C_1948_-_collezione_Tino_Barindelli_%28ritaglio%29.tif.jpg');
-- artist 387 Amel Brahim-Djelloul (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages122/v4/d6/a3/45/d6a3451b-3982-61fd-f362-ef33cc307801/8b740483-7e82-435c-9853-df225529a13b_ami-identity-bf36d3e83d47e4f27edde07b3c15b398-2022-11-01T13-21-12.127Z_cropped.png/600x600bb.jpg'
WHERE id = 387 AND english_name = 'Amel Brahim-Djelloul' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/719977808', 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages122/v4/d6/a3/45/d6a3451b-3982-61fd-f362-ef33cc307801/8b740483-7e82-435c-9853-df225529a13b_ami-identity-bf36d3e83d47e4f27edde07b3c15b398-2022-11-01T13-21-12.127Z_cropped.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 387 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages122/v4/d6/a3/45/d6a3451b-3982-61fd-f362-ef33cc307801/8b740483-7e82-435c-9853-df225529a13b_ami-identity-bf36d3e83d47e4f27edde07b3c15b398-2022-11-01T13-21-12.127Z_cropped.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages122/v4/d6/a3/45/d6a3451b-3982-61fd-f362-ef33cc307801/8b740483-7e82-435c-9853-df225529a13b_ami-identity-bf36d3e83d47e4f27edde07b3c15b398-2022-11-01T13-21-12.127Z_cropped.png/600x600bb.jpg');
-- artist 388 Randi Stene (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bf/Randi_Stene.jpg'
WHERE id = 388 AND english_name = 'Randi Stene' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Randi_Stene.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/bf/Randi_Stene.jpg', 'Trond Rømo', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 388 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bf/Randi_Stene.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bf/Randi_Stene.jpg');
-- artist 389 라비니아 메이여르 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/de/Lavinia_Meijer_playing_the_harp%2C_2011_%282%29.jpg'
WHERE id = 389 AND english_name = 'Lavinia Meijer' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Lavinia_Meijer_playing_the_harp,_2011_(2).jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/de/Lavinia_Meijer_playing_the_harp%2C_2011_%282%29.jpg', 'Fred Ernst', 'CC BY-SA 2.0', 'https://creativecommons.org/licenses/by-sa/2.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 389 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/de/Lavinia_Meijer_playing_the_harp%2C_2011_%282%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/de/Lavinia_Meijer_playing_the_harp%2C_2011_%282%29.jpg');
-- artist 394 Ion Voicu (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/60/Ion_Voicu.jpg'
WHERE id = 394 AND english_name = 'Ion Voicu' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Ion_Voicu.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/60/Ion_Voicu.jpg', NULL, 'Attribution', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 394 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/60/Ion_Voicu.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/60/Ion_Voicu.jpg');
-- artist 395 Jane Berbié (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/08/Jane-Berbi%C3%A9-1.jpg'
WHERE id = 395 AND english_name = 'Jane Berbié' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jane-Berbi%C3%A9-1.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/08/Jane-Berbi%C3%A9-1.jpg', 'No machine-readable author provided. Auriol assumed (based on copyright claims).', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 395 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/08/Jane-Berbi%C3%A9-1.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/0/08/Jane-Berbi%C3%A9-1.jpg');
-- artist 401 Tytus Wojnowicz (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/Tytus_Wojnowicz_2013.jpg'
WHERE id = 401 AND english_name = 'Tytus Wojnowicz' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Tytus_Wojnowicz_2013.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/3f/Tytus_Wojnowicz_2013.jpg', 'This photo was taken by Przemysław JahrAutorem zdjęcia jest Przemysław JahrWykorzystując zdjęcie proszę podać jako autora:Przemysław Jahr / Wikimedia Commons', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 401 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/Tytus_Wojnowicz_2013.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/Tytus_Wojnowicz_2013.jpg');
-- artist 405 Hiro Kurosaki (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/b4/52/54/b452543a-fb9a-400c-3ed7-30d4cbba00d2/mza_14378871064415409573.png/600x600bb.jpg'
WHERE id = 405 AND english_name = 'Hiro Kurosaki' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/161181118', 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/b4/52/54/b452543a-fb9a-400c-3ed7-30d4cbba00d2/mza_14378871064415409573.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 405 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/b4/52/54/b452543a-fb9a-400c-3ed7-30d4cbba00d2/mza_14378871064415409573.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/b4/52/54/b452543a-fb9a-400c-3ed7-30d4cbba00d2/mza_14378871064415409573.png/600x600bb.jpg');
-- artist 407 데이비드 가렛 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cd/David_Garrett_-_2024110190752_2024-04-19_Radio_Regenbogen_Award_2024_-_Sven_-_1D_X_MK_II_-_0163_-_AK8I4419_%28headshot%29.jpg'
WHERE id = 407 AND english_name = 'David Garrett' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:David_Garrett_-_2024110190752_2024-04-19_Radio_Regenbogen_Award_2024_-_Sven_-_1D_X_MK_II_-_0163_-_AK8I4419_(headshot).jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/cd/David_Garrett_-_2024110190752_2024-04-19_Radio_Regenbogen_Award_2024_-_Sven_-_1D_X_MK_II_-_0163_-_AK8I4419_%28headshot%29.jpg', 'Original: Sven Mandel / Derivative work: Danyele', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 407 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cd/David_Garrett_-_2024110190752_2024-04-19_Radio_Regenbogen_Award_2024_-_Sven_-_1D_X_MK_II_-_0163_-_AK8I4419_%28headshot%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cd/David_Garrett_-_2024110190752_2024-04-19_Radio_Regenbogen_Award_2024_-_Sven_-_1D_X_MK_II_-_0163_-_AK8I4419_%28headshot%29.jpg');
-- artist 409 Agata Szymczewska (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/82/f1/6d/82f16d0f-d2e4-1492-c4e9-4c57680b3dec/pr_source.png/600x600bb.jpg'
WHERE id = 409 AND english_name = 'Agata Szymczewska' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/417239965', 'https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/82/f1/6d/82f16d0f-d2e4-1492-c4e9-4c57680b3dec/pr_source.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 409 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/82/f1/6d/82f16d0f-d2e4-1492-c4e9-4c57680b3dec/pr_source.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/82/f1/6d/82f16d0f-d2e4-1492-c4e9-4c57680b3dec/pr_source.png/600x600bb.jpg');
-- artist 411 사토 시노부 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/7e/92/77/7e9277bb-7962-efb0-b0c7-5ceed0d0c5f6/mzl.edmgpulx.jpg/600x600bb.jpg'
WHERE id = 411 AND english_name = 'Shinobu Satō' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/634261375', 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/7e/92/77/7e9277bb-7962-efb0-b0c7-5ceed0d0c5f6/mzl.edmgpulx.jpg/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 411 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/7e/92/77/7e9277bb-7962-efb0-b0c7-5ceed0d0c5f6/mzl.edmgpulx.jpg/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/7e/92/77/7e9277bb-7962-efb0-b0c7-5ceed0d0c5f6/mzl.edmgpulx.jpg/600x600bb.jpg');
-- artist 412 Karin Branzell (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/68/Bramzill_LCCN2014716990.jpg'
WHERE id = 412 AND english_name = 'Karin Branzell' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Bramzill_LCCN2014716990.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/68/Bramzill_LCCN2014716990.jpg', 'Bain News Service, publisher', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 412 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/68/Bramzill_LCCN2014716990.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/68/Bramzill_LCCN2014716990.jpg');
-- artist 413 나카조노 리사 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b3/Lisa_Nakazono_Portrait_Photo.jpg'
WHERE id = 413 AND english_name = 'Lisa Nakazono' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Lisa_Nakazono_Portrait_Photo.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/b3/Lisa_Nakazono_Portrait_Photo.jpg', 'Tyranzion', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 413 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b3/Lisa_Nakazono_Portrait_Photo.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b3/Lisa_Nakazono_Portrait_Photo.jpg');
-- artist 414 Christian Ihle Hadland (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e3/ChristianHadland2017.jpg'
WHERE id = 414 AND english_name = 'Christian Ihle Hadland' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:ChristianHadland2017.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/e3/ChristianHadland2017.jpg', 'Vysotsky', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 414 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e3/ChristianHadland2017.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e3/ChristianHadland2017.jpg');
-- artist 417 Yasuko Ōtani (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b6/Yasuko_Otani_2019.jpg'
WHERE id = 417 AND english_name = 'Yasuko Ōtani' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Yasuko_Otani_2019.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/b6/Yasuko_Otani_2019.jpg', '海上自衛隊東京音楽隊', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 417 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b6/Yasuko_Otani_2019.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b6/Yasuko_Otani_2019.jpg');
-- artist 418 멜리시 죄르지 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5c/Melis_Gy%C3%B6rgy_fortepan_146533.jpg'
WHERE id = 418 AND english_name = 'György Melis' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Melis_Gy%C3%B6rgy_fortepan_146533.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/5c/Melis_Gy%C3%B6rgy_fortepan_146533.jpg', 'FOTO:Fortepan — ID 146533: Adományozó/Donor: Szalay Zoltán.', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 418 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5c/Melis_Gy%C3%B6rgy_fortepan_146533.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5c/Melis_Gy%C3%B6rgy_fortepan_146533.jpg');
-- artist 421 Franck Ferrari (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/84/1858719-franck-ferrari-re-ccedil-oit-la-950x0-2.jpg'
WHERE id = 421 AND english_name = 'Franck Ferrari' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:1858719-franck-ferrari-re-ccedil-oit-la-950x0-2.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/84/1858719-franck-ferrari-re-ccedil-oit-la-950x0-2.jpg', 'Nissa70', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 421 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/84/1858719-franck-ferrari-re-ccedil-oit-la-950x0-2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/84/1858719-franck-ferrari-re-ccedil-oit-la-950x0-2.jpg');
-- artist 423 Wilbert Hazelzet (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features211/v4/e6/af/45/e6af4515-c903-a182-48d8-e6d18810e070/mza_5117342576935763739.png/600x600bb.jpg'
WHERE id = 423 AND english_name = 'Wilbert Hazelzet' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/4345221', 'https://is1-ssl.mzstatic.com/image/thumb/Features211/v4/e6/af/45/e6af4515-c903-a182-48d8-e6d18810e070/mza_5117342576935763739.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 423 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features211/v4/e6/af/45/e6af4515-c903-a182-48d8-e6d18810e070/mza_5117342576935763739.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features211/v4/e6/af/45/e6af4515-c903-a182-48d8-e6d18810e070/mza_5117342576935763739.png/600x600bb.jpg');
-- artist 424 Michele Marelli (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d7/Michele_Marelli_portrait.jpg'
WHERE id = 424 AND english_name = 'Michele Marelli' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Michele_Marelli_portrait.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d7/Michele_Marelli_portrait.jpg', 'the photo has been taken by Roberto Masotti and the artwork shown is by the artist Marco Lodola.', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 424 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d7/Michele_Marelli_portrait.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d7/Michele_Marelli_portrait.jpg');
-- artist 428 야샤 하이페츠 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/6a7aeef10289f8b1235f7e7a06cce20da2d478a2'
WHERE id = 428 AND english_name = 'Jascha Heifetz' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/7yaBUcdjmqPP2vIv6F5bFD', 'https://i.scdn.co/image/6a7aeef10289f8b1235f7e7a06cce20da2d478a2', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 428 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/6a7aeef10289f8b1235f7e7a06cce20da2d478a2'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/6a7aeef10289f8b1235f7e7a06cce20da2d478a2');
-- artist 429 토마시 코니에츠니 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/9d/59/12/9d5912df-b46b-f2f0-c88c-f4a23bf45fdd/pr_source.png/600x600bb.jpg'
WHERE id = 429 AND english_name = 'Tomasz Konieczny' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/553036070', 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/9d/59/12/9d5912df-b46b-f2f0-c88c-f4a23bf45fdd/pr_source.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 429 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/9d/59/12/9d5912df-b46b-f2f0-c88c-f4a23bf45fdd/pr_source.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/9d/59/12/9d5912df-b46b-f2f0-c88c-f4a23bf45fdd/pr_source.png/600x600bb.jpg');
-- artist 431 Lynne Dawson (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/7ad88f432a8e3f627e104d6ef74794650ebca3d4'
WHERE id = 431 AND english_name = 'Lynne Dawson' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/43XANdhJ0X9qTH14fT51TL', 'https://i.scdn.co/image/7ad88f432a8e3f627e104d6ef74794650ebca3d4', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 431 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/7ad88f432a8e3f627e104d6ef74794650ebca3d4'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/7ad88f432a8e3f627e104d6ef74794650ebca3d4');
-- artist 432 나카미치 이쿠요 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music113/v4/02/f4/60/02f4605f-5a8e-a3b3-16e9-c8b5b61c2b25/pr_source.png/600x600bb.jpg'
WHERE id = 432 AND english_name = 'Ikuyo Nakamichi' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/299984455', 'https://is1-ssl.mzstatic.com/image/thumb/Music113/v4/02/f4/60/02f4605f-5a8e-a3b3-16e9-c8b5b61c2b25/pr_source.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 432 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music113/v4/02/f4/60/02f4605f-5a8e-a3b3-16e9-c8b5b61c2b25/pr_source.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music113/v4/02/f4/60/02f4605f-5a8e-a3b3-16e9-c8b5b61c2b25/pr_source.png/600x600bb.jpg');
-- artist 433 시몬 영 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/18/Simone_Young_2010_-_Portrait_by_Bertold_Fabricius.jpg'
WHERE id = 433 AND english_name = 'Simone Young' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Simone_Young_2010_-_Portrait_by_Bertold_Fabricius.jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/18/Simone_Young_2010_-_Portrait_by_Bertold_Fabricius.jpg', 'Bertold Fabricius, professional photographer from Hamburg.', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 433 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/18/Simone_Young_2010_-_Portrait_by_Bertold_Fabricius.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/18/Simone_Young_2010_-_Portrait_by_Bertold_Fabricius.jpg');
-- artist 434 Witold Rowicki (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/58/Rowicki-1210847.jpg'
WHERE id = 434 AND english_name = 'Witold Rowicki' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Rowicki-1210847.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/58/Rowicki-1210847.jpg', 'Ermell', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 434 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/58/Rowicki-1210847.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/58/Rowicki-1210847.jpg');
-- artist 435 Kenneth Tarver (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/c7/e1/95/c7e1959f-8811-c2d3-807e-34c01632e432/pr_source.png/600x600bb.jpg'
WHERE id = 435 AND english_name = 'Kenneth Tarver' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/4796661', 'https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/c7/e1/95/c7e1959f-8811-c2d3-807e-34c01632e432/pr_source.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 435 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/c7/e1/95/c7e1959f-8811-c2d3-807e-34c01632e432/pr_source.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/c7/e1/95/c7e1959f-8811-c2d3-807e-34c01632e432/pr_source.png/600x600bb.jpg');
-- artist 437 피에타리 잉키넨 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/ab6772690000c46ccab525fdefe85a9845eb03c7'
WHERE id = 437 AND english_name = 'Pietari Inkinen' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/7HSpdA66WWQUOz9ERNCvL1', 'https://i.scdn.co/image/ab6772690000c46ccab525fdefe85a9845eb03c7', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 437 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/ab6772690000c46ccab525fdefe85a9845eb03c7'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6772690000c46ccab525fdefe85a9845eb03c7');
-- artist 438 Arve Tellefsen (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a7/Arve_Tellefsen_Harrywad09.jpg'
WHERE id = 438 AND english_name = 'Arve Tellefsen' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Arve_Tellefsen_Harrywad09.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a7/Arve_Tellefsen_Harrywad09.jpg', 'Harry Wad', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 438 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a7/Arve_Tellefsen_Harrywad09.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a7/Arve_Tellefsen_Harrywad09.jpg');
-- artist 441 Vladimir Feltsman (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Vladimir_Feltsman_in_New_York.jpg'
WHERE id = 441 AND english_name = 'Vladimir Feltsman' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Vladimir_Feltsman_in_New_York.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Vladimir_Feltsman_in_New_York.jpg', 'Gotfryd, Bernard, photographer', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 441 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Vladimir_Feltsman_in_New_York.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Vladimir_Feltsman_in_New_York.jpg');
-- artist 442 Caroline Campbell (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/00/Caroline_Campbell.jpg'
WHERE id = 442 AND english_name = 'Caroline Campbell' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Caroline_Campbell.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/00/Caroline_Campbell.jpg', 'Max808', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 442 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/00/Caroline_Campbell.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/0/00/Caroline_Campbell.jpg');
-- artist 444 Sharon Isbin (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/da/Sharon_Isbin_2011.jpg'
WHERE id = 444 AND english_name = 'Sharon Isbin' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Sharon_Isbin_2011.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/da/Sharon_Isbin_2011.jpg', 'laembajada', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 444 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/da/Sharon_Isbin_2011.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/da/Sharon_Isbin_2011.jpg');
-- artist 445 Alexandre Da Costa (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/13/Alexandre_Da_Costa.jpg'
WHERE id = 445 AND english_name = 'Alexandre Da Costa' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Alexandre_Da_Costa.jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/13/Alexandre_Da_Costa.jpg', 'DLivernoche', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 445 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/13/Alexandre_Da_Costa.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/13/Alexandre_Da_Costa.jpg');
-- artist 446 Josef Greindl (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/4f8c34236803e198132f0217fec737172dfa6a2d'
WHERE id = 446 AND english_name = 'Josef Greindl' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/2vZXFmXCmzwuS35JDToX7t', 'https://i.scdn.co/image/4f8c34236803e198132f0217fec737172dfa6a2d', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 446 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/4f8c34236803e198132f0217fec737172dfa6a2d'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/4f8c34236803e198132f0217fec737172dfa6a2d');
-- artist 447 Carlos Barbosa-Lima (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/29/CBL_Red_Bricks_9x12_200_dpi.jpg'
WHERE id = 447 AND english_name = 'Carlos Barbosa-Lima' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:CBL_Red_Bricks_9x12_200_dpi.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/29/CBL_Red_Bricks_9x12_200_dpi.jpg', 'Ldelcasale', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 447 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/29/CBL_Red_Bricks_9x12_200_dpi.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/29/CBL_Red_Bricks_9x12_200_dpi.jpg');
-- artist 449 Josetxu Obregón (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/24/Josetxu_Obreg%C3%B3n.jpg'
WHERE id = 449 AND english_name = 'Josetxu Obregón' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Josetxu_Obreg%C3%B3n.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/24/Josetxu_Obreg%C3%B3n.jpg', 'Josetxu Obregón', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 449 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/24/Josetxu_Obreg%C3%B3n.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/24/Josetxu_Obreg%C3%B3n.jpg');
-- artist 450 Gloria Campaner (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a1/Gloria_Campaner_ph_Bill_Knight.jpg'
WHERE id = 450 AND english_name = 'Gloria Campaner' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Gloria_Campaner_ph_Bill_Knight.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a1/Gloria_Campaner_ph_Bill_Knight.jpg', 'Bill Knight', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 450 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a1/Gloria_Campaner_ph_Bill_Knight.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a1/Gloria_Campaner_ph_Bill_Knight.jpg');
-- artist 455 Regina Resnik (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/a079b9bf8a11c481f55cbb47f8495d8c508fd745'
WHERE id = 455 AND english_name = 'Regina Resnik' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/4EXCZdjgyKeOrYLVqO7Log', 'https://i.scdn.co/image/a079b9bf8a11c481f55cbb47f8495d8c508fd745', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 455 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/a079b9bf8a11c481f55cbb47f8495d8c508fd745'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/a079b9bf8a11c481f55cbb47f8495d8c508fd745');
-- artist 458 Gavriel Lipkind (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6b/Gavriel_Lipkind_by_Lipkind_Productions.jpg'
WHERE id = 458 AND english_name = 'Gavriel Lipkind' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Gavriel_Lipkind_by_Lipkind_Productions.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/6b/Gavriel_Lipkind_by_Lipkind_Productions.jpg', 'Photographer: Marco Borggreve / Copyright holder: Gavriel Lipkind', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 458 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6b/Gavriel_Lipkind_by_Lipkind_Productions.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6b/Gavriel_Lipkind_by_Lipkind_Productions.jpg');
-- artist 459 Blanche Thebom (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e2/Blanche_Thebom_1954.JPG'
WHERE id = 459 AND english_name = 'Blanche Thebom' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Blanche_Thebom_1954.JPG', 'https://upload.wikimedia.org/wikipedia/commons/e/e2/Blanche_Thebom_1954.JPG', 'S. Hurok-Hurok Attractions-concert promoter', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 459 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e2/Blanche_Thebom_1954.JPG'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e2/Blanche_Thebom_1954.JPG');
-- artist 461 Verónica Villarroel (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/59/Ver%C3%B3nica_Villarroel_2011.jpg'
WHERE id = 461 AND english_name = 'Verónica Villarroel' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Ver%C3%B3nica_Villarroel_2011.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/59/Ver%C3%B3nica_Villarroel_2011.jpg', 'Municipalidad Antofagasta', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 461 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/59/Ver%C3%B3nica_Villarroel_2011.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/59/Ver%C3%B3nica_Villarroel_2011.jpg');
-- artist 463 프랑크 붕가르텐 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Frank_Bungarten_111.jpg'
WHERE id = 463 AND english_name = 'Frank Bungarten' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Frank_Bungarten_111.jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Frank_Bungarten_111.jpg', 'Maxneo111', 'CC BY-SA 2.0', 'https://creativecommons.org/licenses/by-sa/2.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 463 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Frank_Bungarten_111.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Frank_Bungarten_111.jpg');
-- artist 464 Antonio José (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/dd/Antonio_Jos%C3%A9_en_Vodafone_yu.jpg'
WHERE id = 464 AND english_name = 'Antonio José' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Antonio_Jos%C3%A9_en_Vodafone_yu.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/dd/Antonio_Jos%C3%A9_en_Vodafone_yu.jpg', 'Manoloyuser', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 464 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/dd/Antonio_Jos%C3%A9_en_Vodafone_yu.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/dd/Antonio_Jos%C3%A9_en_Vodafone_yu.jpg');
-- artist 465 Jadwiga Rappé (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/38/Jadwiga_Rapp%C3%A9_Polish_classical_singer.jpg'
WHERE id = 465 AND english_name = 'Jadwiga Rappé' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jadwiga_Rapp%C3%A9_Polish_classical_singer.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/38/Jadwiga_Rapp%C3%A9_Polish_classical_singer.jpg', 'photographer Andrzej Świetlik', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 465 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/38/Jadwiga_Rapp%C3%A9_Polish_classical_singer.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/38/Jadwiga_Rapp%C3%A9_Polish_classical_singer.jpg');
-- artist 467 기욤 레미 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/29/Guillaume_Remy_%28cropped%29.jpg'
WHERE id = 467 AND english_name = 'Guillaume Rémy' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Guillaume_Remy_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/29/Guillaume_Remy_%28cropped%29.jpg', 'Alcide Allevy', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 467 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/29/Guillaume_Remy_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/29/Guillaume_Remy_%28cropped%29.jpg');
-- artist 470 Cesare Siepi (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Cesare_Siepi%2C_anni_1950_-_collezione_Tino_Barindelli.tif/lossy-page1-960px-Cesare_Siepi%2C_anni_1950_-_collezione_Tino_Barindelli.tif.jpg'
WHERE id = 470 AND english_name = 'Cesare Siepi' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Cesare_Siepi,_anni_1950_-_collezione_Tino_Barindelli.tif', 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Cesare_Siepi%2C_anni_1950_-_collezione_Tino_Barindelli.tif/lossy-page1-960px-Cesare_Siepi%2C_anni_1950_-_collezione_Tino_Barindelli.tif.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 470 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Cesare_Siepi%2C_anni_1950_-_collezione_Tino_Barindelli.tif/lossy-page1-960px-Cesare_Siepi%2C_anni_1950_-_collezione_Tino_Barindelli.tif.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Cesare_Siepi%2C_anni_1950_-_collezione_Tino_Barindelli.tif/lossy-page1-960px-Cesare_Siepi%2C_anni_1950_-_collezione_Tino_Barindelli.tif.jpg');
-- artist 471 얀도 예노 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/87/25/cc/8725cc42-f871-3a41-acfd-1a7344e1b309/mzl.pqnkbcxa.png/600x600bb.jpg'
WHERE id = 471 AND english_name = 'Jenő Jandó' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/3323344', 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/87/25/cc/8725cc42-f871-3a41-acfd-1a7344e1b309/mzl.pqnkbcxa.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 471 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/87/25/cc/8725cc42-f871-3a41-acfd-1a7344e1b309/mzl.pqnkbcxa.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/87/25/cc/8725cc42-f871-3a41-acfd-1a7344e1b309/mzl.pqnkbcxa.png/600x600bb.jpg');
-- artist 474 미야모토 후미아키 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/ab6772690000c46c63eccb0f8f3d43136b64a687'
WHERE id = 474 AND english_name = 'Fumiaki Miyamoto' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/6dmUdpxkwlK0RxdJldLll3', 'https://i.scdn.co/image/ab6772690000c46c63eccb0f8f3d43136b64a687', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 474 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/ab6772690000c46c63eccb0f8f3d43136b64a687'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6772690000c46c63eccb0f8f3d43136b64a687');
-- artist 475 Elena Gerhardt (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/8a38a730862093ff45312e83cfdde3605c209d63'
WHERE id = 475 AND english_name = 'Elena Gerhardt' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/3xPkiC46HjHfbe6axfTp42', 'https://i.scdn.co/image/8a38a730862093ff45312e83cfdde3605c209d63', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 475 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/8a38a730862093ff45312e83cfdde3605c209d63'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/8a38a730862093ff45312e83cfdde3605c209d63');
-- artist 476 Delfina Ambroziak (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/57/Delfina_Ambroziak.jpg'
WHERE id = 476 AND english_name = 'Delfina Ambroziak' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Delfina_Ambroziak.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/57/Delfina_Ambroziak.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 476 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/57/Delfina_Ambroziak.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/57/Delfina_Ambroziak.jpg');
-- artist 477 Krzysztof Urbański (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/ab6761610000e5ebad871cfa51050b946d30f623'
WHERE id = 477 AND english_name = 'Krzysztof Urbański' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/4u4T4u2Z9MqnLAptUlCM2w', 'https://i.scdn.co/image/ab6761610000e5ebad871cfa51050b946d30f623', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 477 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/ab6761610000e5ebad871cfa51050b946d30f623'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761610000e5ebad871cfa51050b946d30f623');
-- artist 478 알레산드로 사피나 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/41c63be4487e9b02f319fa25dc89524bbc83c1b3'
WHERE id = 478 AND english_name = 'Alessandro Safina' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/5ITJs06INM9JWxK5hROEj3', 'https://i.scdn.co/image/41c63be4487e9b02f319fa25dc89524bbc83c1b3', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 478 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/41c63be4487e9b02f319fa25dc89524bbc83c1b3'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/41c63be4487e9b02f319fa25dc89524bbc83c1b3');
-- artist 480 요엘 레비 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/6733dcac56c7f35f2f534eb7d0e4fefc78dd19ff'
WHERE id = 480 AND english_name = 'Yoel Levi' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/5g1dWN1Hc2Ez59EnbqgGYc', 'https://i.scdn.co/image/6733dcac56c7f35f2f534eb7d0e4fefc78dd19ff', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 480 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/6733dcac56c7f35f2f534eb7d0e4fefc78dd19ff'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/6733dcac56c7f35f2f534eb7d0e4fefc78dd19ff');
-- artist 481 Leo Slezak (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9e/Leo_Slezak_1927.jpg'
WHERE id = 481 AND english_name = 'Leo Slezak' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Leo_Slezak_1927.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/9e/Leo_Slezak_1927.jpg', 'Ferdinand Schmutzer', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 481 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9e/Leo_Slezak_1927.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9e/Leo_Slezak_1927.jpg');
-- artist 482 Roberto Urbay (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8e/RobertoUrbay.jpg'
WHERE id = 482 AND english_name = 'Roberto Urbay' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:RobertoUrbay.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/8e/RobertoUrbay.jpg', 'PassionatoAssai', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 482 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8e/RobertoUrbay.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8e/RobertoUrbay.jpg');
-- artist 484 Hu Nai-yuan (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/0c/a6/40/0ca640e4-5a39-58b5-512b-5aece6b9eac8/mzl.bozyhomv.jpg/600x600bb.jpg'
WHERE id = 484 AND english_name = 'Hu Nai-yuan' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/284096330', 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/0c/a6/40/0ca640e4-5a39-58b5-512b-5aece6b9eac8/mzl.bozyhomv.jpg/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 484 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/0c/a6/40/0ca640e4-5a39-58b5-512b-5aece6b9eac8/mzl.bozyhomv.jpg/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/0c/a6/40/0ca640e4-5a39-58b5-512b-5aece6b9eac8/mzl.bozyhomv.jpg/600x600bb.jpg');
-- artist 485 Jadwiga Kotnowska (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/92/Jadwiga_Kotnowska.jpg'
WHERE id = 485 AND english_name = 'Jadwiga Kotnowska' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jadwiga_Kotnowska.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/92/Jadwiga_Kotnowska.jpg', 'Iwona Limonca', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 485 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/92/Jadwiga_Kotnowska.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/92/Jadwiga_Kotnowska.jpg');
-- artist 486 Natasha Marsh (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/ab67616d0000b273aa2ef2027825cec69fa9b2a3'
WHERE id = 486 AND english_name = 'Natasha Marsh' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/3jTYaIoa2XJ0EUsPFGFKys', 'https://i.scdn.co/image/ab67616d0000b273aa2ef2027825cec69fa9b2a3', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 486 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/ab67616d0000b273aa2ef2027825cec69fa9b2a3'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab67616d0000b273aa2ef2027825cec69fa9b2a3');
-- artist 487 사이먼 킨리사이드 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/2f/7a/c7/2f7ac7b2-1631-2c64-09d2-9407239aefbc/a7d8b5e9-93b6-4fd3-a46a-111ae6f5eb6c.png/600x600bb.jpg'
WHERE id = 487 AND english_name = 'Simon Keenlyside' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/14810939', 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/2f/7a/c7/2f7ac7b2-1631-2c64-09d2-9407239aefbc/a7d8b5e9-93b6-4fd3-a46a-111ae6f5eb6c.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 487 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/2f/7a/c7/2f7ac7b2-1631-2c64-09d2-9407239aefbc/a7d8b5e9-93b6-4fd3-a46a-111ae6f5eb6c.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/2f/7a/c7/2f7ac7b2-1631-2c64-09d2-9407239aefbc/a7d8b5e9-93b6-4fd3-a46a-111ae6f5eb6c.png/600x600bb.jpg');
-- artist 488 Camilla Wicks (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2f/25806_Camilla_Wicks.jpg'
WHERE id = 488 AND english_name = 'Camilla Wicks' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:25806_Camilla_Wicks.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/2f/25806_Camilla_Wicks.jpg', 'Leif Ørnelund', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 488 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2f/25806_Camilla_Wicks.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2f/25806_Camilla_Wicks.jpg');
-- artist 489 레오 누치 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Leo_nucci.jpg'
WHERE id = 489 AND english_name = 'Leo Nucci' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Leo_nucci.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Leo_nucci.jpg', 'Rainer Leiss Author: Rainer Leiss', 'CC BY 2.5', 'https://creativecommons.org/licenses/by/2.5', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 489 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Leo_nucci.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Leo_nucci.jpg');
-- artist 491 Trouvère Quartet (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/d4/69/a9/d469a9c7-0cca-9dcd-4093-1684ff95812e/f17e444a-5049-496c-a545-b0e9b744d344.png/600x600bb.jpg'
WHERE id = 491 AND english_name = 'Trouvère Quartet' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/204094139', 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/d4/69/a9/d469a9c7-0cca-9dcd-4093-1684ff95812e/f17e444a-5049-496c-a545-b0e9b744d344.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 491 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/d4/69/a9/d469a9c7-0cca-9dcd-4093-1684ff95812e/f17e444a-5049-496c-a545-b0e9b744d344.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/d4/69/a9/d469a9c7-0cca-9dcd-4093-1684ff95812e/f17e444a-5049-496c-a545-b0e9b744d344.png/600x600bb.jpg');
-- artist 492 The 5 Browns (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/72/The_5_Browns.jpg'
WHERE id = 492 AND english_name = 'The 5 Browns' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:The_5_Browns.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/72/The_5_Browns.jpg', 'Giuseppe1925', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 492 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/72/The_5_Browns.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/72/The_5_Browns.jpg');
-- artist 493 Augustin Dumay (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/72/d8/d3/72d8d34c-320d-26bc-e0d5-db1865fbced8/bd99f568-5a6d-4b88-b760-1f7c6a511083.png/600x600bb.jpg'
WHERE id = 493 AND english_name = 'Augustin Dumay' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/4563029', 'https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/72/d8/d3/72d8d34c-320d-26bc-e0d5-db1865fbced8/bd99f568-5a6d-4b88-b760-1f7c6a511083.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 493 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/72/d8/d3/72d8d34c-320d-26bc-e0d5-db1865fbced8/bd99f568-5a6d-4b88-b760-1f7c6a511083.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/72/d8/d3/72d8d34c-320d-26bc-e0d5-db1865fbced8/bd99f568-5a6d-4b88-b760-1f7c6a511083.png/600x600bb.jpg');
-- artist 495 다비드 오이스트라흐 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cc/David_Oistrach_1953.jpg'
WHERE id = 495 AND english_name = 'David Oistrakh' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:David_Oistrach_1953.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/cc/David_Oistrach_1953.jpg', 'Главархив Москвы', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 495 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cc/David_Oistrach_1953.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cc/David_Oistrach_1953.jpg');
-- artist 497 William Joseph (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/eb/William_Joseph_by_Gage_Skidmore.jpg'
WHERE id = 497 AND english_name = 'William Joseph' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:William_Joseph_by_Gage_Skidmore.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/eb/William_Joseph_by_Gage_Skidmore.jpg', 'Gage Skidmore', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 497 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/eb/William_Joseph_by_Gage_Skidmore.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/eb/William_Joseph_by_Gage_Skidmore.jpg');
-- artist 499 Ferruccio Furlanetto (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/cb443cdea005919162d33bff70fc4203b614c1ff'
WHERE id = 499 AND english_name = 'Ferruccio Furlanetto' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/5fN6PDw4pvvYRQtseOS4ru', 'https://i.scdn.co/image/cb443cdea005919162d33bff70fc4203b614c1ff', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 499 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/cb443cdea005919162d33bff70fc4203b614c1ff'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/cb443cdea005919162d33bff70fc4203b614c1ff');
-- artist 501 Karine Deshayes (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/57/Karine_Deshayes.jpg'
WHERE id = 501 AND english_name = 'Karine Deshayes' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Karine_Deshayes.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/57/Karine_Deshayes.jpg', 'VeronicaO', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 501 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/57/Karine_Deshayes.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/57/Karine_Deshayes.jpg');
-- artist 502 Amit Dolberg (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/dc/Amit_Dolberg.JPG'
WHERE id = 502 AND english_name = 'Amit Dolberg' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Amit_Dolberg.JPG', 'https://upload.wikimedia.org/wikipedia/commons/d/dc/Amit_Dolberg.JPG', 'Botend', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 502 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/dc/Amit_Dolberg.JPG'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/dc/Amit_Dolberg.JPG');
-- artist 503 Tim Mead (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1a/Tim_Mead_sitting.jpg'
WHERE id = 503 AND english_name = 'Tim Mead' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Tim_Mead_sitting.jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/1a/Tim_Mead_sitting.jpg', 'Andy Staples', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 503 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1a/Tim_Mead_sitting.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1a/Tim_Mead_sitting.jpg');
-- artist 505 Burak Bilgili (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/38/Burak_abi.JPG'
WHERE id = 505 AND english_name = 'Burak Bilgili' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Burak_abi.JPG', 'https://upload.wikimedia.org/wikipedia/commons/3/38/Burak_abi.JPG', 'Avicenna23', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 505 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/38/Burak_abi.JPG'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/38/Burak_abi.JPG');
-- artist 506 Jarmila Novotná (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/c7dfded2f1dbb13a60c7af3aab3683d5f6924c9a'
WHERE id = 506 AND english_name = 'Jarmila Novotná' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/7IPE1DKqWUlGlCPFcM162L', 'https://i.scdn.co/image/c7dfded2f1dbb13a60c7af3aab3683d5f6924c9a', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 506 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/c7dfded2f1dbb13a60c7af3aab3683d5f6924c9a'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/c7dfded2f1dbb13a60c7af3aab3683d5f6924c9a');
-- artist 513 Konstantin Soukhovetski (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages112/v4/66/db/57/66db57c7-11d5-c881-0878-88cdd4f4ad23/57399598-2179-4c68-9ddb-a71d5de75a7b_ami-identity-8b0a6f5946aa8a9ac2a971decfbb3ced-2022-11-09T16-05-32.830Z_cropped.png/600x600bb.jpg'
WHERE id = 513 AND english_name = 'Konstantin Soukhovetski' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/1315104114', 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages112/v4/66/db/57/66db57c7-11d5-c881-0878-88cdd4f4ad23/57399598-2179-4c68-9ddb-a71d5de75a7b_ami-identity-8b0a6f5946aa8a9ac2a971decfbb3ced-2022-11-09T16-05-32.830Z_cropped.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 513 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages112/v4/66/db/57/66db57c7-11d5-c881-0878-88cdd4f4ad23/57399598-2179-4c68-9ddb-a71d5de75a7b_ami-identity-8b0a6f5946aa8a9ac2a971decfbb3ced-2022-11-09T16-05-32.830Z_cropped.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages112/v4/66/db/57/66db57c7-11d5-c881-0878-88cdd4f4ad23/57399598-2179-4c68-9ddb-a71d5de75a7b_ami-identity-8b0a6f5946aa8a9ac2a971decfbb3ced-2022-11-09T16-05-32.830Z_cropped.png/600x600bb.jpg');
-- artist 514 이레네 아벤드로트 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/38/Irene_abendroth.jpg'
WHERE id = 514 AND english_name = 'Irene Abendroth' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Irene_abendroth.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/38/Irene_abendroth.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 514 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/38/Irene_abendroth.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/38/Irene_abendroth.jpg');
-- artist 515 Marie-Françoise Bucquet (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/65/Marie-Fran%C3%A7oise_Bucquet.jpg'
WHERE id = 515 AND english_name = 'Marie-Françoise Bucquet' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Marie-Fran%C3%A7oise_Bucquet.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/65/Marie-Fran%C3%A7oise_Bucquet.jpg', 'W&SI37', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 515 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/65/Marie-Fran%C3%A7oise_Bucquet.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/65/Marie-Fran%C3%A7oise_Bucquet.jpg');
-- artist 517 Michael Weinius (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/67/LA2_Michael_Weinius.jpg'
WHERE id = 517 AND english_name = 'Michael Weinius' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:LA2_Michael_Weinius.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/67/LA2_Michael_Weinius.jpg', 'LA2', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 517 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/67/LA2_Michael_Weinius.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/67/LA2_Michael_Weinius.jpg');
-- artist 518 Rashid Vatandoust (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/ba/Rashid_Vatandoust.jpg'
WHERE id = 518 AND english_name = 'Rashid Vatandoust' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Rashid_Vatandoust.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/ba/Rashid_Vatandoust.jpg', 'Mohammad Khodabakhsh', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 518 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/ba/Rashid_Vatandoust.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/ba/Rashid_Vatandoust.jpg');
-- artist 519 피에로 카푸칠리 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/34/Piero_Cappuccilli_75.jpg'
WHERE id = 519 AND english_name = 'Piero Cappuccilli' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Piero_Cappuccilli_75.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/34/Piero_Cappuccilli_75.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 519 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/34/Piero_Cappuccilli_75.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/34/Piero_Cappuccilli_75.jpg');
-- artist 522 Ruslan Maynov (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e4/Ruslan_mainov.jpg'
WHERE id = 522 AND english_name = 'Ruslan Maynov' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Ruslan_mainov.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/e4/Ruslan_mainov.jpg', 'Biser Todorov', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 522 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e4/Ruslan_mainov.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e4/Ruslan_mainov.jpg');
-- artist 523 Cláudio Cruz (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/76/68/24/76682427-61d0-c899-a08d-4f6f9dc68ba1/pr_source.png/600x600bb.jpg'
WHERE id = 523 AND english_name = 'Cláudio Cruz' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/60841752', 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/76/68/24/76682427-61d0-c899-a08d-4f6f9dc68ba1/pr_source.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 523 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/76/68/24/76682427-61d0-c899-a08d-4f6f9dc68ba1/pr_source.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/76/68/24/76682427-61d0-c899-a08d-4f6f9dc68ba1/pr_source.png/600x600bb.jpg');
-- artist 525 수산네 뤼덴 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Susanne_Ryden_01_%28cropped%29.JPG'
WHERE id = 525 AND english_name = 'Susanne Rydén' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Susanne_Ryden_01_(cropped).JPG', 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Susanne_Ryden_01_%28cropped%29.JPG', 'Bengt Oberger', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 525 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Susanne_Ryden_01_%28cropped%29.JPG'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Susanne_Ryden_01_%28cropped%29.JPG');
-- artist 526 Thibault Cauvin (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bc/Thibault_Cauvin_Flaneries_musicales_Reims_04212.JPG'
WHERE id = 526 AND english_name = 'Thibault Cauvin' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Thibault_Cauvin_Flaneries_musicales_Reims_04212.JPG', 'https://upload.wikimedia.org/wikipedia/commons/b/bc/Thibault_Cauvin_Flaneries_musicales_Reims_04212.JPG', 'G.Garitan', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 526 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bc/Thibault_Cauvin_Flaneries_musicales_Reims_04212.JPG'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bc/Thibault_Cauvin_Flaneries_musicales_Reims_04212.JPG');
-- artist 527 Ginette Neveu (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c7/Violinist_Ginette_Neveu_SLNSW_FL16326315.jpg'
WHERE id = 527 AND english_name = 'Ginette Neveu' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Violinist_Ginette_Neveu_SLNSW_FL16326315.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/c7/Violinist_Ginette_Neveu_SLNSW_FL16326315.jpg', 'Max Dupain', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 527 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c7/Violinist_Ginette_Neveu_SLNSW_FL16326315.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c7/Violinist_Ginette_Neveu_SLNSW_FL16326315.jpg');
-- artist 529 Cécile Ousset (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/c2/8c/2f/c28c2f89-fb00-c9a3-bc3f-95b990627832/7a399d0a-fc51-4c2a-beaf-8b8f9169b99e.png/600x600bb.jpg'
WHERE id = 529 AND english_name = 'Cécile Ousset' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/821077', 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/c2/8c/2f/c28c2f89-fb00-c9a3-bc3f-95b990627832/7a399d0a-fc51-4c2a-beaf-8b8f9169b99e.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 529 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/c2/8c/2f/c28c2f89-fb00-c9a3-bc3f-95b990627832/7a399d0a-fc51-4c2a-beaf-8b8f9169b99e.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/c2/8c/2f/c28c2f89-fb00-c9a3-bc3f-95b990627832/7a399d0a-fc51-4c2a-beaf-8b8f9169b99e.png/600x600bb.jpg');
-- artist 531 Alison Crum (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/1b5c9672115cd081fdfc9e619435b8c2e632288d'
WHERE id = 531 AND english_name = 'Alison Crum' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/0xNJjEAyksAze8Dze7dsM8', 'https://i.scdn.co/image/1b5c9672115cd081fdfc9e619435b8c2e632288d', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 531 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/1b5c9672115cd081fdfc9e619435b8c2e632288d'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/1b5c9672115cd081fdfc9e619435b8c2e632288d');
-- artist 532 João Carlos Martins (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f7/2024-12-03%2C_CE_-_Comiss%C3%A3o_de_Educa%C3%A7%C3%A3o_e_Cultura%2C_014_%28Jo%C3%A3o_Carlos_Martins%29.jpg'
WHERE id = 532 AND english_name = 'João Carlos Martins' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:2024-12-03,_CE_-_Comiss%C3%A3o_de_Educa%C3%A7%C3%A3o_e_Cultura,_014_(Jo%C3%A3o_Carlos_Martins).jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f7/2024-12-03%2C_CE_-_Comiss%C3%A3o_de_Educa%C3%A7%C3%A3o_e_Cultura%2C_014_%28Jo%C3%A3o_Carlos_Martins%29.jpg', 'Senado Federal', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 532 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f7/2024-12-03%2C_CE_-_Comiss%C3%A3o_de_Educa%C3%A7%C3%A3o_e_Cultura%2C_014_%28Jo%C3%A3o_Carlos_Martins%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f7/2024-12-03%2C_CE_-_Comiss%C3%A3o_de_Educa%C3%A7%C3%A3o_e_Cultura%2C_014_%28Jo%C3%A3o_Carlos_Martins%29.jpg');
-- artist 533 고바야시 아이미 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/84/Aimi_Kobayashi_-_Chopin_and_his_Europe_2022-08-22.jpg'
WHERE id = 533 AND english_name = 'Aimi Kobayashi' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Aimi_Kobayashi_-_Chopin_and_his_Europe_2022-08-22.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/84/Aimi_Kobayashi_-_Chopin_and_his_Europe_2022-08-22.jpg', 'Robert Drózd', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 533 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/84/Aimi_Kobayashi_-_Chopin_and_his_Europe_2022-08-22.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/84/Aimi_Kobayashi_-_Chopin_and_his_Europe_2022-08-22.jpg');
-- artist 534 Anders Näslund (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/49/Anders_N%C3%A4slund_circa_1960.jpg'
WHERE id = 534 AND english_name = 'Anders Näslund' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Anders_N%C3%A4slund_circa_1960.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/49/Anders_N%C3%A4slund_circa_1960.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 534 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/49/Anders_N%C3%A4slund_circa_1960.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/49/Anders_N%C3%A4slund_circa_1960.jpg');
-- artist 535 Gervase de Peyer (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/0729b7db0495324e4676236f47470cf7a276878d'
WHERE id = 535 AND english_name = 'Gervase de Peyer' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/77LIzLu0vVqpJSLd7xQKTU', 'https://i.scdn.co/image/0729b7db0495324e4676236f47470cf7a276878d', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 535 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/0729b7db0495324e4676236f47470cf7a276878d'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/0729b7db0495324e4676236f47470cf7a276878d');
-- artist 536 호바르 임세 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/29/e5/9b/29e59b73-a2f9-673d-9105-0d925dd4effe/7bb7ab94-8951-4ee0-9461-2f00b83237e2.png/600x600bb.jpg'
WHERE id = 536 AND english_name = 'Håvard Gimse' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/2679704', 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/29/e5/9b/29e59b73-a2f9-673d-9105-0d925dd4effe/7bb7ab94-8951-4ee0-9461-2f00b83237e2.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 536 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/29/e5/9b/29e59b73-a2f9-673d-9105-0d925dd4effe/7bb7ab94-8951-4ee0-9461-2f00b83237e2.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/29/e5/9b/29e59b73-a2f9-673d-9105-0d925dd4effe/7bb7ab94-8951-4ee0-9461-2f00b83237e2.png/600x600bb.jpg');
-- artist 537 Yann Beuron (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a8/Yannbeuron.jpg'
WHERE id = 537 AND english_name = 'Yann Beuron' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Yannbeuron.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a8/Yannbeuron.jpg', 'yann beuron', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 537 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a8/Yannbeuron.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a8/Yannbeuron.jpg');
-- artist 538 누르 제한 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/71/Noor_Jehan_in_Zeenat.jpg'
WHERE id = 538 AND english_name = 'Noor Jehan' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Noor_Jehan_in_Zeenat.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/71/Noor_Jehan_in_Zeenat.jpg', 'FilmIndia', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 538 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/71/Noor_Jehan_in_Zeenat.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/71/Noor_Jehan_in_Zeenat.jpg');
-- artist 539 Lina Bruna Rasa (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c2/Lina_Bruna_Rasa.jpg'
WHERE id = 539 AND english_name = 'Lina Bruna Rasa' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Lina_Bruna_Rasa.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/c2/Lina_Bruna_Rasa.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 539 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c2/Lina_Bruna_Rasa.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c2/Lina_Bruna_Rasa.jpg');
-- artist 540 에르네스티네 슈만하잉크 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Schumann-Heink_LOC_16269560308.jpg'
WHERE id = 540 AND english_name = 'Ernestine Schumann-Heink' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Schumann-Heink_LOC_16269560308.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Schumann-Heink_LOC_16269560308.jpg', 'The Library of Congress', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 540 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Schumann-Heink_LOC_16269560308.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Schumann-Heink_LOC_16269560308.jpg');
-- artist 541 안젤라 휴이트 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/06/Angela_Hewitt_Toronto2017_%28cropped%29.jpg'
WHERE id = 541 AND english_name = 'Angela Hewitt' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Angela_Hewitt_Toronto2017_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/06/Angela_Hewitt_Toronto2017_%28cropped%29.jpg', 'Original: Mykola Swarnyk Derivative work: Danyele', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 541 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/06/Angela_Hewitt_Toronto2017_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/0/06/Angela_Hewitt_Toronto2017_%28cropped%29.jpg');
-- artist 543 Bernhard Kontarsky (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/1ffaba9bf608a444c258af8ce92f5f7568d60379'
WHERE id = 543 AND english_name = 'Bernhard Kontarsky' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/4luNKQ4icX84IgCgC49hLQ', 'https://i.scdn.co/image/1ffaba9bf608a444c258af8ce92f5f7568d60379', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 543 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/1ffaba9bf608a444c258af8ce92f5f7568d60379'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/1ffaba9bf608a444c258af8ce92f5f7568d60379');
-- artist 548 Carlo Zecchi (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Carlo_Zecchi%2C_1957_-_collezione_Tino_Barindelli.tif/lossy-page1-960px-Carlo_Zecchi%2C_1957_-_collezione_Tino_Barindelli.tif.jpg'
WHERE id = 548 AND english_name = 'Carlo Zecchi' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Carlo_Zecchi,_1957_-_collezione_Tino_Barindelli.tif', 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Carlo_Zecchi%2C_1957_-_collezione_Tino_Barindelli.tif/lossy-page1-960px-Carlo_Zecchi%2C_1957_-_collezione_Tino_Barindelli.tif.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 548 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Carlo_Zecchi%2C_1957_-_collezione_Tino_Barindelli.tif/lossy-page1-960px-Carlo_Zecchi%2C_1957_-_collezione_Tino_Barindelli.tif.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Carlo_Zecchi%2C_1957_-_collezione_Tino_Barindelli.tif/lossy-page1-960px-Carlo_Zecchi%2C_1957_-_collezione_Tino_Barindelli.tif.jpg');
-- artist 551 Anna Larsson (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/16/Anna_Larsson%2C_alt.JPG'
WHERE id = 551 AND english_name = 'Anna Larsson' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Anna_Larsson,_alt.JPG', 'https://upload.wikimedia.org/wikipedia/commons/1/16/Anna_Larsson%2C_alt.JPG', 'Eskil Malmberg', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 551 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/16/Anna_Larsson%2C_alt.JPG'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/16/Anna_Larsson%2C_alt.JPG');
-- artist 553 스즈키 신이치 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/67/bb/a6/67bba60f-8dac-37d9-bfea-8227bcf044a0/mza_12748552119483048881.png/600x600bb.jpg'
WHERE id = 553 AND english_name = 'Shin''ichi Suzuki' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/208596512', 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/67/bb/a6/67bba60f-8dac-37d9-bfea-8227bcf044a0/mza_12748552119483048881.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 553 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/67/bb/a6/67bba60f-8dac-37d9-bfea-8227bcf044a0/mza_12748552119483048881.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/67/bb/a6/67bba60f-8dac-37d9-bfea-8227bcf044a0/mza_12748552119483048881.png/600x600bb.jpg');
-- artist 555 Otmar Suitner (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Otmar-Suitner.jpg'
WHERE id = 555 AND english_name = 'Otmar Suitner' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Otmar-Suitner.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Otmar-Suitner.jpg', 'G. Liebig, Inductor 13:59, 8. Sep. 2009 (CEST)', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 555 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Otmar-Suitner.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Otmar-Suitner.jpg');
-- artist 560 Kaori Uemura (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/c7/8c/51/c78c51a7-48f4-9a4a-2320-9491b5496ada/mzl.wdbjplgg.jpg/600x600bb.jpg'
WHERE id = 560 AND english_name = 'Kaori Uemura' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/123060584', 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/c7/8c/51/c78c51a7-48f4-9a4a-2320-9491b5496ada/mzl.wdbjplgg.jpg/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 560 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/c7/8c/51/c78c51a7-48f4-9a4a-2320-9491b5496ada/mzl.wdbjplgg.jpg/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/c7/8c/51/c78c51a7-48f4-9a4a-2320-9491b5496ada/mzl.wdbjplgg.jpg/600x600bb.jpg');
-- artist 579 볼프강 조보트카 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2d/Wolfgang_Sobotka_BHO-0079_%28cropped%29.jpg'
WHERE id = 579 AND english_name = 'Wolfgang Sobotka' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Wolfgang_Sobotka_BHO-0079_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/2d/Wolfgang_Sobotka_BHO-0079_%28cropped%29.jpg', 'Bernhard Holub', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 579 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2d/Wolfgang_Sobotka_BHO-0079_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2d/Wolfgang_Sobotka_BHO-0079_%28cropped%29.jpg');
-- artist 593 레이먼드 레파드 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/6bbf2b0deccc72de1669f2dbfb20df5d4e26ec6b'
WHERE id = 593 AND english_name = 'Raymond Leppard' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/6RX3X6dI939ANy78YXqWXT', 'https://i.scdn.co/image/6bbf2b0deccc72de1669f2dbfb20df5d4e26ec6b', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 593 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/6bbf2b0deccc72de1669f2dbfb20df5d4e26ec6b'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/6bbf2b0deccc72de1669f2dbfb20df5d4e26ec6b');
-- artist 595 한스 슈타틀마이어 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/ace2e880a85c7ed58e16612d2b799f528f2cc456'
WHERE id = 595 AND english_name = 'Hans Stadlmair' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/2nSo5GklA6StFDLyVq0uEA', 'https://i.scdn.co/image/ace2e880a85c7ed58e16612d2b799f528f2cc456', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 595 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/ace2e880a85c7ed58e16612d2b799f528f2cc456'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ace2e880a85c7ed58e16612d2b799f528f2cc456');
-- artist 608 세인트로렌스 현악 4중주단 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/ab6761610000e5eb952486dce9d18e7e682bcfb4'
WHERE id = 608 AND english_name = 'St. Lawrence String Quartet' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/58YsnduEdytXyJYLELXpJk', 'https://i.scdn.co/image/ab6761610000e5eb952486dce9d18e7e682bcfb4', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 608 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/ab6761610000e5eb952486dce9d18e7e682bcfb4'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761610000e5eb952486dce9d18e7e682bcfb4');
-- artist 616 휴 울프 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/6e/c6/34/6ec63483-2959-72e0-2cc0-1e7e588bcb22/24a3bcff-6ad4-4483-826b-292e0c6d2051.png/600x600bb.jpg'
WHERE id = 616 AND english_name = 'Hugh Wolff' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/1129536', 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/6e/c6/34/6ec63483-2959-72e0-2cc0-1e7e588bcb22/24a3bcff-6ad4-4483-826b-292e0c6d2051.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 616 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/6e/c6/34/6ec63483-2959-72e0-2cc0-1e7e588bcb22/24a3bcff-6ad4-4483-826b-292e0c6d2051.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/6e/c6/34/6ec63483-2959-72e0-2cc0-1e7e588bcb22/24a3bcff-6ad4-4483-826b-292e0c6d2051.png/600x600bb.jpg');
-- artist 635 베르트랑 드 비이 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/1c4dfb6fe547aef68bb05d566ee0f18cf50d24cd'
WHERE id = 635 AND english_name = 'Bertrand de Billy' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/6kbc1zpIRBv6xijMei9dra', 'https://i.scdn.co/image/1c4dfb6fe547aef68bb05d566ee0f18cf50d24cd', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 635 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/1c4dfb6fe547aef68bb05d566ee0f18cf50d24cd'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/1c4dfb6fe547aef68bb05d566ee0f18cf50d24cd');
-- artist 656 암브로시안 싱어스 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/dc/d2/a5/dcd2a52d-757a-7898-0683-04b235c3aba7/e83d36ab-0bbb-4b3a-9060-7e565f224b65.png/600x600bb.jpg'
WHERE id = 656 AND english_name = 'Ambrosian Singers' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/78336', 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/dc/d2/a5/dcd2a52d-757a-7898-0683-04b235c3aba7/e83d36ab-0bbb-4b3a-9060-7e565f224b65.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 656 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/dc/d2/a5/dcd2a52d-757a-7898-0683-04b235c3aba7/e83d36ab-0bbb-4b3a-9060-7e565f224b65.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/dc/d2/a5/dcd2a52d-757a-7898-0683-04b235c3aba7/e83d36ab-0bbb-4b3a-9060-7e565f224b65.png/600x600bb.jpg');
-- artist 668 이온 마린 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/119f0f443e5072b69be17d0662ea3f20481b5cc5'
WHERE id = 668 AND english_name = 'Ion Marin' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/6grbrl3Fnn9y9UdoK6Dfdb', 'https://i.scdn.co/image/119f0f443e5072b69be17d0662ea3f20481b5cc5', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 668 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/119f0f443e5072b69be17d0662ea3f20481b5cc5'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/119f0f443e5072b69be17d0662ea3f20481b5cc5');
-- artist 687 실비아 맥네어 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/60b9354e6df871bd1a87eb86cbc660a48e15172b'
WHERE id = 687 AND english_name = 'Sylvia McNair' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/63aSj4hbN7Q4nw74Y0xNF6', 'https://i.scdn.co/image/60b9354e6df871bd1a87eb86cbc660a48e15172b', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 687 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/60b9354e6df871bd1a87eb86cbc660a48e15172b'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/60b9354e6df871bd1a87eb86cbc660a48e15172b');
-- artist 698 쾰른 아카데미 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/887a7225d6165c23d4f00fbd47f474618b13a102'
WHERE id = 698 AND english_name = 'Kölner Akademie' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/1EzsQ4hVU2PIIIYow0QuRF', 'https://i.scdn.co/image/887a7225d6165c23d4f00fbd47f474618b13a102', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 698 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/887a7225d6165c23d4f00fbd47f474618b13a102'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/887a7225d6165c23d4f00fbd47f474618b13a102');
-- artist 702 콜레기움 아우레움 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/ebb469f980fa4b267c11bb04fbb9e9ae9cb14e0f'
WHERE id = 702 AND english_name = 'Collegium Aureum' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/3zIDEmXI9EVBCKFo4M99Re', 'https://i.scdn.co/image/ebb469f980fa4b267c11bb04fbb9e9ae9cb14e0f', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 702 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/ebb469f980fa4b267c11bb04fbb9e9ae9cb14e0f'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ebb469f980fa4b267c11bb04fbb9e9ae9cb14e0f');
-- artist 703 하노버 밴드 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/42360dc4d9fd2870e5d06e01f77747a4887b7dd8'
WHERE id = 703 AND english_name = 'Hanover Band' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/1ELhyIXfx2DUcYtZlmzwJ4', 'https://i.scdn.co/image/42360dc4d9fd2870e5d06e01f77747a4887b7dd8', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 703 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/42360dc4d9fd2870e5d06e01f77747a4887b7dd8'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/42360dc4d9fd2870e5d06e01f77747a4887b7dd8');
-- artist 711 외르크 페르버 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/050be8df02fdab63c646f4226ebd5ce5a8e9b544'
WHERE id = 711 AND english_name = 'Jörg Faerber' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/6VemLCzrmF3n1lxY3cbfKf', 'https://i.scdn.co/image/050be8df02fdab63c646f4226ebd5ce5a8e9b544', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 711 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/050be8df02fdab63c646f4226ebd5ce5a8e9b544'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/050be8df02fdab63c646f4226ebd5ce5a8e9b544');
-- artist 712 케빈 맬런 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/c82bd640538c42b17118e62ef896734065ff83dc'
WHERE id = 712 AND english_name = 'Kevin Mallon' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/6PwinjxhkFHQ9GqZjdBm3s', 'https://i.scdn.co/image/c82bd640538c42b17118e62ef896734065ff83dc', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 712 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/c82bd640538c42b17118e62ef896734065ff83dc'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/c82bd640538c42b17118e62ef896734065ff83dc');
-- artist 714 뷔르템베르크 실내관현악단 하일브론 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/ab6761610000e5eba8aafaadd5c0f22fd4109113'
WHERE id = 714 AND english_name = 'Württembergisches Kammerorchester Heilbronn' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/7AUztDRea3gAzwq6FKVfV4', 'https://i.scdn.co/image/ab6761610000e5eba8aafaadd5c0f22fd4109113', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 714 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/ab6761610000e5eba8aafaadd5c0f22fd4109113'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761610000e5eba8aafaadd5c0f22fd4109113');
-- artist 728 아이오나 브라운 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/b7ff9a1af84c6093798b4c7bb8227e6a2d06e5e0'
WHERE id = 728 AND english_name = 'Iona Brown' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/4EQ6Hw3KV9S80ZG1swsFN5', 'https://i.scdn.co/image/b7ff9a1af84c6093798b4c7bb8227e6a2d06e5e0', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 728 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/b7ff9a1af84c6093798b4c7bb8227e6a2d06e5e0'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/b7ff9a1af84c6093798b4c7bb8227e6a2d06e5e0');
-- artist 743 라트비아 방송합창단 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/30/b0/20/30b020fc-57bd-c292-e39a-edba2f3666ae/c19830b2-ee4c-4abf-ac2e-d6529f3ae7e7.png/600x600bb.jpg'
WHERE id = 743 AND english_name = 'Latvian Radio Choir' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/64975101', 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/30/b0/20/30b020fc-57bd-c292-e39a-edba2f3666ae/c19830b2-ee4c-4abf-ac2e-d6529f3ae7e7.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 743 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/30/b0/20/30b020fc-57bd-c292-e39a-edba2f3666ae/c19830b2-ee4c-4abf-ac2e-d6529f3ae7e7.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/30/b0/20/30b020fc-57bd-c292-e39a-edba2f3666ae/c19830b2-ee4c-4abf-ac2e-d6529f3ae7e7.png/600x600bb.jpg');
-- artist 756 파스칼 드부아용 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/b70089706dfaaac85f4421931fff2973fa2a3be3'
WHERE id = 756 AND english_name = 'Pascal Devoyon' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/62LQUUl6THxN3wFMqmSx08', 'https://i.scdn.co/image/b70089706dfaaac85f4421931fff2973fa2a3be3', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 756 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/b70089706dfaaac85f4421931fff2973fa2a3be3'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/b70089706dfaaac85f4421931fff2973fa2a3be3');
-- artist 776 오우에 에이지 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/a7/7d/c6/a77dc6c5-97c2-c6fa-18ba-6e71872ec22e/76c3f861-0ad6-4749-ac7e-88e59c1cddc9.png/600x600bb.jpg'
WHERE id = 776 AND english_name = 'Eiji Oue' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/160012748', 'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/a7/7d/c6/a77dc6c5-97c2-c6fa-18ba-6e71872ec22e/76c3f861-0ad6-4749-ac7e-88e59c1cddc9.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 776 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/a7/7d/c6/a77dc6c5-97c2-c6fa-18ba-6e71872ec22e/76c3f861-0ad6-4749-ac7e-88e59c1cddc9.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/a7/7d/c6/a77dc6c5-97c2-c6fa-18ba-6e71872ec22e/76c3f861-0ad6-4749-ac7e-88e59c1cddc9.png/600x600bb.jpg');
-- artist 790 샌프란시스코 심포니 합창단 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/72/76/7b/72767b81-4b48-0f59-eaea-d0e1cd2c5bc2/33587484-3f6e-4c52-a464-4a555da96a93.png/600x600bb.jpg'
WHERE id = 790 AND english_name = 'San Francisco Symphony Chorus' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/4360634', 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/72/76/7b/72767b81-4b48-0f59-eaea-d0e1cd2c5bc2/33587484-3f6e-4c52-a464-4a555da96a93.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 790 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/72/76/7b/72767b81-4b48-0f59-eaea-d0e1cd2c5bc2/33587484-3f6e-4c52-a464-4a555da96a93.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/72/76/7b/72767b81-4b48-0f59-eaea-d0e1cd2c5bc2/33587484-3f6e-4c52-a464-4a555da96a93.png/600x600bb.jpg');
-- artist 794 바이에른 방송합창단 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/ab6761610000e5eb3a8c0542ea006c5d72ed33c6'
WHERE id = 794 AND english_name = 'Bavarian Radio Chorus' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/536pGG9V0mbcKOSgw37g4m', 'https://i.scdn.co/image/ab6761610000e5eb3a8c0542ea006c5d72ed33c6', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 794 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/ab6761610000e5eb3a8c0542ea006c5d72ed33c6'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761610000e5eb3a8c0542ea006c5d72ed33c6');
-- artist 800 한스 로스바우트 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f8/Donaueschingen-_Donaueschinger_Musiktage%3B_Sternensaal%3B_Karlheinz_Stockhausen_und_Hans_Rosbaud_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._054220_%28cropped%29.jpeg'
WHERE id = 800 AND english_name = 'Hans Rosbaud' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Donaueschingen-_Donaueschinger_Musiktage;_Sternensaal;_Karlheinz_Stockhausen_und_Hans_Rosbaud_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._054220_(cropped).jpeg', 'https://upload.wikimedia.org/wikipedia/commons/f/f8/Donaueschingen-_Donaueschinger_Musiktage%3B_Sternensaal%3B_Karlheinz_Stockhausen_und_Hans_Rosbaud_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._054220_%28cropped%29.jpeg', 'Willy Pragher', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 800 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f8/Donaueschingen-_Donaueschinger_Musiktage%3B_Sternensaal%3B_Karlheinz_Stockhausen_und_Hans_Rosbaud_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._054220_%28cropped%29.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f8/Donaueschingen-_Donaueschinger_Musiktage%3B_Sternensaal%3B_Karlheinz_Stockhausen_und_Hans_Rosbaud_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._054220_%28cropped%29.jpeg');
-- artist 802 줄리아드 현악 4중주단 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/df/Juilliard_String_Quartet.jpg'
WHERE id = 802 AND english_name = 'Juilliard String Quartet' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Juilliard_String_Quartet.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/df/Juilliard_String_Quartet.jpg', 'Shan Su', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 802 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/df/Juilliard_String_Quartet.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/df/Juilliard_String_Quartet.jpg');
-- artist 829 콘세르트헤바우 실내관현악단 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/c2/a5/f0/c2a5f0b5-a25d-de73-340c-e4ed8c5e555d/pr_source.png/600x600bb.jpg'
WHERE id = 829 AND english_name = 'Concertgebouw Chamber Orchestra' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/31314743', 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/c2/a5/f0/c2a5f0b5-a25d-de73-340c-e4ed8c5e555d/pr_source.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 829 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/c2/a5/f0/c2a5f0b5-a25d-de73-340c-e4ed8c5e555d/pr_source.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/c2/a5/f0/c2a5f0b5-a25d-de73-340c-e4ed8c5e555d/pr_source.png/600x600bb.jpg');
-- artist 834 빈 악우협회 합창단 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/e403106a45cbd0e2ca51e4d1b18b9a587f9177be'
WHERE id = 834 AND english_name = 'Wiener Singverein' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/35QSympF887CO8h5eZHme2', 'https://i.scdn.co/image/e403106a45cbd0e2ca51e4d1b18b9a587f9177be', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 834 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/e403106a45cbd0e2ca51e4d1b18b9a587f9177be'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/e403106a45cbd0e2ca51e4d1b18b9a587f9177be');
-- artist 835 잉글리시 바로크 솔로이스츠 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e2/English_Barroque_Soloist_37_%2814839397691%29.jpg'
WHERE id = 835 AND english_name = 'English Baroque Soloists' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:English_Barroque_Soloist_37_(14839397691).jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/e2/English_Barroque_Soloist_37_%2814839397691%29.jpg', 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 835 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e2/English_Barroque_Soloist_37_%2814839397691%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e2/English_Barroque_Soloist_37_%2814839397691%29.jpg');
-- artist 836 퇼츠 소년합창단 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/08/T%C3%B6lzer_Knabenchor_Konzertchor_Lederhosen.jpg'
WHERE id = 836 AND english_name = 'Tölzer Knabenchor' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:T%C3%B6lzer_Knabenchor_Konzertchor_Lederhosen.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/08/T%C3%B6lzer_Knabenchor_Konzertchor_Lederhosen.jpg', 'Michael Schilhansl / Tölzer Knabenchor', 'CC BY-SA 3.0', 'http://creativecommons.org/licenses/by-sa/3.0/', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 836 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/08/T%C3%B6lzer_Knabenchor_Konzertchor_Lederhosen.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/0/08/T%C3%B6lzer_Knabenchor_Konzertchor_Lederhosen.jpg');
-- artist 837 필리프 헤레베허 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/38/Herreweghe675.jpg'
WHERE id = 837 AND english_name = 'Philippe Herreweghe' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Herreweghe675.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/38/Herreweghe675.jpg', 'Michiel Hendryckx', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 837 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/38/Herreweghe675.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/38/Herreweghe675.jpg');
-- artist 838 콜레기움 보칼레 겐트 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Collegium_vocale675.jpg'
WHERE id = 838 AND english_name = 'Collegium Vocale Gent' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Collegium_vocale675.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Collegium_vocale675.jpg', 'Michiel Hendryckx', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 838 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Collegium_vocale675.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Collegium_vocale675.jpg');
-- artist 839 카를 리히터 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Karl_Richter%2C_1959_-_collezione_Tino_Barindelli.tif/lossy-page1-960px-Karl_Richter%2C_1959_-_collezione_Tino_Barindelli.tif.jpg'
WHERE id = 839 AND english_name = 'Karl Richter' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Karl_Richter,_1959_-_collezione_Tino_Barindelli.tif', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Karl_Richter%2C_1959_-_collezione_Tino_Barindelli.tif/lossy-page1-960px-Karl_Richter%2C_1959_-_collezione_Tino_Barindelli.tif.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 839 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Karl_Richter%2C_1959_-_collezione_Tino_Barindelli.tif/lossy-page1-960px-Karl_Richter%2C_1959_-_collezione_Tino_Barindelli.tif.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Karl_Richter%2C_1959_-_collezione_Tino_Barindelli.tif/lossy-page1-960px-Karl_Richter%2C_1959_-_collezione_Tino_Barindelli.tif.jpg');
-- artist 841 로저 노링턴 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/d3d17e60cd49541f153727b466dcc83f5cfe67c6'
WHERE id = 841 AND english_name = 'Roger Norrington' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/2nXNvTKpp7LSEXNUMFOd1t', 'https://i.scdn.co/image/d3d17e60cd49541f153727b466dcc83f5cfe67c6', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 841 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/d3d17e60cd49541f153727b466dcc83f5cfe67c6'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/d3d17e60cd49541f153727b466dcc83f5cfe67c6');
-- artist 842 카메라타 잘츠부르크 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/68/Camerata_am_Marko-Feingold-Steg.jpg'
WHERE id = 842 AND english_name = 'Camerata Salzburg' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Camerata_am_Marko-Feingold-Steg.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/68/Camerata_am_Marko-Feingold-Steg.jpg', 'Camerata Salzburg', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 842 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/68/Camerata_am_Marko-Feingold-Steg.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/68/Camerata_am_Marko-Feingold-Steg.jpg');
-- artist 843 하노 뮐러브라흐만 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/24/fa/7a/24fa7a81-0ca7-9f49-7ce7-cbd33054b28b/fb594cb1-fff7-40b5-a2f4-69333d11d628.png/600x600bb.jpg'
WHERE id = 843 AND english_name = 'Hanno Müller-Brachmann' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/29799132', 'https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/24/fa/7a/24fa7a81-0ca7-9f49-7ce7-cbd33054b28b/fb594cb1-fff7-40b5-a2f4-69333d11d628.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 843 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/24/fa/7a/24fa7a81-0ca7-9f49-7ce7-cbd33054b28b/fb594cb1-fff7-40b5-a2f4-69333d11d628.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/24/fa/7a/24fa7a81-0ca7-9f49-7ce7-cbd33054b28b/fb594cb1-fff7-40b5-a2f4-69333d11d628.png/600x600bb.jpg');
-- artist 844 구스타프 레온하르트 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/af/Gustav_Leonhardt%2C_2008_%28cropped%29.jpg'
WHERE id = 844 AND english_name = 'Gustav Leonhardt' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Gustav_Leonhardt,_2008_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/af/Gustav_Leonhardt%2C_2008_%28cropped%29.jpg', 'Paul Ruet', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 844 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/af/Gustav_Leonhardt%2C_2008_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/af/Gustav_Leonhardt%2C_2008_%28cropped%29.jpg');
-- artist 846 콘라트 융해넬 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/9f35a03cd7477b15d7300fe258c67e96f49ced11'
WHERE id = 846 AND english_name = 'Konrad Junghänel' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/7zhA38UalSM1TkXWJxhqF5', 'https://i.scdn.co/image/9f35a03cd7477b15d7300fe258c67e96f49ced11', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 846 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/9f35a03cd7477b15d7300fe258c67e96f49ced11'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/9f35a03cd7477b15d7300fe258c67e96f49ced11');
-- artist 848 예테보리 심포니 오케스트라 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/ab6761610000e5eb5e0b47b63aa6ce21344c6cc4'
WHERE id = 848 AND english_name = 'Gothenburg Symphony Orchestra' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/1XaPI6thQ3zTKqIU6sCvd2', 'https://i.scdn.co/image/ab6761610000e5eb5e0b47b63aa6ce21344c6cc4', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 848 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/ab6761610000e5eb5e0b47b63aa6ce21344c6cc4'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761610000e5eb5e0b47b63aa6ce21344c6cc4');
-- artist 849 에사페카 살로넨 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/8e/7e/04/8e7e04ed-a360-4fd3-be57-297f30f530fa/mzl.oxxasrem.jpg/600x600bb.jpg'
WHERE id = 849 AND english_name = 'Esa-Pekka Salonen' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/5192302', 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/8e/7e/04/8e7e04ed-a360-4fd3-be57-297f30f530fa/mzl.oxxasrem.jpg/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 849 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/8e/7e/04/8e7e04ed-a360-4fd3-be57-297f30f530fa/mzl.oxxasrem.jpg/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/8e/7e/04/8e7e04ed-a360-4fd3-be57-297f30f530fa/mzl.oxxasrem.jpg/600x600bb.jpg');
-- artist 850 카밀라 틸링 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/ab6772690000c46cc006e5439253c797b161b234'
WHERE id = 850 AND english_name = 'Camilla Tilling' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/125PYk9VJbA5d7CQ0DjLtK', 'https://i.scdn.co/image/ab6772690000c46cc006e5439253c797b161b234', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 850 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/ab6772690000c46cc006e5439253c797b161b234'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6772690000c46cc006e5439253c797b161b234');
-- artist 851 에스토니아 국립 교향악단 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/35/Estonian_National_Symphony_Orchestra_%28ERSO%29_in_Stockholm%2C_2008.jpg'
WHERE id = 851 AND english_name = 'Estonian National Symphony Orchestra' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Estonian_National_Symphony_Orchestra_(ERSO)_in_Stockholm,_2008.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/35/Estonian_National_Symphony_Orchestra_%28ERSO%29_in_Stockholm%2C_2008.jpg', 'Estonian Foreign Ministry', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 851 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/35/Estonian_National_Symphony_Orchestra_%28ERSO%29_in_Stockholm%2C_2008.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/35/Estonian_National_Symphony_Orchestra_%28ERSO%29_in_Stockholm%2C_2008.jpg');
-- artist 852 로테르담 필하모닉 오케스트라 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d8/R%C3%B3tterdam14_%2815007002076%29.jpg'
WHERE id = 852 AND english_name = 'Rotterdam Philharmonic Orchestra' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:R%C3%B3tterdam14_(15007002076).jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d8/R%C3%B3tterdam14_%2815007002076%29.jpg', 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 852 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d8/R%C3%B3tterdam14_%2815007002076%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d8/R%C3%B3tterdam14_%2815007002076%29.jpg');
-- artist 853 토머스 앨런 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/ab6772690000c46c2539ed7c67f0404707b44ed4'
WHERE id = 853 AND english_name = 'Thomas Allen' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/2SFBZgfO2H1nVSgjxzJLUy', 'https://i.scdn.co/image/ab6772690000c46c2539ed7c67f0404707b44ed4', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 853 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/ab6772690000c46c2539ed7c67f0404707b44ed4'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6772690000c46c2539ed7c67f0404707b44ed4');
-- artist 855 새뮤얼 레이미 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/34/Samuel_Ramey_como_Argante.jpg'
WHERE id = 855 AND english_name = 'Samuel Ramey' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Samuel_Ramey_como_Argante.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/34/Samuel_Ramey_como_Argante.jpg', 'Olivia Lazalde Valdez', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 855 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/34/Samuel_Ramey_como_Argante.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/34/Samuel_Ramey_como_Argante.jpg');
-- artist 856 파아타 부르출라제 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/17/Paata_Burchuladze_2022.jpg'
WHERE id = 856 AND english_name = 'Paata Burchuladze' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Paata_Burchuladze_2022.jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/17/Paata_Burchuladze_2022.jpg', 'რადიო არ დაიდარდო / Radio Ar Daidardo', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 856 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/17/Paata_Burchuladze_2022.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/17/Paata_Burchuladze_2022.jpg');
-- artist 857 마티 살미넨 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/64/Matti_salminen.jpg'
WHERE id = 857 AND english_name = 'Matti Salminen' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Matti_salminen.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/64/Matti_salminen.jpg', 'Motopark', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 857 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/64/Matti_salminen.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/64/Matti_salminen.jpg');
-- artist 858 베를린 슈타츠카펠레 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/92/Musikverein_Wien_2009_04_30.JPG'
WHERE id = 858 AND english_name = 'Berlin Staatskapelle' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Musikverein_Wien_2009_04_30.JPG', 'https://upload.wikimedia.org/wikipedia/commons/9/92/Musikverein_Wien_2009_04_30.JPG', 'Li Sun', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 858 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/92/Musikverein_Wien_2009_04_30.JPG'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/92/Musikverein_Wien_2009_04_30.JPG');
-- artist 859 프란츠 콘비츠니 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Bundesarchiv_Bild_183-12295-0002%2C_Franz_Konwitschny.jpg'
WHERE id = 859 AND english_name = 'Franz Konwitschny' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Bundesarchiv_Bild_183-12295-0002,_Franz_Konwitschny.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Bundesarchiv_Bild_183-12295-0002%2C_Franz_Konwitschny.jpg', 'Hans-Günter Quaschinsky', 'CC BY-SA 3.0 de', 'https://creativecommons.org/licenses/by-sa/3.0/de/deed.en', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 859 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Bundesarchiv_Bild_183-12295-0002%2C_Franz_Konwitschny.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Bundesarchiv_Bild_183-12295-0002%2C_Franz_Konwitschny.jpg');
-- artist 860 크리스타 루트비히 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1f/KS_Christa_Ludwig%2C_geboren_am_16._M%C3%A4rz_1928_in_Berlin%2C_deutsche_Opern-_und_Konzerts%C3%A4ngerin_%28Mezzosopran%29_wurde_zur_Ehrenpr%C3%A4sidentin_der_Hilde_Zadek_Stiftung_ernannt._%2817122239712%29_%28cropped%29.jpg'
WHERE id = 860 AND english_name = 'Christa Ludwig' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:KS_Christa_Ludwig,_geboren_am_16._M%C3%A4rz_1928_in_Berlin,_deutsche_Opern-_und_Konzerts%C3%A4ngerin_(Mezzosopran)_wurde_zur_Ehrenpr%C3%A4sidentin_der_Hilde_Zadek_Stiftung_ernannt._(17122239712)_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/1f/KS_Christa_Ludwig%2C_geboren_am_16._M%C3%A4rz_1928_in_Berlin%2C_deutsche_Opern-_und_Konzerts%C3%A4ngerin_%28Mezzosopran%29_wurde_zur_Ehrenpr%C3%A4sidentin_der_Hilde_Zadek_Stiftung_ernannt._%2817122239712%29_%28cropped%29.jpg', 'Franz Johann Morgenbesser from Vienna, Austria', 'CC BY-SA 2.0', 'https://creativecommons.org/licenses/by-sa/2.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 860 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1f/KS_Christa_Ludwig%2C_geboren_am_16._M%C3%A4rz_1928_in_Berlin%2C_deutsche_Opern-_und_Konzerts%C3%A4ngerin_%28Mezzosopran%29_wurde_zur_Ehrenpr%C3%A4sidentin_der_Hilde_Zadek_Stiftung_ernannt._%2817122239712%29_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1f/KS_Christa_Ludwig%2C_geboren_am_16._M%C3%A4rz_1928_in_Berlin%2C_deutsche_Opern-_und_Konzerts%C3%A4ngerin_%28Mezzosopran%29_wurde_zur_Ehrenpr%C3%A4sidentin_der_Hilde_Zadek_Stiftung_ernannt._%2817122239712%29_%28cropped%29.jpg');
-- artist 861 안네 소피 폰 오터 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/ae/Anne_Sofie_von_Otter_2011-10-13_002.jpg'
WHERE id = 861 AND english_name = 'Anne Sofie von Otter' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Anne_Sofie_von_Otter_2011-10-13_002.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/ae/Anne_Sofie_von_Otter_2011-10-13_002.jpg', 'Ewa-Marie Rundquist', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 861 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/ae/Anne_Sofie_von_Otter_2011-10-13_002.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/ae/Anne_Sofie_von_Otter_2011-10-13_002.jpg');
-- artist 862 레오폴드 스토코프스키 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/db/Leopold_Stokowski_LOC_26447u.jpg'
WHERE id = 862 AND english_name = 'Leopold Stokowski' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Leopold_Stokowski_LOC_26447u.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/db/Leopold_Stokowski_LOC_26447u.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 862 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/db/Leopold_Stokowski_LOC_26447u.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/db/Leopold_Stokowski_LOC_26447u.jpg');
-- artist 863 체칠리아 바르톨리 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Cecilia_Bartoli_at_BOZAR_2007_Cropped.jpg'
WHERE id = 863 AND english_name = 'Cecilia Bartoli' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Cecilia_Bartoli_at_BOZAR_2007_Cropped.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Cecilia_Bartoli_at_BOZAR_2007_Cropped.jpg', 'Erinc Salor', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 863 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Cecilia_Bartoli_at_BOZAR_2007_Cropped.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Cecilia_Bartoli_at_BOZAR_2007_Cropped.jpg');
-- artist 864 주세페 파타네 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/1c66a206efb6cb443929887f633d8dd4333d6cb8'
WHERE id = 864 AND english_name = 'Giuseppe Patanè' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/5ZJ9PMKBpN56YhrhFzAR5o', 'https://i.scdn.co/image/1c66a206efb6cb443929887f633d8dd4333d6cb8', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 864 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/1c66a206efb6cb443929887f633d8dd4333d6cb8'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/1c66a206efb6cb443929887f633d8dd4333d6cb8');
-- artist 865 아그네스 발차 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/88/Agnes_Baltsa_1988_Prinzregententheater-19880109-RM-200830.jpg'
WHERE id = 865 AND english_name = 'Agnes Baltsa' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Agnes_Baltsa_1988_Prinzregententheater-19880109-RM-200830.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/88/Agnes_Baltsa_1988_Prinzregententheater-19880109-RM-200830.jpg', 'Ermell', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 865 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/88/Agnes_Baltsa_1988_Prinzregententheater-19880109-RM-200830.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/88/Agnes_Baltsa_1988_Prinzregententheater-19880109-RM-200830.jpg');
-- artist 867 앙상블 코레스퐁당스 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/58/Ensemble_Correspondances_%C2%A9Victoire_Andrieux.jpg'
WHERE id = 867 AND english_name = 'Ensemble Correspondances' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Ensemble_Correspondances_%C2%A9Victoire_Andrieux.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/58/Ensemble_Correspondances_%C2%A9Victoire_Andrieux.jpg', 'CoViAn', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 867 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/58/Ensemble_Correspondances_%C2%A9Victoire_Andrieux.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/58/Ensemble_Correspondances_%C2%A9Victoire_Andrieux.jpg');
-- artist 868 모린 포레스터 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/53d6a621147833e99542f2bf9878f5ee333e570f'
WHERE id = 868 AND english_name = 'Maureen Forrester' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/6qSsYTbt6l80JYki1i4SlA', 'https://i.scdn.co/image/53d6a621147833e99542f2bf9878f5ee333e570f', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 868 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/53d6a621147833e99542f2bf9878f5ee333e570f'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/53d6a621147833e99542f2bf9878f5ee333e570f');
-- artist 870 야로슬라프 크르체크 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Jaroslav_Kr%C4%8Dek_%282016%29.jpg'
WHERE id = 870 AND english_name = 'Jaroslav Krček' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jaroslav_Kr%C4%8Dek_(2016).jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Jaroslav_Kr%C4%8Dek_%282016%29.jpg', 'Jindřich Nosek (NoJin)', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 870 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Jaroslav_Kr%C4%8Dek_%282016%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Jaroslav_Kr%C4%8Dek_%282016%29.jpg');
-- artist 871 카를로 마리아 줄리니 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2b/Carlo_Maria_Giulini_1965.jpg'
WHERE id = 871 AND english_name = 'Carlo Maria Giulini' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Carlo_Maria_Giulini_1965.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/2b/Carlo_Maria_Giulini_1965.jpg', 'Ron Kroon for Anefo', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 871 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2b/Carlo_Maria_Giulini_1965.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2b/Carlo_Maria_Giulini_1965.jpg');
-- artist 872 유스투스 프란츠 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Justus_Frantz_%282015%29.jpg'
WHERE id = 872 AND english_name = 'Justus Frantz' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Justus_Frantz_(2015).jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Justus_Frantz_%282015%29.jpg', 'Original: WDKrause Derivative work: Laddo', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 872 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Justus_Frantz_%282015%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Justus_Frantz_%282015%29.jpg');
-- artist 875 쿠어팔츠 실내관현악단 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Kurpf%C3%A4lzisches_Kammerorchester.jpg'
WHERE id = 875 AND english_name = 'Kurpfälzisches Kammerorchester' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Kurpf%C3%A4lzisches_Kammerorchester.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Kurpf%C3%A4lzisches_Kammerorchester.jpg', 'Graf Foto', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 875 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Kurpf%C3%A4lzisches_Kammerorchester.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Kurpf%C3%A4lzisches_Kammerorchester.jpg');
-- artist 877 클라우스 투네만 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/89080c264803abef754f797e27dd8ce71afab13c'
WHERE id = 877 AND english_name = 'Klaus Thunemann' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/0HLqp813o9kv2t8JtVLH4a', 'https://i.scdn.co/image/89080c264803abef754f797e27dd8ce71afab13c', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 877 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/89080c264803abef754f797e27dd8ce71afab13c'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/89080c264803abef754f797e27dd8ce71afab13c');
-- artist 878 이 무지치 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/2b/e7/55/2be7554c-51e0-b263-2cbb-cb7257d4c52f/mza_8531189918168587618.png/600x600bb.jpg'
WHERE id = 878 AND english_name = 'I Musici' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/4564760', 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/2b/e7/55/2be7554c-51e0-b263-2cbb-cb7257d4c52f/mza_8531189918168587618.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 878 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/2b/e7/55/2be7554c-51e0-b263-2cbb-cb7257d4c52f/mza_8531189918168587618.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/2b/e7/55/2be7554c-51e0-b263-2cbb-cb7257d4c52f/mza_8531189918168587618.png/600x600bb.jpg');
-- artist 882 슈투트가르트 방송 교향악단 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/88/Sir_Roger_and_RSO_Stuttgart.jpg'
WHERE id = 882 AND english_name = 'Stuttgart Radio Symphony Orchestra' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Sir_Roger_and_RSO_Stuttgart.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/88/Sir_Roger_and_RSO_Stuttgart.jpg', 'masaka', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 882 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/88/Sir_Roger_and_RSO_Stuttgart.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/88/Sir_Roger_and_RSO_Stuttgart.jpg');
-- artist 883 조너선 코언 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features124/v4/14/d9/6a/14d96a08-d950-5eaa-f309-6c7593aa29da/mzl.cuetidze.png/600x600bb.jpg'
WHERE id = 883 AND english_name = 'Jonathan Cohen' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/203512903', 'https://is1-ssl.mzstatic.com/image/thumb/Features124/v4/14/d9/6a/14d96a08-d950-5eaa-f309-6c7593aa29da/mzl.cuetidze.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 883 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features124/v4/14/d9/6a/14d96a08-d950-5eaa-f309-6c7593aa29da/mzl.cuetidze.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features124/v4/14/d9/6a/14d96a08-d950-5eaa-f309-6c7593aa29da/mzl.cuetidze.png/600x600bb.jpg');
-- artist 886 니컬러스 맥기건 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/df/ef/a3/dfefa358-8f17-1fd5-570b-c4986bcd6a19/mzl.lxyiejaj.jpg/600x600bb.jpg'
WHERE id = 886 AND english_name = 'Nicholas McGegan' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/13703228', 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/df/ef/a3/dfefa358-8f17-1fd5-570b-c4986bcd6a19/mzl.lxyiejaj.jpg/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 886 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/df/ef/a3/dfefa358-8f17-1fd5-570b-c4986bcd6a19/mzl.lxyiejaj.jpg/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/df/ef/a3/dfefa358-8f17-1fd5-570b-c4986bcd6a19/mzl.lxyiejaj.jpg/600x600bb.jpg');
-- artist 888 제라르 레스네 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/21295bf12e5497c69c95a16c7732ea1acc0433d2'
WHERE id = 888 AND english_name = 'Gérard Lesne' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/2PEeqeHxCh3wPb1qU04n98', 'https://i.scdn.co/image/21295bf12e5497c69c95a16c7732ea1acc0433d2', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 888 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/21295bf12e5497c69c95a16c7732ea1acc0433d2'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/21295bf12e5497c69c95a16c7732ea1acc0433d2');
-- artist 890 조너선 노트 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e8/Orquesta_Sinf%C3%B3nica_de_Bamberg_011.jpg'
WHERE id = 890 AND english_name = 'Jonathan Nott' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Orquesta_Sinf%C3%B3nica_de_Bamberg_011.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/e8/Orquesta_Sinf%C3%B3nica_de_Bamberg_011.jpg', 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 890 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e8/Orquesta_Sinf%C3%B3nica_de_Bamberg_011.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e8/Orquesta_Sinf%C3%B3nica_de_Bamberg_011.jpg');
-- artist 891 런던 보이시스 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/46/London_Voices_full_clr.jpg'
WHERE id = 891 AND english_name = 'London Voices' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:London_Voices_full_clr.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/46/London_Voices_full_clr.jpg', 'Benparry65', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 891 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/46/London_Voices_full_clr.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/46/London_Voices_full_clr.jpg');
-- artist 893 오타비오 단토네 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/be/Ottavio_Dantone3.jpg'
WHERE id = 893 AND english_name = 'Ottavio Dantone' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Ottavio_Dantone3.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/be/Ottavio_Dantone3.jpg', 'Mrug', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 893 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/be/Ottavio_Dantone3.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/be/Ottavio_Dantone3.jpg');
-- artist 894 아카데미아 비잔티나 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/f8/a9/82/f8a9821d-474c-c675-9644-0199e36998e3/pr_source.png/600x600bb.jpg'
WHERE id = 894 AND english_name = 'Accademia Bizantina' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/5313779', 'https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/f8/a9/82/f8a9821d-474c-c675-9644-0199e36998e3/pr_source.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 894 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/f8/a9/82/f8a9821d-474c-c675-9644-0199e36998e3/pr_source.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/f8/a9/82/f8a9821d-474c-c675-9644-0199e36998e3/pr_source.png/600x600bb.jpg');
-- artist 895 페테르 외트뵈시 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/89/P%C3%A9ter_E%C3%B6tv%C3%B6s_by_Istvan_Huszti.jpg'
WHERE id = 895 AND english_name = 'Péter Eötvös' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:P%C3%A9ter_E%C3%B6tv%C3%B6s_by_Istvan_Huszti.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/89/P%C3%A9ter_E%C3%B6tv%C3%B6s_by_Istvan_Huszti.jpg', 'The original uploader was Riceklang at English Wikipedia.', 'Attribution', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 895 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/89/P%C3%A9ter_E%C3%B6tv%C3%B6s_by_Istvan_Huszti.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/89/P%C3%A9ter_E%C3%B6tv%C3%B6s_by_Istvan_Huszti.jpg');
-- artist 897 시모네 케르메스 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d8/Soprano_Simone_Kermes.jpg'
WHERE id = 897 AND english_name = 'Simone Kermes' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Soprano_Simone_Kermes.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d8/Soprano_Simone_Kermes.jpg', 'Alexander Böhm', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 897 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d8/Soprano_Simone_Kermes.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d8/Soprano_Simone_Kermes.jpg');
-- artist 898 앨런 커티스 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/57/Portrait_Alan_Curtis%2C_Florence_2006_%28cropped%29.jpg'
WHERE id = 898 AND english_name = 'Alan Curtis' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Portrait_Alan_Curtis,_Florence_2006_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/57/Portrait_Alan_Curtis%2C_Florence_2006_%28cropped%29.jpg', 'Frédéric Almaviva', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 898 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/57/Portrait_Alan_Curtis%2C_Florence_2006_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/57/Portrait_Alan_Curtis%2C_Florence_2006_%28cropped%29.jpg');
-- artist 899 일 콤플레소 바로코 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/efa29eab5b407c67319eda009e3d946fc94c8ae6'
WHERE id = 899 AND english_name = 'Il Complesso Barocco' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/0tEcOib2nBnCi6OM5jgC87', 'https://i.scdn.co/image/efa29eab5b407c67319eda009e3d946fc94c8ae6', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 899 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/efa29eab5b407c67319eda009e3d946fc94c8ae6'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/efa29eab5b407c67319eda009e3d946fc94c8ae6');
-- artist 900 루시 크로 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features71/v4/f0/27/57/f027577a-31b0-f257-91d0-d983fbfe0246/mzl.utvalsap.jpg/600x600bb.jpg'
WHERE id = 900 AND english_name = 'Lucy Crowe' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/252128127', 'https://is1-ssl.mzstatic.com/image/thumb/Features71/v4/f0/27/57/f027577a-31b0-f257-91d0-d983fbfe0246/mzl.utvalsap.jpg/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 900 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features71/v4/f0/27/57/f027577a-31b0-f257-91d0-d983fbfe0246/mzl.utvalsap.jpg/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features71/v4/f0/27/57/f027577a-31b0-f257-91d0-d983fbfe0246/mzl.utvalsap.jpg/600x600bb.jpg');
-- artist 901 해리 비켓 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features124/v4/ce/33/11/ce331167-f32f-d4e3-bd1f-de2093ac0749/mzl.uphbjiwf.png/600x600bb.jpg'
WHERE id = 901 AND english_name = 'Harry Bicket' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/1103612', 'https://is1-ssl.mzstatic.com/image/thumb/Features124/v4/ce/33/11/ce331167-f32f-d4e3-bd1f-de2093ac0749/mzl.uphbjiwf.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 901 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features124/v4/ce/33/11/ce331167-f32f-d4e3-bd1f-de2093ac0749/mzl.uphbjiwf.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features124/v4/ce/33/11/ce331167-f32f-d4e3-bd1f-de2093ac0749/mzl.uphbjiwf.png/600x600bb.jpg');
-- artist 902 잉글리시 콘서트 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages221/v4/c1/f9/ad/c1f9adbd-c067-97de-4de4-cde31e222a67/ami-identity-441da429b6805a2129d72dbb370d71f0-2026-03-28T23-43-48.518Z_cropped.png/600x600bb.jpg'
WHERE id = 902 AND english_name = 'The English Concert' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/4310952', 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages221/v4/c1/f9/ad/c1f9adbd-c067-97de-4de4-cde31e222a67/ami-identity-441da429b6805a2129d72dbb370d71f0-2026-03-28T23-43-48.518Z_cropped.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 902 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages221/v4/c1/f9/ad/c1f9adbd-c067-97de-4de4-cde31e222a67/ami-identity-441da429b6805a2129d72dbb370d71f0-2026-03-28T23-43-48.518Z_cropped.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages221/v4/c1/f9/ad/c1f9adbd-c067-97de-4de4-cde31e222a67/ami-identity-441da429b6805a2129d72dbb370d71f0-2026-03-28T23-43-48.518Z_cropped.png/600x600bb.jpg');
-- artist 903 다니엘 로이스 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/45/8b/7d/458b7dbf-482b-e9a3-d80a-782344a2f5b6/mzl.xywpdjgq.jpg/600x600bb.jpg'
WHERE id = 903 AND english_name = 'Daniël Reuss' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/27888958', 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/45/8b/7d/458b7dbf-482b-e9a3-d80a-782344a2f5b6/mzl.xywpdjgq.jpg/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 903 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/45/8b/7d/458b7dbf-482b-e9a3-d80a-782344a2f5b6/mzl.xywpdjgq.jpg/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/45/8b/7d/458b7dbf-482b-e9a3-d80a-782344a2f5b6/mzl.xywpdjgq.jpg/600x600bb.jpg');
-- artist 904 카펠라 암스테르담 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/42/Cappella_Amsterdam.jpg'
WHERE id = 904 AND english_name = 'Cappella Amsterdam' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Cappella_Amsterdam.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/42/Cappella_Amsterdam.jpg', 'Annelies van der Vegt (upload by Gosiaimp)', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 904 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/42/Cappella_Amsterdam.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/42/Cappella_Amsterdam.jpg');
-- artist 905 유발 바인베르크 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c3/Yuval_Weinberg.jpg'
WHERE id = 905 AND english_name = 'Yuval Weinberg' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Yuval_Weinberg.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/c3/Yuval_Weinberg.jpg', 'Katinka Hustad', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 905 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c3/Yuval_Weinberg.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c3/Yuval_Weinberg.jpg');
-- artist 906 이네사 갈란테 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/de/Inese_Galante_%28cropped%29.jpg'
WHERE id = 906 AND english_name = 'Inese Galante' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Inese_Galante_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/de/Inese_Galante_%28cropped%29.jpg', 'Herman Braun Foundation', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 906 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/de/Inese_Galante_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/de/Inese_Galante_%28cropped%29.jpg');
-- artist 908 패트릭 서머스 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/97fcd1244847b57d0e6804cb9eb24778e5ca9ec8'
WHERE id = 908 AND english_name = 'Patrick Summers' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/7qkyDQcGLxzaZPKOWDFmKk', 'https://i.scdn.co/image/97fcd1244847b57d0e6804cb9eb24778e5ca9ec8', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 908 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/97fcd1244847b57d0e6804cb9eb24778e5ca9ec8'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/97fcd1244847b57d0e6804cb9eb24778e5ca9ec8');
-- artist 909 문태국 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features124/v4/fb/f6/4a/fbf64a3e-0979-a23e-56ed-fd37988c10a4/mzl.kutkmjdk.jpg/600x600bb.jpg'
WHERE id = 909 AND english_name = 'Taeguk Mun' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/1358762564', 'https://is1-ssl.mzstatic.com/image/thumb/Features124/v4/fb/f6/4a/fbf64a3e-0979-a23e-56ed-fd37988c10a4/mzl.kutkmjdk.jpg/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 909 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features124/v4/fb/f6/4a/fbf64a3e-0979-a23e-56ed-fd37988c10a4/mzl.kutkmjdk.jpg/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features124/v4/fb/f6/4a/fbf64a3e-0979-a23e-56ed-fd37988c10a4/mzl.kutkmjdk.jpg/600x600bb.jpg');
