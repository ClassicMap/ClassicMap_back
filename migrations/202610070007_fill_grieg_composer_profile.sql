-- 그리그(composers 117)에 초상과 소개·스타일·영향을 채운다.
--
-- 국제 시드가 만든 작곡가라 초상·소개가 비어 있다. 영화 속 클래식 「하모니」 큐가 <페르 귄트>
-- (202610070006 에서 한국어화한 시드 작품 14198)로 이어지면서 이 작곡가 페이지로 들어오게 됐다.
-- 202610070004 의 새 작곡가 여섯처럼 기존 수동 작곡가와 같은 꼴로 채운다.
--
-- 초상은 Wikidata P18 (Edvard Grieg portrait) (3470673354).jpg 원본(305KB, Bergen Public Library,
-- 'No restrictions')이다. 시드가 남긴 entity_images 행(Special:FilePath 주소, REVIEW_REQUIRED)은 그대로 두고
-- upload.wikimedia.org 주소로 출처 행을 하나 더 둔다.
-- editor_locked 를 켜서 다음 시드 실행이 덮어쓰지 못하게 한다. 이미 누가 채웠으면 건드리지 않는다.

UPDATE composers SET
    avatar_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e9/%28Edvard_Grieg_portrait%29_%283470673354%29.jpg',
    cover_image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e9/%28Edvard_Grieg_portrait%29_%283470673354%29.jpg',
    bio = '노르웨이의 작곡가이자 피아니스트. 라이프치히 음악원에서 공부한 뒤 노르웨이 민요와 춤곡의 선율과 리듬을 작품에 녹여 노르웨이 국민악파를 대표하는 작곡가가 되었다. 피아노 협주곡 A단조, 입센의 희곡에 붙인 <페르 귄트> 극음악, 66곡으로 된 <서정 소품집>으로 유명하다.',
    style = '노르웨이 민속 선율과 춤곡 리듬(할링, 스프링가르), 서정적인 피아노 소품, 섬세한 화성, <페르 귄트>, 피아노 협주곡 A단조',
    influence = '그는 독일 낭만주의의 어법에 노르웨이 민속음악의 색채를 더해 북유럽 국민악파의 길을 열었다. 그의 화성은 드뷔시와 라벨 등 프랑스 작곡가들에게도 영향을 주었다.',
    editor_locked = 1
WHERE id = 117 AND origin = 'seed' AND english_name = 'Edvard Grieg'
  AND avatar_url IS NULL AND bio IS NULL;

INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT composer.authority_entity_id, 'profile',
       'https://commons.wikimedia.org/wiki/File:(Edvard_Grieg_portrait)_(3470673354).jpg',
       'https://upload.wikimedia.org/wikipedia/commons/e/e9/%28Edvard_Grieg_portrait%29_%283470673354%29.jpg',
       'Bergen Public Library Norway', 'No restrictions', NULL, 'Bergen Public Library Norway', TRUE, 'PUBLISHED'
FROM (SELECT id, authority_entity_id FROM composers) composer
WHERE composer.id = 117 AND composer.authority_entity_id IS NOT NULL
AND NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, file_url FROM entity_images) existing
    WHERE existing.authority_entity_id = composer.authority_entity_id
      AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e9/%28Edvard_Grieg_portrait%29_%283470673354%29.jpg'
);
