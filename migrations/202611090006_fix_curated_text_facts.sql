-- 큐레이션 글의 사실 오류를 고친다(번역할 때 걸린 곳을 웹 자료로 확인). 자료·근거:
-- seed_pipeline/curation/fact-fixes-2026-11-09/(result.json 의 evidence).
-- 한국어·영어 함께 고침 34칸, 근거 없는 수상 기록 2행 삭제
--   (아믈랭 「음반 다수」 2100년, 브론프만 「콜롬비아 국제 콩쿠르」 1975년).
-- 한국어 표기 맞추기: 쇼팽 스타일·세트 안 곡 2곳의 「에튀드」→「연습곡」.
-- 지금 값이 확인할 때 본 값과 같을 때만 바꾼다. 두 번 넣어도 같다.

UPDATE pieces SET description = '''런던의 바흐''다운 우아하고 경쾌한 갈랑 양식의 교향곡. 자신의 오페라 <루치오 실라>의 서곡으로도 알려져 있다.', description_en = 'A symphony in the elegant, light galant style, worthy of "the London Bach." It is also known as the overture to his own opera Lucio Silla.'
WHERE id = 107 AND description = '''런던의 바흐''다운 우아하고 경쾌한 갈랑 양식의 교향곡. 모차르트의 오페라 <루치오 실라>의 서곡으로도 알려져 있다.';

UPDATE pieces SET description = 'J.C. 바흐의 작품으로 알려져 널리 연주되었으나, 실제로는 20세기 프랑스 비올리스트 앙리 카자드쉬의 위작(僞作)으로 밝혀졌다. 그럼에도 불구, 여전히 인기 있는 비올라 레퍼토리이다.', description_en = 'Long known as a work by J.C. Bach and widely performed, it was revealed to be a forgery by the 20th-century French violist Henri Casadesus. Even so, it remains a popular piece of viola repertoire.'
WHERE id = 109 AND description = 'J.C. 바흐의 작품으로 알려져 널리 연주되었으나, 실제로는 20세기 프랑스 첼리스트 앙리 카자드쉬의 위작(僞作)으로 밝혀졌다. 그럼에도 불구, 여전히 인기 있는 비올라 레퍼토리이다.';

UPDATE pieces SET description = '브람스가 20년 이상 공들여 완성한 첫 교향곡. 베토벤의 5번 교향곡과 유사한 C단조에서 C장조로의 ''투쟁과 승리'' 구도를 계승하여 ''베토벤의 10번 교향곡''이라는 찬사를 받았다.', description_en = 'Brahms''s first symphony, which he labored over for more than 20 years. It inherits the "struggle and triumph" design, from C minor to C major, that resembles Beethoven''s Fifth Symphony, and was praised as "Beethoven''s Tenth Symphony."'
WHERE id = 153 AND description = '브람스가 20년 이상 공들여 완성한 첫 교향곡. 베토벤의 9번 교향곡과 유사한 C단조에서 C장조로의 ''투쟁과 승리'' 구도를 계승하여 ''베토벤의 10번 교향곡''이라는 찬사를 받았다.';

UPDATE pieces SET description = '19세에 작곡하여 세계적인 명성을 안겨준 피아노 소품. 크렘린의 종소리를 연상시키는 장엄하고 어두운 화음이 특징이다.', description_en = 'A short piano piece composed at age 19 that brought him worldwide fame. It is characterized by solemn, dark chords reminiscent of the bells of the Kremlin.'
WHERE id = 229 AND description = '23세에 작곡하여 세계적인 명성을 안겨준 피아노 소품. 크렘린의 종소리를 연상시키는 장엄하고 어두운 화음이 특징이다.';

UPDATE performance_sectors SET description = '3악장 클라이맥스부터 끝까지', description_en = 'From the climax of the third movement to the end.'
WHERE id = 18 AND description = '2악장 클라이맥스부터 3악장 피날레까지';

UPDATE performance_sectors SET description = '3악장 도입부', description_en = 'The introduction to the third movement.'
WHERE id = 19 AND description = '2악장 도입부';

UPDATE performance_sectors SET description = '라흐마니노프 피아노 협주곡 1악장', description_en = 'Rachmaninoff Piano Concerto, first movement.'
WHERE id = 11 AND description = '라흐마니노프 피아노 협주곡1 악장';

DELETE FROM artist_awards WHERE id = 112 AND award_name = '음반 다수';

DELETE FROM artist_awards WHERE id = 233 AND award_name = '콜롬비아 국제 콩쿠르';

UPDATE artist_awards SET award_name = '카를로 알베르토 카펠리 국제 콩쿠르', award_name_en = 'Carlo Alberto Cappelli International Competition'
WHERE id = 32 AND award_name = '프리마 베리나 국제 콩쿠르';

UPDATE artist_awards SET award_name = '한스 가보르 벨베데레 성악 콩쿠르', award_name_en = 'Hans Gabor Belvedere Singing Competition'
WHERE id = 178 AND award_name = '한스 기아르디니 콩쿠르';

UPDATE artist_awards SET award_name = '레너드 로즈 국제 첼로 콩쿠르', award_name_en = 'Leonard Rose International Cello Competition'
WHERE id = 265 AND award_name = '레벤탈 콩쿠르';

UPDATE artist_awards SET award_name = '스페인 하엔 국제 피아노 콩쿠르 1위', award_name_en = 'Jaén (Spain) International Piano Competition, 1st prize'
WHERE id = 302 AND award_name = '스페인 안도라 국제 피아노 콩쿠르 1위';

UPDATE artist_awards SET award_name = '궁정가수 (Kammersänger)', award_name_en = 'Kammersänger'
WHERE id = 87 AND award_name = '오페르베트만 (Kammersänger)';

UPDATE artists SET bio = '양인모는 1995년 출생의 한국 바이올리니스트이다.

