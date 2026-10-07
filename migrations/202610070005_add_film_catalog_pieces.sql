-- 영화 속 클래식 카탈로그 밖 큐가 가리키는 작품 36개를 manual 작품으로 만든다.
--
-- 작곡가 여섯을 만드는 A(composers) 마이그레이션을 먼저 적용해야 한다. 새 작곡가 아래 작품은 composers.authority_entity_id 로
-- 작곡가를 찾는다. 작품 단위는 기존 관례대로 오페라·모음곡·다악장 작품 전체 하나다(대목은 나중에 구간으로
-- 붙는다). 낱곡 manual 작품 127·447 꼴을 따른 쇼팽 Op. 10-1 과, 편곡이 곧 큐인 세 곡(사랑의 슬픔·헌정·
-- 파사칼리아)은 예외로 190 '<전람회의 그림> (라벨 편곡 관현악 버전)'처럼 원작곡가 아래 편곡 작품으로 둔다.
--
-- 비교 적재기는 작품을 piece_identifiers.musicbrainz_work 로만 찾는다(comparison_seed_loader.rs resolve_work).
-- 그래서 작품마다 MusicBrainz work MBID 를 붙인다. 원곡과 편성 다른 판을 한 작품에 함께 쓰는 곳이 둘이다
-- (생상스 서주와 론도 카프리치오소: 관현악 원곡 + 바이올린·피아노판, 할보르센 파사칼리아: 바이올린·비올라
-- 원판 + 바이올린·첼로판). 마스카니 <실바노>는 MusicBrainz 에 work 가 없어 작품만 만든다.
--
-- 정한 것
--   라벨 <어미 거위>: SKY 캐슬 근거(OST 10번 '박정은 피아노 편곡')는 관현악 모음곡도 피아노 연탄 원판도
--     아니라 판을 가를 근거가 없다. 녹음이 가장 많은 관현악 모음곡 work(5곡 녹음 77건)를 골랐다.
--   바그너 <탄호이저>: 오페라 전체를 새 작품으로 만든다. manual 147 '<탄호이저> 서곡'(드레스덴판 서곡 work)은
--     그대로 둔다. 1막 베누스베르크(바카날레)는 나중에 이 작품의 구간으로 붙는다.
--   무소르크스키 자장가: 공식 OST 표기를 따라 오스트롭스키 시(희곡 <보예보다>)에 붙인 1865년 가곡으로 둔다.
--     OST 3번 트랙이 연결된 MB work 4fadb9a7 'Cradle Song' 은 작곡 연도 1865, 별칭 'Колыбельная песня' 로
--     같은 곡이라 붙인다(죽음의 노래와 춤 1곡은 1875년, 골레니셰프쿠투조프 시라 다른 곡이다).
--
-- 같은 MBID 가 이미 다른 작품에 있으면 작품도 식별자도 넣지 않는다(202610070002 와 같은 가드).
-- 2026-10-06 덤프 기준으로 이 37개 MBID 는 piece_identifiers·piece_parts 어디에도 없다.
-- 방금 넣은 행은 (작곡가, 제목, origin='manual') 로 찾는다. 두 번 돌려도 같다.
--
-- Apple Music 링크는 iTunes Search API 로 고른 음반이다(트랙 목록에서 그 곡을 확인). 무소르크스키 자장가는
-- 이 곡이 확실히 든 음반을 못 찾아 비워 둔다. Spotify 는 비워 둔다.

-- 오페라 <로델린다> · 기생충 (2막 Spietati, 3막 Mio caro bene)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '오페라 <로델린다>',
       'Opera <Rodelinda>',
       'album',
       '헨델이 런던의 왕립 음악 아카데미를 위해 쓴 3막 오페라 세리아. 남편 베르타리도가 죽은 줄 알고 슬퍼하면서도, 왕위를 빼앗은 그리무알도의 청혼을 끝내 거절하는 롬바르드 왕비 로델린다의 정절을 그렸다. 1725년 런던 킹스 극장에서 초연되었다.',
       'HWV 19',
       1725,
       10,
       180,
       NULL,
       'https://music.apple.com/us/album/handel-rodelinda-hwv-19/1452801717',
       'manual',
       1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <로델린다>'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ceee2305-8a7e-4fed-b7da-f52006958aec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ceee2305-8a7e-4fed-b7da-f52006958aec'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 6 AND p.title = '오페라 <로델린다>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ceee2305-8a7e-4fed-b7da-f52006958aec'
);


-- 교향시 <차라투스트라는 이렇게 말했다> · 2001: 스페이스 오디세이 (서주)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '교향시 <차라투스트라는 이렇게 말했다>',
       'Symphonic Poem <Also sprach Zarathustra>',
       'album',
       '니체의 같은 제목 철학서에서 영감을 받은 교향시. 오르간과 저음의 지속음 위로 트럼펫이 C-G-C 를 울리는 ''일출'' 서주가 특히 유명하며, 큐브릭의 영화 <2001: 스페이스 오디세이>에 쓰이며 널리 알려졌다. 니체의 장 제목을 딴 아홉 부분이 거의 쉬지 않고 이어진다.',
       'Op. 30',
       1896,
       9,
       33,
       NULL,
       'https://music.apple.com/us/album/also-sprach-zarathustra/1452164755',
       'manual',
       1
FROM composers c
WHERE c.authority_entity_id = '17c891e4-7a22-556e-a182-dafe06f86a73'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <차라투스트라는 이렇게 말했다>'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fec1c6a5-ece2-393b-89ed-00cdf5cf2afa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fec1c6a5-ece2-393b-89ed-00cdf5cf2afa'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.authority_entity_id = '17c891e4-7a22-556e-a182-dafe06f86a73' AND p.title = '교향시 <차라투스트라는 이렇게 말했다>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fec1c6a5-ece2-393b-89ed-00cdf5cf2afa'
);


