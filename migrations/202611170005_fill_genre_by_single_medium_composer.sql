-- 작곡가 화면 '기타'(갈래 없음) 줄이기 2026-11-17: 한 가지 매체만 쓴 작곡가(손 목록)로 빈 갈래·형식을 채운다.
-- 근거와 생성기: seed_pipeline/curation/piece-genre-fill-2026-11-17/(README.md, fill.py, fills.jsonl).
-- 갈래·형식이 둘 다 비어 있고 제목이 덤프 때와 같을 때만 바꾼다(이미 있는 값은 그대로, 두 번 넣어도 같다).
-- 작품 152곡. 규칙별: composer:default 152
-- 갈래/형식별: piano/piano_other 51, vocal/choral 41, chamber/solo 32, vocal/sacred 20, piano/organ 8

UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 296 AND composer_id = 75 AND title = '알함브라 궁전의 추억'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 297 AND composer_id = 75 AND title = '아라비아 기상곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 7630 AND composer_id = 75 AND title = 'Gran vals'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 7867 AND composer_id = 75 AND title = 'Vals (en re)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 8895 AND composer_id = 75 AND title = 'Las dos hermanitas (vals)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 9107 AND composer_id = 75 AND title = 'Paquito (vals en do)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 9154 AND composer_id = 75 AND title = 'Sueño (trémolo)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 9343 AND composer_id = 75 AND title = 'Isabel (vals)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 9462 AND composer_id = 75 AND title = 'Pavana'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 10109 AND composer_id = 75 AND title = 'Minueto'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 10189 AND composer_id = 75 AND title = 'María (gavota)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 10203 AND composer_id = 75 AND title = 'El columpio'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 10272 AND composer_id = 75 AND title = '탱고'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 10295 AND composer_id = 75 AND title = 'Alborada'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 11053 AND composer_id = 75 AND title = 'La cartagenera'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 11128 AND composer_id = 75 AND title = 'Malagueña'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 11173 AND composer_id = 75 AND title = '오달리스크 춤곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 11182 AND composer_id = 75 AND title = '무어인의 춤곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 11282 AND composer_id = 75 AND title = '하바네라 G단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 15757 AND composer_id = 298 AND title = 'Diferencias sobre El Canto del Caballero'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 15834 AND composer_id = 298 AND title = 'Tres "Sobre el canto Ilano de la alta"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16024 AND composer_id = 331 AND title = 'Twilight Thoughts'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16052 AND composer_id = 298 AND title = 'Psalmus II: Confitebor tibi / Alternatim fabordones tono II'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16118 AND composer_id = 298 AND title = 'Hosanna (Intabulation of Josquin de Prez)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16156 AND composer_id = 298 AND title = 'Fabordón y glosas del sexto tono'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16164 AND composer_id = 298 AND title = 'Pavana con su glosa'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16166 AND composer_id = 298 AND title = 'Tiento Cuarto tono'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16188 AND composer_id = 298 AND title = 'Susana'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16237 AND composer_id = 331 AND title = '왼손만을 위한 엘레지'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16290 AND composer_id = 298 AND title = 'Himno: Ave, maris stella VI'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 16305 AND composer_id = 201 AND title = 'Élévation'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16384 AND composer_id = 331 AND title = 'Triakontameron, Thirty Moods and Scenes in Triple Measure'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16392 AND composer_id = 298 AND title = 'Himno: Pange lingua V'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16595 AND composer_id = 298 AND title = 'Fabordon y glosas del Primer Tono Ilano'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16723 AND composer_id = 331 AND title = 'Moto perpetuo'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16824 AND composer_id = 298 AND title = 'Pavana Italiana'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16860 AND composer_id = 298 AND title = 'Du vien sela'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 16872 AND composer_id = 201 AND title = 'Offertoire in G major'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16876 AND composer_id = 298 AND title = 'Himno “Christe Redemptor omnium”'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16905 AND composer_id = 298 AND title = 'Au joli bois'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 17456 AND composer_id = 298 AND title = 'Rugier, glosado de Antonio'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 17533 AND composer_id = 298 AND title = 'Quien llamó al partir partir'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 17582 AND composer_id = 298 AND title = 'Prenez pitie, Cancion glosada'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 17589 AND composer_id = 298 AND title = 'Psalmus IV: Beati omnes / Alternatim fabordones, tono IV'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 17617 AND composer_id = 298 AND title = 'Canción glosada “Triste départ”'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 17683 AND composer_id = 298 AND title = 'Tiento I'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 18064 AND composer_id = 331 AND title = 'Four Poems'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 18167 AND composer_id = 298 AND title = 'Tiento del primer tono'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 18294 AND composer_id = 201 AND title = 'Grand Offertoire in D'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 18383 AND composer_id = 331 AND title = '사라반드'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 18406 AND composer_id = 298 AND title = 'Diferencias sobre "Belle qui tiens ma vie"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 18596 AND composer_id = 298 AND title = 'Tiento del quarto tono sobre Maheur me bat'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 18723 AND composer_id = 201 AND title = 'Elévation en la bémol majeur'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 18761 AND composer_id = 298 AND title = 'Pange lingua (glosado)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 18793 AND composer_id = 298 AND title = 'Benedictus (Intabulation of Josquin de Prez)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 18854 AND composer_id = 298 AND title = 'Dic nobis, Maria'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 18875 AND composer_id = 298 AND title = '로망스 "Para quien crie yo cabellos"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19026 AND composer_id = 331 AND title = 'Walzermasken'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19046 AND composer_id = 298 AND title = 'Fabordon y Glosas del octavo tono'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19081 AND composer_id = 298 AND title = 'Duuiensela'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19122 AND composer_id = 298 AND title = 'D''où vient cela'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 19167 AND composer_id = 201 AND title = 'Offertoire in D minor'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 19194 AND composer_id = 298 AND title = 'Tiento para órgano: Verso II, glosade en el tiple, tono V'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19273 AND composer_id = 331 AND title = 'Märchen'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19305 AND composer_id = 298 AND title = 'Fabordones del premier tono Ilano'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19319 AND composer_id = 298 AND title = 'Himno: Te lucis ante terminum'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19560 AND composer_id = 298 AND title = 'Tiento XVIII'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19566 AND composer_id = 331 AND title = 'The Gardens of Buitenzorg'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19602 AND composer_id = 298 AND title = 'Himno XVI'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 19645 AND composer_id = 298 AND title = 'Versos para órganos 1, 2, 4, 6, 7: tono VI'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19653 AND composer_id = 298 AND title = 'Je prens en gre, Cancion glosada'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 19658 AND composer_id = 201 AND title = 'Communion en mi majeur'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19691 AND composer_id = 298 AND title = 'Tiento Primo tono'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19850 AND composer_id = 298 AND title = 'Ancol que col partire'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 19922 AND composer_id = 298 AND title = 'Obras de música: Diferencias sobre El canto de la dama le demanda'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 20067 AND composer_id = 298 AND title = 'Salmodia para principantes'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 23083 AND composer_id = 389 AND title = '"Gospodi, spasi" i Trisvyatoye'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 23089 AND composer_id = 389 AND title = 'Воскресни, Боже, ор. 48 №2'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23092 AND composer_id = 467 AND title = 'Media vita in morte sumus'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 23097 AND composer_id = 389 AND title = 'Во дни брани Op. 45'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 23101 AND composer_id = 389 AND title = 'Литургия св. Иоанна Златоуста Op. 42'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 23201 AND composer_id = 449 AND title = 'Romanza'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23212 AND composer_id = 467 AND title = 'Laus Deo, pax vivis'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 23254 AND composer_id = 389 AND title = 'Angel vopiyashe'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 23295 AND composer_id = 449 AND title = 'Leonesa'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23344 AND composer_id = 467 AND title = 'Lugebat David Absalom'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23354 AND composer_id = 467 AND title = 'Or suis je prins à 4'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 23402 AND composer_id = 389 AND title = 'Come, Let Us Worship'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 23420 AND composer_id = 449 AND title = 'Variaciones sobre un tema de Fernando Sor'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23463 AND composer_id = 467 AND title = 'Vae, vae Babylon'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23491 AND composer_id = 467 AND title = 'O beata Maria'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 23494 AND composer_id = 389 AND title = 'Veriu'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23501 AND composer_id = 467 AND title = 'Quam pulchra es'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23511 AND composer_id = 467 AND title = 'Mille regretz'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23573 AND composer_id = 467 AND title = 'Homo erat'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23581 AND composer_id = 467 AND title = 'Qui colis Ausoniam'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23600 AND composer_id = 467 AND title = 'O flos campi'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23655 AND composer_id = 467 AND title = 'Plaisir n''ay plus que vivre en desconfort'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 23845 AND composer_id = 449 AND title = 'La filla del marxant'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23848 AND composer_id = 467 AND title = 'O malheureuse journee à 5'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 23916 AND composer_id = 467 AND title = 'Credo'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 23928 AND composer_id = 389 AND title = 'Отче Наш'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 24026 AND composer_id = 467 AND title = 'Par un regard à 3'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 24063 AND composer_id = 395 AND title = 'De profundis'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 24125 AND composer_id = 389 AND title = 'Praise ye the name of the Lord'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 24154 AND composer_id = 389 AND title = 'O Lord God'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 24164 AND composer_id = 389 AND title = 'O Tebe raduyetsia'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 24197 AND composer_id = 449 AND title = 'El mestre'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 24230 AND composer_id = 467 AND title = 'O gloriosa Dei genitrix à 4'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 24354 AND composer_id = 389 AND title = 'Matija bozija'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 24390 AND composer_id = 467 AND title = 'Tribulatione et angustia'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 24536 AND composer_id = 389 AND title = 'In That We Have Beheld the Resurrection of Christ (Kiev Chant)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 24609 AND composer_id = 449 AND title = 'La filadora'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 24618 AND composer_id = 395 AND title = 'Exultate Justi in Domino'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 24625 AND composer_id = 449 AND title = 'L''hereu Riera'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 24684 AND composer_id = 449 AND title = 'Lo rossinyol'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 24702 AND composer_id = 467 AND title = 'In illo tempore'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 24747 AND composer_id = 467 AND title = 'Je prens congie'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 24752 AND composer_id = 389 AND title = 'The Assembly of the Angels (Znamenny Chant)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 24814 AND composer_id = 389 AND title = 'All-night Vigil Op. 44'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 24829 AND composer_id = 467 AND title = 'Veni electa mea'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 24843 AND composer_id = 467 AND title = 'Pleust a Dieu à 3'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 24885 AND composer_id = 467 AND title = 'A quoy tient il à 4'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 24947 AND composer_id = 449 AND title = 'La preço de Lleida'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 24971 AND composer_id = 395 AND title = 'En languissant avoir secours j''attens'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 25001 AND composer_id = 389 AND title = 'To the Most Holy Sovereign Lady Op. 43'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25049 AND composer_id = 467 AND title = 'O rex gloriae'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25078 AND composer_id = 467 AND title = 'Musae Jovis á 6'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 25151 AND composer_id = 389 AND title = 'Da ispravitsa molitva noja'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25190 AND composer_id = 467 AND title = 'Angelus Domini ad pastores'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25200 AND composer_id = 467 AND title = 'Dezilde al cavallero'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25280 AND composer_id = 467 AND title = 'Epitaphium in Josquinum à Prato'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 25296 AND composer_id = 449 AND title = 'Plany'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 25341 AND composer_id = 449 AND title = 'La pastoreta'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25385 AND composer_id = 395 AND title = 'C''Est Trop Parlé de Bacchus'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25391 AND composer_id = 467 AND title = 'Tulerunt Dominum meum'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25460 AND composer_id = 467 AND title = 'Triste depart à 5'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 25485 AND composer_id = 389 AND title = 'From My Youth'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25613 AND composer_id = 467 AND title = 'Mort et fortune à 4'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25703 AND composer_id = 467 AND title = 'Mille regres'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25727 AND composer_id = 467 AND title = 'En attendant à 6'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25743 AND composer_id = 395 AND title = 'O Adonai'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25817 AND composer_id = 467 AND title = 'O Gloriosa Domina'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25938 AND composer_id = 467 AND title = 'Mon seul a 7'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 33332 AND composer_id = 467 AND title = 'Super flumina Babylonis'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 33358 AND composer_id = 75 AND title = 'Gran jota'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 33418 AND composer_id = 298 AND title = 'Ave maris stella'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 33507 AND composer_id = 389 AND title = 'Дух твой благий'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 33508 AND composer_id = 389 AND title = 'Спасение соделал'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 33580 AND composer_id = 395 AND title = 'Super flumina Babylonis'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 33585 AND composer_id = 449 AND title = 'Clavelitos'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 33905 AND composer_id = 331 AND title = '18세기의 에어'
  AND genre IS NULL AND form_key IS NULL;
