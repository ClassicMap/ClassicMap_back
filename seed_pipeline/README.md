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
