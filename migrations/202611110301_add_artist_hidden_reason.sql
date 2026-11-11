-- 연주자도 작곡가(composers.hidden_reason)처럼 목록·검색에서만 숨길 수 있게 한다. 상세는 그대로 열린다.
ALTER TABLE artists ADD COLUMN hidden_reason VARCHAR(64) NULL;

-- 236 권헤이든(Haydn Kwon): 2025-11-20 첫 수동 시드로 들어왔는데 이름·출생 연도·수상(2024 베르비에 아카데미 상)으로
-- 찾을 수 있는 자료가 없고 연주 기록도 없어 실존을 확인하지 못했다(2026-11-11). 지우지 않고 숨긴다.
UPDATE artists SET hidden_reason = 'unverified'
WHERE id = 236 AND english_name = 'Haydn Kwon' AND hidden_reason IS NULL;
