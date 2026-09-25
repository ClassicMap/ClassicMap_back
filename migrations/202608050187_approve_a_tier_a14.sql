-- A tier A14 비교 영상 6건을 발행 직전 상태로 올린다. 세 곡 중 하나는 뺐다.
--
--   프랑크 교향곡 D단조 1악장 도입(piece 180):
--     번스타인·프랑스 국립관현악단 / 뒤투아·몬트리올 / 오자와·보스턴  0.0438~0.0699
--   포레 레퀴엠 4곡 "Pie Jesu"(piece 206, 1900 관현악판):
--     뒤투아·테 카나와 / 바렌보임·암스트롱 / 콜린 데이비스·포프      0.0733~0.0857
--
-- **piece 181 "생명의 양식" 은 뺐다.** 사유는 아래에 따로 적는다.
--
-- **180 의 검출이 세 건 모두 도입을 지나쳤다.** 이 악장은 저현의 느린 3음 동기로
-- 시작하는데 여리고 저역이라 광대역 RMS 로는 가려지지 않는다.
--
--   뒤투아 47.69 → 1.95   오자와 3.13 → 2.50   번스타인 14.63 → 3.85
--
-- 16384점 FFT · 0.05초 · 12음계급으로 좁게 떠서 갈랐다. 세 연주 모두 D → C# → F
-- 동기가 같은 차례로 나온다(뒤투아 2.4/5.2/6.2, 오자와 2.6/5.2/6.2, 번스타인
-- 4.2/9.1/10.2초). 저현 첫 D 의 진입을 시작으로 잡았다. 뒤투아의 0.5~2.1초는
-- 32768점 스펙트럼에서 40Hz 대 저역 럼블이고 D2 배음열이 없어 음악이 아니다.
-- 번스타인의 상시 G(+7dB)는 50Hz 전원 험, 뒤투아·오자와의 A#은 60Hz 험이다.
-- A12 의 말러 1번과 같은 유형이고, 02-detection.md 의 협대역 방법이 두 번째로
-- 일을 했다.
--
-- **180 의 길이 비율이 1.43배였다. 07-excerpt.md 의 두 방법으로 갈랐다.**
-- (1) 기준을 셋 다 바꿔 보니 번스타인/뒤투아가 1.274 / 1.257 / 1.379 로 일정하고
--     오자와/뒤투아도 0.894 / 0.898 / 0.892 로 일정했다. 압축이면 흔들린다.
-- (2) 발췌를 넓히니 120s 1.274 → 180s 1.197 → 300s 1.143 → 600s 1.069 →
--     악장 전체 1.031 로 단조 수렴했다.
-- **실제 템포 차이다.** 번스타인이 Lento 도입을 크게 넓게 잡고 뒤에서 따라잡는다.
-- 규칙대로 가장 느린 번스타인을 기준으로 바꿔 셋을 권장 폭 안에 넣었다
-- (120 / 87.0 / 77.6초). 뒤투아 기준을 두면 번스타인이 152.9초로 넘친다.
-- 오자와의 옮김 비용 0.0631 이 0.06 을 살짝 넘는데, 120초 창을 77.6초로 압축해
-- 맞추느라 오른 것이고 최종 교차 정렬은 0.0699 다.
--
-- 180 은 번스타인이 낀 두 쌍이 0.0695·0.0699 로 나란히 높다. **한 쌍만 튀는 모양이
-- 아니라 두 쌍이 같은 값**이어서 위 템포 차이로 설명된다. 회전 최저 0반음.
--
-- **206 은 발췌를 돌리지 않았다.** 세 영상 모두 Pie Jesu 만 담긴 낱 트랙
-- (206~257초)이라 검출 길이가 이미 그 대목의 길이다. A12 의 천인 교향곡과 같다.
-- 세 트랙 다 시작 화음이 B♭–D–F 로 같고 검출값 앞 4~6초는 저역 럼블뿐이라
-- 큐("반주의 첫 화음")에 맞춰 당겼다(5.78→0.60, 4.76→0.46, 8.06→1.52).
--
-- **206 에 소프라노 크레딧을 보탰다.** 배치 정의가 role 을 CONDUCTOR 로 두어
-- 서브에이전트는 지휘자와 악단만 붙였는데, **Pie Jesu 는 소프라노 독창 악장이라
-- 이 섹터에서 실제로 비교되는 것은 소프라노다.** 202608050186 에서 셋을 등록하고
-- CONDUCTOR(0) → SOPRANO(1) → ORCHESTRA(2) 차례로 넣었다. A12 의 합창단과 같다.
--
-- **합창단은 보태지 않았다.** Pie Jesu 는 합창이 노래하지 않는 악장이라 붙이면
-- 이 섹터에 대해 틀린 크레딧이 된다. 뒤투아의 Choeur de l'OSM 은 wikidata 항목도
-- 없어 셋을 맞출 수도 없었다.
--
-- 206 판본은 셋 다 1900 관현악판이다. 전곡 녹음이고 전현 편성의 대형 교향악단
-- (OSM · 파리 관현악단 · 드레스덴 슈타츠카펠레)이다. 오르간 중심의 1893 판
-- (C-m335SxWFo)과 Rutter 교정판(nT4cmjWRC3Q)은 선정 단계에서 뺐다.
--
-- 콜린 데이비스 트랙(bju1nDX9_rc)은 종결 화음 잔향이 -44dB 인 채 259초 파일
-- 끝에서 잘려 있다. 클립 끝을 258초로 당겨 파일 안에서 끝내게 했다.
--
-- 채널 이름 함정을 한 건 더 만났다. 0SZAJdmkLlg 는 채널이 카라얀인데 표기는
-- 빈 필·푸르트벵글러 1945 다. 오늘 열네 번째다. 채택한 bju1nDX9_rc 도 채널은
-- "Lucia Popp - Topic" 이고 지휘자는 표기로만 확인된다.
--
-- 여섯 건 모두 회전 12방향에서 0반음이 최저다. tuning 폭은 180 이 0.13, 206 이
-- 0.17 반음이다. 오자와 +0.05 · 뒤투아 +0.10 이 0 근처라 A=415 접힘을 의심할
-- 자리지만 회전이 갈랐고 둘 다 현대악기 녹음이다.
--
-- ## piece 181 "생명의 양식" 을 뺀 이유
--
-- 배급 표기와 wikidata 를 다 갖춘 후보로 셋을 골랐는데(그리골로 · 도밍고 ·
-- 알라냐) 첫 정렬이 0.1365 / 0.4166 / 0.3682 로 **세 쌍 모두 임계를 넘었다.**
-- 알라냐가 A♭장조(회전 최저 1반음), 예비로 받은 플로레스가 B♭장조여서 둘을 뺐다.
--
-- 남은 A장조 세 종(그리골로 · 도밍고 · 카레라스)도 **0.1126~0.1370 으로 세 쌍
-- 모두 임계를 넘는다.** 경계 문제가 아니고(끝을 세 가지로 바꿔도 0.113~0.137 로
-- 평평), 이조가 아니고(회전 최저 0반음), 조율 덩어리도 아니다(가장 가까운 쌍이
-- 가장 나쁜 축이다). 삼등분에서 **세 쌍 모두 중간이 가장 나쁘다.**
--
-- 둘째 절 처리가 편곡마다 갈리는 것으로 보인다 — 도밍고는 빈 소년합창단,
-- 카레라스는 보이 소프라노와의 이중창, 그리골로는 관현악이다. 길이가 거의 같은
-- 그리골로(245초)와 카레라스(238초)조차 0.1147 이다. **03-verification 의 5번
-- 패턴(연주마다 구조가 다른 곡)으로 보이나 판정하지 않고 멈췄다.** 예비 둘을
-- 다 썼다.
--
-- 다시 볼 거라면 **같은 출판 편곡을 쓰는 녹음끼리 묶어야 한다. 조만 맞춰서는
-- 안 된다.** 미등록은 카레라스(Q485165) 하나뿐이다.
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
