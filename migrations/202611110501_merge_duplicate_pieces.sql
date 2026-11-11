-- 같은 작곡가 안에서 한 작품이 두 줄 이상으로 보이던 것을 하나로 합친다(묶음 35개, 숨긴 작품 37개).
-- 근거와 고르지 않은 후보: seed_pipeline/curation/duplicate-pieces-2026-11-11/(README.md, decisions.json). 본문은 gen_sql.py 가 만든다.
--   숨길 작품은 hidden_reason='duplicate'(지우지 않음, 상세는 열림). 비교 구간이 있거나 part 가 가리키는 작품은 숨기지 않는다.
--   숨긴 뒤 그 작품을 가리키던 행(식별자·별칭·관계·카드·사용자 즐겨찾기 등)을 남길 작품으로 옮기고,
--   남길 작품의 빈 칸(설명·링크·연도)과 대표곡 표시를 채운다. part 는 남길 작품에 part 가 없을 때만 통째로 옮긴다.
--   두 번 넣어도 같다.


-- 보케리니: 100 「현악 5중주 E장조 중 "미뉴에트"」 ← 442 「현악 5중주 E장조 중 "미뉴에트"」
-- 같은 곡(Op. 11 No. 5 미뉴에트)을 손으로 두 번 넣었다. 제목·작품번호·연도 같음. 먼저 넣은 100 을 남긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 100 AND kept.composer_id = 20
    AND kept.title = '현악 5중주 E장조 중 "미뉴에트"' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 442 AND hidden.composer_id = 20 AND hidden.title = '현악 5중주 E장조 중 "미뉴에트"'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 100
WHERE piece_id = 442 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 100
WHERE piece_id = 442 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 100
WHERE piece_id = 442 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 100
WHERE piece_id = 442 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 100
WHERE piece_id = 442 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 100
WHERE piece_id = 442 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 100
WHERE piece_id = 442 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 100
WHERE piece_id = 442 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 100
WHERE piece_id = 442 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 100
WHERE piece_id = 442 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 100
WHERE piece_id = 442 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 100
WHERE from_piece_id = 442 AND to_piece_id <> 100 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 100
WHERE to_piece_id = 442 AND from_piece_id <> 100 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 100, part_id = NULL
WHERE piece_id = 442 AND composer_id = 20 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 100
WHERE piece_id = 442 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 100
    WHERE hidden_piece.id = 442 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 442 AND hidden.composer_id = 20
    AND hidden.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 100 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 442 AND hidden.composer_id = 20
    AND hidden.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 100 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 442 AND hidden.composer_id = 20
    AND hidden.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 100 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 442 AND hidden.composer_id = 20
    AND hidden.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 100 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 442 AND hidden.composer_id = 20
    AND hidden.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 100 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 442 AND hidden.composer_id = 20
    AND hidden.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 100 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 442 AND hidden.composer_id = 20
    AND hidden.title = '현악 5중주 E장조 중 "미뉴에트"' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 100 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 보케리니: 101 「첼로 협주곡 9번 B♭장조」 ← 7810 「첼로 협주곡 9번 B♭장조 G. 482」
-- G. 482 첼로 협주곡 9번. 7810 은 MusicBrainz work(original 판). 손 작품 101 에 설명·링크가 있어 남기고 악장 3개·MBID 를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 101 AND kept.composer_id = 20
    AND kept.title = '첼로 협주곡 9번 B♭장조' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 7810 AND hidden.composer_id = 20 AND hidden.title = '첼로 협주곡 9번 B♭장조 G. 482'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 101
WHERE piece_id = 7810 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 101
WHERE piece_id = 7810 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 101
WHERE piece_id = 7810 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 101
WHERE piece_id = 7810 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 101
WHERE piece_id = 7810 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 101
WHERE piece_id = 7810 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 101
WHERE piece_id = 7810 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 101
WHERE piece_id = 7810 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 101
WHERE piece_id = 7810 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 101
WHERE piece_id = 7810 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 101
WHERE piece_id = 7810 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 101
WHERE from_piece_id = 7810 AND to_piece_id <> 101 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 101
WHERE to_piece_id = 7810 AND from_piece_id <> 101 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 101, part_id = part_id
WHERE piece_id = 7810 AND composer_id = 20 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 101
WHERE piece_id = 7810 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7810 AND hidden.composer_id = 20
    AND hidden.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 101 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7810 AND hidden.composer_id = 20
    AND hidden.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 101 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7810 AND hidden.composer_id = 20
    AND hidden.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 101 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7810 AND hidden.composer_id = 20
    AND hidden.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 101 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7810 AND hidden.composer_id = 20
    AND hidden.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 101 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7810 AND hidden.composer_id = 20
    AND hidden.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 101 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7810 AND hidden.composer_id = 20
    AND hidden.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 101 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 101
WHERE piece_id = 7810 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 101
    WHERE hidden_piece.id = 7810 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '첼로 협주곡 9번 B♭장조 G. 482' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 101 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 7810 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 7810 AND link.piece_part_id IS NOT NULL);

-- 보케리니: 102 「기타 5중주 4번 D장조 "판당고"」 ← 9400 「기타 5중주 4번 D장조 "Fandango"」
-- G. 448 기타 5중주 4번 "판당고". 손 작품 102 를 남기고 악장 2개·MBID 를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 102 AND kept.composer_id = 20
    AND kept.title = '기타 5중주 4번 D장조 "판당고"' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 9400 AND hidden.composer_id = 20 AND hidden.title = '기타 5중주 4번 D장조 "Fandango"'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 102
WHERE piece_id = 9400 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 102
WHERE piece_id = 9400 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 102
WHERE piece_id = 9400 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 102
WHERE piece_id = 9400 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 102
WHERE piece_id = 9400 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 102
WHERE piece_id = 9400 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 102
WHERE piece_id = 9400 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 102
WHERE piece_id = 9400 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 102
WHERE piece_id = 9400 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 102
WHERE piece_id = 9400 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 102
WHERE piece_id = 9400 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 102
WHERE from_piece_id = 9400 AND to_piece_id <> 102 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 102
WHERE to_piece_id = 9400 AND from_piece_id <> 102 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 102, part_id = part_id
WHERE piece_id = 9400 AND composer_id = 20 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 102
WHERE piece_id = 9400 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9400 AND hidden.composer_id = 20
    AND hidden.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 102 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9400 AND hidden.composer_id = 20
    AND hidden.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 102 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9400 AND hidden.composer_id = 20
    AND hidden.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 102 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9400 AND hidden.composer_id = 20
    AND hidden.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 102 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9400 AND hidden.composer_id = 20
    AND hidden.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 102 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9400 AND hidden.composer_id = 20
    AND hidden.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 102 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9400 AND hidden.composer_id = 20
    AND hidden.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 102 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 102
WHERE piece_id = 9400 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 102
    WHERE hidden_piece.id = 9400 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '기타 5중주 4번 D장조 "Fandango"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 102 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 9400 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 9400 AND link.piece_part_id IS NOT NULL);

-- 보케리니: 32874 「소나타 6번 C장조」 ← 9536 「소나타 6번 C장조 G 6」
-- G. 6 첼로 소나타 6번(MusicBrainz 에 work 가 둘). 32874 의 악장이 낱곡 7754·8195·9633 을 품고 있어 32874 를 남긴다(9536 을 남기면 그 낱곡이 목록 맨 위로 튀어나온다). 9536 의 MBID·편곡 관계와 갈래(실내악·이중주 소나타)를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 32874 AND kept.composer_id = 20
    AND kept.title = '소나타 6번 C장조' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 9536 AND hidden.composer_id = 20 AND hidden.title = '소나타 6번 C장조 G 6'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 32874
WHERE piece_id = 9536 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 32874
WHERE piece_id = 9536 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 32874
WHERE piece_id = 9536 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 32874
WHERE piece_id = 9536 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 32874
WHERE piece_id = 9536 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 32874
WHERE piece_id = 9536 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 32874
WHERE piece_id = 9536 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 32874
WHERE piece_id = 9536 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 32874
WHERE piece_id = 9536 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 32874
WHERE piece_id = 9536 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 32874
WHERE piece_id = 9536 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 32874
WHERE from_piece_id = 9536 AND to_piece_id <> 32874 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 32874
WHERE to_piece_id = 9536 AND from_piece_id <> 32874 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 32874, part_id = NULL
WHERE piece_id = 9536 AND composer_id = 20 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 32874
WHERE piece_id = 9536 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 32874
    WHERE hidden_piece.id = 9536 AND hidden_piece.composer_id = 20
      AND hidden_piece.title = '소나타 6번 C장조 G 6' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 20 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9536 AND hidden.composer_id = 20
    AND hidden.title = '소나타 6번 C장조 G 6' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 32874 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9536 AND hidden.composer_id = 20
    AND hidden.title = '소나타 6번 C장조 G 6' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 32874 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9536 AND hidden.composer_id = 20
    AND hidden.title = '소나타 6번 C장조 G 6' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 32874 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9536 AND hidden.composer_id = 20
    AND hidden.title = '소나타 6번 C장조 G 6' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 32874 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9536 AND hidden.composer_id = 20
    AND hidden.title = '소나타 6번 C장조 G 6' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 32874 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9536 AND hidden.composer_id = 20
    AND hidden.title = '소나타 6번 C장조 G 6' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 32874 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 9536 AND hidden.composer_id = 20
    AND hidden.title = '소나타 6번 C장조 G 6' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 32874 AND kept.composer_id = 20 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE pieces piece SET piece.genre = 'chamber', piece.form_key = 'duo_sonata'
WHERE piece.id = 32874 AND piece.composer_id = 20 AND piece.hidden_reason IS NULL AND piece.genre = 'piano' AND piece.form_key = 'sonata';

-- C.P.E. 바흐: 12256 「2중창 E단조」 ← 12337 「Duetto in E minor」
-- Wq. 140, H. 598 플루트·바이올린 2중주(MusicBrainz 에 work 가 둘). 링크가 더 많은 12256 을 남기고, 성악으로 잘못 옮긴 제목 「2중창」을 「2중주」로, 갈래를 실내악으로 고친다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 12256 AND kept.composer_id = 22
    AND kept.title = '2중창 E단조' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 12337 AND hidden.composer_id = 22 AND hidden.title = 'Duetto in E minor'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 12256
