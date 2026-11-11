-- 남은 원어 seed 가운데 같은 작품이 이미 손 작품으로 있는 것을 숨기고 남길 작품으로 합친다(묶음 22개).
-- 근거: seed_pipeline/curation/leftover-seeds-2026-11-11/dup_decisions.json. 본문은 duplicate-pieces-2026-11-11/gen_sql.py 와 같다:
--   hidden_reason='duplicate'(지우지 않음), 숨긴 뒤 그 작품을 가리키던 행을 남길 작품으로 옮기고
--   남길 작품의 빈 칸(설명·링크·연도)을 채운다. 비교 구간이 있거나 part 가 가리키면 숨기지 않는다.
--   두 번 넣어도 같다.


-- 보케리니: 8841 「플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"」 ← 8145 「플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"」
-- 보케리니 G 430 「Las Parejas」의 같은 곡 Entrada - Marcia 를 MB 가 두 work(III·I 번호만 다름)로 둔 seed. 제목이 완전히 같다. 중복 정리 작업(duplicate-pieces-2026-11-11)이 넘긴 짝
UPDATE pieces hidden JOIN pieces kept ON kept.id = 8841 AND kept.composer_id = 20
    AND kept.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 8145 AND hidden.composer_id = 20 AND hidden.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 8841
WHERE piece_id = 8145 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 8841
WHERE piece_id = 8145 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 8841
WHERE piece_id = 8145 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 8841
WHERE piece_id = 8145 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 8841
WHERE piece_id = 8145 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 8841
WHERE piece_id = 8145 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 8841
WHERE piece_id = 8145 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 8841
WHERE piece_id = 8145 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 8841
WHERE piece_id = 8145 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 8841
WHERE piece_id = 8145 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 8841
WHERE piece_id = 8145 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 8841
WHERE from_piece_id = 8145 AND to_piece_id <> 8841 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 8841
WHERE to_piece_id = 8145 AND from_piece_id <> 8841 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 8841, part_id = NULL
WHERE piece_id = 8145 AND composer_id = 20 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 8841
WHERE piece_id = 8145 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8841
    WHERE hidden_piece.id = 8145 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8145 AND hidden.composer_id = 20
    AND hidden.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 8841 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8145 AND hidden.composer_id = 20
    AND hidden.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 8841 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8145 AND hidden.composer_id = 20
    AND hidden.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 8841 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8145 AND hidden.composer_id = 20
    AND hidden.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 8841 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8145 AND hidden.composer_id = 20
    AND hidden.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 8841 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8145 AND hidden.composer_id = 20
    AND hidden.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 8841 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8145 AND hidden.composer_id = 20
    AND hidden.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 8841 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- C.P.E. 바흐: 106 「마니피카트 D장조」 ← 12125 「마니피카트 Wq. 215, H. 772」
-- MB 식별자가 없는 seed 의 원제 「Magnificat, Wq. 215, H. 772」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/00f1b8fc-b0f9-4f87-aaad-145c2806d6d9 「Magnificat, Wq. 215, H. 772」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 106 AND kept.composer_id = 22
    AND kept.title = '마니피카트 D장조' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 12125 AND hidden.composer_id = 22 AND hidden.title = '마니피카트 Wq. 215, H. 772'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 106
WHERE piece_id = 12125 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 106
WHERE piece_id = 12125 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 106
WHERE piece_id = 12125 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 106
WHERE piece_id = 12125 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 106
WHERE piece_id = 12125 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 106
WHERE piece_id = 12125 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 106
WHERE piece_id = 12125 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 106
WHERE piece_id = 12125 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 106
WHERE piece_id = 12125 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 106
WHERE piece_id = 12125 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 106
WHERE piece_id = 12125 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 106
WHERE from_piece_id = 12125 AND to_piece_id <> 106 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 106
WHERE to_piece_id = 12125 AND from_piece_id <> 106 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 106, part_id = NULL
WHERE piece_id = 12125 AND composer_id = 22 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 106
WHERE piece_id = 12125 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 106
    WHERE hidden_piece.id = 12125 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '마니피카트 Wq. 215, H. 772' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12125 AND hidden.composer_id = 22
    AND hidden.title = '마니피카트 Wq. 215, H. 772' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 106 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12125 AND hidden.composer_id = 22
    AND hidden.title = '마니피카트 Wq. 215, H. 772' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 106 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12125 AND hidden.composer_id = 22
    AND hidden.title = '마니피카트 Wq. 215, H. 772' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 106 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12125 AND hidden.composer_id = 22
    AND hidden.title = '마니피카트 Wq. 215, H. 772' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 106 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12125 AND hidden.composer_id = 22
    AND hidden.title = '마니피카트 Wq. 215, H. 772' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 106 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12125 AND hidden.composer_id = 22
    AND hidden.title = '마니피카트 Wq. 215, H. 772' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 106 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12125 AND hidden.composer_id = 22
    AND hidden.title = '마니피카트 Wq. 215, H. 772' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 106 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- C.P.E. 바흐: 104 「첼로 협주곡 A단조」 ← 13512 「첼로 협주곡 A단조 Wq. 170, H. 432」
