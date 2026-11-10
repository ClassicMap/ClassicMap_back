-- 공개 배너가 없던 A 연주자의 화면 머리 배너(공식 사이트·대행사·공연장·뉴스 등).
-- 원본: seed_pipeline/curation/entity-images-2-2026-11-11/ (gen_sql.py 로 만든다).
-- 공개 배너가 하나도 없을 때만 넣는다. 권리자가 요청하면 그 줄을 RETIRED 로 내린다.
-- artist 217 스티븐 이설리스 (IMG Artists · Jacky Lepage)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://imgartists.com/roster/steven-isserlis/', 'https://imgartists.com/wp-content/uploads/2023/08/Credit-jackylepage.com-J-L-JLEP0382-HD.jpg', 'IMG Artists · Jacky Lepage', NULL, NULL, NULL, '95% 8%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 217 AND artist.english_name = 'Steven Isserlis' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://imgartists.com/wp-content/uploads/2023/08/Credit-jackylepage.com-J-L-JLEP0382-HD.jpg');
-- artist 262 장 에플람 바부제 (HarrisonParrott)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://harrisonparrott.com/artists/jean-efflam-bavouzet', 'https://www.harrisonparrott.com/sites/default/files/styles/banner_huge/public/images/2026-05/103%20colour%20hi-res%20-%20Jean-Efflam%20Bavouzet%20May%202024_0.jpg?h=e83bf42d&itok=NnUSg2P7', 'HarrisonParrott', NULL, NULL, NULL, '65% 42%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 262 AND artist.english_name = 'Jean-Efflam Bavouzet' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.harrisonparrott.com/sites/default/files/styles/banner_huge/public/images/2026-05/103%20colour%20hi-res%20-%20Jean-Efflam%20Bavouzet%20May%202024_0.jpg?h=e83bf42d&itok=NnUSg2P7');
-- artist 263 베르트랑 샤마유 (HarrisonParrott · Marco Borggreve)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.harrisonparrott.com/artists/bertrand-chamayou', 'https://www.harrisonparrott.com/sites/default/files/styles/landscape_huge/public/images/2018-02/bertrand-chamayou-c-marco-borggreve-warner-classics-2.jpg?h=681bc87f&itok=aZHozUxe', 'HarrisonParrott · Marco Borggreve', NULL, NULL, NULL, '61% 46%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 263 AND artist.english_name = 'Bertrand Chamayou' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.harrisonparrott.com/sites/default/files/styles/landscape_huge/public/images/2018-02/bertrand-chamayou-c-marco-borggreve-warner-classics-2.jpg?h=681bc87f&itok=aZHozUxe');
-- artist 272 바이바 스크리데 (KD Schmid · Marko Rass)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.kdschmid.de/kd-schmid-en/artists/data/skride-baiba.php', 'https://www.kdschmid.de/kd-schmid-wAssets/img/artists/skride-baiba/weblication/wThumbnails/skride-baiba-zf-bso-an-concert-1205-foto-markorass-31-page-bdb12c09-924f645a-mh1022@2398w2x.webp', 'KD Schmid · Marko Rass', NULL, NULL, NULL, '57% 67%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 272 AND artist.english_name = 'Baiba Skride' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.kdschmid.de/kd-schmid-wAssets/img/artists/skride-baiba/weblication/wThumbnails/skride-baiba-zf-bso-an-concert-1205-foto-markorass-31-page-bdb12c09-924f645a-mh1022@2398w2x.webp');
-- artist 298 알렉산드라 쿠르작 (aleksandrakurzak.com)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://aleksandrakurzak.com/biography', 'https://aleksandrakurzak.com/themes/akurzak/images/bckgrounds/biography.jpg', 'aleksandrakurzak.com', NULL, NULL, NULL, '81% 24%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 298 AND artist.english_name = 'Aleksandra Kurzak' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://aleksandrakurzak.com/themes/akurzak/images/bckgrounds/biography.jpg');
-- artist 303 마이클 파비아노 (michaelfabianotenor.com)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://michaelfabianotenor.com/', 'https://michaelfabianotenor.com/wp-content/uploads/2017/09/DSC_7840-extended-landscape-1024x707.jpg', 'michaelfabianotenor.com', NULL, NULL, NULL, '34% 21%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 303 AND artist.english_name = 'Michael Fabiano' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://michaelfabianotenor.com/wp-content/uploads/2017/09/DSC_7840-extended-landscape-1024x707.jpg');
-- artist 315 루카시 본드라체크 (HarrisonParrott · Irene Kim)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.harrisonparrott.com/news/2016-05-30/lukas-vondracek-wins-the-queen-elisabeth-competition', 'https://www.harrisonparrott.com/sites/default/files/styles/banner_huge/public/images/2018-02/lukas-vondracek-high-res-3-credit-irene-kim.jpg?h=0f4230fa&itok=yCqcpWfd', 'HarrisonParrott · Irene Kim', NULL, NULL, NULL, '48% 34%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 315 AND artist.english_name = 'Lukáš Vondráček' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.harrisonparrott.com/sites/default/files/styles/banner_huge/public/images/2018-02/lukas-vondracek-high-res-3-credit-irene-kim.jpg?h=0f4230fa&itok=yCqcpWfd');
-- artist 351 도쿄 도립 교향악단 (일본 오케스트라 연맹 연감 (yearbook.orchestra.or.jp))
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://yearbook.orchestra.or.jp/en/orchestra/tokyo-metropolitan-symphony-orchestra/', 'https://yearbook.orchestra.or.jp/en/2025/wp-content/uploads/2026/03/12_tokyo.png', '일본 오케스트라 연맹 연감 (yearbook.orchestra.or.jp)', NULL, NULL, NULL, '50% 90%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 351 AND artist.english_name = 'Tokyo Metropolitan Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://yearbook.orchestra.or.jp/en/2025/wp-content/uploads/2026/03/12_tokyo.png');
-- artist 354 홍콩 필하모닉 (hkphil.org)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://hkphil.org/tour', 'https://www.hkphil.org/f/key_visual/11131/2600p920/tour2.jpg', 'hkphil.org', NULL, NULL, NULL, '50% 75%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 354 AND artist.english_name = 'Hong Kong Philharmonic' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.hkphil.org/f/key_visual/11131/2600p920/tour2.jpg');
-- artist 355 차이나 필하모닉 (gongfu_king)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Beijing_Concert_Hall_pic_2.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Beijing_Concert_Hall_pic_2.jpg', NULL, 'gongfu_king', 'CC BY-SA 2.0', 'https://creativecommons.org/licenses/by-sa/2.0', '50% 72%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 355 AND artist.english_name = 'China Philharmonic Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Beijing_Concert_Hall_pic_2.jpg');
-- artist 365 세르게이 타라소프 (Smotrim (Russia-Kultura))
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://smotrim.ru/article/4907102', 'https://cdn.smotrim.ru/photobank/old/pic-dk/838/263/6.jpg', 'Smotrim (Russia-Kultura)', NULL, NULL, NULL, '33% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 365 AND artist.english_name = 'Sergei Tarasov' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://cdn.smotrim.ru/photobank/old/pic-dk/838/263/6.jpg');
-- artist 592 모리스 앙드레 (France Musique · Daniel Simon/Gamma-Rapho/Getty Images)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.radiofrance.fr/francemusique/podcasts/les-tresors-de-france-musique/maurice-andre-j-ai-mis-la-trompette-sur-son-piedestal-parce-que-c-est-un-instrument-noble-5623894', 'https://www.radiofrance.fr/pikapi/images/19bfc276-d5f5-4a49-b3a7-3ad93407614f/2048?webp=false', 'France Musique · Daniel Simon/Gamma-Rapho/Getty Images', NULL, NULL, NULL, '0% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 592 AND artist.english_name = 'Maurice André' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.radiofrance.fr/pikapi/images/19bfc276-d5f5-4a49-b3a7-3ad93407614f/2048?webp=false');
-- artist 602 쿠르트 마주어 (NPR · Hiroyuki Ito/Getty Images)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.npr.org/sections/deceptivecadence/2015/12/19/460392051/remembering-kurt-masur-the-conductor-who-rebuilt-the-new-york-philharmonic', 'https://media.npr.org/assets/img/2015/12/19/gettyimages-150445517_wide-7da3a4716a2c68181f843152b01063d7386ea68d.jpg?s=1800&c=85&f=jpeg', 'NPR · Hiroyuki Ito/Getty Images', NULL, NULL, NULL, '100% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 602 AND artist.english_name = 'Kurt Masur' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://media.npr.org/assets/img/2015/12/19/gettyimages-150445517_wide-7da3a4716a2c68181f843152b01063d7386ea68d.jpg?s=1800&c=85&f=jpeg');
-- artist 606 보로딘 콰르텟 (Rayfield Allied)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.rayfieldallied.com/artists/borodin-quartet', 'https://www.rayfieldallied.com/images/_1640xAUTO_crop_center-center_none/164_Volkov_BW.jpg', 'Rayfield Allied', NULL, NULL, NULL, '53% 16%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 606 AND artist.english_name = 'Borodin Quartet' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.rayfieldallied.com/images/_1640xAUTO_crop_center-center_none/164_Volkov_BW.jpg');
-- artist 609 바버라 보니 (STAGE+ (Deutsche Grammophon))
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.stage-plus.com/klassikakzente/barbara-bonney', 'https://dg-stage-production-pictures.s3.eu-west-1.amazonaws.com/ccfbd5588bca7b4538a58d09f9c6663e2be2e566.jpg', 'STAGE+ (Deutsche Grammophon)', NULL, NULL, NULL, '36% 33%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 609 AND artist.english_name = 'Barbara Bonney' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://dg-stage-production-pictures.s3.eu-west-1.amazonaws.com/ccfbd5588bca7b4538a58d09f9c6663e2be2e566.jpg');
-- artist 613 피터 서킨 (KPBS · Stu Rosner/BSO)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.kpbs.org/news/2020/02/03/remembering-peter-serkin-the-searching-pianist', 'https://kpbs-brightspot.s3.us-west-2.amazonaws.com/assets/img/2020/02/03/st-phane-den-ve-after-leading-the-bso-and-pianist-peter-serkin-on-2.16.12-stu-rosner--save-as-jpg_wide-303a1d576c6e8e4105e776f8a45fed898efc3a4e.jpg', 'KPBS · Stu Rosner/BSO', NULL, NULL, NULL, '97% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 613 AND artist.english_name = 'Peter Serkin' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://kpbs-brightspot.s3.us-west-2.amazonaws.com/assets/img/2020/02/03/st-phane-den-ve-after-leading-the-bso-and-pianist-peter-serkin-on-2.16.12-stu-rosner--save-as-jpg_wide-303a1d576c6e8e4105e776f8a45fed898efc3a4e.jpg');
-- artist 623 클라라 하스킬 (inkl (The Conversation))
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://inkl.com/news/the-unjustly-forgotten-genius-of-pianist-clara-haskil', 'https://images.inkl.com/s3/article/lead_image/17151344/file-20221124-26-qgs3t3.jpg', 'inkl (The Conversation)', NULL, NULL, NULL, '9% 23%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 623 AND artist.english_name = 'Clara Haskil' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://images.inkl.com/s3/article/lead_image/17151344/file-20221124-26-qgs3t3.jpg');
-- artist 635 베르트랑 드 비이 (debilly.com)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://debilly.com/', 'https://debilly.com/wp-content/uploads/2024/03/Bertrand-de-Billy037_1400.jpg', 'debilly.com', NULL, NULL, NULL, '55% 37%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 635 AND artist.english_name = 'Bertrand de Billy' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://debilly.com/wp-content/uploads/2024/03/Bertrand-de-Billy037_1400.jpg');
-- artist 638 빈 방송 교향악단 (ORF Radio-Symphonieorchester Wien · Theresa Wey)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://rso.orf.at/en/rsowien', 'https://rso.orf.at/sites/default/files/styles/max/public/bilder/ORF%20Radio-Symphonieorchester%20Wien%20mit%20Marin%20Alsop%20%28c%29%20Theresa%20Wey%202-1.jpg', 'ORF Radio-Symphonieorchester Wien · Theresa Wey', NULL, NULL, NULL, '50% 40%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 638 AND artist.english_name = 'Vienna Radio Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://rso.orf.at/sites/default/files/styles/max/public/bilder/ORF%20Radio-Symphonieorchester%20Wien%20mit%20Marin%20Alsop%20%28c%29%20Theresa%20Wey%202-1.jpg');
-- artist 639 램버트 오키스 (Hollywood Bowl)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.hollywoodbowl.com/musicdb/artists/4014/lambert-orkis', 'https://images.baskercdn.com/laphil/media/v/1773196400608/Lambert-Orkis-1920x1280.jpg', 'Hollywood Bowl', NULL, NULL, NULL, '48% 36%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 639 AND artist.english_name = 'Lambert Orkis' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://images.baskercdn.com/laphil/media/v/1773196400608/Lambert-Orkis-1920x1280.jpg');
-- artist 652 맬컴 마티노 (Askonas Holt)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.askonasholt.com/artist/malcolm-martineau', 'https://cdn.sanity.io/images/ssnxcmsx/prod/b48f2e092d23f95f9281af5088ee86e7c2024dc8-4288x2848.jpg?w=2048&q=75', 'Askonas Holt', NULL, NULL, NULL, '46% 33%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 652 AND artist.english_name = 'Malcolm Martineau' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://cdn.sanity.io/images/ssnxcmsx/prod/b48f2e092d23f95f9281af5088ee86e7c2024dc8-4288x2848.jpg?w=2048&q=75');
-- artist 659 라 페니체 극장 관현악단 (Teatro La Fenice)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.teatrolafenice.it/en/?p=13584', 'https://www.teatrolafenice.it/wp-content/uploads/2019/01/CoroOrchestra-1920x720.jpg', 'Teatro La Fenice', NULL, NULL, NULL, '50% 60%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 659 AND artist.english_name = 'Orchestra del Teatro La Fenice' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.teatrolafenice.it/wp-content/uploads/2019/01/CoroOrchestra-1920x720.jpg');
-- artist 666 취리히 오페라 관현악단 (Bachtrack · Andrin Fretz/Opernhaus Zürich)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://bachtrack.com/kritik-strauss-noseda-muller-philharmonia-opernhaus-zurich-januar-2025', 'https://cdn.bachtrack.com/wfiles/407512-opernhaus-presse-30-10-2021--c--andrin-fretz-13.webp', 'Bachtrack · Andrin Fretz/Opernhaus Zürich', NULL, NULL, NULL, '50% 75%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 666 AND artist.english_name = 'Orchester der Oper Zürich' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://cdn.bachtrack.com/wfiles/407512-opernhaus-presse-30-10-2021--c--andrin-fretz-13.webp');
-- artist 668 이온 마린 (Cami Music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://camimusic.com/ion-marin', 'https://images.squarespace-cdn.com/content/v1/55a80922e4b0c355c5cf1948/1486075647665-RFPLCANGM8SUE16ORF78/Ion+Marin+in+performance_03.JPG?format=2500w', 'Cami Music', NULL, NULL, NULL, '80% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 668 AND artist.english_name = 'Ion Marin' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://images.squarespace-cdn.com/content/v1/55a80922e4b0c355c5cf1948/1486075647665-RFPLCANGM8SUE16ORF78/Ion+Marin+in+performance_03.JPG?format=2500w');
-- artist 669 뮌헨 방송관현악단 (Salzburger Festspiele · Felix Broede)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.salzburgerfestspiele.at/en/a/muenchner-rundfunkorchester', 'https://www.salzburgerfestspiele.at/wp-content/uploads/2023/11/muenchner_rundfunkorchester_foto_1_c_felix-broede-scaled.jpg', 'Salzburger Festspiele · Felix Broede', NULL, NULL, NULL, '50% 35%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 669 AND artist.english_name = 'Münchner Rundfunkorchester' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.salzburgerfestspiele.at/wp-content/uploads/2023/11/muenchner_rundfunkorchester_foto_1_c_felix-broede-scaled.jpg');
-- artist 682 게롤트 후버 (Künstlersekretariat am Gasteig · Clive Barda)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://ks-gasteig.de/index.php/en/artist-vv-58', 'https://ks-gasteig.de/images/News/Huber/News/2019_Huber_Wigmore_c_Clive_Barda.jpg', 'Künstlersekretariat am Gasteig · Clive Barda', NULL, NULL, NULL, '72% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 682 AND artist.english_name = 'Gerold Huber' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://ks-gasteig.de/images/News/Huber/News/2019_Huber_Wigmore_c_Clive_Barda.jpg');
-- artist 687 실비아 맥네어 (sylviamcnair.com)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://sylviamcnair.com/photos--2', 'https://images.zoogletools.com/s:bzglfiles/u/207762/a37ce1dd772d538e04130c847ae770e99eb82f15/original/sylvia-singing.jpg/!!/b%3AW1sicmVzaXplIiwxODAwXSxbIm1heCJdLFsid2UiXV0%3D/meta%3AeyJzcmNCdWNrZXQiOiJiemdsZmlsZXMifQ%3D%3D.jpg', 'sylviamcnair.com', NULL, NULL, NULL, '0% 42%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 687 AND artist.english_name = 'Sylvia McNair' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://images.zoogletools.com/s:bzglfiles/u/207762/a37ce1dd772d538e04130c847ae770e99eb82f15/original/sylvia-singing.jpg/!!/b%3AW1sicmVzaXplIiwxODAwXSxbIm1heCJdLFsid2UiXV0%3D/meta%3AeyJzcmNCdWNrZXQiOiJiemdsZmlsZXMifQ%3D%3D.jpg');
-- artist 688 샤를로테 마르히오노 (NRC)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.nrc.nl/nieuws/2007/07/05/charlotte-margiono-11353579-a526129', 'https://images.nrc.nl/hVADLr2hll_2l9XD5ZwCbgJck44=/1280x/filters:no_upscale()/s3/tark/images/NH/200707/05/678338.jpg', 'NRC', NULL, NULL, NULL, '20% 10%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 688 AND artist.english_name = 'Charlotte Margiono' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://images.nrc.nl/hVADLr2hll_2l9XD5ZwCbgJck44=/1280x/filters:no_upscale()/s3/tark/images/NH/200707/05/678338.jpg');
-- artist 690 마이클 알렉산더 윌런스 (koelnerakademie.de)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://koelnerakademie.de/brautigam_dka_maw/', 'https://koelnerakademie.de/wp-content/uploads/2021/04/Brautigam_DKA_MAW-scaled.jpg', 'koelnerakademie.de', NULL, NULL, NULL, '59% 33%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 690 AND artist.english_name = 'Michael Alexander Willens' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://koelnerakademie.de/wp-content/uploads/2021/04/Brautigam_DKA_MAW-scaled.jpg');
-- artist 691 미하엘 슈나이더 (michael-schneider-info.de)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://michael-schneider-info.de/', 'https://michael-schneider-info.de/uploads/pages/michael-schneider-info-startseite.jpg', 'michael-schneider-info.de', NULL, NULL, NULL, '63% 18%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 691 AND artist.english_name = 'Michael Schneider' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://michael-schneider-info.de/uploads/pages/michael-schneider-info-startseite.jpg');
-- artist 698 쾰른 아카데미 (koelnerakademie.de)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://koelnerakademie.de/event/osnabruck-2025-10-02/', 'https://koelnerakademie.de/wp-content/uploads/2025/08/kolnerakademie_web_608583443.jpg', 'koelnerakademie.de', NULL, NULL, NULL, '58% 49%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 698 AND artist.english_name = 'Kölner Akademie' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://koelnerakademie.de/wp-content/uploads/2025/08/kolnerakademie_web_608583443.jpg');
-- artist 699 라 스타조네 프랑크푸르트 (lastagione.de)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://lastagione.de/', 'https://lastagione.de/images/big-images/StagioneFloersheim.jpg', 'lastagione.de', NULL, NULL, NULL, '50% 55%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 699 AND artist.english_name = 'La Stagione Frankfurt' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://lastagione.de/images/big-images/StagioneFloersheim.jpg');
-- artist 700 네덜란드 체임버 오케스트라 (orkest.nl)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://orkest.nl/en/nederlands-kamerorkest/', 'https://cms.orkest.nl/media/original_images/Nederlands_Kamerorkest_jhG8wtt.jpg', 'orkest.nl', NULL, NULL, NULL, '50% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 700 AND artist.english_name = 'Netherlands Chamber Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://cms.orkest.nl/media/original_images/Nederlands_Kamerorkest_jhG8wtt.jpg');
-- artist 703 하노버 밴드 (thehanoverband.com)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://thehanoverband.com/about/', 'https://thehanoverband.com/wp-content/uploads/2017/02/the-hanover-band-concert-banner-02.jpg', 'thehanoverband.com', NULL, NULL, NULL, '66% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 703 AND artist.english_name = 'Hanover Band' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://thehanoverband.com/wp-content/uploads/2017/02/the-hanover-band-concert-banner-02.jpg');
-- artist 709 파트리크 갈루아 (Mendelssohn Festival · Tiina Osara)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://mendelssohn-festival.com/en/artists/patrick-gallois/', 'https://mendelssohn-festival.com/wp-content/uploads/2022/03/Gallois-Patrick-2-Copyright-Tiina-Osara.jpg', 'Mendelssohn Festival · Tiina Osara', NULL, NULL, NULL, '100% 23%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 709 AND artist.english_name = 'Patrick Gallois' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://mendelssohn-festival.com/wp-content/uploads/2022/03/Gallois-Patrick-2-Copyright-Tiina-Osara.jpg');
-- artist 710 트레버 피노크 (Askonas Holt)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://askonasholt.com/artist/trevor-pinnock', 'https://cdn.sanity.io/images/ssnxcmsx/prod/17c6ac52a3c91cdb3b418e98d72be87a52918ffa-5000x3332.jpg?w=2048&q=75', 'Askonas Holt', NULL, NULL, NULL, '36% 34%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 710 AND artist.english_name = 'Trevor Pinnock' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://cdn.sanity.io/images/ssnxcmsx/prod/17c6ac52a3c91cdb3b418e98d72be87a52918ffa-5000x3332.jpg?w=2048&q=75');
-- artist 711 외르크 페르버 (Heilbronner Stimme)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.stimme.de/freizeit/kultur/kultur/wko-gruender-joerg-faerber-im-alter-von-93-jahren-gestorben-art-4673701', 'https://www.stimme.de/storage/image/3/2/9/0/3680923_twitter-card_1AAldH_j4n0XS.jpg', 'Heilbronner Stimme', NULL, NULL, NULL, '50% 28%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 711 AND artist.english_name = 'Jörg Faerber' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.stimme.de/storage/image/3/2/9/0/3680923_twitter-card_1AAldH_j4n0XS.jpg');
-- artist 717 존 매케이브 (Interlude)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://interlude.hk/interview-with-monica-mccabe-remembering-piano-music-of-john-mccabe/', 'https://interlude-cdn-blob-prod.azureedge.net/interlude-blob-storage-prod/2021/08/john-mccabe.jpg', 'Interlude', NULL, NULL, NULL, '0% 27%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 717 AND artist.english_name = 'John McCabe' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://interlude-cdn-blob-prod.azureedge.net/interlude-blob-storage-prod/2021/08/john-mccabe.jpg');
-- artist 718 산드로 데 팔마 (langhe.net)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://langhe.net/en/event/alba-music-festival-ombre-sogni-e-fantasmi-nella-belle-epoque-31-05-2025/', 'https://langhe.net/wp-content/uploads/2025/05/Sandro-DePalma.jpg', 'langhe.net', NULL, NULL, NULL, '44% 21%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 718 AND artist.english_name = 'Sandro De Palma' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://langhe.net/wp-content/uploads/2025/05/Sandro-DePalma.jpg');
-- artist 721 프레데리카 폰 슈타데 (KUSC)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://kusc.org/articles/classical-californians-frederica-von-stade', 'https://assets.classicalcalifornia.org/contentful/2OCA1T2EHLxbQYlbdDHyS0/49a6dc81db1825d3eff4d46266e07af7/Frederica-von-Stade-16x9.webp', 'KUSC', NULL, NULL, NULL, '53% 12%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 721 AND artist.english_name = 'Frederica von Stade' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://assets.classicalcalifornia.org/contentful/2OCA1T2EHLxbQYlbdDHyS0/49a6dc81db1825d3eff4d46266e07af7/Frederica-von-Stade-16x9.webp');
-- artist 723 볼프람 크리스트 (wolframchrist.de)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.wolframchrist.de/', 'https://www.wolframchrist.de/img/backgrounds/WChrist_HG_Bild_Start_neu.jpg', 'wolframchrist.de', NULL, NULL, NULL, '100% 31%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 723 AND artist.english_name = 'Wolfram Christ' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.wolframchrist.de/img/backgrounds/WChrist_HG_Bild_Start_neu.jpg');
-- artist 729 쾰른 실내관현악단 (koelner-kammerorchester.de · Diesner)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.koelner-kammerorchester.de/', 'https://www.koelner-kammerorchester.de/wp-content/uploads/2023/10/230319_koelner_kammerorchester_001_5577_diesner.jpg', 'koelner-kammerorchester.de · Diesner', NULL, NULL, NULL, '50% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 729 AND artist.english_name = 'Cologne Chamber Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.koelner-kammerorchester.de/wp-content/uploads/2023/10/230319_koelner_kammerorchester_001_5577_diesner.jpg');
-- artist 731 갈리나 비슈넵스카야 (The Blueprint · Yuri Abramochkin/RIA Novosti)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://theblueprint.ru/culture/music/vishnevskaya-100', 'https://theblueprint.ru/upload/42562/vms/a6e23227d70316e5bbf3a428a329324d_small.png', 'The Blueprint · Yuri Abramochkin/RIA Novosti', NULL, NULL, NULL, '70% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 731 AND artist.english_name = 'Galina Vishnevskaya' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://theblueprint.ru/upload/42562/vms/a6e23227d70316e5bbf3a428a329324d_small.png');
-- artist 732 갈리나 고르차코바 (alastairmacaulay.com)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://alastairmacaulay.com/blog/c8g7ks3sqzolucy3wk6agch51eck6s', 'https://images.squarespace-cdn.com/content/v1/5f7a13e2cc6d622013f6e6d4/1609888835043-XPY2KD615ZDDE63F4PZJ/IMG_0843.png?format=2500w', 'alastairmacaulay.com', NULL, NULL, NULL, '45% 12%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 732 AND artist.english_name = 'Galina Gorchakova' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://images.squarespace-cdn.com/content/v1/5f7a13e2cc6d622013f6e6d4/1609888835043-XPY2KD615ZDDE63F4PZJ/IMG_0843.png?format=2500w');
-- artist 733 율리아 숙마노바 (juliasukmanova.com)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.juliasukmanova.com/', 'https://impro.usercontent.one/appid/oneComWsb/domain/juliasukmanova.com/media/juliasukmanova.com/onewebmedia/17.jpg?etag=W%2F%2267669e-5fcbb608%22&sourceContentType=image%2Fjpeg&ignoreAspectRatio&resize=2400%2B1600&quality=85', 'juliasukmanova.com', NULL, NULL, NULL, '51% 25%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 733 AND artist.english_name = 'Julia Sukmanova' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://impro.usercontent.one/appid/oneComWsb/domain/juliasukmanova.com/media/juliasukmanova.com/onewebmedia/17.jpg?etag=W%2F%2267669e-5fcbb608%22&sourceContentType=image%2Fjpeg&ignoreAspectRatio&resize=2400%2B1600&quality=85');
-- artist 739 루돌프 피르쿠슈니 (Steinway & Sons · Steve J. Sherman)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.steinway.com/artists/rudolf-firkusny', 'https://www.steinway.com/.imaging/mte/steinway-us-theme/XL-Rectangle/dam/artists/usable-artist-images/Rudolf-Firkusny_photo_Steve-J.-Sherman_Carnegie_Hall_1987_fma.jpg/jcr:content/Rudolf-Firkusny_photo_Steve-J.-Sherman_Carnegie_Hall_1987_fma.jpg', 'Steinway & Sons · Steve J. Sherman', NULL, NULL, NULL, '82% 47%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 739 AND artist.english_name = 'Rudolf Firkušný' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.steinway.com/.imaging/mte/steinway-us-theme/XL-Rectangle/dam/artists/usable-artist-images/Rudolf-Firkusny_photo_Steve-J.-Sherman_Carnegie_Hall_1987_fma.jpg/jcr:content/Rudolf-Firkusny_photo_Steve-J.-Sherman_Carnegie_Hall_1987_fma.jpg');
-- artist 740 모라 림파니 (karnaval.com)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://karnaval.com/sanatcilar/moura-lympany-4491', 'https://mediacdns.karnaval.com/media/artist_media/4491/biography_1280x720/photo_4491_0.jpg?v=150413035405', 'karnaval.com', NULL, NULL, NULL, '0% 18%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 740 AND artist.english_name = 'Moura Lympany' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://mediacdns.karnaval.com/media/artist_media/4491/biography_1280x720/photo_4491_0.jpg?v=150413035405');
-- artist 744 스티븐 레이턴 (stephenlayton.com)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://stephenlayton.com/', 'https://stephenlayton.com/assets/img/sl-4w-2560.webp', 'stephenlayton.com', NULL, NULL, NULL, '65% 11%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 744 AND artist.english_name = 'Stephen Layton' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://stephenlayton.com/assets/img/sl-4w-2560.webp');
-- artist 745 시그바르스 클라바 (LSM.lv)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.lsm.lv/raksts/kultura/muzika/daudz-laimes-dzimsanas-diena-sigvard-klava.a302267/', 'https://static.lsm.lv/media/2018/11/large/1/a8yg.jpg', 'LSM.lv', NULL, NULL, NULL, '26% 28%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 745 AND artist.english_name = 'Sigvards Kļava' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://static.lsm.lv/media/2018/11/large/1/a8yg.jpg');
-- artist 746 빈 국립오페라 합창연합 (Salzburger Festspiele · Thomas Köber)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.salzburgerfestspiele.at/en/a/konzertvereinigung-wiener-staatsopernchor', 'https://www.salzburgerfestspiele.at/wp-content/uploads/2018/11/konzertvereinigungwienerstaatsopernchor_c_thomaskoeber-2-scaled.jpg', 'Salzburger Festspiele · Thomas Köber', NULL, NULL, NULL, '50% 70%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 746 AND artist.english_name = 'Konzertvereinigung Wiener Staatsopernchor' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.salzburgerfestspiele.at/wp-content/uploads/2018/11/konzertvereinigungwienerstaatsopernchor_c_thomaskoeber-2-scaled.jpg');
-- artist 751 루치아 포프 (Warner Classics)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.warnerclassics.com/artist/lucia-popp', 'https://www.warnerclassics.com/sites/default/files/H550868.jpg', 'Warner Classics', NULL, NULL, NULL, '90% 65%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 751 AND artist.english_name = 'Lucia Popp' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.warnerclassics.com/sites/default/files/H550868.jpg');
-- artist 760 루시 파럼 (Wigmore Hall)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.wigmore-hall.org.uk/whats-on/202610281930', 'https://media.wigmore-hall.org.uk/images/.phpref24508sizewebextjpgpage1al.format-webp.width-3200_KFE24GMB3NBHaZaB.webp', 'Wigmore Hall', NULL, NULL, NULL, '86% 59%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 760 AND artist.english_name = 'Lucy Parham' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://media.wigmore-hall.org.uk/images/.phpref24508sizewebextjpgpage1al.format-webp.width-3200_KFE24GMB3NBHaZaB.webp');
-- artist 761 홀리 매시슨 (Marty Melville)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:191001Turn_of_the_Screw144.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a9/191001Turn_of_the_Screw144.jpg', NULL, 'Marty Melville', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '18% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 761 AND artist.english_name = 'Holly Mathieson' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/a/a9/191001Turn_of_the_Screw144.jpg');
-- artist 763 BBC 콘서트 오케스트라 (Southbank Centre)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.southbankcentre.co.uk/whats-on/bbc-concert-orchestra-brahms/', 'https://bynder.southbankcentre.co.uk/transform/217a8c4f-5c45-4777-9aef-545981f2e1c5/260508_BBC-CO_Brahms_QEH?io=transform%3Afill%2Cwidth%3A1600%2Cheight%3A1000', 'Southbank Centre', NULL, NULL, NULL, '33% 53%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 763 AND artist.english_name = 'BBC Concert Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://bynder.southbankcentre.co.uk/transform/217a8c4f-5c45-4777-9aef-545981f2e1c5/260508_BBC-CO_Brahms_QEH?io=transform%3Afill%2Cwidth%3A1600%2Cheight%3A1000');
-- artist 765 이시도어 코언 (valerieaimard.fr)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://valerieaimard.fr/concerts-memorables-2/', 'https://valerieaimard.fr/wp-content/uploads/2015/06/Isidore-Cohen-Marlboro-Green-Room.jpg', 'valerieaimard.fr', NULL, NULL, NULL, '100% 43%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 765 AND artist.english_name = 'Isidore Cohen' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://valerieaimard.fr/wp-content/uploads/2015/06/Isidore-Cohen-Marlboro-Green-Room.jpg');
-- artist 766 버나드 그린하우스 (Fotopersbureau De Boer)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Beaux_Arts_Trio,_Concertgebouw,_1978_-_35.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Beaux_Arts_Trio%2C_Concertgebouw%2C_1978_-_35.jpg', NULL, 'Fotopersbureau De Boer', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', '90% 15%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 766 AND artist.english_name = 'Bernard Greenhouse' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Beaux_Arts_Trio%2C_Concertgebouw%2C_1978_-_35.jpg');
-- artist 768 베네딕트 클뢰크너 (benedictkloeckner.de · Marco Borggreve)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://benedictkloeckner.de/', 'https://benedictkloeckner.com/media/ig/avatar_full.jpg', 'benedictkloeckner.de · Marco Borggreve', NULL, NULL, NULL, '12% 18%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 768 AND artist.english_name = 'Benedict Klöckner' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://benedictkloeckner.com/media/ig/avatar_full.jpg');
-- artist 770 살바토레 아카르도 (Fondazione Walter Stauffer · Marcella Cistola)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.stauffer.org/en/?p=23347', 'https://www.stauffer.org/wp-content/uploads/2024/09/Salvatore-Accardo-Ph-Marcella-Cistola-7-1.jpg', 'Fondazione Walter Stauffer · Marcella Cistola', NULL, NULL, NULL, '39% 15%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 770 AND artist.english_name = 'Salvatore Accardo' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.stauffer.org/wp-content/uploads/2024/09/Salvatore-Accardo-Ph-Marcella-Cistola-7-1.jpg');
-- artist 771 슈무엘 아슈케나시 (Curtis Institute of Music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://curtis.edu/?p=6722', 'https://www.curtis.edu/wp-content/uploads/2022/01/Ashkenasi-Hero-Layered-Desktop-v6.png', 'Curtis Institute of Music', NULL, NULL, NULL, '0% 3%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 771 AND artist.english_name = 'Shmuel Ashkenasi' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.curtis.edu/wp-content/uploads/2022/01/Ashkenasi-Hero-Layered-Desktop-v6.png');
-- artist 781 티모시 허친스 (timothyhutchinsflute.com · Tam Photography)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://timothyhutchinsflute.com/', 'https://static.wixstatic.com/media/3846e6_3572abd463864187ad7769733faf6e1c%7Emv2.jpg/v1/fit/w_2500,h_1330,al_c/3846e6_3572abd463864187ad7769733faf6e1c%7Emv2.jpg', 'timothyhutchinsflute.com · Tam Photography', NULL, NULL, NULL, '100% 9%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 781 AND artist.english_name = 'Timothy Hutchins' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://static.wixstatic.com/media/3846e6_3572abd463864187ad7769733faf6e1c%7Emv2.jpg/v1/fit/w_2500,h_1330,al_c/3846e6_3572abd463864187ad7769733faf6e1c%7Emv2.jpg');
-- artist 783 시카고 심포니 합창단 (cso.org)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://cso.org/about/performers/chicago-symphony-chorus/chicago-symphony-chorus/', 'https://chicagosymphony.org/media/gyvfo3xr/cso20251208_024fv2.jpg', 'cso.org', NULL, NULL, NULL, '50% 75%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 783 AND artist.english_name = 'Chicago Symphony Chorus' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://chicagosymphony.org/media/gyvfo3xr/cso20251208_024fv2.jpg');
-- artist 784 필하모니아 합창단 (philharmoniachorus.co.uk)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.philharmoniachorus.co.uk/join/members', 'https://boxstuff-development-thumbnails.s3.amazonaws.com/510881_orig.jpg', 'philharmoniachorus.co.uk', NULL, NULL, NULL, '50% 40%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 784 AND artist.english_name = 'Philharmonia Chorus' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://boxstuff-development-thumbnails.s3.amazonaws.com/510881_orig.jpg');
-- artist 785 미하엘 길렌 (Jüdische Allgemeine · imago)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.juedische-allgemeine.de/kultur/mutiger-erneuerer-am-taktstock', 'https://www.juedische-allgemeine.de/wp-content/uploads/2019/03/imago60979309h-2880x1440-2320x1160-c-default.jpg', 'Jüdische Allgemeine · imago', NULL, NULL, NULL, '60% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 785 AND artist.english_name = 'Michael Gielen' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.juedische-allgemeine.de/wp-content/uploads/2019/03/imago60979309h-2880x1440-2320x1160-c-default.jpg');
-- artist 790 샌프란시스코 심포니 합창단 (San Francisco Symphony · Brandon Patoc)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.sfsymphony.org/About-SFS/Press-Room/Press-Kits/SFS-CHORUS', 'https://sfs.imgix.net/getmedia/900b3f28-f5a4-4e1c-b041-b7cfa78efbc1/2425-Concerts-JohnAdamsCarminaBurana-Brandon-Patoc_0059.jpg?w=2000&fm=jpg', 'San Francisco Symphony · Brandon Patoc', NULL, NULL, NULL, '50% 45%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 790 AND artist.english_name = 'San Francisco Symphony Chorus' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://sfs.imgix.net/getmedia/900b3f28-f5a4-4e1c-b041-b7cfa78efbc1/2425-Concerts-JohnAdamsCarminaBurana-Brandon-Patoc_0059.jpg?w=2000&fm=jpg');
-- artist 791 탱글우드 페스티벌 합창단 (bso.org · Hilary Scott)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.bso.org/profiles/tanglewood-festival-chorus', 'https://cdn.bso.org/uploads/TFC/8.22.26-Prelude-TFC-Zoie-Reams-Julia-Carey-Jean-S%C3%A9bastien-Vall%C3%A9e-Julien-Labro-Caleb-Quillen-2-Hilary-Scott.jpeg?fit=contain&height=2000&width=2000&s=yxIS7LxsOwcrzvhYqHCxzke4KveldHx4td-alX2G9So', 'bso.org · Hilary Scott', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 791 AND artist.english_name = 'Tanglewood Festival Chorus' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://cdn.bso.org/uploads/TFC/8.22.26-Prelude-TFC-Zoie-Reams-Julia-Carey-Jean-S%C3%A9bastien-Vall%C3%A9e-Julien-Labro-Caleb-Quillen-2-Hilary-Scott.jpeg?fit=contain&height=2000&width=2000&s=yxIS7LxsOwcrzvhYqHCxzke4KveldHx4td-alX2G9So');
-- artist 793 버밍엄 시립교향악단 합창단 (CBSO · Andrew Fox)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://cbso.co.uk/profile/cbso-chorus', 'https://cbso-orchestra.transforms.svdcdn.com/production/General/Choruses/Adult-Chorus/CBSO_22-09-20.AdultChorus2.crAndrewFox_2023-02-24-103452_bswe.jpg?w=1200&h=628&q=100&auto=format&fit=crop&dm=1677234898&s=f3a3d5f2db98dde49832e78d2052d0d8', 'CBSO · Andrew Fox', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 793 AND artist.english_name = 'City of Birmingham Symphony Chorus' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://cbso-orchestra.transforms.svdcdn.com/production/General/Choruses/Adult-Chorus/CBSO_22-09-20.AdultChorus2.crAndrewFox_2023-02-24-103452_bswe.jpg?w=1200&h=628&q=100&auto=format&fit=crop&dm=1677234898&s=f3a3d5f2db98dde49832e78d2052d0d8');
-- artist 797 라살 4중주단 (Willy Pragher)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Donaueschingen-_Donaueschinger_Musiktage;_La_Salle_Quartet_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._079694f.jpeg', 'https://upload.wikimedia.org/wikipedia/commons/6/67/Donaueschingen-_Donaueschinger_Musiktage%3B_La_Salle_Quartet_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._079694f.jpeg', NULL, 'Willy Pragher', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', '43% 20%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 797 AND artist.english_name = 'LaSalle Quartet' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/67/Donaueschingen-_Donaueschinger_Musiktage%3B_La_Salle_Quartet_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._079694f.jpeg');
-- artist 812 자샤 괴첼 (Vancouver Symphony Orchestra)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.vancouversymphony.ca/artist/sascha-goetzel/', 'https://www.vancouversymphony.ca/site-content/uploads/2019/02/ARTISTgoetzel.jpg', 'Vancouver Symphony Orchestra', NULL, NULL, NULL, '0% 27%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 812 AND artist.english_name = 'Sascha Goetzel' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.vancouversymphony.ca/site-content/uploads/2019/02/ARTISTgoetzel.jpg');
-- artist 813 보루산 이스탄불 필하모닉 오케스트라 (Borusan Sanat)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://borusansanat.com/en/bipo_vQ49/biography_YKGY/', 'https://borusansanat.com/img/microsite/borusan-istanbul-philharmonic-orchestra_bg.jpg', 'Borusan Sanat', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 813 AND artist.english_name = 'Borusan Istanbul Philharmonic Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://borusansanat.com/img/microsite/borusan-istanbul-philharmonic-orchestra_bg.jpg');
-- artist 822 존 윌리엄스 (Askonas Holt)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://askonasholt.com/artist/john-williams', 'https://cdn.sanity.io/images/ssnxcmsx/prod/5fac70c7ca4a179c63b6112d38bf80148f05bdbd-2508x1717.jpg?w=2400&q=85', 'Askonas Holt', NULL, NULL, NULL, '61% 1%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 822 AND artist.english_name = 'John Williams' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://cdn.sanity.io/images/ssnxcmsx/prod/5fac70c7ca4a179c63b6112d38bf80148f05bdbd-2508x1717.jpg?w=2400&q=85');
-- artist 827 세르히오 티엠포 (Luzerner Sinfonieorchester)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://sinfonieorchester.ch/en/artist/sergio-tiempo', 'https://sinfonieorchester.ch/wp-content/uploads/2023/12/Sergio-Tiempo_FB_cmyk-1.jpeg', 'Luzerner Sinfonieorchester', NULL, NULL, NULL, '100% 33%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 827 AND artist.english_name = 'Sergio Tiempo' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://sinfonieorchester.ch/wp-content/uploads/2023/12/Sergio-Tiempo_FB_cmyk-1.jpeg');
-- artist 833 쾰른 신 필하모닉 오케스트라 (junge-philharmonie-koeln.com)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.junge-philharmonie-koeln.com/', 'https://www.junge-philharmonie-koeln.com/resources/Beethoven_9th_JPK_Philharmonie.web.jpg', 'junge-philharmonie-koeln.com', NULL, NULL, NULL, '50% 55%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 833 AND artist.english_name = 'Cologne New Philharmonic Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.junge-philharmonie-koeln.com/resources/Beethoven_9th_JPK_Philharmonie.web.jpg');
-- artist 839 카를 리히터 (Deutsche Grammophon)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.deutschegrammophon.com/de/kuenstler-innen/karl-richter/pressestimmen/massstaeblich-karl-richter-dirigiert-bach-91495', 'https://images.universal-music.de/img/assets/504/504166/995/2048/karl-richter.jpg', 'Deutsche Grammophon', NULL, NULL, NULL, '5% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 839 AND artist.english_name = 'Karl Richter' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://images.universal-music.de/img/assets/504/504166/995/2048/karl-richter.jpg');
-- artist 841 로저 노링턴 (Bachtrack · Manfred Esser)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://bachtrack.com/news-roger-norrington-obituary-july-2025', 'https://cdn.bachtrack.com/files/439491-180411-sir-roger-norrington-credit-manfred-esser.jpg', 'Bachtrack · Manfred Esser', NULL, NULL, NULL, '49% 27%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 841 AND artist.english_name = 'Roger Norrington' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://cdn.bachtrack.com/files/439491-180411-sir-roger-norrington-credit-manfred-esser.jpg');
-- artist 855 새뮤얼 레이미 (L2 Artists)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.l2artists.com/samuel-ramey/', 'https://www.l2artists.com/wp-content/uploads/2020/10/Ramey9.jpg', 'L2 Artists', NULL, NULL, NULL, '50% 27%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 855 AND artist.english_name = 'Samuel Ramey' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.l2artists.com/wp-content/uploads/2020/10/Ramey9.jpg');
-- artist 861 안네 소피 폰 오터 (Digital Concert Hall (Berliner Philharmoniker))
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://digitalconcerthall.com/en/artist/410', 'https://images.digitalconcerthall.com/cms/thumbnails/2046x1064/images/core/3e651c5fc2d3da5b226747a48994bfdb.jpg', 'Digital Concert Hall (Berliner Philharmoniker)', NULL, NULL, NULL, '41% 38%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 861 AND artist.english_name = 'Anne Sofie von Otter' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://images.digitalconcerthall.com/cms/thumbnails/2046x1064/images/core/3e651c5fc2d3da5b226747a48994bfdb.jpg');
-- artist 862 레오폴드 스토코프스키 (Playbill)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://playbill.com/article/how-conductor-leopold-stokowski-popularized-orchestral-music-in-america', 'https://assets.playbill.com/editorial/42242ab0e5061c25c9b13c9777e46c4e-leopold-stokowski-hr.jpg', 'Playbill', NULL, NULL, NULL, '51% 10%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 862 AND artist.english_name = 'Leopold Stokowski' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://assets.playbill.com/editorial/42242ab0e5061c25c9b13c9777e46c4e-leopold-stokowski-hr.jpg');
-- artist 865 아그네스 발차 (To Vima · AP Photo/Petros Giannakouris)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.tovima.com/culture/greek-national-opera-hosts-international-opera-awards-for-the-first-time', 'https://www.tovima.com/wp-content/uploads/2025/11/14/AP25318056836528-2048x1365.jpg', 'To Vima · AP Photo/Petros Giannakouris', NULL, NULL, NULL, '52% 40%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 865 AND artist.english_name = 'Agnes Baltsa' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.tovima.com/wp-content/uploads/2025/11/14/AP25318056836528-2048x1365.jpg');
-- artist 878 이 무지치 (imusici.info)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.imusici.info/media.php', 'https://www.imusici.info/media/i_musici1.jpg', 'imusici.info', NULL, NULL, NULL, '70% 37%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 878 AND artist.english_name = 'I Musici' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.imusici.info/media/i_musici1.jpg');
