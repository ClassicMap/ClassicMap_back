# 2026-08-05 국제 초기 시드 로컬 파일럿

## 점검 범위

이 문서는 국제 초기 시드 v1의 로컬 구현 및 격리 MySQL 검증 결과를 기록합니다. 운영 데이터베이스와 홈서버에는 데이터를 쓰지 않았습니다. 홈서버 SSH가 응답하지 않아 현재 컨테이너와 클립 저장소 상태는 확인하지 못했습니다.

## 구현 완료 범위

- Wikidata API의 정확한 QID 수집과 공식 entities dump 스트리밍 수집
- MusicBrainz 작곡가별 작품 수집, 공식 dump 스트리밍 수집, 정확한 작품·상위 악장 계층 수집
- 작품 bundle이 참조하는 누락 작곡가 closure 수집
- canonical JSONL 적재, dry-run, 멱등 재실행, 수동 데이터 보호
- 비교영상 후보의 정확한 작품·작곡가·연주자 식별자 해소
- 기존 비교 인물 12행을 이름 검색 없이 검수된 Wikidata QID로 명시 연결
- 악장 또는 부분 작품 후보의 `piece_part_id` 연결
- 권리 검토 전 후보를 `REVIEW_REQUIRED`, performance를 `DRAFT`, clip job을 `PENDING`으로 제한
- 검증된 클립 자산 적재와 아티스트 상세 비교 API

## 로컬 staging 산출물

| 묶음 | canonical SHA-256 | 전체 행 | 핵심 결과 | 검수 행 |
|---|---|---:|---|---:|
| 작곡가 500명 후보 | `1557629919d3d6110898ad811dd7ec8f1aaf11653a88a340e09c7702c864dd64` | 5,960 | authority 498, legacy composer 100 | 399 |
| 작품 browse | `b0fd5e90db1612dc475ffaa6304a8ebfbdc7bc2d15ba43f1d4c933b2f57c884b` | 5,684 | piece 851, identifier 1,143, part 45 | 814 |
| 발행 가능 작품 | `d58031d58968cd6ba76782f2b6edbcf3e330e28680e1419d7a1e4e4bfa968352` | 5,031 | piece 650, identifier 855, part 40 | 1,015 |
| 작품 누락 작곡가 closure | `31eea452d48ad6f474e6cd517616ae8ca6b41c5cec431494efc5da06bd4ec2f0` | 3,131 | authority 159, legacy composer 102 | 57 |
| 비교 인물 파일럿 | `b0ede437ad15ce50434d672aba0d39bbb7fb2558be7a4314e2c807e448c9fc1e` | 379 | authority 17, artist 13, composer 7, 수동 provenance 8 | 2 |
| 비교 작품 정확 계층 | `c875ad37ed4daa6a0125cdd38133855744f084e06a3bc5ea80b1103b74618b3b` | 37 | root piece 5, part 6 | 0 |

작품 browse 묶음은 226개의 작곡가 MusicBrainz MBID를 참조했습니다. 기존 작곡가 묶음에 없던 191개 중 159개를 Wikidata QID로 정확히 해소했고, 32개는 자동 연결하지 않았습니다.

발행 가능 작품 묶음은 의존성이 미해소된 작품 201개와 그 종속 행 653개를 제외했습니다. 격리 MySQL에는 작곡가 두 묶음을 먼저 적재한 뒤 작품 650개를 포함한 5,031행을 적재했고, 같은 묶음 재실행은 mutation 0이었습니다.

## 비교영상 파일럿

- 비교 대상은 5개 작품·악장, 15개 연주 후보, 13명의 주요 연주자입니다.
- 구간 길이는 26~115초이며 기술적 최대 길이는 600초입니다.
- 다섯 MusicBrainz 작품 식별자는 모두 상위 작품의 악장 또는 부분 작품으로 확인했습니다.
- comparison loader는 상위 `pieces.id`에 performance를 연결하고, 실제 비교 구간에는 정확한 `piece_parts.id`를 저장합니다.
- 격리 MySQL에서 15개 후보가 후보 MusicBrainz work MBID와 동일한 `piece_parts.part_key`에 연결되고, 13명의 기존 연주자 ID를 재사용하는지 확인했습니다.
- 모든 후보의 권리 상태가 아직 `unknown`이므로 클립을 생성하거나 홈서버에 저장하지 않았습니다.
- 권리가 확인되지 않은 YouTube 영상을 광고 제거 목적으로 자체 저장하는 경로는 발행하지 않습니다.

