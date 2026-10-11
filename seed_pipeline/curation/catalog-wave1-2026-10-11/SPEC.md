# 작품 카탈로그 1차 확장 — 작곡가별 작업 명세

ClassicMap 작곡가 화면에 그 작곡가의 작품 전체를 **출판 단위**로 보이게 하려는 자료를 만든다.
묶음(예: 베토벤 「현악 4중주 Op. 18」 6곡)은 작품 하나, 그 안의 곡은 part 로 둔다. 악장으로 나뉜
작품(교향곡 등)은 악장을 part 로 둔다. 쇼팽으로 이미 해 봤다. 참고 예:
`../chopin/catalog.json`, `../chopin/report.md` (형식은 아래가 우선이다. 쇼팽 것과 조금 다르다).

결과는 **데이터 파일만** 만든다. 내(리드)가 이 파일로 DB 마이그레이션을 만든다.

## 하지 말 것

- DB 접속, kubectl, git, 브라우저 쿠키 사용 금지. 운영 DB 에서 필요한 건 `db/` 에 이미 받아 뒀다.
- 웹 요청은 `tools/fetch.py` 의 `mb()`·`wiki_raw()` 로만 한다(요청 간격·캐시·User-Agent 를 여러
  에이전트가 같이 맞춘다). 직접 curl/urllib 로 MusicBrainz·위키백과를 부르지 않는다. User-Agent 에
  개인정보를 넣지 않는다. fetch.py 는 고치지 않는다. MusicBrainz 가 503 을 계속 주면 멈추고 보고한다.
- 받은 자료를 읽는 파이썬은 `python3 -I` 로 돌린다(시스템 파이썬 3.9, `X | None` 문법 대신
  `Optional` 이나 `from __future__ import annotations`).
- 자기 폴더(`<작곡가>/`) 밖에 파일을 쓰지 않는다.

## 자료

- `db/composers.tsv`: 작곡가 id, MusicBrainz artist id, Wikidata id.
- `db/pieces.tsv`: 이 작곡가들의 운영 작품 전부(id, 제목, opus_number, origin, 설명·링크·비교 구간 수).
- `db/piece_identifiers.tsv`: 그 작품들의 MBID. `db/all_mbids_taken.tsv`: 운영 전체에서 이미 쓰인 work MBID.
- `db/piece_parts.tsv`: 그 작품들에 이미 있는 part.
- MusicBrainz: `mb("work", {"artist": <artist mbid>, "limit": 100, "offset": N, "inc": "aliases+work-rels"})`
  로 작곡가 work 를 100개씩 relation 과 함께 받을 수 있다(작곡가당 수십 번이면 끝난다). 묶음 안 part 는
  work-rels 의 `parts` 관계로 이어진다. 낱개 조회는 꼭 필요할 때만.
- 위키백과: `wiki_raw("List of compositions by …")` 등. 작품 목록의 기준은 위키백과 영어판 작품 목록이다.

## 범위

- 넣는 것: 그 작곡가의 표준 카탈로그(작품번호·K.·Hob.·S.·WoO·TH·MWV 등)에 오른 **현존·완성** 원작.
  어릴 때 작품도 카탈로그에 있고 악보가 전하면 넣는다.
- 빼는 것: 위작·위작 의심, 소실, 단편·스케치·미완성 단장, 남의 작품을 편곡·전사한 것(리스트의
  다른 작곡가 곡 편곡·패러프레이즈, 모차르트의 헨델 편곡 등), 민요 편곡(하이든 Hob. XXXIa/b), 같은 곡의
  옛 판(마지막 판만 넣음, 다른 판은 보고에 적기), 카탈로그 보유(Anh.)의 출처 불명 곡.
  애매한 큰 묶음(하이든 바리톤 3중주 Hob. XI, 음악 시계 곡 등)은 빼고 보고에 적는다.
- 미완성이지만 연주 관례가 확고한 작품(모차르트 레퀴엠, 슈베르트 미완성 교향곡 같은 것)은 넣는다.

## 단위 정하기