-- 레퀴엠 · 2001: 스페이스 오디세이 (2악장 Kyrie)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '레퀴엠',
       'Requiem',
       'album',
       '소프라노와 메조소프라노 독창, 두 혼성 합창과 관현악을 위한 레퀴엠. 입당송, 키리에, 심판의 날, 라크리모사 네 부분으로 되어 있다. 스무 성부가 미크로폴리포니로 얽히는 2악장 키리에는 영화 <2001: 스페이스 오디세이>에 쓰였다. 1965년 스톡홀름에서 초연되었다.',
       NULL,
       1965,
       10,
       27,
       NULL,
       'https://music.apple.com/us/album/requiem-apparitions-san-francisco-polyphony/1705096624',
       'manual',
       1
FROM composers c
WHERE c.authority_entity_id = '1e6a00d2-5e51-5d69-b7c9-7c5604478c63'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '레퀴엠'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e56e2c6-0d01-3911-9101-acd6a7aef8f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3e56e2c6-0d01-3911-9101-acd6a7aef8f8'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.authority_entity_id = '1e6a00d2-5e51-5d69-b7c9-7c5604478c63' AND p.title = '레퀴엠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e56e2c6-0d01-3911-9101-acd6a7aef8f8'
);


-- 룩스 에테르나 · 2001: 스페이스 오디세이

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '룩스 에테르나',
       'Lux aeterna',
       'song',
       '16성부 무반주 혼성 합창곡. 진혼 미사의 영성체송 ''영원한 빛을 그들에게 비추소서''를 가사로, 성부들이 같은 음들을 조금씩 어긋나게 불러 화음이 번지듯 겹쳐지고 풀린다. 리게티의 미크로폴리포니를 대표하는 곡으로 영화 <2001: 스페이스 오디세이>에 쓰였다.',
       NULL,
       1966,
       10,
       9,
       NULL,
       'https://music.apple.com/us/album/ligeti-lux-aeterna/293897391',
       'manual',
       1
FROM composers c
WHERE c.authority_entity_id = '1e6a00d2-5e51-5d69-b7c9-7c5604478c63'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '룩스 에테르나'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d8d7e30-d89c-3967-9a1c-cd538636d00e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5d8d7e30-d89c-3967-9a1c-cd538636d00e'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.authority_entity_id = '1e6a00d2-5e51-5d69-b7c9-7c5604478c63' AND p.title = '룩스 에테르나' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d8d7e30-d89c-3967-9a1c-cd538636d00e'
);


-- 아트모스페르 · 2001: 스페이스 오디세이

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '아트모스페르',
       'Atmosphères',
       'song',
       '뚜렷한 선율과 박자 대신 거대한 음향 덩어리로 짜인 관현악곡. 악기마다 다른 음을 맡아 촘촘한 음괴를 이루고, 그 색과 밀도가 천천히 바뀌어 간다. 1961년 도나우에싱엔 음악제에서 초연되어 리게티의 이름을 알렸고, 영화 <2001: 스페이스 오디세이>에 쓰였다.',
       NULL,
       1961,
       10,
       9,
       NULL,
       'https://music.apple.com/us/album/ligeti-atmosph%C3%A8res/1467966883',
       'manual',
       1
FROM composers c
WHERE c.authority_entity_id = '1e6a00d2-5e51-5d69-b7c9-7c5604478c63'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '아트모스페르'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25af274b-4a4f-3d80-8cb9-e34a1f147831'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '25af274b-4a4f-3d80-8cb9-e34a1f147831'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.authority_entity_id = '1e6a00d2-5e51-5d69-b7c9-7c5604478c63' AND p.title = '아트모스페르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25af274b-4a4f-3d80-8cb9-e34a1f147831'
);


-- 바이올린 소나타 9번 A장조 "크로이처" · 4월은 너의 거짓말 (1악장)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '바이올린 소나타 9번 A장조 "크로이처"',
       'Violin Sonata No. 9 in A major "Kreutzer"',
       'album',
       '베토벤의 바이올린 소나타 가운데 규모가 가장 크고 격렬한 작품. 바이올린과 피아노가 협주곡처럼 대등하게 맞선다. 처음에는 바이올리니스트 브리지타워를 위해 썼지만, 프랑스의 바이올리니스트 로돌프 크로이처에게 헌정되면서 지금의 이름이 붙었다.',
       'Op. 47',
       1803,
       9,
       40,
       NULL,
       'https://music.apple.com/us/album/beethoven-violin-sonatas-spring-kreutzer/1452630270',
       'manual',
       1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 9번 A장조 "크로이처"'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87281f3c-67c6-48ff-be2b-a84d758d2831'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '87281f3c-67c6-48ff-be2b-a84d758d2831'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 15 AND p.title = '바이올린 소나타 9번 A장조 "크로이처"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87281f3c-67c6-48ff-be2b-a84d758d2831'
);


