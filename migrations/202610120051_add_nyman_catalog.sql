-- 마이클 나이먼 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 261개(묶음 10, 다악장 8, 낱곡 243),
-- 새 작품 30개, part 147개, 그 아래 0개.
-- seed 335개 중 231개를 작품·part 에 잇고, 30개를 숨기고, 74개는 그대로 둔다.
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
SET piece.title = 'Exit No Exit (Part 1) (중복 16497)'
WHERE piece.id = 16497 AND piece.composer_id = 280 AND piece.title = 'Exit No Exit (Part 1)'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

UPDATE pieces piece
SET piece.title = 'Trysting Fields (편곡 23104)'
WHERE piece.id = 23104 AND piece.composer_id = 280 AND piece.title = 'Trysting Fields'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None 1-100

UPDATE pieces piece
SET piece.title = '1-100', piece.title_en = '1-100',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17916 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 3개의 4중주

UPDATE pieces piece
SET piece.title = '3개의 4중주', piece.title_en = '3 Quartets',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16335 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Borrowed Ladder

UPDATE pieces piece
SET piece.title = 'A Borrowed Ladder', piece.title_en = 'A Borrowed Ladder',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17960 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Neat Slice of Tango

UPDATE pieces piece
SET piece.title = 'A Neat Slice of Tango', piece.title_en = 'A Neat Slice of Tango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18322 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Sixth Part of the World 1

UPDATE pieces piece
SET piece.title = 'A Sixth Part of the World 1', piece.title_en = 'A Sixth Part of the World 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16545 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Sixth Part of the World 2

UPDATE pieces piece
SET piece.title = 'A Sixth Part of the World 2', piece.title_en = 'A Sixth Part of the World 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18078 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Sixth Part of the World 3

UPDATE pieces piece
SET piece.title = 'A Sixth Part of the World 3', piece.title_en = 'A Sixth Part of the World 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18501 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Sixth Part of the World 4

UPDATE pieces piece
SET piece.title = 'A Sixth Part of the World 4', piece.title_en = 'A Sixth Part of the World 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18439 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Sixth Part of the World 5

UPDATE pieces piece
SET piece.title = 'A Sixth Part of the World 5', piece.title_en = 'A Sixth Part of the World 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17783 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Swift Exit

UPDATE pieces piece
SET piece.title = 'A Swift Exit', piece.title_en = 'A Swift Exit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16979 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Walk Through H

UPDATE pieces piece
SET piece.title = 'A Walk Through H', piece.title_en = 'A Walk Through H',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17811 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Watery Death

UPDATE pieces piece
SET piece.title = 'A Watery Death', piece.title_en = 'A Watery Death',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17838 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A la Pensee des Absents

UPDATE pieces piece
SET piece.title = 'A la Pensee des Absents', piece.title_en = 'A la Pensee des Absents',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19352 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Abel's Revolt

UPDATE pieces piece
SET piece.title = 'Abel''s Revolt', piece.title_en = 'Abel''s Revolt',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19743 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ach! Tea from China, Lovely Fragrance

UPDATE pieces piece
SET piece.title = 'Ach! Tea from China, Lovely Fragrance', piece.title_en = 'Ach! Tea from China, Lovely Fragrance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19216 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time I

UPDATE pieces piece
SET piece.title = 'After Extra Time I', piece.title_en = 'After Extra Time I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17098 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time II

UPDATE pieces piece
SET piece.title = 'After Extra Time II', piece.title_en = 'After Extra Time II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17865 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time III

UPDATE pieces piece
SET piece.title = 'After Extra Time III', piece.title_en = 'After Extra Time III',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18124 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time IV

UPDATE pieces piece
SET piece.title = 'After Extra Time IV', piece.title_en = 'After Extra Time IV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19485 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time IX

UPDATE pieces piece
SET piece.title = 'After Extra Time IX', piece.title_en = 'After Extra Time IX',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16837 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time V

UPDATE pieces piece
SET piece.title = 'After Extra Time V', piece.title_en = 'After Extra Time V',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19847 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time VI

UPDATE pieces piece
SET piece.title = 'After Extra Time VI', piece.title_en = 'After Extra Time VI',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19989 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time VII

UPDATE pieces piece
SET piece.title = 'After Extra Time VII', piece.title_en = 'After Extra Time VII',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17601 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time VIII

UPDATE pieces piece
SET piece.title = 'After Extra Time VIII', piece.title_en = 'After Extra Time VIII',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18232 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time X

UPDATE pieces piece
SET piece.title = 'After Extra Time X', piece.title_en = 'After Extra Time X',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17108 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time XI

UPDATE pieces piece
SET piece.title = 'After Extra Time XI', piece.title_en = 'After Extra Time XI',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19979 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time XII

UPDATE pieces piece
SET piece.title = 'After Extra Time XII', piece.title_en = 'After Extra Time XII',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17132 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time XIII

UPDATE pieces piece
SET piece.title = 'After Extra Time XIII', piece.title_en = 'After Extra Time XIII',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18380 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time XIV

UPDATE pieces piece
SET piece.title = 'After Extra Time XIV', piece.title_en = 'After Extra Time XIV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16336 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time XV

UPDATE pieces piece
SET piece.title = 'After Extra Time XV', piece.title_en = 'After Extra Time XV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16155 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None After Extra Time XVI

UPDATE pieces piece
SET piece.title = 'After Extra Time XVI', piece.title_en = 'After Extra Time XVI',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16445 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <And Do They Do>

UPDATE pieces piece
SET piece.title = '연가곡집 <And Do They Do>', piece.title_en = 'And Do They Do',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17246 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None And Yet … and Yet

UPDATE pieces piece
SET piece.title = 'And Yet … and Yet', piece.title_en = 'And Yet … and Yet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19269 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Balancing the Books

UPDATE pieces piece
SET piece.title = 'Balancing the Books', piece.title_en = 'Balancing the Books',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16278 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Becoming Jerome

UPDATE pieces piece
SET piece.title = 'Becoming Jerome', piece.title_en = 'Becoming Jerome',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17687 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bees in Trees

UPDATE pieces piece
SET piece.title = 'Bees in Trees', piece.title_en = 'Bees in Trees',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16281 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bravura in the Face of Grief

UPDATE pieces piece
SET piece.title = 'Bravura in the Face of Grief', piece.title_en = 'Bravura in the Face of Grief',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18173 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None But What of the Parietal Regions?

UPDATE pieces piece
SET piece.title = 'But What of the Parietal Regions?', piece.title_en = 'But What of the Parietal Regions?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16936 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bösendorfer!

UPDATE pieces piece
SET piece.title = 'Bösendorfer!', piece.title_en = 'Bösendorfer!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16498 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Call Me Eugene

UPDATE pieces piece
SET piece.title = 'Call Me Eugene', piece.title_en = 'Call Me Eugene',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16462 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Can I Help?

UPDATE pieces piece
SET piece.title = 'Can I Help?', piece.title_en = 'Can I Help?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17748 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Car Crash

UPDATE pieces piece
SET piece.title = 'Car Crash', piece.title_en = 'Car Crash',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18209 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Come Unto These Yellow Sands

UPDATE pieces piece
SET piece.title = 'Come Unto These Yellow Sands', piece.title_en = 'Come Unto These Yellow Sands',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19544 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 하프시코드 협주곡

UPDATE pieces piece
SET piece.title = '하프시코드 협주곡', piece.title_en = 'Concerto for Harpsichord and Strings',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16858 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Concerto for Harpsichord and Strings: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16858 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:129178ea-4156-3ce6-a6ea-896dc5bc3cdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:129178ea-4156-3ce6-a6ea-896dc5bc3cdb', 1, NULL, 'I', 'Concerto for Harpsichord and Strings: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16858 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:129178ea-4156-3ce6-a6ea-896dc5bc3cdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Concerto for Harpsichord and Strings: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16858 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:39c86acf-06f4-3de4-8fc7-03042ed94019' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39c86acf-06f4-3de4-8fc7-03042ed94019', 2, NULL, 'II', 'Concerto for Harpsichord and Strings: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16858 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39c86acf-06f4-3de4-8fc7-03042ed94019'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Concerto for Harpsichord and Strings: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16858 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:01d182d9-4102-30ed-891b-13991949af83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01d182d9-4102-30ed-891b-13991949af83', 3, NULL, 'III', 'Concerto for Harpsichord and Strings: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16858 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01d182d9-4102-30ed-891b-13991949af83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Concerto for Harpsichord and Strings: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16858 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:82f652d6-8027-3580-9d49-e0862a8dfe7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82f652d6-8027-3580-9d49-e0862a8dfe7b', 4, NULL, 'IV', 'Concerto for Harpsichord and Strings: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16858 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82f652d6-8027-3580-9d49-e0862a8dfe7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Concerto for Harpsichord and Strings: V.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16858 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:abc79e22-7ae9-3082-80ed-fa16f5b30608' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abc79e22-7ae9-3082-80ed-fa16f5b30608', 5, NULL, 'V', 'Concerto for Harpsichord and Strings: V.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16858 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abc79e22-7ae9-3082-80ed-fa16f5b30608'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'Concerto for Harpsichord and Strings: VI.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16858 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:2cd23dd2-f4eb-39a7-980b-0930427e5d7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cd23dd2-f4eb-39a7-980b-0930427e5d7b', 6, NULL, 'VI', 'Concerto for Harpsichord and Strings: VI.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16858 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cd23dd2-f4eb-39a7-980b-0930427e5d7b'
);


-- None Contract on the Draughtsman

UPDATE pieces piece
SET piece.title = 'Contract on the Draughtsman', piece.title_en = 'Contract on the Draughtsman',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18169 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Convening the Coven

UPDATE pieces piece
SET piece.title = 'Convening the Coven', piece.title_en = 'Convening the Coven',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18281 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Crematorium Conspiracy

UPDATE pieces piece
SET piece.title = 'Crematorium Conspiracy', piece.title_en = 'Crematorium Conspiracy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18247 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dead Man's Catch

UPDATE pieces piece
SET piece.title = 'Dead Man''s Catch', piece.title_en = 'Dead Man''s Catch',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18364 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Decomposing by the Numbers

UPDATE pieces piece
SET piece.title = 'Decomposing by the Numbers', piece.title_en = 'Decomposing by the Numbers',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18168 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Diary of Hate

UPDATE pieces piece
SET piece.title = 'Diary of Hate', piece.title_en = 'Diary of Hate',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15901 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Diary of Love

UPDATE pieces piece
SET piece.title = 'Diary of Love', piece.title_en = 'Diary of Love',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16202 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Disaster

UPDATE pieces piece
SET piece.title = 'Disaster', piece.title_en = 'Disaster',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17719 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dreaming of Home

UPDATE pieces piece
SET piece.title = 'Dreaming of Home', piece.title_en = 'Dreaming of Home',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19127 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Drowning by Number 3

UPDATE pieces piece
SET piece.title = 'Drowning by Number 3', piece.title_en = 'Drowning by Number 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16117 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Due figliuole di un contadino

UPDATE pieces piece
SET piece.title = 'Due figliuole di un contadino', piece.title_en = 'Due figliuole di un contadino',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20006 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Earth in Turmoil

UPDATE pieces piece
SET piece.title = 'Earth in Turmoil', piece.title_en = 'Earth in Turmoil',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16613 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Endgame

UPDATE pieces piece
SET piece.title = 'Endgame', piece.title_en = 'Endgame',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15895 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Exit No Exit (Part 1)

UPDATE pieces piece
SET piece.title = 'Exit No Exit (Part 1)', piece.title_en = 'Exit No Exit (Part 1)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16404 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Family Reflections

