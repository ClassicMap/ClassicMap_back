-- 영화 속 클래식 카탈로그 밖 큐에 필요한 작곡가 여섯을 등록한다.
--
--   리하르트 슈트라우스 (Q13894)  2001: 스페이스 오디세이 — 차라투스트라
--   리게티             (Q154331) 2001: 스페이스 오디세이 — 레퀴엠·룩스 에테르나·아트모스페르
--   바버               (Q216870) 플래툰 — 현을 위한 아다지오
--   뒤카               (Q215556) 판타지아 — 마법사의 제자
--   레스피기           (Q243837) 판타지아 2000 — 로마의 소나무
--   크라이슬러         (Q78517)  4월은 너의 거짓말 — 사랑의 슬픔
--
-- 여섯 다 composers·artists·external_identifiers 어디에도 없다(QID·MusicBrainz artist 로 확인).
-- 202610070001 과 같은 꼴로 엔티티 → 이름 → 식별자 → 표시 행 순서로 만든다.
-- 엔티티 id 는 식별자 집합의 uuid5 다(wikidata·gnd·isni·lccn·musicbrainz_artist·viaf 가운데 있는 값 전부).
-- 슈트라우스는 isni 가 둘, 뒤카는 gnd 가 둘(같은 사람의 중복 레코드)이라 둘 다 넣었다.
--
-- 표시 행은 manual·잠금이고 초상·소개를 모두 채운다(manual 작곡가는 전원 초상·소개가 있다).
-- 이름은 기존 관례대로 짧게 쓰되, 슈트라우스는 요한 슈트라우스 1세(54)·2세(42)와 갈리도록
-- '리하르트 슈트라우스'로 쓴다.
-- 시대는 같은 세대를 갈라 적는 기존 표기를 따랐다. 슈트라우스는 말러(1860)처럼, 크라이슬러는
-- 라흐마니노프(1873)처럼 낭만주의, 뒤카는 드뷔시(1862)처럼, 레스피기는 파야(1876)처럼 근현대.
-- 티어는 말러·푸치니 A, 메시앙·케이지 A, 홀스트·본 윌리엄스·사라사테 B, 파야·닐센 C 에 맞췄다.
--
-- 초상은 Wikidata P18 이다. 원본이 큰 슈트라우스(1.9MB)·리게티(4.4MB)·레스피기(17MB)는
-- 헨델·비발디 행처럼 upload.wikimedia.org 의 500px 썸네일 주소를 쓴다. 여섯 주소 모두 200 을 확인했다.
-- Commons 사진은 entity_images 에 작가·라이선스를 남긴다(202610020001 과 같은 규칙). 리게티 사진은
-- CC BY-SA 3.0 nl 이라 저작자 표시가 필요하다.

-- 리하르트 슈트라우스 (Richard Strauss, Q13894) · 1864–1949

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '17c891e4-7a22-556e-a182-dafe06f86a73', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '17c891e4-7a22-556e-a182-dafe06f86a73');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '17c891e4-7a22-556e-a182-dafe06f86a73', 'en', 'canonical', 'Richard Strauss', 'richard strauss', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '17c891e4-7a22-556e-a182-dafe06f86a73' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '17c891e4-7a22-556e-a182-dafe06f86a73', 'ko', 'canonical', '리하르트 슈트라우스', '리하르트 슈트라우스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '17c891e4-7a22-556e-a182-dafe06f86a73' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '17c891e4-7a22-556e-a182-dafe06f86a73' AS a, 'gnd' AS n, '11861911X' AS v UNION ALL SELECT '17c891e4-7a22-556e-a182-dafe06f86a73' AS a, 'isni' AS n, '0000000029864532' AS v UNION ALL SELECT '17c891e4-7a22-556e-a182-dafe06f86a73' AS a, 'isni' AS n, '0000000120999614' AS v UNION ALL SELECT '17c891e4-7a22-556e-a182-dafe06f86a73' AS a, 'lccn' AS n, 'n79041680' AS v UNION ALL SELECT '17c891e4-7a22-556e-a182-dafe06f86a73' AS a, 'musicbrainz_artist' AS n, '4cb43d82-824e-4034-b03d-1a98f36f6e16' AS v UNION ALL SELECT '17c891e4-7a22-556e-a182-dafe06f86a73' AS a, 'viaf' AS n, '24796264' AS v UNION ALL SELECT '17c891e4-7a22-556e-a182-dafe06f86a73' AS a, 'wikidata' AS n, 'Q13894' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO composers
    (name, full_name, english_name, period, tier, birth_year, death_year, nationality, avatar_url, cover_image_url, bio, style, influence, authority_entity_id, origin, editor_locked)