WHERE piece_id = 12337 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 12256
WHERE piece_id = 12337 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 12256
WHERE piece_id = 12337 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 12256
WHERE piece_id = 12337 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 12256
WHERE piece_id = 12337 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 12256
WHERE piece_id = 12337 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 12256
WHERE piece_id = 12337 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 12256
WHERE piece_id = 12337 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 12256
WHERE piece_id = 12337 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 12256
WHERE piece_id = 12337 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 12256
WHERE piece_id = 12337 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 12256
WHERE from_piece_id = 12337 AND to_piece_id <> 12256 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 12256
WHERE to_piece_id = 12337 AND from_piece_id <> 12256 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 12256, part_id = NULL
WHERE piece_id = 12337 AND composer_id = 22 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 12256
WHERE piece_id = 12337 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 12256
    WHERE hidden_piece.id = 12337 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = 'Duetto in E minor' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12337 AND hidden.composer_id = 22
    AND hidden.title = 'Duetto in E minor' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 12256 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12337 AND hidden.composer_id = 22
    AND hidden.title = 'Duetto in E minor' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 12256 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12337 AND hidden.composer_id = 22
    AND hidden.title = 'Duetto in E minor' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 12256 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12337 AND hidden.composer_id = 22
    AND hidden.title = 'Duetto in E minor' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 12256 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12337 AND hidden.composer_id = 22
    AND hidden.title = 'Duetto in E minor' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 12256 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12337 AND hidden.composer_id = 22
    AND hidden.title = 'Duetto in E minor' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 12256 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12337 AND hidden.composer_id = 22
    AND hidden.title = 'Duetto in E minor' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 12256 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE pieces piece SET piece.title = '플루트와 바이올린을 위한 2중주 E단조', piece.genre = 'chamber', piece.form_key = 'chamber_other'
WHERE piece.id = 12256 AND piece.composer_id = 22 AND piece.hidden_reason IS NULL AND piece.title = '2중창 E단조';

-- C.P.E. 바흐: 13536 「비올라 다 감바 소나타 G단조」 ← 13224 「소나타 G단조」
-- Wq. 88, H. 510 비올라 다 감바 소나타(MusicBrainz 에 work 가 둘). 제목이 더 정확한 13536 을 남긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 13536 AND kept.composer_id = 22
    AND kept.title = '비올라 다 감바 소나타 G단조' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 13224 AND hidden.composer_id = 22 AND hidden.title = '소나타 G단조'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 13536
WHERE piece_id = 13224 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 13536
WHERE piece_id = 13224 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 13536
WHERE piece_id = 13224 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 13536
WHERE piece_id = 13224 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 13536
WHERE piece_id = 13224 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 13536
WHERE piece_id = 13224 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 13536
WHERE piece_id = 13224 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 13536
WHERE piece_id = 13224 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 13536
WHERE piece_id = 13224 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 13536
WHERE piece_id = 13224 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 13536
WHERE piece_id = 13224 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 13536
WHERE from_piece_id = 13224 AND to_piece_id <> 13536 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 13536
WHERE to_piece_id = 13224 AND from_piece_id <> 13536 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 13536, part_id = NULL
WHERE piece_id = 13224 AND composer_id = 22 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 13536
WHERE piece_id = 13224 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 13536
    WHERE hidden_piece.id = 13224 AND hidden_piece.composer_id = 22
      AND hidden_piece.title = '소나타 G단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 22 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13224 AND hidden.composer_id = 22
    AND hidden.title = '소나타 G단조' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 13536 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13224 AND hidden.composer_id = 22
    AND hidden.title = '소나타 G단조' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 13536 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13224 AND hidden.composer_id = 22
    AND hidden.title = '소나타 G단조' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 13536 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13224 AND hidden.composer_id = 22
    AND hidden.title = '소나타 G단조' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 13536 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13224 AND hidden.composer_id = 22
    AND hidden.title = '소나타 G단조' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 13536 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13224 AND hidden.composer_id = 22
    AND hidden.title = '소나타 G단조' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 13536 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 13224 AND hidden.composer_id = 22
    AND hidden.title = '소나타 G단조' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 13536 AND kept.composer_id = 22 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 슈만: 464 「어린이의 정경 Op. 15」 ← 135 「피아노 모음곡 <어린이의 정경>」
-- 어린이의 정경 Op. 15. 비교 구간·카드·영화 큐가 붙은 seed 464 를 남기고(골드베르크 461 선례), 손 작품 135 의 설명·Spotify 링크를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 464 AND kept.composer_id = 29
    AND kept.title = '어린이의 정경 Op. 15' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 135 AND hidden.composer_id = 29 AND hidden.title = '피아노 모음곡 <어린이의 정경>'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 464
WHERE piece_id = 135 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 464
WHERE piece_id = 135 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 464
WHERE piece_id = 135 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 464
WHERE piece_id = 135 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 464
WHERE piece_id = 135 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 464
WHERE piece_id = 135 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 464
WHERE piece_id = 135 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 464
WHERE piece_id = 135 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 464
WHERE piece_id = 135 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 464
WHERE piece_id = 135 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 464
WHERE piece_id = 135 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 464
WHERE from_piece_id = 135 AND to_piece_id <> 464 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 464
WHERE to_piece_id = 135 AND from_piece_id <> 464 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 464, part_id = NULL
WHERE piece_id = 135 AND composer_id = 29 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 464
WHERE piece_id = 135 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 464
    WHERE hidden_piece.id = 135 AND hidden_piece.composer_id = 29
      AND hidden_piece.title = '피아노 모음곡 <어린이의 정경>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 29 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 135 AND hidden.composer_id = 29
    AND hidden.title = '피아노 모음곡 <어린이의 정경>' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 464 AND kept.composer_id = 29 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 135 AND hidden.composer_id = 29
    AND hidden.title = '피아노 모음곡 <어린이의 정경>' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 464 AND kept.composer_id = 29 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 135 AND hidden.composer_id = 29
    AND hidden.title = '피아노 모음곡 <어린이의 정경>' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 464 AND kept.composer_id = 29 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 135 AND hidden.composer_id = 29
    AND hidden.title = '피아노 모음곡 <어린이의 정경>' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 464 AND kept.composer_id = 29 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 135 AND hidden.composer_id = 29
    AND hidden.title = '피아노 모음곡 <어린이의 정경>' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 464 AND kept.composer_id = 29 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 135 AND hidden.composer_id = 29
    AND hidden.title = '피아노 모음곡 <어린이의 정경>' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 464 AND kept.composer_id = 29 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 135 AND hidden.composer_id = 29
    AND hidden.title = '피아노 모음곡 <어린이의 정경>' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 464 AND kept.composer_id = 29 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 베를리오즈: 171 「<파우스트의 겁벌> 중 "헝가리 행진곡"」 ← 1600 「오페라 <La Damnation De Faust - Hungarian March>」
-- 파우스트의 겁벌 중 헝가리 행진곡. 비교 구간·카드가 있는 171 을 남긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 171 AND kept.composer_id = 37
    AND kept.title = '<파우스트의 겁벌> 중 "헝가리 행진곡"' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 1600 AND hidden.composer_id = 37 AND hidden.title = '오페라 <La Damnation De Faust - Hungarian March>'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 171
WHERE piece_id = 1600 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 171
WHERE piece_id = 1600 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 171
WHERE piece_id = 1600 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 171
WHERE piece_id = 1600 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 171
WHERE piece_id = 1600 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 171
WHERE piece_id = 1600 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 171
WHERE piece_id = 1600 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 171
WHERE piece_id = 1600 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 171
WHERE piece_id = 1600 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 171
WHERE piece_id = 1600 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 171
WHERE piece_id = 1600 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 171
WHERE from_piece_id = 1600 AND to_piece_id <> 171 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 171
WHERE to_piece_id = 1600 AND from_piece_id <> 171 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 171, part_id = NULL
WHERE piece_id = 1600 AND composer_id = 37 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 171
WHERE piece_id = 1600 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 171
    WHERE hidden_piece.id = 1600 AND hidden_piece.composer_id = 37
      AND hidden_piece.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 37 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1600 AND hidden.composer_id = 37
    AND hidden.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 171 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1600 AND hidden.composer_id = 37
    AND hidden.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 171 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1600 AND hidden.composer_id = 37
    AND hidden.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 171 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1600 AND hidden.composer_id = 37
    AND hidden.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 171 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1600 AND hidden.composer_id = 37
    AND hidden.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 171 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1600 AND hidden.composer_id = 37
    AND hidden.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 171 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1600 AND hidden.composer_id = 37
    AND hidden.title = '오페라 <La Damnation De Faust - Hungarian March>' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 171 AND kept.composer_id = 37 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 비제: 193 「오페라 <카르멘>」 ← 11318 「오페라 <Carmen, WD 31>」
-- 카르멘 WD 31. 카드·설명이 있는 193 을 남기고 11318 의 MBID·별칭·관계 12개(카르멘 환상곡 등 based_on)·대표곡 표시를 옮긴다. 193 은 이미 part 68개가 있어 part 는 옮기지 않는다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 193 AND kept.composer_id = 44
    AND kept.title = '오페라 <카르멘>' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 11318 AND hidden.composer_id = 44 AND hidden.title = '오페라 <Carmen, WD 31>'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 193
WHERE piece_id = 11318 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 193
WHERE piece_id = 11318 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 193
WHERE piece_id = 11318 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 193
WHERE piece_id = 11318 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 193
WHERE piece_id = 11318 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 193
WHERE piece_id = 11318 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 193
WHERE piece_id = 11318 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 193
WHERE piece_id = 11318 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 193
WHERE piece_id = 11318 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 193
WHERE piece_id = 11318 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 193
WHERE piece_id = 11318 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 193
WHERE from_piece_id = 11318 AND to_piece_id <> 193 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 193
WHERE to_piece_id = 11318 AND from_piece_id <> 193 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 193, part_id = NULL
WHERE piece_id = 11318 AND composer_id = 44 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 193
WHERE piece_id = 11318 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 193
    WHERE hidden_piece.id = 11318 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '오페라 <Carmen, WD 31>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11318 AND hidden.composer_id = 44
    AND hidden.title = '오페라 <Carmen, WD 31>' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 193 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11318 AND hidden.composer_id = 44
    AND hidden.title = '오페라 <Carmen, WD 31>' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 193 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11318 AND hidden.composer_id = 44
    AND hidden.title = '오페라 <Carmen, WD 31>' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 193 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11318 AND hidden.composer_id = 44
    AND hidden.title = '오페라 <Carmen, WD 31>' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 193 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11318 AND hidden.composer_id = 44
    AND hidden.title = '오페라 <Carmen, WD 31>' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 193 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11318 AND hidden.composer_id = 44
    AND hidden.title = '오페라 <Carmen, WD 31>' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 193 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11318 AND hidden.composer_id = 44
    AND hidden.title = '오페라 <Carmen, WD 31>' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 193 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 비제: 11795 「가곡 <La Rose et l’Abeille, WD 70>」 ← 11598 「가곡 <La Rose et l’Abeille>」
-- 비제 가곡 La Rose et l'Abeille WD 70(MusicBrainz 에 work 가 둘). WD 번호가 있는 11795 를 남긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 11795 AND kept.composer_id = 44
    AND kept.title = '가곡 <La Rose et l’Abeille, WD 70>' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 11598 AND hidden.composer_id = 44 AND hidden.title = '가곡 <La Rose et l’Abeille>'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 11795