-- 서주와 론도 카프리치오소 A단조 · 4월은 너의 거짓말

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '서주와 론도 카프리치오소 A단조',
       'Introduction and Rondo Capriccioso in A minor',
       'song',
       '생상스가 스페인의 바이올리니스트 사라사테를 위해 쓴 바이올린과 관현악을 위한 곡. 우수에 찬 서주에 이어 스페인풍 리듬의 론도가 화려한 기교를 펼친다. 비제가 편곡한 바이올린과 피아노판으로도 자주 연주된다.',
       'Op. 28',
       1863,
       9,
       9,
       NULL,
       'https://music.apple.com/us/album/saint-sa%C3%ABns-introduction-rondo-capriccioso-havanaise-etc/1467917600',
       'manual',
       1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '서주와 론도 카프리치오소 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '075a814d-a8a2-48d6-970d-90eea4e5e9ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '075a814d-a8a2-48d6-970d-90eea4e5e9ea'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 60 AND p.title = '서주와 론도 카프리치오소 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '075a814d-a8a2-48d6-970d-90eea4e5e9ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b5d1958a-fc97-40a8-b44c-1101cbd55c20'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 60 AND p.title = '서주와 론도 카프리치오소 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5d1958a-fc97-40a8-b44c-1101cbd55c20'
);


-- 사랑의 슬픔 (라흐마니노프 피아노 편곡) · 4월은 너의 거짓말

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '사랑의 슬픔 (라흐마니노프 피아노 편곡)',
       'Liebesleid (Arr. by Rachmaninoff)',
       'song',
       '크라이슬러의 바이올린 소품 <사랑의 슬픔>을 라흐마니노프가 1921년 피아노 독주곡으로 편곡한 곡. 빈 왈츠풍의 애잔한 원곡 선율에 라흐마니노프 특유의 짙은 화성과 대선율을 더해, 원곡보다 한층 깊고 화려한 피아노 소품이 되었다.',
       NULL,
       1921,
       8,
       5,
       NULL,
       'https://music.apple.com/us/album/rachmaninov-transcriptions-corelli-variations/586109988',
       'manual',
       1
FROM composers c
WHERE c.authority_entity_id = '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '사랑의 슬픔 (라흐마니노프 피아노 편곡)'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f39946b4-81cb-4f80-afcc-fe4528e7e2b4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f39946b4-81cb-4f80-afcc-fe4528e7e2b4'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.authority_entity_id = '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e' AND p.title = '사랑의 슬픔 (라흐마니노프 피아노 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f39946b4-81cb-4f80-afcc-fe4528e7e2b4'
);


-- 헌정 (리스트 피아노 편곡) · 브람스를 좋아하세요?

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '헌정 (리스트 피아노 편곡)',
       'Widmung (Arr. by Liszt)',
       'song',
       '슈만이 클라라와의 결혼을 앞두고 바친 가곡집 <미르테의 꽃>의 첫 곡 ''헌정''을 리스트가 피아노 독주곡으로 편곡한 곡. 노래 선율을 그대로 살리면서 넓은 아르페지오와 옥타브로 점점 고조시켜, 사랑의 고백을 웅장한 피아노 음악으로 바꿔 놓았다.',
       'S. 566',
       1848,
       8,
       4,
       NULL,
       'https://music.apple.com/us/album/liszt-piano-works/1452609615',
       'manual',
       1
FROM composers c
WHERE c.id = 29
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '헌정 (리스트 피아노 편곡)'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14197202-1fd5-41d1-b274-140dd4418e2f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '14197202-1fd5-41d1-b274-140dd4418e2f'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 29 AND p.title = '헌정 (리스트 피아노 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14197202-1fd5-41d1-b274-140dd4418e2f'
);


-- 네 손을 위한 환상곡 F단조 · 밀회

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '네 손을 위한 환상곡 F단조',
       'Fantasia in F minor for Piano Four Hands',
       'album',
       '슈베르트가 세상을 떠난 해인 1828년에 쓴 피아노 연탄곡. 애틋한 F단조 주제로 시작해 라르고, 스케르초, 푸가풍의 피날레를 쉬지 않고 거쳐 다시 첫 주제로 돌아온다. 사후 출판 때 그가 마음에 두었던 제자 카롤리네 에스테르하지에게 헌정되었다.',
       'D. 940',
       1828,
       8,
       19,
       NULL,
       'https://music.apple.com/us/album/mozart-sonata-in-d-major-for-two-pianos-k-448-schubert/431656434',
       'manual',
       1
FROM composers c
WHERE c.id = 26
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 환상곡 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ace0f06-d3d8-4ee8-8731-4dfe3acacc59'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5ace0f06-d3d8-4ee8-8731-4dfe3acacc59'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 26 AND p.title = '네 손을 위한 환상곡 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ace0f06-d3d8-4ee8-8731-4dfe3acacc59'
);


-- 피아노 모음곡 <사계> · 밀회 (4월)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '피아노 모음곡 <사계>',
       'The Seasons',
       'album',
       '음악 잡지 <누벨리스트>의 의뢰로 1876년 한 해 동안 매달 한 곡씩 실은 12곡의 피아노 소품집. 1월 ''난롯가에서''부터 12월 ''크리스마스''까지 러시아의 열두 달 풍경을 그린다. 6월 ''뱃노래''와 11월 ''트로이카''가 특히 사랑받는다.',
       'Op. 37a',
       1876,
       6,
       42,
       NULL,
       'https://music.apple.com/us/album/tchaikovsky-the-seasons/1817499875',
       'manual',
       1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <사계>'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76cd571a-1a95-4cee-8ae0-40387733d0f0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '76cd571a-1a95-4cee-8ae0-40387733d0f0'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 34 AND p.title = '피아노 모음곡 <사계>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76cd571a-1a95-4cee-8ae0-40387733d0f0'
);


