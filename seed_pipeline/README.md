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

이 API collector는 작은 live 검증, 파일럿, 증분 보강용입니다. 수만 명 이상의 전세계 공개 seed를 반복 생성하는 주 경로로 WDQS/API를 사용하지 않습니다. 전세계 대량 seed의 주 경로는 아래의 날짜 고정 공식 dump ingestion입니다.

### Wikidata 공식 dump 대량 수집

`snapshot-wikidata-dump`는 공식 entities JSON dump의 로컬 `.json.bz2` 파일을 streaming으로 읽습니다. 테스트용 uncompressed `.json`도 같은 줄 단위 JSON array 계약으로 읽습니다. 네트워크를 호출하지 않으며 파일 전체를 메모리에 올리지 않습니다. 결과 수는 `--limit`으로 제한되고, 입력 entity는 한 행씩만 메모리에 유지합니다.

입력에는 다음 strict release metadata sidecar가 필수입니다. `source_url`은 `latest`가 아닌 날짜 고정 `dumps.wikimedia.org` entities URL이어야 하며 URL 날짜와 `dump_date`가 같아야 합니다. `sha256`과 `size_bytes`는 실제 로컬 입력 파일과 정확히 일치해야 합니다. 이 네 값은 모든 dump 기반 manifest의 `input_provenance`에 보존됩니다.

```json
{
  "schema_version": "1",
  "dump_date": "2026-08-01",
  "source_url": "https://dumps.wikimedia.org/wikidatawiki/entities/20260801/wikidata-20260801-all.json.bz2",
  "sha256": "<실제 로컬 파일의 소문자 SHA-256 64자리>",
  "size_bytes": 123456789
}
```

```bash
uv run classicmap-seed snapshot-wikidata-dump \
  --run-id wikidata-20260801-part-000 \
  --input /data/wikidata-20260801-all.json.bz2 \
  --release-metadata /data/wikidata-20260801.release.json \
  --start-ordinal 0 \
  --end-ordinal 10000000 \
  --checkpoint-every 10000 \
  --limit 100000 \
  --artifacts-dir artifacts \
  --json-report reports/wikidata-20260801-part-000.json
```

partition은 dump JSON array에 나타나는 모든 top-level entity의 0-based ordinal입니다. `start`는 inclusive, `end`는 exclusive입니다. 같은 dump와 partition은 항상 같은 범위를 가리킵니다. checkpoint에는 다음 ordinal과 immutable page manifest만 저장합니다. 입력 파일이나 sidecar checksum이 바뀐 상태에서 같은 run/partition을 resume하면 거부합니다.

첫 실행은 dump의 P279 edge와 영어·한국어 linked label/P297을 `artifacts/_indexes/wikidata/<input-sha>.scope.sqlite`에 streaming으로 구축합니다. 이 로컬 파생 index로 기존 `P106/P279* composer`, `P106/P279* musician`, `P31/P279* musical ensemble` predicate를 평가합니다. composer가 musician 계층에도 속하는 구조적 중첩에는 composer precedence를 적용합니다. 이름은 scope 판정에 사용하지 않습니다. scope 근거가 손상되었거나 person/ensemble이 동시에 일치하면 공개 raw에 섞지 않고 별도 review artifact로 보냅니다.

Wikidata raw payload는 국가 ISO code와 국가 QID를 `country_code_links`로 함께 보존합니다. ISO code가 정확히 하나면 그 code에 연결된 QID의 한국어, 영어 순서로 국가명을 선택합니다. 역사 국가 QID가 함께 있어도 연결되지 않은 label을 nationality로 고르지 않습니다. ISO code 또는 같은 code의 연결 QID가 둘 이상이면 legacy projection은 계속 review입니다.

dump snapshot 이후에는 report의 공개 raw `manifest_path`를 표준 단계에 그대로 전달합니다. `input_provenance`는 canonical까지 전파됩니다. review manifest를 normalize 입력으로 사용하면 안 됩니다.

