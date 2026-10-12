-- Nicolas Gombert 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 86개(묶음 0, 다악장 1, 낱곡 85),
-- 새 작품 1개, part 6개, 그 아래 0개.
-- seed 89개 중 85개를 작품·part 에 잇고, 1개를 숨기고, 3개는 그대로 둔다.
--
-- 4차는 사람·에이전트 판단 없이 규칙으로 만들었다. 자료와 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/(auto_catalog.py, <작곡가>/catalog.json·seed_map.json).
--   작품: MusicBrainz 에서 이 작곡가가 composer 인 work 중 다른 work 의 part 가 아니고 편곡·다른 판·
--     발췌·단편·리믹스 표시가 없는 것. part 는 MB parts 순서대로 두 겹까지.
--   제목: 「Symphony no. 5 in C minor」 꼴은 「교향곡 5번 C단조」로 옮기고, 못 읽으면 원제를 둔다
--     (MB 갈래가 가곡·오페라 등이면 「가곡 <원제>」).
--   seed 작품: MBID 가 작품이면 그 자리(제목을 위 꼴로 고치고 잠금), part 면 part 로 잇고,
--     편곡·다른 판·중복·리믹스면 hidden_reason='catalog_unmatched' 로 숨긴다(지우지 않음).
--     판단이 서지 않는 seed 는 손대지 않고 보이게 둔다. 숨길 seed 가 카탈로그 제목을 쥐고 있으면
--     그 seed 제목 뒤에 까닭을 붙여 자리를 비운다(숨긴 작품이라 목록에 안 보임).
--   manual 작품: 제목·설명·링크는 바꾸지 않는다. MBID 가 엉뚱한 work 를 가리키면(제목이 전혀 다름)
--     잇지 않고, MBID 가 없으면 영어 제목이 같은 작품에 잇는다(식별자는 더하지 않음).
--   비교 구간이 있거나 part 가 가리키는 작품은 숨기지 않는다. 두 번 돌려도 같다.

-- None A quoy tient il à 4

UPDATE pieces piece
SET piece.title = 'A quoy tient il à 4', piece.title_en = 'A quoy tient il à 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24885 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Adonai, Domine Jesu Christe

UPDATE pieces piece
SET piece.title = 'Adonai, Domine Jesu Christe', piece.title_en = 'Adonai, Domine Jesu Christe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25721 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Amy souffrez>

UPDATE pieces piece
SET piece.title = '가곡 <Amy souffrez>', piece.title_en = 'Amy souffrez',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25024 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Angelus Domini ad pastores

UPDATE pieces piece
SET piece.title = 'Angelus Domini ad pastores', piece.title_en = 'Angelus Domini ad pastores',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25190 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aspice Domine à 4

UPDATE pieces piece
SET piece.title = 'Aspice Domine à 4', piece.title_en = 'Aspice Domine à 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23940 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Ave mater matris Dei>

UPDATE pieces piece
SET piece.title = '모테트 <Ave mater matris Dei>', piece.title_en = 'Ave mater matris Dei',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23857 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ave regina caelorum à 5

UPDATE pieces piece
SET piece.title = 'Ave regina caelorum à 5', piece.title_en = 'Ave regina caelorum à 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25982 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Ave salus mundi>

UPDATE pieces piece
SET piece.title = '모테트 <Ave salus mundi>', piece.title_en = 'Ave salus mundi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24049 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Beatus vir qui non abiit>

UPDATE pieces piece
SET piece.title = '모테트 <Beatus vir qui non abiit>', piece.title_en = 'Beatus vir qui non abiit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25376 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Benedicta es caelorum regina>

UPDATE pieces piece
SET piece.title = '모테트 <Benedicta es caelorum regina>', piece.title_en = 'Benedicta es caelorum regina',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23917 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Conceptio tua Dei genitrix>

UPDATE pieces piece
SET piece.title = '모테트 <Conceptio tua Dei genitrix>', piece.title_en = 'Conceptio tua Dei genitrix',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23977 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Credo