- **묶음(collection)**: 한 작품번호·카탈로그 번호 아래 여러 곡이 함께 출판된 것. 예: 베토벤 Op. 18(현악
  4중주 6곡), Op. 2(피아노 소나타 3곡), Op. 27(소나타 2곡), Op. 126(바가텔 6곡); 리스트 S. 139(초절기교
  12곡), S. 244(헝가리 광시곡 19곡), S. 541(사랑의 꿈 3곡), 순례의 해 각 권; 슈만 Op. 15·48 등 연작;
  멘델스존 무언가 각 권(Op. 19b·30·38·53·62·67·85·102); 하이든 현악 4중주 세트(Op. 76 등, Hob. III 번호를
  part 쪽에); 차이콥스키 Op. 37a(사계 12곡), Op. 39, 가곡 세트.
  모차르트는 K. 번호가 낱곡 단위라 대부분 낱곡이고, 한 K. 번호 아래 여러 곡(K. 600 독일 무곡 6곡 등)만 묶음.
- **다악장(multi_movement)**: 악장으로 나뉜 한 작품(교향곡·협주곡·소나타·실내악·미사·레퀴엠 등). 악장을 part 로.
- **낱곡(single)**: 그 밖. 오페라·발레·오라토리오·부수음악 같은 무대·대형 성악 작품은 이번에는 **part 없이
  낱곡**으로 둔다(번호·아리아 목록은 나중에). 발레·부수음악에서 따로 작품번호를 받은 모음곡(예:
  차이콥스키 Op. 71a)은 다악장으로.
- 묶음 안의 곡이 다시 악장으로 나뉘면(Op. 18 의 각 4중주, Op. 2 의 각 소나타) 그 곡의 `children` 에 악장을 둔다.
- 묶음은 두 겹까지만. 그보다 깊으면 펴서 두 겹으로 만들고 보고에 적는다.

## 이름 규칙 (운영 DB 관례)