WHERE piece_id = 11598 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 11795
WHERE piece_id = 11598 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 11795
WHERE piece_id = 11598 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 11795
WHERE piece_id = 11598 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 11795
WHERE piece_id = 11598 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 11795
WHERE piece_id = 11598 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 11795
WHERE piece_id = 11598 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 11795
WHERE piece_id = 11598 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 11795
WHERE piece_id = 11598 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 11795
WHERE piece_id = 11598 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 11795
WHERE piece_id = 11598 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 11795
WHERE from_piece_id = 11598 AND to_piece_id <> 11795 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 11795
WHERE to_piece_id = 11598 AND from_piece_id <> 11795 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 11795, part_id = NULL
WHERE piece_id = 11598 AND composer_id = 44 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 11795
WHERE piece_id = 11598 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 11795
    WHERE hidden_piece.id = 11598 AND hidden_piece.composer_id = 44
      AND hidden_piece.title = '가곡 <La Rose et l’Abeille>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 44 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11598 AND hidden.composer_id = 44
    AND hidden.title = '가곡 <La Rose et l’Abeille>' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 11795 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11598 AND hidden.composer_id = 44
    AND hidden.title = '가곡 <La Rose et l’Abeille>' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 11795 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11598 AND hidden.composer_id = 44
    AND hidden.title = '가곡 <La Rose et l’Abeille>' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 11795 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11598 AND hidden.composer_id = 44
    AND hidden.title = '가곡 <La Rose et l’Abeille>' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 11795 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11598 AND hidden.composer_id = 44
    AND hidden.title = '가곡 <La Rose et l’Abeille>' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 11795 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11598 AND hidden.composer_id = 44
    AND hidden.title = '가곡 <La Rose et l’Abeille>' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 11795 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11598 AND hidden.composer_id = 44
    AND hidden.title = '가곡 <La Rose et l’Abeille>' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 11795 AND kept.composer_id = 44 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 브루흐: 258 「스코틀랜드 환상곡」 ← 863 「Scottish Fantasy in E-flat major」
-- 브루흐 스코틀랜드 환상곡 Op. 46. 손 작품 258 을 남기고 악장 4개·MBID·대표곡 표시를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 258 AND kept.composer_id = 61
    AND kept.title = '스코틀랜드 환상곡' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 863 AND hidden.composer_id = 61 AND hidden.title = 'Scottish Fantasy in E-flat major'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 258
WHERE piece_id = 863 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 258
WHERE piece_id = 863 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 258
WHERE piece_id = 863 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 258
WHERE piece_id = 863 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 258
WHERE piece_id = 863 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 258
WHERE piece_id = 863 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 258
WHERE piece_id = 863 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 258
WHERE piece_id = 863 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 258
WHERE piece_id = 863 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 258
WHERE piece_id = 863 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 258
WHERE piece_id = 863 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 258
WHERE from_piece_id = 863 AND to_piece_id <> 258 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 258
WHERE to_piece_id = 863 AND from_piece_id <> 258 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 258, part_id = part_id
WHERE piece_id = 863 AND composer_id = 61 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 258
WHERE piece_id = 863 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 863 AND hidden.composer_id = 61
    AND hidden.title = 'Scottish Fantasy in E-flat major' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 258 AND kept.composer_id = 61 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 863 AND hidden.composer_id = 61
    AND hidden.title = 'Scottish Fantasy in E-flat major' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 258 AND kept.composer_id = 61 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 863 AND hidden.composer_id = 61
    AND hidden.title = 'Scottish Fantasy in E-flat major' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 258 AND kept.composer_id = 61 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 863 AND hidden.composer_id = 61
    AND hidden.title = 'Scottish Fantasy in E-flat major' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 258 AND kept.composer_id = 61 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 863 AND hidden.composer_id = 61
    AND hidden.title = 'Scottish Fantasy in E-flat major' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 258 AND kept.composer_id = 61 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 863 AND hidden.composer_id = 61
    AND hidden.title = 'Scottish Fantasy in E-flat major' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 258 AND kept.composer_id = 61 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 863 AND hidden.composer_id = 61
    AND hidden.title = 'Scottish Fantasy in E-flat major' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 258 AND kept.composer_id = 61 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 258
WHERE piece_id = 863 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 258
    WHERE hidden_piece.id = 863 AND hidden_piece.composer_id = 61
      AND hidden_piece.title = 'Scottish Fantasy in E-flat major' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 61 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 258 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 863 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 863 AND link.piece_part_id IS NOT NULL);

-- 사라사테: 264 「서주와 타란텔라」 ← 8680 「Introduction et tarantelle」
-- 사라사테 서주와 타란텔라 Op. 43. 손 작품 264 를 남기고 MBID·편곡 관계를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 264 AND kept.composer_id = 63
    AND kept.title = '서주와 타란텔라' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 8680 AND hidden.composer_id = 63 AND hidden.title = 'Introduction et tarantelle'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 264
WHERE piece_id = 8680 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 264
WHERE piece_id = 8680 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 264
WHERE piece_id = 8680 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 264
WHERE piece_id = 8680 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 264
WHERE piece_id = 8680 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 264
WHERE piece_id = 8680 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 264
WHERE piece_id = 8680 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 264
WHERE piece_id = 8680 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 264
WHERE piece_id = 8680 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 264
WHERE piece_id = 8680 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 264
WHERE piece_id = 8680 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 264
WHERE from_piece_id = 8680 AND to_piece_id <> 264 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 264
WHERE to_piece_id = 8680 AND from_piece_id <> 264 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 264, part_id = NULL
WHERE piece_id = 8680 AND composer_id = 63 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 264
WHERE piece_id = 8680 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 264
    WHERE hidden_piece.id = 8680 AND hidden_piece.composer_id = 63
      AND hidden_piece.title = 'Introduction et tarantelle' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 63 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8680 AND hidden.composer_id = 63
    AND hidden.title = 'Introduction et tarantelle' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 264 AND kept.composer_id = 63 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8680 AND hidden.composer_id = 63
    AND hidden.title = 'Introduction et tarantelle' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 264 AND kept.composer_id = 63 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8680 AND hidden.composer_id = 63
    AND hidden.title = 'Introduction et tarantelle' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 264 AND kept.composer_id = 63 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8680 AND hidden.composer_id = 63
    AND hidden.title = 'Introduction et tarantelle' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 264 AND kept.composer_id = 63 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8680 AND hidden.composer_id = 63
    AND hidden.title = 'Introduction et tarantelle' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 264 AND kept.composer_id = 63 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8680 AND hidden.composer_id = 63
    AND hidden.title = 'Introduction et tarantelle' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 264 AND kept.composer_id = 63 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8680 AND hidden.composer_id = 63
    AND hidden.title = 'Introduction et tarantelle' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 264 AND kept.composer_id = 63 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 엘가: 267 「수수께끼 변주곡」 ← 550 「독창적 주제에 의한 변주곡 "에니그마"」
-- 엘가 수수께끼 변주곡 Op. 36. 손 작품 267 을 남기고 변주 15개·MBID·ISWC·별칭 4개·편곡 관계·대표곡 표시를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 267 AND kept.composer_id = 64
    AND kept.title = '수수께끼 변주곡' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 550 AND hidden.composer_id = 64 AND hidden.title = '독창적 주제에 의한 변주곡 "에니그마"'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 267
WHERE piece_id = 550 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 267
WHERE piece_id = 550 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 267
WHERE piece_id = 550 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 267
WHERE piece_id = 550 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 267
WHERE piece_id = 550 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 267
WHERE piece_id = 550 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 267
WHERE piece_id = 550 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 267
WHERE piece_id = 550 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 267
WHERE piece_id = 550 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 267
WHERE piece_id = 550 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 267
WHERE piece_id = 550 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 267
WHERE from_piece_id = 550 AND to_piece_id <> 267 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 267
WHERE to_piece_id = 550 AND from_piece_id <> 267 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 267, part_id = part_id
WHERE piece_id = 550 AND composer_id = 64 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 267
WHERE piece_id = 550 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 550 AND hidden.composer_id = 64
    AND hidden.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 267 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 550 AND hidden.composer_id = 64
    AND hidden.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 267 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 550 AND hidden.composer_id = 64
    AND hidden.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 267 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 550 AND hidden.composer_id = 64
    AND hidden.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 267 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 550 AND hidden.composer_id = 64
    AND hidden.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 267 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 550 AND hidden.composer_id = 64
    AND hidden.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 267 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 550 AND hidden.composer_id = 64
    AND hidden.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 267 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 267
WHERE piece_id = 550 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 267
    WHERE hidden_piece.id = 550 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '독창적 주제에 의한 변주곡 "에니그마"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 267 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 550 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 550 AND link.piece_part_id IS NOT NULL);

-- 엘가: 268 「사랑의 인사」 ← 33052 「Salut d’amour」
-- 엘가 사랑의 인사 Op. 12(바이올린·피아노 원곡). 손 작품 268 을 남기고 MBID·대표곡 표시를 옮긴다. 1964(네덜란드어 노래판)는 다른 작품이라 그대로 둔다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 268 AND kept.composer_id = 64
    AND kept.title = '사랑의 인사' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 33052 AND hidden.composer_id = 64 AND hidden.title = 'Salut d’amour'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 268
WHERE piece_id = 33052 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 268
WHERE piece_id = 33052 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 268
WHERE piece_id = 33052 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 268
WHERE piece_id = 33052 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 268
WHERE piece_id = 33052 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 268
WHERE piece_id = 33052 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 268
WHERE piece_id = 33052 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 268
WHERE piece_id = 33052 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 268
WHERE piece_id = 33052 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 268
WHERE piece_id = 33052 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 268
WHERE piece_id = 33052 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 268
WHERE from_piece_id = 33052 AND to_piece_id <> 268 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 268
WHERE to_piece_id = 33052 AND from_piece_id <> 268 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 268, part_id = NULL
WHERE piece_id = 33052 AND composer_id = 64 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 268
WHERE piece_id = 33052 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 268
    WHERE hidden_piece.id = 33052 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = 'Salut d’amour' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33052 AND hidden.composer_id = 64
    AND hidden.title = 'Salut d’amour' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 268 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33052 AND hidden.composer_id = 64
    AND hidden.title = 'Salut d’amour' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 268 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33052 AND hidden.composer_id = 64
    AND hidden.title = 'Salut d’amour' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 268 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33052 AND hidden.composer_id = 64
    AND hidden.title = 'Salut d’amour' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 268 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33052 AND hidden.composer_id = 64
    AND hidden.title = 'Salut d’amour' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 268 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33052 AND hidden.composer_id = 64
    AND hidden.title = 'Salut d’amour' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 268 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33052 AND hidden.composer_id = 64
    AND hidden.title = 'Salut d’amour' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 268 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 엘가: 459 「현을 위한 세레나데 E단조」 ← 33054 「현악 세레나데 E단조」
-- 엘가 현을 위한 세레나데 Op. 20. 손 작품 459 를 남기고 악장 3개·MBID 를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 459 AND kept.composer_id = 64
    AND kept.title = '현을 위한 세레나데 E단조' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 33054 AND hidden.composer_id = 64 AND hidden.title = '현악 세레나데 E단조'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 459
