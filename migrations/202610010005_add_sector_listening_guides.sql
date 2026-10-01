-- 비교 구간 21곳에 "이 구간 듣기" 안내를 붙인다.
-- 초안과 확정 기록은 seed_pipeline/curation/listening-notes-2026-10-01/sector-guide-drafts.md 에 있다.
-- 같은 문구를 그 구간을 만든 배치 정의(listeningNote)와 후보 JSONL(editorialNote)에도 넣었다.
-- 설명이 비어 있는 시드 행만 바꾸므로 수동 데이터·편집 잠금 행·이미 쓴 안내는 안전하고, 다시 실행해도 결과가 같다.

-- 36 리스트 파가니니 주제에 의한 대연습곡 3번 "라 캄파넬라" · 도입 종소리 음형
UPDATE performance_sectors
SET description = '작품 첫머리, 높은 D#이 종소리처럼 울리는 대목이에요. 종소리가 몇 번 울리고 잠깐 멈춘 뒤, 오른손이 높은 D#과 그 아래 선율 사이를 한 옥타브 넘게 뛰어다니며 주제를 펼쳐요. 악보에는 **여리게, 그러나 주제는 늘 또렷하게**(ben marcato) 치라고 적혀 있어요. 뛰는 손 사이로 선율이 끊기지 않고 이어지는지 따라가 보세요.'
WHERE piece_id = 140
  AND sector_key = 'opening'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 37 리스트 파가니니 주제에 의한 대연습곡 3번 "라 캄파넬라" · 종결 클라이맥스
UPDATE performance_sectors
SET description = '마지막 스무 초 남짓, 옥타브와 화음이 몰아치는 대목이에요. 처음부터 최대로 치는지, 끝으로 갈수록 쌓는지가 연주자마다 갈려요.'
WHERE piece_id = 140
  AND sector_key = 'coda'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 87 쇼팽 발라드 1번 G단조 · 서주 & 제1주제
UPDATE performance_sectors
SET description = '발라드의 문을 여는 느린 서주와 G단조 제1주제예요. 서주는 옥타브로 겹친 한 줄의 선율을 무겁게 그은 뒤 풀리지 않은 화음에서 멈추고, 주제는 여리게 시작해 뒤로 갈수록 거세져요. **서주 끝 화음에서 얼마나 머물다** 주제로 넘어가는지 귀 기울여 보세요.'
WHERE piece_id = 129
  AND sector_key = 'intro-first-theme'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 71 쇼팽 발라드 1번 G단조 · 전곡
UPDATE performance_sectors
SET description = '느린 서주에서 불같이 몰아치는 코다까지 발라드 한 곡 전체예요. 여린 G단조 제1주제와 속삭이듯 들어오는 E♭장조 제2주제가 조를 바꿔 다시 나와요. **제2주제는 뒤에서 두 번 아주 세게(ff) 커져요.** 처음 여리게 들은 그 선율이 커지는 두 곳을 찾아 들어 보세요.'
WHERE piece_id = 129
  AND sector_key = 'whole-work'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 88 쇼팽 발라드 1번 G단조 · 제2주제
UPDATE performance_sectors
SET description = 'E♭장조 제2주제가 조금 느려지며 속삭이듯(sotto voce) 아주 여리게 들어오는 대목이에요. 왼손이 넓게 펼친 화음 위로 오른손이 두 성부를 겹친 선율을 노래하고, 같은 선율이 곧 한 번 더 시작돼요. 제1주제 구간에 이어서, 얼마나 늦추고 작게 들어오는지 들어 보세요.'
WHERE piece_id = 129
  AND sector_key = 'second-theme'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 89 쇼팽 발라드 1번 G단조 · 코다
UPDATE performance_sectors
SET description = '발라드를 끝맺는 코다예요. 빠르기가 불같이 빨라지고(Presto con fuoco) 박자도 바뀌며, 오른손 화음이 박 사이마다 악센트를 받아 앞으로 밀고 나가요. 왼손은 낮은 베이스와 화음을 오가며 그 엇박을 받쳐요. 이 빠르기를 어디까지 몰아붙이는지 연주를 바꿔 가며 들어 보세요.'
WHERE piece_id = 129
  AND sector_key = 'coda'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 29 슈만 어린이의 정경 Op. 15 · 제3곡 술래잡기
UPDATE performance_sectors
SET description = '술래잡기 놀이를 그린 B단조 곡으로, 빠른 16분음표가 쫓고 쫓기듯 달려요. 앞부분은 두 마디마다 첫 음을 세게 짚고 곧바로 여려지는(sfp) 움직임이 되풀이돼요. 30초 안팎의 짧은 곡이라, 짚는 힘과 달리는 빠르기를 연주마다 번갈아 들어 보기 좋아요.'
WHERE piece_id = 464
  AND sector_key = 'whole-work'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 68 슈만 어린이의 정경 Op. 15 · 제7곡 트로이메라이
