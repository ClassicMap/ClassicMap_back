#!/bin/sh
# 배치 하나를 적재하고 클립을 만들어 발행한다. 클러스터 안에서 도는 것을 전제한다.
#
#   seed_publish.sh <batchDir>
#
# <batchDir> 는 candidates.jsonl 이 든 디렉터리다. 이미지 안에서는
# /app/seed/comparison-<batchId>-<날짜>/ 에 있다.
#
# 노트북에서 하던 다섯 단계를 대신한다 — 포트포워딩, cargo 로컬 실행,
# prewarm.mjs, kubectl cp, approve 마이그레이션.
#
# 환경변수
#   DATABASE_URL              DB 주소. 없으면 MYSQL_HOST·MYSQL_PASSWORD 부품으로 짓는다
#   VIDEO_CLIP_BUILD_TOKEN    (필수) 클리퍼 빌드 토큰. 값은 찍지 않는다
#   CLIP_PUBLIC_BASE_URL      (필수) 공개 클립 주소
#   CLIP_BASE_URL             기본 http://clipper:3200
#   CLIP_CACHE_DIR            기본 /var/cache/classicmap-video-clips
#   SEED_RUN_ID               주면 그 id 로 적재한다. 없으면 새로 만든다
#   SEED_DRY_RUN=1            적재까지만 하고 발행하지 않는다
set -eu

batch_dir=${1:-}
if [ -z "$batch_dir" ]; then
    echo "사용법: seed_publish.sh <batchDir>" >&2
    exit 2
fi

bundle="$batch_dir/candidates.jsonl"
if [ ! -f "$bundle" ]; then
    echo "candidates.jsonl 이 없음: $bundle" >&2
    exit 2
fi

# DB 주소는 DATABASE_URL 로 직접 받거나, MYSQL_HOST·MYSQL_PASSWORD 부품으로 받는다.
# 부품일 때는 src/db/mod.rs 가 퍼센트 인코딩해 주소를 짓는다 — 셸에서 조립하면
# 비밀번호의 URL 예약 문자에 취약하다.
if [ -z "${DATABASE_URL:-}" ] && { [ -z "${MYSQL_HOST:-}" ] || [ -z "${MYSQL_PASSWORD:-}" ]; }; then
    echo "DATABASE_URL 또는 MYSQL_HOST·MYSQL_PASSWORD 가 필요함" >&2
    exit 2
fi
: "${VIDEO_CLIP_BUILD_TOKEN:?VIDEO_CLIP_BUILD_TOKEN 이 필요함}"
: "${CLIP_PUBLIC_BASE_URL:?CLIP_PUBLIC_BASE_URL 이 필요함}"
CLIP_BASE_URL=${CLIP_BASE_URL:-http://clipper:3200}
CLIP_CACHE_DIR=${CLIP_CACHE_DIR:-/var/cache/classicmap-video-clips}

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

batch_id=$(basename "$batch_dir")
run_id=${SEED_RUN_ID:-$(cat /proc/sys/kernel/random/uuid)}
echo "■ $batch_id  run-id=$run_id  ($(wc -l < "$bundle") 건)"

# 1. 후보 적재. 실패하면 rollback 되고 review_queue 에만 남는다 — 설계된 동작이다.
#
# SEED_DRY_RUN=1 이면 적재기에 --dry-run 을 주고 멈춘다. 아무것도 쓰지 않는다.
# 다만 **run-id 는 소비된다** — 실제 적재는 새 run-id 로 해야 한다.
if [ "${SEED_DRY_RUN:-0}" = "1" ]; then
    echo "1/1 후보 적재 (dry-run, 쓰지 않음)"
    /app/load_comparison_candidates \
        --bundle "$bundle" \
        --run-id "$run_id" \
        --dry-run \
        --json-report "$work/load.json"
    echo "SEED_DRY_RUN=1 이라 여기서 멈춘다. 이 run-id 는 소비됐다: $run_id"
    exit 0
fi

echo "1/4 후보 적재"
/app/load_comparison_candidates \
    --bundle "$bundle" \
    --run-id "$run_id" \
    --json-report "$work/load.json"

# 2. 클립 생성. 한 건이라도 실패하면 exit 5 로 빠져 뒤 단계를 돌리지 않는다.
echo "2/4 클립 생성"
/app/build_clip_bundle \
    --run-id "$run_id" \
    --out "$work/clip-assets.jsonl" \
    --clipper-base-url "$CLIP_BASE_URL" \
    --public-base-url "$CLIP_PUBLIC_BASE_URL" \
    --cache-dir "$CLIP_CACHE_DIR" \
    --json-report "$work/prewarm-report.json"

# 3. 발행 직전 상태로 올린다. 배치마다 쓰던 approve 마이그레이션을 대신한다.
echo "3/4 승인"
/app/approve_seed_run --run-id "$run_id" --json-report "$work/approve.json"

# 4. 자산 등록과 발행. 같은 트랜잭션에서 발행까지 한다.
echo "4/4 자산 등록과 발행"
/app/load_clip_assets \
    --bundle "$work/clip-assets.jsonl" \
    --public-base-url "$CLIP_PUBLIC_BASE_URL" \
    --cache-dir "$CLIP_CACHE_DIR" \
    --seed-run-id "$run_id" \
    --publish \
    --json-report "$work/clip-publish.json"

echo "■ $batch_id 끝. run-id=$run_id"
echo "산출물을 저장소에 남기려면 아래를 큐레이션 디렉터리에 복사한다."
for name in load.json prewarm-report.json approve.json clip-publish.json; do
    [ -f "$work/$name" ] && echo "--- $name" && cat "$work/$name"
done