## 검증 결과

| 검증 | 결과 |
|---|---|
| Python Ruff | 통과 |
| Python mypy | 56개 source file 통과 |
| Python pytest | 94개 통과 |
| Rust 전체 target check | 통과 |
| 비교 후보 격리 MySQL | 1개 통합 테스트 통과 |
| 비교 파일럿 전체 경로 격리 MySQL | authority bootstrap, legacy 12행 연결, 정확 악장 15건, DRAFT/PENDING 15건 검증 통과 |
| composer canonical 격리 MySQL | 최초 적재 성공, 재실행 mutation 0 |
| composer+works 누락 의존성 preflight | 첫 누락 작곡가에서 실패, DB 변경 0 |
| 전체 migration·global loader 격리 MySQL | migration 1~10 및 loader 검증 통과 |
| 프론트 클립 서버 | 19개 테스트 통과 |

Rust 저장소 전체 `cargo fmt --check`는 기존 파일의 포맷 차이 때문에 실패합니다. 이번에 변경한 Rust 파일은 `rustfmt`와 `git diff --check`를 통과했습니다. 기존 compiler warning은 이번 범위에서 변경하지 않았습니다.

## 공식 dump 실행 계약

Wikidata 대량 수집은 날짜가 고정된 공식 `.json.bz2`와 다음 정보를 포함한 sidecar를 요구합니다.

```text
dump_date
official source_url
sha256
size_bytes
```

파일은 streaming으로 읽으며 P279 계층과 linked label/P297을 content SHA별 SQLite index로 만듭니다. checkpoint는 다음 ordinal과 immutable page manifest만 저장합니다. 입력 checksum 또는 partition 범위가 달라지면 resume을 거부합니다.

MusicBrainz 공식 dump 수집기는 tar 루트의 `SCHEMA_SEQUENCE=31`과 필요한 PostgreSQL COPY entry를 먼저 검증합니다. page artifact를 누적 메모리 없이 스트리밍 결합하며, checkpoint의 run/source/stage/source URI/input provenance가 다르면 resume을 거부합니다. 잘못된 MBID와 orphan FK는 정확 연결로 승격하지 않고 review로 보냅니다. 관계 날짜, 종료 여부, entity credit, link attribute qualifier는 raw 근거에 보존합니다. 두 dump 모두 작은 fixture 검증만 완료했으며 실제 전체 공식 dump는 아직 내려받거나 실행하지 않았습니다.

## 발행 차단 항목

1. 비교 파일럿 12행 외의 기존 수동 composer·artist에는 이름 없이 연결할 명시적 mapping 검수가 더 필요합니다.
2. 공식 Wikidata 전체 dump와 MusicBrainz 전체 dump 실행이 필요합니다.
3. Apple Music과 Spotify 링크는 인증된 공식 export와 ISRC 일치 자료가 필요합니다.
4. 비교영상 15건은 업로더 권한, 별도 허가 또는 자유 라이선스 근거가 필요합니다.
5. 권리가 확인된 후보만 홈서버 prewarm, FFprobe, SHA-256, HTTP Range 206 검증을 수행할 수 있습니다.
6. staging 결과를 사용자 검토한 뒤에만 운영 DB와 홈서버에 적용합니다.

## 다음 발행 단위

다음 안전한 발행 단위는 검증된 파일럿의 `authority bootstrap → 명시적 legacy linkage → full canonical load → 발행 가능 작품 load`입니다. 이 순서로 기존 수동 행의 표시값을 유지하면서 작품 FK가 기존 composer ID를 재사용하도록 로컬 검증했습니다. 실제 적용은 staging 검토 후 별도 승인하며, 공식 dump 전체 실행과 비교영상 권리 검수 결과도 각각 별도 승인 단위로 적용합니다.
