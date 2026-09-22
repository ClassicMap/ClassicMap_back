-- 슈만 카니발 마지막 곡(piece 138, sector final-marche) 연주 세 건의 구간을 트랙 전체로
-- 되돌린다.
--
-- 이 세 영상은 마지막 곡 "다비드 동맹의 행진"만 담긴 낱 트랙이라 발췌가 필요 없었다.
-- 그런데 202608050098 로 발행할 때 배치 정의의 발췌 지시(끝에서 150초)를 그대로 돌려
-- 트랙의 앞 39~47초가 잘렸다. 섹터 이름은 "마지막 곡 다비드 동맹의 행진" 인데 클립은
-- 그 곡의 뒷부분만 담고 있었다.
--
-- 되돌리는 값은 검출값이다(키신 2~197초, 길트부르그 2~219초, 루빈스타인 0~208초).
-- 이 값으로 잰 교차 정렬은 0.0482 / 0.0485 / 0.0549 로, 잘린 상태(0.0484 / 0.0486 /
-- 0.0557)와 사실상 같다. 클립은 새 구간으로 다시 만들어 갈아 끼운다.
--
-- 섹터의 시작 단서도 발췌 표현에서 곡 시작으로 고친다.

UPDATE performances SET start_ms = 2000,  end_ms = 197000 WHERE id = 328;
UPDATE performances SET start_ms = 2000,  end_ms = 219000 WHERE id = 329;
UPDATE performances SET start_ms = 0,     end_ms = 208000 WHERE id = 326;

UPDATE performance_candidates candidate
JOIN performances performance
  ON performance.sector_id = candidate.sector_id
 AND performance.performance_source_id = candidate.performance_source_id
SET candidate.proposed_start_ms = performance.start_ms,
    candidate.proposed_end_ms = performance.end_ms
WHERE performance.id IN (326, 328, 329);

UPDATE performance_sectors
SET start_cue = '행진 주제의 첫 타건(곡 시작)'
WHERE id = (SELECT sector_id FROM (SELECT sector_id FROM performances WHERE id = 328) s);