UPDATE pieces piece
SET piece.title = 'Credo', piece.title_en = 'Credo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23916 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Da pacem Domine>

UPDATE pieces piece
SET piece.title = '모테트 <Da pacem Domine>', piece.title_en = 'Da pacem Domine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24598 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Descendi in hortum meum>

UPDATE pieces piece
SET piece.title = '모테트 <Descendi in hortum meum>', piece.title_en = 'Descendi in hortum meum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25695 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dezilde al cavallero

UPDATE pieces piece
SET piece.title = 'Dezilde al cavallero', piece.title_en = 'Dezilde al cavallero',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25200 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Dicite in magni>

UPDATE pieces piece
SET piece.title = '모테트 <Dicite in magni>', piece.title_en = 'Dicite in magni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23516 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Domine non secundum peccata nostra>

UPDATE pieces piece
SET piece.title = '모테트 <Domine non secundum peccata nostra>', piece.title_en = 'Domine non secundum peccata nostra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24570 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Domine, si tu es

UPDATE pieces piece
SET piece.title = 'Domine, si tu es', piece.title_en = 'Domine, si tu es',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23261 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Ego flos campi>

UPDATE pieces piece
SET piece.title = '모테트 <Ego flos campi>', piece.title_en = 'Ego flos campi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25480 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Ego sum qui sum>

UPDATE pieces piece
SET piece.title = '모테트 <Ego sum qui sum>', piece.title_en = 'Ego sum qui sum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24020 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Emendemus in melius>

UPDATE pieces piece
SET piece.title = '모테트 <Emendemus in melius>', piece.title_en = 'Emendemus in melius',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23335 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None En attendant à 6

UPDATE pieces piece
SET piece.title = 'En attendant à 6', piece.title_en = 'En attendant à 6',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25727 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Epitaphium in Josquinum à Prato

UPDATE pieces piece
SET piece.title = 'Epitaphium in Josquinum à Prato', piece.title_en = 'Epitaphium in Josquinum à Prato',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25280 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Haec dies quam fecit Dominus

UPDATE pieces piece
SET piece.title = 'Haec dies quam fecit Dominus', piece.title_en = 'Haec dies quam fecit Dominus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23935 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Hodie nata est virgo Maria>

UPDATE pieces piece
SET piece.title = '모테트 <Hodie nata est virgo Maria>', piece.title_en = 'Hodie nata est virgo Maria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25566 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Homo erat

UPDATE pieces piece
SET piece.title = 'Homo erat', piece.title_en = 'Homo erat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23573 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Hortus conclusus es Dei genitrix>

UPDATE pieces piece
SET piece.title = '모테트 <Hortus conclusus es Dei genitrix>', piece.title_en = 'Hortus conclusus es Dei genitrix',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25756 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In illo tempore

UPDATE pieces piece
SET piece.title = 'In illo tempore', piece.title_en = 'In illo tempore',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24702 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <In te Domine speravi … Educes me>

UPDATE pieces piece
SET piece.title = '모테트 <In te Domine speravi … Educes me>', piece.title_en = 'In te Domine speravi … Educes me',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24470 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Je prens congie

UPDATE pieces piece
SET piece.title = 'Je prens congie', piece.title_en = 'Je prens congie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24747 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La chasse au lièvre>

UPDATE pieces piece
SET piece.title = '가곡 <La chasse au lièvre>', piece.title_en = 'La chasse au lièvre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24621 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La rose (Chanson)

UPDATE pieces piece
SET piece.title = 'La rose (Chanson)', piece.title_en = 'La rose (Chanson)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23391 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Laus Deo, pax vivis

UPDATE pieces piece
SET piece.title = 'Laus Deo, pax vivis', piece.title_en = 'Laus Deo, pax vivis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23212 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Chant des oyseaux "Resveillez vous cueurs endormis"

UPDATE pieces piece
SET piece.title = 'Le Chant des oyseaux "Resveillez vous cueurs endormis"', piece.title_en = 'Le Chant des oyseaux "Resveillez vous cueurs endormis"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25586 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lugebat David Absalom

