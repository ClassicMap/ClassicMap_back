# 비발디 작품 목록 — 묶음·다악장·낱곡 정리 보고

데이터만 만들었습니다(DB·git·브라우저 안 씀). 결과는 `catalog.json`, 원자료와 중간 산출물은 `raw/`, 스크립트는 `scripts/` 입니다.

- 위키백과: `List of compositions by Antonio Vivaldi`(작품번호 표·RV 기악 표·종교음악·칸타타·세레나타 표) + `List of operas by Antonio Vivaldi`(오페라 악보 현존 여부), 경계선 오페라 개별 문서. 원문은 `raw/wiki/`, 표를 푼 것은 `raw/wiki_rows.json`.
- MusicBrainz: 비발디 artist(ad79836d…) work 4,450개를 browse(`inc=aliases+work-rels`, 100개씩 45번)로만 받았습니다. 낱개 조회는 하지 않았습니다. `raw/browse.json`.
- 순서: `scripts/wikiparse.py`(위키 표 풀기) → `defs.py`(넣을 것·뺄 것·이름 규칙) → `mbx.py`(RV 번호로 MB work 찾기) → `build.py`(catalog.json) → `check.py`(검사·위키 대조) → `report.py`.
- 리드 생성기 `gen/gen_catalog.py` 를 seed_pipeline 의 `uv run python` 으로 돌려 오류 없이 통과했습니다: `{"pieces": 588, "parts": 1647, "children": 359, "linked": 1, "updated_parts": 0, "existing_pieces": 7}` (출력 `gen_test.sql`).

## 1. 개수

| 갈래 | 작품 | part | children |
|---|---:|---:|---:|
| 묶음(collection) | 12 | 111 | 359 |
| 다악장(multi_movement) | 450 | 1536 | 0 |
| 낱곡(single) | 133 | 0 | 0 |
| 합계 | 595 | 1647 | 359 |

갈래별 작품 수: 바이올린 협주곡 162, 그 밖 협주곡(여러 독주 악기·류트·만돌린 등) 114, 현을 위한 협주곡 42, 칸타타 40, 바순 협주곡 37, 바이올린 소나타 32, 첼로 협주곡 24, 모테트(도입 모테트 포함) 19, 오페라 19, 시편 18, 트리오 소나타 15, 신포니아 14, 그 밖 교회음악 14, 오보에 협주곡 13, 플루트 협주곡 10, 첼로 소나타 9, 그 밖 소나타 9, 세레나타 3, 오라토리오 1.

MBID: 작품 571/595, part 1647/1647, children 359/359. 모든 작품 authenticity 는 authentic 입니다(위작·의심은 다 뺌).

다악장 갈래(협주곡·소나타·신포니아·교회음악)인데 **part 없이 낱곡으로 둔 것 70개** (리드 생성기가 part 없는 다악장을 막고, 악장 이름을 지어내지 않기 때문):

- 악장 제목 이름 없음·꼴 다름(42): RV 111, RV 115, RV 129, RV 142, RV 405, RV 429, RV 430, RV 783, RV 572, RV 446, RV 92, RV 392, RV 393, RV 172, RV 186, RV 197, RV 209, RV 218, RV 224, RV 231, RV 233, RV 287, RV 311, RV 313, RV 340, RV 343, RV 384, RV 576, RV 506, RV 527, RV 585, RV 131, RV 140, RV 192, RV 52, RV 2, RV 798, RV 19, RV 25, RV 26, RV 28, RV 29
- MB 에 work 없음(20): RV 426, RV 89, RV 102, RV 395a, RV 223, RV 263, RV 267a, RV 275a, RV 294, RV 768, RV 769, RV 563, RV 829, RV 37a, RV 779a, RV 828, RV 603, RV 607, RV 609, RV 827
- MB 악장 이름이 [Allegro]·'[Violin] Solo' 같은 편집 표기뿐(1): RV 820
- MB 에 악장(parts) 관계 없음(7): RV 598, RV 604, RV 606, RV 612, RV 613, RV 620, RV 640
- 묶음 안 곡 가운데 Op. 1 No. 12 <라 폴리아>(RV 63)는 MB 변주 20개 중 이름 없는 것이 있어 children 없이 두었습니다.

성악 대형곡(오페라 19·칸타타 40·세레나타 3·오라토리오 1)은 명세대로 part 없이 낱곡입니다.

## 2. 운영 기존 작품 대응

