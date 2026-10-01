-- 라 캄파넬라 종결 클라이맥스(작품 140, 구간 coda)의 첫 연주 노트와 추천 비교.
-- 들어 본 감상과 클립 음량 실측이 같은 쪽을 가리켜 확정했다(기획 artifact "ClassicMap 듣기 노트").
-- 연주 id 는 DB 마다 다르므로 영상과 구간 경계로 찾는다. 들을 곳은 원본 영상 시각이다.
-- 드미트리 시시킨 연주는 곡선 폭이 1.1dB 라 근거가 없어 노트를 두지 않는다.

INSERT INTO performance_listening_notes
    (performance_id, headline, note, moments, facts, evidence, editorial_status, reviewed_at)
SELECT performance.id,
       '처음부터 천둥처럼',
       '시작하자마자 가장 큰 소리가 나오고, 끝날 때까지 세기가 거의 떨어지지 않아요. 숨 돌릴 틈 없이 한 덩어리로 밀어붙여요.',
       JSON_ARRAY(JSON_OBJECT('atMs', performance.start_ms + 2600, 'label', '시작하자마자 정점')),
       JSON_ARRAY(),
       JSON_ARRAY(
           JSON_OBJECT('kind', 'measured', 'key', 'peakRatio', 'value', 0.11),
           JSON_OBJECT('kind', 'measured', 'key', 'startRelDb', 'value', -1.6),
           JSON_OBJECT('kind', 'listening', 'status', 'done')
       ),
       'PUBLISHED',
       CURRENT_TIMESTAMP(6)
FROM performances performance
JOIN performance_sectors sector ON sector.id = performance.sector_id
JOIN performance_sources source ON source.id = performance.performance_source_id
WHERE sector.piece_id = 140
  AND sector.sector_key = 'coda'
  AND source.provider_video_id = '0FbQZCsYXVg'
  AND performance.start_ms = 236000
  AND performance.end_ms = 259000
  AND NOT EXISTS (
      SELECT 1 FROM performance_listening_notes existing
      WHERE existing.performance_id = performance.id
  );

INSERT INTO performance_listening_notes
    (performance_id, headline, note, moments, facts, evidence, editorial_status, reviewed_at)
SELECT performance.id,
       '참았다가 폭풍처럼',
       '처음 몇 초는 힘을 아끼고 조금씩 쌓아 올려요. 가장 큰 소리는 끝나기 4초 전에 터져요. 크레센도가 어디서 시작되는지 따라가 보세요.',
       JSON_ARRAY(JSON_OBJECT('atMs', performance.start_ms + 19900, 'label', '여기서 터져요')),
       JSON_ARRAY(),
       JSON_ARRAY(
           JSON_OBJECT('kind', 'measured', 'key', 'peakRatio', 'value', 0.83),
           JSON_OBJECT('kind', 'measured', 'key', 'startRelDb', 'value', -4.3),
           JSON_OBJECT('kind', 'listening', 'status', 'done')
       ),
       'PUBLISHED',
       CURRENT_TIMESTAMP(6)
FROM performances performance
JOIN performance_sectors sector ON sector.id = performance.sector_id
JOIN performance_sources source ON source.id = performance.performance_source_id
WHERE sector.piece_id = 140
  AND sector.sector_key = 'coda'
  AND source.provider_video_id = 'cIxGUAnj46U'
  AND performance.start_ms = 243000
  AND performance.end_ms = 267000
  AND NOT EXISTS (
      SELECT 1 FROM performance_listening_notes existing
      WHERE existing.performance_id = performance.id
  );

INSERT INTO sector_featured_pairs
    (sector_id, performance_a_id, performance_b_id, title, note, moments, editorial_status, reviewed_at)
SELECT sector.id,
       kissin.id,
       lang.id,
       '쏟아내기 vs 쌓아 올리기',
       '같은 20여 초를 정반대로 설계했어요. 키신은 시작하자마자 정점에 올라 끝까지 버티고, 랑랑은 힘을 아꼈다가 끝나기 4초 전에 터뜨려요. 두 곳을 번갈아 들어 보세요.',
       JSON_ARRAY(
           JSON_OBJECT('performanceId', kissin.id, 'atMs', kissin.start_ms + 2600, 'label', '키신의 정점'),
           JSON_OBJECT('performanceId', lang.id, 'atMs', lang.start_ms + 19900, 'label', '랑랑의 정점')
       ),
       'PUBLISHED',
       CURRENT_TIMESTAMP(6)
FROM performance_sectors sector
JOIN performances kissin ON kissin.sector_id = sector.id
JOIN performance_sources kissin_source ON kissin_source.id = kissin.performance_source_id
JOIN performances lang ON lang.sector_id = sector.id
JOIN performance_sources lang_source ON lang_source.id = lang.performance_source_id
WHERE sector.piece_id = 140
  AND sector.sector_key = 'coda'
  AND kissin_source.provider_video_id = '0FbQZCsYXVg'
  AND kissin.start_ms = 236000
  AND kissin.end_ms = 259000
  AND lang_source.provider_video_id = 'cIxGUAnj46U'
  AND lang.start_ms = 243000
  AND lang.end_ms = 267000
  AND NOT EXISTS (
      SELECT 1 FROM sector_featured_pairs existing
      WHERE existing.sector_id = sector.id
  );
