# 음량 곡선 측정 2026-10-01

공개된 클립 전부의 음량 곡선을 잰 기록이다. 결과는 `loudness-profiles.jsonl` 이고,
`load_loudness_profiles` 가 `clip_loudness_profiles` 에 넣는다.

## 재는 방식 (`ebur128-short-v1`)

- `scripts/measure_loudness.py`. 클리퍼 이미지(ffmpeg 8)로 클립 캐시를 읽기 전용으로 붙여 잰다
- ffmpeg `ebur128` 의 단기 음량(3초 창)을 0.5초 간격으로 뽑는다. 단기 음량은 창이 끝나는
  시각에 찍히므로 1.5초 당겨 창 가운데에 둔다. 창이 차지 않은 처음 1.5초는 처음 잰 값으로 채운다
- 가장 센 곳을 0dB 로 둔 상대값이다. 바닥은 -60dB
- 처음 5초 평균, 가장 센 곳 위치(시점·진행률), 곡선 폭(90분위 - 10분위)을 같이 남긴다
- 재기 전에 파일의 sha256 을 `clip_assets.sha256` 과 맞춘다

## 차례

1. 측정할 클립 목록을 만든다(읽기만 한다)

   ```sql
   SELECT JSON_OBJECT('clipAssetId', clip.id,
     'storageKey', CONCAT(CAST(source.provider_video_id AS CHAR), '-', p.start_ms, '-',
                          p.end_ms - p.start_ms, '-', clip.encoding_profile_version, '.mp4'),
     'sha256', clip.sha256, 'durationMs', clip.duration_ms,
     'performanceId', p.id, 'sectorId', p.sector_id)
   FROM clip_assets clip
   JOIN performances p ON p.id = clip.performance_id
   JOIN performance_sources source ON source.id = p.performance_source_id
   WHERE clip.is_current = TRUE AND clip.status IN ('READY', 'PUBLISHED')
     AND clip.public_url IS NOT NULL AND clip.public_url <> ''
     AND p.publish_status = 'PUBLISHED'
   ORDER BY clip.id;
   ```

   캐시 파일 이름은 `{영상 id}-{시작 ms}-{길이 ms}-{인코딩 판}.mp4` 다.

2. `deploy/loudness-measure-job.yaml` 로 잰다. 결과는 Job 로그의 `{` 로 시작하는 줄이다
3. 결과를 이 디렉터리의 `loudness-profiles.jsonl` 로 커밋하고 배포한다(이미지의 `/app/seed/` 로 들어간다)
4. `deploy/loudness-load-job.yaml` 로 dry-run → 적재 → dry-run(계획 변경 0) 순으로 넣는다
