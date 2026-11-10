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
-- artist 375 Tugomir Franc (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/OAjlrX5xM7L1z6Fg8QTdjhLPzjDaZfTu5HmwGLSkqHs/rs:fit/g:sm/q:90/h:600/w:435/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTEzMzA0/MDctMTQ5MzQ0NzEy/NC0yMTY5LmpwZWc.jpeg'
WHERE id = 375 AND english_name = 'Tugomir Franc' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/1330407-Tugomir-Franc', 'https://i.discogs.com/OAjlrX5xM7L1z6Fg8QTdjhLPzjDaZfTu5HmwGLSkqHs/rs:fit/g:sm/q:90/h:600/w:435/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTEzMzA0/MDctMTQ5MzQ0NzEy/NC0yMTY5LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 375 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/OAjlrX5xM7L1z6Fg8QTdjhLPzjDaZfTu5HmwGLSkqHs/rs:fit/g:sm/q:90/h:600/w:435/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTEzMzA0/MDctMTQ5MzQ0NzEy/NC0yMTY5LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/OAjlrX5xM7L1z6Fg8QTdjhLPzjDaZfTu5HmwGLSkqHs/rs:fit/g:sm/q:90/h:600/w:435/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTEzMzA0/MDctMTQ5MzQ0NzEy/NC0yMTY5LmpwZWc.jpeg');
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
-- artist 379 Josef Sivó (Hungarian Wikipedia (Magyar TV still))
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/hu/4/4c/S%C3%ADv%C3%B3_J%C3%B3zsef_heged%C5%B1m%C5%B1v%C3%A9sz.png'
WHERE id = 379 AND english_name = 'Josef Sivó' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://hu.wikipedia.org/wiki/F%C3%A1jl:S%C3%ADv%C3%B3_J%C3%B3zsef_heged%C5%B1m%C5%B1v%C3%A9sz.png', 'https://upload.wikimedia.org/wikipedia/hu/4/4c/S%C3%ADv%C3%B3_J%C3%B3zsef_heged%C5%B1m%C5%B1v%C3%A9sz.png', NULL, NULL, NULL, 'Hungarian Wikipedia (Magyar TV still)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 379 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/hu/4/4c/S%C3%ADv%C3%B3_J%C3%B3zsef_heged%C5%B1m%C5%B1v%C3%A9sz.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/hu/4/4c/S%C3%ADv%C3%B3_J%C3%B3zsef_heged%C5%B1m%C5%B1v%C3%A9sz.png');
-- artist 380 Oliver Schnyder (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a4/Oliver_Schnyder.jpg'
WHERE id = 380 AND english_name = 'Oliver Schnyder' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Oliver_Schnyder.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a4/Oliver_Schnyder.jpg', 'Kurt Schnyder', 'CC BY-SA 3.0', 'http://creativecommons.org/licenses/by-sa/3.0/', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 380 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a4/Oliver_Schnyder.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a4/Oliver_Schnyder.jpg');
-- artist 381 Yara Bernette (Jewish Women's Archive)
UPDATE artists SET image_url = 'https://jwa.org/sites/default/files/styles/scale_width_300px/public/mediaobjects/Bernetta-Yara_small.jpg?itok=8mxvJewT'
WHERE id = 381 AND english_name = 'Yara Bernette' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://jwa.org/encyclopedia/article/bernette-yara', 'https://jwa.org/sites/default/files/styles/scale_width_300px/public/mediaobjects/Bernetta-Yara_small.jpg?itok=8mxvJewT', NULL, NULL, NULL, 'Jewish Women''s Archive', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 381 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://jwa.org/sites/default/files/styles/scale_width_300px/public/mediaobjects/Bernetta-Yara_small.jpg?itok=8mxvJewT'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://jwa.org/sites/default/files/styles/scale_width_300px/public/mediaobjects/Bernetta-Yara_small.jpg?itok=8mxvJewT');
-- artist 382 도쿠나가 쓰기오 (ぶらあぼONLINE (ebravo.jp))
UPDATE artists SET image_url = 'https://ebravo.jp/wp-content/uploads/2016/05/DSC_1763.jpg'
WHERE id = 382 AND english_name = 'Tsugio Tokunaga' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://ebravo.jp/archives/26786', 'https://ebravo.jp/wp-content/uploads/2016/05/DSC_1763.jpg', NULL, NULL, NULL, 'ぶらあぼONLINE (ebravo.jp)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 382 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://ebravo.jp/wp-content/uploads/2016/05/DSC_1763.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://ebravo.jp/wp-content/uploads/2016/05/DSC_1763.jpg');
-- artist 383 Anne Evans (wagneropera.net)
UPDATE artists SET image_url = 'https://www.wagneropera.net/images2/2AnneEvansSiegf09.jpg'
WHERE id = 383 AND english_name = 'Anne Evans' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.wagneropera.net/biographies/anne-evans.htm', 'https://www.wagneropera.net/images2/2AnneEvansSiegf09.jpg', NULL, NULL, NULL, 'wagneropera.net', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 383 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.wagneropera.net/images2/2AnneEvansSiegf09.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.wagneropera.net/images2/2AnneEvansSiegf09.jpg');
-- artist 384 Sakari Oramo (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/42/b4/6a/42b46a92-f00d-f67c-01d3-e159368b0d7f/mzl.luxnufgj.jpg/600x600bb.jpg'
WHERE id = 384 AND english_name = 'Sakari Oramo' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/40618232', 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/42/b4/6a/42b46a92-f00d-f67c-01d3-e159368b0d7f/mzl.luxnufgj.jpg/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 384 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/42/b4/6a/42b46a92-f00d-f67c-01d3-e159368b0d7f/mzl.luxnufgj.jpg/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/42/b4/6a/42b46a92-f00d-f67c-01d3-e159368b0d7f/mzl.luxnufgj.jpg/600x600bb.jpg');
-- artist 385 Ricardo Kanji (Revista CONCERTO)
UPDATE artists SET image_url = 'https://concerto.com.br/sites/default/files/w-RicardoKanji_g.jpg'
WHERE id = 385 AND english_name = 'Ricardo Kanji' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://concerto.com.br/noticias/musica-classica/morre-o-flautista-maestro-e-professor-ricardo-kanji', 'https://concerto.com.br/sites/default/files/w-RicardoKanji_g.jpg', NULL, NULL, NULL, 'Revista CONCERTO', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 385 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://concerto.com.br/sites/default/files/w-RicardoKanji_g.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://concerto.com.br/sites/default/files/w-RicardoKanji_g.jpg');
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
-- artist 390 Adriana Maliponte (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/HCzXwh5LWZ4k2WPA_j7XJZ4PSV8GPPDRJ0wuw0b8b9s/rs:fit/g:sm/q:90/h:600/w:480/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE4MDE1/MDMtMTUyMzk0MTM1/NS04NTM0LmpwZWc.jpeg'
WHERE id = 390 AND english_name = 'Adriana Maliponte' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/1801503-Adriana-Maliponte', 'https://i.discogs.com/HCzXwh5LWZ4k2WPA_j7XJZ4PSV8GPPDRJ0wuw0b8b9s/rs:fit/g:sm/q:90/h:600/w:480/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE4MDE1/MDMtMTUyMzk0MTM1/NS04NTM0LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 390 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/HCzXwh5LWZ4k2WPA_j7XJZ4PSV8GPPDRJ0wuw0b8b9s/rs:fit/g:sm/q:90/h:600/w:480/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE4MDE1/MDMtMTUyMzk0MTM1/NS04NTM0LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/HCzXwh5LWZ4k2WPA_j7XJZ4PSV8GPPDRJ0wuw0b8b9s/rs:fit/g:sm/q:90/h:600/w:480/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE4MDE1/MDMtMTUyMzk0MTM1/NS04NTM0LmpwZWc.jpeg');
-- artist 391 Rafael Orozco (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/UxHQJsOjTMKIrsvRc4cRayxN2gCHGp7Fg4RPdowOGWs/rs:fit/g:sm/q:90/h:533/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE5MDY0/NzMtMTc0NDE3MTIw/Mi02OTA2LmpwZWc.jpeg'
WHERE id = 391 AND english_name = 'Rafael Orozco' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/1906473', 'https://i.discogs.com/UxHQJsOjTMKIrsvRc4cRayxN2gCHGp7Fg4RPdowOGWs/rs:fit/g:sm/q:90/h:533/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE5MDY0/NzMtMTc0NDE3MTIw/Mi02OTA2LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 391 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/UxHQJsOjTMKIrsvRc4cRayxN2gCHGp7Fg4RPdowOGWs/rs:fit/g:sm/q:90/h:533/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE5MDY0/NzMtMTc0NDE3MTIw/Mi02OTA2LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/UxHQJsOjTMKIrsvRc4cRayxN2gCHGp7Fg4RPdowOGWs/rs:fit/g:sm/q:90/h:533/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE5MDY0/NzMtMTc0NDE3MTIw/Mi02OTA2LmpwZWc.jpeg');
-- artist 392 즈비그니에프 제비에츠키 (Wikimedia Commons)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5e/Zbigniew_Drzewiecki_%28-1918%29.jpg'
WHERE id = 392 AND english_name = 'Zbigniew Drzewiecki' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Zbigniew_Drzewiecki_(-1918).jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/5e/Zbigniew_Drzewiecki_%28-1918%29.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 392 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5e/Zbigniew_Drzewiecki_%28-1918%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5e/Zbigniew_Drzewiecki_%28-1918%29.jpg');
-- artist 393 Masashi Ueda (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/ZB-F3wftblap3zLVVVa3tCzdzGbOtxrwYaq-7mm7GgU/rs:fit/g:sm/q:90/h:500/w:380/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTQ1ODM2/ODctMTQ2NDc0NjQ2/OC0yOTA0LmpwZWc.jpeg'
WHERE id = 393 AND english_name = 'Masashi Ueda' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/4583687', 'https://i.discogs.com/ZB-F3wftblap3zLVVVa3tCzdzGbOtxrwYaq-7mm7GgU/rs:fit/g:sm/q:90/h:500/w:380/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTQ1ODM2/ODctMTQ2NDc0NjQ2/OC0yOTA0LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 393 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/ZB-F3wftblap3zLVVVa3tCzdzGbOtxrwYaq-7mm7GgU/rs:fit/g:sm/q:90/h:500/w:380/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTQ1ODM2/ODctMTQ2NDc0NjQ2/OC0yOTA0LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/ZB-F3wftblap3zLVVVa3tCzdzGbOtxrwYaq-7mm7GgU/rs:fit/g:sm/q:90/h:500/w:380/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTQ1ODM2/ODctMTQ2NDc0NjQ2/OC0yOTA0LmpwZWc.jpeg');
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
-- artist 396 David Shallon (davidshallon.com (David Shallon Foundation))
UPDATE artists SET image_url = 'https://www.davidshallon.com/wp-content/uploads/2024/02/david-shallon.jpg'
WHERE id = 396 AND english_name = 'David Shallon' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://davidshallon.com/', 'https://www.davidshallon.com/wp-content/uploads/2024/02/david-shallon.jpg', NULL, NULL, NULL, 'davidshallon.com (David Shallon Foundation)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 396 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.davidshallon.com/wp-content/uploads/2024/02/david-shallon.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.davidshallon.com/wp-content/uploads/2024/02/david-shallon.jpg');
-- artist 397 Maria Tănase (Wikimedia Commons (Electrecord))
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Maria_T%C4%83nase.jpg'
WHERE id = 397 AND english_name = 'Maria Tănase' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Maria_T%C4%83nase.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Maria_T%C4%83nase.jpg', 'Electrecord', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 397 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Maria_T%C4%83nase.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Maria_T%C4%83nase.jpg');
-- artist 398 Turibio Santos (Deezer)
UPDATE artists SET image_url = 'https://cdn-images.dzcdn.net/images/artist/aa46548bea463eada49fba764b6e33a3/1000x1000-000000-80-0-0.jpg'
WHERE id = 398 AND english_name = 'Turibio Santos' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.deezer.com/artist/195216', 'https://cdn-images.dzcdn.net/images/artist/aa46548bea463eada49fba764b6e33a3/1000x1000-000000-80-0-0.jpg', NULL, NULL, NULL, 'Deezer', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 398 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://cdn-images.dzcdn.net/images/artist/aa46548bea463eada49fba764b6e33a3/1000x1000-000000-80-0-0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://cdn-images.dzcdn.net/images/artist/aa46548bea463eada49fba764b6e33a3/1000x1000-000000-80-0-0.jpg');
-- artist 400 마에하시 데이코 (Hirasa Office (management))
UPDATE artists SET image_url = 'https://www.hirasaoffice06.com/media/2/9/5/6/2956_600x600.jpg'
WHERE id = 400 AND english_name = 'Teiko Maehashi' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.hirasaoffice06.com/artists/view/456', 'https://www.hirasaoffice06.com/media/2/9/5/6/2956_600x600.jpg', NULL, NULL, NULL, 'Hirasa Office (management)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 400 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.hirasaoffice06.com/media/2/9/5/6/2956_600x600.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.hirasaoffice06.com/media/2/9/5/6/2956_600x600.jpg');
-- artist 401 Tytus Wojnowicz (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/Tytus_Wojnowicz_2013.jpg'
WHERE id = 401 AND english_name = 'Tytus Wojnowicz' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Tytus_Wojnowicz_2013.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/3f/Tytus_Wojnowicz_2013.jpg', 'This photo was taken by Przemysław JahrAutorem zdjęcia jest Przemysław JahrWykorzystując zdjęcie proszę podać jako autora:Przemysław Jahr / Wikimedia Commons', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 401 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/Tytus_Wojnowicz_2013.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/Tytus_Wojnowicz_2013.jpg');
-- artist 403 Masao Kawasaki (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/mibP-MLQ9JsuZc1Z_W8uEhekgYKp2OMyGNT7wIHL2XM/rs:fit/g:sm/q:90/h:300/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE0MDAx/NzUtMTcxNzA0NTMw/NS02NDUzLmpwZWc.jpeg'
WHERE id = 403 AND english_name = 'Masao Kawasaki' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/1400175', 'https://i.discogs.com/mibP-MLQ9JsuZc1Z_W8uEhekgYKp2OMyGNT7wIHL2XM/rs:fit/g:sm/q:90/h:300/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE0MDAx/NzUtMTcxNzA0NTMw/NS02NDUzLmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 403 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/mibP-MLQ9JsuZc1Z_W8uEhekgYKp2OMyGNT7wIHL2XM/rs:fit/g:sm/q:90/h:300/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE0MDAx/NzUtMTcxNzA0NTMw/NS02NDUzLmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/mibP-MLQ9JsuZc1Z_W8uEhekgYKp2OMyGNT7wIHL2XM/rs:fit/g:sm/q:90/h:300/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE0MDAx/NzUtMTcxNzA0NTMw/NS02NDUzLmpwZWc.jpeg');
-- artist 405 Hiro Kurosaki (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/b4/52/54/b452543a-fb9a-400c-3ed7-30d4cbba00d2/mza_14378871064415409573.png/600x600bb.jpg'
WHERE id = 405 AND english_name = 'Hiro Kurosaki' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/161181118', 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/b4/52/54/b452543a-fb9a-400c-3ed7-30d4cbba00d2/mza_14378871064415409573.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 405 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/b4/52/54/b452543a-fb9a-400c-3ed7-30d4cbba00d2/mza_14378871064415409573.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/b4/52/54/b452543a-fb9a-400c-3ed7-30d4cbba00d2/mza_14378871064415409573.png/600x600bb.jpg');
-- artist 406 Stanisław Drzewiecki (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/WqQ6ROL_HTirR3GARK-yN2ZakpdStT8LF_o4EEgaRAs/rs:fit/g:sm/q:90/h:396/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTEwNjk5/MzQtMTQ5MzM4NDAz/OC0zNDI4LmpwZWc.jpeg'
WHERE id = 406 AND english_name = 'Stanisław Drzewiecki' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/1069934', 'https://i.discogs.com/WqQ6ROL_HTirR3GARK-yN2ZakpdStT8LF_o4EEgaRAs/rs:fit/g:sm/q:90/h:396/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTEwNjk5/MzQtMTQ5MzM4NDAz/OC0zNDI4LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 406 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/WqQ6ROL_HTirR3GARK-yN2ZakpdStT8LF_o4EEgaRAs/rs:fit/g:sm/q:90/h:396/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTEwNjk5/MzQtMTQ5MzM4NDAz/OC0zNDI4LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/WqQ6ROL_HTirR3GARK-yN2ZakpdStT8LF_o4EEgaRAs/rs:fit/g:sm/q:90/h:396/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTEwNjk5/MzQtMTQ5MzM4NDAz/OC0zNDI4LmpwZWc.jpeg');
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
-- artist 410 오카모토 도모타카 (Tomotaka Okamoto official site)
UPDATE artists SET image_url = 'https://www.okamototomotaka.com/okamoto01/wp-content/uploads/2025/11/okamoto.jpg'
WHERE id = 410 AND english_name = 'Tomotaka Okamoto' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.okamototomotaka.com/profile/', 'https://www.okamototomotaka.com/okamoto01/wp-content/uploads/2025/11/okamoto.jpg', NULL, NULL, NULL, 'Tomotaka Okamoto official site', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 410 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.okamototomotaka.com/okamoto01/wp-content/uploads/2025/11/okamoto.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.okamototomotaka.com/okamoto01/wp-content/uploads/2025/11/okamoto.jpg');
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
-- artist 415 Casper Reardon (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/6N0Go5ZXerJ3GyC1EawfStwRNanYT1DYh9JIB0cxqVw/rs:fit/g:sm/q:90/h:600/w:468/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwNzc2/MDMtMTczMzg2MTg0/OS02MjUwLmpwZWc.jpeg'
WHERE id = 415 AND english_name = 'Casper Reardon' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/2077603-Casper-Reardon', 'https://i.discogs.com/6N0Go5ZXerJ3GyC1EawfStwRNanYT1DYh9JIB0cxqVw/rs:fit/g:sm/q:90/h:600/w:468/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwNzc2/MDMtMTczMzg2MTg0/OS02MjUwLmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 415 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/6N0Go5ZXerJ3GyC1EawfStwRNanYT1DYh9JIB0cxqVw/rs:fit/g:sm/q:90/h:600/w:468/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwNzc2/MDMtMTczMzg2MTg0/OS02MjUwLmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/6N0Go5ZXerJ3GyC1EawfStwRNanYT1DYh9JIB0cxqVw/rs:fit/g:sm/q:90/h:600/w:468/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwNzc2/MDMtMTczMzg2MTg0/OS02MjUwLmpwZWc.jpeg');
-- artist 416 Jerzy Katlewicz (Radio Kraków)
UPDATE artists SET image_url = 'https://radiokrakow.pl/media/cache/widen_1200/media/data/1755379/cd8d597eda4b8f825339ad6e3e8556db.webp'
WHERE id = 416 AND english_name = 'Jerzy Katlewicz' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.radiokrakow.pl/audycje/kolo-kultury-muzyka-klasyczna/jerzy-katlewicz-in-memoriam', 'https://radiokrakow.pl/media/cache/widen_1200/media/data/1755379/cd8d597eda4b8f825339ad6e3e8556db.webp', NULL, NULL, NULL, 'Radio Kraków', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 416 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://radiokrakow.pl/media/cache/widen_1200/media/data/1755379/cd8d597eda4b8f825339ad6e3e8556db.webp'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://radiokrakow.pl/media/cache/widen_1200/media/data/1755379/cd8d597eda4b8f825339ad6e3e8556db.webp');
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
-- artist 419 Daniel Pezzotti (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/lQOxYgFWy9QHL_BXtoyOR5TTAsdT9UfXNMSx2ikbEy4/rs:fit/g:sm/q:90/h:548/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTMwNzU1/MS0xMTQ2NDEwMTky/LmpwZWc.jpeg'
WHERE id = 419 AND english_name = 'Daniel Pezzotti' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/307551-Daniel-Pezzotti', 'https://i.discogs.com/lQOxYgFWy9QHL_BXtoyOR5TTAsdT9UfXNMSx2ikbEy4/rs:fit/g:sm/q:90/h:548/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTMwNzU1/MS0xMTQ2NDEwMTky/LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 419 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/lQOxYgFWy9QHL_BXtoyOR5TTAsdT9UfXNMSx2ikbEy4/rs:fit/g:sm/q:90/h:548/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTMwNzU1/MS0xMTQ2NDEwMTky/LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/lQOxYgFWy9QHL_BXtoyOR5TTAsdT9UfXNMSx2ikbEy4/rs:fit/g:sm/q:90/h:548/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTMwNzU1/MS0xMTQ2NDEwMTky/LmpwZWc.jpeg');
-- artist 420 Nazzareno De Angelis (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/vahPy5fA9eoVQ_nVxote1YCiurgkvqp0bPZuyIWCo6g/rs:fit/g:sm/q:90/h:600/w:363/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIyNjYy/NjYtMTUzMzQ2ODk1/MS0yMjkxLmpwZWc.jpeg'
WHERE id = 420 AND english_name = 'Nazzareno De Angelis' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/2266266', 'https://i.discogs.com/vahPy5fA9eoVQ_nVxote1YCiurgkvqp0bPZuyIWCo6g/rs:fit/g:sm/q:90/h:600/w:363/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIyNjYy/NjYtMTUzMzQ2ODk1/MS0yMjkxLmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 420 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/vahPy5fA9eoVQ_nVxote1YCiurgkvqp0bPZuyIWCo6g/rs:fit/g:sm/q:90/h:600/w:363/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIyNjYy/NjYtMTUzMzQ2ODk1/MS0yMjkxLmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/vahPy5fA9eoVQ_nVxote1YCiurgkvqp0bPZuyIWCo6g/rs:fit/g:sm/q:90/h:600/w:363/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIyNjYy/NjYtMTUzMzQ2ODk1/MS0yMjkxLmpwZWc.jpeg');
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
-- artist 425 Mark Reizen (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/sRbUgtNysjzHze4E-SELuJJYT_-xNjY9K4JCjLWNUh8/rs:fit/g:sm/q:90/h:600/w:428/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE0MDg0/NjItMTczNTg4NTI1/NS0yMjM3LnBuZw.jpeg'
WHERE id = 425 AND english_name = 'Mark Reizen' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/1408462-%D0%9C%D0%B0%D1%80%D0%BA-%D0%A0%D0%B5%D0%B9%D0%B7%D0%B5%D0%BD', 'https://i.discogs.com/sRbUgtNysjzHze4E-SELuJJYT_-xNjY9K4JCjLWNUh8/rs:fit/g:sm/q:90/h:600/w:428/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE0MDg0/NjItMTczNTg4NTI1/NS0yMjM3LnBuZw.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 425 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/sRbUgtNysjzHze4E-SELuJJYT_-xNjY9K4JCjLWNUh8/rs:fit/g:sm/q:90/h:600/w:428/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE0MDg0/NjItMTczNTg4NTI1/NS0yMjM3LnBuZw.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/sRbUgtNysjzHze4E-SELuJJYT_-xNjY9K4JCjLWNUh8/rs:fit/g:sm/q:90/h:600/w:428/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE0MDg0/NjItMTczNTg4NTI1/NS0yMjM3LnBuZw.jpeg');
-- artist 426 유렉 뒤발 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/R_u4E2gTryIe9wRP0qlQFRKT1ieZqbhDsjkFlft8pe0/rs:fit/g:sm/q:90/h:466/w:466/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTU1ODgz/MjAtMTU1MzYyOTkw/Mi0zMTkzLmpwZWc.jpeg'
WHERE id = 426 AND english_name = 'Jurek Dybal' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/5588320-Jurek-Dybal', 'https://i.discogs.com/R_u4E2gTryIe9wRP0qlQFRKT1ieZqbhDsjkFlft8pe0/rs:fit/g:sm/q:90/h:466/w:466/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTU1ODgz/MjAtMTU1MzYyOTkw/Mi0zMTkzLmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 426 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/R_u4E2gTryIe9wRP0qlQFRKT1ieZqbhDsjkFlft8pe0/rs:fit/g:sm/q:90/h:466/w:466/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTU1ODgz/MjAtMTU1MzYyOTkw/Mi0zMTkzLmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/R_u4E2gTryIe9wRP0qlQFRKT1ieZqbhDsjkFlft8pe0/rs:fit/g:sm/q:90/h:466/w:466/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTU1ODgz/MjAtMTU1MzYyOTkw/Mi0zMTkzLmpwZWc.jpeg');
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
-- artist 430 Shinnosuke Ishihara (Shinnosuke Ishihara official site)
UPDATE artists SET image_url = 'https://public.readdy.ai/ai/img_res/edited_bc579952c2f1eecf3703c99f351ae38a_f94a8ef3.jpg'
WHERE id = 430 AND english_name = 'Shinnosuke Ishihara' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://shinnosukeishihara.com/', 'https://public.readdy.ai/ai/img_res/edited_bc579952c2f1eecf3703c99f351ae38a_f94a8ef3.jpg', NULL, NULL, NULL, 'Shinnosuke Ishihara official site', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 430 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://public.readdy.ai/ai/img_res/edited_bc579952c2f1eecf3703c99f351ae38a_f94a8ef3.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://public.readdy.ai/ai/img_res/edited_bc579952c2f1eecf3703c99f351ae38a_f94a8ef3.jpg');
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
-- artist 436 서정학 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/phGSHe_mcihhgRntDuUxL1mqubFaHtnTgg46iYqvYPY/rs:fit/g:sm/q:90/h:512/w:362/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTczNTA2/ODMtMTU4OTg5NDg1/OS01Mjg4LmpwZWc.jpeg'
WHERE id = 436 AND english_name = 'Seo Jung-Hack' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/7350683', 'https://i.discogs.com/phGSHe_mcihhgRntDuUxL1mqubFaHtnTgg46iYqvYPY/rs:fit/g:sm/q:90/h:512/w:362/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTczNTA2/ODMtMTU4OTg5NDg1/OS01Mjg4LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 436 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/phGSHe_mcihhgRntDuUxL1mqubFaHtnTgg46iYqvYPY/rs:fit/g:sm/q:90/h:512/w:362/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTczNTA2/ODMtMTU4OTg5NDg1/OS01Mjg4LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/phGSHe_mcihhgRntDuUxL1mqubFaHtnTgg46iYqvYPY/rs:fit/g:sm/q:90/h:512/w:362/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTczNTA2/ODMtMTU4OTg5NDg1/OS01Mjg4LmpwZWc.jpeg');
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
-- artist 440 프란스 헬메르손 (Kronberg Academy)
UPDATE artists SET image_url = 'https://www.kronbergacademy.de/fileadmin/_processed_/1/3/csm_2015_Helmerson__Frans_neu_6e2920bcb0.jpg'
WHERE id = 440 AND english_name = 'Frans Helmerson' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.kronbergacademy.de/en/person/frans-helmerson', 'https://www.kronbergacademy.de/fileadmin/_processed_/1/3/csm_2015_Helmerson__Frans_neu_6e2920bcb0.jpg', NULL, NULL, NULL, 'Kronberg Academy', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 440 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.kronbergacademy.de/fileadmin/_processed_/1/3/csm_2015_Helmerson__Frans_neu_6e2920bcb0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.kronbergacademy.de/fileadmin/_processed_/1/3/csm_2015_Helmerson__Frans_neu_6e2920bcb0.jpg');
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
-- artist 448 월터 바릴리 (Wiener Philharmoniker)
UPDATE artists SET image_url = 'https://wph-live.s3.amazonaws.com/media/filer_public_thumbnails/filer_public/65/01/6501b011-82f4-4906-834a-3e6e4c13b414/scan_20220209_walter_barylli.jpg__944x531_q85_crop_subject_location-1785%2C799_subsampling-2.jpg'
WHERE id = 448 AND english_name = 'Walter Barylli' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.wienerphilharmoniker.at/de/magazin/zum-gedenken-von-walter-barylli/6186', 'https://wph-live.s3.amazonaws.com/media/filer_public_thumbnails/filer_public/65/01/6501b011-82f4-4906-834a-3e6e4c13b414/scan_20220209_walter_barylli.jpg__944x531_q85_crop_subject_location-1785%2C799_subsampling-2.jpg', NULL, NULL, NULL, 'Wiener Philharmoniker', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 448 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://wph-live.s3.amazonaws.com/media/filer_public_thumbnails/filer_public/65/01/6501b011-82f4-4906-834a-3e6e4c13b414/scan_20220209_walter_barylli.jpg__944x531_q85_crop_subject_location-1785%2C799_subsampling-2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://wph-live.s3.amazonaws.com/media/filer_public_thumbnails/filer_public/65/01/6501b011-82f4-4906-834a-3e6e4c13b414/scan_20220209_walter_barylli.jpg__944x531_q85_crop_subject_location-1785%2C799_subsampling-2.jpg');
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
-- artist 451 Jakob Gimpel (Hebrew Wikipedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/he/e/e5/%D7%92%27%D7%99%D7%99%D7%A7%D7%95%D7%91_%D7%92%D7%99%D7%9E%D7%A4%D7%9C.jpg'
WHERE id = 451 AND english_name = 'Jakob Gimpel' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://he.wikipedia.org/wiki/%D7%A7%D7%95%D7%91%D7%A5:%D7%92%27%D7%99%D7%99%D7%A7%D7%95%D7%91_%D7%92%D7%99%D7%9E%D7%A4%D7%9C.jpg', 'https://upload.wikimedia.org/wikipedia/he/e/e5/%D7%92%27%D7%99%D7%99%D7%A7%D7%95%D7%91_%D7%92%D7%99%D7%9E%D7%A4%D7%9C.jpg', NULL, NULL, NULL, 'Hebrew Wikipedia', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 451 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/he/e/e5/%D7%92%27%D7%99%D7%99%D7%A7%D7%95%D7%91_%D7%92%D7%99%D7%9E%D7%A4%D7%9C.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/he/e/e5/%D7%92%27%D7%99%D7%99%D7%A7%D7%95%D7%91_%D7%92%D7%99%D7%9E%D7%A4%D7%9C.jpg');
-- artist 453 Jhalak Man Gandarbha (ArtistNepal)
UPDATE artists SET image_url = 'https://artistnepal.com/uploads/2025/11/Jhalakman-Gandharva-was-a-pioneering-Nepali-folk-singer-who-popularized-Gaine-Geet-giving-voice-to-Nepal-s-marginalized-Gandharbha-community.png'
WHERE id = 453 AND english_name = 'Jhalak Man Gandarbha' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://artistnepal.com/artist/3ng2xmmyd1', 'https://artistnepal.com/uploads/2025/11/Jhalakman-Gandharva-was-a-pioneering-Nepali-folk-singer-who-popularized-Gaine-Geet-giving-voice-to-Nepal-s-marginalized-Gandharbha-community.png', NULL, NULL, NULL, 'ArtistNepal', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 453 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://artistnepal.com/uploads/2025/11/Jhalakman-Gandharva-was-a-pioneering-Nepali-folk-singer-who-popularized-Gaine-Geet-giving-voice-to-Nepal-s-marginalized-Gandharbha-community.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://artistnepal.com/uploads/2025/11/Jhalakman-Gandharva-was-a-pioneering-Nepali-folk-singer-who-popularized-Gaine-Geet-giving-voice-to-Nepal-s-marginalized-Gandharbha-community.png');
-- artist 455 Regina Resnik (Deezer)
UPDATE artists SET image_url = 'https://cdn-images.dzcdn.net/images/artist/655f08a5e180c02237027488d1633eb1/1000x1000-000000-80-0-0.jpg'
WHERE id = 455 AND english_name = 'Regina Resnik' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.deezer.com/artist/4187058', 'https://cdn-images.dzcdn.net/images/artist/655f08a5e180c02237027488d1633eb1/1000x1000-000000-80-0-0.jpg', NULL, NULL, NULL, 'Deezer', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 455 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://cdn-images.dzcdn.net/images/artist/655f08a5e180c02237027488d1633eb1/1000x1000-000000-80-0-0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://cdn-images.dzcdn.net/images/artist/655f08a5e180c02237027488d1633eb1/1000x1000-000000-80-0-0.jpg');
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
-- artist 460 Simon Over (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/QEkzs-vPi8P-BoVqKcDhIOj6CyhhQza2u4nyy4ko_Ew/rs:fit/g:sm/q:90/h:600/w:532/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTQzMzI1/MDctMTUwOTE1ODE3/NC00NzU3LnBuZw.jpeg'
WHERE id = 460 AND english_name = 'Simon Over' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/4332507-Simon-Over', 'https://i.discogs.com/QEkzs-vPi8P-BoVqKcDhIOj6CyhhQza2u4nyy4ko_Ew/rs:fit/g:sm/q:90/h:600/w:532/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTQzMzI1/MDctMTUwOTE1ODE3/NC00NzU3LnBuZw.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 460 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/QEkzs-vPi8P-BoVqKcDhIOj6CyhhQza2u4nyy4ko_Ew/rs:fit/g:sm/q:90/h:600/w:532/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTQzMzI1/MDctMTUwOTE1ODE3/NC00NzU3LnBuZw.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/QEkzs-vPi8P-BoVqKcDhIOj6CyhhQza2u4nyy4ko_Ew/rs:fit/g:sm/q:90/h:600/w:532/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTQzMzI1/MDctMTUwOTE1ODE3/NC00NzU3LnBuZw.jpeg');
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
-- artist 466 Sirena Huang (Sirena Huang (official YouTube channel))
UPDATE artists SET image_url = 'https://yt3.googleusercontent.com/o85EMFQf4JUtCXZ1iPNDRT4S9X_FTkXEXXR6ZInoi1VJNaIHevhy18yh4FxPGcjZlZUCORYW-w=s900-c-k-c0x00ffffff-no-rj'
WHERE id = 466 AND english_name = 'Sirena Huang' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.youtube.com/channel/UCbql744As9Act3VczkN3PoQ', 'https://yt3.googleusercontent.com/o85EMFQf4JUtCXZ1iPNDRT4S9X_FTkXEXXR6ZInoi1VJNaIHevhy18yh4FxPGcjZlZUCORYW-w=s900-c-k-c0x00ffffff-no-rj', NULL, NULL, NULL, 'Sirena Huang (official YouTube channel)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 466 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://yt3.googleusercontent.com/o85EMFQf4JUtCXZ1iPNDRT4S9X_FTkXEXXR6ZInoi1VJNaIHevhy18yh4FxPGcjZlZUCORYW-w=s900-c-k-c0x00ffffff-no-rj'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://yt3.googleusercontent.com/o85EMFQf4JUtCXZ1iPNDRT4S9X_FTkXEXXR6ZInoi1VJNaIHevhy18yh4FxPGcjZlZUCORYW-w=s900-c-k-c0x00ffffff-no-rj');
-- artist 467 기욤 레미 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/29/Guillaume_Remy_%28cropped%29.jpg'
WHERE id = 467 AND english_name = 'Guillaume Rémy' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Guillaume_Remy_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/29/Guillaume_Remy_%28cropped%29.jpg', 'Alcide Allevy', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 467 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/29/Guillaume_Remy_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/29/Guillaume_Remy_%28cropped%29.jpg');
-- artist 468 Ragnar Ulfung (Wikimedia Commons (Lars Jacob for CabarEng))
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5f/RagnarUlfung_2016.jpg'
WHERE id = 468 AND english_name = 'Ragnar Ulfung' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:RagnarUlfung_2016.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/5f/RagnarUlfung_2016.jpg', 'Lars Jacob for CabarEng', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 468 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5f/RagnarUlfung_2016.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5f/RagnarUlfung_2016.jpg');
-- artist 469 Ganna Walska (Wikimedia Commons (George Grantham Bain Collection, Library of Congress))
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Ganna_Walska.jpg/1280px-Ganna_Walska.jpg'
WHERE id = 469 AND english_name = 'Ganna Walska' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Ganna_Walska.jpg', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Ganna_Walska.jpg/1280px-Ganna_Walska.jpg', 'George Grantham Bain Collection (Library of Congress)', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 469 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Ganna_Walska.jpg/1280px-Ganna_Walska.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Ganna_Walska.jpg/1280px-Ganna_Walska.jpg');
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
-- artist 479 Hansheinz Schneeberger (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/_epJ1Dz_B3w-OtynxRRlJAmPyVV5AVDd5y6Qh5ffJV8/rs:fit/g:sm/q:90/h:332/w:500/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTkwMzA3/My0xMTk1MjM4NTgx/LmpwZWc.jpeg'
WHERE id = 479 AND english_name = 'Hansheinz Schneeberger' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/903073', 'https://i.discogs.com/_epJ1Dz_B3w-OtynxRRlJAmPyVV5AVDd5y6Qh5ffJV8/rs:fit/g:sm/q:90/h:332/w:500/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTkwMzA3/My0xMTk1MjM4NTgx/LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 479 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/_epJ1Dz_B3w-OtynxRRlJAmPyVV5AVDd5y6Qh5ffJV8/rs:fit/g:sm/q:90/h:332/w:500/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTkwMzA3/My0xMTk1MjM4NTgx/LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/_epJ1Dz_B3w-OtynxRRlJAmPyVV5AVDd5y6Qh5ffJV8/rs:fit/g:sm/q:90/h:332/w:500/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTkwMzA3/My0xMTk1MjM4NTgx/LmpwZWc.jpeg');
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
-- artist 496 Stuart Burrows (BBC News)
UPDATE artists SET image_url = 'https://ichef.bbci.co.uk/news/1024/cpsprodpb/0b64/live/cf053020-5525-11f0-95e9-2d6b2682e694.jpg'
WHERE id = 496 AND english_name = 'Stuart Burrows' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.bbc.com/news/articles/c5y7e885nv9o', 'https://ichef.bbci.co.uk/news/1024/cpsprodpb/0b64/live/cf053020-5525-11f0-95e9-2d6b2682e694.jpg', NULL, NULL, NULL, 'BBC News', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 496 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://ichef.bbci.co.uk/news/1024/cpsprodpb/0b64/live/cf053020-5525-11f0-95e9-2d6b2682e694.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://ichef.bbci.co.uk/news/1024/cpsprodpb/0b64/live/cf053020-5525-11f0-95e9-2d6b2682e694.jpg');
-- artist 497 William Joseph (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/eb/William_Joseph_by_Gage_Skidmore.jpg'
WHERE id = 497 AND english_name = 'William Joseph' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:William_Joseph_by_Gage_Skidmore.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/eb/William_Joseph_by_Gage_Skidmore.jpg', 'Gage Skidmore', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 497 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/eb/William_Joseph_by_Gage_Skidmore.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/eb/William_Joseph_by_Gage_Skidmore.jpg');
-- artist 498 Frøydis Ree Wekre (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/qvB5BV6lsC-ms2EfHtzslHKXIzo3BrYGzvxgM3pdFnw/rs:fit/g:sm/q:90/h:433/w:430/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwMjI3/OTktMTQ1Nzk2NDM4/My04NjY5LmdpZg.jpeg'
WHERE id = 498 AND english_name = 'Frøydis Ree Wekre' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/2022799-Fr%C3%B8ydis-Ree-Wekre', 'https://i.discogs.com/qvB5BV6lsC-ms2EfHtzslHKXIzo3BrYGzvxgM3pdFnw/rs:fit/g:sm/q:90/h:433/w:430/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwMjI3/OTktMTQ1Nzk2NDM4/My04NjY5LmdpZg.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 498 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/qvB5BV6lsC-ms2EfHtzslHKXIzo3BrYGzvxgM3pdFnw/rs:fit/g:sm/q:90/h:433/w:430/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwMjI3/OTktMTQ1Nzk2NDM4/My04NjY5LmdpZg.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/qvB5BV6lsC-ms2EfHtzslHKXIzo3BrYGzvxgM3pdFnw/rs:fit/g:sm/q:90/h:433/w:430/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwMjI3/OTktMTQ1Nzk2NDM4/My04NjY5LmdpZg.jpeg');
-- artist 499 Ferruccio Furlanetto (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/cb443cdea005919162d33bff70fc4203b614c1ff'
WHERE id = 499 AND english_name = 'Ferruccio Furlanetto' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/5fN6PDw4pvvYRQtseOS4ru', 'https://i.scdn.co/image/cb443cdea005919162d33bff70fc4203b614c1ff', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 499 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/cb443cdea005919162d33bff70fc4203b614c1ff'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/cb443cdea005919162d33bff70fc4203b614c1ff');
-- artist 500 Raya Garbousova (Wikipedia (en))
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/en/c/cd/RayaGarbousova.jpg'
WHERE id = 500 AND english_name = 'Raya Garbousova' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://en.wikipedia.org/wiki/File:RayaGarbousova.jpg', 'https://upload.wikimedia.org/wikipedia/en/c/cd/RayaGarbousova.jpg', NULL, NULL, NULL, 'Wikipedia (en)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 500 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/en/c/cd/RayaGarbousova.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/en/c/cd/RayaGarbousova.jpg');
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
-- artist 504 Nicolae Herlea (Hebrew Wikipedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/he/7/7b/Nicolae_Herlea.jpg'
WHERE id = 504 AND english_name = 'Nicolae Herlea' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://he.wikipedia.org/wiki/%D7%A7%D7%95%D7%91%D7%A5:Nicolae_Herlea.jpg', 'https://upload.wikimedia.org/wikipedia/he/7/7b/Nicolae_Herlea.jpg', NULL, NULL, NULL, 'Hebrew Wikipedia', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 504 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/he/7/7b/Nicolae_Herlea.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/he/7/7b/Nicolae_Herlea.jpg');
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
-- artist 507 Danjūrō Ishizaka (Hong Kong Philharmonic Orchestra)
UPDATE artists SET image_url = 'https://www.hkphil.org/f/artist/5124/421c432/2787.jpg'
WHERE id = 507 AND english_name = 'Danjūrō Ishizaka' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.hkphil.org/artist/danjulo-ishizaka', 'https://www.hkphil.org/f/artist/5124/421c432/2787.jpg', NULL, NULL, NULL, 'Hong Kong Philharmonic Orchestra', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 507 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.hkphil.org/f/artist/5124/421c432/2787.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.hkphil.org/f/artist/5124/421c432/2787.jpg');
-- artist 508 Florence Cole Talbert (Wikimedia Commons (from Maud Cuney-Hare, Negro Musicians and Their Music))
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Maud_Cuney_Hare-378-Florence_Cole_Talbert.jpg'
WHERE id = 508 AND english_name = 'Florence Cole Talbert' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Maud_Cuney_Hare-378-Florence_Cole_Talbert.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Maud_Cuney_Hare-378-Florence_Cole_Talbert.jpg', 'Maud Cuney-Hare', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 508 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Maud_Cuney_Hare-378-Florence_Cole_Talbert.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Maud_Cuney_Hare-378-Florence_Cole_Talbert.jpg');
-- artist 509 Kyoko Takezawa (Argerich Arts Foundation (Beppu Argerich Music Festival))
UPDATE artists SET image_url = 'https://argerich-mf.jp/wp-content/uploads/2022/08/Takezawa.jpg'
WHERE id = 509 AND english_name = 'Kyoko Takezawa' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://argerich-mf.jp/en/artist/takezawa-kyoko', 'https://argerich-mf.jp/wp-content/uploads/2022/08/Takezawa.jpg', NULL, NULL, NULL, 'Argerich Arts Foundation (Beppu Argerich Music Festival)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 509 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://argerich-mf.jp/wp-content/uploads/2022/08/Takezawa.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://argerich-mf.jp/wp-content/uploads/2022/08/Takezawa.jpg');
-- artist 510 Domenico Nordio (Domenico Nordio official site)
UPDATE artists SET image_url = 'https://www.domeniconordio.com/pluginAppObj/pluginAppObj_111/rr.webp'
WHERE id = 510 AND english_name = 'Domenico Nordio' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.domeniconordio.com/', 'https://www.domeniconordio.com/pluginAppObj/pluginAppObj_111/rr.webp', NULL, NULL, NULL, 'Domenico Nordio official site', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 510 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.domeniconordio.com/pluginAppObj/pluginAppObj_111/rr.webp'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.domeniconordio.com/pluginAppObj/pluginAppObj_111/rr.webp');
-- artist 512 줄리앤 베어드 (Deezer)
UPDATE artists SET image_url = 'https://cdn-images.dzcdn.net/images/artist/a01ba537ece6d4bde5473513dce9ad67/1000x1000-000000-80-0-0.jpg'
WHERE id = 512 AND english_name = 'Julianne Baird' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.deezer.com/artist/1282374', 'https://cdn-images.dzcdn.net/images/artist/a01ba537ece6d4bde5473513dce9ad67/1000x1000-000000-80-0-0.jpg', NULL, NULL, NULL, 'Deezer', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 512 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://cdn-images.dzcdn.net/images/artist/a01ba537ece6d4bde5473513dce9ad67/1000x1000-000000-80-0-0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://cdn-images.dzcdn.net/images/artist/a01ba537ece6d4bde5473513dce9ad67/1000x1000-000000-80-0-0.jpg');
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
-- artist 516 Farid Farjad (Deezer)
UPDATE artists SET image_url = 'https://cdn-images.dzcdn.net/images/artist/9921741c256e18454cc5addf7bae4ec2/1000x1000-000000-80-0-0.jpg'
WHERE id = 516 AND english_name = 'Farid Farjad' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.deezer.com/artist/1247798', 'https://cdn-images.dzcdn.net/images/artist/9921741c256e18454cc5addf7bae4ec2/1000x1000-000000-80-0-0.jpg', NULL, NULL, NULL, 'Deezer', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 516 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://cdn-images.dzcdn.net/images/artist/9921741c256e18454cc5addf7bae4ec2/1000x1000-000000-80-0-0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://cdn-images.dzcdn.net/images/artist/9921741c256e18454cc5addf7bae4ec2/1000x1000-000000-80-0-0.jpg');
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
-- artist 520 Einar Beyron (Wikimedia Commons (photo Ekstrand, Scenen 1927))
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Einar_Beyron_Scenen_1927.jpg/960px-Einar_Beyron_Scenen_1927.jpg'
WHERE id = 520 AND english_name = 'Einar Beyron' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Einar_Beyron_Scenen_1927.jpg', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Einar_Beyron_Scenen_1927.jpg/960px-Einar_Beyron_Scenen_1927.jpg', 'Ekstrand', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 520 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Einar_Beyron_Scenen_1927.jpg/960px-Einar_Beyron_Scenen_1927.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Einar_Beyron_Scenen_1927.jpg/960px-Einar_Beyron_Scenen_1927.jpg');
-- artist 521 David Campbell (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/U5Ke-sxVE9Tp2BMAOVogL7V2AU2tksvDPx9vO7YVyfk/rs:fit/g:sm/q:90/h:454/w:542/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE1OTgx/NjMtMTU2MTEwMjE1/My0yMzM4LmpwZWc.jpeg'
WHERE id = 521 AND english_name = 'David Campbell' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/1598163', 'https://i.discogs.com/U5Ke-sxVE9Tp2BMAOVogL7V2AU2tksvDPx9vO7YVyfk/rs:fit/g:sm/q:90/h:454/w:542/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE1OTgx/NjMtMTU2MTEwMjE1/My0yMzM4LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 521 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/U5Ke-sxVE9Tp2BMAOVogL7V2AU2tksvDPx9vO7YVyfk/rs:fit/g:sm/q:90/h:454/w:542/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE1OTgx/NjMtMTU2MTEwMjE1/My0yMzM4LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/U5Ke-sxVE9Tp2BMAOVogL7V2AU2tksvDPx9vO7YVyfk/rs:fit/g:sm/q:90/h:454/w:542/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTE1OTgx/NjMtMTU2MTEwMjE1/My0yMzM4LmpwZWc.jpeg');
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
-- artist 524 Matthew Odell (Matthew Odell official site)
UPDATE artists SET image_url = 'https://www.matthewodell.com/wp-content/uploads/2012/10/homepage.jpg'
WHERE id = 524 AND english_name = 'Matthew Odell' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.matthewodell.com/', 'https://www.matthewodell.com/wp-content/uploads/2012/10/homepage.jpg', NULL, NULL, NULL, 'Matthew Odell official site', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 524 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.matthewodell.com/wp-content/uploads/2012/10/homepage.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.matthewodell.com/wp-content/uploads/2012/10/homepage.jpg');
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
-- artist 528 David Lloyd (Wikimedia Commons (Geoff Charles, National Library of Wales))
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2d/Lluniau_o_David_Lloyd_y_tenor_yn_yr_Eisteddfod_Genedlaethol_%281502257%29.jpg'
WHERE id = 528 AND english_name = 'David Lloyd' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Lluniau_o_David_Lloyd_y_tenor_yn_yr_Eisteddfod_Genedlaethol_(1502257).jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/2d/Lluniau_o_David_Lloyd_y_tenor_yn_yr_Eisteddfod_Genedlaethol_%281502257%29.jpg', 'Geoff Charles', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 528 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2d/Lluniau_o_David_Lloyd_y_tenor_yn_yr_Eisteddfod_Genedlaethol_%281502257%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2d/Lluniau_o_David_Lloyd_y_tenor_yn_yr_Eisteddfod_Genedlaethol_%281502257%29.jpg');
-- artist 529 Cécile Ousset (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/c2/8c/2f/c28c2f89-fb00-c9a3-bc3f-95b990627832/7a399d0a-fc51-4c2a-beaf-8b8f9169b99e.png/600x600bb.jpg'
WHERE id = 529 AND english_name = 'Cécile Ousset' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/821077', 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/c2/8c/2f/c28c2f89-fb00-c9a3-bc3f-95b990627832/7a399d0a-fc51-4c2a-beaf-8b8f9169b99e.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 529 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/c2/8c/2f/c28c2f89-fb00-c9a3-bc3f-95b990627832/7a399d0a-fc51-4c2a-beaf-8b8f9169b99e.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/c2/8c/2f/c28c2f89-fb00-c9a3-bc3f-95b990627832/7a399d0a-fc51-4c2a-beaf-8b8f9169b99e.png/600x600bb.jpg');
-- artist 530 Gilad Karni (Gilad Karni official site)
UPDATE artists SET image_url = 'https://static.wixstatic.com/media/336ac4_98d2f92ef9134ea1a4ae8ead5e21754d~mv2.jpg'
WHERE id = 530 AND english_name = 'Gilad Karni' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://giladkarni.com/', 'https://static.wixstatic.com/media/336ac4_98d2f92ef9134ea1a4ae8ead5e21754d~mv2.jpg', NULL, NULL, NULL, 'Gilad Karni official site', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 530 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://static.wixstatic.com/media/336ac4_98d2f92ef9134ea1a4ae8ead5e21754d~mv2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://static.wixstatic.com/media/336ac4_98d2f92ef9134ea1a4ae8ead5e21754d~mv2.jpg');
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
-- artist 544 Dolora Zajick (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/ESxCRjTjRjtoluwjeZMix4l4Gsyo4n3y8eHkAYmvrHk/rs:fit/g:sm/q:90/h:600/w:514/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIyMTk5/MTMtMTc3MTQyMzY0/MS00MjUwLmpwZWc.jpeg'
WHERE id = 544 AND english_name = 'Dolora Zajick' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/2219913', 'https://i.discogs.com/ESxCRjTjRjtoluwjeZMix4l4Gsyo4n3y8eHkAYmvrHk/rs:fit/g:sm/q:90/h:600/w:514/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIyMTk5/MTMtMTc3MTQyMzY0/MS00MjUwLmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 544 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/ESxCRjTjRjtoluwjeZMix4l4Gsyo4n3y8eHkAYmvrHk/rs:fit/g:sm/q:90/h:600/w:514/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIyMTk5/MTMtMTc3MTQyMzY0/MS00MjUwLmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/ESxCRjTjRjtoluwjeZMix4l4Gsyo4n3y8eHkAYmvrHk/rs:fit/g:sm/q:90/h:600/w:514/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIyMTk5/MTMtMTc3MTQyMzY0/MS00MjUwLmpwZWc.jpeg');
-- artist 545 Balázs Máté (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/5MQmZUa_ZLR_rTilRrIQnoe9hf0pyiv-tfCj1hbQ8FU/rs:fit/g:sm/q:90/h:600/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTk2MDkz/Mi0xNjAzNDM4MjQy/LTQ3ODQuanBlZw.jpeg'
WHERE id = 545 AND english_name = 'Balázs Máté' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/960932', 'https://i.discogs.com/5MQmZUa_ZLR_rTilRrIQnoe9hf0pyiv-tfCj1hbQ8FU/rs:fit/g:sm/q:90/h:600/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTk2MDkz/Mi0xNjAzNDM4MjQy/LTQ3ODQuanBlZw.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 545 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/5MQmZUa_ZLR_rTilRrIQnoe9hf0pyiv-tfCj1hbQ8FU/rs:fit/g:sm/q:90/h:600/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTk2MDkz/Mi0xNjAzNDM4MjQy/LTQ3ODQuanBlZw.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/5MQmZUa_ZLR_rTilRrIQnoe9hf0pyiv-tfCj1hbQ8FU/rs:fit/g:sm/q:90/h:600/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTk2MDkz/Mi0xNjAzNDM4MjQy/LTQ3ODQuanBlZw.jpeg');
-- artist 547 Eleonore Schoenfeld (USC Thornton School of Music)
UPDATE artists SET image_url = 'https://music.usc.edu/wp-content/uploads/2014/06/es.jpg'
WHERE id = 547 AND english_name = 'Eleonore Schoenfeld' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.usc.edu/spotlights/eleonore-schoenfeld-a-life-of-elegance/', 'https://music.usc.edu/wp-content/uploads/2014/06/es.jpg', NULL, NULL, NULL, 'USC Thornton School of Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 547 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://music.usc.edu/wp-content/uploads/2014/06/es.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://music.usc.edu/wp-content/uploads/2014/06/es.jpg');
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
-- artist 552 Rinat Ibragimov (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/-YRvRij2RB2AgDA5anZlmslIPjx-MwEj0X9RF5il820/rs:fit/g:sm/q:90/h:532/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTkwMzQw/Ny0xNjc1NTkxNzcw/LTY2MjUuanBlZw.jpeg'
WHERE id = 552 AND english_name = 'Rinat Ibragimov' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/903407', 'https://i.discogs.com/-YRvRij2RB2AgDA5anZlmslIPjx-MwEj0X9RF5il820/rs:fit/g:sm/q:90/h:532/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTkwMzQw/Ny0xNjc1NTkxNzcw/LTY2MjUuanBlZw.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 552 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/-YRvRij2RB2AgDA5anZlmslIPjx-MwEj0X9RF5il820/rs:fit/g:sm/q:90/h:532/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTkwMzQw/Ny0xNjc1NTkxNzcw/LTY2MjUuanBlZw.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/-YRvRij2RB2AgDA5anZlmslIPjx-MwEj0X9RF5il820/rs:fit/g:sm/q:90/h:532/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTkwMzQw/Ny0xNjc1NTkxNzcw/LTY2MjUuanBlZw.jpeg');
-- artist 553 스즈키 신이치 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/67/bb/a6/67bba60f-8dac-37d9-bfea-8227bcf044a0/mza_12748552119483048881.png/600x600bb.jpg'
WHERE id = 553 AND english_name = 'Shin''ichi Suzuki' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/208596512', 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/67/bb/a6/67bba60f-8dac-37d9-bfea-8227bcf044a0/mza_12748552119483048881.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 553 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/67/bb/a6/67bba60f-8dac-37d9-bfea-8227bcf044a0/mza_12748552119483048881.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/67/bb/a6/67bba60f-8dac-37d9-bfea-8227bcf044a0/mza_12748552119483048881.png/600x600bb.jpg');
-- artist 554 Paul Makanowitzky (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/ZJlwmXgZnPF4teTkjB0Esdo5MvF4Qds6KW7ldC3XsqQ/rs:fit/g:sm/q:90/h:600/w:452/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwNjM0/MjItMTUxOTYyMDE1/Ny04MDkxLmpwZWc.jpeg'
WHERE id = 554 AND english_name = 'Paul Makanowitzky' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/2063422-Paul-Makanowitzky', 'https://i.discogs.com/ZJlwmXgZnPF4teTkjB0Esdo5MvF4Qds6KW7ldC3XsqQ/rs:fit/g:sm/q:90/h:600/w:452/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwNjM0/MjItMTUxOTYyMDE1/Ny04MDkxLmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 554 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/ZJlwmXgZnPF4teTkjB0Esdo5MvF4Qds6KW7ldC3XsqQ/rs:fit/g:sm/q:90/h:600/w:452/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwNjM0/MjItMTUxOTYyMDE1/Ny04MDkxLmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/ZJlwmXgZnPF4teTkjB0Esdo5MvF4Qds6KW7ldC3XsqQ/rs:fit/g:sm/q:90/h:600/w:452/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwNjM0/MjItMTUxOTYyMDE1/Ny04MDkxLmpwZWc.jpeg');
-- artist 555 Otmar Suitner (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Otmar-Suitner.jpg'
WHERE id = 555 AND english_name = 'Otmar Suitner' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Otmar-Suitner.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Otmar-Suitner.jpg', 'G. Liebig, Inductor 13:59, 8. Sep. 2009 (CEST)', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 555 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Otmar-Suitner.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Otmar-Suitner.jpg');
-- artist 556 Robert Cohen (Deezer)
UPDATE artists SET image_url = 'https://cdn-images.dzcdn.net/images/artist/f84c2ea30ee4081511789b6faf27e2af/1000x1000-000000-80-0-0.jpg'
WHERE id = 556 AND english_name = 'Robert Cohen' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.deezer.com/artist/240820', 'https://cdn-images.dzcdn.net/images/artist/f84c2ea30ee4081511789b6faf27e2af/1000x1000-000000-80-0-0.jpg', NULL, NULL, NULL, 'Deezer', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 556 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://cdn-images.dzcdn.net/images/artist/f84c2ea30ee4081511789b6faf27e2af/1000x1000-000000-80-0-0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://cdn-images.dzcdn.net/images/artist/f84c2ea30ee4081511789b6faf27e2af/1000x1000-000000-80-0-0.jpg');
-- artist 558 잉바르 빅셀 (Wikimedia Commons (RAI))
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d0/Eurovision_Song_Contest_1965_-_Ingvar_Wixell.jpg'
WHERE id = 558 AND english_name = 'Ingvar Wixell' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Eurovision_Song_Contest_1965_-_Ingvar_Wixell.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d0/Eurovision_Song_Contest_1965_-_Ingvar_Wixell.jpg', 'RAI', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 558 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d0/Eurovision_Song_Contest_1965_-_Ingvar_Wixell.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d0/Eurovision_Song_Contest_1965_-_Ingvar_Wixell.jpg');
-- artist 559 Anja Thauer (Wikimedia Commons (pencil drawing by Hannah Böhm))
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Anja_Thauer_%28pencil_drawing_by_Hannah_B%C3%B6hm%29.png/1280px-Anja_Thauer_%28pencil_drawing_by_Hannah_B%C3%B6hm%29.png'
WHERE id = 559 AND english_name = 'Anja Thauer' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Anja_Thauer_(pencil_drawing_by_Hannah_B%C3%B6hm).png', 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Anja_Thauer_%28pencil_drawing_by_Hannah_B%C3%B6hm%29.png/1280px-Anja_Thauer_%28pencil_drawing_by_Hannah_B%C3%B6hm%29.png', 'Hannah Böhm', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 559 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Anja_Thauer_%28pencil_drawing_by_Hannah_B%C3%B6hm%29.png/1280px-Anja_Thauer_%28pencil_drawing_by_Hannah_B%C3%B6hm%29.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Anja_Thauer_%28pencil_drawing_by_Hannah_B%C3%B6hm%29.png/1280px-Anja_Thauer_%28pencil_drawing_by_Hannah_B%C3%B6hm%29.png');
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
-- artist 582 베르비에 페스티벌 오케스트라 (Verbier Festival (photo Agnieszka Biolik))
UPDATE artists SET image_url = 'https://verbierfestival.com/app/uploads/2019/11/140723_WANG_ZUBIN_COMBINS_18H30_@AgnieszkaBiolik-1536x1024.jpg'
WHERE id = 582 AND english_name = 'Verbier Festival Orchestra' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.verbierfestival.com/en/orchestra/verbier-festival-orchestra/', 'https://verbierfestival.com/app/uploads/2019/11/140723_WANG_ZUBIN_COMBINS_18H30_@AgnieszkaBiolik-1536x1024.jpg', NULL, NULL, NULL, 'Verbier Festival (photo Agnieszka Biolik)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 582 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://verbierfestival.com/app/uploads/2019/11/140723_WANG_ZUBIN_COMBINS_18H30_@AgnieszkaBiolik-1536x1024.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://verbierfestival.com/app/uploads/2019/11/140723_WANG_ZUBIN_COMBINS_18H30_@AgnieszkaBiolik-1536x1024.jpg');
-- artist 589 마르틴 판텔레예프 (Pantelife (Martin Panteleev's site))
UPDATE artists SET image_url = 'https://pantelife.wordpress.com/wp-content/uploads/2014/11/fs_kol_7700.jpg?w=1200'
WHERE id = 589 AND english_name = 'Martin Panteleev' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://pantelife.wordpress.com/eine-seite/', 'https://pantelife.wordpress.com/wp-content/uploads/2014/11/fs_kol_7700.jpg?w=1200', NULL, NULL, NULL, 'Pantelife (Martin Panteleev''s site)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 589 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://pantelife.wordpress.com/wp-content/uploads/2014/11/fs_kol_7700.jpg?w=1200'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://pantelife.wordpress.com/wp-content/uploads/2014/11/fs_kol_7700.jpg?w=1200');
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
-- artist 659 라 페니체 극장 관현악단 (Teatro La Fenice)
UPDATE artists SET image_url = 'https://www.teatrolafenice.it/wp-content/uploads/2019/02/coro002.jpg'
WHERE id = 659 AND english_name = 'Orchestra del Teatro La Fenice' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.teatrolafenice.it/en/la-fenice-foundation/orchestra-choir/', 'https://www.teatrolafenice.it/wp-content/uploads/2019/02/coro002.jpg', NULL, NULL, NULL, 'Teatro La Fenice', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 659 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.teatrolafenice.it/wp-content/uploads/2019/02/coro002.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.teatrolafenice.it/wp-content/uploads/2019/02/coro002.jpg');
-- artist 667 피에르 조르조 모란디 (Wiener Staatsoper (photo Elena Cherkashyna))
UPDATE artists SET image_url = 'https://www.wiener-staatsoper.at/cdn-cgi/image/gravity=0.5000x0.5000,width=1000,height=1250,quality=90,fit=cover/files/Kuenstler/0_DirigentInnen/Morandi-Pier-Giorgio_c_Elena-Cherkashyna.jpg'
WHERE id = 667 AND english_name = 'Pier Giorgio Morandi' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.wiener-staatsoper.at/en/artists/opera/detail/artist/2192-morandi-pier-giorgio/', 'https://www.wiener-staatsoper.at/cdn-cgi/image/gravity=0.5000x0.5000,width=1000,height=1250,quality=90,fit=cover/files/Kuenstler/0_DirigentInnen/Morandi-Pier-Giorgio_c_Elena-Cherkashyna.jpg', NULL, NULL, NULL, 'Wiener Staatsoper (photo Elena Cherkashyna)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 667 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.wiener-staatsoper.at/cdn-cgi/image/gravity=0.5000x0.5000,width=1000,height=1250,quality=90,fit=cover/files/Kuenstler/0_DirigentInnen/Morandi-Pier-Giorgio_c_Elena-Cherkashyna.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.wiener-staatsoper.at/cdn-cgi/image/gravity=0.5000x0.5000,width=1000,height=1250,quality=90,fit=cover/files/Kuenstler/0_DirigentInnen/Morandi-Pier-Giorgio_c_Elena-Cherkashyna.jpg');
-- artist 668 이온 마린 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/119f0f443e5072b69be17d0662ea3f20481b5cc5'
WHERE id = 668 AND english_name = 'Ion Marin' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/6grbrl3Fnn9y9UdoK6Dfdb', 'https://i.scdn.co/image/119f0f443e5072b69be17d0662ea3f20481b5cc5', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 668 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/119f0f443e5072b69be17d0662ea3f20481b5cc5'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/119f0f443e5072b69be17d0662ea3f20481b5cc5');
-- artist 679 프랭크 로파르도 (WFMT (publicity photo, Susan Johann))
UPDATE artists SET image_url = 'https://www.wfmt.com/cdn-cgi/image/trim=0;0;120;820,quality=85,format=jpeg/wp-content/uploads/2022/04/Frank.jpg'
WHERE id = 679 AND english_name = 'Frank Lopardo' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.wfmt.com/2022/04/09/on-the-mozart-and-rossini-tenor-with-frank-lopardo/', 'https://www.wfmt.com/cdn-cgi/image/trim=0;0;120;820,quality=85,format=jpeg/wp-content/uploads/2022/04/Frank.jpg', NULL, NULL, NULL, 'WFMT (publicity photo, Susan Johann)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 679 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.wfmt.com/cdn-cgi/image/trim=0;0;120;820,quality=85,format=jpeg/wp-content/uploads/2022/04/Frank.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.wfmt.com/cdn-cgi/image/trim=0;0;120;820,quality=85,format=jpeg/wp-content/uploads/2022/04/Frank.jpg');
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
-- artist 699 라 스타조네 프랑크푸르트 (La Stagione Frankfurt (official site))
UPDATE artists SET image_url = 'https://www.lastagione.de/images/big-images/StagioneFloersheim.jpg'
WHERE id = 699 AND english_name = 'La Stagione Frankfurt' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.lastagione.de/', 'https://www.lastagione.de/images/big-images/StagioneFloersheim.jpg', NULL, NULL, NULL, 'La Stagione Frankfurt (official site)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 699 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.lastagione.de/images/big-images/StagioneFloersheim.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.lastagione.de/images/big-images/StagioneFloersheim.jpg');
-- artist 702 콜레기움 아우레움 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/QJifhZ5rjfsEvuavJU3VqjO6JBBrWJKisuXx53IjwIM/rs:fit/g:sm/q:90/h:491/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTg0NTc2/MC0xNjg5NDg2Njcz/LTU0NzkuanBlZw.jpeg'
WHERE id = 702 AND english_name = 'Collegium Aureum' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/845760', 'https://i.discogs.com/QJifhZ5rjfsEvuavJU3VqjO6JBBrWJKisuXx53IjwIM/rs:fit/g:sm/q:90/h:491/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTg0NTc2/MC0xNjg5NDg2Njcz/LTU0NzkuanBlZw.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 702 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/QJifhZ5rjfsEvuavJU3VqjO6JBBrWJKisuXx53IjwIM/rs:fit/g:sm/q:90/h:491/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTg0NTc2/MC0xNjg5NDg2Njcz/LTU0NzkuanBlZw.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/QJifhZ5rjfsEvuavJU3VqjO6JBBrWJKisuXx53IjwIM/rs:fit/g:sm/q:90/h:491/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTg0NTc2/MC0xNjg5NDg2Njcz/LTU0NzkuanBlZw.jpeg');
-- artist 703 하노버 밴드 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/42360dc4d9fd2870e5d06e01f77747a4887b7dd8'
WHERE id = 703 AND english_name = 'Hanover Band' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/1ELhyIXfx2DUcYtZlmzwJ4', 'https://i.scdn.co/image/42360dc4d9fd2870e5d06e01f77747a4887b7dd8', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 703 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/42360dc4d9fd2870e5d06e01f77747a4887b7dd8'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/42360dc4d9fd2870e5d06e01f77747a4887b7dd8');
-- artist 706 드레스덴 실내합창단 (Dresdner Kammerchor (official site))
UPDATE artists SET image_url = 'https://dresdner-kammerchor.de/assets/images/s/slider-1920x1065-13-1zyvctee2k6phme.jpg'
WHERE id = 706 AND english_name = 'Dresdner Kammerchor' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://dresdner-kammerchor.de/', 'https://dresdner-kammerchor.de/assets/images/s/slider-1920x1065-13-1zyvctee2k6phme.jpg', NULL, NULL, NULL, 'Dresdner Kammerchor (official site)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 706 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://dresdner-kammerchor.de/assets/images/s/slider-1920x1065-13-1zyvctee2k6phme.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://dresdner-kammerchor.de/assets/images/s/slider-1920x1065-13-1zyvctee2k6phme.jpg');
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
-- artist 727 헬무트 뮐러브륄 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/S8hvqWkPZW1xUT5l_atao1pEvBS87vZylLgJtXtFGOQ/rs:fit/g:sm/q:90/h:600/w:458/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzNDA0/Mi0xNzc5MTkwMzU1/LTI2MjMuanBlZw.jpeg'
WHERE id = 727 AND english_name = 'Helmut Müller-Brühl' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/834042', 'https://i.discogs.com/S8hvqWkPZW1xUT5l_atao1pEvBS87vZylLgJtXtFGOQ/rs:fit/g:sm/q:90/h:600/w:458/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzNDA0/Mi0xNzc5MTkwMzU1/LTI2MjMuanBlZw.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 727 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/S8hvqWkPZW1xUT5l_atao1pEvBS87vZylLgJtXtFGOQ/rs:fit/g:sm/q:90/h:600/w:458/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzNDA0/Mi0xNzc5MTkwMzU1/LTI2MjMuanBlZw.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/S8hvqWkPZW1xUT5l_atao1pEvBS87vZylLgJtXtFGOQ/rs:fit/g:sm/q:90/h:600/w:458/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzNDA0/Mi0xNzc5MTkwMzU1/LTI2MjMuanBlZw.jpeg');
-- artist 728 아이오나 브라운 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/b7ff9a1af84c6093798b4c7bb8227e6a2d06e5e0'
WHERE id = 728 AND english_name = 'Iona Brown' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/4EQ6Hw3KV9S80ZG1swsFN5', 'https://i.scdn.co/image/b7ff9a1af84c6093798b4c7bb8227e6a2d06e5e0', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 728 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/b7ff9a1af84c6093798b4c7bb8227e6a2d06e5e0'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/b7ff9a1af84c6093798b4c7bb8227e6a2d06e5e0');
-- artist 729 쾰른 실내관현악단 (Kölner Kammerorchester (official site; photo Diesner))
UPDATE artists SET image_url = 'https://www.koelner-kammerorchester.de/wp-content/uploads/2023/10/230319_koelner_kammerorchester_001_5577_diesner.jpg'
WHERE id = 729 AND english_name = 'Cologne Chamber Orchestra' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.koelner-kammerorchester.de/', 'https://www.koelner-kammerorchester.de/wp-content/uploads/2023/10/230319_koelner_kammerorchester_001_5577_diesner.jpg', NULL, NULL, NULL, 'Kölner Kammerorchester (official site; photo Diesner)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 729 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.koelner-kammerorchester.de/wp-content/uploads/2023/10/230319_koelner_kammerorchester_001_5577_diesner.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.koelner-kammerorchester.de/wp-content/uploads/2023/10/230319_koelner_kammerorchester_001_5577_diesner.jpg');
-- artist 730 프라하 실내관현악단 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/ygCZR6VbsEznWF1NCGGVO2tW2lOKifxqUibEt3N7tY0/rs:fit/g:sm/q:90/h:457/w:427/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzMjk1/Mi0xMjk4MzYzOTM2/LmpwZWc.jpeg'
WHERE id = 730 AND english_name = 'Prague Chamber Orchestra' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/832952', 'https://i.discogs.com/ygCZR6VbsEznWF1NCGGVO2tW2lOKifxqUibEt3N7tY0/rs:fit/g:sm/q:90/h:457/w:427/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzMjk1/Mi0xMjk4MzYzOTM2/LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 730 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/ygCZR6VbsEznWF1NCGGVO2tW2lOKifxqUibEt3N7tY0/rs:fit/g:sm/q:90/h:457/w:427/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzMjk1/Mi0xMjk4MzYzOTM2/LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/ygCZR6VbsEznWF1NCGGVO2tW2lOKifxqUibEt3N7tY0/rs:fit/g:sm/q:90/h:457/w:427/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzMjk1/Mi0xMjk4MzYzOTM2/LmpwZWc.jpeg');
-- artist 743 라트비아 방송합창단 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/30/b0/20/30b020fc-57bd-c292-e39a-edba2f3666ae/c19830b2-ee4c-4abf-ac2e-d6529f3ae7e7.png/600x600bb.jpg'
WHERE id = 743 AND english_name = 'Latvian Radio Choir' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/64975101', 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/30/b0/20/30b020fc-57bd-c292-e39a-edba2f3666ae/c19830b2-ee4c-4abf-ac2e-d6529f3ae7e7.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 743 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/30/b0/20/30b020fc-57bd-c292-e39a-edba2f3666ae/c19830b2-ee4c-4abf-ac2e-d6529f3ae7e7.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/30/b0/20/30b020fc-57bd-c292-e39a-edba2f3666ae/c19830b2-ee4c-4abf-ac2e-d6529f3ae7e7.png/600x600bb.jpg');
-- artist 750 실라 암스트롱 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/M8YcwCRH0aWes4S0j9-LgaTS-VOjk_ac8rWRIuJ1lHs/rs:fit/g:sm/q:90/h:600/w:428/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzODk4/NC0xMzc1MjUxNDU1/LTQ1NzQuanBlZw.jpeg'
WHERE id = 750 AND english_name = 'Sheila Armstrong' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/838984', 'https://i.discogs.com/M8YcwCRH0aWes4S0j9-LgaTS-VOjk_ac8rWRIuJ1lHs/rs:fit/g:sm/q:90/h:600/w:428/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzODk4/NC0xMzc1MjUxNDU1/LTQ1NzQuanBlZw.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 750 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/M8YcwCRH0aWes4S0j9-LgaTS-VOjk_ac8rWRIuJ1lHs/rs:fit/g:sm/q:90/h:600/w:428/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzODk4/NC0xMzc1MjUxNDU1/LTQ1NzQuanBlZw.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/M8YcwCRH0aWes4S0j9-LgaTS-VOjk_ac8rWRIuJ1lHs/rs:fit/g:sm/q:90/h:600/w:428/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzODk4/NC0xMzc1MjUxNDU1/LTQ1NzQuanBlZw.jpeg');
-- artist 756 파스칼 드부아용 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/b70089706dfaaac85f4421931fff2973fa2a3be3'
WHERE id = 756 AND english_name = 'Pascal Devoyon' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/62LQUUl6THxN3wFMqmSx08', 'https://i.scdn.co/image/b70089706dfaaac85f4421931fff2973fa2a3be3', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 756 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/b70089706dfaaac85f4421931fff2973fa2a3be3'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/b70089706dfaaac85f4421931fff2973fa2a3be3');
-- artist 768 베네딕트 클뢰크너 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/htWjepsKikgrPxJdJHDT_qMxBiWm0VL5HWZ6MnrDbSc/rs:fit/g:sm/q:90/h:589/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTUzMDA0/MjEtMTU5OTY3NTc0/Ny0yMDU1LmpwZWc.jpeg'
WHERE id = 768 AND english_name = 'Benedict Klöckner' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/5300421-Benedict-Kloeckner', 'https://i.discogs.com/htWjepsKikgrPxJdJHDT_qMxBiWm0VL5HWZ6MnrDbSc/rs:fit/g:sm/q:90/h:589/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTUzMDA0/MjEtMTU5OTY3NTc0/Ny0yMDU1LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 768 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/htWjepsKikgrPxJdJHDT_qMxBiWm0VL5HWZ6MnrDbSc/rs:fit/g:sm/q:90/h:589/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTUzMDA0/MjEtMTU5OTY3NTc0/Ny0yMDU1LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/htWjepsKikgrPxJdJHDT_qMxBiWm0VL5HWZ6MnrDbSc/rs:fit/g:sm/q:90/h:589/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTUzMDA0/MjEtMTU5OTY3NTc0/Ny0yMDU1LmpwZWc.jpeg');
-- artist 776 오우에 에이지 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/a7/7d/c6/a77dc6c5-97c2-c6fa-18ba-6e71872ec22e/76c3f861-0ad6-4749-ac7e-88e59c1cddc9.png/600x600bb.jpg'
WHERE id = 776 AND english_name = 'Eiji Oue' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/160012748', 'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/a7/7d/c6/a77dc6c5-97c2-c6fa-18ba-6e71872ec22e/76c3f861-0ad6-4749-ac7e-88e59c1cddc9.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 776 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/a7/7d/c6/a77dc6c5-97c2-c6fa-18ba-6e71872ec22e/76c3f861-0ad6-4749-ac7e-88e59c1cddc9.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/a7/7d/c6/a77dc6c5-97c2-c6fa-18ba-6e71872ec22e/76c3f861-0ad6-4749-ac7e-88e59c1cddc9.png/600x600bb.jpg');
-- artist 781 티모시 허친스 (Timothy Hutchins official site)
UPDATE artists SET image_url = 'https://static.wixstatic.com/media/3846e6_3572abd463864187ad7769733faf6e1c~mv2.jpg/v1/fill/w_900,h_900,fp_0.70_0.30,q_85/3846e6_3572abd463864187ad7769733faf6e1c~mv2.jpg'
WHERE id = 781 AND english_name = 'Timothy Hutchins' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.timothyhutchinsflute.com/', 'https://static.wixstatic.com/media/3846e6_3572abd463864187ad7769733faf6e1c~mv2.jpg/v1/fill/w_900,h_900,fp_0.70_0.30,q_85/3846e6_3572abd463864187ad7769733faf6e1c~mv2.jpg', NULL, NULL, NULL, 'Timothy Hutchins official site', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 781 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://static.wixstatic.com/media/3846e6_3572abd463864187ad7769733faf6e1c~mv2.jpg/v1/fill/w_900,h_900,fp_0.70_0.30,q_85/3846e6_3572abd463864187ad7769733faf6e1c~mv2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://static.wixstatic.com/media/3846e6_3572abd463864187ad7769733faf6e1c~mv2.jpg/v1/fill/w_900,h_900,fp_0.70_0.30,q_85/3846e6_3572abd463864187ad7769733faf6e1c~mv2.jpg');
-- artist 783 시카고 심포니 합창단 (Chicago Symphony Orchestra (cso.org))
UPDATE artists SET image_url = 'https://chicagosymphony.org/media/gyvfo3xr/cso20251208_024fv2.jpg?width=1200&format=jpg&quality=85'
WHERE id = 783 AND english_name = 'Chicago Symphony Chorus' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://cso.org/about/chicago-symphony-chorus/', 'https://chicagosymphony.org/media/gyvfo3xr/cso20251208_024fv2.jpg?width=1200&format=jpg&quality=85', NULL, NULL, NULL, 'Chicago Symphony Orchestra (cso.org)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 783 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://chicagosymphony.org/media/gyvfo3xr/cso20251208_024fv2.jpg?width=1200&format=jpg&quality=85'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://chicagosymphony.org/media/gyvfo3xr/cso20251208_024fv2.jpg?width=1200&format=jpg&quality=85');
-- artist 784 필하모니아 합창단 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/gUhCAfQQIBsluk2_VjoaqxL7Gn28D3G-M8JFyIszaCw/rs:fit/g:sm/q:90/h:333/w:500/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzMzE2/OS0xMTk4MTUxNzMz/LmpwZWc.jpeg'
WHERE id = 784 AND english_name = 'Philharmonia Chorus' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/833169', 'https://i.discogs.com/gUhCAfQQIBsluk2_VjoaqxL7Gn28D3G-M8JFyIszaCw/rs:fit/g:sm/q:90/h:333/w:500/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzMzE2/OS0xMTk4MTUxNzMz/LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 784 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/gUhCAfQQIBsluk2_VjoaqxL7Gn28D3G-M8JFyIszaCw/rs:fit/g:sm/q:90/h:333/w:500/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzMzE2/OS0xMTk4MTUxNzMz/LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/gUhCAfQQIBsluk2_VjoaqxL7Gn28D3G-M8JFyIszaCw/rs:fit/g:sm/q:90/h:333/w:500/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzMzE2/OS0xMTk4MTUxNzMz/LmpwZWc.jpeg');
-- artist 790 샌프란시스코 심포니 합창단 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/72/76/7b/72767b81-4b48-0f59-eaea-d0e1cd2c5bc2/33587484-3f6e-4c52-a464-4a555da96a93.png/600x600bb.jpg'
WHERE id = 790 AND english_name = 'San Francisco Symphony Chorus' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/4360634', 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/72/76/7b/72767b81-4b48-0f59-eaea-d0e1cd2c5bc2/33587484-3f6e-4c52-a464-4a555da96a93.png/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 790 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/72/76/7b/72767b81-4b48-0f59-eaea-d0e1cd2c5bc2/33587484-3f6e-4c52-a464-4a555da96a93.png/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/72/76/7b/72767b81-4b48-0f59-eaea-d0e1cd2c5bc2/33587484-3f6e-4c52-a464-4a555da96a93.png/600x600bb.jpg');
-- artist 791 탱글우드 페스티벌 합창단 (Boston Symphony Orchestra (photo Hilary Scott))
UPDATE artists SET image_url = 'https://cdn.bso.org/uploads/TFC/8.22.26-Prelude-TFC-Zoie-Reams-Julia-Carey-Jean-S%C3%A9bastien-Vall%C3%A9e-Julien-Labro-Caleb-Quillen-2-Hilary-Scott.jpeg?fit=contain&height=1200&width=1200&s=4BQbUbQ60LO4PXkSGo2La5Q_gQ5ngY9jDNOQD00iWCE'
WHERE id = 791 AND english_name = 'Tanglewood Festival Chorus' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.bso.org/brands/bso/about-us/musicians/tanglewood-festival-chorus.aspx', 'https://cdn.bso.org/uploads/TFC/8.22.26-Prelude-TFC-Zoie-Reams-Julia-Carey-Jean-S%C3%A9bastien-Vall%C3%A9e-Julien-Labro-Caleb-Quillen-2-Hilary-Scott.jpeg?fit=contain&height=1200&width=1200&s=4BQbUbQ60LO4PXkSGo2La5Q_gQ5ngY9jDNOQD00iWCE', NULL, NULL, NULL, 'Boston Symphony Orchestra (photo Hilary Scott)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 791 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://cdn.bso.org/uploads/TFC/8.22.26-Prelude-TFC-Zoie-Reams-Julia-Carey-Jean-S%C3%A9bastien-Vall%C3%A9e-Julien-Labro-Caleb-Quillen-2-Hilary-Scott.jpeg?fit=contain&height=1200&width=1200&s=4BQbUbQ60LO4PXkSGo2La5Q_gQ5ngY9jDNOQD00iWCE'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://cdn.bso.org/uploads/TFC/8.22.26-Prelude-TFC-Zoie-Reams-Julia-Carey-Jean-S%C3%A9bastien-Vall%C3%A9e-Julien-Labro-Caleb-Quillen-2-Hilary-Scott.jpeg?fit=contain&height=1200&width=1200&s=4BQbUbQ60LO4PXkSGo2La5Q_gQ5ngY9jDNOQD00iWCE');
-- artist 793 버밍엄 시립교향악단 합창단 (CBSO (photo Andrew Fox))
UPDATE artists SET image_url = 'https://cbso-orchestra.transforms.svdcdn.com/production/General/Choruses/Adult-Chorus/CBSO_22-09-20.AdultChorus2.crAndrewFox.jpg?w=1200&h=628&q=100&auto=format&fit=crop&dm=1676567244&s=78cce97884f8ad13fe270df4e751e9ff'
WHERE id = 793 AND english_name = 'City of Birmingham Symphony Chorus' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://cbso.co.uk/take-part/sing-with-the-cbso/cbso-chorus', 'https://cbso-orchestra.transforms.svdcdn.com/production/General/Choruses/Adult-Chorus/CBSO_22-09-20.AdultChorus2.crAndrewFox.jpg?w=1200&h=628&q=100&auto=format&fit=crop&dm=1676567244&s=78cce97884f8ad13fe270df4e751e9ff', NULL, NULL, NULL, 'CBSO (photo Andrew Fox)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 793 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://cbso-orchestra.transforms.svdcdn.com/production/General/Choruses/Adult-Chorus/CBSO_22-09-20.AdultChorus2.crAndrewFox.jpg?w=1200&h=628&q=100&auto=format&fit=crop&dm=1676567244&s=78cce97884f8ad13fe270df4e751e9ff'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://cbso-orchestra.transforms.svdcdn.com/production/General/Choruses/Adult-Chorus/CBSO_22-09-20.AdultChorus2.crAndrewFox.jpg?w=1200&h=628&q=100&auto=format&fit=crop&dm=1676567244&s=78cce97884f8ad13fe270df4e751e9ff');
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
-- artist 813 보루산 이스탄불 필하모닉 오케스트라 (Deezer)
UPDATE artists SET image_url = 'https://cdn-images.dzcdn.net/images/artist/1a5597894ee98dba822a32320fb3fc1d/1000x1000-000000-80-0-0.jpg'
WHERE id = 813 AND english_name = 'Borusan Istanbul Philharmonic Orchestra' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.deezer.com/artist/5150519', 'https://cdn-images.dzcdn.net/images/artist/1a5597894ee98dba822a32320fb3fc1d/1000x1000-000000-80-0-0.jpg', NULL, NULL, NULL, 'Deezer', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 813 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://cdn-images.dzcdn.net/images/artist/1a5597894ee98dba822a32320fb3fc1d/1000x1000-000000-80-0-0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://cdn-images.dzcdn.net/images/artist/1a5597894ee98dba822a32320fb3fc1d/1000x1000-000000-80-0-0.jpg');
-- artist 815 아나톨 피스툴라리 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/nxkqO8mgdnTJv5FJIjyaxC2XNAYHfvyAqy9NtUmxUlE/rs:fit/g:sm/q:90/h:600/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTg1NTA1/OS0xMzY2ODkyNjM2/LTE4NTUuanBlZw.jpeg'
WHERE id = 815 AND english_name = 'Anatole Fistoulari' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/855059', 'https://i.discogs.com/nxkqO8mgdnTJv5FJIjyaxC2XNAYHfvyAqy9NtUmxUlE/rs:fit/g:sm/q:90/h:600/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTg1NTA1/OS0xMzY2ODkyNjM2/LTE4NTUuanBlZw.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 815 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/nxkqO8mgdnTJv5FJIjyaxC2XNAYHfvyAqy9NtUmxUlE/rs:fit/g:sm/q:90/h:600/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTg1NTA1/OS0xMzY2ODkyNjM2/LTE4NTUuanBlZw.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/nxkqO8mgdnTJv5FJIjyaxC2XNAYHfvyAqy9NtUmxUlE/rs:fit/g:sm/q:90/h:600/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTg1NTA1/OS0xMzY2ODkyNjM2/LTE4NTUuanBlZw.jpeg');
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
-- artist 840 뮌헨 바흐 오케스트라 (Münchener Bach-Chor & Bach-Orchester (official site))
UPDATE artists SET image_url = 'https://www.muenchener-bachchor.de/storage/2024/01/Bach-Chor-7_MBO_klein-scaled-e1706122293401.jpeg'
WHERE id = 840 AND english_name = 'Münchener Bach-Orchester' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.muenchener-bachchor.de/orchester/', 'https://www.muenchener-bachchor.de/storage/2024/01/Bach-Chor-7_MBO_klein-scaled-e1706122293401.jpeg', NULL, NULL, NULL, 'Münchener Bach-Chor & Bach-Orchester (official site)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 840 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.muenchener-bachchor.de/storage/2024/01/Bach-Chor-7_MBO_klein-scaled-e1706122293401.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.muenchener-bachchor.de/storage/2024/01/Bach-Chor-7_MBO_klein-scaled-e1706122293401.jpeg');
-- artist 841 로저 노링턴 (BR-KLASSIK (photo Manfred Esser))
UPDATE artists SET image_url = 'https://www.br-klassik.de/programm/sendungen-a-z/roger-norrington-100~_v-img__16__9__xl_-d31c35f8186ebeb80b0cd843a7c267a0e0c81647.jpg?version=88193'
WHERE id = 841 AND english_name = 'Roger Norrington' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.br-klassik.de/aktuell/news-kritik/roger-norrington-dirigent-beendet-karriere-100.html', 'https://www.br-klassik.de/programm/sendungen-a-z/roger-norrington-100~_v-img__16__9__xl_-d31c35f8186ebeb80b0cd843a7c267a0e0c81647.jpg?version=88193', NULL, NULL, NULL, 'BR-KLASSIK (photo Manfred Esser)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 841 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www.br-klassik.de/programm/sendungen-a-z/roger-norrington-100~_v-img__16__9__xl_-d31c35f8186ebeb80b0cd843a7c267a0e0c81647.jpg?version=88193'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.br-klassik.de/programm/sendungen-a-z/roger-norrington-100~_v-img__16__9__xl_-d31c35f8186ebeb80b0cd843a7c267a0e0c81647.jpg?version=88193');
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
-- artist 845 레온하르트 콘소트 (Deezer)
UPDATE artists SET image_url = 'https://cdn-images.dzcdn.net/images/artist/8c40ccd0b0ab83d859490340ddbafb2f/1000x1000-000000-80-0-0.jpg'
WHERE id = 845 AND english_name = 'Leonhardt-Consort' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.deezer.com/artist/4381626', 'https://cdn-images.dzcdn.net/images/artist/8c40ccd0b0ab83d859490340ddbafb2f/1000x1000-000000-80-0-0.jpg', NULL, NULL, NULL, 'Deezer', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 845 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://cdn-images.dzcdn.net/images/artist/8c40ccd0b0ab83d859490340ddbafb2f/1000x1000-000000-80-0-0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://cdn-images.dzcdn.net/images/artist/8c40ccd0b0ab83d859490340ddbafb2f/1000x1000-000000-80-0-0.jpg');
-- artist 846 콘라트 융해넬 (Spotify)
UPDATE artists SET image_url = 'https://i.scdn.co/image/9f35a03cd7477b15d7300fe258c67e96f49ced11'
WHERE id = 846 AND english_name = 'Konrad Junghänel' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/7zhA38UalSM1TkXWJxhqF5', 'https://i.scdn.co/image/9f35a03cd7477b15d7300fe258c67e96f49ced11', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 846 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.scdn.co/image/9f35a03cd7477b15d7300fe258c67e96f49ced11'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/9f35a03cd7477b15d7300fe258c67e96f49ced11');
-- artist 847 칸투스 쾰른 (Deezer)
UPDATE artists SET image_url = 'https://cdn-images.dzcdn.net/images/artist/c1b4dddfad94cf1e1c0e1cd2de32c699/1000x1000-000000-80-0-0.jpg'
WHERE id = 847 AND english_name = 'Cantus Cölln' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.deezer.com/artist/71485', 'https://cdn-images.dzcdn.net/images/artist/c1b4dddfad94cf1e1c0e1cd2de32c699/1000x1000-000000-80-0-0.jpg', NULL, NULL, NULL, 'Deezer', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 847 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://cdn-images.dzcdn.net/images/artist/c1b4dddfad94cf1e1c0e1cd2de32c699/1000x1000-000000-80-0-0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://cdn-images.dzcdn.net/images/artist/c1b4dddfad94cf1e1c0e1cd2de32c699/1000x1000-000000-80-0-0.jpg');
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
-- artist 854 로버트 로이드 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/46upeZN0Aml0zmBYZ2uJIP1ZkJOP43FpE3ljSpvIem0/rs:fit/g:sm/q:90/h:600/w:470/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTkzNzA3/Ny0xNTI3OTQ1MjA5/LTI2MTYuanBlZw.jpeg'
WHERE id = 854 AND english_name = 'Robert Lloyd' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/937077-Robert-Lloyd-4', 'https://i.discogs.com/46upeZN0Aml0zmBYZ2uJIP1ZkJOP43FpE3ljSpvIem0/rs:fit/g:sm/q:90/h:600/w:470/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTkzNzA3/Ny0xNTI3OTQ1MjA5/LTI2MTYuanBlZw.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 854 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/46upeZN0Aml0zmBYZ2uJIP1ZkJOP43FpE3ljSpvIem0/rs:fit/g:sm/q:90/h:600/w:470/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTkzNzA3/Ny0xNTI3OTQ1MjA5/LTI2MTYuanBlZw.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/46upeZN0Aml0zmBYZ2uJIP1ZkJOP43FpE3ljSpvIem0/rs:fit/g:sm/q:90/h:600/w:470/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTkzNzA3/Ny0xNTI3OTQ1MjA5/LTI2MTYuanBlZw.jpeg');
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
-- artist 866 세바스티앵 도세 (Wikimedia Commons (Bull-Doser))
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/S%C3%A9bastien_Dauc%C3%A9_au_salle_Bourgie.jpg/960px-S%C3%A9bastien_Dauc%C3%A9_au_salle_Bourgie.jpg'
WHERE id = 866 AND english_name = 'Sébastien Daucé' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:S%C3%A9bastien_Dauc%C3%A9_au_salle_Bourgie.jpg', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/S%C3%A9bastien_Dauc%C3%A9_au_salle_Bourgie.jpg/960px-S%C3%A9bastien_Dauc%C3%A9_au_salle_Bourgie.jpg', 'Bull-Doser', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 866 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/S%C3%A9bastien_Dauc%C3%A9_au_salle_Bourgie.jpg/960px-S%C3%A9bastien_Dauc%C3%A9_au_salle_Bourgie.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/S%C3%A9bastien_Dauc%C3%A9_au_salle_Bourgie.jpg/960px-S%C3%A9bastien_Dauc%C3%A9_au_salle_Bourgie.jpg');
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
-- artist 869 프란티셰크 헤르만 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/4efbR98TVrHqMmI246_1nqQyACxZAspUkTTzqiIdF_Y/rs:fit/g:sm/q:90/h:600/w:485/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzNTEw/NC0xNjE4ODQzNTY4/LTUwMzAuanBlZw.jpeg'
WHERE id = 869 AND english_name = 'František Herman' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/835104', 'https://i.discogs.com/4efbR98TVrHqMmI246_1nqQyACxZAspUkTTzqiIdF_Y/rs:fit/g:sm/q:90/h:600/w:485/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzNTEw/NC0xNjE4ODQzNTY4/LTUwMzAuanBlZw.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 869 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/4efbR98TVrHqMmI246_1nqQyACxZAspUkTTzqiIdF_Y/rs:fit/g:sm/q:90/h:600/w:485/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzNTEw/NC0xNjE4ODQzNTY4/LTUwMzAuanBlZw.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/4efbR98TVrHqMmI246_1nqQyACxZAspUkTTzqiIdF_Y/rs:fit/g:sm/q:90/h:600/w:485/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTgzNTEw/NC0xNjE4ODQzNTY4/LTUwMzAuanBlZw.jpeg');
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
-- artist 873 마티아스 라츠 (Matthias Rácz official site)
UPDATE artists SET image_url = 'https://static.wixstatic.com/media/37e39f_7de7dd7494414d92a859b98ca9a96097~mv2_d_6016_4016_s_4_2.jpg/v1/fill/w_1200,h_800,al_c,q_85/37e39f_7de7dd7494414d92a859b98ca9a96097~mv2_d_6016_4016_s_4_2.jpg'
WHERE id = 873 AND english_name = 'Matthias Racz' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.matthiasracz.de/', 'https://static.wixstatic.com/media/37e39f_7de7dd7494414d92a859b98ca9a96097~mv2_d_6016_4016_s_4_2.jpg/v1/fill/w_1200,h_800,al_c,q_85/37e39f_7de7dd7494414d92a859b98ca9a96097~mv2_d_6016_4016_s_4_2.jpg', NULL, NULL, NULL, 'Matthias Rácz official site', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 873 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://static.wixstatic.com/media/37e39f_7de7dd7494414d92a859b98ca9a96097~mv2_d_6016_4016_s_4_2.jpg/v1/fill/w_1200,h_800,al_c,q_85/37e39f_7de7dd7494414d92a859b98ca9a96097~mv2_d_6016_4016_s_4_2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://static.wixstatic.com/media/37e39f_7de7dd7494414d92a859b98ca9a96097~mv2_d_6016_4016_s_4_2.jpg/v1/fill/w_1200,h_800,al_c,q_85/37e39f_7de7dd7494414d92a859b98ca9a96097~mv2_d_6016_4016_s_4_2.jpg');
-- artist 874 요하네스 슐레플리 (Johannes Schlaefli official site)
UPDATE artists SET image_url = 'https://johannesschlaefli.com/wp-content/uploads/2018/06/cv-web-1-2000x1200.jpg'
WHERE id = 874 AND english_name = 'Johannes Schlaefli' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://johannesschlaefli.com/', 'https://johannesschlaefli.com/wp-content/uploads/2018/06/cv-web-1-2000x1200.jpg', NULL, NULL, NULL, 'Johannes Schlaefli official site', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 874 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://johannesschlaefli.com/wp-content/uploads/2018/06/cv-web-1-2000x1200.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://johannesschlaefli.com/wp-content/uploads/2018/06/cv-web-1-2000x1200.jpg');
-- artist 875 쿠어팔츠 실내관현악단 (wikimedia)
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Kurpf%C3%A4lzisches_Kammerorchester.jpg'
WHERE id = 875 AND english_name = 'Kurpfälzisches Kammerorchester' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Kurpf%C3%A4lzisches_Kammerorchester.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Kurpf%C3%A4lzisches_Kammerorchester.jpg', 'Graf Foto', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 875 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Kurpf%C3%A4lzisches_Kammerorchester.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Kurpf%C3%A4lzisches_Kammerorchester.jpg');
-- artist 876 앨런 와이스 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/nR79EeqgS_afRf8vdMwE3ycO6icUHMMy0itDQ1yvm8M/rs:fit/g:sm/q:90/h:455/w:327/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwMTE0/NzQtMTU5OTI5NjI0/MC04NTA3LnBuZw.jpeg'
WHERE id = 876 AND english_name = 'Alan Weiss' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/2011474', 'https://i.discogs.com/nR79EeqgS_afRf8vdMwE3ycO6icUHMMy0itDQ1yvm8M/rs:fit/g:sm/q:90/h:455/w:327/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwMTE0/NzQtMTU5OTI5NjI0/MC04NTA3LnBuZw.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 876 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/nR79EeqgS_afRf8vdMwE3ycO6icUHMMy0itDQ1yvm8M/rs:fit/g:sm/q:90/h:455/w:327/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwMTE0/NzQtMTU5OTI5NjI0/MC04NTA3LnBuZw.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/nR79EeqgS_afRf8vdMwE3ycO6icUHMMy0itDQ1yvm8M/rs:fit/g:sm/q:90/h:455/w:327/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTIwMTE0/NzQtMTU5OTI5NjI0/MC04NTA3LnBuZw.jpeg');
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
-- artist 879 앨프리드 월렌스타인 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/Fxr61IaKi_74STgtZcE3JIMpG7Jzf75Zdul6FbaWPVc/rs:fit/g:sm/q:90/h:600/w:466/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTk0Njk0/OC0xMjcwNzMxOTQz/LmpwZWc.jpeg'
WHERE id = 879 AND english_name = 'Alfred Wallenstein' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/946948-Alfred-Wallenstein', 'https://i.discogs.com/Fxr61IaKi_74STgtZcE3JIMpG7Jzf75Zdul6FbaWPVc/rs:fit/g:sm/q:90/h:600/w:466/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTk0Njk0/OC0xMjcwNzMxOTQz/LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 879 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/Fxr61IaKi_74STgtZcE3JIMpG7Jzf75Zdul6FbaWPVc/rs:fit/g:sm/q:90/h:600/w:466/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTk0Njk0/OC0xMjcwNzMxOTQz/LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/Fxr61IaKi_74STgtZcE3JIMpG7Jzf75Zdul6FbaWPVc/rs:fit/g:sm/q:90/h:600/w:466/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTk0Njk0/OC0xMjcwNzMxOTQz/LmpwZWc.jpeg');
-- artist 880 심포니 오브 디 에어 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/XVxZLGODb9VFASAsmcH4ihnVKY-GYIEIT7Tt70ptDxI/rs:fit/g:sm/q:90/h:450/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTExNTIy/NjYtMTU3NDkxNDA3/MS0xNTY3LmpwZWc.jpeg'
WHERE id = 880 AND english_name = 'Symphony of the Air' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/1152266-Symphony-Of-The-Air', 'https://i.discogs.com/XVxZLGODb9VFASAsmcH4ihnVKY-GYIEIT7Tt70ptDxI/rs:fit/g:sm/q:90/h:450/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTExNTIy/NjYtMTU3NDkxNDA3/MS0xNTY3LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 880 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/XVxZLGODb9VFASAsmcH4ihnVKY-GYIEIT7Tt70ptDxI/rs:fit/g:sm/q:90/h:450/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTExNTIy/NjYtMTU3NDkxNDA3/MS0xNTY3LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/XVxZLGODb9VFASAsmcH4ihnVKY-GYIEIT7Tt70ptDxI/rs:fit/g:sm/q:90/h:450/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTExNTIy/NjYtMTU3NDkxNDA3/MS0xNTY3LmpwZWc.jpeg');
-- artist 881 SWR 보컬앙상블 (Wikimedia Commons (Heinz Bunse))
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/SWR_Vokalensemble_Stuttgart_unter_Leitung_von_Marcus_Creed_%282017%29.jpg/960px-SWR_Vokalensemble_Stuttgart_unter_Leitung_von_Marcus_Creed_%282017%29.jpg'
WHERE id = 881 AND english_name = 'SWR Vokalensemble' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:SWR_Vokalensemble_Stuttgart_unter_Leitung_von_Marcus_Creed_(2017).jpg', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/SWR_Vokalensemble_Stuttgart_unter_Leitung_von_Marcus_Creed_%282017%29.jpg/960px-SWR_Vokalensemble_Stuttgart_unter_Leitung_von_Marcus_Creed_%282017%29.jpg', 'Heinz Bunse', 'CC BY-SA 2.0', 'https://creativecommons.org/licenses/by-sa/2.0', NULL, TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 881 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/SWR_Vokalensemble_Stuttgart_unter_Leitung_von_Marcus_Creed_%282017%29.jpg/960px-SWR_Vokalensemble_Stuttgart_unter_Leitung_von_Marcus_Creed_%282017%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/SWR_Vokalensemble_Stuttgart_unter_Leitung_von_Marcus_Creed_%282017%29.jpg/960px-SWR_Vokalensemble_Stuttgart_unter_Leitung_von_Marcus_Creed_%282017%29.jpg');
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
-- artist 884 아르칸젤로 (Discogs)
UPDATE artists SET image_url = 'https://i.discogs.com/IUA33Nh5zLUtPupAM_EOlp0eckKQgY2Lfkq-wBvjFNk/rs:fit/g:sm/q:90/h:434/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTI4Nzg4/OTUtMTM2MDk2NTQ1/My0yOTcxLmpwZWc.jpeg'
WHERE id = 884 AND english_name = 'Arcangelo' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/2878895-Arcangelo', 'https://i.discogs.com/IUA33Nh5zLUtPupAM_EOlp0eckKQgY2Lfkq-wBvjFNk/rs:fit/g:sm/q:90/h:434/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTI4Nzg4/OTUtMTM2MDk2NTQ1/My0yOTcxLmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 884 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://i.discogs.com/IUA33Nh5zLUtPupAM_EOlp0eckKQgY2Lfkq-wBvjFNk/rs:fit/g:sm/q:90/h:434/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTI4Nzg4/OTUtMTM2MDk2NTQ1/My0yOTcxLmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/IUA33Nh5zLUtPupAM_EOlp0eckKQgY2Lfkq-wBvjFNk/rs:fit/g:sm/q:90/h:434/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTI4Nzg4/OTUtMTM2MDk2NTQ1/My0yOTcxLmpwZWc.jpeg');
-- artist 885 리사 새퍼 (The Santa Fe Opera)
UPDATE artists SET image_url = 'https://images.santafeopera.org/uploads/2023/03/Lisa-Saffer-375x375-1.jpg'
WHERE id = 885 AND english_name = 'Lisa Saffer' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.santafeopera.org/bio/lisa-saffer', 'https://images.santafeopera.org/uploads/2023/03/Lisa-Saffer-375x375-1.jpg', NULL, NULL, NULL, 'The Santa Fe Opera', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 885 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://images.santafeopera.org/uploads/2023/03/Lisa-Saffer-375x375-1.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://images.santafeopera.org/uploads/2023/03/Lisa-Saffer-375x375-1.jpg');
-- artist 886 니컬러스 맥기건 (Apple Music)
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/df/ef/a3/dfefa358-8f17-1fd5-570b-c4986bcd6a19/mzl.lxyiejaj.jpg/600x600bb.jpg'
WHERE id = 886 AND english_name = 'Nicholas McGegan' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.apple.com/us/artist/13703228', 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/df/ef/a3/dfefa358-8f17-1fd5-570b-c4986bcd6a19/mzl.lxyiejaj.jpg/600x600bb.jpg', NULL, NULL, NULL, 'Apple Music', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 886 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/df/ef/a3/dfefa358-8f17-1fd5-570b-c4986bcd6a19/mzl.lxyiejaj.jpg/600x600bb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/df/ef/a3/dfefa358-8f17-1fd5-570b-c4986bcd6a19/mzl.lxyiejaj.jpg/600x600bb.jpg');
-- artist 887 필하모니아 바로크 오케스트라 (Boston Symphony Orchestra (photo Frank Wing))
UPDATE artists SET image_url = 'https://cdn.bso.org/uploads/Musician-Portraits/Guest-Artists/PBO_REOrchcFrankWing-07.jpg?fit=contain&gravity%5Bx%5D=0.4626&gravity%5By%5D=0.3962&height=1200&width=1200&s=EFHTo_yzuU7B6M09gqDlzHKSKxYVoU-TnIFzYbQN0Gs'
WHERE id = 887 AND english_name = 'Philharmonia Baroque Orchestra' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.bso.org/profiles/philharmonia-baroque', 'https://cdn.bso.org/uploads/Musician-Portraits/Guest-Artists/PBO_REOrchcFrankWing-07.jpg?fit=contain&gravity%5Bx%5D=0.4626&gravity%5By%5D=0.3962&height=1200&width=1200&s=EFHTo_yzuU7B6M09gqDlzHKSKxYVoU-TnIFzYbQN0Gs', NULL, NULL, NULL, 'Boston Symphony Orchestra (photo Frank Wing)', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 887 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://cdn.bso.org/uploads/Musician-Portraits/Guest-Artists/PBO_REOrchcFrankWing-07.jpg?fit=contain&gravity%5Bx%5D=0.4626&gravity%5By%5D=0.3962&height=1200&width=1200&s=EFHTo_yzuU7B6M09gqDlzHKSKxYVoU-TnIFzYbQN0Gs'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://cdn.bso.org/uploads/Musician-Portraits/Guest-Artists/PBO_REOrchcFrankWing-07.jpg?fit=contain&gravity%5Bx%5D=0.4626&gravity%5By%5D=0.3962&height=1200&width=1200&s=EFHTo_yzuU7B6M09gqDlzHKSKxYVoU-TnIFzYbQN0Gs');
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
-- artist 892 델핀 갈루 (Deezer)
UPDATE artists SET image_url = 'https://cdn-images.dzcdn.net/images/artist/5c9942c447b40128de521ffda3cdc884/1000x1000-000000-80-0-0.jpg'
WHERE id = 892 AND english_name = 'Delphine Galou' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.deezer.com/artist/4887080', 'https://cdn-images.dzcdn.net/images/artist/5c9942c447b40128de521ffda3cdc884/1000x1000-000000-80-0-0.jpg', NULL, NULL, NULL, 'Deezer', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 892 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://cdn-images.dzcdn.net/images/artist/5c9942c447b40128de521ffda3cdc884/1000x1000-000000-80-0-0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://cdn-images.dzcdn.net/images/artist/5c9942c447b40128de521ffda3cdc884/1000x1000-000000-80-0-0.jpg');
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
-- artist 896 WDR 방송 합창단 (WDR)
UPDATE artists SET image_url = 'https://www1.wdr.de/orchester-und-chor/rundfunkchor/wrc_totale110~_v-original.jpg'
WHERE id = 896 AND english_name = 'WDR Rundfunkchor' AND (image_url IS NULL OR image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www1.wdr.de/orchester-und-chor/rundfunkchor/chor/index.html', 'https://www1.wdr.de/orchester-und-chor/rundfunkchor/wrc_totale110~_v-original.jpg', NULL, NULL, NULL, 'WDR', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 896 AND entity.authority_entity_id IS NOT NULL AND entity.image_url = 'https://www1.wdr.de/orchester-und-chor/rundfunkchor/wrc_totale110~_v-original.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www1.wdr.de/orchester-und-chor/rundfunkchor/wrc_totale110~_v-original.jpg');
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