한국예술종합학교에서 공부했으며, 미국 뉴잉글랜드 음악원에서 미리암 프리드에게, 독일 베를린 한스 아이슬러 음악대학에서 안티에 바이타스에게 사사했다. 2015년 파가니니 국제 바이올린 콩쿠르와 2022년 시벨리우스 국제 바이올린 콩쿠르에서 우승했으며, 베토벤, 슈베르트, 브람스 등 독일 고전-낭만파 레퍼토리를 중심으로 활동하고 있다.

예술의전당, 롯데콘서트홀 등 국내 주요 콘서트홀에서 리사이틀을 개최했으며, 국내 오케스트라와 협연 경험을 쌓아가고 있다. 실내악 활동에도 적극적이며, 다양한 연주자들과 협업하고 있다. 진지하고 성실한 접근으로 작품의 본질을 탐구하는 연주자로 평가받고 있다.', bio_en = 'Inmo Yang is a Korean violinist, born in 1995.

Yang studied at the Korea National University of the Arts, and studied with Miriam Fried at the New England Conservatory in the United States and with Antje Weithaas at the Hanns Eisler School of Music Berlin in Germany. Yang won the International Paganini Competition in 2015 and the International Jean Sibelius Violin Competition in 2022, and works mainly in the German Classical-Romantic repertoire of Beethoven, Schubert, Brahms and others.

Yang has given recitals at leading Korean concert halls such as the Seoul Arts Center and Lotte Concert Hall, and has been gaining experience performing with Korean orchestras. Yang is also active in chamber music and collaborates with a variety of performers. Yang is regarded as a performer who explores the essence of a work with a serious and sincere approach.'
WHERE id = 192 AND bio = '양인모는 1986년 출생의 한국 피아니스트이다.

한국예술종합학교를 졸업했으며, 독일 하노버 음악대학에서 아리에 바르디 교수에게 사사했다. 국내 주요 콩쿠르에서 입상한 경력이 있으며, 베토벤, 슈베르트, 브람스 등 독일 고전-낭만파 레퍼토리를 중심으로 활동하고 있다.

예술의전당, 롯데콘서트홀 등 국내 주요 콘서트홀에서 리사이틀을 개최했으며, 국내 오케스트라와 협연 경험을 쌓아가고 있다. 실내악 활동에도 적극적이며, 다양한 연주자들과 협업하고 있다. 진지하고 성실한 접근으로 작품의 본질을 탐구하는 연주자로 평가받고 있다.';

UPDATE artists SET bio = '대니구(Danny Koo)는 1991년 출생의 한국계 미국인 바이올리니스트이다.

뉴잉글랜드 음악원을 졸업했으며, 미국과 한국을 오가며 양국에서 연주 활동을 하고 있다. 클래식부터 현대음악까지 폭넓은 레퍼토리를 선보인다.

젊은 감각의 연주와 SNS를 통한 적극적인 소통으로 젊은 세대 청중들에게 클래식 음악을 알리는 데 기여하고 있다. 미국과 한국의 주요 콘서트홀에서 리사이틀을 개최하며, 다양한 협연 기회를 통해 경력을 쌓아가고 있다.', bio_en = 'Danny Koo is a Korean-American violinist, born in 1991.

Koo graduated from the New England Conservatory and performs in both the United States and Korea, moving between the two countries. Koo plays a broad repertoire from classical to contemporary music.

Through playing with a youthful sensibility and active engagement on social media, Koo helps introduce classical music to younger audiences. Koo gives recitals at major concert halls in the United States and Korea and builds a career through a variety of opportunities to perform with orchestras.'
WHERE id = 195 AND bio = '대니구(Danny Koo)는 1997년 출생의 미국계 한국 피아니스트이다.

줄리어드 음악원을 졸업했으며, 미국과 한국을 오가며 양국에서 연주 활동을 하고 있다. 국제 콩쿠르 입상 경력이 있으며, 클래식부터 현대음악까지 폭넓은 레퍼토리를 선보인다.

젊은 감각의 연주와 SNS를 통한 적극적인 소통으로 젊은 세대 청중들에게 클래식 음악을 알리는 데 기여하고 있다. 미국과 한국의 주요 콘서트홀에서 리사이틀을 개최하며, 다양한 협연 기회를 통해 경력을 쌓아가고 있다.';

UPDATE artists SET bio = '이지윤(Ji-Yoon Lee)은 1992년 대한민국 출생의 바이올리니스트이다.

유럽 등 국제 무대에서 솔로 및 실내악 연주자로 활동하며 커리어를 쌓고 있다. 섬세하고 통찰력 있는 음악성을 보여준다.', bio_en = 'Ji-Yoon Lee is a violinist born in South Korea in 1992.

Lee is building a career as a soloist and chamber musician on the international stage, including in Europe, and shows delicate, insightful musicianship.'
WHERE id = 244 AND bio = '이지윤(Ji-Yoon Lee)은 1997년 대한민국 출생의 피아니스트이다.

유럽 등 국제 무대에서 솔로 및 실내악 연주자로 활동하며 커리어를 쌓고 있다. 섬세하고 통찰력 있는 음악성을 보여준다.';

UPDATE artists SET style = '명료한 아티큘레이션과 지적인 해석이 돋보이며, 작품의 형식과 구조를 명확하게 표현하는 연주를 구사한다.', style_en = 'Clear articulation and intellectual interpretation stand out, and the playing expresses the form and structure of a work clearly.'
WHERE id = 244 AND style = '명료한 타건과 지적인 해석이 돋보이며, 작품의 형식과 구조를 명확하게 표현하는 연주를 구사한다.';

UPDATE artists SET bio = '조슈아 벨(Joshua Bell)은 1967년 미국 인디애나주 블루밍턴 출생의 바이올리니스트이다.

4세에 바이올린을 시작했으며, 인디애나 대학교에서 조셉 긴골드에게 사사했다. 14세에 리카르도 무티가 지휘하는 필라델피아 오케스트라와 협연하며 데뷔했다.

1713년산 스트라디바리우스 "Gibson ex Huberman"을 연주하며, Decca와 Sony Classical에서 40장이 넘는 음반을 발매했다. 브루흐, 멘델스존, 차이콥스키, 브람스 등 낭만파 협주곡에서 탁월한 해석을 보여준다.