SELECT '리하르트 슈트라우스',
       '리하르트 게오르크 슈트라우스',
       'Richard Strauss',
       '낭만주의',
       'A',
       1864,
       1949,
       '독일',
       'https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Postcard-1910_Strauss_Richard.jpg/500px-Postcard-1910_Strauss_Richard.jpg',
       'https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Postcard-1910_Strauss_Richard.jpg/500px-Postcard-1910_Strauss_Richard.jpg',
       '독일의 작곡가이자 지휘자. 리스트와 바그너를 잇는 독일 후기 낭만주의의 마지막 대가로 꼽힌다. 젊은 시절 <돈 후안>, <차라투스트라는 이렇게 말했다> 등 교향시로 이름을 알렸고, 20세기에는 <살로메>, <엘렉트라>, <장미의 기사> 등 오페라로 큰 성공을 거두었다.',
       '교향시, 거대한 편성의 화려한 관현악법, 라이트모티프, 대담한 불협화음(<살로메>, <엘렉트라>), 소프라노를 위한 서정적 선율',
       '그는 리스트가 시작한 교향시를 관현악 묘사의 정점으로 끌어올렸고, 바그너 이후 독일 오페라의 맥을 20세기 중반까지 이었다. <차라투스트라는 이렇게 말했다>의 서주는 영화 <2001: 스페이스 오디세이>에 쓰여 대중에게도 널리 알려졌다.',
       '17c891e4-7a22-556e-a182-dafe06f86a73',
       'manual',
       1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM composers) existing WHERE existing.authority_entity_id = '17c891e4-7a22-556e-a182-dafe06f86a73');

INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT '17c891e4-7a22-556e-a182-dafe06f86a73', 'profile', 'https://commons.wikimedia.org/wiki/File:Postcard-1910_Strauss_Richard.jpg', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Postcard-1910_Strauss_Richard.jpg/500px-Postcard-1910_Strauss_Richard.jpg', NULL, 'Public domain', NULL, 'Public domain', TRUE, 'PUBLISHED'
WHERE EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM composers) target WHERE target.authority_entity_id = '17c891e4-7a22-556e-a182-dafe06f86a73')
AND NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, file_url FROM entity_images) existing
    WHERE existing.authority_entity_id = '17c891e4-7a22-556e-a182-dafe06f86a73' AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Postcard-1910_Strauss_Richard.jpg/500px-Postcard-1910_Strauss_Richard.jpg'
);


-- 리게티 (György Ligeti, Q154331) · 1923–2006

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '1e6a00d2-5e51-5d69-b7c9-7c5604478c63', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '1e6a00d2-5e51-5d69-b7c9-7c5604478c63');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1e6a00d2-5e51-5d69-b7c9-7c5604478c63', 'en', 'canonical', 'György Ligeti', 'györgy ligeti', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1e6a00d2-5e51-5d69-b7c9-7c5604478c63' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1e6a00d2-5e51-5d69-b7c9-7c5604478c63', 'ko', 'canonical', '죄르지 리게티', '죄르지 리게티', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1e6a00d2-5e51-5d69-b7c9-7c5604478c63' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '1e6a00d2-5e51-5d69-b7c9-7c5604478c63' AS a, 'gnd' AS n, '118572911' AS v UNION ALL SELECT '1e6a00d2-5e51-5d69-b7c9-7c5604478c63' AS a, 'isni' AS n, '0000000121358907' AS v UNION ALL SELECT '1e6a00d2-5e51-5d69-b7c9-7c5604478c63' AS a, 'lccn' AS n, 'n80021715' AS v UNION ALL SELECT '1e6a00d2-5e51-5d69-b7c9-7c5604478c63' AS a, 'musicbrainz_artist' AS n, 'da5e774b-026a-4117-82a4-11d246c05a8b' AS v UNION ALL SELECT '1e6a00d2-5e51-5d69-b7c9-7c5604478c63' AS a, 'viaf' AS n, '61732409' AS v UNION ALL SELECT '1e6a00d2-5e51-5d69-b7c9-7c5604478c63' AS a, 'wikidata' AS n, 'Q154331' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO composers
    (name, full_name, english_name, period, tier, birth_year, death_year, nationality, avatar_url, cover_image_url, bio, style, influence, authority_entity_id, origin, editor_locked)
