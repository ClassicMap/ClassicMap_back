-- 비제·마스네 오페라 대본 대목이 따로 작품 줄로 보이던 것을 숨긴다(지우지 않음, 상세는 열림).
-- 근거: seed_pipeline/curation/piece-genre-fill-2026-11-17/(README.md, opera_excerpts.py, opera_excerpts.json).
--   duplicate: 오페라 작품의 보이는 part 와 MusicBrainz work 가 같은 줄(그 곡은 오페라 안 part 로 이미 보인다).
--   catalog_unmatched: MB 에서 원어 작품과 이어지지 않은 번역판 work(같은 번역판 전곡 11541 선례).
--   part 에 잇지 않는다: 이으면 part 의 곡별 링크 대신 링크 없는 이 줄의 링크를 써서 오페라 안 곡 링크가 사라진다.
--   보이고, 갈래가 비고, 제목이 같고, 식별자 말고 이 줄을 가리키는 행이 없을 때만 숨긴다. 두 번 넣어도 같다.
-- 작품 118줄: 오페라 <Cendrillon> duplicate 31, 오페라 <Les Pêcheurs de perles> catalog_unmatched 27, 오페라 <Manon> catalog_unmatched 1, 오페라 <카르멘> duplicate 59

UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33069 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Ah, just look!” (Soldiers, Cigarette Girls, Young Men)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33070 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “But why hasn’t she come, our Carmencita?” (Soldiers, Young Men, Cigarette Girls, Carmen)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33071 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Careful—it’s the lieutenant” (Don José, Zuniga, Carmen)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33072 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Carmen! We will follow you high and low!” (Young Men, Carmen, Don José, Cigarette Girls)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33073 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Come and help!” (Cigarette Girls, Zuniga, Soldiers)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33074 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Corporal! — Sir!” (Zuniga, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33075 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Give me news of my mother!” (Don José, Micaëla)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33076 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Here come our new soldier boys” (Children)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33077 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “I see my mother’s face!” (Don José, Micaëla)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33078 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “In the plaza” (Soldiers, Moralès)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33079 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “José! There was a girl looking for you just now” (Moralès, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33080 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Just look at that delicious morsel” (Moralès, Soldiers, Micaëla)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33081 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Love’s a bird wild as any rebel” (Carmen, Cigarette Girls, Young Men, Soldiers)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33082 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Off with you old soldier boys” (Children)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33083 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “So corporal: tell me what happened” (Zuniga, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33084 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “The cheek of it!” (Don José, Micaëla)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33085 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “There’s an old bar in the city” (Carmen, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33086 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Wait a moment—I’m going to read the letter” (Don José, Micaëla)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33087 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “We have heard the bell summon us to meet here” (Young Men)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33088 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Well, Carmencita: what do you have to say for yourself?” (Zuniga, Carmen)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33089 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Where are you taking me?” (Carmen, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33090 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act I. “Your dear mother and I were leaving church this morning” (Micaëla, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33091 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “At last! – We got rid of them as quickly as we could” (Remendado, Frasquita, Dancaïre, Mercédès)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33092 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “Back to camp!… Go at once!” (Carmen, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33093 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “Being in love is not a reason” (Dancaïre, Carmen, Frasquita, Mercédès, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33094 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “Bravo! bravo! More! Keep dancing!” (Zuniga, Frasquita, Mercédès, Carmen)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33095 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “From far away mysterious sounds” (Carmen, Frasquita, Mercédès)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33096 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “Hello! Carmen!” (Zuniga, Don José, Carmen)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33097 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “Hurrah! Hurrah! The Torero!” (Friends of Escamillo)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33098 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “La la la la la la la…” (Carmen, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33099 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “Lieutenant fair, it’s true” (Carmen, Remendado, Dancaïre, Gipsies, Zuniga, Don José, Frasquita, Mercédès)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33100 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “No, it’s not love at all!” (Carmen, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33101 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “That flow’r you threw to me I treasured” (Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33102 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “The sky above the open road” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33103 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “There’s a little job that we''re starting!” (Dancaïre, Mercédès, Frasquita, Remendado, Carmen)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33104 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “To bid you welcome to our bar” (Carmen)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33105 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “Toreador, be ready!” (Friends of Escamillo)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33106 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “We’ll come with you, Señor Torero” (Zuniga, Escamillo, Friends of Escamillo, Carmen, Frasquita, Mercédès)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33107 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “Who’s that? — It’s Escamillo, the bullfighter from Granada” (Zuniga, Frasquita, Friends of Escamillo)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33108 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act II. “You’re most kind” (Escamillo, Frasquita, Mercédès, Carmen, Moralès, Zuniga, Officers, Friends of Escamillo)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33109 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “Alas! José, your mother is ill” (Micaëla, Don José, Escamillo)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33110 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “As for that man, it should be easy!” (Frasquita, Mercédès, Carmen, Gipsies, Remendado, Dancaïre)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33111 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “Escamillo is my name, and I come from Granada” (Escamillo, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33112 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “Holà! holà! José!” (Carmen, Escamillo, Dancaïre)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33113 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “I say that there’s nothing to fear” (Micaëla)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33114 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “In vain you would avoid the bitter things they’re saying” (Carmen, Frasquita, Mercédès)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33115 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “Is this the place?” (Micaëla, Guide)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33116 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “It’s him! I’m sure it’s him over there!” (Micaëla, Escamillo, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33117 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “Keep going, dear old friend keep going!” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33118 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “Right! Let’s stop for a while” (Dancaïre, Don José, Carmen)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33119 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “She had a lover here” (Escamillo, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33120 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “Shuffle! Cut them!” (Frasquita, Mercédès, Carmen)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33121 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “You should take care, Carmen” (Don José, Dancaïre, Gipsies, Remendado, Carmen, Micaëla, Frasquita, Mercédès)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33122 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act III. “You''re back!” (Frasquita, Dancaïre, Mercédès, Carmen, Remendado, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33123 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act IV. “A few cuartos! A few cuartos!” (Merchants, Vendors, Zuniga, An Orange Vendor, A Gipsy)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33124 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act IV. “Here they come! Here they come!” (Children, Merchants, Vendors, Crowd)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33125 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act IV. “If you love me, Carmen” (Escamillo, Carmen, Cordeliers, Frasquita, Mercédès)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33126 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act IV. “It’s you! — It’s me!” (Carmen, Don José)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33127 AND piece.composer_id = 44 AND piece.title = 'Carmen: Act IV. “Viva!, Viva! What a corrida!” (Crowd, Don José, Carmen)'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33128 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt I. „Das Glück, das große Glück“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33129 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt I. „Der Himmel schuf die Perlen“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33130 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt I. „Hier ist der Tempel“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33131 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt I. „Höre Leila, was ich nun fragen muß“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33132 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt I. „Im Tempel Brahmas kniet“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33133 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt I. „Komm’, süßer Sonne Licht“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33134 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt I. „Mein Freund, du, sei gegrüßt“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33135 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt I. „Nadir, es lichtet sich der Platz“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33136 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt I. „O Freude! Ihr Schiff, es kommt!“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33137 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt I. „Seht hin, sie ist es“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33138 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt I. „Sei uns gegrüßt!“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33139 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt I. „Wo des Morgens Grau’n“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33140 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt II. Entr’acte'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33141 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt II. „Das letzte Schiff ist nun verankert“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33142 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt II. „Der Abend bricht an“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33143 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt II. „Ein Opfer ist der Liebe Pfand“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33144 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt II. „Hin, zu ihr! Leila!“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33145 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt II. „Hör’ mich, o Brahma!“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33146 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt II. „Leila, träume, träume von Blumen“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33147 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt II. „Nun wird es einsam um mich her“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33148 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt III. „Ach, wie find’ ich rechte Worte“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33149 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt III. „Die Stimme ihres Fleh’ns“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33150 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt III. „Haltet ein!“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33151 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt III. „Leila, Liebste, du“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33152 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt III. „Sie kommt zu mir“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33153 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt III. „Was ich fühl’ darf sie niemals wissen“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33154 AND piece.composer_id = 44 AND piece.title = 'Die Perlenfischer: Akt III. „Zurga, Flut! Die Springflut des Meers“'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33179 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte I. « Ah ! Douce enfant »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33180 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte I. « Ah ! Que mes sœurs sont heureuses ! »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33181 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte I. « Du côte de la barbe »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33182 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte I. « Enfin, je connaîtrai »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33183 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte I. « Faites‐vous très belles »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33184 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte I. « Félicitez‐moi donc »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33185 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte I. « Madame, ce sont les modistes »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33186 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte I. « On appelle, on sonne ! »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33187 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte I. « Pour en faire un tissu »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33188 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte I. « Prenez un maintien gracieux »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33189 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte II. Cinquième Entrée : Le Rigodon du Roy'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33190 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte II. Deuxième Entrée : Les Fiancés'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33191 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte II. Entrée du Roi et de la Cour'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33192 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte II. Première Entrée : Les Filles de Noblesse'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33193 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte II. Quatrième Entrée : La Florentine'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33194 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte II. Troisième Entrée : Les Mandores'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33195 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte II. « Allez, laissez‐moi seul »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33196 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte II. « O la surprenante aventure » / « O la décevante aventure »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33197 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte II. « Que les doux pensers »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33198 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte II. « Toi qui m’es apparue »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33199 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte III. « Ah ! Fugitives chimères »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33200 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte III. « C’est vrai ! »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33201 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte III. « Enfin, je suis ici »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33202 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte III. « Lorsqu’on a plus de vingt quartiers »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33203 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte III. « Ma pauvre enfant chérie ! »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33204 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte III. « Seule, je partirai »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33205 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte III. « À deux genoux » / « Je viens à vous »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33207 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte IV. « Ah ! Ouvre ta porte »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33208 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte IV. « Avancez ! Reculez ! »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33209 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte IV. « O pauvre enfant ! »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'duplicate'
WHERE piece.id = 33210 AND piece.composer_id = 62 AND piece.title = 'Cendrillon : Acte IV. « Posez dans son écrin »'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
UPDATE pieces piece SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.id = 33217 AND piece.composer_id = 62 AND piece.title = 'Manon: Atto III. “Ahimè! L’augel … La tua non è la mano che mi tocca”'
  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL
  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL
  AND (piece.description IS NULL OR piece.description = '')
  AND NOT EXISTS (SELECT 1 FROM performance_sectors ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM performances ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_highlights ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM composer_major_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM popular_comparisons ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM screen_music_cues ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM track_piece_links ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_aliases ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_instrumentation ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_reco_features ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.from_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_relations ref WHERE ref.to_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts ref WHERE ref.linked_piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_favorite_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_taste_seed_pieces ref WHERE ref.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM user_listening_events ref WHERE ref.piece_id = piece.id);