```bash
uv run classicmap-seed normalize \
  --run-id wikidata-20260801-part-000 \
  --manifest artifacts/wikidata-20260801-part-000/raw/wikidata/<raw-sha>.manifest.json \
  --limit 100000

uv run classicmap-seed resolve \
  --run-id wikidata-20260801-part-000 \
  --manifest artifacts/wikidata-20260801-part-000/normalized/wikidata/<normalized-sha>.manifest.json \
  --limit 100000

uv run classicmap-seed export-canonical \
  --run-id wikidata-20260801-part-000 \
  --manifest artifacts/wikidata-20260801-part-000/resolved/wikidata/<resolved-sha>.manifest.json \
  --limit 100000
```

낮은 사양 모델이나 운영 자동화는 다음 순서를 바꾸지 않습니다.

1. 날짜 고정 공식 URL, dump 날짜, 로컬 SHA-256, 파일 크기를 sidecar에 기록합니다.
2. 서로 겹치지 않는 `[start-ordinal, end-ordinal)` partition과 고유 run-id를 정합니다.
3. 먼저 `--dry-run`으로 계약과 예상 결과를 확인합니다.
4. write 실행 후 raw와 review manifest 경로를 각각 기록합니다.
5. 같은 명령을 `--resume`으로 다시 실행해 `scanned_entity_count=0`, `mutation_count=0`을 확인합니다.
6. review가 아닌 raw manifest만 normalize, resolve, export-canonical에 전달합니다.
7. canonical의 두 번째 dry-run mutation 0과 review queue를 확인하기 전에는 staging loader에도 전달하지 않습니다.
8. 이 명령에는 contact, 토큰, API key를 추가하지 않으며 운영 DB와 홈서버 경로를 사용하지 않습니다.

이미 외부 검수가 끝난 QID dependency는 이름 검색 없이 entity API로 직접 수집합니다. 입력은 `{qid, scope}` 두 필드만 허용하며 QID 중복, 잘못된 scope, 이름 필드와 알 수 없는 필드를 거부합니다. main entity와 역할·악기·국가 linked entity를 `wbgetentities` 최대 50건 batch로 읽고 immutable page artifact와 입력 SHA-256별 checkpoint를 남깁니다. 입력 scope는 그대로 신뢰하지 않습니다. 같은 50건 page를 WDQS `VALUES`와 기존 작곡가·연주자·앙상블 predicate로 검증하며, 불일치는 수집 전에 거부하고 검증 근거를 각 raw record의 `scope_validation`에 남깁니다.

```bash
uv run classicmap-seed snapshot-wikidata-entities \
  --run-id comparison-pilot-wikidata-20260805 \
  --input curation/pilot-2026-08-05/wikidata-entities.jsonl \
  --contact maintainer@example.com \
  --limit 17
```

비교 파일럿 입력은 `candidates.jsonl`의 작곡가와 연주자 Wikidata 식별자에서 결정적으로 추출한 17개 QID입니다. 같은 run-id로 `--resume`하면 완료 checkpoint와 content-addressed aggregate를 재사용하여 mutation 0이 되어야 합니다. 이 명령도 운영 DB나 홈서버에 연결하지 않습니다.

후속 작품 수집에는 `curation/pilot-2026-08-05/wikidata-composers.jsonl`의 작곡가 4건만 별도 run으로 수집합니다. 이 결과의 canonical manifest에는 검증된 MusicBrainz artist ID만 남으므로 `snapshot-musicbrainz-works --artist-manifest` 입력으로 바로 연결할 수 있습니다. mixed 17건 canonical manifest를 작품 browse 입력으로 사용하지 않습니다.

레거시 `composers`와 `artists` 행은 필요한 표시 필드가 공식 원본에서 모두 검증된 경우에만 생성합니다. 작곡가 시대 정보가 원본에 없을 때는 검증된 출생연도를 기준으로 `<1400 중세`, `<1600 르네상스`, `<1750 바로크`, `<1810 고전주의`, `<1860 낭만주의`, 그 외 `근현대` 규칙을 적용하고 bundle evidence에 `birth_year_boundaries_v1`을 남깁니다. 국가 표시명, 영어 이름, 연주 분야 등 필수값이 없거나 여러 값으로 충돌하면 임의 기본값을 만들지 않고 `review_queue`로 보냅니다. Commons 이미지는 파일별 저작자와 라이선스가 검증되기 전에는 `entity_images.REVIEW_REQUIRED`에만 두며 레거시 공개 이미지 필드로 투영하지 않습니다.