-- MB 식별자가 없는 seed 의 원제 「Cello Concerto in A minor, Wq. 170, H. 432」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/ddebfc59-04e3-46a0-b4aa-80b17e4522dd 「Cello Concerto in A minor, Wq. 170, H. 432」). 남길 쪽은 손 작품(비교 구간 0개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 104 AND kept.composer_id = 22
    AND kept.title = '첼로 협주곡 A단조' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 13512 AND hidden.composer_id = 22 AND hidden.title = '첼로 협주곡 A단조 Wq. 170, H. 432'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 104
WHERE piece_id = 13512 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 104
WHERE piece_id = 13512 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 104
WHERE piece_id = 13512 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 104
WHERE piece_id = 13512 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 104
WHERE piece_id = 13512 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 104
WHERE piece_id = 13512 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 104
WHERE piece_id = 13512 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 104
WHERE piece_id = 13512 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 104
WHERE piece_id = 13512 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 104
WHERE piece_id = 13512 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 104
WHERE piece_id = 13512 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 104
WHERE from_piece_id = 13512 AND to_piece_id <> 104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 104
WHERE to_piece_id = 13512 AND from_piece_id <> 104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 104, part_id = NULL
WHERE piece_id = 13512 AND composer_id = 22 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 104
WHERE piece_id = 13512 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 104
    WHERE hidden_piece.id = 13512 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13512 AND hidden.composer_id = 22
    AND hidden.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 104 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13512 AND hidden.composer_id = 22
    AND hidden.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 104 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13512 AND hidden.composer_id = 22
    AND hidden.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 104 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13512 AND hidden.composer_id = 22
    AND hidden.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 104 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13512 AND hidden.composer_id = 22
    AND hidden.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 104 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13512 AND hidden.composer_id = 22
    AND hidden.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 104 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13512 AND hidden.composer_id = 22
    AND hidden.title = '첼로 협주곡 A단조 Wq. 170, H. 432' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 104 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- C.P.E. 바흐: 105 「플루트 협주곡 D단조」 ← 13697 「플루트 협주곡 D단조 H. 484.1」
-- MB 식별자가 없는 seed 의 원제 「Flute Concerto in D minor, H. 484.1」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/fcac157c-a205-43e6-ae87-5a4e1b419422 「Flute Concerto in D minor, H. 484.1」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 105 AND kept.composer_id = 22
    AND kept.title = '플루트 협주곡 D단조' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 13697 AND hidden.composer_id = 22 AND hidden.title = '플루트 협주곡 D단조 H. 484.1'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 105
WHERE piece_id = 13697 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 105
WHERE piece_id = 13697 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 105
WHERE piece_id = 13697 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 105
WHERE piece_id = 13697 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 105
WHERE piece_id = 13697 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 105
WHERE piece_id = 13697 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 105
WHERE piece_id = 13697 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 105
WHERE piece_id = 13697 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 105
WHERE piece_id = 13697 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 105
WHERE piece_id = 13697 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 105
WHERE piece_id = 13697 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 105
WHERE from_piece_id = 13697 AND to_piece_id <> 105 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 105
WHERE to_piece_id = 13697 AND from_piece_id <> 105 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 105, part_id = NULL
WHERE piece_id = 13697 AND composer_id = 22 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 105
WHERE piece_id = 13697 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 105
    WHERE hidden_piece.id = 13697 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '플루트 협주곡 D단조 H. 484.1' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13697 AND hidden.composer_id = 22
    AND hidden.title = '플루트 협주곡 D단조 H. 484.1' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 105 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13697 AND hidden.composer_id = 22
    AND hidden.title = '플루트 협주곡 D단조 H. 484.1' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 105 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13697 AND hidden.composer_id = 22
    AND hidden.title = '플루트 협주곡 D단조 H. 484.1' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 105 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13697 AND hidden.composer_id = 22
    AND hidden.title = '플루트 협주곡 D단조 H. 484.1' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 105 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13697 AND hidden.composer_id = 22
    AND hidden.title = '플루트 협주곡 D단조 H. 484.1' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 105 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13697 AND hidden.composer_id = 22
    AND hidden.title = '플루트 협주곡 D단조 H. 484.1' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 105 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13697 AND hidden.composer_id = 22
    AND hidden.title = '플루트 협주곡 D단조 H. 484.1' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 105 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 베를리오즈: 170 「환상 교향곡」 ← 507 「환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"」
-- MB 식별자가 없는 seed 의 원제 「Symphonie fantastique, op. 14 : Épisode de la vie d’un artiste … en cinq parties」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/312510a8-a429-39a0-9a33-8d5f914872dd 「Symphonie fantastique, op. 14 : Épisode de la vie d’un artiste … en cinq parties」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 170 AND kept.composer_id = 37
    AND kept.title = '환상 교향곡' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 507 AND hidden.composer_id = 37 AND hidden.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 170
WHERE piece_id = 507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 170
WHERE piece_id = 507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 170
WHERE piece_id = 507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 170
WHERE piece_id = 507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 170
WHERE piece_id = 507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 170
WHERE piece_id = 507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 170
WHERE piece_id = 507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 170
WHERE piece_id = 507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 170
WHERE piece_id = 507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 170
WHERE piece_id = 507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 170
WHERE piece_id = 507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 170
WHERE from_piece_id = 507 AND to_piece_id <> 170 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 170
WHERE to_piece_id = 507 AND from_piece_id <> 170 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 170, part_id = NULL
WHERE piece_id = 507 AND composer_id = 37 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 170
WHERE piece_id = 507 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 170
    WHERE hidden_piece.id = 507 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 507 AND hidden.composer_id = 37
    AND hidden.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 170 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 507 AND hidden.composer_id = 37
    AND hidden.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 170 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 507 AND hidden.composer_id = 37
    AND hidden.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 170 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 507 AND hidden.composer_id = 37
    AND hidden.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 170 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 507 AND hidden.composer_id = 37
    AND hidden.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 170 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 507 AND hidden.composer_id = 37
    AND hidden.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 170 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 507 AND hidden.composer_id = 37
    AND hidden.title = '환상 교향곡 Op. 14 "한 예술가의 생애의 에피소드"' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 170 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 비제: 196 「교향곡 C장조」 ← 11307 「교향곡 1번 C장조」
-- MB 식별자가 없는 seed 의 원제 「Symphonie no. 1 en ut majeur」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/37b35e9f-3c6f-4204-9c2f-0745af4267a6 「Symphonie no. 1 en ut majeur」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 196 AND kept.composer_id = 44
    AND kept.title = '교향곡 C장조' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 11307 AND hidden.composer_id = 44 AND hidden.title = '교향곡 1번 C장조'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 196
WHERE piece_id = 11307 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 196
WHERE piece_id = 11307 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 196
WHERE piece_id = 11307 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 196
WHERE piece_id = 11307 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 196
WHERE piece_id = 11307 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 196
WHERE piece_id = 11307 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 196
WHERE piece_id = 11307 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 196
WHERE piece_id = 11307 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 196
WHERE piece_id = 11307 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 196
WHERE piece_id = 11307 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 196
WHERE piece_id = 11307 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 196
WHERE from_piece_id = 11307 AND to_piece_id <> 196 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 196
WHERE to_piece_id = 11307 AND from_piece_id <> 196 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 196, part_id = NULL
WHERE piece_id = 11307 AND composer_id = 44 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 196
WHERE piece_id = 11307 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 196
    WHERE hidden_piece.id = 11307 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '교향곡 1번 C장조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11307 AND hidden.composer_id = 44
    AND hidden.title = '교향곡 1번 C장조' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 196 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11307 AND hidden.composer_id = 44
    AND hidden.title = '교향곡 1번 C장조' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 196 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11307 AND hidden.composer_id = 44
    AND hidden.title = '교향곡 1번 C장조' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 196 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11307 AND hidden.composer_id = 44
    AND hidden.title = '교향곡 1번 C장조' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 196 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11307 AND hidden.composer_id = 44
    AND hidden.title = '교향곡 1번 C장조' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 196 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11307 AND hidden.composer_id = 44
    AND hidden.title = '교향곡 1번 C장조' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 196 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11307 AND hidden.composer_id = 44
    AND hidden.title = '교향곡 1번 C장조' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 196 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 알베니스: 10393 「España, seis hojas de álbum」 ← 10216 「에스파냐: 6개의 앨범 낱장 Op. 165」
-- 알베니스 「España, seis hojas de álbum, op. 165」 같은 작품(작품번호 Op. 165·제목 같음). 10393 은 이미 잠긴 seed 라 남기고 원어 seed 10216 을 숨긴다. 중복 정리 작업이 넘긴 짝
UPDATE pieces hidden JOIN pieces kept ON kept.id = 10393 AND kept.composer_id = 66
    AND kept.title = 'España, seis hojas de álbum' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 10216 AND hidden.composer_id = 66 AND hidden.title = '에스파냐: 6개의 앨범 낱장 Op. 165'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 10393
WHERE piece_id = 10216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 10393
WHERE piece_id = 10216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 10393
WHERE piece_id = 10216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 10393
WHERE piece_id = 10216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 10393
WHERE piece_id = 10216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 10393
WHERE piece_id = 10216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 10393
WHERE piece_id = 10216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 10393
WHERE piece_id = 10216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 10393
WHERE piece_id = 10216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 10393
WHERE piece_id = 10216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 10393
WHERE piece_id = 10216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 10393
WHERE from_piece_id = 10216 AND to_piece_id <> 10393 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 10393
WHERE to_piece_id = 10216 AND from_piece_id <> 10393 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 10393, part_id = NULL
WHERE piece_id = 10216 AND composer_id = 66 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 10393
WHERE piece_id = 10216 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 10393
    WHERE hidden_piece.id = 10216 AND hidden_piece.composer_id = 66
      AND hidden_piece.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 66 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10216 AND hidden.composer_id = 66
    AND hidden.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 10393 AND kept.composer_id = 66 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10216 AND hidden.composer_id = 66
    AND hidden.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 10393 AND kept.composer_id = 66 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10216 AND hidden.composer_id = 66
    AND hidden.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 10393 AND kept.composer_id = 66 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10216 AND hidden.composer_id = 66
    AND hidden.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 10393 AND kept.composer_id = 66 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10216 AND hidden.composer_id = 66
    AND hidden.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 10393 AND kept.composer_id = 66 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10216 AND hidden.composer_id = 66
    AND hidden.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 10393 AND kept.composer_id = 66 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10216 AND hidden.composer_id = 66
    AND hidden.title = '에스파냐: 6개의 앨범 낱장 Op. 165' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 10393 AND kept.composer_id = 66 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 번스타인: 337 「<웨스트 사이드 스토리> 중 "심포닉 댄스"」 ← 761 「<웨스트 사이드 스토리>의 교향적 무곡」
-- MB 식별자가 없는 seed 의 원제 「Symphonic Dances from West Side Story」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/67cb661e-8c40-32f7-8687-11a06a450738 「Symphonic Dances from West Side Story」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 337 AND kept.composer_id = 87
    AND kept.title = '<웨스트 사이드 스토리> 중 "심포닉 댄스"' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 761 AND hidden.composer_id = 87 AND hidden.title = '<웨스트 사이드 스토리>의 교향적 무곡'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 337
WHERE piece_id = 761 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 337
WHERE piece_id = 761 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 337
WHERE piece_id = 761 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 337
WHERE piece_id = 761 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 337
WHERE piece_id = 761 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 337
WHERE piece_id = 761 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 337
WHERE piece_id = 761 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 337
WHERE piece_id = 761 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 337
WHERE piece_id = 761 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 337
WHERE piece_id = 761 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 337
WHERE piece_id = 761 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 337
WHERE from_piece_id = 761 AND to_piece_id <> 337 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 337
WHERE to_piece_id = 761 AND from_piece_id <> 337 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 337, part_id = NULL
WHERE piece_id = 761 AND composer_id = 87 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 337
WHERE piece_id = 761 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 337
    WHERE hidden_piece.id = 761 AND hidden_piece.composer_id = 87
      AND hidden_piece.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 87 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 761 AND hidden.composer_id = 87
    AND hidden.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 337 AND kept.composer_id = 87 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 761 AND hidden.composer_id = 87
    AND hidden.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 337 AND kept.composer_id = 87 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 761 AND hidden.composer_id = 87
    AND hidden.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 337 AND kept.composer_id = 87 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 761 AND hidden.composer_id = 87
    AND hidden.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 337 AND kept.composer_id = 87 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 761 AND hidden.composer_id = 87
    AND hidden.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 337 AND kept.composer_id = 87 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 761 AND hidden.composer_id = 87
    AND hidden.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 337 AND kept.composer_id = 87 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 761 AND hidden.composer_id = 87
    AND hidden.title = '<웨스트 사이드 스토리>의 교향적 무곡' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 337 AND kept.composer_id = 87 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 브리튼: 358 「전쟁 레퀴엠」 ← 1024 「전쟁 레퀴엠 Op. 66」
-- MB 식별자가 없는 seed 의 원제 「War Requiem, op. 66」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/145fc3a0-b3a1-4bcc-ac4e-adb7a3eed972 「War Requiem, op. 66」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 358 AND kept.composer_id = 94
    AND kept.title = '전쟁 레퀴엠' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 1024 AND hidden.composer_id = 94 AND hidden.title = '전쟁 레퀴엠 Op. 66'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 358
WHERE piece_id = 1024 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 358
WHERE piece_id = 1024 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 358
WHERE piece_id = 1024 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 358
WHERE piece_id = 1024 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 358
WHERE piece_id = 1024 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 358
WHERE piece_id = 1024 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 358
WHERE piece_id = 1024 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 358
WHERE piece_id = 1024 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 358
WHERE piece_id = 1024 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 358
WHERE piece_id = 1024 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 358
WHERE piece_id = 1024 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 358
WHERE from_piece_id = 1024 AND to_piece_id <> 358 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 358
WHERE to_piece_id = 1024 AND from_piece_id <> 358 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 358, part_id = NULL
WHERE piece_id = 1024 AND composer_id = 94 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 358
WHERE piece_id = 1024 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 358
    WHERE hidden_piece.id = 1024 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '전쟁 레퀴엠 Op. 66' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1024 AND hidden.composer_id = 94
    AND hidden.title = '전쟁 레퀴엠 Op. 66' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 358 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1024 AND hidden.composer_id = 94
    AND hidden.title = '전쟁 레퀴엠 Op. 66' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 358 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1024 AND hidden.composer_id = 94
    AND hidden.title = '전쟁 레퀴엠 Op. 66' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 358 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1024 AND hidden.composer_id = 94
    AND hidden.title = '전쟁 레퀴엠 Op. 66' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 358 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1024 AND hidden.composer_id = 94
    AND hidden.title = '전쟁 레퀴엠 Op. 66' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 358 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1024 AND hidden.composer_id = 94
    AND hidden.title = '전쟁 레퀴엠 Op. 66' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 358 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1024 AND hidden.composer_id = 94
    AND hidden.title = '전쟁 레퀴엠 Op. 66' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 358 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 브리튼: 359 「첼로 모음곡 1번」 ← 1418 「첼로 모음곡 1번 Op. 72」
-- MB 식별자가 없는 seed 의 원제 「Cello Suite no. 1, op. 72」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/44506c7a-871f-4c7c-918f-00990699b8b6 「Cello Suite no. 1, op. 72」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 359 AND kept.composer_id = 94
    AND kept.title = '첼로 모음곡 1번' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 1418 AND hidden.composer_id = 94 AND hidden.title = '첼로 모음곡 1번 Op. 72'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 359
WHERE piece_id = 1418 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 359
WHERE piece_id = 1418 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 359
WHERE piece_id = 1418 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 359
WHERE piece_id = 1418 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 359
WHERE piece_id = 1418 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 359
WHERE piece_id = 1418 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 359
WHERE piece_id = 1418 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 359
WHERE piece_id = 1418 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 359
WHERE piece_id = 1418 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 359
WHERE piece_id = 1418 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 359
WHERE piece_id = 1418 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 359
WHERE from_piece_id = 1418 AND to_piece_id <> 359 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 359
WHERE to_piece_id = 1418 AND from_piece_id <> 359 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 359, part_id = NULL
WHERE piece_id = 1418 AND composer_id = 94 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 359
WHERE piece_id = 1418 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 359
    WHERE hidden_piece.id = 1418 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = '첼로 모음곡 1번 Op. 72' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1418 AND hidden.composer_id = 94
    AND hidden.title = '첼로 모음곡 1번 Op. 72' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 359 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1418 AND hidden.composer_id = 94
    AND hidden.title = '첼로 모음곡 1번 Op. 72' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 359 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1418 AND hidden.composer_id = 94
    AND hidden.title = '첼로 모음곡 1번 Op. 72' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 359 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1418 AND hidden.composer_id = 94
    AND hidden.title = '첼로 모음곡 1번 Op. 72' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 359 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1418 AND hidden.composer_id = 94
    AND hidden.title = '첼로 모음곡 1번 Op. 72' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 359 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1418 AND hidden.composer_id = 94
    AND hidden.title = '첼로 모음곡 1번 Op. 72' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 359 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1418 AND hidden.composer_id = 94
    AND hidden.title = '첼로 모음곡 1번 Op. 72' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 359 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 브리튼: 356 「청소년을 위한 관현악 입문」 ← 2274 「The Young Person’s Guide to the Orchestra, op. 34」
-- MB 식별자가 없는 seed 의 원제 「The Young Person’s Guide to the Orchestra, op. 34」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/ace72a0f-a21f-4ebd-a994-3957aaf14d9f 「The Young Person’s Guide to the Orchestra, op. 34」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 356 AND kept.composer_id = 94
    AND kept.title = '청소년을 위한 관현악 입문' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 2274 AND hidden.composer_id = 94 AND hidden.title = 'The Young Person’s Guide to the Orchestra, op. 34'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 356
WHERE piece_id = 2274 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 356
WHERE piece_id = 2274 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 356
WHERE piece_id = 2274 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 356
WHERE piece_id = 2274 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 356
WHERE piece_id = 2274 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 356
WHERE piece_id = 2274 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 356
WHERE piece_id = 2274 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 356
WHERE piece_id = 2274 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 356
WHERE piece_id = 2274 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 356
WHERE piece_id = 2274 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 356
WHERE piece_id = 2274 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 356
WHERE from_piece_id = 2274 AND to_piece_id <> 356 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 356
WHERE to_piece_id = 2274 AND from_piece_id <> 356 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 356, part_id = NULL
WHERE piece_id = 2274 AND composer_id = 94 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 356
WHERE piece_id = 2274 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 356
    WHERE hidden_piece.id = 2274 AND hidden_piece.composer_id = 94
      AND hidden_piece.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 94 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2274 AND hidden.composer_id = 94
    AND hidden.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 356 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2274 AND hidden.composer_id = 94
    AND hidden.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 356 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2274 AND hidden.composer_id = 94
    AND hidden.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 356 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2274 AND hidden.composer_id = 94
    AND hidden.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 356 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2274 AND hidden.composer_id = 94
    AND hidden.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 356 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2274 AND hidden.composer_id = 94
    AND hidden.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 356 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2274 AND hidden.composer_id = 94
    AND hidden.title = 'The Young Person’s Guide to the Orchestra, op. 34' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 356 AND kept.composer_id = 94 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 메시앙: 360 「시간의 종말을 위한 4중주」 ← 593 「시간의 종말을 위한 4중주」
-- MB 식별자가 없는 seed 의 원제 「Quatuor pour la fin du Temps」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/92eab622-10fb-4613-8b95-e7ef4e76d99b 「Quatuor pour la fin du Temps」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 360 AND kept.composer_id = 95
    AND kept.title = '시간의 종말을 위한 4중주' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 593 AND hidden.composer_id = 95 AND hidden.title = '시간의 종말을 위한 4중주'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 360
WHERE piece_id = 593 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 360
WHERE piece_id = 593 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 360
WHERE piece_id = 593 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 360
WHERE piece_id = 593 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 360
WHERE piece_id = 593 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 360
WHERE piece_id = 593 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 360
WHERE piece_id = 593 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 360
WHERE piece_id = 593 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 360
WHERE piece_id = 593 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 360
WHERE piece_id = 593 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 360
WHERE piece_id = 593 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 360
WHERE from_piece_id = 593 AND to_piece_id <> 360 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 360
WHERE to_piece_id = 593 AND from_piece_id <> 360 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 360, part_id = NULL
WHERE piece_id = 593 AND composer_id = 95 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 360
WHERE piece_id = 593 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 360
    WHERE hidden_piece.id = 593 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '시간의 종말을 위한 4중주' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 593 AND hidden.composer_id = 95
    AND hidden.title = '시간의 종말을 위한 4중주' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 360 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 593 AND hidden.composer_id = 95
    AND hidden.title = '시간의 종말을 위한 4중주' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 360 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 593 AND hidden.composer_id = 95
    AND hidden.title = '시간의 종말을 위한 4중주' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 360 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 593 AND hidden.composer_id = 95
    AND hidden.title = '시간의 종말을 위한 4중주' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 360 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 593 AND hidden.composer_id = 95
    AND hidden.title = '시간의 종말을 위한 4중주' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 360 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 593 AND hidden.composer_id = 95
    AND hidden.title = '시간의 종말을 위한 4중주' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 360 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 593 AND hidden.composer_id = 95
    AND hidden.title = '시간의 종말을 위한 4중주' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 360 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 메시앙: 362 「투랑갈릴라 교향곡」 ← 705 「투랑갈릴라 교향곡 I/29」
-- MB 식별자가 없는 seed 의 원제 「Turangalîla-Symphonie, I/29」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/ec48e2cb-8e50-4648-89ba-ec86fb914304 「Turangalîla-Symphonie, I/29」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 362 AND kept.composer_id = 95
    AND kept.title = '투랑갈릴라 교향곡' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 705 AND hidden.composer_id = 95 AND hidden.title = '투랑갈릴라 교향곡 I/29'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 362
WHERE piece_id = 705 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 362
WHERE piece_id = 705 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 362
WHERE piece_id = 705 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 362
WHERE piece_id = 705 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 362
WHERE piece_id = 705 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 362
WHERE piece_id = 705 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 362
WHERE piece_id = 705 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 362
WHERE piece_id = 705 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 362
WHERE piece_id = 705 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 362
WHERE piece_id = 705 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 362
WHERE piece_id = 705 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 362
WHERE from_piece_id = 705 AND to_piece_id <> 362 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 362
WHERE to_piece_id = 705 AND from_piece_id <> 362 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 362, part_id = NULL
WHERE piece_id = 705 AND composer_id = 95 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 362
WHERE piece_id = 705 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 362
    WHERE hidden_piece.id = 705 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '투랑갈릴라 교향곡 I/29' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 705 AND hidden.composer_id = 95
    AND hidden.title = '투랑갈릴라 교향곡 I/29' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 362 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 705 AND hidden.composer_id = 95
    AND hidden.title = '투랑갈릴라 교향곡 I/29' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 362 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 705 AND hidden.composer_id = 95
    AND hidden.title = '투랑갈릴라 교향곡 I/29' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 362 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 705 AND hidden.composer_id = 95
    AND hidden.title = '투랑갈릴라 교향곡 I/29' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 362 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 705 AND hidden.composer_id = 95
    AND hidden.title = '투랑갈릴라 교향곡 I/29' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 362 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 705 AND hidden.composer_id = 95
    AND hidden.title = '투랑갈릴라 교향곡 I/29' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 362 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 705 AND hidden.composer_id = 95
    AND hidden.title = '투랑갈릴라 교향곡 I/29' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 362 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 베르크: 365 「바이올린 협주곡 "어느 천사를 추억하며"」 ← 7581 「바이올린 협주곡 "Dem Andenken eines Engels"」
-- MB 식별자가 없는 seed 의 원제 「Violinkonzert „Dem Andenken eines Engels“」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/baca1b94-4041-49c4-8b61-32a99d46524d 「Violinkonzert „Dem Andenken eines Engels“」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 365 AND kept.composer_id = 96
    AND kept.title = '바이올린 협주곡 "어느 천사를 추억하며"' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 7581 AND hidden.composer_id = 96 AND hidden.title = '바이올린 협주곡 "Dem Andenken eines Engels"'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 365
WHERE piece_id = 7581 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 365
WHERE piece_id = 7581 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 365
WHERE piece_id = 7581 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 365
WHERE piece_id = 7581 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 365
WHERE piece_id = 7581 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 365
WHERE piece_id = 7581 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 365
WHERE piece_id = 7581 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 365
WHERE piece_id = 7581 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 365
WHERE piece_id = 7581 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 365
WHERE piece_id = 7581 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 365
WHERE piece_id = 7581 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 365
WHERE from_piece_id = 7581 AND to_piece_id <> 365 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 365
WHERE to_piece_id = 7581 AND from_piece_id <> 365 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 365, part_id = NULL
WHERE piece_id = 7581 AND composer_id = 96 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 365
WHERE piece_id = 7581 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 365
    WHERE hidden_piece.id = 7581 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7581 AND hidden.composer_id = 96
    AND hidden.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 365 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7581 AND hidden.composer_id = 96
    AND hidden.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 365 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7581 AND hidden.composer_id = 96
    AND hidden.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 365 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7581 AND hidden.composer_id = 96
    AND hidden.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 365 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7581 AND hidden.composer_id = 96
    AND hidden.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 365 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7581 AND hidden.composer_id = 96
    AND hidden.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 365 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7581 AND hidden.composer_id = 96
    AND hidden.title = '바이올린 협주곡 "Dem Andenken eines Engels"' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 365 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 베베른: 369 「오케스트라를 위한 6개의 소품」 ← 7586 「관현악을 위한 6개의 소품 Op. 6」
-- MB 식별자가 없는 seed 의 원제 「Sechs Stücke für Orchester, op. 6」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/c13f2347-8145-41a6-9f7a-b4ef2a4bddd0 「Sechs Stücke für Orchester, op. 6」). 남길 쪽은 손 작품(비교 구간 0개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 369 AND kept.composer_id = 97
    AND kept.title = '오케스트라를 위한 6개의 소품' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 7586 AND hidden.composer_id = 97 AND hidden.title = '관현악을 위한 6개의 소품 Op. 6'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 369
WHERE piece_id = 7586 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 369
WHERE piece_id = 7586 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 369
WHERE piece_id = 7586 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 369
WHERE piece_id = 7586 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 369
WHERE piece_id = 7586 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 369
WHERE piece_id = 7586 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 369
WHERE piece_id = 7586 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 369
WHERE piece_id = 7586 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 369
WHERE piece_id = 7586 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 369
WHERE piece_id = 7586 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 369
WHERE piece_id = 7586 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 369
WHERE from_piece_id = 7586 AND to_piece_id <> 369 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 369
WHERE to_piece_id = 7586 AND from_piece_id <> 369 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 369, part_id = NULL
WHERE piece_id = 7586 AND composer_id = 97 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 369
WHERE piece_id = 7586 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 369
    WHERE hidden_piece.id = 7586 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7586 AND hidden.composer_id = 97
    AND hidden.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 369 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7586 AND hidden.composer_id = 97
    AND hidden.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 369 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7586 AND hidden.composer_id = 97
    AND hidden.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 369 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7586 AND hidden.composer_id = 97
    AND hidden.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 369 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7586 AND hidden.composer_id = 97
    AND hidden.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 369 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7586 AND hidden.composer_id = 97
    AND hidden.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 369 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7586 AND hidden.composer_id = 97
    AND hidden.title = '관현악을 위한 6개의 소품 Op. 6' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 369 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 베베른: 367 「교향곡」 ← 8216 「교향곡 Op. 21」
-- MB 식별자가 없는 seed 의 원제 「Symphony, op. 21」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/2195c606-ddb5-44c6-8993-4c5ea1cbb1ef 「Symphony, op. 21」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 367 AND kept.composer_id = 97
    AND kept.title = '교향곡' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 8216 AND hidden.composer_id = 97 AND hidden.title = '교향곡 Op. 21'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 367
WHERE piece_id = 8216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 367
WHERE piece_id = 8216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 367
WHERE piece_id = 8216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 367
WHERE piece_id = 8216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 367
WHERE piece_id = 8216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 367
WHERE piece_id = 8216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 367
WHERE piece_id = 8216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 367
WHERE piece_id = 8216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 367
WHERE piece_id = 8216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 367
WHERE piece_id = 8216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 367
WHERE piece_id = 8216 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 367
WHERE from_piece_id = 8216 AND to_piece_id <> 367 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 367
WHERE to_piece_id = 8216 AND from_piece_id <> 367 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 367, part_id = NULL
WHERE piece_id = 8216 AND composer_id = 97 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 367
WHERE piece_id = 8216 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 367
    WHERE hidden_piece.id = 8216 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '교향곡 Op. 21' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8216 AND hidden.composer_id = 97
    AND hidden.title = '교향곡 Op. 21' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 367 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8216 AND hidden.composer_id = 97
    AND hidden.title = '교향곡 Op. 21' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 367 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8216 AND hidden.composer_id = 97
    AND hidden.title = '교향곡 Op. 21' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 367 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8216 AND hidden.composer_id = 97
    AND hidden.title = '교향곡 Op. 21' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 367 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8216 AND hidden.composer_id = 97
    AND hidden.title = '교향곡 Op. 21' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 367 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8216 AND hidden.composer_id = 97
    AND hidden.title = '교향곡 Op. 21' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 367 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8216 AND hidden.composer_id = 97
    AND hidden.title = '교향곡 Op. 21' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 367 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 베베른: 368 「현악 4중주를 위한 5개의 악장」 ← 11213 「현악 4중주를 위한 5개의 악장 Op. 5」
-- MB 식별자가 없는 seed 의 원제 「Five Movements for String Quartet, op. 5」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/fafa518d-4f22-45b7-b784-d744f8072240 「Five Movements for String Quartet, op. 5」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 368 AND kept.composer_id = 97
    AND kept.title = '현악 4중주를 위한 5개의 악장' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 11213 AND hidden.composer_id = 97 AND hidden.title = '현악 4중주를 위한 5개의 악장 Op. 5'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 368
WHERE piece_id = 11213 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 368
WHERE piece_id = 11213 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 368
WHERE piece_id = 11213 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 368
WHERE piece_id = 11213 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 368
WHERE piece_id = 11213 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 368
WHERE piece_id = 11213 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 368
WHERE piece_id = 11213 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 368
WHERE piece_id = 11213 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 368
WHERE piece_id = 11213 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 368
WHERE piece_id = 11213 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 368
WHERE piece_id = 11213 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 368
WHERE from_piece_id = 11213 AND to_piece_id <> 368 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 368
WHERE to_piece_id = 11213 AND from_piece_id <> 368 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 368, part_id = NULL
WHERE piece_id = 11213 AND composer_id = 97 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 368
WHERE piece_id = 11213 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 368
    WHERE hidden_piece.id = 11213 AND hidden_piece.composer_id = 97
      AND hidden_piece.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 97 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11213 AND hidden.composer_id = 97
    AND hidden.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 368 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11213 AND hidden.composer_id = 97
    AND hidden.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 368 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11213 AND hidden.composer_id = 97
    AND hidden.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 368 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11213 AND hidden.composer_id = 97
    AND hidden.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 368 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11213 AND hidden.composer_id = 97
    AND hidden.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 368 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11213 AND hidden.composer_id = 97
    AND hidden.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 368 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11213 AND hidden.composer_id = 97
    AND hidden.title = '현악 4중주를 위한 5개의 악장 Op. 5' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 368 AND kept.composer_id = 97 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 아이브스: 372 「피아노 소나타 2번 "콩코드"」 ← 8076 「피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"」
-- MB 식별자가 없는 seed 의 원제 「Piano Sonata no. 2, S. 88 “Concord, Mass., 1840–60”」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/172d92e8-3033-40be-9830-4884a91df532 「Piano Sonata no. 2, S. 88 “Concord, Mass., 1840–60”」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 372 AND kept.composer_id = 98
    AND kept.title = '피아노 소나타 2번 "콩코드"' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 8076 AND hidden.composer_id = 98 AND hidden.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 372
WHERE piece_id = 8076 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 372
WHERE piece_id = 8076 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 372
WHERE piece_id = 8076 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 372
WHERE piece_id = 8076 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 372
WHERE piece_id = 8076 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 372
WHERE piece_id = 8076 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 372
WHERE piece_id = 8076 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 372
WHERE piece_id = 8076 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 372
WHERE piece_id = 8076 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 372
WHERE piece_id = 8076 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 372
WHERE piece_id = 8076 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 372
WHERE from_piece_id = 8076 AND to_piece_id <> 372 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 372
WHERE to_piece_id = 8076 AND from_piece_id <> 372 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 372, part_id = NULL
WHERE piece_id = 8076 AND composer_id = 98 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 372
WHERE piece_id = 8076 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 372
    WHERE hidden_piece.id = 8076 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8076 AND hidden.composer_id = 98
    AND hidden.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 372 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8076 AND hidden.composer_id = 98
    AND hidden.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 372 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8076 AND hidden.composer_id = 98
    AND hidden.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 372 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8076 AND hidden.composer_id = 98
    AND hidden.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 372 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8076 AND hidden.composer_id = 98
    AND hidden.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 372 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8076 AND hidden.composer_id = 98
    AND hidden.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 372 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8076 AND hidden.composer_id = 98
    AND hidden.title = '피아노 소나타 2번 S. 88 "Concord, Mass., 1840–60"' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 372 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 아이브스: 373 「<뉴잉글랜드의 세 장소>」 ← 9507 「관현악 모음곡 1번 S. 7 "Three Places in New England"」
-- MB 식별자가 없는 seed 의 원제 「Orchestral Set No. 1, S. 7 "Three Places in New England"」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/7d77c078-c85f-4306-84fa-0054c91f402a 「Orchestral Set No. 1, S. 7 "Three Places in New England"」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 373 AND kept.composer_id = 98
    AND kept.title = '<뉴잉글랜드의 세 장소>' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 9507 AND hidden.composer_id = 98 AND hidden.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 373
WHERE piece_id = 9507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 373
WHERE piece_id = 9507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 373
WHERE piece_id = 9507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 373
WHERE piece_id = 9507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 373
WHERE piece_id = 9507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 373
WHERE piece_id = 9507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 373
WHERE piece_id = 9507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 373
WHERE piece_id = 9507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 373
WHERE piece_id = 9507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 373
WHERE piece_id = 9507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 373
WHERE piece_id = 9507 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 373
WHERE from_piece_id = 9507 AND to_piece_id <> 373 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 373
WHERE to_piece_id = 9507 AND from_piece_id <> 373 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 373, part_id = NULL
WHERE piece_id = 9507 AND composer_id = 98 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 373
WHERE piece_id = 9507 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 373
    WHERE hidden_piece.id = 9507 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9507 AND hidden.composer_id = 98
    AND hidden.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 373 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9507 AND hidden.composer_id = 98
    AND hidden.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 373 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9507 AND hidden.composer_id = 98
    AND hidden.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 373 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9507 AND hidden.composer_id = 98
    AND hidden.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 373 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9507 AND hidden.composer_id = 98
    AND hidden.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 373 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9507 AND hidden.composer_id = 98
    AND hidden.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 373 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9507 AND hidden.composer_id = 98
    AND hidden.title = '관현악 모음곡 1번 S. 7 "Three Places in New England"' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 373 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 아이브스: 371 「교향곡 4번」 ← 10392 「교향곡 4번 S. 4」
-- MB 식별자가 없는 seed 의 원제 「Symphony no. 4, S. 4」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/be10e23b-a4d0-497d-add0-d42a9be01551 「Symphony no. 4, S. 4」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 371 AND kept.composer_id = 98
    AND kept.title = '교향곡 4번' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 10392 AND hidden.composer_id = 98 AND hidden.title = '교향곡 4번 S. 4'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 371
WHERE piece_id = 10392 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 371
WHERE piece_id = 10392 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 371
WHERE piece_id = 10392 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 371
WHERE piece_id = 10392 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 371
WHERE piece_id = 10392 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 371
WHERE piece_id = 10392 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 371
WHERE piece_id = 10392 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 371
WHERE piece_id = 10392 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 371
WHERE piece_id = 10392 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 371
WHERE piece_id = 10392 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 371
WHERE piece_id = 10392 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 371
WHERE from_piece_id = 10392 AND to_piece_id <> 371 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 371
WHERE to_piece_id = 10392 AND from_piece_id <> 371 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 371, part_id = NULL
WHERE piece_id = 10392 AND composer_id = 98 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 371
WHERE piece_id = 10392 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 371
    WHERE hidden_piece.id = 10392 AND hidden_piece.composer_id = 98
      AND hidden_piece.title = '교향곡 4번 S. 4' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 98 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10392 AND hidden.composer_id = 98
    AND hidden.title = '교향곡 4번 S. 4' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 371 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10392 AND hidden.composer_id = 98
    AND hidden.title = '교향곡 4번 S. 4' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 371 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10392 AND hidden.composer_id = 98
    AND hidden.title = '교향곡 4번 S. 4' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 371 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10392 AND hidden.composer_id = 98
    AND hidden.title = '교향곡 4번 S. 4' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 371 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10392 AND hidden.composer_id = 98
    AND hidden.title = '교향곡 4번 S. 4' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 371 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10392 AND hidden.composer_id = 98
    AND hidden.title = '교향곡 4번 S. 4' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 371 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10392 AND hidden.composer_id = 98
    AND hidden.title = '교향곡 4번 S. 4' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 371 AND kept.composer_id = 98 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 하차투리안: 384 「가면무도회 모음곡」 ← 1332 「가면무도회 모음곡 Op. 48a」
-- MB 식별자가 없는 seed 의 원제 「Masquerade Suite, op. 48a」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/3abf8cb1-f308-4acf-bbef-02206b801f9b 「Masquerade Suite, op. 48a」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 384 AND kept.composer_id = 101
    AND kept.title = '가면무도회 모음곡' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 1332 AND hidden.composer_id = 101 AND hidden.title = '가면무도회 모음곡 Op. 48a'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 384
WHERE piece_id = 1332 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 384
WHERE piece_id = 1332 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 384
WHERE piece_id = 1332 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 384
WHERE piece_id = 1332 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 384
WHERE piece_id = 1332 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 384
WHERE piece_id = 1332 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 384
WHERE piece_id = 1332 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 384
WHERE piece_id = 1332 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 384
WHERE piece_id = 1332 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 384
WHERE piece_id = 1332 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 384
WHERE piece_id = 1332 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 384
WHERE from_piece_id = 1332 AND to_piece_id <> 384 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 384
WHERE to_piece_id = 1332 AND from_piece_id <> 384 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 384, part_id = NULL
WHERE piece_id = 1332 AND composer_id = 101 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 384
WHERE piece_id = 1332 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 384
    WHERE hidden_piece.id = 1332 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '가면무도회 모음곡 Op. 48a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1332 AND hidden.composer_id = 101
    AND hidden.title = '가면무도회 모음곡 Op. 48a' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 384 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1332 AND hidden.composer_id = 101
    AND hidden.title = '가면무도회 모음곡 Op. 48a' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 384 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1332 AND hidden.composer_id = 101
    AND hidden.title = '가면무도회 모음곡 Op. 48a' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 384 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1332 AND hidden.composer_id = 101
    AND hidden.title = '가면무도회 모음곡 Op. 48a' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 384 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1332 AND hidden.composer_id = 101
    AND hidden.title = '가면무도회 모음곡 Op. 48a' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 384 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1332 AND hidden.composer_id = 101
    AND hidden.title = '가면무도회 모음곡 Op. 48a' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 384 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1332 AND hidden.composer_id = 101
    AND hidden.title = '가면무도회 모음곡 Op. 48a' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 384 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 하차투리안: 383 「바이올린 협주곡 D단조」 ← 2253 「바이올린 협주곡 D단조 Op. 46」
-- MB 식별자가 없는 seed 의 원제 「Violin Concerto in D minor, op. 46」가 남길 작품의 MB work 제목과 같다(https://musicbrainz.org/work/aa1c1ce0-5d39-4e59-bf38-3b9b32347b6f 「Violin Concerto in D minor, op. 46」). 남길 쪽은 손 작품(비교 구간 1개)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 383 AND kept.composer_id = 101
    AND kept.title = '바이올린 협주곡 D단조' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 2253 AND hidden.composer_id = 101 AND hidden.title = '바이올린 협주곡 D단조 Op. 46'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 383
WHERE piece_id = 2253 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 383
WHERE piece_id = 2253 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 383
WHERE piece_id = 2253 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 383
WHERE piece_id = 2253 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 383
WHERE piece_id = 2253 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 383
WHERE piece_id = 2253 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 383
WHERE piece_id = 2253 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 383
WHERE piece_id = 2253 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 383
WHERE piece_id = 2253 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 383
WHERE piece_id = 2253 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 383
WHERE piece_id = 2253 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 383
WHERE from_piece_id = 2253 AND to_piece_id <> 383 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 383
WHERE to_piece_id = 2253 AND from_piece_id <> 383 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 383, part_id = NULL
WHERE piece_id = 2253 AND composer_id = 101 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 383
WHERE piece_id = 2253 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 383
    WHERE hidden_piece.id = 2253 AND hidden_piece.composer_id = 101
      AND hidden_piece.title = '바이올린 협주곡 D단조 Op. 46' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 101 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2253 AND hidden.composer_id = 101
    AND hidden.title = '바이올린 협주곡 D단조 Op. 46' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 383 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2253 AND hidden.composer_id = 101
    AND hidden.title = '바이올린 협주곡 D단조 Op. 46' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 383 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2253 AND hidden.composer_id = 101
    AND hidden.title = '바이올린 협주곡 D단조 Op. 46' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 383 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2253 AND hidden.composer_id = 101
    AND hidden.title = '바이올린 협주곡 D단조 Op. 46' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 383 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2253 AND hidden.composer_id = 101
    AND hidden.title = '바이올린 협주곡 D단조 Op. 46' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 383 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2253 AND hidden.composer_id = 101
    AND hidden.title = '바이올린 협주곡 D단조 Op. 46' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 383 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 2253 AND hidden.composer_id = 101
    AND hidden.title = '바이올린 협주곡 D단조 Op. 46' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 383 AND kept.composer_id = 101 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
