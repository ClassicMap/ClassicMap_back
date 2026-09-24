# 곡과 연주 고르기

배치가 막히는 곳은 거의 여기다. 검출과 정렬은 자동이지만 **연주 3종을 구하는 일은
자동이 아니다.** 곡을 잘못 고르면 30분을 쓰고 배치를 접는다.

## 연주 3종이 모이는 곡

**유명할수록 쉽다.** 역설적으로 짧은 소품보다 유명 소나타·협주곡이 후보가 많다.
8분 이하 소품 중 유명도가 떨어지는 것은 공식 채널 영상이 한둘뿐이라 자주 막힌다.

실제로 막혔던 예:

| 곡 | 막힌 이유 |
|---|---|
| 시벨리우스 핀란디아·슬픈 왈츠 | 유명 영상이 전부 카라얀+베를린필로 겹침 |
| 생상스 죽음의 무도 | 유명 지휘자 영상 자체가 드묾 |
| 비에니아프스키 화려한 폴로네즈 | 검색 상위가 같은 연주자로 채워짐 |
| 엘가 사랑의 인사 | DB 에 등록된 바이올리니스트 영상이 둘뿐 |

**검색 전에 DB 를 본다.** 적재기는 연주자를 `external_identifiers.wikidata` 로만
해소한다. 이름은 근거가 아니다. 등록되지 않은 연주자를 골랐다면 추가 마이그레이션이
먼저다.

```sql
SELECT a.id, a.name, a.category, e.external_id
FROM artists a
JOIN external_identifiers e
  ON e.authority_entity_id = a.authority_entity_id AND e.namespace = 'wikidata'
WHERE a.category = 'pianist';
```

## 영상 고르기

- **공식 채널을 우선한다.** 연주자 본인, DG·Warner·Sony, 악단 공식 채널.
- **관현악은 제목으로 악단을 알 수 없다.** "Die Fledermaus Overture" 같은 제목이
  대부분이다. 영상 설명의 배급 표기(`작품 · 악단 · 지휘자`)를 근거로 삼는다.
- **채널 이름으로도 악단을 알 수 없다.** 아래를 보라.
  `yt-dlp --print "%(description).150s"` 로 확인한다.
- **같은 연주자가 둘이면 안 된다.** 비교의 뜻이 사라진다.
- **600초를 넘는 클립은 만들 수 없다.** 긴 연주는 후보에서 뺀다.

## 구간을 어떻게 나눌 것인가

| 작품 길이 | sectorType | 방식 |
|---|---|---|
| 8분 이하 | `WHOLE_WORK` | 작품 전체가 곧 구간 |
| 8~20분 다악장 | `MOVEMENT` | 작품 전체 work + 악장별 sector |
| 8~20분 단일 악장 | `WHOLE_WORK` | 전곡 (600초 안에 들면) |
| 20분 초과 | `EXCERPT` | 유명한 대목을 발췌 |
| 오페라 아리아 | `EXCERPT` | 아리아 단위 work 이 따로 있다 |

**다악장 작품은 악장만 담긴 영상을 찾는다.** 전악장 영상에서 악장 경계를 찾는
일은 하지 않는다. 유명 소나타는 악장 단위 영상이 충분히 있다.

한 작품에 sector 를 여럿 만들 수 있다. 월광 소나타는 1악장과 3악장이 각각
붙어 있고, 영상 검색·MBID·충돌 검사를 한 번만 하면 되므로 **곡당 비용이 줄어든다.**

## 작품 MBID 고르기

같은 제목의 work 이 여럿이면 **연결된 녹음 수**로 가린다. 압도적인 것이 원곡이고
나머지는 편곡이거나 중복이다.

```
Ballade no. 1 in G minor, op. 23      313건  ← 이것
Ballade, "Hommage à Chopin"             1건
Ballade for Orchestra, op. 23           3건
```

**낱곡 work 을 함부로 쓰지 않는다.** 모음곡의 한 곡이면 낱곡 work 의 녹음 수가
전체보다 많은 일이 흔하지만(월광 1악장 739건 vs 전체 180건), 낱곡 work 은
국제 시드의 `piece_parts` 와 겹쳐 해소가 막힌다. **전체 work 에 sector 로 붙인다.**

## 붙이기 전에 충돌을 검사한다

이것을 건너뛰면 적재 단계에서 막히고 되돌려야 한다.

```sql
SELECT 'part' k, pp.piece_id, p.title
FROM piece_parts pp JOIN pieces p ON p.id = pp.piece_id
WHERE pp.part_key = 'musicbrainz:<MBID>'
UNION ALL
SELECT 'ident', pi.piece_id, p.title
FROM piece_identifiers pi JOIN pieces p ON p.id = pi.piece_id
WHERE pi.external_id = '<MBID>';
```

비어 있으면 안전하다. 걸리는 것이 있으면 `05-pitfalls.md` 의 중복 항목을 읽는다.

**독립 작품은 대체로 안전하고 모음곡의 낱곡은 의심한다.** 지금까지 막힌 것은
전부 모음곡의 낱곡이었다(달빛, 라흐마니노프 전주곡, 그노시엔 1번).