UPDATE pieces piece
SET piece.title = 'Family Reflections', piece.title_en = 'Family Reflections',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17014 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Fish Beach>

UPDATE pieces piece
SET piece.title = '가곡 <Fish Beach>', piece.title_en = 'Fish Beach',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19753 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Five Orchestral Pieces for Opus Tree

UPDATE pieces piece
SET piece.title = 'Five Orchestral Pieces for Opus Tree', piece.title_en = 'Five Orchestral Pieces for Opus Tree',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18670 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fly Drive

UPDATE pieces piece
SET piece.title = 'Fly Drive', piece.title_en = 'Fly Drive',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19342 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None For John Cage

UPDATE pieces piece
SET piece.title = 'For John Cage', piece.title_en = 'For John Cage',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19546 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None From Our End, High Up Here

UPDATE pieces piece
SET piece.title = 'From Our End, High Up Here', piece.title_en = 'From Our End, High Up Here',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18023 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Further and Further

UPDATE pieces piece
SET piece.title = 'Further and Further', piece.title_en = 'Further and Further',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19084 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None God's Hands

UPDATE pieces piece
SET piece.title = 'God''s Hands', piece.title_en = 'God''s Hands',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18474 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Great Death Game

UPDATE pieces piece
SET piece.title = 'Great Death Game', piece.title_en = 'Great Death Game',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17971 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Göring's Huntig Party

UPDATE pieces piece
SET piece.title = 'Göring''s Huntig Party', piece.title_en = 'Göring''s Huntig Party',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18347 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Halt, We Are Specialists

UPDATE pieces piece
SET piece.title = 'Halt, We Are Specialists', piece.title_en = 'Halt, We Are Specialists',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18893 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Her Man Awaits

UPDATE pieces piece
SET piece.title = 'Her Man Awaits', piece.title_en = 'Her Man Awaits',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16322 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <I Am an Unusual Thing>

UPDATE pieces piece
SET piece.title = '가곡 <I Am an Unusual Thing>', piece.title_en = 'I Am an Unusual Thing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18164 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I Cannot Tell You What Is Wrong

UPDATE pieces piece
SET piece.title = 'I Cannot Tell You What Is Wrong', piece.title_en = 'I Cannot Tell You What Is Wrong',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16777 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I Thought You Wanted to Dance

UPDATE pieces piece
SET piece.title = 'I Thought You Wanted to Dance', piece.title_en = 'I Thought You Wanted to Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20004 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ich grolle nicht

UPDATE pieces piece
SET piece.title = 'Ich grolle nicht', piece.title_en = 'Ich grolle nicht',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16656 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 즉흥곡 3번 G♭장조 "s"

UPDATE pieces piece
SET piece.title = '즉흥곡 3번 G♭장조 "s"', piece.title_en = 'Impromptu for 12 Fingers (From Schubert''s "Impromptu in G-flat major, op. 90 no. 3")',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16550 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Impromptu on an English Court

UPDATE pieces piece
SET piece.title = 'Impromptu on an English Court', piece.title_en = 'Impromptu on an English Court',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19152 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In re Don Giovanni

UPDATE pieces piece
SET piece.title = 'In re Don Giovanni', piece.title_en = 'In re Don Giovanni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15896 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Irene / The Morrow

UPDATE pieces piece
SET piece.title = 'Irene / The Morrow', piece.title_en = 'Irene / The Morrow',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16562 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Irene's Theme

UPDATE pieces piece
SET piece.title = 'Irene''s Theme', piece.title_en = 'Irene''s Theme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17467 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None It Must Be the Light

UPDATE pieces piece
SET piece.title = 'It Must Be the Light', piece.title_en = 'It Must Be the Light',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18549 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jealousy and Revenge

UPDATE pieces piece
SET piece.title = 'Jealousy and Revenge', piece.title_en = 'Jealousy and Revenge',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18694 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Knowing the Ropes

UPDATE pieces piece
SET piece.title = 'Knowing the Ropes', piece.title_en = 'Knowing the Ropes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15894 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Life's Chaos

UPDATE pieces piece
SET piece.title = 'Life''s Chaos', piece.title_en = 'Life''s Chaos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17286 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Look for an Enemy!

UPDATE pieces piece
SET piece.title = 'Look for an Enemy!', piece.title_en = 'Look for an Enemy!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16382 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None MGV

UPDATE pieces piece
SET piece.title = 'MGV', piece.title_en = 'MGV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18068 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Main Theme - Reprise

UPDATE pieces piece
SET piece.title = 'Main Theme - Reprise', piece.title_en = 'Main Theme - Reprise',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16454 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Maria Owens

UPDATE pieces piece
SET piece.title = 'Maria Owens', piece.title_en = 'Maria Owens',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18335 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Marulla's Hobby

UPDATE pieces piece
SET piece.title = 'Marulla''s Hobby', piece.title_en = 'Marulla''s Hobby',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17070 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Michael Nyman 1

UPDATE pieces piece
SET piece.title = 'Michael Nyman 1', piece.title_en = 'Michael Nyman 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18046 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Michael Nyman 2

UPDATE pieces piece
SET piece.title = 'Michael Nyman 2', piece.title_en = 'Michael Nyman 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17114 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Michael Nyman 3

UPDATE pieces piece
SET piece.title = 'Michael Nyman 3', piece.title_en = 'Michael Nyman 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18743 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Michael Nyman 4

UPDATE pieces piece
SET piece.title = 'Michael Nyman 4', piece.title_en = 'Michael Nyman 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19299 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Michael Nyman 5

UPDATE pieces piece
SET piece.title = 'Michael Nyman 5', piece.title_en = 'Michael Nyman 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16126 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Michael Nyman 6

UPDATE pieces piece
SET piece.title = 'Michael Nyman 6', piece.title_en = 'Michael Nyman 6',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18947 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Miranda

UPDATE pieces piece
SET piece.title = 'Miranda', piece.title_en = 'Miranda',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19697 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Miserere (from The Cook, the Thief, his Wife and her Lover)

UPDATE pieces piece
SET piece.title = 'Miserere (from The Cook, the Thief, his Wife and her Lover)', piece.title_en = 'Miserere (from The Cook, the Thief, his Wife and her Lover)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19513 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Miserere Paraphrase

UPDATE pieces piece
SET piece.title = 'Miserere Paraphrase', piece.title_en = 'Miserere Paraphrase',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17998 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Movement I

UPDATE pieces piece
SET piece.title = 'Movement I', piece.title_en = 'Movement I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19573 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Movement II

UPDATE pieces piece
SET piece.title = 'Movement II', piece.title_en = 'Movement II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17962 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Movement III

UPDATE pieces piece
SET piece.title = 'Movement III', piece.title_en = 'Movement III',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16044 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music After a While

UPDATE pieces piece
SET piece.title = 'Music After a While', piece.title_en = 'Music After a While',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18502 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None No Time in Eternity

UPDATE pieces piece
SET piece.title = 'No Time in Eternity', piece.title_en = 'No Time in Eternity',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16788 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'To Music (I)', part.name_en = 'No Time in Eternity: I. To Music (I)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16788 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:55ddd4d4-a423-4792-ae66-672ac8e86831' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55ddd4d4-a423-4792-ae66-672ac8e86831', 1, 'I', 'To Music (I)', 'No Time in Eternity: I. To Music (I)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16788 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55ddd4d4-a423-4792-ae66-672ac8e86831'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'The Definition of Beauty', part.name_en = 'No Time in Eternity: IV. The Definition of Beauty',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16788 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:62fc2b37-4cf5-4733-9bde-cb419fb10803' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62fc2b37-4cf5-4733-9bde-cb419fb10803', 2, 'IV', 'The Definition of Beauty', 'No Time in Eternity: IV. The Definition of Beauty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16788 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62fc2b37-4cf5-4733-9bde-cb419fb10803'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'VII',
    part.name_ko = 'To Music (II)', part.name_en = 'No Time in Eternity: VII. To Music (II)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16788 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:6ee84412-8018-479b-af3e-2b5862347a51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ee84412-8018-479b-af3e-2b5862347a51', 3, 'VII', 'To Music (II)', 'No Time in Eternity: VII. To Music (II)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16788 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ee84412-8018-479b-af3e-2b5862347a51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = 'Fortune', part.name_en = 'No Time in Eternity: III. Fortune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16788 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:a5f8c80b-e8d1-4012-92f0-9e614764cdf3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5f8c80b-e8d1-4012-92f0-9e614764cdf3', 4, 'III', 'Fortune', 'No Time in Eternity: III. Fortune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16788 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5f8c80b-e8d1-4012-92f0-9e614764cdf3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'VI',
    part.name_ko = 'The Watch', part.name_en = 'No Time in Eternity: VI. The Watch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16788 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:b10506c8-1424-4bac-829f-a55bdd1ab919' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b10506c8-1424-4bac-829f-a55bdd1ab919', 5, 'VI', 'The Watch', 'No Time in Eternity: VI. The Watch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16788 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b10506c8-1424-4bac-829f-a55bdd1ab919'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'V',
    part.name_ko = 'Things Mortal Still Mutable', part.name_en = 'No Time in Eternity: V. Things Mortal Still Mutable',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16788 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:e0110ba1-2987-4b96-800e-2aae307dc5fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0110ba1-2987-4b96-800e-2aae307dc5fd', 6, 'V', 'Things Mortal Still Mutable', 'No Time in Eternity: V. Things Mortal Still Mutable', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16788 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0110ba1-2987-4b96-800e-2aae307dc5fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'II',
    part.name_ko = 'No Time in Eternity', part.name_en = 'No Time in Eternity: II. No Time in Eternity',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16788 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:fe40fc4b-5c4c-4965-b867-a09532f8d936' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe40fc4b-5c4c-4965-b867-a09532f8d936', 7, 'II', 'No Time in Eternity', 'No Time in Eternity: II. No Time in Eternity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16788 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe40fc4b-5c4c-4965-b867-a09532f8d936'
);


-- None Not the Only One

UPDATE pieces piece
SET piece.title = 'Not the Only One', piece.title_en = 'Not the Only One',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20082 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Now That You're Here

UPDATE pieces piece
SET piece.title = 'Now That You''re Here', piece.title_en = 'Now That You''re Here',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17663 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Now, What Is This?

UPDATE pieces piece
SET piece.title = 'Now, What Is This?', piece.title_en = 'Now, What Is This?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18070 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Odessa Beach

UPDATE pieces piece
SET piece.title = 'Odessa Beach', piece.title_en = 'Odessa Beach',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16465 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None On the Fiddle

UPDATE pieces piece
SET piece.title = 'On the Fiddle', piece.title_en = 'On the Fiddle',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16874 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Full Fathom Five', part.name_en = 'On the Fiddle: I. Full Fathom Five',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16874 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:8aa8e91e-b7af-4865-b3cc-4c12b9dab442' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8aa8e91e-b7af-4865-b3cc-4c12b9dab442', 1, 'I', 'Full Fathom Five', 'On the Fiddle: I. Full Fathom Five', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16874 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8aa8e91e-b7af-4865-b3cc-4c12b9dab442'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Angelfish Decay', part.name_en = 'On the Fiddle: II. Angelfish Decay',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16874 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:7cd7d3f5-e779-4121-a48b-7341d503e11b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cd7d3f5-e779-4121-a48b-7341d503e11b', 2, 'II', 'Angelfish Decay', 'On the Fiddle: II. Angelfish Decay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16874 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cd7d3f5-e779-4121-a48b-7341d503e11b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Miserere Paraphrase', part.name_en = 'On the Fiddle: III. Miserere Paraphrase',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16874 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:36428a34-d75f-4dad-9ac9-0650d48e8481' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36428a34-d75f-4dad-9ac9-0650d48e8481', 3, 'III', 'Miserere Paraphrase', 'On the Fiddle: III. Miserere Paraphrase', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16874 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36428a34-d75f-4dad-9ac9-0650d48e8481'
);