2007년 워싱턴 D.C. 지하철역에서 변장하고 연주한 실험으로 유명해졌으며, 영화 "레드 바이올린" 사운드트랙 연주로도 알려져 있다. 2011년부터 아카데미 오브 세인트 마틴 인 더 필즈의 음악 감독으로 활동하며 지휘와 독주를 병행하고 있다. 현재도 세계 무대에서 활발한 연주 활동을 이어가고 있다.', bio_en = 'Joshua Bell is a violinist born in Bloomington, Indiana, in 1967.

Bell began the violin at the age of 4 and studied with Josef Gingold at Indiana University. At 14, Bell made a debut with the Philadelphia Orchestra under Riccardo Muti.

Bell plays the 1713 Stradivarius “Gibson ex Huberman” and has released more than 40 albums on Decca and Sony Classical. Bell gives outstanding interpretations of Romantic concertos by Bruch, Mendelssohn, Tchaikovsky, Brahms and others.

Bell became famous for a 2007 experiment in which a performance was given in disguise in a Washington, D.C. subway station, and is also known for playing the soundtrack of the film “The Red Violin.” Since 2011 Bell has been music director of the Academy of St Martin in the Fields, combining conducting with solo playing. Bell continues to perform actively on the world stage today.'
WHERE id = 210 AND bio = '조슈아 벨(Joshua Bell)은 1967년 미국 인디애나주 블루밍턴 출생의 바이올리니스트이다.

4세에 바이올린을 시작했으며, 인디애나 대학교에서 조셉 긴골드에게, 이후 필라델피아에서 이반 갈라미안의 제자인 조셉 푹스에게 사사했다. 14세에 리카르도 무티가 지휘하는 필라델피아 오케스트라와 협연하며 데뷔했다.

1989년산 스트라디바리우스 "Gibson ex Huberman"을 연주하며, Sony Classical과 Warner Classics에서 40장이 넘는 음반을 발매했다. 브루흐, 멘델스존, 차이콥스키, 브람스 등 낭만파 협주곡에서 탁월한 해석을 보여준다.

2007년 워싱턴 D.C. 지하철역에서 변장하고 연주한 실험으로 유명해졌으며, 영화 "레드 바이올린" 사운드트랙 연주로도 알려져 있다. 2011년부터 아카데미 오브 세인트 마틴 인 더 필즈의 음악 감독으로 활동하며 지휘와 독주를 병행하고 있다. 현재도 세계 무대에서 활발한 연주 활동을 이어가고 있다.';

UPDATE artists SET bio = '김봄소리는 1989년 대구 출신의 바이올리니스트이다.

2013년 ARD 국제 음악 콩쿠르 바이올린 부문에서 공동 2위(1위 없음)에 올랐으며, 2015년 퀸 엘리자베스 콩쿠르에서 입상한 경력이 있다. 서울대학교에서 김영욱 교수에게 사사했으며, 줄리어드 음악원에서 실비아 로젠버그와 로널드 코프스에게 배웠다.

1725년산 과르네리 델 제수를 연주하며, 도이치 그라모폰과 전속 계약을 맺고 있다. 차이콥스키, 브람스, 시벨리우스 바이올린 협주곡 등 낭만파 대곡에서 탁월한 해석을 보여주며, 런던 필하모닉, 도이치 심포니 베를린, NHK 교향악단 등과 협연했다.

국내외 주요 콘서트홀에서 리사이틀을 개최하고 있다. 실내악에도 적극적으로 참여하며, 다양한 음악가들과 협업하고 있다. 현재 유럽과 아시아를 중심으로 활발한 연주 활동을 이어가고 있다.', bio_en = 'Bomsori Kim is a violinist from Daegu, born in 1989.

Kim shared second prize (no first prize was awarded) in the violin category of the ARD International Music Competition in 2013, and was a laureate of the Queen Elisabeth Competition in 2015. Kim studied with Professor Young Uck Kim at Seoul National University, and with Sylvia Rosenberg and Ronald Copes at the Juilliard School.

Kim plays a 1725 Guarneri del Gesù and has an exclusive contract with Deutsche Grammophon. Kim gives outstanding interpretations of major Romantic works such as the Tchaikovsky, Brahms and Sibelius violin concertos, and has appeared as a soloist with the London Philharmonic Orchestra, the Deutsches Symphonie-Orchester Berlin, the NHK Symphony Orchestra and others.

Kim gives recitals in major concert halls in Korea and abroad. Kim is also an active chamber musician and collaborates with a variety of musicians. Kim currently performs actively, mainly in Europe and Asia.'
WHERE id = 190 AND bio = '김봄소리는 1989년 서울 출신의 바이올리니스트이다.

2016년 ARD 국제 음악 콩쿠르 바이올린 부문에서 우승했으며, 2010년 퀸 엘리자베스 콩쿠르에서 3위에 입상한 경력이 있다. 한국예술종합학교에서 김남윤 교수에게 사사했으며, 줄리어드 음악원에서 도로시 딜레이와 조셉 린에게 배웠다.

1774년산 과르네리 델 제수를 연주하며, Warner Classics와 전속 계약을 맺고 있다. 차이콥스키, 브람스, 시벨리우스 바이올린 협주곡 등 낭만파 대곡에서 탁월한 해석을 보여주며, 런던 필하모닉, 도이치 심포니 베를린, NHK 교향악단 등과 협연했다.

2017년 금호아트홀 상주음악가로 활동했으며, 국내외 주요 콘서트홀에서 리사이틀을 개최하고 있다. 실내악에도 적극적으로 참여하며, 다양한 음악가들과 협업하고 있다. 현재 유럽과 아시아를 중심으로 활발한 연주 활동을 이어가고 있다.';

UPDATE artists SET bio = '키에프 태생으로, 키에프 음악원에서 블루멘펠트에게서 가르침을 받고, 소년 시절부터 범상치 않은 천재적 재능을 발휘하였다. 

