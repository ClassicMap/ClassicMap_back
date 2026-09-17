# 적재·발행

후보 JSONL 을 만든 뒤부터 배포까지다. 순서를 지키지 않으면 중간에 막힌다.

## 준비

DB 는 포트포워딩으로 붙는다. `.env` 의 `DATABASE_URL` 은 외부 주소라 막혀 있다.

```bash
kubectl -n homeserver port-forward svc/classicmap-mysql 13306:3306 &
kubectl -n homeserver port-forward svc/clipper 13200:3200 &

set -a; . ./.env; set +a
export DATABASE_URL=$(printf '%s' "$DATABASE_URL" \
  | sed 's|@61.253.113.42:3307/|@127.0.0.1:13306/|')
```

DB 를 직접 볼 때는 `kubectl exec` 로 붙는다. 비밀번호를 명령줄에 쓰지 않는다.

```bash
kubectl -n homeserver exec -i classicmap-mysql-0 -- sh -c \
  'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" classicmap -N --batch \
   --default-character-set=utf8mb4'
```

## 1. 작품 식별자 마이그레이션

적재기는 작품을 `piece_identifiers.musicbrainz_work` 로 해소한다. **적재 전에**
연결해야 한다. `INSERT ... WHERE NOT EXISTS` 로 멱등하게 쓴다.

마이그레이션을 쓴 뒤 DB 에 직접 적용한다. 나중에 배포될 때 앱이 다시 실행해도
멱등하므로 문제없다.

## 2. 후보 적재

```bash
RUN_ID=$(python3 -c "import uuid;print(uuid.uuid4())")
cargo run --quiet --bin load_comparison_candidates -- \
  --bundle <batchId>-candidates.jsonl --run-id "$RUN_ID" \
  --json-report <batchId>-load.json
```

**dry-run 은 run-id 를 소비한다.** dry-run 을 돌렸으면 실제 적재는 새 run-id 로
한다. 같은 것을 쓰면 `DUPLICATE_RUN_ID` 가 난다.

적재에 실패하면 후보는 rollback 되고 `review_queue` 에만 남는다. 설계된 동작이다.
원인을 고쳐 다시 적재한 뒤, 해소된 항목은 닫는다(`05-pitfalls.md` 참고).

## 3. 발행 마이그레이션

세 가지를 올린다. 기존 마이그레이션(`202608050030` 등)을 본떠 쓴다.

```
performance_sources.rights_mode   unknown → licensed_self_hosted
performance_sectors.editorial_status  FACTS_VERIFIED → EDITOR_REVIEWED
performance_candidates.candidate_status  REVIEW_REQUIRED → APPROVED
```

**주석에 판단 근거를 남긴다.** 정렬 비용 범위, 교체한 연주와 그 이유,
막힌 것이 있으면 무엇이 왜 막혔는지. 나중에 이 기록이 판단의 근거가 된다.

**권리 경고를 반드시 넣는다.** `licensed_self_hosted` 는 내부 검증 표기일 뿐
실제 이용 허락을 받은 것이 아니다.

## 4. 클립 선생성

적재된 `performance_id` 를 DB 에서 읽어 매니페스트를 만든다.

```sql
SELECT p.id, s.provider_video_id, ROUND(p.start_ms/1000), ROUND(p.end_ms/1000)
FROM clip_jobs j
JOIN performances p ON p.id = j.performance_id
JOIN performance_sources s ON s.id = p.performance_source_id
WHERE j.seed_run_id = '<RUN_ID>' ORDER BY p.id;
```

```bash
python3 build_prewarm.py batch.json <migration-id> 201:xN-JCdM4or0:5:184 ...

cd ClassicMap_front
VIDEO_CLIP_BUILD_TOKEN="$TOKEN" node ops/video-clips/prewarm.mjs \
  --manifest <batchId>-prewarm.jsonl --base-url http://127.0.0.1:13200 \
  --public-base-url https://kang1027.com/classicmap/clips \
  --encoding-profile-version v1-copy \
  --report <batchId>-prewarm-report.json \
  --bundle <batchId>-clip-assets.jsonl
```

## 5. 클립을 로컬로 가져온다

`load_clip_assets` 의 `--cache-dir` 은 **로컬 경로**다. 클리퍼 파드의 경로를
주면 읽지 못한다. 만들어진 클립을 복사해 온다.

```bash
POD=$(kubectl -n homeserver get pods --no-headers \
      -o custom-columns=":metadata.name" | grep '^clipper-')
for key in $(python3 -c "
import json
for line in open('<batchId>-clip-assets.jsonl'):
    print(json.loads(line)['storageKey'])"); do
  base=${key%.mp4}
  for f in "$key" "$base.metadata.json"; do
    kubectl -n homeserver cp \
      "homeserver/$POD:/var/cache/classicmap-video-clips/$f" "$CACHE/$f"
  done
done
```

## 6. 자산 등록과 발행

```bash
cargo run --quiet --bin load_clip_assets -- \
  --bundle <batchId>-clip-assets.jsonl \
  --public-base-url https://kang1027.com/classicmap/clips \
  --cache-dir "$CACHE" --seed-run-id "$RUN_ID" --publish \
  --json-report <batchId>-clip-publish.json
```

`--publish` 가 같은 트랜잭션에서 발행까지 한다. 클립을 만들지 않은 연주는
발행되지 않고 남는다. **의도적으로 보류할 때 이것을 쓴다.**

## 7. 커밋과 배포

마이그레이션을 새로 추가했으면 `src/db/mod.rs` 를 touch 한다.
`sqlx::migrate!` 가 컴파일 타임 매크로라 건드리지 않으면 새 파일을 보지 못한다.

```bash
touch src/db/mod.rs
git add migrations/... seed_pipeline/curation/... src/db/mod.rs
git commit   # 한국어로, 판단 근거를 담아
git push
gh run list --limit 1            # CI 통과 확인
kubectl -n homeserver rollout restart deploy/classicmap-back
```

## 8. 검수 보고서

`seed_pipeline/curation/comparison-<batchId>-<날짜>/` 에 남긴다.

- `candidates.jsonl` — 적재한 것
- `review-report.md` — 무엇을 왜 넣고 왜 뺐는지
- `held-*.json` — 보류한 것이 있으면

보고서에는 **정렬 비용 표**와 **교체·보류 사유**를 반드시 적는다.
숫자만 적지 말고 그 숫자를 어떻게 읽었는지 적는다.

## 확인

```sql
SELECT '발행 연주', COUNT(*) FROM performances WHERE publish_status='PUBLISHED'
UNION ALL SELECT '미발행', COUNT(*) FROM performances
  WHERE publish_status<>'PUBLISHED' AND seed_run_id IS NOT NULL
UNION ALL SELECT '비교 가능 구간', COUNT(*) FROM (
  SELECT sector_id FROM performances WHERE publish_status='PUBLISHED'
  GROUP BY sector_id HAVING COUNT(*)>=2) s
UNION ALL SELECT '검수 큐 OPEN', COUNT(*) FROM review_queue WHERE status='OPEN';
```

크레딧까지 보려면 비교 전용 엔드포인트를 쓴다. `/pieces/{id}/performances` 는
레거시 형식이라 크레딧이 없다.

```
https://api.kang1027.com/classicmap/api/artists/{artistId}/comparison-performances
```
