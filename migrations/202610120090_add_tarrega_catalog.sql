-- 타레가 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 71개(묶음 0, 다악장 0, 낱곡 71),
-- 새 작품 1개, part 0개, 그 아래 0개.
-- seed 76개 중 69개를 작품·part 에 잇고, 7개를 숨기고, 0개는 그대로 둔다.
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

-- 숨길 seed 가 쥔 카탈로그 제목을 비운다
UPDATE pieces piece
SET piece.title = 'Capricho árabe (중복 7539)'
WHERE piece.id = 7539 AND piece.composer_id = 75 AND piece.title = 'Capricho árabe'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None Adelita (mazurka)

UPDATE pieces piece
SET piece.title = 'Adelita (mazurka)', piece.title_en = 'Adelita (mazurka)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7468 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Alborada

UPDATE pieces piece
SET piece.title = 'Alborada', piece.title_en = 'Alborada',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10295 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Danza Odalisca

UPDATE pieces piece
SET piece.title = 'Danza Odalisca', piece.title_en = 'Danza Odalisca',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11173 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Danza mora

UPDATE pieces piece
SET piece.title = 'Danza mora', piece.title_en = 'Danza mora',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11182 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None El columpio

UPDATE pieces piece
SET piece.title = 'El columpio', piece.title_en = 'El columpio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10203 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 1번

UPDATE pieces piece
SET piece.title = '연습곡 1번', piece.title_en = 'Etude for guitar no. 1 en forma de minuetto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10338 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 10번 "Petit Menuet"

UPDATE pieces piece
SET piece.title = '연습곡 10번 "Petit Menuet"', piece.title_en = 'Etude for guitar no. 10 "Petit Menuet"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9488 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 11번 D장조

UPDATE pieces piece
SET piece.title = '연습곡 11번 D장조', piece.title_en = 'Etude for guitar no. 11 in D major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10101 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 12번 C장조

UPDATE pieces piece
SET piece.title = '연습곡 12번 C장조', piece.title_en = 'Etude for guitar no. 12 in C major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7968 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 13번 A장조

UPDATE pieces piece
SET piece.title = '연습곡 13번 A장조', piece.title_en = 'Etude for guitar no. 13 in A major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9827 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 14번 "La mariposa"

UPDATE pieces piece
SET piece.title = '연습곡 14번 "La mariposa"', piece.title_en = 'Etude for guitar no. 14 "La mariposa"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9842 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 15번

UPDATE pieces piece
SET piece.title = '연습곡 15번', piece.title_en = 'Etude for guitar no. 15, sobre un tema de Wagner',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8569 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 16번

UPDATE pieces piece
SET piece.title = '연습곡 16번', piece.title_en = 'Etude for guitar no. 16, inspirado en J. B. Cramer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10592 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 17번

UPDATE pieces piece
SET piece.title = '연습곡 17번', piece.title_en = 'Etude for guitar no. 17, sobre un tema de Mendelssohn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10288 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 18번 A장조

UPDATE pieces piece
SET piece.title = '연습곡 18번 A장조', piece.title_en = 'Etude for guitar no. 18 in A major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9562 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 19번 E단조

UPDATE pieces piece
SET piece.title = '연습곡 19번 E단조', piece.title_en = 'Etude for guitar no. 19 in E minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7962 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 2번

UPDATE pieces piece
SET piece.title = '연습곡 2번', piece.title_en = 'Etude for guitar no. 2 de velocidad',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11162 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 20번 "Estudio brillante de Alard"

UPDATE pieces piece
SET piece.title = '연습곡 20번 "Estudio brillante de Alard"', piece.title_en = 'Etude for guitar no. 20 "Estudio brillante de Alard"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8281 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 3번 G장조

UPDATE pieces piece
SET piece.title = '연습곡 3번 G장조', piece.title_en = 'Etude for guitar no. 3 in G major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11041 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 4번 B단조

UPDATE pieces piece
SET piece.title = '연습곡 4번 B단조', piece.title_en = 'Etude for guitar no. 4 in B minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8992 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 5번 A장조

UPDATE pieces piece
SET piece.title = '연습곡 5번 A장조', piece.title_en = 'Etude for guitar no. 5 in A major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9341 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 6번 A장조