WHERE piece_id = 33054 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 459
WHERE piece_id = 33054 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 459
WHERE piece_id = 33054 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 459
WHERE piece_id = 33054 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 459
WHERE piece_id = 33054 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 459
WHERE piece_id = 33054 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 459
WHERE piece_id = 33054 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 459
WHERE piece_id = 33054 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 459
WHERE piece_id = 33054 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 459
WHERE piece_id = 33054 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 459
WHERE piece_id = 33054 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 459
WHERE from_piece_id = 33054 AND to_piece_id <> 459 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 459
WHERE to_piece_id = 33054 AND from_piece_id <> 459 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 459, part_id = part_id
WHERE piece_id = 33054 AND composer_id = 64 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 459
WHERE piece_id = 33054 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33054 AND hidden.composer_id = 64
    AND hidden.title = '현악 세레나데 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 459 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33054 AND hidden.composer_id = 64
    AND hidden.title = '현악 세레나데 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 459 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33054 AND hidden.composer_id = 64
    AND hidden.title = '현악 세레나데 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 459 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33054 AND hidden.composer_id = 64
    AND hidden.title = '현악 세레나데 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 459 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33054 AND hidden.composer_id = 64
    AND hidden.title = '현악 세레나데 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 459 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33054 AND hidden.composer_id = 64
    AND hidden.title = '현악 세레나데 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 459 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33054 AND hidden.composer_id = 64
    AND hidden.title = '현악 세레나데 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 459 AND kept.composer_id = 64 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 459
WHERE piece_id = 33054 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 459
    WHERE hidden_piece.id = 33054 AND hidden_piece.composer_id = 64
      AND hidden_piece.title = '현악 세레나데 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 64 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 459 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 33054 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 33054 AND link.piece_part_id IS NOT NULL);

-- 홀스트: 284 「모음곡 <행성>」 ← 33066 「The Planets Op. 32」, 10490 「The Planets」, 10408 「Die Planeten」
-- 홀스트 행성 Op. 32. 손 작품 284 를 남긴다. 33066 은 4차 카탈로그가 만든 같은 작품(악장 7개·MBID 를 옮김), 10490(「VIENNA performance」 MusicBrainz work)·10408(「Die Planeten」)은 같은 곡의 중복 work
UPDATE pieces hidden JOIN pieces kept ON kept.id = 284 AND kept.composer_id = 70
    AND kept.title = '모음곡 <행성>' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 33066 AND hidden.composer_id = 70 AND hidden.title = 'The Planets Op. 32'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 284
WHERE piece_id = 33066 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 284
WHERE piece_id = 33066 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 284
WHERE piece_id = 33066 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 284
WHERE piece_id = 33066 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 284
WHERE piece_id = 33066 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 284
WHERE piece_id = 33066 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 284
WHERE piece_id = 33066 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 284
WHERE piece_id = 33066 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 284
WHERE piece_id = 33066 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 284
WHERE piece_id = 33066 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 284
WHERE piece_id = 33066 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 284
WHERE from_piece_id = 33066 AND to_piece_id <> 284 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 284
WHERE to_piece_id = 33066 AND from_piece_id <> 284 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 284, part_id = part_id
WHERE piece_id = 33066 AND composer_id = 70 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 284
WHERE piece_id = 33066 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33066 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets Op. 32' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33066 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets Op. 32' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33066 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets Op. 32' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33066 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets Op. 32' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33066 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets Op. 32' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33066 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets Op. 32' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33066 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets Op. 32' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 284
WHERE piece_id = 33066 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 33066 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets Op. 32' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 284 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 33066 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 33066 AND link.piece_part_id IS NOT NULL);
UPDATE pieces hidden JOIN pieces kept ON kept.id = 284 AND kept.composer_id = 70
    AND kept.title = '모음곡 <행성>' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 10490 AND hidden.composer_id = 70 AND hidden.title = 'The Planets'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 284
WHERE piece_id = 10490 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 284
WHERE piece_id = 10490 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 284
WHERE piece_id = 10490 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 284
WHERE piece_id = 10490 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 284
WHERE piece_id = 10490 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 284
WHERE piece_id = 10490 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 284
WHERE piece_id = 10490 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 284
WHERE piece_id = 10490 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 284
WHERE piece_id = 10490 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 284
WHERE piece_id = 10490 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 284
WHERE piece_id = 10490 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 284
WHERE from_piece_id = 10490 AND to_piece_id <> 284 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 284
WHERE to_piece_id = 10490 AND from_piece_id <> 284 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 284, part_id = part_id
WHERE piece_id = 10490 AND composer_id = 70 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 284
WHERE piece_id = 10490 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10490 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10490 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10490 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10490 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10490 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10490 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10490 AND hidden.composer_id = 70
    AND hidden.title = 'The Planets' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 284
WHERE piece_id = 10490 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10490 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'The Planets' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 284 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 10490 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 10490 AND link.piece_part_id IS NOT NULL);
UPDATE pieces hidden JOIN pieces kept ON kept.id = 284 AND kept.composer_id = 70
    AND kept.title = '모음곡 <행성>' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 10408 AND hidden.composer_id = 70 AND hidden.title = 'Die Planeten'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 284
WHERE piece_id = 10408 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 284
WHERE piece_id = 10408 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 284
WHERE piece_id = 10408 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 284
WHERE piece_id = 10408 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 284
WHERE piece_id = 10408 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 284
WHERE piece_id = 10408 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 284
WHERE piece_id = 10408 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 284
WHERE piece_id = 10408 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 284
WHERE piece_id = 10408 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 284
WHERE piece_id = 10408 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 284
WHERE piece_id = 10408 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 284
WHERE from_piece_id = 10408 AND to_piece_id <> 284 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 284
WHERE to_piece_id = 10408 AND from_piece_id <> 284 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 284, part_id = part_id
WHERE piece_id = 10408 AND composer_id = 70 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 284
WHERE piece_id = 10408 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10408 AND hidden.composer_id = 70
    AND hidden.title = 'Die Planeten' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10408 AND hidden.composer_id = 70
    AND hidden.title = 'Die Planeten' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10408 AND hidden.composer_id = 70
    AND hidden.title = 'Die Planeten' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10408 AND hidden.composer_id = 70
    AND hidden.title = 'Die Planeten' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10408 AND hidden.composer_id = 70
    AND hidden.title = 'Die Planeten' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10408 AND hidden.composer_id = 70
    AND hidden.title = 'Die Planeten' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10408 AND hidden.composer_id = 70
    AND hidden.title = 'Die Planeten' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 284 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 284
WHERE piece_id = 10408 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 284
    WHERE hidden_piece.id = 10408 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = 'Die Planeten' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 284 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 10408 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 10408 AND link.piece_part_id IS NOT NULL);

-- 홀스트: 285 「세인트 폴 모음곡」 ← 10837 「현악 합주를 위한 세인트 폴 모음곡」
-- 홀스트 세인트 폴 모음곡 Op. 29 No. 2. 손 작품 285 를 남기고 악장 4개·MBID·대표곡 표시를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 285 AND kept.composer_id = 70
    AND kept.title = '세인트 폴 모음곡' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 10837 AND hidden.composer_id = 70 AND hidden.title = '현악 합주를 위한 세인트 폴 모음곡'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 285
WHERE piece_id = 10837 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 285
WHERE piece_id = 10837 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 285
WHERE piece_id = 10837 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 285
WHERE piece_id = 10837 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 285
WHERE piece_id = 10837 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 285
WHERE piece_id = 10837 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 285
WHERE piece_id = 10837 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 285
WHERE piece_id = 10837 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 285
WHERE piece_id = 10837 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 285
WHERE piece_id = 10837 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 285
WHERE piece_id = 10837 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 285
WHERE from_piece_id = 10837 AND to_piece_id <> 285 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 285
WHERE to_piece_id = 10837 AND from_piece_id <> 285 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 285, part_id = part_id
WHERE piece_id = 10837 AND composer_id = 70 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 285
WHERE piece_id = 10837 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10837 AND hidden.composer_id = 70
    AND hidden.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 285 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10837 AND hidden.composer_id = 70
    AND hidden.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 285 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10837 AND hidden.composer_id = 70
    AND hidden.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 285 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10837 AND hidden.composer_id = 70
    AND hidden.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 285 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10837 AND hidden.composer_id = 70
    AND hidden.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 285 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10837 AND hidden.composer_id = 70
    AND hidden.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 285 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10837 AND hidden.composer_id = 70
    AND hidden.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 285 AND kept.composer_id = 70 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 285
WHERE piece_id = 10837 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 285
    WHERE hidden_piece.id = 10837 AND hidden_piece.composer_id = 70
      AND hidden_piece.title = '현악 합주를 위한 세인트 폴 모음곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 70 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 285 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 10837 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 10837 AND link.piece_part_id IS NOT NULL);

-- 부르크뮐러: 289 「25개의 점진적인 연습곡」 ← 11658 「25 Études faciles et progressives Op. 100」
-- 부르크뮐러 25개의 연습곡 Op. 100(6차 README 의 한계). 손 작품 289 를 남기고 25곡·MBID 를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 289 AND kept.composer_id = 72
    AND kept.title = '25개의 점진적인 연습곡' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 11658 AND hidden.composer_id = 72 AND hidden.title = '25 Études faciles et progressives Op. 100'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 289
WHERE piece_id = 11658 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 289
WHERE piece_id = 11658 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 289
WHERE piece_id = 11658 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 289
WHERE piece_id = 11658 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 289
WHERE piece_id = 11658 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 289
WHERE piece_id = 11658 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 289
WHERE piece_id = 11658 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 289
WHERE piece_id = 11658 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 289
WHERE piece_id = 11658 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 289
WHERE piece_id = 11658 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 289
WHERE piece_id = 11658 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 289
WHERE from_piece_id = 11658 AND to_piece_id <> 289 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 289
WHERE to_piece_id = 11658 AND from_piece_id <> 289 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 289, part_id = part_id
WHERE piece_id = 11658 AND composer_id = 72 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 289
WHERE piece_id = 11658 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11658 AND hidden.composer_id = 72
    AND hidden.title = '25 Études faciles et progressives Op. 100' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 289 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11658 AND hidden.composer_id = 72
    AND hidden.title = '25 Études faciles et progressives Op. 100' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 289 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11658 AND hidden.composer_id = 72
    AND hidden.title = '25 Études faciles et progressives Op. 100' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 289 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11658 AND hidden.composer_id = 72
    AND hidden.title = '25 Études faciles et progressives Op. 100' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 289 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11658 AND hidden.composer_id = 72
    AND hidden.title = '25 Études faciles et progressives Op. 100' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 289 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11658 AND hidden.composer_id = 72
    AND hidden.title = '25 Études faciles et progressives Op. 100' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 289 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11658 AND hidden.composer_id = 72
    AND hidden.title = '25 Études faciles et progressives Op. 100' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 289 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 289