| id | 운영 제목 | 운영 opus | → key | 위치 | 근거 |
|---:|---|---|---|---|---|
| 29 | 조화의 영감 | Op. 3 | `vivaldi-op3` | 묶음 | 카탈로그(Op. 3), 리드 지시 |
| 30 | 글로리아 D장조 | RV 589 | `vivaldi-rv589` | 작품 | 카탈로그(RV 589) |
| 31 | 만돌린 협주곡 C장조 | RV 425 | `vivaldi-rv425` | 작품 | 카탈로그(RV 425) |
| 32 | 두 대의 트럼펫을 위한 협주곡 C장조 | RV 537 | `vivaldi-rv537` | 작품 | 카탈로그(RV 537) |
| 33 | 바이올린 협주곡 A단조 | Op. 3, No. 6 (RV 356) | `vivaldi-op3` | Op. 3 의 6번 part(existingPieceId) | 카탈로그(Op. 3, No. 6 = RV 356), 리드 지시 |
| 26038 | 칸타타 <그만, 이제 그만> | RV 684 | `vivaldi-rv684` | 작품 | MBID 8df04551-8a82-46a7-b699-94e93703fefb |
| 26039 | 현을 위한 협주곡 A장조 | RV 159 | `vivaldi-rv159` | 작품 | MBID d702634b-ec22-4245-90e0-619abbf31070 |
| 26040 | 바순 협주곡 E단조 | RV 484 | `vivaldi-rv484` | 작품 | MBID 0b502d5b-dde4-4efb-8a19-6390811f872c |
| 28 | 사계 | Op. 8, No. 1-4 (RV 269, 315, 293, 297) | — | 잇지 않음 | 여러 작품(Op. 8 1~4번)을 한데 묶은 운영 작품이라 명세대로 그대로 둠 |

- MBID 로 맞춘 것 3개(26038·26039·26040), 카탈로그 번호로 맞춘 것 5개(29·30·31·32 는 운영에 MBID 가 없어 RV·Op. 번호로, 33 은 Op. 3 No. 6 = RV 356). 29·30·31·32 는 운영에 MBID 가 없어 이번에 고른 MB work(운영 다른 작품이 쓰지 않음)를 생성기가 식별자로 더합니다. 33 은 part 의 linked_piece_id 로만 이어지고 식별자는 더하지 않습니다.
- 기존 작품 7개는 제목을 운영과 똑같이 두었습니다(「조화의 영감」 「글로리아 D장조」 「만돌린 협주곡 C장조」 「두 대의 트럼펫을 위한 협주곡 C장조」 「현을 위한 협주곡 A장조」 「바순 협주곡 E단조」 「칸타타 <그만, 이제 그만>」). 이 가운데 다섯(30·31·32·26039·26040)은 MB 악장을 part 로 붙였습니다.
- 33 「바이올린 협주곡 A단조」는 「조화의 영감」 6번 part 의 `existingPieceId` 로 이었습니다.
- 28 「사계」는 Op. 8 1~4번을 한데 묶은 운영 작품이라 그대로 두고 part 에 잇지 않았습니다. 「협주곡집 <화성과 창의의 시도>」 1~4번 part(봄·여름·가을·겨울)는 새로 들어가고, 28 은 MB 「Le quattro stagioni」(87886dcf…)를 계속 씁니다.
- 운영에 같은 작품이 둘인 경우는 없습니다. piece_parts 에 비발디 part 가 없어 `existingPartId` 는 모두 null 입니다.
- 「<X> 중 "아리아"」 꼴의 운영 대목 작품은 비발디에 없습니다.

## 3. 뺀 것과 까닭

위키백과 RV 번호 858개 가운데 696개를 넣고(작품번호 묶음 안 곡 포함) 164개를 뺐습니다(RV 449·454 는 Op. 8 9·12번의 오보에 판이라 묶음 part 의 catalogueAlt 에 같이 적고 따로 넣지 않아 양쪽에 셈).

| 까닭 | 개수 |
|---|---:|
| 미완성·불완전 | 42 |
| 소실 | 40 |
| 위작·위작 의심(Anh.) | 26 |
| 오페라: 악보 소실 | 17 |
| 오페라: 일부만 남음·파스티치오 | 13 |
| 같은 곡의 다른 판(a 번호 등, 기본 번호만 넣음) | 8 |
| 작품번호 묶음 안 위작(Op. 7 1·7·9번) | 3 |
| 단편 | 3 |
| 진위 의심 | 3 |
| 편곡·남의 판 | 3 |
| 오페라 아리아에 새 가사를 붙인 종교곡(같은 곡의 다른 판) | 3 |
| 작품번호 곡의 오보에 판(묶음 part 에 함께 적음) | 2 |
| 카탈로그 부록(Anh.)·파스티치오 | 2 |
| 같은 곡의 옛 판 | 1 |

