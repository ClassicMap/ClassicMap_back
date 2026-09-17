#!/bin/bash
# 배치의 영상 오디오와 메타데이터를 받는다.
#
#   COMPARISON_WORK_DIR=... ./fetch_videos.sh batch.json
#
# yt-dlp 와 ffmpeg 이 PATH 에 있어야 한다. 쿠키가 필요하면 YT_COOKIES 를 준다.
# 하이픈으로 시작하는 영상 ID 는 yt-dlp 가 옵션으로 읽으므로 출력 이름을 따로 준다.
# 루프 안의 명령에는 </dev/null 을 붙인다. 붙이지 않으면 yt-dlp 가 루프의
# stdin 을 먹어 다음 영상 ID 의 첫 글자가 잘린다.
set -u
BATCH="${1:?배치 정의 파일이 필요함}"
WORK="${COMPARISON_WORK_DIR:?COMPARISON_WORK_DIR 이 필요함}"
COOKIE_ARGS=()
[ -n "${YT_COOKIES:-}" ] && COOKIE_ARGS=(--cookies "$YT_COOKIES")

BATCH_ID=$(python3 -c "import json,sys;print(json.load(open(sys.argv[1]))['batchId'])" "$BATCH")
META="$WORK/$BATCH_ID-videometa.txt"
mkdir -p "$WORK"
: > "$META"

python3 -c "
import json, sys
batch = json.load(open(sys.argv[1]))
for piece in batch['pieces']:
    for video in piece['videos']:
        print(video['videoId'])
" "$BATCH" | while read -r vid; do
  out="$vid"
  case "$vid" in -*) out="dash-${vid#-}" ;; esac
  if [ ! -f "$WORK/$vid.wav" ]; then
    yt-dlp "${COOKIE_ARGS[@]}" -f bestaudio --no-warnings \
      -o "$WORK/$out.%(ext)s" "https://www.youtube.com/watch?v=$vid" \
      >/dev/null 2>&1 </dev/null
    src=$(ls "$WORK/$out".m4a "$WORK/$out".webm "$WORK/$out".opus 2>/dev/null | head -1)
    if [ -z "$src" ]; then
      echo "$vid 내려받기 실패"
      continue
    fi
    ffmpeg -y -loglevel error -i "$src" -ac 1 -ar 22050 "$WORK/$vid.wav" </dev/null
  fi
  yt-dlp "${COOKIE_ARGS[@]}" --no-warnings --skip-download \
    --print "%(id)s|%(duration)s|%(channel)s|%(upload_date)s|%(availability)s|%(live_status)s|%(title)s" \
    "https://www.youtube.com/watch?v=$vid" 2>/dev/null </dev/null >> "$META"
  echo "$vid ok"
done

echo "메타 → $META"
