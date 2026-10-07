-- 영화 속 클래식 큐가 쓰는 국제 시드 작품 6개를 한국어 제목으로 바꾸고 잠근다.
--
--   2799  하차투리안 <가야네> 모음곡 1번       2001: 스페이스 오디세이
--   15339 바흐 칸타타 BWV 82                 박쥐
--   11933 말러 교향곡 3번                    베니스에서의 죽음, 은하영웅전설
--   11293 말러 교향곡 9번                    은하영웅전설
--   14198 그리그 <페르 귄트>                  하모니
--   14951 바흐 칸타타 BWV 106                포핸즈
--
-- 202608050048 과 같은 방식이다. title 만 국내 표기로 바꾸고 title_en 은 원어로 둔다.
-- editor_locked 를 켜야 다음 시드 실행이 title 을 원어로 조용히 되돌리지 않는다(켜면 MANUAL_ROW_CONFLICT 로 멈춘다).
-- 비어 있는 설명·작품 번호·작곡 연도·난이도·연주 시간·Apple Music 링크도 채운다. 이미 값이 있으면 두고
-- (COALESCE) 없는 칸만 채운다. 말러는 manual 말러 작품(215~219)처럼 작품 번호를 비워 둔다.
-- 하차투리안 모음곡도 manual 하차투리안 작품(381~384)처럼 작품 번호를 비워 둔다.
-- 제목에는 작품 번호를 넣지 않는다. opus_number 를 채우면 화면이 제목 옆에 따로 보여 주기 때문이다.
-- 여섯 다 여러 곡·악장으로 된 작품이라 manual 관례대로 type 을 album 으로 둔다.
-- WHERE 의 title 은 2026-10-06 덤프의 원어 값이다. 누가 이미 바꿨으면 건드리지 않는다.

-- 2799 <가야네> 모음곡 1번 · 2001: 스페이스 오디세이 (가야네의 아다지오)
UPDATE pieces SET
    title = '<가야네> 모음곡 1번',
    editor_locked = 1,
    type = 'album',
    description = COALESCE(description, '하차투리안이 아르메니아의 집단 농장을 배경으로 한 발레 <가야네>의 음악을 추려 1943년에 엮은 관현악 모음곡 가운데 첫 번째. 아르메니아 민속 선율과 리듬을 살린 춤곡들 사이에 서정적인 ''가야네의 아다지오''가 들어 있으며, 이 아다지오는 영화 <2001: 스페이스 오디세이>에 쓰였다.'),
    composition_year = COALESCE(composition_year, 1943),
    difficulty_level = COALESCE(difficulty_level, 8),
    duration_minutes = COALESCE(duration_minutes, 25),
    apple_music_url = COALESCE(apple_music_url, 'https://music.apple.com/us/album/khachaturian-gayane-suites-nos-1-3/30103184')
WHERE id = 2799 AND origin = 'seed' AND title = 'First Suite from the ballet “Gayaneh” for orchestra, op. 53';

-- 15339 칸타타 <나는 만족하나이다> · 박쥐 (1곡 아리아)
UPDATE pieces SET
    title = '칸타타 <나는 만족하나이다>',
    editor_locked = 1,
    type = 'album',
    description = COALESCE(description, '베이스 독창을 위한 바흐의 교회 칸타타. 1727년 라이프치히에서 성모 마리아 정결례 축일을 위해 썼으며, 아기 예수를 품에 안은 노인 시므온처럼 이제 평안히 세상을 떠날 수 있다는 마음을 노래한다. 잠을 청하듯 흔들리는 3곡 아리아 ''잠들라, 지친 눈이여''가 특히 유명하다.'),
    opus_number = COALESCE(opus_number, 'BWV 82'),
    composition_year = COALESCE(composition_year, 1727),
    difficulty_level = COALESCE(difficulty_level, 7),
    duration_minutes = COALESCE(duration_minutes, 22),
    apple_music_url = COALESCE(apple_music_url, 'https://music.apple.com/us/album/j-s-bach-cantatas-bwv-56-bwv-4-bwv-82/1452134664')
