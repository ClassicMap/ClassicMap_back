-- 틀린 옛 작품 링크를 바꾸고(편곡·다른 작품·발췌 음반), 빈 타펠무지크 Apple 작품 링크를 채운다.
-- 타펠무지크(52) Spotify, 클레멘티 Op. 24(33936) Apple, 압델라자르(38) 두 서비스, 디도의 탄식(35) 두 서비스,
-- 스카를라티 K. 27(41) Apple. 바꾸는 것은 지금 값이 그때 본 값과 같을 때만, 채우는 것은 비어 있을 때만.
-- 자료·까닭: seed_pipeline/curation/old-link-fixes-2026-11-12/(README, fixes.tsv, decisions.jsonl). 두 번 돌려도 같다.
-- apple fill 1, apple replace 4, spotify replace 3

-- 35 When I am laid in earth (Dido's Lament) (from Dido and Aeneas) (apple replace: Purcell: Dido and Aeneas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/dido-and-aeneas-z-626-act-3-scene-2-when-i-am-laid-in-earth-dido/696500692?i=696501356' WHERE id = 35 AND composer_id = 8 AND apple_music_url = 'https://music.apple.com/us/album/dido-and-aeneas-z-626-act-iii-didos-lament-arr-diluka/1788286944?i=1788287073';
-- 35 When I am laid in earth (Dido's Lament) (from Dido and Aeneas) (spotify replace: Purcell: Dido and Aeneas)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/track/04ZCDm1hOk2oGCTgWSQqA6' WHERE id = 35 AND composer_id = 8 AND spotify_url = 'https://open.spotify.com/track/06O078Zw6xX8iMh4lpWn01';
-- 38 Abdelazer Suite (apple replace: Purcell: Abdelazer Suite)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/purcell-abdelazer-suite/1810565869' WHERE id = 38 AND composer_id = 8 AND apple_music_url = 'https://music.apple.com/us/album/bach-orchestral-suite-no-1-in-c-major-bwv-1066-delalande-symphonie-de-noel-christmas-symphony-purcell-abdelazer-suite-z-570-vivaldi-sinfonia-in-b-minor-rv-169-mozart-adagio-and-fugue-in-c-minor-k-546/1004735500';
-- 38 Abdelazer Suite (spotify replace: Purcell: Abdelazer Suite)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/4oKt1zmCJp9nVFcdpMIKOv' WHERE id = 38 AND composer_id = 8 AND spotify_url = 'https://open.spotify.com/album/5VOd26mK3cOLkRXrwfvRt9';
-- 41 Sonata in B minor (apple replace: Scarlatti: 12 Sonatas)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/b-minor-k-27-allegro/373940433?i=373940476' WHERE id = 41 AND composer_id = 9 AND apple_music_url = 'https://music.apple.com/us/album/scarlatti-sonata-in-b-minor-k-27-l-449-allegro-marimba-version/1687657824?i=1687657825';
-- 52 Tafelmusik (Musique de Table) (apple fill: Telemann: Tafelmusik)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/telemann-tafelmusik/692814679' WHERE id = 52 AND composer_id = 11 AND (apple_music_url IS NULL OR apple_music_url = '');
-- 52 Tafelmusik (Musique de Table) (spotify replace: Telemann: Tafelmusik)
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/53D4pW4e3Y5eO8VyGxpU0c' WHERE id = 52 AND composer_id = 11 AND spotify_url = 'https://open.spotify.com/album/43j5ZByQWUcDIePeOlEXrH';
-- 33936 2 Piano Sonatas, op. 24 (apple replace: Clementi: Complete Piano Sonatas, Vol. 3)
UPDATE pieces SET apple_music_url = 'https://music.apple.com/us/album/clementi-complete-piano-sonatas-vol-3/1721136971' WHERE id = 33936 AND composer_id = 25 AND apple_music_url = 'https://music.apple.com/us/album/vladimir-horowitz-live-at-carnegie-hall-recital-march/1102597360';