UPDATE pieces piece
SET piece.title = 'Lugebat David Absalom', piece.title_en = 'Lugebat David Absalom',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23344 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 마니피카트 1번

UPDATE pieces piece
SET piece.title = '마니피카트 1번', piece.title_en = 'Magnificat No. 1, Primi toni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24899 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 마니피카트 2번

UPDATE pieces piece
SET piece.title = '마니피카트 2번', piece.title_en = 'Magnificat No. 2, Secundi toni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23492 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 마니피카트 3번

UPDATE pieces piece
SET piece.title = '마니피카트 3번', piece.title_en = 'Magnificat No. 3, Tertii et octavi toni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24131 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 마니피카트 4번

UPDATE pieces piece
SET piece.title = '마니피카트 4번', piece.title_en = 'Magnificat No. 4, Quarti toni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24132 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 마니피카트 5번

UPDATE pieces piece
SET piece.title = '마니피카트 5번', piece.title_en = 'Magnificat No. 5, Quinti toni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25673 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 마니피카트 6번

UPDATE pieces piece
SET piece.title = '마니피카트 6번', piece.title_en = 'Magnificat No. 6, Sexti et primi toni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24727 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 마니피카트 7번

UPDATE pieces piece
SET piece.title = '마니피카트 7번', piece.title_en = 'Magnificat No. 7, Septimi toni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23362 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 마니피카트 8번

UPDATE pieces piece
SET piece.title = '마니피카트 8번', piece.title_en = 'Magnificat No. 8, Octavi toni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25387 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Media vita in morte sumus

UPDATE pieces piece
SET piece.title = 'Media vita in morte sumus', piece.title_en = 'Media vita in morte sumus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23092 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mille regres

UPDATE pieces piece
SET piece.title = 'Mille regres', piece.title_en = 'Mille regres',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25703 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mille regretz

UPDATE pieces piece
SET piece.title = 'Mille regretz', piece.title_en = 'Mille regretz',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23511 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Missa Tempore paschali

UPDATE pieces piece
SET piece.title = 'Missa Tempore paschali', piece.title_en = 'Missa Tempore paschali',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24874 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kyrie', part.name_en = 'Missa Tempore paschali: I. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24874 AND p.composer_id = 467 AND part.part_key = 'musicbrainz:36d7630e-3aee-4a65-aa60-d649200fac53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36d7630e-3aee-4a65-aa60-d649200fac53', 1, 'I', 'Kyrie', 'Missa Tempore paschali: I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24874 AND p.composer_id = 467
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36d7630e-3aee-4a65-aa60-d649200fac53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gloria', part.name_en = 'Missa Tempore paschali: II. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24874 AND p.composer_id = 467 AND part.part_key = 'musicbrainz:5923b816-ae1f-4828-a0ba-5c90f45a078b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5923b816-ae1f-4828-a0ba-5c90f45a078b', 2, 'II', 'Gloria', 'Missa Tempore paschali: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24874 AND p.composer_id = 467
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5923b816-ae1f-4828-a0ba-5c90f45a078b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Credo', part.name_en = 'Missa Tempore paschali: III. Credo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24874 AND p.composer_id = 467 AND part.part_key = 'musicbrainz:db653ed8-f24b-469f-b37d-d99906a28d33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db653ed8-f24b-469f-b37d-d99906a28d33', 3, 'III', 'Credo', 'Missa Tempore paschali: III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24874 AND p.composer_id = 467
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db653ed8-f24b-469f-b37d-d99906a28d33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sanctus', part.name_en = 'Missa Tempore paschali: IV. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24874 AND p.composer_id = 467 AND part.part_key = 'musicbrainz:af82e08f-788e-41fb-8965-61a7c352a5bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af82e08f-788e-41fb-8965-61a7c352a5bb', 4, 'IV', 'Sanctus', 'Missa Tempore paschali: IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24874 AND p.composer_id = 467
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af82e08f-788e-41fb-8965-61a7c352a5bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Benedictus', part.name_en = 'Missa Tempore paschali: V. Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24874 AND p.composer_id = 467 AND part.part_key = 'musicbrainz:83149195-14b1-4569-b9ba-a228d1d8bda3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83149195-14b1-4569-b9ba-a228d1d8bda3', 5, 'V', 'Benedictus', 'Missa Tempore paschali: V. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24874 AND p.composer_id = 467
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83149195-14b1-4569-b9ba-a228d1d8bda3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Agnus Dei', part.name_en = 'Missa Tempore paschali: VI. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24874 AND p.composer_id = 467 AND part.part_key = 'musicbrainz:6cab45fd-a712-4849-81df-c6b711f5262b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cab45fd-a712-4849-81df-c6b711f5262b', 6, 'VI', 'Agnus Dei', 'Missa Tempore paschali: VI. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24874 AND p.composer_id = 467
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cab45fd-a712-4849-81df-c6b711f5262b'
);