-- 네 손을 위한 피아노 소나타 C장조 · 밀회 (1악장)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '네 손을 위한 피아노 소나타 C장조',
       'Sonata for Piano Four Hands in C major',
       'album',
       '모차르트가 1787년 빈에서 완성한 피아노 연탄 소나타. 두 연주자가 주제를 활기차게 주고받는 1악장, 노래하듯 흐르는 2악장, 우아한 론도 3악장으로 되어 있다. 두 파트가 협주곡처럼 대등하게 맞서는 그의 원숙한 연탄곡이다.',
       'K. 521',
       1787,
       6,
       20,
       NULL,
       'https://music.apple.com/us/album/mozart-the-music-for-piano-duet/1452528063',
       'manual',
       1
FROM composers c
WHERE c.id = 14
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 피아노 소나타 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0faa463-2708-46b3-8c68-77ff4aa18a15'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a0faa463-2708-46b3-8c68-77ff4aa18a15'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 14 AND p.title = '네 손을 위한 피아노 소나타 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0faa463-2708-46b3-8c68-77ff4aa18a15'
);


-- 안단테 스피아나토와 화려한 대폴로네즈 · 피아니스트

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '안단테 스피아나토와 화려한 대폴로네즈',
       'Andante spianato et Grande polonaise brillante',
       'album',
       '쇼팽이 먼저 피아노와 관현악을 위해 쓴 폴로네즈 앞에, 1834년 피아노 독주로 쓴 잔잔한 안단테 스피아나토를 붙여 한 곡으로 만들었다. 호수처럼 고요한 G장조 서두에서 팡파르를 거쳐 화려하고 당당한 E♭장조 폴로네즈로 넘어간다.',
       'Op. 22',
       1835,
       10,
       14,
       NULL,
       'https://music.apple.com/us/album/chopin-piano-concertos/1452800452',
       'manual',
       1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 스피아나토와 화려한 대폴로네즈'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c9f3751-a09a-3b1a-8ef4-5a4fc098120a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4c9f3751-a09a-3b1a-8ef4-5a4fc098120a'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 28 AND p.title = '안단테 스피아나토와 화려한 대폴로네즈' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c9f3751-a09a-3b1a-8ef4-5a4fc098120a'
);


-- <어미 거위> 모음곡 · SKY 캐슬 (5곡 요정의 정원)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '<어미 거위> 모음곡',
       'Ma mère l''Oye Suite',
       'album',
       '라벨이 친구의 어린 남매를 위해 쓴 피아노 연탄곡을 1911년 관현악으로 옮긴 모음곡. 페로의 동화 등을 바탕으로 ''잠자는 숲속 미녀의 파반'', ''엄지 동자'', ''파고다의 여왕 레드로네트'', ''미녀와 야수의 대화'', ''요정의 정원'' 다섯 곡이 섬세한 색채로 동화 속 장면을 그린다.',
       'M. 60',
       1911,
       7,
       17,
       NULL,
       'https://music.apple.com/us/album/debussy-la-mer-ravel-ma-mere-loye-la-valse/1452646537',
       'manual',
       1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '<어미 거위> 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e2bdea3b-9d95-46f7-9607-08852bb836e5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e2bdea3b-9d95-46f7-9607-08852bb836e5'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 52 AND p.title = '<어미 거위> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e2bdea3b-9d95-46f7-9607-08852bb836e5'
);


-- 칸타타 <그만, 이제 그만> · 친절한 금자씨 (아리아 Ah ch'infelice sempre)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '칸타타 <그만, 이제 그만>',
       'Cantata <Cessate, omai cessate>',
       'album',
       '알토 독창과 현악, 통주저음을 위한 비발디의 실내 칸타타. 무정한 연인 때문에 괴로워하는 이의 탄식과 분노를 두 레치타티보와 두 아리아에 담았다. 피치카토와 활로 켜는 현이 겹쳐 흐느끼듯 이어지는 첫 아리아 ''Ah ch''infelice sempre''가 특히 유명하다.',
       'RV 684',
       NULL,
       7,
       13,
       NULL,
       'https://music.apple.com/us/album/vivaldi-stabat-mater/207550272',
       'manual',
       1
FROM composers c
WHERE c.id = 7
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <그만, 이제 그만>'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8df04551-8a82-46a7-b699-94e93703fefb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8df04551-8a82-46a7-b699-94e93703fefb'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 7 AND p.title = '칸타타 <그만, 이제 그만>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8df04551-8a82-46a7-b699-94e93703fefb'
);


-- 현을 위한 협주곡 A장조 · 친절한 금자씨

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '현을 위한 협주곡 A장조',
       'Concerto for Strings in A major',
       'album',
       '독주 악기 없이 현악 합주와 통주저음만으로 연주하는 비발디의 ''리피에노 협주곡''. 빠름–느림–빠름 세 악장으로 된 짧은 곡으로, 힘찬 리듬과 선명한 강약 대비 같은 비발디 협주곡의 특징이 압축되어 있다.',
       'RV 159',
       NULL,
       5,
       6,
       NULL,
       'https://music.apple.com/us/album/vivaldi-concertos/1452191934',
       'manual',
       1
FROM composers c
WHERE c.id = 7
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '현을 위한 협주곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd702634b-ec22-4245-90e0-619abbf31070'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd702634b-ec22-4245-90e0-619abbf31070'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 7 AND p.title = '현을 위한 협주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd702634b-ec22-4245-90e0-619abbf31070'
);


