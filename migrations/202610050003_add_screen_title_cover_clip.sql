-- 영화 속 클래식 작품의 대표 그림. 권리자 공식 YouTube 예고편·클립 {videoId, startSec, channel, title}.
-- TMDB 포스터를 쓰지 않아 장면 클립이 없는 작품도 썸네일로 알아볼 수 있게 한다.
ALTER TABLE screen_titles
    ADD COLUMN cover_clip JSON NULL AFTER credit_line,
    ADD CONSTRAINT chk_screen_titles_cover_clip
        CHECK (cover_clip IS NULL OR JSON_TYPE(cover_clip) = 'OBJECT');
