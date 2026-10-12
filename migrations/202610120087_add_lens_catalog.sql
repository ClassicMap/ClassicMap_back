-- 니콜라 렌스 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 81개(묶음 1, 다악장 0, 낱곡 80),
-- 새 작품 3개, part 2개, 그 아래 0개.
-- seed 78개 중 78개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.
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

-- None Agnus purus

UPDATE pieces piece
SET piece.title = 'Agnus purus', piece.title_en = 'Agnus purus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19094 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aliosne

UPDATE pieces piece
SET piece.title = 'Aliosne', piece.title_en = 'Aliosne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16435 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Amice mi

UPDATE pieces piece
SET piece.title = 'Amice mi', piece.title_en = 'Amice mi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17817 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Amor aeternus II

UPDATE pieces piece
SET piece.title = 'Amor aeternus II', piece.title_en = 'Amor aeternus II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18614 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Amor aeternus i

UPDATE pieces piece
SET piece.title = 'Amor aeternus i', piece.title_en = 'Amor aeternus i',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19525 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Amor mundum

UPDATE pieces piece
SET piece.title = 'Amor mundum', piece.title_en = 'Amor mundum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18588 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Amor omnibus

UPDATE pieces piece
SET piece.title = 'Amor omnibus', piece.title_en = 'Amor omnibus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19956 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Amor, amore

UPDATE pieces piece
SET piece.title = 'Amor, amore', piece.title_en = 'Amor, amore',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17707 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None An amorem II

UPDATE pieces piece
SET piece.title = 'An amorem II', piece.title_en = 'An amorem II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18009 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None An amorem i

UPDATE pieces piece
SET piece.title = 'An amorem i', piece.title_en = 'An amorem i',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19978 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Anima Superba

UPDATE pieces piece
SET piece.title = 'Anima Superba', piece.title_en = 'Anima Superba',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19236 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ardeat ignis

UPDATE pieces piece
SET piece.title = 'Ardeat ignis', piece.title_en = 'Ardeat ignis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18734 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Attack

UPDATE pieces piece
SET piece.title = 'Attack', piece.title_en = 'Attack',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16921 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ave ignis

UPDATE pieces piece
SET piece.title = 'Ave ignis', piece.title_en = 'Ave ignis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17051 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bangkok Shame

UPDATE pieces piece
SET piece.title = 'Bangkok Shame', piece.title_en = 'Bangkok Shame',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16820 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Calling for Nam & Kim

UPDATE pieces piece
SET piece.title = 'Calling for Nam & Kim', piece.title_en = 'Calling for Nam & Kim',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17207 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Angels of Death

UPDATE pieces piece
SET piece.title = 'Canto of the Angels of Death', piece.title_en = 'Canto of the Angels of Death',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18744 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Colonial Soldier

UPDATE pieces piece
SET piece.title = 'Canto of the Colonial Soldier', piece.title_en = 'Canto of the Colonial Soldier',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18991 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Deserter – Part 1

UPDATE pieces piece
SET piece.title = 'Canto of the Deserter – Part 1', piece.title_en = 'Canto of the Deserter – Part 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18695 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Deserter – Part 2

UPDATE pieces piece
SET piece.title = 'Canto of the Deserter – Part 2', piece.title_en = 'Canto of the Deserter – Part 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19919 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Deserter – Part 3

UPDATE pieces piece
SET piece.title = 'Canto of the Deserter – Part 3', piece.title_en = 'Canto of the Deserter – Part 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16685 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Deserter – Part 4

UPDATE pieces piece
SET piece.title = 'Canto of the Deserter – Part 4', piece.title_en = 'Canto of the Deserter – Part 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17157 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Fallen

UPDATE pieces piece
SET piece.title = 'Canto of the Fallen', piece.title_en = 'Canto of the Fallen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16761 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Missing

UPDATE pieces piece
SET piece.title = 'Canto of the Missing', piece.title_en = 'Canto of the Missing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16815 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Mother

UPDATE pieces piece
SET piece.title = 'Canto of the Mother', piece.title_en = 'Canto of the Mother',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16210 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Nurse

UPDATE pieces piece
SET piece.title = 'Canto of the Nurse', piece.title_en = 'Canto of the Nurse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18637 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Orphans

UPDATE pieces piece
SET piece.title = 'Canto of the Orphans', piece.title_en = 'Canto of the Orphans',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19987 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Soldier

UPDATE pieces piece
SET piece.title = 'Canto of the Soldier', piece.title_en = 'Canto of the Soldier',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17224 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Surviver – Part 1

UPDATE pieces piece
SET piece.title = 'Canto of the Surviver – Part 1', piece.title_en = 'Canto of the Surviver – Part 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19912 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Surviver – Part 2

