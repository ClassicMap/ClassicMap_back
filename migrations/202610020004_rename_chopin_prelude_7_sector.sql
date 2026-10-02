-- 쇼팽 〈24개의 전주곡〉 Op. 28 의 파일럿 구간(운영 id 25)은 작품 전체에 '전곡'으로 걸려 있지만
-- 클립은 셋 다 제7번 A장조(40초 안팎) 한 곡뿐이다. 이름과 갈래를 제7번으로 바로잡는다. sector_key 는 그대로 둔다.
-- 202610010003(슈만 〈어린이의 정경〉 제3곡)과 같은 경우다.
-- 구간이 가리키는 작품 부분(MusicBrainz 제7번)과 옛 값이 모두 같은 시드 행만 고치므로 다시 실행해도 결과가 같다.
-- 파일럿 candidates.jsonl 도 같은 값으로 고쳐 재적재 때 되돌아가지 않게 했다.

UPDATE performance_sectors
SET sector_name = '제7번 A장조',
    name_ko = '제7번 A장조',
    name_en = 'No. 7 in A major',
    sector_type = 'MOVEMENT'
WHERE origin = 'seed'
  AND editor_locked = FALSE
  AND sector_key = 'whole-work'
  AND sector_type = 'WHOLE_WORK'
  AND name_ko = '전곡'
  AND piece_part_id IN (
      SELECT id FROM piece_parts
      WHERE part_key = 'musicbrainz:6ee8d38d-70fb-3442-af41-5669434c494f'
  );
