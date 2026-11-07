-- 작품 장르. 화면이 작품 카드의 색·커버와 장르 필터에 쓴다.
-- 비교할 수 있는 작품만 채우고, 나머지는 NULL 로 둔다(화면은 중립 색을 쓴다).
-- 원곡 편성 기준이다. 비교 연주가 모두 굳은 편곡판(관현악판 등)으로 도는 곡만 그 편성을 따른다.
--   symphony   교향곡(합창 교향곡 포함)
--   concerto   협주곡과 협주풍 작품(독주 악기 + 관현악)
--   piano      건반 독주(하프시코드·피아노 연탄·두 대의 피아노 포함)
--   chamber    실내악과 건반 아닌 독주
--   orchestral 교향곡·협주곡이 아닌 관현악(교향시·서곡·모음곡·세레나데·부수음악 등)
--   stage      오페라·오페레타·발레와 그 발췌(서곡·아리아·합창·무곡 포함)
--   vocal      가곡·연가곡·합창·종교곡(미사·레퀴엠·오라토리오·칸타타·모테트 등)
ALTER TABLE pieces
    ADD COLUMN genre VARCHAR(16) NULL,
    ADD CONSTRAINT chk_pieces_genre
        CHECK (genre IS NULL OR genre IN (
            'symphony', 'concerto', 'piano', 'chamber', 'orchestral', 'stage', 'vocal'
        ));
