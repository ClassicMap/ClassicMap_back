-- S·A tier 작곡가(숨기지 않은 사람)
SELECT id, name, english_name, tier, birth_year, death_year, period
FROM composers
WHERE tier IN ('S', 'A') AND hidden_reason IS NULL
ORDER BY id;