- **미완성·불완전**: RV 786 Concerto (Strings) D major; RV 468 Concerto (Bassoon, strings) C major; RV 482 Concerto (Bassoon, strings) D minor; RV 787 Concerto (Cello, strings) E minor; RV 788 Concerto (Cello, strings) B♭ major; RV 431 Concerto (Flute, strings) E minor; RV 432 Concerto (Flute, strings) E minor; RV 459 Concerto (Oboe, strings) G minor; RV 203 Concerto (Violin, strings) D major; RV 213a Concerto (Violin, strings) D major; RV 270a Concerto (Violin, strings) E major; RV 794 Concerto (Violin, strings) F major; RV 320 Concerto (Violin, strings) G minor; RV 322 Concerto (Violin, strings) G minor; RV 792 Concerto (Violin, strings) A major; RV 360 Concerto (Violin, strings) B♭ major; RV 372a Concerto (Violin, strings) B♭ major; RV 378 Concerto (Violin, strings) B♭ major; RV 771 Concerto (Violin, strings) C minor; RV 772 Concerto (Violin, strings) D major; RV 773 Concerto (Violin, strings) F major; RV 818 Concerto (Violin, strings) D major; RV 793 Concerto (Violin, double string orchestra) C major; RV 814 Concerto (Violin, cello, strings) G major; RV 774 Concerto (Violin, organ, strings) C major; RV 775 Concerto (Violin, organ, strings) F major; RV 520 Concerto (2 violins, strings) A major; RV 526 Concerto (2 violins, strings) B♭ major; RV 584 Concerto (2 violins, 2 organs, double string orchestra) F major; RV 125 Sinfonia (Strings) D major; RV 192a Sinfonia (Violin, strings) C major; RV 4 Sonata (Violin) C major; RV 7a Sonata (Violin) C minor; RV 11 Sonata (Violin) D major; RV 17 Sonata (Violin) E minor; RV 791 Sonata (Violin) B♭ major; RV 37 Sonata (Violin) B minor; RV 615 Regina coeli; RV 624 Carae rosae respirate; RV 628 Invicti bellate; RV 643 Oratorio Moyses Deus Pharaonis; RV 789 Confitebor tibi, domine
- **소실**: RV 750 Concerto (Flute, strings) ?; RV 784 Concerto (Flute, strings) G major; RV 805 Concerto (Flute, strings) G major; RV 821 Concerto (Flute, strings) ?; RV 822 Concerto (Flute, strings) ?; RV 823 Concerto (Flute, strings) ?; RV 824 Concerto (Flute, strings) ?; RV 825 Concerto (Flute, strings) ?; RV 826 Concerto (Flute, strings) ?; RV 751 Concerto (2 flutes, 2 violins, 2 bassoons, strings) D major; RV 573 Concerto (2 oboes, 2 horns, 2 bassoons, strings) F major; RV 174 Concerto (Violin, strings) C major; RV 193 Concerto (Violin, strings) C major; RV 200 Concerto (Violin, strings) C minor; RV 255 Concerto (Violin, strings) E♭ major; RV 290 Concerto (Violin, strings) F major; RV 304 Concerto (Violin, strings) G major; RV 305 Concerto (Violin, strings) G major; RV 309 Concerto (Violin, strings) G major; RV 316 Concerto (Violin, strings) G minor; RV 337 Concerto (Violin, strings) A major; RV 351 Concerto (Violin, strings) A major; RV 743 Concerto (Violin, strings) F minor; RV 752 Concerto (Violin, strings) D major; RV 741 Sinfonia (unknown) C major; RV 38 Sonata (Cello) D minor; RV 590 Gloria; RV 599 Beatus vir; RV 619 Salve Regina; RV 622 Te Deum; RV 645 Oratorio L'adorazione delli tre re magi al bambino Gesu; RV 748 Aria per la communione; RV 782 Oratorio La vittoria navale predetta dal S Pontefice Pio V Ghisilieri; RV 797 Magnificat; RV 804 Salve Regina; RV 688 Le gare del dovere; RV 689 Le gare della giustitia e della pace; RV 691 Il Mopso; RV 692 Queste Eurilla gentil; RV 694 L'unione della pace et di marte
- **위작·위작 의심(Anh.)**: RV 144 Concerto (Strings) G major; RV 404 Concerto (Cello, strings) D major; RV 415 Concerto (Cello, strings) G major; RV 458 Concerto (Oboe, strings) F major; RV 272 Concerto (Violin, strings) E minor; RV 338 Concerto (Violin, strings) A major; RV 385 Concerto (Violin, strings) B minor; RV 116 Sinfonia (Strings) C major; RV 132 Sinfonia (Strings) E major; RV 148 Sinfonia (Strings) G major; RV 809 Sonata (Flute) C major; RV 49 Sonata (Flute) D minor; RV 50 Sonata (Flute) E minor; RV 54 Sonata (Musette (or vielle à roue or recorder or flute or oboe or violin)) C major; RV 55 Sonata (Musette (or vielle à roue or recorder or flute or oboe or violin)) C major; RV 56 Sonata (Musette (or vielle à roue or recorder or flute or oboe or violin)) C major; RV 57 Sonata (Musette (or vielle à roue or recorder or flute or oboe or violin)) G major; RV 58 Sonata (Musette (or vielle à roue or recorder or flute or oboe or violin)) G minor; RV 59 Sonata (Musette (or vielle à roue or recorder or flute or oboe or violin)) A major; RV 785 Sonata (Violin) D major; RV 13 Sonata (Violin) D minor; RV 24 Sonata (Violin) G major; RV 776 Sonata (Violin) G major; RV 80 Trio sonata (2 recorders) G major; RV 586 Missa Sacrum; RV 605 Credidi propter quod
- **오페라: 악보 소실**: RV 724 Nerone fatto Cesare; RV 720 Gl’inganni per vendetta; RV 715 Filippo re di Macedonia; RV 721 L’inganno trionfante in amore; RV 707 Cunegonda; RV 712 La fede tradita e vendicata; RV 722 Ipermestra; RV 735 Siroe, re di Persia; RV 730 Rosilena ed Oronta; RV 696 Alvilda regina de' Goti; RV 733 Semiramide; RV 695 L’Adelaide; RV 698 Aristide; RV 716 Ginevra principessa di Scozia; RV 726 L'oracolo in Messenia; RV 777 Il giorno felice; RV 713 Feraspe
- **오페라: 일부만 남음·파스티치오**: RV 819 Orlando furioso — 3막이 없고 남은 아리아 7곡도 베이스 성부만 남음(리스토리 작품을 고쳐 쓴 것); RV 706 La costanza trionfante degl'amori e de gl'odii — 아리아 일부만 남음; RV 737 Tieteberga — 아리아 일부만 남음; RV 701 Artabano, re dei Parti — 아리아 1곡만 남음; RV 732 Scanderbeg — 단편만 남음; RV 778 Tito Manlio — 파스티치오, 비발디 몫은 3막뿐; RV 704 La Candace, o siano Li veri amici — 아리아 일부만 남음; RV 734 La Silvia — 아리아 9곡만 남음; RV 710 Ercole su'l Termodonte — 아리아 30곡·2중창 2곡만 남아 나머지는 현대 복원; RV 740 La virtù trionfante dell’amore, e dell’odio, overo Il Tigrane — 파스티치오, 비발디 몫은 2막뿐; RV 697 Argippo — 아리아 일부만 남아 현대 복원(파스티치오); RV 708 Doriclea — 일부만 남음; RV 731 Rosmira (Rosmira fedele) — 다른 작곡가 음악을 엮은 파스티치오
- **같은 곡의 다른 판(a 번호 등, 기본 번호만 넣음)**: RV 179a Concerto (Violin, strings) C major; RV 224a Concerto (Violin, strings) D major; RV 364a Concerto (Violin, strings) B♭ major; RV 562a Concerto (Violin, 2 oboes, 2 horns, timpani, strings) D major; RV 111a Sinfonia (Strings) C major; RV 602a Laudate pueri Dominum; RV 639a Introduzione al Gloria (RV 588) "Jubilate o amoeni chori"; RV 684a Cessate, omai cessate
- **작품번호 묶음 안 위작(Op. 7 1·7·9번)**: Op. 7 No. 1 (RV 465) Concerto B♭ major; Op. 7 No. 7 (RV 464) Concerto B♭ major; Op. 7 No. 9 (RV 373) Concerto B♭ major
- **단편**: RV 742 Concerto (Violin, strings) D major; RV 744 Concerto (Violin, strings) A major; RV 745 Concerto (Violin, strings) B♭ major
- **진위 의심**: RV 542 Concerto (Violin, organ, strings) F major; RV 592 Credo; RV 614 Laudate Dominum
- **편곡·남의 판**: RV 518 Concerto (2 violins, strings) A major; RV 564a Concerto (2 violins, 2 oboes, bassoon, strings) D major; RV 746 Organ solo
- **오페라 아리아에 새 가사를 붙인 종교곡(같은 곡의 다른 판)**: RV 646 Ad corda reclina; RV 647 Eja voces plausum date; RV 648 Ihr Himmel nun
- **작품번호 곡의 오보에 판(묶음 part 에 함께 적음)**: RV 449 Concerto (Oboe, strings) C major; RV 454 Concerto (Oboe, strings) D minor
- **카탈로그 부록(Anh.)·파스티치오**: RV Anh 58 Il vinto trionfante del vincitore; RV Anh 55 La tirannia castigata
- **같은 곡의 옛 판**: RV 578a Concerto (2 violins, cello, strings) G minor