-- None Only a Matter of Time

UPDATE pieces piece
SET piece.title = 'Only a Matter of Time', piece.title_en = 'Only a Matter of Time',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18410 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ordinary Citizens

UPDATE pieces piece
SET piece.title = 'Ordinary Citizens', piece.title_en = 'Ordinary Citizens',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18198 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Passage De L'Égalité

UPDATE pieces piece
SET piece.title = 'Passage De L''Égalité', piece.title_en = 'Passage De L''Égalité',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18812 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pawn to King 4

UPDATE pieces piece
SET piece.title = 'Pawn to King 4', piece.title_en = 'Pawn to King 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19422 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Picabia’s Pigeons

UPDATE pieces piece
SET piece.title = 'Picabia’s Pigeons', piece.title_en = 'Picabia’s Pigeons',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19662 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Playing at Soldiering

UPDATE pieces piece
SET piece.title = 'Playing at Soldiering', piece.title_en = 'Playing at Soldiering',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16103 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Polish Song

UPDATE pieces piece
SET piece.title = 'Polish Song', piece.title_en = 'Polish Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17831 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prospero’s Books

UPDATE pieces piece
SET piece.title = 'Prospero’s Books', piece.title_en = 'Prospero’s Books',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17627 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Reconciliation', part.name_en = 'Prospero’s Books: Reconciliation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:180c27e6-594d-46e6-99b8-cc3934fb302a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:180c27e6-594d-46e6-99b8-cc3934fb302a', 1, NULL, 'Reconciliation', 'Prospero’s Books: Reconciliation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:180c27e6-594d-46e6-99b8-cc3934fb302a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Where the bee sucks', part.name_en = 'Prospero’s Books: Where the bee sucks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:3c075438-0df8-4658-b989-22cf550c0dfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c075438-0df8-4658-b989-22cf550c0dfe', 2, NULL, 'Where the bee sucks', 'Prospero’s Books: Where the bee sucks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c075438-0df8-4658-b989-22cf550c0dfe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Prospero’s Magic', part.name_en = 'Prospero’s Books: Prospero’s Magic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:3cf3c09c-905f-44b4-89f6-9d834075d3d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cf3c09c-905f-44b4-89f6-9d834075d3d7', 3, NULL, 'Prospero’s Magic', 'Prospero’s Books: Prospero’s Magic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cf3c09c-905f-44b4-89f6-9d834075d3d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'While you here do snoring lie', part.name_en = 'Prospero’s Books: While you here do snoring lie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:4d736f93-9125-4539-a998-6ba5aa862c00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d736f93-9125-4539-a998-6ba5aa862c00', 4, NULL, 'While you here do snoring lie', 'Prospero’s Books: While you here do snoring lie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d736f93-9125-4539-a998-6ba5aa862c00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Miranda', part.name_en = 'Prospero’s Books: Miranda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:57c8b013-7e25-4639-9a84-f5babf3e6bd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57c8b013-7e25-4639-9a84-f5babf3e6bd0', 5, NULL, 'Miranda', 'Prospero’s Books: Miranda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57c8b013-7e25-4639-9a84-f5babf3e6bd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'History of Sycorax', part.name_en = 'Prospero’s Books: History of Sycorax',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:6e9a2b28-75c7-4090-983e-219336c76ee5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e9a2b28-75c7-4090-983e-219336c76ee5', 6, NULL, 'History of Sycorax', 'Prospero’s Books: History of Sycorax', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e9a2b28-75c7-4090-983e-219336c76ee5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Full Fathom Five', part.name_en = 'Prospero’s Books: Full Fathom Five',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:89893dfd-44f7-4a63-afcc-007f265d7abc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89893dfd-44f7-4a63-afcc-007f265d7abc', 7, NULL, 'Full Fathom Five', 'Prospero’s Books: Full Fathom Five', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89893dfd-44f7-4a63-afcc-007f265d7abc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The Masque', part.name_en = 'Prospero’s Books: The Masque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:8ce7a59d-13e8-422c-b3c4-52d5102b6565' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ce7a59d-13e8-422c-b3c4-52d5102b6565', 8, NULL, 'The Masque', 'Prospero’s Books: The Masque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ce7a59d-13e8-422c-b3c4-52d5102b6565'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Come and go', part.name_en = 'Prospero’s Books: Come and go',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:b8e613cb-254a-4acf-bd56-e0b80fe9c598' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8e613cb-254a-4acf-bd56-e0b80fe9c598', 9, NULL, 'Come and go', 'Prospero’s Books: Come and go', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8e613cb-254a-4acf-bd56-e0b80fe9c598'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Prospero’s Curse', part.name_en = 'Prospero’s Books: Prospero’s Curse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:c0afa94b-e1bf-4beb-8e76-096678491e5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0afa94b-e1bf-4beb-8e76-096678491e5f', 10, NULL, 'Prospero’s Curse', 'Prospero’s Books: Prospero’s Curse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0afa94b-e1bf-4beb-8e76-096678491e5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Come unto these yellow sands', part.name_en = 'Prospero’s Books: Come unto these yellow sands',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:d48d628c-a728-48e3-9207-5180a4ad2034' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d48d628c-a728-48e3-9207-5180a4ad2034', 11, NULL, 'Come unto these yellow sands', 'Prospero’s Books: Come unto these yellow sands', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d48d628c-a728-48e3-9207-5180a4ad2034'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Twelve Years Since', part.name_en = 'Prospero’s Books: Twelve Years Since',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:e0465221-23cf-4a61-bc6a-91a861cf2291' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0465221-23cf-4a61-bc6a-91a861cf2291', 12, NULL, 'Twelve Years Since', 'Prospero’s Books: Twelve Years Since', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0465221-23cf-4a61-bc6a-91a861cf2291'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Cornfield', part.name_en = 'Prospero’s Books: Cornfield',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:ef8457b0-4c37-475a-8ce2-89c49ac43218' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef8457b0-4c37-475a-8ce2-89c49ac43218', 13, NULL, 'Cornfield', 'Prospero’s Books: Cornfield', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef8457b0-4c37-475a-8ce2-89c49ac43218'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Caliban’s pit', part.name_en = 'Prospero’s Books: Caliban’s pit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17627 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:f7afe036-4661-4939-9b14-c993d8b27dd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7afe036-4661-4939-9b14-c993d8b27dd4', 14, NULL, 'Caliban’s pit', 'Prospero’s Books: Caliban’s pit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17627 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7afe036-4661-4939-9b14-c993d8b27dd4'
);


-- None Puppenkorper

UPDATE pieces piece
SET piece.title = 'Puppenkorper', piece.title_en = 'Puppenkorper',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17531 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Red Drum

UPDATE pieces piece
SET piece.title = 'Red Drum', piece.title_en = 'Red Drum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17654 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rochester's Farewell

UPDATE pieces piece
SET piece.title = 'Rochester''s Farewell', piece.title_en = 'Rochester''s Farewell',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16094 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 1 - "Excuse Me. Excuse Me"

UPDATE pieces piece
SET piece.title = 'Scene 1 - "Excuse Me. Excuse Me"', piece.title_en = 'Scene 1 - "Excuse Me. Excuse Me"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19926 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 10 - "It's for You. Why Is It for You?"

UPDATE pieces piece
SET piece.title = 'Scene 10 - "It''s for You. Why Is It for You?"', piece.title_en = 'Scene 10 - "It''s for You. Why Is It for You?"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16236 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 11 - "Now, in Hebrew Mathematical Art"

UPDATE pieces piece
SET piece.title = 'Scene 11 - "Now, in Hebrew Mathematical Art"', piece.title_en = 'Scene 11 - "Now, in Hebrew Mathematical Art"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16036 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 12 - "You Didn't Tell Me You Did This Every Morning"

UPDATE pieces piece
SET piece.title = 'Scene 12 - "You Didn''t Tell Me You Did This Every Morning"', piece.title_en = 'Scene 12 - "You Didn''t Tell Me You Did This Every Morning"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18980 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 13 - Instrumental 1

UPDATE pieces piece
SET piece.title = 'Scene 13 - Instrumental 1', piece.title_en = 'Scene 13 - Instrumental 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16460 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 14 - "You Look as Though You Have Lost Something"

UPDATE pieces piece
SET piece.title = 'Scene 14 - "You Look as Though You Have Lost Something"', piece.title_en = 'Scene 14 - "You Look as Though You Have Lost Something"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16749 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 15 - "Give Me My Card Back!"

UPDATE pieces piece
SET piece.title = 'Scene 15 - "Give Me My Card Back!"', piece.title_en = 'Scene 15 - "Give Me My Card Back!"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18182 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 16 - "Hello, Guv'Nor, Yes, It's Me"

UPDATE pieces piece
SET piece.title = 'Scene 16 - "Hello, Guv''Nor, Yes, It''s Me"', piece.title_en = 'Scene 16 - "Hello, Guv''Nor, Yes, It''s Me"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16162 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 17 - Instrumental 2

UPDATE pieces piece
SET piece.title = 'Scene 17 - Instrumental 2', piece.title_en = 'Scene 17 - Instrumental 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18534 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 18 - "I've Tried to Tell You What I Think"

UPDATE pieces piece
SET piece.title = 'Scene 18 - "I''ve Tried to Tell You What I Think"', piece.title_en = 'Scene 18 - "I''ve Tried to Tell You What I Think"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16366 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 19 - Instrumental 3

UPDATE pieces piece
SET piece.title = 'Scene 19 - Instrumental 3', piece.title_en = 'Scene 19 - Instrumental 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17903 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 2 - "This Lah-Di-Dah Dame"

UPDATE pieces piece
SET piece.title = 'Scene 2 - "This Lah-Di-Dah Dame"', piece.title_en = 'Scene 2 - "This Lah-Di-Dah Dame"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17958 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 20 - "I've Spoken to the Guv'nor at the Gym"

UPDATE pieces piece
SET piece.title = 'Scene 20 - "I''ve Spoken to the Guv''nor at the Gym"', piece.title_en = 'Scene 20 - "I''ve Spoken to the Guv''nor at the Gym"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16093 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 21 - "There You Are... And That Tree"

UPDATE pieces piece
SET piece.title = 'Scene 21 - "There You Are... And That Tree"', piece.title_en = 'Scene 21 - "There You Are... And That Tree"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19858 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 3 - "Wore These My First Pro Win"

UPDATE pieces piece
SET piece.title = 'Scene 3 - "Wore These My First Pro Win"', piece.title_en = 'Scene 3 - "Wore These My First Pro Win"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16072 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 4 - "How Much Does This Bill Say?"

UPDATE pieces piece
SET piece.title = 'Scene 4 - "How Much Does This Bill Say?"', piece.title_en = 'Scene 4 - "How Much Does This Bill Say?"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16855 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 5 - "This Is a Set"

UPDATE pieces piece
SET piece.title = 'Scene 5 - "This Is a Set"', piece.title_en = 'Scene 5 - "This Is a Set"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16302 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 6 - "Patsy, My Love"

UPDATE pieces piece
SET piece.title = 'Scene 6 - "Patsy, My Love"', piece.title_en = 'Scene 6 - "Patsy, My Love"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19785 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 7 - "Let's Suppose for Today"

UPDATE pieces piece
SET piece.title = 'Scene 7 - "Let''s Suppose for Today"', piece.title_en = 'Scene 7 - "Let''s Suppose for Today"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19042 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 8 - "They Say Nothing Is Secret"

