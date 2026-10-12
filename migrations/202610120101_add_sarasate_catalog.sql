-- 사라사테 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 49개(묶음 4, 다악장 0, 낱곡 45),
-- 새 작품 3개, part 8개, 그 아래 0개.
-- seed 57개 중 45개를 작품·part 에 잇고, 12개를 숨기고, 0개는 그대로 둔다.
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

-- Op. 18 Airs espagnols

UPDATE pieces piece
SET piece.title = 'Airs espagnols', piece.title_en = 'Airs espagnols, op. 18',
    piece.type = 'song', piece.opus_number = 'Op. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9162 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 34 Airs écossais

UPDATE pieces piece
SET piece.title = 'Airs écossais', piece.title_en = 'Airs écossais, op. 34',
    piece.type = 'song', piece.opus_number = 'Op. 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10433 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 31 Balada

UPDATE pieces piece
SET piece.title = 'Balada', piece.title_en = 'Balada, op. 31',
    piece.type = 'song', piece.opus_number = 'Op. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9266 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 30 볼레로

UPDATE pieces piece
SET piece.title = '볼레로', piece.title_en = 'Bolero, op. 30',
    piece.type = 'song', piece.opus_number = 'Op. 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7886 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 49 Canciones rusas

UPDATE pieces piece
SET piece.title = 'Canciones rusas', piece.title_en = 'Canciones rusas, op. 49',
    piece.type = 'song', piece.opus_number = 'Op. 49',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10395 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 5 Concert Fantasy on Gounod’s Roméo et Juliette

UPDATE pieces piece
SET piece.title = 'Concert Fantasy on Gounod’s Roméo et Juliette', piece.title_en = 'Concert Fantasy on Gounod’s Roméo et Juliette, op. 5',
    piece.type = 'song', piece.opus_number = 'Op. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9053 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 54 Concert Fantasy on Mozart’s Die Zauberflöte

UPDATE pieces piece
SET piece.title = 'Concert Fantasy on Mozart’s Die Zauberflöte', piece.title_en = 'Concert Fantasy on Mozart’s Die Zauberflöte, op. 54',
    piece.type = 'song', piece.opus_number = 'Op. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8626 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 13 Concert Fantasy on themes from Gounod's "Faust"

UPDATE pieces piece
SET piece.title = 'Concert Fantasy on themes from Gounod''s "Faust"', piece.title_en = 'Concert Fantasy on themes from Gounod''s "Faust", op. 13',
    piece.type = 'song', piece.opus_number = 'Op. 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8599 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 7 Confidences

UPDATE pieces piece
SET piece.title = 'Confidences', piece.title_en = 'Confidences, op. 7',
    piece.type = 'song', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8925 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Danse espagnole, op. 37 "Adiós montañas mías"

UPDATE pieces piece
SET piece.title = 'Danse espagnole, op. 37 "Adiós montañas mías"', piece.title_en = 'Danse espagnole, op. 37 "Adiós montañas mías"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10894 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 29 El canto del ruiseñor

UPDATE pieces piece
SET piece.title = 'El canto del ruiseñor', piece.title_en = 'El canto del ruiseñor, op. 29',
    piece.type = 'song', piece.opus_number = 'Op. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9750 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantaisie Caprice

UPDATE pieces piece
SET piece.title = 'Fantaisie Caprice', piece.title_en = 'Fantaisie Caprice',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8282 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 3 Fantasie sur La Dame Blanche

UPDATE pieces piece
SET piece.title = 'Fantasie sur La Dame Blanche', piece.title_en = 'Fantasie sur La Dame Blanche, op. 3',
    piece.type = 'song', piece.opus_number = 'Op. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10564 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 46 Gondoliéra veneziana

UPDATE pieces piece
SET piece.title = 'Gondoliéra veneziana', piece.title_en = 'Gondoliéra veneziana, op. 46',
    piece.type = 'song', piece.opus_number = 'Op. 46',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9520 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 2 Homenaje a Rossini

UPDATE pieces piece
SET piece.title = 'Homenaje a Rossini', piece.title_en = 'Homenaje a Rossini, op. 2',
    piece.type = 'song', piece.opus_number = 'Op. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10953 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 40 Introduction et Fandango varié

