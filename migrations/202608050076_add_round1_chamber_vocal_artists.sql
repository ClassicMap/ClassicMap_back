-- 1라운드 실내악·가곡·피아노 곡에 필요한 연주자를 추가한다.
--   쇼스타코비치 현악 4중주 8번 2악장(piece 320): 보로딘·에머슨·세인트로렌스 4중주단
--   슈베르트 "아베 마리아"(piece 443): 바버라 보니, 루트 치자크, 반주자 제프리 파슨스
--   쇤베르크 Op.23-1(piece 316): 잔루카 카시올리, 피터 서킨
--
-- 202608050070 과 같은 방식이다. 4중주단은 DB 에 처음 들어오는 현악 앙상블이라
-- 분류를 ensemble 로 쓴다. 가수는 기존 수동 데이터와 같이 soprano 로 쓴다.
-- 파슨스는 설명에 "Piano:" 로 적힌 반주자라 크레딧 역할은 accompanist 다.
-- 한국어 라벨이 없는 곳은 음역했다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'dc75ecca-26c2-5eee-aeb8-7721c47c73a8', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'dc75ecca-26c2-5eee-aeb8-7721c47c73a8');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'dc75ecca-26c2-5eee-aeb8-7721c47c73a8', 'en', 'canonical', 'Borodin Quartet', 'borodin quartet', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'dc75ecca-26c2-5eee-aeb8-7721c47c73a8' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'dc75ecca-26c2-5eee-aeb8-7721c47c73a8', 'ko', 'canonical', '보로딘 콰르텟', '보로딘 콰르텟', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'dc75ecca-26c2-5eee-aeb8-7721c47c73a8' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'dc75ecca-26c2-5eee-aeb8-7721c47c73a8' AS a, 'gnd' AS n, '1212435-7' AS v UNION ALL SELECT 'dc75ecca-26c2-5eee-aeb8-7721c47c73a8' AS a, 'isni' AS n, '0000000120374737' AS v UNION ALL SELECT 'dc75ecca-26c2-5eee-aeb8-7721c47c73a8' AS a, 'musicbrainz_artist' AS n, '598063d1-1fc6-496a-8e91-2c21c38d8c92' AS v UNION ALL SELECT 'dc75ecca-26c2-5eee-aeb8-7721c47c73a8' AS a, 'viaf' AS n, '151425752' AS v UNION ALL SELECT 'dc75ecca-26c2-5eee-aeb8-7721c47c73a8' AS a, 'wikidata' AS n, 'Q894040' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '보로딘 콰르텟', 'Borodin Quartet', 'ensemble', 'A', '1945', 'Russia', 'dc75ecca-26c2-5eee-aeb8-7721c47c73a8', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'dc75ecca-26c2-5eee-aeb8-7721c47c73a8');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '879512cc-2f47-51dd-8124-c5f8045e7bf3', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '879512cc-2f47-51dd-8124-c5f8045e7bf3');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '879512cc-2f47-51dd-8124-c5f8045e7bf3', 'en', 'canonical', 'Emerson String Quartet', 'emerson string quartet', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '879512cc-2f47-51dd-8124-c5f8045e7bf3' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '879512cc-2f47-51dd-8124-c5f8045e7bf3', 'ko', 'canonical', '에머슨 현악 4중주단', '에머슨 현악 4중주단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '879512cc-2f47-51dd-8124-c5f8045e7bf3' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '879512cc-2f47-51dd-8124-c5f8045e7bf3' AS a, 'gnd' AS n, '5048291-9' AS v UNION ALL SELECT '879512cc-2f47-51dd-8124-c5f8045e7bf3' AS a, 'isni' AS n, '0000000110893090' AS v UNION ALL SELECT '879512cc-2f47-51dd-8124-c5f8045e7bf3' AS a, 'musicbrainz_artist' AS n, 'fd20e8ed-0736-44db-8d97-530fbf00e813' AS v UNION ALL SELECT '879512cc-2f47-51dd-8124-c5f8045e7bf3' AS a, 'viaf' AS n, '131479967' AS v UNION ALL SELECT '879512cc-2f47-51dd-8124-c5f8045e7bf3' AS a, 'wikidata' AS n, 'Q681006' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '에머슨 현악 4중주단', 'Emerson String Quartet', 'ensemble', 'A', '1976', 'United States', '879512cc-2f47-51dd-8124-c5f8045e7bf3', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '879512cc-2f47-51dd-8124-c5f8045e7bf3');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '558e9926-1b07-5d9d-bd25-22cb0222d401', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '558e9926-1b07-5d9d-bd25-22cb0222d401');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '558e9926-1b07-5d9d-bd25-22cb0222d401', 'en', 'canonical', 'St. Lawrence String Quartet', 'st. lawrence string quartet', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '558e9926-1b07-5d9d-bd25-22cb0222d401' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '558e9926-1b07-5d9d-bd25-22cb0222d401', 'ko', 'canonical', '세인트로렌스 현악 4중주단', '세인트로렌스 현악 4중주단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '558e9926-1b07-5d9d-bd25-22cb0222d401' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '558e9926-1b07-5d9d-bd25-22cb0222d401' AS a, 'isni' AS n, '0000000106719137' AS v UNION ALL SELECT '558e9926-1b07-5d9d-bd25-22cb0222d401' AS a, 'musicbrainz_artist' AS n, 'f5ed0f7a-5d84-4058-827e-b535fa255a4a' AS v UNION ALL SELECT '558e9926-1b07-5d9d-bd25-22cb0222d401' AS a, 'viaf' AS n, '150032740' AS v UNION ALL SELECT '558e9926-1b07-5d9d-bd25-22cb0222d401' AS a, 'wikidata' AS n, 'Q7589494' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '세인트로렌스 현악 4중주단', 'St. Lawrence String Quartet', 'ensemble', 'B', '1989', 'Canada', '558e9926-1b07-5d9d-bd25-22cb0222d401', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '558e9926-1b07-5d9d-bd25-22cb0222d401');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '34b52252-9a49-5ecd-b9d5-a9d5b6643638', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '34b52252-9a49-5ecd-b9d5-a9d5b6643638');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '34b52252-9a49-5ecd-b9d5-a9d5b6643638', 'en', 'canonical', 'Barbara Bonney', 'barbara bonney', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '34b52252-9a49-5ecd-b9d5-a9d5b6643638' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '34b52252-9a49-5ecd-b9d5-a9d5b6643638', 'ko', 'canonical', '바버라 보니', '바버라 보니', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '34b52252-9a49-5ecd-b9d5-a9d5b6643638' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '34b52252-9a49-5ecd-b9d5-a9d5b6643638' AS a, 'gnd' AS n, '128475684' AS v UNION ALL SELECT '34b52252-9a49-5ecd-b9d5-a9d5b6643638' AS a, 'isni' AS n, '0000000114504697' AS v UNION ALL SELECT '34b52252-9a49-5ecd-b9d5-a9d5b6643638' AS a, 'musicbrainz_artist' AS n, 'c6364110-01b0-44a9-8ea2-4409fadfc66c' AS v UNION ALL SELECT '34b52252-9a49-5ecd-b9d5-a9d5b6643638' AS a, 'viaf' AS n, '198149365979385600403' AS v UNION ALL SELECT '34b52252-9a49-5ecd-b9d5-a9d5b6643638' AS a, 'viaf' AS n, '85380679' AS v UNION ALL SELECT '34b52252-9a49-5ecd-b9d5-a9d5b6643638' AS a, 'wikidata' AS n, 'Q201079' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '바버라 보니', 'Barbara Bonney', 'soprano', 'A', '1956', 'United States', '34b52252-9a49-5ecd-b9d5-a9d5b6643638', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '34b52252-9a49-5ecd-b9d5-a9d5b6643638');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b008c177-ea88-5155-adb7-a7045e20a04b', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b008c177-ea88-5155-adb7-a7045e20a04b');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b008c177-ea88-5155-adb7-a7045e20a04b', 'en', 'canonical', 'Geoffrey Parsons', 'geoffrey parsons', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b008c177-ea88-5155-adb7-a7045e20a04b' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b008c177-ea88-5155-adb7-a7045e20a04b', 'ko', 'canonical', '제프리 파슨스', '제프리 파슨스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b008c177-ea88-5155-adb7-a7045e20a04b' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b008c177-ea88-5155-adb7-a7045e20a04b' AS a, 'gnd' AS n, '12847596X' AS v UNION ALL SELECT 'b008c177-ea88-5155-adb7-a7045e20a04b' AS a, 'isni' AS n, '0000000109300665' AS v UNION ALL SELECT 'b008c177-ea88-5155-adb7-a7045e20a04b' AS a, 'musicbrainz_artist' AS n, '575f99fa-81a8-48ee-b27d-92ca62c32b2e' AS v UNION ALL SELECT 'b008c177-ea88-5155-adb7-a7045e20a04b' AS a, 'viaf' AS n, '104246004' AS v UNION ALL SELECT 'b008c177-ea88-5155-adb7-a7045e20a04b' AS a, 'wikidata' AS n, 'Q326911' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '제프리 파슨스', 'Geoffrey Parsons', 'pianist', 'B', '1929', 'Australia', 'b008c177-ea88-5155-adb7-a7045e20a04b', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'b008c177-ea88-5155-adb7-a7045e20a04b');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'fb600444-22dc-551a-b14d-2c67ef535fe4', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'fb600444-22dc-551a-b14d-2c67ef535fe4');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'fb600444-22dc-551a-b14d-2c67ef535fe4', 'en', 'canonical', 'Ruth Ziesak', 'ruth ziesak', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'fb600444-22dc-551a-b14d-2c67ef535fe4' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'fb600444-22dc-551a-b14d-2c67ef535fe4', 'ko', 'canonical', '루트 치자크', '루트 치자크', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'fb600444-22dc-551a-b14d-2c67ef535fe4' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'fb600444-22dc-551a-b14d-2c67ef535fe4' AS a, 'gnd' AS n, '12854497X' AS v UNION ALL SELECT 'fb600444-22dc-551a-b14d-2c67ef535fe4' AS a, 'isni' AS n, '0000000109732994' AS v UNION ALL SELECT 'fb600444-22dc-551a-b14d-2c67ef535fe4' AS a, 'musicbrainz_artist' AS n, 'f8e0a98a-083b-49c2-a0ef-6b7db2a21c5b' AS v UNION ALL SELECT 'fb600444-22dc-551a-b14d-2c67ef535fe4' AS a, 'viaf' AS n, '54338048' AS v UNION ALL SELECT 'fb600444-22dc-551a-b14d-2c67ef535fe4' AS a, 'wikidata' AS n, 'Q105705' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '루트 치자크', 'Ruth Ziesak', 'soprano', 'B', '1963', 'Germany', 'fb600444-22dc-551a-b14d-2c67ef535fe4', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'fb600444-22dc-551a-b14d-2c67ef535fe4');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'd7d2e196-345d-5e8a-bd02-3851a8ab49e6', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'd7d2e196-345d-5e8a-bd02-3851a8ab49e6');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd7d2e196-345d-5e8a-bd02-3851a8ab49e6', 'en', 'canonical', 'Gianluca Cascioli', 'gianluca cascioli', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd7d2e196-345d-5e8a-bd02-3851a8ab49e6' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd7d2e196-345d-5e8a-bd02-3851a8ab49e6', 'ko', 'canonical', '잔루카 카시올리', '잔루카 카시올리', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd7d2e196-345d-5e8a-bd02-3851a8ab49e6' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'd7d2e196-345d-5e8a-bd02-3851a8ab49e6' AS a, 'gnd' AS n, '135045347' AS v UNION ALL SELECT 'd7d2e196-345d-5e8a-bd02-3851a8ab49e6' AS a, 'isni' AS n, '0000000059440562' AS v UNION ALL SELECT 'd7d2e196-345d-5e8a-bd02-3851a8ab49e6' AS a, 'musicbrainz_artist' AS n, '127d7cb3-d63c-411f-91fe-41f5ee692725' AS v UNION ALL SELECT 'd7d2e196-345d-5e8a-bd02-3851a8ab49e6' AS a, 'viaf' AS n, '49419575' AS v UNION ALL SELECT 'd7d2e196-345d-5e8a-bd02-3851a8ab49e6' AS a, 'wikidata' AS n, 'Q5558139' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '잔루카 카시올리', 'Gianluca Cascioli', 'pianist', 'B', '1979', 'Italy', 'd7d2e196-345d-5e8a-bd02-3851a8ab49e6', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'd7d2e196-345d-5e8a-bd02-3851a8ab49e6');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '0ee431ab-0804-52f6-a116-b5579a5841d9', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '0ee431ab-0804-52f6-a116-b5579a5841d9');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0ee431ab-0804-52f6-a116-b5579a5841d9', 'en', 'canonical', 'Peter Serkin', 'peter serkin', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0ee431ab-0804-52f6-a116-b5579a5841d9' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0ee431ab-0804-52f6-a116-b5579a5841d9', 'ko', 'canonical', '피터 서킨', '피터 서킨', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0ee431ab-0804-52f6-a116-b5579a5841d9' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '0ee431ab-0804-52f6-a116-b5579a5841d9' AS a, 'gnd' AS n, '134519949' AS v UNION ALL SELECT '0ee431ab-0804-52f6-a116-b5579a5841d9' AS a, 'isni' AS n, '0000000114948052' AS v UNION ALL SELECT '0ee431ab-0804-52f6-a116-b5579a5841d9' AS a, 'musicbrainz_artist' AS n, 'ab23df5e-6dcf-4e6c-b125-1091ee50046a' AS v UNION ALL SELECT '0ee431ab-0804-52f6-a116-b5579a5841d9' AS a, 'viaf' AS n, '85870487' AS v UNION ALL SELECT '0ee431ab-0804-52f6-a116-b5579a5841d9' AS a, 'wikidata' AS n, 'Q1361841' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '피터 서킨', 'Peter Serkin', 'pianist', 'A', '1947', 'United States', '0ee431ab-0804-52f6-a116-b5579a5841d9', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '0ee431ab-0804-52f6-a116-b5579a5841d9');

