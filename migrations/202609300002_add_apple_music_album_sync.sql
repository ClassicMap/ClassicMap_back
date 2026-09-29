-- Apple Music 에서 연주자의 새 앨범을 받아 오기 위한 자리.
--
-- 앨범은 시드로 한 번 들어온 뒤(최신 발매일 2026-02-06) 갱신이 없었다. 서버가 하루 한 번
-- Apple Music 카탈로그에서 연주자별 최근 정규 앨범을 받아 recordings 에 없는 것만 더한다.
--
-- apple_music_artist_id 는 그 연주자의 Apple Music 아티스트 ID 다. 이미 가진 앨범의 참여
-- 아티스트에서 이름이 맞는 사람을 고르고, 앨범이 없으면 이름 검색에서 이름이 정확히 같고
-- 클래식 장르인 사람이 하나뿐일 때만 채운다. 못 찾으면 비워 두고 apple_music_checked_at 만
-- 남겨 30일 동안 다시 묻지 않는다.

ALTER TABLE artists
    ADD COLUMN apple_music_artist_id VARCHAR(32) CHARACTER SET ascii COLLATE ascii_bin NULL
        COMMENT 'Apple Music 아티스트 ID',
    ADD COLUMN apple_music_checked_at TIMESTAMP NULL
        COMMENT '마지막으로 Apple Music 아티스트를 찾아본 시각',
    ADD INDEX idx_artists_apple_music_artist (apple_music_artist_id);