UPDATE pieces piece
SET piece.title = 'Introduction et Fandango varié', piece.title_en = 'Introduction et Fandango varié, op. 40',
    piece.type = 'song', piece.opus_number = 'Op. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9534 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 41 Introduction et caprice-jota

UPDATE pieces piece
SET piece.title = 'Introduction et caprice-jota', piece.title_en = 'Introduction et caprice-jota, op. 41',
    piece.type = 'song', piece.opus_number = 'Op. 41',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8021 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 43 Introduction et tarantelle

UPDATE pieces piece
SET piece.title = 'Introduction et tarantelle', piece.title_en = 'Introduction et tarantelle, op. 43',
    piece.type = 'song', piece.opus_number = 'Op. 43',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8680 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 27 Jota aragonesa

UPDATE pieces piece
SET piece.title = 'Jota aragonesa', piece.title_en = 'Jota aragonesa, op. 27',
    piece.type = 'song', piece.opus_number = 'Op. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10870 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 52 Jota de Pablo

UPDATE pieces piece
SET piece.title = 'Jota de Pablo', piece.title_en = 'Jota de Pablo, op. 52',
    piece.type = 'song', piece.opus_number = 'Op. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9853 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 50 Jota de Pamplona

UPDATE pieces piece
SET piece.title = 'Jota de Pamplona', piece.title_en = 'Jota de Pamplona, op. 50',
    piece.type = 'song', piece.opus_number = 'Op. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9389 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 36 Jota de San Fermín

UPDATE pieces piece
SET piece.title = 'Jota de San Fermín', piece.title_en = 'Jota de San Fermín, op. 36',
    piece.type = 'song', piece.opus_number = 'Op. 36',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9095 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 44 La Chasse

UPDATE pieces piece
SET piece.title = 'La Chasse', piece.title_en = 'La Chasse, op. 44',
    piece.type = 'song', piece.opus_number = 'Op. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10546 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 53 Le Rêve

UPDATE pieces piece
SET piece.title = 'Le Rêve', piece.title_en = 'Le Rêve, op. 53',
    piece.type = 'song', piece.opus_number = 'Op. 53',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10177 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 11 Le Sommeil

UPDATE pieces piece
SET piece.title = 'Le Sommeil', piece.title_en = 'Le Sommeil, op. 11',
    piece.type = 'song', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7776 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 9 Les Adieux

UPDATE pieces piece
SET piece.title = 'Les Adieux', piece.title_en = 'Les Adieux, op. 9',
    piece.type = 'song', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9791 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Los pájaros de Chile

UPDATE pieces piece
SET piece.title = 'Los pájaros de Chile', piece.title_en = 'Los pájaros de Chile',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10814 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 48 L’Esprit follet

UPDATE pieces piece
SET piece.title = 'L’Esprit follet', piece.title_en = 'L’Esprit follet, op. 48',
    piece.type = 'song', piece.opus_number = 'Op. 48',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11275 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 42 Miramar

UPDATE pieces piece
SET piece.title = 'Miramar', piece.title_en = 'Miramar, op. 42',
    piece.type = 'song', piece.opus_number = 'Op. 42',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11230 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 12 Moscovienne

UPDATE pieces piece
SET piece.title = 'Moscovienne', piece.title_en = 'Moscovienne, op. 12',
    piece.type = 'song', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8577 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 47 Mélodie roumaine

UPDATE pieces piece
SET piece.title = 'Mélodie roumaine', piece.title_en = 'Mélodie roumaine, op. 47',
    piece.type = 'song', piece.opus_number = 'Op. 47',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9193 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 33 Navarra

UPDATE pieces piece
SET piece.title = 'Navarra', piece.title_en = 'Navarra, op. 33',
    piece.type = 'song', piece.opus_number = 'Op. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8638 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 45 Nocturne-sérénade

UPDATE pieces piece
SET piece.title = 'Nocturne-sérénade', piece.title_en = 'Nocturne-sérénade, op. 45',
    piece.type = 'song', piece.opus_number = 'Op. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7792 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 35 Peteneras, capriccio espagnol

