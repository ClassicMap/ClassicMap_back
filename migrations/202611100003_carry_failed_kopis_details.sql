-- 11/10 03:00 UTC 전체 다시 받기는 1,754개를 받았지만 상세 5개가 재시도 뒤에도 KOPIS 에 막혀(400) 마지막
-- 동기화 날짜가 2020-01-01 에 남았다. 그대로면 매일 1시간짜리 전체 다시 받기를 되풀이한다.
-- 날짜를 그 동기화를 시작한 날로 올리고, 막힌 5개는 다시 받을 목록(retry:)으로 넘긴다.
UPDATE sync_metadata
SET last_sync_date = '2026-11-10',
    status = 'success',
    error_message = 'retry:PF301238,PF301753,PF302677,PF302999,PF303587'
WHERE sync_type = 'concerts'
  AND last_sync_date = '2020-01-01';
