-- 텔레만 「파리 사중주」(56) Spotify 링크가 다른 곡(「Sonata in A Minor, TWV 43:a5」 한 악장짜리 앨범)이라
-- Apple 링크와 같은 런던 헨델 플레이어스 「Telemann: Paris Quartets, Vol. 1」(1730년 사중주 6곡)으로 바꾼다.
-- 12곡이 한 앨범에 다 든 음반은 두 서비스 다 없어 절반짜리지만 같은 작품이다. 안 곡 링크는 채우지 않는다.
-- 지금 값이 그때 본 값과 같을 때만 바꾼다. 두 번 돌려도 같다.
UPDATE pieces SET spotify_url = 'https://open.spotify.com/album/392k5ogevZNVqHsoqNsA0R'
WHERE id = 56 AND composer_id = 11 AND spotify_url = 'https://open.spotify.com/album/2msX4mNyfqw0bFgZ6De4sM';