UPDATE pieces piece
SET piece.title = 'Scene 8 - "They Say Nothing Is Secret"', piece.title_en = 'Scene 8 - "They Say Nothing Is Secret"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18430 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scene 9 - "Forty Seven", "Sixty Three"

UPDATE pieces piece
SET piece.title = 'Scene 9 - "Forty Seven", "Sixty Three"', piece.title_en = 'Scene 9 - "Forty Seven", "Sixty Three"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18288 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Second Morrow

UPDATE pieces piece
SET piece.title = 'Second Morrow', piece.title_en = 'Second Morrow',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18497 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sheep ’n’ Tides

UPDATE pieces piece
SET piece.title = 'Sheep ’n’ Tides', piece.title_en = 'Sheep ’n’ Tides',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15893 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Signior D

UPDATE pieces piece
SET piece.title = 'Signior D', piece.title_en = 'Signior D',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19638 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Signior Dildo

UPDATE pieces piece
SET piece.title = 'Signior Dildo', piece.title_en = 'Signior Dildo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19771 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Six Celan Songs>

UPDATE pieces piece
SET piece.title = '연가곡집 <Six Celan Songs>', piece.title_en = 'Six Celan Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16039 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chanson einer Dame im Schatten', part.name_en = 'Six Celan Songs: Chanson einer Dame im Schatten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16039 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:039e98af-5d01-4cb0-a1ea-cf850560d538' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:039e98af-5d01-4cb0-a1ea-cf850560d538', 1, NULL, 'Chanson einer Dame im Schatten', 'Six Celan Songs: Chanson einer Dame im Schatten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16039 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:039e98af-5d01-4cb0-a1ea-cf850560d538'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Es war Erde in ihnen', part.name_en = 'Six Celan Songs: Es war Erde in ihnen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16039 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:75614312-8a63-49db-a073-cf54ae85a685' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75614312-8a63-49db-a073-cf54ae85a685', 2, NULL, 'Es war Erde in ihnen', 'Six Celan Songs: Es war Erde in ihnen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16039 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75614312-8a63-49db-a073-cf54ae85a685'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Psalm', part.name_en = 'Six Celan Songs: Psalm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16039 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:a6520491-f6ed-4618-b7d8-ab0193f381a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6520491-f6ed-4618-b7d8-ab0193f381a8', 3, NULL, 'Psalm', 'Six Celan Songs: Psalm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16039 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6520491-f6ed-4618-b7d8-ab0193f381a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Corona', part.name_en = 'Six Celan Songs: Corona',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16039 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:0b94cc30-0b96-482c-a084-7a412bbdbc62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b94cc30-0b96-482c-a084-7a412bbdbc62', 4, NULL, 'Corona', 'Six Celan Songs: Corona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16039 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b94cc30-0b96-482c-a084-7a412bbdbc62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Nächtlich geschürzt', part.name_en = 'Six Celan Songs: Nächtlich geschürzt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16039 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:79bd808e-e87b-4ac6-941f-95df09bb0b08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79bd808e-e87b-4ac6-941f-95df09bb0b08', 5, NULL, 'Nächtlich geschürzt', 'Six Celan Songs: Nächtlich geschürzt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16039 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79bd808e-e87b-4ac6-941f-95df09bb0b08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Blume', part.name_en = 'Six Celan Songs: Blume',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16039 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:f0050c08-fd26-4d01-a755-3850ae1d5389' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0050c08-fd26-4d01-a755-3850ae1d5389', 6, NULL, 'Blume', 'Six Celan Songs: Blume', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16039 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0050c08-fd26-4d01-a755-3850ae1d5389'
);


-- None Sounds of the Night

UPDATE pieces piece
SET piece.title = 'Sounds of the Night', piece.title_en = 'Sounds of the Night',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19572 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Strong on Oaks, Strong on the Causes of Oaks

UPDATE pieces piece
SET piece.title = 'Strong on Oaks, Strong on the Causes of Oaks', piece.title_en = 'Strong on Oaks, Strong on the Causes of Oaks',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17928 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 5번

UPDATE pieces piece
SET piece.title = '교향곡 5번', piece.title_en = 'Symphony No. 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19065 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Taking It as Read

UPDATE pieces piece
SET piece.title = 'Taking It as Read', piece.title_en = 'Taking It as Read',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19916 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Taking It as Read: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19916 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:5969bd99-77ec-4d2c-9a23-b18c0645e856' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5969bd99-77ec-4d2c-9a23-b18c0645e856', 1, NULL, 'No. 1', 'Taking It as Read: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19916 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5969bd99-77ec-4d2c-9a23-b18c0645e856'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Taking It as Read: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19916 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:174be913-fb7b-4561-b850-ba289a8542bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:174be913-fb7b-4561-b850-ba289a8542bf', 2, NULL, 'No. 2', 'Taking It as Read: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19916 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:174be913-fb7b-4561-b850-ba289a8542bf'
);


-- None Tango for Tim

UPDATE pieces piece
SET piece.title = 'Tango for Tim', piece.title_en = 'Tango for Tim',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19809 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The 96

UPDATE pieces piece
SET piece.title = 'The 96', piece.title_en = 'The 96',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17448 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Arrival

UPDATE pieces piece
SET piece.title = 'The Arrival', piece.title_en = 'The Arrival',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18757 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Ballad of Kastriot Rexhepi

UPDATE pieces piece
SET piece.title = 'The Ballad of Kastriot Rexhepi', piece.title_en = 'The Ballad of Kastriot Rexhepi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17414 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Closet

UPDATE pieces piece
SET piece.title = 'The Closet', piece.title_en = 'The Closet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16063 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Convertibility of the Lute Strings

UPDATE pieces piece
SET piece.title = 'The Convertibility of the Lute Strings', piece.title_en = 'The Convertibility of the Lute Strings',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16264 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <The Cook, The Thief, His Wife and Her Lover>

UPDATE pieces piece
SET piece.title = '영화음악 <The Cook, The Thief, His Wife and Her Lover>', piece.title_en = 'The Cook, The Thief, His Wife and Her Lover',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18496 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Memorial', part.name_en = 'Memorial',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18496 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:eac8e598-2d23-4e08-a001-7c70b48a75e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eac8e598-2d23-4e08-a001-7c70b48a75e4', 1, NULL, 'Memorial', 'Memorial', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18496 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eac8e598-2d23-4e08-a001-7c70b48a75e4'
);


-- None The Crossing

UPDATE pieces piece
SET piece.title = 'The Crossing', piece.title_en = 'The Crossing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19314 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Damned

UPDATE pieces piece
SET piece.title = 'The Damned', piece.title_en = 'The Damned',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19064 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Dead Are Sad Enough in Their Eternal Silence

UPDATE pieces piece
SET piece.title = 'The Dead Are Sad Enough in Their Eternal Silence', piece.title_en = 'The Dead Are Sad Enough in Their Eternal Silence',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17226 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Dead and the Two Plots

UPDATE pieces piece
SET piece.title = 'The Dead and the Two Plots', piece.title_en = 'The Dead and the Two Plots',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16944 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Departure

UPDATE pieces piece
SET piece.title = 'The Departure', piece.title_en = 'The Departure',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18319 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <The Diary of Anne Frank>

UPDATE pieces piece
SET piece.title = '영화음악 <The Diary of Anne Frank>', piece.title_en = 'The Diary of Anne Frank',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17900 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Amsterdam Dawn', part.name_en = 'Amsterdam Dawn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:04eff7b3-b80d-4d9d-8230-5aee819bdceb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04eff7b3-b80d-4d9d-8230-5aee819bdceb', 1, NULL, 'Amsterdam Dawn', 'Amsterdam Dawn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04eff7b3-b80d-4d9d-8230-5aee819bdceb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Goodbye Moortie', part.name_en = 'Goodbye Moortie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:3427d612-9471-4405-bbf4-495df4b2c68c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3427d612-9471-4405-bbf4-495df4b2c68c', 2, NULL, 'Goodbye Moortie', 'Goodbye Moortie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3427d612-9471-4405-bbf4-495df4b2c68c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Why?', part.name_en = 'Why?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:386e4bb6-1255-4cd9-b3d5-66d4e338ab2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:386e4bb6-1255-4cd9-b3d5-66d4e338ab2b', 3, NULL, 'Why?', 'Why?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:386e4bb6-1255-4cd9-b3d5-66d4e338ab2b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Renewal', part.name_en = 'Renewal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:3bba7873-e5b5-4bff-8ab3-edd9b50a75c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bba7873-e5b5-4bff-8ab3-edd9b50a75c5', 4, NULL, 'Renewal', 'Renewal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bba7873-e5b5-4bff-8ab3-edd9b50a75c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Letter From Germany', part.name_en = 'Letter From Germany',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:3fddf8a9-8e0c-4abc-86f9-f5906ebc7101' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fddf8a9-8e0c-4abc-86f9-f5906ebc7101', 5, NULL, 'Letter From Germany', 'Letter From Germany', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fddf8a9-8e0c-4abc-86f9-f5906ebc7101'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Light Of Love', part.name_en = 'Light Of Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:48f129a7-708e-415f-872a-f76ae9e4a740' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48f129a7-708e-415f-872a-f76ae9e4a740', 6, NULL, 'Light Of Love', 'Light Of Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48f129a7-708e-415f-872a-f76ae9e4a740'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Lament For Lost Youth', part.name_en = 'Lament For Lost Youth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:519257d7-7bc9-4238-80aa-32e0bc2d1ced' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:519257d7-7bc9-4238-80aa-32e0bc2d1ced', 7, NULL, 'Lament For Lost Youth', 'Lament For Lost Youth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:519257d7-7bc9-4238-80aa-32e0bc2d1ced'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Anne''s Birthday', part.name_en = 'Anne''s Birthday',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:5bb09cb2-9986-4359-a0ea-9914d396f39a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bb09cb2-9986-4359-a0ea-9914d396f39a', 8, NULL, 'Anne''s Birthday', 'Anne''s Birthday', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bb09cb2-9986-4359-a0ea-9914d396f39a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Silent Separation', part.name_en = 'Silent Separation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:6f238b83-f37c-4d42-9332-41f7b77883a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f238b83-f37c-4d42-9332-41f7b77883a4', 9, NULL, 'Silent Separation', 'Silent Separation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f238b83-f37c-4d42-9332-41f7b77883a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Spring Freedom', part.name_en = 'Spring Freedom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:8222f03c-f4bc-4c0b-803f-c055164b502e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8222f03c-f4bc-4c0b-803f-c055164b502e', 10, NULL, 'Spring Freedom', 'Spring Freedom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8222f03c-f4bc-4c0b-803f-c055164b502e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'The Schoolroom', part.name_en = 'The Schoolroom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:94d19fd3-e8b1-4150-ab9c-e0976f8d8c3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94d19fd3-e8b1-4150-ab9c-e0976f8d8c3c', 11, NULL, 'The Schoolroom', 'The Schoolroom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94d19fd3-e8b1-4150-ab9c-e0976f8d8c3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Hanukah', part.name_en = 'Hanukah',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:9852305b-ca52-4917-8974-d59a72acdaec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9852305b-ca52-4917-8974-d59a72acdaec', 12, NULL, 'Hanukah', 'Hanukah', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9852305b-ca52-4917-8974-d59a72acdaec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'First Kiss', part.name_en = 'First Kiss',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:9fc1de94-cd71-4051-8abc-3d558b9f93a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fc1de94-cd71-4051-8abc-3d558b9f93a2', 13, NULL, 'First Kiss', 'First Kiss', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fc1de94-cd71-4051-8abc-3d558b9f93a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'D-Day', part.name_en = 'D-Day',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:a2e42ed2-3dbc-4af5-9b43-3f948ef77190' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2e42ed2-3dbc-4af5-9b43-3f948ef77190', 14, NULL, 'D-Day', 'D-Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2e42ed2-3dbc-4af5-9b43-3f948ef77190'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Chatterbox Waltz', part.name_en = 'Chatterbox Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:c019a4fe-ebb4-402a-8f00-5ff86f1af01b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c019a4fe-ebb4-402a-8f00-5ff86f1af01b', 15, NULL, 'Chatterbox Waltz', 'Chatterbox Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c019a4fe-ebb4-402a-8f00-5ff86f1af01b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'The Diary Of Hope', part.name_en = 'The Diary Of Hope',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:c08f44ee-ff50-4c5b-8af3-80c274251d79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c08f44ee-ff50-4c5b-8af3-80c274251d79', 16, NULL, 'The Diary Of Hope', 'The Diary Of Hope', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c08f44ee-ff50-4c5b-8af3-80c274251d79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Concentration Camp', part.name_en = 'Concentration Camp',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:c798398e-92eb-4240-bee3-e29869597b19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c798398e-92eb-4240-bee3-e29869597b19', 17, NULL, 'Concentration Camp', 'Concentration Camp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c798398e-92eb-4240-bee3-e29869597b19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Candlefire', part.name_en = 'Candlefire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:c95a5e3d-67b6-4625-a63f-facad5e7e3bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c95a5e3d-67b6-4625-a63f-facad5e7e3bb', 18, NULL, 'Candlefire', 'Candlefire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c95a5e3d-67b6-4625-a63f-facad5e7e3bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'If', part.name_en = 'If',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17900 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:ccf6c051-4ee2-4635-b7e4-e43cb1bfc015' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccf6c051-4ee2-4635-b7e4-e43cb1bfc015', 19, NULL, 'If', 'If', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17900 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccf6c051-4ee2-4635-b7e4-e43cb1bfc015'
);


