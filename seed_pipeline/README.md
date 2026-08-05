# ClassicMap 국제 초기 시드 파이프라인

공식 데이터 원본을 immutable JSONL artifact로 수집하고, 정규화와 식별 결정을 거쳐 staging 적재용 결과를 만드는 독립 도구입니다. 이 패키지는 운영 데이터베이스에 연결하거나 직접 쓰지 않습니다.

## 실행 환경

```bash
uv sync
uv run classicmap-seed --help
```

`uv`가 없는 점검 환경에서는 저장소 내부 가상환경만 사용합니다.

```bash
python3 -m venv .venv
.venv/bin/python -m pip install -e '.[dev]'
.venv/bin/python -m ruff check .
.venv/bin/python -m mypy .
.venv/bin/python -m pytest
```

모든 명령은 다음 공통 옵션을 받습니다.

```text
--run-id
--dry-run
--resume / --no-resume
--limit
--json-report
```

## 작은 공식 원본 수집 예시

MusicBrainz는 연락 가능한 User-Agent 정보가 필요합니다. 연락처는 비밀값이 아니지만 artifact에는 저장하지 않습니다.

```bash
uv run classicmap-seed snapshot \
  --run-id sample-20260805 \
  --source musicbrainz \
  --contact maintainer@example.com \
  --limit 5

uv run classicmap-seed snapshot \
  --run-id sample-20260805 \
  --source open-opus \
  --limit 5

uv run classicmap-seed snapshot \
  --run-id sample-20260805 \
  --source wikidata \
  --contact maintainer@example.com \
  --limit 5
```

생성된 manifest 경로를 다음 단계에 전달합니다.

### Wikidata 범위 수집의 운영 경계

`snapshot-wikidata`는 `composers`, `performers`, `ensembles` scope를 QID keyset으로 순회합니다. 각 page는 immutable artifact로 남고 mutable checkpoint에는 page manifest 경로와 다음 cursor만 기록합니다. 수집값은 Wikidata QID, MusicBrainz artist ID, GND, VIAF, ISNI, RISM ID(P5504), 역할, 악기, 국가, Commons 이미지 식별자, 한국어·영어 이름과 별칭입니다.

```bash
uv run classicmap-seed snapshot-wikidata \
  --run-id sample-wikidata-20260805 \
  --scope composers \
  --contact maintainer@example.com \
  --page-size 100 \
  --limit 1000
```

이 API collector는 작은 live 검증, 파일럿, 증분 보강용입니다. 수만 명 이상의 전세계 공개 seed를 반복 생성하는 주 경로로 WDQS/API를 사용하지 않습니다. 전체 공개 목표는 공식 Wikidata dump를 고정 버전으로 내려받아 동일한 raw `SourceRecord` 계약으로 변환하는 별도 ingestion job이 필요합니다. dump checksum, 배포일, 재시작 가능한 partition cursor를 manifest에 남긴 뒤 이 파이프라인의 normalize 이후 단계를 재사용해야 합니다.

레거시 `composers`와 `artists` 행은 필요한 표시 필드가 공식 원본에서 모두 검증된 경우에만 생성합니다. 작곡가 시대 정보가 원본에 없을 때는 검증된 출생연도를 기준으로 `<1400 중세`, `<1600 르네상스`, `<1750 바로크`, `<1820 고전주의`, `<1900 낭만주의`, 그 외 `근현대` 규칙을 적용하고 bundle evidence에 `birth_year_boundaries_v1`을 남깁니다. 국가 표시명, 영어 이름, 연주 분야 등 필수값이 없거나 여러 값으로 충돌하면 임의 기본값을 만들지 않고 `review_queue`로 보냅니다.

```bash
uv run classicmap-seed normalize \
  --run-id sample-20260805 \
  --manifest artifacts/sample-20260805/raw/musicbrainz/<sha256>.manifest.json

uv run classicmap-seed resolve \
  --run-id sample-20260805 \
  --manifest artifacts/sample-20260805/normalized/musicbrainz/<sha256>.manifest.json

uv run classicmap-seed export-canonical \
  --run-id sample-20260805 \
  --manifest artifacts/sample-20260805/resolved/musicbrainz/<sha256>.manifest.json

uv run classicmap-seed link-streaming \
  --run-id sample-20260805 \
  --platform spotify \
  --input tests/fixtures/spotify_tracks.jsonl
```

