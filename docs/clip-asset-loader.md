# 비교영상 클립 자산 적재

`load_clip_assets`는 프런트의 `ops/video-clips/prewarm.mjs`가 만든 9필드 JSONL 번들을 검증하고 `clip_jobs`, `clip_assets`, `performances`를 한 트랜잭션으로 갱신합니다. 명령 자체는 마이그레이션을 실행하지 않으므로 먼저 서버 시작 또는 `cargo run --bin migrate`로 최신 마이그레이션을 적용해야 합니다.

## 실행 순서

먼저 쓰기 없는 검증을 실행합니다.

```bash
DATABASE_URL='mysql://...' \
CLIP_CACHE_DIR='/var/cache/classicmap-video-clips' \
CLIP_PUBLIC_BASE_URL='https://example.com/classicmap/clips' \
cargo run --bin load_clip_assets -- \
  --bundle ./seed-clips.clip-assets.jsonl \
  --seed-run-id 00000000-0000-0000-0000-000000000000 \
  --dry-run \
  --json-report ./clip-assets.dry-run.json
```

검증 보고서를 확인한 뒤 READY 적재 또는 즉시 발행을 실행합니다.

```bash
cargo run --bin load_clip_assets -- \
  --bundle ./seed-clips.clip-assets.jsonl \
  --cache-dir /var/cache/classicmap-video-clips \
  --public-base-url https://example.com/classicmap/clips \
  --seed-run-id 00000000-0000-0000-0000-000000000000 \
  --publish \
  --json-report ./clip-assets.publish.json
```

`--publish`를 생략하면 자산과 performance는 READY 상태로 남습니다. 동일한 번들을 같은 옵션으로 다시 실행했을 때 보고서의 `mutations.total`은 0이어야 합니다.

## 파일 검증 계약

- `storageKey`는 cache 디렉터리 바로 아래의 flat `.mp4` 파일명이어야 합니다.
- cache 디렉터리, MP4, FFprobe sidecar는 symlink일 수 없습니다.
- MP4는 regular file이어야 하며 실제 크기와 스트리밍 SHA-256이 번들과 일치해야 합니다.
- `{storage stem}.metadata.json` sidecar의 storage key, profile, 시작점, 길이, 크기, SHA-256, codec, 검증 시각이 번들과 일치해야 합니다.
- `publicUrl`은 허용된 외부 HTTPS base 바로 아래의 `{videoId}` 경로와 `end`, `profile`, `start` 쿼리만 사용할 수 있습니다.
- URL의 video ID와 구간은 DB performance source 및 `start_ms`/`end_ms`와 일치해야 합니다.

입력 또는 계약 오류는 exit code 2, DB 또는 발행 오류는 exit code 3을 반환합니다. 성공과 실패 모두 구조화 JSON을 출력합니다.