-- None 영화음악 <The Draughtman’s Contract>

UPDATE pieces piece
SET piece.title = '영화음악 <The Draughtman’s Contract>', piece.title_en = 'The Draughtman’s Contract',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19093 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chasing Sheep Is Best Left to Shepherds', part.name_en = 'Chasing Sheep Is Best Left to Shepherds',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19093 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:991756d6-fc44-4c49-a61f-19781fd177ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:991756d6-fc44-4c49-a61f-19781fd177ed', 1, NULL, 'Chasing Sheep Is Best Left to Shepherds', 'Chasing Sheep Is Best Left to Shepherds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19093 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:991756d6-fc44-4c49-a61f-19781fd177ed'
);


-- None The Effects of Gas

UPDATE pieces piece
SET piece.title = 'The Effects of Gas', piece.title_en = 'The Effects of Gas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19657 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Eleventh Year 1

UPDATE pieces piece
SET piece.title = 'The Eleventh Year 1', piece.title_en = 'The Eleventh Year 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16459 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Eleventh Year 2

UPDATE pieces piece
SET piece.title = 'The Eleventh Year 2', piece.title_en = 'The Eleventh Year 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18150 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Eleventh Year 3

UPDATE pieces piece
SET piece.title = 'The Eleventh Year 3', piece.title_en = 'The Eleventh Year 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18327 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Eleventh Year 4

UPDATE pieces piece
SET piece.title = 'The Eleventh Year 4', piece.title_en = 'The Eleventh Year 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17221 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Eleventh Year 5

UPDATE pieces piece
SET piece.title = 'The Eleventh Year 5', piece.title_en = 'The Eleventh Year 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18998 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Engine Turns

UPDATE pieces piece
SET piece.title = 'The Engine Turns', piece.title_en = 'The Engine Turns',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16666 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Exchange

UPDATE pieces piece
SET piece.title = 'The Exchange', piece.title_en = 'The Exchange',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19120 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <The Falls>

UPDATE pieces piece
SET piece.title = '영화음악 <The Falls>', piece.title_en = 'The Falls',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19466 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Bird Anthem', part.name_en = 'Bird Anthem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19466 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:0538611d-add6-42f6-9e01-ac39513213cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0538611d-add6-42f6-9e01-ac39513213cd', 1, NULL, 'Bird Anthem', 'Bird Anthem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19466 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0538611d-add6-42f6-9e01-ac39513213cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Bird List Song', part.name_en = 'Bird List Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19466 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:ee44e664-376a-4fb4-b774-0b8c6c23e31f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee44e664-376a-4fb4-b774-0b8c6c23e31f', 2, NULL, 'Bird List Song', 'Bird List Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19466 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee44e664-376a-4fb4-b774-0b8c6c23e31f'
);


-- None The Final Score I

UPDATE pieces piece
SET piece.title = 'The Final Score I', piece.title_en = 'The Final Score I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16179 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Final Score II

UPDATE pieces piece
SET piece.title = 'The Final Score II', piece.title_en = 'The Final Score II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17608 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Final Score III

UPDATE pieces piece
SET piece.title = 'The Final Score III', piece.title_en = 'The Final Score III',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19890 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Final Score IV

UPDATE pieces piece
SET piece.title = 'The Final Score IV', piece.title_en = 'The Final Score IV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18427 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Final Score IX

UPDATE pieces piece
SET piece.title = 'The Final Score IX', piece.title_en = 'The Final Score IX',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16907 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Final Score V

UPDATE pieces piece
SET piece.title = 'The Final Score V', piece.title_en = 'The Final Score V',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18206 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Final Score VI

UPDATE pieces piece
SET piece.title = 'The Final Score VI', piece.title_en = 'The Final Score VI',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17425 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Final Score VII

UPDATE pieces piece
SET piece.title = 'The Final Score VII', piece.title_en = 'The Final Score VII',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17382 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Final Score VIII

UPDATE pieces piece
SET piece.title = 'The Final Score VIII', piece.title_en = 'The Final Score VIII',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20000 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Garden Is Becoming a Robe Room

UPDATE pieces piece
SET piece.title = 'The Garden Is Becoming a Robe Room', piece.title_en = 'The Garden Is Becoming a Robe Room',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17042 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Imperfect Enjoyment

UPDATE pieces piece
SET piece.title = 'The Imperfect Enjoyment', piece.title_en = 'The Imperfect Enjoyment',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18128 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Maimed Debauchee

UPDATE pieces piece
SET piece.title = 'The Maimed Debauchee', piece.title_en = 'The Maimed Debauchee',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17484 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Making of Faces

UPDATE pieces piece
SET piece.title = 'The Making of Faces', piece.title_en = 'The Making of Faces',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17853 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <The Man Who Mistook His Wife for a Hat>

UPDATE pieces piece
SET piece.title = '오페라 <The Man Who Mistook His Wife for a Hat>', piece.title_en = 'The Man Who Mistook His Wife for a Hat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19245 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Mechanical Horse

UPDATE pieces piece
SET piece.title = 'The Mechanical Horse', piece.title_en = 'The Mechanical Horse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19561 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Morrow

UPDATE pieces piece
SET piece.title = 'The Morrow', piece.title_en = 'The Morrow',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18303 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Musicologist Scores

UPDATE pieces piece
SET piece.title = 'The Musicologist Scores', piece.title_en = 'The Musicologist Scores',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16973 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Nightmare Begins

UPDATE pieces piece
SET piece.title = 'The Nightmare Begins', piece.title_en = 'The Nightmare Begins',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19643 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Nightmare Ends

UPDATE pieces piece
SET piece.title = 'The Nightmare Ends', piece.title_en = 'The Nightmare Ends',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19829 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The One Moment

UPDATE pieces piece
SET piece.title = 'The One Moment', piece.title_en = 'The One Moment',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19176 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <The Piano>

UPDATE pieces piece
SET piece.title = '영화음악 <The Piano>', piece.title_en = 'The Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19915 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Embrace', part.name_en = 'The Embrace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:090c007c-fee3-3a45-97e1-438422082ec4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:090c007c-fee3-3a45-97e1-438422082ec4', 1, NULL, 'The Embrace', 'The Embrace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:090c007c-fee3-3a45-97e1-438422082ec4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Silver-Fingered Fling', part.name_en = 'Silver-Fingered Fling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:299ede95-1017-463e-9893-75e16901c250' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:299ede95-1017-463e-9893-75e16901c250', 2, NULL, 'Silver-Fingered Fling', 'Silver-Fingered Fling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:299ede95-1017-463e-9893-75e16901c250'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Sacrifice', part.name_en = 'The Sacrifice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:3c7d18be-d523-3023-9d2c-345527209bcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c7d18be-d523-3023-9d2c-345527209bcb', 3, NULL, 'The Sacrifice', 'The Sacrifice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c7d18be-d523-3023-9d2c-345527209bcb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A Wild and Distant Shore', part.name_en = 'A Wild and Distant Shore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:3dafe650-476a-3941-9f6d-90e449e9b5ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dafe650-476a-3941-9f6d-90e449e9b5ff', 4, NULL, 'A Wild and Distant Shore', 'A Wild and Distant Shore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dafe650-476a-3941-9f6d-90e449e9b5ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Fling', part.name_en = 'The Fling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:42bcb76a-6929-358e-821a-9e3eecb1d0fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42bcb76a-6929-358e-821a-9e3eecb1d0fc', 5, NULL, 'The Fling', 'The Fling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42bcb76a-6929-358e-821a-9e3eecb1d0fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Dreams of a Journey', part.name_en = 'Dreams of a Journey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:45195c12-1cd2-3f1c-9bd0-49b1f510c147' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45195c12-1cd2-3f1c-9bd0-49b1f510c147', 6, NULL, 'Dreams of a Journey', 'Dreams of a Journey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45195c12-1cd2-3f1c-9bd0-49b1f510c147'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Here to There', part.name_en = 'Here to There',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:53936c5c-a49c-3022-9f25-8c4aeb47a388' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53936c5c-a49c-3022-9f25-8c4aeb47a388', 7, NULL, 'Here to There', 'Here to There', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53936c5c-a49c-3022-9f25-8c4aeb47a388'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Lost and Found', part.name_en = 'Lost and Found',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:5d156e19-75aa-3057-8f69-00ef80cabb9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d156e19-75aa-3057-8f69-00ef80cabb9c', 8, NULL, 'Lost and Found', 'Lost and Found', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d156e19-75aa-3057-8f69-00ef80cabb9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Deep Sleep Playing', part.name_en = 'Deep Sleep Playing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:69063442-8e00-48b1-a194-61835eb3e58b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69063442-8e00-48b1-a194-61835eb3e58b', 9, NULL, 'Deep Sleep Playing', 'Deep Sleep Playing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69063442-8e00-48b1-a194-61835eb3e58b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'To the Edge of the Earth', part.name_en = 'To the Edge of the Earth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:71e0f3c4-a102-3e75-87d0-b7c37b7f01ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71e0f3c4-a102-3e75-87d0-b7c37b7f01ee', 10, NULL, 'To the Edge of the Earth', 'To the Edge of the Earth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71e0f3c4-a102-3e75-87d0-b7c37b7f01ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Big My Secret', part.name_en = 'Big My Secret',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:78c1409f-6341-3f13-b70e-1ef22dc1af55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78c1409f-6341-3f13-b70e-1ef22dc1af55', 11, NULL, 'Big My Secret', 'Big My Secret', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78c1409f-6341-3f13-b70e-1ef22dc1af55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'The Wounded', part.name_en = 'The Wounded',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:8396dcda-329a-3fd8-895d-95aa6eae75a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8396dcda-329a-3fd8-895d-95aa6eae75a5', 12, NULL, 'The Wounded', 'The Wounded', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8396dcda-329a-3fd8-895d-95aa6eae75a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'The Scent of Love', part.name_en = 'The Scent of Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:8e422250-d144-30b2-9d20-9b2d77b3462a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e422250-d144-30b2-9d20-9b2d77b3462a', 13, NULL, 'The Scent of Love', 'The Scent of Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e422250-d144-30b2-9d20-9b2d77b3462a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'All Imperfect Things', part.name_en = 'All Imperfect Things',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:8e6ccf88-260b-3cb3-8b44-8a1d785f7773' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e6ccf88-260b-3cb3-8b44-8a1d785f7773', 14, NULL, 'All Imperfect Things', 'All Imperfect Things', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e6ccf88-260b-3cb3-8b44-8a1d785f7773'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'I Clipped Your Wing', part.name_en = 'I Clipped Your Wing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:90ce1c4a-94ac-3cb8-92da-0065aeb97a13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90ce1c4a-94ac-3cb8-92da-0065aeb97a13', 15, NULL, 'I Clipped Your Wing', 'I Clipped Your Wing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90ce1c4a-94ac-3cb8-92da-0065aeb97a13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'The Attraction of the Pedalling Ankle', part.name_en = 'The Attraction of the Pedalling Ankle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:a2da4ab4-d363-41f6-bd27-f63ae21f54ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2da4ab4-d363-41f6-bd27-f63ae21f54ca', 16, NULL, 'The Attraction of the Pedalling Ankle', 'The Attraction of the Pedalling Ankle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2da4ab4-d363-41f6-bd27-f63ae21f54ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Deep Into the Forest', part.name_en = 'Deep Into the Forest',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:a877a50a-cd6e-39cb-83d0-6e4db7145d44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a877a50a-cd6e-39cb-83d0-6e4db7145d44', 17, NULL, 'Deep Into the Forest', 'Deep Into the Forest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a877a50a-cd6e-39cb-83d0-6e4db7145d44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'The Promise', part.name_en = 'The Promise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:ba8050cc-8294-36eb-af43-442653b83e47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba8050cc-8294-36eb-af43-442653b83e47', 18, NULL, 'The Promise', 'The Promise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba8050cc-8294-36eb-af43-442653b83e47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'The Mood That Passes Through You', part.name_en = 'The Mood That Passes Through You',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:c79c5535-f559-39ca-badf-4b535af4c845' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c79c5535-f559-39ca-badf-4b535af4c845', 19, NULL, 'The Mood That Passes Through You', 'The Mood That Passes Through You', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c79c5535-f559-39ca-badf-4b535af4c845'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'The Heart Asks Pleasure First', part.name_en = 'The Heart Asks Pleasure First',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:cb0bd4e8-b91c-3b77-9612-57ad69dc6cde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb0bd4e8-b91c-3b77-9612-57ad69dc6cde', 20, NULL, 'The Heart Asks Pleasure First', 'The Heart Asks Pleasure First', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb0bd4e8-b91c-3b77-9612-57ad69dc6cde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Little Impulse', part.name_en = 'Little Impulse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:d4f00677-9139-3f84-a489-89c123d03768' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4f00677-9139-3f84-a489-89c123d03768', 21, NULL, 'Little Impulse', 'Little Impulse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4f00677-9139-3f84-a489-89c123d03768'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'A Bed of Ferns', part.name_en = 'A Bed of Ferns',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19915 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:f69b9f14-a8ac-3204-9b06-3bdb1787a13b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f69b9f14-a8ac-3204-9b06-3bdb1787a13b', 22, NULL, 'A Bed of Ferns', 'A Bed of Ferns', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19915 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f69b9f14-a8ac-3204-9b06-3bdb1787a13b'
);