### MusicBrainz 작품 수집

이미 외부 검수가 끝난 작품은 `{mbid}` 한 필드만 있는 JSONL로 exact 수집합니다. 입력의 알 수 없는 필드, 비정규 UUID, 중복 MBID를 거부합니다. 각 행은 공식 `/ws/2/work/<mbid>?inc=aliases+artist-rels+work-rels&fmt=json`에서 한 번씩 조회하며 반환 ID가 요청 MBID와 정확히 같아야 합니다.

```bash
uv run classicmap-seed snapshot-musicbrainz-work-entities \
  --run-id comparison-pilot-works-20260805 \
  --input curation/pilot-2026-08-05/musicbrainz-works.jsonl \
  --contact maintainer@example.com \
  --limit 5 \
  --max-hierarchy-depth 8 \
  --max-hierarchy-records 1000
```

비교 파일럿 입력은 `candidates.jsonl`의 `workCandidate.naturalKey`와 같은 `musicbrainz_work` 외부 식별자를 함께 검증해 결정적으로 추출한 5개 MBID입니다. 악장인 작품은 canonical 계층 FK에 필요한 `parts` backward 부모만 제한적으로 재귀 수집합니다. `based on`, 편곡 등 다른 관계를 따라가지는 않으며 깊이와 전체 레코드 상한을 넘으면 중단합니다. 각 raw record에는 최초 root MBID, 깊이와 dependency relation을 남깁니다. HTTP 요청당 작품 한 건, MusicBrainz 1 req/s 제한을 적용합니다. 입력 SHA-256과 계층 제한별 checkpoint와 immutable page artifact를 남기므로 같은 run-id와 입력으로 `--resume`하면 요청과 mutation이 모두 0이어야 합니다. 이름 검색, 작곡가 전체 browse, 운영 DB나 홈서버 연결은 수행하지 않습니다.

#### 작곡가별 전체 작품 탐색

작품 수집은 이전 단계에서 만든 canonical artist manifest를 입력으로 받습니다. `authority_entities`를 참조하며 evidence가 strong인 `musicbrainz_artist` 식별자만 허용합니다.

```bash
uv run classicmap-seed snapshot-musicbrainz-works \
  --run-id sample-works-20260805 \
  --artist-manifest artifacts/sample-artists/canonical/wikidata/<sha256>.manifest.json \
  --contact maintainer@example.com \
  --page-size 100 \
  --limit 25000
```

공식 `/ws/2/work?artist=<MBID>` browse를 offset checkpoint로 순회합니다. work MBID, ISWC, type, language, alias, 명시적 work attribute, composer relation, work-to-work relation과 movement ordering을 보존합니다. 제목 문자열에서 작품번호나 악장을 추측하지 않습니다. page 100 기준 25,000 work의 절대 하한은 약 250 요청이며 MusicBrainz 1 req/s 제한 때문에 최소 약 250초가 필요합니다. 작곡가 work browse의 artist 의미는 녹음의 연주자와 다르므로 이 명령은 recording/ISRC를 수집하지 않습니다. recording은 release/recording 관계와 공식 식별 계약이 별도로 승인된 뒤 추가해야 합니다.

### 작품 bundle의 작곡가 closure 보강

`snapshot-work-composer-dependencies`는 작품 canonical bundle의 `pieces.composer_id` FK가 참조하지만 입력한 작곡가 canonical bundle들에 없는 `musicbrainz_artist:<mbid>`만 결정적으로 정렬해 수집합니다. 이름과 제목은 식별 근거로 사용하지 않습니다.

