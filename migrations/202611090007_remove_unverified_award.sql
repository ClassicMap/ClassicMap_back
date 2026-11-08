-- 확인되지 않는 수상 기록 하나를 지운다: 알렉산드라 쿠르자크 2009 「오토 크렘퍼 상」(주최 Opernwelt).
-- Opernwelt 에는 그런 이름의 상이 없고, 쿠르자크 공식 약력·위키백과·로열 오페라 하우스 소개에도 없다.
-- 근거: seed_pipeline/curation/fact-fixes-2026-11-09/README.md. 지금 값이 그때 본 값과 같을 때만 지운다.
DELETE FROM artist_awards WHERE id = 270 AND award_name = '오토 크렘퍼 상';
