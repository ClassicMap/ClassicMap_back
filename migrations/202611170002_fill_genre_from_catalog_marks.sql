-- 작곡가 화면 '기타'(갈래 없음) 줄이기 2026-11-17: 1~3차 손 카탈로그(catalog.json)의 갈래 표시로 빈 갈래·형식을 채운다.
-- 근거와 생성기: seed_pipeline/curation/piece-genre-fill-2026-11-17/(README.md, fill.py, fills.jsonl).
-- 갈래·형식이 둘 다 비어 있고 제목이 덤프 때와 같을 때만 바꾼다(이미 있는 값은 그대로, 두 번 넣어도 같다).
-- 작품 455곡. 규칙별: catalog:piano 86, catalog:piano_pieces 41, catalog:orchestral 31, catalog:songs 28, catalog:keyboard 25, catalog:sacred 21, catalog:chamber 19, catalog:sacred_choral 19, catalog:part_song 19, catalog:piano_piece 16, catalog:guitar 15, catalog:organ 13, catalog:psalm 13, catalog:choral 9, catalog:violin_orchestra 9, catalog:concertante 8, catalog:sacred_vocal 7, catalog:song 6, catalog:vocal_quartets 6, catalog:violin_piano 5, catalog:serenata 5, catalog:violin_guitar 5, catalog:aria 4, catalog:cantata 4, catalog:oratorio 4, catalog:two_pianos 3, catalog:part_songs 3, catalog:ode 3, catalog:cello_piano 2, catalog:concert_piece 2, catalog:string_quartet 2, catalog:violin_solo 2, catalog:duets 1, catalog:pedal_piano 1, catalog:choral_orchestral 1, catalog:opera 1, catalog:piano_duet 1, catalog:piano_orchestra 1, catalog:album_leaf 1, catalog:piano_sonata 1, catalog:vocal_ensemble 1, catalog:masque 1, catalog:canticle 1, catalog:string_ensemble 1, catalog:band 1, catalog:mass 1, catalog:string_trio 1, catalog:incidental_music 1, catalog:wind_ensemble 1, catalog:stage 1, catalog:mandolin_guitar 1, catalog:piano_four_hands 1
-- 갈래/형식별: piano/piano_other 111, vocal/sacred 61, piano/character 59, vocal/song 34, chamber/chamber_other 32, orchestral/orchestral_other 32, vocal/choral 32, concerto/concertante 20, chamber/solo 17, piano/organ 13, vocal/cantata 12, vocal/vocal_other 8, piano/four_hands 5, vocal/concert_aria 4, vocal/oratorio_passion 4, stage/stage_other 2, chamber/string_ensemble 2, chamber/string_quartet 2, stage/operetta 1, piano/sonata 1, vocal/mass_requiem 1, orchestral/incidental 1, chamber/wind_chamber 1

UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 511 AND composer_id = 60 AND title = '하바네즈 E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 518 AND composer_id = 47 AND title = '엘레지 C단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 626 AND composer_id = 47 AND title = '로망스 B♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 675 AND composer_id = 47 AND title = '안단테 B♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'concert_aria'
WHERE id = 968 AND composer_id = 60 AND title = '<롤라>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 987 AND composer_id = 60 AND title = '<사포의 노래>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 1010 AND composer_id = 60 AND title = '<Veni Creator> C장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 1021 AND composer_id = 60 AND title = '<아베 베룸> B♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 1157 AND composer_id = 47 AND title = '<비너스의 탄생>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 1299 AND composer_id = 60 AND title = '엘레지 1번'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 1400 AND composer_id = 60 AND title = '덴마크와 러시아 선율에 의한 카프리스'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'four_hands'
WHERE id = 1527 AND composer_id = 60 AND title = '<아랍 카프리스>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 1555 AND composer_id = 51 AND title = '<보리스 고두노프>의 2개의 독백'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 1623 AND composer_id = 51 AND title = '카논 E단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 1817 AND composer_id = 60 AND title = '<Panis angelicus> F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 1837 AND composer_id = 47 AND title = '<Super flumina Babylonis>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 2007 AND composer_id = 60 AND title = '<이스마일리아의 추억>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 2039 AND composer_id = 60 AND title = '<거양성체 또는 영성체> E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 2162 AND composer_id = 60 AND title = '<사이프러스와 월계수> D단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 2306 AND composer_id = 60 AND title = '<시계의 노래>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 2443 AND composer_id = 47 AND title = '<나비>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 2661 AND composer_id = 60 AND title = '<이탈리아의 추억> G장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'four_hands'
WHERE id = 2687 AND composer_id = 60 AND title = '<영웅 카프리스>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 2854 AND composer_id = 47 AND title = '로망스 A장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 7439 AND composer_id = 50 AND title = '<스티리아풍 타란텔라>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 7541 AND composer_id = 50 AND title = '<가면>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 7588 AND composer_id = 50 AND title = '<보헤미안 춤>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 7727 AND composer_id = 50 AND title = '<하이든 찬가>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 8226 AND composer_id = 50 AND title = '<잊혀진 영상>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'four_hands'
WHERE id = 8776 AND composer_id = 50 AND title = '<흰색과 검은색으로>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 9422 AND composer_id = 50 AND title = '<말라르메의 시 3편>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 10040 AND composer_id = 50 AND title = '<판화>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 10259 AND composer_id = 50 AND title = '<스케치북에서>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11415 AND composer_id = 33 AND title = '4중창 왈츠 <새로운 사랑의 노래>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 11444 AND composer_id = 33 AND title = '4개의 발라드 Op. 10'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11458 AND composer_id = 33 AND title = '6개의 4중창 Op. 112'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 11459 AND composer_id = 33 AND title = '2개의 모테트 Op. 29'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 11604 AND composer_id = 33 AND title = '2개의 모테트 Op. 74'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11610 AND composer_id = 33 AND title = '3개의 4중창 Op. 31'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 11704 AND composer_id = 33 AND title = '5개의 노래 Op. 72'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 11711 AND composer_id = 84 AND title = '5개의 시 Op. 23'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 11727 AND composer_id = 33 AND title = '3개의 인테르메초 Op. 117'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11830 AND composer_id = 33 AND title = '4개의 4중창 Op. 92'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 11845 AND composer_id = 33 AND title = '2개의 사라반드 WoO 5'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11922 AND composer_id = 33 AND title = '3개의 4중창 Op. 64'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 11959 AND composer_id = 84 AND title = '전쟁 종결 송가'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 11983 AND composer_id = 33 AND title = '3개의 모테트 Op. 110'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 11988 AND composer_id = 33 AND title = '4개의 발라드와 로망스 Op. 75'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 12004 AND composer_id = 84 AND title = '축전 시 <볼가 강과 돈 강의 만남>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 12026 AND composer_id = 26 AND title = '오페르토리움 <Totus in corde langueo> C장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 12055 AND composer_id = 26 AND title = '헝가리 선율 B단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 12066 AND composer_id = 26 AND title = '남성 4중창 <Leise, leise laßt uns singen>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 12176 AND composer_id = 26 AND title = '3개의 노래 D. 902'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 12181 AND composer_id = 26 AND title = '성령 찬가 <Hymnus an den heiligen Geist>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 12192 AND composer_id = 26 AND title = '혼성 4중창 <Gott im Ungewitter>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 12226 AND composer_id = 26 AND title = '<Lacrimas>의 두 장면 D. 857'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 12377 AND composer_id = 26 AND title = '탄툼 에르고 C장조 D. 739'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 12435 AND composer_id = 26 AND title = '남성 4중창 <Ewige Liebe>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 12522 AND composer_id = 83 AND title = '5개의 단편'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 12604 AND composer_id = 26 AND title = '남성 4중창 <Fischerlied>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 12640 AND composer_id = 26 AND title = '남성 4중창 <Flucht>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 12792 AND composer_id = 26 AND title = '남성 4중창 <Nachtmusik>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 12804 AND composer_id = 26 AND title = '남성 4중창 <Wein und Liebe>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 12841 AND composer_id = 83 AND title = '<노보로시스크의 종> (영원한 영광의 불꽃)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 12877 AND composer_id = 26 AND title = '오페르토리움 <Intende voci> B♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 12951 AND composer_id = 26 AND title = '남성 4중창 <Liebe>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 12986 AND composer_id = 83 AND title = '크릴로프의 2개의 우화'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 12994 AND composer_id = 26 AND title = '살리에리 50주년 기념 축하곡 D. 407'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 13051 AND composer_id = 26 AND title = '남성 4중창 <Frühlingsgesang> D. 709'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 13108 AND composer_id = 26 AND title = '남성 4중창 <Die Einsiedelei>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 13151 AND composer_id = 26 AND title = '남성 4중창 <Frühlingslied>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 13184 AND composer_id = 26 AND title = '남성 4중창 <Ruhe, schönstes Glück der Erde>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 13215 AND composer_id = 26 AND title = '2개의 스케르초 D. 593'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 13358 AND composer_id = 26 AND title = '탄툼 에르고 E♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 13404 AND composer_id = 26 AND title = '남성 4중창 <Wehmut>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 13500 AND composer_id = 26 AND title = '혼성 4중창 <Gott der Weltschöpfer>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 13533 AND composer_id = 26 AND title = '오페르토리움 <Auguste jam coelestium> G장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 13554 AND composer_id = 26 AND title = '남성 4중창 <Trinklied aus dem 16. Jahrhundert>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 13559 AND composer_id = 26 AND title = '남성 4중창 <Zum Rundetanz>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 13599 AND composer_id = 26 AND title = '종려 주일을 위한 6개의 안티폰'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 13617 AND composer_id = 26 AND title = '혼성 4중창 <Das Grab>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 13785 AND composer_id = 117 AND title = '노르웨이 농민 무곡 <슬로테르>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 13807 AND composer_id = 117 AND title = '6개의 노르웨이 산의 선율'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 13820 AND composer_id = 117 AND title = '4개의 유모레스크 Op. 6'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 13825 AND composer_id = 117 AND title = '4개의 시편'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 14405 AND composer_id = 117 AND title = '4성부 카논'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 14790 AND composer_id = 4 AND title = '샤콘 G단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 26287 AND composer_id = 14 AND title = '카프리치오 C장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 26295 AND composer_id = 14 AND title = '작은 지그 G장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 26525 AND composer_id = 14 AND title = '미세레레 A단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 26526 AND composer_id = 14 AND title = '안티폰 <Quaerite primum regnum Dei> D단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'concert_aria'
WHERE id = 26620 AND composer_id = 14 AND title = '칸초네타 <Più non si trovano>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 26856 AND composer_id = 15 AND title = '알레그레토 콰지 안단테 G단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'concert_aria'
WHERE id = 26885 AND composer_id = 15 AND title = '<Die schöne Schusterin>을 위한 아리아 2곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 26892 AND composer_id = 15 AND title = '<Es ist vollbracht> (<Die Ehrenpforten> 피날레)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 26899 AND composer_id = 15 AND title = '<Gesang der Mönche>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 27335 AND composer_id = 16 AND title = '카프리치오 G장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 27377 AND composer_id = 16 AND title = '아베 레지나 A장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 27385 AND composer_id = 16 AND title = '칸틸레나 <Ein'' Magd, ein'' Dienerin>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 27388 AND composer_id = 16 AND title = '6개의 시편'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'concert_aria'
WHERE id = 27402 AND composer_id = 16 AND title = '카바티나 <Sono Alcina e sono ancora>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 27519 AND composer_id = 29 AND title = '알레그로 B단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 27528 AND composer_id = 29 AND title = '꽃의 곡 D♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 27529 AND composer_id = 29 AND title = '유머레스크 B♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 27538 AND composer_id = 29 AND title = '3개의 시 Op. 29'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27539 AND composer_id = 29 AND title = '3개의 시 Op. 30'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27540 AND composer_id = 29 AND title = '3개의 노래 Op. 31'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27544 AND composer_id = 29 AND title = '12개의 시 Op. 35'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27545 AND composer_id = 29 AND title = '6개의 시 Op. 36'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27553 AND composer_id = 29 AND title = '로망스와 발라드 1집 Op. 45'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27556 AND composer_id = 29 AND title = '로망스와 발라드 2집 Op. 49'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27560 AND composer_id = 29 AND title = '로망스와 발라드 3집 Op. 53'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 27564 AND composer_id = 29 AND title = '스케치 Op. 58'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27570 AND composer_id = 29 AND title = '로망스와 발라드 4집 Op. 64'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 27571 AND composer_id = 29 AND title = '카논풍의 리토르넬로 Op. 65'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 27576 AND composer_id = 29 AND title = '아다지오와 알레그로 A♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27589 AND composer_id = 29 AND title = '3개의 노래 Op. 83'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 27590 AND composer_id = 29 AND title = '<이별에 부르는 노래>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27595 AND composer_id = 29 AND title = '6개의 노래 Op. 89'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 27598 AND composer_id = 29 AND title = '서주와 알레그로 아파시오나토 G장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27601 AND composer_id = 29 AND title = '3개의 노래 Op. 95'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27613 AND composer_id = 29 AND title = '6개의 노래 Op. 107'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE id = 27618 AND composer_id = 29 AND title = '<장미의 순례>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27623 AND composer_id = 29 AND title = '4개의 경기병 노래 Op. 117'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27625 AND composer_id = 29 AND title = '3개의 시 Op. 119'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27631 AND composer_id = 29 AND title = '5개의 즐거운 노래 Op. 125'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 27640 AND composer_id = 29 AND title = '서주와 협주풍 알레그로 D단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 27643 AND composer_id = 29 AND title = '5개의 사냥 노래 Op. 137'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27648 AND composer_id = 29 AND title = '4개의 노래 Op. 142'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE id = 27657 AND composer_id = 29 AND title = '<괴테의 파우스트 장면>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 27658 AND composer_id = 29 AND title = '힘멜의 "An Alexis send'' ich dich"에 의한 카논 A♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 27700 AND composer_id = 27 AND title = '카프리치오 브릴란테 B단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 27701 AND composer_id = 27 AND title = '교회 음악 Op. 23'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 27710 AND composer_id = 27 AND title = '카프리스 Op. 33'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 27753 AND composer_id = 27 AND title = '6개의 격언 Op. 79'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'operetta'
WHERE id = 27763 AND composer_id = 27 AND title = '리더슈필 <타향에서의 귀향>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'four_hands'
WHERE id = 27765 AND composer_id = 27 AND title = '알레그로 브릴란테 A장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 27788 AND composer_id = 27 AND title = '장송가 G단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 27791 AND composer_id = 27 AND title = '무궁동 C장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 27799 AND composer_id = 27 AND title = '안단테 칸타빌레와 프레스토 아지타토 B장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 27803 AND composer_id = 27 AND title = '곤돌라의 노래 A장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 27853 AND composer_id = 27 AND title = '<저녁 종> B♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 27855 AND composer_id = 27 AND title = '아사이 트란퀼로 B단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 27876 AND composer_id = 30 AND title = '<아시시의 성 프란치스코의 태양의 찬가>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 27877 AND composer_id = 30 AND title = '<성 체칠리아의 전설>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 27900 AND composer_id = 30 AND title = '<Responsorien und Antiphonen>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 27919 AND composer_id = 30 AND title = '<Septem sacramenta>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 27920 AND composer_id = 30 AND title = '<십자가의 길>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 27974 AND composer_id = 30 AND title = '레나우의 <파우스트>에 의한 2개의 에피소드'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 27975 AND composer_id = 30 AND title = '3개의 장송 송가'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 27977 AND composer_id = 30 AND title = '<예술가 축제 행렬>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 27981 AND composer_id = 30 AND title = '<저주> E단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 27988 AND composer_id = 30 AND title = '<결혼 축가>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 27989 AND composer_id = 30 AND title = '<리하르트 바그너의 무덤에서>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 27999 AND composer_id = 30 AND title = '알레그로 디 브라부라 E♭단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28000 AND composer_id = 30 AND title = '아다지오 논 트로포'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 28014 AND composer_id = 30 AND title = '안단티노 E♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28055 AND composer_id = 30 AND title = '로망스 E단조 "오, 왜 그런가"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28064 AND composer_id = 30 AND title = '대연주회 독주곡 E단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28070 AND composer_id = 30 AND title = '알렐루야 F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28071 AND composer_id = 30 AND title = '<우르비 에트 오르비>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28075 AND composer_id = 30 AND title = '<체념> E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28076 AND composer_id = 30 AND title = '<주님의 거룩한 변모 축일에>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28082 AND composer_id = 30 AND title = '비가 1번'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28083 AND composer_id = 30 AND title = '비가 2번'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28085 AND composer_id = 30 AND title = '<카이저 빌헬름!>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28086 AND composer_id = 30 AND title = '<요람의 노래>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28087 AND composer_id = 30 AND title = '<잿빛 구름>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28088 AND composer_id = 30 AND title = '<슬픈 곤돌라>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28089 AND composer_id = 30 AND title = '<R.W. – 베네치아>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28090 AND composer_id = 30 AND title = '<잠 못 이루고! 물음과 대답>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28091 AND composer_id = 30 AND title = '<명상>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28096 AND composer_id = 30 AND title = '<불길한 별!>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28118 AND composer_id = 30 AND title = '<축전 전주곡>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28240 AND composer_id = 34 AND title = '로망스 F단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28243 AND composer_id = 34 AND title = '카프리치오 G♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE id = 28268 AND composer_id = 34 AND title = '그랜드 소나타 G장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 28291 AND composer_id = 34 AND title = '페초 카프리치오소 B단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 28321 AND composer_id = 34 AND title = '엘레지 G장조 "사마린을 기리며"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 28331 AND composer_id = 34 AND title = '삼중창 <Priroda i lyubov''>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 28334 AND composer_id = 34 AND title = '9개의 성가 TH 78'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 28341 AND composer_id = 34 AND title = 'A. G. 루빈시테인에게 보내는 인사'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28356 AND composer_id = 34 AND title = '열정적인 고백 E단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_other'
WHERE id = 28412 AND composer_id = 6 AND title = '가면극 <에스더>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 28435 AND composer_id = 6 AND title = '세레나타 <아치, 갈라테아와 폴리페모>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 28436 AND composer_id = 6 AND title = '세레나타 <파르나소스의 축제>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 28437 AND composer_id = 6 AND title = '앤 여왕 탄신 송가'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 28438 AND composer_id = 6 AND title = '송가 <알렉산더의 향연>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 28439 AND composer_id = 6 AND title = '성 체칠리아의 날을 위한 송가'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 28580 AND composer_id = 6 AND title = '안티폰 <Haec est Regina virginum>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 28588 AND composer_id = 6 AND title = '안티폰 <Te decus virgineum>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 28600 AND composer_id = 6 AND title = '위트레흐트 유빌라테'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 28621 AND composer_id = 6 AND title = '라르고 F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 28624 AND composer_id = 6 AND title = '아다지오와 알레그로'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 28626 AND composer_id = 6 AND title = '알레그로 G장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28667 AND composer_id = 6 AND title = '에어(사라방드) E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28681 AND composer_id = 6 AND title = '에어 C장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28683 AND composer_id = 6 AND title = '에어(혼파이프) D단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28685 AND composer_id = 6 AND title = '에어 F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28686 AND composer_id = 6 AND title = '에어와 두 개의 두블 F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28687 AND composer_id = 6 AND title = '에어 G단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28688 AND composer_id = 6 AND title = '에어 G단조 "Lentement"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28689 AND composer_id = 6 AND title = '에어 A장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28690 AND composer_id = 6 AND title = '에어 B♭장조 HWV 469'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28691 AND composer_id = 6 AND title = '에어 B♭장조 HWV 470'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28692 AND composer_id = 6 AND title = '에어 B♭장조 HWV 471'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28693 AND composer_id = 6 AND title = '알레그로 C장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28694 AND composer_id = 6 AND title = '알레그로 D단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28695 AND composer_id = 6 AND title = '알르망드 F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28696 AND composer_id = 6 AND title = '알르망드 A장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28697 AND composer_id = 6 AND title = '알르망드 A단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28698 AND composer_id = 6 AND title = '알르망드 B단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28700 AND composer_id = 6 AND title = '카프리치오 F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28701 AND composer_id = 6 AND title = '카프리치오 G단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28702 AND composer_id = 6 AND title = '샤콘 F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28703 AND composer_id = 6 AND title = '샤콘 G단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28711 AND composer_id = 6 AND title = '레슨 A단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28712 AND composer_id = 6 AND title = '파스피에 C장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 28713 AND composer_id = 6 AND title = '파스피에 A장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29179 AND composer_id = 7 AND title = '크레도'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29181 AND composer_id = 7 AND title = '딕시트 도미누스 RV 594'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29182 AND composer_id = 7 AND title = '딕시트 도미누스 RV 595'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29184 AND composer_id = 7 AND title = '베아투스 비르 RV 597'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29185 AND composer_id = 7 AND title = '베아투스 비르 RV 598'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29186 AND composer_id = 7 AND title = '라우다테 푸에리 RV 600'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29187 AND composer_id = 7 AND title = '라우다테 푸에리 RV 601'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29188 AND composer_id = 7 AND title = '라우다테 푸에리 RV 602'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29190 AND composer_id = 7 AND title = '인 엑시투 이스라엘'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29191 AND composer_id = 7 AND title = '라우다테 도미눔'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29193 AND composer_id = 7 AND title = '니시 도미누스 RV 608'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 29260 AND composer_id = 7 AND title = '세레나타 <La Gloria e Imeneo>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 29261 AND composer_id = 7 AND title = '세레나타 <Mio cor, povero cor>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 29262 AND composer_id = 7 AND title = '세레나타 <La Senna festeggiante>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29306 AND composer_id = 7 AND title = '베아투스 비르 RV 795'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29311 AND composer_id = 7 AND title = '니시 도미누스 RV 803'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29313 AND composer_id = 7 AND title = '딕시트 도미누스 RV 807'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29539 AND composer_id = 23 AND title = '<Ingresso e Kyrie della Messa de'' morti> C단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_ensemble'
WHERE id = 29666 AND composer_id = 36 AND title = '6개의 현악 소나타'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 29671 AND composer_id = 36 AND title = '콘트라베이스 오블리가토 신포니아'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 29678 AND composer_id = 36 AND title = '작은 합주를 위한 세레나타 E♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 29685 AND composer_id = 36 AND title = '팡파르 <La corona d''Italia>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'mass_requiem'
WHERE id = 29687 AND composer_id = 36 AND title = '대영광 미사'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29693 AND composer_id = 36 AND title = '오 살루타리스 호스티아 (1857)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 29903 AND composer_id = 31 AND title = '민중 찬가 <니콜라이>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 29915 AND composer_id = 31 AND title = '축전가 <Der Tag erscheint>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 29916 AND composer_id = 31 AND title = '성서 장면 <사도들의 애찬>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 29927 AND composer_id = 31 AND title = '엘레지 A♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29976 AND composer_id = 32 AND title = '파테르 노스테르'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29979 AND composer_id = 32 AND title = '탄툼 에르고 G장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29980 AND composer_id = 32 AND title = '탄툼 에르고 F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29982 AND composer_id = 32 AND title = '라우다테 푸에리 D장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29983 AND composer_id = 32 AND title = '퀴 톨리스 F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 29986 AND composer_id = 32 AND title = '말 없는 로망스'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 30733 AND composer_id = 40 AND title = '안단티노 콰이에토소 E♭단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 30737 AND composer_id = 40 AND title = '<목가>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 30739 AND composer_id = 40 AND title = '대카프리스 1번'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 30740 AND composer_id = 40 AND title = '<아헨의 추억>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 30745 AND composer_id = 40 AND title = '<인형의 탄식>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 30747 AND composer_id = 40 AND title = '<느린 춤>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 30750 AND composer_id = 40 AND title = '안단티노 G단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 30755 AND composer_id = 40 AND title = '파스토랄 E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 30756 AND composer_id = 40 AND title = '기도 C#단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 30757 AND composer_id = 40 AND title = '피날레 B♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 30758 AND composer_id = 40 AND title = '콰지 마르차 F#단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 30760 AND composer_id = 40 AND title = '칸타빌레 B장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 30765 AND composer_id = 40 AND title = '<오르가니스트>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE id = 30774 AND composer_id = 40 AND title = '<속죄>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 30780 AND composer_id = 40 AND title = '<탄툼 에르고> D장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 30800 AND composer_id = 40 AND title = '애국 송가 <파리>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE id = 30824 AND composer_id = 40 AND title = '<십자가 위의 일곱 말씀>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 30829 AND composer_id = 40 AND title = '브르타뉴 노엘에 의한 봉헌송 A단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 30830 AND composer_id = 40 AND title = '입당곡 E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 30832 AND composer_id = 40 AND title = '작은 봉헌송 C단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 30977 AND composer_id = 58 AND title = '활인화 음악 <어부> E♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31023 AND composer_id = 58 AND title = '3개의 살롱 폴카'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31024 AND composer_id = 58 AND title = '스케치 1권'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31025 AND composer_id = 58 AND title = '스케치 2권'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31036 AND composer_id = 58 AND title = '토카티나 B♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31044 AND composer_id = 58 AND title = '3개의 시적인 폴카'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31050 AND composer_id = 58 AND title = '보헤미아의 추억 Op. 12'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31051 AND composer_id = 58 AND title = '보헤미아의 추억 Op. 13'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31055 AND composer_id = 58 AND title = '체코 무곡 1권'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31056 AND composer_id = 58 AND title = '체코 무곡 2권'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31058 AND composer_id = 58 AND title = '로망스 G단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31118 AND composer_id = 43 AND title = '<어린 시절의 추억>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31121 AND composer_id = 43 AND title = '<아이들의 장난>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31123 AND composer_id = 43 AND title = '몽상'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31124 AND composer_id = 43 AND title = '<변덕스러운 여인>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31125 AND composer_id = 43 AND title = '스케르치노 <재봉사>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31126 AND composer_id = 43 AND title = '<크림 남쪽 기슭에서> "아유다그의 구르주프"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31127 AND composer_id = 43 AND title = '카프리치오 <크림 남쪽 기슭 가까이> "바이다르키"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31129 AND composer_id = 43 AND title = '<눈물>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31185 AND composer_id = 39 AND title = '낭만적 왈츠'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31207 AND composer_id = 39 AND title = '로망스 A단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31208 AND composer_id = 39 AND title = '로망스 B단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 31251 AND composer_id = 45 AND title = '로망스 F단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE id = 31253 AND composer_id = 45 AND title = '안단테 아파시오나토 F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31284 AND composer_id = 45 AND title = '스코틀랜드 무곡 D단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 31291 AND composer_id = 45 AND title = '카프리치오 C장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 31292 AND composer_id = 45 AND title = '삼위일체 축일 찬가'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31294 AND composer_id = 45 AND title = '푸리안트 Op. 42'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 31298 AND composer_id = 45 AND title = '마주레크 E단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 31303 AND composer_id = 45 AND title = '아베 마리스 스텔라'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31311 AND composer_id = 45 AND title = '에클로그 B. 103'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31320 AND composer_id = 45 AND title = '모데라토 A장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31331 AND composer_id = 45 AND title = '질문 G단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31339 AND composer_id = 45 AND title = '푸리안트 G단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31340 AND composer_id = 45 AND title = '유모레스크 F#장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_ensemble'
WHERE id = 31349 AND composer_id = 45 AND title = '미니어처'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 31354 AND composer_id = 45 AND title = '2개의 작은 진주'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 31365 AND composer_id = 45 AND title = '팡파르 C장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 31428 AND composer_id = 46 AND title = '전주곡 <무덤 앞에서>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 31429 AND composer_id = 46 AND title = '<두비누시카>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 31430 AND composer_id = 46 AND title = '<건배의 노래>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31483 AND composer_id = 46 AND title = '<작은 노래> (Andantino)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 31514 AND composer_id = 48 AND title = '라르고 아다제토 F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 31530 AND composer_id = 68 AND title = '카사치오네'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31564 AND composer_id = 68 AND title = '10개의 서정적 상념 Op. 40'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31590 AND composer_id = 68 AND title = '2개의 론디노 Op. 68'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 31599 AND composer_id = 68 AND title = '2개의 장엄한 선율 Op. 77'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31625 AND composer_id = 68 AND title = '5개의 성격적 인상 Op. 103'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 31634 AND composer_id = 68 AND title = '<프리메이슨 의식 음악>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31635 AND composer_id = 68 AND title = '<5개의 스케치> Op. 114'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31643 AND composer_id = 68 AND title = '프레스토 A단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31647 AND composer_id = 68 AND title = '아다지오 D장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31649 AND composer_id = 68 AND title = '아다지오 E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31654 AND composer_id = 68 AND title = '알레그레토 B♭단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31657 AND composer_id = 68 AND title = '알레그레토 E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31659 AND composer_id = 68 AND title = '알레그레토 F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31660 AND composer_id = 68 AND title = '알레그레토 G단조 (1888)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31664 AND composer_id = 68 AND title = '안단테 E♭장조 (1887)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 31668 AND composer_id = 68 AND title = '안단테 페스티보'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31674 AND composer_id = 68 AND title = '안단티노 E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31676 AND composer_id = 68 AND title = '안단티노 B장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31678 AND composer_id = 68 AND title = '아침의 노래 A♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31679 AND composer_id = 68 AND title = '황혼에 F#단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31683 AND composer_id = 68 AND title = '콘 모토, 셈프레 우나 코르다 D♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31684 AND composer_id = 68 AND title = '콘 파시오네'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31702 AND composer_id = 68 AND title = '안단테 E♭장조 (1885)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 31726 AND composer_id = 68 AND title = '3개의 입당 교창 JS 110'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31732 AND composer_id = 68 AND title = '라르고 A장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31733 AND composer_id = 68 AND title = '렌토 E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31736 AND composer_id = 68 AND title = '만돌리나토'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31746 AND composer_id = 68 AND title = '모데라토 – 프레스토 D단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'incidental'
WHERE id = 31750 AND composer_id = 68 AND title = '<신문의 날 축제 음악>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31787 AND composer_id = 68 AND title = '스파뇰로'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31802 AND composer_id = 68 AND title = '안단티노 "O. 파르비아이넨에게"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31818 AND composer_id = 68 AND title = '비바체 D단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31821 AND composer_id = 68 AND title = '알레그레토 G단조 (1897)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 31829 AND composer_id = 81 AND title = '파스토랄'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 31832 AND composer_id = 81 AND title = '불꽃놀이'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 31842 AND composer_id = 81 AND title = '3개의 일본 서정시'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 31852 AND composer_id = 81 AND title = '어린이를 위한 3개의 이야기'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 31864 AND composer_id = 81 AND title = '11개 악기를 위한 래그타임'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 31865 AND composer_id = 81 AND title = '4개의 러시아 노래'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'wind_chamber'
WHERE id = 31874 AND composer_id = 81 AND title = '관악기를 위한 교향곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 31883 AND composer_id = 81 AND title = '파테르 노스테르 (주기도문)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 31892 AND composer_id = 81 AND title = '크레도'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31901 AND composer_id = 81 AND title = '탱고'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 31902 AND composer_id = 81 AND title = '협주적 무곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 31904 AND composer_id = 81 AND title = '4개의 노르웨이 무드'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 31905 AND composer_id = 81 AND title = '오드'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 31922 AND composer_id = 81 AND title = '딜런 토머스를 추모하며'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 31924 AND composer_id = 81 AND title = '칸티쿰 사크룸'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 31926 AND composer_id = 81 AND title = '트레니 (예레미야 애가)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 31928 AND composer_id = 81 AND title = '에피타피움'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE id = 31929 AND composer_id = 81 AND title = '이중 카논 "라울 뒤피를 추모하며"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 31930 AND composer_id = 81 AND title = '설교, 이야기, 기도'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 31932 AND composer_id = 81 AND title = '8개의 기악 미니어처'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_other'
WHERE id = 31933 AND composer_id = 81 AND title = '음악극 <대홍수>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 31934 AND composer_id = 81 AND title = '아브라함과 이삭'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 31935 AND composer_id = 81 AND title = 'J. F. K.를 위한 엘레지'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 31936 AND composer_id = 81 AND title = '새 극장을 위한 팡파르'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 31938 AND composer_id = 81 AND title = '인트로이투스 "T. S. 엘리엇을 추모하며"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 31963 AND composer_id = 85 AND title = '2개의 초상'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31967 AND composer_id = 85 AND title = '2개의 엘레지'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31969 AND composer_id = 85 AND title = '2개의 루마니아 무곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31970 AND composer_id = 85 AND title = '4개의 만가'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31971 AND composer_id = 85 AND title = '7개의 스케치'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 31972 AND composer_id = 85 AND title = '2개의 영상'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31973 AND composer_id = 85 AND title = '3개의 부를레스크'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31976 AND composer_id = 85 AND title = '알레그로 바르바로'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31980 AND composer_id = 85 AND title = '루마니아 민속 무곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31981 AND composer_id = 85 AND title = '루마니아 크리스마스 캐럴'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 31988 AND composer_id = 85 AND title = '3개의 헝가리 민요 선율'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 31998 AND composer_id = 85 AND title = '마을 풍경'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 32012 AND composer_id = 85 AND title = '20개의 헝가리 민요'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 32015 AND composer_id = 85 AND title = '트란실바니아 무곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 32016 AND composer_id = 85 AND title = '헝가리 스케치'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 32026 AND composer_id = 85 AND title = '콘트라스트'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 32043 AND composer_id = 35 AND title = '무궁동 C장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 32048 AND composer_id = 35 AND title = '소나타 콘체르타타 A장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 32049 AND composer_id = 35 AND title = '그랜드 소나타 A장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 32050 AND composer_id = 35 AND title = '<사육제 디베르티멘토>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 32051 AND composer_id = 35 AND title = '소나타 E♭장조 "나폴레옹"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 32054 AND composer_id = 35 AND title = '<Entrata d''Adone nella reggia di Venere>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 32060 AND composer_id = 35 AND title = '세레나타 E단조 "로베네를 위한"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32076 AND composer_id = 35 AND title = '<기리비치>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 32078 AND composer_id = 35 AND title = '칸타빌레와 왈츠 E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 32080 AND composer_id = 35 AND title = '아다지오 E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32084 AND composer_id = 35 AND title = '카프리치오 G장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 32087 AND composer_id = 35 AND title = '<애국의 노래>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 32090 AND composer_id = 35 AND title = '<생베르나르 산의 수도원>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32091 AND composer_id = 35 AND title = '<작별의 카프리스> E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 32094 AND composer_id = 35 AND title = '소나타 A장조 "봄"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 32097 AND composer_id = 35 AND title = '타란텔라 A단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 32099 AND composer_id = 35 AND title = '소나타 E장조 "마리아 루이사"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32106 AND composer_id = 35 AND title = '알레그레토 A장조 MS 86'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32108 AND composer_id = 35 AND title = '안단티노 G장조 MS 88'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32109 AND composer_id = 35 AND title = '안단티노 C장조 MS 89'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32110 AND composer_id = 35 AND title = '알레그레토 A장조 MS 90'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32111 AND composer_id = 35 AND title = '알레그레토 A단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32112 AND composer_id = 35 AND title = '왈츠 C장조 MS 92'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32114 AND composer_id = 35 AND title = '론돈치노 E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32115 AND composer_id = 35 AND title = '알레그레토 C장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32117 AND composer_id = 35 AND title = '안단티노 C장조 MS 97'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32118 AND composer_id = 35 AND title = '<로도비시아 교향곡> D장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32119 AND composer_id = 35 AND title = '안단티노 G장조 MS 99'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32120 AND composer_id = 35 AND title = '왈츠 C장조 MS 100'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32122 AND composer_id = 35 AND title = '안단티노 F단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 32125 AND composer_id = 35 AND title = '마르치알레 E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 32129 AND composer_id = 35 AND title = '칸타빌레 D장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 32140 AND composer_id = 35 AND title = '<Ghiribizzo vocale>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 32150 AND composer_id = 35 AND title = '<6개의 새 알레산드리나>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 32330 AND composer_id = 26 AND title = '남성 4중창 <Die Nacht>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 32356 AND composer_id = 33 AND title = '4중창곡집 <집시의 노래>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 32398 AND composer_id = 50 AND title = '샤를 도를레앙의 시에 의한 3개의 노래'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 32400 AND composer_id = 50 AND title = '<신성한 춤과 세속적인 춤>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 32401 AND composer_id = 50 AND title = '<Le petit nègre>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 32402 AND composer_id = 50 AND title = '프랑수아 비용의 발라드 3곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'four_hands'
WHERE id = 32404 AND composer_id = 50 AND title = '<6개의 고대 비명>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 32408 AND composer_id = 50 AND title = '<Les soirs illuminés par l''ardeur du charbon>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 32426 AND composer_id = 52 AND title = '고풍스러운 미뉴에트'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 32448 AND composer_id = 52 AND title = '하이든 이름에 의한 미뉴에트'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 32479 AND composer_id = 60 AND title = '<리스본의 밤> E♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 32480 AND composer_id = 60 AND title = '<아라곤의 호타> A장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 32491 AND composer_id = 60 AND title = '알레그로 아파시오나토 C#단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 32494 AND composer_id = 60 AND title = '<안달루시아 카프리스> G장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE id = 32495 AND composer_id = 60 AND title = '<뮤즈와 시인> E단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 32502 AND composer_id = 60 AND title = '엘레지 2번'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 32507 AND composer_id = 60 AND title = '<혼례 축복> F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 32523 AND composer_id = 60 AND title = '<저녁 종> A♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE id = 32671 AND composer_id = 83 AND title = '3개의 환상적인 춤곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 32778 AND composer_id = 117 AND title = '서정 소곡집 1권 Op. 12'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 32781 AND composer_id = 117 AND title = '2개의 비가적 선율'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 32783 AND composer_id = 117 AND title = '서정 소곡집 2권 Op. 38'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 32785 AND composer_id = 117 AND title = '서정 소곡집 3권 Op. 43'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 32787 AND composer_id = 117 AND title = '서정 소곡집 4권 Op. 47'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 32788 AND composer_id = 117 AND title = '서정 소곡집 5권 Op. 54'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 32791 AND composer_id = 117 AND title = '서정 소곡집 6권 Op. 57'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 32792 AND composer_id = 117 AND title = '서정 소곡집 7권 Op. 62'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 32793 AND composer_id = 117 AND title = '2개의 북유럽 선율'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 32794 AND composer_id = 117 AND title = '서정 소곡집 8권 Op. 65'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 32795 AND composer_id = 117 AND title = '서정 소곡집 9권 Op. 68'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 32796 AND composer_id = 117 AND title = '서정 소곡집 10권 Op. 71'
  AND genre IS NULL AND form_key IS NULL;