- 가짜 Op. 13 <Il pastor fido>(RV 54–59, 셰드빌 작품)는 위작으로 뺐습니다(위 표의 위작 칸에 포함).

## 4. 애매했던 판단

1. **제목 끝 RV**: 번호 없는 같은 갈래·같은 조성이 너무 많아(바이올린 협주곡 D장조만 20곡 넘음) 하이든 디베르티멘토처럼 **한 갈래 안에서 하나라도 겹치면 그 갈래 전체** 제목 끝에 RV 를 붙였습니다(`바이올린 협주곡 D장조 "그로소 모굴" RV 208`, titleEn `…, RV 208`). 겹침이 없는 갈래(류트 협주곡, 바이올린과 첼로를 위한 협주곡, 플루트 소나타 등)는 붙이지 않았습니다. 이름 붙은 성악곡은 겹친 것만 붙였습니다(칸타타 <Amor, hai vinto> RV 651·683, 모테트 <Longe mala, umbrae, terrores> RV 629·640). 생성기는 이 제목들을 catalogue_system `RV`·catalogue_number 로 넣습니다. 운영 기존 작품(RV 159·425·484·537·589)은 제목에 RV 가 없어 같은 갈래 새 작품과 모양이 다릅니다(예: 운영 「바순 협주곡 E단조」 옆에 새 「바순 협주곡 C장조 RV 466」).
2. **Op. 7 은 진작 9곡만, seq 를 출판 번호로**: 위키백과가 1·7·9번(RV 465·464·373)을 위작(Anh.)으로 적어 뺐고, 남은 곡의 seq 를 2·3·4·5·6·8·10·11·12 로 두었습니다(출판 번호와 맞추려고). 하이든 Op. 2 처럼 1부터 이어 붙이려면 seq 만 고치면 됩니다. 12곡을 다 넣고 싶으면 위작 3곡은 MB work(220ac06a·32fc0ef7·a0ac55e0)가 있어 바로 넣을 수 있습니다.
3. **작품번호 묶음 이름**: 운영 29 가 「조화의 영감」(꺾쇠·갈래 없음)이지만, 새 고유 제목 묶음은 명세의 `연가곡집 <시인의 사랑>` 꼴을 따라 「협주곡집 <라 스트라바간차>」(Op. 4) 「협주곡집 <화성과 창의의 시도>」(Op. 8) 「협주곡집 <라 체트라>」(Op. 9)로 했습니다. 고유 제목 없는 묶음은 「트리오 소나타 Op. 1」 「바이올린 소나타 Op. 2」 「소나타 Op. 5」(바이올린 소나타 4 + 트리오 소나타 2) 「바이올린 협주곡 Op. 6」 「협주곡 Op. 7」 「플루트 협주곡 Op. 10」 「협주곡 Op. 11」 「협주곡 Op. 12」 입니다. part 이름은 곡 자체가 큰 작품이라 갈래 포함(`바이올린 협주곡 E장조 "봄"`, `네 대의 바이올린을 위한 협주곡 D장조`), 번호는 seq 로만 붙고 nameEn 은 `No. 1: Violin Concerto in E major "La primavera", RV 269`.
4. **같은 곡의 다른 판**: (1) 작품번호 판과 필사본 판이 따로 RV 를 받은 것(Op. 4-1 RV 383a / RV 383, Op. 7-5 285a / 285, Op. 7-10 294a / 294, Op. 7-11 208a / 208 "그로소 모굴", Op. 9-1 181a / 181, Op. 9-4 263a / 263, Op. 9-11 198a / 198)은 위키 표가 따로 적고 따로 연주·녹음돼 **둘 다 넣었습니다**(a 판은 묶음 part, 기본 판은 낱개 작품). (2) Op. 8 9·12번의 오보에 판 RV 454·449 는 묶음 part 의 catalogueAlt `RV 236/454`·`RV 178/449` 로 같이 적고 따로 넣지 않았습니다. (3) 악장 하나만 다른 a 판(RV 179a·224a·364a·111a·562a)과 위키 비고 없는 변형(RV 602a·639a·684a)은 기본 번호만 넣었습니다. RV 562/562a 는 비고가 562 쪽에 붙어 있지만 기본 번호를 남겼습니다. (4) 「Original version of RV 578」(578a)은 옛 판이라 뺐습니다. (5) <바다의 폭풍>(RV 98·433·570), <밤>(RV 104·439), <홍방울새>(RV 90·428)처럼 같은 소재를 다른 편성으로 쓴 것은 별개 RV 라 모두 넣었습니다.
5. **마니피캇**: 위키 표가 한 줄(`610 · 611`)이지만 RV 610(G단조, 가장 많이 연주)과 RV 611(새 독창 아리아로 바꾼 뒤 판)을 각각 넣었습니다(MB 도 따로). RV 610a·610b(이중 합창판)는 위키 표에 번호가 없어 다루지 않았습니다. '마지막 판만' 규칙을 엄격히 하면 611 하나만 남깁니다.
6. **오페라 19편**: 위키 오페라 목록에서 악보가 다 남았거나 한 막 정도만 빠지고 무대·녹음이 굳은 것만 넣었습니다. 넣은 것 중 악보 일부가 빠진 것: <Armida al campo d'Egitto>(2막 소실, 복원판 녹음), <Catone in Utica>(1막 소실), <Motezuma>(일부 소실, 복원 녹음). <Bajazet>·<Dorilla in Tempe>는 파스티치오지만 비발디 몫이 대부분이라 넣었고, 남의 음악 위주인 <Rosmira fedele>는 뺐습니다. 아리아만 남아 현대 복원한 <Ercole su'l Termodonte>(RV 710)·<Argippo>(RV 697), 3막이 없는 <Orlando furioso> 1714년판(RV 819)은 뺐습니다(녹음은 있음). 제목은 하이든처럼 원제 꺾쇠(`오페라 <Bajazet>`), year 는 초연 해입니다.
7. **교회음악 이름**: 모차르트 「딕시트 도미누스와 마니피캇」 선례대로 널리 쓰는 라틴 제목은 소리대로(키리에·글로리아·크레도·딕시트 도미누스·베아투스 비르·라우다테 푸에리·라우다테 도미눔·라에타투스 숨·니시 도미누스·라우다 예루살렘·인 엑시투 이스라엘·콘피테보르 티비 도미네·마니피캇·살베 레지나·스타바트 마테르) 적고, 찬가·응답송·모테트는 하이든처럼 갈래 + 원제 꺾쇠(`찬가 <Deus tuorum militum>`, `모테트 <In furore iustissimae irae>`)로 했습니다. 위키 표에 조성이 없어 교회음악 제목에는 조성을 넣지 않았습니다(운영 「글로리아 D장조」만 조성 있음). 도입 모테트(Introduzione, RV 635–642)도 `모테트 <…>` 로 두고 titleEn 에 `Introduzione al Dixit "Ascende laeta"` 처럼 적었습니다. RV 637 은 위키 비고가 '뒤따를 글로리아가 소실'이라는 뜻이라 모테트 자체는 넣었습니다.
8. **성악곡 제목 원문**: 위키 칸타타·모테트 표가 첫머리를 줄이거나 틀리게 적은 것이 많아("Lundi dal vago" → Lungi dal vago volto, "Alla caccia, alla caccia" → Alla caccia dell'alme e de' cori 등) MB 제목의 가사 첫머리를 썼고, MB 쪽이 잘린 6곡(RV 636·651·666·671·678·683)만 손으로 고쳤습니다. 목록은 6절.
9. **편성 갈래 이름**: 위키 표의 편성 칸을 그대로 옮겼습니다. 독주 하나면 `오보에 협주곡`, 둘·셋이면 `바이올린과 오르간을 위한 협주곡`·`플루트, 바이올린, 바순을 위한 협주곡`, 독주 악기가 네 종류 이상이면 `여러 악기를 위한 협주곡`(RV 88·90·94·95·97·98 같은 실내 협주곡 일부와 RV 555–585 의 대편성 협주곡). 현만이면 운영 26039 를 따라 `현을 위한 협주곡`. 위키가 Op. 3 1·4번을 '4 violins'로 적어(MB 는 '4 violins, cello') 위키대로 `네 대의 바이올린을 위한 협주곡` 입니다. RV 443–445 는 위키가 Flautino 라 `플라우티노 협주곡` 으로 했는데 국내에서는 '피콜로 협주곡'으로 많이 부릅니다.
10. **악장 정리**: MB 대체 악장(RV 438 `I-b`, RV 395 `II-b`, RV 633 `IIIa`)은 뺐고, RV 807 의 번호 없는 끝 악장 'Amen (chorus)'에는 XII 를 매겼습니다. RV 820 은 위키가 바이올린 소나타인데 MB 악장 이름이 `[Allegro]`·`[Violin] Solo` 같은 편집 표기뿐이라 낱곡으로 내렸습니다. RV 275a 는 MB 의 유일한 work 가 RV 275 를 플루트로 편곡한 것이라 쓰지 않아 MBID 가 없습니다.
11. **MB 「6 Cello Sonatas, op. 14」**: MB 에는 첼로 소나타 RV 47·41·43·45·40·46 을 묶은 Op. 14 work 가 있지만 위키 작품번호 표(Op. 1–12)에 없어 묶음으로 만들지 않고 RV 별 다악장으로 넣었습니다. MB 의 Op. 10 'Venetian version' 묶음도 쓰지 않았습니다.

