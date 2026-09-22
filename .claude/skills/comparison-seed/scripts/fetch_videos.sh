#!/bin/bash
# 배치의 영상 오디오와 메타데이터를 받는다.
#
#   COMPARISON_WORK_DIR=... ./fetch_videos.sh batch.json
#
# yt-dlp 와 ffmpeg 이 PATH 에 있어야 한다. 쿠키가 필요하면 YT_COOKIES 를 준다.
# 하이픈으로 시작하는 영상 ID 는 yt-dlp 가 옵션으로 읽으므로 출력 이름을 따로 준다.
# 쿠키 배열은 ${배열[@]+"${배열[@]}"} 로 전개한다. macOS 의 bash 3.2 는 set -u
# 아래에서 빈 배열 전개를 unbound variable 로 보고 죽는다.
# 루프 안의 명령에는 </dev/null 을 붙인다. 붙이지 않으면 yt-dlp 가 루프의
# stdin 을 먹어 다음 영상 ID 의 첫 글자가 잘린다.
#
# yt-dlp 에는 --remote-components ejs:github 를 준다. 유튜브는 스트림 주소를 JS 챌린지로
# 가리는데 푸는 스크립트는 yt-dlp 에 들어 있지 않고 처음 한 번 받아 캐시에 둔다. 캐시가
# 비면 "Requested format is not available" 로 죽는다. 파드는 재시작하면 캐시가 사라진다.
#
# 로컬 IP 가 "Sign in to confirm you're not a bot" 으로 막히면 파드를 경유한다.
#
#   COMPARISON_FETCH_POD=clipper-xxxxx ./fetch_videos.sh batch.json
#
# 파드 안에서 받아 wav 로 바꾼 뒤 그것만 가져온다. 쿠키는 파드에 이미 마운트된
# 것을 그 자리에서 쓰고 값을 밖으로 꺼내지 않는다. yt-dlp 가 쿠키 파일에 쓰기를
# 시도하므로 읽기 전용 마운트를 그대로 가리키면 죽는다. /tmp 로 복사해 쓴다.
set -u
BATCH="${1:?배치 정의 파일이 필요함}"
WORK="${COMPARISON_WORK_DIR:?COMPARISON_WORK_DIR 이 필요함}"
COOKIE_ARGS=()
[ -n "${YT_COOKIES:-}" ] && COOKIE_ARGS=(--cookies "$YT_COOKIES")

POD="${COMPARISON_FETCH_POD:-}"
NS="${COMPARISON_FETCH_NS:-homeserver}"
POD_COOKIES="${COMPARISON_POD_COOKIES:-/etc/clipper/youtube/cookies.txt}"
POD_WORK=/tmp/comparison-fetch
# 영상 사이에 쉰다. 파드는 운영 클리퍼라 몰아서 부르면 운영 IP 까지 봇 차단에 걸린다.
DELAY="${COMPARISON_FETCH_DELAY:-20}"

BATCH_ID=$(python3 -c "import json,sys;print(json.load(open(sys.argv[1]))['batchId'])" "$BATCH")
META="$WORK/$BATCH_ID-videometa.txt"
META_FMT='%(id)s|%(duration)s|%(channel)s|%(upload_date)s|%(availability)s|%(live_status)s|%(title)s'
mkdir -p "$WORK"
: > "$META"

if [ -n "$POD" ]; then
  # 읽기 전용 마운트를 쓰기 가능한 곳으로 옮겨 둔다. 파드 안에서만 존재한다.
  kubectl -n "$NS" exec -i "$POD" -- sh -s "$POD_WORK" "$POD_COOKIES" >/dev/null 2>&1 <<'EOS' || { echo "파드 준비 실패: $POD"; exit 1; }
work=$1; mounted=$2
mkdir -p "$work"
[ -f "$work/cookies.txt" ] || { cp "$mounted" "$work/cookies.txt"; chmod 600 "$work/cookies.txt"; }
EOS
fi

# 영상 ID 는 셸 문자열에 넣지 않는다. 배치 정의는 자동으로 채워지므로
# 그 값을 그대로 보간하면 파드 안에서 임의 명령이 된다. 먼저 글자를 검사하고,
# 파드에는 stdin 으로 스크립트를 주고 ID 는 인자로 넘긴다.
valid_id() {
  case "$1" in
    ""|*[!A-Za-z0-9_-]*) return 1 ;;
    *) return 0 ;;
  esac
}

# 받은 wav 가 영상 길이와 맞는지 본다. 파드에서 kubectl exec cat 으로 옮기다
# 전송이 끊기면 비어 있지 않은 채로 잘린다(2160초 영상이 1956초로 온 적이 있다).
# 22050Hz 모노 16비트라 초당 44100바이트다. 기대 길이를 모르면 검사하지 않는다.
wav_matches() {
  local path="$1" expected="$2" size seconds diff
  case "$expected" in ""|*[!0-9]*) return 0 ;; esac
  [ -s "$path" ] || return 1
  size=$(stat -f %z "$path" 2>/dev/null || stat -c %s "$path")
  seconds=$(( (size - 44) / 44100 ))
  diff=$(( seconds - expected )); [ "$diff" -lt 0 ] && diff=$(( -diff ))
  [ "$diff" -le 2 ]
}

