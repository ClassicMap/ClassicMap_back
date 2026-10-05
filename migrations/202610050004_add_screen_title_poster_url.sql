-- 영화 속 클래식 작품 포스터. 한국영상자료원 KMDb 오픈 API 가 주는 포스터 주소(file.koreafilm.or.kr)를 그대로 쓴다.
-- TMDB 파일 경로(poster_path)와 따로 두고, 화면에 출처(poster_credit)를 같이 적는다.
ALTER TABLE screen_titles
    ADD COLUMN poster_url VARCHAR(500) NULL AFTER cover_clip,
    ADD COLUMN poster_credit VARCHAR(100) NULL AFTER poster_url,
    ADD CONSTRAINT chk_screen_titles_poster_credit
        CHECK ((poster_url IS NULL) = (poster_credit IS NULL));