SELECT '리게티',
       '죄르지 샨도르 리게티',
       'György Ligeti',
       '근현대',
       'A',
       1923,
       2006,
       '헝가리/오스트리아',
       'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Gy%C3%B6rgy_Ligeti_%281984%29.jpg/500px-Gy%C3%B6rgy_Ligeti_%281984%29.jpg',
       'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Gy%C3%B6rgy_Ligeti_%281984%29.jpg/500px-Gy%C3%B6rgy_Ligeti_%281984%29.jpg',
       '헝가리 출신의 오스트리아 작곡가. 루마니아 트란실바니아의 헝가리계 유대인 가정에서 태어나 1956년 헝가리 혁명 직후 빈으로 망명했다. 수많은 성부를 촘촘히 겹친 음향으로 <아트모스페르>, <룩스 에테르나> 등을 썼고, 이 곡들이 영화 <2001: 스페이스 오디세이>에 쓰이며 대중에게도 알려졌다.',
       '미크로폴리포니(Micropolyphony), 음향 덩어리, 복잡한 폴리리듬, 기계 장치 같은 리듬, 피아노 연습곡',
       '그는 선율과 화성 대신 음색과 질감의 변화로 음악을 짜는 길을 열어 20세기 후반 아방가르드 음악을 대표하는 작곡가가 되었다. 1973년부터 1989년까지 함부르크 음악대학에서 작곡을 가르쳤으며, 제자 가운데 진은숙이 있다.',
       '1e6a00d2-5e51-5d69-b7c9-7c5604478c63',
       'manual',
       1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM composers) existing WHERE existing.authority_entity_id = '1e6a00d2-5e51-5d69-b7c9-7c5604478c63');

INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT '1e6a00d2-5e51-5d69-b7c9-7c5604478c63', 'profile', 'https://commons.wikimedia.org/wiki/File:Gy%C3%B6rgy_Ligeti_(1984).jpg', 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Gy%C3%B6rgy_Ligeti_%281984%29.jpg/500px-Gy%C3%B6rgy_Ligeti_%281984%29.jpg', 'Marcel Antonisse / Anefo (Nationaal Archief)', 'CC BY-SA 3.0 nl', 'https://creativecommons.org/licenses/by-sa/3.0/nl/deed.en', 'Marcel Antonisse / Anefo (Nationaal Archief) · CC BY-SA 3.0 nl', TRUE, 'PUBLISHED'
WHERE EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM composers) target WHERE target.authority_entity_id = '1e6a00d2-5e51-5d69-b7c9-7c5604478c63')
AND NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, file_url FROM entity_images) existing
    WHERE existing.authority_entity_id = '1e6a00d2-5e51-5d69-b7c9-7c5604478c63' AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Gy%C3%B6rgy_Ligeti_%281984%29.jpg/500px-Gy%C3%B6rgy_Ligeti_%281984%29.jpg'
);


-- 바버 (Samuel Barber, Q216870) · 1910–1981

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b616415c-5102-5aea-ae56-5daf0081361c', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b616415c-5102-5aea-ae56-5daf0081361c');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b616415c-5102-5aea-ae56-5daf0081361c', 'en', 'canonical', 'Samuel Barber', 'samuel barber', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b616415c-5102-5aea-ae56-5daf0081361c' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b616415c-5102-5aea-ae56-5daf0081361c', 'ko', 'canonical', '새뮤얼 바버', '새뮤얼 바버', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b616415c-5102-5aea-ae56-5daf0081361c' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b616415c-5102-5aea-ae56-5daf0081361c' AS a, 'gnd' AS n, '118924109' AS v UNION ALL SELECT 'b616415c-5102-5aea-ae56-5daf0081361c' AS a, 'isni' AS n, '0000000110330095' AS v UNION ALL SELECT 'b616415c-5102-5aea-ae56-5daf0081361c' AS a, 'lccn' AS n, 'n81015460' AS v UNION ALL SELECT 'b616415c-5102-5aea-ae56-5daf0081361c' AS a, 'musicbrainz_artist' AS n, '74ed34ce-ee95-44e9-a87d-4d2d5056c24a' AS v UNION ALL SELECT 'b616415c-5102-5aea-ae56-5daf0081361c' AS a, 'viaf' AS n, '113063168' AS v UNION ALL SELECT 'b616415c-5102-5aea-ae56-5daf0081361c' AS a, 'wikidata' AS n, 'Q216870' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO composers
    (name, full_name, english_name, period, tier, birth_year, death_year, nationality, avatar_url, cover_image_url, bio, style, influence, authority_entity_id, origin, editor_locked)
