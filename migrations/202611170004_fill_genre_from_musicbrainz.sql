-- 작곡가 화면 '기타'(갈래 없음) 줄이기 2026-11-17: MusicBrainz work(유형·편성 설명·부모 작품)로 빈 갈래·형식을 채운다.
-- 근거와 생성기: seed_pipeline/curation/piece-genre-fill-2026-11-17/(README.md, fill.py, fills.jsonl).
-- 갈래·형식이 둘 다 비어 있고 제목이 덤프 때와 같을 때만 바꾼다(이미 있는 값은 그대로, 두 번 넣어도 같다).
-- 작품 136곡. 규칙별: mb:disambiguation 130, mb:type:Symphonic poem 2, mb:type:Song 1, mb:type:Symphony 1, mb:type:Concerto 1, mb:type:Soundtrack 1
-- 갈래/형식별: piano/piano_other 30, chamber/chamber_other 28, vocal/song 21, orchestral/orchestral_other 16, vocal/choral 13, piano/organ 7, vocal/vocal_other 6, chamber/solo 6, piano/four_hands 3, orchestral/symphonic_poem 2, orchestral/dance_march 1, symphony/symphony 1, concerto/piano_concerto 1, screen/soundtrack 1

UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 268 AND composer_id = 64 AND title = '사랑의 인사'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 600 AND composer_id = 64 AND title = 'Offertoire'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 907 AND composer_id = 37 AND title = 'Aubade'
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
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 1575 AND composer_id = 108 AND title = 'KLANG – 3rd Hour: Natürliche Dauern: Nr. 5'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 1736 AND composer_id = 37 AND title = 'Aubade H. 78B'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 1955 AND composer_id = 92 AND title = 'Credo in US'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 2564 AND composer_id = 61 AND title = 'Wettspiele zu Ehren des Patroklus'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 2766 AND composer_id = 94 AND title = '5개의 왈츠'
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
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 7735 AND composer_id = 105 AND title = 'New York Skyline Melody'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 7770 AND composer_id = 105 AND title = 'Rudepoêma'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 7783 AND composer_id = 70 AND title = 'Walt Whitman'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 7901 AND composer_id = 70 AND title = 'Ah, Come, Fair Mistress'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 8093 AND composer_id = 70 AND title = 'Not a Sound But Echoing in Me'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 8260 AND composer_id = 105 AND title = '카프리치오'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 8273 AND composer_id = 105 AND title = 'Marquesa de Santos'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 8435 AND composer_id = 105 AND title = 'Danças características africanas'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 8520 AND composer_id = 105 AND title = 'Sonhar'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 8577 AND composer_id = 63 AND title = 'Moscovienne'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 8864 AND composer_id = 70 AND title = 'Twin Stars Aloft'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 8883 AND composer_id = 70 AND title = 'Sing Heigh-Ho!'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 9074 AND composer_id = 66 AND title = 'To Nellie'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 9137 AND composer_id = 104 AND title = 'Říkadla, JW V/16'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 9372 AND composer_id = 69 AND title = '영웅적 엘레지와 승리의 에필로그'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 9434 AND composer_id = 70 AND title = 'The Day of the Lord'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 9445 AND composer_id = 70 AND title = 'Not Unto Us, O Lord'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 9579 AND composer_id = 104 AND title = 'Skladby JW 8/7'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 9602 AND composer_id = 62 AND title = 'Le roman d’Arlequin'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 9825 AND composer_id = 70 AND title = 'Airly Beacon'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 9968 AND composer_id = 70 AND title = 'Whether We Die or Live'
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
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 10387 AND composer_id = 70 AND title = 'The Kiss'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 10441 AND composer_id = 70 AND title = 'I Scanned Her Picture'
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
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 10605 AND composer_id = 70 AND title = 'My Joy'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 10658 AND composer_id = 105 AND title = 'Canções de cordialidade'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 10673 AND composer_id = 105 AND title = 'Uirapurú'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 10875 AND composer_id = 70 AND title = 'Draw Not Away Thy Hands'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 10922 AND composer_id = 70 AND title = 'Maya'
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
UPDATE pieces SET genre = 'piano', form_key = 'four_hands'
WHERE id = 11100 AND composer_id = 109 AND title = 'Touch'
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
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE id = 15758 AND composer_id = 282 AND title = '샤콘 C♯단조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 15811 AND composer_id = 204 AND title = 'Paisaje cubano con lluvia'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 16722 AND composer_id = 341 AND title = '두란다르테의 로망스'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16750 AND composer_id = 252 AND title = 'Canonical Form'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16757 AND composer_id = 252 AND title = 'Tableaux'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 16787 AND composer_id = 278 AND title = 'Lost Sounds II'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 16890 AND composer_id = 307 AND title = 'Quasi bolero'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 17515 AND composer_id = 225 AND title = 'Polveri laterali'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE id = 17725 AND composer_id = 239 AND title = '12 Seguidillas'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 17968 AND composer_id = 252 AND title = 'Partitions'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 18033 AND composer_id = 252 AND title = 'Post-Partitions'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 18193 AND composer_id = 162 AND title = 'Rooms of Elsinore'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE id = 18285 AND composer_id = 252 AND title = 'Lagniappe'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 18776 AND composer_id = 301 AND title = 'An Orkney Wedding, with Sunrise'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE id = 19080 AND composer_id = 139 AND title = 'My Love Is Mine'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE id = 19239 AND composer_id = 162 AND title = 'Confessio'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 19815 AND composer_id = 301 AND title = 'Midhouse Air'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'four_hands'
WHERE id = 23123 AND composer_id = 441 AND title = 'Hallelujah Junction'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 23210 AND composer_id = 430 AND title = 'Chant corse'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 23384 AND composer_id = 418 AND title = 'Il paesaggio'
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
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 24558 AND composer_id = 418 AND title = 'Sormin soitti Väinämöinen'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 25027 AND composer_id = 468 AND title = 'Salmo IX°'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 25161 AND composer_id = 359 AND title = 'Laulu maasta'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 25663 AND composer_id = 359 AND title = 'Hiljaisuus'
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
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE id = 32904 AND composer_id = 105 AND title = 'Bachianas Brasileiras nº 9'
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
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE id = 33000 AND composer_id = 100 AND title = 'Trois petites pièces montées'
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
UPDATE pieces SET genre = 'concerto', form_key = 'piano_concerto'
WHERE id = 33656 AND composer_id = 111 AND title = '피아노 협주곡 C장조'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'
WHERE id = 33687 AND composer_id = 112 AND title = '서곡'
  AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 33690 AND composer_id = 112 AND title = 'Vertigo Suite'
  AND genre IS NULL AND form_key IS NULL;
