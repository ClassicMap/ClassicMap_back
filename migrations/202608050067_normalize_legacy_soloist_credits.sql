-- 레거시 비교 영상 source 11건의 독주자 크레딧 역할을 primary_performer 에서 soloist 로 맞춘다.
--
-- 라흐마니노프 협주곡 2·3번과 쇼팽 발라드 1번의 레거시 연주는 수동으로 넣을 때
-- 독주자를 primary_performer 로 적었다. DB 에서 이 역할을 쓰는 크레딧은 이 11건뿐이고
-- 전부 피아노 독주자다. 다른 비교 영상은 같은 자리를 soloist 로 쓴다.
--
-- 같은 영상과 사람이 잡은 발췌 경계로 다시 수집하면 적재기는 기존 source 를 재사용하고,
-- 크레딧은 (source, 연주자, 역할) 이 같을 때만 기존 것으로 본다. 역할이 다르면 같은
-- 사람을 primary 로 한 번 더 넣는다. 역할을 맞춰 두면 기존 크레딧을 그대로 쓴다.
--
-- primary 여부와 순서(is_primary=1, display_order=0)는 바꾸지 않는다.

UPDATE performance_credits credit
JOIN performance_sources source ON source.id = credit.performance_source_id
SET credit.role_code = 'soloist'
WHERE credit.role_code = 'primary_performer'
  AND credit.is_primary = 1
  AND credit.display_order = 0
  AND source.provider = 'youtube'
  AND source.provider_video_id IN (
      'YYUu4Rl7EdE', 'taY5oHleS4I', 'eG1Olvh7vCU', 'l7GtUKE-Ju0', 'SlJEjza0-FQ',
      'rEGOihjqO9w', 'YviN1tuXbzc', 'NsqXCO0ADwM',
      'DPJL488cfRw', 'KUbi0nEnUi4', '5bX_yRzCuM4'
  );