제1차 세계 대전 및 러시아 혁명 직후의 혼란기에 고국을 탈출, 1925년 말 독일로 건너가 베를린에서 서방 무대에 데뷔하였고, 이후 영국 런던과 프랑스 파리에서 압도적인 호평을 받았다. 1928년 도미하여 성공적으로 데뷔하고, 곧 명지휘자 토스카니니에게 전폭적인 지지를 받았으며, 결국 그의 딸 완다와 결혼까지 하게 된다. 

그 후 구미에서 활약했으나 건강이 좋지 못하게 되어, 1953년에는 완전히 무대에서 물러났다. 하지만 1965년 5월에는 카네기 홀에서 부활 독주회를 개최하여 무대에 다시 복귀하였다. 그는 몸이 다소 허약하였지만 손가락 끝은 날카로워 명확한 터치에 능하고, 다이내믹하다는 평을 들었다. 또 옥타브의 연속, 세련되면서도 박력있는 음악적 효과를 빚어내는데도 뛰어난 재능을 보였다. 하지만 한 작곡가의 작품에 몰입하여 작품을 연주하지 않은 것은 그의 약점으로 항상 지적받았다. 템포, 리듬은 빈틈없이 꼼꼼했지만, 후기에는 건강 상태 때문에 점차로 음악에 주관이 강한 낭만적 기분이 강렬하게 나타나, 과거의 확고한 템포나 리듬이 자유로이 다뤄지는 경향이 점점 심해졌다. 

명연주는 쇼팽의 〈스케르초 1번〉, 〈바르카롤>, <소나타 2번>, 〈마주르카〉, 리스트의 <피아노 소나타 B단조>와 〈오베르만의 골짜기〉, 슈만의 〈어린이의 정경〉, 라흐마니노프의 <피아노 협주곡 제3번>과 <피아노 소나타 2번>, 스크랴빈의 <연습곡>, <전주곡> 및 〈시곡〉과 〈소나타 9번〉, 스카를라티의 소나타 등이다. ', bio_en = 'Born in Kyiv, Horowitz studied with Felix Blumenfeld at the Kyiv Conservatory and showed extraordinary genius from boyhood.

Escaping his homeland in the turmoil that followed World War I and the Russian Revolution, he went to Germany at the end of 1925 and made his Western debut in Berlin; he then received overwhelming acclaim in London, England, and Paris, France. In 1928 he went to the United States and made a successful debut there, soon received wholehearted support from the famous conductor Toscanini, and eventually married Toscanini''s daughter Wanda.

He was active in Europe and America afterward, but his health declined, and in 1953 he withdrew from the stage completely. In May 1965, however, he gave a “comeback” recital at Carnegie Hall and returned to the stage. Though somewhat frail in body, he had sharp fingertips and was said to excel at clear touch and to be dynamic. He also showed outstanding talent in producing refined yet forceful musical effects, such as in successions of octaves. However, it was always pointed out as his weakness that he did not devote himself to the works of a single composer. His tempo and rhythm were meticulous and exact, but in his later years, because of his health, a strongly subjective, romantic mood increasingly appeared in his music, and the tendency to treat his former firm tempo and rhythm freely grew more and more pronounced.

His acclaimed performances include Chopin''s Scherzo No. 1, Barcarolle, Sonata No. 2 and Mazurkas; Liszt''s Piano Sonata in B minor and “Vallée d''Obermann”; Schumann''s Kinderszenen (Scenes from Childhood); Rachmaninoff''s Piano Concerto No. 3 and Piano Sonata No. 2; Scriabin''s Études, Preludes and Poèmes, and Sonata No. 9; and Scarlatti''s sonatas.'
WHERE id = 367 AND bio = '키에프 태생으로, 키에프 음악원에서 블루멘펠트예게서 가르침을 받고, 소년 시절부터 범상치 않은 천재적 재능을 발휘하였다. 

제1차 세계 대전 및 러시아 혁명 직후의 혼란기에 고국을 탈출, 1923년 독일 제국 바이에른주 뮌헨에서 피아니스트로 데뷔하였으며 이듬해 1924년 독일 제국 베를린에서 정식 데뷔하였고, 이후 영국 런던과 프랑스 파리에서 압도적인 호평을 받았다. 1928년 도미하여 성공적으로 데뷔하고, 곧 명지휘자 토스카니니에게 전폭적인 지지를 받았으며, 결국 그의 딸 완다와 결혼까지 하게 된다. 

그 후 구미에서 활약했으나 건강이 좋지 못하게 되어, 1953년에는 완전히 무대에서 물러났다. 하지만 1965년 5월에는 카네기 홀에서 부활 독주회를 개최하여 무대에 다시 복귀하였다. 그는 몸이 다소 허약하였지만 손가락 끝은 날카로워 명확한 터치에 능하고, 다이내믹하다는 평을 들었다. 또 옥타브의 연속, 세련되면서도 박력있는 음악적 효과를 빚어내는데도 뛰어난 재능을 보였다. 하지만 한 작곡가의 작품에 몰입하여 작품을 연주하지 않은 것은 그의 약점으로 항상 지적받았다. 템포, 리듬은 빈틈없이 꼼꼼했지만, 후기에는 건강 상태 때문에 점차로 음악에 주관이 강한 낭만적 기분이 강렬하게 나타나, 과거의 확고한 템포나 리듬이 자유로이 다뤄지는 경향이 점점 심해졌다. 

명연주는 쇼팽의 〈스케르초 1번〉, 〈바르카롤>, <소나타 2번>, 〈마주르카〉, 리스트의 <피아노 소나타 B단조>와 〈오베르만의 골짜기〉, 슈만의 〈어린이의 정경〉, 라흐마니노프의 <피아노 협주곡 제3번>과 <피아노 소나타 2번>, 스크랴빈의 <연습곡>, <전주곡> 및 〈시곡〉과 〈소나타 9번〉, 스카를라티의 소나타 등이다. ';

