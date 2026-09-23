-- S tier 대기열 F5 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   슈베르트 <겨울나그네> 5곡 "보리수"(piece 116): 피셔디스카우·무어 /
--     괴르네·존슨 / 게르하허·후버                                       0.0741~0.0912
--   슈만 <시인의 사랑> 1곡 "아름다운 5월에"(piece 134): 피셔디스카우·에셴바흐 /
--     괴르네·아슈케나지 / 게르하허·후버                                 0.0595~0.0813
--   하이든 <천지창조> 1부 2곡(piece 87): 카라얀·베를린필 /
--     번스타인·바이에른방송 / 솔티·시카고심포니                          0.0780~0.0916
--
-- 셋 다 낱 트랙을 통째로 썼다. 발췌하지 않았다.
--
-- ## 가곡의 성부를 맞췄다
--
-- 가곡은 조를 옮겨 부르는 것이 표준 관행이다. 보리수는 원조 E장조인데 저음 가수용
-- 이조판이 널리 쓰인다. **세 연주를 모두 바리톤으로 맞춰 골랐고** 회전 곡선에서
-- 0반음이 압도적 최저였다(116 은 0.083~0.091 대 나머지 0.260~0.450, 134 는
-- 0.069~0.077 대 0.314~0.453). 이조로 걸린 연주가 없어 교체하지 않았다.
--
-- 성부를 맞추려고 카우프만(테너)·디도나토(메조)·슈투츠만(콘트랄토)·파스벤더(메조)를
-- 뺐다. 202608050136 에서 "F1 의 마왕이 이조에 안 걸린 것은 셋 다 바리톤이라 조를
-- 옮길 이유가 없었던 운" 이라고 적어 둔 것을 이번에 규칙으로 썼다.
--
-- 천지창조는 시대악기 연주(아르농쿠르·헹엘브로크·헤레베헤)를 전부 뺐다. 남은 셋의
-- tuning 이 +0.30 / +0.20 / +0.14 로 폭 0.16반음 한 덩어리다.
--
-- ## 검출 여섯 건을 고쳤다 — 전부 끝쪽이다
--
-- 마지막 화음이 잘려 있었다. 끝 뒤를 0.1초 해상도로 훑어 화음 타점을 찾고 **타점 +
-- 2.5초**로 통일했다. 평탄도가 내내 0.0001~0.003 이고 하모닉 RMS 가 광대역을 0.2~3dB
-- 차이로 따라붙는 화음의 감쇠라 박수가 아니다.
--
--   보리수 피셔디스카우  270.74 → 272.70   화음 타점 270.21, 남은 길이 0.5 → 2.5초
--   보리수 괴르네        279.55 → 281.60   화음 타점 279.09
--   보리수 게르하허      314.61 → 316.10   화음 타점 313.63
--   5월에 피셔디스카우    86.54 →  88.75   화음 타점 86.25
--   5월에 괴르네          89.49 →  93.10   화음 타점 90.60
--   5월에 게르하허        90.51 →  92.70   화음 타점 90.23
--
-- **괴르네의 시인의 사랑이 가장 심했다. 검출 끝 89.49 가 마지막 화음(90.60)보다 앞이라
-- 섹터 큐가 가리키는 "해결되지 않는 마지막 화음" 이 통째로 빠져 있었다.** 나머지 다섯은
-- 화음 타점 직후 0.3~1.0초에서 끊겨 화음이 뭉텅 잘린 소리가 났을 것이다.
--
-- **끝을 늘리니 비용이 최대 0.0044 올랐다**(134 피셔디스카우↔게르하허 0.0769 → 0.0813).
-- 비용을 낮추려 옮긴 것이 아니라 큐가 가리키는 화음을 넣으려 옮긴 것이다. 202608050147
-- (브람스 바협)·202608050139(실로폰 도입)과 같은 판단이다.
--
-- 천지창조 셋은 트랙 자체가 마지막 화음 감쇠 중에 끊겨 있고 검출 끝이 파일 끝과
-- 0.4~0.9초 차이라 고치지 않았다.
--
-- ## 천지창조의 섹터 이름과 큐를 트랙에 맞췄다
--
-- 섹터를 "1부 '빛이 있으라'(혼돈의 묘사에 이은 합창)" 으로, 큐를 "레치타티보 'Und Gott
-- sprach' 의 첫 음" 으로 적어 두었으나 **세 음반 모두 그 앞의 라파엘 레치타티보
-- "Im Anfange schuf Gott Himmel und Erde" 부터 한 트랙으로 묶는다.** 혼돈의 묘사(서주)는
-- 들어 있지 않고, "Es werde Licht" 는 트랙 안쪽에 있다.
--
-- 구간을 큐에 맞추면 트랙을 잘라야 하므로 **구간을 두고 이름과 큐를 고쳤다.**
-- 202608050143(기사들의 춤)·202608050153(진노의 날)과 같은 판단이다.
--
-- ## 천지창조의 정렬이 레치타티보 쪽에서만 나쁘다
--
-- 세 쌍이 0.0780~0.0916 이다. 구간 삼등분에서 카라얀 기준 앞 0.1498/0.1017,
-- 중간 0.1340/0.1147, **뒤 0.0596/0.0801** 로 뒤가 훨씬 좋다. 경계 훑기는 평평하고
-- 회전 최저는 0반음이다.
--
-- **레치타티보는 박자가 자유롭고 화성이 성기어 chroma 가 붙잡을 것이 적다.** "빛이
-- 있으라" 합창이 들어오는 뒤 1/3 은 0.06~0.08 로 기악 수준이다. 03-verification.md 의
-- "한 음만 반복하는 대목" 과 같은 결이라 판정하지 않고 그대로 뒀다.
--
-- 보리수도 2번 평평함 모양이다(끝점·시작점 훑기가 0.089~0.100 으로 평평하고 최저와
-- 현재 값 차이가 0.0015). 유절가곡이라 3절이 같은 화성을 되풀이하고 연주자마다 3절의
-- 템포·강약 처리가 갈리는 것으로 본다. 202608050136 이 정한 성악의 정상 범위 안이다.
--
-- ## 크레딧
--
-- 가곡의 반주자는 역할이 ACCOMPANIST 다(실내악 짝의 PIANIST 와 다르다).
-- 합창단(빈 징페어라인·바이에른방송 합창단·시카고심포니 합창단)은 붙이지 않았다.
--
-- 천지창조 세 영상은 셋 다 **성악가 Topic 채널**이라 제목·채널로는 지휘자를 알 수 없다.
-- 전부 영상 설명의 배급 표기로 확정했다.
--
-- 경고: rights_mode 를 licensed_self_hosted 로 적지만 실제 이용 허락을 받은
-- 것이 아니다. 202608050017 의 경고와 같은 내용이다.

UPDATE performance_sources source
SET source.rights_mode = 'licensed_self_hosted',
    source.last_checked_at = CURRENT_TIMESTAMP(6)
WHERE source.rights_mode = 'unknown'
  AND EXISTS (
      SELECT 1
      FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.performance_source_id = source.id
  );

UPDATE performance_sectors sector
SET sector.editorial_status = 'EDITOR_REVIEWED'
WHERE sector.editorial_status = 'FACTS_VERIFIED'
  AND EXISTS (
      SELECT 1
      FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.sector_id = sector.id
  );

UPDATE performance_candidates candidate
SET candidate.candidate_status = 'APPROVED'
WHERE candidate.candidate_status = 'REVIEW_REQUIRED'
  AND EXISTS (
      SELECT 1
      FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.sector_id = candidate.sector_id
        AND performance.performance_source_id = candidate.performance_source_id
        AND performance.start_ms = candidate.proposed_start_ms
        AND performance.end_ms = candidate.proposed_end_ms
  );
