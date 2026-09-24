-- 국제 시드가 따로 만든 중복 곡 29 쌍의 작품 식별자와 악장을 수동 곡으로 옮긴다.
--
-- A tier 수동 곡 88 개의 MusicBrainz work 을 확정하고 소유를 확인했더니 29 개(33%)를
-- 시드 곡이 쥐고 있었다. 적재기는 곡을 musicbrainz_work 로 해소하므로 이대로 두면
-- 연주가 수동 곡이 아니라 시드 곡에 붙고, 비교 화면에는 아무것도 뜨지 않는다.
--
-- 29 쌍 모두 시드 곡에 연주도 구간도 없고 악장과 식별자뿐인 것을 확인했다
-- (performance_sectors 가 전부 0 건). 시드 곡 자체는 지우지 않는다.
--
-- 202608050108 과 같은 이유와 같은 방식이다. 악장은 시드 곡의 행을 그대로 복사하고
-- 한국어 이름은 비워 둔다. 자동 시드가 덮어쓰지 못하게 origin 을 manual,
-- editor_locked 를 1 로 둔다.
--
-- | 작곡가 | 곡 | 시드 | 수동 | 옮길 악장 |
-- |---|---|---|---|---|
-- | C.P.E. 바흐 | Cello Concerto in A minor, Wq. 170, H. 432 | 13512 | 104 | 3 |
-- | C.P.E. 바흐 | Flute Concerto in D minor, H. 484.1 | 13697 | 105 | 3 |
-- | C.P.E. 바흐 | Magnificat, Wq. 215, H. 772 | 12125 | 106 | 9 |
-- | 드뷔시 | Prélude à l’après‐midi d’un faune, L. 86, CD 8 | 601 | 221 | 0 |
-- | 드뷔시 | Children’s Corner, L. 113, CD 119 | 10378 | 223 | 4 |
-- | 드뷔시 | Rêverie, L. 68, CD 76 | 7519 | 456 | 0 |
-- | 라벨 | Boléro | 7491 | 230 | 0 |
-- | 라벨 | Piano Concerto in G major, M. 83 | 1060 | 233 | 3 |
-- | 라벨 | Daphnis et Chloé, Suite no. 2 | 7571 | 234 | 0 |
-- | 말러 | Symphony no. 2 “Resurrection” | 614 | 215 | 5 |
-- | 말러 | Symphony no. 1 in D major “Titan” | 543 | 217 | 4 |
-- | 말러 | Symphony no. 8 “Symphony of a Thousand” | 11358 | 218 | 33 |
-- | 메시앙 | Quatuor pour la fin du Temps | 593 | 360 | 8 |
-- | 메시앙 | Turangalîla-Symphonie, I/29 | 705 | 362 | 10 |
-- | 베르크 | Violinkonzert „Dem Andenken eines Engels“ | 7581 | 365 | 2 |
-- | 베를리오즈 | Symphonie fantastique, op. 14 : Épisode de la  | 507 | 170 | 0 |
-- | 베베른 | Symphony, op. 21 | 8216 | 367 | 2 |
-- | 베베른 | Five Movements for String Quartet, op. 5 | 11213 | 368 | 5 |
-- | 베베른 | Sechs Stücke für Orchester, op. 6 | 7586 | 369 | 6 |
-- | 브리튼 | The Young Person’s Guide to the Orchestra, op. | 2274 | 356 | 15 |
-- | 브리튼 | War Requiem, op. 66 | 1024 | 358 | 6 |
-- | 브리튼 | Cello Suite no. 1, op. 72 | 1418 | 359 | 9 |
-- | 비제 | Symphonie no. 1 en ut majeur | 11307 | 196 | 4 |
-- | 아이브스 | Symphony no. 4, S. 4 | 10392 | 371 | 4 |
-- | 아이브스 | Piano Sonata no. 2, S. 88 “Concord, Mass., 184 | 8076 | 372 | 4 |
-- | 아이브스 | Orchestral Set No. 1, S. 7 "Three Places in Ne | 9507 | 373 | 3 |
-- | 포레 | Pavane in F-sharp minor, op. 50 | 676 | 207 | 0 |
-- | 하차투리안 | Violin Concerto in D minor, op. 46 | 2253 | 383 | 3 |
-- | 하차투리안 | Masquerade Suite, op. 48a | 1332 | 384 | 4 |