-- None The Piano from Hell

UPDATE pieces piece
SET piece.title = 'The Piano from Hell', piece.title_en = 'The Piano from Hell',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18661 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Self-Laudatory Hymn of Inanna and her Omnipotence

UPDATE pieces piece
SET piece.title = 'The Self-Laudatory Hymn of Inanna and her Omnipotence', piece.title_en = 'The Self-Laudatory Hymn of Inanna and her Omnipotence',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18567 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Singing of the Names

UPDATE pieces piece
SET piece.title = 'The Singing of the Names', piece.title_en = 'The Singing of the Names',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16081 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Sorcerer, the Warlock, His Wife & Her Troll

UPDATE pieces piece
SET piece.title = 'The Sorcerer, the Warlock, His Wife & Her Troll', piece.title_en = 'The Sorcerer, the Warlock, His Wife & Her Troll',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19503 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Submission

UPDATE pieces piece
SET piece.title = 'The Submission', piece.title_en = 'The Submission',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19864 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Truth

UPDATE pieces piece
SET piece.title = 'The Truth', piece.title_en = 'The Truth',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19654 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Wish

UPDATE pieces piece
SET piece.title = 'The Wish', piece.title_en = 'The Wish',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16492 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Thoughtful

UPDATE pieces piece
SET piece.title = 'Thoughtful', piece.title_en = 'Thoughtful',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17635 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Time Lapse

UPDATE pieces piece
SET piece.title = 'Time Lapse', piece.title_en = 'Time Lapse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17253 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Time Will Pronounce

UPDATE pieces piece
SET piece.title = 'Time Will Pronounce', piece.title_en = 'Time Will Pronounce',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19237 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Traces

UPDATE pieces piece
SET piece.title = 'Traces', piece.title_en = 'Traces',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17135 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Traffic. Street Sounds

UPDATE pieces piece
SET piece.title = 'Traffic. Street Sounds', piece.title_en = 'Traffic. Street Sounds',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19579 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trysting Fields

UPDATE pieces piece
SET piece.title = 'Trysting Fields', piece.title_en = 'Trysting Fields',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26020 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trysting Fields / Sheep 'n' Tides

UPDATE pieces piece
SET piece.title = 'Trysting Fields / Sheep ''n'' Tides', piece.title_en = 'Trysting Fields / Sheep ''n'' Tides',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19819 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trysting Fields/Sheep & Tides

UPDATE pieces piece
SET piece.title = 'Trysting Fields/Sheep & Tides', piece.title_en = 'Trysting Fields/Sheep & Tides',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16151 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Up Stairs

UPDATE pieces piece
SET piece.title = 'Up Stairs', piece.title_en = 'Up Stairs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16111 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Upon Drinking in a Bowl

UPDATE pieces piece
SET piece.title = 'Upon Drinking in a Bowl', piece.title_en = 'Upon Drinking in a Bowl',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19597 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Upon Leaving His Mistress

UPDATE pieces piece
SET piece.title = 'Upon Leaving His Mistress', piece.title_en = 'Upon Leaving His Mistress',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17191 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vermeer's Wife

UPDATE pieces piece
SET piece.title = 'Vermeer''s Wife', piece.title_en = 'Vermeer''s Wife',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18202 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Walls

UPDATE pieces piece
SET piece.title = 'Walls', piece.title_en = 'Walls',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16533 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Water

UPDATE pieces piece
SET piece.title = 'Water', piece.title_en = 'Water',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17947 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Water Dances

UPDATE pieces piece
SET piece.title = 'Water Dances', piece.title_en = 'Water Dances',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17957 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Dipping', part.name_en = 'Water Dances: I. Dipping',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17957 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:b587f5f1-1e89-426f-8e39-d99bd1b3246f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b587f5f1-1e89-426f-8e39-d99bd1b3246f', 1, 'I', 'Dipping', 'Water Dances: I. Dipping', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17957 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b587f5f1-1e89-426f-8e39-d99bd1b3246f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Stroking', part.name_en = 'Water Dances: II. Stroking',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17957 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:3b37d177-9bd5-4894-a03b-763774473442' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b37d177-9bd5-4894-a03b-763774473442', 2, 'II', 'Stroking', 'Water Dances: II. Stroking', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17957 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b37d177-9bd5-4894-a03b-763774473442'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Submerging', part.name_en = 'Water Dances: III. Submerging',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17957 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:fa479d4b-9f2b-470b-b535-d97d25778bfb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa479d4b-9f2b-470b-b535-d97d25778bfb', 3, 'III', 'Submerging', 'Water Dances: III. Submerging', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17957 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa479d4b-9f2b-470b-b535-d97d25778bfb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Gliding', part.name_en = 'Water Dances: IV. Gliding',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17957 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:191f7ab5-714c-4e08-9a2d-ed9a6fb9bb53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:191f7ab5-714c-4e08-9a2d-ed9a6fb9bb53', 4, 'IV', 'Gliding', 'Water Dances: IV. Gliding', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17957 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:191f7ab5-714c-4e08-9a2d-ed9a6fb9bb53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Synchronising', part.name_en = 'Water Dances: V. Synchronising',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17957 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:51055ca8-674f-4ba5-b023-a8c5a9a32b78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51055ca8-674f-4ba5-b023-a8c5a9a32b78', 5, 'V', 'Synchronising', 'Water Dances: V. Synchronising', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17957 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51055ca8-674f-4ba5-b023-a8c5a9a32b78'
);


-- None We Are at a Film Studio

UPDATE pieces piece
SET piece.title = 'We Are at a Film Studio', piece.title_en = 'We Are at a Film Studio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17888 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Wedding Tango

UPDATE pieces piece
SET piece.title = 'Wedding Tango', piece.title_en = 'Wedding Tango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19465 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None What Do You See Now?

UPDATE pieces piece
SET piece.title = 'What Do You See Now?', piece.title_en = 'What Do You See Now?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19750 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None What Is This? … It’s a Square

UPDATE pieces piece
SET piece.title = 'What Is This? … It’s a Square', piece.title_en = 'What Is This? … It’s a Square',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16332 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None What Is This? … Six Inches in Length

UPDATE pieces piece
SET piece.title = 'What Is This? … Six Inches in Length', piece.title_en = 'What Is This? … Six Inches in Length',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16330 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None What’s the Time?

UPDATE pieces piece
SET piece.title = 'What’s the Time?', piece.title_en = 'What’s the Time?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17612 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Where Was His Hat?

UPDATE pieces piece
SET piece.title = 'Where Was His Hat?', piece.title_en = 'Where Was His Hat?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19389 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Where the Bee Dances

UPDATE pieces piece
SET piece.title = 'Where the Bee Dances', piece.title_en = 'Where the Bee Dances',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17250 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Wings

UPDATE pieces piece
SET piece.title = 'Wings', piece.title_en = 'Wings',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18698 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Wonderland>