fetch_one() {
  local vid="$1" out="$2" expected="$3"
  valid_id "$vid" || { echo "영상 ID 에 쓸 수 없는 글자: $vid"; return 1; }
  valid_id "$out" || { echo "출력 이름에 쓸 수 없는 글자: $out"; return 1; }
  if [ -n "$POD" ]; then
    kubectl -n "$NS" exec -i "$POD" -- sh -s "$vid" "$out" "$POD_WORK" >/dev/null 2>&1 <<'EOS' || return 1
set -e
vid=$1; out=$2; work=$3
yt-dlp --remote-components ejs:github --cookies "$work/cookies.txt" -f bestaudio --no-warnings   -o "$work/$out.%(ext)s" "https://www.youtube.com/watch?v=$vid" >/dev/null 2>&1
src=$(ls "$work/$out".m4a "$work/$out".webm "$work/$out".opus 2>/dev/null | head -1)
[ -n "$src" ] || exit 3
ffmpeg -y -loglevel error -i "$src" -ac 1 -ar 22050 "$work/$vid.wav"
rm -f "$src"
EOS
    # 옮기다 끊기면 한 번만 다시 옮긴다. 파드 쪽 wav 는 검사가 끝난 뒤 지운다.
    local attempt
    for attempt in 1 2; do
      kubectl -n "$NS" exec "$POD" -- cat "$POD_WORK/$vid.wav" > "$WORK/$vid.wav" 2>/dev/null
      wav_matches "$WORK/$vid.wav" "$expected" && break
      echo "$vid 전송이 잘림 ($attempt 회째)"
      [ "$attempt" = 2 ] && rm -f "$WORK/$vid.wav"
    done
    kubectl -n "$NS" exec "$POD" -- rm -f "$POD_WORK/$vid.wav" >/dev/null 2>&1
    [ -s "$WORK/$vid.wav" ] || return 1
  else
    yt-dlp --remote-components ejs:github ${COOKIE_ARGS[@]+"${COOKIE_ARGS[@]}"} -f bestaudio --no-warnings \
      -o "$WORK/$out.%(ext)s" "https://www.youtube.com/watch?v=$vid" \
      >/dev/null 2>&1 </dev/null
    local src
    src=$(ls "$WORK/$out".m4a "$WORK/$out".webm "$WORK/$out".opus 2>/dev/null | head -1)
    [ -n "$src" ] || return 1
    ffmpeg -y -loglevel error -i "$src" -ac 1 -ar 22050 "$WORK/$vid.wav" </dev/null
    rm -f "$src"
    wav_matches "$WORK/$vid.wav" "$expected" || { rm -f "$WORK/$vid.wav"; return 1; }
  fi
}

fetch_meta() {
  local vid="$1"
  valid_id "$vid" || return 1
  if [ -n "$POD" ]; then
    kubectl -n "$NS" exec -i "$POD" -- sh -s "$vid" "$POD_WORK" "$META_FMT" <<'EOS'
vid=$1; work=$2; fmt=$3
yt-dlp --remote-components ejs:github --cookies "$work/cookies.txt" --no-warnings --skip-download \
  --print "$fmt" "https://www.youtube.com/watch?v=$vid" 2>/dev/null
EOS
  else
    yt-dlp --remote-components ejs:github ${COOKIE_ARGS[@]+"${COOKIE_ARGS[@]}"} --no-warnings --skip-download \
      --print "$META_FMT" "https://www.youtube.com/watch?v=$vid" 2>/dev/null </dev/null
  fi
}

python3 -c "
import json, sys
batch = json.load(open(sys.argv[1]))
for piece in batch['pieces']:
    for video in piece['videos']:
        print(video['videoId'])
" "$BATCH" | while read -r vid; do
  out="$vid"
  case "$vid" in -*) out="dash-${vid#-}" ;; esac
  meta_line=$(fetch_meta "$vid")
  expected=$(printf '%s' "$meta_line" | cut -d'|' -f2)
  # 예전에 잘린 채 남은 wav 를 그대로 쓰지 않는다.
  if [ -f "$WORK/$vid.wav" ] && ! wav_matches "$WORK/$vid.wav" "$expected"; then
    echo "$vid 기존 wav 길이가 맞지 않아 다시 받음"
    rm -f "$WORK/$vid.wav" "$WORK/$vid".*.npy
  fi
  if [ ! -f "$WORK/$vid.wav" ]; then
    if ! fetch_one "$vid" "$out" "$expected"; then
      echo "$vid 내려받기 실패"
      continue
    fi
  fi
  [ -n "$meta_line" ] && printf '%s\n' "$meta_line" >> "$META"
  echo "$vid ok"
  sleep "$DELAY"
done

echo "메타 → $META"
