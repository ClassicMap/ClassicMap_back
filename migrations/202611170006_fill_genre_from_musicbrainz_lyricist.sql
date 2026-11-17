-- 작곡가 화면 '기타'(갈래 없음) 줄이기 2026-11-17: MusicBrainz 작사가 관계(대본 작가 없음)로 빈 갈래·형식을 채운다.
-- 근거와 생성기: seed_pipeline/curation/piece-genre-fill-2026-11-17/(README.md, fill.py, fills.jsonl).
-- 갈래·형식이 둘 다 비어 있고 제목이 덤프 때와 같을 때만 바꾼다(이미 있는 값은 그대로, 두 번 넣어도 같다).
-- 작품 207곡. 규칙별: mb:lyricist 207
-- 갈래/형식별: vocal/vocal_other 207

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
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7748 AND composer_id = 69 AND title = 'Rest'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7812 AND composer_id = 69 AND title = '3 Poems by Walt Whitman'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7899 AND composer_id = 107 AND title = 'Cinq poèmes de Max Jacob, FP 59'
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
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8337 AND composer_id = 69 AND title = 'Saraband “Helen”'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8369 AND composer_id = 77 AND title = 'Påskeblomst! Hvad vil du her?'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8450 AND composer_id = 98 AND title = 'I Come To Thee'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8467 AND composer_id = 107 AND title = 'Cinq poèmes de Paul Éluard, FP 77'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8522 AND composer_id = 77 AND title = 'Sange af Ludvig Holstein Op. 10'
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
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8882 AND composer_id = 107 AND title = 'Poèmes de Ronsard, FP 38'
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
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9096 AND composer_id = 69 AND title = 'Come down, O love divine'
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
WHERE id = 9349 AND composer_id = 70 AND title = 'Two Eastern Pictures'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9367 AND composer_id = 69 AND title = 'For All the Saints'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9392 AND composer_id = 70 AND title = 'A Dirge for Two Veterans'
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
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9580 AND composer_id = 70 AND title = 'Ah Tyrant Love'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9752 AND composer_id = 70 AND title = 'Masters in This Hall'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9816 AND composer_id = 77 AND title = 'Søvnen'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9861 AND composer_id = 70 AND title = 'Dirge and Hymeneal'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9877 AND composer_id = 98 AND title = 'The Pond'
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
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10368 AND composer_id = 107 AND title = 'Trois poèmes de Louise de Vilmorin, FP 91'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10486 AND composer_id = 80 AND title = 'Psyché'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10522 AND composer_id = 77 AND title = 'Som en rejselysten flåde'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10585 AND composer_id = 107 AND title = 'Airs chantés, FP 46'
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
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10880 AND composer_id = 70 AND title = 'Eternal Father'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10917 AND composer_id = 69 AND title = 'Joy, shipmate, joy!'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 10963 AND composer_id = 107 AND title = 'Parisiana, FP 157'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11095 AND composer_id = 69 AND title = 'Come Away Death'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11111 AND composer_id = 69 AND title = 'Silence and Music'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11120 AND composer_id = 69 AND title = 'England, My England'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11260 AND composer_id = 70 AND title = 'Man Born to Toil'
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
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16733 AND composer_id = 343 AND title = 'The Tale of Andrew'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16764 AND composer_id = 302 AND title = 'Le Cri'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 16796 AND composer_id = 341 AND title = 'Ausencias de Dulcinea'
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
WHERE id = 17765 AND composer_id = 139 AND title = 'Nights Not Spent Alone'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18001 AND composer_id = 260 AND title = 'Due sonetti del Berni'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18084 AND composer_id = 139 AND title = 'All You Who Sleep Tonight'
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
WHERE id = 18880 AND composer_id = 341 AND title = 'Líricas castellanas'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18933 AND composer_id = 341 AND title = 'Tríptic de Mossèn Cinto'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19017 AND composer_id = 307 AND title = 'Havannan yö'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19019 AND composer_id = 301 AND title = 'From Stone to Thorn'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19055 AND composer_id = 296 AND title = 'Römisches Triptychon'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19163 AND composer_id = 139 AND title = 'Seek Him That Maketh the Seven Stars'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19195 AND composer_id = 260 AND title = 'I sonetti delle fate'
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
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23376 AND composer_id = 397 AND title = 'Les Clairs de lune'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23393 AND composer_id = 433 AND title = 'The Phoenix and the Turtle'
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
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 25104 AND composer_id = 371 AND title = 'Tipaatsungaalerit'
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
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 25737 AND composer_id = 441 AND title = 'The Wound-Dresser'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 32872 AND composer_id = 98 AND title = 'Bread of the World'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 32906 AND composer_id = 105 AND title = 'Choros nº 10 "Rasga o coração"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 32995 AND composer_id = 100 AND title = 'Socrate'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 33001 AND composer_id = 100 AND title = '엘레지'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 33059 AND composer_id = 64 AND title = 'The Prince of Sleep'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 33275 AND composer_id = 77 AND title = 'Underlige aftenlufte'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 33426 AND composer_id = 139 AND title = 'The End'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 33586 AND composer_id = 473 AND title = 'Oh! weep for those'
  AND genre IS NULL AND form_key IS NULL;
