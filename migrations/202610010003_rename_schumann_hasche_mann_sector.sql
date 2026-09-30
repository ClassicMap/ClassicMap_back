-- 슈만 〈어린이의 정경〉의 파일럿 구간(운영 id 29)은 작품 전체에 '전곡'으로 걸려 있지만
-- 클립은 모두 제3곡 '술래잡기'뿐이다. 이름과 갈래를 제3곡으로 바로잡는다. sector_key 는 그대로 둔다.
-- 구간이 가리키는 작품 부분(MusicBrainz 제3곡)과 옛 값이 모두 같은 시드 행만 고치므로 다시 실행해도 결과가 같다.
-- 파일럿 candidates.jsonl 도 같은 값으로 고쳐 재적재 때 되돌아가지 않게 했다.

UPDATE performance_sectors
SET sector_name = '제3곡 술래잡기',
    name_ko = '제3곡 술래잡기',
    name_en = 'III. Hasche-Mann',
    sector_type = 'MOVEMENT'
WHERE origin = 'seed'
  AND editor_locked = FALSE
  AND sector_key = 'whole-work'
  AND sector_type = 'WHOLE_WORK'
  AND name_ko = '전곡'
  AND piece_part_id IN (
      SELECT id FROM piece_parts
      WHERE part_key = 'musicbrainz:7a8d4ff2-f178-39c5-b03b-4050606e11ef'
  );
