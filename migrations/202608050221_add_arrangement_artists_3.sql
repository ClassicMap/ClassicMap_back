-- 편곡 비교 배치 3(생명의 양식)에 필요한 인물 하나를 등록한다.
--
--   호세 카레라스 (Q485165) 테너 — **artists 행만 넣는다**
--
-- 그리골로(546)와 도밍고(674)는 이미 등록돼 있다.
--
-- **카레라스는 authority 엔티티는 있는데 artists 행이 없었다.** 엔티티
-- 8adf0c99-eacb-5adb-8fa4-829fbe378d07 에 식별자 여섯이 이미 붙어 있고 artists 행만
-- 0개다. 새 엔티티를 만들면 같은 viaf·gnd·isni·musicbrainz·lccn 이 두 엔티티에 붙어
-- external_identifiers 의 유니크 제약을 깬다. 그래서 기존 엔티티에 행만 붙인다.
--
-- 202608050219 의 크레메르와 같은 자리다(05-pitfalls.md 의 "등록 여부는 세 단계로
-- 확인한다" 2번). **씨드 앞단이 인물 엔티티를 미리 만들어 두고 artists 행은 배치에서
-- 만드는 구조라 이 자리가 앞으로도 자주 나온다.**

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '호세 카레라스', 'José Carreras', 'tenor', 'A', '1946', 'Spain',
       '8adf0c99-eacb-5adb-8fa4-829fbe378d07', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = '8adf0c99-eacb-5adb-8fa4-829fbe378d07'
);