-- 바순 협주곡 E단조 · 친절한 금자씨 (3악장)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '바순 협주곡 E단조',
       'Bassoon Concerto in E minor',
       'album',
       '비발디는 바순을 위한 협주곡을 서른 곡 넘게 남겼는데, 이 곡은 그 가운데 자주 연주되는 작품의 하나다. 어두운 E단조 속에서 바순이 낮은 음역의 무게와 민첩한 도약을 함께 보여 주며, 빠름–느림–빠름 세 악장으로 되어 있다.',
       'RV 484',
       NULL,
       8,
       11,
       NULL,
       'https://music.apple.com/us/album/vivaldi-concertos/1452191934',
       'manual',
       1
FROM composers c
WHERE c.id = 7
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '바순 협주곡 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b502d5b-dde4-4efb-8a19-6390811f872c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b502d5b-dde4-4efb-8a19-6390811f872c'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 7 AND p.title = '바순 협주곡 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b502d5b-dde4-4efb-8a19-6390811f872c'
);


-- 교향곡 25번 G단조 · 아마데우스 (1악장)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '교향곡 25번 G단조',
       'Symphony No. 25 in G minor',
       'album',
       '모차르트가 17세에 쓴 교향곡. 그의 교향곡 가운데 단조는 이 곡과 40번 둘뿐이어서 ''작은 G단조 교향곡''이라 불린다. 당김음으로 몰아치는 격정적인 1악장은 영화 <아마데우스>의 첫 장면에 쓰여 널리 알려졌다.',
       'K. 183',
       1773,
       7,
       22,
       NULL,
       'https://music.apple.com/us/album/mozart-symphonies-nos-25-29-31-pariser/1452191462',
       'manual',
       1
FROM composers c
WHERE c.id = 14
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 25번 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e99e8e9e-fff1-3da2-a55d-2833516e9899'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e99e8e9e-fff1-3da2-a55d-2833516e9899'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 14 AND p.title = '교향곡 25번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e99e8e9e-fff1-3da2-a55d-2833516e9899'
);


-- 세레나데 10번 B♭장조 "그랑 파르티타" · 아마데우스 (3악장 아다지오)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '세레나데 10번 B♭장조 "그랑 파르티타"',
       'Serenade No. 10 in B♭ major "Gran Partita"',
       'album',
       '12대의 관악기와 콘트라베이스를 위한 일곱 악장의 대규모 세레나데. 오보에, 클라리넷, 바셋호른, 호른, 바순이 어우러지며, 3악장 아다지오는 영화 <아마데우스>에서 살리에리가 악보를 보며 ''신의 목소리''를 들은 것 같다고 털어놓는 장면에 쓰였다.',
       'K. 361',
       1781,
       8,
       50,
       NULL,
       'https://music.apple.com/us/album/mozart-gran-partita-wind-serenades-k-361-375/1612754389',
       'manual',
       1
FROM composers c
WHERE c.id = 14
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나데 10번 B♭장조 "그랑 파르티타"'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc8bc562-e604-49d6-bd3b-f0b7a68c2153'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc8bc562-e604-49d6-bd3b-f0b7a68c2153'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 14 AND p.title = '세레나데 10번 B♭장조 "그랑 파르티타"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc8bc562-e604-49d6-bd3b-f0b7a68c2153'
);


-- 오페라 <돈 조반니> · 아마데우스 (2막 피날레)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '오페라 <돈 조반니>',
       'Opera <Don Giovanni>',
       'album',
       '다 폰테의 대본에 의한 모차르트의 2막 오페라. 바람둥이 귀족 돈 조반니의 방탕과 몰락을 희극과 비극을 넘나들며 그렸다. 1787년 프라하에서 초연되었으며, 석상이 된 기사장이 나타나 회개를 거부하는 돈 조반니를 지옥으로 끌고 가는 2막 피날레가 압권이다.',
       'K. 527',
       1787,
       10,
       165,
       NULL,
       'https://music.apple.com/us/album/mozart-don-giovanni/1604636952',
       'manual',
       1
FROM composers c
WHERE c.id = 14
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <돈 조반니>'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b3b1e2b3-cbb8-4b46-a7d0-0031ec13492c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b3b1e2b3-cbb8-4b46-a7d0-0031ec13492c'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 14 AND p.title = '오페라 <돈 조반니>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b3b1e2b3-cbb8-4b46-a7d0-0031ec13492c'
);


-- 현을 위한 아다지오 · 플래툰

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '현을 위한 아다지오',
       'Adagio for Strings',
       'song',
       '바버가 1936년에 쓴 현악 4중주 Op. 11 의 2악장을 현악 합주용으로 옮긴 곡으로, 1938년 토스카니니와 NBC 교향악단이 초연했다. 느린 선율이 한 걸음씩 쌓여 절정에 이른 뒤 침묵으로 끊기는 구성으로, 추모의 자리에서 자주 연주된다.',
       'Op. 11',
       1936,
       6,
       8,
       NULL,
       'https://music.apple.com/us/album/barber-adagio-for-strings-copland-quiet-city-ives-symphony/1452171694',
       'manual',
       1
FROM composers c
WHERE c.authority_entity_id = 'b616415c-5102-5aea-ae56-5daf0081361c'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '현을 위한 아다지오'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ebe1abf-daf2-3e5e-b3ad-b6c5a4ec5727'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ebe1abf-daf2-3e5e-b3ad-b6c5a4ec5727'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.authority_entity_id = 'b616415c-5102-5aea-ae56-5daf0081361c' AND p.title = '현을 위한 아다지오' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ebe1abf-daf2-3e5e-b3ad-b6c5a4ec5727'
);