-- None Mon seul a 7

UPDATE pieces piece
SET piece.title = 'Mon seul a 7', piece.title_en = 'Mon seul a 7',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25938 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mort et fortune à 4

UPDATE pieces piece
SET piece.title = 'Mort et fortune à 4', piece.title_en = 'Mort et fortune à 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25613 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Musae Jovis á 6

UPDATE pieces piece
SET piece.title = 'Musae Jovis á 6', piece.title_en = 'Musae Jovis á 6',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25078 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Ne reminiscaris Domine>

UPDATE pieces piece
SET piece.title = '모테트 <Ne reminiscaris Domine>', piece.title_en = 'Ne reminiscaris Domine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23447 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <O Domine Jesu Christe>

UPDATE pieces piece
SET piece.title = '모테트 <O Domine Jesu Christe>', piece.title_en = 'O Domine Jesu Christe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24642 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O Gloriosa Domina

UPDATE pieces piece
SET piece.title = 'O Gloriosa Domina', piece.title_en = 'O Gloriosa Domina',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25817 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <O Jesu Christe>

UPDATE pieces piece
SET piece.title = '모테트 <O Jesu Christe>', piece.title_en = 'O Jesu Christe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23538 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O beata Maria

UPDATE pieces piece
SET piece.title = 'O beata Maria', piece.title_en = 'O beata Maria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23491 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <O crux splendidior>

UPDATE pieces piece
SET piece.title = '모테트 <O crux splendidior>', piece.title_en = 'O crux splendidior',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25173 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <O domina mundi>

UPDATE pieces piece
SET piece.title = '모테트 <O domina mundi>', piece.title_en = 'O domina mundi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25134 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O flos campi

UPDATE pieces piece
SET piece.title = 'O flos campi', piece.title_en = 'O flos campi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23600 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O gloriosa Dei genitrix à 4

UPDATE pieces piece
SET piece.title = 'O gloriosa Dei genitrix à 4', piece.title_en = 'O gloriosa Dei genitrix à 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24230 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O malheureuse journee à 5

UPDATE pieces piece
SET piece.title = 'O malheureuse journee à 5', piece.title_en = 'O malheureuse journee à 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23848 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O rex gloriae

UPDATE pieces piece
SET piece.title = 'O rex gloriae', piece.title_en = 'O rex gloriae',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25049 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Or suis je prins à 4

UPDATE pieces piece
SET piece.title = 'Or suis je prins à 4', piece.title_en = 'Or suis je prins à 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23354 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Par un regard à 3

UPDATE pieces piece
SET piece.title = 'Par un regard à 3', piece.title_en = 'Par un regard à 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24026 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Patefactae sunt januae caeli>

UPDATE pieces piece
SET piece.title = '모테트 <Patefactae sunt januae caeli>', piece.title_en = 'Patefactae sunt januae caeli',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25753 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Peccata mea sicut sagittae>

UPDATE pieces piece
SET piece.title = '모테트 <Peccata mea sicut sagittae>', piece.title_en = 'Peccata mea sicut sagittae',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24194 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Plaisir n'ay plus que vivre en desconfort