WHERE piece_id = 11658 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 289
    WHERE hidden_piece.id = 11658 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '25 Études faciles et progressives Op. 100' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 289 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 11658 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 11658 AND link.piece_part_id IS NOT NULL);

-- 부르크뮐러: 290 「18개의 성격 연습곡」 ← 11781 「18개의 연습곡 Op. 109」
-- 부르크뮐러 18개의 연습곡 Op. 109. 손 작품 290 을 남기고 18곡·MBID 를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 290 AND kept.composer_id = 72
    AND kept.title = '18개의 성격 연습곡' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 11781 AND hidden.composer_id = 72 AND hidden.title = '18개의 연습곡 Op. 109'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 290
WHERE piece_id = 11781 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 290
WHERE piece_id = 11781 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 290
WHERE piece_id = 11781 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 290
WHERE piece_id = 11781 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 290
WHERE piece_id = 11781 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 290
WHERE piece_id = 11781 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 290
WHERE piece_id = 11781 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 290
WHERE piece_id = 11781 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 290
WHERE piece_id = 11781 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 290
WHERE piece_id = 11781 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 290
WHERE piece_id = 11781 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 290
WHERE from_piece_id = 11781 AND to_piece_id <> 290 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 290
WHERE to_piece_id = 11781 AND from_piece_id <> 290 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 290, part_id = part_id
WHERE piece_id = 11781 AND composer_id = 72 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 290
WHERE piece_id = 11781 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11781 AND hidden.composer_id = 72
    AND hidden.title = '18개의 연습곡 Op. 109' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 290 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11781 AND hidden.composer_id = 72
    AND hidden.title = '18개의 연습곡 Op. 109' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 290 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11781 AND hidden.composer_id = 72
    AND hidden.title = '18개의 연습곡 Op. 109' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 290 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11781 AND hidden.composer_id = 72
    AND hidden.title = '18개의 연습곡 Op. 109' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 290 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11781 AND hidden.composer_id = 72
    AND hidden.title = '18개의 연습곡 Op. 109' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 290 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11781 AND hidden.composer_id = 72
    AND hidden.title = '18개의 연습곡 Op. 109' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 290 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11781 AND hidden.composer_id = 72
    AND hidden.title = '18개의 연습곡 Op. 109' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 290 AND kept.composer_id = 72 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 290
WHERE piece_id = 11781 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 290
    WHERE hidden_piece.id = 11781 AND hidden_piece.composer_id = 72
      AND hidden_piece.title = '18개의 연습곡 Op. 109' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 72 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 290 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 11781 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 11781 AND link.piece_part_id IS NOT NULL);

-- 닐센: 300 「교향곡 4번 "불멸"」 ← 10796 「교향곡 4번 "The Inextinguishable"」
-- 닐센 교향곡 4번 Op. 29, FS 76. 손 작품 300 을 남기고 악장 4개·MBID·대표곡 표시를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 300 AND kept.composer_id = 77
    AND kept.title = '교향곡 4번 "불멸"' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 10796 AND hidden.composer_id = 77 AND hidden.title = '교향곡 4번 "The Inextinguishable"'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 300
WHERE piece_id = 10796 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 300
WHERE piece_id = 10796 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 300
WHERE piece_id = 10796 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 300
WHERE piece_id = 10796 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 300
WHERE piece_id = 10796 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 300
WHERE piece_id = 10796 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 300
WHERE piece_id = 10796 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 300
WHERE piece_id = 10796 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 300
WHERE piece_id = 10796 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 300
WHERE piece_id = 10796 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 300
WHERE piece_id = 10796 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 300
WHERE from_piece_id = 10796 AND to_piece_id <> 300 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 300
WHERE to_piece_id = 10796 AND from_piece_id <> 300 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 300, part_id = part_id
WHERE piece_id = 10796 AND composer_id = 77 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 300
WHERE piece_id = 10796 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10796 AND hidden.composer_id = 77
    AND hidden.title = '교향곡 4번 "The Inextinguishable"' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 300 AND kept.composer_id = 77 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10796 AND hidden.composer_id = 77
    AND hidden.title = '교향곡 4번 "The Inextinguishable"' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 300 AND kept.composer_id = 77 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10796 AND hidden.composer_id = 77
    AND hidden.title = '교향곡 4번 "The Inextinguishable"' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 300 AND kept.composer_id = 77 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10796 AND hidden.composer_id = 77
    AND hidden.title = '교향곡 4번 "The Inextinguishable"' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 300 AND kept.composer_id = 77 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10796 AND hidden.composer_id = 77
    AND hidden.title = '교향곡 4번 "The Inextinguishable"' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 300 AND kept.composer_id = 77 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10796 AND hidden.composer_id = 77
    AND hidden.title = '교향곡 4번 "The Inextinguishable"' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 300 AND kept.composer_id = 77 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10796 AND hidden.composer_id = 77
    AND hidden.title = '교향곡 4번 "The Inextinguishable"' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 300 AND kept.composer_id = 77 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 300
WHERE piece_id = 10796 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 300
    WHERE hidden_piece.id = 10796 AND hidden_piece.composer_id = 77
      AND hidden_piece.title = '교향곡 4번 "The Inextinguishable"' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 77 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 300 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 10796 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 10796 AND link.piece_part_id IS NOT NULL);

-- 파야: 306 「발레 <사랑은 마술사>」 ← 33412 「발레 <El amor brujo>」
-- 파야 사랑은 마술사(1915 원판). 손 작품 306 을 남기고 16곡·MBID·대표곡 표시를 옮긴다. 8087(G. 69 피아노 모음곡)은 다른 판이라 그대로 둔다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 306 AND kept.composer_id = 80
    AND kept.title = '발레 <사랑은 마술사>' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 33412 AND hidden.composer_id = 80 AND hidden.title = '발레 <El amor brujo>'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 306
WHERE piece_id = 33412 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 306
WHERE piece_id = 33412 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 306
WHERE piece_id = 33412 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 306
WHERE piece_id = 33412 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 306
WHERE piece_id = 33412 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 306
WHERE piece_id = 33412 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 306
WHERE piece_id = 33412 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 306
WHERE piece_id = 33412 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 306
WHERE piece_id = 33412 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 306
WHERE piece_id = 33412 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 306
WHERE piece_id = 33412 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 306
WHERE from_piece_id = 33412 AND to_piece_id <> 306 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 306
WHERE to_piece_id = 33412 AND from_piece_id <> 306 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 306, part_id = part_id
WHERE piece_id = 33412 AND composer_id = 80 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 306
WHERE piece_id = 33412 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33412 AND hidden.composer_id = 80
    AND hidden.title = '발레 <El amor brujo>' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 306 AND kept.composer_id = 80 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33412 AND hidden.composer_id = 80
    AND hidden.title = '발레 <El amor brujo>' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 306 AND kept.composer_id = 80 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33412 AND hidden.composer_id = 80
    AND hidden.title = '발레 <El amor brujo>' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 306 AND kept.composer_id = 80 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33412 AND hidden.composer_id = 80
    AND hidden.title = '발레 <El amor brujo>' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 306 AND kept.composer_id = 80 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33412 AND hidden.composer_id = 80
    AND hidden.title = '발레 <El amor brujo>' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 306 AND kept.composer_id = 80 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33412 AND hidden.composer_id = 80
    AND hidden.title = '발레 <El amor brujo>' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 306 AND kept.composer_id = 80 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 33412 AND hidden.composer_id = 80
    AND hidden.title = '발레 <El amor brujo>' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 306 AND kept.composer_id = 80 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 306
WHERE piece_id = 33412 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 306
    WHERE hidden_piece.id = 33412 AND hidden_piece.composer_id = 80
      AND hidden_piece.title = '발레 <El amor brujo>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 80 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 306 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 33412 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 33412 AND link.piece_part_id IS NOT NULL);

-- 안익태: 340 「애국가」 ← 11348 「애국가 (South Korea)」
-- 안익태 애국가. 카드가 있는 340 을 남기고 MBID·별칭(Aegukga·愛國歌)·대표곡 표시를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 340 AND kept.composer_id = 88
    AND kept.title = '애국가' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 11348 AND hidden.composer_id = 88 AND hidden.title = '애국가 (South Korea)'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 340
WHERE piece_id = 11348 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 340
WHERE piece_id = 11348 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 340
WHERE piece_id = 11348 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 340
WHERE piece_id = 11348 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 340
WHERE piece_id = 11348 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 340
WHERE piece_id = 11348 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 340
WHERE piece_id = 11348 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 340
WHERE piece_id = 11348 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 340
WHERE piece_id = 11348 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 340
WHERE piece_id = 11348 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 340
WHERE piece_id = 11348 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 340
WHERE from_piece_id = 11348 AND to_piece_id <> 340 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 340
WHERE to_piece_id = 11348 AND from_piece_id <> 340 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 340, part_id = NULL
WHERE piece_id = 11348 AND composer_id = 88 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 340
WHERE piece_id = 11348 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 340
    WHERE hidden_piece.id = 11348 AND hidden_piece.composer_id = 88
      AND hidden_piece.title = '애국가 (South Korea)' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 88 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11348 AND hidden.composer_id = 88
    AND hidden.title = '애국가 (South Korea)' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 340 AND kept.composer_id = 88 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11348 AND hidden.composer_id = 88
    AND hidden.title = '애국가 (South Korea)' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 340 AND kept.composer_id = 88 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11348 AND hidden.composer_id = 88
    AND hidden.title = '애국가 (South Korea)' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 340 AND kept.composer_id = 88 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11348 AND hidden.composer_id = 88
    AND hidden.title = '애국가 (South Korea)' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 340 AND kept.composer_id = 88 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11348 AND hidden.composer_id = 88
    AND hidden.title = '애국가 (South Korea)' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 340 AND kept.composer_id = 88 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11348 AND hidden.composer_id = 88
    AND hidden.title = '애국가 (South Korea)' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 340 AND kept.composer_id = 88 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 11348 AND hidden.composer_id = 88
    AND hidden.title = '애국가 (South Korea)' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 340 AND kept.composer_id = 88 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 케이지: 351 「4분 33초」 ← 767 「4′33″」
-- 케이지 4분 33초. 카드가 있는 351 을 남기고 악장 3개·MBID·ISWC·대표곡 표시를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 351 AND kept.composer_id = 92
    AND kept.title = '4분 33초' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 767 AND hidden.composer_id = 92 AND hidden.title = '4′33″'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 351