UPDATE artists SET bio = '다니엘 호프(Daniel Hope)는 1973년 남아프리카 공화국 더반 출생의 바이올리니스트이다.

메뉴힌에게 사사했으며, 베토벤, 브람스 등 주요 레퍼토리 외에도 잘 알려지지 않은 작품과 현대 작곡가들의 작품을 적극적으로 발굴하여 연주한다.

보자르 트리오의 멤버로 활동하기도 했으며, 2016년부터 취리히 실내관현악단의 음악감독으로 활동하고 있다.', bio_en = 'Daniel Hope is a violinist born in Durban, South Africa, in 1973.

A student of Menuhin, Hope actively unearths and performs little-known works and works by contemporary composers, in addition to major repertoire such as Beethoven and Brahms.

Hope has also been a member of the Beaux Arts Trio, and since 2016 has served as music director of the Zurich Chamber Orchestra.'
WHERE id = 270 AND bio = '다니엘 호프(Daniel Hope)는 1974년 남아프리카 공화국 더반 출생의 바이올리니스트이다.

메뉴힌에게 사사했으며, 베토벤, 브람스 등 주요 레퍼토리 외에도 잘 알려지지 않은 작품과 현대 작곡가들의 작품을 적극적으로 발굴하여 연주한다.

크로노스 콰르텟의 멤버로 활동하기도 했으며, 2020년부터 취리히 오페라의 음악감독으로 활동하고 있다.';

UPDATE artists SET bio = '프랑수아 자비에 로트(François-Xavier Roth)는 1971년 프랑스 파리 출생의 지휘자이다.

오케스트라 레 시에클(Les Siècles)을 창단하여 시대악기와 현대악기를 오가며 연주하는 혁신적인 접근을 시도하고 있다. 특히 프랑스 레퍼토리 해석에 정평이 나 있다.', bio_en = 'François-Xavier Roth is a conductor born in Paris in 1971.

Roth founded the orchestra Les Siècles and takes an innovative approach, moving between period and modern instruments. Roth is especially well established for interpretations of French repertoire.'
WHERE id = 292 AND bio = '프랑수아 자비에 로트(François-Xavier Roth)는 1971년 프랑스 파리 출생의 지휘자이다.

현대 음악 전문 앙상블인 레 시에클(Les Siècles)을 창단하여 시대악기와 현대악기를 오가며 연주하는 혁신적인 접근을 시도하고 있다. 특히 프랑스 레퍼토리 해석에 정평이 나 있다.';

UPDATE artists SET bio = '라두 루푸(Radu Lupu)는 1945년 루마니아 갈라치 출생의 피아니스트이다. 2022년 별세했다.

1966년 반 클라이번 국제 피아노 콩쿠르 우승, 1967년 조르주 에네스쿠 국제 콩쿠르 우승, 1969년 리즈 국제 피아노 콩쿠르 우승 등 최고의 콩쿠르를 석권했다. 은둔적인 사생활과 달리 깊고 서정적인 연주로 추앙받았다.

특히 슈베르트, 모차르트, 브람스 연주에 있어 독보적인 해석을 보여주었다.', bio_en = 'Radu Lupu was a pianist born in Galați, Romania, in 1945. Lupu died in 2022.

Lupu won the Van Cliburn International Piano Competition in 1966, the George Enescu International Competition in 1967 and the Leeds International Piano Competition in 1969, sweeping the top competitions. In contrast to a reclusive private life, Lupu was revered for deep, lyrical playing.

The interpretations of Schubert, Mozart and Brahms in particular were unrivaled.'
WHERE id = 252 AND bio = '라두 루푸(Radu Lupu)는 1945년 루마니아 갈라치 출생의 피아니스트이다.

1966년 반 클라이번 국제 피아노 콩쿠르 우승, 1967년 조르주 에네스쿠 국제 콩쿠르 우승, 1969년 리즈 국제 피아노 콩쿠르 우승 등 최고의 콩쿠르를 석권했다. 은둔적인 사생활과 달리 깊고 서정적인 연주로 추앙받았다.

특히 슈베르트, 모차르트, 브람스 연주에 있어 독보적인 해석을 보여주었다.';

UPDATE artists SET style = '부드럽고 유려한 프레이징과 맑은 음색을 특징으로 하며, 섬세한 감성을 표현한다.', style_en = 'Soft, fluent phrasing and a clear tone, expressing a delicate sensibility.'
WHERE id = 284 AND style = '부드럽고 유려한 프레이징과 맑은 음색을 특징으로 하며, 여성 첼리스트 특유의 섬세한 감성을 표현한다.';

UPDATE artists SET bio = '임윤찬은 2004년 경기도 시흥 출신의 피아니스트이다.

2022년 제16회 반 클라이번 국제 피아노 콩쿠르에서 18세의 나이로 최연소 우승을 차지하며 전 세계의 주목을 받았다. 한국예술종합학교 재학 중 우승했으며, 손민수 교수에게 사사했다.

2019년 윤이상 국제 음악 콩쿠르 최연소 우승을 거쳐, 2022년 반 클라이번 콩쿠르에서 라흐마니노프 피아노 협주곡 3번과 베토벤 피아노 협주곡 3번으로 심사위원들과 청중을 사로잡았다. 우승 후 즉시 카네기홀, 링컨센터, 베를린 필하모니 등에서 연주했다.

2023년 데카 클래식스(Decca Classics)와 전속 계약을 맺었으며, 첫 앨범으로 쇼팽 연습곡을 녹음했다. 필라델피아 오케스트라, 로스앤젤레스 필하모닉, 런던 심포니 등과 협연하며, 2024-2025 시즌에는 유럽과 미국 주요 도시에서 리사이틀 투어를 진행했다. 현재 클래식 음악계에서 가장 주목받는 젊은 피아니스트로 평가받고 있다.', bio_en = 'Yunchan Lim is a pianist born in 2004 in Siheung, Gyeonggi Province.

