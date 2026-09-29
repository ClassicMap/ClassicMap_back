-- A tier A27 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   메시앙 <시간의 종말을 위한 4중주> 1곡 "수정의 전례"(piece 360):
--     샤함 / 프뢰스트 / 크라카워                                   0.0696~0.1007
--   메시앙 <투랑갈릴라 교향곡> 1악장 Introduction(piece 362):
--     티보데·샤이·콘세르트허바우 / 유자 왕·넬손스·보스턴 /
--     로리오·정명훈·파리 국립오페라                                 0.0601~0.0692
--   글래스 피아노 연습곡 6번 전곡(piece 354):
--     유자 왕 / 올라프손 / 휘트웰                                   0.0466~0.1021
--
-- 아홉 쌍 전부 임계(0.11) 아래다.
--
-- **셋 다 낱 악장·전곡 트랙이 600초 안에 들어 발췌를 뺐다**(360 은 155~167초,
-- 362 는 374~385초, 354 는 159~377초). A25 373·366, A26 367·368 과 같은 방식이다.
--
-- ## 역할을 둘 바꿨다
--
-- **360 의 role 을 ENSEMBLE 에서 SOLOIST 로 바꿨다.** 이 곡의 이름 붙은 앙상블 녹음
-- (Tashi · Ensemble Walter Boeykens · Amici · Zurich · Left Coast · Eurythmia)은
-- **하나도 위키데이터 항목이 없다.** 적재기는 연주자를 wikidata 로만 해소하므로 쓸 수
-- 없다. 낱 연주자를 앞세운 판은 앞선 악기가 갈린다(샤함 바이올린, 프뢰스트·크라카워
-- 클라리넷). `canonical_credit_role` 이 **SOLOIST 를 받아 soloist 로 줄이므로**
-- (`src/comparison_seed_loader.rs`) 실내악의 첫 크레딧을 악기를 속이지 않고 적을 수 있다.
--
-- **362 의 role 을 CONDUCTOR 에서 PIANIST 로 바꿨다.** 배급 표기가 셋 다 피아니스트를
-- 앞세운다(투랑갈릴라는 사실상 피아노 협주곡이다). 지휘자와 악단을 딸림 크레딧으로
-- 붙이는 것이 스키마에 맞고 A21 457 치건(정경화·뒤투아·RPO)과 같은 꼴이다.
--
-- **362 는 옹드 마르트노 연주자를 적을 자리가 없다.** 배치 정의의 딸림 크레딧 키가
-- conductor · choir · orchestra · accompanist 넷뿐이다. 세 판 모두 배급 표기에 옹드
-- 주자가 있다(하라다 다카시 · 세실 라르티고 · 잔 로리오). 04-loading.md 의 방식대로
-- 나중에 performance_credits 에 직접 보탤 수 있다.
--
-- ## 교체 둘
--
-- **360 에서 포펜을 크라카워로 바꿨다.** 다섯 연주 열 쌍을 다 쟀다.
--
--   프뢰스트↔크라카워 0.0731 · 포펜↔크라카워 0.0978 · 샤함↔프뢰스트 0.0995
--   포펜↔프뢰스트 0.1005 · 에셴바흐↔크라카워 0.1020 · 샤함↔크라카워 0.1028
--   포펜↔에셴바흐 0.1140 · 샤함↔에셴바흐 0.1144 · 프뢰스트↔에셴바흐 0.1173
--   샤함↔포펜 0.1176
--
-- 처음 편성(샤함·포펜·프뢰스트)에서 **샤함↔포펜 한 쌍만 임계를 넘었다.** 조합 열 가지
-- 가운데 포펜·프뢰스트·크라카워가 0.1005 로 가장 낮고 샤함·프뢰스트·크라카워가
-- 0.1028 로 다음인데, 차이가 0.0023 으로 잡음이라 **더 알려진 샤함(DG, 폴 메이어·
-- 왕젠·정명훈과의 판)을 남겼다.**
--
-- **354 에서 레빙스턴을 휘트웰로 바꿨다.** 레빙스턴·올라프손·휘트웰이 최대 0.0720 으로
-- 가장 낮았으나 **레빙스턴의 위키데이터 항목이 클레임 12개에 viaf 하나뿐이라 얇다.**
-- 유자 왕·올라프손·휘트웰이 최대 0.1021 이고 셋 다 항목이 충실하다.
--
-- ## 354 의 길이가 2.37배 갈린다
--
-- 유자 왕 159초 · 올라프손 255초 · 휘트웰 377초다. 글래스 연습곡은 메트로놈 지시가
-- 있어도 연주자마다 크게 갈린다. 전곡이라 발췌 압축 판별이 해당하지 않고, 근거를
-- 회전(셋 다 0반음 최저에 차점 0.27~0.29)과 교차 정렬에 두었다. 자기 정렬이
-- 0.088~0.129 로 낮은 편인데(되풀이 음형이라 자리를 덜 가린다) 구간이 전곡이라
-- 자리가 구조로 고정돼 있다.
--
-- ## 경계
--
-- 아홉 건 모두 끝을 늘리면 나빠지거나 0.001 안에서 움직여 검출값을 그대로 두었다.
-- 360 의 샤함은 시작을 ±3초 밀어 보았고 최저가 검출값 그대로였다.
--
-- ## 선정
--
-- **메시앙 본인이 친 360 의 1956년 판(`Sn8KcMfkiC8`)을 뺐다** — 배급 표기가
-- "Olivier Messiaen · Jean Pasquier · André Vacellier · Etienne Pasquier" 다.
-- 01-selection.md 의 "작곡가가 자기 곡을 연주한 판은 쓰지 않는다" 다. 반면 362 의
-- **이본 로리오는 메시앙의 아내이자 초연 피아니스트이지 작곡가 본인이 아니므로 쓴다.**
--
-- 362 의 나가노 판(`prO9kzXitK8`)은 배급 표기에 악단 이름이 없어 뺐다.
--
-- 202608050211 에서 인물·단체 다섯 곳을 등록했다.
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