UPDATE pieces piece
SET piece.title = 'Peteneras, capriccio espagnol', piece.title_en = 'Peteneras, capriccio espagnol, op. 35',
    piece.type = 'song', piece.opus_number = 'Op. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7859 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 17 Prière et Berceuse

UPDATE pieces piece
SET piece.title = 'Prière et Berceuse', piece.title_en = 'Prière et Berceuse, op. 17',
    piece.type = 'song', piece.opus_number = 'Op. 17',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10170 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 4 Rêverie

UPDATE pieces piece
SET piece.title = 'Rêverie', piece.title_en = 'Rêverie, op. 4',
    piece.type = 'song', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9834 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 28 Serenata andaluza

UPDATE pieces piece
SET piece.title = 'Serenata andaluza', piece.title_en = 'Serenata andaluza, op. 28',
    piece.type = 'song', piece.opus_number = 'Op. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10160 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 8 Souvenir de Domont

UPDATE pieces piece
SET piece.title = 'Souvenir de Domont', piece.title_en = 'Souvenir de Domont, op. 8',
    piece.type = 'song', piece.opus_number = 'Op. 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8240 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 21 Spanish Dances Op. 21

UPDATE pieces piece
SET piece.title = 'Spanish Dances Op. 21', piece.title_en = 'Spanish Dances, op. 21',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '21',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8923 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Malagueña, op. 21 no. 1', part.name_en = 'Malagueña, op. 21 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8923 AND p.composer_id = 63 AND part.part_key = 'musicbrainz:7431bd96-59c9-43b8-8954-e33f85c42206' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7431bd96-59c9-43b8-8954-e33f85c42206', 1, NULL, 'Malagueña, op. 21 no. 1', 'Malagueña, op. 21 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8923 AND p.composer_id = 63
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7431bd96-59c9-43b8-8954-e33f85c42206'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Habanera, op. 21 no. 2', part.name_en = 'Habanera, op. 21 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8923 AND p.composer_id = 63 AND part.part_key = 'musicbrainz:831ea23f-452a-49b1-9c2a-0794b507e7d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:831ea23f-452a-49b1-9c2a-0794b507e7d1', 2, NULL, 'Habanera, op. 21 no. 2', 'Habanera, op. 21 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8923 AND p.composer_id = 63
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:831ea23f-452a-49b1-9c2a-0794b507e7d1'
);


-- Op. 22 Spanish Dances Op. 22

UPDATE pieces piece
SET piece.title = 'Spanish Dances Op. 22', piece.title_en = 'Spanish Dances, op. 22',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '22',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8589 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Romanza andaluza', part.name_en = 'Spanish Dances, op. 22, no. 1: Romanza andaluza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8589 AND p.composer_id = 63 AND part.part_key = 'musicbrainz:516af8d2-eb95-4179-9bf6-cb59996b99f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:516af8d2-eb95-4179-9bf6-cb59996b99f5', 1, NULL, 'Romanza andaluza', 'Spanish Dances, op. 22, no. 1: Romanza andaluza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8589 AND p.composer_id = 63
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:516af8d2-eb95-4179-9bf6-cb59996b99f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Jota navarra', part.name_en = 'Spanish Dances, op. 22, no. 2: Jota navarra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8589 AND p.composer_id = 63 AND part.part_key = 'musicbrainz:f971c8b6-293d-4e05-9924-2dfea6a4caa9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f971c8b6-293d-4e05-9924-2dfea6a4caa9', 2, NULL, 'Jota navarra', 'Spanish Dances, op. 22, no. 2: Jota navarra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8589 AND p.composer_id = 63
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f971c8b6-293d-4e05-9924-2dfea6a4caa9'
);


-- Op. 23 Spanish Dances Op. 23