-- 가곡 <자장가> (오스트롭스키 시) · 베니스에서의 죽음

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '가곡 <자장가> (오스트롭스키 시)',
       'Cradle Song (words by Ostrovsky)',
       'song',
       '극작가 오스트롭스키의 희곡 <보예보다>에 나오는 노래 ''잠들어라, 농부의 아들아''에 무소르크스키가 1865년 곡을 붙인 가곡. 농민의 아기를 재우는 러시아 민요풍의 노래로, 그가 남긴 초기 가곡 가운데 하나이며 두 가지 판이 전한다.',
       NULL,
       1865,
       5,
       4,
       NULL,
       NULL,
       'manual',
       1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <자장가> (오스트롭스키 시)'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4fadb9a7-93b3-419f-a8d5-b47bb218a22c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4fadb9a7-93b3-419f-a8d5-b47bb218a22c'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 43 AND p.title = '가곡 <자장가> (오스트롭스키 시)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4fadb9a7-93b3-419f-a8d5-b47bb218a22c'
);


-- 두 대의 피아노를 위한 소나타 D장조 · 노다메 칸타빌레 (1악장)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '두 대의 피아노를 위한 소나타 D장조',
       'Sonata for Two Pianos in D major',
       'album',
       '모차르트가 1781년 빈에서 제자 요제파 아우에른하머와 함께 연주하려고 쓴 소나타. 두 피아노가 주제를 나누어 주고받으며 경쟁하듯 빛나는 밝은 곡이다. 모차르트가 남긴 몇 안 되는 두 대의 피아노 작품 가운데 하나다.',
       'K. 448',
       1781,
       8,
       23,
       NULL,
       'https://music.apple.com/us/album/mozart-sonata-in-d-major-for-two-pianos-k-448-schubert/431656434',
       'manual',
       1
FROM composers c
WHERE c.id = 14
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 피아노를 위한 소나타 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38d1a243-7432-4adf-8d5a-1f0ac8820e9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38d1a243-7432-4adf-8d5a-1f0ac8820e9c'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 14 AND p.title = '두 대의 피아노를 위한 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38d1a243-7432-4adf-8d5a-1f0ac8820e9c'
);


-- 뱃노래 F#장조 · 피아노의 숲

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '뱃노래 F#장조',
       'Barcarolle in F# major',
       'song',
       '베네치아 곤돌라 사공의 노래에서 이름을 딴 쇼팽 말년의 작품. 왼손이 8분의 12박자로 물결처럼 흔들리는 반주를 이어 가고, 오른손은 3도와 6도로 겹친 선율을 노래한다. 1845~46년에 쓴 그의 유일한 뱃노래다.',
       'Op. 60',
       1846,
       9,
       9,
       NULL,
       'https://music.apple.com/us/album/chopin-ballades-barcarolle-fantaisie/1440776206',
       'manual',
       1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '뱃노래 F#장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0d5d12d1-19d8-34fa-9c5d-61e118e4ff4c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0d5d12d1-19d8-34fa-9c5d-61e118e4ff4c'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 28 AND p.title = '뱃노래 F#장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0d5d12d1-19d8-34fa-9c5d-61e118e4ff4c'
);


-- 연습곡 Op. 10, No. 1 C장조 · 피아노의 숲

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '연습곡 Op. 10, No. 1 C장조',
       'Étude Op. 10 No. 1 in C major',
       'song',
       '쇼팽이 리스트에게 헌정한 연습곡집 Op. 10 의 첫 곡. 오른손이 건반 위아래로 넓게 펼쳐진 아르페지오를 쉬지 않고 오르내리고, 왼손은 옥타브로 묵직한 저음 선율을 받친다. 손을 크게 벌려야 해서 가장 어려운 연습곡의 하나로 꼽힌다.',
       'Op. 10, No. 1',
       1829,
       10,
       2,
       NULL,
       'https://music.apple.com/us/album/chopin-%C3%A9tudes-op-10-25/1731383228',
       'manual',
       1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '연습곡 Op. 10, No. 1 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c6f04d7-dca0-3f06-b603-0d9d8cecdb27'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c6f04d7-dca0-3f06-b603-0d9d8cecdb27'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 28 AND p.title = '연습곡 Op. 10, No. 1 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c6f04d7-dca0-3f06-b603-0d9d8cecdb27'
);


-- 피아노 소나타 2번 B♭단조 "장송" · 피아노의 숲

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '피아노 소나타 2번 B♭단조 "장송"',
       'Piano Sonata No. 2 in B♭ minor "Funeral March"',
       'album',
       '3악장 ''장송 행진곡''으로 널리 알려진 쇼팽의 피아노 소나타. 행진곡은 1837년에 먼저 쓰였고, 1839년 노앙에서 나머지 악장을 더해 완성했다. 격정적인 1악장과 스케르초, 장송 행진곡에 이어 두 손이 유니즌으로 휘몰아치는 짧은 피날레가 파격적이다.',
       'Op. 35',
       1839,
       10,
       23,
       NULL,
       'https://music.apple.com/us/album/chopin-piano-sonatas-nos-2-3/1452527398',
       'manual',
       1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 2번 B♭단조 "장송"'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f3f7fdf-6a54-3f28-ba5c-765dbe3d689f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7f3f7fdf-6a54-3f28-ba5c-765dbe3d689f'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 28 AND p.title = '피아노 소나타 2번 B♭단조 "장송"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f3f7fdf-6a54-3f28-ba5c-765dbe3d689f'
);