In 2022 Lim won the 16th Van Cliburn International Piano Competition at the age of 18, the youngest winner in its history, and drew attention around the world. The win came while Lim was still a student at the Korea National University of the Arts, where Lim studied with Professor Minsoo Sohn.

After becoming the youngest winner of the 2019 Isang Yun International Music Competition, Lim won over the jury and audience at the 2022 Van Cliburn Competition with Rachmaninoff''s Piano Concerto No. 3 and Beethoven''s Piano Concerto No. 3. Right after winning, Lim performed at Carnegie Hall, Lincoln Center, the Berlin Philharmonie and elsewhere.

In 2023 Lim signed an exclusive contract with Decca Classics, and the first album for the label recorded Chopin''s Études. Lim has appeared as a soloist with the Philadelphia Orchestra, the Los Angeles Philharmonic, the London Symphony Orchestra and others, and in the 2024-2025 season gave a recital tour of major cities in Europe and the United States. Lim is currently regarded as the young pianist attracting the most attention in the classical music world.'
WHERE id = 187 AND bio = '임윤찬은 2004년 경기도 시흥 출신의 피아니스트이다.

2022년 제16회 반 클라이번 국제 피아노 콩쿠르에서 18세의 나이로 최연소 우승을 차지하며 전 세계의 주목을 받았다. 한국예술종합학교 재학 중 우승했으며, 손민수 교수에게 사사했다.

2021년 이사이 국제 피아노 콩쿠르 세미파이널 진출을 거쳐, 2022년 반 클라이번 콩쿠르에서 라흐마니노프 피아노 협주곡 3번과 베토벤 소나타로 심사위원들과 청중을 사로잡았다. 우승 후 즉시 카네기홀, 링컨센터, 베를린 필하모니 등에서 연주했다.

2024년 도이치 그라모폰(DG)과 전속 계약을 맺었으며, 첫 앨범으로 쇼팽과 리스트 작품을 녹음했다. 필라델피아 오케스트라, 로스앤젤레스 필하모닉, 런던 심포니 등과 협연하며, 2024-2025 시즌에는 유럽과 미국 주요 도시에서 리사이틀 투어를 진행했다. 현재 클래식 음악계에서 가장 주목받는 젊은 피아니스트로 평가받고 있다.';

UPDATE artists SET bio = '다닐 트리포노프(Daniil Trifonov)는 1991년 러시아 니즈니노브고로드 출생의 피아니스트이다.

2011년 루빈스타인 국제 피아노 콩쿠르와 차이콥스키 국제 콩쿠르에서 모두 우승하며 세계적인 주목을 받았다. 모스크바 그네신 음악학교에서 타티아나 젤리크만에게, 클리블랜드 음악원에서 세르게이 바바얀에게 사사했다.

도이치 그라모폰과 전속 계약을 맺고 쇼팽, 리스트, 라흐마니노프, 차이콥스키 등의 앨범을 발매했으며, 여러 음반이 그래미상 후보에 올랐다. 베를린 필하모닉, 빈 필하모닉, 뉴욕 필하모닉 등 세계 정상급 오케스트라와 정기적으로 협연하고 있다.

피아니스트로서뿐만 아니라 작곡가로도 활동하며, 자신의 작품을 연주하기도 한다. 카네기홀, 빈 무지크페라인, 베를린 필하모니 등 세계 주요 콘서트홀에서 리사이틀을 개최하고 있다. 현재 세대를 대표하는 최고의 피아니스트 중 한 명으로 평가받으며, 뛰어난 음악성과 테크닉을 겸비한 연주자로 인정받고 있다.', bio_en = 'Daniil Trifonov is a pianist born in Nizhny Novgorod, Russia, in 1991.

In 2011 Trifonov won both the Rubinstein International Piano Competition and the Tchaikovsky International Competition, which brought worldwide attention. Trifonov studied with Tatiana Zelikman at the Gnessin School of Music in Moscow and with Sergei Babayan at the Cleveland Institute of Music.

An exclusive contract with Deutsche Grammophon followed, and albums of works by Chopin, Liszt, Rachmaninoff, Tchaikovsky and others have been released, several of them nominated for Grammy Awards. Trifonov performs regularly as a soloist with leading orchestras such as the Berlin Philharmonic, the Vienna Philharmonic and the New York Philharmonic.

Besides being a pianist, Trifonov is also active as a composer and sometimes performs original works. Recitals are given at major concert halls around the world, including Carnegie Hall, the Vienna Musikverein and the Berlin Philharmonie. Trifonov is regarded as one of the leading pianists of this generation and is recognized as a performer who combines outstanding musicianship with technique.'
WHERE id = 202 AND bio = '다닐 트리포노프(Daniil Trifonov)는 1991년 러시아 니즈니노브고로드 출생의 피아니스트이다.

2011년 루빈스타인 국제 피아노 콩쿠르와 차이콥스키 국제 콩쿠르에서 모두 우승하며 세계적인 주목을 받았다. 클리블랜드 음악원에서 세르게이 바바얀에게, 뉴욕에서 세르게이 레시체티스키에게 사사했다.

도이치 그라모폰과 전속 계약을 맺고 쇼팽, 리스트, 라흐마니노프, 차이콥스키 등의 앨범을 발매했으며, 여러 음반이 그래미상 후보에 올랐다. 베를린 필하모닉, 빈 필하모닉, 뉴욕 필하모닉 등 세계 정상급 오케스트라와 정기적으로 협연하고 있다.

피아니스트로서뿐만 아니라 작곡가로도 활동하며, 자신의 작품을 연주하기도 한다. 카네기홀, 빈 무지크페라인, 베를린 필하모니 등 세계 주요 콘서트홀에서 리사이틀을 개최하고 있다. 현재 세대를 대표하는 최고의 피아니스트 중 한 명으로 평가받으며, 뛰어난 음악성과 테크닉을 겸비한 연주자로 인정받고 있다.';

UPDATE artists SET bio = '마우리치오 폴리니(Maurizio Pollini)는 1942년 이탈리아 밀라노 출생의 피아니스트이다. 2024년 별세했다.

