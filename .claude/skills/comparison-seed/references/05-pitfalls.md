# 막혔을 때

실제로 부딪힌 것들이다. 같은 곳에서 두 번 막히지 않게 적어 둔다.

## 작품 해소

### `UNRESOLVED_WORK_IDENTIFIER`

작곡가 QID 가 틀렸거나 작품 MBID 가 연결되지 않았다.
**QID 를 추측하지 말고 DB 에서 읽는다.** 마스네를 Q153793(실제 Q194436),
라벨을 Q781(실제 Q1178)로 적어 두 번 실패했다.

### 같은 MBID 가 `piece_parts` 에도 있음

국제 시드가 모음곡을 악장 part 로 넣어 두었고 legacy 곡이 그 낱곡을 독립된
곡으로 갖고 있으면 겹친다. 달빛·라흐마니노프 전주곡·그노시엔 1번이 그랬다.

지금은 해소 규칙이 **직접 진술을 앞세운다.** `piece_identifiers` 가 1건이면
그것으로 해소하고, 없을 때만 `piece_parts` 를 본다. 그래서 legacy 곡에 식별자를
붙이면 된다.

### 같은 MBID 가 다른 `piece_identifiers` 에 이미 있음

이건 다르다. `(namespace, external_id)` 가 유일해서 **붙일 수가 없다.**
트로이메라이가 그랬다. 그 MBID 가 piece 464 에 있어 legacy 135 에 붙지 않았고,
연주가 464 로 해소됐다.

어느 곡을 정본으로 둘지는 화면 문제라 시드에서 정하지 않는다.
**병합하려 하지 말 것.** `seed_natural_keys` 의 `target_id` 를 옮기면 다음 시드
실행이 `MANUAL_ROW_CONFLICT` 로 멈춘다. 그 예외는 composers/artists 에만 있고
pieces 에는 없다.

### 검수 항목이 남았을 때

적재 실패는 `review_queue` 에 항목을 남긴다. 문제를 고쳐 적재한 뒤 닫는다.
판정은 **"그 작품으로 실제 발행된 연주가 있는가"** 로 한다. 식별자가 붙어
있는지로 보면 달빛처럼 붙이고도 해소되지 않은 경우를 구분하지 못한다.

## 적재

| 오류 | 원인 |
|---|---|
| `DUPLICATE_RUN_ID` | dry-run 이 run-id 를 소비했다. 새로 만든다 |
| `UNKNOWN_SEED_RUN` | `load_clip_assets` 의 `--seed-run-id` 는 기존 행이어야 한다. 후보 적재 run-id 를 쓴다 |
| `OVERLAPPING_VIDEO_SPAN` | 한 영상에서 겹치는 구간을 둘 뽑았다. 겹치지 않으면 허용된다 |
| `UNSUPPORTED_CREDIT_ROLE` | `canonical_credit_role` 에 없는 역할이다. 7개 canonical role 로 줄여진다 |
| `INVALID_CREDITS` | primary 가 정확히 하나여야 한다 |
| `INVALID_SECTOR` | `targetMaxMs` 가 600,000 을 넘었다 |

## 클립

**`CACHE_DIR_READ_ERROR`** — `--cache-dir` 은 로컬 경로다. 클리퍼 파드 경로를
주면 안 된다. 클립을 `kubectl cp` 로 가져온 뒤 그 디렉터리를 준다.

**`INVALID_VERIFICATION_TIME`** — `rangeVerifiedAt` 이 `assetValidatedAt` 보다
앞섰다. 앞은 클리퍼 서버 시계, 뒤는 실행 프로세스 시계라 어긋날 수 있다.
`prewarm.mjs` 에서 자산 시각 아래로 내려가지 않게 고쳤으므로 지금은 나지 않는다.

**클립 600초 제한** — 넘는 연주는 후보에서 뺀다. `build_candidates.py` 가 경고한다.

## 영상

**하이픈으로 시작하는 ID** — `yt-dlp` 가 옵션으로 읽는다. 출력 파일명을 따로
준다. `fetch_videos.sh` 가 처리한다.

**MusicBrainz 503** — 자주 난다. 재시도를 넣고, 급하면 Wikidata SPARQL 의
P435 로 우회한다.

## 배포

**새 마이그레이션이 적용되지 않음** — `sqlx::migrate!` 는 컴파일 타임 매크로다.
`touch src/db/mod.rs` 로 재컴파일을 강제한다.

**마이그레이션이 CI 에서 실패** — 로컬에서 적용해 보고 커밋한다. 실패한 파일을
커밋하면 배포가 막힌다. UNIQUE 제약에 걸린 마이그레이션을 커밋하기 전에 지운
적이 있다.

**`chk_review_queue_status`** — 허용값은 OPEN/IN_REVIEW/APPROVED/REJECTED/
CANCELLED 다. `RESOLVED` 는 없다.

**`resolution` 컬럼** — JSON 이라 문자열을 거부한다. `JSON_OBJECT(...)` 로 쓴다.

## 오디오 수집

**`Sign in to confirm you're not a bot`** — 유튜브가 IP 를 막은 것이다. 영상을
100건 넘게 받으면 걸리고, 여러 배치를 동시에 돌리면 더 빨리 온다. 재시도로는
풀리지 않는다. **두드릴수록 길어진다.**

**클리퍼 파드를 경유한다.** IP 가 다르고 쿠키가 이미 마운트돼 있다.

```bash
export COMPARISON_FETCH_POD=$(kubectl -n homeserver get pods -o name | grep clip | head -1 | cut -d/ -f2)
./fetch_videos.sh batch.json
```

파드 안에서 받아 wav 로 바꾼 뒤 그것만 가져온다. 349초 영상이 받기 10초,
전송 0.13초였다.

**쿠키 값을 밖으로 꺼내지 않는다.** 파드 안에서 `/tmp` 로 복사해 그 자리에서
쓰고 끝낸다. 읽기 전용 마운트를 그대로 가리키면 yt-dlp 가 쿠키를 갱신하려다
`Read-only file system` 으로 죽는다.

**브라우저 쿠키를 임의로 쓰지 않는다.** `--cookies-from-browser` 는 사용자
계정 자격증명이다. 필요하면 사용자에게 받는다.

**`COOKIE_ARGS[@]: unbound variable`** — macOS 의 bash 3.2 는 `set -u` 아래에서
빈 배열 전개를 unbound 로 본다. `${배열[@]+"${배열[@]}"}` 로 쓴다. 고쳐 뒀다.

## 디스크

WAV 는 배치마다 지운다. 한 세션에서 133개가 남아 스크래치패드가 9.2GB 가 된
적이 있다. 초당 44KB 씩 쌓인다.

## 비밀

`kubectl exec <pod> -- env` 를 통째로 찍지 않는다. 클리퍼 빌드 토큰이 출력에
섞여 나온 적이 있다. 필요한 변수만 `grep` 한다.

DB 비밀번호는 명령줄에 쓰지 않는다. 파드 안에서 `$MYSQL_ROOT_PASSWORD` 를
참조하게 한다.

SQL 파일은 실행 전에 위험 구문을 확인한다.

```bash
grep -inE 'USE |DROP |TRUNCATE |DELETE |ALTER ' <파일>
```