-- 피아노 소나타 3번 B단조 · 피아노의 숲

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '피아노 소나타 3번 B단조',
       'Piano Sonata No. 3 in B minor',
       'album',
       '쇼팽이 1844년 노앙에서 완성한 마지막 피아노 소나타. 2번보다 고전적인 균형을 갖추었으며, 당당한 1악장과 가벼운 스케르초, 녹턴처럼 노래하는 라르고를 지나 격렬한 론도 피날레로 끝난다. 그의 피아노 독주곡 가운데 규모가 가장 큰 작품에 속한다.',
       'Op. 58',
       1844,
       10,
       27,
       NULL,
       'https://music.apple.com/us/album/chopin-piano-sonatas-nos-2-3/1452527398',
       'manual',
       1
FROM composers c
WHERE c.id = 28
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 3번 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2eeca1e5-6ef5-4725-af55-fba234f34528'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2eeca1e5-6ef5-4725-af55-fba234f34528'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 28 AND p.title = '피아노 소나타 3번 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2eeca1e5-6ef5-4725-af55-fba234f34528'
);


-- 교향적 스케르초 <마법사의 제자> · 판타지아

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '교향적 스케르초 <마법사의 제자>',
       'Symphonic Scherzo <The Sorcerer''s Apprentice>',
       'song',
       '괴테의 시 <마법사의 제자>를 바탕으로 한 관현악곡. 스승이 없는 사이 주문으로 빗자루에게 물을 길어 오게 한 제자가 멈추는 법을 몰라 집이 물바다가 되는 이야기를, 바순이 이끄는 익살스러운 주제로 생생하게 그린다. 1897년 파리에서 뒤카의 지휘로 초연되었다.',
       NULL,
       1897,
       8,
       11,
       NULL,
       'https://music.apple.com/us/album/dukas-the-sorcerers-apprentice-ep/1452138329',
       'manual',
       1
FROM composers c
WHERE c.authority_entity_id = '812fe5cc-035c-533f-a669-fcdea344438a'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 스케르초 <마법사의 제자>'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39c69a8c-9279-320e-b90e-c3ff4217c293'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '39c69a8c-9279-320e-b90e-c3ff4217c293'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.authority_entity_id = '812fe5cc-035c-533f-a669-fcdea344438a' AND p.title = '교향적 스케르초 <마법사의 제자>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39c69a8c-9279-320e-b90e-c3ff4217c293'
);


-- 교향시 <로마의 소나무> · 판타지아 2000

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '교향시 <로마의 소나무>',
       'Symphonic Poem <Pines of Rome>',
       'album',
       '<로마의 분수>, <로마의 축제>와 함께 ''로마 3부작''을 이루는 교향시. 보르게세 별장, 카타콤, 자니콜로 언덕, 아피아 가도의 소나무 네 장면을 쉬지 않고 이어 그린다. 3부 끝에는 녹음한 나이팅게일 소리를 틀고, 4부에서는 로마 군단의 행진이 거대한 크레셴도로 다가온다.',
       'P. 141',
       1924,
       9,
       22,
       NULL,
       'https://music.apple.com/us/album/respighi-pines-of-rome-fountains-of-rome-roman-festivals/1452545135',
       'manual',
       1
FROM composers c
WHERE c.authority_entity_id = 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <로마의 소나무>'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51fa49f1-d58f-4ec1-b5f0-308c3f7547da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51fa49f1-d58f-4ec1-b5f0-308c3f7547da'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.authority_entity_id = 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036' AND p.title = '교향시 <로마의 소나무>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51fa49f1-d58f-4ec1-b5f0-308c3f7547da'
);


-- 오페라 <방황하는 네덜란드인> · 오페라가 뭐예요, 박사님? (서곡)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '오페라 <방황하는 네덜란드인>',
       'Opera <Der fliegende Holländer>',
       'album',
       '영원히 바다를 떠도는 저주를 받은 네덜란드인 선장이 끝까지 신실한 여인 젠타의 사랑으로 구원받는다는 전설을 그린 3막 오페라. 1843년 드레스덴에서 바그너의 지휘로 초연되었다. 폭풍우 치는 바다를 그린 서곡과 ''젠타의 발라드''가 유명하다.',
       'WWV 63',
       1841,
       10,
       140,
       NULL,
       'https://music.apple.com/us/album/wagner-der-fliegende-holl%C3%A4nder/1452352470',
       'manual',
       1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <방황하는 네덜란드인>'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '561be908-2cf7-445e-a4aa-5eaed98cfc86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '561be908-2cf7-445e-a4aa-5eaed98cfc86'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 31 AND p.title = '오페라 <방황하는 네덜란드인>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '561be908-2cf7-445e-a4aa-5eaed98cfc86'
);


-- 오페라 <리엔치> · 오페라가 뭐예요, 박사님? (서곡)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '오페라 <리엔치>',
       'Opera <Rienzi>',
       'album',
       '14세기 로마에서 귀족에 맞서 민중의 지도자가 되었다가 몰락하는 호민관 리엔치의 이야기를 그린 5막 그랜드 오페라. 불워리턴의 소설을 바탕으로 바그너가 직접 대본을 썼고, 1842년 드레스덴 초연으로 그에게 첫 큰 성공을 안겼다. 트럼펫 신호로 시작하는 서곡이 따로 자주 연주된다.',
       'WWV 49',
       1840,
       10,
       220,
       NULL,
       'https://music.apple.com/us/album/wagner-rienzi/726438306',
       'manual',
       1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <리엔치>'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '315a0fe2-4e5a-477f-a4b7-e9c66523b70e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '315a0fe2-4e5a-477f-a4b7-e9c66523b70e'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 31 AND p.title = '오페라 <리엔치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '315a0fe2-4e5a-477f-a4b7-e9c66523b70e'
);