```bash
.venv/bin/classicmap-seed snapshot-work-composer-dependencies \
  --run-id sample-work-composer-dependencies-20260805 \
  --work-manifest artifacts/sample-works/canonical/musicbrainz-works/<sha256>.manifest.json \
  --composer-manifest artifacts/sample-composers-a/canonical/wikidata/<sha256>.manifest.json \
  --composer-manifest artifacts/sample-composers-b/canonical/wikidata/<sha256>.manifest.json \
  --contact maintainer@example.com \
  --batch-size 50 \
  --limit 1000 \
  --json-report reports/work-composer-dependencies.json
```

WDQS에는 canonical UUID만 `VALUES ?mbid { ... }`로 전달하고 `?entity wdt:P434 ?mbid`의 정확한 결과만 사용합니다. MBID가 Wikidata QID 0개 또는 2개 이상에 대응하거나, 한 QID가 여러 MusicBrainz artist ID를 주장하면 자동 병합하지 않습니다. 이 경우 구조화 immutable review artifact와 실패 report를 남기고 exit code 1을 반환합니다.

성공 snapshot은 기존 Wikidata 인물 enrichment와 `SourceRecord` 계약을 그대로 사용합니다. 따라서 일반 파이프라인으로 legacy `composers` projection까지 이어집니다.

```bash
.venv/bin/classicmap-seed normalize \
  --run-id sample-work-composer-dependencies-20260805 \
  --manifest artifacts/sample-work-composer-dependencies-20260805/raw/wikidata/<sha256>.manifest.json \
  --limit 1000

.venv/bin/classicmap-seed resolve \
  --run-id sample-work-composer-dependencies-20260805 \
  --manifest artifacts/sample-work-composer-dependencies-20260805/normalized/wikidata/<sha256>.manifest.json \
  --limit 1000

.venv/bin/classicmap-seed export-canonical \
  --run-id sample-work-composer-dependencies-20260805 \
  --manifest artifacts/sample-work-composer-dependencies-20260805/resolved/wikidata/<sha256>.manifest.json \
  --limit 1000
```

각 WDQS batch는 immutable artifact로 남고 checkpoint는 그 manifest 경로와 처리한 MBID prefix만 보관합니다. 같은 입력과 `--limit`으로 `--resume`하면 외부 요청과 mutation이 모두 0이어야 합니다. `--dry-run`은 조회와 예상 mutation 계산만 수행하며 artifact, checkpoint, JSON report를 쓰지 않습니다.

누락 작곡가 중 공식 식별자로 해소되지 않은 항목이 있으면 원본 작품 bundle 전체를 loader에 전달하지 않습니다. 먼저 적재할 composer canonical manifest들을 명시해 발행 가능한 작품 bundle을 만듭니다.

```bash
.venv/bin/classicmap-seed prepare-publishable-works \
  --run-id sample-works-20260805 \
  --work-manifest artifacts/sample-works-20260805/canonical/musicbrainz-works/<sha256>.manifest.json \
  --composer-manifest artifacts/sample-composers-a/canonical/wikidata/<sha256>.manifest.json \
  --composer-manifest artifacts/sample-work-composer-dependencies-20260805/canonical/wikidata/<sha256>.manifest.json \
  --limit 100000 \
  --json-report reports/sample-works-publishable.json
```

이 명령은 `composers` canonical natural key가 정확히 준비된 작품만 유지합니다. 미해소 작품과 그 alias, identifier, part, relation, provenance는 함께 제외하고 `WORK_COMPOSER_UNAVAILABLE` review로 바꿉니다. 이름과 작품 제목은 연결에 사용하지 않습니다. composer manifest 사이 natural key가 중복되거나 작품에 composer FK가 정확히 하나가 아니면 전체를 거부합니다.

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

artifacts/_indexes/wikidata/<input-sha256>.scope.sqlite
```

파일명은 JSONL 본문의 SHA-256으로 결정됩니다. 이미 생성된 artifact는 덮어쓰지 않습니다. 같은 입력을 다시 실행하면 기존 artifact를 재사용하며 mutation 수는 0입니다. `_indexes`는 dump 자체를 복사한 artifact가 아니라 동일 input SHA partition들이 공유하는 bounded-memory 분류용 로컬 SQLite 파생 index입니다.

## 검증

```bash
uv run ruff check .
uv run mypy .
uv run pytest
```
