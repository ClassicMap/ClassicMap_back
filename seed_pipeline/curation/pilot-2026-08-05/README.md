# 비교 영상 파일럿 데이터

이 디렉터리는 운영 데이터베이스와 홈서버를 변경하지 않는 1차 수동 큐레이션 결과입니다. 다섯 작품마다 세 연주를 선정했으며, 임의의 데이터베이스 ID는 포함하지 않습니다.

## 파일

- `candidates.jsonl`: 작품, 작곡가, 연주자, 원본 영상, 구간, 크레딧과 검수 근거를 포함한 정규 후보입니다.
- `prewarm-template.jsonl`: 데이터베이스 적재 전 단계의 클립 선생성 템플릿입니다. `candidateKey`를 사용하므로 그대로 실행할 수 없습니다.
- `wikidata-entities.jsonl`: 후보 작곡가와 연주자의 중복 제거된 exact QID dependency 17건입니다. 이름 검색에 사용하지 않습니다.
- `wikidata-composers.jsonl`: 위 dependency에서 분리한 작곡가 exact QID 4건입니다. 작곡가 canonical manifest를 만든 뒤 MusicBrainz 작품 수집 입력으로 사용합니다.
- `musicbrainz-works.jsonl`: 후보의 `workCandidate.naturalKey`에서 중복 제거한 exact MusicBrainz work MBID 5건입니다. 이름 검색이나 작곡가 전체 작품 탐색에 사용하지 않습니다.
- `review-report.md`: 선정 기준, 출처, 검수 결과와 남은 공개 조건을 정리한 사람이 읽는 보고서입니다.
- `validate.py`: 두 JSONL의 구조와 상호 참조를 검증하고, 적재 후 실제 prewarm manifest를 생성합니다.
- `test_validate.py`: 검증기와 변환기의 회귀 테스트입니다.

## 검증

```bash
python3 seed_pipeline/curation/pilot-2026-08-05/validate.py validate \
  --candidates seed_pipeline/curation/pilot-2026-08-05/candidates.jsonl \
  --prewarm-template seed_pipeline/curation/pilot-2026-08-05/prewarm-template.jsonl

python3 seed_pipeline/curation/pilot-2026-08-05/test_validate.py
```

검증은 다음 조건을 강제합니다.

- 승인 후보가 정확히 다섯 작품, 작품별 세 연주인지 확인합니다.
- `candidateKey`와 YouTube `videoId`가 중복되지 않는지 확인합니다.
- 원본 URL, 영상 길이, 시작·끝 초, 최대 600초 제한을 확인합니다.
- 같은 작품의 후보가 동일한 `sectorKey`, 시작 큐, 끝 큐를 사용하는지 확인합니다.
- 각 영상에 primary 크레딧이 정확히 하나인지 확인합니다.
- 기존 데이터베이스의 `performanceId`, `artistId`, `pieceId`, `sectorId`를 추정하여 넣지 못하게 합니다.
- prewarm 템플릿이 승인 후보와 정확히 일치하는지 확인합니다.

## 적재 후 prewarm manifest 변환

1. staging 적재기는 `candidateKey`를 별도 provenance 또는 적재 결과 표에 보존해야 합니다.
2. 적재가 끝나면 다음 형식의 매핑 JSONL을 만듭니다.

```json
{"candidateKey":"yt:X37lU27kyPs:0:40","performanceId":123}
```

3. 권리 담당자가 후보 원본의 `rightsMode`, `rightsReviewedAt`, `rightsEvidence`와 템플릿의 `rightsCheckStatus=RIGHTS_VERIFIED`를 함께 승인합니다. 허용되는 자체 호스팅 모드는 `licensed_self_hosted`, `permission_granted`, `public_domain`뿐입니다.
4. 아래 명령은 프론트엔드 `ops/video-clips/prewarm.mjs`가 받는 승인 정보 포함 JSONL을 표준 출력으로 생성합니다. 한 건이라도 권리 검토 전이면 전체 출력을 거부합니다.

```bash
python3 seed_pipeline/curation/pilot-2026-08-05/validate.py render-prewarm \
  --candidates seed_pipeline/curation/pilot-2026-08-05/candidates.jsonl \
  --prewarm-template seed_pipeline/curation/pilot-2026-08-05/prewarm-template.jsonl \
  --id-map /path/to/staging-performance-id-map.jsonl \
  > /path/to/prewarm-manifest.jsonl
```

`candidateKey`는 `yt:{videoId}:{start}:{end}` 형식입니다. 적재 과정에서 영상 ID나 구간이 바뀌면 새 키를 만들고 기존 키를 재사용하지 않습니다. 이 템플릿은 권리 검토와 운영 승인을 대신하지 않으며, 현재 행의 `rightsCheckStatus`가 `REVIEW_REQUIRED`이므로 자동 실행 대상이 아닙니다.