- 조성: `C장조`, `A단조`, `B♭장조`, `F#단조` (♭ 기호, # 문자). 영어도 `E♭ major`, `C# minor`.
- 별명: 큰따옴표. `교향곡 5번 C단조 "운명"`, `피아노 소나타 14번 C#단조 "월광"`.
- 고유 제목이 있는 작품은 꺾쇠: `오페라 <돈 조반니>`, `연가곡집 <시인의 사랑>`, `교향시 <전주곡>`,
  `발레 <백조의 호수>`, `피아노 모음곡 <어린이의 정경>`.
- 갈래 이름: 교향곡, 피아노 협주곡, 바이올린 협주곡, 피아노 소나타, 바이올린 소나타, 첼로 소나타,
  현악 4중주, 피아노 3중주, 피아노 4중주, 피아노 5중주, 현악 5중주, 세레나데, 디베르티멘토, 미사, 서곡,
  변주곡, 론도, 환상곡, 가곡, 무언가 등. 숫자 갈래는 "4중주"처럼 숫자로(운영 관례).
- **작품 제목(titleKo)**:
  - 낱곡·다악장: 작품번호를 제목에 넣지 않는다(`catalogue` 칸에 따로). `피아노 소나타 8번 C단조 "비창"`.
  - 묶음: 갈래 이름만으로는 서로 구별이 안 되면 제목 끝에 카탈로그를 넣는다: `현악 4중주 Op. 18`,
    `피아노 소나타 Op. 2`, `헝가리 광시곡 S. 244`. 고유 제목 묶음은 넣지 않는다: `연가곡집 <시인의 사랑>`.
  - 같은 작곡가 안에서 제목이 겹치면 안 된다(운영 `db/pieces.tsv` 제목 포함).
- **titleEn**: 영어 관례 제목(`Symphony No. 5 in C minor "Fate"`, `6 String Quartets, Op. 18`).
- **part 이름(nameKo)**: 번호는 따로 붙으므로 넣지 않는다.
  - 묶음 안 곡: `C장조`, `E장조 "이별의 곡"`, 소나타 묶음이면 `피아노 소나타 1번 F단조`(곡 자체가 큰 작품이면
    갈래 이름 포함), 갈래가 섞인 묶음이면 `녹턴 E단조`.
  - 악장: 빠르기말·악장 이름 원어 그대로, 우리말 갈래어만 옮김: `Allegro con brio`, `미뉴에트. Allegretto`,
    `스케르초. Presto`, `피날레. Allegro`, `로망스. Larghetto`, `주제와 변주`. 미사는 `키리에`, `글로리아` 등.
  - 가곡·노래 제목: 국내에서 널리 쓰는 우리말 제목이 확실하면 `우리말 (원제)`, 아니면 `원제` 그대로.
    직접 옮긴 우리말은 보고서에 목록으로 남긴다.
- **nameEn**: 원어/영어 이름(`No. 1 in F minor`, `I. Allegro con brio`, `Im wunderschönen Monat Mai`).
- **movementNumber**: 악장 part 에만 로마 숫자(`I`, `II` …). 묶음 안 곡에는 null.

## catalog.json (작곡가별 배열)

```json
{
  "key": "beethoven-op18",
  "kind": "collection | multi_movement | single",
  "catalogue": "Op. 18",
  "catalogueAlt": "Hob. III:75",
  "titleKo": "현악 4중주 Op. 18",
  "titleEn": "6 String Quartets, Op. 18",
  "year": 1800,
  "yearText": "1798–1800",
  "genre": "string_quartet",
  "authenticity": "authentic",
  "mbid": "…",
  "mbTitle": "…",
  "existingPieceId": null,
  "parts": [
    {
      "seq": 1,
      "mbid": "…",
      "nameKo": "현악 4중주 1번 F장조",
      "nameEn": "No. 1 in F major",
      "movementNumber": null,
      "catalogueAlt": null,
      "existingPieceId": null,
      "existingPartId": null,
      "children": [
        {"seq": 1, "mbid": "…", "nameKo": "Allegro con brio", "nameEn": "I. Allegro con brio",
         "movementNumber": "I", "existingPieceId": null, "existingPartId": null}
      ]
    }
  ]
}
```

- `catalogue`: 작품 단위 카탈로그 표기(위키백과 꼴). 없으면 null. `catalogueAlt`: 다른 체계 번호(선택).
- `year`: 완성 연도(정수, 범위면 끝 해). `yearText`: 범위 그대로.
- `mbid`: 그 작품의 MusicBrainz work. 확실히 맞는 work 가 없으면 null. **`db/all_mbids_taken.tsv` 에서
  다른 작품이 이미 쓰는 MBID 는 그 작품이 이 작곡가의 기존 작품일 때만 쓴다**(그때는 existingPieceId 로).
- `existingPieceId`: 운영에 이미 같은 작품이 있으면 그 id. **MBID 로 맞추는 게 먼저**이고, MBID 가 없으면
  카탈로그 번호로 맞춘 뒤 보고서에 근거를 적는다. 제목만으로 맞추지 않는다.
  - 운영의 낱곡이 새 묶음 안의 곡이면(베토벤 78 「월광」 = Op. 27 의 2번) 그 part 의 `existingPieceId` 에 적는다.
  - 운영에 같은 작품이 둘 있으면(예: 슈만 135 manual 과 464 seed 「어린이의 정경」) 둘 다 보고서에 적고,
    MBID 를 가진 쪽을 existingPieceId 로 쓴다.
- `existingPartId`: `db/piece_parts.tsv` 의 part 와 같은 곡이면 그 id.
- parts 순서는 출판·카탈로그 순(seq 1부터). 다악장이면 악장 순.
- part 의 mbid 는 MusicBrainz parts 관계에서 찾은 것. 없으면 null.

## 검증 (꼭)

- 위키백과 작품 목록과 기계로 대조: 묶음별 곡 수·조성, 카탈로그 번호 빠짐 없음. 다른 곳은 보고서에.
- MusicBrainz parts 관계와 위키백과가 다르면 위키백과를 따르고 보고서에 적는다.
- 제목 겹침 0, nameKo 가 `1번 `·`1악장 ` 으로 시작하는 것 0, 빈 nameKo 0.

## 보고서 report.md

1. 개수(작품: 묶음·다악장·낱곡, part, children).
2. 운영 기존 작품 대응표(id → key, 맞춘 근거: MBID/카탈로그), 운영 중복 작품.
3. 뺀 것과 까닭(갈래별 개수 + 목록).
4. 애매했던 판단.
5. 직접 옮긴 우리말 이름 목록(검수용).
6. 위키백과 대조 결과.

마지막에 리드에게 짧게: 개수, 기존 대응, 꼭 봐야 할 판단 3~5개.
