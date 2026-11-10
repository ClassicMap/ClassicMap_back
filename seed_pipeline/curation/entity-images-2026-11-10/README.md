# 작곡가 얼굴·연주자 배너 빈칸 채우기 (2026-11-10)

그림이 하나도 없던 작곡가에게 얼굴 그림을, 배너가 없던 S·A 연주자에게 화면 머리 배너를 넣은 목록이에요.
그림은 한 장씩 확인 격자로 눈으로 보고 골랐어요. 맞는 그림이 없으면 빈칸으로 뒀어요.

## 대상 (운영 DB, 2026-11-10 읽기)

- 작곡가: 숨기지 않은 작곡가 중 `avatar_url`·`cover_image_url` 이 둘 다 빈 292명(B 291, A 1).
- 연주자: 공개 배너(`entity_images` `banner`, `PUBLISHED`)가 없는 S 36명, A 211명.
  - A 6명은 `authority_entity_id` 가 없어 배너를 넣을 수 없어요(배너는 인물 기록에 붙어요).
- 대상 목록은 `raw/composer-targets.tsv`, `raw/artist-targets.tsv` 에 있어요.

## 작곡가 얼굴

프론트는 작곡가 얼굴을 `composers.avatar_url` 로 그려요(목록·검색·타임라인의 동그란 칸, 배너가 없을 때 화면 머리).
S·A 작곡가는 `avatar_url` 과 `cover_image_url` 에 같은 위키미디어 주소가 들어 있어서 같은 꼴로 채웠어요.

### 출처와 고른 순서

1. 위키데이터 대표 그림(P18). 위키미디어 공용 자유 라이선스예요.
2. P18 이 없거나 쓸 수 없으면 공용 분류(P373)와 위키백과 각 언어판 문서의 자유 라이선스 대표 그림(`pageimages`, `pilicense=free`).
3. 그래도 없으면 애플 뮤직 아티스트 그림, 위키데이터 P1902 로 이어진 스포티파이 아티스트 그림.
   - 애플 뮤직 아이디는 위키데이터 P2850, 없으면 iTunes 검색에서 이름이 정확히 같고 장르가 클래식·사운드트랙인 것만 썼어요.
   - 스포티파이는 이름 검색을 하지 않았어요(동명이인 위험).

### 고른 기준

- 그 사람 한 명이 분명한 초상이어야 해요. 흉상·무덤·악보·건물·음반 표지·글자 로고·두 사람 이상이 같은 크기로 나온 그림은 뺐어요.
- 프론트는 얼굴 칸을 가운데 정사각(원형)으로 잘라요. macOS Vision 얼굴 상자로 가운데 정사각에 얼굴이 들어오는지 보고,
  세로로 긴 전신 사진처럼 얼굴이 잘리는 그림은 같은 사람의 다른 그림으로 바꾸거나 뺐어요.
- 라이선스는 Public domain, CC0, No restrictions, CC BY, CC BY-SA 만 써요.

### 넣는 곳

- `202611100101_fill_composer_portraits.sql`: 위키미디어 그림.
  - `avatar_url`·`cover_image_url` 이 둘 다 비었을 때만 채워요.
  - 지은이·라이선스·출처 페이지는 `entity_images`(`profile`, `PUBLISHED`, 대표)에 남겨요.
  - 원본 주소(upload.wikimedia.org)를 넣어요. 프론트가 500px·1920px 썸네일을 먼저 불러요.
  - TIFF 는 브라우저가 못 그려서 공용 썸네일(`lossy-page1-960px-…tif.jpg`)을 넣어요.
  - 같은 그림이 이미 배너로 들어 있는 10명은 그 배너 행에 저작자 기록이 있어 `profile` 행을 더하지 않아요(같은 인물·같은 주소 unique).
  - 시드가 남긴 `Special:FilePath` 행(`REVIEW_REQUIRED`)은 건드리지 않아요.
- `202611100102_fill_composer_portraits_from_services.sql`: 애플 뮤직·스포티파이 그림.
  - 같은 빈칸 조건으로 채워요. 그림은 각 서비스 서버를 그대로 가리켜요.
  - 권리자가 요청하면 그 작곡가의 두 칸을 비워요.

## 연주자 배너

11/7·11/8 과 같은 방법이에요(`../entity-banners-spotify-2026-11-07/`, `../entity-banners-more-2026-11-08/`).

1. 스포티파이 아티스트 머리 그림(`headerImage`, 2660×1140 등). 아이디는 위키데이터 P1902, 없으면 웹 검색 아티스트 탭에서 이름이 정확히 같은 첫 결과.
2. 없거나 쓸 수 없으면 애플 뮤직 아티스트 머리 그림(`wideArtwork`, 2880×1440 webp). 아이디는 `artists.apple_music_artist_id`, 위키데이터 P2850, iTunes 검색 순.
3. 초점(`focal_point`)은 macOS Vision 얼굴 상자로 정하고(가로 값은 모바일 1.15:1, 세로 값은 데스크톱 3.2:1 기준),
   데스크톱·모바일로 자른 확인 격자를 보고 손으로 고쳤어요. 단체(오케스트라·합창단)는 사람들이 보이게 맞췄어요.

`202611100103_fill_artist_banners.sql` 은 공개 배너가 하나도 없을 때만 넣어요. 출처는 화면에 "Spotify"·"Apple Music" 과 아티스트 페이지로 밝혀요.

## 뺀 것

`review.json` 에 이유와 함께 적어요.

- `portraitChoice`: P18 첫 장 대신 다른 그림을 고른 작곡가.
- `portraitReject`: P18 이 있었지만 쓰지 않은 작곡가.
- `serviceAccept`·`serviceReject`: 애플 뮤직·스포티파이 얼굴 그림.
- `bannerChoice`·`bannerReject`: 연주자 배너.

못 찾은 사람은 `missing-composer-portraits.tsv`, `missing-artist-banners.tsv` 예요.

## 다시 만들기

```bash
cd seed_pipeline
uv run python curation/entity-images-2026-11-10/build_portraits.py
uv run python curation/entity-images-2026-11-10/build_banners.py
uv run python curation/entity-images-2026-11-10/gen_sql.py
```

`raw/` 는 수집 결과예요(위키데이터·공용 정보, 애플 뮤직·스포티파이 응답에서 필요한 칸만).
수집 스크립트는 `collect/` 에 있어요. 요청은 순서대로 천천히 보냈고 User-Agent 연락처는 kang3171611@naver.com 이에요.