`resolve`는 안정적 외부 식별자를 공유한 후보만 자동 병합합니다. 이름만 같은 후보는 항상 `REVIEW_REQUIRED`로 분류합니다.

## DB 적재 계약

canonical과 streaming 결과의 모든 행에는 `db_contract_version: global-seed-v1`과 같은 `seed_run_id`가 포함됩니다. CLI의 사람이 읽는 `run-id`는 UUIDv5 기반의 결정적 `seed_run_id`로 변환됩니다. 따라서 동일한 run을 재실행해도 DB 식별자가 바뀌지 않습니다.

출력의 `table`은 추상 엔티티명이 아니라 migration의 실제 적재 대상입니다. 인물·단체는 `authority_entities`와 `entity_names`, `entity_roles`, `entity_instruments`, `entity_countries`, `entity_images`, `external_identifiers`로 나뉩니다. 작품은 `pieces`, `piece_aliases`, `piece_identifiers`, `piece_parts`, `piece_relations`, `piece_instrumentation`으로 나뉩니다.

AUTO_INCREMENT 또는 기존 정수 PK는 JSON 값으로 임의 생성하지 않습니다. 각 행의 `natural_key`와 `foreign_keys`가 다음 정보를 명시합니다.

- 적재 시 채울 FK 컬럼
- 참조할 실제 DB 테이블
- 참조 대상의 결정적 natural key
- 현재 bundle 안에서 반드시 해석할지, 기존 DB 행까지 허용할지

이 패키지는 해당 계약을 검증한 JSONL만 생성합니다. 실제 PK 조회, upsert, transaction은 별도 staging loader 책임이며 운영 DB에는 직접 쓰지 않습니다.

## 스트리밍 export 입력

`link-streaming`은 Spotify 또는 Apple Music의 공식 API/export 결과를 JSONL로 받은 뒤 처리합니다. 이 명령은 토큰을 받거나 외부 API를 직접 호출하지 않습니다.

자동 확정에는 다음 조건이 모두 필요합니다.

- canonical track과 platform track의 ISRC가 정확히 일치합니다.
- 정규화한 연주자 이름이 하나 이상 정확히 겹칩니다.
- 재생시간 차이가 2초 또는 canonical duration의 2% 이내입니다.
- storefront, 확인 시각, 공식 track URL이 존재합니다.
- 링크 대상은 작품이나 앨범이 아니라 `recording_track`입니다.

하나라도 충돌하면 platform link를 만들지 않고 `review_queue` record만 생성합니다. [Spotify fixture](tests/fixtures/spotify_tracks.jsonl)와 [Apple Music fixture](tests/fixtures/apple_music_tracks.jsonl)를 입력 계약 예제로 사용할 수 있습니다.

## Artifact 구조

```text
artifacts/<run-id>/
├─ raw/<source>/<sha256>.jsonl
├─ raw/<source>/<sha256>.manifest.json
├─ normalized/<source>/<sha256>.jsonl
├─ normalized/<source>/<sha256>.manifest.json
├─ resolved/<source>/<sha256>.jsonl
├─ resolved/<source>/<sha256>.manifest.json
├─ canonical/<source>/<sha256>.jsonl
├─ canonical/<source>/<sha256>.manifest.json
├─ streaming/<source>/<sha256>.jsonl
└─ streaming/<source>/<sha256>.manifest.json
```

파일명은 JSONL 본문의 SHA-256으로 결정됩니다. 이미 생성된 artifact는 덮어쓰지 않습니다. 같은 입력을 다시 실행하면 기존 artifact를 재사용하며 mutation 수는 0입니다.

## 검증

```bash
uv run ruff check .
uv run mypy .
uv run pytest
```