UPDATE pieces piece
SET piece.title = '영화음악 <Wonderland>', piece.title_en = 'Wonderland',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17349 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Jack', part.name_en = 'Jack',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17349 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:02e99988-1b3e-410e-9c47-9bece4909637' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02e99988-1b3e-410e-9c47-9bece4909637', 1, NULL, 'Jack', 'Jack', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17349 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02e99988-1b3e-410e-9c47-9bece4909637'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Eileen', part.name_en = 'Eileen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17349 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:170f69be-de83-4bbb-867b-c9aeef4b964c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:170f69be-de83-4bbb-867b-c9aeef4b964c', 2, NULL, 'Eileen', 'Eileen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17349 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:170f69be-de83-4bbb-867b-c9aeef4b964c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Debbie', part.name_en = 'Debbie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17349 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:2b817a0b-f765-45c2-af8c-93e6516854b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b817a0b-f765-45c2-af8c-93e6516854b3', 3, NULL, 'Debbie', 'Debbie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17349 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b817a0b-f765-45c2-af8c-93e6516854b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Eddie', part.name_en = 'Eddie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17349 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:3d9ce005-2d81-49fa-856a-ea49b5239243' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d9ce005-2d81-49fa-856a-ea49b5239243', 4, NULL, 'Eddie', 'Eddie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17349 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d9ce005-2d81-49fa-856a-ea49b5239243'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Darren', part.name_en = 'Darren',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17349 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:8c258d70-453b-4640-98c7-d1147f76af9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c258d70-453b-4640-98c7-d1147f76af9e', 5, NULL, 'Darren', 'Darren', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17349 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c258d70-453b-4640-98c7-d1147f76af9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Franklyn', part.name_en = 'Franklyn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17349 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:b44b5ccf-90d6-4fe2-98c4-9882fd45741a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b44b5ccf-90d6-4fe2-98c4-9882fd45741a', 6, NULL, 'Franklyn', 'Franklyn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17349 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b44b5ccf-90d6-4fe2-98c4-9882fd45741a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Unnamed', part.name_en = 'Unnamed',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17349 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:ceaf091b-2af1-44cc-9f03-5fbe5fef0ceb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceaf091b-2af1-44cc-9f03-5fbe5fef0ceb', 7, NULL, 'Unnamed', 'Unnamed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17349 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceaf091b-2af1-44cc-9f03-5fbe5fef0ceb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Bill', part.name_en = 'Bill',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17349 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:d162d419-00cf-4058-af1c-c268e41520b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d162d419-00cf-4058-af1c-c268e41520b1', 8, NULL, 'Bill', 'Bill', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17349 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d162d419-00cf-4058-af1c-c268e41520b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Dan', part.name_en = 'Dan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17349 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:e1854c0f-134d-4844-9e55-eb8abf1f23c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1854c0f-134d-4844-9e55-eb8abf1f23c7', 9, NULL, 'Dan', 'Dan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17349 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1854c0f-134d-4844-9e55-eb8abf1f23c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Molly', part.name_en = 'Molly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17349 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:e603c9a2-4660-4793-9e74-66060458b779' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e603c9a2-4660-4793-9e74-66060458b779', 10, NULL, 'Molly', 'Molly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17349 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e603c9a2-4660-4793-9e74-66060458b779'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Nadia', part.name_en = 'Nadia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17349 AND p.composer_id = 280 AND part.part_key = 'musicbrainz:f95f6e2e-e8a3-487e-9d46-05d1a10e3d6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f95f6e2e-e8a3-487e-9d46-05d1a10e3d6e', 11, NULL, 'Nadia', 'Nadia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17349 AND p.composer_id = 280
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f95f6e2e-e8a3-487e-9d46-05d1a10e3d6e'
);


-- None Yellow Beach

UPDATE pieces piece
SET piece.title = 'Yellow Beach', piece.title_en = 'Yellow Beach',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18293 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None You Can See Very Clearly

UPDATE pieces piece
SET piece.title = 'You Can See Very Clearly', piece.title_en = 'You Can See Very Clearly',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17863 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Your Husband’s a Painter, I See

UPDATE pieces piece
SET piece.title = 'Your Husband’s a Painter, I See', piece.title_en = 'Your Husband’s a Painter, I See',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18375 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Yourself for the Day

UPDATE pieces piece
SET piece.title = 'Yourself for the Day', piece.title_en = 'Yourself for the Day',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18683 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None [That's Why] I’m Here

UPDATE pieces piece
SET piece.title = '[That''s Why] I’m Here', piece.title_en = '[That''s Why] I’m Here',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16055 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None “Urtod” (re‐recording)

UPDATE pieces piece
SET piece.title = '“Urtod” (re‐recording)', piece.title_en = '“Urtod” (re‐recording)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16859 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None … [Mistake His] Wife for a Hat?

UPDATE pieces piece
SET piece.title = '… [Mistake His] Wife for a Hat?', piece.title_en = '… [Mistake His] Wife for a Hat?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19594 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Ramble in St. James's Park

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'A Ramble in St. James''s Park', 'A Ramble in St. James''s Park', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'A Ramble in St. James''s Park'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51061366-caa9-46db-96c1-741c2b09d801'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51061366-caa9-46db-96c1-741c2b09d801'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'A Ramble in St. James''s Park' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51061366-caa9-46db-96c1-741c2b09d801'
);


-- None A Satire Against Mankind

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'A Satire Against Mankind', 'A Satire Against Mankind', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'A Satire Against Mankind'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54f6d9c9-87fa-4702-99f0-046f6c393d50'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '54f6d9c9-87fa-4702-99f0-046f6c393d50'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'A Satire Against Mankind' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54f6d9c9-87fa-4702-99f0-046f6c393d50'
);


-- None A Satire Against Reason

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'A Satire Against Reason', 'A Satire Against Reason', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'A Satire Against Reason'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1d97d1d4-fde2-4710-addc-a0dc1f7a6eac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1d97d1d4-fde2-4710-addc-a0dc1f7a6eac'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'A Satire Against Reason' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1d97d1d4-fde2-4710-addc-a0dc1f7a6eac'
);


-- None Abel Carries Ephraim

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Abel Carries Ephraim', 'Abel Carries Ephraim', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Abel Carries Ephraim'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e1c5295-8394-4323-9eb4-7d35bf5b68d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1e1c5295-8394-4323-9eb4-7d35bf5b68d5'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Abel Carries Ephraim' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e1c5295-8394-4323-9eb4-7d35bf5b68d5'
);


-- None Against Constancy

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Against Constancy', 'Against Constancy', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Against Constancy'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ae2e380-ec8b-40b6-a400-ef11b4501a48'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ae2e380-ec8b-40b6-a400-ef11b4501a48'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Against Constancy' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ae2e380-ec8b-40b6-a400-ef11b4501a48'
);


-- None Chase

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Chase', 'Chase', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Chase'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84647e88-2e82-4e62-b6db-36553beee324'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '84647e88-2e82-4e62-b6db-36553beee324'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Chase' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84647e88-2e82-4e62-b6db-36553beee324'
);


-- None Child Bearer

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Child Bearer', 'Child Bearer', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Child Bearer'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b15cae0-738c-40f3-930e-4f3d7cd1ab17'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3b15cae0-738c-40f3-930e-4f3d7cd1ab17'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Child Bearer' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b15cae0-738c-40f3-930e-4f3d7cd1ab17'
);


-- None Drowning by Number 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Drowning by Number 2', 'Drowning by Number 2', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Drowning by Number 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f4226a5-3995-4abb-9d35-8ca55a77d488'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1f4226a5-3995-4abb-9d35-8ca55a77d488'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Drowning by Number 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f4226a5-3995-4abb-9d35-8ca55a77d488'
);


-- None 영화음악 <Enemy Zero>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <Enemy Zero>', 'Enemy Zero', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <Enemy Zero>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0bc4466-ed35-4e34-8df1-a813be5f75ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f0bc4466-ed35-4e34-8df1-a813be5f75ee'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0bc4466-ed35-4e34-8df1-a813be5f75ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01e22d33-656e-43b3-9a9c-ef6067cad893', 1, NULL, 'Digital Tragedy', 'Digital Tragedy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01e22d33-656e-43b3-9a9c-ef6067cad893'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0aae485f-3b7a-4f1e-be34-a7d8c42d3726', 2, NULL, 'Enemy Zero', 'Enemy Zero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0aae485f-3b7a-4f1e-be34-a7d8c42d3726'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a1ff0b7-8808-434f-863a-72b2bb792e26', 3, NULL, 'Battle', 'Battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a1ff0b7-8808-434f-863a-72b2bb792e26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b85178c-d81c-4fdf-a87d-f37558980891', 4, NULL, 'Lamentation', 'Lamentation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b85178c-d81c-4fdf-a87d-f37558980891'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cfc78bd-ff87-46c0-aa1e-50c616289783', 5, NULL, 'Laura''s Theme', 'Laura''s Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cfc78bd-ff87-46c0-aa1e-50c616289783'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37a804ff-66e1-4332-b41e-9f209ffbf9ad', 6, NULL, 'Love Theme', 'Love Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37a804ff-66e1-4332-b41e-9f209ffbf9ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d534557-e3b1-4c69-b72c-7a771f591f1d', 7, NULL, 'Aspects of Love', 'Aspects of Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d534557-e3b1-4c69-b72c-7a771f591f1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66658bdb-d17b-4092-aea5-90f83ceecb6c', 8, NULL, 'Confusion', 'Confusion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66658bdb-d17b-4092-aea5-90f83ceecb6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6192f54-dac0-4af4-92f3-d92561ee71b6', 9, NULL, 'The Last Movement', 'The Last Movement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6192f54-dac0-4af4-92f3-d92561ee71b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb6ede97-622a-49b3-8385-b266e9f11973', 10, NULL, 'Invisible Enemy', 'Invisible Enemy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb6ede97-622a-49b3-8385-b266e9f11973'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d11e07b9-268c-49f8-be62-2dc722273a15', 11, NULL, 'Malfunction', 'Malfunction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d11e07b9-268c-49f8-be62-2dc722273a15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d656c8dc-0249-4bbd-9169-1747a9d1aa9e', 12, NULL, 'Digital Complex', 'Digital Complex', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d656c8dc-0249-4bbd-9169-1747a9d1aa9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7e54c95-bc39-4366-b589-5024d2bf6dfb', 13, NULL, 'Agony', 'Agony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7e54c95-bc39-4366-b589-5024d2bf6dfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9d1e8df-35d4-4610-ae6d-4dfa67350f98', 14, NULL, 'Laura''s Dream', 'Laura''s Dream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '영화음악 <Enemy Zero>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9d1e8df-35d4-4610-ae6d-4dfa67350f98'
);


-- None History of the Insipid

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'History of the Insipid', 'History of the Insipid', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'History of the Insipid'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6c00913-c30f-495e-ba32-1ea4f64b2f58'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a6c00913-c30f-495e-ba32-1ea4f64b2f58'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'History of the Insipid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6c00913-c30f-495e-ba32-1ea4f64b2f58'
);


-- None Into the Woods

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Into the Woods', 'Into the Woods', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Into the Woods'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4d2a335-eb19-4829-b778-d5df0a9802dd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4d2a335-eb19-4829-b778-d5df0a9802dd'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Into the Woods' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4d2a335-eb19-4829-b778-d5df0a9802dd'
);


-- None Knights at School

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Knights at School', 'Knights at School', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Knights at School'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a982f95f-3805-423e-863b-1f42df7cdc92'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a982f95f-3805-423e-863b-1f42df7cdc92'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Knights at School' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a982f95f-3805-423e-863b-1f42df7cdc92'
);


-- None Magic Forest

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Magic Forest', 'Magic Forest', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Magic Forest'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9169fc1e-d556-4916-b00e-844f5a37692b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9169fc1e-d556-4916-b00e-844f5a37692b'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Magic Forest' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9169fc1e-d556-4916-b00e-844f5a37692b'
);


-- None Main Theme

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Main Theme', 'Main Theme', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Main Theme'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a09563d5-39f0-40fe-b010-15a60d9be7ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a09563d5-39f0-40fe-b010-15a60d9be7ba'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Main Theme' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a09563d5-39f0-40fe-b010-15a60d9be7ba'
);


-- None Meeting the Moose

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Meeting the Moose', 'Meeting the Moose', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Meeting the Moose'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eec62a4b-2ed5-48f9-b659-518b22e2e598'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eec62a4b-2ed5-48f9-b659-518b22e2e598'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Meeting the Moose' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eec62a4b-2ed5-48f9-b659-518b22e2e598'
);


-- None Memorial

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Memorial', 'Memorial', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Memorial'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a7c1cec-6210-48f9-b0fd-2ea9b4b90edd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4a7c1cec-6210-48f9-b0fd-2ea9b4b90edd'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Memorial' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a7c1cec-6210-48f9-b0fd-2ea9b4b90edd'
);


