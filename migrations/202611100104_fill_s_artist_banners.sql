-- 배너가 없던 S 연주자의 화면 머리 배너(공식 사이트·음반사·대행사·공연장 페이지의 보도용 사진).
-- 원본: seed_pipeline/curation/s-artist-banners-2026-11-10/ (gen_sql.py 로 만든다).
-- 자유 라이선스가 아니다. credit_line 에 출처 이름, source_url 에 출처 페이지를 남기고,
-- 권리자가 요청하면 그 줄을 RETIRED 로 내린다. 공개 배너가 하나도 없을 때만 넣는다.
-- artist 264 레오니다스 카바코스 (leonidaskavakos.com · Marco Borggreve)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.leonidaskavakos.com/', 'https://www.leonidaskavakos.com/wp-content/uploads/2025/01/Leonidas_Kavakos_credit_Marco_Borggreve_8-scaled.jpg', 'leonidaskavakos.com · Marco Borggreve', '41% 20%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 264 AND artist.english_name = 'Leonidas Kavakos' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.leonidaskavakos.com/wp-content/uploads/2025/01/Leonidas_Kavakos_credit_Marco_Borggreve_8-scaled.jpg');
-- artist 346 마린스키 극장 오케스트라 (Intermusica)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://intermusica.com/international-tours/Orchestra-Mariinsky-Theater', 'https://www.intermusica.co.uk/assets/images/1440/10000/marnisky_header.jpg', 'Intermusica', '50% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 346 AND artist.english_name = 'Mariinsky Theatre Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.intermusica.co.uk/assets/images/1440/10000/marnisky_header.jpg');
-- artist 361 메트로폴리탄 오페라 오케스트라 (Askonas Holt)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://askonasholt.com/tour/the-met-orchestra', 'https://cdn.sanity.io/images/ssnxcmsx/prod/8ed1dbebabcd6993e778f5ceab02ef72097dc5e3-7296x4866.jpg?w=2560&q=80', 'Askonas Holt', '50% 45%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 361 AND artist.english_name = 'Metropolitan Opera Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://cdn.sanity.io/images/ssnxcmsx/prod/8ed1dbebabcd6993e778f5ceab02ef72097dc5e3-7296x4866.jpg?w=2560&q=80');
-- artist 646 하인리히 시프 (Slippedisc)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://slippedisc.com/2016/12/tragic-news-a-great-cellist-has-died-at-65/', 'https://slippedisc.com/wp-content/uploads/2016/12/heinrich-schiff.jpg', 'Slippedisc', '47% 14%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 646 AND artist.english_name = 'Heinrich Schiff' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://slippedisc.com/wp-content/uploads/2016/12/heinrich-schiff.jpg');
-- artist 655 라파엘 프뤼베크 데 부르고스 (Eloquence Classics)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.eloquenceclassics.com/celebrating-the-legacy-of-rafael-fruhbeck-de-burgos/', 'https://www.eloquenceclassics.com/wp-content/uploads/sites/1141/2025/05/Features-1-compressed.jpg', 'Eloquence Classics', '85% 10%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 655 AND artist.english_name = 'Rafael Frühbeck de Burgos' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.eloquenceclassics.com/wp-content/uploads/sites/1141/2025/05/Features-1-compressed.jpg');
-- artist 657 라 스칼라 극장 합창단 (Teatro alla Scala · Brescia e Amisano)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.teatroallascala.org/en/the-theater/chorus/chorus.html', 'https://www.teatroallascala.org/static/upload/724/724574badg-ph-brescia-e-amisano--teatro-alla-scala.preset-.jpg', 'Teatro alla Scala · Brescia e Amisano', '50% 90%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 657 AND artist.english_name = 'Coro del Teatro alla Scala' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.teatroallascala.org/static/upload/724/724574badg-ph-brescia-e-amisano--teatro-alla-scala.preset-.jpg');
-- artist 660 바이로이트 축제 관현악단 (Bayreuther Festspiele)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.bayreuther-festspiele.de/en/contributors/festival-orchestra/', 'https://www.bayreuther-festspiele.de/wp-content/uploads/2025/08/orchester-sw.webp', 'Bayreuther Festspiele', '50% 35%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 660 AND artist.english_name = 'Bayreuther Festspielorchester' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.bayreuther-festspiele.de/wp-content/uploads/2025/08/orchester-sw.webp');
-- artist 673 일레아나 코트루바슈 (Bucharest National Opera (Bachtrack))
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://bachtrack.com/news-ileana-cotrubas-obituary-august-2026', 'https://cdn.bachtrack.com/wfiles/502776-ileana-cotrubas-c-bucharest-national-opera.webp', 'Bucharest National Opera (Bachtrack)', '40% 68%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 673 AND artist.english_name = 'Ileana Cotrubaș' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://cdn.bachtrack.com/wfiles/502776-ileana-cotrubas-c-bucharest-national-opera.webp');
-- artist 677 로열 오페라하우스 관현악단 (Royal Ballet and Opera)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.rbo.org.uk/about/orchestra', 'https://images.prismic.io/royal-opera-house/9a8aa6fa-2baf-41dc-a140-0f1dd4023675_ROHOrchestraOct+2022002.jpg?auto=compress', 'Royal Ballet and Opera', '50% 80%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 677 AND artist.english_name = 'Orchestra of the Royal Opera House' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://images.prismic.io/royal-opera-house/9a8aa6fa-2baf-41dc-a140-0f1dd4023675_ROHOrchestraOct+2022002.jpg?auto=compress');
-- artist 680 산타 체칠리아 국립음악원 관현악단 (Accademia Nazionale di Santa Cecilia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://santacecilia.it/orchestra-e-coro/', 'https://santacecilia.it/wp-content/uploads/2024/10/Orchestra-1920.jpg', 'Accademia Nazionale di Santa Cecilia', '50% 70%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 680 AND artist.english_name = 'Orchestra dell''Accademia Nazionale di Santa Cecilia' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://santacecilia.it/wp-content/uploads/2024/10/Orchestra-1920.jpg');
-- artist 683 그레이엄 존슨 (Podularity)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://podularity.com/2014/10/30/1985/', 'https://podularity.com/wp-content/uploads/2014/10/Graham-Johnson-b-and-wh-002.jpg', 'Podularity', '46% 31%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 683 AND artist.english_name = 'Graham Johnson' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://podularity.com/wp-content/uploads/2014/10/Graham-Johnson-b-and-wh-002.jpg');
-- artist 685 마거릿 프라이스 (Warner Classics)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://www.warnerclassics.com/artist/margaret-price', 'https://www.warnerclassics.com/sites/default/files/H553380.jpg', 'Warner Classics', '62% 37%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 685 AND artist.english_name = 'Margaret Price' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://www.warnerclassics.com/sites/default/files/H553380.jpg');