UPDATE pieces piece
SET piece.title = 'Canto of the Surviver – Part 2', piece.title_en = 'Canto of the Surviver – Part 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18367 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto of the Unknown Soldier

UPDATE pieces piece
SET piece.title = 'Canto of the Unknown Soldier', piece.title_en = 'Canto of the Unknown Soldier',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18067 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Complorate filiae

UPDATE pieces piece
SET piece.title = 'Complorate filiae', piece.title_en = 'Complorate filiae',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19211 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Corpore toto

UPDATE pieces piece
SET piece.title = 'Corpore toto', piece.title_en = 'Corpore toto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18782 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Corpus inimici

UPDATE pieces piece
SET piece.title = 'Corpus inimici', piece.title_en = 'Corpus inimici',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18850 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cremation

UPDATE pieces piece
SET piece.title = 'Cremation', piece.title_en = 'Cremation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18066 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Deliciae meae

UPDATE pieces piece
SET piece.title = 'Deliciae meae', piece.title_en = 'Deliciae meae',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19140 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Deus Meus

UPDATE pieces piece
SET piece.title = 'Deus Meus', piece.title_en = 'Deus Meus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17297 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Eia! Eia! Fetus In Vulva

UPDATE pieces piece
SET piece.title = 'Eia! Eia! Fetus In Vulva', piece.title_en = 'Eia! Eia! Fetus In Vulva',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16517 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Eva>

UPDATE pieces piece
SET piece.title = '가곡 <Eva>', piece.title_en = 'Eva',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17126 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Flamma flamma

UPDATE pieces piece
SET piece.title = 'Flamma flamma', piece.title_en = 'Flamma flamma',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16259 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Going to Bangkok

UPDATE pieces piece
SET piece.title = 'Going to Bangkok', piece.title_en = 'Going to Bangkok',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17939 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hic iacet I

UPDATE pieces piece
SET piece.title = 'Hic iacet I', piece.title_en = 'Hic iacet I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18702 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hic iacet II

UPDATE pieces piece
SET piece.title = 'Hic iacet II', piece.title_en = 'Hic iacet II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17514 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In corpore

UPDATE pieces piece
SET piece.title = 'In corpore', piece.title_en = 'In corpore',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19966 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Infans Dolore

UPDATE pieces piece
SET piece.title = 'Infans Dolore', piece.title_en = 'Infans Dolore',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19711 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Iuppiter olympium

UPDATE pieces piece
SET piece.title = 'Iuppiter olympium', piece.title_en = 'Iuppiter olympium',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17208 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ma matutinum

UPDATE pieces piece
SET piece.title = 'Ma matutinum', piece.title_en = 'Ma matutinum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17080 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mama Thong & The Troublemaker

UPDATE pieces piece
SET piece.title = 'Mama Thong & The Troublemaker', piece.title_en = 'Mama Thong & The Troublemaker',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16311 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mater

UPDATE pieces piece
SET piece.title = 'Mater', piece.title_en = 'Mater',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16638 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Milliens Millenae

UPDATE pieces piece
SET piece.title = 'Milliens Millenae', piece.title_en = 'Milliens Millenae',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17169 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Molitur Memoria

UPDATE pieces piece
SET piece.title = 'Molitur Memoria', piece.title_en = 'Molitur Memoria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17463 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Moritur Terra

UPDATE pieces piece
SET piece.title = 'Moritur Terra', piece.title_en = 'Moritur Terra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17201 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mors O Suavissima Rerum

UPDATE pieces piece
SET piece.title = 'Mors O Suavissima Rerum', piece.title_en = 'Mors O Suavissima Rerum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18558 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mors neutra

UPDATE pieces piece
SET piece.title = 'Mors neutra', piece.title_en = 'Mors neutra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16930 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nam sum II

UPDATE pieces piece
SET piece.title = 'Nam sum II', piece.title_en = 'Nam sum II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18601 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nam sum i

UPDATE pieces piece
SET piece.title = 'Nam sum i', piece.title_en = 'Nam sum i',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18161 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nomen meum

UPDATE pieces piece
SET piece.title = 'Nomen meum', piece.title_en = 'Nomen meum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16340 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O amabilis amor

UPDATE pieces piece
SET piece.title = 'O amabilis amor', piece.title_en = 'O amabilis amor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19007 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O basiorum

UPDATE pieces piece
SET piece.title = 'O basiorum', piece.title_en = 'O basiorum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17160 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pater

UPDATE pieces piece
SET piece.title = 'Pater', piece.title_en = 'Pater',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17743 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pirates & The Refugeecamp