UPDATE performance_sectors
SET description = '여린 상행 도약으로 시작하는 F장조 선율이 거듭 돌아오는 곡이에요. 같은 악구가 그대로, 또는 다른 음높이에서 몇 번이고 다시 시작되고, 끝 무렵 가장 높은 음에서 길게 멈췄다가 잦아들어요. 그 높은 음에서 얼마나 오래 머무는지 비교해 보세요.'
WHERE piece_id = 464
  AND sector_key = 'no7-traumerei'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 63 베토벤 피아노 소나타 14번 C#단조 "월광" · 1악장 Adagio sostenuto
UPDATE performance_sectors
SET description = '셋잇단음 반주 위로 점리듬 선율이 떠오르는 1악장 전체예요. 베토벤은 처음부터 끝까지 아주 여리고 섬세하게, 댐퍼를 들어 올린 채(senza sordino) 치라고 적었고, 악장 안에서 가장 센 표시도 ''여리게''예요. 반주의 울림이 선율을 얼마나 감싸는지 느껴 보세요.'
WHERE piece_id = 78
  AND sector_key = 'mv1-adagio'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 69 베토벤 피아노 소나타 14번 C#단조 "월광" · 3악장 Presto agitato
UPDATE performance_sectors
SET description = '여린 아르페지오가 솟구치다 두 마디마다 센 화음 두 개에 부딪히며 시작하는 3악장 전체예요. 곧 G#단조 제2주제가 이어지고, 끝 무렵 두 마디 느린 대목(Adagio)에서 잠깐 멎었다가 처음 빠르기로 돌아가 아주 센 화음으로 닫혀요. 첫 아르페지오의 여림과 센 화음 사이의 대비부터 들어 보세요.'
WHERE piece_id = 78
  AND sector_key = 'mv3-presto'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 80 라흐마니노프 피아노 협주곡 3번 D단조 · 1악장 카덴차
UPDATE performance_sectors
SET description = '1악장의 긴 독주 카덴차가 시작되는 대목이에요. 라흐마니노프는 무거운 화음으로 쌓아 올리는 판(오시아)과 가볍게 달리는 토카타풍 원래 카덴차를 함께 남겼고, **이 구간의 연주들도 판이 갈려요.** 화음으로 밀고 가는지, 가볍게 달려가는지로 어느 판인지 가려 보세요.'
WHERE piece_id = 226
  AND sector_key = 'mv1-cadenza'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 39 차이콥스키 피아노 협주곡 1번 B♭단조 · 1악장 도입부
UPDATE performance_sectors
SET description = '호른이 B♭단조로 짧게 외치며 협주곡의 문을 여는 대목이에요. 곧 D♭장조로 옮겨 가 현악기가 큰 선율을 노래하고, 피아노는 건반을 넓게 가로지르는 화음으로 받쳐요. 이 선율은 도입부가 지나면 다시 나오지 않아요. 피아노 화음이 그 아래서 얼마나 크게 울리는지 살펴보세요.'
WHERE piece_id = 159
  AND sector_key = 'mv1-opening'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 70 베토벤 피아노 소나타 8번 C단조 "비창" · 3악장 Rondo. Allegro
UPDATE performance_sectors
SET description = '〈비창〉의 마지막 악장 전체예요. C단조 론도 주제 사이사이에 E♭장조, A♭장조, C장조 대목이 차례로 끼어들고, 끝 무렵 주제가 A♭장조로 한 번 비친 뒤 C단조로 닫혀요. 같은 악장인데 클립 길이가 4분 안쪽에서 5분 가까이까지 벌어지니, 론도 주제의 빠르기부터 견줘 보세요.'
WHERE piece_id = 79
  AND sector_key = 'mv3-rondo'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 64 베토벤 피아노 소나타 8번 C단조 "비창" · 2악장 Adagio cantabile
UPDATE performance_sectors
SET description = '같은 노래 선율이 세 번 나오는 느린 2악장 전체예요. 가운데 음역에서 시작한 주제가 곧 한 옥타브 위에서 되풀이되고, 단조로 기우는 두 중간 대목을 지날 때마다 다시 돌아와요. 두 번째 중간 대목부터는 반주가 셋잇단음으로 잘게 바뀌어요. 처음과 마지막 주제의 반주를 견줘 보세요.'
WHERE piece_id = 79
  AND sector_key = 'mv2-adagio'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 41 베토벤 교향곡 5번 C단조 "운명" · 1악장 운명 동기