UPDATE pieces piece
SET piece.title = '연습곡 6번 A장조', piece.title_en = 'Etude for guitar no. 6 in A major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9948 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 7번 A장조

UPDATE pieces piece
SET piece.title = '연습곡 7번 A장조', piece.title_en = 'Etude for guitar no. 7 in A major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9276 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 8번 A단조

UPDATE pieces piece
SET piece.title = '연습곡 8번 A단조', piece.title_en = 'Etude for guitar no. 8 in A minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8081 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 9번 E장조

UPDATE pieces piece
SET piece.title = '연습곡 9번 E장조', piece.title_en = 'Etude for guitar no. 9 in E major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10988 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 A

UPDATE pieces piece
SET piece.title = '연습곡 A', piece.title_en = 'Etude in A',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10302 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gran vals

UPDATE pieces piece
SET piece.title = 'Gran vals', piece.title_en = 'Gran vals',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7630 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Habanera en sol menor

UPDATE pieces piece
SET piece.title = 'Habanera en sol menor', piece.title_en = 'Habanera en sol menor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11282 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Isabel (vals)

UPDATE pieces piece
SET piece.title = 'Isabel (vals)', piece.title_en = 'Isabel (vals)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9343 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La cartagenera

UPDATE pieces piece
SET piece.title = 'La cartagenera', piece.title_en = 'La cartagenera',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11053 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Las dos hermanitas (vals)

UPDATE pieces piece
SET piece.title = 'Las dos hermanitas (vals)', piece.title_en = 'Las dos hermanitas (vals)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8895 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Malagueña

UPDATE pieces piece
SET piece.title = 'Malagueña', piece.title_en = 'Malagueña',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11128 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Marieta (mazurka)

UPDATE pieces piece
SET piece.title = 'Marieta (mazurka)', piece.title_en = 'Marieta (mazurka)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7476 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Marzurka para dos guitarras

UPDATE pieces piece
SET piece.title = 'Marzurka para dos guitarras', piece.title_en = 'Marzurka para dos guitarras',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11163 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None María (gavota)

UPDATE pieces piece
SET piece.title = 'María (gavota)', piece.title_en = 'María (gavota)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10189 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mazurka en Sol

UPDATE pieces piece
SET piece.title = 'Mazurka en Sol', piece.title_en = 'Mazurka en Sol',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7572 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Minueto

UPDATE pieces piece
SET piece.title = 'Minueto', piece.title_en = 'Minueto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10109 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paquito (vals en do)

UPDATE pieces piece
SET piece.title = 'Paquito (vals en do)', piece.title_en = 'Paquito (vals en do)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9107 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pavana

UPDATE pieces piece
SET piece.title = 'Pavana', piece.title_en = 'Pavana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9462 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pepita (polka)

UPDATE pieces piece
SET piece.title = 'Pepita (polka)', piece.title_en = 'Pepita (polka)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7823 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 18번 D단조

UPDATE pieces piece
SET piece.title = '전주곡 18번 D단조', piece.title_en = 'Prelude for Guitar no. 18 in D minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10358 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 1번 D단조

UPDATE pieces piece
SET piece.title = '전주곡 1번 D단조', piece.title_en = 'Prelude for guitar no. 1 in D minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8033 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 1번 E장조

UPDATE pieces piece
SET piece.title = '전주곡 1번 E장조', piece.title_en = 'Prelude for guitar no. 1 in E major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9872 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 10번 D "Oremus"

UPDATE pieces piece
SET piece.title = '전주곡 10번 D "Oremus"', piece.title_en = 'Prelude for guitar no. 10 in D- "Oremus"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10720 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 11번 D

UPDATE pieces piece
SET piece.title = '전주곡 11번 D', piece.title_en = 'Prelude for guitar no. 11 in D',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10606 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 11번 D장조

UPDATE pieces piece
SET piece.title = '전주곡 11번 D장조', piece.title_en = 'Prelude for guitar no. 11 in D major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10975 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 12번 D

UPDATE pieces piece
SET piece.title = '전주곡 12번 D', piece.title_en = 'Prelude for guitar no. 12 in D',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7824 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 13번 E

