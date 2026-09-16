-- 파일럿 시드 곡 31개의 제목을 한국어로 바꾼다.
--
-- 202608050048 에서 비교 화면에 나오는 5곡(461~465)을 먼저 바꿨고, 여기서는
-- 나머지를 마저 바꾼다. 이 곡들은 연주가 붙지 않아 비교 화면에는 나오지 않지만
-- 곡 목록에는 그대로 노출된다.
--
-- 범위를 여기까지로 한 이유를 적어 둔다. 전체 18,642곡 중 한글 제목은 454개뿐이고
-- 국제 시드 곡 18,155개는 사실상 전부 원어다. 그것까지 한국어로 만드는 일은
-- 시드 파이프라인에서 한국어 라벨을 가져오는 별도 과제다.
-- 다만 legacy 영역(id<500)의 487곡 중 원어 제목은 이 34개뿐이라 그 안의
-- 일관성은 맞출 값어치가 있다.
--
-- 케이지의 466 "1O1", 472 "Six", 489 "One²" 는 제목 자체가 숫자·기호여서
-- 원어가 정확하므로 바꾸지 않는다. 그래서 34개가 아니라 31개다.
--
-- title_en 은 원어 그대로 둔다. editor_locked 는 202608050048 과 같은 이유로
-- 함께 켠다. 켜지 않으면 다음 시드 실행이 원어로 조용히 되돌린다.
--
-- 제목은 국내 표기 관행을 따라 옮겼다. 확정된 번역이 없는 곡은 원제의 뜻을
-- 살려 적었고, 작품 번호와 목록 번호는 원어 표기를 유지했다.


UPDATE pieces SET title = '스위스 병정의 행진', editor_locked = 1
WHERE id = 467 AND origin = 'seed' AND title = 'March of the Swiss';

UPDATE pieces SET title = '론도 I/24', editor_locked = 1
WHERE id = 468 AND origin = 'seed' AND title = 'Rondeau, I/24';

UPDATE pieces SET title = '뱃노래 3번 G♭장조 Op. 42', editor_locked = 1
WHERE id = 469 AND origin = 'seed' AND title = 'Barcarolle no. 3 in G‐flat major, op. 42';

UPDATE pieces SET title = '바이올린과 첼로를 위한 소나타 M. 73', editor_locked = 1
WHERE id = 470 AND origin = 'seed' AND title = 'Sonate pour violon et violoncelle, M. 73';

UPDATE pieces SET title = '<그린슬리브즈> 주제에 의한 환상곡', editor_locked = 1
WHERE id = 471 AND origin = 'seed' AND title = 'Fantasia on “Greensleeves”';

UPDATE pieces SET title = '마주르카 B♭장조 Op. 32', editor_locked = 1
WHERE id = 473 AND origin = 'seed' AND title = 'Mazurka in B‐flat major, op. 32';

UPDATE pieces SET title = '2개의 가곡 TN ii/50: 제1곡 “거룩한 처소의 문에서” G단조', editor_locked = 1
WHERE id = 474 AND origin = 'seed' AND title = '2 Songs, TN ii/50: no. 1 “At the Gates of the Holy Abode” in G minor';

UPDATE pieces SET title = '포로가 된 여인 (동방풍) H. 60C', editor_locked = 1
WHERE id = 475 AND origin = 'seed' AND title = 'La Captive. Orientale, H. 60C';

UPDATE pieces SET title = '플루트와 관현악을 위한 오들레트 Op. 162', editor_locked = 1
WHERE id = 476 AND origin = 'seed' AND title = 'Odelette pour flûte et orchestre, op. 162';

UPDATE pieces SET title = '슬라바! 관현악을 위한 정치적 서곡', editor_locked = 1
WHERE id = 477 AND origin = 'seed' AND title = 'Slava! A Political Overture for Orchestra';

UPDATE pieces SET title = '사랑', editor_locked = 1
WHERE id = 478 AND origin = 'seed' AND title = 'El amor';

