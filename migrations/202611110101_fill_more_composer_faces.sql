-- 얼굴 그림이 없던 숨기지 않은 작곡가의 얼굴 그림(위키미디어·출판사·공식 사이트·뉴스 등).
-- 원본: seed_pipeline/curation/entity-images-2-2026-11-11/ (gen_sql.py 로 만든다).
-- 초상·커버가 둘 다 비었을 때만 채우고, 출처는 entity_images 'profile' 에 남긴다.
-- composer 103 김동진 (조선일보 · 일러스트 이철원)
UPDATE composers SET avatar_url = 'https://www.chosun.com/resizer/v2/GKW223KIMFUK7L2GDAHAMUA7JE.jpg?auth=924f2496548d11723b5770d83127c9666dae20e43aaa265cd7e88ee6bdd90bf9&width=700&height=483&smart=true', cover_image_url = 'https://www.chosun.com/resizer/v2/GKW223KIMFUK7L2GDAHAMUA7JE.jpg?auth=924f2496548d11723b5770d83127c9666dae20e43aaa265cd7e88ee6bdd90bf9&width=700&height=483&smart=true'
WHERE id = 103 AND english_name = 'Kim Dong-jin'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.chosun.com/site/data/html_dir/2018/06/29/2018062901701.html', 'https://www.chosun.com/resizer/v2/GKW223KIMFUK7L2GDAHAMUA7JE.jpg?auth=924f2496548d11723b5770d83127c9666dae20e43aaa265cd7e88ee6bdd90bf9&width=700&height=483&smart=true', NULL, NULL, NULL, '조선일보 · 일러스트 이철원', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 103 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.chosun.com/resizer/v2/GKW223KIMFUK7L2GDAHAMUA7JE.jpg?auth=924f2496548d11723b5770d83127c9666dae20e43aaa265cd7e88ee6bdd90bf9&width=700&height=483&smart=true'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.chosun.com/resizer/v2/GKW223KIMFUK7L2GDAHAMUA7JE.jpg?auth=924f2496548d11723b5770d83127c9666dae20e43aaa265cd7e88ee6bdd90bf9&width=700&height=483&smart=true');
-- composer 136 Albert Huybrechts (Spotify)
UPDATE composers SET avatar_url = 'https://i.scdn.co/image/ba26bfd6b66beb65390118459b3fe694cef3f501', cover_image_url = 'https://i.scdn.co/image/ba26bfd6b66beb65390118459b3fe694cef3f501'
WHERE id = 136 AND english_name = 'Albert Huybrechts'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/7ntJP33uOxd6M9K2roQBEY', 'https://i.scdn.co/image/ba26bfd6b66beb65390118459b3fe694cef3f501', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 136 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://i.scdn.co/image/ba26bfd6b66beb65390118459b3fe694cef3f501'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ba26bfd6b66beb65390118459b3fe694cef3f501');
-- composer 141 카타리누스 엘링 (Store norske leksikon · NTB)
UPDATE composers SET avatar_url = 'https://media.snl.no/media/30862/standard_compressed_catharinus-elling.jpg', cover_image_url = 'https://media.snl.no/media/30862/standard_compressed_catharinus-elling.jpg'
WHERE id = 141 AND english_name = 'Catharinus Elling'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://snl.no/Catharinus_Elling', 'https://media.snl.no/media/30862/standard_compressed_catharinus-elling.jpg', NULL, NULL, NULL, 'Store norske leksikon · NTB', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 141 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://media.snl.no/media/30862/standard_compressed_catharinus-elling.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://media.snl.no/media/30862/standard_compressed_catharinus-elling.jpg');
-- composer 142 Hubert Klyne Headley (Interlude (interlude.hk))
UPDATE composers SET avatar_url = 'https://interlude-cdn-blob-prod.azureedge.net/interlude-blob-storage-prod/2023/07/Hubert-Klyne-Headley-square.jpg', cover_image_url = 'https://interlude-cdn-blob-prod.azureedge.net/interlude-blob-storage-prod/2023/07/Hubert-Klyne-Headley-square.jpg'
WHERE id = 142 AND english_name = 'Hubert Klyne Headley'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://interlude.hk/golden-gate-the-humming-bridge/', 'https://interlude-cdn-blob-prod.azureedge.net/interlude-blob-storage-prod/2023/07/Hubert-Klyne-Headley-square.jpg', NULL, NULL, NULL, 'Interlude (interlude.hk)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 142 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://interlude-cdn-blob-prod.azureedge.net/interlude-blob-storage-prod/2023/07/Hubert-Klyne-Headley-square.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://interlude-cdn-blob-prod.azureedge.net/interlude-blob-storage-prod/2023/07/Hubert-Klyne-Headley-square.jpg');
-- composer 143 Vsevolod Zaderatsky (Melodiya (melody.su))
UPDATE composers SET avatar_url = 'https://melody.su/upload/iblock/791/791c5762d9f244b32e7bb9eef8e381d1.jpg', cover_image_url = 'https://melody.su/upload/iblock/791/791c5762d9f244b32e7bb9eef8e381d1.jpg'
WHERE id = 143 AND english_name = 'Vsevolod Zaderatsky'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://melody.su/en/artists/43544/', 'https://melody.su/upload/iblock/791/791c5762d9f244b32e7bb9eef8e381d1.jpg', NULL, NULL, NULL, 'Melodiya (melody.su)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 143 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://melody.su/upload/iblock/791/791c5762d9f244b32e7bb9eef8e381d1.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://melody.su/upload/iblock/791/791c5762d9f244b32e7bb9eef8e381d1.jpg');
-- composer 144 Anjelika Akbar (Izba Arts (interview with Anjelika Akbar))
UPDATE composers SET avatar_url = 'https://www.izbaarts.com/wp-content/uploads/2020/03/IMG_20200205_093319_655.jpg', cover_image_url = 'https://www.izbaarts.com/wp-content/uploads/2020/03/IMG_20200205_093319_655.jpg'
WHERE id = 144 AND english_name = 'Anjelika Akbar'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.izbaarts.com/anjelika-akbar-music-was-reflecting-hidden-and-unseen-things-beyond-my-real-life/', 'https://www.izbaarts.com/wp-content/uploads/2020/03/IMG_20200205_093319_655.jpg', NULL, NULL, NULL, 'Izba Arts (interview with Anjelika Akbar)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 144 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.izbaarts.com/wp-content/uploads/2020/03/IMG_20200205_093319_655.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.izbaarts.com/wp-content/uploads/2020/03/IMG_20200205_093319_655.jpg');
-- composer 158 Nancy Van de Vate (Spotify)
UPDATE composers SET avatar_url = 'https://i.scdn.co/image/452e3ca835181af3bc6f242f6e2e9182280510c0', cover_image_url = 'https://i.scdn.co/image/452e3ca835181af3bc6f242f6e2e9182280510c0'
WHERE id = 158 AND english_name = 'Nancy Van de Vate'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/1YDURx3zYNPnoVXUpbsyUh', 'https://i.scdn.co/image/452e3ca835181af3bc6f242f6e2e9182280510c0', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 158 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://i.scdn.co/image/452e3ca835181af3bc6f242f6e2e9182280510c0'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/452e3ca835181af3bc6f242f6e2e9182280510c0');
-- composer 160 André Souris (OPRL (Orchestre Philharmonique Royal de Liège))
UPDATE composers SET avatar_url = 'https://www.oprl.be/sites/default/files/styles/max_2600x2600/public/2018-08/Rameau%20Souris%20sans%20texte.jpg?itok=h8M3NpXk', cover_image_url = 'https://www.oprl.be/sites/default/files/styles/max_2600x2600/public/2018-08/Rameau%20Souris%20sans%20texte.jpg?itok=h8M3NpXk'
WHERE id = 160 AND english_name = 'André Souris'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.oprl.be/fr/actualites/oprl-live-la-video-de-la-semaine-en-ligne-49', 'https://www.oprl.be/sites/default/files/styles/max_2600x2600/public/2018-08/Rameau%20Souris%20sans%20texte.jpg?itok=h8M3NpXk', NULL, NULL, NULL, 'OPRL (Orchestre Philharmonique Royal de Liège)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 160 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.oprl.be/sites/default/files/styles/max_2600x2600/public/2018-08/Rameau%20Souris%20sans%20texte.jpg?itok=h8M3NpXk'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.oprl.be/sites/default/files/styles/max_2600x2600/public/2018-08/Rameau%20Souris%20sans%20texte.jpg?itok=h8M3NpXk');
-- composer 166 Pierre Wissmer (musicologie.org)
UPDATE composers SET avatar_url = 'https://www.musicologie.org/Biographies/w/i/wissmer_pierre.jpg', cover_image_url = 'https://www.musicologie.org/Biographies/w/i/wissmer_pierre.jpg'
WHERE id = 166 AND english_name = 'Pierre Wissmer'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.musicologie.org/Biographies/w/wissmer_pierre.html', 'https://www.musicologie.org/Biographies/w/i/wissmer_pierre.jpg', NULL, NULL, NULL, 'musicologie.org', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 166 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.musicologie.org/Biographies/w/i/wissmer_pierre.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.musicologie.org/Biographies/w/i/wissmer_pierre.jpg');
-- composer 177 William Sweeney (X @sweeney1_b)
UPDATE composers SET avatar_url = 'https://pbs.twimg.com/profile_images/511820485382778880/M1E7QPLu_400x400.jpeg', cover_image_url = 'https://pbs.twimg.com/profile_images/511820485382778880/M1E7QPLu_400x400.jpeg'
WHERE id = 177 AND english_name = 'William Sweeney'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://x.com/sweeney1_b', 'https://pbs.twimg.com/profile_images/511820485382778880/M1E7QPLu_400x400.jpeg', NULL, NULL, NULL, 'X @sweeney1_b', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 177 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://pbs.twimg.com/profile_images/511820485382778880/M1E7QPLu_400x400.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://pbs.twimg.com/profile_images/511820485382778880/M1E7QPLu_400x400.jpeg');
-- composer 179 도야마유조 (Wikipedia (ja) · NHK Symphony Orchestra, 1966)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/ja/a/a9/Conductor_Yuzo_Toyama_1966.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/ja/a/a9/Conductor_Yuzo_Toyama_1966.png'
WHERE id = 179 AND english_name = 'Yūzō Toyama'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://ja.wikipedia.org/wiki/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB:Conductor_Yuzo_Toyama_1966.png', 'https://upload.wikimedia.org/wikipedia/ja/a/a9/Conductor_Yuzo_Toyama_1966.png', NULL, NULL, NULL, 'Wikipedia (ja) · NHK Symphony Orchestra, 1966', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 179 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://upload.wikimedia.org/wikipedia/ja/a/a9/Conductor_Yuzo_Toyama_1966.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/ja/a/a9/Conductor_Yuzo_Toyama_1966.png');
-- composer 187 마르크앙드레 달바비 (Opéra national de Paris)
UPDATE composers SET avatar_url = 'https://res.cloudinary.com/opera-national-de-paris/image/upload/c_crop%2ch_681%2cw_1200%2cx_0%2cy_0/h_550/f_auto/v1/user_photos/kvf12fqoxzjbxalahsnn?_a=E', cover_image_url = 'https://res.cloudinary.com/opera-national-de-paris/image/upload/c_crop%2ch_681%2cw_1200%2cx_0%2cy_0/h_550/f_auto/v1/user_photos/kvf12fqoxzjbxalahsnn?_a=E'
WHERE id = 187 AND english_name = 'Marc-André Dalbavie'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.operadeparis.fr/artistes/marc-andre-dalbavie', 'https://res.cloudinary.com/opera-national-de-paris/image/upload/c_crop%2ch_681%2cw_1200%2cx_0%2cy_0/h_550/f_auto/v1/user_photos/kvf12fqoxzjbxalahsnn?_a=E', NULL, NULL, NULL, 'Opéra national de Paris', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 187 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://res.cloudinary.com/opera-national-de-paris/image/upload/c_crop%2ch_681%2cw_1200%2cx_0%2cy_0/h_550/f_auto/v1/user_photos/kvf12fqoxzjbxalahsnn?_a=E'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://res.cloudinary.com/opera-national-de-paris/image/upload/c_crop%2ch_681%2cw_1200%2cx_0%2cy_0/h_550/f_auto/v1/user_photos/kvf12fqoxzjbxalahsnn?_a=E');
-- composer 188 James Wilson (Contemporary Music Centre Ireland)
UPDATE composers SET avatar_url = 'https://www.cmc.ie/sites/default/files/styles/composer-large/public/composer_images/117.jpg?itok=4c-A7Mqa', cover_image_url = 'https://www.cmc.ie/sites/default/files/styles/composer-large/public/composer_images/117.jpg?itok=4c-A7Mqa'
WHERE id = 188 AND english_name = 'James Wilson'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.cmc.ie/composers/james-wilson', 'https://www.cmc.ie/sites/default/files/styles/composer-large/public/composer_images/117.jpg?itok=4c-A7Mqa', NULL, NULL, NULL, 'Contemporary Music Centre Ireland', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 188 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.cmc.ie/sites/default/files/styles/composer-large/public/composer_images/117.jpg?itok=4c-A7Mqa'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.cmc.ie/sites/default/files/styles/composer-large/public/composer_images/117.jpg?itok=4c-A7Mqa');
-- composer 189 Eduard Khagagortyan (Pianokafe)
UPDATE composers SET avatar_url = 'https://storage.yandexcloud.net/pianokafe-image-storage/iblock/ae9/OS04OTE1LmpwZWc.jpeg', cover_image_url = 'https://storage.yandexcloud.net/pianokafe-image-storage/iblock/ae9/OS04OTE1LmpwZWc.jpeg'
WHERE id = 189 AND english_name = 'Eduard Khagagortyan'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://pianokafe.com/artist/eduard-khagagortyan/about/', 'https://storage.yandexcloud.net/pianokafe-image-storage/iblock/ae9/OS04OTE1LmpwZWc.jpeg', NULL, NULL, NULL, 'Pianokafe', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 189 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://storage.yandexcloud.net/pianokafe-image-storage/iblock/ae9/OS04OTE1LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://storage.yandexcloud.net/pianokafe-image-storage/iblock/ae9/OS04OTE1LmpwZWc.jpeg');
-- composer 190 Jean Catoire (jeancatoire.com)
UPDATE composers SET avatar_url = 'https://www.jeancatoire.com/images/jean-catoire.jpg', cover_image_url = 'https://www.jeancatoire.com/images/jean-catoire.jpg'
WHERE id = 190 AND english_name = 'Jean Catoire'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.jeancatoire.com/', 'https://www.jeancatoire.com/images/jean-catoire.jpg', NULL, NULL, NULL, 'jeancatoire.com', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 190 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.jeancatoire.com/images/jean-catoire.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.jeancatoire.com/images/jean-catoire.jpg');
-- composer 193 Gardner Read (Sibley Music Library, Eastman School of Music (Gardner Read Collection))
UPDATE composers SET avatar_url = 'https://www.esm.rochester.edu/sibley/files/Read-Gardner_ESPA-5-9-8x10-1-710x901.jpg', cover_image_url = 'https://www.esm.rochester.edu/sibley/files/Read-Gardner_ESPA-5-9-8x10-1-710x901.jpg'
WHERE id = 193 AND english_name = 'Gardner Read'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.esm.rochester.edu/sibley/specialcollections/findingaids/gread/', 'https://www.esm.rochester.edu/sibley/files/Read-Gardner_ESPA-5-9-8x10-1-710x901.jpg', NULL, NULL, NULL, 'Sibley Music Library, Eastman School of Music (Gardner Read Collection)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 193 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.esm.rochester.edu/sibley/files/Read-Gardner_ESPA-5-9-8x10-1-710x901.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.esm.rochester.edu/sibley/files/Read-Gardner_ESPA-5-9-8x10-1-710x901.jpg');
-- composer 196 알랭 방카르 (RTBF)
UPDATE composers SET avatar_url = 'https://static-content.rtbf.be/article/image/1920x1080/b/b/7/ce2b9a26bddc32cba5af69372ee14c00-1643376390.jpg', cover_image_url = 'https://static-content.rtbf.be/article/image/1920x1080/b/b/7/ce2b9a26bddc32cba5af69372ee14c00-1643376390.jpg'
WHERE id = 196 AND english_name = 'Alain Bancquart'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.rtbf.be/article/le-compositeur-francais-alain-bancquart-nous-a-quittes-10923788', 'https://static-content.rtbf.be/article/image/1920x1080/b/b/7/ce2b9a26bddc32cba5af69372ee14c00-1643376390.jpg', NULL, NULL, NULL, 'RTBF', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 196 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://static-content.rtbf.be/article/image/1920x1080/b/b/7/ce2b9a26bddc32cba5af69372ee14c00-1643376390.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://static-content.rtbf.be/article/image/1920x1080/b/b/7/ce2b9a26bddc32cba5af69372ee14c00-1643376390.jpg');
-- composer 197 Gerard Victory (Contemporary Music Centre Ireland)
UPDATE composers SET avatar_url = 'https://www.cmc.ie/sites/default/files/media/000cc028-1500_0.webp', cover_image_url = 'https://www.cmc.ie/sites/default/files/media/000cc028-1500_0.webp'
WHERE id = 197 AND english_name = 'Gerard Victory'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.cmc.ie/features/centenary-gerard-victorys-birth', 'https://www.cmc.ie/sites/default/files/media/000cc028-1500_0.webp', NULL, NULL, NULL, 'Contemporary Music Centre Ireland', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 197 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.cmc.ie/sites/default/files/media/000cc028-1500_0.webp'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.cmc.ie/sites/default/files/media/000cc028-1500_0.webp');
-- composer 201 Édouard Batiste (Aeolus Music)
UPDATE composers SET avatar_url = 'https://aeolus-music.com/cdn/shop/files/Batiste-Edouard.jpg?v=1704410740&width=800', cover_image_url = 'https://aeolus-music.com/cdn/shop/files/Batiste-Edouard.jpg?v=1704410740&width=800'
WHERE id = 201 AND english_name = 'Édouard Batiste'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://aeolus-music.com/pages/page-batiste-edouard', 'https://aeolus-music.com/cdn/shop/files/Batiste-Edouard.jpg?v=1704410740&width=800', NULL, NULL, NULL, 'Aeolus Music', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 201 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://aeolus-music.com/cdn/shop/files/Batiste-Edouard.jpg?v=1704410740&width=800'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://aeolus-music.com/cdn/shop/files/Batiste-Edouard.jpg?v=1704410740&width=800');
-- composer 202 Thomas Pasatieri (barczablog)
UPDATE composers SET avatar_url = 'https://barczablog.com/wp-content/uploads/2024/06/tom-pasatieri.jpeg', cover_image_url = 'https://barczablog.com/wp-content/uploads/2024/06/tom-pasatieri.jpeg'
WHERE id = 202 AND english_name = 'Thomas Pasatieri'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://barczablog.com/tag/tom-pasatieri/', 'https://barczablog.com/wp-content/uploads/2024/06/tom-pasatieri.jpeg', NULL, NULL, NULL, 'barczablog', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 202 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://barczablog.com/wp-content/uploads/2024/06/tom-pasatieri.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://barczablog.com/wp-content/uploads/2024/06/tom-pasatieri.jpeg');
-- composer 211 Micha Hamel (Dutch National Opera & Ballet · Janita Sassen)
UPDATE composers SET avatar_url = 'https://www.operaballet.nl/sites/default/files/styles/twig_image_square_800_800/public/images/persons/janita%20sassen-Micha%20Hamel-6249def.jpg?itok=Tz0yrG6x', cover_image_url = 'https://www.operaballet.nl/sites/default/files/styles/twig_image_square_800_800/public/images/persons/janita%20sassen-Micha%20Hamel-6249def.jpg?itok=Tz0yrG6x'
WHERE id = 211 AND english_name = 'Micha Hamel'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.operaballet.nl/en/micha-hamel', 'https://www.operaballet.nl/sites/default/files/styles/twig_image_square_800_800/public/images/persons/janita%20sassen-Micha%20Hamel-6249def.jpg?itok=Tz0yrG6x', NULL, NULL, NULL, 'Dutch National Opera & Ballet · Janita Sassen', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 211 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.operaballet.nl/sites/default/files/styles/twig_image_square_800_800/public/images/persons/janita%20sassen-Micha%20Hamel-6249def.jpg?itok=Tz0yrG6x'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.operaballet.nl/sites/default/files/styles/twig_image_square_800_800/public/images/persons/janita%20sassen-Micha%20Hamel-6249def.jpg?itok=Tz0yrG6x');
-- composer 220 David Chesky (Spotify)
UPDATE composers SET avatar_url = 'https://i.scdn.co/image/ab6772690000c46ce227fd7e518840bd38e710e4', cover_image_url = 'https://i.scdn.co/image/ab6772690000c46ce227fd7e518840bd38e710e4'
WHERE id = 220 AND english_name = 'David Chesky'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/6HNDEix35Azf1emWWEfuNn', 'https://i.scdn.co/image/ab6772690000c46ce227fd7e518840bd38e710e4', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 220 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://i.scdn.co/image/ab6772690000c46ce227fd7e518840bd38e710e4'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6772690000c46ce227fd7e518840bd38e710e4');
-- composer 226 Claudio Ambrosini (Accademia Malibran)
UPDATE composers SET avatar_url = 'https://www.accademiamalibran.it/curricula_images/full/claudio-ambrosini_133.jpg', cover_image_url = 'https://www.accademiamalibran.it/curricula_images/full/claudio-ambrosini_133.jpg'
WHERE id = 226 AND english_name = 'Claudio Ambrosini'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.accademiamalibran.it/masterclasses/2018/CLAUDIO+AMBROSINI/composizione1', 'https://www.accademiamalibran.it/curricula_images/full/claudio-ambrosini_133.jpg', NULL, NULL, NULL, 'Accademia Malibran', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 226 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.accademiamalibran.it/curricula_images/full/claudio-ambrosini_133.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.accademiamalibran.it/curricula_images/full/claudio-ambrosini_133.jpg');
-- composer 231 Brice Pauset (Forum Opéra · Gilles Abegg / Opéra de Dijon)
UPDATE composers SET avatar_url = 'https://www.forumopera.com/wp-content/uploads/img_9435_brice_pauset_c_gilles_abegg_opera_de_dijon-1-1000x600.jpg', cover_image_url = 'https://www.forumopera.com/wp-content/uploads/img_9435_brice_pauset_c_gilles_abegg_opera_de_dijon-1-1000x600.jpg'
WHERE id = 231 AND english_name = 'Brice Pauset'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.forumopera.com/brice-pauset-pour-vous-preparer-a-mon-opera-ecoutez-monteverdi-et-schoenberg/', 'https://www.forumopera.com/wp-content/uploads/img_9435_brice_pauset_c_gilles_abegg_opera_de_dijon-1-1000x600.jpg', NULL, NULL, NULL, 'Forum Opéra · Gilles Abegg / Opéra de Dijon', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 231 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.forumopera.com/wp-content/uploads/img_9435_brice_pauset_c_gilles_abegg_opera_de_dijon-1-1000x600.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.forumopera.com/wp-content/uploads/img_9435_brice_pauset_c_gilles_abegg_opera_de_dijon-1-1000x600.jpg');
-- composer 232 Ulvi Cemal Erkin (Hacettepe Üniversitesi Ankara Devlet Konservatuvarı)
UPDATE composers SET avatar_url = 'https://fs.hacettepe.edu.tr/adk/resimler/mudurlerimiz/08%20Ulvi%20Cemal%20Erkin.png', cover_image_url = 'https://fs.hacettepe.edu.tr/adk/resimler/mudurlerimiz/08%20Ulvi%20Cemal%20Erkin.png'
WHERE id = 232 AND english_name = 'Ulvi Cemal Erkin'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://adk.hacettepe.edu.tr/tr/ulvi_cemal_erkin-671', 'https://fs.hacettepe.edu.tr/adk/resimler/mudurlerimiz/08%20Ulvi%20Cemal%20Erkin.png', NULL, NULL, NULL, 'Hacettepe Üniversitesi Ankara Devlet Konservatuvarı', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 232 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://fs.hacettepe.edu.tr/adk/resimler/mudurlerimiz/08%20Ulvi%20Cemal%20Erkin.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://fs.hacettepe.edu.tr/adk/resimler/mudurlerimiz/08%20Ulvi%20Cemal%20Erkin.png');
-- composer 237 Leon Stein (Milken Archive of Jewish Music)
UPDATE composers SET avatar_url = 'https://www.milkenarchive.org/assets/ProfileImages/Stein-Leon-536__ScaleMaxWidthWzUwMF0.jpg', cover_image_url = 'https://www.milkenarchive.org/assets/ProfileImages/Stein-Leon-536__ScaleMaxWidthWzUwMF0.jpg'
WHERE id = 237 AND english_name = 'Leon Stein'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.milkenarchive.org/artists/view/leon-stein', 'https://www.milkenarchive.org/assets/ProfileImages/Stein-Leon-536__ScaleMaxWidthWzUwMF0.jpg', NULL, NULL, NULL, 'Milken Archive of Jewish Music', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 237 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.milkenarchive.org/assets/ProfileImages/Stein-Leon-536__ScaleMaxWidthWzUwMF0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.milkenarchive.org/assets/ProfileImages/Stein-Leon-536__ScaleMaxWidthWzUwMF0.jpg');
-- composer 244 Vano Muradeli (История России в фотографиях (russiainphoto.ru))
UPDATE composers SET avatar_url = 'https://735606.selcdn.ru/thumbnails/photos/2017/02/10/rpd4fqsv2kscl4fk_1024.jpg', cover_image_url = 'https://735606.selcdn.ru/thumbnails/photos/2017/02/10/rpd4fqsv2kscl4fk_1024.jpg'
WHERE id = 244 AND english_name = 'Vano Muradeli'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://russiainphoto.ru/photos/132973/', 'https://735606.selcdn.ru/thumbnails/photos/2017/02/10/rpd4fqsv2kscl4fk_1024.jpg', NULL, NULL, NULL, 'История России в фотографиях (russiainphoto.ru)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 244 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://735606.selcdn.ru/thumbnails/photos/2017/02/10/rpd4fqsv2kscl4fk_1024.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://735606.selcdn.ru/thumbnails/photos/2017/02/10/rpd4fqsv2kscl4fk_1024.jpg');
-- composer 248 Denis Gougeon (National Arts Centre / Centre national des Arts (Canada))
UPDATE composers SET avatar_url = 'https://naccnaca-biographies.s3.amazonaws.com/32485/denis-gougeon_osm.jpg', cover_image_url = 'https://naccnaca-biographies.s3.amazonaws.com/32485/denis-gougeon_osm.jpg'
WHERE id = 248 AND english_name = 'Denis Gougeon'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://nac-cna.ca/fr/bio/denis-gougeon', 'https://naccnaca-biographies.s3.amazonaws.com/32485/denis-gougeon_osm.jpg', NULL, NULL, NULL, 'National Arts Centre / Centre national des Arts (Canada)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 248 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://naccnaca-biographies.s3.amazonaws.com/32485/denis-gougeon_osm.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://naccnaca-biographies.s3.amazonaws.com/32485/denis-gougeon_osm.jpg');
-- composer 250 Alois Piňos (Encyklopedie dějin města Brna)
UPDATE composers SET avatar_url = 'https://encyklopedie.brna.cz/data/images/0755/img37763.jpg', cover_image_url = 'https://encyklopedie.brna.cz/data/images/0755/img37763.jpg'
WHERE id = 250 AND english_name = 'Alois Piňos'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://encyklopedie.brna.cz/home-mmb/?acc=profil-osobnosti&load=13644', 'https://encyklopedie.brna.cz/data/images/0755/img37763.jpg', NULL, NULL, NULL, 'Encyklopedie dějin města Brna', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 250 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://encyklopedie.brna.cz/data/images/0755/img37763.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://encyklopedie.brna.cz/data/images/0755/img37763.jpg');
-- composer 251 Albert Guinovart i Mingacho (albertguinovart.com)
UPDATE composers SET avatar_url = 'https://static.wixstatic.com/media/e92d94_1194dd8703374b919ce1be84cb13deb3~mv2.jpg/v1/fill/w_800,h_800,fp_0.43_0.31,q_90/e92d94_1194dd8703374b919ce1be84cb13deb3~mv2.jpg', cover_image_url = 'https://static.wixstatic.com/media/e92d94_1194dd8703374b919ce1be84cb13deb3~mv2.jpg/v1/fill/w_800,h_800,fp_0.43_0.31,q_90/e92d94_1194dd8703374b919ce1be84cb13deb3~mv2.jpg'
WHERE id = 251 AND english_name = 'Albert Guinovart i Mingacho'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.albertguinovart.com/en/bio', 'https://static.wixstatic.com/media/e92d94_1194dd8703374b919ce1be84cb13deb3~mv2.jpg/v1/fill/w_800,h_800,fp_0.43_0.31,q_90/e92d94_1194dd8703374b919ce1be84cb13deb3~mv2.jpg', NULL, NULL, NULL, 'albertguinovart.com', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 251 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://static.wixstatic.com/media/e92d94_1194dd8703374b919ce1be84cb13deb3~mv2.jpg/v1/fill/w_800,h_800,fp_0.43_0.31,q_90/e92d94_1194dd8703374b919ce1be84cb13deb3~mv2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://static.wixstatic.com/media/e92d94_1194dd8703374b919ce1be84cb13deb3~mv2.jpg/v1/fill/w_800,h_800,fp_0.43_0.31,q_90/e92d94_1194dd8703374b919ce1be84cb13deb3~mv2.jpg');
-- composer 252 밀턴 배빗 (Spotify)
UPDATE composers SET avatar_url = 'https://i.scdn.co/image/92392ca25fe76f717e508101d1506c7ee5e7b016', cover_image_url = 'https://i.scdn.co/image/92392ca25fe76f717e508101d1506c7ee5e7b016'
WHERE id = 252 AND english_name = 'Milton Babbitt'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/1s4OwCgHh16FZOkmmNLWeO', 'https://i.scdn.co/image/92392ca25fe76f717e508101d1506c7ee5e7b016', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 252 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://i.scdn.co/image/92392ca25fe76f717e508101d1506c7ee5e7b016'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/92392ca25fe76f717e508101d1506c7ee5e7b016');
-- composer 253 Marcel Delannoy (Schubertiade Music & Arts (signed photograph))
UPDATE composers SET avatar_url = 'https://www.schubertiademusic.com/cdn/shop/files/Delannoy_Marcel_SP_15450.jpg?v=1722189003', cover_image_url = 'https://www.schubertiademusic.com/cdn/shop/files/Delannoy_Marcel_SP_15450.jpg?v=1722189003'
WHERE id = 253 AND english_name = 'Marcel Delannoy'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.schubertiademusic.com/products/15450-delannoy-marcel-signed-photograph', 'https://www.schubertiademusic.com/cdn/shop/files/Delannoy_Marcel_SP_15450.jpg?v=1722189003', NULL, NULL, NULL, 'Schubertiade Music & Arts (signed photograph)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 253 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.schubertiademusic.com/cdn/shop/files/Delannoy_Marcel_SP_15450.jpg?v=1722189003'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.schubertiademusic.com/cdn/shop/files/Delannoy_Marcel_SP_15450.jpg?v=1722189003');
-- composer 256 Ruth Watson Henderson (Canadian Chamber Choir)
UPDATE composers SET avatar_url = 'https://canadianchamberchoir.ca/welcome/wp-content/uploads/2019/07/Ruth-Watson-Henderson-600dpi-811x1024.jpg', cover_image_url = 'https://canadianchamberchoir.ca/welcome/wp-content/uploads/2019/07/Ruth-Watson-Henderson-600dpi-811x1024.jpg'
WHERE id = 256 AND english_name = 'Ruth Watson Henderson'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://canadianchamberchoir.ca/welcome/about-the-ccc/board-patrons/ruth-watson-henderson/', 'https://canadianchamberchoir.ca/welcome/wp-content/uploads/2019/07/Ruth-Watson-Henderson-600dpi-811x1024.jpg', NULL, NULL, NULL, 'Canadian Chamber Choir', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 256 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://canadianchamberchoir.ca/welcome/wp-content/uploads/2019/07/Ruth-Watson-Henderson-600dpi-811x1024.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://canadianchamberchoir.ca/welcome/wp-content/uploads/2019/07/Ruth-Watson-Henderson-600dpi-811x1024.jpg');
-- composer 267 Roberto Sierra (Cornell University Department of Music)
UPDATE composers SET avatar_url = 'https://music.cornell.edu/sites/default/files/2026-09/0872ba564cbb-roberto-sierra.jpg', cover_image_url = 'https://music.cornell.edu/sites/default/files/2026-09/0872ba564cbb-roberto-sierra.jpg'
WHERE id = 267 AND english_name = 'Roberto Sierra'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.cornell.edu/roberto-sierra', 'https://music.cornell.edu/sites/default/files/2026-09/0872ba564cbb-roberto-sierra.jpg', NULL, NULL, NULL, 'Cornell University Department of Music', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 267 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://music.cornell.edu/sites/default/files/2026-09/0872ba564cbb-roberto-sierra.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://music.cornell.edu/sites/default/files/2026-09/0872ba564cbb-roberto-sierra.jpg');
-- composer 269 Alice Shields (Columbia University Department of Music)
UPDATE composers SET avatar_url = 'https://music.columbia.edu/sites/music.columbia.edu/files/2023-09/Alice%20Shields.jpeg', cover_image_url = 'https://music.columbia.edu/sites/music.columbia.edu/files/2023-09/Alice%20Shields.jpeg'
WHERE id = 269 AND english_name = 'Alice Shields'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://music.columbia.edu/content/alice-shields', 'https://music.columbia.edu/sites/music.columbia.edu/files/2023-09/Alice%20Shields.jpeg', NULL, NULL, NULL, 'Columbia University Department of Music', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 269 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://music.columbia.edu/sites/music.columbia.edu/files/2023-09/Alice%20Shields.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://music.columbia.edu/sites/music.columbia.edu/files/2023-09/Alice%20Shields.jpeg');
-- composer 270 Pia Sebastiani (Fundación Beethoven (Buenos Aires))
UPDATE composers SET avatar_url = 'https://fundacionbeethoven.com.ar/wp-content/uploads/2019/11/sliderpia03.jpg', cover_image_url = 'https://fundacionbeethoven.com.ar/wp-content/uploads/2019/11/sliderpia03.jpg'
WHERE id = 270 AND english_name = 'Pia Sebastiani'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://fundacionbeethoven.com.ar/pia-sebastiani/', 'https://fundacionbeethoven.com.ar/wp-content/uploads/2019/11/sliderpia03.jpg', NULL, NULL, NULL, 'Fundación Beethoven (Buenos Aires)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 270 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://fundacionbeethoven.com.ar/wp-content/uploads/2019/11/sliderpia03.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://fundacionbeethoven.com.ar/wp-content/uploads/2019/11/sliderpia03.jpg');
-- composer 275 Antonio Bibalo (Wise Music Classical)
UPDATE composers SET avatar_url = 'https://s3.amazonaws.com/static.musicsalesclassical.com/images/composer/newsite/large/antonio%20bibalo.jpg', cover_image_url = 'https://s3.amazonaws.com/static.musicsalesclassical.com/images/composer/newsite/large/antonio%20bibalo.jpg'
WHERE id = 275 AND english_name = 'Antonio Bibalo'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.wisemusicclassical.com/composer/118/Antonio-Bibalo/', 'https://s3.amazonaws.com/static.musicsalesclassical.com/images/composer/newsite/large/antonio%20bibalo.jpg', NULL, NULL, NULL, 'Wise Music Classical', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 275 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://s3.amazonaws.com/static.musicsalesclassical.com/images/composer/newsite/large/antonio%20bibalo.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://s3.amazonaws.com/static.musicsalesclassical.com/images/composer/newsite/large/antonio%20bibalo.jpg');
-- composer 288 Dan Welcher (Reference Recordings)
UPDATE composers SET avatar_url = 'https://3.bp.blogspot.com/-PaDl5DHPDLY/VtXNzv8n5bI/AAAAAAAABak/RneRfwjcwOk/s1600/DW_ParkCity_Profile.jpg', cover_image_url = 'https://3.bp.blogspot.com/-PaDl5DHPDLY/VtXNzv8n5bI/AAAAAAAABak/RneRfwjcwOk/s1600/DW_ParkCity_Profile.jpg'
WHERE id = 288 AND english_name = 'Dan Welcher'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://referencerecordings.com/dan-welcher-discusses-spumante/', 'https://3.bp.blogspot.com/-PaDl5DHPDLY/VtXNzv8n5bI/AAAAAAAABak/RneRfwjcwOk/s1600/DW_ParkCity_Profile.jpg', NULL, NULL, NULL, 'Reference Recordings', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 288 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://3.bp.blogspot.com/-PaDl5DHPDLY/VtXNzv8n5bI/AAAAAAAABak/RneRfwjcwOk/s1600/DW_ParkCity_Profile.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://3.bp.blogspot.com/-PaDl5DHPDLY/VtXNzv8n5bI/AAAAAAAABak/RneRfwjcwOk/s1600/DW_ParkCity_Profile.jpg');
-- composer 289 오나카 메구미 (大中恩音楽記念館)
UPDATE composers SET avatar_url = 'https://ohnakamegumi.com/ohnakamegumi/wp-content/uploads/2025/11/about-img-05.png', cover_image_url = 'https://ohnakamegumi.com/ohnakamegumi/wp-content/uploads/2025/11/about-img-05.png'
WHERE id = 289 AND english_name = 'Megumi Ōnaka'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://ohnakamegumi.com/', 'https://ohnakamegumi.com/ohnakamegumi/wp-content/uploads/2025/11/about-img-05.png', NULL, NULL, NULL, '大中恩音楽記念館', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 289 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://ohnakamegumi.com/ohnakamegumi/wp-content/uploads/2025/11/about-img-05.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://ohnakamegumi.com/ohnakamegumi/wp-content/uploads/2025/11/about-img-05.png');
-- composer 295 Henry Brant (henrybrant.com · AP / Mike Eliason)
UPDATE composers SET avatar_url = 'https://i0.wp.com/henrybrant.com/wp-content/uploads/2015/05/Henry-Brant-after-Pulitzer-nomination.jpg?resize=631%2C920&ssl=1', cover_image_url = 'https://i0.wp.com/henrybrant.com/wp-content/uploads/2015/05/Henry-Brant-after-Pulitzer-nomination.jpg?resize=631%2C920&ssl=1'
WHERE id = 295 AND english_name = 'Henry Brant'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://henrybrant.com/', 'https://i0.wp.com/henrybrant.com/wp-content/uploads/2015/05/Henry-Brant-after-Pulitzer-nomination.jpg?resize=631%2C920&ssl=1', NULL, NULL, NULL, 'henrybrant.com · AP / Mike Eliason', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 295 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://i0.wp.com/henrybrant.com/wp-content/uploads/2015/05/Henry-Brant-after-Pulitzer-nomination.jpg?resize=631%2C920&ssl=1'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i0.wp.com/henrybrant.com/wp-content/uploads/2015/05/Henry-Brant-after-Pulitzer-nomination.jpg?resize=631%2C920&ssl=1');
-- composer 299 Franck Bedrossian (SoundCloud (Franck Bedrossian))
UPDATE composers SET avatar_url = 'https://i1.sndcdn.com/avatars-egz7gRRb126ns04R-bP5mRQ-t1080x1080.jpg', cover_image_url = 'https://i1.sndcdn.com/avatars-egz7gRRb126ns04R-bP5mRQ-t1080x1080.jpg'
WHERE id = 299 AND english_name = 'Franck Bedrossian'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://soundcloud.com/franck-bedrossian', 'https://i1.sndcdn.com/avatars-egz7gRRb126ns04R-bP5mRQ-t1080x1080.jpg', NULL, NULL, NULL, 'SoundCloud (Franck Bedrossian)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 299 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://i1.sndcdn.com/avatars-egz7gRRb126ns04R-bP5mRQ-t1080x1080.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i1.sndcdn.com/avatars-egz7gRRb126ns04R-bP5mRQ-t1080x1080.jpg');
-- composer 302 브뤼노 뒤콜 (Maison Messiaen)
UPDATE composers SET avatar_url = 'https://www.maisonmessiaen.com/wp-content/uploads/2022/10/bruno-ducol-500-500.jpg', cover_image_url = 'https://www.maisonmessiaen.com/wp-content/uploads/2022/10/bruno-ducol-500-500.jpg'
WHERE id = 302 AND english_name = 'Bruno Ducol'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.maisonmessiaen.com/residence/bruno-ducol/', 'https://www.maisonmessiaen.com/wp-content/uploads/2022/10/bruno-ducol-500-500.jpg', NULL, NULL, NULL, 'Maison Messiaen', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 302 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.maisonmessiaen.com/wp-content/uploads/2022/10/bruno-ducol-500-500.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.maisonmessiaen.com/wp-content/uploads/2022/10/bruno-ducol-500-500.jpg');
-- composer 313 Meinrad Schütter (meinrad-schuetter.ch)
UPDATE composers SET avatar_url = 'https://www.meinrad-schuetter.ch/images/meinrad_01_440x654.jpg', cover_image_url = 'https://www.meinrad-schuetter.ch/images/meinrad_01_440x654.jpg'
WHERE id = 313 AND english_name = 'Meinrad Schütter'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.meinrad-schuetter.ch/', 'https://www.meinrad-schuetter.ch/images/meinrad_01_440x654.jpg', NULL, NULL, NULL, 'meinrad-schuetter.ch', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 313 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.meinrad-schuetter.ch/images/meinrad_01_440x654.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.meinrad-schuetter.ch/images/meinrad_01_440x654.jpg');
-- composer 314 Makoto Shinohara (Yomiuri Shimbun)
UPDATE composers SET avatar_url = 'https://www.yomiuri.co.jp/media/2024/03/20240303-OYT1I50132-1.jpg?type=large', cover_image_url = 'https://www.yomiuri.co.jp/media/2024/03/20240303-OYT1I50132-1.jpg?type=large'
WHERE id = 314 AND english_name = 'Makoto Shinohara'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.yomiuri.co.jp/culture/music/20240303-OYT1T50109/', 'https://www.yomiuri.co.jp/media/2024/03/20240303-OYT1I50132-1.jpg?type=large', NULL, NULL, NULL, 'Yomiuri Shimbun', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 314 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.yomiuri.co.jp/media/2024/03/20240303-OYT1I50132-1.jpg?type=large'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.yomiuri.co.jp/media/2024/03/20240303-OYT1I50132-1.jpg?type=large');
-- composer 315 Nikolai Golovanov (История России в фотографиях (russiainphoto.ru))
UPDATE composers SET avatar_url = 'https://735606.selcdn.ru/thumbnails/photos/9/3/6/936d7a0fb094c90e_1024.jpg', cover_image_url = 'https://735606.selcdn.ru/thumbnails/photos/9/3/6/936d7a0fb094c90e_1024.jpg'
WHERE id = 315 AND english_name = 'Nikolai Golovanov'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://russiainphoto.ru/photos/74705/', 'https://735606.selcdn.ru/thumbnails/photos/9/3/6/936d7a0fb094c90e_1024.jpg', NULL, NULL, NULL, 'История России в фотографиях (russiainphoto.ru)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 315 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://735606.selcdn.ru/thumbnails/photos/9/3/6/936d7a0fb094c90e_1024.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://735606.selcdn.ru/thumbnails/photos/9/3/6/936d7a0fb094c90e_1024.jpg');
-- composer 318 Robert Turner (Winnipeg Free Press)
UPDATE composers SET avatar_url = 'https://www.winnipegfreepress.com/wp-content/uploads/sites/2/2022/04/3780779.jpg?w=1600', cover_image_url = 'https://www.winnipegfreepress.com/wp-content/uploads/sites/2/2022/04/3780779.jpg?w=1600'
WHERE id = 318 AND english_name = 'Robert Turner'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.winnipegfreepress.com/local/2012/01/28/music-professor-composed-more-than-70-works', 'https://www.winnipegfreepress.com/wp-content/uploads/sites/2/2022/04/3780779.jpg?w=1600', NULL, NULL, NULL, 'Winnipeg Free Press', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 318 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.winnipegfreepress.com/wp-content/uploads/sites/2/2022/04/3780779.jpg?w=1600'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.winnipegfreepress.com/wp-content/uploads/sites/2/2022/04/3780779.jpg?w=1600');
-- composer 319 Zdeněk Zahradník (zdenekzahradnik.cz)
UPDATE composers SET avatar_url = 'https://zdenekzahradnik.cz/downloads/00912144.jpeg', cover_image_url = 'https://zdenekzahradnik.cz/downloads/00912144.jpeg'
WHERE id = 319 AND english_name = 'Zdeněk Zahradník'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://zdenekzahradnik.cz/', 'https://zdenekzahradnik.cz/downloads/00912144.jpeg', NULL, NULL, NULL, 'zdenekzahradnik.cz', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 319 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://zdenekzahradnik.cz/downloads/00912144.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://zdenekzahradnik.cz/downloads/00912144.jpeg');
-- composer 327 José García Román (Real Academia de Bellas Artes de Granada)
UPDATE composers SET avatar_url = 'https://ra-bellasartesgranada.es/wp-content/uploads/2021/07/garcia_roman.jpg', cover_image_url = 'https://ra-bellasartesgranada.es/wp-content/uploads/2021/07/garcia_roman.jpg'
WHERE id = 327 AND english_name = 'José García Román'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://ra-bellasartesgranada.es/academicos/d-jose-garcia-roman/', 'https://ra-bellasartesgranada.es/wp-content/uploads/2021/07/garcia_roman.jpg', NULL, NULL, NULL, 'Real Academia de Bellas Artes de Granada', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 327 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://ra-bellasartesgranada.es/wp-content/uploads/2021/07/garcia_roman.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://ra-bellasartesgranada.es/wp-content/uploads/2021/07/garcia_roman.jpg');
-- composer 353 Peter Wishart (British Music Society)
UPDATE composers SET avatar_url = 'https://www.britishmusicsociety.co.uk/wp-content/uploads/2020/11/Peter-Wishart-copy-1024x795.png', cover_image_url = 'https://www.britishmusicsociety.co.uk/wp-content/uploads/2020/11/Peter-Wishart-copy-1024x795.png'
WHERE id = 353 AND english_name = 'Peter Wishart'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.britishmusicsociety.co.uk/2020/11/memories-of-peter-wishart/', 'https://www.britishmusicsociety.co.uk/wp-content/uploads/2020/11/Peter-Wishart-copy-1024x795.png', NULL, NULL, NULL, 'British Music Society', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 353 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.britishmusicsociety.co.uk/wp-content/uploads/2020/11/Peter-Wishart-copy-1024x795.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.britishmusicsociety.co.uk/wp-content/uploads/2020/11/Peter-Wishart-copy-1024x795.png');
-- composer 354 Robert Wykes (Washington University in St. Louis (The Source) · University Archives)
UPDATE composers SET avatar_url = 'https://source.washu.edu/app/uploads/2021/07/apf7-01641r.jpg', cover_image_url = 'https://source.washu.edu/app/uploads/2021/07/apf7-01641r.jpg'
WHERE id = 354 AND english_name = 'Robert Wykes'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://source.washu.edu/2021/07/obituary-robert-wykes-professor-emeritus-of-music-95/', 'https://source.washu.edu/app/uploads/2021/07/apf7-01641r.jpg', NULL, NULL, NULL, 'Washington University in St. Louis (The Source) · University Archives', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 354 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://source.washu.edu/app/uploads/2021/07/apf7-01641r.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://source.washu.edu/app/uploads/2021/07/apf7-01641r.jpg');
-- composer 358 Berthe di Vito-Delvaux (RTBF)
UPDATE composers SET avatar_url = 'https://static-content.rtbf.be/article/image/1920x1080/2/f/8/75ac2c91d93efba8651671f18ec013d0-1634202400.jpg', cover_image_url = 'https://static-content.rtbf.be/article/image/1920x1080/2/f/8/75ac2c91d93efba8651671f18ec013d0-1634202400.jpg'
WHERE id = 358 AND english_name = 'Berthe di Vito-Delvaux'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.rtbf.be/article/a-la-re-decouverte-de-berthe-di-vito-delvaux-compositrice-liegeoise-10860113', 'https://static-content.rtbf.be/article/image/1920x1080/2/f/8/75ac2c91d93efba8651671f18ec013d0-1634202400.jpg', NULL, NULL, NULL, 'RTBF', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 358 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://static-content.rtbf.be/article/image/1920x1080/2/f/8/75ac2c91d93efba8651671f18ec013d0-1634202400.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://static-content.rtbf.be/article/image/1920x1080/2/f/8/75ac2c91d93efba8651671f18ec013d0-1634202400.jpg');
-- composer 360 Sergio Rendine (ANSA)
UPDATE composers SET avatar_url = 'https://www.ansa.it/webimages/img_700/2023/4/21/601f00035928f9ee1fff88d4c7528055.jpg', cover_image_url = 'https://www.ansa.it/webimages/img_700/2023/4/21/601f00035928f9ee1fff88d4c7528055.jpg'
WHERE id = 360 AND english_name = 'Sergio Rendine'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.ansa.it/sito/notizie/cultura/musica/2023/04/21/morto-compositore-e-direttore-dorchestra-sergio-rendine_1b9e2b96-93e9-4416-a562-f49bc8cb7714.html', 'https://www.ansa.it/webimages/img_700/2023/4/21/601f00035928f9ee1fff88d4c7528055.jpg', NULL, NULL, NULL, 'ANSA', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 360 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.ansa.it/webimages/img_700/2023/4/21/601f00035928f9ee1fff88d4c7528055.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.ansa.it/webimages/img_700/2023/4/21/601f00035928f9ee1fff88d4c7528055.jpg');
-- composer 368 얼 와일드 (bruceduffie.com)
UPDATE composers SET avatar_url = 'https://www.bruceduffie.com/wilde.jpg', cover_image_url = 'https://www.bruceduffie.com/wilde.jpg'
WHERE id = 368 AND english_name = 'Earl Wild'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.bruceduffie.com/wild.html', 'https://www.bruceduffie.com/wilde.jpg', NULL, NULL, NULL, 'bruceduffie.com', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 368 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.bruceduffie.com/wilde.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.bruceduffie.com/wilde.jpg');
-- composer 369 Dieter Lehnhoff (Asociación de Academias de la Lengua Española (ASALE))
UPDATE composers SET avatar_url = 'https://www.asale.org/sites/default/files/styles/academico_retrato_grande/public/2021-11/12.%20Dieter%20Lehnhoff%20Teme.jpg?h=a82907fc&itok=JOTGwHGW', cover_image_url = 'https://www.asale.org/sites/default/files/styles/academico_retrato_grande/public/2021-11/12.%20Dieter%20Lehnhoff%20Teme.jpg?h=a82907fc&itok=JOTGwHGW'
WHERE id = 369 AND english_name = 'Dieter Lehnhoff'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.asale.org/academico/dieter-lehnhoff', 'https://www.asale.org/sites/default/files/styles/academico_retrato_grande/public/2021-11/12.%20Dieter%20Lehnhoff%20Teme.jpg?h=a82907fc&itok=JOTGwHGW', NULL, NULL, NULL, 'Asociación de Academias de la Lengua Española (ASALE)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 369 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.asale.org/sites/default/files/styles/academico_retrato_grande/public/2021-11/12.%20Dieter%20Lehnhoff%20Teme.jpg?h=a82907fc&itok=JOTGwHGW'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.asale.org/sites/default/files/styles/academico_retrato_grande/public/2021-11/12.%20Dieter%20Lehnhoff%20Teme.jpg?h=a82907fc&itok=JOTGwHGW');
-- composer 375 한스 첸더 (Breitkopf & Härtel)
UPDATE composers SET avatar_url = 'https://www.breitkopf.com/media/3a/39/54/1776856922/11104_Zender.jpg?ts=1776856922', cover_image_url = 'https://www.breitkopf.com/media/3a/39/54/1776856922/11104_Zender.jpg?ts=1776856922'
WHERE id = 375 AND english_name = 'Hans Zender'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.breitkopf.com/en/Hans-Zender', 'https://www.breitkopf.com/media/3a/39/54/1776856922/11104_Zender.jpg?ts=1776856922', NULL, NULL, NULL, 'Breitkopf & Härtel', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 375 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.breitkopf.com/media/3a/39/54/1776856922/11104_Zender.jpg?ts=1776856922'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.breitkopf.com/media/3a/39/54/1776856922/11104_Zender.jpg?ts=1776856922');
-- composer 385 Mark O'Connor (markoconnor.com)
UPDATE composers SET avatar_url = 'https://images.zoogletools.com/s:bzglfiles/u/168946/1772487cdb4a30198e6086c2fc130e79ad4897cf/original/mark-18.jpg/!!/meta%3AeyJzcmNCdWNrZXQiOiJiemdsZmlsZXMifQ%3D%3D.jpg', cover_image_url = 'https://images.zoogletools.com/s:bzglfiles/u/168946/1772487cdb4a30198e6086c2fc130e79ad4897cf/original/mark-18.jpg/!!/meta%3AeyJzcmNCdWNrZXQiOiJiemdsZmlsZXMifQ%3D%3D.jpg'
WHERE id = 385 AND english_name = 'Mark O''Connor'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.markoconnor.com/', 'https://images.zoogletools.com/s:bzglfiles/u/168946/1772487cdb4a30198e6086c2fc130e79ad4897cf/original/mark-18.jpg/!!/meta%3AeyJzcmNCdWNrZXQiOiJiemdsZmlsZXMifQ%3D%3D.jpg', NULL, NULL, NULL, 'markoconnor.com', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 385 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://images.zoogletools.com/s:bzglfiles/u/168946/1772487cdb4a30198e6086c2fc130e79ad4897cf/original/mark-18.jpg/!!/meta%3AeyJzcmNCdWNrZXQiOiJiemdsZmlsZXMifQ%3D%3D.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://images.zoogletools.com/s:bzglfiles/u/168946/1772487cdb4a30198e6086c2fc130e79ad4897cf/original/mark-18.jpg/!!/meta%3AeyJzcmNCdWNrZXQiOiJiemdsZmlsZXMifQ%3D%3D.jpg');
-- composer 387 Geoffrey Bush (Spotify)
UPDATE composers SET avatar_url = 'https://i.scdn.co/image/6161afd7585b4c374baa6697d19f8a279b6740eb', cover_image_url = 'https://i.scdn.co/image/6161afd7585b4c374baa6697d19f8a279b6740eb'
WHERE id = 387 AND english_name = 'Geoffrey Bush'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://open.spotify.com/artist/3aqOURvAJc2jGZILrOkDth', 'https://i.scdn.co/image/6161afd7585b4c374baa6697d19f8a279b6740eb', NULL, NULL, NULL, 'Spotify', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 387 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://i.scdn.co/image/6161afd7585b4c374baa6697d19f8a279b6740eb'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/6161afd7585b4c374baa6697d19f8a279b6740eb');
-- composer 388 Charles Sanford Skilton (Discogs)
UPDATE composers SET avatar_url = 'https://i.discogs.com/49b1sCXR-wyIhVLr5BxhTsQfN2j5Jv5sQnX5COBsniE/rs:fit/g:sm/q:90/h:600/w:479/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTMzNzIz/NjUtMTU1MjQ1Nzc0/OS03Njc3LmpwZWc.jpeg', cover_image_url = 'https://i.discogs.com/49b1sCXR-wyIhVLr5BxhTsQfN2j5Jv5sQnX5COBsniE/rs:fit/g:sm/q:90/h:600/w:479/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTMzNzIz/NjUtMTU1MjQ1Nzc0/OS03Njc3LmpwZWc.jpeg'
WHERE id = 388 AND english_name = 'Charles Sanford Skilton'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.discogs.com/artist/3372365-Charles-Skilton', 'https://i.discogs.com/49b1sCXR-wyIhVLr5BxhTsQfN2j5Jv5sQnX5COBsniE/rs:fit/g:sm/q:90/h:600/w:479/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTMzNzIz/NjUtMTU1MjQ1Nzc0/OS03Njc3LmpwZWc.jpeg', NULL, NULL, NULL, 'Discogs', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 388 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://i.discogs.com/49b1sCXR-wyIhVLr5BxhTsQfN2j5Jv5sQnX5COBsniE/rs:fit/g:sm/q:90/h:600/w:479/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTMzNzIz/NjUtMTU1MjQ1Nzc0/OS03Njc3LmpwZWc.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.discogs.com/49b1sCXR-wyIhVLr5BxhTsQfN2j5Jv5sQnX5COBsniE/rs:fit/g:sm/q:90/h:600/w:479/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTMzNzIz/NjUtMTU1MjQ1Nzc0/OS03Njc3LmpwZWc.jpeg');
-- composer 389 Pavel Chesnokov (Belcanto.ru)
UPDATE composers SET avatar_url = 'https://www.belcanto.ru/media/images/persons/chesnokov2025.jpeg', cover_image_url = 'https://www.belcanto.ru/media/images/persons/chesnokov2025.jpeg'
WHERE id = 389 AND english_name = 'Pavel Chesnokov'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.belcanto.ru/chesnokov.html', 'https://www.belcanto.ru/media/images/persons/chesnokov2025.jpeg', NULL, NULL, NULL, 'Belcanto.ru', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 389 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.belcanto.ru/media/images/persons/chesnokov2025.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.belcanto.ru/media/images/persons/chesnokov2025.jpeg');
-- composer 404 아서 버거 (APNM (Association for the Promotion of New Music))
UPDATE composers SET avatar_url = 'https://www.apnmmusic.org/site/assets/files/5283/arthur-berger.900x0.jpg', cover_image_url = 'https://www.apnmmusic.org/site/assets/files/5283/arthur-berger.900x0.jpg'
WHERE id = 404 AND english_name = 'Arthur Berger'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.apnmmusic.org/composers/arthur-berger/', 'https://www.apnmmusic.org/site/assets/files/5283/arthur-berger.900x0.jpg', NULL, NULL, NULL, 'APNM (Association for the Promotion of New Music)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 404 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.apnmmusic.org/site/assets/files/5283/arthur-berger.900x0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.apnmmusic.org/site/assets/files/5283/arthur-berger.900x0.jpg');
-- composer 405 Zoltán Jeney (Papageno · Felvégi Andrea)
UPDATE composers SET avatar_url = 'https://papageno.hu/wp-content/uploads/2018/02/large_407_JeneyZoltan_FelvegiAndrea-e1517572488510.jpg', cover_image_url = 'https://papageno.hu/wp-content/uploads/2018/02/large_407_JeneyZoltan_FelvegiAndrea-e1517572488510.jpg'
WHERE id = 405 AND english_name = 'Zoltán Jeney'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://papageno.hu/intermezzo/2019/10/elhunyt-jeney-zoltan-kossuth-dijas-zeneszerzo/', 'https://papageno.hu/wp-content/uploads/2018/02/large_407_JeneyZoltan_FelvegiAndrea-e1517572488510.jpg', NULL, NULL, NULL, 'Papageno · Felvégi Andrea', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 405 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://papageno.hu/wp-content/uploads/2018/02/large_407_JeneyZoltan_FelvegiAndrea-e1517572488510.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://papageno.hu/wp-content/uploads/2018/02/large_407_JeneyZoltan_FelvegiAndrea-e1517572488510.jpg');
-- composer 406 Murray Boren (National Opera Association)
UPDATE composers SET avatar_url = 'https://www.noa.org/uploads/SIO/Boren%2C%20Murray-min.jpg', cover_image_url = 'https://www.noa.org/uploads/SIO/Boren%2C%20Murray-min.jpg'
WHERE id = 406 AND english_name = 'Murray Boren'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.noa.org/2020/07/Composer-Spotlight-Murray-Boren-and-The-Church-of-Jesus-Christ-of-Latter-Day-Saints.html', 'https://www.noa.org/uploads/SIO/Boren%2C%20Murray-min.jpg', NULL, NULL, NULL, 'National Opera Association', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 406 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.noa.org/uploads/SIO/Boren%2C%20Murray-min.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.noa.org/uploads/SIO/Boren%2C%20Murray-min.jpg');
-- composer 408 Waldemar Kazanecki (sadyba24.pl)
UPDATE composers SET avatar_url = 'https://sadyba24.pl/media/k2/items/cache/02c6ee0b9d4025a26902d55e7d1ded60_XL.jpg', cover_image_url = 'https://sadyba24.pl/media/k2/items/cache/02c6ee0b9d4025a26902d55e7d1ded60_XL.jpg'
WHERE id = 408 AND english_name = 'Waldemar Kazanecki'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://sadyba24.pl/template-features/item/3509-jego-walc-otworzyl-drzwi-do-oscara-waldemar-kazanecki-geniusz-z-sadyby-ktorego-melodie-zna-kazdy-dzis-', 'https://sadyba24.pl/media/k2/items/cache/02c6ee0b9d4025a26902d55e7d1ded60_XL.jpg', NULL, NULL, NULL, 'sadyba24.pl', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 408 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://sadyba24.pl/media/k2/items/cache/02c6ee0b9d4025a26902d55e7d1ded60_XL.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://sadyba24.pl/media/k2/items/cache/02c6ee0b9d4025a26902d55e7d1ded60_XL.jpg');
-- composer 419 Terry Plumeri (No Treble)
UPDATE composers SET avatar_url = 'https://i0.wp.com/www.notreble.com/wp-content/uploads/2016/04/Terry-Plumeri-featured-600x400.jpg', cover_image_url = 'https://i0.wp.com/www.notreble.com/wp-content/uploads/2016/04/Terry-Plumeri-featured-600x400.jpg'
WHERE id = 419 AND english_name = 'Terry Plumeri'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.notreble.com/buzz/2016/04/08/in-memoriam-terry-plumeri/', 'https://i0.wp.com/www.notreble.com/wp-content/uploads/2016/04/Terry-Plumeri-featured-600x400.jpg', NULL, NULL, NULL, 'No Treble', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 419 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://i0.wp.com/www.notreble.com/wp-content/uploads/2016/04/Terry-Plumeri-featured-600x400.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i0.wp.com/www.notreble.com/wp-content/uploads/2016/04/Terry-Plumeri-featured-600x400.jpg');
-- composer 428 Mieko Shiomi (AWARE: Archives of Women Artists, Research and Exhibitions)
UPDATE composers SET avatar_url = 'https://awarewomenartists.com/wp-content/uploads/2024/12/portrait-mieko-shiomi-aware-women-artists-artistes-femmes-jpg.webp', cover_image_url = 'https://awarewomenartists.com/wp-content/uploads/2024/12/portrait-mieko-shiomi-aware-women-artists-artistes-femmes-jpg.webp'
WHERE id = 428 AND english_name = 'Mieko Shiomi'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://awarewomenartists.com/en/artists_japan/%E5%A1%A9%E8%A6%8B-%E5%85%81%E6%9E%9D%E5%AD%90/', 'https://awarewomenartists.com/wp-content/uploads/2024/12/portrait-mieko-shiomi-aware-women-artists-artistes-femmes-jpg.webp', NULL, NULL, NULL, 'AWARE: Archives of Women Artists, Research and Exhibitions', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 428 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://awarewomenartists.com/wp-content/uploads/2024/12/portrait-mieko-shiomi-aware-women-artists-artistes-femmes-jpg.webp'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://awarewomenartists.com/wp-content/uploads/2024/12/portrait-mieko-shiomi-aware-women-artists-artistes-femmes-jpg.webp');
-- composer 443 Anatol Vieru (Wikipedia (he))
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/he/a/a8/Anatol_Vieru%D7%95.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/he/a/a8/Anatol_Vieru%D7%95.jpg'
WHERE id = 443 AND english_name = 'Anatol Vieru'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://he.wikipedia.org/wiki/%D7%A7%D7%95%D7%91%D7%A5:Anatol_Vieru%D7%95.jpg', 'https://upload.wikimedia.org/wikipedia/he/a/a8/Anatol_Vieru%D7%95.jpg', NULL, NULL, NULL, 'Wikipedia (he)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 443 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://upload.wikimedia.org/wikipedia/he/a/a8/Anatol_Vieru%D7%95.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/he/a/a8/Anatol_Vieru%D7%95.jpg');
-- composer 454 David del Puerto (Música en Compostela · Elena Castro)
UPDATE composers SET avatar_url = 'https://www.musicaencompostela.es/wp-content/uploads/2018/03/david-del-puerto.jpg', cover_image_url = 'https://www.musicaencompostela.es/wp-content/uploads/2018/03/david-del-puerto.jpg'
WHERE id = 454 AND english_name = 'David del Puerto'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.musicaencompostela.es/en/profesores/david-del-puerto-en/', 'https://www.musicaencompostela.es/wp-content/uploads/2018/03/david-del-puerto.jpg', NULL, NULL, NULL, 'Música en Compostela · Elena Castro', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 454 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.musicaencompostela.es/wp-content/uploads/2018/03/david-del-puerto.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.musicaencompostela.es/wp-content/uploads/2018/03/david-del-puerto.jpg');
-- composer 464 Heinz Tiessen (Olympedia · Ries & Erler)
UPDATE composers SET avatar_url = 'https://olympedia-photos.s3.us-east-1.amazonaws.com/5005164.jpg', cover_image_url = 'https://olympedia-photos.s3.us-east-1.amazonaws.com/5005164.jpg'
WHERE id = 464 AND english_name = 'Heinz Tiessen'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.olympedia.org/athletes/5005164', 'https://olympedia-photos.s3.us-east-1.amazonaws.com/5005164.jpg', NULL, NULL, NULL, 'Olympedia · Ries & Erler', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 464 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://olympedia-photos.s3.us-east-1.amazonaws.com/5005164.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://olympedia-photos.s3.us-east-1.amazonaws.com/5005164.jpg');
-- composer 465 Philipp Maintz (Bärenreiter)
UPDATE composers SET avatar_url = 'https://emag.baerenreiter.com/wp-content/uploads/2024/05/Maintz2013_500px.webp', cover_image_url = 'https://emag.baerenreiter.com/wp-content/uploads/2024/05/Maintz2013_500px.webp'
WHERE id = 465 AND english_name = 'Philipp Maintz'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://emag.baerenreiter.com/en/maintz-philipp/', 'https://emag.baerenreiter.com/wp-content/uploads/2024/05/Maintz2013_500px.webp', NULL, NULL, NULL, 'Bärenreiter', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 465 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://emag.baerenreiter.com/wp-content/uploads/2024/05/Maintz2013_500px.webp'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://emag.baerenreiter.com/wp-content/uploads/2024/05/Maintz2013_500px.webp');
-- composer 470 Kentaro Sato (YouTube · Ken-Pの音楽学校)
UPDATE composers SET avatar_url = 'https://yt3.googleusercontent.com/ytc/AIdro_n0wO5ZCBGDKawo7an_MBh3Xbb7-thCvwXFA9v7mGBwSw=s900-c-k-c0x00ffffff-no-rj', cover_image_url = 'https://yt3.googleusercontent.com/ytc/AIdro_n0wO5ZCBGDKawo7an_MBh3Xbb7-thCvwXFA9v7mGBwSw=s900-c-k-c0x00ffffff-no-rj'
WHERE id = 470 AND english_name = 'Kentaro Sato'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.youtube.com/@KentaroSatoMusicSchool', 'https://yt3.googleusercontent.com/ytc/AIdro_n0wO5ZCBGDKawo7an_MBh3Xbb7-thCvwXFA9v7mGBwSw=s900-c-k-c0x00ffffff-no-rj', NULL, NULL, NULL, 'YouTube · Ken-Pの音楽学校', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 470 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://yt3.googleusercontent.com/ytc/AIdro_n0wO5ZCBGDKawo7an_MBh3Xbb7-thCvwXFA9v7mGBwSw=s900-c-k-c0x00ffffff-no-rj'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://yt3.googleusercontent.com/ytc/AIdro_n0wO5ZCBGDKawo7an_MBh3Xbb7-thCvwXFA9v7mGBwSw=s900-c-k-c0x00ffffff-no-rj');
-- composer 475 Jan Málek (Opera PLUS · Telefonotéka 2016 / Havlík)
UPDATE composers SET avatar_url = 'https://operaplus.cz/wp-content/uploads/2026/06/Jan-Malek-foto-Telefonoteka-2016-Havlik_page-0001-1536x1087.jpg', cover_image_url = 'https://operaplus.cz/wp-content/uploads/2026/06/Jan-Malek-foto-Telefonoteka-2016-Havlik_page-0001-1536x1087.jpg'
WHERE id = 475 AND english_name = 'Jan Málek'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://operaplus.cz/zemrel-skladatel-a-reziser-jan-malek/', 'https://operaplus.cz/wp-content/uploads/2026/06/Jan-Malek-foto-Telefonoteka-2016-Havlik_page-0001-1536x1087.jpg', NULL, NULL, NULL, 'Opera PLUS · Telefonotéka 2016 / Havlík', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 475 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://operaplus.cz/wp-content/uploads/2026/06/Jan-Malek-foto-Telefonoteka-2016-Havlik_page-0001-1536x1087.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://operaplus.cz/wp-content/uploads/2026/06/Jan-Malek-foto-Telefonoteka-2016-Havlik_page-0001-1536x1087.jpg');
-- composer 478 Carin Bartosch Edström (carinbartoschedstrom.com · Cato Lein)
UPDATE composers SET avatar_url = 'https://images.squarespace-cdn.com/content/v1/640d73d51ec3b90abc9c8708/57571a37-9c59-4992-bad7-13190c9c4b68/Carin-Bartosch-Edstrom-foto-cato-lein.jpg?format=1500w', cover_image_url = 'https://images.squarespace-cdn.com/content/v1/640d73d51ec3b90abc9c8708/57571a37-9c59-4992-bad7-13190c9c4b68/Carin-Bartosch-Edstrom-foto-cato-lein.jpg?format=1500w'
WHERE id = 478 AND english_name = 'Carin Bartosch Edström'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.carinbartoschedstrom.com/biografi', 'https://images.squarespace-cdn.com/content/v1/640d73d51ec3b90abc9c8708/57571a37-9c59-4992-bad7-13190c9c4b68/Carin-Bartosch-Edstrom-foto-cato-lein.jpg?format=1500w', NULL, NULL, NULL, 'carinbartoschedstrom.com · Cato Lein', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 478 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://images.squarespace-cdn.com/content/v1/640d73d51ec3b90abc9c8708/57571a37-9c59-4992-bad7-13190c9c4b68/Carin-Bartosch-Edstrom-foto-cato-lein.jpg?format=1500w'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://images.squarespace-cdn.com/content/v1/640d73d51ec3b90abc9c8708/57571a37-9c59-4992-bad7-13190c9c4b68/Carin-Bartosch-Edstrom-foto-cato-lein.jpg?format=1500w');
-- composer 481 Mark Bucci (MacDowell)
UPDATE composers SET avatar_url = 'https://www.macdowell.org/assets/artists/_700x700_crop_center-center_none/MarkBucci_ND_PD.jpg', cover_image_url = 'https://www.macdowell.org/assets/artists/_700x700_crop_center-center_none/MarkBucci_ND_PD.jpg'
WHERE id = 481 AND english_name = 'Mark Bucci'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.macdowell.org/artists/mark-bucci', 'https://www.macdowell.org/assets/artists/_700x700_crop_center-center_none/MarkBucci_ND_PD.jpg', NULL, NULL, NULL, 'MacDowell', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 481 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.macdowell.org/assets/artists/_700x700_crop_center-center_none/MarkBucci_ND_PD.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.macdowell.org/assets/artists/_700x700_crop_center-center_none/MarkBucci_ND_PD.jpg');
-- composer 483 Eric Gross (Celebrating Australian Music)
UPDATE composers SET avatar_url = 'https://celebratingaustralianmusic.com/wp-content/uploads/2023/02/Eric-Gross-e1677576307447.jpeg', cover_image_url = 'https://celebratingaustralianmusic.com/wp-content/uploads/2023/02/Eric-Gross-e1677576307447.jpeg'
WHERE id = 483 AND english_name = 'Eric Gross'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://celebratingaustralianmusic.com/portfolio-item/eric-gross/', 'https://celebratingaustralianmusic.com/wp-content/uploads/2023/02/Eric-Gross-e1677576307447.jpeg', NULL, NULL, NULL, 'Celebrating Australian Music', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 483 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://celebratingaustralianmusic.com/wp-content/uploads/2023/02/Eric-Gross-e1677576307447.jpeg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://celebratingaustralianmusic.com/wp-content/uploads/2023/02/Eric-Gross-e1677576307447.jpeg');
-- composer 486 Yoshiaki Onishi (Civitella Ranieri Foundation)
UPDATE composers SET avatar_url = 'https://civitella.org/wp-content/uploads/2018/08/b233db58_0704_449f_ab59_144c834c9466_onishi_30-875x1024.jpg', cover_image_url = 'https://civitella.org/wp-content/uploads/2018/08/b233db58_0704_449f_ab59_144c834c9466_onishi_30-875x1024.jpg'
WHERE id = 486 AND english_name = 'Yoshiaki Onishi'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://civitella.org/fellow/yoshiaki-onishi/', 'https://civitella.org/wp-content/uploads/2018/08/b233db58_0704_449f_ab59_144c834c9466_onishi_30-875x1024.jpg', NULL, NULL, NULL, 'Civitella Ranieri Foundation', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 486 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://civitella.org/wp-content/uploads/2018/08/b233db58_0704_449f_ab59_144c834c9466_onishi_30-875x1024.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://civitella.org/wp-content/uploads/2018/08/b233db58_0704_449f_ab59_144c834c9466_onishi_30-875x1024.jpg');
-- composer 491 Cornel Trăilescu (Opera Națională București)
UPDATE composers SET avatar_url = 'https://operanb.ro/wp-content/uploads/2019/01/cornel-trailescu.jpg', cover_image_url = 'https://operanb.ro/wp-content/uploads/2019/01/cornel-trailescu.jpg'
WHERE id = 491 AND english_name = 'Cornel Trăilescu'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://operanb.ro/in-memoriam-cornel-trailescu/', 'https://operanb.ro/wp-content/uploads/2019/01/cornel-trailescu.jpg', NULL, NULL, NULL, 'Opera Națională București', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 491 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://operanb.ro/wp-content/uploads/2019/01/cornel-trailescu.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://operanb.ro/wp-content/uploads/2019/01/cornel-trailescu.jpg');
-- composer 492 Rolf Riehm (Deutschlandfunk Kultur)
UPDATE composers SET avatar_url = 'https://bilder.deutschlandfunk.de/00/62/d2/ac/0062d2ac-e5b0-40cf-9b6d-b6a9e1e0365c/rolf-riehm-100-1920x1080.jpg', cover_image_url = 'https://bilder.deutschlandfunk.de/00/62/d2/ac/0062d2ac-e5b0-40cf-9b6d-b6a9e1e0365c/rolf-riehm-100-1920x1080.jpg'
WHERE id = 492 AND english_name = 'Rolf Riehm'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.deutschlandfunkkultur.de/der-komponist-rolf-riehm-ist-tot-100.html', 'https://bilder.deutschlandfunk.de/00/62/d2/ac/0062d2ac-e5b0-40cf-9b6d-b6a9e1e0365c/rolf-riehm-100-1920x1080.jpg', NULL, NULL, NULL, 'Deutschlandfunk Kultur', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 492 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://bilder.deutschlandfunk.de/00/62/d2/ac/0062d2ac-e5b0-40cf-9b6d-b6a9e1e0365c/rolf-riehm-100-1920x1080.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://bilder.deutschlandfunk.de/00/62/d2/ac/0062d2ac-e5b0-40cf-9b6d-b6a9e1e0365c/rolf-riehm-100-1920x1080.jpg');
-- composer 495 Eugen Lindner (Volksliederarchiv (Liederlexikon))
UPDATE composers SET avatar_url = 'https://www.volksliederarchiv.de/bilder/personen/lindner-eugen.jpg', cover_image_url = 'https://www.volksliederarchiv.de/bilder/personen/lindner-eugen.jpg'
WHERE id = 495 AND english_name = 'Eugen Lindner'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'profile', 'https://www.volksliederarchiv.de/lexikon/eugen-lindner/', 'https://www.volksliederarchiv.de/bilder/personen/lindner-eugen.jpg', NULL, NULL, NULL, 'Volksliederarchiv (Liederlexikon)', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 495 AND entity.authority_entity_id IS NOT NULL AND entity.avatar_url = 'https://www.volksliederarchiv.de/bilder/personen/lindner-eugen.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://www.volksliederarchiv.de/bilder/personen/lindner-eugen.jpg');