UPDATE pieces piece
SET piece.title = '전주곡 13번 E', piece.title_en = 'Prelude for guitar no. 13 in E',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10571 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 14번 A단조

UPDATE pieces piece
SET piece.title = '전주곡 14번 A단조', piece.title_en = 'Prelude for guitar no. 14 in A minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7857 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 15번 A단조

UPDATE pieces piece
SET piece.title = '전주곡 15번 A단조', piece.title_en = 'Prelude for guitar no. 15 in A minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8831 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 16번 E

UPDATE pieces piece
SET piece.title = '전주곡 16번 E', piece.title_en = 'Prelude for guitar no. 16 in E',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8527 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 2번 A단조

UPDATE pieces piece
SET piece.title = '전주곡 2번 A단조', piece.title_en = 'Prelude for guitar no. 2 in A minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7596 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 3번 A단조

UPDATE pieces piece
SET piece.title = '전주곡 3번 A단조', piece.title_en = 'Prelude for guitar no. 3 in A minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8692 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 4번 B단조

UPDATE pieces piece
SET piece.title = '전주곡 4번 B단조', piece.title_en = 'Prelude for guitar no. 4 in B minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10578 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 5번 E장조

UPDATE pieces piece
SET piece.title = '전주곡 5번 E장조', piece.title_en = 'Prelude for guitar no. 5 in E major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7570 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 5번 G

UPDATE pieces piece
SET piece.title = '전주곡 5번 G', piece.title_en = 'Prelude for guitar no. 5 in G',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9666 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 6번 D단조

UPDATE pieces piece
SET piece.title = '전주곡 6번 D단조', piece.title_en = 'Prelude for guitar no. 6 in D minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10568 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 7번 G

UPDATE pieces piece
SET piece.title = '전주곡 7번 G', piece.title_en = 'Prelude for guitar no. 7 in G',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10435 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 8번 A "Lágrima"

UPDATE pieces piece
SET piece.title = '전주곡 8번 A "Lágrima"', piece.title_en = 'Prelude for guitar no. 8 in A- "Lágrima"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7551 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 9번 D "Endecha"

UPDATE pieces piece
SET piece.title = '전주곡 9번 D "Endecha"', piece.title_en = 'Prelude for guitar no. 9 in D- "Endecha"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11106 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 A단조

UPDATE pieces piece
SET piece.title = '전주곡 A단조', piece.title_en = 'Prelude in A minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10797 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 F♯단조

UPDATE pieces piece
SET piece.title = '전주곡 F♯단조', piece.title_en = 'Preludio in F-sharp minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10757 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rosita (polka)

UPDATE pieces piece
SET piece.title = 'Rosita (polka)', piece.title_en = 'Rosita (polka)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8117 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sueño (trémolo)

UPDATE pieces piece
SET piece.title = 'Sueño (trémolo)', piece.title_en = 'Sueño (trémolo)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9154 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 탱고

UPDATE pieces piece
SET piece.title = '탱고', piece.title_en = 'Tango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10272 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vals (en re)

UPDATE pieces piece
SET piece.title = 'Vals (en re)', piece.title_en = 'Vals (en re)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7867 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vals para dos guitarras

UPDATE pieces piece
SET piece.title = 'Vals para dos guitarras', piece.title_en = 'Vals para dos guitarras',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11253 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variaciones sobre "El carnaval de Venecia"

UPDATE pieces piece
SET piece.title = 'Variaciones sobre "El carnaval de Venecia"', piece.title_en = 'Variaciones sobre "El carnaval de Venecia"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7564 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Waltzing Memories>

UPDATE pieces piece
SET piece.title = '가곡 <Waltzing Memories>', piece.title_en = 'Waltzing Memories',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9799 AND piece.composer_id = 75
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gran jota

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Gran jota', 'Gran jota', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 75
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Gran jota'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5fd9403a-6dff-4359-8056-045857168eaf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5fd9403a-6dff-4359-8056-045857168eaf'
FROM pieces p
WHERE p.composer_id = 75 AND p.title = 'Gran jota' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5fd9403a-6dff-4359-8056-045857168eaf'
);


-- 카탈로그에 대응이 없는 seed 작품 7개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 75 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    7467, 7539, 7703, 7789, 9954, 10727, 11199
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
