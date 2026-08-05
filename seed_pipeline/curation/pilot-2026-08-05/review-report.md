# 비교 영상 파일럿 수동 검수 보고서

## 결론

다섯 작품에 대해 작품별 세 연주, 총 열다섯 후보를 선정했습니다. 모든 후보는 2026년 8월 5일 05:18:51 UTC에 YouTube 공개 상태와 oEmbed HTTP 200 응답을 확인했습니다. 영상이나 오디오는 내려받지 않았으며 운영 데이터베이스와 홈서버도 변경하지 않았습니다.

이번 파일럿에서는 풀 콘서트에서 임의의 시작·끝 초를 추정하는 방식을 사용하지 않았습니다. 작품 또는 변주 하나만 담긴 짧은 공식 아티스트·레이블·기관·YouTube Topic 영상을 골라 `0초~트랙 종료`를 비교 구간으로 정했습니다. 따라서 각 연주가 같은 악보의 첫 마디에서 시작해 같은 작품의 마지막 종지에서 끝납니다. 최장 구간은 115초로 기술 한도 600초 이내입니다.

콘텐츠와 구간 판정은 `APPROVED`이지만 공개 승인은 아닙니다. 공식 업로드도 클립 재생성·자체 호스팅 권한을 의미하지 않으므로 모든 행의 `rightsMode`는 `unknown`, prewarm 템플릿의 `rightsCheckStatus`는 `REVIEW_REQUIRED`로 유지했습니다. 권리 검토와 클립 자산 검증이 끝나기 전에는 발행하면 안 됩니다.

## 선정 결과

### 쇼팽: 전주곡 Op. 28 제7번 A장조

