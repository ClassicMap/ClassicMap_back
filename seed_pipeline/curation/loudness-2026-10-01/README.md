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

## 결과 (2026-10-01)

- 공개 클립 680개 전부 잼(실패 0). Job 6분 42초
- 곡선 폭(90분위 - 10분위): 10분위 7.6dB, 중앙값 14.3dB, 90분위 23.1dB, 최대 58.0dB
- 2dB 미만(평평함)은 1개뿐이다. 라 캄파넬라 종결의 드미트리 시시킨(1.7dB)
- 가장 센 곳이 끝 10% 안에 있는 클립 133개, 처음 10% 안에 있는 클립 37개

### 기획 값과 견준 라 캄파넬라 종결 (구간 37)

| 연주 | 기획(1초 RMS) | 이 측정(단기 음량) |
|---|---|---|
| 예브게니 키신 | 가장 센 곳 0:03, 처음 5초 −1.6dB | 15.5초(67%), −0.7dB, 폭 2.9dB |
| 랑랑 | 가장 센 곳 0:20, 처음 5초 −4.3dB | 19.0초(79%), −2.9dB, 폭 3.5dB |
| 드미트리 시시킨 | 거의 평평(폭 1.1dB) | 폭 1.7dB, 평평함 |

랑랑과 시시킨은 맞는다. 키신은 청감 보정을 하면 처음부터 끝 근처까지 최고점에서
1dB 안쪽인 고원이라, 0:03 과 0:15 의 차이가 0.5dB 도 안 된다(1초 창, 0.4초 창으로
재도 같다). 기획의 0:03 은 보정 없는 1초 RMS 에서 나온 값이다. "처음부터 셈" 은
처음 5초 값(키신 −0.7dB, 랑랑 −2.9dB)으로 드러난다.
