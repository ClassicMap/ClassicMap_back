# 작품 카탈로그 3차 — 시드가 많은 작곡가 다시 짜기 명세

ClassicMap 작곡가 화면에 그 작곡가의 작품 전체를 **출판 단위**로 보이게 하려는 자료를 만든다.
묶음(예: 베토벤 「현악 4중주 Op. 18」 6곡)은 작품 하나, 그 안의 곡은 part 로 둔다. 악장으로 나뉜
작품(교향곡 등)은 악장을 part 로 둔다. 1차(모차르트·베토벤·하이든·슈만·멘델스존·리스트·차이콥스키)는
이미 운영에 반영됐고, 2차(헨델·비발디 등 25명)도 반영됐다. 참고 예: `../wave1/beethoven/catalog.json`,
`../wave2/vivaldi/catalog.json`, `../wave1/beethoven/report.md` (이 명세가 우선이다).

**3차가 다른 점**: 이 작곡가들은 운영에 국제 시드 작품(origin=seed)이 수백~천여 개 있다. 제목은 원어 그대로이고,
작품이 아니라 악장·칸타타 안의 한 곡이거나, 찬송가 번안·팝 편곡·남의 곡처럼 잡음도 섞여 있다. 그래서
카탈로그를 만들면서 **모든 seed 작품을 하나씩 어디에 넣을지 정한다**(아래 「기존 시드 작품 대응」).

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
- `db/piece_parts.tsv`: 그 작품들에 이미 있는 part(비어 있으면 없음).
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

## 기존 시드 작품 대응 (3차의 핵심)

`db/pieces.tsv` 에서 그 작곡가의 origin=seed 작품 하나하나를 다음 셋 중 하나로 정해 `seed_map.json` 에 적는다.
대응은 **MBID 로 먼저**(`mbids` 칸이 seed 작품의 musicbrainz_work 들) 한다. MBID 가 없거나 안 맞으면 카탈로그 번호·제목으로
맞추되, 제목만으로 맞춘 것은 근거를 적는다.

- `work`: 그 seed 작품이 카탈로그의 한 작품 자체다 → catalog.json 그 작품의 `existingPieceId` 에 seed id 를 적는다.
  생성기가 그 seed 작품의 제목·영어 제목·작품번호·연도를 catalog.json 값으로 바꾸고 잠근다(seed 제목은 원어라서).
- `part`: 그 seed 작품이 카탈로그 작품 안의 곡·악장이다 → 그 part(또는 children)의 `existingPieceId` 에 seed id 를 적는다.
  묶음 안으로 들어가 목록 최상위에서는 빠진다. 큰 작품이 지금 규칙상 part 없는 낱곡(오페라·오라토리오·칸타타·수난곡·미사)이라도,
  **seed 작품이 그 안의 대목을 가리키면 그 작품에 part 를 만들어(MusicBrainz parts 순서대로) 잇는다.**
- `unmatched`: 카탈로그 어디에도 대응이 없다 → 까닭을 고른다: `arrangement`(남의 편곡·번안·다른 편성 판), `other_composer`
  (남의 곡이 잘못 붙음), `popular`(팝·록·재즈·영화 등 대중음악 재해석), `hymn_translation`(찬송가·노래 가사 번안·다른 언어 제목),
  `fragment`(단편·스케치), `spurious`(위작), `duplicate`(같은 작품의 다른 seed 행 — 어느 work 와 겹치는지 적음), `excluded_scope`
  (카탈로그 범위 밖으로 뺀 곡), `unknown`, `excerpt_keep`. 리드가 이 목록으로 숨긴다(비교 구간이 있는 seed 작품은 숨기지 않는다).
- `excerpt_keep`: part 없이 둔 큰 작품(오페라·발레 등)의 대목인데 **단독으로 널리 연주·녹음되는 것**(서곡, 유명 아리아·간주곡 등)은
  숨기지 않고 남긴다. 그 seed_map 항목에 `"titleKo"`·`"titleEn"` 을 적는다(운영 꼴: `<피에라브라스> 서곡`,
  `오페라 <로엔그린> 중 "혼례의 합창"`). 남의 편곡·잡음에는 쓰지 않는다.