WHERE id = 15339 AND origin = 'seed' AND title = 'Kantate, BWV 82 “Ich habe genung”';

-- 11933 교향곡 3번 D단조 · 베니스에서의 죽음 (4악장), 은하영웅전설 (1악장)
UPDATE pieces SET
    title = '교향곡 3번 D단조',
    editor_locked = 1,
    type = 'album',
    description = COALESCE(description, '여섯 악장에 연주 시간이 1시간 30분을 넘는 말러의 가장 긴 교향곡. 자연의 여러 단계를 차례로 그려 나간다는 구상 아래 거대한 1악장에서 시작해, 4악장에서는 알토가 니체의 <차라투스트라는 이렇게 말했다> 중 ''한밤의 노래''를 부르고, 장엄한 현악 아다지오로 끝난다.'),
    composition_year = COALESCE(composition_year, 1896),
    difficulty_level = COALESCE(difficulty_level, 10),
    duration_minutes = COALESCE(duration_minutes, 95)
WHERE id = 11933 AND origin = 'seed' AND title = 'Symphony no. 3 in D minor';

-- 11293 교향곡 9번 D장조 · 은하영웅전설 (1악장)
UPDATE pieces SET
    title = '교향곡 9번 D장조',
    editor_locked = 1,
    type = 'album',
    description = COALESCE(description, '말러가 완성한 마지막 교향곡. 머뭇거리는 리듬으로 시작하는 1악장에서 삶과 죽음이 맞부딪치고, 끝 악장 아다지오는 현악기의 선율이 점점 잦아들어 침묵 속으로 사라진다. 말러는 초연을 보지 못하고 1911년 세상을 떠났고, 이듬해 브루노 발터가 빈에서 초연했다.'),
    composition_year = COALESCE(composition_year, 1909),
    difficulty_level = COALESCE(difficulty_level, 10),
    duration_minutes = COALESCE(duration_minutes, 80)
WHERE id = 11293 AND origin = 'seed' AND title = 'Symphony no. 9 in D major';

-- 14198 극음악 <페르 귄트> · 하모니 (솔베이그의 노래)
UPDATE pieces SET
    title = '극음악 <페르 귄트>',
    editor_locked = 1,
    type = 'album',
    description = COALESCE(description, '입센의 희곡 <페르 귄트> 공연을 위해 그리그가 쓴 극음악. 1876년 크리스티아니아(지금의 오슬로)에서 초연되었다. ''아침 기분'', ''오제의 죽음'', ''산왕의 궁전에서'', ''솔베이그의 노래'' 등은 뒤에 두 개의 관현악 모음곡으로 엮여 더욱 널리 알려졌다.'),
    opus_number = COALESCE(opus_number, 'Op. 23'),
    composition_year = COALESCE(composition_year, 1875),
    difficulty_level = COALESCE(difficulty_level, 8),
    duration_minutes = COALESCE(duration_minutes, 90)
WHERE id = 14198 AND origin = 'seed' AND title = 'Peer Gynt, op. 23';

-- 14951 칸타타 <하나님의 시간이 가장 좋은 때> · 포핸즈 (1곡 소나티나)
UPDATE pieces SET
    title = '칸타타 <하나님의 시간이 가장 좋은 때>',
    editor_locked = 1,
    type = 'album',
    description = COALESCE(description, '''악투스 트라기쿠스(Actus tragicus)''라고도 불리는 바흐 초기의 장례 칸타타. 20대 초반 뮐하우젠 시절인 1707년 무렵 쓴 것으로 보인다. 리코더 두 대와 비올라 다 감바 두 대가 어우러지는 고요한 소나티나로 시작해, 죽음을 받아들이는 믿음을 노래한다.'),
    opus_number = COALESCE(opus_number, 'BWV 106'),
    composition_year = COALESCE(composition_year, 1707),
    difficulty_level = COALESCE(difficulty_level, 6),
    duration_minutes = COALESCE(duration_minutes, 20)
WHERE id = 14951 AND origin = 'seed' AND title = 'Kantate, BWV 106 "Gottes Zeit ist die allerbeste Zeit"';