## 작곡가 QID

**추측하지 않는다.** 두 번 틀려서 적재가 실패한 적이 있다.

```sql
SELECT p.id, p.title, c.name, e.external_id
FROM pieces p JOIN composers c ON c.id = p.composer_id
LEFT JOIN external_identifiers e
  ON e.authority_entity_id = c.authority_entity_id AND e.namespace = 'wikidata'
WHERE p.id = <pieceId>;
```

## 협주곡 크레딧

**협주곡은 독주자만으로 성립하지 않는다.** 독주자를 primary 로 두고 video 에
`conductor` 와 `orchestra` 를 함께 적는다. 둘 다 wikidata 로 해소하므로
등록되지 않은 지휘자·악단이면 추가 마이그레이션이 먼저다.

```json
{"videoId": "...", "artistName": "Yunchan Lim", "wikidata": "Q...",
 "conductor": {"name": "...", "wikidata": "Q..."},
 "orchestra": {"name": "...", "wikidata": "Q..."}}
```

크레딧 순서는 독주자(0) → 지휘자(1) → 악단(2)이다. 지휘자가 primary 인 관현악 곡에는
`conductor` 를 적지 않는다(`build_candidates.py` 가 막는다).
2026-09-17 이전에 발행한 차이콥스키 협주곡 1번(작품 159)은 이 필드가 없던 때라
독주자 크레딧만 있다.

## 재수집 대기

클립 자산 없이 수동으로 넣었던 레거시 연주는 새 비교 API 공개 기준에 들지 못한다.
clip_assets 를 따로 등록하지 않고 **이 파이프라인으로 다시 수집한다.**
전부 협주곡이거나 긴 곡이라 구간은 `EXCERPT` 이고, 협주곡은 위의 크레딧 규칙을 따른다.

| 작품 | 레거시 구간 (섹터 id) | 레거시 연주자 | 상태 |
|---|---|---|---|
| 226 라흐마니노프 피아노 협주곡 3번 | 1악장 카덴차(14) · 2악장(17) · 3악장 도입부(19) · 3악장 클라이맥스(18) | 임윤찬 · 랑랑 · 유자 왕 | 작품 MBID 미연결 |
| 225 라흐마니노프 피아노 협주곡 2번 | 1악장(11) · 2악장(12) · 3악장(13) | 안나 페도로바 · 조성진 · 유자 왕 | 작품 MBID 미연결 |
| 129 쇼팽 발라드 1번 | 서주·제1주제(7) · 제2주제(8) · 코다(9) | 짐머만 · 조성진 · 호로비츠 · 루빈스타인 · 키신 | 전곡 섹터 71 로 이미 공개됨. 발췌 구간만 남음 |

- 레거시 구간 이름과 연주자는 참고용이다. 같은 영상을 다시 쓸 수 있는지는 검출·정렬로 다시 판정한다.
- 레거시 영상은 대부분 협주곡 전곡이라 600초 제한과 악장 경계에 걸린다. 발췌 구간만 담긴 영상이 없으면 전곡 영상에서 구간을 검출한다.
- 레거시 섹터(sector_key 없음)는 그대로 두고 새 sector_key 로 붙인다. 적재기가 기존 수동 데이터를 덮어쓰지 않는다.


## 채널 이름은 악단의 근거가 되지 못한다 (2026-09-25)

**악단 공식 채널이 다른 악단의 녹음을 올린다.** 레이블이 배급을 맡기면서 채널이
섞이기 때문이다. 하루에 여섯 번 걸렸다.

| videoId | 채널 이름 | 배급 표기의 실제 |
|---|---|---|
| `MiIiB9MWnlo` · `K6j7D9xwdH8` | Herbert von Karajan | **루돌프 켐페 · 빈 필** |
| `iia2J-6CHmY` | Berliner Philharmoniker - Topic | **빈 필 · 콜린 데이비스** |
| `PE6eKvsyx-8` · `UeUblo_aK7c` | Michel Schwalbé / Sergei Levitin - Topic | 채널 이름이 **악장(콘서트마스터)** 이다 |
| `Ac13w5uVfd0` | Berliner Philharmoniker | **빈 필 · 로린 마젤** |
| `2bDHzugiOvA` | Berliner Philharmoniker | **빈 필 · 카를 뵘** |
| `bSYSXB93i-4` | Berliner Philharmoniker | **빈 필 · 카라얀** |

베를린 필 채널이 네 번 나왔고 네 번 다 실제로는 빈 필이었다. 연주자 본인 이름을
단 채널도 남의 녹음을 올린다.

**근거는 영상 설명의 배급 표기 하나뿐이다.**

```
Provided to YouTube by Universal Music Group
<작품> · <악단> · <지휘자>
<음반 이름>
℗ <연도> <레이블>
```

이 표기가 없으면 그 영상은 쓰지 않는다. 제목·채널·섬네일로 짐작해 적은 악단은
나중에 고칠 방법이 없다 — 크레딧이 틀린 채로 발행된다.