-- 작곡가 화면 '기타'(갈래 없음) 줄이기 2026-11-17: 제목 낱말(무대 막 발췌·영화·종교·노래)로 빈 갈래·형식을 채운다.
-- 근거와 생성기: seed_pipeline/curation/piece-genre-fill-2026-11-17/(README.md, fill.py, fills.jsonl).
-- 갈래·형식이 둘 다 비어 있고 제목이 덤프 때와 같을 때만 바꾼다(이미 있는 값은 그대로, 두 번 넣어도 같다).
-- 작품 161곡. 규칙별: words:sacred 59, words:song 26, words:sacred+mb-lyrics 23, words:film 21, words:song+mb-lyrics 14, words:stage-excerpt 14, words:stage-work 4
-- 갈래/형식별: vocal/sacred 69, vocal/song 31, screen/soundtrack 21, stage/stage_excerpt 14, vocal/vocal_other 13, vocal/choral 5, vocal/cantata 3, stage/stage_other 2, stage/ballet 2, vocal/concert_aria 1

UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 481 AND composer_id = 110 AND title = '6개의 어린이 노래'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 483 AND composer_id = 94 AND title = '칸티클 1번 Op. 40 “내 사랑은 나의 것”'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 565 AND composer_id = 94 AND title = 'Quatre chansons françaises'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 641 AND composer_id = 94 AND title = 'Jubilate Deo in C major'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 789 AND composer_id = 64 AND title = 'Coronation Ode Op. 44'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 856 AND composer_id = 101 AND title = 'Music to the Film "Salavat Iulaev"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 867 AND composer_id = 94 AND title = 'Canticle II, op. 51 "Abraham and Isaac"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 888 AND composer_id = 101 AND title = 'Music to the Film "The Battle of Stalingrad"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 1018 AND composer_id = 101 AND title = 'Music to the Film “Prisoner no. 217”'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 1022 AND composer_id = 101 AND title = 'Music to the Documentary Film "The Tocsin of Peace"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 1101 AND composer_id = 61 AND title = '12 Schottische Volkslieder'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 1130 AND composer_id = 94 AND title = 'Jubilate Deo in E-flat'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 1235 AND composer_id = 94 AND title = 'Voices for Today'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 1376 AND composer_id = 101 AND title = 'Music to the Documentary Film "Vladimir Ilich Lenin"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 1382 AND composer_id = 86 AND title = '오페라 <포기와 베스> 중 "Tell me quick where''s Bess"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 1744 AND composer_id = 101 AND title = 'Music to the Film “Secret Mission”'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 1783 AND composer_id = 64 AND title = 'Kyrie in A'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 1797 AND composer_id = 101 AND title = 'Music to the Film "The Garden"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 1845 AND composer_id = 101 AND title = 'Music to the Film of K. Simonov''s Play "The Russian Question"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 1862 AND composer_id = 94 AND title = 'Canticle V, op. 89 "The Death of Saint Narcissus"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 2016 AND composer_id = 101 AND title = 'Music to the Film of Shakespeare''s tragedy "Othello"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 2116 AND composer_id = 37 AND title = 'Tantum Ergo'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 2145 AND composer_id = 101 AND title = 'Music to the Film "The Bonfire of Immortality / Undying Flame" Op. 86'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 2196 AND composer_id = 37 AND title = 'Chant du neuf Thermidor'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 2211 AND composer_id = 37 AND title = 'Les Troyens: Acte I, scène 3. "Du peuple et des soldats"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 2229 AND composer_id = 86 AND title = '오페라 <포기와 베스> 중 "Now de time, oh Gawd"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_other'
WHERE id = 2286 AND composer_id = 86 AND title = '뮤지컬 <Crazy for You>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 2335 AND composer_id = 108 AND title = 'Chöre für Doris, Nr. 1/11'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2348 AND composer_id = 37 AND title = 'Hymne à la France'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 2353 AND composer_id = 94 AND title = 'Antiphon'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 2426 AND composer_id = 101 AND title = 'Music to the Film "Ships Storming the Bastions"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 2446 AND composer_id = 101 AND title = 'Music to the film “Admiral Ushakov”'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 2472 AND composer_id = 94 AND title = 'Canticle IV, op. 86 "The Journey of the Magi"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'ballet'
WHERE id = 2520 AND composer_id = 101 AND title = '발레 음악 <서커스>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 2533 AND composer_id = 37 AND title = 'Les Troyens: Acte IV, scène 2. "Ah! quand viendra l''insant …"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 2573 AND composer_id = 101 AND title = 'Music to the Film of A. Kuprin''s Story "The Duel"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 2599 AND composer_id = 37 AND title = 'Hymne pour la consécration du nouveau tabernacle'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 2613 AND composer_id = 94 AND title = 'Canticle III, op. 55 "Still Falls the Rain - the Raids, 1940, Night and Dawn"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 2634 AND composer_id = 94 AND title = 'A Shepherd''s Carol'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 2703 AND composer_id = 37 AND title = 'Veni Creator'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 2704 AND composer_id = 37 AND title = 'Les Troyens: Acte V, scène 1. "En un dernier naufrage"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 2841 AND composer_id = 101 AND title = 'Music to the Film “Pepo”'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 2899 AND composer_id = 61 AND title = 'Sieben Gesänge Op. 71'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 2928 AND composer_id = 101 AND title = 'Music to the Film "Saltanat"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 2987 AND composer_id = 94 AND title = 'Peter Grimes: Act I Scene I: "What harbour shelters peace" (Peter)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'ballet'
WHERE id = 7535 AND composer_id = 100 AND title = '3막의 기독교 발레 <Uspud>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 7637 AND composer_id = 107 AND title = '성탄절을 위한 4개의 모테트 FP 152'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7644 AND composer_id = 100 AND title = '[Hymne pour le] Salut drapeau !'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 7708 AND composer_id = 107 AND title = 'Ave verum corpus, FP 154'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_other'
WHERE id = 7756 AND composer_id = 105 AND title = '뮤지컬 <Magdalena>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 7838 AND composer_id = 77 AND title = 'Hymnus amoris'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 8078 AND composer_id = 55 AND title = 'Le Corsaire: Act III. Action'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 8094 AND composer_id = 70 AND title = 'There''s a Voice in the Wind'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 8241 AND composer_id = 70 AND title = '리그베다 찬가 Op. 24'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 8416 AND composer_id = 70 AND title = '2개의 시편'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 8716 AND composer_id = 107 AND title = 'Exultate Deo, FP 109'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 8987 AND composer_id = 105 AND title = 'O Salutaris Hostia'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9308 AND composer_id = 98 AND title = 'Benedictus in E'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 9435 AND composer_id = 107 AND title = '참회의 시기를 위한 4개의 모테트 FP 97'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 9619 AND composer_id = 70 AND title = 'Nunc dimittis'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 9678 AND composer_id = 69 AND title = 'The Golden Carol'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 9829 AND composer_id = 107 AND title = 'Quatre chansons pour enfants, FP 75'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 10115 AND composer_id = 105 AND title = 'Panis Angelicus'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 10204 AND composer_id = 107 AND title = 'Trois chansons de F. García Lorca, FP 136'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 10388 AND composer_id = 70 AND title = '크리스마스 데이: 옛 캐럴에 의한 합창 환상곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 10491 AND composer_id = 104 AND title = 'From the House of the Dead: Act II. The Play of Kedril and Juan'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 10758 AND composer_id = 62 AND title = 'Chansons des bois d''Amaranthe'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 10815 AND composer_id = 70 AND title = 'Ode to Death'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 10918 AND composer_id = 62 AND title = 'Thaïs: Acte II, Scène II. Divertissement VI. La Charmeuse (avec chant)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 10966 AND composer_id = 70 AND title = '2개의 모테트 Op. 43'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 11164 AND composer_id = 107 AND title = 'Deux mélodies inédites du bestiaire, FP 15b'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 11205 AND composer_id = 98 AND title = 'Easter Carol'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 11443 AND composer_id = 44 AND title = 'Carmen: Act II. Entr''acte. Les Dragons d’Alcala'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 12382 AND composer_id = 96 AND title = 'Wozzek: Act III. Interlude'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 12429 AND composer_id = 22 AND title = 'Sturms geistliche Gesänge mit Melodien, Zweite Sammlung Wq. 198'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 12641 AND composer_id = 22 AND title = 'Cramers übersetzte Psalmen mit Melodien Wq. 196'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 13037 AND composer_id = 22 AND title = 'Sturms geistliche Gesänge mit Melodien, Erste Sammlung Wq. 197'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 16009 AND composer_id = 249 AND title = 'Ave verum'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 16873 AND composer_id = 263 AND title = 'Tantum ergo'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 17218 AND composer_id = 324 AND title = 'Trois motets à la Sainte Vierge Op. 31'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 17421 AND composer_id = 341 AND title = '4개의 사랑의 마드리갈'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 17590 AND composer_id = 204 AND title = 'Tita and Pedro''s Love Theme'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 17878 AND composer_id = 225 AND title = 'Responsorio delle tenebre'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 18042 AND composer_id = 256 AND title = 'Gloria'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 18139 AND composer_id = 341 AND title = 'Quatre cançons en llengua catalana'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 18542 AND composer_id = 332 AND title = 'Laudate Dominum'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 18647 AND composer_id = 204 AND title = '사랑의 노래'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19130 AND composer_id = 301 AND title = 'Stone Litany: Runes from a House of the Dead, op. 57'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'concert_aria'
WHERE id = 19177 AND composer_id = 341 AND title = '<El hijo fingido> 중 6개의 아리아'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 19278 AND composer_id = 260 AND title = 'Sette canzonette veneziane'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 19366 AND composer_id = 301 AND title = '2개의 라틴어 모테트 Op. 235'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19721 AND composer_id = 205 AND title = 'Jesu, wijs en wondermachtig'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 19780 AND composer_id = 341 AND title = '4개의 세파르디 노래'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 19791 AND composer_id = 263 AND title = 'Chansons de mer Op. 75'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23112 AND composer_id = 366 AND title = 'Ave, o Vergine Sposa'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 23184 AND composer_id = 366 AND title = 'Ave Madre di Dio'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 23693 AND composer_id = 431 AND title = 'Laudate pueri Dominum'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 23721 AND composer_id = 397 AND title = 'Chansons de Bilitis Op. 39'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 23935 AND composer_id = 467 AND title = 'Haec dies quam fecit Dominus'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 24055 AND composer_id = 400 AND title = 'Le Voyage en Chine: Acte II'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 24321 AND composer_id = 423 AND title = 'Hymne pour l’inauguration d’un temple de la Liberté'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 24337 AND composer_id = 434 AND title = '오페라 <Den Iilla slavinnan> 중 "아리아"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 24381 AND composer_id = 397 AND title = '3 Chansons populaires de la Vendée'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 24918 AND composer_id = 414 AND title = 'Ave verum corpus'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 25403 AND composer_id = 353 AND title = 'Three Carols Op. 17'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 25586 AND composer_id = 467 AND title = 'Le Chant des oyseaux "Resveillez vous cueurs endormis"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 25982 AND composer_id = 467 AND title = 'Ave regina caelorum à 5'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25985 AND composer_id = 397 AND title = 'Deux Chœurs pour voix de femmes Op. 4'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 27382 AND composer_id = 16 AND title = '응답송 <Responsoria de venerabili>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27433 AND composer_id = 16 AND title = '6개의 칸초네타 Hob. XXVIa:25–30'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 27434 AND composer_id = 16 AND title = '6개의 칸초네타 Hob. XXVIa:31–36'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29189 AND composer_id = 7 AND title = '라우다테 푸에리 RV 603'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29543 AND composer_id = 23 AND title = '<Dixit Dominus> D장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29545 AND composer_id = 23 AND title = '<Beatus vir> F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29546 AND composer_id = 23 AND title = '<Laudate pueri> E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29547 AND composer_id = 23 AND title = '<Laudate pueri> G장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29552 AND composer_id = 23 AND title = '<Tantum ergo> F장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29553 AND composer_id = 23 AND title = '<Tantum ergo> G장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29689 AND composer_id = 36 AND title = '탄툼 에르고 (1824)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 29692 AND composer_id = 36 AND title = '탄툼 에르고 (1847)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 29703 AND composer_id = 36 AND title = '4중창 <Il carnevale di Venezia>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 29712 AND composer_id = 36 AND title = '3개의 실내 4중창'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 29827 AND composer_id = 38 AND title = '2개의 이탈리아 칸초네타'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 29835 AND composer_id = 38 AND title = '4중창 <Molitva> B♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 29839 AND composer_id = 38 AND title = '4중창 <Sogna chi crede d''esser felice>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 29841 AND composer_id = 38 AND title = '4중창 <Come di gloria al nome>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 30789 AND composer_id = 40 AND title = '<Veni creator> E♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 30815 AND composer_id = 40 AND title = '2개의 선율'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32280 AND composer_id = 26 AND title = '탄툼 에르고 C장조 D. 460'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32281 AND composer_id = 26 AND title = '탄툼 에르고 C장조 D. 461'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32301 AND composer_id = 26 AND title = '탄툼 에르고 B♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32303 AND composer_id = 26 AND title = '탄툼 에르고 D장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 32329 AND composer_id = 26 AND title = '남성 4중창 <Jünglingswonne>'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32535 AND composer_id = 60 AND title = '<아베 베룸> D장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32536 AND composer_id = 60 AND title = '9개의 라틴어 성가'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32574 AND composer_id = 60 AND title = '<O salutaris> B♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32578 AND composer_id = 60 AND title = '<O salutaris> A장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32580 AND composer_id = 60 AND title = '<Sub tuum> F단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32582 AND composer_id = 60 AND title = '<아베 베룸> B단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32584 AND composer_id = 60 AND title = '<O salutaris> A♭장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32585 AND composer_id = 60 AND title = '<O salutaris> E♭장조 (1875)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32586 AND composer_id = 60 AND title = '<O salutaris> E장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32587 AND composer_id = 60 AND title = '<O salutaris> E♭장조 (1884)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 32588 AND composer_id = 60 AND title = '<Pie Jesu> C단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 33034 AND composer_id = 64 AND title = 'Ave maris stella'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 33038 AND composer_id = 64 AND title = 'Ecce sacerdos magnus'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 33046 AND composer_id = 64 AND title = 'O Salutaris hostia'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 33168 AND composer_id = 107 AND title = 'Litanies à la Vierge noire, FP 82'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33178 AND composer_id = 101 AND title = 'Music to the Historical-Revolutionary Film "Zangezur"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 33251 AND composer_id = 87 AND title = '치체스터 시편'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 33365 AND composer_id = 95 AND title = 'O sacrum convivium, I/18'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE id = 33393 AND composer_id = 91 AND title = 'Oedipus der Tyrann: Act I "Gleich wissens wirs"'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 33432 AND composer_id = 110 AND title = 'Polish Christmas Carols'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE id = 33552 AND composer_id = 256 AND title = 'Cantate Domino'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 33559 AND composer_id = 259 AND title = 'O salutaris hostia'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33694 AND composer_id = 112 AND title = 'Torn Curtain (The Unused Score)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33696 AND composer_id = 112 AND title = 'The Film Scores'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33700 AND composer_id = 112 AND title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33701 AND composer_id = 112 AND title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 33856 AND composer_id = 69 AND title = 'Folksongs for Schools (Excerpts)'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE id = 33914 AND composer_id = 467 AND title = '3개의 모테트'
  AND genre IS NULL AND form_key IS NULL;