작품 식별자는 [MusicBrainz Work](https://musicbrainz.org/work/6ee8d38d-70fb-3442-af41-5669434c494f), 작곡가 식별자는 [Wikidata Q1268](https://www.wikidata.org/wiki/Q1268)을 사용했습니다. 비교 큐는 첫 마디의 첫 음부터 마지막 종지와 잔향까지입니다.

| 연주자 | 영상과 업로더 | 구간 | 가용성 |
|---|---|---:|---|
| Maurizio Pollini | [24 Preludes, Op 28: Prelude a-Dur Nr. 7](https://www.youtube.com/watch?v=X37lU27kyPs) · Maurizio Pollini - Topic | 0–40초 | public, oEmbed 200 |
| Martha Argerich | [Chopin: 24 Préludes, Op. 28: No. 7 in A Major](https://www.youtube.com/watch?v=9BajgStzY9E) · Martha Argerich - Topic | 0–44초 | public, oEmbed 200 |
| Seong-Jin Cho | [Seong-Jin Cho – Prelude in A major Op. 28 No. 7 (third stage)](https://www.youtube.com/watch?v=0hcF2AAE7sc) · Chopin Institute | 0–42초 | public, oEmbed 200 |

### 쇼팽: 연습곡 Op. 25 제9번 G플랫장조 ‘나비’

작품 식별자는 [MusicBrainz Work](https://musicbrainz.org/work/0a957e8a-0b86-30c5-bfa9-ad095ee43be8), 작곡가 식별자는 [Wikidata Q1268](https://www.wikidata.org/wiki/Q1268)을 사용했습니다. 비교 큐는 첫 마디의 빠른 동기부터 마지막 상승 동기 뒤 종지까지입니다.

| 연주자 | 영상과 업로더 | 구간 | 가용성 |
|---|---|---:|---|
| Murray Perahia | [12 Études, Op. 25: No. 9 in G-Flat Major “Butterfly's Wings”](https://www.youtube.com/watch?v=6Dze40F0suQ) · Murray Perahia - Topic | 0–61초 | public, oEmbed 200 |
| Vladimir Ashkenazy | [12 Etudes, Op. 25: No. 9 in G-Flat Major “Butterfly”](https://www.youtube.com/watch?v=g3o2QVuuIWI) · Vladimir Ashkenazy - Topic | 0–61초 | public, oEmbed 200 |
| Beatrice Rana | [12 Études, Op. 25: No. 9 in G-Flat Major “Butterfly”](https://www.youtube.com/watch?v=ubFem6hAZrc) · Beatrice Rana - Topic | 0–62초 | public, oEmbed 200 |

### 슈만: 어린이 정경 Op. 15 제3곡 ‘술래잡기’

작품 식별자는 [MusicBrainz Work](https://musicbrainz.org/work/7a8d4ff2-f178-39c5-b03b-4050606e11ef), 작곡가 식별자는 [Wikidata Q7351](https://www.wikidata.org/wiki/Q7351)을 사용했습니다. 비교 큐는 빠른 16분음표 동기의 첫 음부터 마지막 악센트 화음까지입니다.

이 작품은 전곡 자체가 약 30초이므로 한 후보가 권장 최소 길이 30초보다 짧습니다. 부분을 인위적으로 늘리는 대신 완결된 전곡을 유지했습니다.

| 연주자 | 영상과 업로더 | 구간 | 가용성 |
|---|---|---:|---|
| Martha Argerich | [Schumann: Kinderszenen, Op. 15: III. Hasche-Mann (Live)](https://www.youtube.com/watch?v=satKCMMp1E4) · Martha Argerich - Topic | 0–26초 | public, oEmbed 200 |
| Vladimir Horowitz | [Schumann: Kinderszenen, Op. 15: III. Hasche-Mann](https://www.youtube.com/watch?v=IxG3yTedhgk) · Vladimir Horowitz - Topic | 0–32초 | public, oEmbed 200 |
| Leif Ove Andsnes | [Kinderszenen, Op. 15: No. 3, Hasche-Mann](https://www.youtube.com/watch?v=dcbWEvwIGmo) · LeifOveAndsnesTV | 0–34초 | public, oEmbed 200 |

### 그리그: 서정 소곡집 Op. 12 제1곡 ‘아리에타’

작품 식별자는 [MusicBrainz Work](https://musicbrainz.org/work/b6115546-141a-3366-9e3c-77c1459d21f8), 작곡가 식별자는 [Wikidata Q80621](https://www.wikidata.org/wiki/Q80621)을 사용했습니다. 비교 큐는 여린 못갖춘마디 선율의 첫 음부터 주제 회귀 뒤 마지막 으뜸화음까지입니다.

| 연주자 | 영상과 업로더 | 구간 | 가용성 |
|---|---|---:|---|
| Leif Ove Andsnes | [Lyric Pieces, Book 1, Op. 12: No. 1, Arietta](https://www.youtube.com/watch?v=4eHcvvmox_8) · LeifOveAndsnesTV | 0–80초 | public, oEmbed 200 |
| Emil Gilels | [Grieg: Lyric Pieces, Book 1, Op. 12: No. 1, Arietta](https://www.youtube.com/watch?v=bLcjSU1NvLA) · Emil Gilels - Topic | 0–85초 | public, oEmbed 200 |
| Stephen Hough | [Grieg: Lyric Pieces Book 1, Op. 12: No. 1, Arietta](https://www.youtube.com/watch?v=8hW0wzcNW8g) · Stephen Hough | 0–69초 | public, oEmbed 200 |

### 바흐: 골드베르크 변주곡 BWV 988 제1변주

작품 식별자는 [MusicBrainz Work](https://musicbrainz.org/work/84d128d5-7b06-3c41-ad1b-002a46821345), 작곡가 식별자는 [Wikidata Q1339](https://www.wikidata.org/wiki/Q1339)을 사용했습니다. 비교 큐는 제1변주의 첫 마디부터 마지막 반복구의 종지와 이중세로줄까지입니다.

| 연주자 | 영상과 업로더 | 구간 | 가용성 |
|---|---|---:|---|
| Glenn Gould | [Goldberg Variations, BWV 988: Variation 1 a 1 Clav.](https://www.youtube.com/watch?v=4_IC4_MFdGM) · Glenn Gould | 0–70초 | public, oEmbed 200 |
| Víkingur Ólafsson | [Bach: Goldberg Variations, BWV 988: Var. 1 (Official Music Video)](https://www.youtube.com/watch?v=vn-g510Zxng) · Deutsche Grammophon - DG | 0–105초 | public, oEmbed 200 |
| Igor Levit | [Goldberg Variations, BWV 988: Var. 1 a 1 Clav.](https://www.youtube.com/watch?v=wFMiD7MvLpQ) · Igor Levit | 0–115초 | public, oEmbed 200 |

## 크레딧과 식별자

모든 작품은 독주 피아노곡이므로 performance credit은 피아니스트 한 명이며 그 연주자를 primary로 지정했습니다. 작곡가는 performance credit이 아니라 작품 관계로 분리했습니다. 연주자 후보는 다음 Wikidata 식별자를 사용했습니다.

- [Maurizio Pollini Q160058](https://www.wikidata.org/wiki/Q160058)
- [Martha Argerich Q156810](https://www.wikidata.org/wiki/Q156810)
- [Seong-Jin Cho Q4516986](https://www.wikidata.org/wiki/Q4516986)
- [Murray Perahia Q326221](https://www.wikidata.org/wiki/Q326221)
- [Vladimir Ashkenazy Q157785](https://www.wikidata.org/wiki/Q157785)
- [Beatrice Rana Q17490313](https://www.wikidata.org/wiki/Q17490313)
- [Vladimir Horowitz Q192506](https://www.wikidata.org/wiki/Q192506)
- [Leif Ove Andsnes Q453617](https://www.wikidata.org/wiki/Q453617)
- [Emil Gilels Q319732](https://www.wikidata.org/wiki/Q319732)
- [Stephen Hough Q1243635](https://www.wikidata.org/wiki/Q1243635)
- [Glenn Gould Q216924](https://www.wikidata.org/wiki/Q216924)
- [Víkingur Ólafsson Q27916341](https://www.wikidata.org/wiki/Q27916341)
- [Igor Levit Q100759](https://www.wikidata.org/wiki/Q100759)

기존 ClassicMap 데이터베이스의 인물·작품 ID는 추정하지 않았습니다. staging 적재 시 외부 식별자를 먼저 조회하고, 식별자가 일치하지 않으면 이름만으로 자동 병합하지 않고 검토 큐로 보내야 합니다.

## 검수 방법과 한계

1. MusicBrainz Work의 작품명과 작곡가 관계를 확인했습니다.
2. Wikidata에서 작곡가와 연주자 항목을 확인했습니다.
3. YouTube 메타데이터에서 영상 ID, 제목, 채널, 업로드 날짜, 재생 길이, `public`/`not_live` 상태를 확인했습니다.
4. 각 영상의 YouTube oEmbed URL이 HTTP 200을 반환하는지 별도로 확인했습니다.
5. 정확한 작품 하나로 분리된 트랙만 남기고, 풀 콘서트·모음 영상·편곡 영상·제3자 재업로드는 제외했습니다.
6. 트랙 전체를 사용하므로 임의 타임스탬프에 대한 청음 추정을 하지 않았습니다. 공식 메타데이터상 작품 범위가 명확하다는 근거로 음악 문맥을 판정했습니다.

공개 상태는 시점에 따라 바뀔 수 있습니다. prewarm 직전과 정기 점검에서 다시 확인해야 합니다. 또한 oEmbed 성공은 임베드·다운로드·재배포 권리를 보장하지 않습니다. 열다섯 후보 모두 별도의 권리 검토가 필요합니다.

## 다음 단계

1. staging에서 외부 식별자를 기준으로 작품·작곡가·연주자 후보를 resolve합니다.
2. 이름만 일치하거나 외부 식별자가 충돌하면 `REVIEW_REQUIRED`로 보냅니다.
3. `candidateKey`를 보존하면서 performance를 DRAFT로 적재합니다.
4. 권리 검토가 승인된 행만 실제 prewarm manifest로 변환합니다.
5. 클립 생성, FFprobe, SHA-256, Range 206 검증이 모두 끝난 뒤에만 READY와 PUBLISHED로 전이합니다.
