-- 작곡가 화면 작품 정리(갈래·형식 묶음, 대표곡 표시).
-- 1단 갈래는 pieces.genre(장르 7종, NULL 은 화면의 '기타')이고, 2단 형식은 pieces.form_key 다.
-- 형식 사전 piece_forms 는 형식마다 속한 갈래, 화면 이름, 갈래 안 순서를 둔다.
-- 대표곡은 공개 신호(위키데이터 언어판 수, MusicBrainz 녹음 수)와 비교 구간으로 정하고,
-- 사람이 고친 값은 notable_locked 로 잠가 다시 계산해도 바뀌지 않게 한다.
-- fame_score 는 위키데이터 언어판 수(작품 MBID 중 가장 큰 값)이고, 대표곡끼리 줄 세울 때 쓴다.
CREATE TABLE piece_forms (
    form_key VARCHAR(32) NOT NULL PRIMARY KEY,
    genre VARCHAR(16) NOT NULL,
    name_ko VARCHAR(64) NOT NULL,
    sort_order INT NOT NULL,
    CONSTRAINT chk_piece_forms_genre CHECK (genre IN (
        'symphony', 'concerto', 'piano', 'chamber', 'orchestral', 'stage', 'vocal'
    ))
);

INSERT INTO piece_forms (form_key, genre, name_ko, sort_order) VALUES
    ('symphony', 'symphony', '교향곡', 10),
    ('sinfonia', 'symphony', '신포니아·신포니에타', 20),
    ('symphony_other', 'symphony', '그 밖의 교향곡', 999),
    ('piano_concerto', 'concerto', '피아노 협주곡', 10),
    ('violin_concerto', 'concerto', '바이올린 협주곡', 20),
    ('cello_concerto', 'concerto', '첼로 협주곡', 30),
    ('wind_concerto', 'concerto', '관악 협주곡', 40),
    ('other_concerto', 'concerto', '그 밖의 협주곡', 50),
    ('concerto_grosso', 'concerto', '합주 협주곡', 60),
    ('concertante', 'concerto', '독주와 관현악', 70),
    ('concerto_other', 'concerto', '그 밖의 곡', 999),
    ('sonata', 'piano', '소나타', 10),
    ('etude', 'piano', '연습곡', 20),
    ('prelude_fugue', 'piano', '전주곡·푸가', 30),
    ('ballade', 'piano', '발라드', 40),
    ('scherzo', 'piano', '스케르초', 50),
    ('nocturne', 'piano', '녹턴', 60),
    ('impromptu', 'piano', '즉흥곡', 70),
    ('fantasia', 'piano', '환상곡·랩소디', 80),
    ('character', 'piano', '소품', 90),
    ('mazurka', 'piano', '마주르카', 100),
    ('polonaise', 'piano', '폴로네즈', 110),
    ('waltz', 'piano', '왈츠', 120),
    ('dance', 'piano', '그 밖의 무곡', 130),
    ('variations', 'piano', '변주곡', 140),
    ('rondo', 'piano', '론도', 150),
    ('keyboard_suite', 'piano', '모음곡·파르티타', 160),
    ('four_hands', 'piano', '네 손·두 대 피아노', 170),
    ('organ', 'piano', '오르간', 180),
    ('piano_other', 'piano', '그 밖의 곡', 999),
    ('string_quartet', 'chamber', '현악 4중주', 10),
    ('string_ensemble', 'chamber', '현악 3·5·6중주', 20),
    ('piano_chamber', 'chamber', '피아노 3·4·5중주', 30),
    ('duo_sonata', 'chamber', '이중주 소나타', 40),
    ('wind_chamber', 'chamber', '관악 실내악', 50),
    ('solo', 'chamber', '무반주 독주', 60),
    ('chamber_other', 'chamber', '그 밖의 실내악', 999),
    ('overture', 'orchestral', '서곡', 10),
    ('symphonic_poem', 'orchestral', '교향시', 20),
    ('orch_suite', 'orchestral', '모음곡', 30),
    ('serenade', 'orchestral', '세레나데·디베르티멘토', 40),
    ('dance_march', 'orchestral', '무곡·행진곡', 50),
    ('incidental', 'orchestral', '부수음악', 60),
    ('orchestral_other', 'orchestral', '그 밖의 관현악', 999),
    ('opera', 'stage', '오페라', 10),
    ('operetta', 'stage', '오페레타·징슈필', 20),
    ('ballet', 'stage', '발레', 30),
    ('stage_excerpt', 'stage', '서곡·발췌', 40),
    ('stage_other', 'stage', '그 밖의 무대 음악', 999),
    ('song', 'vocal', '가곡·연가곡', 10),
    ('concert_aria', 'vocal', '연주회용 아리아', 20),
    ('mass_requiem', 'vocal', '미사·레퀴엠', 30),
    ('oratorio_passion', 'vocal', '오라토리오·수난곡', 40),
    ('cantata', 'vocal', '칸타타', 50),
    ('sacred', 'vocal', '모테트·종교곡', 60),
    ('choral', 'vocal', '합창곡', 70),
    ('folk', 'vocal', '민요 편곡', 80),
    ('vocal_other', 'vocal', '그 밖의 성악', 999);

ALTER TABLE pieces
    ADD COLUMN form_key VARCHAR(32) NULL,
    ADD COLUMN notable TINYINT(1) NOT NULL DEFAULT 0,
    ADD COLUMN notable_locked TINYINT(1) NOT NULL DEFAULT 0,
    ADD COLUMN fame_score INT NULL,
    ADD CONSTRAINT fk_pieces_form FOREIGN KEY (form_key) REFERENCES piece_forms (form_key),
    ADD INDEX idx_pieces_composer_genre_form (composer_id, genre, form_key);

ALTER TABLE piece_parts
    ADD COLUMN notable TINYINT(1) NOT NULL DEFAULT 0,
    ADD COLUMN notable_locked TINYINT(1) NOT NULL DEFAULT 0;