- seed 작품 하나를 두 곳에 쓰지 않는다. 한 catalog 작품/part 에 seed 작품 둘을 붙이지 않는다(겹치면 하나는 `duplicate`).
- seed 작품에 이미 붙은 seed part(`db/piece_parts.tsv`, IDENTIFIERS_MATCHED)는 생성기가 같은 MBID part 를 찾아 이름·순서·상태를
  고쳐 쓴다. catalog 에 적을 필요는 없다(existingPartId 비워 둠).
- manual 작품(origin=manual)은 1·2차와 같다(제목을 바꾸지 않는다).

`seed_map.json` 꼴: `[{"pieceId": 14352, "title": "<운영 제목>", "mbids": ["…"], "mapping": "work|part|unmatched",
"key": "<catalog key>", "path": [3, 5], "reason": null|"arrangement"|…, "note": null|"…"}]` — 그 작곡가의 seed 작품 전부.
`path` 는 part 일 때 seq 경로(묶음 3번 곡의 5악장이면 [3, 5]).

## 운영 기존 작품 중 주의할 꼴

- 「오페라 <X> 중 "아리아">」·「<X> 중 "Y"」 처럼 큰 작품의 한 대목을 따로 둔 운영 작품은 그대로 둔다. 큰 작품(오페라 X)은
  따로 낱곡으로 넣되, 그 대목 작품을 existingPieceId 로 쓰지 않는다. 보고서 2절에 목록만 적는다.
- 여러 작품을 한데 묶은 운영 작품(예: 비발디 「사계」 = Op. 8 1~4번, 버르토크 「6개의 현악 4중주」)은 그대로 두고,
  part 하나에 이어 붙이지도 않는다(part 여러 개가 한 작품을 가리키게 하지 않는다). 보고서에 적는다.
- 운영 작품이 새 묶음 안의 낱곡 하나와 정확히 같으면(예: 「바이올린 협주곡 A단조 Op. 3, No. 6」) 그 part 의 existingPieceId 로 잇는다.
- 운영 작품의 opus_number 가 비어 있거나 꼴이 달라도(“Op. 8, No. 1-4 (RV …)”) 제목을 바꾸지 않는다.

## 검증 (꼭)

- 위키백과 작품 목록과 기계로 대조: 묶음별 곡 수·조성, 카탈로그 번호 빠짐 없음. 다른 곳은 보고서에.
- MusicBrainz parts 관계와 위키백과가 다르면 위키백과를 따르고 보고서에 적는다.
- 제목 겹침 0, nameKo 가 `1번 `·`1악장 ` 으로 시작하는 것 0, 빈 nameKo 0.
- seed_map.json 이 그 작곡가의 seed 작품 수와 같고, work/part 로 적은 id 가 catalog.json 의 existingPieceId 와 정확히 맞는다.
- 운영 seed 작품끼리 제목이 같아도 생성기는 막지 않지만, catalog titleKo 는 같은 작곡가 안에서 겹치지 않아야 한다.
- 리드 생성기로 시험 변환: `../wave1/gen/gen_catalog.py` (파이썬 3.10 이상. `python3.13` 이 있으면 그걸로, 없으면
  저장소의 `seed_pipeline` 폴더에서 `uv run python <생성기> …`). 인자는
  `--composer-id <id> --slug <slug> --catalog <catalog.json> --pieces db/pieces.tsv --taken db/all_mbids_taken.tsv --out <자기 폴더>/gen_test.sql`.
  오류가 나면 catalog.json 을 고친다(생성기는 고치지 않는다).

## 보고서 report.md

보고서 .md 파일 쓰기가 막혀 있으면 우회하지 말고(확장자 바꾸기 등 금지) 본문을 리드에게 메시지로 나눠 보낸다.

1. 개수(작품: 묶음·다악장·낱곡, part, children). seed 대응 수(work / part / unmatched 와 까닭별).
2. 운영 기존 작품 대응표(id → key, 맞춘 근거: MBID/카탈로그), 운영 중복 작품.
3. 뺀 것과 까닭(갈래별 개수 + 목록).
4. 애매했던 판단.
5. 직접 옮긴 우리말 이름 목록(검수용).
6. 위키백과 대조 결과.

마지막에 리드에게 짧게: 개수, 기존 대응, 꼭 봐야 할 판단 3~5개.