-- 오페라 <탄호이저> · 오페라가 뭐예요, 박사님? (1막 베누스베르크)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '오페라 <탄호이저>',
       'Opera <Tannhäuser>',
       'album',
       '여신 베누스의 동굴에서 쾌락에 빠졌던 기사 탄호이저가 바르트부르크 노래 경연에서 그 사실을 드러내 순례를 떠나고, 엘리자베트의 희생으로 구원받는 3막 오페라. 1845년 드레스덴에서 초연했고, 1861년 파리 공연을 위해 1막 베누스베르크 장면에 관능적인 발레 음악을 새로 썼다.',
       'WWV 70',
       1845,
       10,
       180,
       NULL,
       'https://music.apple.com/us/album/wagner-tannh%C3%A4user-paris-version/1452385481',
       'manual',
       1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <탄호이저>'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b1bd955-8635-43e6-9711-f2b820ffe8b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9b1bd955-8635-43e6-9711-f2b820ffe8b8'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 31 AND p.title = '오페라 <탄호이저>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b1bd955-8635-43e6-9711-f2b820ffe8b8'
);


-- 교향곡 9번 D단조 · 은하영웅전설 (1악장)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '교향곡 9번 D단조',
       'Symphony No. 9 in D minor',
       'album',
       '브루크너가 생애 마지막 몇 해를 바쳤으나 4악장을 끝내지 못하고 세상을 떠나 세 악장으로 남은 교향곡. ''사랑하는 하느님께'' 바쳤다고 전한다. 신비로운 1악장, 거칠게 내리찍는 스케르초, 장엄한 아다지오로 이어지며 1903년 빈에서 초연되었다.',
       'WAB 109',
       1896,
       10,
       60,
       NULL,
       'https://music.apple.com/us/album/bruckner-symphony-no-9/1452240175',
       'manual',
       1
FROM composers c
WHERE c.id = 41
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 9번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce1c5444-e952-48f3-a02a-ec0d235c6ade'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ce1c5444-e952-48f3-a02a-ec0d235c6ade'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 41 AND p.title = '교향곡 9번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce1c5444-e952-48f3-a02a-ec0d235c6ade'
);


-- 파사칼리아 G단조 (할보르센 편곡) · 마에스트라: 스트링스 오브 트루스

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '파사칼리아 G단조 (할보르센 편곡)',
       'Passacaglia in G minor (Arr. by Halvorsen)',
       'song',
       '헨델의 하프시코드 모음곡 G단조 HWV 432 의 마지막 곡 파사칼리아를 노르웨이의 작곡가 할보르센이 바이올린과 비올라 이중주로 편곡한 곡. 원곡의 짧은 주제 위에 화려한 변주를 더해 두 현악기가 숨 가쁘게 주고받는 연주회용 곡이 되었다. 바이올린과 첼로로도 자주 연주된다.',
       NULL,
       1897,
       9,
       8,
       NULL,
       'https://music.apple.com/us/album/halvorsen-passacaglia-for-violin-and-viola-op-20-no-2/6799100559',
       'manual',
       1
FROM composers c
WHERE c.id = 6
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '파사칼리아 G단조 (할보르센 편곡)'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcfeffa8-6a77-40ff-9d9c-486f0ca98a5d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dcfeffa8-6a77-40ff-9d9c-486f0ca98a5d'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 6 AND p.title = '파사칼리아 G단조 (할보르센 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcfeffa8-6a77-40ff-9d9c-486f0ca98a5d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6261476e-6637-45a5-9b01-c7bddcdc085f'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 6 AND p.title = '파사칼리아 G단조 (할보르센 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6261476e-6637-45a5-9b01-c7bddcdc085f'
);


-- 피아노 협주곡 21번 C장조 · 엘비라 마디간 (2악장)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '피아노 협주곡 21번 C장조',
       'Piano Concerto No. 21 in C major',
       'album',
       '1785년 3월, 20번 D단조 협주곡을 완성하고 한 달 만에 내놓은 협주곡. 행진곡풍의 당당한 1악장과 경쾌한 피날레 사이에, 약음기를 낀 현악기 위로 피아노가 꿈결처럼 노래하는 2악장 안단테가 있다. 2악장이 1967년 스웨덴 영화 <엘비라 마디간>에 쓰여 그 이름이 별명처럼 붙었다.',
       'K. 467',
       1785,
       9,
       28,
       NULL,
       'https://music.apple.com/us/album/mozart-piano-concerto-no-21-the-works-ep/1452617321',
       'manual',
       1
FROM composers c
WHERE c.id = 14
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 21번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f210c793-f668-413c-8821-3628b3c55483'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f210c793-f668-413c-8821-3628b3c55483'
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE c.id = 14 AND p.title = '피아노 협주곡 21번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f210c793-f668-413c-8821-3628b3c55483'
);


-- 오페라 <실바노> · 성난 황소 (뱃노래)

INSERT INTO pieces
    (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, origin, editor_locked)
SELECT c.id,
       '오페라 <실바노>',
       'Opera <Silvano>',
       'album',
       '마스카니가 <카발레리아 루스티카나>의 성공 뒤에 쓴 2막짜리 ''뱃사람 드라마''. 알퐁스 카르의 소설을 바탕으로 타르조니토체티가 대본을 썼고, 1895년 밀라노 스칼라 극장에서 초연되었다. 지금은 드물게 공연되지만 테너 아리아에 이어지는 뱃노래(Barcarola)는 따로 자주 녹음된다.',
       NULL,
       1895,
       9,
       70,
       NULL,
       'https://music.apple.com/us/album/mascagni-silvano/825585112',
       'manual',
       1
FROM composers c
WHERE c.id = 67
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <실바노>'
);
