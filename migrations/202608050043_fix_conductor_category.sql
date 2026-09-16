-- 지휘자인데 category 가 '피아노'로 들어가 있는 연주자 3명을 고친다.
--
-- 비교 영상에 관현악 곡을 넣으면서 발견했다. 적재기는 연주자를
-- external_identifiers.wikidata 로 해소하므로 적재에는 영향이 없었지만
-- 화면 표기에는 영향이 있다.
--
-- 대상은 근거가 분명한 것만이다.
--   422 헤르베르트 폰 카라얀 - 우리 데이터가 이미 지휘자로 쓰고 있다
--                             (performance_credits.role_code='conductor')
--   427 리카르도 무티       - 같은 이유이고, Wikidata 직업에도 pianist 가 없다
--                             (Q158852 지휘자, Q1198887 바이올리니스트)
--   477 Krzysztof Urbański  - Wikidata 직업이 지휘자(Q158852) 하나뿐이다
--
-- category='피아노'인 43명 전체를 훑어 Wikidata 직업(P106)과 대조했다.
-- 아슈케나지·안스네스·자발리슈처럼 피아니스트 겸 지휘자인 사람은 '피아노'가
-- 틀린 것이 아니므로 그대로 둔다. 콘타르스키 형제와 The 5 Browns 는
-- 개인이 아니라 피아노 앙상블이라 P106 이 없을 뿐이다.
--
-- category 자체가 한국어와 영어로 뒤섞여 있는 것(피아노 43 / pianist 70,
-- 바이올린 36 / violinist 26, 목소리 70 ...)은 표기 통일의 문제이고
-- 화면에 어떻게 보여야 하는지와 얽혀 있으므로 여기서 다루지 않는다.

UPDATE artists
SET category = 'conductor'
WHERE id IN (422, 427, 477)
  AND category = '피아노';