SELECT '바버',
       '새뮤얼 오즈먼드 바버 2세',
       'Samuel Barber',
       '근현대',
       'B',
       1910,
       1981,
       '미국',
       'https://upload.wikimedia.org/wikipedia/commons/9/91/Samuel_Barber.jpg',
       'https://upload.wikimedia.org/wikipedia/commons/9/91/Samuel_Barber.jpg',
       '미국의 작곡가. 커티스 음악원에서 공부했으며, 20세기 모더니즘의 실험보다 낭만주의의 서정성과 전통적인 화성을 지킨 작곡가로 꼽힌다. 1938년 토스카니니가 초연한 <현을 위한 아다지오>가 대표작이며, 오페라 <바네사>와 피아노 협주곡으로 퓰리처상을 두 차례 받았다.',
       '신낭만주의, 길게 이어지는 서정적 선율, 전통적인 조성과 형식, 가곡과 합창곡, <현을 위한 아다지오>',
       '<현을 위한 아다지오>는 루스벨트 대통령의 서거 소식과 케네디 대통령의 장례 뒤 방송에 쓰이는 등 미국을 대표하는 추모 음악이 되었다. 영화 <엘리펀트 맨>, <플래툰>에도 쓰여 널리 알려졌다.',
       'b616415c-5102-5aea-ae56-5daf0081361c',
       'manual',
       1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM composers) existing WHERE existing.authority_entity_id = 'b616415c-5102-5aea-ae56-5daf0081361c');

INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT 'b616415c-5102-5aea-ae56-5daf0081361c', 'profile', 'https://commons.wikimedia.org/wiki/File:Samuel_Barber.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/91/Samuel_Barber.jpg', 'Carl Van Vechten', 'Public domain', NULL, 'Carl Van Vechten · Public domain', TRUE, 'PUBLISHED'
WHERE EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM composers) target WHERE target.authority_entity_id = 'b616415c-5102-5aea-ae56-5daf0081361c')
AND NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, file_url FROM entity_images) existing
    WHERE existing.authority_entity_id = 'b616415c-5102-5aea-ae56-5daf0081361c' AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/9/91/Samuel_Barber.jpg'
);


-- 뒤카 (Paul Dukas, Q215556) · 1865–1935

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '812fe5cc-035c-533f-a669-fcdea344438a', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '812fe5cc-035c-533f-a669-fcdea344438a');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '812fe5cc-035c-533f-a669-fcdea344438a', 'en', 'canonical', 'Paul Dukas', 'paul dukas', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '812fe5cc-035c-533f-a669-fcdea344438a' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '812fe5cc-035c-533f-a669-fcdea344438a', 'ko', 'canonical', '폴 뒤카', '폴 뒤카', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '812fe5cc-035c-533f-a669-fcdea344438a' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '812fe5cc-035c-533f-a669-fcdea344438a' AS a, 'gnd' AS n, '119174049' AS v UNION ALL SELECT '812fe5cc-035c-533f-a669-fcdea344438a' AS a, 'gnd' AS n, '1394591780' AS v UNION ALL SELECT '812fe5cc-035c-533f-a669-fcdea344438a' AS a, 'isni' AS n, '0000000121299126' AS v UNION ALL SELECT '812fe5cc-035c-533f-a669-fcdea344438a' AS a, 'lccn' AS n, 'n81133533' AS v UNION ALL SELECT '812fe5cc-035c-533f-a669-fcdea344438a' AS a, 'musicbrainz_artist' AS n, '8048b7be-cda8-4e5a-bc4b-57267fc05be1' AS v UNION ALL SELECT '812fe5cc-035c-533f-a669-fcdea344438a' AS a, 'viaf' AS n, '42025062' AS v UNION ALL SELECT '812fe5cc-035c-533f-a669-fcdea344438a' AS a, 'wikidata' AS n, 'Q215556' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO composers
    (name, full_name, english_name, period, tier, birth_year, death_year, nationality, avatar_url, cover_image_url, bio, style, influence, authority_entity_id, origin, editor_locked)
