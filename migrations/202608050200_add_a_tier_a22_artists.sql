-- A tier A22 배치에 필요한 인물·단체 셋을 추가한다.
--   제임스 러바인(지휘) · 시카고 심포니 합창단 · 필하모니아 합창단
--
-- 오르프 <카르미나 부라나> 2곡 "Fortune plango vulnera"(piece 349)와 1곡
-- "오 포르투나"(piece 350)에 쓴다. **이 곡은 합창이 주역이라 choir 를 처음부터
-- 넣었다** — A12 의 천인 교향곡에서 빠뜨려 나중에 보탠 일이 있었다.
--
-- 두 합창단은 wikidata 에 나라 진술이 없어 각각 미국·영국으로 적었다. 한국어
-- 라벨도 없어 한글 이름을 직접 적었다. 러바인은 라벨이 있다.
--
-- 셋 다 항목이 충실하다(클레임 17~140개). 시카고 심포니 합창단만 GND 가 없고
-- ISNI·MusicBrainz·VIAF 는 있다.
--
-- **미등록을 피해 연주를 낮추지 않았다.** 미등록을 피하는 대안은 프레빈·빈 필
-- 이었으나 그 영상이 카라얀·베를린 필 채널에만 올라와 채널 근거가 나빴다.
-- 오자와의 New England Conservatory Chorus 와 요훔·틸레만의 Chor der Deutschen
-- Oper Berlin 은 **wikidata 에 항목 자체가 없다.** 합창단에 QID 가 있는 것은
-- 레바인(시카고)뿐이었다. A20 에서 서브에이전트가 미등록을 피해 더 나쁜 후보로
-- 바꾼 일이 있었는데 그 반대로 한 것이다.
--
-- 202608050193 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '994c6d65-f470-573a-aeae-097b799bdc2f', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '994c6d65-f470-573a-aeae-097b799bdc2f');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '994c6d65-f470-573a-aeae-097b799bdc2f', 'en', 'canonical', 'James Levine', 'james levine', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '994c6d65-f470-573a-aeae-097b799bdc2f' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '994c6d65-f470-573a-aeae-097b799bdc2f', 'ko', 'canonical', '제임스 러바인', '제임스 러바인', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '994c6d65-f470-573a-aeae-097b799bdc2f' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '994c6d65-f470-573a-aeae-097b799bdc2f' AS a, 'gnd' AS n, '118840525' AS v UNION ALL SELECT '994c6d65-f470-573a-aeae-097b799bdc2f' AS a, 'isni' AS n, '0000000122771453' AS v UNION ALL SELECT '994c6d65-f470-573a-aeae-097b799bdc2f' AS a, 'musicbrainz_artist' AS n, '37a2d213-9c2b-4216-a02c-10b1e150c130' AS v UNION ALL SELECT '994c6d65-f470-573a-aeae-097b799bdc2f' AS a, 'viaf' AS n, '19660880' AS v UNION ALL SELECT '994c6d65-f470-573a-aeae-097b799bdc2f' AS a, 'wikidata' AS n, 'Q336388' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '제임스 러바인', 'James Levine', 'conductor', 'A', '1943', 'United States', '994c6d65-f470-573a-aeae-097b799bdc2f', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '994c6d65-f470-573a-aeae-097b799bdc2f');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'ffc75369-fe25-5a94-8890-514d5552fe64', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'ffc75369-fe25-5a94-8890-514d5552fe64');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ffc75369-fe25-5a94-8890-514d5552fe64', 'en', 'canonical', 'Chicago Symphony Chorus', 'chicago symphony chorus', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ffc75369-fe25-5a94-8890-514d5552fe64' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ffc75369-fe25-5a94-8890-514d5552fe64', 'ko', 'canonical', '시카고 심포니 합창단', '시카고 심포니 합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ffc75369-fe25-5a94-8890-514d5552fe64' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'ffc75369-fe25-5a94-8890-514d5552fe64' AS a, 'isni' AS n, '0000000121758177' AS v UNION ALL SELECT 'ffc75369-fe25-5a94-8890-514d5552fe64' AS a, 'musicbrainz_artist' AS n, '63a1b104-76a7-4a9f-b14d-e3e007e0efba' AS v UNION ALL SELECT 'ffc75369-fe25-5a94-8890-514d5552fe64' AS a, 'viaf' AS n, '144392040' AS v UNION ALL SELECT 'ffc75369-fe25-5a94-8890-514d5552fe64' AS a, 'wikidata' AS n, 'Q5095798' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '시카고 심포니 합창단', 'Chicago Symphony Chorus', 'choir', 'A', '1957', 'United States', 'ffc75369-fe25-5a94-8890-514d5552fe64', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'ffc75369-fe25-5a94-8890-514d5552fe64');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a063cdf4-5d68-53e0-b307-f8c73b4af827', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a063cdf4-5d68-53e0-b307-f8c73b4af827');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a063cdf4-5d68-53e0-b307-f8c73b4af827', 'en', 'canonical', 'Philharmonia Chorus', 'philharmonia chorus', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a063cdf4-5d68-53e0-b307-f8c73b4af827' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a063cdf4-5d68-53e0-b307-f8c73b4af827', 'ko', 'canonical', '필하모니아 합창단', '필하모니아 합창단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a063cdf4-5d68-53e0-b307-f8c73b4af827' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a063cdf4-5d68-53e0-b307-f8c73b4af827' AS a, 'gnd' AS n, '802059-0' AS v UNION ALL SELECT 'a063cdf4-5d68-53e0-b307-f8c73b4af827' AS a, 'isni' AS n, '0000000121754651' AS v UNION ALL SELECT 'a063cdf4-5d68-53e0-b307-f8c73b4af827' AS a, 'musicbrainz_artist' AS n, 'c44ca179-80e1-4959-8c47-5c6d516d67fa' AS v UNION ALL SELECT 'a063cdf4-5d68-53e0-b307-f8c73b4af827' AS a, 'viaf' AS n, '146729780' AS v UNION ALL SELECT 'a063cdf4-5d68-53e0-b307-f8c73b4af827' AS a, 'wikidata' AS n, 'Q7183042' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '필하모니아 합창단', 'Philharmonia Chorus', 'choir', 'A', '1957', 'United Kingdom', 'a063cdf4-5d68-53e0-b307-f8c73b4af827', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a063cdf4-5d68-53e0-b307-f8c73b4af827');

