-- 비교 화면에 영어로 보이는 곡 5개의 제목을 한국어로 바꾼다.
--
-- 461~499 는 2026-08 비교 영상 파일럿이 만든 곡이다(origin='seed').
-- title 에 원어가 그대로 들어 있어 화면에 영어로 보인다.
-- 그중 발행된 연주가 붙어 실제로 비교 화면에 나오는 것은 5개뿐이다.
--
--   461 Goldberg-Variationen, BWV 988          연주 3
--   462 Lyriske stykker                        연주 3
--   463 Études, op. 25                         연주 3
--   464 Kinderszenen, op. 15                   연주 6
--   465 24 Préludes pour le piano, op. 28      연주 3
--
-- 나머지 34곡은 연주가 없어 비교 화면에 나오지 않으므로 지금 다루지 않는다.
--
-- title_en 은 원어 그대로 둔다. title 만 국내 표기 관행을 따라 바꾼다.
-- 461 은 legacy 곡 11 이 "골든베르크 변주곡"으로 적고 있으나 표준 표기는
-- "골드베르크"이므로 그것을 쓴다.
--
-- editor_locked 를 함께 켠다. 켜지 않으면 다음 시드 실행이 title 을 원어로
-- 조용히 되돌린다. 켜면 global_seed_loader 가 MANUAL_ROW_CONFLICT 로 멈춘다.
-- 조용히 깨지는 것보다 멈추는 편이 낫다고 보았다.
-- 시드를 다시 돌릴 때 이 5행이 걸리면, 시드 입력의 title 을 여기 값과 맞춘 뒤
-- 다시 실행하면 된다.
--
-- 461 과 464 는 각각 legacy 곡 11, 135 와 같은 작품이다. 그 둘은 식별자도
-- part 도 연주도 없는 껍데기이므로 여기서 정리하지 않고 남겨 둔다.
-- 202608050047 에 판단 근거를 적었다.

UPDATE pieces SET title = '골드베르크 변주곡 BWV 988', editor_locked = 1
WHERE id = 461 AND origin = 'seed' AND title = 'Goldberg-Variationen, BWV 988';

UPDATE pieces SET title = '서정 소품집', editor_locked = 1
WHERE id = 462 AND origin = 'seed' AND title = 'Lyriske stykker';

UPDATE pieces SET title = '연습곡 Op. 25', editor_locked = 1
WHERE id = 463 AND origin = 'seed' AND title = 'Études, op. 25';

UPDATE pieces SET title = '어린이의 정경 Op. 15', editor_locked = 1
WHERE id = 464 AND origin = 'seed' AND title = 'Kinderszenen, op. 15';

UPDATE pieces SET title = '24개의 전주곡 Op. 28', editor_locked = 1
WHERE id = 465 AND origin = 'seed' AND title = '24 Préludes pour le piano, op. 28';