SELECT '뒤카',
       '폴 아브라함 뒤카',
       'Paul Dukas',
       '근현대',
       'C',
       1865,
       1935,
       '프랑스',
       'https://upload.wikimedia.org/wikipedia/commons/2/2a/Paul_Dukas_01.jpg',
       'https://upload.wikimedia.org/wikipedia/commons/2/2a/Paul_Dukas_01.jpg',
       '프랑스의 작곡가이자 평론가, 교육자. 자신에게 매우 엄격해 마음에 들지 않는 작품을 스스로 없앴기 때문에 남은 곡이 많지 않다. 괴테의 시를 바탕으로 한 교향적 스케르초 <마법사의 제자>가 대표작으로, 디즈니 영화 <판타지아>에 쓰이며 더욱 널리 알려졌다.',
       '치밀한 형식과 구성, 화려한 관현악법, 프랑크와 댕디의 영향, 인상주의적 색채, 교향적 스케르초 <마법사의 제자>',
       '그는 파리 음악원과 에콜 노르말에서 작곡을 가르쳐 메시앙, 뒤뤼플레, 로드리고 등을 길러 냈다. 보수와 진보로 갈린 당시 프랑스 음악계에서 어느 편에도 서지 않으면서 양쪽 모두의 존경을 받았다.',
       '812fe5cc-035c-533f-a669-fcdea344438a',
       'manual',
       1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM composers) existing WHERE existing.authority_entity_id = '812fe5cc-035c-533f-a669-fcdea344438a');

INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT '812fe5cc-035c-533f-a669-fcdea344438a', 'profile', 'https://commons.wikimedia.org/wiki/File:Paul_Dukas_01.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Paul_Dukas_01.jpg', NULL, 'Public domain', NULL, 'Public domain', TRUE, 'PUBLISHED'
WHERE EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM composers) target WHERE target.authority_entity_id = '812fe5cc-035c-533f-a669-fcdea344438a')
AND NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, file_url FROM entity_images) existing
    WHERE existing.authority_entity_id = '812fe5cc-035c-533f-a669-fcdea344438a' AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/2a/Paul_Dukas_01.jpg'
);


-- 레스피기 (Ottorino Respighi, Q243837) · 1879–1936

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036', 'en', 'canonical', 'Ottorino Respighi', 'ottorino respighi', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036', 'ko', 'canonical', '오토리노 레스피기', '오토리노 레스피기', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036' AS a, 'gnd' AS n, '118744593' AS v UNION ALL SELECT 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036' AS a, 'isni' AS n, '0000000108726031' AS v UNION ALL SELECT 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036' AS a, 'lccn' AS n, 'n80014383' AS v UNION ALL SELECT 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036' AS a, 'musicbrainz_artist' AS n, '788c380d-247b-42f0-b7a9-64881e1f0fd9' AS v UNION ALL SELECT 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036' AS a, 'viaf' AS n, '14959407' AS v UNION ALL SELECT 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036' AS a, 'wikidata' AS n, 'Q243837' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO composers
    (name, full_name, english_name, period, tier, birth_year, death_year, nationality, avatar_url, cover_image_url, bio, style, influence, authority_entity_id, origin, editor_locked)
SELECT '레스피기',
       '오토리노 레스피기',
       'Ottorino Respighi',
       '근현대',
       'B',
       1879,
       1936,
       '이탈리아',
       'https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Ottorino_Respighi%2C_1927_%28cropped%29.jpg/500px-Ottorino_Respighi%2C_1927_%28cropped%29.jpg',
       'https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Ottorino_Respighi%2C_1927_%28cropped%29.jpg/500px-Ottorino_Respighi%2C_1927_%28cropped%29.jpg',
       '이탈리아의 작곡가, 바이올리니스트, 음악학자. 1900년 상트페테르부르크 황실 극장 관현악단의 수석 비올라 주자로 일하며 림스키코르사코프에게 관현악법을 배웠다. 1913년부터 로마에서 작곡을 가르쳤고, <로마의 분수>, <로마의 소나무>, <로마의 축제>로 이어지는 ''로마 3부작''으로 국제적인 명성을 얻었다.',
       '화려하고 색채적인 관현악법, 로마 3부작 교향시, 그레고리오 성가와 옛 이탈리아 음악의 차용, 회화적 묘사',
       '그는 오페라가 중심이던 이탈리아 음악계에서 관현악곡으로 국제적 성공을 거둔 드문 작곡가였다. 르네상스 시대 류트 음악을 관현악으로 옮긴 <옛 노래와 춤곡>처럼 옛 이탈리아 음악을 되살리는 작업에도 힘썼다.',
       'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036',
       'manual',
       1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM composers) existing WHERE existing.authority_entity_id = 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036');

INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036', 'profile', 'https://commons.wikimedia.org/wiki/File:Ottorino_Respighi,_1927_(cropped).jpg', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Ottorino_Respighi%2C_1927_%28cropped%29.jpg/500px-Ottorino_Respighi%2C_1927_%28cropped%29.jpg', 'Becker & Maass / Marie Boehm', 'Public domain', NULL, 'Becker & Maass / Marie Boehm · Public domain', TRUE, 'PUBLISHED'
WHERE EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM composers) target WHERE target.authority_entity_id = 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036')
AND NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, file_url FROM entity_images) existing
    WHERE existing.authority_entity_id = 'c1c35ab0-1d93-59f7-ab2f-0493ef0ab036' AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Ottorino_Respighi%2C_1927_%28cropped%29.jpg/500px-Ottorino_Respighi%2C_1927_%28cropped%29.jpg'
);


-- 크라이슬러 (Fritz Kreisler, Q78517) · 1875–1962

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e', 'en', 'canonical', 'Fritz Kreisler', 'fritz kreisler', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e', 'ko', 'canonical', '프리츠 크라이슬러', '프리츠 크라이슬러', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e' AS a, 'gnd' AS n, '119069261' AS v UNION ALL SELECT '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e' AS a, 'isni' AS n, '0000000108577654' AS v UNION ALL SELECT '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e' AS a, 'lccn' AS n, 'n81015317' AS v UNION ALL SELECT '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e' AS a, 'musicbrainz_artist' AS n, '590fcad4-2ba4-43bc-a22f-a4bb9b496fe8' AS v UNION ALL SELECT '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e' AS a, 'viaf' AS n, '56796717' AS v UNION ALL SELECT '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e' AS a, 'wikidata' AS n, 'Q78517' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO composers
    (name, full_name, english_name, period, tier, birth_year, death_year, nationality, avatar_url, cover_image_url, bio, style, influence, authority_entity_id, origin, editor_locked)
SELECT '크라이슬러',
       '프리츠 크라이슬러',
       'Fritz Kreisler',
       '낭만주의',
       'B',
       1875,
       1962,
       '오스트리아/미국',
       'https://upload.wikimedia.org/wikipedia/commons/3/3a/Kreisler.jpg',
       'https://upload.wikimedia.org/wikipedia/commons/3/3a/Kreisler.jpg',
       '오스트리아 빈 출신의 바이올리니스트이자 작곡가. 달콤한 음색과 포르타멘토, 루바토를 살린 표현으로 20세기 전반을 대표하는 바이올리니스트로 활약했고, 1910년 엘가의 바이올린 협주곡을 초연했다. <사랑의 기쁨>, <사랑의 슬픔>, <아름다운 로즈마린> 등 빈 정서가 담긴 소품을 남겼다.',
       '빈 왈츠풍의 바이올린 소품, 달콤한 음색, 포르타멘토와 루바토, 옛 거장 양식을 빌린 작품, 앙코르 소품',
       '그의 소품들은 지금도 바이올린 독주회의 단골 앙코르곡이며, 그가 쓴 베토벤 바이올린 협주곡 카덴차는 오늘날 가장 많이 연주된다. 푸냐니·타르티니 등 옛 거장의 곡이라 소개했던 작품 여럿이 사실 자신의 곡이라고 1935년에 밝혔다.',
       '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e',
       'manual',
       1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM composers) existing WHERE existing.authority_entity_id = '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e');

INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e', 'profile', 'https://commons.wikimedia.org/wiki/File:Kreisler.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/3a/Kreisler.jpg', 'Bain News Service', 'Public domain', NULL, 'Bain News Service · Public domain', TRUE, 'PUBLISHED'
WHERE EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM composers) target WHERE target.authority_entity_id = '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e')
AND NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, file_url FROM entity_images) existing
    WHERE existing.authority_entity_id = '40631a98-1e66-5eb0-a670-2a6ee2a9ff9e' AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/3a/Kreisler.jpg'
);