UPDATE pieces piece
SET piece.title = 'Spanish Dances Op. 23', piece.title_en = 'Spanish Dances, op. 23',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '23',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9903 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Playera', part.name_en = 'Spanish Dances, op. 23, no. 1: Playera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9903 AND p.composer_id = 63 AND part.part_key = 'musicbrainz:ab676275-bb56-4a71-a2ac-66bc785f238b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab676275-bb56-4a71-a2ac-66bc785f238b', 1, NULL, 'Playera', 'Spanish Dances, op. 23, no. 1: Playera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9903 AND p.composer_id = 63
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab676275-bb56-4a71-a2ac-66bc785f238b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Zapateado', part.name_en = 'Spanish Dances, op. 23, no. 2: Zapateado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9903 AND p.composer_id = 63 AND part.part_key = 'musicbrainz:67a12552-e7e3-4dac-bba9-2fc3b7f8c56e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67a12552-e7e3-4dac-bba9-2fc3b7f8c56e', 2, NULL, 'Zapateado', 'Spanish Dances, op. 23, no. 2: Zapateado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9903 AND p.composer_id = 63
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67a12552-e7e3-4dac-bba9-2fc3b7f8c56e'
);


-- Op. 26 Spanish Dances Op. 26

UPDATE pieces piece
SET piece.title = 'Spanish Dances Op. 26', piece.title_en = 'Spanish Dances, op. 26',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '26',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8101 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Vito. Allegretto', part.name_en = 'Spanish Dances, op. 26, no. 1: Vito. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8101 AND p.composer_id = 63 AND part.part_key = 'musicbrainz:8343822f-1085-454e-8725-a77253f1339b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8343822f-1085-454e-8725-a77253f1339b', 1, NULL, 'Vito. Allegretto', 'Spanish Dances, op. 26, no. 1: Vito. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8101 AND p.composer_id = 63
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8343822f-1085-454e-8725-a77253f1339b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Habanera. Allegro moderato', part.name_en = 'Spanish Dances, op. 26, no. 2: Habanera. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8101 AND p.composer_id = 63 AND part.part_key = 'musicbrainz:c3515430-c827-4e47-89a2-f245f35cbb66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3515430-c827-4e47-89a2-f245f35cbb66', 2, NULL, 'Habanera. Allegro moderato', 'Spanish Dances, op. 26, no. 2: Habanera. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8101 AND p.composer_id = 63
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3515430-c827-4e47-89a2-f245f35cbb66'
);


-- Op. 10 Sérénade andalouse

UPDATE pieces piece
SET piece.title = 'Sérénade andalouse', piece.title_en = 'Sérénade andalouse, op. 10',
    piece.type = 'song', piece.opus_number = 'Op. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10691 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 39 Zortzico de Iparraguirre

UPDATE pieces piece
SET piece.title = 'Zortzico de Iparraguirre', piece.title_en = 'Zortzico de Iparraguirre, op. 39',
    piece.type = 'song', piece.opus_number = 'Op. 39',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10649 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 38 ¡Viva Sevilla!

UPDATE pieces piece
SET piece.title = '¡Viva Sevilla!', piece.title_en = '¡Viva Sevilla!, op. 38',
    piece.type = 'song', piece.opus_number = 'Op. 38',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11146 AND piece.composer_id = 63
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 24 Caprice basque

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Caprice basque', 'Caprice basque, op. 24', 'song', 'Op. 24', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 63
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Caprice basque'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34ff5873-caa9-4eb7-afa5-6f18d14aa706'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '34ff5873-caa9-4eb7-afa5-6f18d14aa706'
FROM pieces p
WHERE p.composer_id = 63 AND p.title = 'Caprice basque' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34ff5873-caa9-4eb7-afa5-6f18d14aa706'
);


-- None 마주르카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카', 'Mazurka', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 63
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f380357c-5656-4cdf-8e65-49816f8b9694'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f380357c-5656-4cdf-8e65-49816f8b9694'
FROM pieces p
WHERE p.composer_id = 63 AND p.title = '마주르카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f380357c-5656-4cdf-8e65-49816f8b9694'
);


-- Op. 32 Muiñeira

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Muiñeira', 'Muiñeira, op. 32', 'song', 'Op. 32', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 63
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Muiñeira'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1030161-c71a-4ce5-8b34-01b26cff1c48'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a1030161-c71a-4ce5-8b34-01b26cff1c48'
FROM pieces p
WHERE p.composer_id = 63 AND p.title = 'Muiñeira' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1030161-c71a-4ce5-8b34-01b26cff1c48'
);


-- 카탈로그에 대응이 없는 seed 작품 12개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 63 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    7769, 8347, 8396, 8906, 8980, 9767, 9794, 10085, 10331, 10520, 10793, 11198
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