WHERE piece_id = 767 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 351
WHERE piece_id = 767 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 351
WHERE piece_id = 767 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 351
WHERE piece_id = 767 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 351
WHERE piece_id = 767 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 351
WHERE piece_id = 767 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 351
WHERE piece_id = 767 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 351
WHERE piece_id = 767 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 351
WHERE piece_id = 767 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 351
WHERE piece_id = 767 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 351
WHERE piece_id = 767 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 351
WHERE from_piece_id = 767 AND to_piece_id <> 351 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 351
WHERE to_piece_id = 767 AND from_piece_id <> 351 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 351, part_id = part_id
WHERE piece_id = 767 AND composer_id = 92 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 351
WHERE piece_id = 767 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 767 AND hidden.composer_id = 92
    AND hidden.title = '4′33″' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 351 AND kept.composer_id = 92 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 767 AND hidden.composer_id = 92
    AND hidden.title = '4′33″' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 351 AND kept.composer_id = 92 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 767 AND hidden.composer_id = 92
    AND hidden.title = '4′33″' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 351 AND kept.composer_id = 92 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 767 AND hidden.composer_id = 92
    AND hidden.title = '4′33″' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 351 AND kept.composer_id = 92 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 767 AND hidden.composer_id = 92
    AND hidden.title = '4′33″' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 351 AND kept.composer_id = 92 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 767 AND hidden.composer_id = 92
    AND hidden.title = '4′33″' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 351 AND kept.composer_id = 92 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 767 AND hidden.composer_id = 92
    AND hidden.title = '4′33″' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 351 AND kept.composer_id = 92 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 351
WHERE piece_id = 767 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 351
    WHERE hidden_piece.id = 767 AND hidden_piece.composer_id = 92
      AND hidden_piece.title = '4′33″' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 92 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 351 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 767 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 767 AND link.piece_part_id IS NOT NULL);

-- 필립 글래스: 355 「영화 <디 아워스> 사운드트랙」 ← 32829 「영화음악 <The Hours>」
-- 필립 글래스 영화 <디 아워스> 음악. 카드가 있는 355 를 남기고 12곡·MBID 를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 355 AND kept.composer_id = 93
    AND kept.title = '영화 <디 아워스> 사운드트랙' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 32829 AND hidden.composer_id = 93 AND hidden.title = '영화음악 <The Hours>'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 355
WHERE piece_id = 32829 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 355
WHERE piece_id = 32829 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 355
WHERE piece_id = 32829 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 355
WHERE piece_id = 32829 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 355
WHERE piece_id = 32829 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 355
WHERE piece_id = 32829 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 355
WHERE piece_id = 32829 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 355
WHERE piece_id = 32829 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 355
WHERE piece_id = 32829 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 355
WHERE piece_id = 32829 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 355
WHERE piece_id = 32829 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 355
WHERE from_piece_id = 32829 AND to_piece_id <> 355 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 355
WHERE to_piece_id = 32829 AND from_piece_id <> 355 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 355, part_id = part_id
WHERE piece_id = 32829 AND composer_id = 93 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 355
WHERE piece_id = 32829 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 32829 AND hidden.composer_id = 93
    AND hidden.title = '영화음악 <The Hours>' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 355 AND kept.composer_id = 93 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 32829 AND hidden.composer_id = 93
    AND hidden.title = '영화음악 <The Hours>' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 355 AND kept.composer_id = 93 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 32829 AND hidden.composer_id = 93
    AND hidden.title = '영화음악 <The Hours>' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 355 AND kept.composer_id = 93 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 32829 AND hidden.composer_id = 93
    AND hidden.title = '영화음악 <The Hours>' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 355 AND kept.composer_id = 93 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 32829 AND hidden.composer_id = 93
    AND hidden.title = '영화음악 <The Hours>' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 355 AND kept.composer_id = 93 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 32829 AND hidden.composer_id = 93
    AND hidden.title = '영화음악 <The Hours>' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 355 AND kept.composer_id = 93 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 32829 AND hidden.composer_id = 93
    AND hidden.title = '영화음악 <The Hours>' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 355 AND kept.composer_id = 93 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 355
WHERE piece_id = 32829 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 355
    WHERE hidden_piece.id = 32829 AND hidden_piece.composer_id = 93
      AND hidden_piece.title = '영화음악 <The Hours>' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 93 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 355 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 32829 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 32829 AND link.piece_part_id IS NOT NULL);

-- 메시앙: 361 「20개의 시선으로 아기 예수를 바라보다」 ← 656 「아기 예수를 바라보는 20개의 시선」
-- 메시앙 아기 예수를 바라보는 20개의 시선. 카드가 있는 361 을 남기고 20곡·MBID·ISWC·별칭·대표곡 표시를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 361 AND kept.composer_id = 95
    AND kept.title = '20개의 시선으로 아기 예수를 바라보다' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 656 AND hidden.composer_id = 95 AND hidden.title = '아기 예수를 바라보는 20개의 시선'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 361
WHERE piece_id = 656 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 361
WHERE piece_id = 656 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 361
WHERE piece_id = 656 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 361
WHERE piece_id = 656 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 361
WHERE piece_id = 656 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 361
WHERE piece_id = 656 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 361
WHERE piece_id = 656 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 361
WHERE piece_id = 656 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 361
WHERE piece_id = 656 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 361
WHERE piece_id = 656 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 361
WHERE piece_id = 656 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 361
WHERE from_piece_id = 656 AND to_piece_id <> 361 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 361
WHERE to_piece_id = 656 AND from_piece_id <> 361 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 361, part_id = part_id
WHERE piece_id = 656 AND composer_id = 95 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 361
WHERE piece_id = 656 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 656 AND hidden.composer_id = 95
    AND hidden.title = '아기 예수를 바라보는 20개의 시선' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 361 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 656 AND hidden.composer_id = 95
    AND hidden.title = '아기 예수를 바라보는 20개의 시선' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 361 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 656 AND hidden.composer_id = 95
    AND hidden.title = '아기 예수를 바라보는 20개의 시선' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 361 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 656 AND hidden.composer_id = 95
    AND hidden.title = '아기 예수를 바라보는 20개의 시선' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 361 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 656 AND hidden.composer_id = 95
    AND hidden.title = '아기 예수를 바라보는 20개의 시선' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 361 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 656 AND hidden.composer_id = 95
    AND hidden.title = '아기 예수를 바라보는 20개의 시선' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 361 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 656 AND hidden.composer_id = 95
    AND hidden.title = '아기 예수를 바라보는 20개의 시선' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 361 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 361
WHERE piece_id = 656 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 361
    WHERE hidden_piece.id = 656 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = '아기 예수를 바라보는 20개의 시선' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 361 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 656 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 656 AND link.piece_part_id IS NOT NULL);

-- 메시앙: 363 「새의 카탈로그」 ← 683 「Catalogue d’oiseaux, I/42」
-- 메시앙 새의 카탈로그. 카드가 있는 363 을 남기고 13곡·MBID·ISWC 를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 363 AND kept.composer_id = 95
    AND kept.title = '새의 카탈로그' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 683 AND hidden.composer_id = 95 AND hidden.title = 'Catalogue d’oiseaux, I/42'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 363
WHERE piece_id = 683 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 363
WHERE piece_id = 683 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 363
WHERE piece_id = 683 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 363
WHERE piece_id = 683 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 363
WHERE piece_id = 683 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 363
WHERE piece_id = 683 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 363
WHERE piece_id = 683 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 363
WHERE piece_id = 683 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 363
WHERE piece_id = 683 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 363
WHERE piece_id = 683 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 363
WHERE piece_id = 683 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 363
WHERE from_piece_id = 683 AND to_piece_id <> 363 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 363
WHERE to_piece_id = 683 AND from_piece_id <> 363 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 363, part_id = part_id
WHERE piece_id = 683 AND composer_id = 95 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 363
WHERE piece_id = 683 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 683 AND hidden.composer_id = 95
    AND hidden.title = 'Catalogue d’oiseaux, I/42' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 363 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 683 AND hidden.composer_id = 95
    AND hidden.title = 'Catalogue d’oiseaux, I/42' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 363 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 683 AND hidden.composer_id = 95
    AND hidden.title = 'Catalogue d’oiseaux, I/42' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 363 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 683 AND hidden.composer_id = 95
    AND hidden.title = 'Catalogue d’oiseaux, I/42' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 363 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 683 AND hidden.composer_id = 95
    AND hidden.title = 'Catalogue d’oiseaux, I/42' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 363 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 683 AND hidden.composer_id = 95
    AND hidden.title = 'Catalogue d’oiseaux, I/42' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 363 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 683 AND hidden.composer_id = 95
    AND hidden.title = 'Catalogue d’oiseaux, I/42' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 363 AND kept.composer_id = 95 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 363
WHERE piece_id = 683 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 363
    WHERE hidden_piece.id = 683 AND hidden_piece.composer_id = 95
      AND hidden_piece.title = 'Catalogue d’oiseaux, I/42' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 95 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 363 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 683 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 683 AND link.piece_part_id IS NOT NULL);

-- 베르크: 33352 「4개의 가곡」 ← 12557 「4 Gesänge Op. 2」
-- 베르크 4개의 가곡 Op. 2. 네 곡이 다 있는 33352 를 남긴다(12557 은 첫 곡 하나만 가진 같은 work)
UPDATE pieces hidden JOIN pieces kept ON kept.id = 33352 AND kept.composer_id = 96
    AND kept.title = '4개의 가곡' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 12557 AND hidden.composer_id = 96 AND hidden.title = '4 Gesänge Op. 2'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 33352
WHERE piece_id = 12557 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 33352
WHERE piece_id = 12557 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 33352
WHERE piece_id = 12557 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 33352
WHERE piece_id = 12557 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 33352
WHERE piece_id = 12557 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 33352
WHERE piece_id = 12557 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 33352
WHERE piece_id = 12557 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 33352
WHERE piece_id = 12557 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 33352
WHERE piece_id = 12557 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 33352
WHERE piece_id = 12557 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 33352
WHERE piece_id = 12557 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 33352
WHERE from_piece_id = 12557 AND to_piece_id <> 33352 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 33352
WHERE to_piece_id = 12557 AND from_piece_id <> 33352 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 33352, part_id = NULL
WHERE piece_id = 12557 AND composer_id = 96 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 33352
WHERE piece_id = 12557 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33352
    WHERE hidden_piece.id = 12557 AND hidden_piece.composer_id = 96
      AND hidden_piece.title = '4 Gesänge Op. 2' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 96 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12557 AND hidden.composer_id = 96
    AND hidden.title = '4 Gesänge Op. 2' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 33352 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12557 AND hidden.composer_id = 96
    AND hidden.title = '4 Gesänge Op. 2' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 33352 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12557 AND hidden.composer_id = 96
    AND hidden.title = '4 Gesänge Op. 2' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 33352 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12557 AND hidden.composer_id = 96
    AND hidden.title = '4 Gesänge Op. 2' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 33352 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12557 AND hidden.composer_id = 96
    AND hidden.title = '4 Gesänge Op. 2' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 33352 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12557 AND hidden.composer_id = 96
    AND hidden.title = '4 Gesänge Op. 2' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 33352 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 12557 AND hidden.composer_id = 96
    AND hidden.title = '4 Gesänge Op. 2' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 33352 AND kept.composer_id = 96 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 야나체크: 8542 「Pochod modráčků JW 7/9」 ← 7526 「Pochod modráčků」