1960년 18세의 나이로 쇼팽 국제 피아노 콩쿠르에서 우승하며 심사위원장 아르투르 루빈스타인으로부터 "우리 중 누구보다 뛰어나다"는 찬사를 받았다. 밀라노 음악원에서 카를로 로나티에게 사사했으며, 이후 아르투로 베네데티 미켈란젤리에게도 배웠다.

베토벤, 쇼팽, 슈베르트, 브람스 등 고전-낭만파 레퍼토리뿐만 아니라 쇤베르크, 베베른, 부조니, 노노, 스톡하우젠 등 현대음악 해석에서도 최고의 권위자로 인정받았다. 도이치 그라모폰과 50년 이상 전속 계약을 유지하며 100장이 넘는 음반을 발매했다.

베를린 필하모닉, 빈 필하모닉 등과 수없이 협연했으며, 특히 클라우디오 아바도와의 협업이 유명하다. 완벽주의적 접근과 지적인 해석으로 20세기 후반 최고의 피아니스트 중 한 명으로 평가받았다.', bio_en = 'Maurizio Pollini was a pianist born in Milan, Italy, in 1942. Pollini died in 2024.

In 1960, at the age of 18, Pollini won the International Chopin Piano Competition, and Artur Rubinstein, the chairman of the jury, praised the winner by saying, “Better than any of us.” Pollini studied with Carlo Lonati at the Milan Conservatory and later with Arturo Benedetti Michelangeli.

Pollini was recognized as a leading authority not only in the Classical-Romantic repertoire of Beethoven, Chopin, Schubert, Brahms and others but also in the interpretation of contemporary music by Schoenberg, Webern, Busoni, Nono, Stockhausen and others. An exclusive contract with Deutsche Grammophon lasted more than 50 years, and more than 100 albums were released.

Pollini performed countless times with the Berlin Philharmonic, the Vienna Philharmonic and others, and the collaboration with Claudio Abbado is especially famous. With a perfectionist approach and intellectual interpretations, Pollini was regarded as one of the leading pianists of the late 20th century.'
WHERE id = 207 AND bio = '마우리치오 폴리니(Maurizio Pollini)는 1942년 이탈리아 밀라노 출생의 피아니스트이다. 2024년 별세했다.

1960년 18세의 나이로 쇼팽 국제 피아노 콩쿠르에서 우승하며 심사위원장 아르투르 루빈스타인으로부터 "우리 중 누구보다 뛰어나다"는 찬사를 받았다. 밀라노 음악원에서 카를로 론티에게 사사했으며, 이후 아르투로 베네데티 미켈란젤리에게도 배웠다.

베토벤, 쇼팽, 슈베르트, 브람스 등 고전-낭만파 레퍼토리뿐만 아니라 쇤베르크, 베베른, 부조니, 놀로, 스톡하우젠 등 현대음악 해석에서도 최고의 권위자로 인정받았다. 도이치 그라모폰과 60년 이상 전속 계약을 유지하며 100장이 넘는 음반을 발매했다.

베를린 필하모닉, 빈 필하모닉 등과 수없이 협연했으며, 특히 클라우디오 아바도와의 협업이 유명하다. 완벽주의적 접근과 지적인 해석으로 20세기 후반 최고의 피아니스트 중 한 명으로 평가받았다.';

UPDATE artists SET bio = '바이바 스크리데(Baiba Skride)는 1981년 라트비아 출생의 바이올리니스트이다.

2001년 퀸 엘리자베스 콩쿠르 우승을 통해 국제적인 경력을 쌓기 시작했다. 고전 레퍼토리부터 20세기 레퍼토리까지 폭넓은 음악적 스펙트럼을 소화한다.

그녀의 언니 린다와 여동생 라우마 역시 유명한 연주자이다.', bio_en = 'Baiba Skride is a violinist born in Latvia in 1981.

Skride began an international career through winning the Queen Elisabeth Competition in 2001, and plays a wide musical spectrum from the classical repertoire to 20th-century repertoire.

Her elder sister Linda and younger sister Lauma are also well-known performers.'
WHERE id = 272 AND bio = '바이바 스크리데(Baiba Skride)는 1981년 라트비아 출생의 바이올리니스트이다.

2001년 퀸 엘리자베스 콩쿠르 2위 입상을 통해 국제적인 경력을 쌓기 시작했다. 고전 레퍼토리부터 20세기 레퍼토리까지 폭넓은 음악적 스펙트럼을 소화한다.

그녀의 두 여동생인 라우마와 라우나 역시 유명한 연주자이다.';

UPDATE artists SET bio = '알반 게르하르트(Alban Gerhardt)는 1969년 독일 출생의 첼리스트이다.

1993년 레너드 로즈 국제 첼로 콩쿠르 우승을 차지하며 주목받았다. 현대 음악에 대한 깊은 이해를 바탕으로 다양한 작품을 연주하며, 사회 참여적인 활동에도 적극적이다.', bio_en = 'Alban Gerhardt is a cellist born in Germany in 1969.

Gerhardt drew attention by winning the Leonard Rose International Cello Competition in 1993. On the basis of a deep understanding of contemporary music, Gerhardt plays a wide variety of works and is also active in socially engaged activities.'
WHERE id = 278 AND bio = '알반 게르하르트(Alban Gerhardt)는 1969년 독일 출생의 첼리스트이다.

1993년 레벤탈 콩쿠르(Lievenskonskors) 우승을 차지하며 주목받았다. 현대 음악에 대한 깊은 이해를 바탕으로 다양한 작품을 연주하며, 사회 참여적인 활동에도 적극적이다.';

UPDATE artists SET bio = '마이클 파비아노(Michael Fabiano)는 1984년 미국 출생의 테너이다.

메트로폴리탄 오페라 내셔널 카운슬 오디션 우승 등 주요 콩쿠르에서 수상하며 주목받았다. 강렬한 에너지와 뛰어난 가창력으로 이탈리아 오페라의 주역으로 활약하고 있다.', bio_en = 'Michael Fabiano is a tenor born in the United States in 1984.

