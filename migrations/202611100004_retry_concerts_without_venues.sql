-- 공연장이 DB 에 없어 건너뛴 공연 3개(한국방송회관 코바코홀 FC001107, 예술마을 그리다 FC005030)를
-- 다시 받을 목록에 더한다. 이번 배포부터 공연장이 없으면 KOPIS 에서 받아 넣는다.
UPDATE sync_metadata
SET error_message = CASE
        WHEN error_message LIKE 'retry:%' THEN CONCAT(error_message, ',PF299302,PF300947,PF304684')
        ELSE 'retry:PF299302,PF300947,PF304684'
    END
WHERE sync_type = 'concerts';
