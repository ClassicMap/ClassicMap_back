-- 얼굴 그림이 없던 숨기지 않은 작곡가의 초상(위키미디어 공용, 자유 라이선스).
-- 원본: seed_pipeline/curation/entity-images-2026-11-10/ (gen_sql.py 로 만든다).
-- 초상·커버가 둘 다 비었을 때만 채우고, 지은이·라이선스는 entity_images 'profile' 에 남긴다.
-- 시드가 남긴 Special:FilePath 행(REVIEW_REQUIRED)은 그대로 둔다.
-- composer 133 Ilse Fromm-Michaels (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/55/Fromm-Michaels_by_Anita_Ree.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/55/Fromm-Michaels_by_Anita_Ree.jpg'
WHERE id = 133 AND english_name = 'Ilse Fromm-Michaels'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Fromm-Michaels_by_Anita_Ree.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/55/Fromm-Michaels_by_Anita_Ree.jpg', 'Anita Rée', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 133 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/55/Fromm-Michaels_by_Anita_Ree.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/55/Fromm-Michaels_by_Anita_Ree.jpg');
-- composer 134 Eugeniusz Knapik (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Eugeniusz_Knapik.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Eugeniusz_Knapik.jpg'
WHERE id = 134 AND english_name = 'Eugeniusz Knapik'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Eugeniusz_Knapik.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Eugeniusz_Knapik.jpg', 'Adrian Tync', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 134 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Eugeniusz_Knapik.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Eugeniusz_Knapik.jpg');
-- composer 138 Joji Yuasa (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Joji_Yuasa_cropped_Joji_Yuasa_201411.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Joji_Yuasa_cropped_Joji_Yuasa_201411.jpg'
WHERE id = 138 AND english_name = 'Joji Yuasa'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Joji_Yuasa_cropped_Joji_Yuasa_201411.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Joji_Yuasa_cropped_Joji_Yuasa_201411.jpg', '大臣官房人事課', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 138 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Joji_Yuasa_cropped_Joji_Yuasa_201411.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Joji_Yuasa_cropped_Joji_Yuasa_201411.jpg');
-- composer 140 루이 에마뉘엘 자댕 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/95/Jadin-louis-emmanuel-2.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/95/Jadin-louis-emmanuel-2.jpg'
WHERE id = 140 AND english_name = 'Louis Emmanuel Jadin'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jadin-louis-emmanuel-2.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/95/Jadin-louis-emmanuel-2.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 140 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/95/Jadin-louis-emmanuel-2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/95/Jadin-louis-emmanuel-2.jpg');
-- composer 146 Clara Maïda (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/90/Clara_maida_1506456_faraway.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/90/Clara_maida_1506456_faraway.jpg'
WHERE id = 146 AND english_name = 'Clara Maïda'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Clara_maida_1506456_faraway.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/90/Clara_maida_1506456_faraway.jpg', 'G.Garitan', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 146 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/90/Clara_maida_1506456_faraway.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/90/Clara_maida_1506456_faraway.jpg');
-- composer 147 Eugeniusz Morawski-Da̜browa (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3c/Eugeniusz_Morawski.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3c/Eugeniusz_Morawski.jpg'
WHERE id = 147 AND english_name = 'Eugeniusz Morawski-Da̜browa'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Eugeniusz_Morawski.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/3c/Eugeniusz_Morawski.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 147 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3c/Eugeniusz_Morawski.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3c/Eugeniusz_Morawski.jpg');
-- composer 149 알렉산드르 다르고미시스키 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4d/Makovskiy_Dargomyzhsky.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4d/Makovskiy_Dargomyzhsky.jpg'
WHERE id = 149 AND english_name = 'Alexander Dargomyzhsky'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Makovskiy_Dargomyzhsky.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/4d/Makovskiy_Dargomyzhsky.jpg', 'Konstantin Makovsky', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 149 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4d/Makovskiy_Dargomyzhsky.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4d/Makovskiy_Dargomyzhsky.jpg');
-- composer 150 체사레 소데로 (commons-category)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Cesare_Sodero.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Cesare_Sodero.jpg'
WHERE id = 150 AND english_name = 'Cesare Sodero'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Cesare_Sodero.jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Cesare_Sodero.jpg', 'Thomas A. Edison, Inc.', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 150 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Cesare_Sodero.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Cesare_Sodero.jpg');
-- composer 153 Teizo Matsumura (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/27/Teizo_Matsumura.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/27/Teizo_Matsumura.jpg'
WHERE id = 153 AND english_name = 'Teizo Matsumura'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Teizo_Matsumura.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/27/Teizo_Matsumura.jpg', 'Taichiro Kosugi', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 153 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/27/Teizo_Matsumura.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/27/Teizo_Matsumura.jpg');
-- composer 155 Guillaume Connesson (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9c/G._Connesson.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9c/G._Connesson.jpg'
WHERE id = 155 AND english_name = 'Guillaume Connesson'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:G._Connesson.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/9c/G._Connesson.jpg', 'Benjamorris', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 155 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9c/G._Connesson.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9c/G._Connesson.jpg');
-- composer 159 Kazimierz Serocki (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/61/Kazimierz_Serocki_w_latach_60.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/61/Kazimierz_Serocki_w_latach_60.jpg'
WHERE id = 159 AND english_name = 'Kazimierz Serocki'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Kazimierz_Serocki_w_latach_60.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/61/Kazimierz_Serocki_w_latach_60.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 159 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/61/Kazimierz_Serocki_w_latach_60.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/61/Kazimierz_Serocki_w_latach_60.jpg');
-- composer 163 William Henry Fry (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/William_Henry_Fry.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/William_Henry_Fry.jpg'
WHERE id = 163 AND english_name = 'William Henry Fry'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:William_Henry_Fry.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/3f/William_Henry_Fry.jpg', 'Mathew Benjamin Brady', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 163 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/William_Henry_Fry.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/William_Henry_Fry.jpg');
-- composer 167 Yannis Papaioannou (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fe/%D0%AF%D0%BD%D0%BD%D1%96%D1%81_%D0%9F%D0%B0%D0%BF%D0%B0%D1%97%D0%BE%D0%B0%D0%BD%D0%BD%D1%83.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fe/%D0%AF%D0%BD%D0%BD%D1%96%D1%81_%D0%9F%D0%B0%D0%BF%D0%B0%D1%97%D0%BE%D0%B0%D0%BD%D0%BD%D1%83.jpg'
WHERE id = 167 AND english_name = 'Yannis Papaioannou'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:%D0%AF%D0%BD%D0%BD%D1%96%D1%81_%D0%9F%D0%B0%D0%BF%D0%B0%D1%97%D0%BE%D0%B0%D0%BD%D0%BD%D1%83.jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/fe/%D0%AF%D0%BD%D0%BD%D1%96%D1%81_%D0%9F%D0%B0%D0%BF%D0%B0%D1%97%D0%BE%D0%B0%D0%BD%D0%BD%D1%83.jpg', 'Хьюго', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 167 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fe/%D0%AF%D0%BD%D0%BD%D1%96%D1%81_%D0%9F%D0%B0%D0%BF%D0%B0%D1%97%D0%BE%D0%B0%D0%BD%D0%BD%D1%83.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fe/%D0%AF%D0%BD%D0%BD%D1%96%D1%81_%D0%9F%D0%B0%D0%BF%D0%B0%D1%97%D0%BE%D0%B0%D0%BD%D0%BD%D1%83.jpg');
-- composer 168 에밀 뒤랑 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/40/Emile_Durand_musicien.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/40/Emile_Durand_musicien.jpg'
WHERE id = 168 AND english_name = 'Émile Durand'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Emile_Durand_musicien.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/40/Emile_Durand_musicien.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 168 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/40/Emile_Durand_musicien.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/40/Emile_Durand_musicien.jpg');
-- composer 169 Hans von Koessler (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Koessler.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Koessler.jpg'
WHERE id = 169 AND english_name = 'Hans von Koessler'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Koessler.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Koessler.jpg', 'August Weger', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 169 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Koessler.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Koessler.jpg');
-- composer 170 Charlemagne Palestine (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/80/Charlemagne_Palestine_at_De_Appel_1_feb_2014.JPG', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/80/Charlemagne_Palestine_at_De_Appel_1_feb_2014.JPG'
WHERE id = 170 AND english_name = 'Charlemagne Palestine'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Charlemagne_Palestine_at_De_Appel_1_feb_2014.JPG', 'https://upload.wikimedia.org/wikipedia/commons/8/80/Charlemagne_Palestine_at_De_Appel_1_feb_2014.JPG', 'Sandra Fauconnier', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 170 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/80/Charlemagne_Palestine_at_De_Appel_1_feb_2014.JPG'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/80/Charlemagne_Palestine_at_De_Appel_1_feb_2014.JPG');
-- composer 172 블라디미르 코베킨 (commons-category)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5a/%D0%92%D0%BB%D0%B0%D0%B4%D0%B8%D0%BC%D0%B8%D1%80_%D0%9A%D0%BE%D0%B1%D0%B5%D0%BA%D0%B8%D0%BD_%D0%A4%D0%BE%D1%82%D0%BE%D0%B3%D1%80%D0%B0%D1%84_%D0%94%D0%BC%D0%B8%D1%82%D1%80%D0%B8%D0%B9_%D0%94%D1%83%D0%B1%D0%B8%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_2014_%28cropped%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5a/%D0%92%D0%BB%D0%B0%D0%B4%D0%B8%D0%BC%D0%B8%D1%80_%D0%9A%D0%BE%D0%B1%D0%B5%D0%BA%D0%B8%D0%BD_%D0%A4%D0%BE%D1%82%D0%BE%D0%B3%D1%80%D0%B0%D1%84_%D0%94%D0%BC%D0%B8%D1%82%D1%80%D0%B8%D0%B9_%D0%94%D1%83%D0%B1%D0%B8%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_2014_%28cropped%29.jpg'
WHERE id = 172 AND english_name = 'Vladimir Kobekin'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:%D0%92%D0%BB%D0%B0%D0%B4%D0%B8%D0%BC%D0%B8%D1%80_%D0%9A%D0%BE%D0%B1%D0%B5%D0%BA%D0%B8%D0%BD_%D0%A4%D0%BE%D1%82%D0%BE%D0%B3%D1%80%D0%B0%D1%84_%D0%94%D0%BC%D0%B8%D1%82%D1%80%D0%B8%D0%B9_%D0%94%D1%83%D0%B1%D0%B8%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_2014_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/5a/%D0%92%D0%BB%D0%B0%D0%B4%D0%B8%D0%BC%D0%B8%D1%80_%D0%9A%D0%BE%D0%B1%D0%B5%D0%BA%D0%B8%D0%BD_%D0%A4%D0%BE%D1%82%D0%BE%D0%B3%D1%80%D0%B0%D1%84_%D0%94%D0%BC%D0%B8%D1%82%D1%80%D0%B8%D0%B9_%D0%94%D1%83%D0%B1%D0%B8%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_2014_%28cropped%29.jpg', 'Дмитрий Дубинский', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 172 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5a/%D0%92%D0%BB%D0%B0%D0%B4%D0%B8%D0%BC%D0%B8%D1%80_%D0%9A%D0%BE%D0%B1%D0%B5%D0%BA%D0%B8%D0%BD_%D0%A4%D0%BE%D1%82%D0%BE%D0%B3%D1%80%D0%B0%D1%84_%D0%94%D0%BC%D0%B8%D1%82%D1%80%D0%B8%D0%B9_%D0%94%D1%83%D0%B1%D0%B8%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_2014_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5a/%D0%92%D0%BB%D0%B0%D0%B4%D0%B8%D0%BC%D0%B8%D1%80_%D0%9A%D0%BE%D0%B1%D0%B5%D0%BA%D0%B8%D0%BD_%D0%A4%D0%BE%D1%82%D0%BE%D0%B3%D1%80%D0%B0%D1%84_%D0%94%D0%BC%D0%B8%D1%82%D1%80%D0%B8%D0%B9_%D0%94%D1%83%D0%B1%D0%B8%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_2014_%28cropped%29.jpg');
-- composer 174 파블로 카살스 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cc/Pablocasals_%28cropped_3x4%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cc/Pablocasals_%28cropped_3x4%29.jpg'
WHERE id = 174 AND english_name = 'Pau Casals'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Pablocasals_(cropped_3x4).jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/cc/Pablocasals_%28cropped_3x4%29.jpg', 'Bain News Service', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 174 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cc/Pablocasals_%28cropped_3x4%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cc/Pablocasals_%28cropped_3x4%29.jpg');
-- composer 175 Heinrich Kaspar Schmid (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3a/Heinrich_Kaspar_Schmid_%281924%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3a/Heinrich_Kaspar_Schmid_%281924%29.jpg'
WHERE id = 175 AND english_name = 'Heinrich Kaspar Schmid'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Heinrich_Kaspar_Schmid_(1924).jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/3a/Heinrich_Kaspar_Schmid_%281924%29.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 175 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3a/Heinrich_Kaspar_Schmid_%281924%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3a/Heinrich_Kaspar_Schmid_%281924%29.jpg');
-- composer 176 Frank Van der Stucken (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/af/FrankVanderStucken.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/af/FrankVanderStucken.png'
WHERE id = 176 AND english_name = 'Frank Van der Stucken'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:FrankVanderStucken.png', 'https://upload.wikimedia.org/wikipedia/commons/a/af/FrankVanderStucken.png', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 176 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/af/FrankVanderStucken.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/af/FrankVanderStucken.png');
-- composer 178 Violet Archer (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Violet_Archer_at_the_piano.tif/lossy-page1-960px-Violet_Archer_at_the_piano.tif.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Violet_Archer_at_the_piano.tif/lossy-page1-960px-Violet_Archer_at_the_piano.tif.jpg'
WHERE id = 178 AND english_name = 'Violet Archer'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Violet_Archer_at_the_piano.tif', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Violet_Archer_at_the_piano.tif/lossy-page1-960px-Violet_Archer_at_the_piano.tif.jpg', 'Archer, Violet (1913-2000)', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 178 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Violet_Archer_at_the_piano.tif/lossy-page1-960px-Violet_Archer_at_the_piano.tif.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Violet_Archer_at_the_piano.tif/lossy-page1-960px-Violet_Archer_at_the_piano.tif.jpg');
-- composer 181 Ilkka Kuusisto (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c0/Ilkka_Kuusisto.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c0/Ilkka_Kuusisto.jpg'
WHERE id = 181 AND english_name = 'Ilkka Kuusisto'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Ilkka_Kuusisto.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/c0/Ilkka_Kuusisto.jpg', 'Soppakanuuna', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 181 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c0/Ilkka_Kuusisto.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c0/Ilkka_Kuusisto.jpg');
-- composer 186 브루노 마데르나 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/59/B_Maderna_1963.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/59/B_Maderna_1963.jpg'
WHERE id = 186 AND english_name = 'Bruno Maderna'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:B_Maderna_1963.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/59/B_Maderna_1963.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 186 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/59/B_Maderna_1963.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/59/B_Maderna_1963.jpg');
-- composer 191 조지 헨리 크럼 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/84/George_Crumb.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/84/George_Crumb.jpg'
WHERE id = 191 AND english_name = 'George Crumb'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:George_Crumb.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/84/George_Crumb.jpg', 'Peter Matthews from New York City, United States', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 191 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/84/George_Crumb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/84/George_Crumb.jpg');
-- composer 192 Paul Ladmirault (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1d/Paul_Ladmirault_lisant.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1d/Paul_Ladmirault_lisant.png'
WHERE id = 192 AND english_name = 'Paul Ladmirault'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Paul_Ladmirault_lisant.png', 'https://upload.wikimedia.org/wikipedia/commons/1/1d/Paul_Ladmirault_lisant.png', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 192 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1d/Paul_Ladmirault_lisant.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1d/Paul_Ladmirault_lisant.png');
-- composer 195 Joseph Quesnel (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f8/Schipper_Painting_of_Joseph_Quesnel.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f8/Schipper_Painting_of_Joseph_Quesnel.jpg'
WHERE id = 195 AND english_name = 'Joseph Quesnel'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Schipper_Painting_of_Joseph_Quesnel.jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f8/Schipper_Painting_of_Joseph_Quesnel.jpg', 'attributed to Gerritt Schipper.', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 195 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f8/Schipper_Painting_of_Joseph_Quesnel.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f8/Schipper_Painting_of_Joseph_Quesnel.jpg');
-- composer 198 Émile Pierre Ratez (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cf/%C3%89mile_Ratez.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cf/%C3%89mile_Ratez.jpg'
WHERE id = 198 AND english_name = 'Émile Pierre Ratez'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:%C3%89mile_Ratez.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/cf/%C3%89mile_Ratez.jpg', 'Fdelbrayelle', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 198 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cf/%C3%89mile_Ratez.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cf/%C3%89mile_Ratez.jpg');
-- composer 200 Éric Tanguy (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0c/%C3%89ric_Tanguy_2.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0c/%C3%89ric_Tanguy_2.jpg'
WHERE id = 200 AND english_name = 'Éric Tanguy'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:%C3%89ric_Tanguy_2.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/0c/%C3%89ric_Tanguy_2.jpg', 'Maldoror des Esseintes', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 200 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0c/%C3%89ric_Tanguy_2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0c/%C3%89ric_Tanguy_2.jpg');
-- composer 204 Leo Brouwer (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/48/FotoBrouwer2011Bianchini-1.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/48/FotoBrouwer2011Bianchini-1.jpg'
WHERE id = 204 AND english_name = 'Leo Brouwer'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:FotoBrouwer2011Bianchini-1.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/48/FotoBrouwer2011Bianchini-1.jpg', 'Gabriel Guerra Biancini', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 204 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/48/FotoBrouwer2011Bianchini-1.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/48/FotoBrouwer2011Bianchini-1.jpg');
-- composer 205 Lodewijk Mortelmans (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Lodewijk_Mortelmans_foto.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Lodewijk_Mortelmans_foto.jpg'
WHERE id = 205 AND english_name = 'Lodewijk Mortelmans'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Lodewijk_Mortelmans_foto.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Lodewijk_Mortelmans_foto.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 205 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Lodewijk_Mortelmans_foto.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Lodewijk_Mortelmans_foto.jpg');
-- composer 206 요한 요한손 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2a/J%C3%B3hann_J%C3%B3hannsson_by_Sachyn_Mital_%28cropped%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2a/J%C3%B3hann_J%C3%B3hannsson_by_Sachyn_Mital_%28cropped%29.jpg'
WHERE id = 206 AND english_name = 'Jóhann Jóhannsson'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:J%C3%B3hann_J%C3%B3hannsson_by_Sachyn_Mital_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/2a/J%C3%B3hann_J%C3%B3hannsson_by_Sachyn_Mital_%28cropped%29.jpg', 'Sachyn Mital', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 206 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2a/J%C3%B3hann_J%C3%B3hannsson_by_Sachyn_Mital_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2a/J%C3%B3hann_J%C3%B3hannsson_by_Sachyn_Mital_%28cropped%29.jpg');
-- composer 207 요제프 수크 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Josef_Suk%281%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Josef_Suk%281%29.jpg'
WHERE id = 207 AND english_name = 'Josef Suk'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Josef_Suk(1).jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Josef_Suk%281%29.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 207 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Josef_Suk%281%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Josef_Suk%281%29.jpg');
-- composer 208 Marcial del Adalid y Gurréa (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/Marcial-del-Adalid.tif/lossy-page1-960px-Marcial-del-Adalid.tif.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/Marcial-del-Adalid.tif/lossy-page1-960px-Marcial-del-Adalid.tif.jpg'
WHERE id = 208 AND english_name = 'Marcial del Adalid y Gurréa'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Marcial-del-Adalid.tif', 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/Marcial-del-Adalid.tif/lossy-page1-960px-Marcial-del-Adalid.tif.jpg', 'José Fernández Cuevas / Antonio Manchón Quílez', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 208 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/Marcial-del-Adalid.tif/lossy-page1-960px-Marcial-del-Adalid.tif.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/Marcial-del-Adalid.tif/lossy-page1-960px-Marcial-del-Adalid.tif.jpg');
-- composer 210 Henry Février (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/17/Henri_F%C3%A9vrier.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/17/Henri_F%C3%A9vrier.jpg'
WHERE id = 210 AND english_name = 'Henry Février'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Henri_F%C3%A9vrier.jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/17/Henri_F%C3%A9vrier.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 210 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/17/Henri_F%C3%A9vrier.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/17/Henri_F%C3%A9vrier.jpg');
-- composer 212 Amélie-Julie Candeille (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/be/Julie_Candeille_by_Romany.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/be/Julie_Candeille_by_Romany.png'
WHERE id = 212 AND english_name = 'Amélie-Julie Candeille'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Julie_Candeille_by_Romany.png', 'https://upload.wikimedia.org/wikipedia/commons/b/be/Julie_Candeille_by_Romany.png', 'Adèle Romany', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 212 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/be/Julie_Candeille_by_Romany.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/be/Julie_Candeille_by_Romany.png');
-- composer 214 Jerzy Fitelberg (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/68/Fitelberg_Jerzi.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/68/Fitelberg_Jerzi.png'
WHERE id = 214 AND english_name = 'Jerzy Fitelberg'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Fitelberg_Jerzi.png', 'https://upload.wikimedia.org/wikipedia/commons/6/68/Fitelberg_Jerzi.png', 'Fpveronique', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 214 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/68/Fitelberg_Jerzi.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/68/Fitelberg_Jerzi.png');
-- composer 216 프랑코 페레라 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9c/Franco_Ferrara_%281984%29%2C_Bestanddeelnr_933-0956.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9c/Franco_Ferrara_%281984%29%2C_Bestanddeelnr_933-0956.jpg'
WHERE id = 216 AND english_name = 'Franco Ferrara'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Franco_Ferrara_(1984),_Bestanddeelnr_933-0956.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/9c/Franco_Ferrara_%281984%29%2C_Bestanddeelnr_933-0956.jpg', 'Rob Croes for Anefo', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 216 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9c/Franco_Ferrara_%281984%29%2C_Bestanddeelnr_933-0956.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9c/Franco_Ferrara_%281984%29%2C_Bestanddeelnr_933-0956.jpg');
-- composer 217 Heikki Suolahti (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4a/Heikki_Suolahti.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4a/Heikki_Suolahti.jpg'
WHERE id = 217 AND english_name = 'Heikki Suolahti'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Heikki_Suolahti.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/4a/Heikki_Suolahti.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 217 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4a/Heikki_Suolahti.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4a/Heikki_Suolahti.jpg');
-- composer 221 빅토르 코센코 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/39/Viktor_Stepanovych_Kosenko.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/39/Viktor_Stepanovych_Kosenko.png'
WHERE id = 221 AND english_name = 'Viktor Kosenko'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Viktor_Stepanovych_Kosenko.png', 'https://upload.wikimedia.org/wikipedia/commons/3/39/Viktor_Stepanovych_Kosenko.png', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 221 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/39/Viktor_Stepanovych_Kosenko.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/39/Viktor_Stepanovych_Kosenko.png');
-- composer 222 Henri Miro (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/10/Henri_Miro.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/10/Henri_Miro.jpg'
WHERE id = 222 AND english_name = 'Henri Miro'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Henri_Miro.jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/10/Henri_Miro.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 222 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/10/Henri_Miro.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/10/Henri_Miro.jpg');
-- composer 223 Ernest Pingoud (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b8/Ernest_Pingoud.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b8/Ernest_Pingoud.jpg'
WHERE id = 223 AND english_name = 'Ernest Pingoud'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Ernest_Pingoud.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/b8/Ernest_Pingoud.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 223 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b8/Ernest_Pingoud.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b8/Ernest_Pingoud.jpg');
-- composer 224 Felipe Boero (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/19/Felipe_Boero.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/19/Felipe_Boero.png'
WHERE id = 224 AND english_name = 'Felipe Boero'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Felipe_Boero.png', 'https://upload.wikimedia.org/wikipedia/commons/1/19/Felipe_Boero.png', 'Revista argentina PBT. 27 de febrero de 1918.', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 224 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/19/Felipe_Boero.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/19/Felipe_Boero.png');
-- composer 225 Salvatore Sciarrino (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/19/SalvatoreSciarrino_%28cropped%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/19/SalvatoreSciarrino_%28cropped%29.jpg'
WHERE id = 225 AND english_name = 'Salvatore Sciarrino'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:SalvatoreSciarrino_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/19/SalvatoreSciarrino_%28cropped%29.jpg', 'Pitichinaccio', 'CC BY 2.5', 'https://creativecommons.org/licenses/by/2.5', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 225 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/19/SalvatoreSciarrino_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/19/SalvatoreSciarrino_%28cropped%29.jpg');
-- composer 227 반브리 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Johannes_Bernardus_van_Bree_%281801%E2%80%931857%29%2C_objectnr_A_11408.tif/lossy-page1-960px-Johannes_Bernardus_van_Bree_%281801%E2%80%931857%29%2C_objectnr_A_11408.tif.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Johannes_Bernardus_van_Bree_%281801%E2%80%931857%29%2C_objectnr_A_11408.tif/lossy-page1-960px-Johannes_Bernardus_van_Bree_%281801%E2%80%931857%29%2C_objectnr_A_11408.tif.jpg'
WHERE id = 227 AND english_name = 'Johannes Bernardus van Bree'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Johannes_Bernardus_van_Bree_(1801%E2%80%931857),_objectnr_A_11408.tif', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Johannes_Bernardus_van_Bree_%281801%E2%80%931857%29%2C_objectnr_A_11408.tif/lossy-page1-960px-Johannes_Bernardus_van_Bree_%281801%E2%80%931857%29%2C_objectnr_A_11408.tif.jpg', 'Amsterdam Museum', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 227 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Johannes_Bernardus_van_Bree_%281801%E2%80%931857%29%2C_objectnr_A_11408.tif/lossy-page1-960px-Johannes_Bernardus_van_Bree_%281801%E2%80%931857%29%2C_objectnr_A_11408.tif.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Johannes_Bernardus_van_Bree_%281801%E2%80%931857%29%2C_objectnr_A_11408.tif/lossy-page1-960px-Johannes_Bernardus_van_Bree_%281801%E2%80%931857%29%2C_objectnr_A_11408.tif.jpg');
-- composer 229 헨리 카웰 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/30/Henry_Cowell_portrait_NYPL_4002097_%28cropped%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/30/Henry_Cowell_portrait_NYPL_4002097_%28cropped%29.jpg'
WHERE id = 229 AND english_name = 'Henry Cowell'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Henry_Cowell_portrait_NYPL_4002097_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/30/Henry_Cowell_portrait_NYPL_4002097_%28cropped%29.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 229 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/30/Henry_Cowell_portrait_NYPL_4002097_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/30/Henry_Cowell_portrait_NYPL_4002097_%28cropped%29.jpg');
-- composer 230 Cemal Reşit Rey (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/50/1950_05_03_Aksam_Cemal_Resit_Rey.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/50/1950_05_03_Aksam_Cemal_Resit_Rey.jpg'
WHERE id = 230 AND english_name = 'Cemal Reşit Rey'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:1950_05_03_Aksam_Cemal_Resit_Rey.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/50/1950_05_03_Aksam_Cemal_Resit_Rey.jpg', 'Akşam Gazetesi', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 230 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/50/1950_05_03_Aksam_Cemal_Resit_Rey.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/50/1950_05_03_Aksam_Cemal_Resit_Rey.jpg');
-- composer 235 Tania León (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Tania_Leon_%28Tania_Le%C3%B3n%29_-_Honorees_at_the_2022_Kennedy_Center_Honors_Dinner_%2852542377419%29_%28cropped%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Tania_Leon_%28Tania_Le%C3%B3n%29_-_Honorees_at_the_2022_Kennedy_Center_Honors_Dinner_%2852542377419%29_%28cropped%29.jpg'
WHERE id = 235 AND english_name = 'Tania León'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Tania_Leon_(Tania_Le%C3%B3n)_-_Honorees_at_the_2022_Kennedy_Center_Honors_Dinner_(52542377419)_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Tania_Leon_%28Tania_Le%C3%B3n%29_-_Honorees_at_the_2022_Kennedy_Center_Honors_Dinner_%2852542377419%29_%28cropped%29.jpg', 'U.S. Department of State from United States', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 235 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Tania_Leon_%28Tania_Le%C3%B3n%29_-_Honorees_at_the_2022_Kennedy_Center_Honors_Dinner_%2852542377419%29_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Tania_Leon_%28Tania_Le%C3%B3n%29_-_Honorees_at_the_2022_Kennedy_Center_Honors_Dinner_%2852542377419%29_%28cropped%29.jpg');
-- composer 238 Gustave Charpentier (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8f/Gustave_Charpentier_LOC.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8f/Gustave_Charpentier_LOC.jpg'
WHERE id = 238 AND english_name = 'Gustave Charpentier'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Gustave_Charpentier_LOC.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/8f/Gustave_Charpentier_LOC.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 238 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8f/Gustave_Charpentier_LOC.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8f/Gustave_Charpentier_LOC.jpg');
-- composer 239 페르난도 소르 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d3/Fernando_Sor_%281778-1839%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d3/Fernando_Sor_%281778-1839%29.jpg'
WHERE id = 239 AND english_name = 'Fernando Sor'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Fernando_Sor_(1778-1839).jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d3/Fernando_Sor_%281778-1839%29.jpg', 'Own work', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 239 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d3/Fernando_Sor_%281778-1839%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d3/Fernando_Sor_%281778-1839%29.jpg');
-- composer 241 Kevin Volans (commons-category)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/77/KevinVolans.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/77/KevinVolans.jpg'
WHERE id = 241 AND english_name = 'Kevin Volans'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:KevinVolans.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/77/KevinVolans.jpg', NULL, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 241 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/77/KevinVolans.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/77/KevinVolans.jpg');
-- composer 242 Richard Meale (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/90/Meale_at_piano_1972.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/90/Meale_at_piano_1972.jpg'
WHERE id = 242 AND english_name = 'Richard Meale'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Meale_at_piano_1972.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/90/Meale_at_piano_1972.jpg', 'Australian Overseas Information Service', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 242 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/90/Meale_at_piano_1972.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/90/Meale_at_piano_1972.jpg');
-- composer 243 Manuel Rosenthal (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/31/ROSENTHAL_1920.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/31/ROSENTHAL_1920.jpg'
WHERE id = 243 AND english_name = 'Manuel Rosenthal'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:ROSENTHAL_1920.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/31/ROSENTHAL_1920.jpg', NULL, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 243 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/31/ROSENTHAL_1920.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/31/ROSENTHAL_1920.jpg');
-- composer 245 펠릭스 블루멘펠트 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/52/Feliks_Blumenfeld.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/52/Feliks_Blumenfeld.jpg'
WHERE id = 245 AND english_name = 'Felix Mikhailovich Blumenfeld'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Feliks_Blumenfeld.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/52/Feliks_Blumenfeld.jpg', 'The original uploader was Ivan Velikii at English Wikipedia.', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 245 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/52/Feliks_Blumenfeld.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/52/Feliks_Blumenfeld.jpg');
-- composer 246 Tyondai Braxton (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6e/Tyondai_Braxton_E5100788.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6e/Tyondai_Braxton_E5100788.jpg'
WHERE id = 246 AND english_name = 'Tyondai Braxton'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Tyondai_Braxton_E5100788.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/6e/Tyondai_Braxton_E5100788.jpg', 'Nomo michael hoefner http://www.zwo5.de', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 246 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6e/Tyondai_Braxton_E5100788.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6e/Tyondai_Braxton_E5100788.jpg');
-- composer 249 Jan Blockx (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f9/Jan_Blockx%2C_PA00462.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f9/Jan_Blockx%2C_PA00462.jpg'
WHERE id = 249 AND english_name = 'Jan Blockx'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jan_Blockx,_PA00462.jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f9/Jan_Blockx%2C_PA00462.jpg', 'Blockx, Jan (1851-1912) (depicted)', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 249 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f9/Jan_Blockx%2C_PA00462.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f9/Jan_Blockx%2C_PA00462.jpg');
-- composer 255 Martin O'Donnell (wikipedia-pageimage)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/82/Marty_O%27Donnell_by_Gage_Skidmore.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/82/Marty_O%27Donnell_by_Gage_Skidmore.jpg'
WHERE id = 255 AND english_name = 'Martin O''Donnell'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Marty_O%27Donnell_by_Gage_Skidmore.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/82/Marty_O%27Donnell_by_Gage_Skidmore.jpg', 'Gage Skidmore', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 255 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/82/Marty_O%27Donnell_by_Gage_Skidmore.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/82/Marty_O%27Donnell_by_Gage_Skidmore.jpg');
-- composer 257 John Alden Carpenter (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/28/John_Alden_Carpenter_1921.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/28/John_Alden_Carpenter_1921.jpg'
WHERE id = 257 AND english_name = 'John Alden Carpenter'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:John_Alden_Carpenter_1921.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/28/John_Alden_Carpenter_1921.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 257 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/28/John_Alden_Carpenter_1921.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/28/John_Alden_Carpenter_1921.jpg');
-- composer 259 Juan Crisóstomo de Arriaga (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Juan_de_Arriaga.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Juan_de_Arriaga.jpg'
WHERE id = 259 AND english_name = 'Juan Crisóstomo de Arriaga'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Juan_de_Arriaga.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Juan_de_Arriaga.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 259 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Juan_de_Arriaga.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Juan_de_Arriaga.jpg');
-- composer 260 잔 프란체스코 말리피에로 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bc/Gian_Francesco_Malipiero_%28before_1973%29_-_Archivio_storico_Ricordi_FOTO001318.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bc/Gian_Francesco_Malipiero_%28before_1973%29_-_Archivio_storico_Ricordi_FOTO001318.jpg'
WHERE id = 260 AND english_name = 'Gian Francesco Malipiero'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Gian_Francesco_Malipiero_(before_1973)_-_Archivio_storico_Ricordi_FOTO001318.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/bc/Gian_Francesco_Malipiero_%28before_1973%29_-_Archivio_storico_Ricordi_FOTO001318.jpg', 'Interfoto', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 260 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bc/Gian_Francesco_Malipiero_%28before_1973%29_-_Archivio_storico_Ricordi_FOTO001318.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bc/Gian_Francesco_Malipiero_%28before_1973%29_-_Archivio_storico_Ricordi_FOTO001318.jpg');
-- composer 262 Edmond Missa (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0d/Edmond_Missa_-_franz%C3%B6sischer_Komponist.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0d/Edmond_Missa_-_franz%C3%B6sischer_Komponist.jpg'
WHERE id = 262 AND english_name = 'Edmond Missa'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Edmond_Missa_-_franz%C3%B6sischer_Komponist.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/0d/Edmond_Missa_-_franz%C3%B6sischer_Komponist.jpg', 'Jean-Claude Marmand', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 262 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0d/Edmond_Missa_-_franz%C3%B6sischer_Komponist.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0d/Edmond_Missa_-_franz%C3%B6sischer_Komponist.jpg');
-- composer 263 찰스 마리 비도르 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Charles-Marie_Widor_%282%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Charles-Marie_Widor_%282%29.jpg'
WHERE id = 263 AND english_name = 'Charles-Marie Widor'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Charles-Marie_Widor_(2).jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Charles-Marie_Widor_%282%29.jpg', 'Paul Berger (photographer). Breitkopf & Härtel, London (publisher).', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 263 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Charles-Marie_Widor_%282%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Charles-Marie_Widor_%282%29.jpg');
-- composer 264 Juventino Rosas (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Juventino_Rosas_1894.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Juventino_Rosas_1894.jpg'
WHERE id = 264 AND english_name = 'Juventino Rosas'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Juventino_Rosas_1894.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Juventino_Rosas_1894.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 264 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Juventino_Rosas_1894.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Juventino_Rosas_1894.jpg');
-- composer 266 Issac Strauss (commons-category)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Isaac_Strauss_by_Antoine_Maurin.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Isaac_Strauss_by_Antoine_Maurin.jpg'
WHERE id = 266 AND english_name = 'Issac Strauss'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Isaac_Strauss_by_Antoine_Maurin.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Isaac_Strauss_by_Antoine_Maurin.jpg', 'Antoine Maurin', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 266 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Isaac_Strauss_by_Antoine_Maurin.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Isaac_Strauss_by_Antoine_Maurin.jpg');
-- composer 274 Diana Arismendi (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/33/Arismendi%2C_foto.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/33/Arismendi%2C_foto.jpg'
WHERE id = 274 AND english_name = 'Diana Arismendi'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Arismendi,_foto.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/33/Arismendi%2C_foto.jpg', 'A. Rugeles', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 274 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/33/Arismendi%2C_foto.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/33/Arismendi%2C_foto.jpg');
-- composer 276 루이즈 베르탱 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cc/Louise_Bertin.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cc/Louise_Bertin.jpg'
WHERE id = 276 AND english_name = 'Louise Bertin'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Louise_Bertin.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/cc/Louise_Bertin.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 276 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cc/Louise_Bertin.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cc/Louise_Bertin.jpg');
-- composer 279 Ernesto Elorduy (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/67/Ernesto_Elorduy_-_ca_1900.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/67/Ernesto_Elorduy_-_ca_1900.jpg'
WHERE id = 279 AND english_name = 'Ernesto Elorduy'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Ernesto_Elorduy_-_ca_1900.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/67/Ernesto_Elorduy_-_ca_1900.jpg', 'Agustín Casasola', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 279 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/67/Ernesto_Elorduy_-_ca_1900.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/67/Ernesto_Elorduy_-_ca_1900.jpg');
-- composer 280 마이클 나이먼 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/15/Michael_Nyman_Sant_Cugat.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/15/Michael_Nyman_Sant_Cugat.jpg'
WHERE id = 280 AND english_name = 'Michael Nyman'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Michael_Nyman_Sant_Cugat.jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/15/Michael_Nyman_Sant_Cugat.jpg', 'Josep Renalias', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 280 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/15/Michael_Nyman_Sant_Cugat.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/15/Michael_Nyman_Sant_Cugat.jpg');
-- composer 281 Louise Lincoln Kerr (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/36/Louise_Lincoln_Kerr.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/36/Louise_Lincoln_Kerr.jpg'
WHERE id = 281 AND english_name = 'Louise Lincoln Kerr'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Louise_Lincoln_Kerr.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/36/Louise_Lincoln_Kerr.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 281 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/36/Louise_Lincoln_Kerr.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/36/Louise_Lincoln_Kerr.jpg');
-- composer 282 프란츠 슈미트 (commons-category)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/71/Rektor_Hofrat_Prof._Franz_Schmidt_%28cropped%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/71/Rektor_Hofrat_Prof._Franz_Schmidt_%28cropped%29.jpg'
WHERE id = 282 AND english_name = 'Franz Schmidt'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Rektor_Hofrat_Prof._Franz_Schmidt_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/71/Rektor_Hofrat_Prof._Franz_Schmidt_%28cropped%29.jpg', 'Georg Fayer', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 282 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/71/Rektor_Hofrat_Prof._Franz_Schmidt_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/71/Rektor_Hofrat_Prof._Franz_Schmidt_%28cropped%29.jpg');
-- composer 283 크리스티안 신딩 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5c/Christian_Sinding_OB.F06421a.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5c/Christian_Sinding_OB.F06421a.jpg'
WHERE id = 283 AND english_name = 'Christian Sinding'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Christian_Sinding_OB.F06421a.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/5c/Christian_Sinding_OB.F06421a.jpg', NULL, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 283 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5c/Christian_Sinding_OB.F06421a.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5c/Christian_Sinding_OB.F06421a.jpg');
-- composer 284 Heinrich Esser (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/18/Esser_Heinrich_1869.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/18/Esser_Heinrich_1869.png'
WHERE id = 284 AND english_name = 'Heinrich Esser'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Esser_Heinrich_1869.png', 'https://upload.wikimedia.org/wikipedia/commons/1/18/Esser_Heinrich_1869.png', 'Josef Löwy', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 284 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/18/Esser_Heinrich_1869.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/18/Esser_Heinrich_1869.png');
-- composer 286 Aram Van Ballaert (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/42/Aram_Van_Ballaert%2C_December_2018.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/42/Aram_Van_Ballaert%2C_December_2018.jpg'
WHERE id = 286 AND english_name = 'Aram Van Ballaert'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Aram_Van_Ballaert,_December_2018.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/42/Aram_Van_Ballaert%2C_December_2018.jpg', 'AllenTalk', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 286 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/42/Aram_Van_Ballaert%2C_December_2018.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/42/Aram_Van_Ballaert%2C_December_2018.jpg');
-- composer 287 니콜라 렌스 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0b/N._Lens_%282007-Paris%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0b/N._Lens_%282007-Paris%29.jpg'
WHERE id = 287 AND english_name = 'Nicholas Lens'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:N._Lens_(2007-Paris).jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/0b/N._Lens_%282007-Paris%29.jpg', 'Artistresearch', 'CC BY 2.5', 'https://creativecommons.org/licenses/by/2.5', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 287 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0b/N._Lens_%282007-Paris%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0b/N._Lens_%282007-Paris%29.jpg');
-- composer 290 보이치에흐 킬라르 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/60/Wojciech_Kilar_2.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/60/Wojciech_Kilar_2.jpg'
WHERE id = 290 AND english_name = 'Wojciech Kilar'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Wojciech_Kilar_2.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/60/Wojciech_Kilar_2.jpg', 'Cezary Piwowarski', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 290 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/60/Wojciech_Kilar_2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/60/Wojciech_Kilar_2.jpg');
-- composer 291 William Grant Still (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/14/William_Grant_Still_by_Carl_Van_Vechten.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/14/William_Grant_Still_by_Carl_Van_Vechten.jpg'
WHERE id = 291 AND english_name = 'William Grant Still'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:William_Grant_Still_by_Carl_Van_Vechten.jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/14/William_Grant_Still_by_Carl_Van_Vechten.jpg', 'Carl Van Vechten / Adam Cuerden', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 291 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/14/William_Grant_Still_by_Carl_Van_Vechten.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/14/William_Grant_Still_by_Carl_Van_Vechten.jpg');
-- composer 292 핫토리 다다시 (wikipedia-pageimage)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/Tadashi_Hattori.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/Tadashi_Hattori.jpg'
WHERE id = 292 AND english_name = 'Tadashi Hattori'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Tadashi_Hattori.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/3f/Tadashi_Hattori.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 292 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/Tadashi_Hattori.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3f/Tadashi_Hattori.jpg');
-- composer 293 니코 멀리 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/be/Nico_Muhly_2014.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/be/Nico_Muhly_2014.jpg'
WHERE id = 293 AND english_name = 'Nico Muhly'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Nico_Muhly_2014.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/be/Nico_Muhly_2014.jpg', 'Steven Psano', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 293 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/be/Nico_Muhly_2014.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/be/Nico_Muhly_2014.jpg');
-- composer 296 나지 하킴 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9f/Naji_Hakim_at_the_grand_organ_of_the_Basilica_of_the_Sacred_Heart_of_Montmartre.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9f/Naji_Hakim_at_the_grand_organ_of_the_Basilica_of_the_Sacred_Heart_of_Montmartre.png'
WHERE id = 296 AND english_name = 'Naji Hakim'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Naji_Hakim_at_the_grand_organ_of_the_Basilica_of_the_Sacred_Heart_of_Montmartre.png', 'https://upload.wikimedia.org/wikipedia/commons/9/9f/Naji_Hakim_at_the_grand_organ_of_the_Basilica_of_the_Sacred_Heart_of_Montmartre.png', 'Laetatussum', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 296 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9f/Naji_Hakim_at_the_grand_organ_of_the_Basilica_of_the_Sacred_Heart_of_Montmartre.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9f/Naji_Hakim_at_the_grand_organ_of_the_Basilica_of_the_Sacred_Heart_of_Montmartre.png');
-- composer 297 Jennifer Higdon (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/91/Jennifer_Higdon_at_2014_Cabrillo_Festival_of_Contemporary_Music.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/91/Jennifer_Higdon_at_2014_Cabrillo_Festival_of_Contemporary_Music.jpg'
WHERE id = 297 AND english_name = 'Jennifer Higdon'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jennifer_Higdon_at_2014_Cabrillo_Festival_of_Contemporary_Music.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/91/Jennifer_Higdon_at_2014_Cabrillo_Festival_of_Contemporary_Music.jpg', 'CTV Santa Cruz County', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 297 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/91/Jennifer_Higdon_at_2014_Cabrillo_Festival_of_Contemporary_Music.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/91/Jennifer_Higdon_at_2014_Cabrillo_Festival_of_Contemporary_Music.jpg');
-- composer 300 Adrien Talexy (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/94/Adrien_Talexy_1850.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/94/Adrien_Talexy_1850.jpg'
WHERE id = 300 AND english_name = 'Adrien Talexy'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Adrien_Talexy_1850.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/94/Adrien_Talexy_1850.jpg', 'Unattributed', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 300 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/94/Adrien_Talexy_1850.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/94/Adrien_Talexy_1850.jpg');
-- composer 301 피터 맥스웰 데이비스 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Peter_Maxwell_Davies.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Peter_Maxwell_Davies.jpg'
WHERE id = 301 AND english_name = 'Peter Maxwell Davies'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Peter_Maxwell_Davies.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Peter_Maxwell_Davies.jpg', 'University of Salford Press Office', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 301 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Peter_Maxwell_Davies.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Peter_Maxwell_Davies.jpg');
-- composer 303 Albert Siklós (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Sikl%C3%B3s_Albert.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Sikl%C3%B3s_Albert.jpg'
WHERE id = 303 AND english_name = 'Albert Siklós'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Sikl%C3%B3s_Albert.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Sikl%C3%B3s_Albert.jpg', 'Pál M. Vajda', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 303 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Sikl%C3%B3s_Albert.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Sikl%C3%B3s_Albert.jpg');
-- composer 304 Vieri Tosatti (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6b/Vieri_Tosatti.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6b/Vieri_Tosatti.jpg'
WHERE id = 304 AND english_name = 'Vieri Tosatti'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Vieri_Tosatti.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/6b/Vieri_Tosatti.jpg', 'Indeciso42 at the Italian Wikipedia project.', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 304 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6b/Vieri_Tosatti.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6b/Vieri_Tosatti.jpg');
-- composer 307 에르네스토 레쿠오나 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/55/LecuonaE.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/55/LecuonaE.jpg'
WHERE id = 307 AND english_name = 'Ernesto Lecuona'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:LecuonaE.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/55/LecuonaE.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 307 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/55/LecuonaE.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/55/LecuonaE.jpg');
-- composer 310 사에구사 시게아키 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0b/ShigeakiSaegusaJI1.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0b/ShigeakiSaegusaJI1.jpg'
WHERE id = 310 AND english_name = 'Shigeaki Saegusa'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:ShigeakiSaegusaJI1.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/0b/ShigeakiSaegusaJI1.jpg', 'Joi', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 310 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0b/ShigeakiSaegusaJI1.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0b/ShigeakiSaegusaJI1.jpg');
-- composer 312 Zygmunt Konieczny (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3a/2007.10.27.Zygmunt_Konieczny_Fot_Mariusz_Kubik.JPG', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3a/2007.10.27.Zygmunt_Konieczny_Fot_Mariusz_Kubik.JPG'
WHERE id = 312 AND english_name = 'Zygmunt Konieczny'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:2007.10.27.Zygmunt_Konieczny_Fot_Mariusz_Kubik.JPG', 'https://upload.wikimedia.org/wikipedia/commons/3/3a/2007.10.27.Zygmunt_Konieczny_Fot_Mariusz_Kubik.JPG', 'Mariusz Kubik', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 312 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3a/2007.10.27.Zygmunt_Konieczny_Fot_Mariusz_Kubik.JPG'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3a/2007.10.27.Zygmunt_Konieczny_Fot_Mariusz_Kubik.JPG');
-- composer 316 Zdeněk Šesták (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Zden%C4%9Bk_%C5%A0est%C3%A1k_%282020%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Zden%C4%9Bk_%C5%A0est%C3%A1k_%282020%29.jpg'
WHERE id = 316 AND english_name = 'Zdeněk Šesták'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Zden%C4%9Bk_%C5%A0est%C3%A1k_(2020).jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Zden%C4%9Bk_%C5%A0est%C3%A1k_%282020%29.jpg', 'Jindřich Nosek (NoJin)', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 316 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Zden%C4%9Bk_%C5%A0est%C3%A1k_%282020%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Zden%C4%9Bk_%C5%A0est%C3%A1k_%282020%29.jpg');
-- composer 322 에벤시오 카스테야노스 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Evencio_Castellanos_componiendo.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Evencio_Castellanos_componiendo.jpg'
WHERE id = 322 AND english_name = 'Evencio Castellanos'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Evencio_Castellanos_componiendo.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Evencio_Castellanos_componiendo.jpg', 'Luis Castellanos 2', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 322 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Evencio_Castellanos_componiendo.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Evencio_Castellanos_componiendo.jpg');
-- composer 323 아서 벤저민 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/93/Arthurbenjamin.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/93/Arthurbenjamin.jpg'
WHERE id = 323 AND english_name = 'Arthur Benjamin'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Arthurbenjamin.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/93/Arthurbenjamin.jpg', 'ShortStat', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 323 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/93/Arthurbenjamin.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/93/Arthurbenjamin.jpg');
-- composer 324 Edgar Tinel (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6e/Edgar_Tinel_1911.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6e/Edgar_Tinel_1911.jpg'
WHERE id = 324 AND english_name = 'Edgar Tinel'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Edgar_Tinel_1911.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/6e/Edgar_Tinel_1911.jpg', 'Unattributed', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 324 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6e/Edgar_Tinel_1911.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6e/Edgar_Tinel_1911.jpg');
-- composer 328 Julius Weismann (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f9/Julius_Weismann.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f9/Julius_Weismann.jpg'
WHERE id = 328 AND english_name = 'Julius Weismann'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Julius_Weismann.jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f9/Julius_Weismann.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 328 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f9/Julius_Weismann.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f9/Julius_Weismann.jpg');
-- composer 329 Auguste Mermet (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ec/Auguste_Mermet_1876.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ec/Auguste_Mermet_1876.jpg'
WHERE id = 329 AND english_name = 'Auguste Mermet'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Auguste_Mermet_1876.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/ec/Auguste_Mermet_1876.jpg', 'Imprimerie Gadart (publisher).', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 329 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ec/Auguste_Mermet_1876.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ec/Auguste_Mermet_1876.jpg');
-- composer 330 Georges Mathias (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/96/Georges_Mathias_par_Marie-Alexandre_Alophe.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/96/Georges_Mathias_par_Marie-Alexandre_Alophe.jpg'
WHERE id = 330 AND english_name = 'Georges Mathias'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Georges_Mathias_par_Marie-Alexandre_Alophe.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/96/Georges_Mathias_par_Marie-Alexandre_Alophe.jpg', 'Marie-Alexandre Alophe', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 330 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/96/Georges_Mathias_par_Marie-Alexandre_Alophe.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/96/Georges_Mathias_par_Marie-Alexandre_Alophe.jpg');
-- composer 331 레오폴드 고도프스키 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a8/LeopoldGodowsky55.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a8/LeopoldGodowsky55.jpg'
WHERE id = 331 AND english_name = 'Leopold Godowsky'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:LeopoldGodowsky55.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a8/LeopoldGodowsky55.jpg', 'Carl Van Vechten', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 331 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a8/LeopoldGodowsky55.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a8/LeopoldGodowsky55.jpg');
-- composer 332 Michel Corboz (commons-category)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Michel_Corboz_%282011%29_by_Erling_Mandelmann.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Michel_Corboz_%282011%29_by_Erling_Mandelmann.jpg'
WHERE id = 332 AND english_name = 'Michel Corboz'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Michel_Corboz_(2011)_by_Erling_Mandelmann.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Michel_Corboz_%282011%29_by_Erling_Mandelmann.jpg', 'Erling Mandelmann', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 332 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Michel_Corboz_%282011%29_by_Erling_Mandelmann.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Michel_Corboz_%282011%29_by_Erling_Mandelmann.jpg');
-- composer 334 발보리 아울린 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/55/Valborg_Aulin.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/55/Valborg_Aulin.jpg'
WHERE id = 334 AND english_name = 'Valborg Aulin'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Valborg_Aulin.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/55/Valborg_Aulin.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 334 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/55/Valborg_Aulin.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/55/Valborg_Aulin.jpg');
-- composer 335 Gustave Dugazon (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Gustave_Dugazon_%28perspective_adjusted%2C_cropped%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Gustave_Dugazon_%28perspective_adjusted%2C_cropped%29.jpg'
WHERE id = 335 AND english_name = 'Gustave Dugazon'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Gustave_Dugazon_(perspective_adjusted,_cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Gustave_Dugazon_%28perspective_adjusted%2C_cropped%29.jpg', 'Dugazon', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 335 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Gustave_Dugazon_%28perspective_adjusted%2C_cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Gustave_Dugazon_%28perspective_adjusted%2C_cropped%29.jpg');
-- composer 336 올라브 셸란 (commons-category)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4f/Olav_Kielland%2C_composer_%28cropped%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4f/Olav_Kielland%2C_composer_%28cropped%29.jpg'
WHERE id = 336 AND english_name = 'Olav Kielland'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Olav_Kielland,_composer_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/4f/Olav_Kielland%2C_composer_%28cropped%29.jpg', NULL, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 336 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4f/Olav_Kielland%2C_composer_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4f/Olav_Kielland%2C_composer_%28cropped%29.jpg');
-- composer 337 Vasco Mendonça (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b2/Vasco_Mendonca_2022.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b2/Vasco_Mendonca_2022.jpg'
WHERE id = 337 AND english_name = 'Vasco Mendonça'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Vasco_Mendonca_2022.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/b2/Vasco_Mendonca_2022.jpg', 'Vascofmendonca', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 337 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b2/Vasco_Mendonca_2022.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b2/Vasco_Mendonca_2022.jpg');
-- composer 338 Hermann Zilcher (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d2/Hermann_Zilcher_%281881-1948%29_%28cropped%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d2/Hermann_Zilcher_%281881-1948%29_%28cropped%29.jpg'
WHERE id = 338 AND english_name = 'Hermann Zilcher'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Hermann_Zilcher_(1881-1948)_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d2/Hermann_Zilcher_%281881-1948%29_%28cropped%29.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 338 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d2/Hermann_Zilcher_%281881-1948%29_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d2/Hermann_Zilcher_%281881-1948%29_%28cropped%29.jpg');
-- composer 339 스즈키 세이이치 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/39/Seiichi_Suzuki.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/39/Seiichi_Suzuki.jpg'
WHERE id = 339 AND english_name = 'Seiichi Suzuki'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Seiichi_Suzuki.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/39/Seiichi_Suzuki.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 339 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/39/Seiichi_Suzuki.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/39/Seiichi_Suzuki.jpg');
-- composer 343 Michael Berkeley (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Official_portrait_of_Lord_Berkeley_of_Knighton_crop_2.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Official_portrait_of_Lord_Berkeley_of_Knighton_crop_2.jpg'
WHERE id = 343 AND english_name = 'Michael Berkeley'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Official_portrait_of_Lord_Berkeley_of_Knighton_crop_2.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Official_portrait_of_Lord_Berkeley_of_Knighton_crop_2.jpg', 'Chris McAndrew', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 343 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Official_portrait_of_Lord_Berkeley_of_Knighton_crop_2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Official_portrait_of_Lord_Berkeley_of_Knighton_crop_2.jpg');
-- composer 344 José Pablo Moncayo García (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9b/Jose_Pablo_Moncayo_picture.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9b/Jose_Pablo_Moncayo_picture.jpg'
WHERE id = 344 AND english_name = 'José Pablo Moncayo García'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jose_Pablo_Moncayo_picture.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/9b/Jose_Pablo_Moncayo_picture.jpg', 'Chava2222', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 344 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9b/Jose_Pablo_Moncayo_picture.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/9b/Jose_Pablo_Moncayo_picture.jpg');
-- composer 345 Bruno Mantovani (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/17/20150130_BrunoMantovani.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/17/20150130_BrunoMantovani.jpg'
WHERE id = 345 AND english_name = 'Bruno Mantovani'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:20150130_BrunoMantovani.jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/17/20150130_BrunoMantovani.jpg', 'Roland Berger7', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 345 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/17/20150130_BrunoMantovani.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/17/20150130_BrunoMantovani.jpg');
-- composer 346 도널드 토비 (commons-category)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Philip_Alexius_de_L%C3%A1szl%C3%B3_%281869%E2%80%931937%29_-_Sir_Donald_Francis_Tovey_%281875%E2%80%931940%29_-_EU0517_-_University_of_Edinburgh_Art_Collection.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Philip_Alexius_de_L%C3%A1szl%C3%B3_%281869%E2%80%931937%29_-_Sir_Donald_Francis_Tovey_%281875%E2%80%931940%29_-_EU0517_-_University_of_Edinburgh_Art_Collection.jpg'
WHERE id = 346 AND english_name = 'Donald Tovey'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Philip_Alexius_de_L%C3%A1szl%C3%B3_(1869%E2%80%931937)_-_Sir_Donald_Francis_Tovey_(1875%E2%80%931940)_-_EU0517_-_University_of_Edinburgh_Art_Collection.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Philip_Alexius_de_L%C3%A1szl%C3%B3_%281869%E2%80%931937%29_-_Sir_Donald_Francis_Tovey_%281875%E2%80%931940%29_-_EU0517_-_University_of_Edinburgh_Art_Collection.jpg', 'Philip de László', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 346 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Philip_Alexius_de_L%C3%A1szl%C3%B3_%281869%E2%80%931937%29_-_Sir_Donald_Francis_Tovey_%281875%E2%80%931940%29_-_EU0517_-_University_of_Edinburgh_Art_Collection.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Philip_Alexius_de_L%C3%A1szl%C3%B3_%281869%E2%80%931937%29_-_Sir_Donald_Francis_Tovey_%281875%E2%80%931940%29_-_EU0517_-_University_of_Edinburgh_Art_Collection.jpg');
-- composer 347 리환즈 (wikipedia-pageimage)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7a/%E9%9F%B3%E4%B9%90%E5%AE%B6%E6%9D%8E%E7%84%95%E4%B9%8B.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7a/%E9%9F%B3%E4%B9%90%E5%AE%B6%E6%9D%8E%E7%84%95%E4%B9%8B.png'
WHERE id = 347 AND english_name = 'Li Huanzhi'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:%E9%9F%B3%E4%B9%90%E5%AE%B6%E6%9D%8E%E7%84%95%E4%B9%8B.png', 'https://upload.wikimedia.org/wikipedia/commons/7/7a/%E9%9F%B3%E4%B9%90%E5%AE%B6%E6%9D%8E%E7%84%95%E4%B9%8B.png', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 347 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7a/%E9%9F%B3%E4%B9%90%E5%AE%B6%E6%9D%8E%E7%84%95%E4%B9%8B.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7a/%E9%9F%B3%E4%B9%90%E5%AE%B6%E6%9D%8E%E7%84%95%E4%B9%8B.png');
-- composer 348 프랑수아 조제프 페티스 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/20/Francois_joseph_fetis.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/20/Francois_joseph_fetis.jpg'
WHERE id = 348 AND english_name = 'François-Joseph Fétis'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Francois_joseph_fetis.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/20/Francois_joseph_fetis.jpg', 'Charles Baugniet', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 348 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/20/Francois_joseph_fetis.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/20/Francois_joseph_fetis.jpg');
-- composer 350 Fikret Amirov (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/82/Fikret_Emirov.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/82/Fikret_Emirov.jpg'
WHERE id = 350 AND english_name = 'Fikret Amirov'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Fikret_Emirov.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/82/Fikret_Emirov.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 350 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/82/Fikret_Emirov.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/82/Fikret_Emirov.jpg');
-- composer 351 Ton de Leeuw (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/79/Ton_de_Leeuw%2C_Hilversum_1988.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/79/Ton_de_Leeuw%2C_Hilversum_1988.jpg'
WHERE id = 351 AND english_name = 'Ton de Leeuw'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Ton_de_Leeuw,_Hilversum_1988.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/79/Ton_de_Leeuw%2C_Hilversum_1988.jpg', 'Elf.elle.64', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 351 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/79/Ton_de_Leeuw%2C_Hilversum_1988.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/79/Ton_de_Leeuw%2C_Hilversum_1988.jpg');
-- composer 359 Kalevi Aho (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/82/Kalevi_Aho.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/82/Kalevi_Aho.jpg'
WHERE id = 359 AND english_name = 'Kalevi Aho'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Kalevi_Aho.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/82/Kalevi_Aho.jpg', 'Teemu Rajala', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 359 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/82/Kalevi_Aho.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/82/Kalevi_Aho.jpg');
-- composer 362 루 해리슨 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/19/Lou_Harrison_1940s.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/19/Lou_Harrison_1940s.jpg'
WHERE id = 362 AND english_name = 'Lou Harrison'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Lou_Harrison_1940s.jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/19/Lou_Harrison_1940s.jpg', NULL, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 362 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/19/Lou_Harrison_1940s.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/19/Lou_Harrison_1940s.jpg');
-- composer 365 파울 린케 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/86/Photo_-_Portrait_des_Paul_Lincke_-_1905.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/86/Photo_-_Portrait_des_Paul_Lincke_-_1905.jpg'
WHERE id = 365 AND english_name = 'Paul Lincke'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Photo_-_Portrait_des_Paul_Lincke_-_1905.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/86/Photo_-_Portrait_des_Paul_Lincke_-_1905.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 365 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/86/Photo_-_Portrait_des_Paul_Lincke_-_1905.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/86/Photo_-_Portrait_des_Paul_Lincke_-_1905.jpg');
-- composer 366 Marco Frisina (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f6/Marco_Frisina.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f6/Marco_Frisina.jpg'
WHERE id = 366 AND english_name = 'Marco Frisina'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Marco_Frisina.jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f6/Marco_Frisina.jpg', 'Centro Televisivo Vaticano - Archivio', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 366 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f6/Marco_Frisina.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f6/Marco_Frisina.jpg');
-- composer 367 Emil Sjögren (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Emil_Sjogren.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Emil_Sjogren.jpg'
WHERE id = 367 AND english_name = 'Emil Sjögren'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Emil_Sjogren.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Emil_Sjogren.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 367 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Emil_Sjogren.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Emil_Sjogren.jpg');
-- composer 371 Hans Georg Nägeli (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/97/Hans_Georg_N%C3%A4geli_%28Balder%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/97/Hans_Georg_N%C3%A4geli_%28Balder%29.jpg'
WHERE id = 371 AND english_name = 'Hans Georg Nägeli'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Hans_Georg_N%C3%A4geli_(Balder).jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/97/Hans_Georg_N%C3%A4geli_%28Balder%29.jpg', 'engraving After Georg Balder (1810-1882)', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 371 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/97/Hans_Georg_N%C3%A4geli_%28Balder%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/97/Hans_Georg_N%C3%A4geli_%28Balder%29.jpg');
-- composer 372 Arthur Coquard (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b2/Arthur_Coquard_by_Nadar.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b2/Arthur_Coquard_by_Nadar.jpg'
WHERE id = 372 AND english_name = 'Arthur Coquard'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Arthur_Coquard_by_Nadar.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/b2/Arthur_Coquard_by_Nadar.jpg', 'Nadar', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 372 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b2/Arthur_Coquard_by_Nadar.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b2/Arthur_Coquard_by_Nadar.jpg');
-- composer 374 Olaus Andreas Grøndahl (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Olaus_Andreas_Gr%C3%B8ndahl.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Olaus_Andreas_Gr%C3%B8ndahl.jpg'
WHERE id = 374 AND english_name = 'Olaus Andreas Grøndahl'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Olaus_Andreas_Gr%C3%B8ndahl.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Olaus_Andreas_Gr%C3%B8ndahl.jpg', 'L. Szaciński / Oslo Museum', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 374 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Olaus_Andreas_Gr%C3%B8ndahl.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Olaus_Andreas_Gr%C3%B8ndahl.jpg');
-- composer 381 Julius Eichberg (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b6/JuliusEichberg_byGAKlucken.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b6/JuliusEichberg_byGAKlucken.png'
WHERE id = 381 AND english_name = 'Julius Eichberg'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:JuliusEichberg_byGAKlucken.png', 'https://upload.wikimedia.org/wikipedia/commons/b/b6/JuliusEichberg_byGAKlucken.png', 'Klucken', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 381 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b6/JuliusEichberg_byGAKlucken.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b6/JuliusEichberg_byGAKlucken.png');
-- composer 383 허레이쇼 파커 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2e/Horatio_William_Parker_1916.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2e/Horatio_William_Parker_1916.jpg'
WHERE id = 383 AND english_name = 'Horatio Parker'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Horatio_William_Parker_1916.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/2e/Horatio_William_Parker_1916.jpg', 'Pirie MacDonald', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 383 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2e/Horatio_William_Parker_1916.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2e/Horatio_William_Parker_1916.jpg');
-- composer 386 Bruno Bettinelli (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/52/Bruno_Bettinelli.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/52/Bruno_Bettinelli.jpg'
WHERE id = 386 AND english_name = 'Bruno Bettinelli'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Bruno_Bettinelli.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/52/Bruno_Bettinelli.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 386 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/52/Bruno_Bettinelli.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/52/Bruno_Bettinelli.jpg');
-- composer 391 Henri Mulet (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/86/HenriMulet.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/86/HenriMulet.png'
WHERE id = 391 AND english_name = 'Henri Mulet'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:HenriMulet.png', 'https://upload.wikimedia.org/wikipedia/commons/8/86/HenriMulet.png', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 391 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/86/HenriMulet.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/86/HenriMulet.png');
-- composer 392 Geoffrey Toye (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/83/ToyeGeoffrey.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/83/ToyeGeoffrey.jpg'
WHERE id = 392 AND english_name = 'Geoffrey Toye'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:ToyeGeoffrey.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/83/ToyeGeoffrey.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 392 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/83/ToyeGeoffrey.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/83/ToyeGeoffrey.jpg');
-- composer 393 Viktor Ullmann (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/79/Viktor_Ullmann_2.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/79/Viktor_Ullmann_2.jpg'
WHERE id = 393 AND english_name = 'Viktor Ullmann'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Viktor_Ullmann_2.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/79/Viktor_Ullmann_2.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 393 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/79/Viktor_Ullmann_2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/79/Viktor_Ullmann_2.jpg');
-- composer 397 샤를 쾨클랭 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4d/Charles_Koechlin_1.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4d/Charles_Koechlin_1.jpg'
WHERE id = 397 AND english_name = 'Charles Koechlin'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Charles_Koechlin_1.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/4d/Charles_Koechlin_1.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 397 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4d/Charles_Koechlin_1.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4d/Charles_Koechlin_1.jpg');
-- composer 398 Gustave Doret (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Gustave_Doret.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Gustave_Doret.jpg'
WHERE id = 398 AND english_name = 'Gustave Doret'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Gustave_Doret.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Gustave_Doret.jpg', 'The British Library (Original) Wolfymoza (Commons upload)', 'No restrictions', 'https://www.flickr.com/commons/usage/', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 398 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Gustave_Doret.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Gustave_Doret.jpg');
-- composer 399 해럴드 버드 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/15/Harold_Budd_%28cropped%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/15/Harold_Budd_%28cropped%29.jpg'
WHERE id = 399 AND english_name = 'Harold Budd'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Harold_Budd_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/15/Harold_Budd_%28cropped%29.jpg', 'Masao Nakagami', 'CC BY-SA 2.0', 'https://creativecommons.org/licenses/by-sa/2.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 399 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/15/Harold_Budd_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/15/Harold_Budd_%28cropped%29.jpg');
-- composer 400 프랑수아 바쟁 (commons-category)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/95/Fran%C3%A7ois_Bazin.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/95/Fran%C3%A7ois_Bazin.jpg'
WHERE id = 400 AND english_name = 'François Bazin'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Fran%C3%A7ois_Bazin.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/95/Fran%C3%A7ois_Bazin.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 400 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/95/Fran%C3%A7ois_Bazin.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/95/Fran%C3%A7ois_Bazin.jpg');
-- composer 401 Hisato Ohzawa (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d8/Ozawa_Hisato.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d8/Ozawa_Hisato.jpg'
WHERE id = 401 AND english_name = 'Hisato Ohzawa'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Ozawa_Hisato.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d8/Ozawa_Hisato.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 401 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d8/Ozawa_Hisato.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d8/Ozawa_Hisato.jpg');
-- composer 402 Elena Gnesina (commons-category)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/43/%D0%95%D0%BB%D0%B5%D0%BD%D0%B0_%D0%A4%D0%B0%D0%B1%D0%B8%D0%B0%D0%BD%D0%BE%D0%B2%D0%BD%D0%B0_%D0%93%D0%BD%D0%B5%D1%81%D0%B8%D0%BD%D0%B0.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/43/%D0%95%D0%BB%D0%B5%D0%BD%D0%B0_%D0%A4%D0%B0%D0%B1%D0%B8%D0%B0%D0%BD%D0%BE%D0%B2%D0%BD%D0%B0_%D0%93%D0%BD%D0%B5%D1%81%D0%B8%D0%BD%D0%B0.jpg'
WHERE id = 402 AND english_name = 'Elena Gnesina'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:%D0%95%D0%BB%D0%B5%D0%BD%D0%B0_%D0%A4%D0%B0%D0%B1%D0%B8%D0%B0%D0%BD%D0%BE%D0%B2%D0%BD%D0%B0_%D0%93%D0%BD%D0%B5%D1%81%D0%B8%D0%BD%D0%B0.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/43/%D0%95%D0%BB%D0%B5%D0%BD%D0%B0_%D0%A4%D0%B0%D0%B1%D0%B8%D0%B0%D0%BD%D0%BE%D0%B2%D0%BD%D0%B0_%D0%93%D0%BD%D0%B5%D1%81%D0%B8%D0%BD%D0%B0.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 402 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/43/%D0%95%D0%BB%D0%B5%D0%BD%D0%B0_%D0%A4%D0%B0%D0%B1%D0%B8%D0%B0%D0%BD%D0%BE%D0%B2%D0%BD%D0%B0_%D0%93%D0%BD%D0%B5%D1%81%D0%B8%D0%BD%D0%B0.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/43/%D0%95%D0%BB%D0%B5%D0%BD%D0%B0_%D0%A4%D0%B0%D0%B1%D0%B8%D0%B0%D0%BD%D0%BE%D0%B2%D0%BD%D0%B0_%D0%93%D0%BD%D0%B5%D1%81%D0%B8%D0%BD%D0%B0.jpg');
-- composer 407 게오르크 프리드리히 하스 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a0/Georg_Friedrich_Haas%2C_2014_%28aufgenommen_von_Gian_Marco_Castelberg%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a0/Georg_Friedrich_Haas%2C_2014_%28aufgenommen_von_Gian_Marco_Castelberg%29.jpg'
WHERE id = 407 AND english_name = 'Georg Friedrich Haas'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Georg_Friedrich_Haas,_2014_(aufgenommen_von_Gian_Marco_Castelberg).jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a0/Georg_Friedrich_Haas%2C_2014_%28aufgenommen_von_Gian_Marco_Castelberg%29.jpg', 'Gian Marco Castelberg (Gian Marco Castelberg Photography)', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 407 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a0/Georg_Friedrich_Haas%2C_2014_%28aufgenommen_von_Gian_Marco_Castelberg%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a0/Georg_Friedrich_Haas%2C_2014_%28aufgenommen_von_Gian_Marco_Castelberg%29.jpg');
-- composer 415 Francisco Mignone (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Francisco_Mignone%2C_1972.tif/lossy-page1-960px-Francisco_Mignone%2C_1972.tif.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Francisco_Mignone%2C_1972.tif/lossy-page1-960px-Francisco_Mignone%2C_1972.tif.jpg'
WHERE id = 415 AND english_name = 'Francisco Mignone'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Francisco_Mignone,_1972.tif', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Francisco_Mignone%2C_1972.tif/lossy-page1-960px-Francisco_Mignone%2C_1972.tif.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 415 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Francisco_Mignone%2C_1972.tif/lossy-page1-960px-Francisco_Mignone%2C_1972.tif.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Francisco_Mignone%2C_1972.tif/lossy-page1-960px-Francisco_Mignone%2C_1972.tif.jpg');
-- composer 416 Bernardo Adam Ferrero (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5a/Bernardo_adam_2.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5a/Bernardo_adam_2.jpg'
WHERE id = 416 AND english_name = 'Bernardo Adam Ferrero'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Bernardo_adam_2.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/5a/Bernardo_adam_2.jpg', 'ORMUNDI', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 416 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5a/Bernardo_adam_2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5a/Bernardo_adam_2.jpg');
-- composer 418 Joonas Kokkonen (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a4/JoonasKokkonen.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a4/JoonasKokkonen.jpg'
WHERE id = 418 AND english_name = 'Joonas Kokkonen'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:JoonasKokkonen.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a4/JoonasKokkonen.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 418 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a4/JoonasKokkonen.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a4/JoonasKokkonen.jpg');
-- composer 420 쿠르트 슈베르치크 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/69/Kurt_Schwertsik_AEC_2025_BHO-3985.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/69/Kurt_Schwertsik_AEC_2025_BHO-3985.jpg'
WHERE id = 420 AND english_name = 'Kurt Schwertsik'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Kurt_Schwertsik_AEC_2025_BHO-3985.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/69/Kurt_Schwertsik_AEC_2025_BHO-3985.jpg', 'Bernhard Holub', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 420 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/69/Kurt_Schwertsik_AEC_2025_BHO-3985.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/69/Kurt_Schwertsik_AEC_2025_BHO-3985.jpg');
-- composer 421 베어 매크리리 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/33/Bear_McCreary%2C_GDC_2019_%28GEN1879_1%29_%28cropped%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/33/Bear_McCreary%2C_GDC_2019_%28GEN1879_1%29_%28cropped%29.jpg'
WHERE id = 421 AND english_name = 'Bear McCreary'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Bear_McCreary,_GDC_2019_(GEN1879_1)_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/33/Bear_McCreary%2C_GDC_2019_%28GEN1879_1%29_%28cropped%29.jpg', 'Official GDC', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 421 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/33/Bear_McCreary%2C_GDC_2019_%28GEN1879_1%29_%28cropped%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/33/Bear_McCreary%2C_GDC_2019_%28GEN1879_1%29_%28cropped%29.jpg');
-- composer 422 José Luis Turina (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3b/Jos%C3%A9_Luis_Turina_%28foto_de_Pilar_Sanz%2C_Santiago_2015%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3b/Jos%C3%A9_Luis_Turina_%28foto_de_Pilar_Sanz%2C_Santiago_2015%29.jpg'
WHERE id = 422 AND english_name = 'José Luis Turina'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jos%C3%A9_Luis_Turina_(foto_de_Pilar_Sanz,_Santiago_2015).jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/3b/Jos%C3%A9_Luis_Turina_%28foto_de_Pilar_Sanz%2C_Santiago_2015%29.jpg', 'Marijuana Laloca', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 422 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3b/Jos%C3%A9_Luis_Turina_%28foto_de_Pilar_Sanz%2C_Santiago_2015%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3b/Jos%C3%A9_Luis_Turina_%28foto_de_Pilar_Sanz%2C_Santiago_2015%29.jpg');
-- composer 423 장프랑수아 르쉬외르 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/71/J._F._Le_Sueur_cropped.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/71/J._F._Le_Sueur_cropped.jpg'
WHERE id = 423 AND english_name = 'Jean-François Le Sueur'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:J._F._Le_Sueur_cropped.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/71/J._F._Le_Sueur_cropped.jpg', 'Edme Quenedey des Ricets', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 423 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/71/J._F._Le_Sueur_cropped.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/71/J._F._Le_Sueur_cropped.jpg');
-- composer 424 Avraham Eilam-Amzallag (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/22/Avraham_Eilam-Amzallag.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/22/Avraham_Eilam-Amzallag.jpg'
WHERE id = 424 AND english_name = 'Avraham Eilam-Amzallag'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Avraham_Eilam-Amzallag.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/22/Avraham_Eilam-Amzallag.jpg', 'Family album', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 424 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/2/22/Avraham_Eilam-Amzallag.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/22/Avraham_Eilam-Amzallag.jpg');
-- composer 425 Jaroslav Krček (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Jaroslav_Kr%C4%8Dek_%282016%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Jaroslav_Kr%C4%8Dek_%282016%29.jpg'
WHERE id = 425 AND english_name = 'Jaroslav Krček'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jaroslav_Kr%C4%8Dek_(2016).jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Jaroslav_Kr%C4%8Dek_%282016%29.jpg', 'Jindřich Nosek (NoJin)', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 425 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Jaroslav_Kr%C4%8Dek_%282016%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Jaroslav_Kr%C4%8Dek_%282016%29.jpg');
-- composer 429 Michael Waller (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f6/Wallerbiophoto.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f6/Wallerbiophoto.jpg'
WHERE id = 429 AND english_name = 'Michael Waller'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Wallerbiophoto.jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f6/Wallerbiophoto.jpg', 'Ggg1005', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 429 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f6/Wallerbiophoto.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f6/Wallerbiophoto.jpg');
-- composer 430 Henri Tomasi (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f5/Henri_Tomasi_portrait_corse.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f5/Henri_Tomasi_portrait_corse.jpg'
WHERE id = 430 AND english_name = 'Henri Tomasi'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Henri_Tomasi_portrait_corse.jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f5/Henri_Tomasi_portrait_corse.jpg', 'Michelsolis', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 430 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f5/Henri_Tomasi_portrait_corse.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f5/Henri_Tomasi_portrait_corse.jpg');
-- composer 431 프랑수아 쿠프랭 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/54/Fran%C3%A7ois_Couperin.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/54/Fran%C3%A7ois_Couperin.jpg'
WHERE id = 431 AND english_name = 'François Couperin'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Fran%C3%A7ois_Couperin.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/54/Fran%C3%A7ois_Couperin.jpg', 'Jean Charles Flipart / After André Bouys', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 431 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/54/Fran%C3%A7ois_Couperin.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/54/Fran%C3%A7ois_Couperin.jpg');
-- composer 433 Thea Musgrave (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/07/Thea_Musgrave_2017_-_St_Brides%2C_London.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/07/Thea_Musgrave_2017_-_St_Brides%2C_London.jpg'
WHERE id = 433 AND english_name = 'Thea Musgrave'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Thea_Musgrave_2017_-_St_Brides,_London.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/07/Thea_Musgrave_2017_-_St_Brides%2C_London.jpg', 'Thomas Le Brocq', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 433 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/07/Thea_Musgrave_2017_-_St_Brides%2C_London.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/0/07/Thea_Musgrave_2017_-_St_Brides%2C_London.jpg');
-- composer 434 베른하르드 크루셀 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/73/Bernhard_Henrik_Crusell_1826.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/73/Bernhard_Henrik_Crusell_1826.jpg'
WHERE id = 434 AND english_name = 'Bernhard Crusell'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Bernhard_Henrik_Crusell_1826.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/73/Bernhard_Henrik_Crusell_1826.jpg', 'Johan Gustaf Sandberg', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 434 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/73/Bernhard_Henrik_Crusell_1826.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/73/Bernhard_Henrik_Crusell_1826.jpg');
-- composer 435 Erling Brene (wikipedia-pageimage)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Erling_Brene.gif', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Erling_Brene.gif'
WHERE id = 435 AND english_name = 'Erling Brene'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Erling_Brene.gif', 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Erling_Brene.gif', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 435 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Erling_Brene.gif'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Erling_Brene.gif');
-- composer 439 Pierre Gaviniès (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Pierre_Gavini%C3%A8s_d%27apr%C3%A8s_Pierre_Gu%C3%A9rin.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Pierre_Gavini%C3%A8s_d%27apr%C3%A8s_Pierre_Gu%C3%A9rin.jpg'
WHERE id = 439 AND english_name = 'Pierre Gaviniès'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Pierre_Gavini%C3%A8s_d%27apr%C3%A8s_Pierre_Gu%C3%A9rin.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Pierre_Gavini%C3%A8s_d%27apr%C3%A8s_Pierre_Gu%C3%A9rin.jpg', 'Lambert after Pierre Guérin', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 439 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Pierre_Gavini%C3%A8s_d%27apr%C3%A8s_Pierre_Gu%C3%A9rin.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Pierre_Gavini%C3%A8s_d%27apr%C3%A8s_Pierre_Gu%C3%A9rin.jpg');
-- composer 440 Joaquín Valverde Sanjuán (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/59/Quinito_Valverde.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/59/Quinito_Valverde.png'
WHERE id = 440 AND english_name = 'Joaquín Valverde Sanjuán'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Quinito_Valverde.png', 'https://upload.wikimedia.org/wikipedia/commons/5/59/Quinito_Valverde.png', 'Diego Calvache Gómez de Mercado', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 440 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/59/Quinito_Valverde.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/59/Quinito_Valverde.png');
-- composer 441 존 애덤스 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/07/JA-portrait-1-LW.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/07/JA-portrait-1-LW.jpg'
WHERE id = 441 AND english_name = 'John Adams'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:JA-portrait-1-LW.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/07/JA-portrait-1-LW.jpg', 'The original uploader was Macror at English Wikipedia. (Original text: Deborah O''Grady)', 'CC BY-SA 3.0', 'http://creativecommons.org/licenses/by-sa/3.0/', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 441 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/07/JA-portrait-1-LW.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/0/07/JA-portrait-1-LW.jpg');
-- composer 442 Friedrich Wilhelm Marpurg (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Friedrich_Wilhelm_Marpurg_%282%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Friedrich_Wilhelm_Marpurg_%282%29.jpg'
WHERE id = 442 AND english_name = 'Friedrich Wilhelm Marpurg'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Friedrich_Wilhelm_Marpurg_(2).jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Friedrich_Wilhelm_Marpurg_%282%29.jpg', 'Friedrich Wilhelm Bollinger', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 442 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Friedrich_Wilhelm_Marpurg_%282%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Friedrich_Wilhelm_Marpurg_%282%29.jpg');
-- composer 445 Julia Wolfe (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c6/Julia_Wolfe.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c6/Julia_Wolfe.jpg'
WHERE id = 445 AND english_name = 'Julia Wolfe'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Julia_Wolfe.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/c6/Julia_Wolfe.jpg', 'Louisa Dedalus', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 445 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c6/Julia_Wolfe.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c6/Julia_Wolfe.jpg');
-- composer 446 나리타 다메조 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/76/Tamezo_Narita.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/76/Tamezo_Narita.jpg'
WHERE id = 446 AND english_name = 'Tamezō Narita'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Tamezo_Narita.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/76/Tamezo_Narita.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 446 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/76/Tamezo_Narita.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/76/Tamezo_Narita.jpg');
-- composer 448 지크문트 폰 하우제거 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1c/Sigmund_von_Hausegger%2C_Kapellmeister_MET_DP72104.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1c/Sigmund_von_Hausegger%2C_Kapellmeister_MET_DP72104.jpg'
WHERE id = 448 AND english_name = 'Siegmund von Hausegger'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Sigmund_von_Hausegger,_Kapellmeister_MET_DP72104.jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/1c/Sigmund_von_Hausegger%2C_Kapellmeister_MET_DP72104.jpg', 'Frank Eugene', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 448 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1c/Sigmund_von_Hausegger%2C_Kapellmeister_MET_DP72104.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1c/Sigmund_von_Hausegger%2C_Kapellmeister_MET_DP72104.jpg');
-- composer 449 Miguel Llobet (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/aa/Miquel_llobet_retrato_1916.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/aa/Miquel_llobet_retrato_1916.jpg'
WHERE id = 449 AND english_name = 'Miguel Llobet'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Miquel_llobet_retrato_1916.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/aa/Miquel_llobet_retrato_1916.jpg', 'Joan Vilatobà i Fígols', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 449 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/aa/Miquel_llobet_retrato_1916.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/aa/Miquel_llobet_retrato_1916.jpg');
-- composer 456 필리파 스카일러 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/81/Philippa_Schuyler_NYWTS.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/81/Philippa_Schuyler_NYWTS.jpg'
WHERE id = 456 AND english_name = 'Philippa Schuyler'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Philippa_Schuyler_NYWTS.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/81/Philippa_Schuyler_NYWTS.jpg', 'Fred Palumbo, World Telegram staff photographer', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 456 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/8/81/Philippa_Schuyler_NYWTS.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/81/Philippa_Schuyler_NYWTS.jpg');
-- composer 457 Matthew King (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Composer_Matthew_King_by_the_railroad_tracks_at_Grable%2C_Indiana.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Composer_Matthew_King_by_the_railroad_tracks_at_Grable%2C_Indiana.jpg'
WHERE id = 457 AND english_name = 'Matthew King'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Composer_Matthew_King_by_the_railroad_tracks_at_Grable,_Indiana.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Composer_Matthew_King_by_the_railroad_tracks_at_Grable%2C_Indiana.jpg', 'Conlon Nancarrow', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 457 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Composer_Matthew_King_by_the_railroad_tracks_at_Grable%2C_Indiana.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Composer_Matthew_King_by_the_railroad_tracks_at_Grable%2C_Indiana.jpg');
-- composer 458 기예르모 우리베 올긴 (wikipedia-pageimage)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bf/GuillermoUribeHolguin.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bf/GuillermoUribeHolguin.png'
WHERE id = 458 AND english_name = 'Guillermo Uribe Holguín'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:GuillermoUribeHolguin.png', 'https://upload.wikimedia.org/wikipedia/commons/b/bf/GuillermoUribeHolguin.png', 'Bastisinger2', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 458 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bf/GuillermoUribeHolguin.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/bf/GuillermoUribeHolguin.png');
-- composer 459 Jaume Pahissa (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/78/Jaume_Pahissa_i_Jo_2.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/78/Jaume_Pahissa_i_Jo_2.jpg'
WHERE id = 459 AND english_name = 'Jaume Pahissa'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jaume_Pahissa_i_Jo_2.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/78/Jaume_Pahissa_i_Jo_2.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 459 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/78/Jaume_Pahissa_i_Jo_2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/78/Jaume_Pahissa_i_Jo_2.jpg');
-- composer 460 J. Rosamond Johnson (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Rosamondjohnson.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Rosamondjohnson.jpg'
WHERE id = 460 AND english_name = 'J. Rosamond Johnson'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Rosamondjohnson.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Rosamondjohnson.jpg', 'Carl Van Vechten', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 460 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Rosamondjohnson.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Rosamondjohnson.jpg');
-- composer 463 Kirke Mechem (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ce/KirkeMechemThumb.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ce/KirkeMechemThumb.jpg'
WHERE id = 463 AND english_name = 'Kirke Mechem'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:KirkeMechemThumb.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/ce/KirkeMechemThumb.jpg', 'Bill Blankenship, used by permission', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 463 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ce/KirkeMechemThumb.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/ce/KirkeMechemThumb.jpg');
-- composer 468 고프레도 페트라시 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/63/Goffredo.petrassi2.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/63/Goffredo.petrassi2.jpg'
WHERE id = 468 AND english_name = 'Goffredo Petrassi'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Goffredo.petrassi2.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/63/Goffredo.petrassi2.jpg', 'Zagarolesedoc', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 468 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/63/Goffredo.petrassi2.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/63/Goffredo.petrassi2.jpg');
-- composer 469 Georg Schumann (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Georg_Schumann.tif/lossy-page1-250px-Georg_Schumann.tif.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Georg_Schumann.tif/lossy-page1-250px-Georg_Schumann.tif.jpg'
WHERE id = 469 AND english_name = 'Georg Schumann'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Georg_Schumann.tif', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Georg_Schumann.tif/lossy-page1-250px-Georg_Schumann.tif.jpg', 'Schumann Family', 'CC BY 2.0 de', 'https://creativecommons.org/licenses/by/2.0/de/deed.en', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 469 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Georg_Schumann.tif/lossy-page1-250px-Georg_Schumann.tif.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Georg_Schumann.tif/lossy-page1-250px-Georg_Schumann.tif.jpg');
-- composer 471 Gilbert Duprez (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/ac/Gilbert_Duprez_par_Carolus-Duran.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/ac/Gilbert_Duprez_par_Carolus-Duran.jpg'
WHERE id = 471 AND english_name = 'Gilbert Duprez'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Gilbert_Duprez_par_Carolus-Duran.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/ac/Gilbert_Duprez_par_Carolus-Duran.jpg', 'Alfred Lemoine after Carolus-Duran', 'Public domain', NULL, NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 471 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/a/ac/Gilbert_Duprez_par_Carolus-Duran.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/ac/Gilbert_Duprez_par_Carolus-Duran.jpg');
-- composer 473 Isaac Nathan (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Issac_nathan.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Issac_nathan.jpg'
WHERE id = 473 AND english_name = 'Isaac Nathan'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Issac_nathan.jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Issac_nathan.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 473 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Issac_nathan.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Issac_nathan.jpg');
-- composer 474 Eduard Holst (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7d/EdvardHolst.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7d/EdvardHolst.jpg'
WHERE id = 474 AND english_name = 'Eduard Holst'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:EdvardHolst.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/7d/EdvardHolst.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 474 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7d/EdvardHolst.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/7d/EdvardHolst.jpg');
-- composer 479 José María Valle Riestra (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/94/Jos%C3%A9_Mar%C3%ADa_Valle_Riestra.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/94/Jos%C3%A9_Mar%C3%ADa_Valle_Riestra.jpg'
WHERE id = 479 AND english_name = 'José María Valle Riestra'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jos%C3%A9_Mar%C3%ADa_Valle_Riestra.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/94/Jos%C3%A9_Mar%C3%ADa_Valle_Riestra.jpg', 'Phortus', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 479 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/9/94/Jos%C3%A9_Mar%C3%ADa_Valle_Riestra.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/94/Jos%C3%A9_Mar%C3%ADa_Valle_Riestra.jpg');
-- composer 480 Jean Gilbert (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/48/Jean_Gilbert.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/48/Jean_Gilbert.jpg'
WHERE id = 480 AND english_name = 'Jean Gilbert'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jean_Gilbert.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/48/Jean_Gilbert.jpg', 'Ozelotenor', 'CC BY-SA 3.0', 'http://creativecommons.org/licenses/by-sa/3.0/', NULL, TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 480 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/4/48/Jean_Gilbert.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/48/Jean_Gilbert.jpg');
-- composer 482 Robert Fuchs (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/51/Robert_Fuchs%2C_1926.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/51/Robert_Fuchs%2C_1926.jpg'
WHERE id = 482 AND english_name = 'Robert Fuchs'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Robert_Fuchs,_1926.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/51/Robert_Fuchs%2C_1926.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 482 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/5/51/Robert_Fuchs%2C_1926.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/5/51/Robert_Fuchs%2C_1926.jpg');
-- composer 487 José Ángel Montero (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/30/Jos%C3%A9_%C3%81ngel_Montero_2.png', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/30/Jos%C3%A9_%C3%81ngel_Montero_2.png'
WHERE id = 487 AND english_name = 'José Ángel Montero'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jos%C3%A9_%C3%81ngel_Montero_2.png', 'https://upload.wikimedia.org/wikipedia/commons/3/30/Jos%C3%A9_%C3%81ngel_Montero_2.png', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 487 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/3/30/Jos%C3%A9_%C3%81ngel_Montero_2.png'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/30/Jos%C3%A9_%C3%81ngel_Montero_2.png');
-- composer 488 후카이 시로 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e5/Fukai_Shiro.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e5/Fukai_Shiro.jpg'
WHERE id = 488 AND english_name = 'Shirō Fukai'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Fukai_Shiro.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/e5/Fukai_Shiro.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 488 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e5/Fukai_Shiro.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e5/Fukai_Shiro.jpg');
-- composer 489 Fran Lhotka (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/06/Fran_Lhotka_%281883-1962%29.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/06/Fran_Lhotka_%281883-1962%29.jpg'
WHERE id = 489 AND english_name = 'Fran Lhotka'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Fran_Lhotka_(1883-1962).jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/06/Fran_Lhotka_%281883-1962%29.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 489 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/0/06/Fran_Lhotka_%281883-1962%29.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/0/06/Fran_Lhotka_%281883-1962%29.jpg');
-- composer 494 얀 마클라키에비치 (P18)
UPDATE composers SET avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Jan_Maklakiewicz.jpg', cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Jan_Maklakiewicz.jpg'
WHERE id = 494 AND english_name = 'Jan Maklakiewicz'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Jan_Maklakiewicz.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Jan_Maklakiewicz.jpg', NULL, 'Public domain', NULL, 'Wikimedia Commons', TRUE, 'PUBLISHED'
FROM composers composer WHERE composer.id = 494 AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Jan_Maklakiewicz.jpg'
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = composer.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Jan_Maklakiewicz.jpg');