Fabiano drew attention by winning prizes at major competitions, including the Metropolitan Opera National Council Auditions. With intense energy and outstanding vocal ability, Fabiano sings leading roles in Italian opera.'
WHERE id = 303 AND bio = '마이클 파비아노(Michael Fabiano)는 1984년 미국 출생의 테너이다.

도밍고 국제 성악 콩쿠르 우승 등 주요 콩쿠르에서 수상하며 주목받았다. 강렬한 에너지와 뛰어난 가창력으로 이탈리아 오페라의 주역으로 활약하고 있다.';

UPDATE composers SET bio = '윤이상의 뒤를 잇는 한국 1세대 현대음악 작곡가. 1966년 한국 최초의 전자 음악 <원색의 향연>을 발표했다. 서울대 교수로 재직하며 수많은 제자를 양성했다.', bio_en = 'A first-generation Korean contemporary composer who followed Isang Yun. In 1966 he presented Korea''s first electronic music, Feast of Primary Colors (Wonsaek-ui Hyangyeon). He taught at Seoul National University and trained many pupils.'
WHERE id = 113 AND bio = '윤이상의 뒤를 잇는 한국 1세대 현대음악 작곡가. 한국인 최초로 다름슈타트 현대음악제에 참가했으며, 1966년 한국 최초의 전자 음악 <원색의 향연>을 발표했다. 서울대 교수로 재직하며 수많은 제자를 양성했다.';

UPDATE composers SET bio = '세계적으로 가장 널리 알려진 한국인 작곡가. 독일에서 활동하며 서양의 아방가르드 기법(12음)과 동양의 사상(도교, 음양) 및 국악 기법(농현, 시김새)을 독창적으로 결합시켰다. 1967년 ''동백림 사건''으로 고초를 겪었다.', bio_en = 'The most widely known Korean composer in the world. Based in Germany, he combined Western avant-garde techniques (twelve-tone) with Eastern thought (Taoism, yin-yang) and Korean traditional music techniques (nonghyeon, or vibrato, and sigimsae, or ornamentation) in an original way. He suffered ordeals in 1967 in the "East Berlin Affair".'
WHERE id = 90 AND bio = '세계적으로 가장 널리 알려진 한국인 작곡가. 독일 다름슈타트에서 활동하며 서양의 아방가르드 기법(12음)과 동양의 사상(도교, 음양) 및 국악 기법(농현, 시김새)을 독창적으로 결합시켰다. 1967년 ''동백림 사건''으로 고초를 겪었다.';

UPDATE composers SET influence = '서양 음악계에 동양의 철학과 사운드를 독창적으로 제시하여 ''동양과 서양의 중재자''로 높은 평가를 받았다. 그는 20세기 서양 음악사에 뚜렷한 족적을 남긴 대표적인 동아시아 작곡가이다.', influence_en = 'By presenting Eastern philosophy and sound in an original way to the Western musical world, he was highly regarded as a "mediator between East and West". He is a leading East Asian composer who left a distinct mark on 20th-century Western music history.'
WHERE id = 90 AND influence = '서양 음악계에 동양의 철학과 사운드를 독창적으로 제시하여 ''동양과 서양의 중재자''로 높은 평가를 받았다. 그는 20세기 서양 음악사에 뚜렷한 족적을 남긴 유일한 동아시아 작곡가이다.';

UPDATE composers SET bio = '독일의 작곡가. 슈만에 의해 ''베토벤의 후계자''로 지목받았으며, 바그너-리스트의 ''신독일악파''에 맞서 베토벤의 전통을 계승하는 거장이 되었다. 완벽주의자로, 20년 이상 공들여 교향곡 1번을 완성했다. 낭만주의 시대에 고전적 형식미의 정수를 보여주었다.', bio_en = 'German composer. Named by Schumann as "Beethoven''s heir", he stood against the Wagner-Liszt "New German School" to become a master carrying on the Beethoven tradition. A perfectionist, he took more than twenty years to complete his First Symphony. In the Romantic era he showed the essence of Classical formal beauty.'
WHERE id = 33 AND bio = '독일의 작곡가. 슈만에 의해 ''베토벤의 후계자''로 지목받았으며, 바그너-리스트의 ''신독일악파''에 맞서 베토벤의 전통을 계승하는 ''신고전주의''의 거장이 되었다. 완벽주의자로, 20년 이상 공들여 교향곡 1번을 완성했다. 낭만주의 시대에 고전적 형식미의 정수를 보여주었다.';

UPDATE composers SET style = '절대 음악, 교향곡 4곡, 독일 레퀴엠, 대위법과 고전적 형식미의 부활, 낭만적 서정성, 교차 리듬(Cross-rhythm), 풍부하고 어두운 화성', style_en = 'absolute music, four symphonies, A German Requiem, revival of counterpoint and Classical formal beauty, Romantic lyricism, cross-rhythm, rich and dark harmony'
WHERE id = 33 AND style = '신고전주의, 절대 음악, 교향곡 4곡, 독일 레퀴엠, 대위법과 고전적 형식미의 부활, 낭만적 서정성, 교차 리듬(Cross-rhythm), 풍부하고 어두운 화성';

UPDATE composers SET style = REPLACE(style, '피아노 독주곡(녹턴, 발라드, 에튀드, 왈츠 등)', '피아노 독주곡(녹턴, 발라드, 연습곡, 왈츠 등)')
WHERE id = 28 AND style LIKE '%피아노 독주곡(녹턴, 발라드, 에튀드, 왈츠 등)%';

UPDATE piece_parts SET name_ko = REPLACE(name_ko, '에튀드', '연습곡')
WHERE id = 21847 AND name_ko LIKE '%에튀드%';

UPDATE piece_parts SET name_ko = REPLACE(name_ko, '에튀드. Allegro', '연습곡. Allegro')
WHERE id = 23243 AND name_ko LIKE '%에튀드. Allegro%';
