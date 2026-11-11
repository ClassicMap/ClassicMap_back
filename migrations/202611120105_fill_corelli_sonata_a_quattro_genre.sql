-- 코렐리 「4성부 소나타」(29331, WoO 2, 두 바이올린·비올라·통주저음)의 장르·형식이 비어 있다.
-- 같은 WoO 실내악인 「트리오 소나타 A장조」(29332)와 같이 chamber/chamber_other 로 채운다. 비어 있을 때만, 두 번 돌려도 같다.
-- 코렐리 작품 목록은 2차(seed_pipeline/curation/catalog-wave2-2026-10-12/corelli)에서 Op. 1~6·WoO 1·2·5 로 이미 다 들어가 있어 새 작품은 없다.
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE id = 29331 AND composer_id = 12 AND genre IS NULL AND form_key IS NULL;
