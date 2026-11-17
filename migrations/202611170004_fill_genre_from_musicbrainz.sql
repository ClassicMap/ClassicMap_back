-- 작곡가 화면 '기타'(갈래 없음) 줄이기 2026-11-17: MusicBrainz work(유형·편성 설명·부모 작품·작사가)로 빈 갈래·형식을 채운다.
-- 근거와 생성기: seed_pipeline/curation/piece-genre-fill-2026-11-17/(README.md, fill.py, fills.jsonl).
-- 갈래·형식이 둘 다 비어 있고 제목이 덤프 때와 같을 때만 바꾼다(이미 있는 값은 그대로, 두 번 넣어도 같다).
-- 작품 357곡. 규칙별: mb:lyricist 221, mb:disambiguation 130, mb:type:Symphonic poem 2, mb:type:Song 1, mb:type:Symphony 1, mb:type:Concerto 1, mb:type:Soundtrack 1
-- 갈래/형식별: vocal/vocal_other 227, piano/piano_other 30, chamber/chamber_other 28, vocal/song 21, orchestral/orchestral_other 16, vocal/choral 13, piano/organ 7, chamber/solo 6, piano/four_hands 3, orchestral/symphonic_poem 2, orchestral/dance_march 1, symphony/symphony 1, concerto/piano_concerto 1, screen/soundtrack 1

UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 268 AND composer_id = 64 AND title = '사랑의 인사'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 600 AND composer_id = 64 AND title = 'Offertoire'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 685 AND composer_id = 95 AND title = 'Cinq rechants'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 696 AND composer_id = 95 AND title = 'La Mort du nombre, I/6'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 704 AND composer_id = 95 AND title = 'Trois petites liturgies de la présence divine'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 872 AND composer_id = 64 AND title = 'Lo! Christ the Lord is born'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 907 AND composer_id = 37 AND title = 'Aubade'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1045 AND composer_id = 37 AND title = 'Toi qui l''aimas, verse des pleurs'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1049 AND composer_id = 64 AND title = 'A Child asleep'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1174 AND composer_id = 64 AND title = 'The Fringes of the Fleet'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1279 AND composer_id = 86 AND title = 'The Yankee Doodle Blues'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1292 AND composer_id = 92 AND title = 'The Wonderful Widow of Eighteen Springs'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 1300 AND composer_id = 64 AND title = 'Allegretto: Duet on a Theme of Allegretto on G.E.D.G.E'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 1370 AND composer_id = 37 AND title = 'Tristia'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 1393 AND composer_id = 64 AND title = 'Reminiscences'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 1395 AND composer_id = 37 AND title = 'La menace des Francs'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1405 AND composer_id = 94 AND title = 'Tit for Tat'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1471 AND composer_id = 94 AND title = 'Advance Democracy'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1499 AND composer_id = 94 AND title = 'Now the Leaves Are Falling Fast'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1511 AND composer_id = 94 AND title = 'Let the Florid Music Praise!'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1541 AND composer_id = 87 AND title = 'Dream With Me'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1543 AND composer_id = 64 AND title = 'The Chariots of the Lord'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1573 AND composer_id = 37 AND title = 'La Captive orientale H. 60E'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 1575 AND composer_id = 108 AND title = 'KLANG – 3rd Hour: Natürliche Dauern: Nr. 5'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1614 AND composer_id = 64 AND title = '“Roundel: The little eyes that never knew Light”'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1615 AND composer_id = 87 AND title = 'The Story of My Life'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1618 AND composer_id = 64 AND title = 'Speak, my Heart!'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1695 AND composer_id = 110 AND title = 'Trois poèmes d''Henri Michaux'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1736 AND composer_id = 37 AND title = 'Aubade H. 78B'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1822 AND composer_id = 64 AND title = 'The Music Makers'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1891 AND composer_id = 37 AND title = 'Le Ballet des ombres'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1904 AND composer_id = 87 AND title = 'Warm-Up'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1953 AND composer_id = 94 AND title = 'Hadrian''s Wall: Roman Wall Blues'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 1955 AND composer_id = 92 AND title = 'Credo in US'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1981 AND composer_id = 64 AND title = 'As I laye a-thynkynge'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2000 AND composer_id = 92 AND title = 'Experiences no. 2'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2002 AND composer_id = 64 AND title = 'Always and Everywhere'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2011 AND composer_id = 64 AND title = 'Death on the Hills'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2026 AND composer_id = 86 AND title = 'Home Blues'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2101 AND composer_id = 37 AND title = 'Je vais donc quitter pour jamais'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2125 AND composer_id = 64 AND title = 'Come, Gentle Night'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2172 AND composer_id = 37 AND title = 'Le Temple universel H. 137B'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2191 AND composer_id = 64 AND title = 'The Self-Banished'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2478 AND composer_id = 92 AND title = 'Forever and Sunsmell'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2535 AND composer_id = 64 AND title = 'Big Steamers'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2552 AND composer_id = 94 AND title = 'The Heart of the Matter'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 2564 AND composer_id = 61 AND title = 'Wettspiele zu Ehren des Patroklus'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2572 AND composer_id = 64 AND title = 'Dry Those Fair, Those Crystal Eyes'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2601 AND composer_id = 64 AND title = 'Pageant of Empire'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2622 AND composer_id = 64 AND title = 'It isnae me'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2669 AND composer_id = 37 AND title = 'Le Temple universel'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2752 AND composer_id = 64 AND title = 'To Her Beneath Whose Steadfast Star'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2760 AND composer_id = 94 AND title = 'Seascape'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2762 AND composer_id = 94 AND title = 'The Oxen'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 2766 AND composer_id = 94 AND title = '5개의 왈츠'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2827 AND composer_id = 37 AND title = 'La Captive orientale H. 60B'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2846 AND composer_id = 37 AND title = 'La Captive orientale'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2897 AND composer_id = 64 AND title = 'Evening Scene'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2904 AND composer_id = 37 AND title = 'La Captive orientale H. 60F'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2969 AND composer_id = 37 AND title = 'La Captive orientale H. 60D'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2974 AND composer_id = 37 AND title = 'Sara la baigneuse'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 3013 AND composer_id = 94 AND title = '영웅들의 발라드'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 7550 AND composer_id = 77 AND title = 'Melodi'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 7577 AND composer_id = 69 AND title = '4 Poems by Fredegond Shove'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 7606 AND composer_id = 104 AND title = 'Moravské tance'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7642 AND composer_id = 100 AND title = 'Ludions'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7679 AND composer_id = 109 AND title = 'Circles'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7687 AND composer_id = 109 AND title = 'Chamber Music'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7702 AND composer_id = 69 AND title = 'Willow-Wood'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7704 AND composer_id = 69 AND title = 'The Winter’s Willow'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 7735 AND composer_id = 105 AND title = 'New York Skyline Melody'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7748 AND composer_id = 69 AND title = 'Rest'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 7770 AND composer_id = 105 AND title = 'Rudepoêma'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 7783 AND composer_id = 70 AND title = 'Walt Whitman'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7812 AND composer_id = 69 AND title = '3 Poems by Walt Whitman'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7899 AND composer_id = 107 AND title = 'Cinq poèmes de Max Jacob, FP 59'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 7901 AND composer_id = 70 AND title = 'Ah, Come, Fair Mistress'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7991 AND composer_id = 109 AND title = 'Shofar'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8020 AND composer_id = 69 AND title = 'The Future'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8054 AND composer_id = 77 AND title = 'Frydeligt med jubelkor'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 8093 AND composer_id = 70 AND title = 'Not a Sound But Echoing in Me'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8135 AND composer_id = 69 AND title = '2 Poems by Seumas O''Sullivan'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8187 AND composer_id = 105 AND title = 'Samba clássico'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8193 AND composer_id = 69 AND title = 'The Garden of Proserpine'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8213 AND composer_id = 100 AND title = 'Petit recueil des fêtes'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 8260 AND composer_id = 105 AND title = '카프리치오'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 8273 AND composer_id = 105 AND title = 'Marquesa de Santos'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8278 AND composer_id = 69 AND title = 'The Bridal Day'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8337 AND composer_id = 69 AND title = 'Saraband “Helen”'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8369 AND composer_id = 77 AND title = 'Påskeblomst! Hvad vil du her?'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 8435 AND composer_id = 105 AND title = 'Danças características africanas'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8450 AND composer_id = 98 AND title = 'I Come To Thee'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8467 AND composer_id = 107 AND title = 'Cinq poèmes de Paul Éluard, FP 77'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 8520 AND composer_id = 105 AND title = 'Sonhar'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8522 AND composer_id = 77 AND title = 'Sange af Ludvig Holstein Op. 10'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 8577 AND composer_id = 63 AND title = 'Moscovienne'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8616 AND composer_id = 69 AND title = 'Love Is a Sickness'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8660 AND composer_id = 77 AND title = 'Du danske mand! af al din magt'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8721 AND composer_id = 69 AND title = 'The Steersman'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8740 AND composer_id = 98 AND title = 'Processional "Let There Be Light"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8846 AND composer_id = 107 AND title = 'Miroirs brûlants, FP 98'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 8864 AND composer_id = 70 AND title = 'Twin Stars Aloft'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8882 AND composer_id = 107 AND title = 'Poèmes de Ronsard, FP 38'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 8883 AND composer_id = 70 AND title = 'Sing Heigh-Ho!'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8899 AND composer_id = 107 AND title = 'Quatre poèmes de Max Jacob'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8973 AND composer_id = 77 AND title = 'Havet omkring Danmark'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9005 AND composer_id = 77 AND title = 'Tunge, mørke natteskyer'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9034 AND composer_id = 105 AND title = 'Bendita sabedoria'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9049 AND composer_id = 107 AND title = 'Métamorphoses, FP 121'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 9074 AND composer_id = 66 AND title = 'To Nellie'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9096 AND composer_id = 69 AND title = 'Come down, O love divine'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9110 AND composer_id = 69 AND title = '옥스퍼드 엘레지'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9137 AND composer_id = 104 AND title = 'Říkadla, JW V/16'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9151 AND composer_id = 77 AND title = 'Viser og vers af J.P. Jacobsen Op. 6'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9186 AND composer_id = 70 AND title = 'The Autumn Is Old'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9210 AND composer_id = 70 AND title = 'The Homecoming'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9238 AND composer_id = 98 AND title = 'Crossing the Bar'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9265 AND composer_id = 62 AND title = 'Pitchounette'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9297 AND composer_id = 70 AND title = 'The Stars Are with the Voyager'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9323 AND composer_id = 107 AND title = 'Le Gendarme incompris, FP 20a'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9349 AND composer_id = 70 AND title = 'Two Eastern Pictures'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9367 AND composer_id = 69 AND title = 'For All the Saints'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 9372 AND composer_id = 69 AND title = '영웅적 엘레지와 승리의 에필로그'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9392 AND composer_id = 70 AND title = 'A Dirge for Two Veterans'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 9434 AND composer_id = 70 AND title = 'The Day of the Lord'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 9445 AND composer_id = 70 AND title = 'Not Unto Us, O Lord'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9515 AND composer_id = 70 AND title = 'Christ Hath a Garden'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9546 AND composer_id = 105 AND title = 'José'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9564 AND composer_id = 70 AND title = 'Our Blest Redeemer'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 9579 AND composer_id = 104 AND title = 'Skladby JW 8/7'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9580 AND composer_id = 70 AND title = 'Ah Tyrant Love'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 9602 AND composer_id = 62 AND title = 'Le roman d’Arlequin'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9752 AND composer_id = 70 AND title = 'Masters in This Hall'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9816 AND composer_id = 77 AND title = 'Søvnen'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 9825 AND composer_id = 70 AND title = 'Airly Beacon'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9861 AND composer_id = 70 AND title = 'Dirge and Hymeneal'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9877 AND composer_id = 98 AND title = 'The Pond'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9897 AND composer_id = 109 AND title = 'Altra voce'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 9968 AND composer_id = 70 AND title = 'Whether We Die or Live'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10056 AND composer_id = 70 AND title = 'Spring It Is Cheery'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10060 AND composer_id = 69 AND title = 'Saviour, again to Thy dear name we raise'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10064 AND composer_id = 77 AND title = 'På det jævne, på det jævne!'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10156 AND composer_id = 107 AND title = 'Fiançailles pour rire, FP 101'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10209 AND composer_id = 77 AND title = 'Betragt mit svage spind'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10252 AND composer_id = 107 AND title = 'Deux poèmes de Guillaume Apollinaire, FP 94'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 10299 AND composer_id = 70 AND title = 'Clear and Cool'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 10326 AND composer_id = 70 AND title = 'O Spring''s Little Children'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 10341 AND composer_id = 105 AND title = 'Sonhar Op. 14'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10368 AND composer_id = 107 AND title = 'Trois poèmes de Louise de Vilmorin, FP 91'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 10387 AND composer_id = 70 AND title = 'The Kiss'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 10441 AND composer_id = 70 AND title = 'I Scanned Her Picture'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10454 AND composer_id = 69 AND title = 'The Pilgrim’s Progress - A Bunyan Sequence'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10486 AND composer_id = 80 AND title = 'Psyché'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10522 AND composer_id = 77 AND title = 'Som en rejselysten flåde'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 10527 AND composer_id = 70 AND title = 'All Night I Waited by the Spring'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 10555 AND composer_id = 66 AND title = 'España (Souvenirs) B. 45'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 10582 AND composer_id = 77 AND title = 'Musik til fem Digte af J.P. Jacobsen Op. 4'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10585 AND composer_id = 107 AND title = 'Airs chantés, FP 46'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 10605 AND composer_id = 70 AND title = 'My Joy'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 10658 AND composer_id = 105 AND title = 'Canções de cordialidade'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 10673 AND composer_id = 105 AND title = 'Uirapurú'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10675 AND composer_id = 109 AND title = 'There is no tune'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10781 AND composer_id = 69 AND title = 'Fain Would I Change That Note'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10834 AND composer_id = 107 AND title = 'Quatre petites prières de Saint François d’Assise, FP 142'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 10875 AND composer_id = 70 AND title = 'Draw Not Away Thy Hands'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10880 AND composer_id = 70 AND title = 'Eternal Father'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10917 AND composer_id = 69 AND title = 'Joy, shipmate, joy!'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 10922 AND composer_id = 70 AND title = 'Maya'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10963 AND composer_id = 107 AND title = 'Parisiana, FP 157'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 10974 AND composer_id = 105 AND title = 'Invocação em defesa da pátria'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 10999 AND composer_id = 80 AND title = 'Vals-capricho'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 11052 AND composer_id = 109 AND title = 'Sequenza IV'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 11091 AND composer_id = 70 AND title = 'Two Brown Eyes'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11095 AND composer_id = 69 AND title = 'Come Away Death'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'four_hands'
WHERE id = 11100 AND composer_id = 109 AND title = 'Touch'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11111 AND composer_id = 69 AND title = 'Silence and Music'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11120 AND composer_id = 69 AND title = 'England, My England'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 11138 AND composer_id = 70 AND title = 'A Lake and a Fairy Boat'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 11254 AND composer_id = 70 AND title = 'Bhanavar''s Lament'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 11256 AND composer_id = 70 AND title = 'A Winter Idyll'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11260 AND composer_id = 70 AND title = 'Man Born to Toil'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 15758 AND composer_id = 282 AND title = '샤콘 C♯단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 15811 AND composer_id = 204 AND title = 'Paisaje cubano con lluvia'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16255 AND composer_id = 162 AND title = 'To Look Yet Not Find'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16441 AND composer_id = 295 AND title = 'A Plan of the Air'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16468 AND composer_id = 398 AND title = 'Heureux celui qui revoit sa patrie'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16553 AND composer_id = 301 AND title = 'A Little Birthday Music'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16601 AND composer_id = 341 AND title = 'Dos poemas de Juan Ramón Jiménez'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16647 AND composer_id = 341 AND title = 'Cántico de San Francisco de Asís'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16670 AND composer_id = 260 AND title = 'Keepsake'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16678 AND composer_id = 260 AND title = 'Tre poesie del Poliziano'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 16722 AND composer_id = 341 AND title = '두란다르테의 로망스'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16733 AND composer_id = 343 AND title = 'The Tale of Andrew'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16750 AND composer_id = 252 AND title = 'Canonical Form'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16757 AND composer_id = 252 AND title = 'Tableaux'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16764 AND composer_id = 302 AND title = 'Le Cri'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 16787 AND composer_id = 278 AND title = 'Lost Sounds II'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16796 AND composer_id = 341 AND title = 'Ausencias de Dulcinea'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16890 AND composer_id = 307 AND title = 'Quasi bolero'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16989 AND composer_id = 186 AND title = 'Studi per "Il processo" di Franz Kafka'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 17055 AND composer_id = 174 AND title = 'Eucarística'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 17062 AND composer_id = 341 AND title = 'Coplas del pastor enamorado'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 17089 AND composer_id = 139 AND title = 'Our revels now are ended'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 17107 AND composer_id = 257 AND title = 'Looking Glass River'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 17326 AND composer_id = 341 AND title = 'Cantos de amor y de guerra'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 17454 AND composer_id = 205 AND title = 'Geef mij eens dien dag'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 17505 AND composer_id = 301 AND title = 'Revelation and Fall'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 17515 AND composer_id = 225 AND title = 'Polveri laterali'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 17725 AND composer_id = 239 AND title = '12 Seguidillas'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 17765 AND composer_id = 139 AND title = 'Nights Not Spent Alone'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 17968 AND composer_id = 252 AND title = 'Partitions'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18001 AND composer_id = 260 AND title = 'Due sonetti del Berni'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 18033 AND composer_id = 252 AND title = 'Post-Partitions'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18084 AND composer_id = 139 AND title = 'All You Who Sleep Tonight'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18101 AND composer_id = 252 AND title = 'Vision and Prayer'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18143 AND composer_id = 139 AND title = 'The Three Kings'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18153 AND composer_id = 341 AND title = 'Música para un códice salmantino'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18187 AND composer_id = 174 AND title = 'Oració a la Verge de Montserrat'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 18193 AND composer_id = 162 AND title = 'Rooms of Elsinore'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 18285 AND composer_id = 252 AND title = 'Lagniappe'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18291 AND composer_id = 296 AND title = 'Aš-šawqu ila˘ s-samāʾ'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18333 AND composer_id = 139 AND title = 'Vast Ocean of Light'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18401 AND composer_id = 230 AND title = '10. Yıl Marşı'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18404 AND composer_id = 301 AND title = 'A Hoy Calendar'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18416 AND composer_id = 341 AND title = 'Rosaliana'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18441 AND composer_id = 341 AND title = 'Himnos de los neófitos de Qumran'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18633 AND composer_id = 139 AND title = 'Wellcome All Wonders in One Sight!'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18634 AND composer_id = 260 AND title = 'Quattro sonetti del Burchiello'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18729 AND composer_id = 225 AND title = 'Infinito nero'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 18776 AND composer_id = 301 AND title = 'An Orkney Wedding, with Sunrise'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18880 AND composer_id = 341 AND title = 'Líricas castellanas'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18933 AND composer_id = 341 AND title = 'Tríptic de Mossèn Cinto'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18973 AND composer_id = 226 AND title = 'Tutti parlano'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19017 AND composer_id = 307 AND title = 'Havannan yö'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19019 AND composer_id = 301 AND title = 'From Stone to Thorn'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19035 AND composer_id = 187 AND title = 'Ligne de fuite'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19055 AND composer_id = 296 AND title = 'Römisches Triptychon'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19080 AND composer_id = 139 AND title = 'My Love Is Mine'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19163 AND composer_id = 139 AND title = 'Seek Him That Maketh the Seven Stars'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19195 AND composer_id = 260 AND title = 'I sonetti delle fate'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 19239 AND composer_id = 162 AND title = 'Confessio'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19295 AND composer_id = 301 AND title = 'Leopardi Fragments'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19308 AND composer_id = 139 AND title = 'Cut My Shadow'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19321 AND composer_id = 301 AND title = 'Dark Angels'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19340 AND composer_id = 341 AND title = '오카냐 기사단장의 로망스'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19344 AND composer_id = 323 AND title = 'Three Impressions'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19405 AND composer_id = 301 AND title = 'Kings and Shepherds'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19431 AND composer_id = 260 AND title = 'Tre canti di Filomela'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19496 AND composer_id = 139 AND title = 'In Beauty May I Walk'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19535 AND composer_id = 200 AND title = 'Descendues des étoiles'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19604 AND composer_id = 297 AND title = 'On the Death of the Righteous'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19683 AND composer_id = 139 AND title = 'Into Thy Hands'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19712 AND composer_id = 297 AND title = 'Dooryard Bloom'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 19815 AND composer_id = 301 AND title = 'Midhouse Air'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19837 AND composer_id = 301 AND title = 'Black Pentecost'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19870 AND composer_id = 251 AND title = 'Els somnis'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 20025 AND composer_id = 139 AND title = 'All the Future Days'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23103 AND composer_id = 366 AND title = 'Alto e glorioso Dio'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23114 AND composer_id = 366 AND title = 'Accogli nel tuo grembo'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23115 AND composer_id = 366 AND title = 'Ascende'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23116 AND composer_id = 366 AND title = 'Alla cena dell''Agnello'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23117 AND composer_id = 366 AND title = 'Andate in tutto il mondo'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'four_hands'
WHERE id = 23123 AND composer_id = 441 AND title = 'Hallelujah Junction'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23180 AND composer_id = 366 AND title = 'Ascolta Creatore pietoso'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23181 AND composer_id = 366 AND title = 'Aprite le porte a Cristo'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23183 AND composer_id = 366 AND title = 'Atto d''amore'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23185 AND composer_id = 366 AND title = 'Adoro Te devote'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 23210 AND composer_id = 430 AND title = 'Chant corse'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23376 AND composer_id = 397 AND title = 'Les Clairs de lune'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 23384 AND composer_id = 418 AND title = 'Il paesaggio'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23393 AND composer_id = 433 AND title = 'The Phoenix and the Turtle'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 23397 AND composer_id = 359 AND title = 'Solo XI'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 23761 AND composer_id = 441 AND title = 'Phrygian Gates and China Gates'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 23764 AND composer_id = 418 AND title = 'Iuxta crucem'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23960 AND composer_id = 418 AND title = 'Laudatio Domini'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 24011 AND composer_id = 362 AND title = 'Avalokiteshvara'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 24027 AND composer_id = 345 AND title = 'Monde évanoui (Fragments pour Babylone)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 24138 AND composer_id = 415 AND title = 'Dona Janaína'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 24455 AND composer_id = 362 AND title = 'May Rain'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 24469 AND composer_id = 397 AND title = '2 Poèmes d''André Chénier Op. 23'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 24558 AND composer_id = 418 AND title = 'Sormin soitti Väinämöinen'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 24587 AND composer_id = 468 AND title = 'Nonsense'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 24644 AND composer_id = 375 AND title = 'Music to Hear'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 24664 AND composer_id = 397 AND title = 'Shéhérazade (Recueil 2) Op. 84'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 24711 AND composer_id = 433 AND title = 'Triptych'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 24743 AND composer_id = 345 AND title = 'Cinq Poèmes de János Pilinszky'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 24817 AND composer_id = 383 AND title = 'Rejoice, the Lord Is King!'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 24828 AND composer_id = 397 AND title = '9 Rondels Op. 14'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 24968 AND composer_id = 393 AND title = 'Six Sonnets de Louïze Labé Op. 34'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25027 AND composer_id = 468 AND title = 'Salmo IX°'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 25104 AND composer_id = 371 AND title = 'Tipaatsungaalerit'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 25161 AND composer_id = 359 AND title = 'Laulu maasta'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 25180 AND composer_id = 375 AND title = 'Canto II'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 25389 AND composer_id = 367 AND title = '7 Sånger ur Tannhäuser'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 25561 AND composer_id = 433 AND title = 'Ithaca'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 25618 AND composer_id = 433 AND title = 'Rorate coeli'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 25663 AND composer_id = 359 AND title = 'Hiljaisuus'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 25737 AND composer_id = 441 AND title = 'The Wound-Dresser'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 25762 AND composer_id = 383 AND title = '3 Characteristic Pieces Op. 49'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 25778 AND composer_id = 397 AND title = 'Paysages et Marines'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 26004 AND composer_id = 418 AND title = 'Joululauluja lapsille'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 26016 AND composer_id = 341 AND title = 'Zarabanda lejana'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28116 AND composer_id = 30 AND title = '<죽음의 차르다시>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28120 AND composer_id = 30 AND title = '<바위에서 바다로!> E♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'dance_march'
WHERE id = 31308 AND composer_id = 45 AND title = '프라하 왈츠 D장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 32872 AND composer_id = 98 AND title = 'Bread of the World'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 32904 AND composer_id = 105 AND title = 'Bachianas Brasileiras nº 9'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 32906 AND composer_id = 105 AND title = 'Choros nº 10 "Rasga o coração"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 32907 AND composer_id = 105 AND title = 'Choros nº 2'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 32915 AND composer_id = 105 AND title = '엘레지'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 32960 AND composer_id = 92 AND title = 'Eight Whiskus'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 32965 AND composer_id = 92 AND title = 'She Is Asleep'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 32995 AND composer_id = 100 AND title = 'Socrate'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 33000 AND composer_id = 100 AND title = 'Trois petites pièces montées'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 33001 AND composer_id = 100 AND title = '엘레지'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 33033 AND composer_id = 64 AND title = 'Adieu'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 33035 AND composer_id = 64 AND title = 'Carissima'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 33042 AND composer_id = 64 AND title = 'La Capricieuse'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 33045 AND composer_id = 64 AND title = 'Mot d''amour'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 33049 AND composer_id = 64 AND title = '로망스 G장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 33051 AND composer_id = 64 AND title = 'Rosemary (“That’s for Remembrance”)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 33059 AND composer_id = 64 AND title = 'The Prince of Sleep'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 33063 AND composer_id = 70 AND title = 'Greeting'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 33064 AND composer_id = 70 AND title = 'O Lady, Leave That Silken Thread'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 33211 AND composer_id = 62 AND title = '엘레지'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 33260 AND composer_id = 397 AND title = 'Au loin'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 33263 AND composer_id = 397 AND title = 'Quatre Poèmes d''Edmond Haraucourt'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 33275 AND composer_id = 77 AND title = 'Underlige aftenlufte'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'four_hands'
WHERE id = 33290 AND composer_id = 109 AND title = '칸초네타'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 33294 AND composer_id = 109 AND title = 'Rounds'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 33319 AND composer_id = 341 AND title = '옛 아리아'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 33325 AND composer_id = 341 AND title = 'Juglares'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 33326 AND composer_id = 341 AND title = 'Pastoral'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE id = 33327 AND composer_id = 341 AND title = 'Per la flor del lliri blau'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 33343 AND composer_id = 287 AND title = 'Was hast du mit meinem Herz getan?'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 33348 AND composer_id = 66 AND title = 'Pavana-capricho'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 33364 AND composer_id = 95 AND title = 'L’Ascension'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 33368 AND composer_id = 296 AND title = 'Aalaiki''ssalaam'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 33372 AND composer_id = 296 AND title = 'Esquisses persanes'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 33380 AND composer_id = 61 AND title = '스웨덴 무곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE id = 33381 AND composer_id = 291 AND title = 'Africa'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 33388 AND composer_id = 291 AND title = 'Quit Dat Fool''nish'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 33426 AND composer_id = 139 AND title = 'The End'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 33429 AND composer_id = 110 AND title = 'Grave'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 33430 AND composer_id = 110 AND title = 'Mała suita'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 33446 AND composer_id = 207 AND title = 'Elegie (pod dojmem Zeyerova Vyšehradu)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 33447 AND composer_id = 252 AND title = 'Phonemena'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 33477 AND composer_id = 430 AND title = 'Semaine Sainte à Cuzco'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 33481 AND composer_id = 418 AND title = 'Hääsoitto'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 33500 AND composer_id = 343 AND title = 'Slow Dawn'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 33509 AND composer_id = 267 AND title = 'Alegría'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE id = 33513 AND composer_id = 443 AND title = 'Simfonia nr. 3 "La un cutremur"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 33560 AND composer_id = 314 AND title = 'Obsession'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 33586 AND composer_id = 473 AND title = 'Oh! weep for those'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'piano_concerto'
WHERE id = 33656 AND composer_id = 111 AND title = '피아노 협주곡 C장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33687 AND composer_id = 112 AND title = '서곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 33690 AND composer_id = 112 AND title = 'Vertigo Suite'
  AND genre IS NULL AND form_key IS NULL;
