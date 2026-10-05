# 영화 속 클래식 1단계 조사 지침

ClassicMap(한국 클래식 앱)에 "영화 속 클래식"을 넣는다. 영화·드라마·애니에 나온 클래식 곡을 장면 단위(큐)로 정리한다.
너는 맡은 작품마다 **근거가 있는 큐만** 모아 작품 하나당 JSON 파일 하나로 쓴다.

## 작업 규칙

- 맡은 작품을 하나 끝낼 때마다 **바로** `<이 폴더>/<slug>.json` 을 쓴다. 다 모아서 한 번에 쓰지 않는다(큰 파일 한 번에 쓰다 멈춘 적이 있다).
- 작품에 근거 있는 클래식 큐가 하나도 없으면 같은 종류의 다른 작품으로 바꿔도 된다(한국 작품은 한국 작품으로). 바꾸면 JSON 의 `replacedFrom` 에 원래 작품을 적는다.
- 개인정보를 어디에도 보내지 않는다. 가입·로그인하지 않는다.
- **themoviedb.org(TMDB) 페이지·API 는 열지 않는다**(약관상 AI 처리에 쓰지 않기로 했다). TMDB ID 는 Wikidata 에서만 가져온다.
- IMDb·Tunefind·WhatSong·나무위키는 읽어서 실마리로만 쓰고 근거로 세지 않는다(등급 "ref"). 페이지를 대량으로 긁지 않는다.
- 클래식이 아닌 곡(가요, 팝, 재즈 스탠더드, 영화 창작곡)은 넣지 않는다. 크로스오버 편곡이라도 원곡이 클래식이면 `arranged: true` 로 넣는다.

## 공개 기준 (이걸 못 넘으면 cues 가 아니라 dropped 에 넣는다)

- 1차 근거 1개 이상, 또는 서로 다른 곳의 2차 근거 2개 이상.
- 1차(grade "1"): 공식 OST 트랙 목록(레이블·공식 음반 페이지·MusicBrainz 음반), KMDb(한국영상자료원) 작품 페이지의 삽입곡 기재, 제작진·음악감독·배우 인터뷰 기사에서 곡을 직접 밝힌 것, 공식 채널의 장면 클립 설명에 곡이 적힌 것.
- 2차(grade "2"): 클래식 전문지·일간지·방송사 기사, 출처가 달린 위키백과 문장, AniList 스태프 기재, 오페라·음악 단체의 해설 글.
- 참고(grade "ref"): 나무위키, IMDb 사운드트랙, Tunefind, 블로그, 팬 위키. 세지 않는다.

## 영상 작품 ID

- Wikidata 엔티티 JSON(`https://www.wikidata.org/wiki/Special:EntityData/Q….json`)에서 가져온다.
  - QID, IMDb `P345`, TMDB 영화 `P4947`, TMDB TV `P4983`, KMDb 영화 ID(속성 번호는 Wikidata 에서 확인, 있으면), AniList `P8729`, 한국어 라벨.
- 못 찾으면 null.

## 큐 하나 = 장면 하나에 쓰인 곡 하나

같은 곡이 여러 장면에 나오면 대표 장면 하나로 묶고 `episode`/장면 설명에 "여러 회" 등을 적는다. 작품 하나에 큐는 1~6개.

- `usage`
  - `SCORE` 배경음악(인물은 못 듣는 음악)
  - `SOURCE` 화면 속 음악(스피커·전축·라디오·공연장에서 나와 인물도 듣는 음악)
  - `PERFORMED` 인물이 직접 연주하거나 노래함
  - `TITLES` 오프닝·엔딩·주제곡
- `part`: 악장·곡·아리아 이름(원어). `partKo`: 한국어로 "3악장 Finale. Allegro", "3막 이중창 '저녁 산들바람은 부드럽게'" 처럼. 단악장이면 null.
- `passage`: 그 악장 안에서 어느 대목인지 근거로 알 수 있으면 짧게(영어 또는 한국어). 모르면 null. 추측하지 않는다.
- `episode`: 시리즈·애니면 "S1E1" 꼴(시즌 하나면 "E24"도 됨). 여러 회면 "여러 회". 영화면 null.
- `approxAtSec`: 근거에 시각이 나오면 초 단위, 아니면 null. 추측 금지.
- `sceneNote`: **해요체, 두 문장 안, 70자 안팎.** 누가 어디서 이 음악을 듣거나 연주하는지 사실만. 비유·감상·권유("들어 보세요", "~처럼 흘러요", "압도적인") 금지. 근거 문장을 번역해 옮기지 말고 새로 쓴다.
- `spoiler`: 결말·반전·인물의 죽음이 드러나면 true. 그 경우에도 sceneNote 는 써 두고 true 로 표시.
- `officialClip`: 권리자(제작사·배급사·방송사·OTT, 또는 스튜디오 라이선스 클립 채널) 공식 YouTube 채널에 그 장면 클립이 있으면.
  - `https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=<id>&format=json` 로 확인해 200 이고 `author_name` 이 공식 채널일 때만 넣는다(401·404 면 넣지 않음).
  - `{ "videoId", "startSec"(모르면 0), "channel"(author_name), "title"(영상 제목), "why"(이 장면이라고 본 이유) }`
  - 예고편·팬 업로드·리액션 영상은 넣지 않는다. 없으면 null.
- `evidence`: `[{ "grade": "1"|"2"|"ref", "kind": "ost"|"kmdb"|"interview"|"clip"|"article"|"wikipedia"|"anilist"|"other", "url", "note": "이 근거가 말하는 것 한 줄" }]`
- `confidence`: high / medium.

## 파일 형식 (`<slug>.json`, slug 는 영어 소문자-하이픈)

```json
{
  "slug": "squid-game",
  "kind": "SERIES",
  "titleKo": "오징어 게임",
  "titleOriginal": "오징어 게임",
  "releaseYear": 2021,
  "countryCode": "KR",
  "creditLine": "황동혁 연출 · 넷플릭스",
  "ids": { "wikidata": "Q…", "imdb": "tt…", "tmdbMovie": null, "tmdbTv": 93405, "kmdb": null, "anilist": null },
  "replacedFrom": null,
  "cues": [
    {
      "order": 1,
      "episode": "여러 회",
      "composer": "Joseph Haydn",
      "work": "Trumpet Concerto in E-flat major",
      "catalog": "Hob. VIIe:1",
      "part": "III. Finale. Allegro",
      "partKo": "3악장 Finale. Allegro",
      "passage": null,
      "usage": "SOURCE",
      "arranged": false,
      "approxAtSec": null,
      "sceneNote": "참가자들이 자는 숙소에 아침마다 기상 음악으로 틀어요.",
      "spoiler": false,
      "officialClip": null,
      "evidence": [ { "grade": "2", "kind": "article", "url": "https://…", "note": "…" } ],
      "confidence": "high"
    }
  ],
  "dropped": [ { "what": "베토벤 교향곡 5번 (VIP 장면)", "reason": "2차 근거 하나뿐" } ]
}
```

- `kind`: MOVIE(실사 영화) · SERIES(드라마·실사 시리즈) · ANIME(애니 영화·시리즈·단편 모두).
- `creditLine`: "감독 이름 감독" 또는 "연출 · 방송사/플랫폼" 한 줄, 한국어.
- `titleKo`: 한국에서 통용되는 제목(개봉·방영 제목).

끝나면 마지막 답으로 작품별 큐 개수와 dropped 개수, 바꾼 작품만 짧게 보고한다.