UPDATE performance_sectors
SET description = '네 음짜리 운명 동기가 두 번 울리고 길게 멈추는 교향곡의 첫머리예요. 처음엔 현악기와 클라리넷이 한 줄로 세게 내지르고, 이어서 여린 소리로 현악기들이 동기를 차례로 주고받으며 쌓아 올려요. 두 번의 늘임표에서 숨을 얼마나 오래 참는지 함께 세어 보세요.'
WHERE piece_id = 75
  AND sector_key = 'mv1-fate'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 40 베토벤 교향곡 5번 C단조 "운명" · 4악장 개선 주제
UPDATE performance_sectors
SET description = '앞 악장에서 쉼 없이 넘어와 C장조 총주가 터지는 4악장 첫머리예요. 이 악장에서 처음으로 트롬본과 피콜로, 콘트라바순이 더해져, 으뜸화음을 딛고 올라가는 첫 주제가 앞 악장들보다 두텁게 울려요. 새로 들어온 트롬본이 총주 속 어디서 드러나는지 들어 보세요.'
WHERE piece_id = 75
  AND sector_key = 'mv4-triumph'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 189 글루크 <오르페오와 에우리디체> 중 "에우리디체 없이 어찌하리" · 전곡
UPDATE performance_sectors
SET description = '뒤돌아보는 바람에 에우리디체를 다시 잃은 오르페오가 탄식하는 아리아예요. 장조로 쓰인 같은 선율이 세 번 돌아오고, 그 사이에 그녀의 이름을 부르는 대목이 두 번 끼어들어 조와 빠르기가 바뀌어요. 첫 선율이 돌아올 때마다 같은 말을 어떻게 달리 부르는지 따라가 보세요.'
WHERE piece_id = 63
  AND sector_key = 'whole-work'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 75 모차르트 아이네 클라이네 나흐트무지크 · 1악장 Allegro
UPDATE performance_sectors
SET description = '현악기들이 한목소리로 G장조 화음을 타고 솟구치며 문을 여는 1악장 전체예요. 힘찬 부름 뒤에 바이올린의 노래하는 선율이 이어지고, 곧 D장조의 우아한 둘째 주제가 나와요. 같은 첫머리가 재현부에서 다시 돌아와요. 두 곳을 견줘 들어 보세요.'
WHERE piece_id = 66
  AND sector_key = 'mv1-allegro'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 103 모차르트 교향곡 40번 G단조 · 1악장 도입 (Molto allegro 제1주제)
UPDATE performance_sectors
SET description = '비올라가 잘게 깔아 둔 반주 위에서 바이올린이 여리게 첫 주제를 꺼내는 G단조 교향곡의 첫머리예요. 한숨 같은 두 음 동기를 되풀이하던 주제가 총주로 세차게 터진 뒤, B♭장조로 옮겨 가 반음씩 미끄러져 내려가는 둘째 주제가 이어져요. 첫 마디 반주가 어떤 빠르기와 결로 깔리는지 처음 몇 초에 집중해 보세요.'
WHERE piece_id = 67
  AND sector_key = 'mv1-opening'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 126 모차르트 교향곡 41번 C장조 "주피터" · 4악장 Molto allegro 도입 (푸가 주제)
UPDATE performance_sectors
SET description = '도–레–파–미 네 음 동기로 문을 여는 피날레 첫머리예요. 바이올린이 여리게 꺼낸 이 동기 뒤로 총주가 힘차게 이어지고, 곧 현악기들이 같은 동기를 하나씩 차례로 쌓아 올리는 푸가토가 시작돼요. 네 음이 어느 성부에서 들어오는지 따라가 보면 짜임이 들려요.'
WHERE piece_id = 68
  AND sector_key = 'mv4-molto-allegro'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;

-- 167 모차르트 오페라 <마술피리> · 2막 “밤의 여왕 아리아” (지옥의 복수가 내 마음에 끓어오르고)
UPDATE performance_sectors
SET description = '밤의 여왕이 딸 파미나에게 자라스트로를 죽이라고, 그러지 않으면 모녀의 연을 끊겠다고 몰아붙이는 D단조 아리아예요. 긴 콜로라투라에서 목소리가 높은 F까지 스타카토로 튀어 오르고, 끝은 복수의 신들에게 어머니의 맹세를 들으라고 외치며 맺어요. 높은 F 하나하나가 얼마나 또렷이 찍히는지 들어 보세요.'
WHERE piece_id = 70
  AND sector_key = 'der-holle-rache'
  AND origin = 'seed'
  AND editor_locked = FALSE
  AND description IS NULL;
