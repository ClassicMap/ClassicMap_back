# 적재·발행

후보 JSONL 을 만든 뒤부터 배포까지다. 순서를 지키지 않으면 중간에 막힌다.

## 클러스터 안에서 한 번에 하는 길 (2026-09-30)

아래 1~7 단계를 노트북에서 손으로 하는 대신 **Job 하나로 돌릴 수 있다.**
포트포워딩·`cargo run`·`prewarm.mjs`·`kubectl cp`·approve 마이그레이션이 없어진다.

```bash
BATCH=comparison-a-a18-2026-09-25
git add seed_pipeline/curation/$BATCH/candidates.jsonl && git commit && git push
# CI 가 이미지를 굽는다. 후보 JSONL 이 이미지 안 /app/seed/ 로 들어간다
gh run watch <id> --exit-status

sed "s|__BATCH__|$BATCH|g" deploy/seed-publish-job.yaml | kubectl apply -f -
kubectl -n homeserver logs -f job/seed-publish-$BATCH
kubectl -n homeserver delete job seed-publish-$BATCH
```

쓰기 전에 `SEED_DRY_RUN=1` 로 한 번 돌려 볼 수 있다. 적재기에 `--dry-run` 을 주고
멈춘다. **다만 run-id 는 소비되므로** 실제 적재는 새 run-id 로 간다.

Job 이 하는 네 단계다.

| | 하는 일 | 대신하는 것 |
|---|---|---|
| 1 | `load_comparison_candidates` | 포트포워딩 + 로컬 `cargo run` |
| 2 | `build_clip_bundle` | `prewarm.mjs` + `kubectl cp` |
| 3 | `approve_seed_run` | 배치마다 쓰던 approve 마이그레이션 |
| 4 | `load_clip_assets --publish` | 포트포워딩 + 로컬 `cargo run` |

**approve 가 마이그레이션에서 빠진 까닭.** 푸시 기반이면 순서가 롤아웃 → 적재라서,
마이그레이션이 아직 없는 행을 UPDATE 해 아무 일도 하지 않고 끝난다. sqlx 는 한 번만
실행하므로 그 뒤로 영영 적용되지 않는다. 세 UPDATE 는 스키마 변경이 아니라 상태
전이라 애초에 마이그레이션에 있을 물건이 아니었다. **판단 근거는 이제 마이그레이션
주석이 아니라 배치 폴더의 `review-report.md` 에 남긴다.**

`build_clip_bundle` 은 sha256 을 다시 재지 않는다. 클리퍼가 클립을 만들면서
`<storageKey>.metadata.json` 에 이미 적어 두고, `load_clip_assets` 가 캐시의 실제
파일과 대조해 검증한다. `rangeVerifiedAt` 은 **실제로 Range 요청을 해 206 과
Content-Range 를 받은 뒤에만** 적는다.

한 건이라도 실패하면 exit 5 로 빠져 뒤 단계를 돌리지 않는다. `backoffLimit: 0` 이라
재시도도 하지 않는다 — **절반만 발행되는 것이 가장 나쁘다.**

작품 식별자 마이그레이션(아래 1단계)과 인물 등록 마이그레이션은 **그대로 남는다.**
둘 다 적재보다 먼저 있어야 하므로 롤아웃 순서가 맞다.

아래는 손으로 할 때의 차례다. Job 이 막히면 여기로 돌아온다.

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

**크레딧 역할을 적재 전에 본다.** 적재기는 악기 역할(`PIANIST` 등)을 모두 독주자로 묶는다.
가곡 반주자는 `ACCOMPANIST`, 4중주단은 `QUARTET`, 악단은 `ORCHESTRA` 여야 한다.
반주자를 `PIANIST` 로 넣은 적이 있다.

`build_candidates.py` 가 배치 정의의 `videos[]` 에서 읽는 딸림 크레딧은 넷이다.
차례는 primary → `CHOIR` → `ORCHESTRA` → `ACCOMPANIST` 다.

```json
{"videoId": "…", "artistName": "…", "wikidata": "Q…",
 "conductor":   {"name": "…", "wikidata": "Q…"},
 "choir":       {"name": "…", "wikidata": "Q…"},
 "orchestra":   {"name": "…", "wikidata": "Q…"},
 "accompanist": {"name": "…", "wikidata": "Q…"}}
```

`choir` 와 `accompanist` 는 2026-09-25 에 넣었다. 그 전에는 서브에이전트가 생성된
JSONL 에 손으로 덧붙였고, 그때 역할을 잘못 적는 일이 있었다.

적재에 실패하면 후보는 rollback 되고 `review_queue` 에만 남는다. 설계된 동작이다.
원인을 고쳐 다시 적재한 뒤, 해소된 항목은 닫는다(`05-pitfalls.md` 참고).

### 이미 발행된 연주에 크레딧을 보탤 때 (2026-09-28)

`videos[]` 의 키는 넷뿐이라(`conductor`·`choir`·`orchestra`·`accompanist`) 3중주
주자나 낱 악기 독주자를 적을 자리가 없다. 적재 전이면 생성된 JSONL 에 손으로 넣고,
**이미 발행했으면 `performance_credits` 에 직접 넣는다** — 적재기를 다시 돌리면 같은
`candidate_key` 로 중복이 생긴다.

그때 **적재기의 정규화를 손으로 맞춰야 한다.** 적재기는 역할을 여섯 갈래로 줄여 넣는다.

| 배치 정의의 roleCode | DB 의 role_code |
|---|---|
| `CONDUCTOR` | `conductor` |
| `ORCHESTRA` | `orchestra` |
| `VIOLINIST` · `CELLIST` · `PIANIST` · `FLUTIST` … | **`soloist`** |
| `SOPRANO` · `TENOR` · `VOCALIST` … | **`vocalist`** |
| `TRIO` · `QUARTET` · `ENSEMBLE` · `CHOIR` | `ensemble` |
| `ACCOMPANIST` | `accompanist` |

`FLUTIST` 로 넣었다가 이 표에서 유일하게 튀는 값이 됐다. 넣은 뒤
**`SELECT role_code, COUNT(*) FROM performance_credits GROUP BY role_code` 로
이탈 값이 없는지 본다.**

`display_order` 도 직접 밀어야 한다. 사이에 끼우면 뒤엣것을 먼저 옮긴다 —
플루트를 1번에 넣으려면 이미 1번인 `orchestra` 를 2번으로 보낸다.

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

**`--concurrency` 는 기본값 1 로 둔다.** 파드 메모리 한도가 640Mi 라 서로 다른 영상
둘의 원본을 동시에 받으면 OOMKilled 로 죽는다(쇤베르크 배치에서 2 로 돌려 두 건이
`fetch failed` 로 실패했다). 같은 영상의 구간끼리는 원본을 한 번만 받으므로 1 이어도 빠르다.
파드가 재시작되면 yt-dlp 챌린지 캐시와 `/tmp` 가 비지만 수집·클립 모두 알아서 다시 받는다.

클리퍼는 같은 영상의 원본을 **한 번만** 받아 `sources/` 에 두고(24시간) 로컬에서 자른다.
구간마다 스트림을 받던 때는 실시간의 1.2~1.6배로만 내려와 45분 영상의 네 구간에 6분이
넘게 걸렸다. 지금은 원본 45분이 수십 초, 그 뒤 구간은 0.1~0.2초다. 그러니 **같은 영상의
구간은 한 매니페스트에 모아** 보내는 게 좋다. 예전 방식으로 돌리려면 클리퍼에
`CLIP_SOURCE_CACHE=off` 를 준다.

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
