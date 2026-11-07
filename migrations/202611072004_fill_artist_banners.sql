-- 아티스트 화면 머리 배너(위키미디어 공용, 자유 라이선스). 원본: seed_pipeline/curation/artist-banners-2026-11-07/
-- gen_sql.py 로 만든다. 연주자당 하나, 대표·공개로 넣는다.
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Herbert_von_Karajan_Conducts_in_NHK_Symphony_Orchestra,_Tokyo_1954_(02)_Scan10016.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Herbert_von_Karajan_Conducts_in_NHK_Symphony_Orchestra%2C_Tokyo_1954_%2802%29_Scan10016.jpg', '船山克 (Katsu Funayama) 朝日新聞社 (Asahi Shinbun Publishing Co., LTD. Tokyo Japan)', 'Public domain', NULL, '50% 20%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 422 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Holland_Festival_dirigent_Leonard_Bernstein_zal_het_met_het_Concertgebouworkes,_Bestanddeelnr_933-3399.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/5b/Holland_Festival_dirigent_Leonard_Bernstein_zal_het_met_het_Concertgebouworkes%2C_Bestanddeelnr_933-3399.jpg', 'Sjakkelien Vollebregt', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', '50% 22%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 605 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Foto_di_scena_%22_Al_gran_sole_carico_d%27amore%22.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/c7/Foto_di_scena_%22_Al_gran_sole_carico_d%27amore%22.jpg', 'Pier Paolo Paoletti', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 594 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Muti_prova_con_l%27OGI.tif', 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Muti_prova_con_l%27OGI.tif/lossy-page1-1920px-Muti_prova_con_l%27OGI.tif.jpg', 'Nicola (CeDoMus)', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 427 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Charles_Dutoit_1987_Bamberg-19870114-RM-104231.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/c0/Charles_Dutoit_1987_Bamberg-19870114-RM-104231.jpg', 'Ermell', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '50% 35%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 581 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Bernhard_Haitink_neemt_afscheid_als_chef-dirigent_van_Concertgebouworkest_Bernh,_Bestanddeelnr_934-2312.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/68/Bernhard_Haitink_neemt_afscheid_als_chef-dirigent_van_Concertgebouworkest_Bernh%2C_Bestanddeelnr_934-2312.jpg', 'Rob Croes for Anefo', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 408 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Lang-Lang.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/30/Lang-Lang.jpg', 'SAMA990', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '45% 35%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 200 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Evgeny_Kissin,_interview_with_G._Henle_Verlag,_seated_against_black_background_(September_2019).jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/62/Evgeny_Kissin%2C_interview_with_G._Henle_Verlag%2C_seated_against_black_background_%28September_2019%29.jpg', 'Henleverlag', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', '45% 45%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 206 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:2026.07.26._Marc_Laforet_Photo_Mariusz_Kubik_11.JPG', 'https://upload.wikimedia.org/wikipedia/commons/9/9f/2026.07.26._Marc_Laforet_Photo_Mariusz_Kubik_11.JPG', 'Mariusz Kubik', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', '55% 15%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 370 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:85QM_Scala-Chailly_(5)_(53952778335).jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/8b/85QM_Scala-Chailly_%285%29_%2853952778335%29.jpg', 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '55% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 290 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Vienna_Philharmonic_Orchestra,_Carnegie_Hall,_conducted_by_Michael_Tilson_Thomas_(46396170015).jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/45/Vienna_Philharmonic_Orchestra%2C_Carnegie_Hall%2C_conducted_by_Michael_Tilson_Thomas_%2846396170015%29.jpg', 'Steven Pisano', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '35% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 630 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Verleihung_Konrad-Adenauer-Preis_der_Stadt_K%C3%B6ln_2019_an_Daniel_Barenboim-9423.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/8e/Verleihung_Konrad-Adenauer-Preis_der_Stadt_K%C3%B6ln_2019_an_Daniel_Barenboim-9423.jpg', 'Raimond Spekking', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '40% 15%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 632 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Simon_Rattle.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Simon_Rattle.jpg', 'Ceskafilharmonie', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '40% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 220 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Anne-Sophie_Mutter_(2021)_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/50/Anne-Sophie_Mutter_%282021%29_%28cropped%29.jpg', 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '45% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 211 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Luxemburgo%2B_Yuja_Wang09_(51354474100)_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/df/Luxemburgo%2B_Yuja_Wang09_%2851354474100%29_%28cropped%29.jpg', 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '40% 20%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 201 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Maestro_Mariss_Jansons,_wahrscheinlich_bester_lebender_Dirigent_(19469692152).jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Maestro_Mariss_Jansons%2C_wahrscheinlich_bester_lebender_Dirigent_%2819469692152%29.jpg', 'Franz Johann Morgenbesser from Vienna, Austria', 'CC BY-SA 2.0', 'https://creativecommons.org/licenses/by-sa/2.0', '45% 35%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 288 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Krystian_Zimerman_2018.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/81/Krystian_Zimerman_2018.jpg', 'Bartłomiej Barczyk', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '50% 25%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 366 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Concertpianist_Vladimir_Horowitz_in_Concertgebouw_in_Amsterdam_Horowitz_na_aflo,_Bestanddeelnr_933-8218.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/85/Concertpianist_Vladimir_Horowitz_in_Concertgebouw_in_Amsterdam_Horowitz_na_aflo%2C_Bestanddeelnr_933-8218.jpg', 'Roland Gerrits / Anefo', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', '50% 35%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 367 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Jessye_Norman_and_Zubin_Mehta,_1973.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/03/Jessye_Norman_and_Zubin_Mehta%2C_1973.jpg', 'Larry Bessel, Los Angeles Times', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', '70% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 574 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:The_Emerson_String_Quartet_2014.jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/1d/The_Emerson_String_Quartet_2014.jpg', 'Ralph Daily', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '50% 5%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 607 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Daniil_Trifonov.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/99/Daniil_Trifonov.jpg', 'Ceskafilharmonie', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '40% 40%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 202 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Andras_schiff.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d0/Andras_schiff.jpg', 'Steve Bowbrick', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '45% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 208 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Joshua_Bell.JPG', 'https://upload.wikimedia.org/wikipedia/commons/b/b3/Joshua_Bell.JPG', 'Alexduff', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', '40% 20%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 210 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:MX_MM_YO-YOMA_-_33600527678.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/9b/MX_MM_YO-YOMA_-_33600527678.jpg', 'Secretaría de Cultura de la Ciudad de México', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '50% 35%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 215 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Gustavo_Dudamel_(6664702053).jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f7/Gustavo_Dudamel_%286664702053%29.jpg', 'Anyul Rivas from Los Teques, Venezuela', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '45% 20%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 218 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Gergiev%27s_concert_(2009-04-21)_02.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/99/Gergiev%27s_concert_%282009-04-21%29_02.jpg', 'Сергей Ермолаев', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', '45% 15%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 289 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Yundi2014122802.jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/17/Yundi2014122802.jpg', 'Sailing82', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '45% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 568 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Kyung-wha_Chung_at_SSO_(20151005224117).jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Kyung-wha_Chung_at_SSO_%2820151005224117%29.jpg', 'N509FZ', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '30% 35%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 234 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Jan_Lisiecki_on_stage_in_2019.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/b3/Jan_Lisiecki_on_stage_in_2019.jpg', 'Sideralis', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '45% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 257 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Khatia_Buniatishvili_-_Global_Citizen_Festival_Hamburg_03.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/81/Khatia_Buniatishvili_-_Global_Citizen_Festival_Hamburg_03.jpg', 'Frank Schwichtenberg', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '40% 35%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 564 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:2015._%D0%94%D0%BE%D0%BD%D0%B5%D1%86%D0%BA_084.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/4c/2015._%D0%94%D0%BE%D0%BD%D0%B5%D1%86%D0%BA_084.jpg', 'Andrey Butko', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', '35% 20%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 567 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:James_Levine_(11937897623).jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/5f/James_Levine_%2811937897623%29.jpg', 'Ralph Daily from Birmingham, United States', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '50% 15%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 782 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Bremen-_Hahn18.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/7a/Bremen-_Hahn18.jpg', 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '55% 10%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 209 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Internationaal_Kamermuziek_Festival_Utrecht_2019_(49311436872)_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/30/Internationaal_Kamermuziek_Festival_Utrecht_2019_%2849311436872%29_%28cropped%29.jpg', 'Eric de Redelijkheid from Utrecht, Netherlands', 'CC BY-SA 2.0', 'https://creativecommons.org/licenses/by-sa/2.0', '45% 15%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 212 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Yannick_N%C3%A9zet-S%C3%A9guin_2011.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Yannick_N%C3%A9zet-S%C3%A9guin_2011.jpg', 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '40% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 219 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Bruce_Liu001_(53896792821).jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/13/Bruce_Liu001_%2853896792821%29.jpg', 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '50% 40%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 228 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Kennedy_Center_Awards_Honors_Dinner_2023128.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Kennedy_Center_Awards_Honors_Dinner_2023128.jpg', 'U.S. Department of State', 'Public domain', NULL, '40% 35%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 295 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Angela_Hewitt_Toronto2017.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d7/Angela_Hewitt_Toronto2017.jpg', 'Mykola Swarnyk', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', '45% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 541 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Maazel_08.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/c6/Maazel_08.jpg', 'Barbara Haws at English Wikipedia (Uploader claims to be ''Chris Lee''.)', 'CC BY 2.5', 'https://creativecommons.org/licenses/by/2.5', '45% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 736 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:The_Philadelphia_Orchestra,_Ormandy,_at_the_Palais_de_Chaillot_-_DPLA_-_a276b865989592e04652a628dfbdf3dd.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/34/The_Philadelphia_Orchestra%2C_Ormandy%2C_at_the_Palais_de_Chaillot_-_DPLA_-_a276b865989592e04652a628dfbdf3dd.jpg', 'Department of State. Agency for International Development. 1961-10/1/1979', 'Public domain', NULL, '35% 40%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 752 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Leonard_slatkin_2015.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a6/Leonard_slatkin_2015.jpg', 'KokotheDog', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 775 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:CLARA-JUMI_KANG_(Violinist).jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/42/CLARA-JUMI_KANG_%28Violinist%29.jpg', 'Republic of Korea', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '45% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 191 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Nobuyuki_Tsujii_in_California,_U.S.A.,_May_2014.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/0e/Nobuyuki_Tsujii_in_California%2C_U.S.A.%2C_May_2014.jpg', 'Mlliu2006', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '70% 25%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 227 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Stephen_Hough03_(51387033442).jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/a1/Stephen_Hough03_%2851387033442%29.jpg', 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '35% 10%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 261 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Jonas_Kaufmann,_Waldb%C3%BChne_Berlin,_2018.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/bb/Jonas_Kaufmann%2C_Waldb%C3%BChne_Berlin%2C_2018.jpg', 'Marcello Curto', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '38% 40%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 300 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:%D0%93%D0%B0%D0%BB%D0%B0-%D0%BA%D0%BE%D0%BD%D1%86%D0%B5%D1%80%D1%82_%D0%B7%D0%B0%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D1%8F_%D0%91%D0%A4_04.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/4d/%D0%93%D0%B0%D0%BB%D0%B0-%D0%BA%D0%BE%D0%BD%D1%86%D0%B5%D1%80%D1%82_%D0%B7%D0%B0%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D1%8F_%D0%91%D0%A4_04.jpg', 'Alexander Frolov', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '52% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 565 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:14-05-05-placido-domingo-RalfR-1.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/0f/14-05-05-placido-domingo-RalfR-1.jpg', 'Ralf Roletschek', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', '45% 15%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 674 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Chirstoph_Eschenbach_-19850615-RM-100629.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/be/Chirstoph_Eschenbach_-19850615-RM-100629.jpg', 'Ermell', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '45% 25%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 684 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Gala-Nacht_des_Sports_2013_Wien_show_Jos%C3%A9_Carreras_2.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/c4/Gala-Nacht_des_Sports_2013_Wien_show_Jos%C3%A9_Carreras_2.jpg', 'Manfred Werner / Tsui', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', '40% 35%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 825 AND artist.authority_entity_id IS NOT NULL;
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Grigory-Sokolov-1967-a.jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f4/Grigory-Sokolov-1967-a.jpg', 'AnonymousUnknown author / Hannu Heikinheimon arkisto', 'Public domain', NULL, '70% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 205 AND artist.authority_entity_id IS NOT NULL;