UPDATE pieces piece
SET piece.title = 'Plaisir n''ay plus que vivre en desconfort', piece.title_en = 'Plaisir n''ay plus que vivre en desconfort',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23655 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pleust a Dieu à 3

UPDATE pieces piece
SET piece.title = 'Pleust a Dieu à 3', piece.title_en = 'Pleust a Dieu à 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24843 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quam pulchra es

UPDATE pieces piece
SET piece.title = 'Quam pulchra es', piece.title_en = 'Quam pulchra es',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23501 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Quant ie suis prez de m'amye>

UPDATE pieces piece
SET piece.title = '가곡 <Quant ie suis prez de m''amye>', piece.title_en = 'Quant ie suis prez de m''amye',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23444 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Qui colis Ausoniam

UPDATE pieces piece
SET piece.title = 'Qui colis Ausoniam', piece.title_en = 'Qui colis Ausoniam',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23581 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Regina Caeli, motet à 12

UPDATE pieces piece
SET piece.title = 'Regina Caeli, motet à 12', piece.title_en = 'Regina Caeli, motet à 12',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24612 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Respice Domine>

UPDATE pieces piece
SET piece.title = '모테트 <Respice Domine>', piece.title_en = 'Respice Domine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25927 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Salve Regina "Diversi diversa orant"

UPDATE pieces piece
SET piece.title = 'Salve Regina "Diversi diversa orant"', piece.title_en = 'Salve Regina "Diversi diversa orant"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24363 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Sancta Maria mater Dei>

UPDATE pieces piece
SET piece.title = '모테트 <Sancta Maria mater Dei>', piece.title_en = 'Sancta Maria mater Dei',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25456 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Sancta et immaculata>

UPDATE pieces piece
SET piece.title = '모테트 <Sancta et immaculata>', piece.title_en = 'Sancta et immaculata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23221 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Si bona suscepimus>

UPDATE pieces piece
SET piece.title = '모테트 <Si bona suscepimus>', piece.title_en = 'Si bona suscepimus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23756 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Si ignoras te o pulchra>

UPDATE pieces piece
SET piece.title = '모테트 <Si ignoras te o pulchra>', piece.title_en = 'Si ignoras te o pulchra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24603 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Suscipe verbum virgo Maria>

UPDATE pieces piece
SET piece.title = '모테트 <Suscipe verbum virgo Maria>', piece.title_en = 'Suscipe verbum virgo Maria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24687 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Tribulatio cordis mei>

UPDATE pieces piece
SET piece.title = '모테트 <Tribulatio cordis mei>', piece.title_en = 'Tribulatio cordis mei',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25454 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tribulatione et angustia

UPDATE pieces piece
SET piece.title = 'Tribulatione et angustia', piece.title_en = 'Tribulatione et angustia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24390 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Triste depart à 5

UPDATE pieces piece
SET piece.title = 'Triste depart à 5', piece.title_en = 'Triste depart à 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25460 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tulerunt Dominum meum

UPDATE pieces piece
SET piece.title = 'Tulerunt Dominum meum', piece.title_en = 'Tulerunt Dominum meum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25391 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vae, vae Babylon

UPDATE pieces piece
SET piece.title = 'Vae, vae Babylon', piece.title_en = 'Vae, vae Babylon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23463 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Veni dilecta mea>

UPDATE pieces piece
SET piece.title = '모테트 <Veni dilecta mea>', piece.title_en = 'Veni dilecta mea',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24881 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Veni electa mea

UPDATE pieces piece
SET piece.title = 'Veni electa mea', piece.title_en = 'Veni electa mea',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24829 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Super flumina Babylonis

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Super flumina Babylonis', 'Super flumina Babylonis', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 467
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Super flumina Babylonis'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e17e222b-d7e9-434f-8238-fb32e309a582'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e17e222b-d7e9-434f-8238-fb32e309a582'
FROM pieces p
WHERE p.composer_id = 467 AND p.title = 'Super flumina Babylonis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e17e222b-d7e9-434f-8238-fb32e309a582'
);


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 467 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    25884
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