## 5. 직접 옮긴 우리말 이름 (검수용)

- 묶음 제목: 협주곡집 <라 스트라바간차>(La stravaganza), 협주곡집 <화성과 창의의 시도>(Il cimento dell'armonia e dell'inventione), 협주곡집 <라 체트라>(La cetra).
- 별명(우리말이 굳은 것은 옮기고 나머지는 소리대로): "라 폴리아"(La follia; RV 63), "라 파스토렐라"(La pastorella; RV 95), "마드리갈레스코"(Madrigalesco; RV 129), "알라 루스티카"(Alla rustica; RV 151), "콘카"(Conca; RV 163), "알 산토 세폴크로"(Al Santo Sepolcro; RV 130·169), "즐거움"(Il piacere; RV 180), "일 소스페토"(Il sospetto; RV 199), "그로소 모굴"(Grosso Mogul; RV 208), "린퀴에투디네"(L'inquietudine; RV 234), "바다의 폭풍"(La tempesta di mare; RV 98·253·433·570), "일 리티로"(Il ritiro; RV 256·294), "봄"(La primavera; RV 269), "일 리포소"(Il riposo – Per il Santissimo Natale; RV 270), "라모로소"(L'amoroso; RV 271), "일 파보리토"(Il favorito; RV 277), "가을"(L'autunno; RV 293), "겨울"(L'inverno; RV 297), "여름"(L'estate; RV 315), "뻐꾸기"(Il cucù; RV 335), "나이팅게일"(Il rosignuolo; RV 335a), "사냥"(La caccia; RV 362), "일 코르네토 다 포스타"(Il cornetto da posta; RV 363), "일 카르보넬리"(Il Carbonelli; RV 366), "홍방울새"(Il gardellino; RV 90·428), "일 그란 모골"(Il Gran Mogol; RV 431a), "밤"(La notte; RV 104·439·501), "일 프로테오"(Il Proteo o sia il mondo al rovescio; RV 544), "일 프로테오"(Il Proteo, o il mondo al rovescio; RV 572), "콘체르토 푸네브레"(Concerto funebre; RV 579), "아마토 베네"(Amato bene; RV 761), "로타비나"(L'ottavina; RV 763), "임프로비사타"(Improvvisata; RV 802)
- 별명을 붙이지 않은 비고: Ripieno, Originale, Concerto di Parigi, per Anna Maria·per Signora Chiara 같은 헌정, Per la solennità di S. Lorenzo, Fatto per la solennità della S. Lingua di S. Antonio, Manchester Sonata No. N, Dresden concerto, Brno Concerto, Bergamo, di Lund, del Signore Hendel, in due cori, per eco in lontano, con molti istromenti, Tutti gli istrumenti sordini(출처·헌정·편성 설명이라 별명으로 보지 않음).
- 교회음악 소리 적기: 글로리아(Gloria), 니시 도미누스(Nisi Dominus), 딕시트 도미누스(Dixit Dominus), 라에타투스 숨(Laetatus sum), 라우다 예루살렘(Lauda Jerusalem), 라우다테 도미눔(Laudate Dominum), 라우다테 푸에리(Laudate pueri Dominum), 마니피캇(Magnificat), 베아투스 비르(Beatus vir), 살베 레지나(Salve Regina), 스타바트 마테르(Stabat Mater), 인 엑시투 이스라엘(In exitu Israel), 콘피테보르 티비 도미네(Confitebor tibi, Domine), 크레도(Credo), 키리에(Kyrie)
- 교회음악 갈래어: 찬가(Hymn), 응답송(Responsory), 모테트(Motet), 오라토리오(Oratorio), 세레나타(Serenata).
- 편성 갈래 이름: 네 대의 바이올린을 위한 협주곡, 두 대의 만돌린을 위한 협주곡, 두 대의 바이올린, 두 대의 오보에, 바순을 위한 협주곡, 두 대의 바이올린과 두 대의 첼로를 위한 협주곡, 두 대의 바이올린과 비올라를 위한 소나타, 두 대의 바이올린과 오보에를 위한 소나타, 두 대의 바이올린을 위한 협주곡, 두 대의 오보에를 위한 트리오 소나타, 두 대의 오보에를 위한 협주곡, 두 대의 오보에와 바순을 위한 소나타, 두 대의 첼로를 위한 협주곡, 두 대의 클라리넷과 두 대의 오보에를 위한 협주곡, 두 대의 트럼펫을 위한 협주곡, 두 대의 플루트를 위한 트리오 소나타, 두 대의 플루트를 위한 협주곡, 두 대의 호른을 위한 협주곡, 류트 협주곡, 리코더 소나타, 리코더 협주곡, 리코더, 바이올린, 바순을 위한 협주곡, 리코더, 오보에, 두 대의 바이올린을 위한 협주곡, 리코더, 오보에, 바순을 위한 협주곡, 리코더와 두 대의 바이올린을 위한 협주곡, 리코더와 바순을 위한 트리오 소나타, 만돌린 협주곡, 바순 협주곡, 바이올린 소나타, 바이올린 협주곡, 바이올린, 두 대의 오보에, 두 대의 호른을 위한 협주곡, 바이올린, 오르간, 오보에를 위한 협주곡, 바이올린, 오보에, 오르간을 위한 소나타, 바이올린과 두 대의 오보에를 위한 협주곡, 바이올린과 두 대의 첼로를 위한 협주곡, 바이올린과 두 현악 합주를 위한 협주곡, 바이올린과 류트를 위한 트리오 소나타, 바이올린과 메아리 바이올린을 위한 협주곡, 바이올린과 오르간을 위한 협주곡, 바이올린과 오보에를 위한 협주곡, 바이올린과 첼로를 위한 트리오 소나타, 바이올린과 첼로를 위한 협주곡, 비올라 다모레 협주곡, 비올라 다모레와 류트를 위한 협주곡, 세 대의 바이올린을 위한 협주곡, 신포니아, 여러 악기를 위한 협주곡, 오보에 소나타, 오보에 협주곡, 오보에와 바순을 위한 협주곡, 오보에와 첼로를 위한 협주곡, 첼로 소나타, 첼로 협주곡, 첼로와 바순을 위한 협주곡, 트롬바 마리나 바이올린 협주곡, 트리오 소나타, 플라우티노 협주곡, 플루트 소나타, 플루트 협주곡, 플루트, 두 대의 바이올린, 바순을 위한 협주곡, 플루트, 바이올린, 바순을 위한 협주곡, 플루트와 두 대의 바이올린을 위한 협주곡, 플루트와 바이올린을 위한 트리오 소나타, 하프시코드 협주곡, 현을 위한 협주곡. 악기: 비올라 다모레(viola d'amore), 플라우티노(flautino), 샬뤼모(chalumeau), 테오르보(theorbo), 트롬바 마리나 바이올린(violin in tromba marina), 두 현악 합주(double string orchestra), 메아리 바이올린(per eco in lontano).
- 악장 갈래어(첫 낱말만 옮기고 빠르기말은 원어): 가보트(gavota/gavotta/gavotte), 레치타티보(recitative/recitativo), 미뉴에트(menuet/menuetto/minuet/minuetto), 사라방드(sarabanda/sarabande), 샤콘(ciaccona), 서주(introduzione), 시칠리아나(siciliana), 시칠리아노(siciliano), 신포니아(sinfonia), 아리아(aria), 알르망드(allemanda/allemande), 전주곡(prelude/preludio), 지그(giga/gigue), 카프리치오(capriccio), 쿠랑트(corrente/courante), 파스토랄레(pastorale), 푸가(fuga), 피날레(finale), 합창(coro), 환상곡(fantasia). 'Preludio a Capriccio'·'Aria di Giga' 처럼 뒤에 전치사가 붙은 것은 옮기지 않았습니다. 성악 악장(가사 첫머리)은 원어 그대로입니다.

## 6. 위키백과 대조 결과

- 검사: 제목 겹침 0(새 작품끼리·운영 제목과), nameKo 빈 것 0, `1번 `·`1악장 ` 으로 시작하는 것 0, 다른 작품이 쓰는 MBID 0, 한 MBID 두 번 0, 다악장 악장 seq 빈칸 0. 오류 0개.
- 작품번호 묶음(위키 RV 목록 ↔ catalog part, 곡 수·RV·조성):
  - Op. 1: 위키 12곡, catalog 12곡, 다른 곳 없음
  - Op. 2: 위키 12곡, catalog 12곡, 다른 곳 없음
  - Op. 3: 위키 12곡, catalog 12곡, 다른 곳 없음
  - Op. 4: 위키 12곡, catalog 12곡, 다른 곳 없음
  - Op. 5: 위키 6곡, catalog 6곡, 다른 곳 없음
  - Op. 6: 위키 6곡, catalog 6곡, 다른 곳 없음
  - Op. 7: 위키 12곡, catalog 9곡 — No. 1 없음(RV 465), No. 7 없음(RV 464), No. 9 없음(RV 373)(위작이라 뺌)
  - Op. 8: 위키 12곡, catalog 12곡, 다른 곳 없음
  - Op. 9: 위키 12곡, catalog 12곡, 다른 곳 없음
  - Op. 10: 위키 6곡, catalog 6곡, 다른 곳 없음
  - Op. 11: 위키 6곡, catalog 6곡, 다른 곳 없음
  - Op. 12: 위키 6곡, catalog 6곡, 다른 곳 없음
- MB 묶음 work 의 parts 관계(곡 수·순서·RV)는 Op. 1–12 모두 위키와 같았습니다.
- RV 빠짐: 위키 표의 RV 858개가 모두 '넣음' 또는 '뺌' 중 하나에 들어갔습니다(빠진 번호 0, 위키에 없는 번호 0). 기악 낱개 작품 제목 조성은 위키 조성과 모두 같습니다.
- MB 와 위키가 다른 곳(위키를 따름): Op. 3 1·4번 편성(MB 는 첼로 포함), RV 162(위키 신포니아 B♭장조, MB 'Concerto per archi in si maggiore'), RV 820(위키 바이올린 소나타, MB 바이올린·첼로 소나타), RV 275a(위키 바이올린 협주곡, MB 는 플루트 편곡뿐), RV 429·442(MB 제목에 잘못 붙은 'op. 10 no. 5').
- 성악곡 첫머리를 MB 로 고친 것(위키 → 쓴 것):
  - RV 625: Clarae, stellae → Clarae stellae, scintillate
  - RV 627: In turbato mare → In turbato mare irato
  - RV 637: Cur sagittas → Cur sagittas, cur tela
  - RV 639: Jubilate o amoeni chori → Jubilate, o amoeni chori
  - RV 641: Non in pratis → Non in pratis aut in hortis
  - RV 811: Vos invito, barbare faces → Vos invito, barbarae faces
  - RV 670: Alla caccia, alla caccia → Alla caccia dell'alme e de' cori
  - RV 652: Aure voi piu non siete → Aure, voi più non siete
  - RV 671: Care selve amici prati → Care selve, amici prati
  - RV 679: Che giova il sospirar → Che giova il sospirar povero core
  - RV 654: Elvira, Elvira anima mea → Elvira, anima mia
  - RV 656: Fonti di pianto piangete → Fonti del pianto
  - RV 657: Geme l'onda che parte → Geme l'onda che parte dal fonte
  - RV 680: Lundi dal vago → Lungi dal vago volto
  - RV 661: Nel partir da te mio caro → Nel partir da te, mio caro
  - RV 685: O mie porpore piu belle → O mie porpore più belle
  - RV 681: Perche son molli → Perché son molli
  - RV 674: Perfidissimo cor! → Perfidissimo cor
  - RV 676: Pianti, sospiri → Pianti, sospiri e dimandar mercede
  - RV 677: Qual per ignoto → Qual per ignoto calle
  - RV 663: Scherza di fronda → Scherza di fronda in fronda
  - RV 664: Seben vivono senz'alma → Se ben vivono senz'alma
  - RV 666: Si si luce adorate → Sì, sì, luci adorate
  - RV 668: T'intendo si mio cor → T'intendo, sì mio cor
  - RV 669: Tra l'erbe, i zeffiri → Tra l'erbe i zeffiri placidi