-- None My Lord All-Pride

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'My Lord All-Pride', 'My Lord All-Pride', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'My Lord All-Pride'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f067484-2e4f-416c-a78c-2a3f573a04d2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0f067484-2e4f-416c-a78c-2a3f573a04d2'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'My Lord All-Pride' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f067484-2e4f-416c-a78c-2a3f573a04d2'
);


-- None Queen of the Night

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Queen of the Night', 'Queen of the Night', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Queen of the Night'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c8c62d5-9054-4881-941f-c79d194328c5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c8c62d5-9054-4881-941f-c79d194328c5'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Queen of the Night' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c8c62d5-9054-4881-941f-c79d194328c5'
);


-- None Songs for Tony

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Songs for Tony', 'Songs for Tony', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Songs for Tony'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a238b251-4a1a-48d1-a586-02cb2ffbbeba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a238b251-4a1a-48d1-a586-02cb2ffbbeba'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Songs for Tony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a238b251-4a1a-48d1-a586-02cb2ffbbeba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:529bf53a-2366-4abf-8094-49814f8a5a90', 1, 'I', 'Aggressive', 'Songs for Tony: I. Aggressive', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Songs for Tony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:529bf53a-2366-4abf-8094-49814f8a5a90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15361c3c-38ea-43d9-bddd-b8493e6f629e', 2, 'II', 'Con rubato', 'Songs for Tony: II. Con rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Songs for Tony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15361c3c-38ea-43d9-bddd-b8493e6f629e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80a0eebb-f6c5-4fd2-86ce-8958a3041f98', 3, 'III', 'Warm', 'Songs for Tony: III. Warm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Songs for Tony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80a0eebb-f6c5-4fd2-86ce-8958a3041f98'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00113433-ac10-4823-8943-d40419ba18b0', 4, 'IV', 'Simply', 'Songs for Tony: IV. Simply', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Songs for Tony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00113433-ac10-4823-8943-d40419ba18b0'
);


-- None 현악 4중주 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 1번', 'String Quartet no. 1', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7702f48c-ec36-4834-9ebc-3293ede62ee6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7702f48c-ec36-4834-9ebc-3293ede62ee6'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7702f48c-ec36-4834-9ebc-3293ede62ee6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7c65b3f-4b3f-429d-bae4-17bab3791bdd', 1, 'I', 'Beginning', 'String Quartet no. 1: I. Beginning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7c65b3f-4b3f-429d-bae4-17bab3791bdd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47b34c02-93d2-4376-b90f-919c4079b128', 2, 'II', 'Figure B', 'String Quartet no. 1: II. Figure B', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47b34c02-93d2-4376-b90f-919c4079b128'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abbe1be5-a4e5-4842-87d9-30839b4e77ef', 3, 'III', 'Figure C', 'String Quartet no. 1: III. Figure C', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abbe1be5-a4e5-4842-87d9-30839b4e77ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bbf8933-fef0-47fb-8c54-2b9307f5a8a4', 4, 'IV', 'Figure D', 'String Quartet no. 1: IV. Figure D', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bbf8933-fef0-47fb-8c54-2b9307f5a8a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69673ea1-1808-482e-bac0-d34be7612fce', 5, 'V', 'Figure E', 'String Quartet no. 1: V. Figure E', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69673ea1-1808-482e-bac0-d34be7612fce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3477c786-9992-4d52-b656-e7b4d4cd34b1', 6, 'VI', 'Figure F', 'String Quartet no. 1: VI. Figure F', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3477c786-9992-4d52-b656-e7b4d4cd34b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:414336bd-d676-418d-9756-febaf54a396b', 7, 'VII', 'Figure G', 'String Quartet no. 1: VII. Figure G', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:414336bd-d676-418d-9756-febaf54a396b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:088ca9a0-0591-49d6-9c32-d3d73bdfb476', 8, 'VIII', 'Figure H', 'String Quartet no. 1: VIII. Figure H', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:088ca9a0-0591-49d6-9c32-d3d73bdfb476'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81730f2e-e32a-485a-ab72-6648d9add754', 9, 'IX', 'Figure I', 'String Quartet no. 1: IX. Figure I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81730f2e-e32a-485a-ab72-6648d9add754'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69f4089d-9cae-42c6-b0c4-f72bdf5f3765', 10, 'X', 'Figure J', 'String Quartet no. 1: X. Figure J', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69f4089d-9cae-42c6-b0c4-f72bdf5f3765'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1297d008-b939-4be2-9f11-695bcb8961e4', 11, 'XI', 'Figure K', 'String Quartet no. 1: XI. Figure K', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1297d008-b939-4be2-9f11-695bcb8961e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:613322b8-0b8d-45b6-b3e4-330f77ad32ef', 12, 'XII', 'Figure L', 'String Quartet no. 1: XII. Figure L', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:613322b8-0b8d-45b6-b3e4-330f77ad32ef'
);


-- None 현악 4중주 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 2번', 'String Quartet no. 2', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f136e3c5-9102-42a1-b4b0-e6ea79ea71a8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f136e3c5-9102-42a1-b4b0-e6ea79ea71a8'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f136e3c5-9102-42a1-b4b0-e6ea79ea71a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76cea8e3-1a5a-4fd1-8a0d-6fa8f372350a', 1, NULL, 'I', 'String Quartet no. 2: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76cea8e3-1a5a-4fd1-8a0d-6fa8f372350a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36c9d40b-e766-46a7-a640-c2896d618c23', 2, NULL, 'II', 'String Quartet no. 2: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36c9d40b-e766-46a7-a640-c2896d618c23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fa3cf1d-afd7-4b4a-9926-51a6491e66de', 3, NULL, 'III', 'String Quartet no. 2: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fa3cf1d-afd7-4b4a-9926-51a6491e66de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20622a18-90c7-4fb1-a227-9b7b3a580a35', 4, NULL, 'IV', 'String Quartet no. 2: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20622a18-90c7-4fb1-a227-9b7b3a580a35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f82a96d-251e-4021-a5ca-922ea2b0a9fc', 5, NULL, 'V', 'String Quartet no. 2: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f82a96d-251e-4021-a5ca-922ea2b0a9fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc47dedf-a755-4c77-a3a3-653d012a30cf', 6, 'VI', 'Bright and breezy', 'String Quartet no. 2: VI. Bright and breezy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc47dedf-a755-4c77-a3a3-653d012a30cf'
);


-- None 현악 4중주 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 3번', 'String Quartet no. 3', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04d42c4a-4e08-4838-8b2b-cfed92271d66'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '04d42c4a-4e08-4838-8b2b-cfed92271d66'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04d42c4a-4e08-4838-8b2b-cfed92271d66'
);


-- None 현악 4중주 4번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 4번', 'String Quartet no. 4', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 4번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f4d5d57c-3ac7-46fd-a627-73b627f0159e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f4d5d57c-3ac7-46fd-a627-73b627f0159e'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f4d5d57c-3ac7-46fd-a627-73b627f0159e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8d41111-71d3-4b66-ad11-911d42f6cd65', 1, NULL, 'I', 'String Quartet no. 4: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8d41111-71d3-4b66-ad11-911d42f6cd65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce6969e0-a329-45a9-8b46-2aad617ae699', 2, NULL, 'II', 'String Quartet no. 4: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce6969e0-a329-45a9-8b46-2aad617ae699'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3750f7df-de09-42cc-9418-8621b7e976b0', 3, NULL, 'III', 'String Quartet no. 4: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3750f7df-de09-42cc-9418-8621b7e976b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6239a378-f608-4aff-9881-2f558693f154', 4, NULL, 'IV', 'String Quartet no. 4: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6239a378-f608-4aff-9881-2f558693f154'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b46d0025-d5d2-46be-938d-536c5cb74f8d', 5, NULL, 'V', 'String Quartet no. 4: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b46d0025-d5d2-46be-938d-536c5cb74f8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e807491-da3c-4d3b-a999-5b3a11976cbe', 6, NULL, 'VI', 'String Quartet no. 4: VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e807491-da3c-4d3b-a999-5b3a11976cbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1274b9e3-8617-4747-84d4-0c32db381637', 7, NULL, 'VII', 'String Quartet no. 4: VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1274b9e3-8617-4747-84d4-0c32db381637'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4c7b355-dc76-43fa-9ae0-0c13195ec138', 8, NULL, 'VIII', 'String Quartet no. 4: VIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4c7b355-dc76-43fa-9ae0-0c13195ec138'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afd96d7b-c741-4234-a553-60e5845ab11f', 9, NULL, 'IX', 'String Quartet no. 4: IX', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afd96d7b-c741-4234-a553-60e5845ab11f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:849e2b2c-82e6-4738-aa36-167e8c72f7fc', 10, NULL, 'X', 'String Quartet no. 4: X', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:849e2b2c-82e6-4738-aa36-167e8c72f7fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acff9db1-a86e-4b1d-b6d0-1b94c3874241', 11, NULL, 'XI', 'String Quartet no. 4: XI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acff9db1-a86e-4b1d-b6d0-1b94c3874241'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:314a910c-90d4-4b39-8900-0a808401e780', 12, NULL, 'XII', 'String Quartet no. 4: XII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:314a910c-90d4-4b39-8900-0a808401e780'
);


-- None 교향곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번', 'Symphony No. 2', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92a86113-34f6-4af2-8dfb-d17d14609e23'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '92a86113-34f6-4af2-8dfb-d17d14609e23'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92a86113-34f6-4af2-8dfb-d17d14609e23'
);


-- None The Disposition of the Linen

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Disposition of the Linen', 'The Disposition of the Linen', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Disposition of the Linen'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7080f2ab-41a3-471b-9e6d-d2631a8a6f09'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7080f2ab-41a3-471b-9e6d-d2631a8a6f09'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'The Disposition of the Linen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7080f2ab-41a3-471b-9e6d-d2631a8a6f09'
);


-- None The Mistress

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Mistress', 'The Mistress', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Mistress'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1692949a-b2a7-47fc-bf42-b077664f7294'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1692949a-b2a7-47fc-bf42-b077664f7294'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'The Mistress' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1692949a-b2a7-47fc-bf42-b077664f7294'
);


-- None The Other Side

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Other Side', 'The Other Side', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Other Side'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2029f87a-cb62-3685-becb-7a8ffc7d0f8a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2029f87a-cb62-3685-becb-7a8ffc7d0f8a'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'The Other Side' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2029f87a-cb62-3685-becb-7a8ffc7d0f8a'
);


-- None Upon Nothing

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Upon Nothing', 'Upon Nothing', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Upon Nothing'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c746bac-4eb6-42fb-a5aa-8a5e6815f90b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5c746bac-4eb6-42fb-a5aa-8a5e6815f90b'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Upon Nothing' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c746bac-4eb6-42fb-a5aa-8a5e6815f90b'
);


-- None Utopia

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Utopia', 'Utopia', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Utopia'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be35f937-b75e-49a5-8735-37ab23239eac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be35f937-b75e-49a5-8735-37ab23239eac'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Utopia' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be35f937-b75e-49a5-8735-37ab23239eac'
);


-- None Wheelbarrow Walk

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Wheelbarrow Walk', 'Wheelbarrow Walk', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Wheelbarrow Walk'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be5e84a4-7166-444d-b3c2-c96c9764e979'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be5e84a4-7166-444d-b3c2-c96c9764e979'
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Wheelbarrow Walk' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be5e84a4-7166-444d-b3c2-c96c9764e979'
);


-- 카탈로그에 대응이 없는 seed 작품 30개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 280 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15968, 16074, 16497, 16557, 16658, 16679, 16732, 16743, 16908, 16958, 17016, 17259, 17281, 17660, 17741, 17872, 18186, 18444, 18560, 18860,
    19155, 19252, 19416, 19428, 19504, 19644, 19790, 19807, 20015, 23104
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
