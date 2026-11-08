-- 영어판에서 보일 설명 글의 영어 칸. 비어 있으면 화면은 한국어 칸을 쓴다.
-- 이름 칸(english_name·title_en·name_en)은 이미 있다. 이번에는 소개·설명·노트 같은 글이다.
-- 모두 NULL 을 허용하는 칸을 끝에 더하므로(MySQL 8 INSTANT) 표를 다시 쓰지 않는다.

ALTER TABLE composers
    ADD COLUMN bio_en TEXT NULL,
    ADD COLUMN style_en TEXT NULL,
    ADD COLUMN influence_en TEXT NULL;

ALTER TABLE artists
    ADD COLUMN bio_en TEXT NULL,
    ADD COLUMN style_en TEXT NULL;

ALTER TABLE artist_awards
    ADD COLUMN award_name_en VARCHAR(300) NULL;

ALTER TABLE pieces
    ADD COLUMN description_en TEXT NULL;

ALTER TABLE performance_sectors
    ADD COLUMN description_en TEXT NULL;

ALTER TABLE performance_listening_notes
    ADD COLUMN headline_en VARCHAR(80) NULL,
    ADD COLUMN note_en TEXT NULL;

ALTER TABLE sector_featured_pairs
    ADD COLUMN title_en VARCHAR(80) NULL,
    ADD COLUMN note_en TEXT NULL;

ALTER TABLE screen_titles
    ADD COLUMN title_en VARCHAR(255) NULL;

ALTER TABLE screen_music_cues
    ADD COLUMN part_label_en VARCHAR(255) NULL,
    ADD COLUMN scene_note_en VARCHAR(600) NULL;

-- 연주자 목록·상세는 v_artists_full 로 읽는다. 뷰는 만들 때의 칸으로 굳으므로 영어 칸을 더해 다시 만든다(나머지는 그대로).
CREATE OR REPLACE VIEW v_artists_full AS
SELECT a.id,
       a.name,
       a.english_name,
       a.category,
       a.tier,
       a.rating,
       a.image_url,
       a.cover_image_url,
       a.birth_year,
       a.nationality,
       a.bio,
       a.style,
       a.concert_count,
       a.album_count,
       a.top_award_id,
       a.created_at,
       a.updated_at,
       GROUP_CONCAT(DISTINCT CONCAT(aw.year, ':', aw.award_name) ORDER BY aw.display_order ASC SEPARATOR '|') AS awards,
       top_aw.award_name AS top_award_name,
       top_aw.year AS top_award_year,
       top_aw.ranking AS top_award_ranking,
       a.bio_en,
       a.style_en,
       top_aw.award_name_en AS top_award_name_en
FROM artists a
LEFT JOIN artist_awards aw ON a.id = aw.artist_id
LEFT JOIN artist_awards top_aw ON a.top_award_id = top_aw.id
GROUP BY a.id;
