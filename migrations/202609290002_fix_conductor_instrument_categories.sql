-- 위키데이터 악기로 들어온 지휘자 아홉 명의 분류를 지휘자로 고친다.
--
-- 국제 시드는 Wikidata 의 악기 코드로 분류를 정해서, 젊은 시절 악기 이력이 있는
-- 지휘자가 악기 연주자로 들어왔다(202608050105 하이팅크와 같은 경우).
-- 202608050043 은 피아니스트 겸 지휘자를 그대로 두었지만, 주 활동이 지휘인 사람은
-- 지휘자로 보이게 하기로 방침을 바꿨다(2026-09-29).
--
--   384 Sakari Oramo          바이올린 → conductor
--   396 David Shallon         바이올린 → conductor
--   416 Jerzy Katlewicz       피아노   → conductor
--   433 Simone Young          피아노   → conductor
--   434 Witold Rowicki        바이올린 → conductor
--   437 Pietari Inkinen       바이올린 → conductor
--   473 Wolfgang Sawallisch   피아노   → conductor
--   480 Yoel Levi             타악기   → conductor
--   555 Otmar Suitner         피아노   → conductor
--
-- 비교 시드에서 손으로 pianist 로 넣은 에셴바흐(684)는 그 녹음에서 피아노를 친
-- 것이라 건드리지 않는다. id·영문명·현재 분류가 모두 예상과 같을 때만 바꾸고
-- 자동 시드가 다시 덮지 못하게 editor_locked 를 올린다.

UPDATE artists
SET category = 'conductor',
    editor_locked = 1
WHERE (id, english_name) IN (
        (384, 'Sakari Oramo'),
        (396, 'David Shallon'),
        (434, 'Witold Rowicki'),
        (437, 'Pietari Inkinen')
    )
  AND category IN ('violinist', '바이올린');

UPDATE artists
SET category = 'conductor',
    editor_locked = 1
WHERE (id, english_name) IN (
        (416, 'Jerzy Katlewicz'),
        (433, 'Simone Young'),
        (473, 'Wolfgang Sawallisch'),
        (555, 'Otmar Suitner')
    )
  AND category IN ('pianist', '피아노', '피아니스트');

UPDATE artists
SET category = 'conductor',
    editor_locked = 1
WHERE id = 480
  AND english_name = 'Yoel Levi'
  AND category IN ('percussionist', '타악기', '마림바');
