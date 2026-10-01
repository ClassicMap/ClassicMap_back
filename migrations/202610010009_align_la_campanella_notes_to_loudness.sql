-- 라 캄파넬라 종결(작품 140, 구간 coda) 연주 노트와 추천 비교를 잰 음량 곡선에 맞춘다.
-- 키신 곡선은 처음부터 끝 근처까지 최고점 1dB 안쪽 고원이라 0:03 을 '정점'이라 부르지
-- 않는다. 랑랑의 가장 센 곳은 잰 값으로 0:19(클립 기준 19000ms)다.
-- 옛 문구와 옛 들을 곳이 정확히 같을 때만 바꾼다. 연주는 영상과 구간 경계로 찾는다.

UPDATE performance_listening_notes note
JOIN performances performance ON performance.id = note.performance_id
JOIN performance_sectors sector ON sector.id = performance.sector_id
JOIN performance_sources source ON source.id = performance.performance_source_id
SET note.note = '시작하자마자 거의 최대 세기로 들어가서, 끝날 때까지 그 세기가 거의 떨어지지 않아요. 숨 돌릴 틈 없이 한 덩어리로 밀어붙여요.',
    note.moments = JSON_ARRAY(JSON_OBJECT('atMs', performance.start_ms + 2600, 'label', '벌써 거의 최대'))
WHERE sector.piece_id = 140
  AND sector.sector_key = 'coda'
  AND source.provider_video_id = '0FbQZCsYXVg'
  AND performance.start_ms = 236000
  AND performance.end_ms = 259000
  AND note.note = '시작하자마자 가장 큰 소리가 나오고, 끝날 때까지 세기가 거의 떨어지지 않아요. 숨 돌릴 틈 없이 한 덩어리로 밀어붙여요.'
  AND note.moments = JSON_ARRAY(JSON_OBJECT('atMs', performance.start_ms + 2600, 'label', '시작하자마자 정점'));

UPDATE performance_listening_notes note
JOIN performances performance ON performance.id = note.performance_id
JOIN performance_sectors sector ON sector.id = performance.sector_id
JOIN performance_sources source ON source.id = performance.performance_source_id
SET note.note = '처음 몇 초는 힘을 아끼고 조금씩 쌓아 올려요. 가장 큰 소리는 끝나기 5초 전에 터져요. 크레센도가 어디서 시작되는지 따라가 보세요.',
    note.moments = JSON_ARRAY(JSON_OBJECT('atMs', performance.start_ms + 19000, 'label', '여기서 터져요'))
WHERE sector.piece_id = 140
  AND sector.sector_key = 'coda'
  AND source.provider_video_id = 'cIxGUAnj46U'
  AND performance.start_ms = 243000
  AND performance.end_ms = 267000
  AND note.note = '처음 몇 초는 힘을 아끼고 조금씩 쌓아 올려요. 가장 큰 소리는 끝나기 4초 전에 터져요. 크레센도가 어디서 시작되는지 따라가 보세요.'
  AND note.moments = JSON_ARRAY(JSON_OBJECT('atMs', performance.start_ms + 19900, 'label', '여기서 터져요'));

UPDATE sector_featured_pairs pair
JOIN performance_sectors sector ON sector.id = pair.sector_id
JOIN performances kissin ON kissin.id = pair.performance_a_id
JOIN performance_sources kissin_source ON kissin_source.id = kissin.performance_source_id
JOIN performances lang ON lang.id = pair.performance_b_id
JOIN performance_sources lang_source ON lang_source.id = lang.performance_source_id
SET pair.note = '같은 20여 초를 정반대로 설계했어요. 키신은 시작하자마자 최대 세기에 올라 끝까지 버티고, 랑랑은 힘을 아꼈다가 끝나기 5초 전에 터뜨려요. 두 곳을 번갈아 들어 보세요.',
    pair.moments = JSON_ARRAY(
        JSON_OBJECT('performanceId', kissin.id, 'atMs', kissin.start_ms + 2600, 'label', '키신은 벌써 거의 최대'),
        JSON_OBJECT('performanceId', lang.id, 'atMs', lang.start_ms + 19000, 'label', '랑랑의 정점')
    )
WHERE sector.piece_id = 140
  AND sector.sector_key = 'coda'
  AND kissin_source.provider_video_id = '0FbQZCsYXVg'
  AND kissin.start_ms = 236000
  AND lang_source.provider_video_id = 'cIxGUAnj46U'
  AND lang.start_ms = 243000
  AND pair.note = '같은 20여 초를 정반대로 설계했어요. 키신은 시작하자마자 정점에 올라 끝까지 버티고, 랑랑은 힘을 아꼈다가 끝나기 4초 전에 터뜨려요. 두 곳을 번갈아 들어 보세요.'
  AND pair.moments = JSON_ARRAY(
        JSON_OBJECT('performanceId', kissin.id, 'atMs', kissin.start_ms + 2600, 'label', '키신의 정점'),
        JSON_OBJECT('performanceId', lang.id, 'atMs', lang.start_ms + 19900, 'label', '랑랑의 정점')
  );
