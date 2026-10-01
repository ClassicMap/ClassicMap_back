-- 비교 화면의 연주 노트와 구간별 추천 비교.
-- 사람이 들어 보고 확정한 글(PUBLISHED)만 비교 API 가 내보낸다.
-- 들을 곳(moments)의 atMs 는 원본 영상 시각이다. API 가 클립 처음부터의 오프셋으로 바꾼다.

-- 연주 노트: 구간에 묶인 연주마다 하나
CREATE TABLE performance_listening_notes (
    performance_id INT NOT NULL PRIMARY KEY,
    -- 이 연주를 부르는 제목. "처음부터 천둥처럼"
    headline VARCHAR(40) NOT NULL,
    -- 두세 문장
    note TEXT NOT NULL,
    -- 들을 곳. [{"atMs": 238600, "label": "시작하자마자 정점"}]
    moments JSON NULL,
    -- 사실 태그. ["오시아 카덴차"]
    facts JSON NULL,
    -- 근거. [{"kind": "measured", ...}, {"kind": "listening", "status": "done"}]
    evidence JSON NOT NULL,
    editorial_status VARCHAR(32) NOT NULL DEFAULT 'DRAFT',
    reviewed_at TIMESTAMP(6) NULL,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_listening_notes_performance
        FOREIGN KEY (performance_id) REFERENCES performances(id) ON DELETE CASCADE,
    CONSTRAINT chk_listening_notes_status
        CHECK (editorial_status IN ('DRAFT', 'PUBLISHED', 'RETIRED')),
    CONSTRAINT chk_listening_notes_moments
        CHECK (moments IS NULL OR JSON_TYPE(moments) = 'ARRAY'),
    CONSTRAINT chk_listening_notes_facts
        CHECK (facts IS NULL OR JSON_TYPE(facts) = 'ARRAY')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 추천 비교: 구간마다 대비가 가장 선명한 한 쌍.
-- 두 연주가 같은 구간인지, 서로 다른지는 API 가 공개 연주와 맞춰 볼 때 거른다.
-- (MySQL 은 ON DELETE 동작이 걸린 열을 CHECK 에 쓰지 못한다)
CREATE TABLE sector_featured_pairs (
    sector_id INT NOT NULL PRIMARY KEY,
    performance_a_id INT NOT NULL,
    performance_b_id INT NOT NULL,
    -- "쏟아내기 vs 쌓아 올리기"
    title VARCHAR(40) NOT NULL,
    note TEXT NOT NULL,
    -- 연주별 들을 곳. [{"performanceId": 93, "atMs": 238600, "label": "키신의 정점"}]
    moments JSON NULL,
    editorial_status VARCHAR(32) NOT NULL DEFAULT 'DRAFT',
    reviewed_at TIMESTAMP(6) NULL,
    created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_featured_pairs_sector
        FOREIGN KEY (sector_id) REFERENCES performance_sectors(id) ON DELETE CASCADE,
    CONSTRAINT fk_featured_pairs_performance_a
        FOREIGN KEY (performance_a_id) REFERENCES performances(id) ON DELETE CASCADE,
    CONSTRAINT fk_featured_pairs_performance_b
        FOREIGN KEY (performance_b_id) REFERENCES performances(id) ON DELETE CASCADE,
    CONSTRAINT chk_featured_pairs_status
        CHECK (editorial_status IN ('DRAFT', 'PUBLISHED', 'RETIRED')),
    CONSTRAINT chk_featured_pairs_moments
        CHECK (moments IS NULL OR JSON_TYPE(moments) = 'ARRAY')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