-- 야나체크 Pochod modráčků JW 7/9(피콜로·피아노). JW 번호가 있는 8542 를 남기고 MBID·영어 별칭을 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 8542 AND kept.composer_id = 104
    AND kept.title = 'Pochod modráčků JW 7/9' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 7526 AND hidden.composer_id = 104 AND hidden.title = 'Pochod modráčků'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 8542
WHERE piece_id = 7526 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 8542
WHERE piece_id = 7526 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 8542
WHERE piece_id = 7526 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 8542
WHERE piece_id = 7526 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 8542
WHERE piece_id = 7526 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 8542
WHERE piece_id = 7526 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 8542
WHERE piece_id = 7526 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 8542
WHERE piece_id = 7526 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 8542
WHERE piece_id = 7526 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 8542
WHERE piece_id = 7526 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 8542
WHERE piece_id = 7526 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 8542
WHERE from_piece_id = 7526 AND to_piece_id <> 8542 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 8542
WHERE to_piece_id = 7526 AND from_piece_id <> 8542 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 8542, part_id = NULL
WHERE piece_id = 7526 AND composer_id = 104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 8542
WHERE piece_id = 7526 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 8542
    WHERE hidden_piece.id = 7526 AND hidden_piece.composer_id = 104
      AND hidden_piece.title = 'Pochod modráčků' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 104 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7526 AND hidden.composer_id = 104
    AND hidden.title = 'Pochod modráčků' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 8542 AND kept.composer_id = 104 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7526 AND hidden.composer_id = 104
    AND hidden.title = 'Pochod modráčků' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 8542 AND kept.composer_id = 104 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7526 AND hidden.composer_id = 104
    AND hidden.title = 'Pochod modráčků' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 8542 AND kept.composer_id = 104 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7526 AND hidden.composer_id = 104
    AND hidden.title = 'Pochod modráčků' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 8542 AND kept.composer_id = 104 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7526 AND hidden.composer_id = 104
    AND hidden.title = 'Pochod modráčků' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 8542 AND kept.composer_id = 104 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7526 AND hidden.composer_id = 104
    AND hidden.title = 'Pochod modráčků' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 8542 AND kept.composer_id = 104 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 7526 AND hidden.composer_id = 104
    AND hidden.title = 'Pochod modráčků' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 8542 AND kept.composer_id = 104 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 풀랑크: 405 「3개의 무궁동」 ← 10712 「Trois mouvements perpétuels, FP 14a」
-- 풀랑크 3개의 무궁동 FP 14(a). 손 작품 405 를 남기고 3곡·MBID·편곡 관계 3개를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 405 AND kept.composer_id = 107
    AND kept.title = '3개의 무궁동' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 10712 AND hidden.composer_id = 107 AND hidden.title = 'Trois mouvements perpétuels, FP 14a'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 405
WHERE piece_id = 10712 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 405
WHERE piece_id = 10712 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 405
WHERE piece_id = 10712 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 405
WHERE piece_id = 10712 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 405
WHERE piece_id = 10712 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 405
WHERE piece_id = 10712 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 405
WHERE piece_id = 10712 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 405
WHERE piece_id = 10712 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 405
WHERE piece_id = 10712 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 405
WHERE piece_id = 10712 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 405
WHERE piece_id = 10712 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 405
WHERE from_piece_id = 10712 AND to_piece_id <> 405 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 405
WHERE to_piece_id = 10712 AND from_piece_id <> 405 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 405, part_id = part_id
WHERE piece_id = 10712 AND composer_id = 107 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 405
WHERE piece_id = 10712 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10712 AND hidden.composer_id = 107
    AND hidden.title = 'Trois mouvements perpétuels, FP 14a' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 405 AND kept.composer_id = 107 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10712 AND hidden.composer_id = 107
    AND hidden.title = 'Trois mouvements perpétuels, FP 14a' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 405 AND kept.composer_id = 107 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10712 AND hidden.composer_id = 107
    AND hidden.title = 'Trois mouvements perpétuels, FP 14a' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 405 AND kept.composer_id = 107 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10712 AND hidden.composer_id = 107
    AND hidden.title = 'Trois mouvements perpétuels, FP 14a' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 405 AND kept.composer_id = 107 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10712 AND hidden.composer_id = 107
    AND hidden.title = 'Trois mouvements perpétuels, FP 14a' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 405 AND kept.composer_id = 107 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10712 AND hidden.composer_id = 107
    AND hidden.title = 'Trois mouvements perpétuels, FP 14a' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 405 AND kept.composer_id = 107 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 10712 AND hidden.composer_id = 107
    AND hidden.title = 'Trois mouvements perpétuels, FP 14a' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 405 AND kept.composer_id = 107 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
UPDATE piece_parts SET piece_id = 405
WHERE piece_id = 10712 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 405
    WHERE hidden_piece.id = 10712 AND hidden_piece.composer_id = 107
      AND hidden_piece.title = 'Trois mouvements perpétuels, FP 14a' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 107 AND kept_piece.hidden_reason IS NULL)
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 405 LIMIT 1) AS kept_parts) = 0
  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = 10712 AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0
  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = 10712 AND link.piece_part_id IS NOT NULL);

-- 슈토크하우젠: 407 「소년의 노래」 ← 1256 「Gesang der Jünglinge, Nr. 8」
-- 슈토크하우젠 소년의 노래 Nr. 8. 손 작품 407 을 남기고 MBID 를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 407 AND kept.composer_id = 108
    AND kept.title = '소년의 노래' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 1256 AND hidden.composer_id = 108 AND hidden.title = 'Gesang der Jünglinge, Nr. 8'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 407
WHERE piece_id = 1256 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 407
WHERE piece_id = 1256 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 407
WHERE piece_id = 1256 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 407
WHERE piece_id = 1256 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 407
WHERE piece_id = 1256 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 407
WHERE piece_id = 1256 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 407
WHERE piece_id = 1256 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 407
WHERE piece_id = 1256 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 407
WHERE piece_id = 1256 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 407
WHERE piece_id = 1256 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 407
WHERE piece_id = 1256 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 407
WHERE from_piece_id = 1256 AND to_piece_id <> 407 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 407
WHERE to_piece_id = 1256 AND from_piece_id <> 407 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 407, part_id = NULL
WHERE piece_id = 1256 AND composer_id = 108 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 407
WHERE piece_id = 1256 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 407
    WHERE hidden_piece.id = 1256 AND hidden_piece.composer_id = 108
      AND hidden_piece.title = 'Gesang der Jünglinge, Nr. 8' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 108 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1256 AND hidden.composer_id = 108
    AND hidden.title = 'Gesang der Jünglinge, Nr. 8' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 407 AND kept.composer_id = 108 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1256 AND hidden.composer_id = 108
    AND hidden.title = 'Gesang der Jünglinge, Nr. 8' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 407 AND kept.composer_id = 108 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1256 AND hidden.composer_id = 108
    AND hidden.title = 'Gesang der Jünglinge, Nr. 8' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 407 AND kept.composer_id = 108 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1256 AND hidden.composer_id = 108
    AND hidden.title = 'Gesang der Jünglinge, Nr. 8' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 407 AND kept.composer_id = 108 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1256 AND hidden.composer_id = 108
    AND hidden.title = 'Gesang der Jünglinge, Nr. 8' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 407 AND kept.composer_id = 108 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1256 AND hidden.composer_id = 108
    AND hidden.title = 'Gesang der Jünglinge, Nr. 8' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 407 AND kept.composer_id = 108 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 1256 AND hidden.composer_id = 108
    AND hidden.title = 'Gesang der Jünglinge, Nr. 8' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 407 AND kept.composer_id = 108 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 베리오: 411 「세쿠엔차 III (여성 솔로를 위한)」 ← 8525 「Sequenza III for Woman's Voice」
-- 베리오 세쿠엔차 III. 손 작품 411 을 남기고 MBID 를 옮긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 411 AND kept.composer_id = 109
    AND kept.title = '세쿠엔차 III (여성 솔로를 위한)' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 8525 AND hidden.composer_id = 109 AND hidden.title = 'Sequenza III for Woman''s Voice'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 411
WHERE piece_id = 8525 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 411
WHERE piece_id = 8525 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 411
WHERE piece_id = 8525 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 411
WHERE piece_id = 8525 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 411
WHERE piece_id = 8525 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 411
WHERE piece_id = 8525 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 411
WHERE piece_id = 8525 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 411
WHERE piece_id = 8525 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 411
WHERE piece_id = 8525 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 411
WHERE piece_id = 8525 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 411
WHERE piece_id = 8525 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 411
WHERE from_piece_id = 8525 AND to_piece_id <> 411 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 411
WHERE to_piece_id = 8525 AND from_piece_id <> 411 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 411, part_id = NULL
WHERE piece_id = 8525 AND composer_id = 109 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 411
WHERE piece_id = 8525 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 411
    WHERE hidden_piece.id = 8525 AND hidden_piece.composer_id = 109
      AND hidden_piece.title = 'Sequenza III for Woman''s Voice' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 109 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8525 AND hidden.composer_id = 109
    AND hidden.title = 'Sequenza III for Woman''s Voice' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 411 AND kept.composer_id = 109 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8525 AND hidden.composer_id = 109
    AND hidden.title = 'Sequenza III for Woman''s Voice' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 411 AND kept.composer_id = 109 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8525 AND hidden.composer_id = 109
    AND hidden.title = 'Sequenza III for Woman''s Voice' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 411 AND kept.composer_id = 109 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8525 AND hidden.composer_id = 109
    AND hidden.title = 'Sequenza III for Woman''s Voice' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 411 AND kept.composer_id = 109 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8525 AND hidden.composer_id = 109
    AND hidden.title = 'Sequenza III for Woman''s Voice' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 411 AND kept.composer_id = 109 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8525 AND hidden.composer_id = 109
    AND hidden.title = 'Sequenza III for Woman''s Voice' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 411 AND kept.composer_id = 109 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 8525 AND hidden.composer_id = 109
    AND hidden.title = 'Sequenza III for Woman''s Voice' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 411 AND kept.composer_id = 109 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 루토스와프스키: 33433 「춤곡 전주곡」 ← 906 「춤곡 전주곡」
-- 루토스와프스키 춤곡 전주곡(같은 우리말 제목, 다섯 곡 같음). 5차 카탈로그 자리인 33433 을 남긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 33433 AND kept.composer_id = 110
    AND kept.title = '춤곡 전주곡' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 906 AND hidden.composer_id = 110 AND hidden.title = '춤곡 전주곡'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 33433