UPDATE pieces piece
SET piece.title = 'Pirates & The Refugeecamp', piece.title_en = 'Pirates & The Refugeecamp',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19457 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pupulam O Puram

UPDATE pieces piece
SET piece.title = 'Pupulam O Puram', piece.title_en = 'Pupulam O Puram',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18559 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pupulus

UPDATE pieces piece
SET piece.title = 'Pupulus', piece.title_en = 'Pupulus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16981 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rape

UPDATE pieces piece
SET piece.title = 'Rape', piece.title_en = 'Rape',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16665 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Saigon II

UPDATE pieces piece
SET piece.title = 'Saigon II', piece.title_en = 'Saigon II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18338 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Searching for Love

UPDATE pieces piece
SET piece.title = 'Searching for Love', piece.title_en = 'Searching for Love',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18906 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sumus vicinae

UPDATE pieces piece
SET piece.title = 'Sumus vicinae', piece.title_en = 'Sumus vicinae',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17441 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tegite specula

UPDATE pieces piece
SET piece.title = 'Tegite specula', piece.title_en = 'Tegite specula',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17813 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Terra Aquarius

UPDATE pieces piece
SET piece.title = 'Terra Aquarius', piece.title_en = 'Terra Aquarius',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16058 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Battle on the Island Kohkra

UPDATE pieces piece
SET piece.title = 'The Battle on the Island Kohkra', piece.title_en = 'The Battle on the Island Kohkra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19263 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Fall of Saigon

UPDATE pieces piece
SET piece.title = 'The Fall of Saigon', piece.title_en = 'The Fall of Saigon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20028 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Sad Chinaman

UPDATE pieces piece
SET piece.title = 'The Sad Chinaman', piece.title_en = 'The Sad Chinaman',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19063 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Very Sad Chinaman

UPDATE pieces piece
SET piece.title = 'The Very Sad Chinaman', piece.title_en = 'The Very Sad Chinaman',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18018 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Timore amore

UPDATE pieces piece
SET piece.title = 'Timore amore', piece.title_en = 'Timore amore',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17398 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Utrum vulva

UPDATE pieces piece
SET piece.title = 'Utrum vulva', piece.title_en = 'Utrum vulva',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17940 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vale frater

UPDATE pieces piece
SET piece.title = 'Vale frater', piece.title_en = 'Vale frater',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17637 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Where's Thailand?

UPDATE pieces piece
SET piece.title = 'Where''s Thailand?', piece.title_en = 'Where''s Thailand?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17462 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Woodfire

UPDATE pieces piece
SET piece.title = 'Woodfire', piece.title_en = 'Woodfire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19025 AND piece.composer_id = 287
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Obsession

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Obsession', 'Obsession', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 287
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Obsession'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d77b6f3-9005-417d-b5ec-a1ee8b7eb9b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5d77b6f3-9005-417d-b5ec-a1ee8b7eb9b8'
FROM pieces p
WHERE p.composer_id = 287 AND p.title = 'Obsession' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d77b6f3-9005-417d-b5ec-a1ee8b7eb9b8'
);


-- None 레퀴엠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '레퀴엠', 'Requiem', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 287
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '레퀴엠'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df4915d1-76d4-4d16-b4c9-6787e2c6016e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df4915d1-76d4-4d16-b4c9-6787e2c6016e'
FROM pieces p
WHERE p.composer_id = 287 AND p.title = '레퀴엠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df4915d1-76d4-4d16-b4c9-6787e2c6016e'
);


-- None Was hast du mit meinem Herz getan?

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Was hast du mit meinem Herz getan?', 'Was hast du mit meinem Herz getan?', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 287
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Was hast du mit meinem Herz getan?'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '204a7705-2a6a-4ddf-8c29-85dcec48bd32'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '204a7705-2a6a-4ddf-8c29-85dcec48bd32'
FROM pieces p
WHERE p.composer_id = 287 AND p.title = 'Was hast du mit meinem Herz getan?' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '204a7705-2a6a-4ddf-8c29-85dcec48bd32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:172a8619-b27d-48fb-930c-04766a4ebeed', 1, NULL, 'Orrori dell’amore', 'Orrori dell’amore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 287 AND p.title = 'Was hast du mit meinem Herz getan?' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:172a8619-b27d-48fb-930c-04766a4ebeed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3adca559-e6c3-4977-9af9-938f77d9d029', 2, NULL, 'Was hast du mit meinem Herz getan?', 'Was hast du mit meinem Herz getan?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 287 AND p.title = 'Was hast du mit meinem Herz getan?' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3adca559-e6c3-4977-9af9-938f77d9d029'
);


-- 숨길 seed 작품 없음
