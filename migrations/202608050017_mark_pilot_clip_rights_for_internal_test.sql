-- 파일럿 비교 영상 15건의 권리 상태를 자체 호스팅 가능으로 바꾼다.
--
-- 지금은 외부 공개가 아니라 클립 파이프라인이 끝까지 도는지 확인하는 단계다.
-- performance_sources 에는 rights_mode 만 있고 검토 근거를 적을 자리가 없으므로,
-- 무엇을 근거로 바꿨는지는 이 주석과 커밋 메시지가 유일한 기록이다.
--
-- 경고: licensed_self_hosted 로 적지만 실제 이용 허락을 받은 것이 아니다.
-- 외부 공개나 홍보 전에 권리자 확인을 반드시 다시 거쳐야 한다.
-- 대상은 clip_jobs 가 걸려 있는 파일럿 15건뿐이고, 기존 36건은 건드리지 않는다.

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