WHERE piece_id = 906 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 33433
WHERE piece_id = 906 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 33433
WHERE piece_id = 906 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 33433
WHERE piece_id = 906 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 33433
WHERE piece_id = 906 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 33433
WHERE piece_id = 906 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 33433
WHERE piece_id = 906 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 33433
WHERE piece_id = 906 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 33433
WHERE piece_id = 906 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 33433
WHERE piece_id = 906 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 33433
WHERE piece_id = 906 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 33433
WHERE from_piece_id = 906 AND to_piece_id <> 33433 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 33433
WHERE to_piece_id = 906 AND from_piece_id <> 33433 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 33433, part_id = NULL
WHERE piece_id = 906 AND composer_id = 110 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 33433
WHERE piece_id = 906 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 33433
    WHERE hidden_piece.id = 906 AND hidden_piece.composer_id = 110
      AND hidden_piece.title = '춤곡 전주곡' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 110 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 906 AND hidden.composer_id = 110
    AND hidden.title = '춤곡 전주곡' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 33433 AND kept.composer_id = 110 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 906 AND hidden.composer_id = 110
    AND hidden.title = '춤곡 전주곡' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 33433 AND kept.composer_id = 110 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 906 AND hidden.composer_id = 110
    AND hidden.title = '춤곡 전주곡' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 33433 AND kept.composer_id = 110 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 906 AND hidden.composer_id = 110
    AND hidden.title = '춤곡 전주곡' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 33433 AND kept.composer_id = 110 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 906 AND hidden.composer_id = 110
    AND hidden.title = '춤곡 전주곡' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 33433 AND kept.composer_id = 110 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 906 AND hidden.composer_id = 110
    AND hidden.title = '춤곡 전주곡' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 33433 AND kept.composer_id = 110 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 906 AND hidden.composer_id = 110
    AND hidden.title = '춤곡 전주곡' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 33433 AND kept.composer_id = 110 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 요제프 수크: 18402 「발라드와 세레나데 Op. 3」 ← 16682 「2 Skladby Op. 3」
-- 수크 발라드와 세레나데 Op. 3(= 2 Skladby). 우리말 제목이 있는 18402 를 남긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 18402 AND kept.composer_id = 207
    AND kept.title = '발라드와 세레나데 Op. 3' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 16682 AND hidden.composer_id = 207 AND hidden.title = '2 Skladby Op. 3'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 18402
WHERE piece_id = 16682 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 18402
WHERE piece_id = 16682 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 18402
WHERE piece_id = 16682 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 18402
WHERE piece_id = 16682 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 18402
WHERE piece_id = 16682 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 18402
WHERE piece_id = 16682 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 18402
WHERE piece_id = 16682 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 18402
WHERE piece_id = 16682 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 18402
WHERE piece_id = 16682 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 18402
WHERE piece_id = 16682 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 18402
WHERE piece_id = 16682 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 18402
WHERE from_piece_id = 16682 AND to_piece_id <> 18402 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 18402
WHERE to_piece_id = 16682 AND from_piece_id <> 18402 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 18402, part_id = NULL
WHERE piece_id = 16682 AND composer_id = 207 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 18402
WHERE piece_id = 16682 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 18402
    WHERE hidden_piece.id = 16682 AND hidden_piece.composer_id = 207
      AND hidden_piece.title = '2 Skladby Op. 3' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 207 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16682 AND hidden.composer_id = 207
    AND hidden.title = '2 Skladby Op. 3' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 18402 AND kept.composer_id = 207 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16682 AND hidden.composer_id = 207
    AND hidden.title = '2 Skladby Op. 3' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 18402 AND kept.composer_id = 207 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16682 AND hidden.composer_id = 207
    AND hidden.title = '2 Skladby Op. 3' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 18402 AND kept.composer_id = 207 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16682 AND hidden.composer_id = 207
    AND hidden.title = '2 Skladby Op. 3' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 18402 AND kept.composer_id = 207 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16682 AND hidden.composer_id = 207
    AND hidden.title = '2 Skladby Op. 3' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 18402 AND kept.composer_id = 207 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16682 AND hidden.composer_id = 207
    AND hidden.title = '2 Skladby Op. 3' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 18402 AND kept.composer_id = 207 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16682 AND hidden.composer_id = 207
    AND hidden.title = '2 Skladby Op. 3' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 18402 AND kept.composer_id = 207 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 이시이 마키: 19444 「Monochrome Op. 28」 ← 16222 「Monochrome」
-- 이시이 마키 Monochrome Op. 28. 작품번호가 있는 19444 를 남긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 19444 AND kept.composer_id = 278
    AND kept.title = 'Monochrome Op. 28' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 16222 AND hidden.composer_id = 278 AND hidden.title = 'Monochrome'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 19444
WHERE piece_id = 16222 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 19444
WHERE piece_id = 16222 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 19444
WHERE piece_id = 16222 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 19444
WHERE piece_id = 16222 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 19444
WHERE piece_id = 16222 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 19444
WHERE piece_id = 16222 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 19444
WHERE piece_id = 16222 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 19444
WHERE piece_id = 16222 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 19444
WHERE piece_id = 16222 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 19444
WHERE piece_id = 16222 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 19444
WHERE piece_id = 16222 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 19444
WHERE from_piece_id = 16222 AND to_piece_id <> 19444 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 19444
WHERE to_piece_id = 16222 AND from_piece_id <> 19444 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 19444, part_id = NULL
WHERE piece_id = 16222 AND composer_id = 278 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 19444
WHERE piece_id = 16222 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19444
    WHERE hidden_piece.id = 16222 AND hidden_piece.composer_id = 278
      AND hidden_piece.title = 'Monochrome' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 278 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16222 AND hidden.composer_id = 278
    AND hidden.title = 'Monochrome' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 19444 AND kept.composer_id = 278 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16222 AND hidden.composer_id = 278
    AND hidden.title = 'Monochrome' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 19444 AND kept.composer_id = 278 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16222 AND hidden.composer_id = 278
    AND hidden.title = 'Monochrome' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 19444 AND kept.composer_id = 278 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16222 AND hidden.composer_id = 278
    AND hidden.title = 'Monochrome' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 19444 AND kept.composer_id = 278 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16222 AND hidden.composer_id = 278
    AND hidden.title = 'Monochrome' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 19444 AND kept.composer_id = 278 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16222 AND hidden.composer_id = 278
    AND hidden.title = 'Monochrome' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 19444 AND kept.composer_id = 278 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 16222 AND hidden.composer_id = 278
    AND hidden.title = 'Monochrome' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 19444 AND kept.composer_id = 278 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);

-- 크리스티안 신딩: 19530 「로망스 E단조 Op. 30」 ← 19104 「로망스 E단조」
-- 신딩 로망스 E단조 Op. 30. 작품번호 칸이 채워진 19530 을 남긴다
UPDATE pieces hidden JOIN pieces kept ON kept.id = 19530 AND kept.composer_id = 283
    AND kept.title = '로망스 E단조 Op. 30' AND kept.hidden_reason IS NULL
SET hidden.hidden_reason = 'duplicate'
WHERE hidden.id = 19104 AND hidden.composer_id = 283 AND hidden.title = '로망스 E단조'
  AND hidden.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);
UPDATE piece_identifiers SET piece_id = 19530
WHERE piece_id = 19104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_aliases SET piece_id = 19530
WHERE piece_id = 19104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_instrumentation SET piece_id = 19530
WHERE piece_id = 19104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_reco_features SET piece_id = 19530
WHERE piece_id = 19104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_major_pieces SET piece_id = 19530
WHERE piece_id = 19104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE popular_comparisons SET piece_id = 19530
WHERE piece_id = 19104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE screen_music_cues SET piece_id = 19530
WHERE piece_id = 19104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE performances SET piece_id = 19530
WHERE piece_id = 19104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_favorite_pieces SET piece_id = 19530
WHERE piece_id = 19104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE user_taste_seed_pieces SET piece_id = 19530
WHERE piece_id = 19104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE user_listening_events SET piece_id = 19530
WHERE piece_id = 19104 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET from_piece_id = 19530
WHERE from_piece_id = 19104 AND to_piece_id <> 19530 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE piece_relations SET to_piece_id = 19530
WHERE to_piece_id = 19104 AND from_piece_id <> 19530 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE composer_highlights SET piece_id = 19530, part_id = NULL
WHERE piece_id = 19104 AND composer_id = 283 AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE IGNORE track_piece_links SET piece_id = 19530
WHERE piece_id = 19104 AND piece_part_id IS NULL AND EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = 19530
    WHERE hidden_piece.id = 19104 AND hidden_piece.composer_id = 283
      AND hidden_piece.title = '로망스 E단조' AND hidden_piece.hidden_reason = 'duplicate'
      AND kept_piece.composer_id = 283 AND kept_piece.hidden_reason IS NULL);
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 19104 AND hidden.composer_id = 283
    AND hidden.title = '로망스 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.description = hidden.description, kept.description_en = hidden.description_en
WHERE kept.id = 19530 AND kept.composer_id = 283 AND kept.hidden_reason IS NULL
  AND (kept.description IS NULL OR kept.description = '')
  AND hidden.description IS NOT NULL AND hidden.description <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 19104 AND hidden.composer_id = 283
    AND hidden.title = '로망스 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.spotify_url = hidden.spotify_url
WHERE kept.id = 19530 AND kept.composer_id = 283 AND kept.hidden_reason IS NULL
  AND (kept.spotify_url IS NULL OR kept.spotify_url = '') AND hidden.spotify_url IS NOT NULL AND hidden.spotify_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 19104 AND hidden.composer_id = 283
    AND hidden.title = '로망스 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.apple_music_url = hidden.apple_music_url
WHERE kept.id = 19530 AND kept.composer_id = 283 AND kept.hidden_reason IS NULL
  AND (kept.apple_music_url IS NULL OR kept.apple_music_url = '') AND hidden.apple_music_url IS NOT NULL AND hidden.apple_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 19104 AND hidden.composer_id = 283
    AND hidden.title = '로망스 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.youtube_music_url = hidden.youtube_music_url
WHERE kept.id = 19530 AND kept.composer_id = 283 AND kept.hidden_reason IS NULL
  AND (kept.youtube_music_url IS NULL OR kept.youtube_music_url = '') AND hidden.youtube_music_url IS NOT NULL AND hidden.youtube_music_url <> '';
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 19104 AND hidden.composer_id = 283
    AND hidden.title = '로망스 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.composition_year = hidden.composition_year
WHERE kept.id = 19530 AND kept.composer_id = 283 AND kept.hidden_reason IS NULL
  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 19104 AND hidden.composer_id = 283
    AND hidden.title = '로망스 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.notable = 1
WHERE kept.id = 19530 AND kept.composer_id = 283 AND kept.hidden_reason IS NULL
  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;
UPDATE pieces kept JOIN pieces hidden ON hidden.id = 19104 AND hidden.composer_id = 283
    AND hidden.title = '로망스 E단조' AND hidden.hidden_reason = 'duplicate'
SET kept.fame_score = hidden.fame_score
WHERE kept.id = 19530 AND kept.composer_id = 283 AND kept.hidden_reason IS NULL
  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);
