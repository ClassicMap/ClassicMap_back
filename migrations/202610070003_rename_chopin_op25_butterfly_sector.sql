-- 쇼팽 연습곡 Op. 25(곡 463) 구간 28 의 이름을 '전곡'에서 9번 「나비」로 바로잡는다.
--
-- 2026-08 파일럿이 Op. 25 를 곡으로 두고 9번 한 곡의 연주 셋(페라이아·아슈케나지·라나,
-- 영상 제목 모두 'No. 9 in G-Flat Major "Butterfly"')을 sector_key 'whole-work' 로 붙였다.
-- 화면에는 'Op. 25 전곡'으로 보이고, 같은 곡에 5번·11번 구간을 새로 붙이면 셋이 섞인다.
-- 구간 안내는 이미 G♭장조 연습곡으로 쓰여 있어 이름만 고친다. sector_key 는 노트 적재
-- 파일(listening-notes-2026-10-01·02)이 자연 키로 쓰고 있어 그대로 둔다.

UPDATE performance_sectors
SET sector_name = '9번 G♭장조 「나비」',
    name_ko = '9번 G♭장조 「나비」',
    name_en = 'No. 9 in G-flat major "Butterfly"'
WHERE id = 28 AND piece_id = 463 AND sector_key = 'whole-work'
  AND origin = 'seed' AND editor_locked = FALSE
  AND name_ko = '전곡';
