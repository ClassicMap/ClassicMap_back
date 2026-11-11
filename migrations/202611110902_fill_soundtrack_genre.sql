-- 영화·드라마·게임 음악 작품에 장르 사운드트랙(screen)·형식 soundtrack 을 붙인다.
-- 제목에 사운드트랙·영화음악 등 209, Soundtrack 갈래 음반 묶음 18, 그 세트 안 곡 1755.
-- 작곡가별(세트 안 곡 빼고): Bear McCreary 66, Dmitri Shostakovich 30, Nino Rota 30, Bernard Herrmann 16, Philip Glass 13, Michael Nyman 13, Terry Plumeri 10, Sergei Prokofiev 9, Ralph Vaughan Williams 7, Jóhann Jóhannsson 7, Benjamin Britten 4, George Gershwin 3, Wojciech Kilar 3, Shigeaki Saegusa 2, Marco Frisina 2, Camille Saint-Saëns 1, Astor Piazzolla 1, Francis Poulenc 1, Mina Kubota 1, Kazimierz Serocki 1, Bruno Maderna 1, Leo Brouwer 1, Peter Maxwell Davies 1, Harold Budd 1, Waldemar Kazanecki 1, Joonas Kokkonen 1, Goffredo Petrassi 1
-- 생성기: seed_pipeline/curation/soundtrack-genre-2026-11-11/build.py. 장르·형식이 비어 있을 때만 바꾼다.

UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 355 AND composer_id = 93 AND title = '영화 <디 아워스> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 416 AND composer_id = 111 AND title = '영화 <대부> 사운드트랙 (사랑의 테마)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 417 AND composer_id = 111 AND title = '영화 <로미오와 줄리엣 (1968)> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 418 AND composer_id = 111 AND title = '영화 <라 스트라다> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 419 AND composer_id = 112 AND title = '영화 <사이코> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 420 AND composer_id = 112 AND title = '영화 <현기증> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 421 AND composer_id = 112 AND title = '영화 <택시 드라이버> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 1632 AND composer_id = 86 AND title = '영화음악 <A Damsel in Distress>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 1772 AND composer_id = 94 AND title = '영화음악 <An American in England>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 1785 AND composer_id = 60 AND title = '영화 음악 <기즈 공의 암살>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 1848 AND composer_id = 94 AND title = '영화음악 <Night Mail>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 2184 AND composer_id = 94 AND title = '영화음악 <Love From a Stranger>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 2748 AND composer_id = 94 AND title = '영화음악 <The Way to the Sea>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7447 AND composer_id = 111 AND title = '영화음악 <8½>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7503 AND composer_id = 111 AND title = '영화음악 <The Glass Mountain>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7656 AND composer_id = 111 AND title = '영화 <오케스트라 리허설> 사운드트랙 중 "Galopp"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7657 AND composer_id = 111 AND title = '영화 <오케스트라 리허설> 사운드트랙 중 "I gemelli allo specchio"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7658 AND composer_id = 111 AND title = '영화 <오케스트라 리허설> 사운드트랙 중 "Valzerino n. 72"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7694 AND composer_id = 69 AND title = '영화음악 <The Loves of Joanna Godden>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7738 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Woodland"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7755 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Christina, the Queen"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7763 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Sultan''s Feast"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7788 AND composer_id = 111 AND title = '영화 <Fortunella> 사운드트랙 중 "Fortunella scappa da casa"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7797 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Pago-Pago Jazz"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7800 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙 중 "Kane Meets Susan / Susan''s Room / Mother Memory"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7803 AND composer_id = 112 AND title = '영화음악 <The Day the Earth Stood Still>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7806 AND composer_id = 111 AND title = '영화 <로마> 사운드트랙 중 "Feast of the Snails"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7809 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Nightmare"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7818 AND composer_id = 112 AND title = '영화 <사이코> 사운드트랙 중 "The Cellar, Part 1"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7822 AND composer_id = 111 AND title = '영화 <대부 3> 사운드트랙 중 "The Immigrant"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7830 AND composer_id = 111 AND title = '영화 <대부> 사운드트랙 중 "The Halls of Fear"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7841 AND composer_id = 69 AND title = '영화음악 <The 49th Parallel>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7850 AND composer_id = 111 AND title = '영화 <카사노바> 사운드트랙 중 "L''Oiseau magique à Paris"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7851 AND composer_id = 111 AND title = 'Plein soleil 중 "Thème de marge"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7863 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "The Bedroom"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7881 AND composer_id = 111 AND title = '영화 <전쟁과 평화> 사운드트랙 중 "The Charge of the Cavalry and the Wounded"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7890 AND composer_id = 111 AND title = '영화 <나폴레옹> 사운드트랙 중 "Medley: La voce della guerra / I tredici quadrati / How Can It Be?"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7905 AND composer_id = 112 AND title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "The Home / Sorrow"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7910 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7911 AND composer_id = 111 AND title = '영화 <대부> 사운드트랙 중 "The New Godfather"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7924 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "Love?"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7927 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Il trionfo del nuovo cesare"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7940 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Transformation"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7954 AND composer_id = 111 AND title = '영화 <Fortunella> 사운드트랙 중 "Fortunella all''ospedale"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7955 AND composer_id = 111 AND title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Canzone appassionata"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7966 AND composer_id = 111 AND title = '영화 <Fortunella> 사운드트랙 중 "La corona della pricipessa"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7978 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Jazz in Dockland"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7983 AND composer_id = 111 AND title = '영화 <달콤한 인생> 사운드트랙 중 "Via Veneto e i nobili"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7984 AND composer_id = 112 AND title = 'A Child Is Born (음반) 중 "Part 2"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 7997 AND composer_id = 111 AND title = 'Plein soleil 중 "Le Yacht"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8008 AND composer_id = 112 AND title = '영화음악 <Jason and the Argonauts>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8019 AND composer_id = 93 AND title = '영화음악 <Kundun>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8041 AND composer_id = 111 AND title = 'Chansons pour Fellini 중 "Il canto della buranella"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8042 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Old House"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8052 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Cyclops"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8082 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Katopua"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8097 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "Happiness"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8103 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Cyclops'' Death"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8105 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "Teddy Bear Wired"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8111 AND composer_id = 111 AND title = '영화 <Il brigante> 사운드트랙 중 "Risveglio notturno e attesa nei campi"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8122 AND composer_id = 111 AND title = '영화 <카사노바> 사운드트랙 중 "Chant de la Buranella"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8152 AND composer_id = 93 AND title = '영화음악 <Dracula>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8159 AND composer_id = 111 AND title = '영화 <Fortunella> 사운드트랙 중 "Al mercato"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8165 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙 중 "The Trip to Susan''s / Getty''s Departure / Kane Marries"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8178 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "The Temple of Karnak"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8200 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "The Nightmare"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8222 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "The Doll Queen"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8230 AND composer_id = 111 AND title = 'Plein soleil 중 "Final"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8232 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Oath"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8245 AND composer_id = 112 AND title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "The Lights / Bedtime"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8262 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Fight With The Roc"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8274 AND composer_id = 111 AND title = '영화 <Fortunella> 사운드트랙 중 "Fortunella e professore"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8287 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙 중 "Beneath the 12-Mile Reef"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8314 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "Alchemy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8316 AND composer_id = 111 AND title = '영화 <로코와 그 형제들> 사운드트랙 중 "Il delitto di Simone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8317 AND composer_id = 111 AND title = '영화 <로마> 사운드트랙 중 "Aria di Roma"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8325 AND composer_id = 111 AND title = '영화 <로마> 사운드트랙 중 "Ecclesiastical Fashion Show"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8329 AND composer_id = 111 AND title = '영화 <영혼의 줄리에타> 사운드트랙 중 "L''arcobaleno per Giulietta"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8350 AND composer_id = 111 AND title = '영화 <아마코드> 사운드트랙 중 "Quanto mi piace la Gradisca"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8356 AND composer_id = 111 AND title = 'Plein soleil 중 "Générique"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8360 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Egg"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8366 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Night Delirium"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8379 AND composer_id = 111 AND title = '영화 <카사노바> 사운드트랙 중 "Le Duc de Wurttemberg"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8401 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Mio amato gitone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8425 AND composer_id = 69 AND title = '영화음악 <The Flemish Farm>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8445 AND composer_id = 111 AND title = 'Chansons pour Fellini 중 "Otto e mezzo"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8460 AND composer_id = 111 AND title = '영화 <대부 3> 사운드트랙 중 "Michael''s Letter"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8490 AND composer_id = 111 AND title = 'Plein soleil 중 "Falsification"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8510 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Vase"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8544 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "La nuova isola"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8551 AND composer_id = 111 AND title = '영화 <Il brigante> 사운드트랙 중 "Pataro"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8555 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Christina and the Drawn Up Troops"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8556 AND composer_id = 111 AND title = '영화 <Il brigante> 사운드트랙 중 "Miliella"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8564 AND composer_id = 111 AND title = '영화 <대부 2> 사운드트랙 중 "Remember Vito Andolini"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8573 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Request"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8576 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Birgitto, the Dwarf"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8581 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙 중 "Kane''s Picnic / Susan Leaves"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8583 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Christina''s Decision"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8584 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "Captain''s Death"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8585 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙 중 "Thatcher Library (Litany) / Ms. Reading & Snow Picture / Mother''s Sacrifice / Charlie Meets Thatcher"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8591 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "The Renouncement"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8600 AND composer_id = 111 AND title = '영화 <Fortunella> 사운드트랙 중 "Evviva la principessa!"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8618 AND composer_id = 111 AND title = '영화 <전쟁과 평화> 사운드트랙 중 "The Orgy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8621 AND composer_id = 111 AND title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Il teatrino delle suore"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8647 AND composer_id = 112 AND title = '영화음악 <Hangover Square>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8686 AND composer_id = 111 AND title = '영화 <카사노바> 사운드트랙 중 "L''Oiseau magique"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8687 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "The Road"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8706 AND composer_id = 111 AND title = '영화 <표범> 사운드트랙 중 "Giovani eroi (marchetta)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8743 AND composer_id = 111 AND title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Raquel (End Credits)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8746 AND composer_id = 111 AND title = '영화 <나폴레옹> 사운드트랙 중 "E la guerra continua (titoli finali)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8751 AND composer_id = 112 AND title = '영화 <사이코> 사운드트랙 중 "The Discovery"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8759 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Cardinals"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8774 AND composer_id = 111 AND title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Amara me"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8787 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙 중 "White Witch Doctor"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8797 AND composer_id = 112 AND title = '영화음악 <The Trouble With Harry>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8811 AND composer_id = 111 AND title = 'Plein soleil 중 "Face au miroir"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8814 AND composer_id = 111 AND title = '영화 <Fortunella> 사운드트랙 중 "Titoli"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8823 AND composer_id = 111 AND title = '영화 <전쟁과 평화> 사운드트랙 중 "Winter and the Remembrance of Andrei"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8827 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "Cady Meets the Girls"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8830 AND composer_id = 111 AND title = 'Plein soleil 중 "Tarentelle meurtrière"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8836 AND composer_id = 111 AND title = '영화 <로마> 사운드트랙 중 "Vitelloni''s Bar"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8843 AND composer_id = 111 AND title = '영화 <로코와 그 형제들> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8856 AND composer_id = 111 AND title = '영화 <카사노바> 사운드트랙 중 "Pin Penin"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8857 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Love in Blossom"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8862 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Coronation Percussion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8863 AND composer_id = 111 AND title = '영화 <나폴레옹> 사운드트랙 중 "Il campo dei morti"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8870 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "A Hatful of Fish"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8872 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "Tender is the Night: The Embrace"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8891 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Il minotauro"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8898 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "The Vatican"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8904 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "The Carriage Ride"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8915 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Matangi and Charlotte''s Escape"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8922 AND composer_id = 112 AND title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "Lucia / Dictation / Boyhood''s End / Pastoral"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8936 AND composer_id = 111 AND title = '영화 <표범> 사운드트랙 중 "Valzer del commiato"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8938 AND composer_id = 111 AND title = '영화 <표범> 사운드트랙 중 "Viaggio a Donnafugata"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8940 AND composer_id = 93 AND title = '영화음악 <Bent>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8950 AND composer_id = 111 AND title = '영화 <카사노바> 사운드트랙 중 "Déjeuner chez la Marquise Durfé"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8951 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "Drive"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8952 AND composer_id = 111 AND title = '영화 <달콤한 인생> 사운드트랙 중 "Blues – La dolce vita dei nobili"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8959 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Capture"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8983 AND composer_id = 111 AND title = '영화 <나폴레옹> 사운드트랙 중 "Gli Scots Greys"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8988 AND composer_id = 111 AND title = '영화 <Il brigante> 사운드트랙 중 "La vigilia della rivolta"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 8998 AND composer_id = 69 AND title = '영화음악 <The Dim Little Island>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9004 AND composer_id = 111 AND title = '영화 <나폴레옹> 사운드트랙 중 "Medley: La Vieille Garde / I prussiani / Wellington (Now It''s Your Time!)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9007 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙 중 "Susan in Night Club (Rain Sequence)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9020 AND composer_id = 111 AND title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Valzerino del nonno"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9024 AND composer_id = 111 AND title = '영화 <나폴레옹> 사운드트랙 중 "Medley: Marcia scozzese / Saluto a Wellington e Promenade-Music"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9027 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Mi ascolti, gitone?"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9038 AND composer_id = 111 AND title = '영화 <사기꾼들> 사운드트랙 중 "In viaggio per un bidone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9039 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "Camels and Donkeys"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9042 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Prophesy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9047 AND composer_id = 111 AND title = '영화 <표범> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9051 AND composer_id = 111 AND title = '영화 <로코와 그 형제들> 사운드트랙 중 "Milano e Nadia"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9052 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "The Reading"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9055 AND composer_id = 111 AND title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Mi basta chiudere gli occhi - ecco i diavoli"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9058 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙 중 "Opera Montage"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9072 AND composer_id = 111 AND title = 'Chansons pour Fellini 중 "Maggie"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9075 AND composer_id = 111 AND title = '영화 <카사노바> 사운드트랙 중 "L''Oiseau magique à Dresde"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9078 AND composer_id = 112 AND title = '영화 <사이코> 사운드트랙 중 "The Clean Up"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9081 AND composer_id = 111 AND title = '영화 <사기꾼들> 사운드트랙 중 "Al cinema"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9082 AND composer_id = 111 AND title = 'Chansons pour Fellini 중 "Lla ri llira"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9117 AND composer_id = 111 AND title = '영화 <대부> 사운드트랙 중 "Apollonia"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9124 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Matangi''s Escape"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9144 AND composer_id = 107 AND title = '영화음악 <Le Voyage en Amérique, Original Film Score FP 149>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9165 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "Minuetto"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9171 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "Kersek Killed"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9173 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "The Man in the Grey Flannel Suit: Main Title"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9188 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙 중 "Dissolve to Thatcher / Second Ms. / Bernstein''s Narration"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9189 AND composer_id = 111 AND title = '영화 <대부> 사운드트랙 중 "The Pickup"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9197 AND composer_id = 111 AND title = '영화 <표범> 사운드트랙 중 "Entrata di Angelica, L''amore di Tancredi e Angelica, Finale"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9204 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Bruckner''s Death"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9213 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Princess"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9229 AND composer_id = 111 AND title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Il giardino delle fate"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9234 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Madejà-periamdejà"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9236 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Nest"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9240 AND composer_id = 111 AND title = '영화 <아마코드> 사운드트랙 중 "Lo "struscio" / Quel motivetto che mi piace tanto / Stormy Weather / La cucaracha / Stormy Weather"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9268 AND composer_id = 111 AND title = '영화 <아마코드> 사운드트랙 중 "L''emiro e le sue odalische"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9274 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Gloria in Excelsis Deo - Oath"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9279 AND composer_id = 111 AND title = '영화 <달콤한 인생> 사운드트랙 중 "Valzer (Parlami di me)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9280 AND composer_id = 112 AND title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "The Passing Years / The Late Sea"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9281 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "Strip Search"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9283 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙 중 "El Rancho (Second Dawn Sequence)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9284 AND composer_id = 111 AND title = '영화 <로마> 사운드트랙 중 "Trasteverina (Reprise)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9295 AND composer_id = 111 AND title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Vascello di Susi"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9299 AND composer_id = 112 AND title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "Forever"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9302 AND composer_id = 111 AND title = '영화 <전쟁과 평화> 사운드트랙 중 "Pierre and Natasha"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9307 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Teatrino di vernacchio"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9319 AND composer_id = 111 AND title = '영화 <전쟁과 평화> 사운드트랙 중 "Andrei and Natasha - The Hunt"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9322 AND composer_id = 111 AND title = '영화 <대부 2> 사운드트랙 중 "The Godfathers at Home"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9329 AND composer_id = 111 AND title = '영화 <Fortunella> 사운드트랙 중 "I tre a letto"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9330 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "De La Garde: Love Remembered"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9332 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "The Conclusive Evidence"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9364 AND composer_id = 111 AND title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Mistero (Mystery)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9387 AND composer_id = 112 AND title = 'A Child Is Born (음반) 중 "Part 1"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9407 AND composer_id = 111 AND title = '영화음악 <Le notti di Cabiria>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9413 AND composer_id = 111 AND title = 'Plein soleil 중 "Haute-mer"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9425 AND composer_id = 111 AND title = '영화 <Il brigante> 사운드트랙 중 "Michele soldato americano"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9428 AND composer_id = 111 AND title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Il charleston di Giulietta"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9432 AND composer_id = 111 AND title = '영화 <표범> 사운드트랙 중 "Tancredi garibaldino"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9437 AND composer_id = 111 AND title = 'Plein soleil 중 "La Gémissante"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9443 AND composer_id = 93 AND title = '영화음악 <Visitors>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9464 AND composer_id = 111 AND title = 'Plein soleil 중 "La Plage"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9469 AND composer_id = 111 AND title = '영화 <사기꾼들> 사운드트랙 중 "Ballerina night"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9473 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Storia della matrona de efeso"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9475 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Notturni nelle suburra"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9508 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Crocodile"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9530 AND composer_id = 111 AND title = '영화 <오케스트라 리허설> 사운드트랙 중 "Risatine maliziose"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9549 AND composer_id = 111 AND title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Spara Fore! (Shoot Loud)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9554 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "Naval Battle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9571 AND composer_id = 111 AND title = '영화 <로코와 그 형제들> 사운드트랙 중 "Valzer ai laghi"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9572 AND composer_id = 112 AND title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "Poetry"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9596 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "The Great Pyramids"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9598 AND composer_id = 112 AND title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "London / The Reading / Local Train"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9607 AND composer_id = 111 AND title = '영화 <말괄량이 길들이기> 사운드트랙 중 "The Taming"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9609 AND composer_id = 111 AND title = '영화 <대부 2> 사운드트랙 중 "Kay"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9611 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Thoughts"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9612 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Pool"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9615 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Skeleton"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9636 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Cave"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9650 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "Fire Engine"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9652 AND composer_id = 111 AND title = '영화 <전쟁과 평화> 사운드트랙 중 "Exodus From Moscow"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9654 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Moana''s Dance"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9673 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Procession"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9682 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "The Statues of Rameses"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9695 AND composer_id = 111 AND title = '영화 <아마코드> 사운드트랙 중 "Tutti a vedere il Rex"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9698 AND composer_id = 111 AND title = '영화 <카사노바> 사운드트랙 중 "Souvenir d''Henriette"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9705 AND composer_id = 111 AND title = 'Plein soleil 중 "Meurtre de Philippe"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9723 AND composer_id = 111 AND title = 'Plein soleil 중 "Contrefaçon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9729 AND composer_id = 111 AND title = '영화 <아마코드> 사운드트랙 중 "Ti ricordi di "Siboney"? / Siboney"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9730 AND composer_id = 111 AND title = 'Chansons pour Fellini 중 "Cabiria"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9763 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Le nozze sul mare"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9771 AND composer_id = 112 AND title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "The Spring Sea"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9775 AND composer_id = 111 AND title = '영화 <표범> 사운드트랙 중 "La Locanda (il pic-nic)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9781 AND composer_id = 112 AND title = '영화 <사이코> 사운드트랙 중 "The 1st Floor"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9795 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Delusion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9803 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "Anna and the King of Slam: Montage"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9821 AND composer_id = 111 AND title = '영화 <아마코드> 사운드트랙 중 "La "fogaraccia""'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9822 AND composer_id = 111 AND title = '영화 <사기꾼들> 사운드트랙 중 "La moglie del bidonista"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9843 AND composer_id = 111 AND title = '영화 <대부> 사운드트랙 중 "The Baptism"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9854 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Il fuoco delle vestali"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9855 AND composer_id = 111 AND title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Tarantella Grottesca (Grotesque Tarantella)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9859 AND composer_id = 111 AND title = '영화 <사기꾼들> 사운드트랙 중 "L''ultimo bidone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9871 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Crossbow"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9888 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Holy Mother Church"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9889 AND composer_id = 111 AND title = '영화 <아마코드> 사운드트랙 중 "La Gradisca si sposa e se ne va"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9891 AND composer_id = 111 AND title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Ninna nanna"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9898 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Despair"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9900 AND composer_id = 111 AND title = '영화 <대부 2> 사운드트랙 중 "Michael Comes Home"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9920 AND composer_id = 111 AND title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Mistero III (Mystery #3)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9947 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Sulla nave di lica"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9956 AND composer_id = 111 AND title = '영화 <달콤한 인생> 사운드트랙 중 "Titoli di testa – Canzonetta – Notturno – Cadillac"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9976 AND composer_id = 111 AND title = 'Plein soleil 중 "L''Absence"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9983 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Cobra Dance"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9984 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "Destruction"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9987 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "The Garden"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9991 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Death Of The Dragon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 9998 AND composer_id = 111 AND title = '영화 <대부 3> 사운드트랙 중 "Coda: The Godfather Finale"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10016 AND composer_id = 111 AND title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Mistero II (Mystery #2)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10017 AND composer_id = 111 AND title = '영화 <전쟁과 평화> 사운드트랙 중 "The Homecoming at Moscow"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10021 AND composer_id = 111 AND title = '영화 <로코와 그 형제들> 사운드트랙 중 "Introduzione e canzone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10030 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "L'' oracolo salmodiante"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10047 AND composer_id = 111 AND title = '영화 <대부 2> 사운드트랙 중 "Vito and Abbandando"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10054 AND composer_id = 111 AND title = 'Chansons pour Fellini 중 "Giulietta degli spiriti"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10055 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "The Abdication"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10067 AND composer_id = 111 AND title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Sospettoso Alberto (Suspicious Alberto)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10093 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "Flamethrower"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10102 AND composer_id = 111 AND title = '영화 <카사노바> 사운드트랙 중 "O Venise, Venaga, Venus"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10110 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "Anna and the King of Slam: Coronation"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10111 AND composer_id = 111 AND title = '영화 <나폴레옹> 사운드트랙 중 "Titoli: Ritorno dall''Elba"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10116 AND composer_id = 111 AND title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Passeggiata"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10134 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙 중 "Sunset Narrative"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10143 AND composer_id = 111 AND title = '영화 <말괄량이 길들이기> 사운드트랙 중 "The Wooing"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10145 AND composer_id = 111 AND title = '영화 <카사노바> 사운드트랙 중 "La Poupée automate"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10149 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Stone Gate"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10157 AND composer_id = 111 AND title = '영화 <Fortunella> 사운드트랙 중 "Ingresso nel palazzo del principe"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10158 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Cardinal Azzolino"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10162 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "The Ghost and Mrs. Muir: Andante Cantabile"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10164 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "Flowers of Fire"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10167 AND composer_id = 111 AND title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Canzone arrabbiata finale"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10172 AND composer_id = 112 AND title = '영화 <사이코> 사운드트랙 중 "The Finale"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10185 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Joy of Love in Alava"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10202 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Trumpets"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10211 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Encolpio e ascilto prigioneri"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10223 AND composer_id = 111 AND title = '영화 <표범> 사운드트랙 중 "Quadriglia"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10225 AND composer_id = 111 AND title = 'Chansons pour Fellini 중 "Il tempo passa"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10232 AND composer_id = 111 AND title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Rosa aurata - la ballerina del circo snap"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10234 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Dragon And Cyclops"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10237 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙 중 "Anna and the King of Slam: Elegy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10239 AND composer_id = 111 AND title = '영화 <달콤한 인생> 사운드트랙 중 "finale"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10265 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "Frightened Sam"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10284 AND composer_id = 111 AND title = '영화 <Fortunella> 사운드트랙 중 "Dialogo fortunella"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10287 AND composer_id = 111 AND title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Antonio Soffiantini detto "Tunin""'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10290 AND composer_id = 112 AND title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "Romance / Love / Farewell"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10298 AND composer_id = 111 AND title = '영화 <전쟁과 평화> 사운드트랙 중 "Napoleon''s Retreat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10314 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10318 AND composer_id = 111 AND title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Alberto Investiga (Alberto Investigates)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10322 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Girls"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10332 AND composer_id = 111 AND title = '영화 <로마> 사운드트랙 중 "Roman Festival"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10333 AND composer_id = 111 AND title = '영화 <아마코드> 사운드트랙 중 "Le "manine" di primavera"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10334 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "Rape and Hospital"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10343 AND composer_id = 111 AND title = '영화 <사기꾼들> 사운드트랙 중 "Il tesoro nascosto"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10355 AND composer_id = 112 AND title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "The Ghost / The Storm / The Apparition"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10398 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "Max"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10407 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Duel"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10410 AND composer_id = 111 AND title = '영화 <표범> 사운드트랙 중 "Partenza di Tancredi"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10415 AND composer_id = 111 AND title = '영화 <대부 2> 사운드트랙 중 "The Brothers Mourn"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10440 AND composer_id = 111 AND title = 'Plein soleil 중 "Arrivée à Taormine"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10450 AND composer_id = 111 AND title = 'Plein soleil 중 "Mongibello"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10451 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Fog"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10475 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Cliffs"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10495 AND composer_id = 111 AND title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Ballando Con Raquel (Dancing With Raquel)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10526 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙 중 "Xanadu / Jigsaw Puzzles (Perpetual Motion) / Second Xanadu"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10539 AND composer_id = 111 AND title = '영화 <전쟁과 평화> 사운드트랙 중 "The Battle of Austerlitz"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10540 AND composer_id = 111 AND title = '영화 <로마> 사운드트랙 중 "Barafonda Theatre"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10551 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Lilliputians"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10553 AND composer_id = 111 AND title = '영화 <대부> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10557 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "Fox-Trot - Don''t Say No to Rain"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10559 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Guitar From the Quayside"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10569 AND composer_id = 112 AND title = '영화 <사이코> 사운드트랙 중 "Intro/Logos"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10598 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "Sam''s Story"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10614 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "Reunion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10616 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Genie''s Home"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10633 AND composer_id = 111 AND title = '영화 <아마코드> 사운드트랙 중 "La Gradisca e il principe"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10643 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "Jackie''s Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10648 AND composer_id = 111 AND title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Cupido ha sonno - la maestra d''amore"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10661 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "Houseboat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10674 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Il giardino delle delizie"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10679 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Children''s Plays"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10681 AND composer_id = 111 AND title = 'Chansons pour Fellini 중 "Casanova"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10683 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Skull"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10685 AND composer_id = 111 AND title = '영화 <달콤한 인생> 사운드트랙 중 "Via Veneto"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10686 AND composer_id = 69 AND title = '영화음악 <Scott of the Antarctic>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10688 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Chess Game"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10694 AND composer_id = 111 AND title = '영화 <카사노바> 사운드트랙 중 "L''Oiseau magique à Rome"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10697 AND composer_id = 111 AND title = '영화 <아마코드> 사운드트랙 중 "Gary Cooper"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10702 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Squirrel"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10710 AND composer_id = 111 AND title = '영화 <전쟁과 평화> 사운드트랙 중 "Anatole and Natasha"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10711 AND composer_id = 112 AND title = '영화음악 <The Snows of Kilimanjaro>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10729 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Duel With The Skeleton"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10733 AND composer_id = 93 AND title = '영화음악 <Mishima>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10755 AND composer_id = 111 AND title = '영화 <대부 2> 사운드트랙 중 "After the Party"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10766 AND composer_id = 112 AND title = '영화 <사이코> 사운드트랙 중 "The Search B"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10780 AND composer_id = 111 AND title = '영화 <대부 2> 사운드트랙 중 "Main Title / The Immigrant"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10790 AND composer_id = 111 AND title = '영화 <로코와 그 형제들> 사운드트랙 중 "Paese mio"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10794 AND composer_id = 111 AND title = '영화 <Il brigante> 사운드트랙 중 "''mmazzato a tradimento"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10795 AND composer_id = 111 AND title = '영화 <로코와 그 형제들> 사운드트랙 중 "Come tu vuoi"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10813 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Moana''s Death"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10829 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Solitude"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10855 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Tightrope"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10873 AND composer_id = 112 AND title = '영화음악 <North by Northwest>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10874 AND composer_id = 111 AND title = '영화 <Il brigante> 사운드트랙 중 "La lunga strada - in casa della nonna"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10879 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Dragon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10888 AND composer_id = 111 AND title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "I Guai Di Alberto (The Troubles Of Alberto)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10893 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Encolpio ha perduto la sua spada"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10916 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Fight With The Cyclops"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10929 AND composer_id = 111 AND title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Voci casa tolleranza"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10933 AND composer_id = 111 AND title = '영화 <대부> 사운드트랙 중 "Sicilian Pastorale"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10941 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "Tema di gitone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10949 AND composer_id = 69 AND title = '영화음악 <Bitter Springs>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10964 AND composer_id = 111 AND title = '영화 <사기꾼들> 사운드트랙 중 "Cara bambina"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 10996 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙 중 "Matangi''s Love Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11020 AND composer_id = 111 AND title = '영화 <달콤한 인생> 사운드트랙 중 "Notturno o mattutino"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11027 AND composer_id = 111 AND title = '영화 <아마코드> 사운드트랙 중 "Danzando nella nebbia"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11030 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Night Magic"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11035 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "The Steambot Departs"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11037 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "Journey on the Nile"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11050 AND composer_id = 111 AND title = '영화 <말괄량이 길들이기> 사운드트랙 중 "The Banquet"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11056 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "Duet (main Love Theme)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11057 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Deer Hunting"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11061 AND composer_id = 111 AND title = '영화 <표범> 사운드트랙 중 "Controdanza"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11063 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Trees"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11064 AND composer_id = 111 AND title = '영화 <로코와 그 형제들> 사운드트랙 중 "L’amore dei due fratelli"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11073 AND composer_id = 111 AND title = '영화 <사기꾼들> 사운드트랙 중 "Coimbra / La festa dei bidonisti"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11099 AND composer_id = 111 AND title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Rugiada sui ranocchi"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11101 AND composer_id = 111 AND title = '영화 <Il brigante> 사운드트랙 중 "Echi dei canti di Calabria"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11109 AND composer_id = 112 AND title = '영화 <시민 케인> 사운드트랙 중 "On Dangerous Ground"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11110 AND composer_id = 111 AND title = '영화 <Il brigante> 사운드트랙 중 "La processione nel paese"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11115 AND composer_id = 111 AND title = '영화 <로코와 그 형제들> 사운드트랙 중 "La gelosia di Simone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11131 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "Arrival at Wode Hall"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11137 AND composer_id = 111 AND title = '영화 <로코와 그 형제들> 사운드트랙 중 "L’amore di Rocco"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11145 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Tiny Princess"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11153 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙 중 "Impossible Love"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11174 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "The End"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11179 AND composer_id = 111 AND title = 'Chansons pour Fellini 중 "Lo sceicco bianco"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11206 AND composer_id = 111 AND title = '영화 <나폴레옹> 사운드트랙 중 "Medley: Notte di vigilia / Parata delle truppe napoleoniche"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11209 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "Linnet''s Pearls"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11211 AND composer_id = 112 AND title = '영화 <케이프 피어> 사운드트랙 중 "Sam Hides"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11218 AND composer_id = 111 AND title = '영화 <카사노바> 사운드트랙 중 "La Grande Moune"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11220 AND composer_id = 111 AND title = '영화 <Il brigante> 사운드트랙 중 "Michele cacciatore"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11221 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙 중 "La schiavetta innamorata"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11236 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Clouds"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11238 AND composer_id = 111 AND title = '영화 <Fortunella> 사운드트랙 중 "Il ritratto della principessa"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11252 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Bagdad"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11258 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙 중 "I Love My Baby"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11272 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Fire"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11289 AND composer_id = 111 AND title = '영화 <나일 강의 죽음> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11312 AND composer_id = 84 AND title = '영화 음악 <스페이드의 여왕>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11367 AND composer_id = 84 AND title = '영화 음악 <키제 중위>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 11817 AND composer_id = 84 AND title = '영화 음악 <이반 뇌제> 중 "오프리치니키의 춤"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 12012 AND composer_id = 83 AND title = '영화음악 <베를린 함락>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 12036 AND composer_id = 83 AND title = '영화음악 <카운터플랜>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 12059 AND composer_id = 83 AND title = '영화음악 <코르진키나의 모험>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 12219 AND composer_id = 83 AND title = '영화음악 <닷새 낮 닷새 밤>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 12318 AND composer_id = 83 AND title = '영화음악 <피로고프>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 12492 AND composer_id = 83 AND title = '영화음악 <소피야 페롭스카야>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 12521 AND composer_id = 83 AND title = '영화음악 <신 바빌론>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 12679 AND composer_id = 83 AND title = '영화음악 <햄릿>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 12684 AND composer_id = 83 AND title = '영화음악 <리어 왕>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 12748 AND composer_id = 83 AND title = '영화음악 <어리석은 아기 생쥐 이야기>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 12771 AND composer_id = 83 AND title = '영화음악 <홀로>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 12914 AND composer_id = 83 AND title = '영화음악 <잊을 수 없는 1919년>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 13121 AND composer_id = 83 AND title = '영화음악 <여자 친구들>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 13124 AND composer_id = 83 AND title = '영화음악 <신부와 일꾼 발다 이야기>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 13458 AND composer_id = 83 AND title = '영화음악 <위대한 강들의 노래>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 13538 AND composer_id = 83 AND title = '영화음악 <볼로차예프의 나날>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 13553 AND composer_id = 83 AND title = '영화음악 <카운터플랜> 중 "카운터플랜의 노래"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 13708 AND composer_id = 83 AND title = '영화음악 <미추린>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 15930 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "QUESS PARAYA (クェス・パラヤ)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 15931 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "NEO ZION (ネオ・ジオン軍)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 15932 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "SALLY (出撃)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 15934 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "SWAN (白鳥)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 15935 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "ν GUNDAM (ニュー・ガンダム)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 15936 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "ANXIETY (不安)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 15937 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "MISSION (使命)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 15938 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "AXCIS (惑星アクシズ)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 15939 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "SACRIFICE (犠牲)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 15940 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "COMBAT (格闘)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 15941 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "DESTINY (宿命)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 15942 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "AURORA (オーロラ)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 15943 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "MAIN TITLE (メイン・タイトル)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16007 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Breathe"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16047 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Desert Music"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16066 AND composer_id = 290 AND title = '영화음악 <Bram Stoker’s Dracula>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16075 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Will''s Story 2"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16126 AND composer_id = 280 AND title = '영화 <사랑한다면 이들처럼> 사운드트랙: Michael Nyman 5'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16181 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Dreams That Stuff Is Made Of"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16187 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "リボン"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16215 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Rowing (alternative version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16275 AND composer_id = 206 AND title = 'White Black Boy: Original Soundtrack 중 "Dying Bird"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16321 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "First Attempts"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16342 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Night Montage"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16348 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Hammers and Nails"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16353 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Separation"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16360 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Properties of Explosive Materials"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16439 AND composer_id = 206 AND title = 'White Black Boy: Original Soundtrack 중 "Time To Say Goodbye"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16451 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Camping"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16467 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Around the Clock News"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16599 AND composer_id = 206 AND title = 'White Black Boy: Original Soundtrack 중 "Feather"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16617 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Theory of Everything"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16651 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ライズボール"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16667 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "London, 1988"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16730 AND composer_id = 206 AND title = 'White Black Boy: Original Soundtrack 중 "Exam Results"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16741 AND composer_id = 206 AND title = 'White Black Boy: Original Soundtrack 중 "Automobile"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16778 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "The Border"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16814 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "君を探して"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16819 AND composer_id = 301 AND title = '영화음악 <The Devils>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16826 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Drywall"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16847 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ファニー・スパイ"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 16893 AND composer_id = 310 AND title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Startrek = スタートレック"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17018 AND composer_id = 310 AND title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Globular Cluster = 球状星团"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17039 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "プリズム"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17041 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Forces of Attraction"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17072 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "First Encounter"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17114 AND composer_id = 280 AND title = '영화 <사랑한다면 이들처럼> 사운드트랙: Michael Nyman 2'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17118 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Whirling Ways of Stars That Pass"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17129 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ブルー"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17150 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Melancholia"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17163 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Xenoanthropology"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17222 AND composer_id = 204 AND title = '영화음악 <Alsino y el cóndor>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17244 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Lab"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17251 AND composer_id = 206 AND title = 'White Black Boy: Original Soundtrack 중 "Nightmare II"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17264 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Meditation (From „free the Mind” Soundtrack)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17273 AND composer_id = 310 AND title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Ring Nebula M57 = リング星雲"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17288 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Principle of Least Time"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17292 AND composer_id = 310 AND title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Quasar 3C273 = クェーサー"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17296 AND composer_id = 310 AND title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Startrek (Reprise) = スタートレック(リプライズ)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17311 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Elevator II"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17344 AND composer_id = 206 AND title = 'And in the Endless Pause There Came the Sound of Bees 중 "The Gift"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17349 AND composer_id = 280 AND title = '영화음악 <Wonderland>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17404 AND composer_id = 206 AND title = 'And in the Endless Pause There Came the Sound of Bees 중 "City Building"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17430 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Chalkboard"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17442 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Origins of Time"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17447 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "タンポポとこんぺいとう"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17466 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "メインテーマ"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17476 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "秋桜"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17481 AND composer_id = 206 AND title = 'White Black Boy: Original Soundtrack 중 "Bad Results"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17521 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ミッション"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17526 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Escalation"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17532 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Sparkles"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17539 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "A Normal Family"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17559 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Love After Love"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17569 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Neurons"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17575 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Transmutation at a Distance"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17620 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Emotional Intelligence"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17625 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Cambridge, 1963"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17645 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "嘘と鏡"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17699 AND composer_id = 206 AND title = 'White Black Boy: Original Soundtrack 중 "Playing With Ball"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17767 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Voice Box"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17773 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "星の見える丘"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17869 AND composer_id = 206 AND title = 'And in the Endless Pause There Came the Sound of Bees 중 "Pods"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17892 AND composer_id = 310 AND title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Radio Galaxy M87 = 電波銀河"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17899 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Arrival"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17900 AND composer_id = 280 AND title = '영화음악 <The Diary of Anne Frank>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17942 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Balcony"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18010 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "フォトセッション"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18028 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Innocence (From „free the Mind” Soundtrack)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18040 AND composer_id = 206 AND title = 'And in the Endless Pause There Came the Sound of Bees 중 "Rainwater"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18046 AND composer_id = 280 AND title = '영화 <사랑한다면 이들처럼> 사운드트랙: Michael Nyman 1'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18056 AND composer_id = 310 AND title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Orion Nebula = オリオン大星雲"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18132 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Sapir‐Whorf"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18163 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Daisy, Daisy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18188 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "A Spacetime Singularity"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18220 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "The Bank"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18225 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Will''s Story 1"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18255 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Domestic Pressures"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18269 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Spelling Board"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18270 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "あかね色"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18276 AND composer_id = 206 AND title = 'And in the Endless Pause There Came the Sound of Bees 중 "The Flat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18350 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "メッセージ"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18370 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Target"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18397 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Armoured Vehicle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18421 AND composer_id = 206 AND title = 'And in the Endless Pause There Came the Sound of Bees 중 "Dying City"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18450 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Collapsing Inwards"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18461 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Elevator I"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18470 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Convoy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18496 AND composer_id = 280 AND title = '영화음악 <The Cook, The Thief, His Wife and Her Lover>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18554 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "想いの向こう"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18605 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Cavendish Lab"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18611 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "もの想う午後"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18628 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Viva Voce"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18674 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "フォトグラフ"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18716 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Hydraulic Lift"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18733 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Soccer Game"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18742 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "風のダンス"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18743 AND composer_id = 280 AND title = '영화 <사랑한다면 이들처럼> 사운드트랙: Michael Nyman 3'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18745 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Tunnel Music"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18830 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "A Model of the Universe"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18859 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Stairs"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18863 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "17ステップス"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18947 AND composer_id = 280 AND title = '영화 <사랑한다면 이들처럼> 사운드트랙: Michael Nyman 6'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18967 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Ultimatum"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 18971 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Coma"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19018 AND composer_id = 206 AND title = 'And in the Endless Pause There Came the Sound of Bees 중 "Entering the City"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19022 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Non‐Zero‐Sum Game"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19093 AND composer_id = 280 AND title = '영화음악 <The Draughtman’s Contract>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19109 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Kangaru"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19166 AND composer_id = 290 AND title = '영화음악 <Le roi et l''oiseau>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19170 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ピクニック"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19208 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "A Game of Croquet"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19212 AND composer_id = 206 AND title = '영화음악 <Copenhagen Dreams>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19282 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "One of Twelve"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19299 AND composer_id = 280 AND title = '영화 <사랑한다면 이들처럼> 사운드트랙: Michael Nyman 4'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19322 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ガールズ"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19326 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "The Beast"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19335 AND composer_id = 206 AND title = 'White Black Boy: Original Soundtrack 중 "Exam"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19339 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Surveillance"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19394 AND composer_id = 186 AND title = '영화음악 <La morte ha fatto l''uovo>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19451 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Hazmat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19464 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "A Brief History of Time"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19466 AND composer_id = 280 AND title = '영화음악 <The Falls>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19555 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ハートビート"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19559 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "恋のはじまり"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19586 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "写真部のテーマ"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19595 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Explosion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19725 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Rise"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19739 AND composer_id = 206 AND title = 'White Black Boy: Original Soundtrack 중 "Nightmare"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19915 AND composer_id = 280 AND title = '영화음악 <The Piano>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19927 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "スイートピー"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19935 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Xenolinguistics"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 19968 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙 중 "Decyphering"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 20007 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Free the Mind"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 20020 AND composer_id = 206 AND title = 'And in the Endless Pause There Came the Sound of Bees 중 "Inside the Pods"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 20048 AND composer_id = 310 AND title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Pulser = バルサー"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 20049 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙 중 "Radio"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23178 AND composer_id = 366 AND title = '영화음악 <Al cospetto del sultano>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23179 AND composer_id = 366 AND title = '영화음악 <Assedio>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23190 AND composer_id = 421 AND title = 'Assassin’s Creed Syndicate: Jack the Ripper (Original Game Soundtrack) 중 "Theme from Assassin''s Creed Syndicate: Jack the Ripper"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23191 AND composer_id = 421 AND title = 'Assassin’s Creed Syndicate: Jack the Ripper (Original Game Soundtrack) 중 "Cobblestone and Fog"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23192 AND composer_id = 421 AND title = 'Assassin’s Creed Syndicate: Jack the Ripper (Original Game Soundtrack) 중 "District Activities"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23193 AND composer_id = 421 AND title = 'Assassin’s Creed Syndicate: Jack the Ripper (Original Game Soundtrack) 중 "Evie Frye"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23194 AND composer_id = 421 AND title = 'Assassin’s Creed Syndicate: Jack the Ripper (Original Game Soundtrack) 중 "Jack the Ripper"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23197 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "The Truth From Dariush"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23198 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "In Defiance of Death"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23200 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Theme From SOCOM 4"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23202 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "Beyond Thoughts of Darkness"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23203 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "Bird Feather and the Colonel"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23204 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙 중 "A Happy Family"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23205 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Raeb’s Lament"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23209 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Port Yard Deaths"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23215 AND composer_id = 419 AND title = 'Black Sea Raid 중 "The General’s Orders"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23216 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "Massacre at Valinore"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23220 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "Celestial Apex"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23222 AND composer_id = 419 AND title = 'Raging Angels 중 "The Death of Grandma Ruth"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23223 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Into Númenor"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23224 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "General Dark Onward"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23227 AND composer_id = 419 AND title = 'Zero Option 중 "The Meeting Without One Then Another"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23231 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "The Island’s Secret"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23232 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Father Figures"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23234 AND composer_id = 419 AND title = 'Final Judgement 중 "Daydream"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23235 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "Merwyn of Xintrea"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23236 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "Backseat Butterflies"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23242 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Tommy in Pursuit"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23243 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "A Son’s Path"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23244 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Midgard"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23246 AND composer_id = 421 AND title = 'Dark Void 중 "Watcher Prison"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23247 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "Dog Tags"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23248 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "The Final Confrontation"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23250 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack 중 "Ima Kama"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23253 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Da Vinci’s Demons Main Title Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23262 AND composer_id = 419 AND title = 'Final Judgement 중 "Getting Ready"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23263 AND composer_id = 421 AND title = '영화 <Welcome Home> 사운드트랙 중 "Painful Memories"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23264 AND composer_id = 419 AND title = 'Mr. Atlas 중 "Fun In The Park"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23267 AND composer_id = 421 AND title = 'Caprica 중 "New Cap City"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23268 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙 중 "A Thousand Times"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23270 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Project Phoenix"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23272 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Allison''s Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23273 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "A Message for Ava"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23274 AND composer_id = 419 AND title = 'Final Judgement 중 "Ariel and David / The Burial"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23279 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Fluid Dynamics"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23282 AND composer_id = 419 AND title = 'Black Sea Raid 중 "Ten Million or Death"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23283 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Two: Where The Stars Are Strange - Amazon Original Series Soundtrack) 중 "My Name Is Not Halbrand"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23286 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Asgard"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23288 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "Eile & Fjall"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23292 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Zoe''s Avatar"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23293 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack 중 "Depth Perception"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23294 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "A New Land... An Old Friendship"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23300 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Goodbye Old Friend"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23301 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙 중 "10 Cloverfield Lane"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23302 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Valor and Ash"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23303 AND composer_id = 421 AND title = 'Caprica 중 "Daniel Captures the Code (Expanded Version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23307 AND composer_id = 468 AND title = '영화음악 <Cronaca familiare>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23309 AND composer_id = 419 AND title = 'Black Sea Raid 중 "We’re Getting Out of Here"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23311 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Dark Woods"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23316 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "Evil Watches Through a Glass"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23317 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Allyson’s Past"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23321 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode One: Elven Kings Under The Sky - Amazon Original Series Soundtrack) 중 "The Rings of Power: Season One Overture"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23322 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "Danielle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23323 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Boat and the Crater"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23325 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "The Science Project"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23326 AND composer_id = 421 AND title = '영화 <더 보이> 사운드트랙 중 "Meeting Brahms"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23328 AND composer_id = 421 AND title = '영화 <유로파 리포트> 사운드트랙 중 "Theme From Europa Report"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23330 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "Wider Than the Sky"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23332 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "Typewriter Drums"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23333 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙 중 "At the Door"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23336 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "The Devil’s Mouth"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23337 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Four: Eldest - Amazon Original Series Soundtrack) 중 "Mud Beast"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23338 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Paul''s Package"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23340 AND composer_id = 421 AND title = 'Dark Void 중 "Will at the River"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23341 AND composer_id = 421 AND title = 'Caprica 중 "Through the Paces"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23342 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "A Fucking Piece"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23343 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Maria and Chance"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23346 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Not a Pacifist"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23355 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "The Black Rose"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23359 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Power Over Flesh"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23361 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "Arrival"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23363 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Six: Where Is He? - Amazon Original Series Soundtrack) 중 "The Legions of Adar"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23364 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Sumo Fight"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23365 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "Blackfoot Attack"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23368 AND composer_id = 419 AND title = 'Zero Option 중 "Running for Your Life"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23369 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Muspelheim and Niflheim"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23375 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Military Evacuation"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23377 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "There''s a Storm Coming"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23378 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Friends Until the End"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23379 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "Theme From Black Sails"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23381 AND composer_id = 419 AND title = 'Final Judgement 중 "Following Rob"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23383 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Cryptokey"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23388 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "Love in the Night Drifts Softly"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23389 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Vein"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23394 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "The Old Fort"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23398 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Sausalito"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23399 AND composer_id = 419 AND title = 'Zero Option 중 "The Lesson of Another Era"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23401 AND composer_id = 421 AND title = '영화 <더 보이> 사운드트랙 중 "The Crying Doll"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23403 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙 중 "Darkness Falls"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23405 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "The Hidden Beast"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23406 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "Foundation Main Title"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23409 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "The Carnival of Crime"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23410 AND composer_id = 421 AND title = 'Caprica 중 "Death of the Guatrau"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23412 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "Maverick Regeneration"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23413 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "To Forgive or to Kill"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23415 AND composer_id = 419 AND title = 'Black Sea Raid 중 "The Abduction"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23418 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Confronting the Mystics"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23419 AND composer_id = 421 AND title = 'Outlander: Season 7 (Original Television Soundtrack) 중 "A Dying Kinsman"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23421 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Six: Where Is He? - Amazon Original Series Soundtrack) 중 "Tempest of Bats"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23424 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "You Are One of My Guests"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23425 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "Flight and Escape"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23428 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Driving Away"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23429 AND composer_id = 421 AND title = 'Caprica 중 "Cerberus Dance (demo)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23430 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Votan Romance"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23435 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "Foundation End Credits"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23438 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "One Last Measure"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23440 AND composer_id = 421 AND title = 'Defiance: Original Television Soundtrack 중 "Worth Dying For"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23441 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack 중 "The Voice in the Vault"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23442 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Zoe Awakens"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23449 AND composer_id = 421 AND title = '영화 <Rest Stop: Dead Ahead> 사운드트랙 중 "Vicious Cycle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23453 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "L’Urca de Lima"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23454 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack 중 "Palle! Palle! Palle!"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23455 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Three: The Eagle And The Sceptre - Amazon Original Series Soundtrack) 중 "Isildur and Estrid"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23460 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "Howard Scott Warshaw"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23461 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "A Request from Whit"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23462 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "Come What May"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23465 AND composer_id = 421 AND title = 'Dark Void 중 "Altar Sacrifice"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23468 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Hank Meets Jimbo"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23471 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Circles"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23472 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "Rupert is Next"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23474 AND composer_id = 419 AND title = 'Mr. Atlas 중 "The Tear That Gives Life"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23476 AND composer_id = 421 AND title = '영화 <유로파 리포트> 사운드트랙 중 "Hydrazine"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23477 AND composer_id = 419 AND title = 'Raging Angels 중 "When Darkness Enters the Room"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23478 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "Bananafish"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23479 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Victoria"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23481 AND composer_id = 419 AND title = 'Black Sea Raid 중 "The Hidden Missile"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23482 AND composer_id = 421 AND title = '영화 <포레스트: 죽음의 숲> 사운드트랙 중 "Follow the Rope"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23484 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Flipping the Plane"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23485 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Gil‐Galad’s Gift"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23496 AND composer_id = 419 AND title = 'Zero Option 중 "A Tale of Another Time"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23497 AND composer_id = 421 AND title = '영화 <더 보이> 사운드트랙 중 "Come Play Pretty Greta"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23498 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "He‐Man Transforms"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23499 AND composer_id = 421 AND title = 'Caprica 중 "New Cap City Theme (demo)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23502 AND composer_id = 421 AND title = '영화 <포레스트: 죽음의 숲> 사운드트랙 중 "The Forest Main Title"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23504 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "The Return"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23507 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙 중 "Howard"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23509 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "La Dola Revelations"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23512 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Street Musicians"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23513 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Naga Formation"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23515 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "The Innocence of a Child’s Smile"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23521 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "Pieces of Eight"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23523 AND composer_id = 421 AND title = '영화 <Welcome Home> 사운드트랙 중 "Coniglio Alla Cacciatora"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23524 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Remembering Faye (feat. Eivør)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23527 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "Following Simon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23528 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Four: Eldest - Amazon Original Series Soundtrack) 중 "Galadriel Stands Alone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23529 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Victor''s Getaway"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23532 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Four: Eldest - Amazon Original Series Soundtrack) 중 "The Sûzat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23533 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "The One Who Is Many"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23535 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "Turndown"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23536 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Bloodlust"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23542 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode One: Elven Kings Under The Sky - Amazon Original Series Soundtrack) 중 "Trees of Stone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23543 AND composer_id = 419 AND title = 'Mr. Atlas 중 "The Ride Home"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23547 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "Paying Toni a Visit"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23548 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "Char Car Chase"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23549 AND composer_id = 419 AND title = 'Raging Angels 중 "Chris and Lila"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23551 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "The Coolest Cat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23552 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Theme From Human Target (long version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23553 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Four: Eldest - Amazon Original Series Soundtrack) 중 "Meeting Tom Bombadil"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23554 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "Showtime (extended version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23555 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "Boneyard"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23557 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "A Surprise for Andy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23559 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "Impending War"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23560 AND composer_id = 419 AND title = 'Black Sea Raid 중 "Russian Tanks in Pursuit"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23561 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "The Sons of Mithras"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23562 AND composer_id = 421 AND title = 'Outlander: Season 7 (Original Television Soundtrack) 중 "Changed History"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23564 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack 중 "The Undiscovered Land"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23570 AND composer_id = 419 AND title = 'Black Sea Raid 중 "Rick’s Greeting"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23579 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Destined for the Darkness"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23582 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "Birds Before Nerds"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23583 AND composer_id = 419 AND title = 'Mr. Atlas 중 "I''ll Bet It''s The Way He Smells"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23586 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "Willoughby"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23589 AND composer_id = 421 AND title = '영화 <유로파 리포트> 사운드트랙 중 "Water"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23591 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙 중 "Roadside Assistance"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23592 AND composer_id = 421 AND title = 'Defiance: Original Television Soundtrack 중 "Battle of the Volge"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23593 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "The Kids and the Truth"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23595 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Three: The Eagle And The Sceptre - Amazon Original Series Soundtrack) 중 "The Road to Pelargir"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23598 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "The Dog Food Factory"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23599 AND composer_id = 421 AND title = 'Caprica 중 "Caprica Abides (Instrumental Version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23601 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "A Hunt in Stalingrad"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23603 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Vol. 1 중 "Mrs. Fitz"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23604 AND composer_id = 421 AND title = '영화 <Welcome Home> 사운드트랙 중 "Theme from Welcome Home"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23605 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Signing the Contract"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23606 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "When I Am Dead (film version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23607 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙 중 "The Last Stand"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23609 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Broken Line and Broken Silence"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23610 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙 중 "Jesus, He Forgives You Too"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23611 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "I Am Not Alone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23613 AND composer_id = 421 AND title = 'Dark Void 중 "The Dweller"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23614 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Seven: Doomed To Die - Amazon Original Series Soundtrack) 중 "The Light of Celebrimbor"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23615 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "Search for a Past"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23618 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Two: Where The Stars Are Strange - Amazon Original Series Soundtrack) 중 "Glimpses of the Unseen World"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23622 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Visions of Lucrezia"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23623 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Return to Brianna"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23626 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Stealing the Orca"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23629 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "The Death of Vince Faraday"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23632 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "The Telepath Strikes"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23633 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "Blue Dream Studios Logo"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23634 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Kakamucho Under Attack"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23636 AND composer_id = 421 AND title = 'Zom‐B Movie: Soundtrack 중 "Rosebud Motherfu**er"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23639 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Holding On (feat. Eivør)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23641 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Atomic Al''s Merry Melody"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23642 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "Snowball Fight"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23643 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "The Hollow Earth"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23645 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "The Heist"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23648 AND composer_id = 421 AND title = 'Dark Void 중 "Crash Site"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23653 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "This Is Awkward"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23654 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "Paintballers"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23662 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "The Tale of Otter Tooth"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23663 AND composer_id = 421 AND title = 'Caprica 중 "Capricoperatica"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23664 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "Theme From Revolt"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23665 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "The Mermaid"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23668 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Alex Meets Zhen Zhen"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23669 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Alfheim"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23671 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Tommy''s Bath"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23674 AND composer_id = 421 AND title = 'Caprica 중 "Here Be Dragons"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23677 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Andy Goode''s Turk"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23678 AND composer_id = 419 AND title = 'Final Judgement 중 "Narrow Escape"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23679 AND composer_id = 399 AND title = 'I Know This Much Is True (Music From The HBO Series) 중 "Give Me Your Hand"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23680 AND composer_id = 421 AND title = '영화 <해피 데스데이> 사운드트랙 중 "The Cupcake"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23682 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "Wartime Anxiety"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23683 AND composer_id = 421 AND title = 'Caprica 중 "Caprica Abides"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23686 AND composer_id = 419 AND title = 'Raging Angels 중 "Colin Reveals the Way to Lila"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23687 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "The Murder of George Merrett"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23694 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Erotomania!"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23695 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Seven: Doomed To Die - Amazon Original Series Soundtrack) 중 "Dwarven Loyalty"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23696 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "She Must Rule"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23697 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "The Watermelon Man"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23698 AND composer_id = 421 AND title = 'Zom‐B Movie: Soundtrack 중 "Cecil and Orson"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23704 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Terrorism on the Lev"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23706 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "The Chant Of The Luminous"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23709 AND composer_id = 421 AND title = '영화 <유로파 리포트> 사운드트랙 중 "That Brings Us to Now"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23710 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "Electrical Substation"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23712 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Three: The Eagle And The Sceptre - Amazon Original Series Soundtrack) 중 "Mithril for Rings"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23714 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "Gwen’s Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23715 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Seven: Doomed To Die - Amazon Original Series Soundtrack) 중 "The Orc Camp"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23717 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "Monday the 18th Again"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23722 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Grýla"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23723 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode One: Elven Kings Under The Sky - Amazon Original Series Soundtrack) 중 "Bow or Bleed"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23726 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙 중 "Watch Her Die"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23727 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Pretty Brave After All"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23735 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "An Old Life"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23737 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Two: Where The Stars Are Strange - Amazon Original Series Soundtrack) 중 "Caras Gaer"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23743 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Into the West"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23745 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "All Debts Paid"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23746 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "We Wait for You"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23753 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "New Dawn at Fraser''s Ridge"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23757 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Faradays Are Fighters"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23758 AND composer_id = 421 AND title = 'Caprica 중 "Lacey and Zoe (Expanded Version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23759 AND composer_id = 421 AND title = '영화 <에벌리> 사운드트랙 중 "The Sadist"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23762 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "I Must Have Ye"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23763 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙 중 "Creepy Gas Station"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23766 AND composer_id = 419 AND title = 'Zero Option 중 "The Rescue"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23767 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Holding the Trigger"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23770 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "The Reese Boys"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23772 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The King in the Tower"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23773 AND composer_id = 421 AND title = 'Defiance: Original Television Soundtrack 중 "The Ritual of Perpetual Motion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23774 AND composer_id = 421 AND title = 'Defiance: Original Television Soundtrack 중 "Defiance Main Title"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23775 AND composer_id = 421 AND title = 'Dark Void 중 "The Imperator"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23776 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "City of Worms"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23777 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "Zandor''s Tale"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23779 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Rebirth"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23783 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "Final Resolution / End Titles"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23784 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "Resist"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23785 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "Talking to the Target"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23786 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Encountering Servants"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23787 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "Hate in My Heart"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23788 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Six: Where Is He? - Amazon Original Series Soundtrack) 중 "Celebrimbor''s Burden"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23789 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "The Future of the Sons of Mithras"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23791 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "No Soldier"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23792 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "In the Basement"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23793 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Prayer to Saint Michael"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23794 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Sewing the Mask"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23795 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "In the Wall"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23799 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "Entrance to the Old Farm House"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23806 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "Death of the Colonel''s Wife and Moving West"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23807 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "The Russian Embassy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23808 AND composer_id = 419 AND title = 'Raging Angels 중 "Retribution and the Final Battle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23810 AND composer_id = 399 AND title = 'I Know This Much Is True (Music From The HBO Series) 중 "Three Rivers"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23811 AND composer_id = 419 AND title = 'Mr. Atlas 중 "Looking For Horses"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23814 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Seven: Doomed To Die - Amazon Original Series Soundtrack) 중 "Shattered Illusion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23815 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙 중 "On the Bus"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23816 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Convergence at Zed Mart"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23817 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Scales in the Cage"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23818 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "Your Heart Sucks My Soul"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23820 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Visions and Demons"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23821 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Irrecoverable Error"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23823 AND composer_id = 421 AND title = 'Caprica 중 "Pact of Brothers"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23826 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "Vane’s Visions"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23829 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "Death on a Plane"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23830 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "Blood on the Moor"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23833 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Marin Exploration"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23834 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Gregor the Great’s Carnival of Fear"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23835 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Gondola"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23836 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "Ava and Duke"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23837 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Intellitons"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23838 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "The Man Stuffed with Money"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23842 AND composer_id = 421 AND title = 'Caprica 중 "Caprica Theme (sketch)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23843 AND composer_id = 421 AND title = '영화 <포레스트: 죽음의 숲> 사운드트랙 중 "The Tent"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23844 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "The Best Pain"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23846 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Grieving"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23847 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "The Volge"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23849 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "The Lullaby"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23854 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "Underwater"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23856 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "To Chaos Return"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23858 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "Revelation – Trailer"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23859 AND composer_id = 419 AND title = 'Black Sea Raid 중 "At the Gate"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23862 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "Joyful Tears"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23863 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Six: Where Is He? - Amazon Original Series Soundtrack) 중 "Sauron''s Illusion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23866 AND composer_id = 419 AND title = 'Zero Option 중 "A Child''s Interest"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23870 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙 중 "Cleansing the Sinner"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23871 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack 중 "Liberta Populi"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23873 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "Uncharted"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23874 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Sarah Connor''s Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23875 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "Ian''s Love Story"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23877 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "Henri-Christian"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23878 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Lockdown"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23882 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "Your Fantasy Begins Now"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23883 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Giantess of Ironwood"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23886 AND composer_id = 399 AND title = 'I Know This Much Is True (Music From The HBO Series) 중 "Yellow"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23887 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "The All‐Father"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23889 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "Ken and Andre in Battle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23890 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "Fatherly Lies"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23892 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "Easy to Talk To"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23893 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Onslaught at the Bridge"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23894 AND composer_id = 419 AND title = 'Black Sea Raid 중 "Spy Talk"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23897 AND composer_id = 421 AND title = 'Outlander: Season 7 (Original Television Soundtrack) 중 "A Home for Bree and Roger"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23900 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Eight: Shadow And Flame - Amazon Original Series Soundtrack) 중 "Confronting the Dark Wizard"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23901 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "The Road to the Farm"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23903 AND composer_id = 419 AND title = 'Final Judgement 중 "Suspect"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23904 AND composer_id = 421 AND title = 'Zom‐B Movie: Soundtrack 중 "Chillerama Main Title / Floyd’s Bean Bag"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23905 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙 중 "Tom and Marilyn"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23909 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "DARPA"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23910 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "Not My Fantasy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23911 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Hank’s Escape"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23912 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Three: The Eagle And The Sceptre - Amazon Original Series Soundtrack) 중 "Shelob''s Nest"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23913 AND composer_id = 421 AND title = 'Dark Void 중 "Theme from Dark Void (Mega version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23915 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "The Bakra"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23920 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "Randor and Marlena"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23924 AND composer_id = 399 AND title = 'I Know This Much Is True (Music From The HBO Series) 중 "Penny Ann Drinkwater"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23926 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Breaking Chains"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23929 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Sal Searches"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23931 AND composer_id = 419 AND title = 'Mr. Atlas 중 "Mr. Atlas To The Rescue"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23933 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "Freaky Credits"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23934 AND composer_id = 421 AND title = '영화 <에벌리> 사운드트랙 중 "Everly End Credits"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23937 AND composer_id = 419 AND title = 'Final Judgement 중 "The Fight / End Titles"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23943 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "Diploma"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23944 AND composer_id = 421 AND title = '영화 <더 보이> 사운드트랙 중 "Family Photos"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23945 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "Join This Fight"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23946 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "Converging Overload"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23948 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Freisinger and Richter"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23949 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙 중 "Run"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23950 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "Michael Learns the Truth"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23952 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "From Man to God"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23956 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "The Mask of Fargo"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23957 AND composer_id = 419 AND title = 'Black Sea Raid 중 "Dusk"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23959 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "Betrayed"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23963 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "Epilogues"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23964 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Mount Tam"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23967 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "At the Gates"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23973 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Old Rivals"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23974 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "A New Day Ahead"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23976 AND composer_id = 421 AND title = '영화 <포레스트: 죽음의 숲> 사운드트랙 중 "Journey to Aokigahara"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23978 AND composer_id = 421 AND title = '영화 <유로파 리포트> 사운드트랙 중 "Under the Ice"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23979 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "Exonerated"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23980 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "Wind and Rain"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23982 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "The Cleaning of Bert''s Head"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23984 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Vol. 1 중 "Clean Pease Strae"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23985 AND composer_id = 419 AND title = 'Final Judgement 중 "Sharons Discovery / Lusus in Persuit"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23986 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "So Many Lost"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23991 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "Black Sails Main Title"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23993 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "A Stable Beam"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23994 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Razad’s Tarocco"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23996 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "The Festival"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 23997 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "The Hand of Odin"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24000 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Wrath"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24004 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack 중 "Lucrezia and Leonardo"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24005 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Sal''s Death"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24006 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "True Creation Requires Sacrifice"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24007 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Rube Goldberg Death Machine"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24010 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Return to Lindon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24012 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "Spacewalk"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24013 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "The Magic Is Gone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24014 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙 중 "Up Above"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24016 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "In the Trench"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24021 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "Molly"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24022 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Samurai Hank"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24025 AND composer_id = 421 AND title = '영화 <유로파 리포트> 사운드트랙 중 "Mausoleum"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24028 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "Gaal Leaves Synnax"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24030 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "The Battle of Kakamucho"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24035 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Confronting Baptiste"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24037 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Eight: Shadow And Flame - Amazon Original Series Soundtrack) 중 "Wounds That Have Endured"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24040 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Unnatural Things"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24041 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "No Threats"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24045 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Ice Cubes"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24046 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "An Offer From Horatio"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24047 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Fargo''s Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24050 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Scales Goes Rogue"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24051 AND composer_id = 421 AND title = 'Outlander: Season 7 (Original Television Soundtrack) 중 "War Is Inevitable"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24052 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Eight: Shadow And Flame - Amazon Original Series Soundtrack) 중 "Shadow and Flame"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24056 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Eight: Shadow And Flame - Amazon Original Series Soundtrack) 중 "Sauron and Celebrimbor"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24057 AND composer_id = 421 AND title = '영화 <콜로설> 사운드트랙 중 "The Colossal Finale, Pt. 2"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24058 AND composer_id = 421 AND title = 'Dark Void 중 "Village Attack"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24059 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "Drifting in the Dark"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24062 AND composer_id = 421 AND title = 'Caprica 중 "A Tauron Sacrifice (Expanded Version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24064 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "Death Mwauthzyx Rises"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24065 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "Dinner for Another Reason"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24067 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Runaway Train"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24070 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Into Khazad‐dûm"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24073 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "Source Music (medley)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24075 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Seven: Doomed To Die - Amazon Original Series Soundtrack) 중 "Never Make War in Anger"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24077 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "Stampede"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24078 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "ISS SOS"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24079 AND composer_id = 421 AND title = 'Defiance: Original Television Soundtrack 중 "Lawkeeper"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24080 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Civil Unrest in the Island Kingdom"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24081 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "Autopeotomy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24082 AND composer_id = 399 AND title = 'I Know This Much Is True (Music From The HBO Series) 중 "Domenico"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24087 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Two: Where The Stars Are Strange - Amazon Original Series Soundtrack) 중 "Catastrophe at Khazad-dûm"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24090 AND composer_id = 421 AND title = 'Outlander: Season 7 (Original Television Soundtrack) 중 "Off to Work"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24096 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "Rescue Bird Feather"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24097 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "Teela Joins the Wild Hunt"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24098 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Coming of Night"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24100 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Redemption"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24102 AND composer_id = 421 AND title = 'Eli: Original Music From the Netflix Film 중 "Eli"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24103 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Celebrimbor’s Ambition"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24105 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "News of the Fire"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24106 AND composer_id = 419 AND title = 'Black Sea Raid 중 "Theft of a Nuclear Warhead"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24107 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Sheriff Carter''s Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24109 AND composer_id = 421 AND title = 'Outlander: Season 7 (Original Television Soundtrack) 중 "Ian and Rachel"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24113 AND composer_id = 419 AND title = 'Zero Option 중 "Reaching for Tomorrow''s Love"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24115 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Five: Halls Of Stone - Amazon Original Series Soundtrack) 중 "Gazing to Eressëa"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24121 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "The Crocodile''s Fire"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24122 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "Broadmoor Asylum"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24126 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Rodan"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24127 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Fading Light"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24128 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "Panic Room"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24130 AND composer_id = 421 AND title = 'Defiance: Original Television Soundtrack 중 "Lost to the River"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24133 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Jimbo’s Sacrifice"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24135 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Theme from Defiance"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24141 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "The First Gods"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24142 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "The Secret Archives"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24144 AND composer_id = 419 AND title = 'Zero Option 중 "Death of the Evil One"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24146 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙 중 "The Driver Gets Marilyn"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24149 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "The Reflection of a Misty Image"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24150 AND composer_id = 419 AND title = 'Raging Angels 중 "Molech Greets Sister Kate"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24152 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Bullet Train"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24156 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Brazil Nuts"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24161 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "Minor Begins"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24163 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "The Installation"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24172 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Henry''s Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24173 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "The Conference"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24174 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "Away You Hunters"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24175 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙 중 "Ten Years Later"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24177 AND composer_id = 418 AND title = '영화음악 <Amy>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24178 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "Ken Boards Ship"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24182 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "Visions and Arrest"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24184 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Dark Matter"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24187 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "Aardvark to Zymurgy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24188 AND composer_id = 399 AND title = 'I Know This Much Is True (Music From The HBO Series) 중 "That Place for Lunatics"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24190 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "When I Am Dead"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24191 AND composer_id = 421 AND title = '영화 <더 보이> 사운드트랙 중 "The Attic"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24192 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Tranquility"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24195 AND composer_id = 421 AND title = 'Dark Void 중 "Taking Flight"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24196 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Huldra Brothers"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24200 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "Joe’s Power Ballad"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24201 AND composer_id = 421 AND title = 'Defiance: Original Television Soundtrack 중 "Terraform My Heart"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24203 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Gorman’s Orders"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24206 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "New Day New Bodies"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24208 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "Arrival in Malta / Rooftop Chase"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24209 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙 중 "Ice Skating"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24213 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "The Mini Bar"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24214 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "Shop Class"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24215 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "A Prayer for My People"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24216 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Five: Halls Of Stone - Amazon Original Series Soundtrack) 중 "Sauron''s Design"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24217 AND composer_id = 419 AND title = 'Black Sea Raid 중 "The Rescue of Natalia Porofsky"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24219 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "Lucius in Pursuit"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24221 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Attack of the Bumblebee"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24223 AND composer_id = 421 AND title = 'Caprica 중 "Clarice Willow"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24224 AND composer_id = 419 AND title = 'Black Sea Raid 중 "Natalia’s Love"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24234 AND composer_id = 421 AND title = 'Caprica 중 "Amanda''s Forgiveness"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24236 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "Awakening"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24237 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "Nassau Shores"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24241 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "Barbed Wire Daddy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24243 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "Papa Bear (extended version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24244 AND composer_id = 421 AND title = 'Defiance: Original Television Soundtrack 중 "Castithan Bath"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24246 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Vol. 1 중 "The Woman of Balnain"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24247 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Three: The Eagle And The Sceptre - Amazon Original Series Soundtrack) 중 "The Wild Men"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24248 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "New Memories"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24249 AND composer_id = 421 AND title = 'Caprica 중 "Lacey and the Cylon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24251 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Tango Fight"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24254 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙 중 "Hazmat Suit"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24259 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "Death in the Tunnels"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24260 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Bloodthirst"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24264 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack 중 "Machu Picchu"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24265 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "A Town Called Eureka"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24267 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "The Astrolabe"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24268 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "Imaginary Kingdom"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24274 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "The Killing Starts"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24277 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "The Kingdom of Eliphaz"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24280 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "The Graystone Family"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24289 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "Living in the Past"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24294 AND composer_id = 421 AND title = '영화 <더 보이> 사운드트랙 중 "Rat Blood"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24295 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Origami"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24297 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "Minor Meets Murray"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24300 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "Satellite Symbol"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24302 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "Family and a Package"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24305 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "Tormented Lovers"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24306 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "Early Writing"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24309 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "The Mask"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24311 AND composer_id = 421 AND title = '영화 <포레스트: 죽음의 숲> 사운드트랙 중 "The Cabin"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24316 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "New York City Arrival"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24318 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "The Sigillum Dei Aemaeth"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24320 AND composer_id = 421 AND title = '영화 <에벌리> 사운드트랙 중 "God Rest Ye Merry Gentlemen"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24323 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Hellbugs"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24325 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "On the Raft"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24327 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙 중 "Theme from I Still See You"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24328 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "God of War Ragnarök (feat. Eivør)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24330 AND composer_id = 419 AND title = 'Raging Angels 중 "Chris''s Meeting"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24334 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Assassination in Milan"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24335 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "Zacaré the Healer"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24345 AND composer_id = 421 AND title = '영화 <더 보이> 사운드트랙 중 "The Phone Call and the Letter"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24347 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "What Happens Now"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24348 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Looking for Mister Right"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24349 AND composer_id = 421 AND title = 'Zom‐B Movie: Soundtrack 중 "Tainted Popcorn"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24357 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Three: The Eagle And The Sceptre - Amazon Original Series Soundtrack) 중 "The Great Eagle and the Forging"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24358 AND composer_id = 419 AND title = 'Mr. Atlas 중 "Fanfare And Opening"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24361 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "A True Writer"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24364 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Operation Tonga"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24365 AND composer_id = 419 AND title = 'Mr. Atlas 중 "Love In The Afternoon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24366 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Miserius Omnium"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24367 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Wise One"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24369 AND composer_id = 419 AND title = 'Raging Angels 중 "To Exorcise the Demonic Need"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24371 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode One: Elven Kings Under The Sky - Amazon Original Series Soundtrack) 중 "To Serve the Lord of Mordor"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24372 AND composer_id = 421 AND title = 'Caprica 중 "The Differently Sentient"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24373 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "Journey to Trantor"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24378 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Vol. 1 중 "The Wedding"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24380 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Kozmo"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24382 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Ninety-Niners"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24384 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Through the Vortex"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24386 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "A Poetry Reading"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24388 AND composer_id = 421 AND title = '영화 <더 보이> 사운드트랙 중 "Following the Rules"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24389 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Young Tracy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24391 AND composer_id = 421 AND title = 'Caprica 중 "Vergis'' Dream"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24396 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "The Battle of San Francisco"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24397 AND composer_id = 419 AND title = 'Raging Angels 중 "An Inner Tornado Brings Voices"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24398 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "This Wounded Land (vocal)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24399 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "The Life You Wanted"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24401 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Eight: Shadow And Flame - Amazon Original Series Soundtrack) 중 "True Wealth of the Mountain"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24402 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "As Goes Eternia"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24403 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "The Heart of the Island"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24404 AND composer_id = 421 AND title = '영화 <에벌리> 사운드트랙 중 "Allies"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24405 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Bad Influence"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24406 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "Duke and Simon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24407 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "River Run"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24408 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "Abandawe"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24410 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "A Daughter’s Wish"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24415 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "Demon Apes"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24416 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "Early Morning Intruder / Shattered Glass at Midnight"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24420 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Durin and His Family"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24421 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙 중 "Two Stories"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24422 AND composer_id = 419 AND title = 'Black Sea Raid 중 "Entrance to the Institution"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24423 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "Writing Catcher"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24427 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Motorcycle Robot Chase"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24428 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "Trail of Blood"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24431 AND composer_id = 421 AND title = 'Caprica 중 "Healing Wounds"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24442 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Brianna and Roger Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24444 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙 중 "Powertools"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24446 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "Humvee Chase"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24453 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "The Hammer of Thor"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24454 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Wandering Madera"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24457 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "The Greatest Circus Act That Ever Lived"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24458 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack 중 "Transfusion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24459 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Katherine’s Killer"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24460 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "The New Champion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24465 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Rise of Ghidorah"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24467 AND composer_id = 421 AND title = 'Zom‐B Movie: Soundtrack 중 "Fernando Phagabeefy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24472 AND composer_id = 421 AND title = 'Dark Void 중 "The Collector"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24474 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Southlands"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24476 AND composer_id = 421 AND title = 'Caprica 중 "Control and Power"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24477 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "Magnetic Resonance Imaging"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24478 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "Jennifer and Omar"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24481 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Tommy''s Place"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24485 AND composer_id = 421 AND title = '영화 <콜로설> 사운드트랙 중 "Have a Beer"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24488 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Asylum Fight"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24489 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Zed Mart Massacre"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24492 AND composer_id = 419 AND title = 'Zero Option 중 "Reaching Into the Darkness"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24494 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Orwell’s Recovery"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24496 AND composer_id = 421 AND title = '영화 <Rest Stop: Dead Ahead> 사운드트랙 중 "Tracy Kress"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24499 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "Freak Fight"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24501 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Shrapnel"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24505 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Into the Lion''s Den"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24506 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Rescuing Orwell"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24508 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Three: The Eagle And The Sceptre - Amazon Original Series Soundtrack) 중 "Funeral Pyre and Reconciliation"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24510 AND composer_id = 421 AND title = '영화 <Rest Stop: Dead Ahead> 사운드트랙 중 "Searing Heat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24512 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "An American Dream"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24516 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Catherine Weaver"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24517 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "The Trip Home"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24518 AND composer_id = 421 AND title = 'Dark Void 중 "Survivor Camp Combat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24520 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Cain"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24521 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Five: Halls Of Stone - Amazon Original Series Soundtrack) 중 "Mirdania Emerges"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24522 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙 중 "Message from Megan"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24524 AND composer_id = 421 AND title = '영화 <포레스트: 죽음의 숲> 사운드트랙 중 "The Reversing River"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24526 AND composer_id = 421 AND title = 'Caprica 중 "Dirteaters"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24528 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙 중 "Marilyn’s Blues"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24529 AND composer_id = 421 AND title = 'Eli: Original Music From the Netflix Film 중 "The Crypt"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24530 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "The Lovers"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24531 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Paint a Bullseye"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24534 AND composer_id = 421 AND title = 'Dark Void 중 "The Watcher Airship"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24535 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "Animal Crackers Overture (extended version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24539 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Andy at Bat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24540 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Four: Eldest - Amazon Original Series Soundtrack) 중 "Snaggleroot and Winterbloom"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24543 AND composer_id = 421 AND title = '영화음악 <The Walking Dead>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24546 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙 중 "Break My Heart"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24551 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "Tamacti Jun"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24559 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "Launch Sequence"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24562 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "Simon Calls the Shots"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24563 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "City Without the City"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24566 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙 중 "Dance Beneath the Ice"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24567 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Explosions In the Atmosphere"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24568 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "Lament for a Friend"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24572 AND composer_id = 421 AND title = 'Caprica 중 "Voices of the Dead"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24574 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Men In Masks"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24576 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "A Bottle of Japanese Whiskey"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24583 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Airborne and Lethal"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24590 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "And After All"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24594 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "Cornered"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24595 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Gabriel''s New Family"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24604 AND composer_id = 419 AND title = 'Black Sea Raid 중 "Escape From the Mental Institution"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24605 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "To the Hall of Lore"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24610 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "The Story of the First Witcher"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24611 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "Kitchen Combat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24613 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Leviathan"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24614 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Vol. 1 중 "Castle Leoch"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24615 AND composer_id = 421 AND title = '영화 <콜로설> 사운드트랙 중 "Confronting Oscar"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24617 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Fireside Flashback"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24619 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Welcome to Bougainville"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24622 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Tests of Isildur and Earien"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24624 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Seven: Doomed To Die - Amazon Original Series Soundtrack) 중 "War at the Wall"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24628 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Both Our Bloodlines"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24629 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Ragnarök"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24630 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "King of the Monsters"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24633 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "The Epic Battle of Evermore"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24634 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Ellison Spared"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24637 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Five: Halls Of Stone - Amazon Original Series Soundtrack) 중 "Assault on the Faithful"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24639 AND composer_id = 421 AND title = 'Dark Void 중 "Above the Canopy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24640 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Six: Where Is He? - Amazon Original Series Soundtrack) 중 "Accused in Númenor"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24643 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "No Thoughts No Words"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24645 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Only Grey"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24646 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "Who Ava Is"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24647 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode One: Elven Kings Under The Sky - Amazon Original Series Soundtrack) 중 "Three Rings for the Elven Kings"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24648 AND composer_id = 421 AND title = '영화 <에벌리> 사운드트랙 중 "A Gift From Taiko"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24649 AND composer_id = 421 AND title = 'Defiance: Original Television Soundtrack 중 "Before the Votans"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24650 AND composer_id = 419 AND title = 'Mr. Atlas 중 "Just Say, "Hey Dude, And I''ll Be Back""'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24651 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Perfect Creatures"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24658 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode One: Elven Kings Under The Sky - Amazon Original Series Soundtrack) 중 "Warning in the Words"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24659 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Sorrow, Water and Flame"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24661 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "Father and Son / Andre''s Death"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24665 AND composer_id = 421 AND title = '영화 <콜로설> 사운드트랙 중 "A Walk in the Park"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24667 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Jack and Callie"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24670 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "The Huntington Brothers"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24672 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "Simply Grand"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24674 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Revelation"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24675 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Eight: Shadow And Flame - Amazon Original Series Soundtrack) 중 "The White Flame"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24679 AND composer_id = 421 AND title = 'Zom‐B Movie: Soundtrack 중 "Deathication (Movement Number Two)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24681 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "Earn Our Valor"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24686 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "For Eternia, Pt. I"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24688 AND composer_id = 421 AND title = '영화 <Rest Stop: Dead Ahead> 사운드트랙 중 "Nicole''s Private Demon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24690 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Starlings"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24691 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "The S.A.R.A.H. Mobile"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24692 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "Two Tuesdays"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24693 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "Birth of the Savage"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24695 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "White Leaves"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24698 AND composer_id = 421 AND title = '영화 <해피 데스데이> 사운드트랙 중 "Day One"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24699 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "Cara''s Death"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24700 AND composer_id = 419 AND title = 'Mr. Atlas 중 "Legend Has It A Giant Sleeps There"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24703 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "The Laser Cannon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24705 AND composer_id = 421 AND title = '영화 <유로파 리포트> 사운드트랙 중 "A World Other Than Our Own"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24710 AND composer_id = 421 AND title = '영화 <포레스트: 죽음의 숲> 사운드트랙 중 "Curse of the Yurei"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24713 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Six: Where Is He? - Amazon Original Series Soundtrack) 중 "The Siege Begins"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24719 AND composer_id = 419 AND title = 'Mr. Atlas 중 "A Clouded Mind Only Shadows The Heart"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24721 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "Into the Misty Marsh"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24722 AND composer_id = 421 AND title = 'Caprica 중 "Lacey''s Test"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24726 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Infirmary"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24731 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Six: Where Is He? - Amazon Original Series Soundtrack) 중 "Trial by Abyss"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24732 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "Revelation – Main Title"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24735 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "A Devil, a Pig and a Clown"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24737 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "The Wedding and Skinner''s Death"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24738 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Whispered Souls"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24742 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Five: Halls Of Stone - Amazon Original Series Soundtrack) 중 "Unveiling the Doors of Durin"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24746 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Alex"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24748 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Outpost 32"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24749 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Welcome to Monarch"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24750 AND composer_id = 421 AND title = 'Dark Void 중 "The Prophesized One"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24751 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Follow the Leader"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24756 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "Airlock 6"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24759 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "The Game Master"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24762 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "The Trip to the Village"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24763 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Threat of Nuclear Cleaning"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24764 AND composer_id = 421 AND title = '영화 <Rest Stop: Dead Ahead> 사운드트랙 중 "Driver Closes In"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24766 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack 중 "The Antidote"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24767 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "Eliza Merrett"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24768 AND composer_id = 419 AND title = 'Zero Option 중 "Love in the Evening"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24769 AND composer_id = 419 AND title = 'Final Judgement 중 "Goodnight Mom"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24771 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Theo in the Shadows"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24772 AND composer_id = 421 AND title = 'Dark Void 중 "Theme from Dark Void"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24774 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Justice Takes Time"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24775 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "The Hydra"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24776 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Vol. 1 중 "The Veil of Time"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24780 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Five: Halls Of Stone - Amazon Original Series Soundtrack) 중 "Seven for the Dwarf-lords"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24781 AND composer_id = 419 AND title = 'Mr. Atlas 중 "Wilshire And Phil Discover The Gold"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24785 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "Into Preternia"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24788 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "Save the Fans"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24789 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Forodwaith"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24791 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "The Butcher and the Beaver"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24792 AND composer_id = 421 AND title = 'Eli: Original Music From the Netflix Film 중 "The House"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24799 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "The Flame of Love’s Betrayal"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24800 AND composer_id = 421 AND title = 'Defiance: Original Television Soundtrack 중 "Besásh"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24801 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Gold Team"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24802 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "Regret Is a Disease"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24804 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "The Handfasting Ceremony"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24808 AND composer_id = 421 AND title = 'Caprica 중 "Caprica Main Title"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24810 AND composer_id = 419 AND title = 'Raging Angels 중 "A View From Above"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24812 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Car Attack"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24813 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Mutants of Delta Bunker"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24815 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Courthouse Brawl"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24816 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Taggart''s Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24818 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "Karina"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24821 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Taking Down the Lights"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24824 AND composer_id = 421 AND title = 'Zom‐B Movie: Soundtrack 중 "The Final Reel"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24827 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "We''re Here"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24831 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "Cassiopeia"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24832 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Two: Where The Stars Are Strange - Amazon Original Series Soundtrack) 중 "Invitation to Eregion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24834 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "Meldof and Gwen"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24835 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "The Hidden Map"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24837 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "The Familiar Blacksmith"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24845 AND composer_id = 421 AND title = '영화 <Welcome Home> 사운드트랙 중 "Two Truths One Lie"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24847 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Crimson Aftermath"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24849 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "Blacklight Maze"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24850 AND composer_id = 421 AND title = '영화 <콜로설> 사운드트랙 중 "Birth of the Monster"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24852 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Life in America"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24853 AND composer_id = 421 AND title = 'Dark Void 중 "Prologue and Main Title"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24854 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "From Under the Floorboards"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24855 AND composer_id = 421 AND title = 'Caprica 중 "Barnabus"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24858 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "The Truck with No Engine"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24859 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Delivering the Message"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24863 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "Poachers"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24864 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "A Leaf Burns"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24867 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "Rock Wall Battle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24871 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "How Are We Gonna Live in Mexico… If We’re Dead?"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24872 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "The Cape Main Title"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24880 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "Skeletor, Lord of Destruction"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24882 AND composer_id = 419 AND title = 'Zero Option 중 "Wicked''s Hood"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24883 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Derek Reese"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24890 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Adar Lord‐Father"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24891 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "The Hand of God"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24892 AND composer_id = 419 AND title = 'Zero Option 중 "Molecules"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24894 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Deactivating Chucky"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24896 AND composer_id = 421 AND title = '영화 <에벌리> 사운드트랙 중 "Dead Man"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24901 AND composer_id = 419 AND title = 'Zero Option 중 "The Sleepless"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24902 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "Malva Christie"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24904 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Firing Excalibur"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24906 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "The Promise of the Imperium"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24907 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "Conversion Disorder"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24908 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Passing the Mantle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24909 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "Three Crosses"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24910 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "The Cape Keeps Watch"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24911 AND composer_id = 421 AND title = '영화 <Rest Stop: Dead Ahead> 사운드트랙 중 "Plea for Death"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24912 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Three: The Eagle And The Sceptre - Amazon Original Series Soundtrack) 중 "The Rings of Power - London Premiere Season One Fanfare (Bonus Track)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24914 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Ikachu"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24915 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Zane on the Lam"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24916 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Da Vinci’s Demons End Credits"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24919 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "An Intriguing Suggestion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24920 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "A Nation of Thieves"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24923 AND composer_id = 421 AND title = '영화 <에벌리> 사운드트랙 중 "Fighting to Survive"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24925 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Four: Eldest - Amazon Original Series Soundtrack) 중 "The Dark Wizard"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24926 AND composer_id = 421 AND title = 'Eli: Original Music From the Netflix Film 중 "Must Get out of Here"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24929 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Arthur''s Elegy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24931 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Kaslan Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24935 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Madera Combat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24938 AND composer_id = 421 AND title = 'Eli: Original Music From the Netflix Film 중 "Burning Distrust"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24940 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "Through the Woods"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24941 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Children of Caprica"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24944 AND composer_id = 421 AND title = 'Caprica 중 "Gemenon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24945 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "Anacreon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24946 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "Ken Parachutes / Overlooking Malta"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24949 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "Out of Game"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24951 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Four Heroes"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24952 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Raiders"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24955 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Return to Helheim"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24956 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Vol. 1 중 "Dance of the Druids"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24959 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "The Heathers"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24962 AND composer_id = 419 AND title = 'Black Sea Raid 중 "Burial at Sea"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24963 AND composer_id = 419 AND title = 'Mr. Atlas 중 "Mr. Atlas Main Title Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24965 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Stephanie’s Ring"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24967 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "Innocence (Theme from Rebel in the Rye)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24969 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Cronhite Bunker"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24973 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "The Lich"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24974 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Turning Point"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24975 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Letting Go"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24977 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Two Weddings"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24981 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "The Children of Jerlamarel"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24982 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Freddie Meets Olivia"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24983 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Showdown"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24984 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "We Haunt Ourselves"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24987 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "Father Voss"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24989 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "A Collaboration and Friendship"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24991 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "Cleaved in Twain"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 24995 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Seven: Doomed To Die - Amazon Original Series Soundtrack) 중 "Damrod"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25002 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙 중 "The New Michelle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25004 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Vol. 1 중 "The Marriage Contract"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25005 AND composer_id = 419 AND title = 'Final Judgement 중 "David and Ariel / David''s Fight"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25007 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Black Flags"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25008 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙 중 "Nicole’s Ghost"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25009 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Lucrezia Donati"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25011 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "Patricia''s Capture / On a Cliff"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25015 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Monotheism at the Athena Academy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25017 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Scales"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25023 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Reggie''s Pressing"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25030 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "The Clan"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25031 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙 중 "A Bright Red Flash"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25032 AND composer_id = 421 AND title = 'Eli: Original Music From the Netflix Film 중 "Eli Reborn"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25035 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Brianna in the Snow"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25036 AND composer_id = 419 AND title = 'Zero Option 중 "The Inevitable Fall"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25038 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Offering Snails"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25040 AND composer_id = 419 AND title = 'Black Sea Raid 중 "The Man Who Could Drive Anything"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25041 AND composer_id = 419 AND title = 'Zero Option 중 "The Dripping of Time"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25042 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Tamara''s Heartbeat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25043 AND composer_id = 419 AND title = 'Final Judgement 중 "Reinforcements"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25044 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Perils of Migration"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25046 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Motorcycle Escape"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25051 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode One: Elven Kings Under The Sky - Amazon Original Series Soundtrack) 중 "Dawn of the Second Age"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25052 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Six: Where Is He? - Amazon Original Series Soundtrack) 중 "The Crown of Morgoth"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25055 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Stop Running"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25056 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Derek''s Mission"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25057 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "A New Ore"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25059 AND composer_id = 419 AND title = 'Black Sea Raid 중 "Kiss Your Ass Goodbye"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25067 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "Funeral at Sea"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25068 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Polina''s Vengeance"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25073 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Paul''s Decision"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25074 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "The Cloverfield Paradox"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25075 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "Misleading the Enemy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25076 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "San Francisco Shadows"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25079 AND composer_id = 421 AND title = 'Dark Void 중 "Archon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25080 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "I Will Make The Blue Coats My Enemy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25082 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "The Rats of Tobruk"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25084 AND composer_id = 421 AND title = 'Caprica 중 "Apotheosis"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25086 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "Zucchini Chase"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25087 AND composer_id = 419 AND title = 'Raging Angels 중 "Sister Kate Asks for Help"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25088 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Siege in the Southlands"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25090 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Chance’s Old Boss"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25094 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Pull of the Light (feat. Eivør)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25095 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Pacific Heat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25098 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Theme From Defiance (extended version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25099 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Chikie''s Last Canoli"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25105 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "A Reason to Stay"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25107 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "The Katherine Walters File"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25108 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Torn Contract"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25111 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "Eye of the Storm"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25112 AND composer_id = 421 AND title = 'Outlander: Season 7 (Original Television Soundtrack) 중 "Saratoga"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25114 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "Waking Up"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25117 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "The New Neighbors"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25119 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Fire and Rock"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25120 AND composer_id = 419 AND title = 'Mr. Atlas 중 "Your Chariot Moves Without Horses"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25121 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Cybernetic Life Form Node"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25122 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "The Wounded Bear Goes Down"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25127 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Battle for Control"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25128 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "The Final Battle and Massacre"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25129 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "Motherly Pride"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25130 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙 중 "The Concrete Cell"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25131 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Means to an End"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25136 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "Scare Glow, Lord of Subternia"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25139 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Kitchen Battle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25140 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Flight of the Columbina"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25142 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "Magno-Putty"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25143 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Confession and Sailing Into the Dawn"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25144 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Angel Island"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25145 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Four: Eldest - Amazon Original Series Soundtrack) 중 "Elves Embark"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25146 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Ship Him to Jersey"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25147 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Do No Harm"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25149 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "Home Life"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25150 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "Stalker at the Gym"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25153 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "Maghra’s Fable"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25158 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙 중 "Valencia"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25159 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "The Forklift"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25162 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "Jensen"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25166 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Skydive"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25169 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Vol. 1 중 "Comin’ Thro’ the Rye"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25170 AND composer_id = 421 AND title = '영화 <Welcome Home> 사운드트랙 중 "Bryan and Cassie"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25174 AND composer_id = 421 AND title = 'Eli: Original Music From the Netflix Film 중 "The Final Procedure"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25176 AND composer_id = 421 AND title = '영화 <해피 데스데이> 사운드트랙 중 "Day Four"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25178 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Three: The Eagle And The Sceptre - Amazon Original Series Soundtrack) 중 "Númenórean Grief"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25191 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Old Chance"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25193 AND composer_id = 421 AND title = '영화 <Rest Stop: Dead Ahead> 사운드트랙 중 "Memories of Jesse"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25197 AND composer_id = 421 AND title = 'Dark Void 중 "Hieroglyphs and Betrayal"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25198 AND composer_id = 419 AND title = 'Black Sea Raid 중 "Falling Tires, Blazing Bullets"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25199 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "A Cheval Toutes Homes a Cheval"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25202 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "The Landfill"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25204 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "The Story of Death Mwauthzyx"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25207 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "Can’t Save Everyone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25208 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Welcome to the Tribe"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25209 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Constellation of Fireflies"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25210 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "EMP"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25211 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Fog Over Fenway"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25212 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "Life at the Circus"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25216 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "A Car Accident"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25217 AND composer_id = 421 AND title = 'Caprica 중 "Burlesque"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25220 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Daniel Captures the Code"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25221 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "Silver Overboard"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25222 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Eight: Shadow And Flame - Amazon Original Series Soundtrack) 중 "No Passage for Low Men"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25223 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Prisoners of War"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25224 AND composer_id = 421 AND title = 'Zom‐B Movie: Soundtrack 중 "One Hell of a Show"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25226 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Three: The Eagle And The Sceptre - Amazon Original Series Soundtrack) 중 "The Rings of Power - Title Announcement Trailer (Bonus Track)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25229 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Ridgecrest Mine"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25233 AND composer_id = 421 AND title = '영화 <포레스트: 죽음의 숲> 사운드트랙 중 "Theme From “The Forest”"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25234 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode One: Elven Kings Under The Sky - Amazon Original Series Soundtrack) 중 "Círdan"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25235 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Five: Halls Of Stone - Amazon Original Series Soundtrack) 중 "Disa in the Depths"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25239 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Dangerous Diversion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25241 AND composer_id = 421 AND title = '영화 <Rest Stop: Dead Ahead> 사운드트랙 중 "Road Rage"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25244 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Stalking Sal"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25245 AND composer_id = 419 AND title = 'Mr. Atlas 중 "I Am Atlas, Son Of Iapetus"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25246 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "Two Standing Stones"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25247 AND composer_id = 421 AND title = 'Caprica 중 "Grieving (Alternate Version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25249 AND composer_id = 419 AND title = 'Black Sea Raid 중 "The Crimean Coast"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25251 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "The Tiger"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25252 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Four: Eldest - Amazon Original Series Soundtrack) 중 "Eldest"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25253 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Memories of Dancing"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25254 AND composer_id = 421 AND title = 'Dark Void 중 "Ava''s Sacrifice"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25255 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Seven: Doomed To Die - Amazon Original Series Soundtrack) 중 "Nine for Mortal Men"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25256 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Military Camp Rescue"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25260 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Failed Rescue"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25262 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "Running for the Plane"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25264 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "The Story of the Shield"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25265 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Treasures of the Vatican"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25266 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Transformed by Darkness"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25267 AND composer_id = 419 AND title = 'Raging Angels 중 "Molech''s Revenge"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25268 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Removing Cameron''s Chip"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25270 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "For Andrew"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25272 AND composer_id = 421 AND title = '영화 <콜로설> 사운드트랙 중 "A Monster Hypothesis"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25273 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Everyone''s Dumb"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25274 AND composer_id = 421 AND title = '영화 <에벌리> 사운드트랙 중 "Resolution"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25279 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "Back to the Hospital"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25283 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "Happy Death Day 2U End Credits"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25285 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "The Murray Family"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25286 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "Fanfare for Bullet Man"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25289 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "Killer Robots"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25291 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙 중 "Tom to the Rescue"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25292 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "The Dragon Capsule"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25294 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "Venomous Strike of the Intruder"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25298 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "Masters of the Universe: Revelation (extended version)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25299 AND composer_id = 421 AND title = '영화 <콜로설> 사운드트랙 중 "The Most Irresponsible Thing"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25303 AND composer_id = 419 AND title = 'Final Judgement 중 "Lusus Attacks / Ariel''s Rape"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25308 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Adrift"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25309 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "The Whole World Is Burning"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25312 AND composer_id = 419 AND title = 'Final Judgement 중 "The Chase"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25313 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "The Bath of Another Angle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25314 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙 중 "The Burn"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25315 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Saboteur"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25316 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "The Fortress"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25324 AND composer_id = 399 AND title = 'I Know This Much Is True (Music From The HBO Series) 중 "Angela"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25325 AND composer_id = 421 AND title = '영화 <유로파 리포트> 사운드트랙 중 "The View"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25329 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "The Debutante"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25335 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "Morning Millie"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25336 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Successor"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25337 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "The Imperial Library"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25339 AND composer_id = 421 AND title = '영화 <해피 데스데이> 사운드트랙 중 "Day Three"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25340 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "Ken''s Ritual"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25345 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Riding Bikes"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25349 AND composer_id = 419 AND title = 'Raging Angels 중 "Sister Kate Reaches for Chris"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25350 AND composer_id = 419 AND title = 'Zero Option 중 "Sweet Memories"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25351 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Wade into the Weeds"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25352 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Three: The Eagle And The Sceptre - Amazon Original Series Soundtrack) 중 "The Rings of Power - Season Two Overture (Bonus Track)"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25353 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Central America"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25355 AND composer_id = 419 AND title = 'Raging Angels 중 "The Dance of Darkness"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25358 AND composer_id = 421 AND title = '영화 <에벌리> 사운드트랙 중 "Taiko"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25361 AND composer_id = 419 AND title = 'Raging Angels 중 "A Distant Reach for a Lost Touch"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25366 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "Witch Finders"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25367 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Grove"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25370 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Númenor Prepares"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25371 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Apple"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25373 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Red in the River"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25377 AND composer_id = 421 AND title = 'Dark Void 중 "A Mysterious Jungle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25379 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "Solving Equations"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25380 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "For Eternia, Pt. V"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25381 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "I Am Still Here"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25383 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "The Nerdy Hero"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25388 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "Love in the Night"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25390 AND composer_id = 421 AND title = '영화 <콜로설> 사운드트랙 중 "Separate Ways"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25396 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙 중 "Ghost Fish"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25397 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "On the Beach"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25398 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "John and Riley"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25399 AND composer_id = 419 AND title = 'Zero Option 중 "The Drift of a Late Night Dream"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25401 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Memories of San Francisco"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25402 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "Rebel Attack and Goodbye to War"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25405 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Vanguard"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25406 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙 중 "The Russian Trawler / Brian''s Disappointment"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25407 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "The Committee of Safety"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25410 AND composer_id = 421 AND title = 'Outlander: Season 7 (Original Television Soundtrack) 중 "Ticonderoga"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25412 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "I Love You"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25413 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Zhen Zhen and Alex"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25414 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "The Wrecks"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25416 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "The Alkenny People"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25417 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Orwell’s Dream"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25418 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "Mysterious Green Stuff"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25422 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "Little Cookie Me"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25423 AND composer_id = 421 AND title = '영화 <더 보이> 사운드트랙 중 "Goodnight Brahms"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25425 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Svartalfheim"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25426 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Two: Where The Stars Are Strange - Amazon Original Series Soundtrack) 중 "The Gaudrim"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25427 AND composer_id = 421 AND title = '영화 <콜로설> 사운드트랙 중 "Jealousy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25428 AND composer_id = 419 AND title = 'Mr. Atlas 중 "A Fast Jeep And A Rough Road"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25429 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Confronting Chess"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25430 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "A Nuke for Fargo"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25433 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "Baba Unleashed"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25442 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "Brax Makes His Move"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25445 AND composer_id = 419 AND title = 'Zero Option 중 "The Vision of Death"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25447 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "The Only Story"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25448 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Jacopo"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25449 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "In the Cave"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25466 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Ghosts of Palm City"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25468 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Vol. 1 중 "People Disappear All the Time"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25470 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "Ava and Michael"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25474 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "Running Scared Before Sunrise"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25475 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "Stalking the Elusive Shadow"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25476 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Baptiste"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25478 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "You Want the Money?"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25482 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "The Getaway"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25483 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "The Photographer’s Wish"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25486 AND composer_id = 421 AND title = 'Eli: Original Music From the Netflix Film 중 "Eli on the Run"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25488 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Birth of Chucky"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25490 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "Willie"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25491 AND composer_id = 419 AND title = 'Mr. Atlas 중 "Danny''s Discovery In The Cave"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25492 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Amanda Graystone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25493 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Henry and Beverly"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25495 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "The Adama Name"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25499 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Gregor Molotov"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25500 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Showdown on the Super Bowl"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25501 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "The Extinguished Torch"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25502 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Jotunheim"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25505 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Highwire Training"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25506 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "Ice Cold"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25507 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "The Tide of Transformation"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25508 AND composer_id = 421 AND title = '영화 <Rest Stop: Dead Ahead> 사운드트랙 중 "An Officer''s Story"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25509 AND composer_id = 421 AND title = '영화 <콜로설> 사운드트랙 중 "The Colossal Finale, Pt. 1"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25510 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode One: Elven Kings Under The Sky - Amazon Original Series Soundtrack) 중 "The Last Hope for All Middle‐Earth"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25512 AND composer_id = 419 AND title = 'Zero Option 중 "Lee''s Deadline"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25515 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "Tail Spin"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25518 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "Union Trash"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25520 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "Theme From Angry Video Game Nerd: The Movie"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25522 AND composer_id = 419 AND title = 'Mr. Atlas 중 "A Day In Town"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25525 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Rim of the World"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25526 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "The New Doll"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25527 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙 중 "Rattlesnake on the Highway"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25529 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "Unidentified Flying Nerd"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25533 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "Roboto Reforges"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25537 AND composer_id = 419 AND title = 'Mr. Atlas 중 "Danny And Gus In The Barn"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25538 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "Jessica"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25539 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "Streets of Nassau"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25540 AND composer_id = 421 AND title = 'Zom‐B Movie: Soundtrack 중 "Rosemary’s Picnic Table"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25543 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "Bree and Roger''s Journey"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25545 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "Revolution Approaching"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25548 AND composer_id = 419 AND title = 'Zero Option 중 "Running Out of Time"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25550 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Kaslan Car"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25551 AND composer_id = 421 AND title = '영화 <유로파 리포트> 사운드트랙 중 "Airlock"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25554 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Three: The Eagle And The Sceptre - Amazon Original Series Soundtrack) 중 "Enter Damrod"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25556 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "Find the Way, Child"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25558 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Theme From Child’s Play"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25559 AND composer_id = 421 AND title = 'Zom‐B Movie: Soundtrack 중 "Deathication"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25560 AND composer_id = 419 AND title = 'Black Sea Raid 중 "Death in the Afternoon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25562 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Only Blood Can Bind"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25564 AND composer_id = 419 AND title = 'Mr. Atlas 중 "A Season For Everything"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25567 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Welcome To the Camp"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25570 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "The Last Phone Call"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25577 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "A Helping Hoof"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25579 AND composer_id = 421 AND title = 'Zom‐B Movie: Soundtrack 중 "Seducing Ryan"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25580 AND composer_id = 419 AND title = 'Raging Angels 중 "Chris''s Question"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25581 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "Slightly Badass"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25582 AND composer_id = 421 AND title = 'Caprica 중 "Caprica Buccaneers Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25583 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Enter the Sumo"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25584 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "The Andromache"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25587 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "The Larva"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25596 AND composer_id = 421 AND title = '영화 <유로파 리포트> 사운드트랙 중 "Cosmically Astounding"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25598 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Ice Breaker"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25601 AND composer_id = 421 AND title = 'Dark Void 중 "Ava and Tesla Return"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25603 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "Brock and Woodley"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25606 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Fraser Family Reunion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25609 AND composer_id = 421 AND title = 'Caprica 중 "Tamara Kills"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25610 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Stephen Bonnet Theme"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25611 AND composer_id = 421 AND title = '영화 <더 보이> 사운드트랙 중 "Through the Keyhole"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25615 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "Ava"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25616 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "For Eternia, Pt. II"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25619 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Olivia''s Death"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25620 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "The Echo and the River"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25621 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "He Was Writing"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25625 AND composer_id = 421 AND title = '영화 <더 보이> 사운드트랙 중 "The Boy Main Title"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25627 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙 중 "The Riyadh Job"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25628 AND composer_id = 421 AND title = 'Dark Void 중 "Defending the Ark"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25630 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Six: Where Is He? - Amazon Original Series Soundtrack) 중 "The Secret Fire"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25631 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack 중 "Riario Confesses"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25632 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Four: Eldest - Amazon Original Series Soundtrack) 중 "Lair of the Barrow-wights"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25633 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Beyond Our Wandering"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25634 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "John Grey"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25637 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "The Plan"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25638 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "An Awesome American Car"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25642 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "Finding Duncan"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25643 AND composer_id = 421 AND title = 'Outlander: Season 7 (Original Television Soundtrack) 중 "A Soldier''s Return"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25647 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Samurai for Dummies"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25648 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "The Gun Battery"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25650 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "Sorceress Under Siege"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25653 AND composer_id = 421 AND title = 'Dark Void 중 "Tesla''s Laboratory"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25654 AND composer_id = 421 AND title = '영화 <포레스트: 죽음의 숲> 사운드트랙 중 "Into the Forest"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25661 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Light of El-Alamein"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25662 AND composer_id = 419 AND title = 'Black Sea Raid 중 "A Soldier’s Suspicion"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25664 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "Blazing Samurai"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25668 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "To a New Beginning"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25669 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "Jerlamarel"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25671 AND composer_id = 421 AND title = 'Zom‐B Movie: Soundtrack 중 "Ryan to the Rescue"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25675 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "Death Enters Without Knocking"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25676 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "Inspiration at War"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25677 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "Abominog Battle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25678 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "Balor"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25679 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Bear Killer"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25683 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Two: Where The Stars Are Strange - Amazon Original Series Soundtrack) 중 "Before Darkness Blinds Us All"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25685 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "For Eternia, Pt. IV"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25687 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙 중 "Nerd Nightmares"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25692 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "The Professor and the Madman"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25700 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "The Dream of Cleon the First"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25702 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙 중 "Revelation and Transference"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25706 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "The Temptation of Evil Lyn"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25709 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack 중 "The Test of Worthiness"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25710 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "The Promise of John Grey"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25711 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Seven: Doomed To Die - Amazon Original Series Soundtrack) 중 "The Battle for Eregion Begins"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25712 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "Every Guest Gets a Fantasy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25714 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Prehistoric Love Spores"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25719 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "You Deserve It"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25722 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Cromartie in the Hospital"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25723 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "The Faraday Family"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25728 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Miles Dyson''s Grave"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25730 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Joseph and Daniel"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25731 AND composer_id = 421 AND title = 'Eli: Original Music From the Netflix Film 중 "Forgive Me"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25738 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Battle in Boston"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25741 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "The Sixth Operator"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25747 AND composer_id = 399 AND title = 'I Know This Much Is True (Music From The HBO Series) 중 "The Twins"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25748 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "Escape Pod"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25749 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Five: Halls Of Stone - Amazon Original Series Soundtrack) 중 "Gil-galad''s Vision"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25750 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙 중 "The City of Ghosts"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25751 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙 중 "Underground"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25755 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Before the Storm"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25758 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "Knife Heist"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25760 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Monastery in the Mountains"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25767 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Man of Worth"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25772 AND composer_id = 419 AND title = 'Mr. Atlas 중 "The Joy Of Being Followed"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25777 AND composer_id = 408 AND title = '영화음악 <Cygańska jesień>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25779 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Chucky’s Trap"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25781 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Tickle Time"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25782 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙 중 "The Captain Fires Once"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25783 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Strange Skies"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25784 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Nobody Walks Alone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25789 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Dariush the Great"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25792 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4 중 "Fraser''s Ridge"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25794 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Train Fight"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25797 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Two: Where The Stars Are Strange - Amazon Original Series Soundtrack) 중 "Despair Under the Mountain"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25799 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙 중 "Finding the Pamphlet"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25800 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Casino Attack"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25803 AND composer_id = 399 AND title = 'I Know This Much Is True (Music From The HBO Series) 중 "To the Falls"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25805 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Eight: Shadow And Flame - Amazon Original Series Soundtrack) 중 "The Fall of Galadriel"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25810 AND composer_id = 419 AND title = 'Zero Option 중 "The Desire of a Woman Gone Mad"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25811 AND composer_id = 421 AND title = 'Caprica 중 "Amanda''s Epiphany"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25812 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Vol. 1 중 "The Losing Side of History"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25815 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "The Glider"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25821 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series 중 "Little Big Bang"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25822 AND composer_id = 421 AND title = '영화 <Rest Stop: Dead Ahead> 사운드트랙 중 "Gasoline"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25824 AND composer_id = 419 AND title = 'Zero Option 중 "The First Day Out of Prison"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25827 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "Lee-Ray"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25828 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "The Ballad of Tom Christie"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25829 AND composer_id = 421 AND title = '영화 <포레스트: 죽음의 숲> 사운드트랙 중 "Alone in the Cave"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25831 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "Godbone"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25832 AND composer_id = 421 AND title = '영화 <유로파 리포트> 사운드트랙 중 "Landing on Europa"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25834 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙 중 "Blacklight"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25836 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "The White Board"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25837 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "Underneath the Godfire"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25839 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙 중 "Search for a Past Beyond Tomorrow"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25840 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "Freaky Prologue"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25841 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "Lacey and Zoe-A"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25842 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack 중 "Florence Under Siege"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25844 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙 중 "Roxanne''s Dilemma"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25845 AND composer_id = 421 AND title = '영화 <더 보이> 사운드트랙 중 "Out of the Mirror"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25846 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙 중 "Fighting Fire"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25847 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Bombing Run"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25851 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "Star Bridge"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25852 AND composer_id = 421 AND title = 'Call of Duty: Vanguard 중 "Rigs and the Hunters"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25860 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "Holy Moly"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25862 AND composer_id = 421 AND title = 'Caprica 중 "Rites of Passage"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25864 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "The Trial of Hari Seldon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25866 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Vlad the Third"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25867 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "Monkeying Around"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25871 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙 중 "The Hell Lord Abominog"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25872 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series) 중 "Scian’s Camp"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25874 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack) 중 "Over the Horizon"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25876 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙 중 "Circus Memorial"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25877 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "Into the Wasteland"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25879 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Countdown"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25880 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Wolves"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25882 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack 중 "Queen Kane"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25883 AND composer_id = 419 AND title = 'Zero Option 중 "A Thought for Tomorrow"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25887 AND composer_id = 421 AND title = 'Outlander: Season 7 (Original Television Soundtrack) 중 "What Awaits Us in Paradise"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25892 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "The Power of Grayskull"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25893 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Clawhammer’s Betrayal"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25894 AND composer_id = 421 AND title = 'Caprica 중 "The Cylon Whisperer"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25895 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙 중 "Whitney"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25897 AND composer_id = 421 AND title = 'Caprica 중 "The Dive Bar"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25901 AND composer_id = 421 AND title = '영화 <Welcome Home> 사운드트랙 중 "Destroying the Evidence"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25902 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "The Mighty Motherboard of Tri‐Klops"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25903 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Emma Barnes"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25906 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Five: Halls Of Stone - Amazon Original Series Soundtrack) 중 "Deceit in the Craft"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25919 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "Orko’s Bubble"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25922 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "All Saints"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25929 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack 중 "Opposite Sides"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25931 AND composer_id = 421 AND title = 'Dark Void 중 "Ava and the Rocket"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25932 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack 중 "Ben Venga Maggio"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25936 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Vol. 1 중 "Fallen Through Time"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25940 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "Lizzie''s Love Story"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25942 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack) 중 "Vanaheim"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25943 AND composer_id = 419 AND title = 'Zero Option 중 "The Drift of an Afternoon Dream"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25945 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙 중 "Rebel in the Rye End Credits"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25946 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙 중 "Mutant Space Worms"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25948 AND composer_id = 421 AND title = '영화 <Welcome Home> 사운드트랙 중 "Watching"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25951 AND composer_id = 421 AND title = '영화 <Rest Stop: Dead Ahead> 사운드트랙 중 "Stranded"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25955 AND composer_id = 421 AND title = '영화 <해피 데스데이> 사운드트랙 중 "Day Two"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25957 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1 중 "Evil‐Lyn Opens Heaven’s Gate"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25958 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙 중 "Homecoming at the Old Mill"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25961 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙 중 "JPL"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25965 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack 중 "Attack at Marin"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25966 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Four: Eldest - Amazon Original Series Soundtrack) 중 "Concerning Stoors"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25967 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One 중 "Carrying a Giant"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25970 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2) 중 "For Eternia, Pt. III"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25971 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙 중 "Karen and Andy"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25974 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙 중 "Freddie Catches the Ball"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25976 AND composer_id = 421 AND title = '영화 <콜로설> 사운드트랙 중 "Colossal Prologue"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25977 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack 중 "Highway Battle"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25978 AND composer_id = 419 AND title = 'Zero Option 중 "Love for a Grandson"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25979 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6 중 "Fergus and Marsali"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25983 AND composer_id = 421 AND title = 'Defiance: Original Television Soundtrack 중 "Nolan and Irisa Reunite"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25988 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Switching Sides"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25992 AND composer_id = 421 AND title = '영화 <Welcome Home> 사운드트랙 중 "Benvenuti"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25994 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙 중 "Birthday Candles"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25995 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "The New Christopher Chance"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25996 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "The Key to Coexistence"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 25999 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙 중 "The Shogun"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 26002 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode 중 "A Tauron Sacrifice"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 26003 AND composer_id = 421 AND title = 'Defiance: Original Television Soundtrack 중 "Welcome to Defiance"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 26005 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack 중 "Clawhammer"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 26007 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3 중 "The Art of Seduction"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 26008 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack 중 "Skyhook Rescue"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 26009 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack 중 "The Banner of Captain Flint"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 26011 AND composer_id = 419 AND title = 'Zero Option 중 "Love Waits"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 26012 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙 중 "Queen of the Monsters"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 26013 AND composer_id = 421 AND title = 'Dark Void 중 "Will and Ava"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32675 AND composer_id = 83 AND title = '영화음악 <황금 산맥>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32679 AND composer_id = 83 AND title = '영화음악 <막심의 귀환>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32681 AND composer_id = 83 AND title = '영화음악 <친구들>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32682 AND composer_id = 83 AND title = '영화음악 <위대한 시민> 1부'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32684 AND composer_id = 83 AND title = '영화음악 <조야>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32686 AND composer_id = 83 AND title = '영화음악 <평범한 사람들>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32689 AND composer_id = 83 AND title = '영화음악 <젊은 근위대>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32690 AND composer_id = 83 AND title = '영화음악 <엘베강의 만남>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32693 AND composer_id = 83 AND title = '영화음악 <벨린스키>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32698 AND composer_id = 83 AND title = '영화음악 <등에>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32700 AND composer_id = 83 AND title = '영화음악 <첫 번째 제대>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32704 AND composer_id = 83 AND title = '영화음악 <일생 같은 한 해>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32759 AND composer_id = 84 AND title = '영화 음악 <알렉산드르 넵스키>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32768 AND composer_id = 84 AND title = '영화 음악 <이반 뇌제>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32772 AND composer_id = 84 AND title = '영화 음악 <레르몬토프>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32773 AND composer_id = 84 AND title = '영화 음악 <코토프스키>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32774 AND composer_id = 84 AND title = '영화 음악 <우크라이나 초원의 파르티잔>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32775 AND composer_id = 84 AND title = '영화 음악 <토냐>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32803 AND composer_id = 93 AND title = '영화음악 <Candyman>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32811 AND composer_id = 93 AND title = '영화음악 <Koyaanisqatsi>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32812 AND composer_id = 93 AND title = '영화음악 <Naqoyqatsi>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32816 AND composer_id = 93 AND title = '영화음악 <Powaqqatsi>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32828 AND composer_id = 93 AND title = '영화음악 <The Family>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32830 AND composer_id = 93 AND title = '영화음악 <The Illusionist>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32833 AND composer_id = 93 AND title = '영화음악 <The Thin Blue Line>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32849 AND composer_id = 280 AND title = '영화음악 <Enemy Zero>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32876 AND composer_id = 99 AND title = '영화음악 <5º año nacional>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 32957 AND composer_id = 69 AND title = '영화음악 <The England of Elizabeth>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33018 AND composer_id = 86 AND title = '영화음악 <New York Rhapsody>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33025 AND composer_id = 86 AND title = '영화음악 <Shall We Dance>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33247 AND composer_id = 290 AND title = '영화음악 <The Portrait of a Lady>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33527 AND composer_id = 159 AND title = '영화음악 <Potop>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33588 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power - Season One'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33589 AND composer_id = 421 AND title = 'Human Target, Season 1: Original Television Soundtrack'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33590 AND composer_id = 421 AND title = 'Caprica'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33591 AND composer_id = 421 AND title = 'The Cape: Original Television Soundtrack'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33592 AND composer_id = 421 AND title = 'God of War Ragnarök (Original Soundtrack)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33593 AND composer_id = 421 AND title = 'Dark Void'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33594 AND composer_id = 421 AND title = 'Da Vinci’s Demons: Original Television Soundtrack'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33595 AND composer_id = 421 AND title = 'Defiance: Original Video Game Soundtrack'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33596 AND composer_id = 421 AND title = 'Call of Duty: Vanguard'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33597 AND composer_id = 421 AND title = '영화 <림 오브 더 월드> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33598 AND composer_id = 421 AND title = '영화 <고질라: 킹 오브 몬스터> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33599 AND composer_id = 421 AND title = 'Eureka: Original Soundtrack From the Sci-Fi Channel Television Series'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33600 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 4'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33601 AND composer_id = 421 AND title = 'Terminator: The Sarah Connor Chronicles: Original Television Soundtrack'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33602 AND composer_id = 421 AND title = '영화 <애니멀 크래커> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33603 AND composer_id = 421 AND title = '영화 <프리키 데스데이> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33604 AND composer_id = 421 AND title = '영화 <Blumhouse’s Fantasy Island> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33605 AND composer_id = 421 AND title = 'SOCOM 4: U.S. Navy SEALs: Original Video Game Soundtrack'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33606 AND composer_id = 421 AND title = '영화 <프로페서 앤 매드맨> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33607 AND composer_id = 421 AND title = '영화 <사탄의 인형> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33608 AND composer_id = 421 AND title = 'See, Season 1: Apple TV+ Original Series Soundtrack'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33609 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 6'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33610 AND composer_id = 421 AND title = '영화 <블레이드 퍼피 워리어> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33611 AND composer_id = 421 AND title = 'Caprica: Original Soundtrack From the Sci fi Channel Television Pilot Episode'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33612 AND composer_id = 421 AND title = '영화 <해피 데스데이 2 유> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33613 AND composer_id = 421 AND title = 'The Witcher: Blood Origin (Soundtrack from the Netflix Series)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33614 AND composer_id = 421 AND title = 'Black Sails: A Starz Original Series Soundtrack'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33615 AND composer_id = 421 AND title = '영화 <Knights of Badassdom> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33616 AND composer_id = 421 AND title = '영화 <앵그리 비디오 게임 너드: 더 무비> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33617 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Season 3'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33618 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation: Original Series Soundtrack – Volume 1'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33619 AND composer_id = 421 AND title = '영화 <호밀밭의 반항아> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33620 AND composer_id = 421 AND title = '영화 <클로버필드 패러독스> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33621 AND composer_id = 421 AND title = '영화 <에이바> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33622 AND composer_id = 421 AND title = 'Foundation: Season 1 (Apple TV+ Original Series Soundtrack)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33623 AND composer_id = 421 AND title = 'Masters of the Universe: Revelation (Netflix Original Series Soundtrack, Vol. 2)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33624 AND composer_id = 421 AND title = 'Zom‐B Movie: Soundtrack'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33625 AND composer_id = 421 AND title = '영화 <Unrest> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33626 AND composer_id = 421 AND title = '영화 <Revolt> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33627 AND composer_id = 421 AND title = '영화 <Rest Stop: Don''t Look Back> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33628 AND composer_id = 421 AND title = 'Defiance: Original Television Soundtrack'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33629 AND composer_id = 421 AND title = 'Da Vinci’s Demons, Season Two: Original Television Soundtrack'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33630 AND composer_id = 421 AND title = '영화 <클로버필드 10번지> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33631 AND composer_id = 421 AND title = '영화 <I Still See You> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33632 AND composer_id = 421 AND title = '영화 <유로파 리포트> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33633 AND composer_id = 421 AND title = 'Outlander: The Series: Original Television Soundtrack, Vol. 1'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33634 AND composer_id = 421 AND title = '영화 <더 보이> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33635 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Three: The Eagle And The Sceptre - Amazon Original Series Soundtrack)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33636 AND composer_id = 421 AND title = '영화 <Rest Stop: Dead Ahead> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33637 AND composer_id = 421 AND title = '영화 <콜로설> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33638 AND composer_id = 421 AND title = '영화 <포레스트: 죽음의 숲> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33639 AND composer_id = 421 AND title = 'Eli: Original Music From the Netflix Film'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33640 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Four: Eldest - Amazon Original Series Soundtrack)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33641 AND composer_id = 421 AND title = 'Outlander: Season 7 (Original Television Soundtrack)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33642 AND composer_id = 421 AND title = '영화 <에벌리> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33643 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode One: Elven Kings Under The Sky - Amazon Original Series Soundtrack)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33644 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Five: Halls Of Stone - Amazon Original Series Soundtrack)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33645 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Six: Where Is He? - Amazon Original Series Soundtrack)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33646 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Seven: Doomed To Die - Amazon Original Series Soundtrack)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33647 AND composer_id = 421 AND title = '영화 <Welcome Home> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33648 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Two: Where The Stars Are Strange - Amazon Original Series Soundtrack)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33649 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two, Episode Eight: Shadow And Flame - Amazon Original Series Soundtrack)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33650 AND composer_id = 421 AND title = 'The Lord of the Rings: The Rings of Power (Season Two: Amazon Original Series Soundtrack)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33651 AND composer_id = 421 AND title = 'Assassin’s Creed Syndicate: Jack the Ripper (Original Game Soundtrack)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33652 AND composer_id = 421 AND title = '영화 <해피 데스데이> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33659 AND composer_id = 111 AND title = '영화 <The Abdication> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33660 AND composer_id = 111 AND title = '영화 <사티리콘> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33661 AND composer_id = 111 AND title = '영화 <허리케인> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33662 AND composer_id = 111 AND title = '영화 <카사노바> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33663 AND composer_id = 111 AND title = 'Plein soleil'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33664 AND composer_id = 111 AND title = '영화 <전쟁과 평화> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33665 AND composer_id = 111 AND title = '영화 <Il brigante> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33666 AND composer_id = 111 AND title = '영화 <아마코드> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33667 AND composer_id = 111 AND title = '영화 <Fortunella> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33668 AND composer_id = 111 AND title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33669 AND composer_id = 111 AND title = '영화 <영혼의 줄리에타> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33670 AND composer_id = 111 AND title = '영화 <나폴레옹> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33671 AND composer_id = 111 AND title = '영화 <대부 2> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33672 AND composer_id = 111 AND title = '영화 <사기꾼들> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33673 AND composer_id = 111 AND title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33674 AND composer_id = 111 AND title = '영화 <로마> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33676 AND composer_id = 111 AND title = '영화 <달콤한 인생> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33677 AND composer_id = 111 AND title = '영화 <오케스트라 리허설> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33679 AND composer_id = 111 AND title = '영화 <말괄량이 길들이기> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33680 AND composer_id = 111 AND title = '영화 <대부 3> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33683 AND composer_id = 111 AND title = 'Chansons pour Fellini'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33692 AND composer_id = 112 AND title = '영화 <신밧드의 7번째 모험> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33693 AND composer_id = 112 AND title = '영화 <The 3 Worlds of Gulliver> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33695 AND composer_id = 112 AND title = '영화 <화씨 451> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33697 AND composer_id = 112 AND title = '영화 <유령과 뮤어 부인> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33698 AND composer_id = 112 AND title = 'A Child Is Born (음반)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33703 AND composer_id = 419 AND title = 'Black Sea Raid'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33704 AND composer_id = 419 AND title = 'Mr. Atlas'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33705 AND composer_id = 419 AND title = '영화 <Night Eyes 3> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33706 AND composer_id = 419 AND title = '영화 <데스 위시 5> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33707 AND composer_id = 419 AND title = '영화 <Scarecrows> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33708 AND composer_id = 419 AND title = '영화 <Nate and the Colonel> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33709 AND composer_id = 419 AND title = 'Raging Angels'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33710 AND composer_id = 419 AND title = '영화 <블랙 이글> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33711 AND composer_id = 419 AND title = 'Final Judgement'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33712 AND composer_id = 419 AND title = 'Zero Option'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33713 AND composer_id = 206 AND title = '영화 <사랑에 대한 모든 것> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33714 AND composer_id = 206 AND title = '영화 <컨택트> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33715 AND composer_id = 206 AND title = '영화 <Free the Mind> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33717 AND composer_id = 206 AND title = '영화 <시카리오: 암살자의 도시> 사운드트랙'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33719 AND composer_id = 206 AND title = 'White Black Boy: Original Soundtrack'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33720 AND composer_id = 206 AND title = 'And in the Endless Pause There Came the Sound of Bees'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33741 AND composer_id = 399 AND title = 'I Know This Much Is True (Music From The HBO Series)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33746 AND composer_id = 154 AND title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33748 AND composer_id = 310 AND title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33749 AND composer_id = 310 AND title = '30億光年の宇宙 〜星たちの軌跡〜'
  AND genre IS NULL AND form_key IS NULL;