UPDATE pieces SET title = '미뉴에트 C#단조 M. 42', editor_locked = 1
WHERE id = 479 AND origin = 'seed' AND title = 'Menuet in C-sharp minor, M. 42';

UPDATE pieces SET title = '가곡 <연인의 곁> D. 162', editor_locked = 1
WHERE id = 480 AND origin = 'seed' AND title = 'Nähe des Geliebten, D. 162';

UPDATE pieces SET title = '6개의 어린이 노래', editor_locked = 1
WHERE id = 481 AND origin = 'seed' AND title = 'Szesc piosenek dziecinnych';

UPDATE pieces SET title = '왈츠 카프리스 4번 A♭장조 Op. 62', editor_locked = 1
WHERE id = 482 AND origin = 'seed' AND title = 'Valse‐caprice no. 4 in A‐flat major, op. 62';

UPDATE pieces SET title = '칸티클 1번 Op. 40 “내 사랑은 나의 것”', editor_locked = 1
WHERE id = 483 AND origin = 'seed' AND title = 'Canticle I, op. 40 “My Beloved Is Mine”';

UPDATE pieces SET title = '오페라 <어린이와 마법>', editor_locked = 1
WHERE id = 484 AND origin = 'seed' AND title = 'L''Enfant et les sortilèges';

UPDATE pieces SET title = '6중주', editor_locked = 1
WHERE id = 485 AND origin = 'seed' AND title = 'Sexteto';

UPDATE pieces SET title = '어린이 앨범 제2권 Op. 100', editor_locked = 1
WHERE id = 486 AND origin = 'seed' AND title = 'Children''s Album, book II for piano, op. 100';

UPDATE pieces SET title = '찬가 I/9', editor_locked = 1
WHERE id = 487 AND origin = 'seed' AND title = 'Hymne, I/9';

UPDATE pieces SET title = '왼손을 위한 피아노 협주곡 D장조', editor_locked = 1
WHERE id = 488 AND origin = 'seed' AND title = 'Concerto for Piano and Orchestra for the Left Hand in D major';

UPDATE pieces SET title = '<아를의 여인> 모음곡 1번 중 미뉴에트', editor_locked = 1
WHERE id = 490 AND origin = 'seed' AND title = 'Minuet from L’Arlésienne Suite no. 1, TN iii/3';

UPDATE pieces SET title = '대학 축전 서곡 Op. 80', editor_locked = 1
WHERE id = 491 AND origin = 'seed' AND title = 'Akademische Fest‐Ouvertüre, op. 80';

UPDATE pieces SET title = '색소폰과 관현악을 위한 랩소디 L. 98', editor_locked = 1
WHERE id = 492 AND origin = 'seed' AND title = 'Rhapsodie pour saxophone et orchestre, L. 98';

UPDATE pieces SET title = '엘레지 Op. 58', editor_locked = 1
WHERE id = 493 AND origin = 'seed' AND title = 'Elegy, op. 58';

UPDATE pieces SET title = '<웨스트 사이드 스토리> 중 “마리아”', editor_locked = 1
WHERE id = 494 AND origin = 'seed' AND title = 'Maria, für mich ist dies der schönste Klang';

UPDATE pieces SET title = '오페라 <헨리 8세>', editor_locked = 1
WHERE id = 495 AND origin = 'seed' AND title = 'Henry VIII';

UPDATE pieces SET title = '6개의 로망스 Op. 4', editor_locked = 1
WHERE id = 496 AND origin = 'seed' AND title = '6 Romances, op. 4';

UPDATE pieces SET title = '뮤직 워크', editor_locked = 1
WHERE id = 497 AND origin = 'seed' AND title = 'Music Walk';

UPDATE pieces SET title = '무무키', editor_locked = 1
WHERE id = 498 AND origin = 'seed' AND title = 'Mumuki';

UPDATE pieces SET title = '엘레바시옹', editor_locked = 1
WHERE id = 499 AND origin = 'seed' AND title = 'Élévation';