UPDATE piece_identifiers identifier
JOIN (
    SELECT 13512 AS seed, 104 AS manual
    UNION ALL SELECT 13697, 105
    UNION ALL SELECT 12125, 106
    UNION ALL SELECT 507, 170
    UNION ALL SELECT 11307, 196
    UNION ALL SELECT 676, 207
    UNION ALL SELECT 614, 215
    UNION ALL SELECT 543, 217
    UNION ALL SELECT 11358, 218
    UNION ALL SELECT 601, 221
    UNION ALL SELECT 10378, 223
    UNION ALL SELECT 7491, 230
    UNION ALL SELECT 1060, 233
    UNION ALL SELECT 7571, 234
    UNION ALL SELECT 2274, 356
    UNION ALL SELECT 1024, 358
    UNION ALL SELECT 1418, 359
    UNION ALL SELECT 593, 360
    UNION ALL SELECT 705, 362
    UNION ALL SELECT 7581, 365
    UNION ALL SELECT 8216, 367
    UNION ALL SELECT 11213, 368
    UNION ALL SELECT 7586, 369
    UNION ALL SELECT 10392, 371
    UNION ALL SELECT 8076, 372
    UNION ALL SELECT 9507, 373
    UNION ALL SELECT 2253, 383
    UNION ALL SELECT 1332, 384
    UNION ALL SELECT 7519, 456
) pair ON pair.seed = identifier.piece_id
SET identifier.piece_id = pair.manual
WHERE NOT EXISTS (
    SELECT 1 FROM (
        SELECT piece_id, namespace FROM piece_identifiers
    ) existing
    WHERE existing.piece_id = pair.manual AND existing.namespace = identifier.namespace
);

INSERT INTO piece_parts
    (piece_id, part_key, sequence_number, movement_number, name_en, duration_ms,
     editorial_status, origin, editor_locked)
SELECT pair.manual, source.part_key, source.sequence_number, source.movement_number,
       source.name_en, source.duration_ms, 'FACTS_VERIFIED', 'manual', 1
FROM (SELECT piece_id, part_key, sequence_number, movement_number, name_en, duration_ms
      FROM piece_parts) source
JOIN (
    SELECT 13512 AS seed, 104 AS manual
    UNION ALL SELECT 13697, 105
    UNION ALL SELECT 12125, 106
    UNION ALL SELECT 507, 170
    UNION ALL SELECT 11307, 196
    UNION ALL SELECT 676, 207
    UNION ALL SELECT 614, 215
    UNION ALL SELECT 543, 217
    UNION ALL SELECT 11358, 218
    UNION ALL SELECT 601, 221
    UNION ALL SELECT 10378, 223
    UNION ALL SELECT 7491, 230
    UNION ALL SELECT 1060, 233
    UNION ALL SELECT 7571, 234
    UNION ALL SELECT 2274, 356
    UNION ALL SELECT 1024, 358
    UNION ALL SELECT 1418, 359
    UNION ALL SELECT 593, 360
    UNION ALL SELECT 705, 362
    UNION ALL SELECT 7581, 365
    UNION ALL SELECT 8216, 367
    UNION ALL SELECT 11213, 368
    UNION ALL SELECT 7586, 369
    UNION ALL SELECT 10392, 371
    UNION ALL SELECT 8076, 372
    UNION ALL SELECT 9507, 373
    UNION ALL SELECT 2253, 383
    UNION ALL SELECT 1332, 384
    UNION ALL SELECT 7519, 456
) pair ON pair.seed = source.piece_id
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = pair.manual AND existing.part_key = source.part_key
);
